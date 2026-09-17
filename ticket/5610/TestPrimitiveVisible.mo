package TestPrimitiveVisible
  model M1
  equation

    annotation(
      Icon(graphics = {Text(origin = {-2, -3}, extent = {{-98, 103}, {102, 3}}, textString = "M1")}, coordinateSystem(initialScale = 0.1)));
  end M1;

  model M2
    extends M1;
  annotation(
      IconMap(primitivesVisible = false),
      Icon(graphics = {Text(origin = {-1, -49}, extent = {{-101, 49}, {101, -49}}, textString = "M2")}, coordinateSystem(initialScale = 0.1)));end M2;
  
  model Test
  TestPrimitiveVisible.M2 m annotation(
      Placement(visible = true, transformation(origin = {1, 1}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  equation
  
  end Test;
end TestPrimitiveVisible;
