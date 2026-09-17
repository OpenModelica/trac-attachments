class test
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = 1) annotation(Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-70, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(firstOrder1.y, y) annotation(Line(points = {{10, 0}, {34, 0}, {34, 0}, {42, 0}}, color = {0, 0, 127}));
  connect(u, firstOrder1.u) annotation(Line(points = {{-70, 2}, {-16, 2}, {-16, 0}, {-14, 0}}, color = {0, 0, 127}));
  annotation(Icon, Diagram);
end test;