model pendel1
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1 annotation(Placement(visible = true, transformation(origin = {-30.1994,54.1311}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-06));
  inner Modelica.Mechanics.MultiBody.World world1 annotation(Placement(visible = true, transformation(origin = {-71.2251,54.1311}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.Body body1(r_CM = {1,0,0}, m = 1) annotation(Placement(visible = true, transformation(origin = {13.9601,53.2764}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(revolute1.frame_a,world1.frame_b) annotation(Line(points = {{-42.1994,54.1311},{-58.9744,54.1311},{-58.9744,54.1311},{-59.2251,54.1311}}));
  connect(revolute1.frame_b,body1.frame_a) annotation(Line(points = {{-18.1994,54.1311},{2.2792,54.1311},{2.2792,53.2764},{1.96007,53.2764}}));
end pendel1;

