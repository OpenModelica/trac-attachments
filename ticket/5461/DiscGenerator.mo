package DiscGenerator
  model EMF "Electromotoric force (electric/mechanic transformer)"
    import SI = Modelica.SIunits;
    
    parameter SI.MagneticFluxDensity B = 0.05 "Magnetic Flux Density of the Magnets";
    parameter SI.Radius r_o "Outer Radius of the Copper Disc";
    parameter SI.Radius r_i "Inner Radius of the Copper Disc";
    parameter SI.Resistivity p_Cu = 1.68e-8 "Resistivity of Copper";
    parameter SI.Area A = 4.2e-6 "Smallest Cross-sectional Area of Conducting Path";
    parameter SI.Length lDisc = r_o - r_i "Length of Conducting Path along the Radius of the Disc";
    parameter SI.Length lRail = 9e-3 "Length of Conducting Rail from Disc to Commutator";
    parameter SI.Length lCom = 15.158e-3 "Length of Conducting Path along the Commutator";
    Real wrapAngle;
    Real cosine;
    SI.Length lDelta "Variable Length of the Conducting Path";
    SI.Length l "Length of Conducting Path";
    SI.Resistance R_disc "Resistance of the Rotor";
    SI.Current i "Current flowing from positive to negative pin";
    SI.Angle phi "Angle of shaft flange with respect to support (= flange.phi - support.phi)";
    SI.AngularVelocity w "Angular velocity of flange relative to support";
    SI.Torque tau "Torque of flange";
    SI.Torque tauElectrical "Electrical torque";
    Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive electrical pin" annotation(
      Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative electrical pin" annotation(
      Placement(transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange" annotation(
      Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage InducedVoltage annotation(
      Placement(visible = true, transformation(origin = {0, -34}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.VariableResistor discResistance annotation(
      Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
//v = p.v - n.v;
//0 = p.i + n.i;
    i = p.i;
    phi = flange.phi;
//wrapAngle = Modelica.Math.wrapAngle(phi,positiveRange = true);
    wrapAngle = mod(phi, Modelica.Constants.pi / 2) / (Modelica.Constants.pi / 2);
    cosine = cos(2 * Modelica.Constants.pi * wrapAngle);
    lDelta = 0.015158 * cosine;
    l = lDisc + lRail + lCom + lDelta;
    discResistance.R = p_Cu * (l / A);
// TODO : use the calculated resistance of the copper for the voltage and current calculations
    w = der(phi);
    tau = flange.tau;
    tauElectrical = B * i * (r_o ^ 2 / 2 - r_i ^ 2 / 2);
    tauElectrical = -tau;
    InducedVoltage.v = 0.5 * w * B * (r_o ^ 2 - r_i ^ 2);
    connect(InducedVoltage.n, n) annotation(
      Line(points = {{0, -44}, {0, -44}, {0, -100}, {0, -100}}, color = {0, 0, 255}));
  connect(p, discResistance.p) annotation(
      Line(points = {{0, 100}, {0, 100}, {0, 34}, {0, 34}}, color = {0, 0, 255}));
  connect(discResistance.n, InducedVoltage.p) annotation(
      Line(points = {{0, 14}, {0, 14}, {0, -24}, {0, -24}}, color = {0, 0, 255}));
    annotation(
      defaultComponentName = "emf",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-85, 10}, {-36, -10}}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192, 192, 192}), Rectangle(extent = {{35, 10}, {100, -10}}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192, 192, 192}), Ellipse(extent = {{-40, 40}, {40, -40}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-150, 90}, {150, 50}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-150, -50}, {150, -90}}, textString = "k=%k"), Line(visible = not useSupport, points = {{-100, -30}, {-40, -30}}), Line(visible = not useSupport, points = {{-100, -50}, {-80, -30}}), Line(visible = not useSupport, points = {{-80, -50}, {-60, -30}}), Line(visible = not useSupport, points = {{-60, -50}, {-40, -30}}), Line(visible = not useSupport, points = {{-70, -30}, {-70, -10}}), Line(points = {{0, 40}, {0, 50}}, color = {0, 0, 255}), Line(points = {{0, -50}, {0, -40}}, color = {0, 0, 255})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-17, 95}, {-20, 85}, {-23, 95}, {-17, 95}}, lineColor = {160, 160, 164}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid), Line(points = {{-20, 110}, {-20, 85}}, color = {160, 160, 164}), Text(extent = {{-40, 110}, {-30, 90}}, lineColor = {160, 160, 164}, textString = "i"), Line(points = {{9, 75}, {19, 75}}, color = {192, 192, 192}), Line(points = {{-20, -110}, {-20, -85}}, color = {160, 160, 164}), Polygon(points = {{-17, -100}, {-20, -110}, {-23, -100}, {-17, -100}}, lineColor = {160, 160, 164}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -110}, {-30, -90}}, lineColor = {160, 160, 164}, textString = "i"), Line(points = {{8, -79}, {18, -79}}, color = {192, 192, 192}), Line(points = {{14, 80}, {14, 70}}, color = {192, 192, 192})}),
      Documentation(info = "<html>
  <p>EMF transforms electrical energy into rotational mechanical energy. It is used as basic building block of an electrical motor. The mechanical connector flange can be connected to elements of the Modelica.Mechanics.Rotational library. flange.tau is the cut-torque, flange.phi is the angle at the rotational connection.</p>
  </html>", revisions = "<html>
  <ul>
  <li><em> 1998   </em>
       by Martin Otter<br> initially implemented<br>
       </li>
  </ul>
  </html>"));
  end EMF;
  
  model TestGen
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {46, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed1(w_fixed = 1) annotation(
      Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Load annotation(
      Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DiscGenerator.EMF DiscGenerator annotation(
      Placement(visible = true, transformation(origin = {-14, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
  connect(constantSpeed1.flange, DiscGenerator.flange) annotation(
      Line(points = {{-48, 0}, {-14, 0}, {-14, 0}, {-14, 0}}));
  connect(DiscGenerator.p, Load.p) annotation(
      Line(points = {{-14, 10}, {46, 10}, {46, 10}, {46, 10}}, color = {0, 0, 255}));
  connect(DiscGenerator.n, Load.n) annotation(
      Line(points = {{-14, -10}, {46, -10}, {46, -10}, {46, -10}}, color = {0, 0, 255}));
  connect(Load.n, ground1.p) annotation(
      Line(points = {{46, -10}, {46, -10}, {46, -28}, {46, -28}}, color = {0, 0, 255}));
  end TestGen;
end DiscGenerator;
