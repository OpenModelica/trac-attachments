model E10_linear
  // Parameters
  parameter Real a = 10.0;
  // Variables
  Real x(start = 1.0, fixed = true);

equation

  der(x) = a;

annotation(
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 1));
end E10_linear;
