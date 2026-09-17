within ;
model typeTest
  import Modelica.Mechanics.MultiBody.Types;

  parameter Integer nPoints=2;
  type Pos3D=Modelica.SIunits.Position[3];

  Pos3D points[nPoints];

  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape visPoints[nPoints](r=points);

equation
  for i in 1:nPoints loop
  points[i,:]={0,0,0};
  end for;

  annotation (uses(Modelica(version="3.2")));
end typeTest;
