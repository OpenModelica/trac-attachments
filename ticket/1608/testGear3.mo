model testGear3
  annotation(Diagram());
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 100) annotation(Placement(visible = true, transformation(origin = {-82.7109,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 5) annotation(Placement(visible = true, transformation(origin = {32.4051,-39.8258}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 5) annotation(Placement(visible = true, transformation(origin = {66.2458,-39.5491}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  GearWithExternalRatio gearwithexternalratio1 annotation(Placement(visible = true, transformation(origin = {-3.58785,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1 annotation(Placement(visible = true, transformation(origin = {-3.59613,7.46888}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(Placement(visible = true, transformation(origin = {-3.3195,82.1329}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  Modelica.Blocks.Tables.CombiTable1Ds combitable1ds1(tableOnFile = true, tableName = "schalt1", fileName = "/home/peter/prog/openModelica/tests/schaltgetriebe.txt") annotation(Placement(visible = true, transformation(origin = {-3.33605,43.4136}, extent = {{-12,12},{12,-12}}, rotation = -90)));
equation
  connect(inertia2.flange_b,inertia1.flange_a) annotation(Line(points = {{44.4051,-39.8258},{54.1311,-39.8258},{54.1311,-39.5491},{54.2458,-39.5491}}));
  connect(gearwithexternalratio1.flb,inertia2.flange_a) annotation(Line(points = {{8.41215,-39.834},{21.3675,-39.834},{21.3675,-39.8258},{20.4051,-39.8258}}));
  connect(constanttorque1.flange,gearwithexternalratio1.fla) annotation(Line(points = {{-70.7109,-39.834},{-15.6695,-39.834},{-15.6695,-39.834},{-15.5879,-39.834}}));
  connect(sum1.y,gearwithexternalratio1.ratio) annotation(Line(points = {{-3.59613,-5.73112},{-3.1339,-5.73112},{-3.1339,-27.834},{-3.58785,-27.834}}));
  connect(combitable1ds1.y,sum1.u) annotation(Line(points = {{-3.33605,30.2136},{-2.849,30.2136},{-2.849,21.8689},{-3.59613,21.8689}}));
  connect(constant1.y,combitable1ds1.u) annotation(Line(points = {{-3.3195,68.9329},{-2.849,68.9329},{-2.849,57.8136},{-3.33605,57.8136}}));
end testGear3;

