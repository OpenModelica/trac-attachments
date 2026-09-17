package TestPrimitiveVisible1
  model M1
    annotation(
      Icon(graphics = {Text(origin = {-2, -3}, extent = {{-98, 103}, {102, 3}}, textString = "M1"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -121}, lineColor = {0, 0, 255}, extent = {{-100, 15}, {100, -15}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
      Diagram);
  end M1;

  model M2
    extends M1 annotation(
      IconMap(primitivesVisible = false));
    annotation(
      Icon(graphics = {Text(origin = {-1, -49}, extent = {{-101, 49}, {101, -49}}, textString = "M2"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
  end M2;

  model Test
    TestPrimitiveVisible1.M2 m2 annotation(
      Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end Test;
end TestPrimitiveVisible1;