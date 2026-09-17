package TestInit 
  model Example1_1 
    Real x;
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  end Example1_1;
  
  model Example1_2 
    Real x(start = 2);
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  end Example1_2;
  
  model Example1_3 
    Real x;
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  initial equation 
    x = 3;
  end Example1_3;
  
  model Example1_4 
    Real x(start = 6);
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  initial equation 
    x = 3;
  end Example1_4;
  
  model Example2_1 
    Real x;
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  initial equation 
    der(x) = 0;
  end Example2_1;
  
  model Example2_2 
    Real x(start = 3);
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  initial equation 
    der(x) = 0;
  end Example2_2;
  
  model Example2_3 
    Real x(fixed = false);
  equation 
    der(x) = -x +1 + (if time > 5 then 1 else 0);
  initial equation 
    der(x) = 0;
  end Example2_3;

  model Example3_1 
    Real x(start = 0.5);
  equation 
    der(x) = -sin(x) + 0.8;
  initial equation 
    der(x) = 0;
  end Example3_1;

  model Example3_2 
    Real x(start = 0.5, fixed = false);
  equation 
    der(x) = -sin(x) + 0.8;
  initial equation 
    der(x) = 0;
  end Example3_2;

  model Example4 
    Real x(start = 3);
    Real y;
    Real z;
  equation 
    der(x) = -x - y - z +1;
    y = x;
    z = x;
  end Example4;
  
end TestInit;
