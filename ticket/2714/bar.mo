within ;
model bar

  parameter Integer a = 3 "size of first array in function foo";
  parameter Integer b = 2 "size of second array in function foo";
  parameter Integer c = a+b "total size of output array, return from function foo";
  parameter Real result[c] = foo(a,b,c);

  annotation (uses(Modelica(version="3.2.1")));
end bar;
