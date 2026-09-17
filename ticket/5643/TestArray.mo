package TestArray
  package PlainEquations
    model A "A simple model using basic types without arrays"
      input Real u;
      parameter Real p = 1;
      Real x;
    equation
      x = p*u;
    end A;

    model B "A simple model using arrays or basic types"
      parameter Integer N = 3;
      parameter Real p = 1;
      Real x[N];
      input Real u;
    equation
      x[1] = u;
      for i in 2:N loop
        x[i] = x[i-1]+p;
      end for;
    end B;
  
    model C "A model using arrays of simple models without arrays"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      A a[N](p = p);  
    equation
      a[1].u = time;
      for i in 2:N loop
        a[i].u = a[i-1].x;
      end for;
    end C;
  
    model D "A model using arrays of models with arrays of basic types (same dimensions)"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      B b[N](p = p, each N = 4);
    equation  
      b[1].u = time;
      for i in 2:N loop
        b[i].u = b[i-1].x[end];
      end for;
    end D;

    model E "A model using arrays of models with arrays of basic types (same dimensions)"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      B b[N](p = p, N = {3, 4, 5});
    equation  
      b[1].u = time;
      for i in 2:N loop
        b[i].u = b[i-1].x[end];
      end for;
    end E;
  end PlainEquations;  

  package ConnectEquations
    connector CC
      Real e;
      flow Real f;
    end CC;

    model S "Source model"
      parameter Real p = 10;
      CC c;
    equation
      c.e = p;
    end S;
  
    model A "A simple model using basic types without arrays"
      CC c;
      parameter Real p = 1;
      Real x;
    equation
      der(x) = -p*x + 1;
      c.f = x;
    end A;

    model B "A simple model using arrays or basic types"
      parameter Integer N = 3;
      parameter Real p = 1;
      Real x[N];
      CC c;
    equation
      x[1] = c.e;
      x[N] = c.f;
      for i in 2:N loop
        x[i] = x[i-1]+p;
      end for;
    end B;
  
    model C "A model using arrays of simple models without arrays"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      A a[N](p = p);
      S s(p = 20);
    equation
      connect(s.c, a[1].c);
      for i in 1:N-1 loop
        connect(a[i].c, a[i+1].c);
      end for;  
    end C;
  
    model D "A model using arrays of models with arrays of basic types (same dimensions)"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      B b[N](p = p, each N = 3);
      S s(p = 3);
    equation
      connect(s.c, b[1].c);
      for i in 1:N-1 loop
        connect(b[i].c, b[i+1].c);
      end for;  
    end D;

    model E "A model using arrays of models with arrays of basic types (same dimensions)"
      parameter Integer N = 3;
      parameter Real p[N] = {1.0, 1.5, 2.0};
      B b[N](p = p, N = {3, 4, 5});
      S s(p = 3);
    equation
      for i in 1:N-1 loop
        connect(b[i].c, b[i+1].c);
      end for;  
    end E;
  end ConnectEquations;
end TestArray;
