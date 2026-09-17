model BraytonPowerCycle

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

  ThermoPower.Gas.SourcePressure SourcePressure(
    redeclare package Medium = ThermoPower.Media.Air,  
    R = 0, 
    T = 244.4, 
    p0 = 34300)  annotation(
    Placement(visible = true, transformation(origin = {-92, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.Compressor Compressor(
    redeclare package Medium = ThermoPower.Media.Air,
    Ndesign = 157.08, 
    Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
    Tdes_in = 244.4, 
    Tstart_in = 244.4, 
    Tstart_out = 600.4, 
    explicitIsentropicEnthalpy = true, 
    pstart_in = 0.343e5, 
    pstart_out = 8.3e5, 
    tableEta = tableEtaC, 
    tablePR = tablePR, 
    tablePhic = tablePhicC)  annotation(
    Placement(visible = true, transformation(origin = {-50, -52}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  
  ThermoPower.Gas.Turbine Turbine(
    redeclare package Medium = ThermoPower.Media.FlueGas,
    Ndesign = 157.08, 
    Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
    Tdes_in = 1400, 
    Tstart_in = 1370, 
    Tstart_out = 800, 
    pstart_in = 7.85e5, 
    pstart_out = 1.52e5, 
    tableEta = tableEtaT, 
    tablePhic = tablePhicT)  annotation(
    Placement(visible = true, transformation(origin = {52, -52}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  
  ThermoPower.Gas.PressDrop pressDrop1(
    redeclare package Medium = ThermoPower.Media.Air, 
    A = 1, 
    FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, 
    Tstart = 600, 
    dpnom = 19000, 
    pstart = 8.3e5, 
    rhonom = 4.7, 
    wnom = 100)  annotation(
    Placement(visible = true, transformation(origin = {-32, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  ThermoPower.Gas.PressDrop pressDrop2(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    A = 1, 
    FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, 
    Tstart = 1370, 
    dpnom = 26000, 
    pstart = 811000, 
    rhonom = 2, 
    wnom = 102)  annotation(
    Placement(visible = true, transformation(origin = {30, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1(
    redeclare package Medium = ThermoPower.Media.Air) annotation(
    Placement(visible = true, transformation(origin = {-32, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {30, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Gas.CombustionChamber combustionChamber1(
    Cm = 1, 
    HH = 41.6e6, 
    S = 0.05, 
    Tstart = 1370, 
    V = 0.05, 
    gamma = 1, 
    initOpt = ThermoPower.Choices.Init.Options.steadyState, 
    pstart = 8.11e5)  annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SourceMassFlow sourceMassFlow1(
    redeclare package Medium = ThermoPower.Media.NaturalGas, 
    T = 300, 
    p0 = 811000, 
    use_in_w0 = true, 
    w0 = 2)  annotation(
    Placement(visible = true, transformation(origin = {-32, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T = 4, 
    initType = Modelica.Blocks.Types.Init.SteadyState, 
    k = 1, 
    y_start = 500)  annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SinkPressure SinkPressure(
    redeclare package Medium = ThermoPower.Media.FlueGas) annotation(
    Placement(visible = true, transformation(origin = {92, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1 annotation(
    Placement(visible = true, transformation(origin = {74, -52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  
  ThermoPower.Electrical.Generator Generator(Pnom = 4e6, initOpt = ThermoPower.Choices.Init.Options.steadyState)  annotation(
    Placement(visible = true, transformation(origin = {96, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder PowerSensor(T = 1, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 56.8e6)  annotation(
    Placement(visible = true, transformation(origin = {81, -81}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {111, -81}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {111, -81}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
equation
  connect(PowerSensor.y, y) annotation(
    Line(points = {{89, -81}, {111, -81}}, color = {0, 0, 127}));
  connect(powerSensor1.power, PowerSensor.u) annotation(
    Line(points = {{68, -61}, {68, -81}, {73, -81}}, color = {0, 0, 127}));
  connect(powerSensor1.flange_b, Generator.shaft) annotation(
    Line(points = {{82, -52}, {87, -52}}));
  connect(Turbine.shaft_b, powerSensor1.flange_a) annotation(
    Line(points = {{60, -52}, {66, -52}}));
  connect(Compressor.shaft_b, Turbine.shaft_a) annotation(
    Line(points = {{-42, -52}, {44, -52}, {44, -52}, {44, -52}}));
  connect(SinkPressure.flange, Turbine.outlet) annotation(
    Line(points = {{82, -10}, {80, -10}, {80, -40}, {64, -40}, {64, -40}}, color = {159, 159, 223}));
  connect(firstOrder1.y, sourceMassFlow1.in_w0) annotation(
    Line(points = {{-64, 60}, {-38, 60}, {-38, 56}, {-38, 56}, {-38, 56}}, color = {0, 0, 127}));
  connect(sourceMassFlow1.flange, combustionChamber1.inf) annotation(
    Line(points = {{-22, 50}, {0, 50}, {0, 50}, {0, 50}}, color = {159, 159, 223}));
  connect(pressDrop2.outlet, Turbine.inlet) annotation(
    Line(points = {{30, -16}, {30, -16}, {30, -40}, {40, -40}, {40, -40}}, color = {159, 159, 223}));
  connect(pressDrop1.inlet, Compressor.outlet) annotation(
    Line(points = {{-32, -16}, {-32, -16}, {-32, -40}, {-38, -40}, {-38, -40}}, color = {159, 159, 223}));
  connect(SourcePressure.flange, Compressor.inlet) annotation(
    Line(points = {{-82, -10}, {-80, -10}, {-80, -41}, {-61, -41}}, color = {159, 159, 223}));
  connect(stateReader_gas2.outlet, pressDrop2.inlet) annotation(
    Line(points = {{30, 16}, {30, 16}, {30, 4}, {30, 4}}, color = {159, 159, 223}));
  connect(combustionChamber1.out, stateReader_gas2.inlet) annotation(
    Line(points = {{10, 40}, {28, 40}, {28, 40}, {30, 40}, {30, 28}, {30, 28}, {30, 28}}, color = {159, 159, 223}));
  connect(stateReader_gas1.outlet, combustionChamber1.ina) annotation(
    Line(points = {{-32, 28}, {-32, 28}, {-32, 40}, {-10, 40}, {-10, 40}}, color = {159, 159, 223}));
  connect(pressDrop1.outlet, stateReader_gas1.inlet) annotation(
    Line(points = {{-32, 4}, {-32, 4}, {-32, 16}, {-32, 16}}, color = {159, 159, 223}));
  connect(u, firstOrder1.u) annotation(
    Line(points = {{-100, 60}, {-78, 60}, {-78, 60}, {-78, 60}}, color = {0, 0, 127}));

annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.3")));end BraytonPowerCycle;
