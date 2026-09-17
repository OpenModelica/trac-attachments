package connectorTest
  partial package partialMedium
    constant Integer nX;
  end partialMedium;

  connector advConnector
    replaceable package Medium = connectorTest.OtherMedium;
    Modelica.SIunits.Pressure p;
    flow Modelica.SIunits.MassFlowRate m_flow;
    stream Modelica.SIunits.Mass C_flow[Medium.nS];
  end advConnector;

  package PackageExample
    extends connectorTest.partialMedium(nX = 2);
    final constant Integer nS = 3;
  end PackageExample;

  package OtherMedium
    final constant Integer nS = 3;
  end OtherMedium;

  model testModel
    replaceable package Medium = PackageExample;
    connectorTest.advConnector something(redeclare package Medium = Medium);
  end testModel;
end connectorTest;