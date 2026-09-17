within ;
package YD
  model Test
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.BooleanTable booleanTable(table={0.5,1,1.5,1.55,1.6,
          2,2.05,2.1},                                            startTime=0.1)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    LogicalDelayEquations logicalDelayEquations(delayTime=0.1)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    LogicalDelayStateGraph logicalDelayStateGraph(delayTime=0.1)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation
    connect(booleanTable.y, logicalDelayEquations.u) annotation (Line(points={{
            -59,0},{-40,0},{-40,30},{-22,30}}, color={255,0,255}));
    connect(booleanTable.y, logicalDelayStateGraph.u) annotation (Line(points={
            {-59,0},{-40,0},{-40,-30},{-22,-30}}, color={255,0,255}));
    annotation (experiment(StopTime=2.5));
  end Test;

  partial block PartialLogicalDelay "Delay boolean signal"
    extends Modelica.Blocks.Icons.PartialBooleanBlock;
    parameter Modelica.SIunits.Time delayTime(final min=0)=0 "Time delay";
    Modelica.Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y1
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
   Modelica.Blocks.Interfaces.BooleanOutput  y2
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    annotation (Documentation(info="<html>
<p>
When input <code>u</code> gets true, output <code>y1</code> gets immediately true, whereas output <code>y2</code> gets true after <code>delayTime</code>.
</p>
<p>
When input <code>u</code> gets false, output <code>y1</code> gets false after <code>delayTime</code>, whereas output <code>y2</code> gets immediately false.
</p>
</html>"), Icon(graphics={
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(points={{-80,68},{-80,-80}},
          color={192,192,192}),
        Line(points={{-90,-70},{82,-70}},
          color={192,192,192}),
        Polygon(lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-70},{68,-62},{68,-78},{90,-70}}),
          Line(points={{-80,-10},{-60,-10},{-60,10},{40,10},{40,-10},{80,-10}},
              color={255,0,255}),
          Line(points={{-80,50},{-60,50},{-60,70},{50,70},{50,50},{80,50}},
              color={255,0,255}),
          Line(points={{-80,-70},{-50,-70},{-50,-50},{40,-50},{40,-70},{80,-70}},
              color={255,0,255}),
          Line(
            points={{-60,70},{-60,-70}},
            color={192,192,192},
            pattern=LinePattern.Dot),
          Line(
            points={{40,70},{40,-70}},
            color={192,192,192},
            pattern=LinePattern.Dot)}));
  end PartialLogicalDelay;

  block LogicalDelayEquations "Delay boolean signal"
    extends YD.PartialLogicalDelay;
  protected
    discrete Modelica.SIunits.Time tSwitch;
  initial equation
    tSwitch = time - 2*delayTime;
  equation
    when {u, not u} then
      tSwitch = time;
    end when;
    y1 = if u then true else not (time >= tSwitch + delayTime);
    y2 = if not u then false else (time >= tSwitch + delayTime);
  end LogicalDelayEquations;

  block LogicalDelayStateGraph "Delay boolean signal"
    extends YD.PartialLogicalDelay;
    Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-60,-30})));
    Modelica.Blocks.Logical.Not not2
      annotation (Placement(transformation(extent={{40,50},{60,70}})));
    Modelica_StateGraph2.Step Y1D0(
      initialStep=true,
      use_activePort=true,
      nOut=1,
      nIn=1) annotation (Placement(transformation(extent={{16,56},{24,64}})));
    Modelica_StateGraph2.Transition T1(use_conditionPort=true)
      annotation (Placement(transformation(extent={{24,26},{16,34}})));
    Modelica_StateGraph2.Step Y0D0(nIn=2, nOut=2)
      annotation (Placement(transformation(extent={{-4,-4},{4,4}})));
    Modelica_StateGraph2.Transition T2(
      use_conditionPort=true,
      delayedTransition=true,
      waitTime=delayTime)
      annotation (Placement(transformation(extent={{24,-34},{16,-26}})));
    Modelica_StateGraph2.Step Y0D1(
      use_activePort=true,
      nIn=1,
      nOut=1) annotation (Placement(transformation(extent={{16,-64},{24,-56}})));
    Modelica_StateGraph2.Transition T3(use_conditionPort=true,
        delayedTransition=false) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={-10,-30})));
    Modelica_StateGraph2.Transition T4(
      use_conditionPort=true,
      delayedTransition=true,
      waitTime=delayTime) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={-20,30})));
  equation
    connect(u, not1.u) annotation (Line(points={{-120,0},{-90,0},{-90,-30},{-72,
            -30}}, color={255,0,255}));
    connect(not2.y, y1)
      annotation (Line(points={{61,60},{110,60}}, color={255,0,255}));
    connect(Y1D0.activePort, not2.u)
      annotation (Line(points={{24.72,60},{38,60}}, color={255,0,255}));
    connect(Y1D0.outPort[1], T1.inPort)
      annotation (Line(points={{20,55.4},{20,34}}, color={0,0,0}));
    connect(Y0D1.activePort, y2)
      annotation (Line(points={{24.72,-60},{110,-60}}, color={255,0,255}));
    connect(T2.outPort, Y0D1.inPort[1])
      annotation (Line(points={{20,-35},{20,-56}}, color={0,0,0}));
    connect(Y0D1.outPort[1], T3.inPort) annotation (Line(points={{20,-64.6},{20,
            -80},{-10,-80},{-10,-34}}, color={0,0,0}));
    connect(not1.y, T3.conditionPort)
      annotation (Line(points={{-49,-30},{-15,-30}}, color={255,0,255}));
    connect(T4.outPort, Y1D0.inPort[1]) annotation (Line(points={{-20,35},{-20,
            80},{20,80},{20,64}}, color={0,0,0}));
    connect(not1.y, T4.conditionPort) annotation (Line(points={{-49,-30},{-40,
            -30},{-40,30},{-25,30}}, color={255,0,255}));
    connect(u, T1.conditionPort) annotation (Line(points={{-120,0},{-90,0},{-90,
            40},{40,40},{40,30},{25,30}}, color={255,0,255}));
    connect(u, T2.conditionPort) annotation (Line(points={{-120,0},{-90,0},{-90,
            40},{40,40},{40,-30},{25,-30}}, color={255,0,255}));
    connect(T3.outPort, Y0D0.inPort[1]) annotation (Line(points={{-10,-25},{-10,
            20},{-1,20},{-1,4}}, color={0,0,0}));
    connect(Y0D0.inPort[2], T1.outPort)
      annotation (Line(points={{1,4},{1,20},{20,20},{20,25}}, color={0,0,0}));
    connect(Y0D0.outPort[1], T4.inPort) annotation (Line(points={{-1,-4.6},{-1,
            -20},{-20,-20},{-20,26}}, color={0,0,0}));
    connect(Y0D0.outPort[2], T2.inPort) annotation (Line(points={{1,-4.6},{1,
            -20},{20,-20},{20,-26}}, color={0,0,0}));
  end LogicalDelayStateGraph;
  annotation (uses(Modelica(version="3.2.3"), Modelica_StateGraph2(version=
            "2.0.4")));
end YD;
