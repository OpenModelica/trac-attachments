model test
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor.n, ground.p) annotation(
    Line(points = {{0, 10}, {0, 10}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.2")));
end test;
