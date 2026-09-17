within ;
model RL_Circuit
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-38,-42},{-18,-22}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,10})));
  annotation (uses(Modelica(version="3.1")), Diagram(graphics));
equation
  connect(sineVoltage.p, resistor.p) annotation (Line(
      points={{-50,20},{-46,20},{-46,50},{-40,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.n, inductor.p) annotation (Line(
      points={{-20,50},{10,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inductor.n, ground.p) annotation (Line(
      points={{30,50},{36,50},{36,-22},{-28,-22}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, sineVoltage.n) annotation (Line(
      points={{-28,-22},{-40,-22},{-40,0},{-50,0}},
      color={0,0,255},
      smooth=Smooth.None));
end RL_Circuit;
