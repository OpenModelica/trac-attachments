model LinTabNEW
  input Real dx(start = 0.0);
  output Real dy;
  parameter Real x0 = 2;
  parameter Modelica.Blocks.Types.Smoothness Smooth = Modelica.Blocks.Types.Smoothness.LinearSegments;
  Modelica.Blocks.Tables.CombiTable2D TAB(table = [
  0, 1, 2, 3, 4; 
  1, 2, 3, 4, 5; 
  2, 3, 4, 5, 6; 
  3, 4, 5, 6, 7; 
  4, 5, 6, 7, 8; 
  5, 6, 7, 8, 9], smoothness = Smooth, tableOnFile = false) annotation(Placement(visible = true, transformation(origin = {-14, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 2.0) annotation(Placement(visible = true, transformation(origin = {-66, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = x0 + dx) annotation(Placement(visible = true, transformation(origin = {-68, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder PT1(T = 0.1, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(Placement(visible = true, transformation(origin = {22, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(realExpression2.y, TAB.u1) annotation(Line(points = {{-56, 82}, {-46, 82}, {-46, 70}, {-26, 70}, {-26, 70}}, color = {0, 0, 127}));
  connect(TAB.u2, realExpression1.y) annotation(Line(points = {{-26, 58}, {-40, 58}, {-40, 52}, {-54, 52}, {-54, 52}}, color = {0, 0, 127}));
  connect(TAB.y, PT1.u) annotation(Line(points = {{-3, 64}, {10, 64}}, color = {0, 0, 127}));
  dy = PT1.y;
  annotation(Icon(coordinateSystem(extent = {{-100, 0}, {100, 100}})), Diagram(coordinateSystem(extent = {{-100, 0}, {100, 100}}, initialScale = 0.1), graphics = {Text(origin = {52, 63}, extent = {{-8, 9}, {8, -9}}, textString = "dy")}));
end LinTabNEW;