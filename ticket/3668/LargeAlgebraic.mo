package LargeAlgebraic
  model M
    parameter Integer N = 10;
    Real x(start = 0, fixed = true);
    Real y[N];
  equation
    der(x) = 1 - x;
    y[1] = x;
    y[N] = x;
    for i in 2:N-1 loop
      y[i-1] + 2* y[i] + y[i+1] = 0;
    end for;
  end M;
  
  model M_2000
    extends M(N=2000);
  end M_2000;

  model M_4000
    extends M(N=4000);
  end M_4000;

  model M_6000
    extends M(N=6000);
  end M_6000;
end LargeAlgebraic;
