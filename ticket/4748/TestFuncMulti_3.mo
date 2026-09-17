model TestFuncMulti_3

	function C_V
		import SI = Modelica.SIunits;
		import nSI = Modelica.SIunits.Conversions.NonSIunits;
		import CN = Modelica.Constants;
		import CV = Modelica.SIunits.Conversions;
		import FI = SolarTherm.Models.Analysis.Finances;

		extends Modelica.Icons.Function;

		input Real V;
		output Real outputs[3];

	protected
		parameter Real V_max = 3.0;
		Integer n1;
		Integer n2;
		Real C;

	algorithm
		n1 := integer(ceil(V/V_max));
		n2 := 0;
		C := n1 * 50 * (V/n1);
	 	outputs := {n1, n2, C};
	end C_V;


	parameter Real V_req = 10;

	parameter Real outs[3] = C_V(V_req);

	parameter Integer n_req = integer(outs[1]);
	parameter Integer n_ub = integer(outs[2]);
	parameter Real C_cap = outs[3];

end TestFuncMulti_3;
