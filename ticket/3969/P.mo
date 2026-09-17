package P
  package Q1
    model M1
      Real x;
      Real y;
      Real z;
      parameter Real q = 3;
    // some comment
    // 
    equation
      x = 3*y;
      der(y) = -y;
      z = q - y;
    end M1;
    
    model M2
      Real x;
      Real y;
      Real z;
      parameter Real q = 3;
    // some comment
    // 
    equation
      x = 3*y;
      der(y) = -y;
      z = q - y;
    end M2;
  end Q1;
  
  package Q2
    model M1
      Real x;
      Real y;
      Real z;
      parameter Real q = 3;
    // some comment
    // 
    equation
      x = 3*y;
      der(y) = -y;
      z = q - y;
    end M1;
    
    model M2
      Real x;
      Real y;
      Real z;
      parameter Real q = 3;
    // some comment
    // 
    equation
      x = 3*y;
      der(y) = -y;
      z = q - y;
    end M2;
  end Q2;
end P;