model TestLambda0DAEMode
  Real x, y, z, w;
equation
  der(x) = z;
  der(y) = w;
  z = homotopy((x - y)^2, x - y);
  w = homotopy((y - 1)^2, y - 1);
initial equation
  der(x) = 0;
  der(y) = 0;
//annotation(__OpenModelica_commandLineOptions="--daeMode");
end TestLambda0DAEMode;
