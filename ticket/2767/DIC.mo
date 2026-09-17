within ;
model DIC "Double Integrator Continuous-time"
  parameter Real p = 1 "gain for input";
  input Real u;
  output Real y1, y2;
  Real x1(start = 1, fixed = true);
  Real x2(start = 0, fixed = true);
equation
  der(x1) = p*u;
  der(x2) = x1;
  y1 = x1;
  y2 = x2;
end DIC;
