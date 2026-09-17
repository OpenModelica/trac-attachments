model Test
  Modelica.Blocks.Continuous.Integrator integrator1(y_start = 1) annotation(Placement(visible = true, transformation(origin = {-42, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = -1) annotation(Placement(visible = true, transformation(origin = {0, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain1.y, integrator1.u) annotation(Line(points = {{11, 48}, {22, 48}, {22, 72}, {-64, 72}, {-64, 48}, {-54, 48}, {-54, 48}}, color = {0, 0, 127}));
  connect(integrator1.y, gain1.u) annotation(Line(points = {{-31, 48}, {-12, 48}}, color = {0, 0, 127}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Test;