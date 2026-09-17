model ThermoPower_HX_Economizer
  ThermoPower.PowerPlants.HRSG.Components.HE Economizer(Cfnom_F = 0, Cfnom_G = 0,FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Liquid, Kfnom_F = 0, Kfnom_G = 0, Tstartbar_G = 604.74, dpnom_F = 0, dpnom_G = 0, exchSurface_F = 2.752, exchSurface_G = 2.752, extSurfaceTub = 2.752, fluidNomFlowRate = 21.5, fluidNomPressure = 8e+06, fluidVol = 4.5, gasNomFlowRate = 169.755, gasNomPressure = 101325, gasVol = 10, lambda = 20, metalVol = 1.2, pstart_F = 8e+06, pstart_G = 101325, rhomcm = 7900, rhonom_F(displayUnit = "kg/m3") = 997, rhonom_G (displayUnit = "kg/m3") = 0.33)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SourceMassFlow Source_FlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, T = 331.59 + 273.15, p0 = 101325, w0 = 169.755)  annotation(
    Placement(visible = true, transformation(origin = {-92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SourceMassFlow Source_Steam(T = 46.45 + 273.15, h = 203.22e3, p0 = 80e5, use_T = true, w0 = 21.5)  annotation(
    Placement(visible = true, transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SensT sensT_WaterIn_Econ annotation(
    Placement(visible = true, transformation(origin = {4, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Water.SensT sensT_WaterOut_Econ annotation(
    Placement(visible = true, transformation(origin = {4, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  ThermoPower.Gas.SensT sensT_ExhaustIn_Econ(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SensT sensT_ExhaustOut_Econ(
    redeclare package Medium = ThermoPower.Media.FlueGas)  annotation(
    Placement(visible = true, transformation(origin = {50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Gas.SinkPressure Sink_FlueGas(
    redeclare package Medium = ThermoPower.Media.FlueGas, p0 = 101325)  annotation(
    Placement(visible = true, transformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoPower.Water.SinkPressure Sink_Steam(p0 = 80e5)  annotation(
    Placement(visible = true, transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sensT_WaterOut_Econ.outlet, Sink_Steam.flange) annotation(
    Line(points = {{0, -56}, {0, -56}, {0, -90}, {0, -90}}, color = {0, 0, 255}));
  connect(sensT_ExhaustOut_Econ.outlet, Sink_FlueGas.flange) annotation(
    Line(points = {{56, 0}, {82, 0}, {82, 0}, {82, 0}}, color = {159, 159, 223}));
  connect(Economizer.gasOut, sensT_ExhaustOut_Econ.inlet) annotation(
    Line(points = {{10, 0}, {44, 0}, {44, 0}, {44, 0}}, color = {159, 159, 223}));
  connect(sensT_ExhaustIn_Econ.outlet, Economizer.gasIn) annotation(
    Line(points = {{-44, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {159, 159, 223}));
  connect(Source_FlueGas.flange, sensT_ExhaustIn_Econ.inlet) annotation(
    Line(points = {{-82, 0}, {-56, 0}, {-56, 0}, {-56, 0}}, color = {159, 159, 223}));
  connect(Economizer.waterOut, sensT_WaterOut_Econ.inlet) annotation(
    Line(points = {{0, -10}, {0, -10}, {0, -44}, {0, -44}}, color = {0, 0, 255}));
  connect(sensT_WaterIn_Econ.outlet, Economizer.waterIn) annotation(
    Line(points = {{0, 44}, {0, 44}, {0, 10}, {0, 10}}, color = {0, 0, 255}));
  connect(Source_Steam.flange, sensT_WaterIn_Econ.inlet) annotation(
    Line(points = {{0, 90}, {0, 90}, {0, 56}, {0, 56}}, color = {0, 0, 255}));
  annotation(
    uses(ThermoPower(version = "3.1")));end ThermoPower_HX_Economizer;
