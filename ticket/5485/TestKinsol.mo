package TestKinsol
  model Test
    parameter Integer N = 10;
    parameter Real k_min = 1;
    parameter Real k_max = 2;
    parameter Real s_0 = 1;
    parameter Real d_tot = 1;
    Real d[N+1];
    Real s[N];
    Real F[N];
    Real k[N];
  equation
    d[1] = d_tot*0.3*sin(2*3.14159*time);
    for i in 1:N loop
      d[i+1] = d[i] + s[i]; 
      s[i]*(s[i]+s_0/N)*k[i]*N = F[i];
      k[i] = k_min + (k_max-k_min)/(N-1)*(i-1);
    end for;
    for i in 1:N-1 loop
      F[i] = F[i+1];
    end for;
    d[end] = d_tot;
  end Test;

  model Test10
    extends Test(N = 10);
    annotation(__OpenModelica_commandLineOptions="--maxSizeNonlinearTearing=0",
               __OpenModelica_simulationFlags(s = "euler", nls = "kinsol"),
               experiment(StopTime = 1, Interval = 1e-5));
  end Test10;
 
  model Test100
    extends Test(N = 100);
    annotation(__OpenModelica_commandLineOptions="--maxSizeNonlinearTearing=0",
               __OpenModelica_simulationFlags(s = "euler", nls = "kinsol"),
               experiment(StopTime = 1, Interval = 1e-5));
  end Test100;

  model Test1000
    extends Test(N = 10);
    annotation(__OpenModelica_commandLineOptions="--maxSizeNonlinearTearing=0",
               __OpenModelica_simulationFlags(s = "euler", nls = "kinsol"),
               experiment(StopTime = 1, Interval = 1e-5));
  end Test1000;
end TestKinsol;

