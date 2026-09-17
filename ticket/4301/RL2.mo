within ;
model RL2
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(Placement(visible = true, transformation(extent = {{-10, 30}, {10, 50}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=1)      annotation(Placement(visible = true, transformation(origin={50,22},   extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent={{-2,-36},
            {18,-16}},                                                                                                                  rotation = 0)));

  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-30,10})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - exp(-(time - 10)^
        2/0.1))
    annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
equation
  connect(inductor.p, resistor.n) annotation(Line(points={{50,32},{50,40},{10,40}},        color = {0, 0, 255}));
  connect(signalVoltage.p, resistor.p)
    annotation (Line(points={{-30,20},{-30,40},{-10,40}}, color={0,0,255}));
  connect(inductor.n, signalVoltage.n) annotation (Line(points={{50,12},{50,-10},
          {-30,-10},{-30,0}}, color={0,0,255}));
  connect(ground.p, signalVoltage.n) annotation (Line(points={{8,-16},{8,-10},{-30,
          -10},{-30,0}}, color={0,0,255}));
  connect(signalVoltage.v, realExpression.y)
    annotation (Line(points={{-37,10},{-47,10}}, color={0,0,127}));
  annotation(experiment(StopTime=12),                                       experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version="3.2.2")));
end RL2;
