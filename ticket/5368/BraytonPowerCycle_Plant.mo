model BraytonPowerCycle_Plant
  BraytonPowerCycle braytonPowerCycle1 annotation(
    Placement(visible = true, transformation(origin = {11, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Step FuelFlowRate(height = 0.3, offset = 2.13, startTime = 500)  annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(FuelFlowRate.y, braytonPowerCycle1.u) annotation(
    Line(points = {{-60, 0}, {0, 0}, {0, 0}, {0, 0}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3"), ThermoPower(version = "3.1")));end BraytonPowerCycle_Plant;
