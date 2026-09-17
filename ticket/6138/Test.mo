package Test
  model M1
  Modelica.Blocks.Sources.RealExpression realExpression(y = 123)  annotation(
      Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
  end M1;

  model M2
    extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.RealExpression realExpression annotation(
      Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
  end M2;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    uses(Modelica(version = "3.2.3")));
end Test;