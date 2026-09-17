model schaltint
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 0.1) annotation(Placement(visible = true, transformation(origin = {-13.0473,11.5561}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia3(J = 100) annotation(Placement(visible = true, transformation(origin = {55.544,12.6745}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  annotation(experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-06));
  GearWithExternalRatioI gearwithexternalratioi1 annotation(Placement(visible = true, transformation(origin = {23.4769,11.8871}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerStep integerstep1(height = -2, offset = 4, startTime = 5) annotation(Placement(visible = true, transformation(origin = {23.477,49.3314}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 150) annotation(Placement(visible = true, transformation(origin = {-55.5721,12.4814}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(constanttorque1.flange,inertia2.flange_a) annotation(Line(points = {{-43.5721,12.4814},{-24.9629,12.4814},{-24.9629,11.5561},{-25.0473,11.5561}}));
  connect(integerstep1.y,gearwithexternalratioi1.ratio) annotation(Line(points = {{23.477,36.1314},{23.7741,36.1314},{23.7741,23.8871},{23.4769,23.8871}}));
  connect(gearwithexternalratioi1.flb,inertia3.flange_a) annotation(Line(points = {{35.4769,11.8871},{43.3878,11.8871},{43.3878,12.6745},{43.544,12.6745}}));
  connect(inertia2.flange_b,gearwithexternalratioi1.fla) annotation(Line(points = {{-1.0473,11.5561},{10.6984,11.5561},{10.6984,11.8871},{11.4769,11.8871}}));
end schaltint;

