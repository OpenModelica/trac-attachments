model test
  Modelica.Blocks.Math.Sum sum1(nin = 2) annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1 annotation(
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2 annotation(
    Placement(visible = true, transformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(realExpression1.y, sum1.u[1]) annotation(
    Line(points = {{-98, 30}, {-80, 30}, {-80, 10}, {-62, 10}, {-62, 10}}, color = {0, 0, 127}));
  connect(realExpression2.y, sum1.u[2]) annotation(
    Line(points = {{-98, -10}, {-80, -10}, {-80, 10}, {-62, 10}, {-62, 10}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")));
end test;