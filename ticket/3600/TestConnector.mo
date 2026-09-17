within ;
package TestConnector

  connector Port
    Real p;
    flow Real q;
    stream Real h;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Port;

  connector HierarchicalPort
    Port port1;
    Port port2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HierarchicalPort;

  model Source
    HierarchicalPort p;
  equation
    p.port1.q=1;
    p.port1.h=1000;
    p.port2.q=10;
    p.port2.h=2000;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Source;

  model Sink
    HierarchicalPort p;
  equation
    p.port1.p=1e6;
    p.port1.h=1000;
    p.port2.p=2e6;
    p.port2.h=2000;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Sink;

  model Test
    Source source;
    Sink sink;
  equation
    connect(source.p, sink.p);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Test;
  annotation (uses(Modelica(version="3.2.1")));
end TestConnector;
