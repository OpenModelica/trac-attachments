within Project1;
model SpringDamperARB_4
  "Rocker arrangement w spring damper per side and anti roll bar4"
  extends
    VDLMotorsports.Chassis.Suspensions.Linkages.Templates.RockerArrangement;

import SI = Modelica.SIunits;
parameter SI.Position r0CS_1[3] = {0.3, 0.08, 0.13}
    "Position of the left spring end connected to the chassis resolved in vehicleFrame"
annotation(Dialog(tab=Geometry));
parameter SI.Position r0RS_1[3] = {0.06, 0.04, 0.13}
    "Position of the left spring end connected to the rocker resolved in vehicleFrame"
annotation(Dialog(tab="Geometry"));

parameter SI.Position r0CD_1[3] = {0.3, 0.08, 0.13}
    "Position of the left damper end connected to the chassis resolved in vehicleFrame"
annotation(Dialog(tab=Geometry));
parameter SI.Position r0RD_1[3] = {0.06, 0.04, 0.13}
    "Position of the left damper end connected to the rocker resolved in vehicleFrame"
annotation(Dialog(tab="Geometry"));

parameter SI.Position r0CS_2[3] = {0.3, 0.08, 0.13}
    "Position of the right spring end connected to the chassis resolved in vehicleFrame"
annotation(Dialog(tab=Geometry));
parameter SI.Position r0RS_2[3] = {0.06, 0.04, 0.13}
    "Position of the right spring end connected to the rocker resolved in vehicleFrame"
annotation(Dialog(tab="Geometry"));

parameter SI.Position r0CD_2[3] = {0.3, 0.08, 0.13}
    "Position of the right damper end connected to the chassis resolved in vehicleFrame"
annotation(Dialog(tab=Geometry));
parameter SI.Position r0RD_2[3] = {0.06, 0.04, 0.13}
    "Position of the right damper end connected to the rocker resolved in vehicleFrame"
annotation(Dialog(tab="Geometry"));

protected
  parameter SI.Position r0CS_1_scaled[3] = r0CS_1 .* scale_factor + offset;
  parameter SI.Position r0RS_1_scaled[3] = r0RS_1 .* scale_factor + offset;

  parameter SI.Position r0CD_1_scaled[3] = r0CD_1 .* scale_factor + offset;
  parameter SI.Position r0RD_1_scaled[3] = r0RD_1 .* scale_factor + offset;

  parameter SI.Position r0CS_2_scaled[3] = r0CS_2 .* scale_factor + offset;
  parameter SI.Position r0RS_2_scaled[3] = r0RS_2 .* scale_factor + offset;

  parameter SI.Position r0CD_2_scaled[3] = r0CD_2 .* scale_factor + offset;
  parameter SI.Position r0RD_2_scaled[3] = r0RD_2 .* scale_factor + offset;
  VehicleDynamics.Vehicles.Chassis.Suspensions.Linkages.Struts.UnconstrainedTranslational
    leftSpring(
    r0J1=r0CS_1_scaled,
    r0J2=r0RS_1_scaled,
    r0B=r0CR_1_scaled)
               annotation (Placement(transformation(
        extent={{-10,4},{10,-4}},
        rotation=-90,
        origin={-100,50})));
  VehicleDynamics.Vehicles.Chassis.Suspensions.Linkages.Struts.UnconstrainedTranslational
    leftDamper(
    r0J1=r0CD_1_scaled,
    r0J2=r0RD_1_scaled,
    r0B=r0CR_1_scaled)
               annotation (Placement(transformation(
        extent={{-10,-4},{10,4}},
        rotation=-90,
        origin={-80,50})));
  VehicleDynamics.Vehicles.Chassis.Suspensions.Linkages.Struts.UnconstrainedTranslational
    rightDamper(
    r0B=r0CR_2_scaled,
    r0J1=r0CD_2_scaled,
    r0J2=r0RD_2_scaled)
                annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=90,
        origin={80,50})));
  VehicleDynamics.Vehicles.Chassis.Suspensions.Linkages.Struts.UnconstrainedTranslational
    rightSpring(
    r0B=r0CR_2_scaled,
    r0J1=r0CS_2_scaled,
    r0J2=r0RS_2_scaled,
    lineForce(m=1))
                annotation (Placement(transformation(
        extent={{-10,-4},{10,4}},
        rotation=-90,
        origin={100,50})));
  VDLMotorsports.Chassis.Suspensions.Linkages.Mechanisms.AntiRoll1 antiRoll(
    r0CR_1=r0CR_1_scaled,
    r0RP_1=r0RP_1 .* scale_factor + offset,
    r0LP_1=r0LP_1 .* scale_factor + offset,
    r0ARB_1=r0ARB_1 .* scale_factor + offset,
    r0CR_2=r0CR_2_scaled,
    r0RP_2=r0RP_2 .* scale_factor + offset,
    r0LP_2=r0LP_2 .* scale_factor + offset,
    r0ARB_2=r0ARB_2 .* scale_factor + offset,
    fAntiRoll_1=fAntiRoll_1,
    manualOverride=manualOverride,
    manualBranchSelection=manualBranchSelection)
    annotation (Placement(transformation(extent={{-10,-48},{10,-68}})));
