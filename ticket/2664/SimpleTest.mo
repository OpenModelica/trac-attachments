model SimpleTest "just a simple model - Compilation etc."
  Modelica.Blocks.Interfaces.IntegerInput u annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerOutput y annotation(Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
algorithm
  when change(u) then
    y := y + 2;
  end when;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-6.15, 2.93}, fillColor = {0, 133, 199}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-77.89, 83.75}, {88.14, -92.53}})}));
end SimpleTest;