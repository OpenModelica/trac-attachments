model TestFuncMulti_2

	function C_V
		import SI = Modelica.SIunits;
		import nSI = Modelica.SIunits.Conversions.NonSIunits;
		import CN = Modelica.Constants;
		import CV = Modelica.SIunits.Conversions;
		import FI = SolarTherm.Models.Analysis.Finances;

		extends Modelica.Icons.Function;

		input Real V;
		output Integer n1;
		output Integer n2;
		output Real C;

	protected
		parameter Real V_max = 3.0;

	algorithm
		n1 := integer(ceil(V/V_max));
		n2 := 0;
		C := n1 * 50 * (V/n1);
	end C_V;


	parameter Real V_req = 10;

	parameter Integer n_req;
	parameter Integer n_ub;
	parameter Real C_cap;

equation
	(n_req, n_ub, C_cap) = C_V(V_req); //Surely, this equation should be here in the "equation" section, but I have no idea where to place it. I did try that outside the equation section above but it did not work either!
end TestFuncMulti_2;
