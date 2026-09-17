within ;
model TestElectroMechanicalDrives2
  ElectroMechanicalDrives.Components.Rotational.ConstantEfficiency efficiency(efficiency=0.9) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-12,60})));
  ElectroMechanicalDrives.Components.Machines.AngularSpeedControlledGearMachine
    machine(
    exact=true,
    ratio=1,
    efficiency=0.9,
    J=0.1)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,60})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=50,
    duration=1,
    startTime=0) annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
equation
  connect(machine.flange, efficiency.flange_a) annotation(
    Line(points = {{-32, 60}, {-27, 60}, {-22, 60}}, color = {0, 0, 0}));
  connect(ramp.y, machine.w_ref) annotation(
    Line(points = {{-69, 60}, {-54, 60}}, color = {0, 0, 127}));
  annotation(experiment(Interval = 0.006, StartTime = 0, StopTime = 3, Tolerance = 1e-06), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version="3.2.2"), ElectroMechanicalDrives(version="0.13.0")));
end TestElectroMechanicalDrives2;