model TestFunctionRecordArray
  constant Integer c = 3;

  record R
    Real v;
    Real x[c];
  end R;

  function f
    input Real v;
    output R rout;
  algorithm
    rout.v := v;
    rout.x := {0.3, 0.4, 0.3};
  end f;

  Real x;
  R r;
equation
  x = time;
  r = f(x);
end TestFunctionRecordArray;
