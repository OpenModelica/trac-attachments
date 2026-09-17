// name:     InstClassBindingMod
// keywords: declaration, binding, modification, bug2159
// status:   correct
// 
// Checks that the instantiation does not reorder the elements of C1 when one
// element is modified with a binding that references a class.
// 

connector C1
  replaceable package P = .P;
  flow Real f;
  Real e;
  stream Real s;
end C1;

connector C2
  extends C1;
end C2;

package P
  constant Real x = 2.0;
end P;

model M1
  package P = .P;
  C2 c(redeclare package P = P);
end M1;

model InstClassBindingMod
  extends M1(c(e(start = P.x)));
end InstClassBindingMod;

// Result:
// class InstClassBindingMod
//   Real c.f;
//   Real c.e(start = 2.0);
//   Real c.s;
// equation
//   c.f = 0.0;
// end InstClassBindingMod;
// endResult
