model boost
	parameter Real C = 1e-4, L = 1e-4, R = 10, U = 24, T = 1e-4, DC = 0.5, ROn = 1e-5, ROff = 1e5;
	discrete Real Rd(start=1e5), Rs(start=1e5), nextT(start=T),lastT,diodeon;
	Real uC,iL,iD;
	
	 equation
		iD=(Rs*iL-uC)/(Rd+Rs);
	 	der(uC) = (iD - uC/R)/C;
		der(iL) =  (U-Rs*(iL-iD))/L;
	  
	algorithm
	when time > nextT then
		lastT:=nextT;
		nextT:=nextT+T;
		Rs := ROn;
	end when;

	when time - lastT-DC*T>0 then
		  Rs := ROff;
		  Rd := ROn;
		diodeon:=1;
	end when;

	when (Rs*iL-uC)/(Rd+Rs)*diodeon<0 then
		  Rd := ROff;
		diodeon:=0;
	end when;
end boost;

