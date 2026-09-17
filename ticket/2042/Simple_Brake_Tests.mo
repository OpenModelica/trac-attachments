package Simple_Brake_Tests

  partial model PartialFrictionModel "Partial model of Coulomb friction elements -- using enumerated types"
    // Equations to define the following variables have to be defined in subclasses
    Real w_relfric "Relative angular velocity between frictional surfaces";
    Real a_relfric "Relative angular acceleration between frictional surfaces";
    //SI.Torque tau "Friction torque (positive, if directed in opposite direction of w_rel)";
    Real tau0 "Friction torque for w=0 and forward sliding";
    Real tau0_max "Maximum friction torque for w=0 and locked";
    Boolean free "true, if frictional element is not active";
    // Equations to define the following variables are given in this class
    Real sa(final unit = "1") "Path parameter of friction characteristic tau = f(a_relfric)";
    Boolean startForward(start = false, fixed = true) "true, if w_rel=0 and start of forward sliding";
    Boolean startBackward(start = false, fixed = true) "true, if w_rel=0 and start of backward sliding";
    Boolean locked(start = false) "true, if w_rel=0 and not sliding";
    type ModeType = enumeration(Unknown, Free, Forward, Stuck , Backward );
    ModeType mode(start = ModeType.Unknown, fixed = true);
  protected
    constant Real unitAngularAcceleration = 1 annotation(HideResult = true);
    constant Real unitTorque = 1 annotation(HideResult = true);
  equation
    startForward = pre(mode) == ModeType.Stuck and (sa > tau0_max / unitTorque or pre(startForward) and sa > tau0 / unitTorque) or initial() and w_relfric > 0;
    startBackward = pre(mode) == ModeType.Stuck and (sa < -tau0_max / unitTorque or pre(startBackward) and sa < -tau0 / unitTorque) or initial() and w_relfric < 0;
    locked = not free and not (pre(mode) == ModeType.Forward or startForward or pre(mode) == ModeType.Backward or startBackward);
    a_relfric / unitAngularAcceleration = if locked then 0 else if free then sa else if startForward then sa - tau0_max / unitTorque else if startBackward then sa + tau0_max / unitTorque else if pre(mode) == ModeType.Forward then sa - tau0_max / unitTorque else sa + tau0_max / unitTorque;
    mode = if free then ModeType.Free else if (pre(mode) == ModeType.Forward or pre(mode) == ModeType.Free or startForward) and w_relfric > 0 then ModeType.Forward else if (pre(mode) == ModeType.Backward or pre(mode) == ModeType.Free or startBackward) and w_relfric < 0 then ModeType.Backward else ModeType.Stuck;
    annotation(Documentation(info = "<html>
			     <p>
			     Basic model for Coulomb friction that models the stuck phase in a reliable way.
			     </p>
			     </html>"));
  end PartialFrictionModel;

  model BrakeModel
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
    parameter Real mue0(final min = 0);
    parameter Real peak(final min = 1) = 1 "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
    parameter Real cgeo(final min = 0) = 1 "Geometry constant containing friction distribution assumption";
    parameter Real fn_max(final min = 0, start = 1) "Maximum normal force";
    //    extends Modelica.Mechanics.Rotational.Interfaces.PartialFriction;
    extends PartialFrictionModel;
    Real phi "Angle between shaft flanges (flange_a, flange_b) and support";
    Real tau "Brake friction torqu";
    Real w "Absolute angular velocity of flange_a and flange_b";
    Real a "Absolute angular acceleration of flange_a and flange_b";
    Real fn "Normal force (=fn_max*f_normalized)";
    // Constant auxiliary variable
    Modelica.Blocks.Interfaces.RealInput f_normalized "Normalized force signal 0..1 (normal force = fn_max*f_normalized; brake is active if > 0)" annotation(Placement(visible = true, transformation(origin = {0,110}, extent = {{20,-20},{-20,20}}, rotation = 90), iconTransformation(origin = {0,110}, extent = {{20,-20},{-20,20}}, rotation = 90)));
  equation
    phi = flange_a.phi - phi_support;
    flange_b.phi = flange_a.phi;
    w = der(phi);
    a = der(w);
    w_relfric = w;
    a_relfric = a;
    flange_a.tau + flange_b.tau - tau = 0;
    fn = fn_max * f_normalized;
    tau0 = mue0 * cgeo * fn;
    tau0_max = peak * tau0;
    free = fn <= 0;
    tau = if locked then sa * unitTorque else if free then 0 else cgeo * fn * (if startForward then mue0 else if startBackward then -mue0 else if pre(mode) == ModeType.Forward then mue0 else -mue0);
  end BrakeModel;

  model Test1
    BrakeModel brake1(fn_max = 0.25, mue0 = 0.5, peak = 2, sa.start = 0, sa.fixed = true, w.start = 0) annotation(Placement(visible = true, transformation(origin = {1.52672,44.8855}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(visible = true, transformation(origin = {-32.9771,44.5802}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Blocks.Sources.Ramp ramp1(duration = 1) annotation(Placement(visible = true, transformation(origin = {-77.5573,45.1908}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation(Placement(visible = true, transformation(origin = {-32.0611,83.0534}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1 annotation(Placement(visible = true, transformation(origin = {47.6336,44.8855}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    annotation(experiment(StartTime = 0.0, StopTime = 1.0, Tolerance = 1e-006));
  equation
    connect(brake1.flange_b,inertia1.flange_a) annotation(Line(points = {{13.5267,44.8855},{39.084,44.8855},{39.084,44.8855},{35.6336,44.8855}}));
    connect(const.y,brake1.f_normalized) annotation(Line(points = {{-18.8611,83.0534},{1.52672,83.0534},{1.52672,58.0855},{1.52672,58.0855}}));
    connect(ramp1.y,torque1.tau) annotation(Line(points = {{-64.3573,45.1908},{-48.855,45.1908},{-48.855,44.5802},{-47.3771,44.5802}}));
    connect(torque1.flange,brake1.flange_a) annotation(Line(points = {{-20.9771,44.5802},{-10.9924,44.5802},{-10.9924,44.8855},{-10.4733,44.8855}}));
  end Test1;

end Simple_Brake_Tests;

