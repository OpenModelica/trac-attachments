package  TestPackage
  model Test
    Modelica.Blocks.Sources.Step step annotation(
      Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MyModel myModel annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(myModel.u, step.y) annotation(
      Line(points = {{10, 0}, {-26, 0}}, color = {0, 0, 127}));
  end Test;
equation

annotation(
    uses(Modelica(version = "3.2.3")));
end TestPackage;
