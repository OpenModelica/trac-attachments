package Bug

  model B
    outer output Real v;
  equation
    v = time;
  end B;

  model A
    inner outer output Real v;
    Real y2;
    B b;
  equation
    y2 = v;
  end A;

  model Test
    inner Real v;
    Real y1;
    A a;
  equation
    y1 = v;
  end Test;
  
end Bug;


