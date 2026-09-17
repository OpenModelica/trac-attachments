model Test
  Modelica.Blocks.Sources.Constant const(k = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {-22, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D1(fileName = "Test.txt",table = [0, 0, 1; 0, 1, 1; 1, 1, 1], tableName = "Table")  annotation(
    Placement(visible = true, transformation(origin = {26, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-22, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, combiTable2D1.u1) annotation(
    Line(points = {{-10, 16}, {-2, 16}, {-2, 4}, {14, 4}, {14, 4}, {14, 4}}, color = {0, 0, 127}));
  connect(const1.y, combiTable2D1.u2) annotation(
    Line(points = {{-10, -22}, {-2, -22}, {-2, -8}, {14, -8}, {14, -8}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-60, -40}, {60, 40}})),
    uses(Modelica(version = "3.2.3")),
  version = "");end Test;
