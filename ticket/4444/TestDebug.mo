model TestDebug
  Real x(start = 0, fixed= true),y,z,w,s;
equation
  der(x)  = 10 - x;
  y + 1e-3*sin(w) = x;
  z + 1e-3*sin(w) = y;
  w + 1e-3*sin(w) = z;
  s = log(5-x);
end TestDebug;
