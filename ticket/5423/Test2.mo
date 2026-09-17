model Test2
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-98, -62}, {-78, -42}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {-88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(freqHz = 50 * ones(3), V = 100 * sqrt(2) * ones(3)) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-88, 20})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Iup annotation(
    Placement(visible = true, transformation(origin = {-32, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.AronSensor aron annotation(
    Placement(visible = true, transformation(origin = {-64, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(aron.plug_p, sineVoltage.plug_n) annotation(
    Line(points = {{-74, 40}, {-88, 40}, {-88, 30}, {-88, 30}, {-88, 30}}, color = {0, 0, 255}));
  connect(aron.plug_n, Iup.plug_p) annotation(
    Line(points = {{-54, 40}, {-42, 40}, {-42, 40}, {-42, 40}}, color = {0, 0, 255}));
  connect(ground.p, star.pin_n) annotation(
    Line(points = {{-88, -42}, {-88, -38}, {-90, -38}, {-90, -32}, {-88, -32}, {-88, -22}}, color = {0, 0, 255}));
  connect(sineVoltage.plug_p, star.plug_p) annotation(
    Line(points = {{-88, 10}, {-88, 4}, {-88, 4}, {-88, -2}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 60}})),
    experimentSetupOutput,
    Commands(file = "A0.mos" "A0"),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 0.0001, Interval = 0.0006),
    Documentation(info = "<html><head></head><body>Start-up of an asynchronous machine from the mains.</body></html>"),
    uses(Modelica(version = "3.2.3")));
end Test2;
