model RenaTest
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1 annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {-32, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2 annotation(Placement(visible = true, transformation(origin = {6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-60, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ground1.p, constantVoltage1.n) annotation(Line(points = {{-60, -32}, {-60, -32}, {-60, -10}, {-60, -10}}, color = {0, 0, 255}));
  connect(resistor2.n, constantVoltage1.n) annotation(Line(points = {{6, -12}, {6, -12}, {6, -22}, {-60, -22}, {-60, -10}, {-60, -10}}, color = {0, 0, 255}));
  connect(resistor1.n, resistor2.p) annotation(Line(points = {{-22, 20}, {6, 20}, {6, 8}, {6, 8}, {6, 8}}, color = {0, 0, 255}));
  connect(resistor1.p, constantVoltage1.p) annotation(Line(points = {{-42, 20}, {-60, 20}, {-60, 10}, {-60, 10}}, color = {0, 0, 255}));
  annotation(Icon, Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end RenaTest;