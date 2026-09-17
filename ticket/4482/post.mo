package Post
  package Chemsep_Database
    model General_Properties
  parameter Integer SN;
  parameter String name;
  parameter Real Tc;
  parameter Real Pc;
  parameter Real Vc;
  parameter Real Cc;
  parameter Real Tb;
  parameter Real Tm;
  parameter Real TT;
  parameter Real TP;
  parameter Real MW;
  parameter Real LVB;
  parameter Real AF;
  parameter Real SP;
  parameter Real DM;
  parameter Real SH;
  parameter Real IGHF;
  parameter Real GEF;
  parameter Real AS;
  parameter Real HFMP;
  parameter Real HOC;
  parameter Real UniquacR;
  parameter Real UniquacQ;
  parameter Real LiqDen[6];
  parameter Real VP[6];
  parameter Real LiqCp[6];
  parameter Real HOV[6];
  parameter Real VapCp[6];
  parameter Real LiqVis[6];
  parameter Real VapVis[6];
  parameter Real LiqK[6];
  parameter Real VapK[6];
  parameter Real Racketparam;
end General_Properties;

  model Benzene
    extends General_Properties(SN = 125, name = "Benzene", Tc = 562.05, Pc = 4895000, Vc = 0.256, Cc = 0.268, Tb = 353.24, Tm = 278.68, TT = 278.68, TP = 4764.22, MW = 78.114, LVB = 0.08941, AF = 0.209, SP = 18700, DM = 0, SH = 49073013.1279, IGHF = 8.288E+07, GEF = 1.296E+08, AS = 269300, HFMP = 9866000, HOC = -3.136E+09, LiqDen = {105, 0.99938, 0.26348, 562.05, 0.27856, 0}, VP = {101, 88.368, -6712.9, -10.022, 0.000007694, 2}, LiqCp = {16, 111460, -1854.3, 22.399, -0.028936, 0.000028991}, HOV = {106, 4.881E+07, 0.61066, -0.25882, 0.032238, 0.022475}, VapCp = {16, 34010.24, -588.0978, 12.81777, -0.000197306, 5.142899E-08}, LiqVis = {101, -24.61, 1576.5, 2.1698, -0.0000051366, 2}, VapVis = {102, 3.1366E-08, 0.9675, 8.0285, -35.629, 0}, LiqK = {16, 0.049539, -177.97, 0.19475, -0.0073805, 0.0000027938}, VapK = {102, 0.0000049549, 1.4519, 154.14, 26202, 0}, Racketparam = 0.2696, UniquacR = 3.1878, UniquacQ = 2.4);
  end Benzene;
  
  model Toluene
    extends General_Properties(SN = 140, name = "Toluene", Tc = 591.75, Pc = 4108000, Vc = 0.316, Cc = 0.264, Tb = 383.79, Tm = 178.18, TT = 178.18, TP = 0.0475285, MW = 92.141, LVB = 0.10687, AF = 0.264, SP = 18250, DM = 1.2E-30, SH = 12079609.7184, IGHF = 5.017E+07, GEF = 1.222E+08, AS = 320990, HFMP = 6636000, HOC = -3.734E+09, LiqDen = {105, 0.89799, 0.27359, 591.75, 0.30006, 0}, VP = {101, 32.89891, -5013.81, -1.348918, -1.869928E-06, 2}, LiqCp = {16, 28291, 48.171, 10.912, 0.0020542, 8.7875E-07}, HOV = {106, 5.3752E+07, 0.50341, 0.24755, -0.72898, 0.37794}, VapCp = {16, 47225, -565.85, 12.856, 0.000005535, -1.998E-08}, LiqVis = {101, -152.84, 5644.6, 22.826, -0.000040987, 2}, VapVis = {102, 8.5581E-07, 0.49514, 307.82, 1891.6, 0}, LiqK = {16, -0.072922, -23.153, -1.0277, -0.0017074, 3.6787E-07}, VapK = {102, 0.000006541, 1.4227, 190.97, 21890, 0}, Racketparam = 0.2646, UniquacR = 3.9228, UniquacQ = 2.968);
  end Toluene;
  
  end Chemsep_Database;
  
  function Psat
  /*Returns vapor pressure at given temperature*/
  input Real VP[6] "from chemsep database";
  input Real T(unit = "K") "Temperature";
  output Real Vp(unit = "Pa") "Vapor pressure";
