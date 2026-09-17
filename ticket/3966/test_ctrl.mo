model test_ctrl
  Table_online_change_test table_online_change_test1 annotation(Placement(visible = true, transformation(origin = {-26, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, -1; 0.5, 1.5; 3, 6]) annotation(Placement(visible = true, transformation(origin = {-96, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 1.5)  annotation(Placement(visible = true, transformation(origin = {-140, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 2, freqHz = 5)  annotation(Placement(visible = true, transformation(origin = {-96, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 3.2)  annotation(Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.5)  annotation(Placement(visible = true, transformation(origin = {-128, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(timeTable1.y, table_online_change_test1.u) annotation(Line(points = {{-84, 28}, {-68, 28}, {-68, 8}, {-38, 8}, {-38, 8}}, color = {0, 0, 127}));
  annotation(uses(Modelica(version = "3.2.1")), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end test_ctrl;