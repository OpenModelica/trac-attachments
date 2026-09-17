package TestDynamicSelection
  model Circular
    Real x; 
    Real y;
    Real vx;
    Real vy;
    Real Fx;
    Real Fy;
    parameter Real m = 1;
    parameter Real L = 1;
  equation
    der(x) = vx;
    der(y) = vy;
    m*der(vx) = Fx;
    m*der(vy) = Fy;
    x^2 + y^2 = 1;
    Fx*y-Fy*x = 0;
  end Circular;
  
  model Test1
    extends Circular(
      x(start = 1-1e-10 ,fixed = true),
      y(start = -1e-5),
      vx(start = 0),
      vy(start = 10, fixed = true));
  end Test1;
  
  model Test2
    extends Circular(
      x(start = 0, fixed = true),
      y(start = 1),
      vx(start = -10, fixed = true),
      vy(start = 0));
  end Test2;
  
  
end TestDynamicSelection;
