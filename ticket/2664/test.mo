model test
  Modelica.Blocks.Sources.IntegerTable integertable1(table = [0, 1; 0.2, 2; 0.4, 3; 0.6, 4; 0.8, 5; 1, 6]) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleTest_me_FMU simpletest_me_fmu1 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(integertable1.y, simpletest_me_fmu1.u) annotation(Line(points = {{-69, 40}, {-12.0069, 40}, {-12.0069, 26.7581}, {-12.0069, 26.7581}}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end test;