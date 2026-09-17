model TestSince
  Modelica.Blocks.Sources.Sine sine1(amplitude = 1, freqHz = 50, offset = 0, phase = -84.3199, startTime = 0)  annotation(
    Placement(visible = true, transformation(origin = {-12, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    uses(Modelica(version = "3.2.2")),
    experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 0.0001),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end TestSince;
