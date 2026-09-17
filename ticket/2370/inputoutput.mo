package inputoutput
  record sig
    Real a,b;
  end sig;
  block a
    // this model compiles with OpenModelica 1.9 r17338
    input Real a,b;
    output Real A,B;
  equation
    A = a;
    B = b;
  end a;
  block b
    // this model compiles with OpenModelica 1.9 r17338
    input Real u[2];
    output Real y[2];
  equation
    y = u;
  end b;
  block c
    // this model fails to compile with OpenModelica 1.9 r17338
    input sig u;
    output sig y;
  equation
    y = u;
  end c;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), uses(Modelica(version = "3.2")));
end inputoutput;

