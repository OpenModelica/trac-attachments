package DCDrive
block ZOH "Zero order holder of a sampled-data system"
  extends Modelica.Blocks.Interfaces.SISO;
  
  parameter Modelica.SIunits.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1) = 1 "Sample period of component";
  parameter Modelica.SIunits.Time startTime=0 "First sample time instant";
protected
  Real old (start=0, fixed=true);
//  Real next (start=0, fixed=true);
equation
  when sample(startTime, samplePeriod) then
    old = pre(u);
  end when;
  y = pre(old);
  annotation (
    Icon(
      coordinateSystem(initialScale = 0.1),
        graphics={Line(points = {{-78, -42}, {-52, -42}, {-52, 0}, {-26, 0}, {-26, 24}, {-6, 24}, {-6, 64}, {18, 64}, {18, 20}, {38, 20}, {38, 0}, {44, 0}, {44, 0}, {62, 0}}, color = {0, 0, 127}), Text(origin = {0, -120}, extent = {{-120, 20}, {120, -20}}, textString = "period=%samplePeriod", fontSize = 16)}),
    Documentation(info= "<html><head></head><body><p>
This block was redefined in order to test if it will fail like the original ZOH supplied in library. Unfortunately it fails like that, freezing its output after a cretain time of simulation, leading to conclude that sample stops working. Using the original ZOH (Modelica.Blocks.Discrete.ZeroOrderHold, the simulation does not even finish.</p><p>The output is identical to the sampled input signal at sample
time instants and holds the output at the value of the last
sample instant during the sample points.
</p>
</body></html>"),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 0.0001, Interval = 0.001),
  __OpenModelica_simulationFlags(iim = "symbolic", lv = "LOG_STATS", maxStepSize = "0.7e-6", s = "rungekuttaSsc"));
end ZOH;

block SawTooth "Generate saw tooth signal"
  parameter Real amplitude=1 "Amplitude of saw tooth";
  parameter Modelica.SIunits.Time period(final min=Modelica.Constants.small,start=1) = 1
    "Time for one period";
  parameter Real offset=0 "Offset of output signals";
  parameter Modelica.SIunits.Time startTime=0 "Output = offset for time < startTime";
  extends Modelica.Blocks.Interfaces.SO;
protected
  Real amp = amplitude/period;
//initial algorithm
//   amp := amplitude / period;
equation
  y = amp * OpenModelica.Internal.realMod(time - startTime, period);
  //y = OpenModelica.Internal.realMod(time - startTime, period);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-60,-70},{0,40},{0,-70},{60,41},{60,-70}}),
        Text(
          extent={{-147,-152},{153,-112}},
          lineColor={0,0,0},
          textString="period=%period")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-80,90},{-86,68},{-74,68},{-80,90}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
        Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
        Polygon(
          points={{90,-70},{68,-65},{68,-75},{90,-70}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,-20},{-37,-33},{-31,-33},{-34,-20}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-34,-20},{-34,-70}}, color={95,95,95}),
        Polygon(
          points={{-34,-70},{-37,-57},{-31,-57},{-34,-70},{-34,-70}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-65,-39},{-29,-47}},
          lineColor={0,0,0},
          textString="offset"),
        Text(
          extent={{-29,-72},{13,-80}},
          lineColor={0,0,0},
          textString="startTime"),
        Text(
          extent={{-82,92},{-43,76}},
          lineColor={0,0,0},
          textString="y"),
        Text(
          extent={{67,-78},{88,-87}},
          lineColor={0,0,0},
          textString="time"),
        Line(points={{-10,-20},{-10,-70}}, color={95,95,95}),
        Line(points={{-10,88},{-10,-20}}, color={95,95,95}),
        Line(points={{30,88},{30,59}}, color={95,95,95}),
        Line(points={{-10,83},{30,83}}, color={95,95,95}),
        Text(
          extent={{-12,94},{34,85}},
          lineColor={0,0,0},
          textString="period"),
        Line(points={{-44,60},{30,60}}, color={95,95,95}),
        Line(points={{-34,47},{-34,-20}},color={95,95,95}),
        Text(
          extent={{-73,25},{-36,16}},
          lineColor={0,0,0},
          textString="amplitude"),
        Polygon(
          points={{-34,60},{-37,47},{-31,47},{-34,60}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,-20},{-37,-7},{-31,-7},{-34,-20},{-34,-20}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,83},{-1,85},{-1,81},{-10,83}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,83},{22,85},{22,81},{30,83}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-20},{-10,-20},{30,60},{30,-20},{72,60},{72,-20}},
          color={0,0,255},
          thickness=0.5)}),
    Documentation(info= "<html><head></head><body><p>This block was redefined because the original sawtooth presented some bugs in the simulatios. It crashes during simulation.</p><p>The Real output y is a saw tooth signal:</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SawTooth.png\" alt=\"SawTooth.png\">
</p>
</body></html>"));
end SawTooth;

  model SimpleDCMachine2
    import Modelica.SIunits;
    import Modelica.Constants.pi;
    constant Real M_2PI = 2 * pi;
    parameter SIunits.Resistance Ra = 5.4 "Armature resistance";
    parameter SIunits.Inductance La = 25e-3 "Armature auto-inductance";
    parameter SIunits.MomentOfInertia J = 4.2e-3 "Moment of inertia of rotor";
    parameter SIunits.CoefficientOfFriction B = 3.032e-3 "Shaft coefficient of friction";
    parameter SIunits.MagneticFlux Phi = 0.72 "Magnetic flux amplitude";
    // Variables
    //  SIunits.ActivePower Pt;
    //  SIunits.ReactivePower Qt;
    // Connectors
    Modelica.Electrical.Analog.Interfaces.PositivePin Vp "Armature positive terminal" annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin Vn "Armature negative terminal" annotation(
      Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a Axle "Rotos axis" annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor R1(R = Ra) annotation(
      Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor L1(L = La) annotation(
      Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = J) annotation(
      Placement(visible = true, transformation(origin = {82, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Rotational.Components.Damper damper1(d = B) annotation(
      Placement(visible = true, transformation(origin = {82, -44}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
      Placement(visible = true, transformation(origin = {62, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1 annotation(
      Placement(visible = true, transformation(origin = {-12, -58}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
      Placement(visible = true, transformation(origin = {60, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1 annotation(
      Placement(visible = true, transformation(origin = {-12, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain1(k = Phi) annotation(
      Placement(visible = true, transformation(origin = {26, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = Phi) annotation(
      Placement(visible = true, transformation(origin = {24, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(gain2.y, torque1.tau) annotation(
      Line(points = {{36, -58}, {50, -58}, {50, -58}, {50, -58}}, color = {0, 0, 127}));
    connect(currentSensor1.i, gain2.u) annotation(
      Line(points = {{-2, -58}, {12, -58}, {12, -58}, {12, -58}, {12, -58}}, color = {0, 0, 127}));
    connect(damper1.flange_b, torque1.flange) annotation(
      Line(points = {{82, -54}, {82, -58}, {72, -58}}));
    connect(inertia1.flange_a, damper1.flange_a) annotation(
      Line(points = {{82, -28}, {82, -34}}));
    connect(inertia1.flange_b, Axle) annotation(
      Line(points = {{82, -8}, {82, 0}, {100, 0}}));
    connect(gain1.y, signalVoltage1.v) annotation(
      Line(points = {{14, 12}, {6, 12}, {6, -24}, {-4, -24}, {-4, -24}}, color = {0, 0, 127}));
    connect(speedSensor1.w, gain1.u) annotation(
      Line(points = {{48, 12}, {40, 12}, {40, 12}, {38, 12}}, color = {0, 0, 127}));
    connect(signalVoltage1.p, L1.n) annotation(
      Line(points = {{-12, -14}, {-12, 0}, {-26, 0}}, color = {0, 0, 255}));
    connect(currentSensor1.p, signalVoltage1.n) annotation(
      Line(points = {{-12, -48}, {-12, -48}, {-12, -34}, {-12, -34}}, color = {0, 0, 255}));
    connect(Axle, speedSensor1.flange) annotation(
      Line(points = {{100, 0}, {82, 0}, {82, 12}, {70, 12}, {70, 12}}));
    connect(Vn, currentSensor1.n) annotation(
      Line(points = {{-100, -80}, {-12, -80}, {-12, -68}, {-12, -68}}, color = {0, 0, 255}));
    connect(L1.p, R1.n) annotation(
      Line(points = {{-46, 0}, {-58, 0}, {-58, 0}, {-58, 0}}, color = {0, 0, 255}));
    connect(Vp, R1.p) annotation(
      Line(points = {{-100, 0}, {-78, 0}, {-78, 0}, {-78, 0}}, color = {0, 0, 255}));
    annotation(
      Icon(graphics = {Rectangle(origin = {80, -80}, rotation = -90, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-130, 10}, {-100, -10}}), Rectangle(origin = {80, -20}, rotation = -90, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {-70, -10}}), Ellipse(extent = {{-70, -70}, {70, 70}}, endAngle = 360), Line(origin = {-28.9818, -58.4058}, points = {{-41.0182, -21.5942}, {-17.0182, 6.40582}}), Line(origin = {0.0972863, -78.99}, points = {{45.9027, 26.99}, {69.9027, -1.01003}, {-70.0973, -1.01003}}), Ellipse(extent = {{-40, -40}, {40, 40}}, endAngle = 360), Line(origin = {69.9552, -22.1621}, points = {{-29.9552, 22.1621}, {30.0448, 22.1621}}), Line(origin = {-94.991, -51.6674}, points = {{28.991, 25.991}, {-5.009, -8.009}, {-5.00902, -28.009}}), Line(origin = {-80.7929, -4.20711}, points = {{-19.2071, 4.20711}, {10.7929, 4.20711}}), Text(origin = {4, 105}, extent = {{-98, 27}, {98, -27}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.0020202),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
  end SimpleDCMachine2;

  block Chopper4Logic
    parameter Real period = 100e-6 "PWM period";
    Modelica.Blocks.Logical.And and1 annotation(
      Placement(visible = true, transformation(origin = {62, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput duty annotation(
      Placement(visible = true, transformation(origin = {-98, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput H1 annotation(
      Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput L1 annotation(
      Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1 annotation(
      Placement(visible = true, transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Abs abs1 annotation(
      Placement(visible = true, transformation(origin = {-54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2 annotation(
      Placement(visible = true, transformation(origin = {-24, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-68, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not1 annotation(
      Placement(visible = true, transformation(origin = {28, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.And and12 annotation(
      Placement(visible = true, transformation(origin = {74, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput H2 annotation(
      Placement(visible = true, transformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not11 annotation(
      Placement(visible = true, transformation(origin = {26, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput L2 annotation(
      Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or1 annotation(
      Placement(visible = true, transformation(origin = {74, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or11 annotation(
      Placement(visible = true, transformation(origin = {74, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SawTooth sawTooth1(period = period)  annotation(
      Placement(visible = true, transformation(origin = {-84, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(greaterEqual2.u2, sawTooth1.y) annotation(
      Line(points = {{-36, -46}, {-72, -46}, {-72, -46}, {-72, -46}}, color = {0, 0, 127}));
    //greaterEqual2.u2 = OpenModelica.Internal.realMod(time, period);
    connect(or11.u1, not11.y) annotation(
      Line(points = {{62, -20}, {48, -20}, {48, 20}, {38, 20}, {38, 20}}, color = {255, 0, 255}));
    connect(not1.y, or11.u2) annotation(
      Line(points = {{40, -38}, {50, -38}, {50, -28}, {62, -28}, {62, -28}}, color = {255, 0, 255}));
    connect(not1.y, or1.u1) annotation(
      Line(points = {{40, -38}, {50, -38}, {50, -60}, {62, -60}, {62, -60}}, color = {255, 0, 255}));
    connect(greaterEqual1.y, or1.u2) annotation(
      Line(points = {{-38, 80}, {-6, 80}, {-6, -68}, {62, -68}, {62, -68}}, color = {255, 0, 255}));
    connect(L1, or11.y) annotation(
      Line(points = {{110, -20}, {84, -20}, {84, -20}, {86, -20}}, color = {255, 0, 255}));
    connect(L2, or1.y) annotation(
      Line(points = {{110, -60}, {86, -60}, {86, -60}, {86, -60}}, color = {255, 0, 255}));
    connect(and1.y, H1) annotation(
      Line(points = {{73, 80}, {90, 80}, {90, 60}, {110, 60}}, color = {255, 0, 255}));
    connect(not11.u, greaterEqual1.y) annotation(
      Line(points = {{14, 20}, {-6, 20}, {-6, 80}, {-38, 80}}, color = {255, 0, 255}));
    connect(and12.u2, greaterEqual2.y) annotation(
      Line(points = {{62, 12}, {40, 12}, {40, -8}, {4, -8}, {4, -38}, {-12, -38}}, color = {255, 0, 255}));
    connect(and12.u1, not11.y) annotation(
      Line(points = {{62, 20}, {38, 20}}, color = {255, 0, 255}));
    connect(H2, and12.y) annotation(
      Line(points = {{110, 20}, {85, 20}}, color = {255, 0, 255}));
    connect(greaterEqual2.y, not1.u) annotation(
      Line(points = {{-12, -38}, {14, -38}, {14, -38}, {16, -38}}, color = {255, 0, 255}));
    connect(greaterEqual1.y, and1.u1) annotation(
      Line(points = {{-38, 80}, {50, 80}}, color = {255, 0, 255}));
    connect(greaterEqual2.y, and1.u2) annotation(
      Line(points = {{-12, -38}, {4, -38}, {4, 72}, {50, 72}}, color = {255, 0, 255}));
    connect(const.y, greaterEqual1.u2) annotation(
      Line(points = {{-56, 48}, {-48, 48}, {-48, 66}, {-74, 66}, {-74, 72}, {-62, 72}, {-62, 72}}, color = {0, 0, 127}));
    connect(abs1.y, greaterEqual2.u1) annotation(
      Line(points = {{-42, -6}, {-40, -6}, {-40, -38}, {-36, -38}, {-36, -38}}, color = {0, 0, 127}));
    connect(greaterEqual1.u1, duty) annotation(
      Line(points = {{-62, 80}, {-84, 80}, {-84, 68}, {-98, 68}, {-98, 68}}, color = {0, 0, 127}));
    connect(duty, abs1.u) annotation(
      Line(points = {{-98, 68}, {-84, 68}, {-84, -6}, {-66, -6}, {-66, -6}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.2")),
      Icon(graphics = {Text(origin = {-2, 125}, extent = {{-90, 19}, {90, -19}}, textString = "%name"), Rectangle(origin = {1, -1}, extent = {{-101, 101}, {99, -99}}), Text(origin = {-4, -119}, extent = {{-140, 17}, {140, -17}}, textString = "period=%period"), Text(origin = {62, 60}, extent = {{-8, 20}, {26, -20}}, textString = "H1", fontSize = 16), Text(origin = {62, 20}, extent = {{-8, 20}, {26, -20}}, textString = "H2", fontSize = 16), Text(origin = {64, -20}, extent = {{-8, 20}, {26, -20}}, textString = "L1", fontSize = 16), Text(origin = {64, -62}, extent = {{-8, 20}, {26, -20}}, textString = "L2", fontSize = 16), Text(origin = {-52, 62}, extent = {{-40, 18}, {18, -18}}, textString = "duty", fontSize = 16)}, coordinateSystem(initialScale = 0.1)),
  experiment(StartTime = 0, StopTime = 0.3, Tolerance = 0.0001, Interval = 6e-06),
  __OpenModelica_simulationFlags(iim = "symbolic", lv = "LOG_STATS", s = "dassl"));
  end Chopper4Logic;




  model DCMotorTest4
    extends Modelica.Icons.Example;
    Modelica.Electrical.Analog.Sources.ConstantVoltage VBUS(V = 180) annotation(
      Placement(visible = true, transformation(origin = {-8, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    DCDrive.Chopper4Logic chopper4Logic1(period = 100.123e-6)  annotation(
      Placement(visible = true, transformation(origin = {10, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 209) annotation(
      Placement(visible = true, transformation(origin = {-178, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.PowerConverters.DCAC.SinglePhase2Level singlePhase2Level1 annotation(
      Placement(visible = true, transformation(origin = {64, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.PowerConverters.DCAC.SinglePhase2Level singlePhase2Level2 annotation(
      Placement(visible = true, transformation(origin = {38, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DCDrive.SimpleDCMachine2 simpleDCMachine21(Ra = 6) annotation(
      Placement(visible = true, transformation(origin = {114, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1 annotation(
      Placement(visible = true, transformation(origin = {88, 24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {-56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  ZOH zeroOrderHold1(samplePeriod = 100e-6) annotation(
  //    Placement(visible = true, transformation(origin = {58, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold1(samplePeriod = 100e-6) annotation(
      Placement(visible = true, transformation(origin = {58, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
      Placement(visible = true, transformation(origin = {132, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain2(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-114, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback2 annotation(
      Placement(visible = true, transformation(origin = {-148, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 6) annotation(
      Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ZOH zeroOrderHold2(samplePeriod = 100e-6)  annotation(
      Placement(visible = true, transformation(origin = {96, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
  connect(zeroOrderHold2.y, feedback2.u2) annotation(
      Line(points = {{85, -44}, {-148, -44}, {-148, -8}}, color = {0, 0, 127}));
  connect(speedSensor1.w, zeroOrderHold2.u) annotation(
      Line(points = {{132, 19}, {132, -44}, {108, -44}}, color = {0, 0, 127}));
    connect(gain2.y, limiter1.u) annotation(
      Line(points = {{-102, 0}, {-96, 0}, {-96, 0}, {-94, 0}}, color = {0, 0, 127}));
    connect(feedback1.u1, limiter1.y) annotation(
      Line(points = {{-64, 0}, {-72, 0}, {-72, 0}, {-70, 0}}, color = {0, 0, 127}));
    connect(feedback2.y, gain2.u) annotation(
      Line(points = {{-139, 0}, {-126, 0}}, color = {0, 0, 127}));
    connect(const.y, feedback2.u1) annotation(
      Line(points = {{-167, 0}, {-156, 0}}, color = {0, 0, 127}));
    connect(speedSensor1.flange, simpleDCMachine21.Axle) annotation(
      Line(points = {{132, 40}, {133, 40}, {133, 50}, {124, 50}}));
    connect(currentSensor1.i, zeroOrderHold1.u) annotation(
      Line(points = {{88, 14}, {88, 14}, {88, -30}, {70, -30}, {70, -30}}, color = {0, 0, 127}));
    connect(zeroOrderHold1.y, feedback1.u2) annotation(
      Line(points = {{47, -30}, {-55, -30}, {-55, -8}, {-55, -8}}, color = {0, 0, 127}));
    connect(chopper4Logic1.duty, gain1.y) annotation(
      Line(points = {{-1, 0}, {-13, 0}, {-13, 0}, {-13, 0}}, color = {0, 0, 127}));
    connect(gain1.u, feedback1.y) annotation(
      Line(points = {{-36, 0}, {-48, 0}, {-48, 0}, {-46, 0}}, color = {0, 0, 127}));
    connect(simpleDCMachine21.Vn, currentSensor1.p) annotation(
      Line(points = {{104, 42}, {104, 42}, {104, 24}, {98, 24}, {98, 24}}, color = {0, 0, 255}));
    connect(currentSensor1.n, singlePhase2Level2.ac) annotation(
      Line(points = {{78, 24}, {48, 24}, {48, 24}, {48, 24}}, color = {0, 0, 255}));
    connect(simpleDCMachine21.Vp, singlePhase2Level1.ac) annotation(
      Line(points = {{104, 50}, {74, 50}, {74, 50}, {74, 50}}, color = {0, 0, 255}));
    connect(chopper4Logic1.L2, singlePhase2Level2.fire_n) annotation(
      Line(points = {{21, -12}, {43, -12}, {43, 12}}, color = {255, 0, 255}));
    connect(VBUS.n, singlePhase2Level2.dc_n) annotation(
      Line(points = {{-8, 26}, {-8, 18}, {28, 18}}, color = {0, 0, 255}));
    connect(singlePhase2Level2.dc_p, VBUS.p) annotation(
      Line(points = {{28, 30}, {10, 30}, {10, 46}, {-8, 46}}, color = {0, 0, 255}));
    connect(chopper4Logic1.H2, singlePhase2Level2.fire_p) annotation(
      Line(points = {{21, -4}, {31, -4}, {31, 12}}, color = {255, 0, 255}));
    connect(singlePhase2Level1.dc_n, VBUS.n) annotation(
      Line(points = {{54, 44}, {16, 44}, {16, 26}, {-8, 26}}, color = {0, 0, 255}));
    connect(VBUS.p, singlePhase2Level1.dc_p) annotation(
      Line(points = {{-8, 46}, {-8, 56}, {54, 56}}, color = {0, 0, 255}));
    connect(chopper4Logic1.L1, singlePhase2Level1.fire_n) annotation(
      Line(points = {{21, -8}, {69, -8}, {69, 38}}, color = {255, 0, 255}));
    connect(chopper4Logic1.H1, singlePhase2Level1.fire_p) annotation(
      Line(points = {{21, 0}, {57, 0}, {57, 38}}, color = {255, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 0.5, Tolerance = 0.0001, Interval = 6e-07),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "rungekuttaSsc", iim = "symbolic", maxStepSize = "0.7e-6"));
  end DCMotorTest4;


  annotation(
    uses(Modelica(version = "3.2.2")));
end DCDrive;
