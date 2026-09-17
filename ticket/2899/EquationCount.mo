within ;
model EquationCount
  expandable connector Conn
    extends Modelica.Icons.SignalBus;
  end Conn;

  Conn conn1 annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  Modelica.Blocks.Interfaces.RealInput vhVel annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{140,0},{100,40}})));
  Modelica.Blocks.Continuous.LimPID PIDice(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    y_start=0,
    Td=0,
    yMin=-20,
    Ti=10,
    k=3,
    yMax=150) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,44})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,44})));
equation
  connect(PIDice.y, conn1.iceTau)
    annotation (Line(points={{39,44},{0,44},{0,98}}, color={0,0,127}));
  connect(PIDice.u_s, const.y) annotation (Line(
      points={{62,44},{71,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIDice.u_m, conn1.wIce) annotation (Line(
      points={{50,56},{50,98},{0,98}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vhVel, conn1.vel) annotation (Line(
      points={{-120,0},{0,0},{0,98}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Icon(coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=false,
        initialScale=0.1,
        grid={2,2}), graphics={Rectangle(
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,100},{100,-60}}), Text(
          origin={0,16},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,36},{98,-26}},
          textString="MB1")}),
    uses(Modelica(version="3.2.1")));
end EquationCount;
