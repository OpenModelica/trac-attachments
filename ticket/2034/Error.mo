within ;
model Error
  parameter Integer a=20;
  parameter Integer b = 2 + integer(ceil(a/2));
  parameter Integer c[8] = 4:(b -1);
  annotation (uses(Modelica(version="3.2")));
end Error;
