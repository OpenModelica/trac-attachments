package Test
  import Modelica.Blocks.Sources.Ramp;
  import Modelica.Blocks.Interfaces.*;

  model M1
	parameter Integer t1 [:]; // list of indices for t2
	parameter Real t2 [:]; // list of items to sum

	RealInput d;
	Integer n (start=1);
	Real s;
  algorithm
	s := sum(t2[i] for i in t1[1:n]);
	n := F1(n,d,s,t1,t2);
  end M1;

  function F1
	input Integer nb;
	input Real d;
	input Real s;
	input Integer t1 [:];
	input Real t2 [:];

	output Integer nbNew;

  algorithm
	nbNew := if d >= s and nb < size(t1,1) then
		nb + 1
	  elseif d <= s/2 and nb > 1 then
		nb - 1
	  else
		nb;
  end F1;

  model Test1
	Ramp rp(offset=5000,startTime=0,duration=10,height=95000);
	M1 m(t1={2,4,1,5,3,6,7},t2={11400,11400,11400,15200,15200,15200,15200});
  equation
	connect(rp.y,m.d);
  end Test1;

end Test;