algorithm
  Vp := exp(VP[2] + VP[3] / T + VP[4] * log(T) + VP[5] .* T .^ VP[6]);
end Psat;

  function LiqCpId
    /*Calculates specific heat of liquid at given Temperature*/
    input Real LiqCp[6] "from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Cp(unit = "J/mol") "Specific heat of liquid";
  algorithm
    Cp := (LiqCp[2] + exp(LiqCp[3] / T + LiqCp[4] + LiqCp[5] * T + LiqCp[6] * T ^ 2)) / 1000;
  end LiqCpId;


  function VapCpId
    /*Calculates Vapor Specific Heat*/
    input Real VapCp[6] "from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Cp(unit = "J/mol.K") "specific heat";
  algorithm
    Cp := (VapCp[2] + exp(VapCp[3] / T + VapCp[4] + VapCp[5] * T + VapCp[6] * T ^ 2)) / 1000;
  end VapCpId;
  
   function HV
    /*Returns Heat of Vaporization*/
    input Real HOV[6] "from chemsep database";
    input Real Tc(unit = "K") "Critical Temperature";
    input Real T(unit = "K") "Temperature";
    output Real Hv(unit = "J/mol") "Heat of Vaporization";
  protected
    Real Tr = T / Tc;
  algorithm
    Hv := HOV[2] * (1 - Tr) ^ (HOV[3] + HOV[4] * Tr + HOV[5] * Tr ^ 2 + HOV[6] * Tr ^ 3) / 1000;
  end HV;




  function HLiqId
    /* Calculates Enthalpy of Ideal Liquid*/
    input Real SH(unit = "J/kmol") "from chemsep database std. Heat of formation";
    input Real VapCp[6] "from chemsep database";
    input Real HOV[6] "from chemsep database";
    input Real Tc "critical temp, from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Ent(unit = "J/mol") "Molar Enthalpy";
  algorithm
    Ent := HVapId(SH, VapCp, HOV, Tc, T) - HV(HOV, Tc, T);
  end HLiqId;







  function HVapId
    /* Calculates enthalpy of ideal vapor */
    input Real SH(unit = "J/kmol") "from chemsep database std. Heat of formation";
    input Real VapCp[6] "from chemsep database";
    input Real HOV[6] "from chemsep database";
    input Real Tc "critical temp, from chemsep database";
    input Real T(unit = "K") "Temperature";
    output Real Ent(unit = "J/mol") "Molar Enthalpy";
  protected
    Real Temp = 298.15;
  algorithm
    Ent := 0;
    if T > 298.15 then
      while Temp < T loop
        Ent := Ent + VapCpId(VapCp, Temp) * 0.01;
        Temp := Temp + 0.01;
      end while;
      Ent := Ent;
    else
      while Temp > T loop
        Ent := Ent + VapCpId(VapCp, Temp) * 0.01;
        Temp := Temp - 0.01;
      end while;
      Ent := -Ent;
    end if;
  end HVapId;

  model Raoults_Law
      import Simulator.Files.Thermodynamic_Functions.*;
      Real K[NOC](each min = 0), resMolSpHeat[3], resMolEnth[3], resMolEntr[3];
    equation
      for i in 1:NOC loop
        K[i] = Psat(comp[i].VP, T) / P;
      end for;
      resMolSpHeat[:] = zeros(3);
      resMolEnth[:] = zeros(3);
      resMolEntr = zeros(3);
    end Raoults_Law;
  
  package Connection
    connector matConn
      Real P, T, mixMolFlo, mixMolEnth, mixMolEntr, mixMolFrac[connNOC](each min = 0, each max = 1), vapPhasMolFrac(min = 0, max = 1);
      parameter Integer connNOC;
      annotation(Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end matConn;


    connector enConn
      Real enFlo;
      annotation(Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 33}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end enConn;



    connector trayConn
      Real  mixMolFlo, mixMolEnth, mixMolFrac[connNOC](each min = 0, each max = 1);
      parameter Integer connNOC;
      annotation(Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {8, 184, 211}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end trayConn;

  end Connection;
  
  model Condensor1
  extends Raoults_Law;
  parameter Integer NOC = 2;
  parameter Chemsep_Database.General_Properties comp[NOC];
  Real P, T;
  Real feedMolFlo(min = 0), sideDrawMolFlo(min = 0), inVapMolFlo(min = 0), outLiqMolFlo(min = 0), feedMolFrac[NOC](each min = 0, each max = 1), sideDrawMolFrac[NOC](each min = 0 , each max = 1), inVapCompMolFrac[NOC](each min = 0, each max = 1), outLiqCompMolFrac[NOC](each min = 0, each max = 1), feedMolEnth, inVapMolEnth, outLiqMolEnth, outVapCompMolEnth[NOC], outLiqCompMolEnth[NOC], heatLoad, sideDrawMolEnth;
  
  parameter String condType"Partial or Total";
  Connection.matConn feed(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.matConn side_draw(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn liquid_outlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn vapor_inlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.enConn heat_load annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//connector equation
  feed.mixMolFrac = feedMolFrac;
  feed.mixMolEnth = feedMolEnth;
  feed.mixMolFlo = feedMolFlo;
  
  side_draw.P = P;
  side_draw.T = T;
  side_draw.mixMolFrac = sideDrawMolFrac;
  side_draw.mixMolFlo = sideDrawMolFlo;
  side_draw.mixMolEnth = sideDrawMolEnth;
  
  liquid_outlet.mixMolFlo = outLiqMolFlo;
  liquid_outlet.mixMolEnth = outLiqMolEnth;
  liquid_outlet.mixMolFrac[:] = outLiqCompMolFrac[:];
  
  vapor_inlet.mixMolFlo = inVapMolFlo;
  vapor_inlet.mixMolEnth = inVapMolEnth;
  vapor_inlet.mixMolFrac[:] = inVapCompMolFrac[:];
  
  heat_load.enFlo = heatLoad;
//molar balance
  //feedMolFlo + inVapMolFlo = sideDrawMolFlo + outLiqMolFlo;
  feedMolFlo .* feedMolFrac[:] + inVapMolFlo .* inVapCompMolFrac[:] = sideDrawMolFlo .* sideDrawMolFrac[:] + outLiqMolFlo .* outLiqCompMolFrac[:];
//equillibrium
  if (condType == "Partial") then
    sideDrawMolFrac[:] = K[:] .* outLiqCompMolFrac[:];
    sideDrawMolEnth = sum(sideDrawMolFrac[:] .* outVapCompMolEnth[:]) + resMolEnth[3];
  elseif (condType == "Total") then
    sideDrawMolFrac[:] = outLiqCompMolFrac[:];
    sideDrawMolEnth = sum(sideDrawMolFrac[:] .* outLiqCompMolEnth[:]) + resMolEnth[2];
  end if; 
//summation equation
  sum(outLiqCompMolFrac[:]) = 1;
  //sum(sideDrawMolFrac[:]) = 1;
// Enthalpy balance
  feedMolFlo * feedMolEnth + inVapMolFlo * inVapMolEnth = sideDrawMolFlo * sideDrawMolEnth + outLiqMolFlo * outLiqMolEnth + heatLoad;

//enthalpy calculation
  for i in 1:NOC loop
    outLiqCompMolEnth[i] = HLiqId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
    outVapCompMolEnth[i] = HVapId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
  end for;
  outLiqMolEnth = sum(outLiqCompMolFrac[:] .* outLiqCompMolEnth[:]) + resMolEnth[2];
//  outVapMolEnth = sum(inVapCompMolFrac[:] .* outVapCompMolEnth[:]) + resMolEnth[3];

  



  annotation(
    Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    Icon(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    __OpenModelica_commandLineOptions = "");
end Condensor1;





model Reboiler1
    extends Raoults_Law;
    parameter Integer NOC = 2;
    parameter Chemsep_Database.General_Properties comp[NOC];
    Real P, T;
    Real feedMolFlo(min = 0), sideDrawMolFlo(min = 0), outVapMolFlo(min = 0), inLiqMolFlo(min = 0), feedMolFrac[NOC](each min = 0, each max = 1), sideDrawMolFrac[NOC](each min = 0, each max = 1), outVapCompMolFrac[NOC](each min = 0, each max = 1), inLiqCompMolFrac[NOC](each min = 0, each max = 1), feedMolEnth, outVapMolEnth, inLiqMolEnth, outVapCompMolEnth[NOC], sideDrawCompMolEnth[NOC], heatLoad, sideDrawMolEnth;
    
    Connection.matConn feed(connNOC = NOC) annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Connection.matConn side_draw(connNOC = NOC) annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Connection.trayConn liquid_inlet(connNOC = NOC) annotation(
      Placement(visible = true, transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Connection.trayConn vapor_outlet(connNOC = NOC) annotation(
      Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Connection.enConn heat_load annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  //connector equation
    feed.mixMolFrac = feedMolFrac;
    feed.mixMolEnth = feedMolEnth;
    feed.mixMolFlo = feedMolFlo;
    
    side_draw.P = P;
    side_draw.T = T;
    side_draw.mixMolFrac = sideDrawMolFrac;
    side_draw.mixMolFlo = sideDrawMolFlo;
    side_draw.mixMolEnth = sideDrawMolEnth;
    
    liquid_inlet.mixMolFlo = inLiqMolFlo;
    liquid_inlet.mixMolEnth = inLiqMolEnth;
    liquid_inlet.mixMolFrac[:] = inLiqCompMolFrac[:];
    
    vapor_outlet.mixMolFlo = outVapMolFlo;
    vapor_outlet.mixMolEnth = outVapMolEnth;
    vapor_outlet.mixMolFrac[:] = outVapCompMolFrac[:];
    
    heat_load.enFlo = heatLoad;
//molar balance
feedMolFlo + inLiqMolFlo = sideDrawMolFlo + outVapMolFlo;
  
   // feedMolFlo .* feedMolFrac[:] + inLiqMolFlo .* inLiqCompMolFrac[:] = sideDrawMolFlo .* sideDrawMolFrac[:] + outVapMolFlo .* outVapCompMolFrac[:];
  
//equillibrium
    outVapCompMolFrac[:] = K[:] .* sideDrawMolFrac[:];
//summation equation
    sum(outVapCompMolFrac[:]) = 1;
 sum(sideDrawMolFrac[:]) = 1;
// Enthalpy balance
    feedMolFlo * feedMolEnth + inLiqMolFlo * inLiqMolEnth = sideDrawMolFlo * sideDrawMolEnth + outVapMolFlo * outVapMolEnth + heatLoad;
//enthalpy calculation
    for i in 1:NOC loop
      sideDrawCompMolEnth[i] =HLiqId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
      outVapCompMolEnth[i] = HVapId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
    end for;
    sideDrawMolEnth = sum(sideDrawMolFrac[:] .* sideDrawCompMolEnth[:]) + resMolEnth[2];
    outVapMolEnth = sum(outVapCompMolFrac[:] .* outVapCompMolEnth[:]) + resMolEnth[3];
    annotation(
    Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    Icon(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    __OpenModelica_commandLineOptions = "");
end Reboiler1;





model distillTray1
extends Raoults_Law;
  parameter Integer NOC = 2;
  parameter Chemsep_Database.General_Properties comp[NOC];
  Real P, T(start = (min(comp[:].Tb) + max(comp[:].Tb)) / NOC);
  Real feedMolFlo(min = 0), sideDrawMolFlo(min = 0), vapMolFlo[2](each min = 0), liqMolFlo[2](each min = 0), feedMolFrac[NOC](each min = 0, each max = 1), sideDrawMolFrac[NOC](each min = 0, each max = 1), vapCompMolFrac[2, NOC](each min = 0, each max = 1), liqCompMolFrac[2, NOC](each min = 0, each max = 1), feedMolEnth, vapMolEnth[2], liqMolEnth[2], outVapCompMolEnth[NOC], outLiqCompMolEnth[NOC], heatLoad, sideDrawMolEnth;
  String sideDrawType(start = "Null");
  //L or V
  Connection.matConn feed(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.matConn side_draw(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn liquid_inlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn liquid_outlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn vapor_outlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.trayConn vapor_inlet(connNOC = NOC) annotation(
    Placement(visible = true, transformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connection.enConn heat_load annotation(
    Placement(visible = true, transformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//connector equation
  feed.mixMolFrac = feedMolFrac;
  feed.mixMolEnth = feedMolEnth;
  feed.mixMolFlo = feedMolFlo;
  
  side_draw.P = P;
  side_draw.T = T;
  side_draw.mixMolFrac = sideDrawMolFrac;
  side_draw.mixMolFlo = sideDrawMolFlo;
  side_draw.mixMolEnth = sideDrawMolEnth;
  
  liquid_inlet.mixMolFlo = liqMolFlo[1];
  liquid_inlet.mixMolEnth = liqMolEnth[1];
  liquid_inlet.mixMolFrac[:] = liqCompMolFrac[1, :];
  
  liquid_outlet.mixMolFlo = liqMolFlo[2];
  liquid_outlet.mixMolEnth = liqMolEnth[2];
  liquid_outlet.mixMolFrac[:] = liqCompMolFrac[2, :];
  
  vapor_inlet.mixMolFlo = vapMolFlo[1];
  vapor_inlet.mixMolEnth = vapMolEnth[1];
  vapor_inlet.mixMolFrac[:] = vapCompMolFrac[1, :];
  
  vapor_outlet.mixMolFlo = vapMolFlo[2];
  vapor_outlet.mixMolEnth = vapMolEnth[2];
  vapor_outlet.mixMolFrac[:] = vapCompMolFrac[2, :];
  
  heat_load.enFlo = heatLoad;
//molar balance
//feedMolFlo + vapMolFlo[1] + liqMolFlo[1] = sideDrawMolFlo + vapMolFlo[2] + liqMolFlo[2];
  feedMolFlo .* feedMolFrac[:] + vapMolFlo[1] .* vapCompMolFrac[1, :] + liqMolFlo[1] .* liqCompMolFrac[1, :] = sideDrawMolFlo .* sideDrawMolFrac[:] + vapMolFlo[2] .* vapCompMolFrac[2, :] + liqMolFlo[2] .* liqCompMolFrac[2, :];
//equillibrium
vapCompMolFrac[2, :] = K[:] .* liqCompMolFrac[2, :];
//summation equation
  sum(liqCompMolFrac[2, :]) = 1;
  sum(vapCompMolFrac[2, :]) = 1;
// Enthalpy balance
  feedMolFlo * feedMolEnth + vapMolFlo[1] * vapMolEnth[1] + liqMolFlo[1] * liqMolEnth[1] = sideDrawMolFlo * sideDrawMolEnth + vapMolFlo[2] * vapMolEnth[2] + liqMolFlo[2] * liqMolEnth[2] + heatLoad;
//enthalpy calculation
  for i in 1:NOC loop
    outLiqCompMolEnth[i] = HLiqId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
    outVapCompMolEnth[i] = HVapId(comp[i].SH, comp[i].VapCp, comp[i].HOV, comp[i].Tc, T);
  end for;
  liqMolEnth[2] = sum(liqCompMolFrac[2, :] .* outLiqCompMolEnth[:]) + resMolEnth[2];
  vapMolEnth[2] = sum(vapCompMolFrac[2, :] .* outVapCompMolEnth[:]) + resMolEnth[3];
//sidedraw calculation
  if sideDrawType == "L" then
    sideDrawMolFrac[:] = liqCompMolFrac[2, :];
  elseif sideDrawType == "V" then
    sideDrawMolFrac[:] = vapCompMolFrac[2, :];
  else
    sideDrawMolFrac[:] = zeros(NOC);
  end if;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    Icon(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    __OpenModelica_commandLineOptions = "");
end distillTray1;




model column1
  import data = Post.Chemsep_Database;
  //instantiation of chemsep database
  parameter data.Benzene benz;
  parameter data.Toluene tol;
  parameter Integer NOC = 2;
  parameter data.General_Properties comp[NOC] = {benz, tol};
  parameter String condType = "Total";
  parameter Integer noOfStages = 3, noOfFeeds = 1, feedStages[noOfFeeds] = {1}, noOfSideDraws = 0, sideDrawStages[noOfSideDraws], noOfHeatLoads = 1, heatLoadStages[noOfHeatLoads] = {1};
  
  distillTray1 tray[noOfStages - 2](each NOC = NOC,each comp = comp, T(start = 370), liquid_outlet.mixMolFlo(start = 81.3864),  vapor_outlet.mixMolFlo(start = 100.999));
  Condensor1 condensor(NOC = NOC, comp = comp, condType = condType, liquid_outlet.mixMolFlo(start = 50.999));
  Reboiler1 reboiler(NOC = NOC, comp = comp, vapor_outlet.mixMolFlo(start = 31.3864));
  
  //Connection.matConn feed[noOfFeeds](each connNOC = NOC);
  //Connection.enConn heat_load[noOfHeatLoads];
  
  equation
  //connector equation
    connect(tray[1].liquid_inlet, condensor.liquid_outlet);
    connect(tray[1].vapor_outlet, condensor.vapor_inlet);
    connect(tray[noOfStages - 2].liquid_outlet, reboiler.liquid_inlet);
    connect(tray[noOfStages - 2].vapor_inlet, reboiler.vapor_outlet);
  //tray equation
    tray[1].sideDrawType = "Null";
    tray[1].heat_load.enFlo = 0;
    tray[1].P = 101325;
    tray[1].feed.mixMolFlo = 100;
    tray[1].feed.mixMolEnth = -2584.65;
    tray[1].feed.mixMolFrac = {0.5, 0.5};
    tray[1].side_draw.mixMolFlo = 0;
    tray[1].side_draw.mixMolEnth = 0;
    tray[1].side_draw.mixMolEntr = 0;
    tray[1].side_draw.vapPhasMolFrac = 0;
    
  //condensor equation  
    condensor.P = 101325;
    condensor.side_draw.mixMolFlo = 50;
    condensor.side_draw.T = 351.1855;
    condensor.side_draw.mixMolEntr = 0;
    condensor.side_draw.vapPhasMolFrac = 0;
    
    
 //Reboiler equation
   reboiler.P = 101325;
  reboiler.side_draw.mixMolFlo = 50;
  reboiler.side_draw.T = 370.076;
  reboiler.side_draw.mixMolEntr = 0;
  reboiler.side_draw.vapPhasMolFrac = 0;

    
  algorithm
  //feed equation
  for i in 1:(noOfStages - 2) loop
    for j in 1:noOfFeeds loop
      if (feedStages[j] == i) then
        tray[i].feed.P := 101325;
        tray[i].feed.T := 370;
        tray[i].feed.mixMolEntr := 0;
        tray[i].feed.vapPhasMolFrac := 0;
        break;
      else
        tray[i].feed.P := 0;
        tray[i].feed.T := 0;
        tray[i].feed.mixMolEntr := 0;
        tray[i].feed.vapPhasMolFrac := 0;
      end if;
    end for;
  end for;
    
  for j in 1:noOfFeeds loop
    if (feedStages[j] == (noOfStages - 1)) then
      reboiler.feed.P := 0;
      reboiler.feed.T := 0;
      reboiler.feed.mixMolFlo := 0;
      reboiler.feed.mixMolEnth := 0;
      reboiler.feed.mixMolEntr := 0;
//      reboiler.feed.mixMolFrac[:] := zeros(NOC);
      reboiler.feed.vapPhasMolFrac := 0;
      break;
    else
      reboiler.feed.P := 0;
      reboiler.feed.T := 0;
      reboiler.feed.mixMolFlo := 0;
      reboiler.feed.mixMolEnth := 0;
      reboiler.feed.mixMolEntr := 0;
//      reboiler.feed.mixMolFrac[:] := zeros(NOC);
      reboiler.feed.vapPhasMolFrac := 0;
    end if;
  end for;
  
  for j in 1:noOfFeeds loop
    if (feedStages[j] == noOfStages) then
      condensor.feed.P := 0;
      condensor.feed.T := 0;
      condensor.feed.mixMolFlo := 0;
      condensor.feed.mixMolEnth := 0;
      condensor.feed.mixMolEntr := 0;
      condensor.feed.mixMolFrac[:] := zeros(NOC);
      condensor.feed.vapPhasMolFrac := 0;
      break;
    else
      condensor.feed.P := 0;
      condensor.feed.T := 0;
      condensor.feed.mixMolFlo := 0;
      condensor.feed.mixMolEnth := 0;
      condensor.feed.mixMolEntr := 0;
      condensor.feed.mixMolFrac[:] := zeros(NOC);
      condensor.feed.vapPhasMolFrac := 0;
    end if;
  end for;
  
  reboiler.feed.mixMolFrac := {0, 0};
  //condensor.feed.mixMolFrac := {0, 0};
  
  //Condensor and reboiler feed.mixMolFrac is creating a problem. If I directly giving value in algorithm it works. It gives error when ran inside if-else statement.    
end column1;






end Post;
