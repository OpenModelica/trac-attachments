model testGear4
  annotation(Diagram());
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 10) annotation(Placement(visible = true, transformation(origin = {61.6874,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  GearWithExternalRatio gearwithexternalratio1 annotation(Placement(visible = true, transformation(origin = {-3.87275,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 100) annotation(Placement(visible = true, transformation(origin = {-82.7109,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 0.1) annotation(Placement(visible = true, transformation(origin = {-43.0935,-40.1107}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 4.15) annotation(Placement(visible = true, transformation(origin = {-4.1742,-1.62779}, extent = {{-12,12},{12,-12}}, rotation = -90)));
equation
  connect(gearwithexternalratio1.flb,inertia1.flange_a) annotation(Line(points = {{8.12725,-39.834},{50.1425,-39.834},{50.1425,-39.834},{49.6874,-39.834}}));
  connect(inertia2.flange_b,gearwithexternalratio1.fla) annotation(Line(points = {{-31.0935,-40.1107},{-15.9544,-40.1107},{-15.9544,-39.834},{-15.8728,-39.834}}));
  connect(constanttorque1.flange,inertia2.flange_a) annotation(Line(points = {{-70.7109,-39.834},{-55.2707,-39.834},{-55.2707,-40.1107},{-55.0935,-40.1107}}));
  connect(constant1.y,gearwithexternalratio1.ratio) annotation(Line(points = {{-4.1742,-14.8278},{-3.9886,-14.8278},{-3.9886,-27.834},{-3.87275,-27.834}}));
end testGear4;

