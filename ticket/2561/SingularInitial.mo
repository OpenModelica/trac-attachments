model SingularInitial
  Real x,y,z;
initial equation
  z = 4;
equation
  z = time * 2;
  y = z * z;
  der(x) = x + y;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end SingularInitial;

