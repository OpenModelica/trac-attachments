package Test
  model M1
  Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    annotation(
      Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 2}, extent = {{-42, 40}, {42, -40}}, textString = "M1")}));
  end M1;

  model M2
    Test.M1 m1 annotation(
        Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Test.M1 m2 annotation(
        Placement(visible = true, transformation(origin = {32, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  end M2;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    uses(Modelica(version = "3.2.3")));
end Test;