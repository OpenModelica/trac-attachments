within ;
model Pendulum_N
  extends Modelica.Icons.Example;
  constant Integer N = 2 "Number of individual elements";
  parameter Real L = 1 "Total length";
  parameter Real d = 0.05 "Diameter";
  parameter Real D = 0.01/L "damping";

  inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false)
    annotation (Placement(transformation(extent={{-46,6},{-26,26}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N](each useAxisFlange=true, phi(start=cat(1,{-0.3}, zeros(N-1)), each fixed=true), w(each start=0, each fixed=true))
    annotation (Placement(transformation(extent={{-6,6},{14,26}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder[N](each r={L/N,0,0},
      each diameter=d)
    annotation (Placement(transformation(extent={{34,6},{54,26}})));
  Modelica.Mechanics.Rotational.Components.Damper damper[N](each d=D)
    annotation (Placement(transformation(extent={{-10,40},{12,60}})));
equation
  connect(world.frame_b, revolute[1].frame_a) annotation (Line(
      points={{-26,16},{-6,16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
      points={{14,16},{34,16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bodyCylinder[1:N-1].frame_b, revolute[2:N].frame_a) annotation (Line(
      points={{54,16},{64,16},{64,-8},{-16,-8},{-16,16},{-6,16}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(damper.flange_a, revolute.support) annotation (Line(
      points={{-10,50},{-10,36},{-2,36},{-2,26}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(damper.flange_b, revolute.axis) annotation (Line(
      points={{12,50},{12,36},{4,36},{4,26}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                      graphics), Icon(coordinateSystem(extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=10),
    uses(Modelica(version="3.2")));
end Pendulum_N;
