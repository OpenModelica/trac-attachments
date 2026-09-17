package TestRedeclareIcon

  model M0
  equation

  end M0;
  model M1
  equation

    annotation(
      Icon(graphics = {Text(origin = {-2, -3}, extent = {{-98, 103}, {102, -97}}, textString = "M1")}));
  end M1;

  model M2
    extends M0;
  equation

  annotation(
      Icon(graphics = {Text(origin = {4, -4}, extent = {{-104, 104}, {96, -96}}, textString = "M2")}));end M2;

  model Test1
  M1 m annotation(
      Placement(visible = true, transformation(origin = {2, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end Test1;

  model Test2
    extends Test1(redeclare M2 m);
  end Test2;
end TestRedeclareIcon;
