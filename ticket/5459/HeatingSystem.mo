within ;
model HeatingSystem "Simple model of a heating system"
  extends Modelica.Icons.Example;
   replaceable package Medium =
      Modelica.Media.Water.StandardWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  Modelica.Fluid.Vessels.OpenTank tank(
    redeclare package Medium = Medium,
    crossArea=0.01,
    height=2,
    level_start=1,
    nPorts= 2,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_HeatTransfer=true,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.01),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.01)},
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer (k=10),
    ports(each p(start=1.1e5)),
    T_start=Modelica.SIunits.Conversions.from_degC(20))
              annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Fluid.Machines.ControlledPump pump(
    redeclare package Medium = Medium,
    N_nominal=1500,
    use_T_start=true,
    T_start=Modelica.SIunits.Conversions.from_degC(40),
    m_flow_start=0.01,
    m_flow_nominal=0.01,
    control_m_flow=false,
    allowFlowReversal=false,
    p_a_start=110000,
    p_b_start=130000,
    p_a_nominal=110000,
    p_b_nominal=130000)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Fluid.Valves.ValveIncompressible valve(
    redeclare package Medium = Medium,
    CvData=Modelica.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=0.01,
    show_T=true,
    allowFlowReversal=false,
    dp_start=18000,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow burner(
                                                     Q_flow=1.6e3,
    T_ref=343.15,
    alpha=-0.5)
    annotation (Placement(transformation(extent={{16,30},{36,50}})));
  inner Modelica.Fluid.System system(
      m_flow_small=1e-4, energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
                        annotation (Placement(transformation(extent={{-90,70},{
            -70,90}})));
  Modelica.Fluid.Pipes.DynamicPipe heater(
    redeclare package Medium = Medium,
    use_T_start=true,
    T_start=Modelica.SIunits.Conversions.from_degC(80),
    length=2,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    diameter=0.01,
    nNodes=1,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_HeatTransfer=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    p_a_start=130000)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Blocks.Sources.Step handle(
    startTime=2000,
    height=0.9,
    offset=0.1) annotation (Placement(transformation(extent={{26,-27},{40,-13}})));
protected
  Modelica.Blocks.Interfaces.RealOutput tankLevel
                                 annotation (Placement(transformation(extent={{-56,34},
            {-44,46}})));
equation
  tankLevel = tank.level;
  connect(tank.ports[1], pump.port_a) annotation(
    Line(points = {{-68, 30}, {-68, 20}, {-50, 20}}, color = {0, 127, 255}));
  connect(handle.y, valve.opening) annotation(
    Line(points = {{40.7, -20}, {50, -20}, {50, -62}}, color = {0, 0, 127}));
  connect(burner.port, heater.heatPorts[1]) annotation(
    Line(points = {{36, 40}, {40.1, 40}, {40.1, 24.4}}, color = {191, 0, 0}));
  connect(heater.port_b, valve.port_a) annotation(
    Line(points = {{50, 20}, {84, 20}, {84, -70}, {60, -70}, {60, -70}}, color = {0, 127, 255}));
  connect(valve.port_b, tank.ports[2]) annotation(
    Line(points = {{40, -70}, {-72, -70}, {-72, 30}, {-70, 30}}, color = {0, 127, 255}));
  connect(pump.port_b, heater.port_a) annotation(
    Line(points = {{-30, 20}, {30, 20}, {30, 20}, {30, 20}}, color = {0, 127, 255}));
  annotation (Documentation(info="<html>
<p>
Simple heating system with a closed flow cycle.
After 2000s of simulation time the valve fully opens. A simple idealized control is embedded
into the respective components, so that the heating system can be regulated with the valve:
the pump controls the pressure, the burner controls the temperature.
</p>
<p>
One can investigate the temperatures and flows for different settings of <code>system.energyDynamics</code>
(see Assumptions tab of the system object).</p>
<ul>
<li>With <code>system.energyDynamics==Types.Dynamics.FixedInitial</code> the states need to find their steady values during the simulation.</li>
<li>With <code>system.energyDynamics==Types.Dynamics.SteadyStateInitial</code> (default setting) the simulation starts in steady-state.</li>
<li>With <code>system.energyDynamics==Types.Dynamics.SteadyState</code> all but one dynamic states are eliminated.
    The left state <code>tank.m</code> is to account for the closed flow cycle. It is constant as outflow and inflow are equal
    in a steady-state simulation.</li>
</ul>
<p>
Note that a closed flow cycle generally causes circular equalities for the mass flow rates and leaves the pressure undefined.
This is why the tank.massDynamics, i.e., the tank level determining the port pressure, is modified locally to Types.Dynamics.FixedInitial.
</p>
<p>
Also note that the tank is thermally isolated against its ambient. This way the temperature of the tank is also
well defined for zero flow rate in the heating system, e.g., for valveOpening.offset=0 at the beginning of a simulation.
The pipe however is assumed to be perfectly isolated.
If steady-state values shall be obtained with the valve fully closed, then a thermal
coupling between the pipe and its ambient should be defined as well.
</p>
<p>
Moreover it is worth noting that the idealized direct connection between the heater and the pipe, resulting in equal port pressures,
is treated as high-index DAE, as opposed to a nonlinear equation system for connected pressure loss correlations. A pressure loss correlation
could be additionally introduced to model the fitting between the heater and the pipe, e.g., to adapt different diameters.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/HeatingSystem.png\" border=\"1\"
     alt=\"HeatingSystem.png\">
</html>"), experiment(StopTime=6000),
    __Dymola_Commands(file(ensureSimulated=true)=
        "modelica://Modelica/Resources/Scripts/Dymola/Fluid/HeatingSystem/plotResults.mos"
        "plotResults"),
    uses(Modelica(version="3.2.3")));
end HeatingSystem;
