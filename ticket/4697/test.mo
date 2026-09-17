package test
  model A
    parameter Modelica.SIunit.Time T "time";
  end A;

  model B
    parameter Modelica.SIunit.Time T1 "time1";
    parameter Modelica.SIunit.Time T2 "time2";
    
    test.A a1 annotation(
      Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end B;
end test;