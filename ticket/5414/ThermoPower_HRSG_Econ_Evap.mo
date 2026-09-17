model ThermoPower_HRSG_Econ_Evap
  ThermoPower.Gas.SourceMassFlow Source_FlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    T = 331.59 + 273.15, 
    p0 = 101325, 
    w0 = 169.755)  annotation(
    Placement(visible = true, transformation(origin = {-92, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SourceMassFlow Source_Steam(
    T = 46.45 + 273.15, 
    h = 203.22e3, 
    p0 = 80e5, 
    use_T = true, 
    w0 = 21.5)  annotation(
    Placement(visible = true, transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SensT sensT_WaterIn_Econ annotation(
    Placement(visible = true, transformation(origin = {4, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SensT sensT_WaterOut_Econ annotation(
    Placement(visible = true, transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Gas.SensT sensT_ExhaustIn_Econ(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {-50, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT_ExhaustOut_Econ(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {50, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure Sink_FlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    p0 = 101325)  annotation(
    Placement(visible = true, transformation(origin = {94, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SinkPressure Sink_Steam(
    p0 = 80e5)  annotation(
    Placement(visible = true, transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Examples.HRB.Models.Evaporator Evaporator(
    cm = 480,
    exchSurface = 2.752, 
    fluidNomFlowRate = 21.5, 
    fluidNomPressure = 8e+06, 
    fluidVol = 0.01376, 
    gamma = 85, 
    gasNomFlowRate = 169.755, 
    gasNomPressure = 101325, 
    gasVol = 0.01376, 
    metalVol = 0.01376, 
    rhom(displayUnit = "kg/m3") = 8055, 
    rhonom_G = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT_ExhaustOut_Evap(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {50, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder VoidFractionSensor annotation(
    Placement(visible = true, transformation(origin = {53, -43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput VoidFraction annotation(
    Placement(visible = true, transformation(origin = {110, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Examples.RankineCycle.Models.HE Economizer(
    FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.OpPoint,
    FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid,
    N_F = 6, 
    N_G = 6, 
    Tstart_G = 604.74, 
    Tstart_M = 573.15, counterCurrent = true, 
    exchSurface_F = 2.752, 
    exchSurface_G = 2.752, 
    extSurfaceTub = 5.504, 
    fluidNomFlowRate = 21.5, 
    fluidNomPressure = 8e+06, 
    fluidVol = 0.01376, 
    gamma_F = 3000, 
    gamma_G = 30, 
    gasNomFlowRate = 169.755, 
    gasNomPressure = 101325, 
    gasVol = 0.01376, 
    lambda = 19.8, 
    metalVol = 0.01376, 
    rhomcm = 8055 * 480, 
    rhonom_F(displayUnit = "kg/m3") = 997, 
    rhonom_G = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(Economizer.gasOut, sensT_ExhaustOut_Econ.inlet) annotation(
    Line(points = {{10, 30}, {44, 30}, {44, 30}, {44, 30}}, color = {159, 159, 223}));
  connect(sensT_ExhaustIn_Econ.outlet, Economizer.gasIn) annotation(
    Line(points = {{-44, 30}, {-10, 30}, {-10, 30}, {-10, 30}}, color = {159, 159, 223}));
  connect(Economizer.waterOut, sensT_WaterOut_Econ.inlet) annotation(
    Line(points = {{0, 20}, {0, 20}, {0, 6}, {0, 6}}, color = {0, 0, 255}));
  connect(sensT_WaterIn_Econ.outlet, Economizer.waterIn) annotation(
    Line(points = {{0, 54}, {0, 54}, {0, 40}, {0, 40}}, color = {0, 0, 255}));
  connect(VoidFractionSensor.y, VoidFraction) annotation(
    Line(points = {{58, -42}, {104, -42}, {104, -42}, {110, -42}}, color = {0, 0, 127}));
  connect(Evaporator.voidFraction, VoidFractionSensor.u) annotation(
    Line(points = {{10, -44}, {46, -44}, {46, -42}, {46, -42}}, color = {0, 0, 127}));
  connect(sensT_ExhaustOut_Evap.outlet, Sink_FlueGas.flange) annotation(
    Line(points = {{56, -70}, {70, -70}, {70, -70}, {84, -70}, {84, -70}, {84, -70}}, color = {159, 159, 223}));
  connect(Evaporator.gasOut, sensT_ExhaustOut_Evap.inlet) annotation(
    Line(points = {{10, -50}, {26, -50}, {26, -70}, {44, -70}}, color = {159, 159, 223}));
  connect(sensT_ExhaustOut_Econ.outlet, Evaporator.gasIn) annotation(
    Line(points = {{56, 30}, {68, 30}, {68, -20}, {-50, -20}, {-50, -20}, {-70, -20}, {-70, -50}, {-10, -50}, {-10, -50}}, color = {159, 159, 223}));
  connect(sensT_WaterOut_Econ.outlet, Evaporator.waterIn) annotation(
    Line(points = {{0, -6}, {0, -40}}, color = {0, 0, 255}));
  connect(Evaporator.waterOut, Sink_Steam.flange) annotation(
    Line(points = {{0, -60}, {0, -90}}, color = {0, 0, 255}));
  connect(Source_FlueGas.flange, sensT_ExhaustIn_Econ.inlet) annotation(
    Line(points = {{-82, 30}, {-56, 30}}, color = {159, 159, 223}));
  connect(Source_Steam.flange, sensT_WaterIn_Econ.inlet) annotation(
    Line(points = {{0, 90}, {0, 66}}, color = {0, 0, 255}));
  annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.3")));end ThermoPower_HRSG_Econ_Evap;
