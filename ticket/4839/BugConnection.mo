model BugConnection
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(extent = {{-36, -46}, {-16, -26}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {-26, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V = 100 * sqrt(2) * ones(3), freqHz = 50 * ones(3), phase = {0, 120, 240}) annotation(
      Placement(visible = true, transformation(origin = {-26, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(R = fill(1000, 3)) annotation(
      Placement(visible = true, transformation(origin = {16, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor1 annotation(
      Placement(visible = true, transformation(origin = {16, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(resistor1.plug_n, inductor1.plug_p) annotation(
      Line(points = {{16, 4}, {16, -4}}, color = {0, 0, 255}));
    connect(sineVoltage.plug_p, resistor1.plug_n) annotation(
      Line(points = {{-26, 32}, {16, 32}, {16, 4}}, color = {0, 0, 255}));
    connect(star.plug_p, inductor1.plug_n) annotation(
      Line(points = {{-26, 0}, {0, 0}, {0, -30}, {16, -30}, {16, -24}, {16, -24}}, color = {0, 0, 255}));
    connect(star.pin_n, ground.p) annotation(
      Line(points = {{-26, -20}, {-26, -28}}, color = {0, 0, 255}));
    connect(star.plug_p, sineVoltage.plug_n) annotation(
      Line(points = {{-26, 0}, {-26, 0}, {-26, 12}, {-26, 12}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {80, 60}})),
      experimentSetupOutput,
      Commands(file = "A0.mos" "A0"),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 0.0002),
      Documentation(info = "<html><head></head><body>Start-up of an asynchronous machine from the mains.</body></html>"),
      __OpenModelica_commandLineOptions = "");
  end BugConnection;
