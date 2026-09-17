model trial
  unicycle unicycle1 annotation(
    Placement(visible = true, transformation(origin = {6, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-50, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-50, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const1.y, unicycle1.angular_vel) annotation(
    Line(points = {{-38, -32}, {-4, -32}, {-4, 8}, {-4, 8}}, color = {0, 0, 127}));
  connect(const.y, unicycle1.linear_vel) annotation(
    Line(points = {{-38, 14}, {-6, 14}, {-6, 16}, {-4, 16}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.2")));
end trial;