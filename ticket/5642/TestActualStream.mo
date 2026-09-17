model TestActualStream
  Modelica.Fluid.Sources.FixedBoundary source( redeclare package Medium = Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient,nPorts = 1, p = 1e5)  annotation(
    Placement(visible = true, transformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink( redeclare package Medium = Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient,nPorts = 1, p = 2e5)  annotation(
    Placement(visible = true, transformation(origin = {42, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient, diameter = 0.025, length = 10) annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Machines.ControlledPump pump(redeclare package Medium = Modelica.Media.CompressibleLiquids.LinearWater_pT_Ambient, m_flow_nominal = 1, p_a_nominal = 1e5, p_b_nominal = 2e5) annotation(
    Placement(visible = true, transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system(allowFlowReversal = false)  annotation(
    Placement(visible = true, transformation(origin = {-88, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(source.ports[1], pipe.port_a) annotation(
    Line(points = {{-52, 0}, {-40, 0}, {-40, 0}, {-40, 0}}, color = {0, 127, 255}));
  connect(pipe.port_b, pump.port_a) annotation(
    Line(points = {{-20, 0}, {-6, 0}, {-6, 0}, {-6, 0}}, color = {0, 127, 255}));
  connect(pump.port_b, sink.ports[1]) annotation(
    Line(points = {{14, 0}, {30, 0}, {30, 0}, {32, 0}}, color = {0, 127, 255}));

annotation(
    uses(Modelica(version = "3.2.3")));
end TestActualStream;
