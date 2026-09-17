within ;
model TopModel
  Real x(start = 1, fixed=true);

  SubModel subModel
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  annotation (uses(Modelica(version="3.2.1")));
equation
  der(x) = -x;
end TopModel;
