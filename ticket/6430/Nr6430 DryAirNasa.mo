package TestBug01MSL
  model Test01002
  
    package Medium = Modelica.Media.Air.ReferenceAir.Air_dT; //.DryAirNasa
    inner Modelica.Fluid.System system annotation(
      Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
    
    
    Modelica.Fluid.Sources.MassFlowSource_T boundary1(redeclare package Medium = Medium, m_flow = 0.1, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Fluid.Vessels.ClosedVolume volume(redeclare package Medium = Modelica.Media.Air.SimpleAir, 
      V = 4, use_portsData = false, nPorts = 1)  annotation(
      Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  equation
    connect(boundary1.ports[1], volume.ports[1]) annotation(
      Line(points = {{-20, 10}, {30, 10}, {30, 20}}, color = {0, 127, 255}));
  
  end Test01002;
  annotation(
    uses(Modelica(version = "4.0.0")));
end TestBug01MSL;
