within ;
model RL
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=2) annotation (
      Placement(visible=true, transformation(extent={{14,24},{34,44}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=0.001, i(start=1))
                                                          annotation (
      Placement(visible=true, transformation(
        origin={58,14},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        visible=true, transformation(extent={{16,-38},{36,-18}}, rotation=0)));

  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-12,8})));
  Modelica.Blocks.Sources.Step step(
    offset=0,
    height=1,
    startTime=0.003)
    annotation (Placement(transformation(extent={{-50,-2},{-30,18}})));
equation
  connect(inductor.p, resistor.n)
    annotation (Line(points={{58,24},{58,34},{34,34}}, color={0,0,255}));
  connect(signalVoltage.p, resistor.p)
    annotation (Line(points={{-12,18},{-12,34},{14,34}},  color={0,0,255}));
  connect(inductor.n, signalVoltage.n) annotation (Line(points={{58,4},{58,
          -12},{-12,-12},{-12,-2}},
                              color={0,0,255}));
  connect(ground.p, signalVoltage.n) annotation (Line(points={{26,-18},{26,
          -12},{-12,-12},{-12,-2}},
                              color={0,0,255}));
  connect(step.y, signalVoltage.v) annotation (Line(points={{-29,8},{-29,8},{
          -19,8}},           color={0,0,127}));
  annotation (
    experiment(StopTime=0.01),
    experimentSetupOutput,
    Diagram(coordinateSystem(
        extent={{-60,-40},{80,60}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={2,2})),
    Icon(coordinateSystem(
        extent={{-60,-40},{80,60}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={2,2})),
    uses(Modelica(version="3.2.2")));
end RL;
