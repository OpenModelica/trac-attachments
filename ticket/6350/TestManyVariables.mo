package TestManyVariables
  model M
    parameter Integer N = 10;
    Real x[N];
  equation
    for i in 1:N loop
      x[i] = time*i;
    end for;
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M;

  model M_10000
    extends M(N = 10000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_10000;

  model M_15000
    extends M(N = 15000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_15000;

  model M_20000
    extends M(N = 20000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_20000;

  model M_25000
    extends M(N = 25000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_25000;

  model M_30000
    extends M(N = 30000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_30000;

  model M_35000
    extends M(N = 35000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_35000;

  model M_40000
    extends M(N = 40000);
    annotation(experiment(StopTime = 1, Interval = 1e-3));
  end M_40000;
end TestManyVariables;
