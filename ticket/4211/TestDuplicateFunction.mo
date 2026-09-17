package TestDuplicateFunction
  function f
    input Real x;
    output Real y;
  algorithm
    y := x;
  end f;
  
  function f
    input Real x;
    input Real z;
    output Real y;
  algorithm
    y := x+z;
  end f;

  model Test
    Real r = f(time);
  end Test;
end TestDuplicateFunction;
