model Buck
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-66, -4})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-32, -32})));
  Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.5) annotation(
    Placement(transformation(extent = {{-16, -14}, {4, 6}})));
  Modelica.Electrical.Analog.Basic.Inductor Lf(L = 10e-3) annotation(
    Placement(transformation(extent = {{14, -14}, {34, 6}})));
  Modelica.Blocks.Sources.SawTooth sawTooth(period = 1 / 1000) annotation(
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {58, 36})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold = 0.55) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {8, 22})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(extent = {{-76, -78}, {-56, -58}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SW annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-32, 22})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {56, -28})));
equation
  connect(V1.n, diode.p) annotation(
    Line(points = {{-66, -14}, {-66, -48}, {-32, -48}, {-32, -42}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(Rf.p, diode.n) annotation(
    Line(points = {{-16, -4}, {-32, -4}, {-32, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(Lf.p, Rf.n) annotation(
    Line(points = {{14, -4}, {4, -4}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(ground.p, V1.n) annotation(
    Line(points = {{-66, -58}, {-66, -14}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(sawTooth.y, lessThreshold.u) annotation(
    Line(points = {{69, 36}, {72, 36}, {72, 16}, {28, 16}, {28, 22}, {20, 22}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(SW.p, V1.p) annotation(
    Line(points = {{-32, 32}, {-32, 44}, {-66, 44}, {-66, 6}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(SW.n, diode.n) annotation(
    Line(points = {{-32, 12}, {-32, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(lessThreshold.y, SW.control) annotation(
    Line(points = {{-3, 22}, {-20, 22}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(Lf.n, V2.p) annotation(
    Line(points = {{34, -4}, {56, -4}, {56, -18}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(V2.n, diode.p) annotation(
    Line(points = {{56, -38}, {56, -48}, {-32, -48}, {-32, -42}}, color = {0, 0, 255}, smooth = Smooth.None));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 60}}), graphics = {Text(lineColor = {238, 46, 47}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-136, 70}, {-28, 46}}, textString = "Es proposto:      usare Ra e La di MSL
fare una simulazione in cui la macchina assorba
circa 10A, alimentata con 90V (medi)
f=250 Hz", horizontalAlignment = TextAlignment.Left)}),
    experiment(StopTime = 0.02),
    experimentSetupOutput,
    Documentation(info = "<html>
<p>Frazionatore abbassatore su carico resistivo con fitro L-C per la regolarizzazione della tensione sul carico.</p>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end Buck;
