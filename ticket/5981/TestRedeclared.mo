package TestRedeclared
  model M
    parameter Real p = q;
    parameter Real q;
  end M;

  model M2
    extends M(p = s);
    parameter Real s;
  end M2;

  model S
    TestIdentical.M2 m2 annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
  end S;

end TestRedeclared;
