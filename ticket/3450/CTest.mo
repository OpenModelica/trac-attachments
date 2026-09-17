package CTest
  model ExampleModel
    Component component annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner Ambient ambient annotation(Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end ExampleModel;

  model Ambient
    extends CTest.AmbientBase(redeclare final function func = CTest.func(x = x));
    parameter Real x = 5;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Ambient;

  partial model AmbientBase
    replaceable partial function func = CTest.func;
    parameter Real var_value = 2;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end AmbientBase;

  model Component
    outer Ambient ambient;
    parameter Real var = ambient.func(ambient.var_value);
    Real z;
  equation
    z = var;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Component;

  function func
    input Real x;
    output Real y;
  algorithm
    y := x + 2;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end func;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end CTest;