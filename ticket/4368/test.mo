model test
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
// comment at the very beginning and followed by a new line

equation
  connect(resistor1.n, ground1.p) annotation(
    Line(points = {{0, 0}, {0, -20}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.2")));
end test;
