within ;
model issue_B
parameter Real position_start = 0.0;
parameter Real speed_start = 0.0;
  PlanarMechanics.Parts.Fixed fixed annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-20})));
  PlanarMechanics.Parts.Body body1(
    I=0,
    a(start={1,0}),
    m=5) annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  inner PlanarMechanics.PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  PlanarMechanics.Joints.Prismatic prismatic(
    r={1,0},
    useFlange=true,
    s(fixed=true, start=position_start),
    v(fixed=true, start=speed_start))
    annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput position
    annotation (Placement(transformation(extent={{60,10},{80,30}}),
        iconTransformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Interfaces.RealOutput speed
    annotation (Placement(transformation(extent={{60,-10},{80,10}}),
        iconTransformation(extent={{60,-10},{80,10}})));
  Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Translational.Components.Damper damper1D(d=1)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
equation

  connect(fixed.frame, prismatic.frame_a) annotation (Line(
      points={{-60,-20},{-50,-20},{-40,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, body1.frame_a) annotation (Line(
      points={{-20,-20},{-10,-20},{0,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.flange_a, positionSensor.flange) annotation (Line(points={{-30,-10},
          {-14,-10},{-14,20},{20,20}},        color={0,127,0}));
  connect(speedSensor1.flange, prismatic.flange_a)
    annotation (Line(points={{20,0},{-14,0},{-14,-10},{-30,-10}},
                                                         color={0,127,0}));
  connect(position, positionSensor.s)
    annotation (Line(points={{70,20},{41,20}},         color={0,0,127}));
  connect(speedSensor1.v, speed)
    annotation (Line(points={{41,0},{41,0},{70,0}},    color={0,0,127}));
  connect(damper1D.flange_b, prismatic.flange_a) annotation (Line(points={{-20,20},
          {-14,20},{-14,-10},{-30,-10}},   color={0,127,0}));
  connect(damper1D.flange_a, prismatic.support) annotation (Line(points={{-40,20},
          {-44,20},{-44,-10},{-36,-10}},   color={0,127,0}));
  annotation (experiment(StopTime=10), uses(Modelica(version="3.2.2"), PlanarMechanics(version="1.4.0")),
    Diagram(coordinateSystem(extent={{-100,-40},{100,40}})),
    Icon(coordinateSystem(extent={{-100,-40},{100,40}})));
end issue_B;
