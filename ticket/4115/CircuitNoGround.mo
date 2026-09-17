model CircuitNoGround
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 1)  annotation(Placement(visible = true, transformation(origin = {-40, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1)  annotation(Placement(visible = true, transformation(origin = {40, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(resistor1.n, constantVoltage1.n) annotation(Line(points = {{40, -12}, {40, -12}, {40, -36}, {-40, -36}, {-40, -12}, {-40, -12}, {-40, -12}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, resistor1.p) annotation(Line(points = {{-40, 8}, {-40, 8}, {-40, 28}, {40, 28}, {40, 8}, {40, 8}}, color = {0, 0, 255}));
  annotation(uses(Modelica(version = "3.2.2")), Diagram(graphics = {Text(origin = {2, 65}, extent = {{-78, 11}, {78, -11}}, textString = "circuit where ground is forgotten", fontName = "DejaVu Sans Mono")}));
end CircuitNoGround;