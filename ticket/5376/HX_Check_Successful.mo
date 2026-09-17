model HX_Check_Successful
  
  ThermoPower.PowerPlants.HRSG.Components.HE HX(FluidPhaseStart = ThermoPower.Choices.FluidPhase.FluidPhases.Steam, Tstartbar_G = 973.15, dpnom_F(displayUnit = "Pa") = 0, dpnom_G = 0, exchSurface_F = 450, exchSurface_G = 2000, extSurfaceTub = 500, fluidNomFlowRate = 55, fluidNomPressure = 100000, fluidVol = 4.5, gasNomFlowRate = 400, gasNomPressure = 100000, gasVol = 10, lambda = 20, metalVol = 1.2, pstart_F = 100000, pstart_G = 100000, rhomcm = 7900, rhonom_F(displayUnit = "kg/m3") = 0.6, rhonom_G(displayUnit = "kg/m3") = 0.33)  annotation(
    Placement(visible = true, transformation(origin = {-1.9984e-15, 1.9984e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure sinkPressure1(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT1(
    redeclare package Medium = ThermoPower.Media.FlueGas, allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {-50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SensT sensT2(
    redeclare package Medium = ThermoPower.Media.FlueGas, allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {50, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SinkPressure sinkPressure2(
    redeclare package Medium = ThermoPower.Water.StandardWater, p0 = 1e5) annotation(
    Placement(visible = true, transformation(origin = {10, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SensT sensT3(
    redeclare package Medium = ThermoPower.Water.StandardWater) annotation(
    Placement(visible = true, transformation(origin = {4, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Water.SensT sensT4(
    redeclare package Medium = ThermoPower.Water.StandardWater, allowFlowReversal = false) annotation(
    Placement(visible = true, transformation(origin = {4, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(
    redeclare package Medium = ThermoPower.Media.FlueGas, T = 700, w0 = 400) annotation(
    Placement(visible = true, transformation(origin = {-90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Water.SourceMassFlow sourceMassFlow2(
    redeclare package Medium = ThermoPower.Water.StandardWater, T = 298.15, p0 = 1e5, use_T = true, w0 = 55) annotation(
    Placement(visible = true, transformation(origin = {2, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(sourceMassFlow1.flange, sensT1.inlet) annotation(
    Line(points = {{-80, 2}, {-69, 2}, {-69, 0}, {-56, 0}}, color = {159, 159, 223}));
  connect(sourceMassFlow2.flange, sensT3.inlet) annotation(
    Line(points = {{0, 82}, {0, 82}, {0, 56}, {0, 56}}, color = {0, 0, 255}));
  connect(sensT2.outlet, sinkPressure1.flange) annotation(
    Line(points = {{56, 0}, {82, 0}, {82, 0}, {82, 0}}, color = {159, 159, 223}));
  connect(HX.gasOut, sensT2.inlet) annotation(
    Line(points = {{20, 0}, {44, 0}, {44, 0}, {44, 0}}, color = {159, 159, 223}));
  connect(sensT1.outlet, HX.gasIn) annotation(
    Line(points = {{-44, 0}, {-20, 0}, {-20, 0}, {-20, 0}}, color = {159, 159, 223}));
  connect(sensT4.outlet, sinkPressure2.flange) annotation(
    Line(points = {{0, -56}, {0, -56}, {0, -92}, {0, -92}}, color = {0, 0, 255}));
  connect(HX.waterOut, sensT4.inlet) annotation(
    Line(points = {{0, -20}, {0, -20}, {0, -44}, {0, -44}}, color = {0, 0, 255}));
  connect(sensT3.outlet, HX.waterIn) annotation(
    Line(points = {{0, 44}, {0, 44}, {0, 20}, {0, 20}}, color = {0, 0, 255}));
  annotation(
    uses(ThermoPower(version = "3.1")));end HX_Check_Successful;
