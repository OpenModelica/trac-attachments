model prova2
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantvoltage1 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1000) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 1000) annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor2.n, ground1.p) annotation(Line(points = {{30, 40}, {41.6422, 40}, {41.6422, -28.739}, {-40.4692, -28.739}, {-40.4692, -28.739}}));
  connect(resistor1.n, resistor2.p) annotation(Line(points = {{-10, 40}, {9.97067, 40}, {9.97067, 40.4692}, {9.97067, 40.4692}}));
  connect(constantvoltage1.p, resistor1.p) annotation(Line(points = {{-50, 0}, {-69.20820000000001, 0}, {-69.20820000000001, 39.2962}, {-29.912, 39.2962}, {-29.912, 39.2962}}));
  connect(constantvoltage1.n, ground1.p) annotation(Line(points = {{-30, 0}, {-20.5279, 0}, {-20.5279, -18.1818}, {-39.8827, -18.1818}, {-39.8827, -29.3255}, {-39.8827, -29.3255}}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.1, 0.1})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end prova2;