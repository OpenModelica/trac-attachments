encapsulated package EVQSPkg "Package per EV con modello QuasiStationary"
  import Modelica;
  import EVQSPkg;
  encapsulated model EVQS0 "Simulates an Electric Vehcile based on BASMADrive electric drive model"
    import Modelica;
    import EVQSPkg;
    parameter Modelica.SIunits.Mass vMass = 16000 "Vehicle mass";
    Modelica.Mechanics.Rotational.Components.IdealRollingWheel Wheel(radius = 0.5715) annotation(Placement(transformation(extent = {{-8,-50},{12,-30}})));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {78,-70})));
    Modelica.Mechanics.Translational.Components.Mass mass(m = vMass) annotation(Placement(transformation(extent = {{46,-50},{66,-30}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-14,36})));
    EVQSPkg.DCLConstP DCL(k = 1, T = 0.001) annotation(Placement(transformation(extent = {{-10,10},{10,-10}}, rotation = 270, origin = {-64,46})));
    Modelica.Blocks.Sources.Constant Paux(k = 60) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {-102,38})));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {28,-40})));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP2 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = -90, origin = {104,-50})));
    EVQSPkg.VhDragForce vhDragForce(m = vMass, Cx = 0.65, rho = 1.226, S = 6.0, fc = 0.013) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {104,-90})));
    Modelica.Mechanics.Rotational.Components.LossyGear Gear(lossTable = [0,1,1,0,0;34.13,0.963,0.963,0,0;136.7,0.952,0.952,0,0;546.5,0.893,0.893,0,0], ratio = 6) annotation(Placement(transformation(extent = {{-40,-50},{-20,-30}})));
    Modelica.Blocks.Continuous.Integrator MechEn annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 0, origin = {44,-70})));
    Modelica.Blocks.Continuous.Integrator DriveEn annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-102,4})));
    Modelica.Electrical.Analog.Sensors.PowerSensor P_DC annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-44,10})));
    EVQSPkg.propDriver Driver(yMax = 100, CycleFileName = "C:\\Users\\Administrator\\Dropbox\\Modelica\\Sort1.txt", k = 1000) annotation(Placement(transformation(extent = {{-110,-46},{-90,-26}})));
    EVQSPkg.QSDrivePU qSDrivePU(X1u = 0.044, R2u = 0.01956, X2u = 0.044, Xmu = 1.28, Hu = 1.23, pp = 2, Snom = 100000.0, LossFact = 4) annotation(Placement(transformation(extent = {{-10,10},{10,-10}}, rotation = -90, origin = {-66,-30})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start = 715), C = 2 * 240 * 3600 / 190 / (4.15 - 3.3)) annotation(Placement(transformation(extent = {{-82,74},{-62,94}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 0.02) annotation(Placement(transformation(extent = {{-48,74},{-28,94}})));
  equation
    connect(Paux.y,DCL.Pref) annotation(Line(points = {{-91,38},{-92,38},{-92,37.8},{-64,37.8}}, color = {0,0,127}, smooth = Smooth.None));
    connect(mP1.flange_a,Wheel.flangeT) annotation(Line(points = {{18,-40},{12,-40}}, color = {0,127,0}, smooth = Smooth.None));
    connect(mP2.flange_a,mass.flange_b) annotation(Line(points = {{104,-40},{66,-40}}, color = {0,127,0}, smooth = Smooth.None));
    connect(mass.flange_a,mP1.flange_b) annotation(Line(points = {{46,-40},{38,-40}}, color = {0,127,0}, smooth = Smooth.None));
    connect(speedSensor.flange,mP2.flange_a) annotation(Line(points = {{78,-60},{78,-40},{104,-40}}, color = {0,127,0}, smooth = Smooth.None));
    connect(vhDragForce.flange,mP2.flange_b) annotation(Line(points = {{104,-80},{104,-60}}, color = {0,127,0}, smooth = Smooth.None));
    connect(Gear.flange_b,Wheel.flangeR) annotation(Line(points = {{-20,-40},{-8,-40}}, color = {0,0,0}, smooth = Smooth.None));
    connect(MechEn.u,mP1.power) annotation(Line(points = {{32,-70},{20,-70},{20,-51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(P_DC.power,DriveEn.u) annotation(Line(points = {{-55,18},{-86,18},{-86,4},{-90,4}}, color = {0,0,127}, smooth = Smooth.None));
    connect(Driver.V,speedSensor.v) annotation(Line(points = {{-100,-47.2},{-100,-90},{78,-90},{78,-81}}, color = {0,0,127}, smooth = Smooth.None));
    connect(qSDrivePU.flange_a,Gear.flange_a) annotation(Line(points = {{-66,-40},{-40,-40}}, color = {0,0,0}, smooth = Smooth.None));
    connect(P_DC.nc,qSDrivePU.pin_n) annotation(Line(points = {{-44,0},{-48,0},{-48,-19.8},{-60,-19.8}}, color = {0,0,255}, smooth = Smooth.None));
    connect(P_DC.pv,P_DC.pc) annotation(Line(points = {{-34,10},{-32,10},{-32,20},{-44,20}}, color = {0,0,255}, smooth = Smooth.None));
    connect(P_DC.nv,qSDrivePU.pin_p) annotation(Line(points = {{-54,10},{-80,10},{-80,-19.8},{-72,-19.8}}, color = {0,0,255}, smooth = Smooth.None));
    connect(Driver.Tref,qSDrivePU.dWe) annotation(Line(points = {{-89,-30},{-78,-30}}, color = {0,0,127}, smooth = Smooth.None));
    connect(ground.p,DCL.pin_n) annotation(Line(points = {{-14,46},{-34.5,46},{-34.5,47},{-55,47}}, color = {0,0,255}, smooth = Smooth.None));
    connect(DCL.pin_n,P_DC.pc) annotation(Line(points = {{-55,47},{-44,47},{-44,20}}, color = {0,0,255}, smooth = Smooth.None));
    connect(DCL.pin_p,P_DC.nv) annotation(Line(points = {{-73.2,47},{-80,47},{-80,10},{-54,10}}, color = {0,0,255}, smooth = Smooth.None));
    connect(resistor.p,capacitor.n) annotation(Line(points = {{-48,84},{-62,84}}, color = {0,0,255}, smooth = Smooth.None));
    connect(resistor.n,DCL.pin_n) annotation(Line(points = {{-28,84},{-28,60},{-55,60},{-55,47}}, color = {0,0,255}, smooth = Smooth.None));
    connect(capacitor.p,DCL.pin_p) annotation(Line(points = {{-82,84},{-92,84},{-92,60},{-73.2,60},{-73.2,47}}, color = {0,0,255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-120,-100},{120,100}}), graphics = {Text(extent = {{8,76},{88,62}}, lineColor = {0,0,255}, textString = "1) perdite inverter
2) batteria completa
"),Rectangle(extent = {{-100,96},{-20,70}}, lineColor = {255,0,0}, pattern = LinePattern.Dash)}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-120,-100},{120,100}}), graphics = {Ellipse(extent = {{-86,110},{114,-90}}, lineColor = {95,95,95}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Polygon(points = {{-22,70},{78,10},{-22,-50},{-22,70}}, lineColor = {0,0,255}, pattern = LinePattern.None, fillColor = {95,95,95}, fillPattern = FillPattern.Solid)}), experimentSetupOutput(derivatives = false), Documentation(info = "<html>
<p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2011-12.</p>
<p><h4>Nota operativa</h4></p>
<p>Questa versione &egrave; inserita nella libreria EVQSPkg, che &egrave; autocontenuta</p>
</html>"), Commands(file = "plotEVQS.mos" "Plot"), experiment(StartTime = 0, StopTime = 135, Tolerance = 0.000001));
  end EVQS0;
  model propDriver "Simple Proportional controller driver"
    parameter String CycleFileName = "MyCycleName.txt" "Drive Cycle Name ex: \"sort1.txt\"";
    parameter Real k "Controller gain";
    parameter Real yMax = 1000000.0 "Max output value (absolute)";
    Modelica.Blocks.Interfaces.RealInput V annotation(Placement(transformation(extent = {{-14,-14},{14,14}}, rotation = 90, origin = {0,-114}), iconTransformation(extent = {{-12,-12},{12,12}}, rotation = 90, origin = {0,-112})));
    Modelica.Blocks.Interfaces.RealOutput Tref annotation(Placement(transformation(extent = {{100,40},{120,60}}), iconTransformation(extent = {{100,50},{120,70}})));
    Modelica.Blocks.Sources.CombiTimeTable DriveCyc(tableOnFile = true, tableName = "Cycle", extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = CycleFileName, columns = {2}) annotation(Placement(transformation(extent = {{-86,40},{-66,60}})));
    Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh annotation(Placement(transformation(extent = {{-48,40},{-28,60}})));
    Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{-10,40},{10,60}})));
    Modelica.Blocks.Math.Gain gain(k = k) annotation(Placement(transformation(extent = {{32,40},{52,60}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = yMax) annotation(Placement(transformation(extent = {{70,40},{90,60}})));
  equation
    connect(from_kmh.u,DriveCyc.y[1]) annotation(Line(points = {{-50,50},{-65,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(from_kmh.y,feedback.u1) annotation(Line(points = {{-27,50},{-8,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(feedback.u2,V) annotation(Line(points = {{0,42},{0,-114}}, color = {0,0,127}, smooth = Smooth.None));
    connect(feedback.y,gain.u) annotation(Line(points = {{9,50},{30,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(gain.y,limiter.u) annotation(Line(points = {{53,50},{68,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(Tref,limiter.y) annotation(Line(points = {{110,50},{91,50}}, color = {0,0,127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-23,46},{-12,20}}, lineColor = {0,0,0}, fillColor = {255,213,170}, fillPattern = FillPattern.Solid),Text(extent = {{-90,126},{88,112}}, lineColor = {0,0,255}, textString = "%name"),Polygon(points = {{-22,-36},{-42,-64},{-16,-64},{16,-64},{-22,-36}}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{-32,64},{-62,-28},{-30,-28},{-30,-28},{-32,64}}, smooth = Smooth.Bezier, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{-68,-12},{-14,-66},{10,-26},{0,-26},{-68,-12}}, smooth = Smooth.Bezier, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{-22,34},{-30,30},{-40,-24},{2,-22},{2,-10},{0,26},{-22,34}}, smooth = Smooth.Bezier, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Ellipse(extent = {{-30,68},{-3,34}}, fillColor = {255,213,170}, fillPattern = FillPattern.Solid, startAngle = 0, endAngle = 360, lineColor = {0,0,0}),Polygon(points = {{-38,58},{-16,74},{-2,60},{4,60},{6,60},{-38,58}}, smooth = Smooth.Bezier, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, pattern = LinePattern.None, lineColor = {0,0,0}),Polygon(points = {{30,-20},{-32,-4},{-36,-20},{-24,-34},{30,-20}}, smooth = Smooth.Bezier, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{42,-46},{36,-60},{48,-54},{52,-48},{50,-44},{42,-46}}, lineColor = {0,0,0}, smooth = Smooth.Bezier, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Line(points = {{48,10},{26,24},{26,24}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Line(points = {{20,14},{34,34},{34,34}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Polygon(points = {{28,28},{32,32},{28,26},{34,30},{30,26},{34,28},{30,24},{26,26},{34,24},{26,24},{26,26},{28,28},{28,28},{26,26},{26,26},{26,26},{28,32},{28,30},{28,28}}, smooth = Smooth.Bezier, fillColor = {255,213,170}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{-18,24},{28,30},{26,22},{-16,8},{-20,8},{-24,18},{-18,24}}, smooth = Smooth.Bezier, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{72,18},{48,18},{36,-2},{58,-62},{72,-62},{72,18}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{49,-70},{17,-16},{7,-20},{-1,-26},{49,-70}}, smooth = Smooth.Bezier, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Line(points = {{-7,55},{-3,53}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-9,42},{-5,42}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-7,55},{-3,55}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-100,100},{102,-100}}, lineColor = {0,0,0})}), Documentation(info = "<html>
<p>Modello semplice di pilota.</p>
<p>Esso contiene al suo interno il ciclo di riferimento, che insegue attraverso un regolatore solo proporzionale.</p>
</html>"));
  end propDriver;
  model QSDrivePU
    import PI = Modelica.Constants.pi;
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{90,-10},{110,10}}), iconTransformation(extent = {{90,-10},{110,10}})));
    // General parameters
    parameter Real UBase = 400 "Base RMS machine line voltage";
    parameter Real WeBase = 314.15 "Base machine angular frequency";
    parameter Real WeMax = 2 * WeBase "Base machine angular frequency";
    parameter Real UdcNom = 500 "DC nominal voltage (only order of magnitude needs to be true)";
    // P.U. reference quantities
    parameter Real Unom = 400 "PU reference RMS machine line voltage" annotation(Dialog(group = "p.u. reference quantities"));
    parameter Modelica.SIunits.ApparentPower Snom = 100000.0 "P.U. reference power" annotation(Dialog(group = "p.u. reference quantities"));
    parameter Modelica.SIunits.Frequency FNom = 50 "Reference frequency of p.u." annotation(Dialog(group = "p.u. reference quantities"));
    // Machine parameters
    parameter Real R1u = 0.01 "Stator phase resistance " annotation(Dialog(tab = "Machine", group = "Resistances and inductances per phase"));
    parameter Real X1u = 0.05 "Stator leackage inductance" annotation(Dialog(tab = "Machine", group = "Resistances and inductances per phase"));
    parameter Real R2u = 0.01 "Rotor phase resistance reported to primary" annotation(Dialog(tab = "Machine", group = "Resistances and inductances per phase"));
    parameter Real X2u = 0.05 "Rotor leackage inductance" annotation(Dialog(tab = "Machine", group = "Resistances and inductances per phase"));
    parameter Real Xmu = 10 "Magnetic coupling inductance" annotation(Dialog(tab = "Machine", group = "Resistances and inductances per phase"));
    //  parameter Real Rmu=10 "Iron loss equivalent resistance (Zm=Rm//Xm)" annotation(Dialog(tab="Machine",group="Resistances and inductances per phase"));
    parameter Modelica.SIunits.Time Hu = 5 "Inertia constant (s)" annotation(Dialog(tab = "Machine", group = "Other parameters"));
    parameter Integer pp(min = 1) = 1 "number of pole pairs" annotation(Dialog(tab = "Machine", group = "Other parameters"));
    // Other/Inverter
    parameter Modelica.SIunits.Time TInv = 0.01 "Inverter time constant" annotation(Dialog(tab = "Other", group = "Inverter"));
    parameter Real LossFact "ratio of inverter losses (W) to machine current (A)";
    // Other/Load
    parameter Real KL = 1 "Inner DCload PI k constant (adimens.)" annotation(Dialog(tab = "Other", group = "DCLoad"));
    parameter Modelica.SIunits.Time TL = 0.001 "Inner DCload PI time constant" annotation(Dialog(tab = "Other", group = "DCLoad"));
    Real tLim "maximum available torque at given frequency";
  protected
    parameter Real UBase1 = UBase / sqrt(3);
    //single-circuit equivalent of UBase
    parameter Real WeNom = 2 * PI * FNom;
    parameter Real WmNom = WeNom / pp;
    parameter Real Znom = Unom ^ 2 / Snom;
    parameter Modelica.SIunits.Resistance R1 = R1u * Znom;
    parameter Modelica.SIunits.Inductance L1 = X1u * Znom / WeNom;
    parameter Modelica.SIunits.Inductance Lm = Xmu * Znom / WeNom;
    parameter Modelica.SIunits.Resistance R2 = R2u * Znom;
    parameter Modelica.SIunits.Inductance L2 = X2u * Znom / WeNom;
    //  parameter Modelica.SIunits.Resistance Rm=Rmu*Z_nom;
    parameter Modelica.SIunits.MomentOfInertia J = 2 * Hu * Snom / WmNom ^ 2;
    Real WeAux;
  public
    Modelica.Blocks.Math.Add addPdc annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-58,30})));
    Modelica.Blocks.Math.Gain LossF_(k = LossFact) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-18,20})));
  algorithm
    WeAux:=abs(limWe.y);
    if WeAux < 0.1 then 
      WeAux:=0.1;
    else

    end if;
    //limite: 0.1 rad/s
    if limWe.y < WeBase then 
      tLim:=3 * UBase ^ 2 * pp / (2 * WeBase ^ 2 * (L1 + L2));
    else
      tLim:=3 * limU.y ^ 2 * pp / (2 * WeAux ^ 2 * (L1 + L2));
    end if;
  public
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(Placement(transformation(extent = {{-110,50},{-90,70}}), iconTransformation(extent = {{-112,50},{-92,70}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(Placement(transformation(extent = {{-110,-70},{-90,-50}}), iconTransformation(extent = {{-112,-70},{-92,-50}})));
    DCLConstP DCLoad(k = KL, T = TL) annotation(Placement(transformation(extent = {{-100,-10},{-80,10}})));
    QSAsma qSAsma(pp = pp, R1 = R1, L1 = L1, Lm = Lm, R2 = R2, L2 = L2, J = J) annotation(Placement(transformation(extent = {{-2,44},{22,64}})));
    Modelica.Blocks.Sources.RealExpression ComputedU(y = F.y + (UBase1 - F.y) * limWe.y / WeBase) annotation(Placement(transformation(extent = {{-76,52},{-52,68}})));
    Modelica.Blocks.Math.Gain U0(k = R1 / 2) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {16,2})));
    Modelica.Blocks.Interfaces.RealInput dWe annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,120})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor Wm annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {56,22})));
    Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {50,-44})));
    Modelica.Blocks.Math.Gain PolePairs(k = pp) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {56,-10})));
    Modelica.Blocks.Math.Gain ToFreq(k = 1 / (2 * PI)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-20,-70})));
    Modelica.Blocks.Nonlinear.Limiter limU(uMax = UBase1) annotation(Placement(transformation(extent = {{-40,50},{-20,70}})));
    Modelica.Blocks.Nonlinear.Limiter limWe(uMax = WeMax) annotation(Placement(transformation(extent = {{26,-80},{6,-60}})));
    Modelica.Blocks.Continuous.FirstOrder F(T = TInv) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {16,-26})));
    Modelica.Blocks.Nonlinear.Limiter limDWe(uMax = R2 / (L1 + L2), uMin = -R2 / (L1 + L2)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {40,70})));
    /*Il seguente assert può essere omesso in quanto la tensione applicata alla macchina è automaticamente limitata

algorithm 
assert(ComputedU.y< 0.5*DCLoad.v, "DC voltage: "+ String(DCLoad.v) + "V\n" +
        "is too low for current machine operating point. Uac:"+String(ComputedU.y) + "Vrms.\n\n");
*/
  equation
    connect(DCLoad.pin_p,pin_p) annotation(Line(points = {{-91,9.2},{-91,60},{-100,60}}, color = {0,0,255}, smooth = Smooth.None));
    connect(DCLoad.pin_n,pin_n) annotation(Line(points = {{-91,-9},{-91,-60},{-100,-60}}, color = {0,0,255}, smooth = Smooth.None));
    connect(qSAsma.Iac,U0.u) annotation(Line(points = {{16,43},{16,28.5},{16,14},{16,14}}, color = {0,0,127}, smooth = Smooth.None));
    connect(qSAsma.flange_a,flange_a) annotation(Line(points = {{19.8,54},{80,54},{80,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
    connect(Wm.flange,qSAsma.flange_a) annotation(Line(points = {{56,32},{56,54},{19.8,54}}, color = {0,0,0}, smooth = Smooth.None));
    connect(PolePairs.u,Wm.w) annotation(Line(points = {{56,2},{56,4},{58,4},{58,6},{56,6},{56,11}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PolePairs.y,add.u1) annotation(Line(points = {{56,-21},{56,-32}}, color = {0,0,127}, smooth = Smooth.None));
    connect(ToFreq.y,qSAsma.f) annotation(Line(points = {{-31,-70},{-40,-70},{-40,48},{-2,48}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limU.u,ComputedU.y) annotation(Line(points = {{-42,60},{-50.8,60}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limU.y,qSAsma.U) annotation(Line(points = {{-19,60},{-2,60}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limWe.y,ToFreq.u) annotation(Line(points = {{5,-70},{2,-70},{2,-72},{-2,-72},{-2,-70},{-8,-70}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limWe.u,add.y) annotation(Line(points = {{28,-70},{50,-70},{50,-55}}, color = {0,0,127}, smooth = Smooth.None));
    connect(F.u,U0.y) annotation(Line(points = {{16,-14},{16,-8},{18,-8},{18,-6},{16,-6},{16,-9}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limDWe.y,add.u2) annotation(Line(points = {{40,59},{40,-32},{44,-32}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limDWe.u,dWe) annotation(Line(points = {{40,82},{40,92},{0,92},{0,120}}, color = {0,0,127}, smooth = Smooth.None));
    connect(addPdc.y,DCLoad.Pref) annotation(Line(points = {{-69,30},{-74.5,30},{-74.5,0},{-81.8,0}}, color = {0,0,127}, smooth = Smooth.None));
    connect(addPdc.u2,qSAsma.Pdc) annotation(Line(points = {{-46,36},{3,36},{3,43}}, color = {0,0,127}, smooth = Smooth.None));
    connect(LossF_.y,addPdc.u1) annotation(Line(points = {{-29,20},{-38,20},{-38,24},{-46,24}}, color = {0,0,127}, smooth = Smooth.None));
    connect(LossF_.u,qSAsma.Iac) annotation(Line(points = {{-6,20},{16,20},{16,43}}, color = {0,0,127}, smooth = Smooth.None));
    annotation(Dialog(tab = "Other", group = "Inverter"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Line(points = {{-28,20},{6,20}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-30,0},{4,0}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-30,-20},{4,-20}}, color = {0,0,255}, smooth = Smooth.None),Text(extent = {{-140,-112},{148,-138}}, lineColor = {0,0,127}, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, textString = "%name"),Line(points = {{-102,-60},{-78,-60},{-78,-28},{-60,-28}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-96,60},{-78,60},{-78,28},{-60,28}}, color = {0,0,255}, smooth = Smooth.None),Rectangle(extent = {{-40,68},{80,-52}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {175,175,175}),Rectangle(extent = {{-40,68},{-62,-52}}, lineColor = {0,0,255}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0,0,255}),Polygon(points = {{-54,-82},{-44,-82},{-14,-12},{36,-12},{66,-82},{76,-82},{76,-92},{-54,-92},{-54,-82}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{80,12},{100,-8}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {95,95,95}),Text(extent = {{-34,18},{74,-4}}, lineColor = {0,0,255}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0,0,255}, textString = "P.U.")}), Documentation(info = "<html>
<p>This model models an asynchrnous machine - based electric drive, containing U/f control, with stator resistance drop compensation.</p>
<p>It makes usage of the quasi-stationary asynchornous machine model QSAsma.</p>
</html>"));
  end QSDrivePU;
  model QSAsma
    import PI = Modelica.Constants.pi;
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor L1_(L = L1) annotation(Placement(transformation(extent = {{-8,8},{12,28}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor R1_(R_ref = R1) annotation(Placement(transformation(extent = {{-32,8},{-12,28}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor L2_(L = L2) annotation(Placement(transformation(extent = {{26,8},{46,28}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor Lm_(L = Lm) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {18,-2})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor Rmecc annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {90,-2})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource uTerminals annotation(Placement(transformation(extent = {{-10,10},{10,-10}}, rotation = 270, origin = {-72,-2})));
    Modelica.ComplexBlocks.ComplexMath.PolarToComplex ToComplexUin annotation(Placement(transformation(origin = {-70,84}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput U annotation(Placement(transformation(extent = {{-160,40},{-120,80}}), iconTransformation(extent = {{-140,40},{-100,80}})));
    Modelica.Blocks.Sources.Constant const(k = 0) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-70,58})));
    Modelica.Blocks.Interfaces.RealInput f annotation(Placement(transformation(extent = {{-160,-80},{-120,-40}}), iconTransformation(extent = {{-140,-80},{-100,-40}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{108,68},{128,88}}), iconTransformation(extent = {{88,-10},{108,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{14,68},{34,88}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor Wm annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {72,60})));
    Modelica.Blocks.Nonlinear.Limiter limF(uMin = 0.000001, uMax = 1000000.0) annotation(Placement(transformation(extent = {{-112,-70},{-92,-50}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor Pag annotation(Placement(transformation(extent = {{54,8},{74,28}})));
    Modelica.Blocks.Sources.RealExpression WmS1(y = 3 * toPag.re / W0) annotation(Placement(transformation(extent = {{-36,68},{-4,88}})));
    parameter Integer pp = 2 "pole pairs";
    parameter Real R1 = 0.435 "stator's phase resistance";
    parameter Real L1 = 0.004 "stator's leakage indctance";
    parameter Real Lm = 0.0693 "stator's leakage indctance";
    parameter Real R2 = 0.4 "rotor's phase resistance";
    parameter Real L2 = 0.002 "rotor's leakage indctance";
    parameter Real J = 2.0 "rotor's moment of inertia";
    Real W0;
    //velocità meccanica di soncronismo
    Real s;
    //scorrimento
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J) annotation(Placement(transformation(extent = {{82,68},{102,88}})));
    Modelica.ComplexBlocks.ComplexMath.ComplexToReal toPag annotation(Placement(transformation(extent = {{-6,-6},{6,6}}, rotation = 270, origin = {46,-8})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation(Placement(transformation(extent = {{8,-38},{28,-18}})));
    Modelica.ComplexBlocks.ComplexMath.ComplexToReal toPin annotation(Placement(transformation(extent = {{-6,-6},{6,6}}, rotation = 270, origin = {-54,-10})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor Pin annotation(Placement(transformation(extent = {{-56,8},{-36,28}})));
    Modelica.Blocks.Interfaces.RealOutput Pdc annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-60,-110}), iconTransformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-70,-110})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent = {{-10,10},{10,-10}}, rotation = 180, origin = {-6,-22})));
    Modelica.ComplexBlocks.ComplexMath.ComplexToPolar ToIPolar annotation(Placement(transformation(extent = {{-6,-6},{6,6}}, rotation = 270, origin = {56,-76})));
    Modelica.Blocks.Interfaces.RealOutput Iac annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {60,-110})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor PmGen annotation(Placement(transformation(extent = {{46,68},{66,88}})));
    Modelica.Blocks.Math.Gain toW1(k = 3) annotation(Placement(transformation(extent = {{-8,-8},{8,8}}, rotation = -90, origin = {-50,-80})));
  equation
    W0 = limF.y * 2 * PI / pp;
    s = (W0 - Wm.w) / W0;
    Rmecc.R_ref = R2 / s;
    connect(R1_.pin_n,L1_.pin_p) annotation(Line(points = {{-12,18},{-8,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(L1_.pin_n,L2_.pin_p) annotation(Line(points = {{12,18},{26,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Lm_.pin_p,L1_.pin_n) annotation(Line(points = {{18,8},{18,18},{12,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Rmecc.pin_n,Lm_.pin_n) annotation(Line(points = {{90,-12},{90,-22},{18,-22},{18,-12}}, color = {85,170,255}, smooth = Smooth.None));
    connect(ToComplexUin.y,uTerminals.V) annotation(Line(points = {{-59,84},{-40,84},{-40,40},{-100,40},{-100,2},{-82,2}}, color = {85,170,255}, smooth = Smooth.None));
    connect(ToComplexUin.len,U) annotation(Line(points = {{-82,90},{-100,90},{-100,60},{-140,60}}, color = {0,0,127}, smooth = Smooth.None));
    connect(const.y,ToComplexUin.phi) annotation(Line(points = {{-81,58},{-92,58},{-92,78},{-82,78}}, color = {0,0,127}, smooth = Smooth.None));
    connect(limF.u,f) annotation(Line(points = {{-114,-60},{-140,-60}}, color = {0,0,127}, smooth = Smooth.None));
    connect(uTerminals.f,limF.y) annotation(Line(points = {{-82,-6},{-88,-6},{-88,-60},{-91,-60}}, color = {0,0,127}, smooth = Smooth.None));
    connect(Pag.currentP,L2_.pin_n) annotation(Line(points = {{54,18},{46,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pag.voltageP,Pag.currentP) annotation(Line(points = {{64,28},{54,28},{54,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pag.voltageN,Rmecc.pin_n) annotation(Line(points = {{64,8},{64,-22},{90,-22},{90,-12}}, color = {85,170,255}, smooth = Smooth.None));
    connect(WmS1.y,torque.tau) annotation(Line(points = {{-2.4,78},{12,78}}, color = {0,0,127}, smooth = Smooth.None));
    connect(inertia.flange_b,flange_a) annotation(Line(points = {{102,78},{118,78}}, color = {0,0,0}, smooth = Smooth.None));
    connect(Pag.y,toPag.u) annotation(Line(points = {{56,7},{46,7},{46,-0.8}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pag.currentN,Rmecc.pin_p) annotation(Line(points = {{74,18},{90,18},{90,8}}, color = {85,170,255}, smooth = Smooth.None));
    connect(ground.pin,Lm_.pin_n) annotation(Line(points = {{18,-18},{18,-15},{18,-12},{18,-12}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pin.currentN,R1_.pin_p) annotation(Line(points = {{-36,18},{-32,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pin.currentP,uTerminals.pin_p) annotation(Line(points = {{-56,18},{-72,18},{-72,8}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pin.voltageP,Pin.currentP) annotation(Line(points = {{-46,28},{-56,28},{-56,18}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pin.y,toPin.u) annotation(Line(points = {{-54,7},{-54,-2.8}}, color = {85,170,255}, smooth = Smooth.None));
    connect(Pin.voltageN,uTerminals.pin_n) annotation(Line(points = {{-46,8},{-46,0},{-26,0},{-26,-22},{-72,-22},{-72,-12}}, color = {85,170,255}, smooth = Smooth.None));
    connect(uTerminals.pin_n,currentSensor.pin_n) annotation(Line(points = {{-72,-12},{-72,-22},{-16,-22}}, color = {85,170,255}, smooth = Smooth.None));
    connect(currentSensor.pin_p,Rmecc.pin_n) annotation(Line(points = {{4,-22},{90,-22},{90,-12}}, color = {85,170,255}, smooth = Smooth.None));
    connect(ToIPolar.u,currentSensor.y) annotation(Line(points = {{56,-68.8},{56,-50},{-6,-50},{-6,-33}}, color = {85,170,255}, smooth = Smooth.None));
    connect(ToIPolar.len,Iac) annotation(Line(points = {{59.6,-83.2},{60,-83.2},{60,-110}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PmGen.flange_a,torque.flange) annotation(Line(points = {{46,78},{34,78}}, color = {0,0,0}, smooth = Smooth.None));
    connect(PmGen.flange_b,inertia.flange_a) annotation(Line(points = {{66,78},{82,78}}, color = {0,0,0}, smooth = Smooth.None));
    connect(Wm.flange,PmGen.flange_b) annotation(Line(points = {{72,70},{72,78},{66,78}}, color = {0,0,0}, smooth = Smooth.None));
    connect(toW1.u,toPin.re) annotation(Line(points = {{-50,-70.4},{-50,-17.2},{-50.4,-17.2}}, color = {0,0,127}, smooth = Smooth.None));
    connect(Pdc,toW1.y) annotation(Line(points = {{-60,-110},{-60,-88.8},{-50,-88.8}}, color = {0,0,127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-120,-100},{120,100}}), graphics = {Rectangle(extent = {{-80,34},{100,-36}}, lineColor = {255,0,0}, pattern = LinePattern.Dash)}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-120,-100},{120,100}}), graphics = {Line(points = {{-100,60},{-48,32}}, color = {0,0,127}, smooth = Smooth.None),Line(points = {{-100,-60},{-48,-30}}, color = {0,0,127}, smooth = Smooth.None),Text(extent = {{-106,138},{106,112}}, lineColor = {0,0,127}, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, textString = "%name"),Rectangle(extent = {{-42,66},{78,-54}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {175,175,175}),Rectangle(extent = {{78,10},{98,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {95,95,95}),Rectangle(extent = {{-42,66},{-62,-54}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {128,128,128}),Polygon(points = {{-54,-84},{-44,-84},{-14,-14},{36,-14},{66,-84},{76,-84},{76,-94},{-54,-94},{-54,-84}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>This model models ans asynchronous machine based on a quasi-stationary approximation: the equivalent single-phase circuit.</p>
<p>This model is very fast and compact, and gives result with sufficient precision in most vehicular propulsion needs.</p>
</html>"));
  end QSAsma;
  model VhDragForce "Vehicle rolling and aerodinamical drag force"
    import Modelica.Constants.g_n;
    extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
    extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
    Modelica.SIunits.Force f "Total drag force";
    Modelica.SIunits.Velocity v "vehicle velocity";
    Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
    Real Sign;
    parameter Modelica.SIunits.Mass m "vehicle mass";
    parameter Modelica.SIunits.Density rho(start = 1.226) "air density";
    parameter Modelica.SIunits.Area S "vehicle cross area";
    parameter Real fc(start = 0.01) "rolling friction coefficient";
    parameter Real Cx "aerodinamic drag coefficient";
  protected
    parameter Real A = fc * m * g_n;
    parameter Real B = 1 / 2 * rho * S * Cx;
    // Constant auxiliary variable
  equation
    //  s = flange.s;
    v = der(s);
    a = der(v);
    // Le seguenti definizioni seguono l'ordine e le ridchieste del modello "PartialFriction" di
    // Modelica.Mechanics.Translational.Interfaces"
    v_relfric = v;
    a_relfric = a;
    f0 = A "forza a velocità 0 ma con scorrimento";
    f0_max = A "massima forza  velocità 0 e senza scorrimento ";
    free = false "sarebbe true quando la ruota si stacca dalla strada";
    // Ora il calcolo di f, e la sua attribuzione alla flangia:
    flange.f - f = 0;
    // friction force
    if v > 0 then
      Sign = 1;
    else
      Sign = -1;
    end if;
    f - B * v ^ 2 * Sign = if locked then sa * unitForce else f0 * (if startForward then Modelica.Math.tempInterpol1(v, [0,1], 2) else if startBackward then -Modelica.Math.tempInterpol1(-v, [0,1], 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(v, [0,1], 2) else -Modelica.Math.tempInterpol1(-v, [0,1], 2));
    annotation(Documentation(info = "<html>
<p>This component modesl the total (rolling &egrave;+ aerrodynamic vehicle drag resistance: </p>
<p>f=mgh+(1/2)*rho*Cx*S*v^2</p>
<p>It models reliably the stuck phase. based on Modelica-Intrerfaces.PartialFriction model</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{-98,10},{22,10},{22,41},{92,0},{22,-41},{22,-10},{-98,-10},{-98,10}}, lineColor = {0,127,0}, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Line(points = {{-42,-50},{87,-50}}, color = {0,0,0}),Polygon(points = {{-72,-50},{-41,-40},{-41,-60},{-72,-50}}, lineColor = {0,0,0}, fillColor = {128,128,128}, fillPattern = FillPattern.Solid),Line(points = {{-90,-90},{-70,-88},{-50,-82},{-30,-72},{-10,-58},{10,-40},{30,-18},{50,8},{70,38},{90,72},{110,110}}, color = {0,0,255}, thickness = 0.5),Text(extent = {{-82,90},{80,50}}, lineColor = {0,0,255}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics));
  end VhDragForce;
  model Batt1rev "Modello di batteria basato su Batt0 con ordine elettrico pari a 1; Cdummy ai morsetti"
    parameter Modelica.SIunits.ElectricCharge QCellNom(min = 0) = 10 * 3600.0 "Nominal admissible electric charge per cell" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Modelica.SIunits.Voltage ECellMin(min = 0) = 3.3 "Minimum open source voltage per cell" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Modelica.SIunits.Voltage ECellMax(min = 0.0001) = 4.15 "Maximum open source voltage per cell" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Real SOCMin(min = 0, max = 1) = 0 "Minimum state of charge" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Real SOCMax(min = 0, max = 1) = 1 "Maximum state of charge" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Real SOCInit(min = 0, max = 1) = 0.5 "Initial state of charge" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Modelica.SIunits.Current ICellMax(min = 0) = 10 * QCellNom / 3600.0 "Maximum admissible cell current" annotation(Dialog(group = "Parameters of the battery cell"));
    parameter Modelica.SIunits.Resistance R0Cell(min = 0) = 0.05 * ECellMax / ICellMax "Serial cell resistance \"R0\"" annotation(Dialog(group = "Parameters related to losses"));
    parameter Modelica.SIunits.Resistance R1Cell(min = 0) = R0Cell "Serial cell resistance \"R1\"" annotation(Dialog(group = "Parameters related to losses"));
    parameter Modelica.SIunits.Capacitance C1Cell(min = 0) = 60 / R1Cell "Serial cell capacitance of the equivalent circuit" annotation(Dialog(group = "Parameters related to losses"));
    parameter Real efficiency(min = 0, max = 0.9999) = 0.85 "Overall charging/discharging energy efficiency" annotation(Dialog(group = "Parameters related to losses"));
    parameter Modelica.SIunits.Current ICellChargeDischarge(min = 0) = 0.5 * ICellMax "Charging/discharging current of a cell that the efficiency refers to" annotation(Dialog(group = "Parameters related to losses"));
    parameter Integer ns = 1 "Number of serial connected cells" annotation(Dialog(group = "Size of the package"));
    parameter Integer np = 1 "Number of parallel connected cells" annotation(Dialog(group = "Size of the package"));
    parameter Real efficiencyMax = (EBatteryMin + EBatteryMax - 2 * Rtot * ICellChargeDischarge) / (EBatteryMin + EBatteryMax + 2 * Rtot * ICellChargeDischarge);
    parameter Modelica.SIunits.Capacitance C = QCellNom / (ECellMax - ECellMin) "Cell capacitance";
    // determine fraction of drain current with respect to the total package current
  protected
    parameter Real k = ((1 - efficiency) * (EBatteryMax + EBatteryMin) - 2 * (1 + efficiency) * Rtot * ICellChargeDischarge) / ((1 + efficiency) * (EBatteryMax + EBatteryMin) - 2 * (1 - efficiency) * Rtot * ICellChargeDischarge);
    parameter Modelica.SIunits.Current IBatteryMax = ICellMax * np "Maximum battery current";
    parameter Modelica.SIunits.Voltage EBatteryMin = ECellMin * ns "Minimum battery voltage";
    parameter Modelica.SIunits.Voltage EBatteryMax = ECellMax * ns "Maximum battery voltage";
    parameter Modelica.SIunits.ElectricCharge QBatteryNominal = QCellNom * np "Battery admissible electric charge";
    parameter Modelica.SIunits.Capacitance CBattery = C * np / ns "Battery capacitance";
    parameter Modelica.SIunits.Resistance R0Battery = R0Cell * ns / np "Serial inner resistance R0 of cell package";
    parameter Modelica.SIunits.Resistance R1Battery = R1Cell * ns / np "Serial inner resistance R1 of cell package";
    parameter Modelica.SIunits.Resistance Rtot = R0Battery + R1Battery;
    parameter Modelica.SIunits.Capacitance C1Battery = C1Cell * np / ns "Battery series inner capacitance C1";
  protected
    Modelica.SIunits.Voltage ECell "Cell e.m.f.";
    Modelica.SIunits.Current iCellStray "Cell stray current";
    Modelica.SIunits.Voltage EBattery(start = EBatteryMin + SOCInit * (EBatteryMax - EBatteryMin), fixed = true) "Battery e.m.f.";
    Modelica.SIunits.Voltage Ubat(start = EBatteryMin + SOCInit * (EBatteryMax - EBatteryMin), fixed = true);
    Modelica.SIunits.Current iBatteryStray "Cell parasitic current";
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent = {{60,50},{80,70}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = k) annotation(Placement(transformation(origin = {52,0}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Blocks.Math.Abs absolute annotation(Placement(transformation(extent = {{34,-10},{14,10}}, rotation = 0)));
  public
    Modelica.Electrical.Analog.Basic.Capacitor cBattery(final C = CBattery) annotation(Placement(transformation(origin = {-60,0}, extent = {{-10,-10},{10,10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor R0(final R = R0Battery) annotation(Placement(transformation(origin = {20,60}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sources.SignalCurrent strayCurrent annotation(Placement(transformation(origin = {-6,0}, extent = {{-10,-10},{10,10}}, rotation = 270)));
    Modelica.Electrical.Analog.Interfaces.Pin p annotation(Placement(transformation(extent = {{90,50},{110,70}}), iconTransformation(extent = {{90,52},{110,72}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(Placement(transformation(extent = {{90,-70},{110,-50}}), iconTransformation(extent = {{91,-70},{111,-50}})));
    Modelica.Electrical.Analog.Basic.Resistor R1(final R = R1Battery) annotation(Placement(transformation(origin = {-37,74}, extent = {{-10,-10},{10,10}}, rotation = 180)));
    Modelica.Electrical.Analog.Basic.Capacitor C1(C = C1Battery) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-37,50})));
    Modelica.Blocks.Interfaces.RealOutput SOC annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-110,0}), iconTransformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {-110,0})));
    Modelica.Electrical.Analog.Basic.Capacitor Cdummy(C = C1Battery / 10000) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {87,12})));
  equation
    assert(SOCMin >= 0, "SOCMin must be greater than, or equal to 0");
    assert(SOCMax <= 1, "SOCMax must be smaller than, or equal to 1");
    assert(efficiency <= efficiencyMax, "Overall charging/discharging energy efficiency is too big with respect to the actual serial resistance (EfficiencyMax =" + String(efficiencyMax) + ")");
    assert(SOCMin < SOCMax, "SOCMax(=" + String(SOCMax) + ") must be greater than SOCMin(=" + String(SOCMin) + ")");
    assert(SOCInit >= SOCMin, "SOCInit(=" + String(SOCInit) + ") must be greater than, or equal to SOCMin(=" + String(SOCMin) + ")");
    assert(SOCInit <= SOCMax, "SOCInit(=" + String(SOCInit) + ") must be smaller than, or equal to SOCMax(=" + String(SOCMax) + ")");
    iBatteryStray = strayCurrent.i;
    iCellStray = iBatteryStray / np;
    EBattery = cBattery.v;
    //Solo per dare maggiore chiarezza all'utente con un nome significativo
    Ubat = Cdummy.v;
    ECell = EBattery / ns;
    assert(abs(p.i / np) < ICellMax, "Battery cell current i=" + String(abs(p.i / np)) + "\n exceeds max admissable ICellMax (=" + String(ICellMax) + "A)");
    SOC = (EBattery - EBatteryMin) / (EBatteryMax - EBatteryMin);
    //*(SOCMax-SOCMin)+SOCMin);
    assert(SOC <= SOCMax, "Battery is fully charged: State of charge reached maximum limit (=" + String(SOCMax) + ")");
    assert(SOCMin <= SOC, "Battery is fully discharged: State of charge reached minimum limit (=" + String(SOCMin) + ")");
    connect(R0.p,currentSensor.p) annotation(Line(points = {{30,60},{60,60}}, color = {0,0,255}));
    connect(strayCurrent.p,R0.n) annotation(Line(points = {{-6,10},{-6,60},{10,60}}, color = {0,0,255}));
    connect(currentSensor.i,gain.u) annotation(Line(points = {{70,50},{70,-0.00000000000000146958},{64,-0.00000000000000146958}}, color = {0,0,127}));
    connect(absolute.u,gain.y) annotation(Line(points = {{36,0},{39.5,0},{39.5,0.00000000000000134711},{41,0.00000000000000134711}}, color = {0,0,127}));
    connect(absolute.y,strayCurrent.i) annotation(Line(points = {{13,0},{7,0},{7,-0.00000000000000128588},{1,-0.00000000000000128588}}, color = {0,0,127}));
    connect(currentSensor.n,p) annotation(Line(points = {{80,60},{80,60},{100,60}}, color = {0,0,255}));
    connect(strayCurrent.n,n) annotation(Line(points = {{-6,-10},{-6,-60},{100,-60}}, color = {0,0,255}));
    connect(n,cBattery.n) annotation(Line(points = {{100,-60},{-60,-60},{-60,-10}}, color = {0,0,255}));
    connect(R1.n,cBattery.p) annotation(Line(points = {{-47,74},{-60,74},{-60,10}}, color = {0,0,255}, smooth = Smooth.None));
    connect(C1.n,cBattery.p) annotation(Line(points = {{-47,50},{-60,50},{-60,10}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R1.p,C1.p) annotation(Line(points = {{-27,74},{-18,74},{-18,50},{-27,50}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R1.p,R0.n) annotation(Line(points = {{-27,74},{-18,74},{-18,60},{10,60}}, color = {0,0,255}, smooth = Smooth.None));
    connect(Cdummy.p,currentSensor.n) annotation(Line(points = {{87,22},{88,22},{88,60},{80,60}}, color = {0,0,255}, smooth = Smooth.None));
    connect(Cdummy.n,n) annotation(Line(points = {{87,2},{88,2},{88,-60},{100,-60}}, color = {0,0,255}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Rectangle(extent = {{-100,100},{78,-98}}, lineColor = {95,95,95}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{-92,6},{-52,6}}, color = {0,0,255}, smooth = Smooth.None),Rectangle(extent = {{-82,-3},{-65,-10}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid),Line(points = {{-73,63},{98,64}}, color = {0,0,255}, smooth = Smooth.None),Rectangle(extent = {{38,69},{68,57}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-37.5,68},{-6.5,56}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{-19.5,49},{-19.5,32}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-54.5,63},{-54.5,41},{-25.5,41}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{9.5,62},{9.5,40},{-19.5,40}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-73,63},{-73,5}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-73,-6},{-73,-60},{96,-60}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{26,63},{26,-61}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{-25.5,49},{-25.5,32}}, color = {0,0,255}, smooth = Smooth.None),Polygon(points = {{26,22},{14,4},{26,-14},{38,4},{26,22}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{20,4},{32,4}}, color = {0,0,255}, smooth = Smooth.None),Polygon(points = {{22,-20},{30,-20},{26,-32},{22,-20}}, lineColor = {0,0,255}, smooth = Smooth.None),Text(extent = {{-100,130},{100,110}}, lineColor = {0,0,255}, textString = "%name")}), Documentation(info = "<html>
<p>Modello di batteria  dotato di efficienza colombica non unitaria, secondo quanto discusso nelle dispense SEB.</p>
<p>Il ramo principaledel modello di cella  presenta una f.e.m. linearmente crescente con il SOC (simulata tramite un condensatore equivalente), una resistenza R0 ed un blocco R-C.</p>
<p>La batteria &egrave; composta da np filari idi celle in parallelo, ciascuno composto da ns celle in serie.</p>
<p><br/>SEB a.a. 2012-2013.</p>
</html>", revisions = "<html><table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-01-12</td>  <td> </td></tr>
<tr><td>1.0.3</td>  <td>2006-08-31</td>  <td> Improved assert statements </td></tr>
<tr><td>1.0.6</td>  <td>2007-05-14</td>  <td> The documentation changed slightly </td></tr>
</tbody>
</table>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics));
  end Batt1rev;
  model DCLConstP "Constant Power DC Load"
    parameter Real k "inner PI follower proportional gain";
    parameter Modelica.SIunits.Time T "inner PI follower integral time constant";
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(Placement(transformation(extent = {{-74,52},{-54,72}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(Placement(transformation(extent = {{-110,70},{-90,90}}), iconTransformation(extent = {{-20,82},{0,102}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(Placement(transformation(extent = {{-110,-90},{-90,-70}}), iconTransformation(extent = {{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-4,48})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(transformation(extent = {{-9,-9},{9,9}}, rotation = 270, origin = {-35,45})));
    Modelica.Blocks.Interfaces.RealInput Pref "Reference power" annotation(Placement(transformation(extent = {{-18,-18},{18,18}}, rotation = 180, origin = {118,-20}), iconTransformation(extent = {{-18,-18},{18,18}}, rotation = 180, origin = {82,0})));
    Modelica.Blocks.Continuous.PI PI(k = k, T = T, initType = Modelica.Blocks.Types.Init.InitialState) annotation(Placement(transformation(extent = {{-8,-8},{8,8}}, rotation = 180, origin = {28,-20})));
    Modelica.Blocks.Math.Feedback feedback1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {64,-20})));
    Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{-8,-8},{8,8}}, rotation = 180, origin = {24,48})));
    Modelica.SIunits.Voltage v;
    Inverse inverse(k = 1) annotation(Placement(visible = true, transformation(origin = {18,74}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  equation
    connect(powerSensor.pv,pin_p) annotation(Line(points = {{-64,72},{-64.094,72},{-64.094,80.2013},{-97.651,80.2013},{-97.651,80.2013}}));
    connect(signalCurrent.p,powerSensor.nc) annotation(Line(points = {{-4,58},{-4,62.0805},{-54.698,62.0805},{-54.698,62.0805}}));
    connect(inverse.y,product.u2) annotation(Line(points = {{28.6,74},{48,74},{48,52.8},{33.6,52.8}}, color = {0,0,127}));
    connect(voltageSensor.v,inverse.u) annotation(Line(points = {{-44,45},{-46,45},{-46,74},{7,74}}, color = {0,0,127}));
    v = pin_p.v - pin_n.v;
    connect(powerSensor.pv,powerSensor.pc) annotation(Line(points = {{-64,72},{-74,72},{-74,62}}, color = {0,0,255}, smooth = Smooth.None));
    connect(signalCurrent.n,pin_n) annotation(Line(points = {{-4,38},{-4,-80},{-100,-80}}, color = {0,0,255}, smooth = Smooth.None));
    connect(voltageSensor.p,powerSensor.nc) annotation(Line(points = {{-35,54},{-35,62},{-54,62}}, color = {0,0,255}, smooth = Smooth.None));
    connect(voltageSensor.n,signalCurrent.n) annotation(Line(points = {{-35,36},{-35,2},{-4,2},{-4,38}}, color = {0,0,255}, smooth = Smooth.None));
    connect(powerSensor.nv,pin_n) annotation(Line(points = {{-64,52},{-64,-80},{-100,-80}}, color = {0,0,255}, smooth = Smooth.None));
    connect(feedback1.u1,Pref) annotation(Line(points = {{72,-20},{118,-20}}, color = {0,0,127}, smooth = Smooth.None));
    connect(feedback1.u2,powerSensor.power) annotation(Line(points = {{64,-12},{64,16},{-72,16},{-72,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(feedback1.y,PI.u) annotation(Line(points = {{55,-20},{37.6,-20}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PI.y,product.u1) annotation(Line(points = {{19.2,-20},{10,-20},{10,24},{46,24},{46,43.2},{33.6,43.2}}, color = {0,0,127}, smooth = Smooth.None));
    connect(product.y,signalCurrent.i) annotation(Line(points = {{15.2,48},{3,48}}, color = {0,0,127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Line(points = {{-4,0},{70,0}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-10,86},{-10,-88},{-12,-90}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-30,54},{10,-56}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{18,36},{54,0}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "P"),Text(extent = {{-100,10},{100,-10}}, lineColor = {0,0,255}, textString = "%name", origin = {-52,0}, rotation = 90)}), Documentation(info = "<html>
<p>Questo componente simula, mediante inseguimento di un riferimento esterno, un carico a potenza costante.</p>
<p>I parametri k e T sono i parametri del regolatore PI che insegue l&apos;input. TIpicamente si potr&agrave; utilizzare k=1 e T di un ordine di grandezza pi&ugrave; piccolo delle costanti di tempo del segnale di ingresso di potenza</p>
</html>"));
  end DCLConstP;
  block Inverse "Outputs the inverse of (input multiplied by k)"
    import Modelica.Constants.inf;
    import Modelica.Constants.eps;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-128,-20},{-88,20}}), iconTransformation(extent = {{-128,-18},{-92,18}})));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{98,-10},{118,10}}), iconTransformation(extent = {{96,-10},{116,10}})));
    parameter Real k;
  equation
    if abs(u) < eps then
      y = inf;
    else
      y = 1.0 / (k * u);
    end if;
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,127}, fillPattern = FillPattern.Solid, fillColor = {255,255,255}),Text(extent = {{-10,-4},{60,52}}, lineColor = {0,0,127}, textString = "1"),Text(extent = {{-32,0},{76,-46}}, lineColor = {0,0,127}, textString = "k u"),Line(points = {{-14,0},{66,0}}, color = {0,0,127}, smooth = Smooth.None),Text(extent = {{-86,-30},{-16,26}}, lineColor = {0,0,127}, textString = "y=")}));
  end Inverse;
  annotation(uses(Modelica(version = "3.2")));
end EVQSPkg;

