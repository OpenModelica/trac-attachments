model units
  Modelica.Blocks.Sources.Constant const annotation(
    Placement(visible = true, transformation(extent = {{-90, 18}, {-70, 38}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(extent = {{-14, 18}, {6, 38}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1 annotation(
    Placement(visible = true, transformation(origin = {-4, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh annotation(
    Placement(visible = true, transformation(extent = {{-48, 18}, {-28, 38}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh1 annotation(
    Placement(visible = true, transformation(origin = {-4, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(feedback.u1, from_kmh.y) annotation(
    Line(points = {{-12, 26}, {-19.5, 26}, {-19.5, 28}, {-27, 28}}, color = {0, 0, 127}));
  connect(feedback.u2, from_kmh1.y) annotation(
    Line(points = {{-4, 18}, {-4, 16}}, color = {0, 0, 127}));
  connect(const.y, from_kmh.u) annotation(
    Line(points = {{-69, 28}, {-59.5, 28}, {-59.5, 26}, {-50, 26}}, color = {0, 0, 127}));
  connect(from_kmh1.u, const1.y) annotation(
    Line(points = {{-4, -8}, {-4, -8}, {-4, -14}, {-4, -14}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}})),
    uses(Modelica(version = "3.2.2")),
    version = "",
    __OpenModelica_commandLineOptions = "");
end units;
