model test_tank 
  extends Modelica.Icons.Example; 
  //incompressible case PD = f(m_flow) 
  Modelica.SIunits.MassFlowRate m_flow = pipe.flowModel.m_flows[1] "Input mass flow rate"; 
  Modelica.SIunits.Pressure DP1 "Output turbulent flow pressure drop"; 
  Modelica.SIunits.Pressure DP2 "Output laminar flow pressure drop"; 
  Real DPT(fixed = false); 
  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, use_eps_Re = true) annotation(Placement(visible = true, transformation(origin = {55.4281,65.428}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
  Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_con dp_turbulent_in_con1(L = pipe.length, d_hyd = pipe.diameter, K = pipe.roughness) annotation(Placement(visible = true, transformation(origin = {-80.3742,-22.6106}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
  Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_var dp_laminar_in_var1(eta = Modelica.Media.Water.ConstantPropertyLiquidWater.eta_const, rho = Modelica.Media.Water.ConstantPropertyLiquidWater.d_const) annotation(Placement(visible = true, transformation(origin = {-13.6273,-68.5371}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
  Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_IN_con dp_laminar_in_con1(d_hyd = pipe.diameter, L = pipe.length) annotation(Placement(visible = true, transformation(origin = {-46.2926,-62.7255}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
  Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_IN_var dp_turbulent_in_var1(eta = Modelica.Media.Water.ConstantPropertyLiquidWater.eta_const, rho = Modelica.Media.Water.ConstantPropertyLiquidWater.d_const) annotation(Placement(visible = true, transformation(origin = {-80.8138,-52.2303}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
  Modelica.Fluid.Vessels.OpenTank tank2(crossArea = 1, redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts = 1, height = 11, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.1, height = 0.5)}, level_start = 0.0000000001) annotation(Placement(visible = true, transformation(origin = {65.9816,17.5947}, extent = {{-20,-20},{20,20}}, rotation = 0))); 
  Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts = 1, crossArea = 1, level_start = 10, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 0.1)}, height = 11) annotation(Placement(visible = true, transformation(origin = {-70.2533,20.1745}, extent = {{-20,-20},{20,20}}, rotation = 0))); 
  Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, length = 20, diameter = 0.1, height_ab = 0) annotation(Placement(visible = true, transformation(origin = {22.6875,-21.4505}, extent = {{-10,-10},{10,10}}, rotation = 360))); 
  Modelica.Fluid.Machines.PrescribedPump pump(checkValve = true, N_nominal = 1000, redeclare function flowCharacteristic = Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow(V_flow_nominal = {0,0.25,0.5}, head_nominal = {100,60,0}), use_N_in = false, nParallel = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, V(displayUnit = "l") = 0.05, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater) annotation(Placement(visible = true, transformation(origin = {-27.4994,-20.8731}, extent = {{-10,-10},{10,10}}, rotation = 0))); 
equation 
  connect(tank1.ports[1],pump.port_a); 
  connect(pump.port_b,pipe.port_a); 
  connect(pipe.port_b,tank2.ports[1]); 
  //incompressible case 
  DP1 = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_turbulent_DP(dp_turbulent_in_con1, dp_turbulent_in_var1, m_flow); 
  DP2 = Modelica.Fluid.Dissipation.PressureLoss.StraightPipe.dp_laminar_DP(dp_laminar_in_con1, dp_laminar_in_var1, m_flow); 
  DPT = DP1 + DP2; 
end test_tank;