within ;
model MotorDriveTest2

  annotation (uses(Modelica(version="3.0.1")), Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.5)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=10)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Mechanics.Rotational.Components.Spring spring(c=100)
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1)
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(stepTorque=1,
      offsetTorque=0)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
equation
  connect(inertia.flange_b, damper.flange_a) annotation (Line(
      points={{62,0},{66,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spring.flange_b, inertia.flange_a) annotation (Line(
      points={{26,0},{42,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inertia1.flange_b, spring.flange_a) annotation (Line(
      points={{-6,0},{6,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(torqueStep.flange, inertia1.flange_a) annotation (Line(
      points={{-36,0},{-26,0}},
      color={0,0,0},
      smooth=Smooth.None));
end MotorDriveTest2;
