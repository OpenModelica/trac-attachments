model Netstart
  extends DCDrive_pkg;
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm annotation(
    Placement(visible = true, transformation(origin = {-74, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-120, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation(
    Placement(visible = true, transformation(origin = {-74, 24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia loadinertia(J = 2) annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant = -30) annotation(
    Placement(visible = true, transformation(origin = {16, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticSpeedDependentTorque(tau_nominal = -30, useSupport = false, w_nominal = 146.6077) annotation(
    Placement(visible = true, transformation(origin = {16, -36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(ground.p, V1.n) annotation(
    Line(points = {{-120, -36}, {-120, 24}, {-84, 24}}, color = {0, 0, 255}));
  connect(V1.p, dcpm.pin_ap) annotation(
    Line(points = {{-64, 24}, {-64, 0}, {-68, 0}}, color = {0, 0, 255}));
  connect(V1.n, dcpm.pin_an) annotation(
    Line(points = {{-84, 24}, {-84, 0}, {-80, 0}}, color = {0, 0, 255}));
  connect(dcpm.flange, loadinertia.flange_a) annotation(
    Line(points = {{-64, -10}, {-40, -10}}));
  connect(constantTorque.flange, loadinertia.flange_b) annotation(
    Line(points = {{6, 8}, {-20, 8}, {-20, -10}}));
  connect(quadraticSpeedDependentTorque.flange, loadinertia.flange_b) annotation(
    Line(points = {{6, -36}, {-20, -36}, {-20, -10}}));
  annotation(
    Icon(coordinateSystem(extent = {{-150, -80}, {150, 80}})),
    Diagram(coordinateSystem(extent = {{-150, -80}, {150, 80}})),
    experiment(StartTime = 0, StopTime = 2.5, Tolerance = 1e-6, Interval = 0.005));
end Netstart;
