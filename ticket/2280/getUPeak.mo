within ;
model getUPeak "gives the peak value of the mesured voltage"
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
    voltageSensor
    annotation (Placement(transformation(extent={{-10,24},{10,44}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,0})));
  Modelica.Blocks.Math.Gain gain(k=sqrt(2)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-46})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
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
      points={{-0.0000000000000019984,-57},{-0.0000000000000019984,-62.5},{0,-62.5},
          {0,-110}},
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
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
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
          smooth=Smooth.None)}),
    uses(Modelica(version="3.2")));
end getUPeak;
