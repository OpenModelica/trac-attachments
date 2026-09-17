model Rankine_HRSG
  
  ThermoPower.PowerPlants.HRSG.Components.HE Superheater(
    Cfnom_F = 0, 
    Cfnom_G = 0, 
    FFtype_F = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, 
    FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, 
    FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, 
    HCtype_F = ThermoPower.Choices.Flow1D.HCtypes.Downstream, 
    Kfnom_F = 0, 
    Kfnom_G = 0, 
    N_F = 2, 
    N_G = 2, 
    Nt = 1, 
    Tstartbar_G = 1073.15, 
    dpnom_F = 0, 
    dpnom_G = 0, 
    exchSurface_F = 10, 
    exchSurface_G = 10, 
    extSurfaceTub = 20, 
    fluidNomFlowRate = 50, 
    fluidNomPressure = 1e+06, 
    fluidVol = 10, 
    gasNomFlowRate = 102, 
    gasNomPressure = 101325, 
    gasQuasiStatic = false, 
    gasVol = 10, 
    lambda = 366, 
    metalVol = 10, 
    pstart_F = 5e+06, 
    pstart_G = 101325, 
    rhonom_F = 1000, 
    rhonom_G = 0.33)
      annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.PowerPlants.HRSG.Components.HE Economizer(
    Cfnom_F = 0,
    Cfnom_G = 0, 
    FFtype_F = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, 
    FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, 
    FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, 
    HCtype_F = ThermoPower.Choices.Flow1D.HCtypes.Downstream, 
    Kfnom_F = 0, 
    Kfnom_G = 0, 
    N_F = 2, 
    N_G = 2, 
    Nt = 1, 
    Tstartbar_G = 1023.15, 
    dpnom_F = 0, 
    dpnom_G = 0, 
    exchSurface_F = 10, 
    exchSurface_G = 10, 
    extSurfaceTub = 20, 
    fluidNomFlowRate = 50, 
    fluidNomPressure = 1e+06, 
    fluidVol = 10, 
    gasNomFlowRate = 102, 
    gasNomPressure = 101325, 
    gasVol = 10, 
    lambda = 366, 
    metalVol = 10, 
    pstart_F = 5e+06, 
    pstart_G = 101325, 
    rhonom_F = 1000, 
    rhonom_G = 0.33)
      annotation(
    Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Examples.HRB.Models.Evaporator Evaporator(
    Cfnom_G = 0, 
    FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, 
    Kfnom_G = 0,
    N = 2, 
    Tstart = 1048.15, 
    cm = 376.812, 
    dpnom_G = 0, 
    exchSurface = 10, 
    fluidNomFlowRate = 50, 
    fluidNomPressure = 1e+06, 
    fluidVol = 10, 
    gamma = 300, 
    gasNomFlowRate = 102, 
    gasNomPressure = 101325, 
    gasVol = 10, 
    metalVol = 10, 
    rhom = 8400, 
    rhonom_G = 0.33)
      annotation(
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Gas.SourcePressure FlueGasSource(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    R = 0, 
    T = 800, 
    p0 = 101325)
      annotation(
    Placement(visible = true, transformation(origin = {94, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Gas.SinkPressure FlueGasSink(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    R = 0, 
    T = 700, 
    p0 = 101325)
      annotation(
    Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Water.SteamTurbineStodola SteamTurbine(
    PRstart = 1,
    eta_iso_nom = 0.92, 
    explicitIsentropicEnthalpy = true, 
    partialArc_nom = 1, 
    pnom = 10e5, 
    wnom = 50, 
    wstart = 50)
      annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Examples.RankineCycle.Models.PrescribedPressureCondenser Condenser(
    Vtot = 10, 
    p = 1e+06)
      annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.Pump Pump(
    Np0 = 1, 
    V = 10, 
    dp0 = 0, 
    hstart = 1e5, 
    n0 = 150, 
    n_const = 150, 
    q_single(fixed = true, start = 10), 
    w0 = 50, 
    w_single(fixed = true), 
    wstart = 50)
      annotation(
    Placement(visible = true, transformation(origin = {-38, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Mechanics.Rotational.Sensors.PowerSensor PowerSensor annotation(
    Placement(visible = true, transformation(origin = {-38, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  ThermoPower.Electrical.Generator Generator annotation(
    Placement(visible = true, transformation(origin = {-64, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder1 annotation(
    Placement(visible = true, transformation(origin = {-50, 92}, extent = {{-8, -8}, {8, 8}}, rotation = 180)));
  
  Modelica.Blocks.Interfaces.RealOutput Power annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

equation
  connect(SteamTurbine.shaft_b, PowerSensor.flange_a) annotation(
    Line(points = {{-6, 80}, {-14, 80}, {-14, 68}, {-28, 68}}));
  connect(SteamTurbine.outlet, Condenser.steamIn) annotation(
    Line(points = {{-8, 72}, {-8, 52}, {-50, 52}, {-50, 40}}, color = {0, 0, 255}));
  connect(Superheater.waterOut, SteamTurbine.inlet) annotation(
    Line(points = {{50, 60}, {50, 64}, {8, 64}, {8, 72}}, color = {0, 0, 255}));
  connect(Evaporator.waterOut, Superheater.waterIn) annotation(
    Line(points = {{50, 10}, {50, 10}, {50, 40}, {50, 40}}, color = {0, 0, 255}));
  connect(Economizer.waterOut, Evaporator.waterIn) annotation(
    Line(points = {{50, -40}, {50, -40}, {50, -10}, {50, -10}}, color = {0, 0, 255}));
  connect(firstOrder1.y, Power) annotation(
    Line(points = {{-58, 92}, {-90, 92}, {-90, 0}, {-102, 0}, {-102, 0}, {-110, 0}}, color = {0, 0, 127}));
  connect(PowerSensor.power, firstOrder1.u) annotation(
    Line(points = {{-30, 80}, {-30, 80}, {-30, 92}, {-40, 92}, {-40, 92}, {-40, 92}}, color = {0, 0, 127}));
  connect(PowerSensor.flange_b, Generator.shaft) annotation(
    Line(points = {{-48, 68}, {-49, 68}, {-49, 80}, {-56, 80}}));
  connect(Condenser.waterOut, Pump.infl) annotation(
    Line(points = {{-50, 20}, {-50, -10}, {-46, -10}}, color = {0, 0, 255}));
  connect(Pump.outfl, Economizer.waterIn) annotation(
    Line(points = {{-32, -4}, {-26, -4}, {-26, -80}, {50, -80}, {50, -60}, {50, -60}}, color = {0, 0, 255}));
  connect(Economizer.gasOut, FlueGasSink.flange) annotation(
    Line(points = {{40, -50}, {20, -50}, {20, -50}, {20, -50}}, color = {159, 159, 223}));
  connect(Superheater.gasOut, Evaporator.gasIn) annotation(
    Line(points = {{40, 50}, {20, 50}, {20, 30}, {80, 30}, {80, 0}, {60, 0}}, color = {159, 159, 223}));
  connect(Evaporator.gasOut, Economizer.gasIn) annotation(
    Line(points = {{40, 0}, {20, 0}, {20, -26}, {20, -26}, {20, -30}, {80, -30}, {80, -50}, {60, -50}, {60, -50}}, color = {159, 159, 223}));
  connect(FlueGasSource.flange, Superheater.gasIn) annotation(
    Line(points = {{84, 50}, {60, 50}, {60, 50}, {60, 50}}, color = {159, 159, 223}));

annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")));end Rankine_HRSG;
