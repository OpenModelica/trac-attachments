model M
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {0, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantvoltage1 annotation(Placement(visible = true, transformation(origin = {-20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(ground1.p, constantvoltage1.n) annotation(Line(points = {{0, -14}, {0, -14}, {0, -8}, {-20, -8}, {-20, 0}, {-20, 0}}, color = {0, 0, 255}));
  connect(resistor1.p, constantvoltage1.p) annotation(Line(points = {{20, 20}, {20, 20}, {20, 30}, {-20, 30}, {-20, 20}, {-20, 20}}, color = {0, 0, 255}));
  connect(constantvoltage1.n, resistor1.n) annotation(Line(points = {{-20, 0}, {-20, 0}, {-20, -8}, {20, -8}, {20, 0}, {20, 0}}, color = {0, 0, 255}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end M;