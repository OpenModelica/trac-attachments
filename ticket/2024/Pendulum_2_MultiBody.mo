within ;
model Pendulum_2_MultiBody
  constant Integer N = 2 "Number of individual elements";
  inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false);
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N];
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder[N](each r={1,0,0});
equation
  connect(world.frame_b, revolute[1].frame_a);
  connect(revolute[1].frame_b, bodyCylinder[1].frame_a);
  connect(revolute[2].frame_b, bodyCylinder[2].frame_a);
  connect(bodyCylinder[1].frame_b, revolute[2].frame_a);
  annotation (uses(Modelica(version="3.2")));  
end Pendulum_2_MultiBody;
