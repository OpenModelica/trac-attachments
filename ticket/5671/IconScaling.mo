package IconScaling
  model IconClass
  equation

    annotation(
      Icon(graphics = {Rectangle(extent = {{-40, 100}, {40, -100}})}, coordinateSystem(extent = {{-40, -100}, {40, 100}})),
      Diagram(coordinateSystem(extent = {{-40, -100}, {40, 100}})));
  end IconClass;

  model IconInstance
  IconClass iconClass annotation(
      Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  IconClass iconClass1 annotation(
      Placement(visible = true, transformation(origin = {0, -10}, extent = {{-4, -10}, {4, 10}}, rotation = 0)));
  equation

  end IconInstance;
end IconScaling;
