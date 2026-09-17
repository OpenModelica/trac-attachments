model scratch
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(visible = true, transformation(origin = {-324, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  frame_model_pack.control_frame control_frame annotation(
    Placement(visible = true, transformation(origin = {-216, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(world.frame_b, control_frame.TOU_conn) annotation(
    Line(points = {{-314, 28}, {-218, 28}, {-218, 14}, {-216, 14}}, color = {95, 95, 95}));
  annotation(
    Icon(coordinateSystem(extent = {{-500, -100}, {500, 100}})),
    Diagram(coordinateSystem(extent = {{-500, -100}, {500, 100}})),
    uses(Modelica(version = "3.2.3")));
end scratch;