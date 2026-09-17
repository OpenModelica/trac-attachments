model BraytonCycle_CombinedCycle_1

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
  
  Modelica.Blocks.Interfaces.RealInput FuelFlowRate 
   annotation(
    Placement(visible = true, transformation(origin = {-110, -1.77636e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -1.77636e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.SourceMassFlow SourceW1(
    redeclare package Medium = ThermoPower.Media.NaturalGas, 
    T = 300, 
    p0 = 811000, 
    use_in_w0 = true, 
    w0 = 2.0)
      annotation(
    Placement(visible = true, transformation(origin = {-44, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder GasFlowActuator(
    T = 4, 
    initType = Modelica.Blocks.Types.Init.SteadyState, 
    y_start = 500)  
      annotation(
    Placement(visible = true, transformation(origin = {-85, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  
  ThermoPower.Gas.CombustionChamber combustionChamber1(
    Cm=1,
    HH=41.6e6,
    S=0.05, Tmstart = 300,
    Tstart=1370,
    V=0.05,gamma=1,
    initOpt=ThermoPower.Choices.Init.Options.steadyState,
    pstart=8.11e5)
      annotation(
    Placement(visible = true, transformation(origin = {4.44089e-16, 60}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  
  ThermoPower.Gas.SourcePressure SourceP1(
    redeclare package Medium = ThermoPower.Media.Air, T = 293, p0 = 101325)
      annotation(
    Placement(visible = true, transformation(origin = {-96, -18}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  
  ThermoPower.Gas.Compressor compressor1(
    redeclare package Medium = ThermoPower.Media.Air, 
    Ndesign = 157.08, 
    Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
    Tdes_in = 293, 
    Tstart_in = 293, 
    Tstart_out = 600, 
    explicitIsentropicEnthalpy = true, 
    pstart_in = 1.01325e5, 
    pstart_out = 8.3e5, 
    tableEta = tableEtaC, 
    tablePR = tablePR, 
    tablePhic = tablePhicC)
      annotation(
    Placement(visible = true, transformation(origin = {-59, -31}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  
  ThermoPower.Gas.Turbine turbine1(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    Ndesign = 157.08, 
    Table = ThermoPower.Choices.TurboMachinery.TableTypes.matrix, 
    Tdes_in = 1370, 
    Tstart_in = 1370, 
    Tstart_out = 800, 
    pstart_in = 711000, 
    pstart_out = 101325, 
    tableEta = tableEtaT, 
    tablePhic = tablePhicT)
      annotation(
    Placement(visible = true, transformation(origin = {52, -30}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  
  ThermoPower.Gas.PressDrop pressDrop1(
    redeclare package Medium = ThermoPower.Media.Air, 
    A = 1, 
    Tstart = 600, 
    dpnom = 19000, 
    pstart = 8.3e5, 
    rhonom = 4.7, 
    wnom = 100) 
      annotation(
    Placement(visible = true, transformation(origin = {-46, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.Gas.PressDrop pressDrop2(
    redeclare package Medium = ThermoPower.Media.FlueGas, 
    A = 1, 
    FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, 
    Tstart = 1370, 
    dpnom = 100000, 
    pstart = 811000, 
    rhonom = 2, 
    wnom = 102)    
      annotation(
    Placement(visible = true, transformation(origin = {40, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas1(
    redeclare package Medium = ThermoPower.Media.Air)
      annotation(
    Placement(visible = true, transformation(origin = {-46, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas2(
    redeclare package Medium = ThermoPower.Media.FlueGas)
      annotation(
    Placement(visible = true, transformation(origin = {40, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1
   annotation(
    Placement(visible = true, transformation(origin = {78, -30}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  
  ThermoPower.Electrical.Generator generator1(
    J = 30, 
    initOpt = ThermoPower.Choices.Init.Options.steadyState) 
      annotation(
    Placement(visible = true, transformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Electrical.NetworkGrid_Pmax networkGrid_Pmax1(
    J = 30, 
    Pmax = 10e6, 
    initOpt = ThermoPower.Choices.Init.Options.steadyState) 
      annotation(
    Placement(visible = true, transformation(origin = {126, -30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T = 1, 
    initType = Modelica.Blocks.Types.Init.SteadyState, 
    y_start = 56.8e6) 
    annotation(
    Placement(visible = true, transformation(origin = {83, -55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput GeneratedPower
   annotation(
    Placement(visible = true, transformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner ThermoPower.System system annotation(
    Placement(visible = true, transformation(origin = {88, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  ThermoPower.Gas.FlangeA ExhaustOutlet(
    redeclare package Medium = ThermoPower.Media.FlueGas)
      annotation(
    Placement(visible = true, transformation(origin = {84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(turbine1.outlet, ExhaustOutlet) annotation(
    Line(points = {{64, -18}, {64, -18}, {64, 0}, {84, 0}, {84, -2}}, color = {159, 159, 223}));
  connect(SourceP1.flange, compressor1.inlet) annotation(
    Line(points = {{-88, -18}, {-70, -18}}, color = {159, 159, 223}));
  connect(GasFlowActuator.y, SourceW1.in_w0) annotation(
    Line(points = {{-80, 86}, {-50, 86}, {-50, 81}}, color = {0, 0, 127}));
  connect(SourceW1.flange, combustionChamber1.inf) annotation(
    Line(points = {{-34, 76}, {0, 76}, {0, 74}}, color = {159, 159, 223}));
  connect(firstOrder1.y, GeneratedPower) annotation(
    Line(points = {{88, -54}, {110, -54}}, color = {0, 0, 127}));
  connect(powerSensor1.power, firstOrder1.u) annotation(
    Line(points = {{74, -36}, {74, -55}, {77, -55}}, color = {0, 0, 127}));
  connect(powerSensor1.flange_b, generator1.shaft) annotation(
    Line(points = {{84, -30}, {92, -30}, {92, -30}, {92, -30}}));
  connect(turbine1.shaft_b, powerSensor1.flange_a) annotation(
    Line(points = {{60, -30}, {72, -30}, {72, -30}, {72, -30}}));
  connect(compressor1.shaft_b, turbine1.shaft_a) annotation(
    Line(points = {{-50, -30}, {44, -30}}));
  connect(pressDrop2.outlet, turbine1.inlet) annotation(
    Line(points = {{40, 8}, {40, 8}, {40, -18}, {40, -18}}, color = {159, 159, 223}));
  connect(stateReader_gas2.outlet, pressDrop2.inlet) annotation(
    Line(points = {{40, 42}, {40, 42}, {40, 28}, {40, 28}}, color = {159, 159, 223}));
  connect(combustionChamber1.out, stateReader_gas2.inlet) annotation(
    Line(points = {{14, 60}, {40, 60}, {40, 56}, {40, 56}, {40, 54}}, color = {159, 159, 223}));
  connect(stateReader_gas1.inlet, combustionChamber1.ina) annotation(
    Line(points = {{-46, 54}, {-46, 54}, {-46, 60}, {-14, 60}, {-14, 60}}, color = {159, 159, 223}));
  connect(pressDrop1.inlet, stateReader_gas1.outlet) annotation(
    Line(points = {{-46, 28}, {-46, 28}, {-46, 42}, {-46, 42}}, color = {159, 159, 223}));
  connect(compressor1.outlet, pressDrop1.outlet) annotation(
    Line(points = {{-46, -18}, {-46, 8}}, color = {159, 159, 223}));
  connect(FuelFlowRate, GasFlowActuator.u) annotation(
    Line(points = {{-110, 0}, {-100, 0}, {-100, 85}, {-91, 85}}, color = {0, 0, 127}));
  annotation(
    uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")));end BraytonCycle_CombinedCycle_1;
