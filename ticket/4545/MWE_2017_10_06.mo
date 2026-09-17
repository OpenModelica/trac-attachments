package MWE_2017_10_06
  model Test_vector
    Real x[2](each start = 0, each fixed = true);
    discrete Real u[2](each start = 0, each fixed = true);
    Real y[2];
  equation 
    for i in 1:2 loop 
      der(x[i]) = u[i];
      y[i] = 0.5*x[i];
    end for;
  algorithm
    when sample(0,1) then
      for i in 1:2 loop
        u[i] := 1 - y[i];
      end for;
    end when;
      
    annotation(experiment(StopTime = 10));
  end Test_vector;

  model Test_scalar
    Real x(start = 0, fixed = true);
    discrete Real u(start = 0, fixed = true);
    Real y;
  equation
    der(x) = u;
    y = 0.5 * x;
  algorithm
    when sample(0, 1) then
      u := 1 - y;
    end when;
    annotation(
      experiment(StopTime = 10));
  end Test_scalar;

  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end MWE_2017_10_06;
