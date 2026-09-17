package Test2
  model LowpassFilter1
    Modelica.Blocks.Continuous.FirstOrder firstorder1(T = 1) annotation(Placement(visible = true, transformation(origin = {6.90476, 2.89474}, extent = {{-13.8972, -13.8972}, {13.8972, 13.8972}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(offset = 0, startTime = 1) annotation(Placement(visible = true, transformation(origin = {-40.8521, 2.50627}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(step1.y, firstorder1.u) annotation(Line(points = {{-29.8521, 2.50627}, {-10.0251, 2.50627}, {-10.0251, 2.50627}, {-10.0251, 2.50627}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end LowpassFilter1;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Test2;