package TestStreamConnectors
  extends Modelica.Icons.Package;
  package Interfaces
    extends Modelica.Icons.InterfacesPackage;

    connector Flange
      Real p;
      flow Real m_flow;
      stream Real h_outflow;
  annotation(
        Icon(graphics = {Ellipse(origin = {1, 0}, fillColor = {85, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-101, 100}, {99, -100}}, endAngle = 360)}));
    end Flange;

  end Interfaces;

  package Components
    extends Modelica.Icons.Package;

    model PressureSource
      parameter Real p = 1e5;
      parameter Real T = 20;
      parameter Real cp = 4000;
      Real h = cp * T;
      TestStreamConnectors.Interfaces.Flange flange annotation(
        Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      flange.p = p;
      flange.h_outflow = h;
      annotation(
        Icon(graphics = {Ellipse(origin = {0, -1}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 99}, {100, -99}}, endAngle = 360)}));
    end PressureSource;

    model FlowSource
      parameter Real m_flow;
      parameter Real T = 20;
      parameter Real cp = 4000;
      Real h = cp * T;
      TestStreamConnectors.Interfaces.Flange outlet annotation(
        Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      outlet.m_flow = -m_flow;
      outlet.h_outflow = h;
      annotation(
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {1, -10}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-101, 50}, {99, -30}}), Line(origin = {-9.61111, -0.111111}, points = {{-50, 0}, {50, 0}}), Line(origin = {30.3889, -10.1111}, points = {{-30, -10}, {10, 10}}), Line(origin = {69.5555, 10}, points = {{-30, -10}, {-70, 10}})}));
    end FlowSource;

    model Pipe
      parameter Real m_flow;
      parameter Real T = 20;
      parameter Real cp = 4000;
      parameter Boolean allowFlowReversal = false;
      Real h = cp * T;
      Real dp = inlet.p - outlet.p;
      Real Kf;
      TestStreamConnectors.Interfaces.Flange outlet annotation(
        Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      TestStreamConnectors.Interfaces.Flange inlet(m_flow(min = if allowFlowReversal then -1e9 else 0)) annotation(
        Placement(visible = true, transformation(origin = {108, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      inlet.m_flow + outlet.m_flow = 0;
      inlet.p - outlet.p = Kf * inlet.m_flow;
      inlet.h_outflow = inStream(outlet.h_outflow);
      outlet.h_outflow = inStream(inlet.h_outflow);
      h = actualStream(inlet.h_outflow);
      annotation(
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {1, -10}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-101, 50}, {99, -30}}), Line(origin = {8.89736, -0.111111}, points = {{-50, 0}, {50, 0}}), Line(origin = {50.3211, -10.1111}, points = {{-30, -10}, {10, 10}}), Line(origin = {89.4877, 9.28817}, points = {{-30, -10}, {-70, 10}})}));
    end Pipe;

    model PressureSensor
      TestStreamConnectors.Interfaces.Flange flange(m_flow(min = 0)) annotation(
        Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput p annotation(
        Placement(visible = true, transformation(origin = {52, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {52, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      flange.p = p;
      flange.h_outflow = 0;
      flange.m_flow = 0;
      annotation(
        Icon(graphics = {Ellipse(origin = {50, -1}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 101}, {0, 1}}, endAngle = 360), Line(origin = {-1, -30}, points = {{1, 30}, {1, -30}})}, coordinateSystem(initialScale = 0.1)));
    end PressureSensor;


  end Components;
  
  package TestModels
    extends Modelica.Icons.ExamplesPackage;

    model Test1
      extends Modelica.Icons.Example;
      Components.PressureSource source annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    annotation(experiment(StopTime = 1));
    end Test1;


  end TestModels;
  annotation(
    uses(Modelica(version = "3.2.2")));
end TestStreamConnectors;
