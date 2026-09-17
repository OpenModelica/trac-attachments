package TestActualStream
  model PressureLoss
    replaceable package Medium = Modelica.Media.Interfaces.PartialPureSubstance;
    
    Modelica.Fluid.Interfaces.FluidPort_a port_a annotation(
      Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_b annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
    Medium.AbsolutePressure p_a, p_b;
    Modelica.SIunits.MassFlowRate w;
    Medium.SpecificEnthalpy h_a, h_b;
    Medium.BaseProperties prop_a;
    Medium.BaseProperties prop_b;
    Medium.Density rho;
  equation
  p_a = port_a.p;
    p_b = port_b.p;
    w = port_a.m_flow;
    w = -port_b.m_flow;
    h_a = actualStream(port_a.h_outflow);
    h_b = actualStream(port_b.h_outflow);
    prop_a.p = p_a;
    prop_a.h = h_a;
    prop_b.p = p_b;
    prop_b.h = h_b;
    rho = (prop_a.d + prop_b.d)/2;
    p_a - p_b = Modelica.Fluid.Utilities.regSquare(w, 0.1)/rho;
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);
    annotation(
      Icon(graphics = {Rectangle(origin = {0.990099, -0.0454545}, extent = {{-99.0099, 21.9545}, {99.0099, -21.9545}})}));
  end PressureLoss;

  model Test
    package Medium = Modelica.Media.Water.StandardWater;
  Modelica.Fluid.Sources.FixedBoundary source(nPorts = 1, redeclare package Medium = Medium)  annotation(
      Placement(visible = true, transformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary sink(nPorts = 1, redeclare package Medium = Medium)  annotation(
      Placement(visible = true, transformation(origin = {60, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
      Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PressureLoss ploss1(redeclare package Medium = Medium)  annotation(
      Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PressureLoss ploss2(redeclare package Medium = Medium) annotation(
      Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(source.ports[1], ploss1.port_a) annotation(
      Line(points = {{-52, 0}, {-38, 0}, {-38, 0}, {-36, 0}, {-36, 0}}, color = {0, 127, 255}));
  connect(ploss1.port_b, ploss2.port_a) annotation(
      Line(points = {{-16, 0}, {8, 0}, {8, 0}, {8, 0}}, color = {0, 127, 255}));
  connect(ploss2.port_b, sink.ports[1]) annotation(
      Line(points = {{28, 0}, {50, 0}, {50, 0}, {50, 0}}, color = {0, 127, 255}));
  end Test;
equation

annotation(
    uses(Modelica(version = "3.2.3")));
end TestActualStream;
