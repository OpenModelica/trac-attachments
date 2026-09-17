within ;
package RedeclarationComponents
  extends Modelica.Icons.Package;

  partial model PartialExample
    extends Modelica.Icons.Example;

    replaceable Components.BaseComponentA componentA annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    replaceable Components.BaseComponentB componentB annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PartialExample;

  model ExampleAB
    extends PartialExample(
      redeclare RedeclarationComponents.Components.ComponentA componentA,
      redeclare RedeclarationComponents.Components.ComponentB componentB);
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  equation
    connect(fixedTemperature.port, componentA.port_a) annotation (Line(points={{-60,0},{-50,0},{-40,0}}, color={191,0,0}));
    connect(componentA.port_b, componentB.port_a) annotation (Line(points={{-20,0},{20,0},{20,0}}, color={191,0,0}));
    connect(componentB.port_b, fixedHeatFlow.port) annotation (Line(points={{40,0},{46,0},{60,0}}, color={191,0,0}));
  end ExampleAB;

  package Components
    extends Modelica.Icons.Package;
    model BaseComponentA
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end BaseComponentA;

    model BaseComponentB
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end BaseComponentB;

    model ComponentA
      extends BaseComponentA;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      connect(port_a, port_b) annotation (Line(points={{-100,0},{100,0},{100,0}}, color={191,0,0}));
      annotation (Icon(graphics={Text(
              extent={{-40,-40},{40,42}},
              lineColor={28,108,200},
              textString="A")}));
    end ComponentA;

    model ComponentB
      extends BaseComponentB;
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      connect(port_a, port_b) annotation (Line(points={{-100,0},{100,0},{100,0}}, color={191,0,0}));
      annotation (Icon(graphics={Text(
              extent={{-40,-40},{40,42}},
              lineColor={28,108,200},
              textString="B")}));
    end ComponentB;
  end Components;
  annotation (uses(Modelica(version="3.2.2")));
end RedeclarationComponents;
