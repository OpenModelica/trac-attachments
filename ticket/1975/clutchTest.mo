model clutchTest

  Modelica.Mechanics.Rotational.Components.OneWayClutch oneWayClutch(
    phi_rel(fixed=true, start=0),
    w_rel(fixed=true, start=0),
    fn_max=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-48,36},{-28,56}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Modelica.Blocks.Sources.Constant const1(k=10)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
equation
  connect(const.y, oneWayClutch.f_normalized) annotation (Line(
      points={{-27,46},{-14,46},{-14,42},{0,42},{0,11}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(torque.flange, oneWayClutch.flange_a) annotation (Line(
      points={{-36,0},{-10,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(oneWayClutch.flange_b, inertia.flange_a) annotation (Line(
      points={{10,0},{44,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(const1.y, torque.tau) annotation (Line(
      points={{-73,0},{-58,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end clutchTest;
