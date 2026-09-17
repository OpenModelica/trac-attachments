model Malcolm3
  parameter Real period = 320e-9;
  Clock cSample = Clock(period);
  Integer y(start = 1);
  Integer yhold;
  Modelica.Blocks.Sources.Pulse phi1(amplitude = 1, period = period) annotation(
    Placement(visible = true, transformation(origin = {76, -16}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
initial equation

equation
  when cSample then
    y = if time <= 0 or previous(y) == 5 then 1 else previous(y) + 1;
  end when;
  yhold = hold(y);
  annotation(
    uses(Modelica(version = "3.2.3"), ModelicaReference(version = "3.2.3"), Modelica_Synchronous(version = "0.93.0")),
    Diagram(coordinateSystem(extent = {{-200, -150}, {100, 100}}, initialScale = 0.1)),
    version = "",
    experiment(StartTime = 0, StopTime = 1e-05, Tolerance = 1e-06, Interval = 5e-11));
end Malcolm3;
