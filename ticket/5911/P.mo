package P
  model M
    P.C c1 annotation (
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real r = 5;
  equation

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false)), Icon(
          coordinateSystem(preserveAspectRatio=false)));
  end M;

  model N
  P.M m1(r(displayUnit="K") = 10, s = 12)  annotation (
      Placement(visible = true, transformation(origin = {-2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P.M m2 annotation (
      Placement(visible = true, transformation(origin={39,10},    extent={{-10,-11},
              {10,11}},                                                                            rotation = 90)));
  C c annotation(
      Placement(visible = true, transformation(origin = {66, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(m1.c1, m2.c1) annotation (
      Line(points={{9,10},{24,10},{24,21},{39,21}}));
  annotation (
      Diagram(coordinateSystem(initialScale = 0.1)));
  end N;

  connector C
    annotation (
      Icon(graphics={  Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  end C;

  model N1
           extends N;
    M m1 annotation (
      Placement(visible = true, transformation(origin = {58, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end N1;
end P;
