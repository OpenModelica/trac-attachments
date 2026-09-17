model test
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque1(tau_constant = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1, phi(fixed = true, start = 0), w(fixed = true, start = 0))  annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(constantTorque1.flange, inertia1.flange_a) annotation(
    Line(points = {{-20, 0}, {0, 0}, {0, 0}, {0, 0}}));

annotation(
    uses(Modelica(version = "3.2.2")));
end test;
