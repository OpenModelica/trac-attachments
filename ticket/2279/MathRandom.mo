// within Random;

record SEEDINFO
  Real s1;
  Real s2;
  Real s3;
end SEEDINFO;

function MathRandom

  input SEEDINFO si;
  input Real tim;
  output Real x(start=0.0);
  output SEEDINFO so;

protected
  Real a=0.0,b=0.0,c=0.0; 
  Real s1=0.0, s2=0.0, s3=0.0; 
algorithm
  
  s1 := si.s1;
  s2 := si.s2;
  s3 := si.s3;
     
  a := mod(tim-11,tim+13);
  a := exp(a);
  a := rem(171*s1*a,30269);
  a := abs(a);
   
  b := mod(tim-5,tim+7); 
  b := exp(b);
  b := rem(172*s2*b,30307);
  b := abs(b);
  
  c := mod(tim-23,tim+76);
  c := exp(c);
  c := rem(170*s3*c,30323);  
  c := abs(c);

  if a < 1e-4 then
    a := 1.0;
  end if;
  if b < 1e-4 then
    b := 1.0;
  end if;
  if c < 1e-4 then
    c := 1.0;
  end if;
  x := rem((a/30269.0+b/30307.0+c/30323.0),1.0);
  
  so.s1 := a;
  so.s2 := b;
  so.s3 := c;
 
end MathRandom;

//-----------------------------------------------------------
//- For direct use in OMShell:
//- 	- Initialise ALL variables
//- 	- Call repeatedly: (r, s1,s2,s3) := MR(s1,s2,s3,t);
//-   Result: random r.
function MR
  input Real si1,si2,si3;
  input Real t;
  output Real x;
  output Real so1,so2,so3;
  protected
  SEEDINFO s;
algorithm
  s.s1:=si1;
  s.s2:=si2;
  s.s3:=si3;
  (x,s):=MathRandom(s,t);
  so1 := s.s1;
  so2 := s.s2;
  so3 := s.s3;
end MR;

//-----------------------------------------------------------

model test_MathRandom
  output Real y(start=0.0);
  parameter Real dtSample = 0.1;

protected
  SEEDINFO s(s1(start=1.0), s2(start=2.0), s3(start=3.0));
  Real x(start=0.0);
  Real s1, s2, s3;
algorithm
  (x,s):=MathRandom(s,time/10.0);
  s1 := s.s1;
  s2 := s.s2;
  s3 := s.s3;
equation
  when sample(0.0, dtSample) then
    y = x;
end when;
end test_MathRandom;

//-----------------------------------------------------------

model test_MR
  output Real y(start=0.0);
  parameter Real dtSample = 0.1;

protected
  Real s1(start=1.0), s2(start=2.0), s3(start=3.0);
  Real x(start=0.0);
algorithm
  (x,s1,s2,s3) := MR(s1,s2,s3,time/10.0);
equation
  when sample(0.0, dtSample) then
    y = x;
end when;
end test_MR;