within ;
package PMP_V16

  package Experiments
    extends Modelica.Icons.ExamplesPackage;
    model HalfWaveRectifier
      extends Modelica.Icons.Example;
      Components.VoltageSource voltageSource(V=sqrt(2)*100, freqHz=50)
                                                                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,0})));
      Components.Voltmeter voltmeter1 annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Components.Diode diode annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-38,50})));
      Components.Voltmeter voltmeter  annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Components.Wattmeter wattmeter  annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Components.Amperemeter amperemeter annotation (Placement(transformation(extent={{30,40},{50,60}})));
      Components.Resistor rLoad(R=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,0})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
    equation
      connect(voltageSource.n, voltmeter1.nv) annotation (Line(points={{-90,-10},{-90,
              -20},{-70,-20},{-70,-10}}, color={0,0,255}));
      connect(voltageSource.p, voltmeter1.pv) annotation (Line(points={{-90,10},{-90,
              20},{-70,20},{-70,10}}, color={0,0,255}));
      connect(wattmeter.pc, wattmeter.pv)
        annotation (Line(points={{0,50},{0,60},{10,60}}, color={0,0,255}));
      connect(wattmeter.nc, amperemeter.pc)
        annotation (Line(points={{20,50},{30,50}}, color={0,0,255}));
      connect(amperemeter.nc, rLoad.p)
        annotation (Line(points={{50,50},{60,50},{60,10}}, color={0,0,255}));
      connect(voltageSource.n, ground.p)
        annotation (Line(points={{-90,-10},{-90,-50}}, color={0,0,255}));
      connect(voltageSource.p, diode.p) annotation (Line(points={{-90,10},{-90,
              50},{-48,50}}, color={0,0,255}));
      connect(diode.n, wattmeter.pc)
        annotation (Line(points={{-28,50},{0,50}}, color={0,0,255}));
      connect(diode.n, voltmeter.pv)
        annotation (Line(points={{-28,50},{-10,50},{-10,10}}, color={0,0,255}));
      connect(ground.p, voltmeter.nv)
        annotation (Line(points={{-90,-50},{-10,-50},{-10,-10}}, color={0,0,255}));
      connect(ground.p, wattmeter.nv) annotation (Line(points={{-90,-50},{10,
              -50},{10,40}}, color={0,0,255}));
      connect(ground.p, rLoad.n) annotation (Line(points={{-90,-50},{60,-50},{
              60,-10}}, color={0,0,255}));
      annotation (experiment(
          StopTime=0.2,
          Interval=1e-05,
          Tolerance=1e-08));
    end HalfWaveRectifier;

    model FullWaveRectifier
      extends Modelica.Icons.Example;
      Components.VoltageSource voltageSource(V=sqrt(2)*100, freqHz=50)
                                                                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,0})));
      Components.Voltmeter voltmeter1 annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Components.Diode diode1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,40})));
      Components.Diode diode2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-40})));
      Components.Diode diode3 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-40})));
      Components.Diode diode4 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,40})));
      Components.Voltmeter voltmeter annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Components.Wattmeter wattmeter annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Components.Amperemeter amperemeter annotation (Placement(transformation(extent={{30,40},{50,60}})));
      Components.Resistor rLoad(R=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,0})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
    equation
      connect(diode1.p, diode2.n)
        annotation (Line(points={{-50,30},{-50,-30}}, color={0,0,255}));
      connect(voltageSource.n, voltmeter1.nv) annotation (Line(points={{-90,-10},{-90,
              -20},{-70,-20},{-70,-10}}, color={0,0,255}));
      connect(diode1.p, voltageSource.p) annotation (Line(points={{-50,30},{-50,
              20},{-90,20},{-90,10}}, color={0,0,255}));
      connect(voltageSource.p, voltmeter1.pv) annotation (Line(points={{-90,10},{-90,
              20},{-70,20},{-70,10}}, color={0,0,255}));
      connect(diode1.n, diode4.n)
        annotation (Line(points={{-50,50},{-30,50}}, color={0,0,255}));
      connect(diode2.p, diode3.p)
        annotation (Line(points={{-50,-50},{-30,-50}}, color={0,0,255}));
      connect(voltageSource.n, diode3.n) annotation (Line(points={{-90,-10},{
              -90,-20},{-30,-20},{-30,-30}}, color={0,0,255}));
      connect(diode3.n, diode4.p)
        annotation (Line(points={{-30,-30},{-30,30}}, color={0,0,255}));
      connect(diode4.n, voltmeter.pv)
        annotation (Line(points={{-30,50},{-10,50},{-10,10}}, color={0,0,255}));
      connect(diode3.p, voltmeter.nv)
        annotation (Line(points={{-30,-50},{-10,-50},{-10,-10}}, color={0,0,255}));
      connect(diode4.n, wattmeter.pc)
        annotation (Line(points={{-30,50},{0,50}}, color={0,0,255}));
      connect(wattmeter.pc, wattmeter.pv)
        annotation (Line(points={{0,50},{0,60},{10,60}}, color={0,0,255}));
      connect(diode3.p, wattmeter.nv) annotation (Line(points={{-30,-50},{10,
              -50},{10,40}}, color={0,0,255}));
      connect(wattmeter.nc, amperemeter.pc)
        annotation (Line(points={{20,50},{30,50}}, color={0,0,255}));
      connect(amperemeter.nc, rLoad.p)
        annotation (Line(points={{50,50},{60,50},{60,10}}, color={0,0,255}));
      connect(diode3.p, rLoad.n) annotation (Line(points={{-30,-50},{60,-50},{
              60,-10}}, color={0,0,255}));
      connect(voltageSource.n, ground.p)
        annotation (Line(points={{-90,-10},{-90,-50}}, color={0,0,255}));
      annotation (experiment(
          StopTime=0.2,
          Interval=1e-05,
          Tolerance=1e-08));
    end FullWaveRectifier;

    model FullWaveRectifierSmoothed
      extends Modelica.Icons.Example;
      Components.VoltageSource voltageSource(V=sqrt(2)*100, freqHz=50) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,0})));
      Components.Voltmeter voltmeter1  annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Components.Diode diode1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,40})));
      Components.Diode diode2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-40})));
      Components.Diode diode3 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,-40})));
      Components.Diode diode4 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,40})));
      Components.Voltmeter voltmeter annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Components.Wattmeter wattmeter annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Components.Amperemeter amperemeter annotation (Placement(transformation(extent={{30,40},{50,60}})));
      Components.Resistor rLoad(R=100) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={60,0})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
      Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=20e-6,
        v(fixed=true, start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,0})));
    equation
      connect(diode1.p, diode2.n)
        annotation (Line(points={{-50,30},{-50,-30}}, color={0,0,255}));
      connect(voltageSource.n, voltmeter1.nv) annotation (Line(points={{-90,-10},{-90,
              -20},{-70,-20},{-70,-10}}, color={0,0,255}));
      connect(diode1.p, voltageSource.p) annotation (Line(points={{-50,30},{-50,
              20},{-90,20},{-90,10}}, color={0,0,255}));
      connect(voltageSource.p, voltmeter1.pv) annotation (Line(points={{-90,10},{-90,
              20},{-70,20},{-70,10}}, color={0,0,255}));
      connect(diode1.n, diode4.n)
        annotation (Line(points={{-50,50},{-30,50}}, color={0,0,255}));
      connect(diode2.p, diode3.p)
        annotation (Line(points={{-50,-50},{-30,-50}}, color={0,0,255}));
      connect(voltageSource.n, diode3.n) annotation (Line(points={{-90,-10},{
              -90,-20},{-30,-20},{-30,-30}}, color={0,0,255}));
      connect(diode3.n, diode4.p)
        annotation (Line(points={{-30,-30},{-30,30}}, color={0,0,255}));
      connect(diode4.n, voltmeter.pv)
        annotation (Line(points={{-30,50},{-10,50},{-10,10}}, color={0,0,255}));
      connect(diode3.p, voltmeter.nv)
        annotation (Line(points={{-30,-50},{-10,-50},{-10,-10}}, color={0,0,255}));
      connect(diode4.n, wattmeter.pc)
        annotation (Line(points={{-30,50},{0,50}}, color={0,0,255}));
      connect(wattmeter.pc, wattmeter.pv)
        annotation (Line(points={{0,50},{0,60},{10,60}}, color={0,0,255}));
      connect(diode3.p, wattmeter.nv) annotation (Line(points={{-30,-50},{10,
              -50},{10,40}}, color={0,0,255}));
      connect(wattmeter.nc, amperemeter.pc)
        annotation (Line(points={{20,50},{30,50}}, color={0,0,255}));
      connect(amperemeter.nc, rLoad.p)
        annotation (Line(points={{50,50},{60,50},{60,10}}, color={0,0,255}));
      connect(diode3.p, rLoad.n) annotation (Line(points={{-30,-50},{60,-50},{
              60,-10}}, color={0,0,255}));
      connect(voltageSource.n, ground.p)
        annotation (Line(points={{-90,-10},{-90,-50}}, color={0,0,255}));
      connect(amperemeter.nc, capacitor.p)
        annotation (Line(points={{50,50},{80,50},{80,10}}, color={0,0,255}));
      connect(diode3.p, capacitor.n) annotation (Line(points={{-30,-50},{80,-50},
              {80,-10}}, color={0,0,255}));
      annotation (experiment(
          StopTime=0.2,
          Interval=1e-05,
          Tolerance=1e-08));
    end FullWaveRectifierSmoothed;
  end Experiments;

  package Components
    extends Modelica.Icons.UtilitiesPackage;
    model VoltageSource "Sine voltage source"
      parameter Modelica.SIunits.Voltage V=sqrt(2)*100 "Amplitude of sine wave";
      parameter Modelica.SIunits.Angle phase=0 "Phase of sine wave";
      parameter Modelica.SIunits.Frequency freqHz=50 "Frequency of sine wave";
      extends Modelica.Electrical.Analog.Interfaces.VoltageSource(redeclare
          Modelica.Blocks.Sources.Sine signalSource(
          final amplitude=V,
          final freqHz=freqHz,
          final phase=phase));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={Line(points={{-66,0},{-56.2,29.9},{-49.8,46.5},
                  {-44.2,58.1},{-39.3,65.2},{-34.3,69.2},{-29.4,69.8},{-24.5,67},
                  {-19.6,61},{-14.6,52},{-9,38.6},{-1.98,18.6},{12.79,-26.9},{
                  19.1,-44},{24.8,-56.2},{29.7,-64},{34.6,-68.6},{39.5,-70},{44.5,
                  -67.9},{49.4,-62.5},{54.3,-54.1},{59.9,-41.3},{67,-21.7},{74,0}},
                color={192,192,192})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={
              192,192,192}),Polygon(
                points={{-80,100},{-86,84},{-74,84},{-80,100}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),Line(points={{-99,-40},{100,-40}},
              color={192,192,192}),Polygon(
                points={{100,-40},{84,-34},{84,-46},{100,-40}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),Line(
                points={{-41,-2},{-32.6,32.2},{-27.1,51.1},{-22.3,64.4},{-18.1,
                72.6},{-13.9,77.1},{-8,78},{-5.42,74.6},{-1.201,67.7},{3.02,57.4},
                {7.84,42.1},{13.9,19.2},{26.5,-32.8},{32,-52.2},{36.8,-66.2},{41,
                -75.1},{45.2,-80.4},{49.5,-82},{53.7,-79.6},{57.9,-73.5},{62.1,-63.9},
                {66.9,-49.2},{73,-26.8},{79,-2}},
                thickness=0.5),Line(
                points={{-41,-2},{-80,-2}},
                thickness=0.5),Text(
                extent={{-106,-11},{-60,-29}},
                lineColor={160,160,164},
                textString="offset"),Line(
                points={{-41,-2},{-41,-40}},
                color={192,192,192},
                pattern=LinePattern.Dash),Text(
                extent={{-60,-43},{-14,-61}},
                lineColor={160,160,164},
                textString="startTime"),Text(
                extent={{76,-52},{100,-72}},
                lineColor={160,160,164},
                textString="time"),Line(
                points={{-8,78},{45,78}},
                color={192,192,192},
                pattern=LinePattern.Dash),Line(
                points={{-41,-2},{52,-2}},
                color={192,192,192},
                pattern=LinePattern.Dash),Polygon(
                points={{33,78},{30,65},{37,65},{33,78}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),Text(
                extent={{37,57},{83,39}},
                lineColor={160,160,164},
                textString="V"),Polygon(
                points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),Line(
                points={{33,78},{33,-2}},
                color={192,192,192}),Text(
                extent={{-69,109},{-4,83}},
                lineColor={160,160,164},
                textString="v = p.v - n.v")}),
        Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",   info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));

    end VoltageSource;

    model Diode "Ideal diode"
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5
        "Forward state-on differential resistance (closed resistance)";
      parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5
        "Backward state-off conductance (opened conductance)";
      parameter Modelica.SIunits.Voltage Vknee(final min=0) = 0.7
        "Forward threshold voltage";
      Boolean off(start=true) "Switching state";
    protected
      Real s(start=0, final unit="1")
        "Auxiliary variable for actual position on the ideal diode characteristic";
      /* s = 0: knee point
     s < 0: below knee point, blocking
     s > 0: above knee point, conducting */
      constant Modelica.SIunits.Voltage unitVoltage=1 annotation (HideResult=true);
      constant Modelica.SIunits.Current unitCurrent=1 annotation (HideResult=true);
    equation
      off = s < 0;
      v = (s*unitCurrent)*(if off then 1 else Ron) + Vknee;
      i = (s*unitVoltage)*(if off then Goff else 1) + Goff*Vknee;
      annotation (
        Documentation(info="<html>
<p>
This is an ideal semiconductor which is<br><br>
<strong>open </strong>(off), if it is reversed biased (voltage drop less than 0)<br>
<strong>closed</strong> (on), if it is conducting (current > 0).<br>
<br/>
This is the behaviour if all parameters are exactly zero.<br><br>
Note, there are circuits, where this ideal description
with zero resistance and zero conductance is not possible.
In order to prevent singularities during switching, the opened
semiconductor has a small conductance <em>Gon</em>
and the closed semiconductor has a low resistance <em>Roff</em> which is default.
</p>
<p>
The parameter <em>Vknee</em> which is the forward threshold voltage, allows to displace
the knee point<br> along  the <em>Gon</em>-characteristic until <em>v = Vknee</em>.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled.
</p>
</html>",   revisions="<html>
<ul>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em>Mai 7, 2004   </em>
       by Christoph Clauss and Anton Haumer<br> Vknee added<br>
       </li>
<li><em>some years ago   </em>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,0},{80,0}}, color={128,128,128}),
              Polygon(
                points={{70,4},{80,0},{70,-4},{70,4}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),Line(points={{0,80},{0,-80}},
              color={128,128,128}),Polygon(
                points={{-4,70},{0,80},{4,70},{-4,70}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),Text(
                extent={{10,80},{20,70}},
                lineColor={128,128,128},
                textString="i"),Text(
                extent={{70,-10},{80,-20}},
                lineColor={128,128,128},
                textString="v"),Line(
                points={{-80,-40},{-20,-10},{20,10},{40,70}},
                thickness=0.5),Line(
                points={{20,9},{20,0}},
                color={128,128,128},
                pattern=LinePattern.Dot),Text(
                extent={{20,0},{40,-10}},
                lineColor={128,128,128},
                textString="Vknee"),Text(
                extent={{20,70},{40,60}},
                lineColor={128,128,128},
                textString="Ron"),Text(
                extent={{-20,10},{0,0}},
                lineColor={128,128,128},
                textString="Goff"),Ellipse(
                extent={{18,12},{22,8}},
                pattern=LinePattern.Dot,
                lineColor={0,0,255})}));
    end Diode;

    model Resistor "Ideal linear electrical resistor"
      parameter Modelica.SIunits.Resistance R(start=100, min=100, max=1000) "Resistance";
      extends Modelica.Electrical.Analog.Interfaces.OnePort;

    equation
      v = R*i;
      annotation (
        Documentation(info="<html>
<p>The linear resistor connects the branch voltage <em>v</em> with the branch current <em>i</em> by <em>i*R = v</em>. The Resistance <em>R</em> is allowed to be positive, zero, or negative.</p>
</html>",   revisions="<html>
<ul>
<li><em> August 07, 2009   </em>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><em> March 11, 2009   </em>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-40},{150,-80}},
              textString="R=%R"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}));
    end Resistor;

  model Wattmeter "Sensor to measure the power"
    parameter Modelica.SIunits.Frequency f=50 "Base frequency";
    parameter Integer significantDigits=4 "Significant digits";
    Modelica.Electrical.Analog.Interfaces.PositivePin pc
        "Positive pin, current path"
      annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin nc
        "Negative pin, current path"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pv
        "Positive pin, voltage path"
      annotation (Placement(transformation(extent={{-10,110},{10,90}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin nv
        "Negative pin, voltage path"
      annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
      annotation (Placement(transformation(
            origin={0,-30},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(
            origin={50,-30},
            extent={{-10,10},{10,-10}},
            rotation=0)));

    Modelica.Blocks.Math.Mean mean(f=f)
      annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
    protected
    Real showNumber=mean.y;
  equation
    connect(pv, voltageSensor.p) annotation (Line(points={{0,100},{0,-20}}, color={0,0,255}));
    connect(voltageSensor.n, nv) annotation (Line(points={{0,-40},{0,-63},{0,-100}}, color={0,0,255}));
    connect(pc, currentSensor.p)
      annotation (Line(points={{-100,0},{20,0}},  color={0,0,255}));
    connect(currentSensor.n, nc)
      annotation (Line(points={{40,0},{100,0}},  color={0,0,255}));
    connect(currentSensor.i, product.u2) annotation (Line(points={{30,-11},{30,
              -24},{38,-24}},                                                                               color={0,0,127}));
    connect(voltageSensor.v, product.u1) annotation (Line(points={{11,-30},{30,
              -30},{30,-36},{38,-36}},                                                            color={0,0,127}));
    connect(product.y, mean.u)
      annotation (Line(points={{61,-30},{68,-30}},          color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(extent={{-90,90},{90,-90}}, lineColor={135,135,135},
            radius=20,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),                              Text(
            extent={{-90,50},{90,10}},
            lineColor={0,0,0},
            textString=DynamicSelect("0.0", String(showNumber, significantDigits=significantDigits))),
            Text(
              extent={{-90,90},{90,60}},
              lineColor={0,0,0},
              textString="W")}));
  end Wattmeter;

  model Amperemeter "Sensor to measure current"
    parameter Modelica.SIunits.Frequency f=50 "Base frequency";
    parameter Integer significantDigits=4 "Significant digits";
    Modelica.Electrical.Analog.Interfaces.PositivePin pc
        "Positive pin, current path"
      annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin nc
        "Negative pin, current path"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Modelica.Blocks.Math.Mean mean(f=f)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-50})));
    Modelica.Blocks.Math.RootMeanSquare rms(f=f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-50})));
    protected
    Real showNumber1=mean.y;
    Real showNumber2=rms.y;
  equation
    connect(pc, currentSensor.p)
      annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
    connect(currentSensor.n, nc)
      annotation (Line(points={{10,0},{100,0}},  color={0,0,255}));
    connect(currentSensor.i, mean.u) annotation (Line(points={{0,-11},{0,-20},{-20,
            -20},{-20,-38}}, color={0,0,127}));
    connect(currentSensor.i, rms.u) annotation (Line(points={{0,-11},{0,-20},{20,-20},
            {20,-38}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(extent={{-90,90},{90,-90}}, lineColor={135,135,135},
            radius=20,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),                              Text(
            extent={{-90,50},{90,10}},
            lineColor={0,0,0},
            textString=DynamicSelect("0.0", String(showNumber1, significantDigits=significantDigits))),
          Text(
            extent={{-90,90},{90,60}},
            lineColor={0,0,0},
              textString="A  av"),
          Text(
            extent={{-90,-60},{90,-90}},
            lineColor={0,0,0},
            textString="A rms"),                                           Text(
            extent={{-90,-10},{90,-50}},
            lineColor={0,0,0},
            textString=DynamicSelect("0.0", String(showNumber2, significantDigits=significantDigits))),
            Line(points={{-90,0},{90,0}}, color={28,108,200})}));
  end Amperemeter;

  model Voltmeter "Sensor to measure voltage"
    parameter Modelica.SIunits.Frequency f=50 "Base frequency";
    parameter Integer significantDigits=4 "Significant digits";
    Modelica.Electrical.Analog.Interfaces.PositivePin pv
        "Positive pin, voltage path"
      annotation (Placement(transformation(extent={{-10,110},{10,90}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin nv
        "Negative pin, voltage path"
      annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
      annotation (Placement(transformation(
            origin={0,0},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    Modelica.Blocks.Math.Mean mean(f=f)
      annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
    Modelica.Blocks.Math.RootMeanSquare rms(f=f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,20})));
    protected
    Real showNumber1=mean.y;
    Real showNumber2=rms.y;
  equation
    connect(pv, voltageSensor.p) annotation (Line(points={{0,100},{0,10},{4.44089e-16,
            10}},                                                           color={0,0,255}));
    connect(voltageSensor.n, nv) annotation (Line(points={{-6.66134e-16,-10},{0,-10},
            {0,-100}},                                                               color={0,0,255}));
    connect(voltageSensor.v, rms.u)
      annotation (Line(points={{11,0},{20,0},{20,20},{38,20}}, color={0,0,127}));
    connect(voltageSensor.v, mean.u) annotation (Line(points={{11,0},{20,0},{20,
              -20},{38,-20}},
                       color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Rectangle(extent={{-90,90},{90,-90}}, lineColor={135,135,135},
            radius=20,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),                              Text(
            extent={{-90,50},{90,10}},
            lineColor={0,0,0},
            textString=DynamicSelect("0.0", String(showNumber1, significantDigits=significantDigits))),
          Text(
            extent={{-90,90},{90,60}},
            lineColor={0,0,0},
              textString="V  av"),
          Text(
            extent={{-90,-60},{90,-90}},
            lineColor={0,0,0},
            textString="V rms"),                                           Text(
            extent={{-90,-10},{90,-50}},
            lineColor={0,0,0},
            textString=DynamicSelect("0.0", String(showNumber2, significantDigits=significantDigits))),
            Line(points={{-90,0},{90,0}}, color={28,108,200})}));
  end Voltmeter;
  end Components;
  annotation (uses(Modelica(version="3.2.3")));
end PMP_V16;
