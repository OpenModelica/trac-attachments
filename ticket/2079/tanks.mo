model tanks
  import Modelica.Fluid;
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation(choicesAllMatching = true);
  final Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, height = 80, crossArea = 20, nPorts = 1, level_start = 70, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.1)}) annotation(Placement(visible = true, transformation(origin = {-60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  final Modelica.Fluid.Vessels.OpenTank tank2(redeclare package Medium = Medium, height = 80, crossArea = 20, nPorts = 1, level_start = 0.0, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.1)}) annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, allowFlowReversal = true, length = 2, diameter = 0.5, height_ab = 0) annotation(Placement(visible = true, transformation(origin = {-35, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(Placement(visible = true, transformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tank1.ports[1], pipe.port_a) annotation(Line(points = {{-60, 50}, {-40.1478, 50}, {-40.1478, 15.0246}, {-40.1478, 15.0246}}));
  connect(pipe.port_b, tank2.ports[1]) annotation(Line(points = {{-30, 15}, {-2.70936, 15}, {-2.70936, 9.85222}, {-2.70936, 9.85222}}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end tanks;