model MultiSubstanceLiquid
  parameter Modelica.Fluid.Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.av_vb;
  //parameter Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b;
  replaceable package Medium = MixtureIncompressibleLiquid.Examples.PipelineOil constrainedby Modelica.Media.Interfaces.PartialMedium;
  //replaceable package Medium =
  //    Modelica.Media.Water.StandardWaterOnePhase
  //  constrainedby Modelica.Media.Interfaces.PartialMedium;
  import Modelica.Fluid.Types.Dynamics;
  parameter Dynamics systemMassDynamics = if Medium.singleState then Dynamics.SteadyState else Dynamics.SteadyStateInitial;
  parameter Boolean filteredValveOpening = not Medium.singleState;
  inner Modelica.Fluid.System system(massDynamics = systemMassDynamics, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, use_eps_Re = true, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, T_ambient = 300) annotation(Placement(visible = true, transformation(origin = {80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe pipeline(use_T_start = true, diameter = 0.1, redeclare package Medium = Medium, modelStructure = pipeModelStructure, length = 10, nNodes = 10, p_a_start = system.p_ambient) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Sink(nPorts = 1, redeclare package Medium = Medium, p = system.p_ambient, T = system.T_ambient, X = {1.0, 0.0}) annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT SourceGlycol(nPorts = 1, redeclare package Medium = Medium, p = 200000, T = system.T_ambient, use_X_in = false, use_T_in = false, use_p_in = false, X = {1.0, 0.0}) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT SourceWater(nPorts = 1, redeclare package Medium = Medium, p = 200000, T = system.T_ambient, use_X_in = false, use_T_in = false, use_p_in = false, X = {0.0, 1.0}) annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback OpenWaterValve annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const(k = 1.0) annotation(Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible GlycolValve(redeclare package Medium = Medium, m_flow_nominal = 1, rho_nominal = 1000, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.025 ^ 2 / 4 * Modelica.Constants.pi, dp_nominal = 30000, filteredOpening = true) annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveIncompressible WaterValve(redeclare package Medium = Medium, m_flow_nominal = 1, rho_nominal = 1000, CvData = Modelica.Fluid.Types.CvTypes.Av, Av = 0.025 ^ 2 / 4 * Modelica.Constants.pi, dp_nominal = 30000, filteredOpening = true) annotation(Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp OpenGlycolValve(height = 1.0, duration = 50.0, offset = 0.0, startTime = 50.0) annotation(Placement(visible = true, transformation(origin = {0, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(OpenGlycolValve.y, OpenWaterValve.u2) annotation(Line(points = {{11, 80}, {80.326, 80}, {80.326, -59.837}, {-30.7334, -59.837}, {-30.7334, -59.837}}, color = {0, 0, 127}));
  connect(OpenGlycolValve.y, GlycolValve.opening) annotation(Line(points = {{11, 80}, {-40.0466, 80}, {-40.0466, 29.8021}, {-40.0466, 29.8021}}, color = {0, 0, 127}));
  connect(OpenWaterValve.y, WaterValve.opening) annotation(Line(points = {{-40, -51}, {-40, -29.2287}, {-40.5954, -29.2287}, {-40.5954, -29.2287}}));
  connect(SourceWater.ports[1], WaterValve.port_a) annotation(Line(points = {{-70, -40}, {-61.705, -40}, {-61.705, -20.0271}, {-50.0677, -20.0271}, {-50.0677, -20.0271}}));
  connect(SourceGlycol.ports[1], GlycolValve.port_a) annotation(Line(points = {{-70, 40}, {-62.2463, 40}, {-62.2463, 20.0271}, {-50.0677, 20.0271}, {-50.0677, 20.0271}}));
  connect(WaterValve.port_b, pipeline.port_a) annotation(Line(points = {{-30, -20}, {-18.9445, -20}, {-18.9445, -0.270636}, {-11.0961, -0.270636}, {-11.0961, -0.270636}}));
  connect(GlycolValve.port_b, pipeline.port_a) annotation(Line(points = {{-30, 20}, {-18.9445, 20}, {-18.9445, -0.270636}, {-9.742900000000001, -0.270636}, {-9.742900000000001, -0.270636}}));
  connect(const.y, OpenWaterValve.u1) annotation(Line(points = {{-69, -80}, {-40.0541, -80}, {-40.0541, -69.5535}, {-39.5129, -69.5535}, {-39.5129, -69.5535}}));
  connect(Sink.ports[1], pipeline.port_b) annotation(Line(points = {{50, 0}, {69.8241, 0}, {10, 0}, {10, 0}}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end MultiSubstanceLiquid;