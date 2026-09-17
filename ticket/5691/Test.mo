package Test
  model M1
    Modelica.Blocks.Continuous.FirstOrder firstOrder annotation(
      Placement(visible = true, transformation(origin = {38, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression annotation(
      Placement(visible = true, transformation(origin = {-42, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation 
        
    connect(realExpression.y, firstOrder.u) annotation(
      Line(points = {{-31, 20}, {26, 20}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 0}, extent = {{-79, 80}, {79, -80}}, textString = "M1")}),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
  end M1;

  model M2
  Modelica.Blocks.Continuous.Derivative derivative annotation(
      Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression annotation(
      Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  M1 m1 annotation(
      Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(realExpression.y, derivative.u) annotation(
      Line(points = {{-18, -30}, {36, -30}, {36, -30}, {38, -30}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
  end M2;
  annotation(
    uses(Modelica(version = "3.2.3")));
end Test;