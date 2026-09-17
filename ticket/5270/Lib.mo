package Lib
  model Test
    input Real a(min = 20, max = 100);
    output Real b;
  equation
    b = 2*a;
  end Test;
end Lib;
