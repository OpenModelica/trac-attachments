model aaa
  SEBLib.SimpleDriver driver(CycleFileName = "Sort1.txt", k = 1, T = 1) annotation(Placement(visible = true, transformation(origin = {-22.0065,-1.94175}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(Placement(visible = true, transformation(origin = {-50.4854,-51.1327}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(const.y,driver.V) annotation(Line(points = {{-37.2854,-51.1327},{-22.0065,-51.1327},{-22.0065,-15.6217},{-22.0065,-15.6217}}));
end aaa;

