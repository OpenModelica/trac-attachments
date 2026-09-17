model test
  Modelica.Blocks.Continuous.FirstOrder firstOrder1 annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1 annotation(
    Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
equation
  connect(step1.y, firstOrder1.u) annotation(
    Line(points = {{-58, 10}, {-20, 10}, {-20, 10}, {-22, 10}}, color = {0, 0, 127}));

annotation(
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    uses(Modelica(version = "3.2.3")));
    
end test;