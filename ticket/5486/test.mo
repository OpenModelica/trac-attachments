package test
  model M1
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-3, 5}, extent = {{-41, 39}, {41, -39}}, textString = "M1"), Text(origin = {16, -130}, extent = {{-92, 26}, {50, -26}}, textString = "%name")}));
  end M1;

  model M2
    M1 test annotation(
      Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end M2;


end test;