model RoomCO2 "Demonstrates a room volume with CO2 accumulation"
  extends Modelica.Icons.Example;
  package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                             C_nominal={1.519E-3});
  Modelica.Blocks.Sources.Constant C(k=0.3*1.519E-3) 
    "substance concentration, raising to 1000 PPM CO2";
  Modelica.Fluid.Sources.FixedBoundary boundary4(nPorts=1,redeclare package Medium = Medium);
  Modelica.Fluid.Sensors.TraceSubstances traceVolume(redeclare package Medium = Medium);
  inner Modelica.Fluid.System system;
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    use_C_in=true,
    m_flow=100/1.2/3600*5,
    redeclare package Medium = Medium,
    nPorts=2,
    X=Medium.X_default);
  Modelica.Fluid.Vessels.ClosedVolume volume(
    C_start={1.519E-3},
    V=100,
    redeclare package Medium = Medium,
    nPorts=2,
    X_start={0.015,0.085},
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_portsData=false);
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Medium,
    length=1,
    diameter=0.15,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow (
         show_Res=true));
  Modelica.Fluid.Sensors.TraceSubstances traceSource(redeclare package Medium = Medium);
equation 
  connect(C.y, boundary1.C_in[1]);
  connect(pipe.port_b, boundary4.ports[1]);
  connect(volume.ports[2], pipe.port_a);
  connect(traceVolume.port, pipe.port_a);
  connect(boundary1.ports[1], volume.ports[1]);
  connect(boundary1.ports[2], traceSource.port);
end RoomCO2;

