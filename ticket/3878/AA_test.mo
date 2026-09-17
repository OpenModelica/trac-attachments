model AA_test
  model thin_lines
    annotation(Icon(graphics = {Line(origin = {-18.8449, 9.8819}, points = {{-61.1551, -49.8819}, {78.8449, 70.1181}, {58.8449, -89.8819}, {-61.1551, -49.8819}}), Ellipse(origin = {-1, -13}, extent = {{-19, -27}, {21, 33}}, endAngle = 360), Text(origin = {-2, 113}, extent = {{-98, 27}, {102, -13}}, textString = "%name%")}));
  end thin_lines;

  model thick_lines
    annotation(Icon(graphics = {Line(origin = {-18.84, 9.88}, points = {{-61.1551, -49.8819}, {78.8449, 70.1181}, {58.8449, -89.8819}, {-61.1551, -49.8819}}, thickness = 1), Ellipse(origin = {-1, -13}, lineThickness = 1, extent = {{-19, -27}, {21, 33}}, endAngle = 360), Text(origin = {-2, 113}, extent = {{-98, 27}, {102, -13}}, textString = "%name%")}, coordinateSystem(initialScale = 0.1)));
  end thick_lines;

  thin_lines thin_lines1 annotation(Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  thick_lines thick_lines1 annotation(Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
end AA_test;