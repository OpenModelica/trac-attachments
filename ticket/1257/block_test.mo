block foo
  input Integer foo1[:];
  input Integer foo2[:];
  output Real result[size(foo1,1)];
 algorithm
  for i in 1:size(foo1,1) loop
   if foo1[i] >= foo2[i] then
    result[i] := 7.0;
   else
    result[i] := 8.0;
   end if;   
  end for;
end foo;

model mod
  parameter Integer mod1[:]={1,1,1};
  parameter Integer mod2[:]={2,0,0};
  Real result[size(mod1,1)];
  foo f1(foo1=mod1, foo2=mod2);
  equation
    result = f1.result;
end mod;
