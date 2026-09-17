package Test;
type Seed=Real[3];

model TestRandom
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Seed  phi={1,4,3};
  Real outp;

initial equation 
outp=random2(phi,1);

equation 
outp=-2*der(outp);

  annotation (experiment(StopTime=10));
end TestRandom;

function random2
input Seed si;
input Real tim;
output Real x;
output Seed so;

algorithm 
so[1] := abs(rem((171*si[1]*exp(
mod(tim-11,tim+13))),30269));
so[2] := abs(rem((172*si[2]*exp(
mod(tim-5,tim+7))),30307));
so[3] := abs(rem((170*si[3]*exp(
mod(tim-23,tim+76))),30323));
if so[1] < 1e-4 then
so[1] := 1;
end if;
if so[2] < 1e-4 then
so[2] := 1;
end if;
if so[3] < 1e-4 then
so[3] := 1;
end if;
x := rem((so[1]/30269.0 +so[2]/30307.0 +
so[3]/30323.0),1.0);
end random2;
end Test;