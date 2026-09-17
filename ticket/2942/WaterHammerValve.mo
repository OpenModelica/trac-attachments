model WaterHammerValve
  extends Modelica.Icons.Example;
  parameter Modelica.Fluid.Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.av_vb;
  //parameter Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b;
  replaceable package Medium = Modelica.Media.CompressibleLiquids.LinearColdWater constrainedby Modelica.Media.Interfaces.PartialMedium;
  //replaceable package Medium =
  //    Modelica.Media.Water.StandardWaterOnePhase
  //  constrainedby Modelica.Media.Interfaces.PartialMedium;
  import Modelica.Fluid.Types.Dynamics;
  parameter Dynamics systemMassDynamics = if Medium.singleState then Dynamics.SteadyState else Dynamics.SteadyStateInitial;
  parameter Boolean filteredValveOpening = not Medium.singleState;
  inner Modelica.Fluid.System system(massDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, use_eps_Re = true, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, T_ambient = 300) annotation(Placement(transformation(extent = {{90, -92}, {110, -72}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible Valve(redeclare package Medium = Medium, m_flow_nominal = 1, rho_nominal = 1000, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.025 ^ 2 / 4 * Modelica.Constants.pi, dp_nominal = 30000, opening_nominal = 1) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp OpenCloseSignal(height = -1, duration = 5, offset = 1, startTime = 10) annotation(Placement(visible = true, transformation(origin = {-20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe Pipeline(use_T_start = true, length = 50, diameter = 0.025, redeclare package Medium = Medium, modelStructure = pipeModelStructure, redeclare model FlowModel = Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow, nNodes = 50) annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Source(nPorts = 1, redeclare package Medium = Medium, p = 500000.0, T = system.T_ambient) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts = 1, redeclare package Medium = Medium, T = system.T_ambient, p = 450000) annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe Pipe(use_T_start = true, diameter = 0.025, redeclare package Medium = Medium, modelStructure = pipeModelStructure, redeclare model FlowModel = Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow, length = 0.5, nNodes = 2) annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(OpenCloseSignal.y, Valve.opening) annotation(Line(points = {{-9, -40}, {0.357782, -40}, {0.357782, -8.94454}, {0.357782, -8.94454}}));
  connect(Pipe.port_b, Sink.ports[1]) annotation(Line(points = {{70, 0}, {86.941, 0}, {86.941, -0.715564}, {86.941, -0.715564}}));
  connect(Valve.port_b, Pipe.port_a) annotation(Line(points = {{10, 0}, {50.0894, 0}, {50.0894, 0}, {50.0894, 0}}));
  connect(Pipeline.port_b, Valve.port_a) annotation(Line(points = {{-30, 0}, {-9.66011, 0}, {-9.66011, -0.715564}, {-9.66011, -0.715564}}));
  connect(Source.ports[1], Pipeline.port_a) annotation(Line(points = {{-67, 0}, {-50.0894, 0}, {-50.0894, -0.357782}, {-50.0894, -0.357782}}));
  annotation(Documentation(info = "<html>
 <p>
 This example demonstrates two aspects: the treatment of multi-way connections
 and the usage of an incompressible medium model.
 </p><p>
 Eleven pipe models with nNodes=2 each introduce 22 temperature states and and 22 pressure states.
 When configuring <b>pipeModelStructure=a_v_b</b>, the flow models at the pipe ports constitute algebraic loops for the pressures.
 A common work-around is to introduce \"mixing volumes\" in critical connections.
 </p><p>
 Here the problem is treated alternatively with the default <b>pipeModelStructure=av_vb</b> of the
 <a href=\"modelica://Modelica.Fluid.Pipes.DynamicPipe\">DynamicPipe</a> model.
 Each pipe exposes the states of the outer fluid segments to the respective fluid ports.
 Consequently the pressures of all connected pipe segments get lumped together into one mass balance spanning the whole connection set.
 Overall this treatment as high-index DAE results in the reduction to 9 pressure states, preventing algebraic loops in connections.
 This can be studied with a rigorous medium model like <b>StandardWaterOnePhase</b>.
 </p><p>
 The pressure dynamics completely disappears with an incompressible medium model, like the used <b>Glycol47</b>.
 It appears reasonable to assume steady-state mass balances in this case
 (see parameter systemMassDynamics used in system.massDynamics, tab Assumptions).
 </p><p>
 Note that with the stream concept in the fluid ports, the energy and substance balances of the connected pipe segments remain independent
 from each other, despite of pressures being lumped together. The following simulation results can be observed:
 </p>
 <ol>
 <li>The simulation starts with system.T_ambient as initial temperature in all pipes.
     The temperatures upstream or bypassing pipe8 are approaching the value of 26.85 degC from the source, including also pipe9.
     The temperatures downstream of pipe8 take a higher value, depending on the mixing with heated fluid, see e.g. pipe10.</li>
 <li>After 50s valve1 fully closes. This causes flow reversal in pipe8. Now heated fluid flows from pipe8 to pipe9.
     Note that the temperature of the connected pipe7 remains unchanged as there is no flow into pipe7.
     The temperature of pipe10 cools down to the source temperature.</li>
 <li>After 100s valve2 closes half way, which affects mass flow rates and temperatures.</li>
 <li>After 150s valve5 closes half way, which affects mass flow rates and temperatures.</li>
 </ol>
 <p>
 The fluid temperatures in the pipes of interest are exposed through heatPorts.
 </p>
 <img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/IncompressibleFluidNetwork.png\" border=\"1\"
      alt=\"IncompressibleFluidNetwork.png\">
 </html>"), __Dymola_Commands(file = "modelica://Modelica/Resources/Scripts/Dymola/Fluid/IncompressibleFluidNetwork/plotResults.mos" "plotResults"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {120, 100}})), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {120, 100}})), experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.01));
end WaterHammerValve;