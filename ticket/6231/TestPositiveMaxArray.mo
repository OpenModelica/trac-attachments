package TestPositiveMaxArray
  connector Port
    Real e;
    flow Real f;
    stream Real s;
  end Port;
  
  model T
    parameter Real fnom;
    Port a(f(nominal = fnom));
    Port b(f(nominal = fnom));
  equation
    a.f + b.f = 0;
    a.f = a.e - b.e;
    a.s = inStream(b.s);
    b.s = inStream(a.s);
  end T;
  
  model V
    parameter Real fnom;
    Port p(f(nominal = fnom));
  equation
    p.e = 1;
    p.s = 1;
  end V;

  model C
    parameter Real fnom;
    parameter Real M;
    Port a(f(nominal = fnom*M));
    Port b(f(nominal = fnom*M));
    T t(fnom = fnom);
    V v(fnom = fnom);
  equation
    connect(a, t.a);
    connect(b, t.b);
    connect(b, v.p);
  end C;
  
  model M
    parameter Integer N = 3;
    parameter Integer M[:] = {10, 20, 30};
    parameter Real fnom[N] = {1, 2, 3};
    C c[N](fnom = fnom, M = M);
  equation
    for i in 1:N-1 loop
      connect(c[i].b, c[i+1].a);
    end for;
  annotation(__OpenModelica_commandLineOptions = "d=evaluateAllParameters");
  end M;

end TestPositiveMaxArray;
