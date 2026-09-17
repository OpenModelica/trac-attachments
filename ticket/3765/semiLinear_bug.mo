model semiLinear_bug
  parameter Real k=1000;
  parameter Real d=2.847;
  parameter Real dL=-0.1;
  Real L(start=2.8,fixed=true);
  Real T;
equation
  der(L)=dL;
  T=semiLinear(d / L - 1, k, 0);
end semiLinear_bug;