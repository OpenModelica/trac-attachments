package TestFixed
  model Consistent
    Real x1(start = 0, fixed = true);
    Real v1(start = 0, fixed = true);
    Real x2(start = 0, fixed = false);
    Real v2(start = 0, fixed = true);
    Real F;
  equation
    der(x1) = v1;
    der(v1) = F;
    der(x2) = v2;
    der(v2) = -F+sin(time);
    x1 = x2;
  end Consistent;

  model Inconsistent
    extends Consistent(v2(start = 1));
  end Inconsistent;

  model Consistent2
    extends Consistent(v2(start = 1, fixed=false));
  end Consistent2;

end TestFixed;
