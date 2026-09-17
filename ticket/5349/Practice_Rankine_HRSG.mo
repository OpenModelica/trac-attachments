model Practice_Rankine_HRSG
  
  HRSG_3LRh HRSG annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow SourceFlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    T = 800, allowFlowReversal = false, 
    p0 = 101325, 
    w0 = 102)  annotation(
    Placement(visible = true, transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT1(
    redeclare package Medium = ThermoPower.Media.FlueGas, allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {42, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure SinkFlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, T = 800, allowFlowReversal = false, 
    p0 = 101325)  annotation(
    Placement(visible = true, transformation(origin = {80, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola HP_Turbine( allowFlowReversal = false, pnom = 134.3e5, wnom = 70.59, wstart = 70.59)  annotation(
    Placement(visible = true, transformation(origin = {-40, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola IP_Turbine(allowFlowReversal = false, pnom = 134.3e5, wnom = 70.59, wstart = 70.59)  annotation(
    Placement(visible = true, transformation(origin = {0, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola LP_Turbine(pnom = 134.3e5, wnom = 70.59)  annotation(
    Placement(visible = true, transformation(origin = {40, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.PowerPlants.SteamTurbineGroup.Components.CondenserPreP condenserPreP1(Vtot = 10, allowFlowReversal = false, p = 100000)  annotation(
    Placement(visible = true, transformation(origin = {48, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.PowerPlants.HRSG.Components.PrescribedSpeedPump prescribedSpeedPump1(V = 1,head_nom = {1, 1, 1}, n0 = 1200, nominalFlow = 122.4, nominalInletPressure = 100000, nominalOutletPressure = 1.98e+06, q_nom = {1, 1, 1}, rho0 = 1000)                        annotation(
    Placement(visible = true, transformation(origin = {38, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Electrical.Generator generator1 annotation(
    Placement(visible = true, transformation(origin = {62, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-72, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 100, height = 1)  annotation(
    Placement(visible = true, transformation(origin = {74, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(ramp1.y, prescribedSpeedPump1.pumpSpeed_rpm) annotation(
    Line(points = {{62, 14}, {46, 14}, {46, 14}, {46, 14}}, color = {0, 0, 127}));
  connect(HRSG.Sh_HP_Out, HP_Turbine.inlet) annotation(
    Line(points = {{-16, 60}, {-16, 20}, {-100, 20}, {-100, -52}, {-54.5, -52}, {-54.5, -66}, {-48, -66}}, color = {0, 0, 255}));
  connect(LP_Turbine.shaft_b, generator1.shaft) annotation(
    Line(points = {{46, -74}, {54, -74}, {54, -74}, {54, -74}}));
  connect(IP_Turbine.shaft_b, LP_Turbine.shaft_a) annotation(
    Line(points = {{6, -74}, {34, -74}, {34, -74}, {34, -74}, {34, -74}}));
  connect(HP_Turbine.shaft_b, IP_Turbine.shaft_a) annotation(
    Line(points = {{-34, -74}, {-8, -74}, {-8, -74}, {-6, -74}}));
  connect(LP_Turbine.outlet, condenserPreP1.steamIn) annotation(
    Line(points = {{48, -66}, {48, -66}, {48, -40}, {48, -40}}, color = {0, 0, 255}));
  connect(prescribedSpeedPump1.outlet, HRSG.WaterIn) annotation(
    Line(points = {{28, 20}, {16, 20}, {16, 60}, {16, 60}, {16, 60}}, color = {0, 0, 255}));
  connect(condenserPreP1.waterOut, prescribedSpeedPump1.inlet) annotation(
    Line(points = {{48, -20}, {48, -20}, {48, 20}, {48, 20}}, color = {0, 0, 255}));
  connect(sensT1.outlet, SinkFlueGas.flange) annotation(
    Line(points = {{48, 76}, {70, 76}, {70, 76}, {70, 76}}, color = {159, 159, 223}));
  connect(HRSG.GasOut, sensT1.inlet) annotation(
    Line(points = {{20, 76}, {36, 76}, {36, 76}, {36, 76}}, color = {159, 159, 223}));
  connect(SourceFlueGas.flange, HRSG.GasIn) annotation(
    Line(points = {{-76, 76}, {-20, 76}, {-20, 76}, {-20, 76}}, color = {159, 159, 223}));
  annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")));end Practice_Rankine_HRSG;
