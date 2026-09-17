package TestStrongComponentJacobians
  model M
    parameter Integer N = 2;
    Real x[N], y[N], z[N], w[N];
  equation
    for i in 1:N loop
      x[i] + 1e-6*sin(x[i]) + y[i] -z[i] + w[i] = 1;
      x[i] + 1e-6*sin(y[i]) - y[i] + z[i] - w[i] = -1;
      -x[i]+ 3*y[i] - 1e-6*sin(z[i]) - z[i] + 4*w[i]= 3;
      -3*x[i] + y[i] + z[i] - 1e-6*sin(w[i]) + 5*w[i] = 10;
    end for;
  end M;
  
  model M_100
    extends M(N = 100);
  end M_100;
  
  model M_400
    extends M(N = 400);
  end M_400;
  
  model M_1600
    extends M(N = 1600);
  end M_1600;

  model M_3200
    extends M(N = 3200);
  end M_3200;
    
end TestStrongComponentJacobians;