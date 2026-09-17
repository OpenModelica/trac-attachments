package TestPriorities
  type Pressure =  Real(start = 1e5, nominal = 1e6);
 
   model M
    parameter Pressure pstart = 2e5;
    parameter Pressure pnom = 3e5;
    Pressure p1;
    Pressure p2(start = pstart, nominal = pnom);
  equation
    p1 = p2;
    p1 + log(p1) = 2e5;
  end M;
   

  model Test
    M m1;
    M m2(pstart = 5e5, pnom = 6e5);
  end Test;
end TestPriorities;
