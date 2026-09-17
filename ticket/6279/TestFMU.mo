model TestFMU 
  parameter Real K = 1;
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = K / 2) annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Gain gain(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
connect(gain1.u, u) annotation(
    Line(points = {{-72, 0}, {-120, 0}}, color = {0, 0, 127}));
connect(gain1.y, gain.u) annotation(
    Line(points = {{-49, 0}, {30, 0}}, color = {0, 0, 127}));
connect(gain.y, y) annotation(
    Line(points = {{54, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {51.5765, 0},lineColor = {0, 0, 255}, extent = {{-147.576, 142}, {48.4235, 116}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}),
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end TestFMU;
