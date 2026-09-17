package TestInput
  record R1
    Real x;
    Real y;
  end R1;
  
  model M1
    input R1 rec1;
    Real z;  
  equation
    z = time;    
  end M1;
end TestInput;
