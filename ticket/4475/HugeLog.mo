model HugeLog
  Real a, b, c, u, x, v;
equation
  u = sin(100 * time);
  a + 0.001 * sin(b) - c = u;
  2 * a + 0.001 * sin(b) - 0.001 * cos(c) = u;
  4 * a + b - 0.001 * sin(c) = u;
  der(x) = v;
  when sample(0, 1e-3) then
    v = c;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 1e-2, Tolerance = 1e-06, Interval = 2e-05));
end HugeLog;
