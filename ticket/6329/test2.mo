package test2
	model base
		parameter Real a = 1;
		Real x;
		output Real y;
		initial equation 
			y = 0;
		equation
		x = a*time;
		der(y) = x/2;
	end base;
	
	model C1
		extends base(a=2);
		parameter Real b = 4;
		Real m;
		equation
			m = 2*time/b;
	end C1;
	
	model C2
		extends base(a=6);
		parameter Real c = 10;
		Real n;
		equation
			n = 10*time+c;
	end C2;
	
	model main
		Real y_sum;
		C1 c1;
		C2 c2;
		base[2] B = {c1,c2};
		equation
			y_sum = sum(B.y);
	end main;
	
	
end test2;
