model DoubleMassVecLen
  import Modelica.Math.Vectors;
  
  Real[3] x1(start = {0, 0, 0}, each fixed = true);
  Real[3] x2(start = {len, 0, 0}, fixed = {true, true, false});
  Real[3] v1(each start = 0, fixed = {true, true, true});
  Real[3] v2(each start = 0, fixed = {true, true, false});
  Real[3] fApplied1 = {0.0, 2.0, 0.0}, fApplied2 = {0.0, -2.0, 0.0};
  Real fInternal (start = 0, fixed = false);
  Real[3] fInternalVec;
  Real[3] x1x2Unit;  // Unit vector from x1 to x2
  parameter Real m1 = 0.8, m2 = 1.2, len =2.5;
  Real lengthCheck;
equation
  // Basic ODE
  der(x1) = v1;
  der(x2) = v2;
  der(v1) = (fApplied1 - fInternalVec) / m1;
  der(v2) = (fApplied2 + fInternalVec) / m2;
  fInternalVec = x1x2Unit * fInternal;
  
  // Computation of constraint information
  x1x2Unit = Vectors.normalize(x2 - x1); // Unit vector from x1 to x2
  Vectors.length(x1 - x2) = len;
  lengthCheck = Vectors.length(x1 - x2);
annotation(experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.006));
end DoubleMassVecLen;
