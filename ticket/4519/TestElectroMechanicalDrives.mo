model TestElectroMechanicalDrives
  ElectroMechanicalDrives.Components.Machines.TorqueControlledGearMachine machine(J = 0.1, efficiency = 0.9, ratio = 1)  annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1 annotation (
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step1.y, machine.tau_ref) annotation(
    Line(points = {{-19, 0}, {-14, 0}, {-12, 0}}, color = {0, 0, 127}));
  annotation (
    uses(                                             Modelica(version = "3.2.2"), ElectroMechanicalDrives(version="0.13.0")));
end TestElectroMechanicalDrives;