model VINoGround "ticket for bad error message at https://trac.openmodelica.org/OpenModelica/ticket/4115"
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 1) annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent1(I = 2)  annotation(Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-20, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ground1.p, constantVoltage1.n) annotation(Line(points = {{-20, -26}, {-40, -26}, {-40, -10}, {-40, -10}}, color = {0, 0, 255}));
  connect(constantCurrent1.n, constantVoltage1.n) annotation(Line(points = {{20, -10}, {20, -10}, {20, -20}, {-40, -20}, {-40, -10}, {-40, -10}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, constantCurrent1.p) annotation(Line(points = {{-40, 10}, {-40, 20}, {20, 20}, {20, 10}}, color = {0, 0, 255}));
  annotation(uses(Modelica(version = "3.2.2")), Diagram(graphics = {Text(origin = {2, 65}, extent = {{-78, 11}, {78, -11}}, textString = "circuit where ground is forgotten", fontName = "DejaVu Sans Mono")}));
end VINoGround;