model M
  A a1;
  B b1;
equation
  for i in 1:2 loop
    connect(a1.y[i], b1.u[i]);
  end for;
end M;