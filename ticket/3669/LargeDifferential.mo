package LargeDifferential
  model M
    parameter Integer N = 10;
    Real x[N](each start = 0, each fixed = true);
  equation
    for i in 1:N loop
      der(x[i]) = 1 - x[i];
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

  model M_8000
    extends M(N=8000);
  end M_8000;
  
  model M_2000_native
    parameter Integer N = 2000;
    Real x[N](each start = 0, each fixed = true);
  equation
    for i in 1:N loop
      der(x[i]) = 1 - x[i];
    end for;
   end M_2000_native;
  
  model M_4000_native
    parameter Integer N = 4000;
    Real x[N](each start = 0, each fixed = true);
  equation
    for i in 1:N loop
      der(x[i]) = 1 - x[i];
    end for;
   end M_4000_native;

  model M_6000_native
    parameter Integer N = 6000;
    Real x[N](each start = 0, each fixed = true);
  equation
    for i in 1:N loop
      der(x[i]) = 1 - x[i];
    end for;
   end M_6000_native;

  model M_8000_native
    parameter Integer N = 8000;
    Real x[N](each start = 0, each fixed = true);
  equation
    for i in 1:N loop
      der(x[i]) = 1 - x[i];
    end for;
   end M_8000_native;


end LargeDifferential;
