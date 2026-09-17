model Test_Math_Matrices_norm
  parameter Real A[:,:]=[1,10,1000;0.01,0,10;0.005,0.01,10];
  Real x1;
  Real x2;
  Real x3;
  Real x4;
equation 
  x1=Modelica.Math.Matrices.norm(A, 1) "Should return 1020";
  x2=Modelica.Math.Matrices.norm(A, 2) "Should return 1000.15";
  x3=Modelica.Math.Matrices.norm(A, Modelica.Constants.inf) "Should return 1011";
  x4=Modelica.Math.Matrices.norm(A) "Should return 1000.15";
end Test_Math_Matrices_norm;
