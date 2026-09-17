model unicycle
  Modelica.Blocks.Interfaces.RealInput linear_vel annotation(
    Placement(visible = true, transformation(origin = {-100, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput angular_vel annotation(
    Placement(visible = true, transformation(origin = {-100, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput x annotation(
    Placement(visible = true, transformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput theta annotation(
    Placement(visible = true, transformation(origin = {110, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    uses(Modelica(version = "3.2.2")));
    equation
    der(x)= linear_vel * cos(theta);
    der(y)= linear_vel * sin(theta);
    der(theta)= angular_vel;
end unicycle;