within ;
package BugPeak
  model simpleMesh

    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource U(
      V=10,
      f=50,
      phi=0.34906585039887) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-80,18})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
        R_ref=1) annotation (Placement(transformation(
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
    getUPeak getUPeak1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={72,16})));
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
    connect(getUPeak1.positivePin, S.currentN) annotation (Line(
        points={{72,26},{72,40},{28,40}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(getUPeak1.negativePin, ground.pin) annotation (Line(
        points={{72,6.2},{72,-8},{-80,-8},{-80,-22}},
        color={85,170,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end simpleMesh;

  model getUPeak "gives the peak value of the mesured voltage"
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
      voltageSensor
      annotation (Placement(transformation(extent={{-10,24},{10,44}})));
    Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,0})));
    Modelica.Blocks.Math.Gain gain(k=sqrt(2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-46})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,-110})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
      positivePin
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
      negativePin
      annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  equation
    connect(voltageSensor.y, complexToPolar.u) annotation (Line(
        points={{0,23},{0,12},{0.00000000000000222045,12}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(complexToPolar.len, gain.u) annotation (Line(
        points={{6,-12},{6,-34},{0.00000000000000222045,-34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, y) annotation (Line(
        points={{-0.0000000000000019984,-57},{-0.0000000000000019984,-62.5},{0,
            -62.5},{0,-110}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(voltageSensor.pin_p, positivePin) annotation (Line(
        points={{-10,34},{-52,34},{-52,0},{-100,0}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(voltageSensor.pin_n, negativePin) annotation (Line(
        points={{10,34},{52,34},{52,0},{98,0}},
        color={85,170,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Line(
            points={{-94,0},{92,0}},
            color={85,170,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{-56,56},{56,-56}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-30,30},{-30,-30}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{30,30},{30,-30}},
            color={0,0,255},
            smooth=Smooth.None),
          Text(
            extent={{-102,42},{102,-40}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="U"),
          Line(
            points={{0,-56},{0,-102}},
            color={0,0,255},
            smooth=Smooth.None)}));
  end getUPeak;
  annotation (uses(Modelica(version="3.2")));
end BugPeak;
