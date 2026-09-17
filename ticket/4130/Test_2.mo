model Test_2
  Modelica.Blocks.Interfaces.RealOutput Out_boucle annotation(Placement(visible = true, transformation(origin = {112, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput In_real annotation(Placement(visible = true, transformation(origin = {-88, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-74, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = 1) annotation(Placement(visible = true, transformation(origin = {44, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation(Placement(visible = true, transformation(origin = {-8, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 10)  annotation(Placement(visible = true, transformation(origin = {-84, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, add1.u1) annotation(Line(points = {{-72, -32}, {-58, -32}, {-58, -4}, {-20, -4}}, color = {0, 0, 127}));
  connect(Out_boucle, add1.u2) annotation(Line(points = {{112, -10}, {79, -10}, {79, -32}, {-29.5, -32}, {-29.5, -18}, {-3.75, -18}, {-3.75, -16}, {-20, -16}}, color = {0, 0, 127}));
  connect(gain2.y, Out_boucle) annotation(Line(points = {{55, -10}, {112, -10}}, color = {0, 0, 127}));
  connect(add1.y, gain2.u) annotation(Line(points = {{4, -10}, {32, -10}}, color = {0, 0, 127}));
  annotation(uses(Modelica(version = "3.2.1")));
end Test_2;