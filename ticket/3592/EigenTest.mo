class EigenTest
  import Modelica.Math.Matrices;
  Real[3, 2] eigVal;
  Real[3, 3] eigVec;
  Real A[3, 3] = [1, 2, 3; 3, 4, 5; 2, 1, 4];
algorithm
  (eigVal, eigVec) := Matrices.eigenValues(A);
end EigenTest;
