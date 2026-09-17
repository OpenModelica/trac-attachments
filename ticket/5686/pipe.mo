model pipe
replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase
    constrainedby Modelica.Media.Interfaces.PartialMedium;
    
  input Modelica.Fluid.Sources.MassFlowSource_T Input(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Fluid.Sources.FixedBoundary Output(redeclare package Medium = Medium, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {62, 2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.DynamicPipe dynamicPipe(redeclare package Medium = Medium, diameter = 0.025, length = 100, nNodes = 3, use_HeatTransfer = true)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow pipeHeatFlow annotation(
    Placement(visible = true, transformation(origin = {-40, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 5, freqHz = 0.01, offset = 293)  annotation(
    Placement(visible = true, transformation(origin = {-86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-88, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Tpipe_in annotation(
    Placement(visible = true, transformation(origin = {64, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Tpipe_out annotation(
    Placement(visible = true, transformation(origin = {66, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qpipe_in annotation(
    Placement(visible = true, transformation(origin = {-94, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Qpipe_in, pipeHeatFlow.Q_flow) annotation(
    Line(points = {{-94, 66}, {-52, 66}, {-52, 66}, {-50, 66}}, color = {0, 0, 127}));
  connect(temperature.T, Tpipe_out) annotation(
    Line(points = {{30, 12}, {30, 12}, {30, 40}, {66, 40}, {66, 40}}, color = {0, 0, 127}));
  connect(temperature.port_b, Output.ports[1]) annotation(
    Line(points = {{40, 0}, {52, 0}, {52, 2}, {52, 2}}, color = {0, 127, 255}));
  connect(dynamicPipe.port_b, temperature.port_a) annotation(
    Line(points = {{10, 0}, {20, 0}, {20, 0}, {20, 0}}, color = {0, 127, 255}));
  connect(pipeHeatFlow.port, dynamicPipe.heatPorts[1]) annotation(
    Line(points = {{-30, 66}, {0, 66}, {0, 4}}, color = {191, 0, 0}));
  connect(const.y, Input.m_flow_in) annotation(
    Line(points = {{-77, 38}, {-68, 38}, {-68, 8}, {-62, 8}}, color = {0, 0, 127}));
  connect(sine1.y, Tpipe_in) annotation(
    Line(points = {{-74, 4}, {-72, 4}, {-72, -36}, {64, -36}, {64, -36}}, color = {0, 0, 127}));
  connect(sine1.y, Input.T_in) annotation(
    Line(points = {{-75, 4}, {-64, 4}}, color = {0, 0, 127}));
  connect(Input.ports[1], dynamicPipe.port_a) annotation(
    Line(points = {{-42, 0}, {-10, 0}}, color = {0, 127, 255}));
  annotation(
    uses(Modelica(version = "3.2.3")));
    
end pipe;
