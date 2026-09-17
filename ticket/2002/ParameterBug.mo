within ;
package ParameterBug
  model Test

    StaticPipe pipe1( redeclare model FlowModel = PartialGenericPipeFlow (m_flow_nominal=1));

  end Test;

  model StaticPipe "Basic pipe flow model without storage of mass or energy"

    // Pressure loss
    replaceable model FlowModel = PartialGenericPipeFlow;

    FlowModel flowModel;

  end StaticPipe;

      model PartialGenericPipeFlow

        parameter Modelica.SIunits.MassFlowRate m_flow_nominal;

      end PartialGenericPipeFlow;
  annotation (uses(Modelica(version="3.2")));
end ParameterBug;
