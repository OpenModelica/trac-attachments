model HX_Turbine_Check
  
  ThermoPower.PowerPlants.HRSG.Components.HE HX(FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, N_F = 6, N_G = 6, Tstartbar_G(displayUnit = "K") = 800, exchSurface_F = 2000, exchSurface_G = 1000, extSurfaceTub = 1500, fluidNomFlowRate = 10, fluidNomPressure = 2e+06, fluidVol = 5, gasNomFlowRate = 100, gasNomPressure = 101325, gasVol = 10, lambda = 20, metalVol = 10, pstart_F = 2e+06, pstart_G = 101325, rhomcm = 7900, rhonom_F(displayUnit = "kg/m3") = 0.6, rhonom_G(displayUnit = "kg/m3") = 0.33)  annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SourceMassFlow FlueGasSource(
    redeclare package Medium = ThermoPower.Media.FlueGas, T = 800, p0 = 101325, w0 = 100)  annotation(
    Placement(visible = true, transformation(origin = {-92, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SinkMassFlow FlueGasSink(
    redeclare package Medium = ThermoPower.Media.FlueGas, p0 = 101325, w0 = 100)  annotation(
    Placement(visible = true, transformation(origin = {32, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SourceMassFlow WaterSource(T = 212.4 + 273, h = 2799500, p0 = 20e5, w0 = 10)  annotation(
    Placement(visible = true, transformation(origin = {-30, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SinkMassFlow SteamSink(p0 = 1.01325e5, w0 = 10)  annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT TGas_Inlet(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {-58, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT TGas_Outlet(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {0, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 
  ThermoPower.Water.SensT TWater_Inlet annotation(
    Placement(visible = true, transformation(origin = {-26, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SensT TSteam_Outlet annotation(
    Placement(visible = true, transformation(origin = {16, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SteamTurbineStodola SteamTurbine(Kt = 0.0131, PRstart = 20, pnom = 20e5, wnom = 10, wstart = 10)  annotation(
    Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
 inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {50, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation(
    Placement(visible = true, transformation(origin = {14, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 ThermoPower.Electrical.Generator generator1 annotation(
    Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Blocks.Continuous.FirstOrder firstOrder1 annotation(
    Placement(visible = true, transformation(origin = {30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {108, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(firstOrder1.y, y) annotation(
    Line(points = {{42, -70}, {100, -70}, {100, -70}, {108, -70}}, color = {0, 0, 127}));
  connect(powerSensor1.power, firstOrder1.u) annotation(
    Line(points = {{6, -42}, {6, -42}, {6, -70}, {18, -70}, {18, -70}}, color = {0, 0, 127}));
  connect(powerSensor1.flange_b, generator1.shaft) annotation(
    Line(points = {{24, -30}, {36, -30}, {36, -30}, {36, -30}}));
  connect(SteamTurbine.shaft_b, powerSensor1.flange_a) annotation(
    Line(points = {{-12, -30}, {4, -30}, {4, -30}, {4, -30}}));
  connect(SteamTurbine.outlet, TSteam_Outlet.inlet) annotation(
    Line(points = {{-10, -20}, {0, -20}, {0, 0}, {10, 0}}, color = {0, 0, 255}));
  connect(TSteam_Outlet.outlet, SteamSink.flange) annotation(
    Line(points = {{22, 0}, {38, 0}}, color = {0, 0, 255}));
  connect(HX.waterOut, SteamTurbine.inlet) annotation(
    Line(points = {{-30, 20}, {-30, -20}}, color = {0, 0, 255}));
  connect(TWater_Inlet.outlet, HX.waterIn) annotation(
    Line(points = {{-30, 54}, {-30, 54}, {-30, 40}, {-30, 40}}, color = {0, 0, 255}));
  connect(WaterSource.flange, TWater_Inlet.inlet) annotation(
    Line(points = {{-30, 82}, {-30, 82}, {-30, 66}, {-30, 66}}, color = {0, 0, 255}));
  connect(TGas_Outlet.outlet, FlueGasSink.flange) annotation(
    Line(points = {{6, 30}, {14, 30}, {14, 30}, {22, 30}, {22, 30}, {22, 30}}, color = {159, 159, 223}));
  connect(HX.gasOut, TGas_Outlet.inlet) annotation(
    Line(points = {{-20, 30}, {-13, 30}, {-13, 30}, {-6, 30}, {-6, 30}, {-6, 30}, {-6, 30}, {-6, 30}}, color = {159, 159, 223}));
  connect(TGas_Inlet.outlet, HX.gasIn) annotation(
    Line(points = {{-52, 30}, {-46, 30}, {-46, 30}, {-40, 30}, {-40, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {159, 159, 223}));
  connect(FlueGasSource.flange, TGas_Inlet.inlet) annotation(
    Line(points = {{-82, 30}, {-64, 30}, {-64, 30}, {-64, 30}}, color = {159, 159, 223}));
  connect(HX.gasOut, HX.gasIn) annotation(
    Line(points = {{-20, 30}, {-40, 30}}, color = {159, 159, 223}));

annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.3")));end HX_Turbine_Check;
