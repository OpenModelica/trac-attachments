within ;
package EVPkg1516 "Package per semplici EV senza azionamenti "
  //€

  model DragForce "Vehicle rolling and aerodinamical drag force"
    import Modelica.Constants.g_n;
    extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
    extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
    Modelica.SIunits.Force f "Total drag force";
    Modelica.SIunits.Velocity v "vehicle velocity";
    Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
    Real Sign;
    parameter Modelica.SIunits.Mass m "vehicle mass";
    parameter Modelica.SIunits.Density rho(start = 1.226) "air density";
    parameter Modelica.SIunits.Area S "vehicle cross area";
    parameter Real fc(start = 0.01) "rolling friction coefficient";
    parameter Real Cx "aerodinamic drag coefficient";
  protected
    parameter Real A = fc * m * g_n;
    parameter Real B = 1 / 2 * rho * S * Cx;
    // Constant auxiliary variable
  equation
//  s = flange.s;
    v = der(s);
    a = der(v);
    v_relfric = v;
    a_relfric = a;
    f0 = A "forza a velocità 0 ma con scorrimento";
    f0_max = A "massima forza  velocità 0 e senza scorrimento ";
    free = false "sarebbe true quando la ruota si stacca dalla strada";
// Ora il calcolo di f, e la sua attribuzione alla flangia:
    flange.f - f = 0;
// friction force
    if v > 0 then
      Sign = 1;
    else
      Sign = -1;
    end if;
    f - B * v ^ 2 * Sign = if locked then sa * unitForce else f0 * (if startForward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else if startBackward then -Modelica.Math.tempInterpol1(-v, [0, 1], 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else -Modelica.Math.tempInterpol1(-v, [0, 1], 2));
  end DragForce;
  annotation (uses(Modelica(version="3.2.1")));
end EVPkg1516;