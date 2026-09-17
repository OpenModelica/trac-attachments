package Test
  model Test1
  Modelica.Blocks.Sources.Step step annotation(
      Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MyFirstOrder myFirstOrder annotation(
      Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(myFirstOrder.u, step.y) annotation(
      Line(points = {{4, 0}, {-22, 0}, {-22, 0}, {-22, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -90}, {100, 80}})));end Test1;

  model MyFirstOrder
  Modelica.Blocks.Continuous.FirstOrder firstOrder annotation(
      Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-106, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-106, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(firstOrder.u, u) annotation(
      Line(points = {{-10, 0}, {-94, 0}, {-94, 0}, {-106, 0}}, color = {0, 0, 127}));
  connect(y, firstOrder.y) annotation(
      Line(points = {{106, 0}, {14, 0}, {14, 0}, {14, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -90}, {100, 80}})));
  end MyFirstOrder;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -90}, {100, 80}})),
    uses(Modelica(version = "3.2.3")));
end Test;
