package TestConditionalArray3

  connector C
    Real x;
    flow Real y;
  end C;
  model M1
    C c;
  equation
    c.x = 10;
  end M1;
  
  model M2
    parameter Boolean act;
    C c;
    M3 m3 if act;
    M4 m4 if not act;
  equation
    connect(c, m3.c);
    connect(c, m4.c);
  end M2;

  model M3
    C c;
  equation
    c.y = 1;
  end M3;
  
  model M4
    C c;
  equation
    c.y = 2;
  end M4;

  model S
    parameter Integer N = 3;
    parameter Boolean act[3] = {true, true, false};
    M1 m1;
    M2 m2[N](act = act);
  equation
  for i in 1:N loop
      connect(m1.c, m2[i].c);
    end for;
  end S;
end TestConditionalArray3;
