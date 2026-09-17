model reallyeasy
  input Real x(start = 5);
  output Real y;
equation
  y = testLib(x);
end reallyeasy;