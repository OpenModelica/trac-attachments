model BraytonCycleLibraryReplica "Brayton Cycle iterations with re-declared mediums and copied values from Library Plant"

//Figure out the importance of table values//
  parameter Real tableEtaC[6, 4]=[0, 95, 100, 105; 1, 82.5e-2, 81e-2,
      80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4,
      82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4]=[0, 95, 100, 105; 1, 38.3e-3, 43e-3,
      46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3;
      4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4]=[0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22,
      26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
      4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
      4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];

  ThermoPower.Gas.Turbine turbine1(
  redeclare package Medium = Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents, 
  Ndesign = 157.08, 
  Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
  Tdes_in = 1400, 
  Tstart_in = 1370, 
  Tstart_out = 800, 
  pstart_in = 7.85e5, 
  pstart_out = 1.52e5, tableEta = tableEtaT, tablePhic = tablePhicT) 
  annotation(
    Placement(visible = true, transformation(origin = {40, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.Compressor compressor1(
  redeclare package Medium = Modelica.Media.Air.SimpleAir, 
  Ndesign = 157.08, 
  Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
  Tdes_in = 244.4, 
  Tstart_in = 244.4, 
  Tstart_out = 600.4, 
  explicitIsentropicEnthalpy = true, 
  pstart_in = 0.343e5, 
  pstart_out = 8.3e5, tableEta = tableEtaC, tablePR = tablePR, tablePhic = tablePhicC) 
  annotation(
    Placement(visible = true, transformation(origin = {-40, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.CombustionChamber combustionChamber1(
  Cm = 1, 
  HH = 41.6e6, 
  S = 0.05, 
  Tstart = 1370, 
  V = 0.05, 
  gamma = 1, 
  initOpt = ThermoPower.Choices.Init.Options.steadyState, 
  pstart = 8.11e5) 
  annotation(
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.PressDrop pressDrop1(
  redeclare package Medium = Modelica.Media.Air.SimpleAir, A = 1, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, Tstart = 600, dpnom = 19000, pstart = 8.3e5, rhonom = 4.7, wnom = 100) 
  annotation(
    Placement(visible = true, transformation(origin = {-32, 14}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  
  ThermoPower.Gas.PressDrop pressDrop2(
  redeclare package Medium = Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents, 
  FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, 
  Tstart = 1370, 
  dpnom = 26000, 
  pstart = 811000, 
  rhonom = 2, 
  wnom = 102) 
  annotation(
    Placement(visible = true, transformation(origin = {32, 14}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(
  redeclare package Medium = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas, T = 300, p0 = 811000, use_in_w0 = true, w0 = 2.02) 
  annotation(
    Placement(visible = true, transformation(origin = {-44, 40}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  ThermoPower.Gas.SourcePressure sourcePressure1(
  redeclare package Medium = Modelica.Media.Air.SimpleAir, 
  T = 244.4, 
  p0 = 34300) 
  annotation(
    Placement(visible = true, transformation(origin = {-92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1(
  redeclare package Medium = Modelica.Media.Air.SimpleAir) 
  annotation(
    Placement(visible = true, transformation(origin = {-22, 30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2(
  redeclare package Medium = Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents) 
  annotation(
    Placement(visible = true, transformation(origin = {22, 30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
  T = 4, 
  initType = Modelica.Blocks.Types.Init.SteadyState, 
  y_start = 500) 
  annotation(
    Placement(visible = true, transformation(origin = {-85, 51}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealInput FuelFlowRate
  annotation(
    Placement(visible = true, transformation(origin = {-142, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-142, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure sinkPressure1(
  redeclare package Medium = Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents, 
  T = 800, 
  p0 = 1.52e5) 
  annotation(
    Placement(visible = true, transformation(origin = {66, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 
  annotation(
    Placement(visible = true, transformation(origin = {60, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  ThermoPower.Electrical.Generator generator1(
  J = 30, 
  initOpt = ThermoPower.Choices.Init.Options.steadyState,
  shaft(phi(start=0, fixed=true))) 
  annotation(
    Placement(visible = true, transformation(origin = {80, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
  T = 1, 
  initType = Modelica.Blocks.Types.Init.SteadyState, 
  k = 1, 
  y_start = 56.8e6) 
  annotation(
    Placement(visible = true, transformation(origin = {80, -36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput GeneratedPower 
  annotation(
    Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Electrical.NetworkGrid_Pmax networkGrid_Pmax1(
  J = 30000, 
  Pmax = 10e6, 
  deltaStart = 0.4, 
  initOpt = ThermoPower.Choices.Init.Options.steadyState)  
  annotation(
    Placement(visible = true, transformation(origin = {106, -8}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));

equation
  connect(firstOrder2.y, GeneratedPower) annotation(
    Line(points = {{86, -36}, {92, -36}, {92, 16}, {106, 16}, {106, 16}}, color = {0, 0, 127}));
  connect(powerSensor1.power, firstOrder2.u) annotation(
    Line(points = {{56, -14}, {56, -36}, {73, -36}}, color = {0, 0, 127}));
  connect(powerSensor1.flange_b, generator1.shaft) annotation(
    Line(points = {{66, -8}, {72, -8}, {72, -8}, {72, -8}}));
  connect(turbine1.shaft_b, powerSensor1.flange_a) annotation(
    Line(points = {{46, -8}, {54, -8}, {54, -8}, {54, -8}, {54, -8}}));
  connect(turbine1.outlet, sinkPressure1.flange) annotation(
    Line(points = {{48, 0}, {48, 0}, {48, 20}, {60, 20}, {60, 20}}, color = {159, 159, 223}));
  connect(sourcePressure1.flange, compressor1.inlet) annotation(
    Line(points = {{-82, 0}, {-48, 0}, {-48, 0}, {-48, 0}}, color = {159, 159, 223}));
  connect(firstOrder1.y, sourceMassFlow1.in_w0) annotation(
    Line(points = {{-80, 52}, {-48, 52}, {-48, 44}, {-48, 44}, {-48, 44}}, color = {0, 0, 127}));
  connect(sourceMassFlow1.flange, combustionChamber1.inf) annotation(
    Line(points = {{-38, 40}, {0, 40}, {0, 40}, {0, 40}}, color = {159, 159, 223}));
  connect(FuelFlowRate, firstOrder1.u) annotation(
    Line(points = {{-142, 18}, {-100, 18}, {-100, 51}, {-91, 51}}, color = {0, 0, 127}));
  connect(pressDrop2.outlet, turbine1.inlet) annotation(
    Line(points = {{32, 8}, {32, 8}, {32, 0}, {32, 0}}, color = {159, 159, 223}));
  connect(pressDrop1.outlet, compressor1.outlet) annotation(
    Line(points = {{-32, 8}, {-32, 8}, {-32, 0}, {-32, 0}}, color = {159, 159, 223}));
  connect(stateReader_gas2.outlet, pressDrop2.inlet) annotation(
    Line(points = {{26, 30}, {32, 30}, {32, 20}, {32, 20}}, color = {159, 159, 223}));
  connect(combustionChamber1.out, stateReader_gas2.inlet) annotation(
    Line(points = {{10, 30}, {18, 30}, {18, 30}, {18, 30}}, color = {159, 159, 223}));
  connect(stateReader_gas1.outlet, combustionChamber1.ina) annotation(
    Line(points = {{-18, 30}, {-10, 30}, {-10, 30}, {-10, 30}}, color = {159, 159, 223}));
  connect(pressDrop1.inlet, stateReader_gas1.inlet) annotation(
    Line(points = {{-32, 20}, {-32, 20}, {-32, 30}, {-26, 30}, {-26, 30}}, color = {159, 159, 223}));
  connect(compressor1.shaft_b, turbine1.shaft_a) annotation(
    Line(points = {{-34, -8}, {34, -8}}));
  annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")));
end BraytonCycleLibraryReplica;
