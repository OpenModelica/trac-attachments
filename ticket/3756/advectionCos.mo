model advectionSin "advection equation"
  parameter Real L = 1;
  parameter DomainLineSegment1D omega(L = L, N = 100);
  field Real u(domain = omega);
  parameter Real c = 1;
initial equation
  u = if omega.x < 0.25 then cos(2*3.14159*omega.x) else 0  indomain omega;
equation
  der(u) + c*pder(u,x) = 0 indomain omega;
  u = 1                          indomain omega.left;
  u = 0                          indomain omega.right;
end advectionSin;
