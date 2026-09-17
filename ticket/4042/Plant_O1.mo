block Plant_O1 "Plant with first order linear dynamics and an offset"
  extends Modelica.Blocks.Icons.Block;
  parameter Real k(unit = "1") "Gain";
  parameter SIunits.Time T(start=1) "Time Constant";
  parameter Real y00(unit = "1") "offset";
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = T, k = k) annotation(Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(Placement(visible = true, transformation(origin = {34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant y0(k = y0) annotation(Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(firstOrder.u, u) annotation(Line(points = {{-42, 0}, {-102, 0}, {-102, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(add.u1, firstOrder.y) annotation(Line(points = {{22, 6}, {0, 6}, {0, 0}, {-19, 0}}, color = {0, 0, 127}));
  connect(y, add.y) annotation(Line(points = {{110, 0}, {44, 0}, {44, 0}, {46, 0}}, color = {0, 0, 127}));
  connect(y0.y, add.u2) annotation(Line(points = {{-18, -40}, {0, -40}, {0, -6}, {22, -6}, {22, -6}}, color = {0, 0, 127}));
  annotation(Icon(graphics = {Text(origin = {-3, 32}, extent = {{-37, 28}, {43, -12}}, textString = "Plant", fontName = "DejaVu Sans Mono"), Text(origin = {-2, -32}, extent = {{-78, 12}, {82, -14}}, textString = "first order with offset", fontName = "DejaVu Sans Mono")}), uses(Modelica(version = "3.2.1")));end Plant_O1;