public
  parameter SI.Position r0RP_1[3]={0,0.3,0.3}
    "Position of left pivot point on rocker resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Position r0LP_1[3]={0,0.3,0.3}
    "Position of left lever pivot point resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Position r0ARB_1[3]={0,0.3,0.3}
    "Position of left end of anti-roll bar resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Position r0RP_2[3]=antiRoll.r0RP_1 .* {1,-1,1}
    "Position of right pivot point on rocker resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Position r0LP_2[3]=antiRoll.r0LP_1 .* {1,-1,1}
    "Position of right lever pivot point resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Position r0ARB_2[3]=antiRoll.r0ARB_1 .* {1,-1,1}
    "Position of right end of anti-roll bar resolved in vehicleFrame"
    annotation (Dialog(tab="Geometry"));
  parameter SI.Force fAntiRoll_1=0
    "Initial estimate of the force in the left anti-roll bar arm"
    annotation (Dialog(tab="Initialization"));
  Modelon.Mechanics.Translational.Interfaces.FlangeU axis2
    annotation (Placement(transformation(extent={{-160,16},{-140,36}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeC bearing2
    annotation (Placement(transformation(extent={{-160,54},{-140,74}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeC bearing1
    annotation (Placement(transformation(extent={{-86,90},{-66,110}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeU axis1
    annotation (Placement(transformation(extent={{-56,90},{-36,110}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeU axis3
    annotation (Placement(transformation(extent={{40,90},{60,110}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeC bearing3
    annotation (Placement(transformation(extent={{68,90},{88,110}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeC bearing4
    annotation (Placement(transformation(extent={{140,58},{160,78}})));
  Modelon.Mechanics.Translational.Interfaces.FlangeU axis4
    annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Modelon.Mechanics.Rotational.Interfaces.FlangeU axis5
    annotation (Placement(transformation(extent={{-34,-110},{-14,-90}})));
  Modelon.Mechanics.Rotational.Interfaces.FlangeC bearing5
    annotation (Placement(transformation(extent={{-82,-110},{-62,-90}})));
  parameter Boolean manualBranchSelection=false
    "Select positive (true) or negative (false) solution branch for inital angle of revolute in the anti-roll bar arms"
    annotation (Dialog(tab="Solution Selection"));
  parameter SI.Mass m=0
    "Mass of point mass on the connetion line between the origin of frame_a and the origin of frame_b"
    annotation (Dialog(tab="Geometry"));
equation
  connect(leftSpring.frame_a, vehicleFrame) annotation (Line(
      points={{-100,60},{-100,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftDamper.frame_a, vehicleFrame) annotation (Line(
      points={{-80,60},{-80,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(rightDamper.frame_a, vehicleFrame) annotation (Line(
      points={{80,60},{80,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(rightSpring.frame_a, vehicleFrame) annotation (Line(
      points={{100,60},{100,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftRockerFrame, antiRoll.leftRockerFrame) annotation (Line(
      points={{-150,-60},{-80,-60},{-80,-64},{-10,-64}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftSpring.frame_b, antiRoll.leftRockerFrame) annotation (Line(
      points={{-100,40},{-100,-60},{-80,-60},{-80,-64},{-10,-64}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftDamper.frame_b, antiRoll.leftRockerFrame) annotation (Line(
      points={{-80,40},{-80,-64},{-10,-64}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(antiRoll.rightRockerFrame, rightRockerFrame) annotation (Line(
      points={{10,-64},{80,-64},{80,-60},{150,-60}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(antiRoll.vehicleFrame, vehicleFrame) annotation (Line(
      points={{0,-48},{0,100}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(leftSpring.axis, axis2) annotation (Line(
      points={{-104,47},{-150,47},{-150,26}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(leftSpring.bearing, bearing2) annotation (Line(
      points={{-104,53},{-128,53},{-128,56},{-150,56},{-150,64}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(leftDamper.bearing, bearing1) annotation (Line(
      points={{-76,53},{-70,53},{-70,100},{-76,100}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(leftDamper.axis, axis1) annotation (Line(
      points={{-76,47},{-52,47},{-52,100},{-46,100}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(rightDamper.axis, axis3) annotation (Line(
      points={{76,47},{42,47},{42,100},{50,100}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(rightDamper.bearing, bearing3) annotation (Line(
      points={{76,53},{74,53},{74,54},{72,54},{72,100},{78,100}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(rightSpring.bearing, bearing4) annotation (Line(
      points={{104,53},{150,53},{150,68}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(rightSpring.axis, axis4) annotation (Line(
      points={{104,47},{150,47},{150,30}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(antiRoll.axis2, axis5) annotation (Line(
      points={{-10,-58},{-20,-58},{-20,-100},{-24,-100}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(antiRoll.bearing2, bearing5) annotation (Line(
      points={{-10,-50},{-34,-50},{-34,-52},{-58,-52},{-58,-100},{-72,-100}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{150,100}}), graphics));
end SpringDamperARB_4;
