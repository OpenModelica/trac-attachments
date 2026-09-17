within ;
model BridgeMono
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-10})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-10})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={12,38})));
  Modelica.Electrical.Analog.Basic.Inductor L(L=2e-3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={12,-6})));
  Modelica.Electrical.Analog.Sources.SineVoltage Us(V=10, freqHz=50)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,10})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-72},{-10,-52}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(
                                              R=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,38})));
  Modelica.Electrical.Analog.Basic.Inductor L1(L=20e-3)
                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,-6})));
equation
  connect(idealDiode.p, idealDiode2.n) annotation (Line(
      points={{-40,20},{-40,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode1.p, idealDiode3.n) annotation (Line(
      points={{-20,20},{-20,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(L.n, idealDiode3.p) annotation (Line(
      points={{12,-16},{12,-40},{-20,-40},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode2.p, idealDiode3.p) annotation (Line(
      points={{-40,-20},{-40,-40},{-20,-40},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode.n, R.p) annotation (Line(
      points={{-40,40},{-40,60},{12,60},{12,48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode1.n, idealDiode.n) annotation (Line(
      points={{-20,40},{-20,60},{-40,60},{-40,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R.n, L.p) annotation (Line(
      points={{12,28},{12,16},{12,4},{12,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, idealDiode3.p) annotation (Line(
      points={{-20,-52},{-20,-20},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Us.p, idealDiode.p) annotation (Line(
      points={{-80,20},{-80,32},{-60,32},{-60,14},{-40,14},{-40,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Us.n, idealDiode3.n) annotation (Line(
      points={{-80,0},{-80,-12},{-60,-12},{-60,8},{-20,8},{-20,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R1.p, R.p) annotation (Line(
      points={{34,48},{34,60},{12,60},{12,48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R1.n, L1.p) annotation (Line(
      points={{34,28},{34,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(L1.n, L.n) annotation (Line(
      points={{34,-16},{34,-40},{12,-40},{12,-16}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (
    uses(Modelica(version="3.2")),
    Diagram(graphics),
    experiment(StopTime=0.12, NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput);
end BridgeMono;
