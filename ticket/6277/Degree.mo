model Degree
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource(phi (displayUnit = "deg") = 0)  annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(voltageSource.pin_n, ground.pin) annotation(
    Line(points = {{0, 0}, {0, -16}}, color = {85, 170, 255}));
  annotation(
    uses(Modelica(version = "3.2.3")));
end Degree;