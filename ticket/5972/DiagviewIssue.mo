package DiagviewIssue
  model M
    extends PartialM;
    import Modelica.Constants.*;
    //  parameter Modelica.SIunits.Mass  vMass = 1300;
    //  parameter Modelica.SIunits.AngularVelocity wIceStart = 167;
    // rad/s
    Modelica.Blocks.Continuous.Integrator tokgFuel(k = 1 / 3.6e6) annotation(
      Placement(visible = true, transformation(origin = {28, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Product product1 annotation(
      Placement(visible = true, transformation(origin = {28, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(tokW.y, product1.u2) annotation(
      Line(points = {{-18, -29}, {-18, -29}, {-18, -36}, {10, -36}, {10, -20}, {22, -20}, {22, -28}, {22, -28}}, color = {0, 0, 127}));
    connect(product1.u1, toGramsPerkWh.y) annotation(
      Line(points = {{34, -28}, {34, -20}, {42, -20}, {42, -13}}, color = {0, 0, 127}));
    connect(tokgFuel.u, product1.y) annotation(
      Line(points = {{28, -58}, {28, -51}, {28, -51}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
      experiment(StopTime = 200, __Dymola_NumberOfIntervals = 1000, __Dymola_Algorithm = "Lsodar"),
      __Dymola_experimentSetupOutput,
      Documentation(info = "<html>
  <p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</span></b> </p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBiceP.</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBiceP.</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
  </html>"),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
      uses(Modelica(version = "3.2.2")));
  end M;

  model PartialM
    import Modelica.Constants.*;
    parameter Real contrGain(unit = "N.m/W") = 0.1 "Proportional controller gain";
    parameter Real wIceStart(unit = "rad/s") = 167;
    parameter Modelica.SIunits.MomentOfInertia iceJ = 0.5 "ICE moment of Inertia";
    // rad/s
    Modelica.Mechanics.Rotational.Components.Inertia inertia(w(fixed = true, start = wIceStart, displayUnit = "rpm"), J = iceJ) annotation(
      Placement(visible = true, transformation(extent = {{30, 42}, {50, 62}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque iceTau annotation(
      Placement(visible = true, transformation(extent = {{4, 42}, {24, 62}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor Pice annotation(
      Placement(transformation(extent = {{66, 62}, {86, 42}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation(
      Placement(visible = true, transformation(origin = {58, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Math.Product toPowW annotation(
      Placement(visible = true, transformation(origin = {-18, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(transformation(extent = {{-90, 62}, {-70, 42}})));
    Modelica.Blocks.Math.Gain gain(k = contrGain) annotation(
      Placement(visible = true, transformation(extent = {{-62, 42}, {-42, 62}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(
      Placement(transformation(extent = {{90, -10}, {110, 10}}), iconTransformation(extent = {{90, -10}, {110, 10}})));
    Modelica.Blocks.Tables.CombiTable2D toGramsPerkWh(table = specificCons) annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = -90, origin = {42, -2})));
    Modelica.Blocks.Math.Gain tokW(k = 0.001) annotation(
      Placement(visible = true, transformation(origin = {-18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Nonlinear.Limiter limiter1(uMax = 1e99, uMin = 0) annotation(
      Placement(visible = true, transformation(origin = {-22, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
    parameter Real specificCons[:, :] = [0.0, 100, 200, 300, 400, 500; 10, 630, 580, 550, 580, 630; 20, 430, 420, 400, 400, 450; 30, 320, 325, 330, 340, 350; 40, 285, 285, 288, 290, 300; 50, 270, 265, 265, 270, 275; 60, 255, 248, 250, 255, 258; 70, 245, 237, 238, 243, 246; 80, 245, 230, 233, 237, 240; 90, 235, 230, 228, 233, 235] "curve of ice specific consumption (g/kWh)";
  equation
    connect(toPowW.y, tokW.u) annotation(
      Line(points = {{-18, -1}, {-18, -6}}, color = {0, 0, 127}));
    connect(toPowW.u2, iceTau.tau) annotation(
      Line(points = {{-24, 22}, {-24, 32}, {-6, 32}, {-6, 52}, {2, 52}}, color = {0, 0, 127}));
    connect(iceTau.tau, limiter1.y) annotation(
      Line(points = {{2, 52}, {-10, 52}, {-10, 52}, {-11, 52}}, color = {0, 0, 127}));
    connect(limiter1.u, gain.y) annotation(
      Line(points = {{-34, 52}, {-42, 52}, {-42, 52}, {-41, 52}}, color = {0, 0, 127}));
    connect(toGramsPerkWh.u1, iceTau.tau) annotation(
      Line(points = {{36, 10}, {36, 32}, {-6, 32}, {-6, 52}, {2, 52}}, color = {0, 0, 127}));
    connect(iceTau.flange, inertia.flange_a) annotation(
      Line(points = {{24, 52}, {30, 52}}));
    connect(w.flange, inertia.flange_b) annotation(
      Line(points = {{58, 46}, {58, 52}, {50, 52}}));
    connect(Pice.flange_a, inertia.flange_b) annotation(
      Line(points = {{66, 52}, {50, 52}}));
    connect(toGramsPerkWh.u2, w.w) annotation(
      Line(points = {{48, 10}, {48, 20}, {58, 20}, {58, 25}}, color = {0, 0, 127}));
    connect(toPowW.u1, w.w) annotation(
      Line(points = {{-12, 22}, {-12, 25}, {58, 25}}, color = {0, 0, 127}));
    connect(gain.u, feedback.y) annotation(
      Line(points = {{-64, 52}, {-71, 52}}, color = {0, 0, 127}));
    connect(Pice.flange_b, flange_a) annotation(
      Line(points = {{86, 52}, {94, 52}, {94, 0}, {100, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(feedback.u2, Pice.power) annotation(
      Line(points = {{-80, 60}, {-80, 72}, {68, 72}, {68, 63}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Documentation(info = "<html>
  <p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</b> </span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBice.</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBice.</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
  <p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
  </html>"),
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-24, 48}, {76, -44}}), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{76, 10}, {100, -10}}), Text(origin = {-2, 0}, extent = {{-140, -52}, {140, -86}}, textString = "J=%J"), Rectangle(extent = {{-100, 62}, {100, -100}}), Text(origin = {0, 10}, lineColor = {0, 0, 255}, extent = {{-140, 100}, {140, 60}}, textString = "%name"), Rectangle(extent = {{-90, 48}, {-32, -46}}), Rectangle(fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, extent = {{-90, 2}, {-32, -20}}), Line(points = {{-60, 36}, {-60, 12}}), Polygon(points = {{-60, 46}, {-66, 36}, {-54, 36}, {-60, 46}}), Polygon(points = {{-60, 4}, {-66, 14}, {-54, 14}, {-60, 4}}), Rectangle(fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid, extent = {{-64, -20}, {-54, -40}})}),
      uses(Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(extent = {{-90, 20}, {-46, -16}}, textString = "follows the power
  reference \nand computes consumption")}));
  end PartialM;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end DiagviewIssue;
