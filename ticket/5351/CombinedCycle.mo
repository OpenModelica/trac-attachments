model CombinedCycle
  
  BraytonCycle_CombinedCycle_1 BraytonCycle annotation(
    Placement(visible = true, transformation(origin = {-59, 81}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  
  Modelica.Blocks.Sources.Step Step_Fuel annotation(
    Placement(visible = true, transformation(origin = {-90, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  HRSG_3LRh HRSG annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT1(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {-36, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT2(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {36, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure sinkPressure1(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {62, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola HP_Turbine annotation(
    Placement(visible = true, transformation(origin = {-28, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola IP_Turbine annotation(
    Placement(visible = true, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola LP_Turbine annotation(
    Placement(visible = true, transformation(origin = {28, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.PowerPlants.SteamTurbineGroup.Components.CondenserPreP condenserPreP1 annotation(
    Placement(visible = true, transformation(origin = {50, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.PowerPlants.HRSG.Components.PrescribedSpeedPump prescribedSpeedPump1 annotation(
    Placement(visible = true, transformation(origin = {34, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {88, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(prescribedSpeedPump1.outlet, HRSG.WaterIn) annotation(
    Line(points = {{24, 34}, {16, 34}, {16, 60}}, color = {0, 0, 255}));
  connect(HRSG.Sh_HP_Out, HP_Turbine.inlet) annotation(
    Line(points = {{-16, 60}, {-16, 50}, {-40, 50}, {-40, -20}, {-36, -20}}, color = {0, 0, 255}));
  connect(condenserPreP1.waterOut, prescribedSpeedPump1.inlet) annotation(
    Line(points = {{50, 16}, {50, 16}, {50, 34}, {44, 34}, {44, 34}}, color = {0, 0, 255}));
  connect(LP_Turbine.outlet, condenserPreP1.steamIn) annotation(
    Line(points = {{36, -20}, {50, -20}, {50, -4}, {50, -4}, {50, -4}}, color = {0, 0, 255}));
  connect(IP_Turbine.shaft_b, LP_Turbine.shaft_a) annotation(
    Line(points = {{6, -28}, {20, -28}, {20, -28}, {22, -28}}));
  connect(HP_Turbine.shaft_b, IP_Turbine.shaft_a) annotation(
    Line(points = {{-22, -28}, {-6, -28}, {-6, -28}, {-6, -28}}));
  connect(IP_Turbine.outlet, LP_Turbine.inlet) annotation(
    Line(points = {{8, -20}, {20, -20}, {20, -20}, {20, -20}}, color = {0, 0, 255}));
  connect(HP_Turbine.outlet, IP_Turbine.inlet) annotation(
    Line(points = {{-20, -20}, {-8, -20}, {-8, -20}, {-8, -20}}, color = {0, 0, 255}));
  connect(sensT2.outlet, sinkPressure1.flange) annotation(
    Line(points = {{42, 76}, {52, 76}, {52, 76}, {52, 76}, {52, 76}, {52, 76}}, color = {159, 159, 223}));
  connect(HRSG.GasOut, sensT2.inlet) annotation(
    Line(points = {{20, 76}, {30, 76}, {30, 76}, {30, 76}}, color = {159, 159, 223}));
  connect(sensT1.outlet, HRSG.GasIn) annotation(
    Line(points = {{-30, 80}, {-30, 80}, {-30, 76}, {-20, 76}, {-20, 76}}, color = {159, 159, 223}));
  connect(BraytonCycle.ExhaustOutlet, sensT1.inlet) annotation(
    Line(points = {{-49.76, 80.78}, {-45.76, 80.78}, {-45.76, 80.78}, {-41.76, 80.78}, {-41.76, 80.78}, {-41.76, 80.78}, {-41.76, 80.78}, {-41.76, 80.78}}, color = {159, 159, 223}));
  connect(Step_Fuel.y, BraytonCycle.FuelFlowRate) annotation(
    Line(points = {{-79, 82}, {-71, 82}, {-71, 82}, {-73, 82}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.2"), ThermoPower(version = "3.1")));end CombinedCycle;
