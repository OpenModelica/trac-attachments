within ;
model RealInput_Failure

  inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Mechanics.MultiBody.Forces.WorldForce force annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,30})));
  Real f[3] = {1,2,3};
equation
  connect(force.frame_b, world.frame_b) annotation (Line(
      points={{-60,30},{-80,30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
algorithm
force.force := f;
end RealInput_Failure;
