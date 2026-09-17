within ;
model test
import SI = Modelica.SIunits;

 extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
 SI.Position s;
SI.Position Smax "maximale Position";

equation
Smax = noEvent(max(Smax,s));
flange_a.s = s;
flange_b.s = Smax;
flange_a.f = 0;
  annotation (uses(Modelica(version="3.2")));
end test;
