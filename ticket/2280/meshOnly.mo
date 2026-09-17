within ;
model meshOnly

  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource U(
    V=10,
    f=50,
    phi=0.34906585039887) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,18})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref
      =1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-14,40})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-42},{-70,-22}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource U1(
    f=50,
    V=10,
    phi=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor S
    annotation (Placement(transformation(extent={{8,30},{28,50}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(L=
        0.01) annotation (Placement(visible=true, transformation(
        origin={-47.5652,40.4348},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(inductor.pin_p, U.pin_p) annotation (Line(points={{-57.5652,40.4348},
          {-80,40.4348},{-80,28}},color={85,170,255}));
  connect(inductor.pin_n, resistor.pin_p) annotation (Line(points={{-37.5652,
          40.4348},{-24,40}}, color={85,170,255}));
  connect(U.pin_n, ground.pin) annotation (Line(
      points={{-80,8},{-80,-22}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(U1.pin_n, ground.pin) annotation (Line(
      points={{40,0},{40,-8},{-80,-8},{-80,-22}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(S.currentP, resistor.pin_n) annotation (Line(
      points={{8,40},{-4,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(S.currentN, U1.pin_p) annotation (Line(
      points={{28,40},{40,40},{40,20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(S.voltageP, S.currentP) annotation (Line(
      points={{18,50},{8,50},{8,40}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(S.voltageN, ground.pin) annotation (Line(
      points={{18,30},{18,-8},{-80,-8},{-80,-22}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), uses(Modelica(version="3.2")));
end meshOnly;
