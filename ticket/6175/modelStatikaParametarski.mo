// modelStatikaParametarski
// 6DOF Rotary Stewart Platform
// Author: Milos Petrasinovic <mpetrasinovic@prdc.rs>
// PRDC, Republic of Serbia
// info@prdc.rs
// ---------------

model modelStatikaParametarski "Inverzna statika mehanizma simulatora leta"

  import SI = Modelica.SIunits;
  import Modelica.SIunits.Conversions.*;
  
  parameter SI.Angle alpha[6,1] = [from_deg(10); from_deg(10); from_deg(10); from_deg(10); from_deg(10); from_deg(10)];
  parameter SI.Mass m(min = 0) = 250 "Masa tereta i platforme";
  parameter SI.Position cg[3] = {0,0,0} / 1000 "[mm] koordinate tezista tereta ";
  parameter SI.Time t1_ramp(min = 0) = 0.5;
  parameter SI.Time t_ramp(min = 0) = 0.2;
  parameter SI.Angle offset_ramp(min = 0) = 0;
  parameter SI.Acceleration g = 9.806 "[m/s^2] gravitaciono ubrzanje";
  parameter SI.Position Op0[3, 1] = [0.0000000000000000;0.0000000000000000;888.2956888774923527] / 1000 "Pocetni polozaj platforme";
  parameter SI.Position Ab[3, 6] = [649.6340398200857180,590.1809005014252989,-590.1809005014252989,-649.6340398200857180,-59.4531393186603054,59.4531393186603907;306.4158157852766635,409.3916737546675222,409.3916737546674085,306.4158157852767204,-715.8074895399441857,-715.8074895399439583;0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000] / 1000 "Polozaj tacaka Ai";
  parameter SI.Position B[3, 6] = [697.3362886642219109,401.5035054457322872,-401.5035054457322872,-697.3362886642219109,-295.8327832184895101,295.8327832184896238;61.0090199233606896,573.4064310022943118,573.4064310022941982,61.0090199233607322,-634.4154509256550227,-634.4154509256549090;0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000,0.0000000000000000] / 1000 "Polozaj tacaka Bi";
  parameter SI.Position Pb[3, 6] = [475.4449058752382484,135.0623043503295833,-135.0623043503296401,-475.4449058752382484,-340.3826015249086936,340.3826015249086367;-118.5417288438371912,471.0182310097762866,471.0182310097762297,-118.5417288438370775,-352.4765021659390527,-352.4765021659390527;888.2956888774923527,888.2956888774923527,888.2956888774923527,888.2956888774923527,888.2956888774923527,888.2956888774923527] / 1000 "Polozaj tacaka Pi";
  parameter Real i_m[3, 6] = [0.7628676012727331,-0.5098536248573545,-0.5098536248573545,0.7628676012727331,-0.2530139764153786,-0.2530139764153784;0.1482864401665435,-0.5865195023430131,0.5865195023430131,-0.1482864401665438,-0.7348059425095567,0.7348059425095568;0.6293203910498374,-0.6293203910498374,0.6293203910498374,-0.6293203910498374,0.6293203910498374,-0.6293203910498374] "Jedinicni vektor ose aktuatora";
  parameter SI.Position BA[3, 6] = Ab - B;
  parameter SI.Position AP[3, 6] = Pb - Ab;
  parameter SI.Position POp[3, 6] = Op0 * ones(1, 6) - Pb;
  parameter SI.Position Pij[3, 6] = [Pb[:,2:6]-Pb[:,1:5],Pb[:,1]-Pb[:,6]];
  parameter SI.Diameter D_M(min = 0) = 60 / 1000;
  parameter SI.Length L_M(min = 0) = 150 / 1000;
  parameter SI.Mass M_M(min = 0) = 0.01;
  parameter SI.Diameter D_B(min = 0) = 80 / 1000;
  parameter SI.Length L_B(min = 0) = 80 / 1000;
  parameter SI.Diameter D_BA(min = 0) = 60 / 1000;
  parameter SI.Diameter D_BAs(min = 0) = 80 / 1000;
  parameter SI.Mass M_BA(min = 0) = 0.01;
  parameter SI.Diameter D_A(min = 0) = 80 / 1000;
  parameter SI.Diameter D_AP(min = 0) = 60 / 1000;
  parameter SI.Diameter D_APs(min = 0) = 80 / 1000;
  parameter SI.Mass M_AP(min = 0) = 0.01;
  parameter SI.Diameter D_P(min = 0) = 80 / 1000;
  parameter SI.Length H_P(min = 0) = 60 / 1000;
  parameter SI.Diameter D_Op(min = 0) = 150 / 1000;
  parameter SI.Position r_Mb[3, 6] = -i_m * L_M / 2;
  
  inner Modelica.Mechanics.MultiBody.World world(g = g, n = {0, 0, -1}) annotation(
    Placement(visible = true, transformation(origin = {-116, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F1(animation = false, r = B[:, 1]) annotation(
    Placement(visible = true, transformation(origin = {-74, 56}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F2(animation = false, r = B[:, 2]) annotation(
    Placement(visible = true, transformation(origin = {-74, 32}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F3(animation = false, r = B[:, 3]) annotation(
    Placement(visible = true, transformation(origin = {-74, 8}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F4(animation = false, r = B[:, 4]) annotation(
    Placement(visible = true, transformation(origin = {-74, -16}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F5(animation = false, r = B[:, 5]) annotation(
    Placement(visible = true, transformation(origin = {-74, -40}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.Fixed F6(animation = false, r = B[:, 6]) annotation(
    Placement(visible = true, transformation(origin = {-74, -64}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B1(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 1], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B2(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 2], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B3(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 3], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B4(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 4], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B5(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 5], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B6(cylinderColor = {255, 153, 51}, cylinderDiameter = D_B, cylinderLength = L_B, n = i_m[:, 6], phi(start = 0), stateSelect = StateSelect.always, useAxisFlange = true) annotation(
    Placement(visible = true, transformation(origin = {-56, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B1A1(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 1], r_0(each fixed = false, start = Ab[:, 1]), r_CM = BA[:, 1] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B2A2(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 2], r_0(each fixed = false, start = Ab[:, 2]), r_CM = BA[:, 2] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B3A3(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 3], r_0(each fixed = false, start = Ab[:, 3]), r_CM = BA[:, 3] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B4A4(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 4], r_0(each fixed = false, start = Ab[:, 4]), r_CM = BA[:, 4] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B5A5(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 5], r_0(each fixed = false, start = Ab[:, 5]), r_CM = BA[:, 5] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape B6A6(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_BA, r = BA[:, 6], r_0(each fixed = false, start = Ab[:, 6]), r_CM = BA[:, 6] / 2, shapeType = "cylinder", sphereDiameter = D_BAs, useQuaternions = false, width = D_BA) annotation(
    Placement(visible = true, transformation(origin = {-32, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A1(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A2(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A3(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A4(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A5(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical A6(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_A) annotation(
    Placement(visible = true, transformation(origin = {-8, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A1P1(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 1], r_0(each fixed = false, start = Pb[:, 1]), r_CM = AP[:, 1] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A2P2(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 2], r_0(each fixed = false, start = Pb[:, 2]), r_CM = AP[:, 2] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A3P3(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 3], r_0(each fixed = false, start = Pb[:, 3]), r_CM = AP[:, 3] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A4P4(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 4], r_0(each fixed = false, start = Pb[:, 4]), r_CM = AP[:, 4] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A5P5(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 5], r_0(each fixed = false, start = Pb[:, 5]), r_CM = AP[:, 5] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape A6P6(animateSphere = false, animation = true, color = {153, 153, 153}, enforceStates = false, m = M_AP, r = AP[:, 6], r_0(each fixed = false, start = Pb[:, 6]), r_CM = AP[:, 6] / 2, shapeType = "cylinder", sphereDiameter = D_APs, useQuaternions = false, width = D_AP) annotation(
    Placement(visible = true, transformation(origin = {16, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P1Op(color = {51, 51, 51}, r = POp[:, 1], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P2Op(color = {51, 51, 51}, r = POp[:, 2], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P3Op(color = {51, 51, 51}, r = POp[:, 3], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P4Op(color = {51, 51, 51}, r = POp[:, 4], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P5Op(color = {51, 51, 51}, r = POp[:, 5], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P6Op(color = {51, 51, 51}, r = POp[:, 6], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {66, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P1(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P2(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P3(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P4(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P5(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Spherical P6(enforceStates = false,sphereColor = {255, 153, 51}, sphereDiameter = D_P) annotation(
    Placement(visible = true, transformation(origin = {40, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.Body M(enforceStates = false,m = m, r_CM = cg, sphereColor = {51, 51, 51}, sphereDiameter = D_Op, useQuaternions = false) annotation(
    Placement(visible = true, transformation(origin = {89, -9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb1(color = {51, 51, 51}, length = L_M, r = i_m[:, 1], r_shape = r_Mb[:,1], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, 46}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb2(color = {51, 51, 51}, length = L_M, r = i_m[:, 2], r_shape = r_Mb[:, 2], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb3(color = {51, 51, 51}, length = L_M, r = i_m[:, 3], r_shape = r_Mb[:, 3], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb4(color = {51, 51, 51}, length = L_M, r = i_m[:, 4], r_shape = r_Mb[:, 4], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, -26}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb5(color = {51, 51, 51}, length = L_M, r = i_m[:, 5], r_shape = r_Mb[:, 5], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation Mb6(color = {51, 51, 51}, length = L_M, r = i_m[:, 6], r_shape = r_Mb[:, 6], width = D_M) annotation(
    Placement(visible = true, transformation(origin = {-74, -74}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P12(color = {51, 51, 51}, r = Pij[:, 1], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {31, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P23(color = {51, 51, 51}, r = Pij[:, 2], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {13, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P34(color = {51, 51, 51}, r = Pij[:, 3], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {-5, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P45(color = {51, 51, 51}, r = Pij[:, 4], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {-23, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P56(color = {51, 51, 51}, r = Pij[:, 5], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {-41, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation P61(color = {51, 51, 51}, r = Pij[:, 6], width = H_P) annotation(
    Placement(visible = true, transformation(origin = {49, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sources.Position M1(w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Position M2(a(fixed = true), w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Position M3(a(fixed = true), w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Position M4(a(fixed = true), w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Position M5(a(fixed = true), w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Position M6(a(fixed = true), w(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-102, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha1(duration = t_ramp, height = alpha[1, 1], offset = offset_ramp, startTime = t1_ramp)  annotation(
    Placement(visible = true, transformation(origin = {-122, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha2(duration = t_ramp, height = alpha[2, 1], offset = offset_ramp, startTime = t1_ramp) annotation(
    Placement(visible = true, transformation(origin = {-122, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha3(duration = t_ramp, height = alpha[3, 1], offset = offset_ramp, startTime = t1_ramp) annotation(
    Placement(visible = true, transformation(origin = {-122, 6}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha4(duration = t_ramp, height = alpha[4, 1], offset = offset_ramp, startTime = t1_ramp) annotation(
    Placement(visible = true, transformation(origin = {-122, -16}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha5(duration = t_ramp, height = alpha[5, 1], offset = offset_ramp, startTime = t1_ramp) annotation(
    Placement(visible = true, transformation(origin = {-122, -40}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp alpha6(duration = t_ramp, height = alpha[6, 1], offset = offset_ramp, startTime = t1_ramp) annotation(
    Placement(visible = true, transformation(origin = {-122, -64}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));

equation
  connect(F1.frame_b, B1.frame_a) annotation(
    Line(points = {{-74, 52}, {-66, 52}}));
  connect(F2.frame_b, B2.frame_a) annotation(
    Line(points = {{-74, 28}, {-66, 28}}));
  connect(F3.frame_b, B3.frame_a) annotation(
    Line(points = {{-74, 4}, {-66, 4}}));
  connect(F4.frame_b, B4.frame_a) annotation(
    Line(points = {{-74, -20}, {-66, -20}}));
  connect(F5.frame_b, B5.frame_a) annotation(
    Line(points = {{-74, -44}, {-66, -44}}));
  connect(F6.frame_b, B6.frame_a) annotation(
    Line(points = {{-74, -68}, {-66, -68}}));
  connect(B1.frame_b, B1A1.frame_a) annotation(
    Line(points = {{-46, 52}, {-42, 52}}));
  connect(B2.frame_b, B2A2.frame_a) annotation(
    Line(points = {{-46, 28}, {-42, 28}}));
  connect(B3.frame_b, B3A3.frame_a) annotation(
    Line(points = {{-46, 4}, {-42, 4}}));
  connect(B4.frame_b, B4A4.frame_a) annotation(
    Line(points = {{-46, -20}, {-42, -20}}));
  connect(B5.frame_b, B5A5.frame_a) annotation(
    Line(points = {{-46, -44}, {-42, -44}}));
  connect(B6.frame_b, B6A6.frame_a) annotation(
    Line(points = {{-46, -68}, {-42, -68}}));
  connect(B1A1.frame_b, A1.frame_a) annotation(
    Line(points = {{-22, 52}, {-18, 52}}));
  connect(B2A2.frame_b, A2.frame_a) annotation(
    Line(points = {{-22, 28}, {-18, 28}}));
  connect(B3A3.frame_b, A3.frame_a) annotation(
    Line(points = {{-22, 4}, {-18, 4}}));
  connect(B4A4.frame_b, A4.frame_a) annotation(
    Line(points = {{-22, -20}, {-18, -20}}));
  connect(B5A5.frame_b, A5.frame_a) annotation(
    Line(points = {{-22, -44}, {-18, -44}}));
  connect(B6A6.frame_b, A6.frame_a) annotation(
    Line(points = {{-22, -68}, {-18, -68}}));
  connect(A1.frame_b, A1P1.frame_a) annotation(
    Line(points = {{2, 52}, {6, 52}}));
  connect(A2.frame_b, A2P2.frame_a) annotation(
    Line(points = {{2, 28}, {6, 28}}));
  connect(A3.frame_b, A3P3.frame_a) annotation(
    Line(points = {{2, 4}, {6, 4}}));
  connect(A4.frame_b, A4P4.frame_a) annotation(
    Line(points = {{2, -20}, {6, -20}}));
  connect(A5.frame_b, A5P5.frame_a) annotation(
    Line(points = {{2, -44}, {6, -44}}));
  connect(A6.frame_b, A6P6.frame_a) annotation(
    Line(points = {{2, -68}, {6, -68}}));
  connect(A1P1.frame_b, P1.frame_a) annotation(
    Line(points = {{26, 52}, {30, 52}}));
  connect(A2P2.frame_b, P2.frame_a) annotation(
    Line(points = {{26, 28}, {30, 28}}));
  connect(A3P3.frame_b, P3.frame_a) annotation(
    Line(points = {{26, 4}, {30, 4}}));
  connect(A4P4.frame_b, P4.frame_a) annotation(
    Line(points = {{26, -20}, {30, -20}}));
  connect(A5P5.frame_b, P5.frame_a) annotation(
    Line(points = {{26, -44}, {30, -44}}));
  connect(A6P6.frame_b, P6.frame_a) annotation(
    Line(points = {{26, -68}, {30, -68}}));
  connect(P1.frame_b, P1Op.frame_a) annotation(
    Line(points = {{50, 52}, {56, 52}}));
  connect(P2.frame_b, P2Op.frame_a) annotation(
    Line(points = {{50, 28}, {56, 28}}));
  connect(P3.frame_b, P3Op.frame_a) annotation(
    Line(points = {{50, 4}, {56, 4}}));
  connect(P4.frame_b, P4Op.frame_a) annotation(
    Line(points = {{50, -20}, {56, -20}}));
  connect(P5.frame_b, P5Op.frame_a) annotation(
    Line(points = {{50, -44}, {56, -44}}));
  connect(P6.frame_b, P6Op.frame_a) annotation(
    Line(points = {{50, -68}, {56, -68}}));
  connect(P1Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, 52}, {76, 52.5}, {82, 52.5}, {82, -9}}));
  connect(P2Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, 28}, {76, 29}, {82, 29}, {82, -9}}));
  connect(P3Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, 4}, {76, 5}, {82, 5}, {82, -9}}));
  connect(P4Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, -20}, {76, -19}, {82, -19}, {82, -9}}));
  connect(P5Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, -44}, {76, -43.5}, {82, -43.5}, {82, -9}}));
  connect(P6Op.frame_b, M.frame_a) annotation(
    Line(points = {{76, -68}, {76, -67.75}, {82, -67.75}, {82, -9}}));
  connect(Mb1.frame_a, F1.frame_b) annotation(
    Line(points = {{-80, 46}, {-80, 52}, {-74, 52}}));
  connect(Mb2.frame_a, F2.frame_b) annotation(
    Line(points = {{-80, 22}, {-80, 28}, {-74, 28}}));
  connect(Mb3.frame_a, F3.frame_b) annotation(
    Line(points = {{-80, -2}, {-80, 4}, {-74, 4}}));
  connect(Mb4.frame_a, F4.frame_b) annotation(
    Line(points = {{-80, -26}, {-80, -20}, {-74, -20}}));
  connect(Mb5.frame_a, F5.frame_b) annotation(
    Line(points = {{-80, -50}, {-80, -44}, {-74, -44}}));
  connect(Mb6.frame_a, F6.frame_b) annotation(
    Line(points = {{-80, -74}, {-80.5, -74}, {-80.5, -68}, {-74, -68}}));
  connect(P61.frame_a, P6Op.frame_a) annotation(
    Line(points = {{56, -87}, {56, -68}}));
  connect(P61.frame_b, P12.frame_a) annotation(
    Line(points = {{42, -86}, {38, -86}, {38, -86}, {38, -86}}));
  connect(P12.frame_b, P23.frame_a) annotation(
    Line(points = {{24, -86}, {20, -86}, {20, -86}, {20, -86}}));
  connect(P23.frame_b, P34.frame_a) annotation(
    Line(points = {{6, -86}, {2, -86}, {2, -86}, {2, -86}}));
  connect(P34.frame_b, P45.frame_a) annotation(
    Line(points = {{-12, -86}, {-16, -86}, {-16, -86}, {-16, -86}}));
  connect(P45.frame_b, P56.frame_a) annotation(
    Line(points = {{-30, -86}, {-34, -86}, {-34, -86}, {-34, -86}}));
  connect(M1.flange, B1.axis) annotation(
    Line(points = {{-92, 56}, {-86, 56}, {-86, 64}, {-55.5, 64}, {-55.5, 62}, {-56, 62}}));
  connect(M2.flange, B2.axis) annotation(
    Line(points = {{-92, 30}, {-86, 30}, {-86, 40}, {-56, 40}, {-56, 38}, {-56, 38}}));
  connect(M3.flange, B3.axis) annotation(
    Line(points = {{-92, 6}, {-86, 6}, {-86, 16}, {-56, 16}, {-56, 14}, {-56, 14}}));
  connect(M4.flange, B4.axis) annotation(
    Line(points = {{-92, -16}, {-86, -16}, {-86, -8}, {-56, -8}, {-56, -10}, {-56, -10}}));
  connect(M5.flange, B5.axis) annotation(
    Line(points = {{-92, -40}, {-86, -40}, {-86, -32}, {-56, -32}, {-56, -34}, {-56, -34}}));
  connect(M6.flange, B6.axis) annotation(
    Line(points = {{-92, -64}, {-86, -64}, {-86, -56}, {-56, -56}, {-56, -58}}));
  connect(alpha1.y, M1.phi_ref) annotation(
    Line(points = {{-118, 56}, {-114, 56}}, color = {0, 0, 127}));
  connect(alpha2.y, M2.phi_ref) annotation(
    Line(points = {{-118, 30}, {-114, 30}}, color = {0, 0, 127}));
  connect(alpha3.y, M3.phi_ref) annotation(
    Line(points = {{-118, 6}, {-114, 6}}, color = {0, 0, 127}));
  connect(alpha4.y, M4.phi_ref) annotation(
    Line(points = {{-118, -16}, {-114, -16}}, color = {0, 0, 127}));
  connect(alpha5.y, M5.phi_ref) annotation(
    Line(points = {{-118, -40}, {-114, -40}}, color = {0, 0, 127}));
  connect(alpha6.y, M6.phi_ref) annotation(
    Line(points = {{-118, -64}, {-114, -64}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
  Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
  Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
  version = "");
end modelStatikaParametarski;
