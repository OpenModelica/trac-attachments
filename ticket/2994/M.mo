model M
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantvoltage1 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {0, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(constantvoltage1.n, ground1.p) annotation(Line(points = {{-30, 0}, {-30, 0}, {-30, -14}, {0, -14}, {0, -14}}, color = {0, 0, 255}));
  connect(resistor1.p, constantvoltage1.n) annotation(Line(points = {{-10, 20}, {-30, 20}, {-30, 0}, {-30, 0}}, color = {0, 0, 255}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end M;