model HX_Pump_2_Superheater_2_HPTurbine
  
  //Heat Exchanger - Steam entering HX (compressed liquid) --> Steam exiting HX (super heated vapor)//
  //Steam Turbine - High Pressure Turbine and is (1) of (2) in series with one another. Exit pressure should be intermediate pressure level before being reheated and directed towards Low Pressure Turbine//
  
  ThermoPower.PowerPlants.HRSG.Components.HE HX(
    FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, 
    Tstartbar_G (displayUnit = "K") = 787.87, 
    dpnom_F(displayUnit = "Pa") = 0, 
    dpnom_G = 0, 
    exchSurface_F = 4.739, 
    exchSurface_G = 4.739, 
    extSurfaceTub = 9.479, 
    fluidNomFlowRate = 26.397, 
    fluidNomPressure = 8e+06, 
    fluidVol = 0.0296, 
    gasNomFlowRate = 169.755, 
    gasNomPressure = 101325, 
    gasVol = 0.0296, 
    lambda = 20, 
    metalVol = 5, 
    pstart_F = 8e+06, 
    pstart_G = 101325, 
    rhomcm = 1, 
    rhonom_F(displayUnit = "kg/m3") = 0.6, 
    rhonom_G(displayUnit = "kg/m3") = 0.33)  annotation(
    Placement(visible = true, transformation(origin = {-1.9984e-15, 14}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure sinkPressure1(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    T = 106.86 + 273, 
    p0 = 101325) annotation(
    Placement(visible = true, transformation(origin = {92, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT1(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {-50, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT2(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {50, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SinkPressure sinkPressure2(
    redeclare package Medium = ThermoPower.Water.StandardWater, 
    T = 165 + 273, 
    h = 2536.2092e5, 
    p0 = 7.0e5) annotation(
    Placement(visible = true, transformation(origin = {92, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SensT sensT3(
    redeclare package Medium = ThermoPower.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {4, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SensT sensT4(
    redeclare package Medium = ThermoPower.Water.StandardWater, 
    allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {4, -32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    T = 514 + 273, 
    p0 = 101325,
    w0 = 169.755) annotation(
    Placement(visible = true, transformation(origin = {-90, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SourceMassFlow sourceMassFlow2(
    redeclare package Medium = ThermoPower.Water.StandardWater, 
    T = 42.88 + 273, 
    h = 183.1e3, 
    p0 = 80e5, 
    use_T = true, 
    w0 = 26.397) annotation(
    Placement(visible = true, transformation(origin = {2, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SteamTurbineStodola steamTurbineStodola1(
    Kt = 0.01328, 
    PRstart = 11.43, 
    explicitIsentropicEnthalpy = false, 
    pnom = 80.0e5, 
    pout(fixed = false), 
    w(fixed = false), 
    wnom = 26.397, 
    wstart = 26.397)  annotation(
    Placement(visible = true, transformation(origin = {12, -72}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));

equation
  connect(sensT2.outlet, sinkPressure1.flange) annotation(
    Line(points = {{56, 14}, {82, 14}}, color = {159, 159, 223}));
  connect(steamTurbineStodola1.outlet, sinkPressure2.flange) annotation(
    Line(points = {{24, -60}, {82, -60}, {82, -60}, {82, -60}}, color = {0, 0, 255}));
  connect(sensT4.outlet, steamTurbineStodola1.inlet) annotation(
    Line(points = {{0, -38}, {0, -38}, {0, -60}, {0, -60}}, color = {0, 0, 255}));
  connect(HX.waterOut, sensT4.inlet) annotation(
    Line(points = {{0, -6}, {0, -26}}, color = {0, 0, 255}));
  connect(sourceMassFlow1.flange, sensT1.inlet) annotation(
    Line(points = {{-80, 14}, {-56, 14}}, color = {159, 159, 223}));
  connect(sensT3.outlet, HX.waterIn) annotation(
    Line(points = {{0, 58}, {0, 58}, {0, 34}, {0, 34}}, color = {0, 0, 255}));
  connect(sourceMassFlow2.flange, sensT3.inlet) annotation(
    Line(points = {{0, 82}, {0, 70}}, color = {0, 0, 255}));
  connect(HX.gasOut, sensT2.inlet) annotation(
    Line(points = {{20, 14}, {44, 14}, {44, 14}, {44, 14}}, color = {159, 159, 223}));
  connect(sensT1.outlet, HX.gasIn) annotation(
    Line(points = {{-44, 14}, {-20, 14}, {-20, 14}, {-20, 14}}, color = {159, 159, 223}));
  annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.3")));end HX_Pump_2_Superheater_2_HPTurbine;
