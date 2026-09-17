within ;
model RecordArrayInFunction
  record Record
    Real x[4];
  end Record;

  function fun
    input Record u[2];
    output Real y;
  algorithm
    y :=sum(u[1].x) + sum(u[2].x);
  end fun;

  Record r[2](each x = 1:4);
  Real z;

equation
  z = fun(r);
end RecordArrayInFunction;
