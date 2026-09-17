model test_input
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal1 annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(integerToReal1.y, y) annotation(
    Line(points = {{12, 0}, {94, 0}, {94, 0}, {100, 0}}, color = {0, 0, 127}));
  connect(u, integerToReal1.u) annotation(
    Line(points = {{-100, 0}, {-14, 0}, {-14, 0}, {-12, 0}}, color = {255, 127, 0}));
  annotation(
    uses(Modelica(version = "3.2.2")));end test_input;
