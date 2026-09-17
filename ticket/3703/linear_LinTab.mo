model linear_LinTab
  parameter Integer n = 1; // states 
  parameter Integer k = 1; // top-level inputs 
  parameter Integer l = 1; // top-level outputs 
  parameter Real x0[1] = {3};
  parameter Real u0[1] = {0};
  parameter Real A[1,1] = [-10];
  parameter Real B[1,1] = [0];
  parameter Real C[1,1] = [1];
  parameter Real D[1,1] = [0];
  Real x[1](start=x0);
  input Real u[1](start= u0);
  output Real y[1];

  Real x_PPT1Py = x[1];
    Real u_Pdx = u[1];
    Real y_Pdy = y[1];
  
equation
  der(x) = A * x + B * u;
  y = C * x + D * u;
end linear_LinTab;
