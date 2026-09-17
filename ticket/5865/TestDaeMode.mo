model TestDaeMode
  Real p1(start = 1.3e5, fixed = true);
  Real p2(start = 1.2e5, fixed = true);
  Real p3(start = 1.1e5);
  Real p4(start = 1.0e5, fixed = true);
  Real rho1;
  Real rho2;
  Real rho3;
  Real w12(start = 1);
  Real w23(start = 1);
  Real w34(start = 1);
  parameter Real C = 1e-3;
  parameter Real k = 1e4;
  function sq = Modelica.Fluid.Utilities.regSquare;
equation
  C*der(p1) = -w12;
  C*der(p2) = w12 - w23;
  w34 = w23;
  C*der(p4) = w34;
  rho1 = p1/1e5;
  rho2 = p2/1e5;
  rho3 = p3/1e5;
  p1 - p2 = k*sq(w12)/rho1;
  p2 - p3 = k*sq(w23)/rho2;
  p3 - p4 = k*sq(w34)/rho3;
//annotation(__OpenModelica_commandLineOptions="--daeMode");

end TestDaeMode;
