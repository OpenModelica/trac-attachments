model testGear2
  annotation(Diagram());
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 10) annotation(Placement(visible = true, transformation(origin = {61.6874,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  GearWithExternalRatio gearwithexternalratio1 annotation(Placement(visible = true, transformation(origin = {-3.87275,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 100) annotation(Placement(visible = true, transformation(origin = {-82.7109,-39.834}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 0.1) annotation(Placement(visible = true, transformation(origin = {-43.0935,-40.1107}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1 annotation(Placement(visible = true, transformation(origin = {-3.59613,7.46888}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  Modelica.Blocks.Tables.CombiTable1Ds combitable1ds1(tableOnFile = true, tableName = "schalt1", fileName = "/home/peter/prog/openModelica/tests/schaltgetriebe.txt") annotation(Placement(visible = true, transformation(origin = {-2.76625,43.9834}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(Placement(visible = true, transformation(origin = {-3.3195,82.1329}, extent = {{-12,12},{12,-12}}, rotation = -90)));
equation
  connect(gearwithexternalratio1.flb,inertia1.flange_a) annotation(Line(points = {{8.12725,-39.834},{50.1425,-39.834},{50.1425,-39.834},{49.6874,-39.834}}));
  connect(inertia2.flange_b,gearwithexternalratio1.fla) annotation(Line(points = {{-31.0935,-40.1107},{-15.6695,-40.1107},{-15.6695,-39.834},{-15.8728,-39.834}}));
  connect(constanttorque1.flange,inertia2.flange_a) annotation(Line(points = {{-70.7109,-39.834},{-54.416,-39.834},{-54.416,-40.1107},{-55.0935,-40.1107}}));
  connect(sum1.y,gearwithexternalratio1.ratio) annotation(Line(points = {{-3.59613,-5.73112},{-3.4188,-5.73112},{-3.4188,-27.834},{-3.87275,-27.834}}));
  connect(combitable1ds1.y,sum1.u) annotation(Line(points = {{-2.76625,30.7834},{-2.849,30.7834},{-2.849,21.8689},{-3.59613,21.8689}}));
  connect(constant1.y,combitable1ds1.u) annotation(Line(points = {{-3.3195,68.9329},{-2.849,68.9329},{-2.849,58.3834},{-2.76625,58.3834}}));
end testGear2;

