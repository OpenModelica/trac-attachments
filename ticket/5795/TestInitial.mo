model TestInitial
  Real v1, v2a, v2b, v3;
  Real i1, i2, i3;
  Real R1 = 1.5, R2 = 2.5, R3 = 3;
equation
  v1 = R1*i1;
  v2a- v1 = R2*i2;
  v3 - v2b = R3*i3;
  v3 = sin(time);
  i1 = i2;
  if initial() then
    v2a = 0;
    v2b = 0;
  else
    v2a = v2b;
    i2 = i3;
  end if;
  annotation(__OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing");
end TestInitial;
