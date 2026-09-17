class HelloWorld
  Real x(start = 1);
  parameter Real a = 1;
equation
  der(x) = -a * x;
  annotation(experiment(StartTime = 0, StopTime = 1, Tolerance = 0.000001, Interval = 2));
end HelloWorld;

