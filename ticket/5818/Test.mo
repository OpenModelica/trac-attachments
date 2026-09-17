model Test
  Real x, y, z;
  parameter Real x0, y0, z0;
equation
  der(x) = -x;
  y = 10+sin(x);
  z = 2*sin(x);
end Test;
