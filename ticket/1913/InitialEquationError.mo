within ;
package InitialEquationError
  model model1
   Real A[2];
  initial equation
  A[1]=5;
  A[2]=6;
  equation
   der(A[1])=A[2]/A[1];
  der(A[2])=A[2];
  end model1;
  annotation (uses(Modelica(version="3.0")));
end InitialEquationError;
