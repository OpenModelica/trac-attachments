within Project1;
model FrontSuspension "Front suspension"
  extends VDLMotorsports.Chassis.Suspensions.Templates.DWPS(
    redeclare SuspensionMechanism leftLinkage,
    redeclare SuspensionMechanism rightLinkage,
    redeclare SpringDamperARB_4
                              rockerArrangement(fAntiRoll_1=geometry.fAntiRoll_1,
      r0CS_1=geometry.r0CS_1,
      r0RS_1=geometry.r0RS_1,
      r0CD_1=geometry.r0CD_1,
      r0RD_1=geometry.r0RD_1,
      r0CS_2=geometry.r0CS_2,
      r0RS_2=geometry.r0RS_2,
      r0CD_2=geometry.r0CD_2,
      r0RD_2=geometry.r0RD_2,
      r0LP_1=geometry.r0LP_1,
      r0ARB_1=geometry.r0ARB_1,
      r0RP_2=geometry.r0RP_2,
      r0LP_2=geometry.r0LP_2,
      r0ARB_2=geometry.r0ARB_2,
      r0RP_1=geometry.r0RP_1,
      manualBranchSelection=geometry.antiroll),
    redeclare VDLMotorsports.Chassis.Suspensions.Steering.SimpleRack steering(
      iPR=geometry.iPR,
      r0QZ=geometry.r0QZ,
      r0Q=geometry.r0Q),
    redeclare Modelon.Mechanics.Rotational.None leftTorsionBar,
    redeclare Modelon.Mechanics.Rotational.None rightTorsionBar,
    redeclare replaceable F1_2009 geometry(nAdjust_2_1={0,-1,0})
                                           constrainedby Project1.F1_2009);

  Modelon.Mechanics.Translational.LinearSpring linearSpring(c=100000)
    annotation (Placement(transformation(extent={{-48,56},{-28,76}})));
  Modelon.Mechanics.Translational.LinearSpring linearSpring1(c=100000)
    annotation (Placement(transformation(extent={{-40,-74},{-20,-54}})));
  Modelon.Mechanics.Translational.LinearDamper linearDamper(d=10000)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-58,18})));
  Modelon.Mechanics.Translational.LinearDamper linearDamper1(d=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,-18})));
  Modelon.Mechanics.Rotational.LinearSpring linearSpring2(c=1000) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,0})));
equation
  connect(linearDamper1.flange_a, rockerArrangement.bearing1) annotation (Line(
      points={{-58,-28},{-42,-28},{-42,-10.1333},{-26,-10.1333}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearDamper1.flange_b, rockerArrangement.axis1) annotation (Line(
      points={{-58,-8},{-42,-8},{-42,-6.13333},{-26,-6.13333}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearDamper.flange_b, rockerArrangement.axis3) annotation (Line(
      points={{-58,8},{-42,8},{-42,6.66667},{-26,6.66667}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearDamper.flange_a, rockerArrangement.bearing3) annotation (Line(
      points={{-58,28},{-42,28},{-42,10.4},{-26,10.4}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearSpring.flange_a, rockerArrangement.bearing4) annotation (Line(
      points={{-48,66},{-36,66},{-36,20},{-21.84,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearSpring.flange_b, rockerArrangement.axis4) annotation (Line(
      points={{-28,66},{-20,66},{-20,28},{-16.9,28},{-16.9,20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearSpring2.flange_b, rockerArrangement.axis5) annotation (Line(
      points={{18,10},{10,10},{10,-3.2},{0,-3.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(linearSpring2.flange_a, rockerArrangement.bearing5) annotation (Line(
      points={{18,-10},{10,-10},{10,-9.6},{0,-9.6}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(linearSpring1.flange_a, rockerArrangement.bearing2) annotation (Line(
      points={{-40,-64},{-32,-64},{-32,-20},{-21.32,-20}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(linearSpring1.flange_b, rockerArrangement.axis2) annotation (Line(
      points={{-20,-64},{-18,-64},{-18,-30},{-16.38,-30},{-16.38,-20}},
      color={0,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{100,140}}), graphics));
end FrontSuspension;
