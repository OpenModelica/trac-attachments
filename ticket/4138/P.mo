package P
  model M0
//    parameter Real p = 3;
//    parameter Real q =10;
//    final parameter Real r = 2;
    Real p = 3;
    Real q =10;
    Real r = 2;
    Real x, y, z;
    Real a, b, c;
    Real d, e, f, g;
  equation
    x = b;
    y = p*x + a;
    z - x = q;
    a = 10;
    b - a = r;
    c + a - 2 = 14;
    d = 40;
    e = 0;
    f = 50;
    c+ d+ e +x +a = 0;
  end M0;
  
  model M
    parameter Real p = 3;
    M0 m01(p = p);
    M0 m02(p = p);
    M0 m03(p = p);
    M0 m04(p = p);
    M0 m05(p = p);
    M0 m06(p = p);
    M0 m07(p = p);
    M0 m08(p = p);
    M0 m09(p = p);
    M0 m10(p = p);
  end M;
  
  model S
    M m1(p = 1);
    M m2(p = 2);
  end S;
end P;
