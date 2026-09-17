within ;
package MIMO

    connector FluidProperties "Type definition for fluid properties"
      // No input or output is declared here, as the whole connector
      // can be all input or all output variables.
      Modelica.SIunits.SpecificEnthalpy h "Specific thermodynamic enthalpy";
      Real X_w "Water vapor mass fractions per kg total air";
    end FluidProperties;

    connector inlet
      input Modelica.SIunits.MassFlowRate m_flow;
      input Modelica.SIunits.AbsolutePressure p;
      input FluidProperties proFor;
      output FluidProperties proBac;
    end inlet;

    connector outlet
      output Modelica.SIunits.MassFlowRate m_flow;
      output Modelica.SIunits.AbsolutePressure p;
      input FluidProperties proBac;
      output FluidProperties proFor;
    end outlet;

block MIMO "Test model"

  inlet inlet1 annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  outlet outlet1 annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
equation

  connect(inlet1, outlet1)
    annotation (Line(points={{-100,0},{100,0},{100,0}}, color={0,0,0}));
  annotation (uses(Modelica(version="3.2.1")), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end MIMO;
  annotation (uses(Modelica(version="3.2.1")));
end MIMO;
