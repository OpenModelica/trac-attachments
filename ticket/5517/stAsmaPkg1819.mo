package stAsmaPkg1819
  // Euro Symbol: €

  package Support
    model AronSensor "Two port three-phase power sensor"
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug pc "Positive plug, current path" annotation (
        Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug nc(final m = 3) "Negative plug, current path" annotation (
        Placement(transformation(extent = {{90, 12}, {110, -8}}, rotation = 0), iconTransformation(extent = {{90, 10}, {110, -10}})));
      Modelica.Blocks.Interfaces.RealOutput y(final unit = "W") annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-20, -110})));
    equation
      for ph in 1:3 loop
        pc.pin[ph].i + nc.pin[ph].i = 0;
        pc.pin[ph].v = nc.pin[ph].v;
      end for;
      //Aron formula for power (common wire is wire 2):
      y = pc.pin[1].i * (pc.pin[1].v - pc.pin[2].v) + pc.pin[3].i * (pc.pin[3].v - pc.pin[2].v);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Line(points = {{-104, 0}, {96, 0}}, color = {0, 0, 255}), Ellipse(extent = {{-70, 70}, {70, -70}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Line(points = {{0, 70}, {0, 40}}, color = {0, 0, 0}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}, color = {0, 0, 0}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}, color = {0, 0, 0}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}, color = {0, 0, 0}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}, color = {0, 0, 0}), Line(points = {{0, 0}, {9.02, 28.6}}, color = {0, 0, 0}), Polygon(points = {{-0.48, 31.6}, {18, 26}, {18, 57.2}, {-0.48, 31.6}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{-5, 5}, {5, -5}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Text(extent = {{-39, -3}, {40, -66}}, lineColor = {0, 0, 0}, textString = "P3"), Line(points = {{-20, -104}, {-20, -66}}, color = {0, 0, 127}, smooth = Smooth.None), Text(origin = {0, 10}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-100, 102}, {100, 62}}, textString = "%name")}),
        Documentation(info = "<html>
<p><code><span style=\"font-family: Courier New,courier;\">&nbsp;Uses the <span style=\"color: #006400;\">Aron&nbsp;formula&nbsp;for&nbsp;power&nbsp;(common&nbsp;wire&nbsp;is&nbsp;wire&nbsp;2):</span></code></p>
<pre><span style=\"font-family: Courier New,courier; color: #006400;\">y=i1*(v1-v2) + i3*(v3-v2)</span></pre>
</html>"));
    end AronSensor;

    block AVG "Sensor to measure the average value of input"
      Modelica.Blocks.Interfaces.RealInput u annotation (
        Placement(transformation(extent = {{-138, -20}, {-98, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator annotation (
        Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add(k2 = -1) annotation (
        Placement(transformation(extent = {{12, -10}, {32, 10}})));
      Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(delayTime = 1 / Frequency) annotation (
        Placement(visible = true, transformation(origin = {-14, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Gain gain(k = Frequency) annotation (
        Placement(transformation(extent = {{52, -10}, {72, 10}})));
      parameter Modelica.SIunits.Frequency Frequency = 50. "Frequency of signals";
    equation
      connect(fixedDelay1.u, integrator.y) annotation (
        Line(points = {{-26, -26}, {-28, -26}, {-28, 0}, {-39, 0}}, color = {0, 0, 127}));
      connect(fixedDelay1.y, add.u2) annotation (
        Line(points = {{-3, -26}, {4, -26}, {4, -6}, {10, -6}}, color = {0, 0, 127}));
      connect(add.u1, integrator.y) annotation (
        Line(points = {{10, 6}, {-14, 6}, {-14, -2}, {-39, -2}}, color = {0, 0, 127}));
      connect(integrator.u, u) annotation (
        Line(points = {{-62, -2}, {-82, -2}, {-82, 0}, {-118, 0}}, color = {0, 0, 127}));
      connect(gain.u, add.y) annotation (
        Line(points = {{50, 0}, {33, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.y, y) annotation (
        Line(points = {{73, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Text(extent = {{104, 70}, {-108, 108}}, textString = "%name", lineColor = {0, 0, 255}), Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Text(extent = {{-72, 36}, {80, -20}}, lineColor = {0, 0, 255}, textString = "AVG")}),
        Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
        Documentation(info = "<html><p>
This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
</p>
</html>", revisions = "<html>
<ul>
<li><i> January 12, 2006   </i>
       by Anton Haumer<br> implemented<br>
       </li>
</ul>
</html>"),
        __OpenModelica_commandLineOptions = "");
    end AVG;

    block RMS "Sensor to measure the RMS value of input"
      Modelica.Blocks.Interfaces.RealInput u annotation (
        Placement(transformation(extent = {{-138, -20}, {-98, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      parameter Modelica.SIunits.Frequency Frequency = 50. "Frequency of signals";
      Modelica.Blocks.Math.Product product annotation (
        Placement(transformation(extent = {{-58, -8}, {-42, 8}})));
      Modelica.Blocks.Math.Sqrt sqrt1 annotation (
        Placement(transformation(extent = {{66, -8}, {82, 8}})));
      Modelica.Blocks.Math.Abs abs1 annotation (
        Placement(transformation(extent = {{36, -8}, {52, 8}})));
      AVG avg(Frequency = Frequency) annotation (
        Placement(transformation(extent = {{-16, -10}, {4, 10}})));
    equation
      connect(abs1.y, sqrt1.u) annotation (
        Line(points = {{52.8, 0}, {64.4, 0}}, color = {0, 0, 127}));
      connect(sqrt1.y, y) annotation (
        Line(points = {{82.8, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(product.u2, product.u1) annotation (
        Line(points = {{-59.6, -4.8}, {-66, -4.8}, {-66, 4.8}, {-59.6, 4.8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(avg.u, product.y) annotation (
        Line(points = {{-17.8, 0}, {-41.2, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(u, product.u1) annotation (
        Line(points = {{-118, 0}, {-66, 0}, {-66, 4.8}, {-59.6, 4.8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(abs1.u, avg.y) annotation (
        Line(points = {{34.4, 0}, {5, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Text(extent = {{100, 68}, {-102, 104}}, textString = "%name", lineColor = {0, 0, 255}), Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-74, 30}, {80, -14}}, lineColor = {0, 0, 255}, textString = "RMS2")}),
        Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})),
        Documentation(info = "<html>
<p>Sensore per la misura del valore efficace sdi un segnale periodico.</p>
<p>Dovendo fare una radice quadrata, a causa di errori di arrotondamento l&apos;argomento della radice pu&ograve; risultare negativo, seppur prossimo a 0; </p>
<p>Pertanto &egrave; stato frapposto un valore assoluto prima dell&apos;estrazione a radice</p>
</html>", revisions = "<html>
<ul>
<li><i> January 12, 2006   </i>
       by Anton Haumer<br> implemented<br>
       </li>
</ul>
</html>"),
        __OpenModelica_commandLineOptions = "");
    end RMS;

    model DWToI "Delta Omega to I"
      // follows eq. 12.13 from FEPE Book
      parameter Modelica.SIunits.Resistance Rr "rotor resistance in stato units";
      parameter Integer pp "pole pairs";
      parameter Real Kw "constant Komega of FEPE Book";
      parameter Modelica.SIunits.Current iMax "maximum calue of rms current";
      parameter Modelica.SIunits.Inductance Lstray "combined stray inductance";
      Modelica.SIunits.Current I "current before limitation";
      Modelica.Blocks.Interfaces.RealInput u annotation (
        Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Sources.RealExpression I_(y = I) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = iMax, uMin = 0) annotation (
        Placement(transformation(extent = {{42, -10}, {62, 10}})));
    equation
      I = sqrt(u ^ 2 * Kw ^ 2 / ((pp * u * Lstray) ^ 2 + Rr ^ 2));
      connect(I_.y, limiter.u) annotation (
        Line(points = {{11, 0}, {26, 0}, {40, 0}}, color = {0, 0, 127}));
      connect(y, limiter.y) annotation (
        Line(points = {{110, 0}, {86, 0}, {63, 0}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                   FillPattern.Solid), Line(points = {{-62, -62}, {-62, 64}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-70, 54}, {-62, 66}, {-56, 54}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-76, -54}, {68, -54}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-7, -6}, {1, 6}, {7, -6}}, color = {0, 0, 127}, smooth = Smooth.None, origin = {65, -54}, rotation = 270), Line(points = {{-68, -62}, {2, 28}, {54, 28}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-50, 68}, {-14, 40}}, lineColor = {0, 0, 127}, textString = "I"), Line(points = {{-69, 27}, {-53, 27}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "%name")}),
        version = "",
        uses,
        __OpenModelica_commandLineOptions = "");
    end DWToI;

    block GenSines "Generates three-phase sine waves"
      import Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.RealInput Westar annotation (
        Placement(transformation(extent = {{-140, 28}, {-100, 68}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 0, origin = {-113, 59})));
      Modelica.Blocks.Interfaces.RealOutput U[3] annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealInput Ustar "RMS phase" annotation (
        Placement(transformation(extent = {{-140, -60}, {-100, -20}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 0, origin = {-113, -59})));
      Modelica.Blocks.Math.Add add1[3] annotation (
        Placement(transformation(extent = {{0, 38}, {20, 58}})));
      Modelica.Blocks.Math.Sin sin[3] annotation (
        Placement(transformation(extent = {{34, 38}, {54, 58}})));
      Modelica.Blocks.Continuous.Integrator integrator annotation (
        Placement(transformation(extent = {{-72, 38}, {-52, 58}})));
      Modelica.Blocks.Routing.Replicator replicator(nout = 3) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {60, 8})));
      Modelica.Blocks.Math.Product product[3] annotation (
        Placement(transformation(extent = {{72, 28}, {92, 48}})));
      Modelica.Blocks.Math.Gain ToPeak(k = sqrt(2)) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {60, -22})));
      Modelica.Blocks.Sources.Constant phase[3](k = 2 * pi / 3 * {0, -1, 1}) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-10, 8})));
      Modelica.Blocks.Routing.Replicator replicator1(nout = 3) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-30, 48})));
    equation
      connect(sin.u, add1.y) annotation (
        Line(points = {{32, 48}, {21, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(product.y, U) annotation (
        Line(points = {{93, 38}, {102, 38}, {102, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(product.u2, replicator.y) annotation (
        Line(points = {{70, 32}, {60, 32}, {60, 19}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ToPeak.y, replicator.u) annotation (
        Line(points = {{60, -11}, {60, -4}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(sin.y, product.u1) annotation (
        Line(points = {{55, 48}, {62, 48}, {62, 44}, {70, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add1.u1, replicator1.y) annotation (
        Line(points = {{-2, 54}, {-10, 54}, {-10, 48}, {-19, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add1.u2, phase.y) annotation (
        Line(points = {{-2, 42}, {-10, 42}, {-10, 19}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(replicator1.u, integrator.y) annotation (
        Line(points = {{-42, 48}, {-51, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(integrator.u, Westar) annotation (
        Line(points = {{-74, 48}, {-82, 48}, {-88, 48}, {-120, 48}}, color = {0, 0, 127}));
      connect(ToPeak.u, Ustar) annotation (
        Line(points = {{60, -34}, {60, -34}, {60, -40}, {-120, -40}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                   FillPattern.Solid), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "%name"), Line(points = {{-4, 28}, {8, 48}, {28, 48}, {48, 8}, {70, 8}, {82, 28}}, color = {0, 0, 0}), Line(points = {{-6, 4}, {6, 24}, {26, 24}, {46, -16}, {68, -16}, {80, 4}}, color = {0, 0, 0}), Line(points = {{-8, -16}, {4, 4}, {24, 4}, {44, -36}, {66, -36}, {78, -16}}, color = {0, 0, 0}), Rectangle(extent = {{-88, 10}, {-60, -4}}, lineColor = {0, 0, 0}), Polygon(points = {{-60, 18}, {-34, 4}, {-60, -10}, {-60, 18}}, lineColor = {0, 0, 0})}),
        Documentation(info = "<html>
<p>This class produces a three-phase voltage system to variable-frequency control of an asynchronous motor.</p>
<p>The output voltages constitute a three-phase system of quasi-sinusoidal shapes, created according to the following equations:</p>
<p>Wel=Wmecc*PolePairs+DeltaWel</p>
<p>U=U0+(Un-U0)*(Wel)/Wnom</p>
<p>where:</p>
<p><ul>
<li>U0, Un U, are initial, nominal actual voltage amplitudes</li>
<li>Wmecc, Wel are machine (mechanical) and supply (electrical) angular speeds</li>
<li>PolePairs are the number of machine pole pairs</li>
<li>DeltaWel is an input variable and depends on the desired torque</li>
</ul></p>
</html>"));
    end GenSines;

    block ControlLogic "Follows upper fig. 12.15 from FEPE Book"
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance Rr(start = 0.04) "Rotor resistance";
      parameter Modelica.SIunits.Resistance Rs(start = 0.03) "Stator resistance";
      parameter Modelica.SIunits.Voltage uBase(start = 400) "Base phase-to-phase RMS voltage";
      parameter Modelica.SIunits.Current iMax(start = 150) "Maximum value of RMS current";
      parameter Modelica.SIunits.AngularVelocity weBase = 314.16 "Base electric frequency";
      parameter Modelica.SIunits.Inductance Lstray(start = 0.2036 / weBase) "Combined stray inductance";
      parameter Modelica.SIunits.AngularVelocity wmMax = 314.16 "Maximum mechanical Speed";
      parameter Integer pp(min = 1, start = 2) "number of pole pairs (Integer)";
      //La seguente keyword final consente fra l'altro di far scomparire questi parametri dalla maschera.
      final parameter Real Kw(fixed = true) = uBase / sqrt(3) / (weBase / pp) "Ratio U/Wmecc";
      Modelica.Blocks.Interfaces.RealInput Wm annotation (
        Placement(transformation(extent = {{-160, -80}, {-120, -40}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 90, origin = {1, -113})));
      Modelica.Blocks.Interfaces.RealOutput Ustar annotation (
        Placement(transformation(extent = {{120, -50}, {140, -30}}), iconTransformation(extent = {{100, -70}, {120, -50}})));
      Modelica.Blocks.Interfaces.RealInput Tstar annotation (
        Placement(transformation(extent = {{-160, 40}, {-120, 80}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 0, origin = {-113, -1})));
      Modelica.Blocks.Math.Add add annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-38, 56})));
      Modelica.Blocks.Nonlinear.Limiter limWm(limitsAtInit = true, uMax = wmMax, uMin = uBase / sqrt(3) / 100 / Kw) annotation (
        Placement(transformation(extent = {{0, 50}, {20, 70}})));
      Modelica.Blocks.Interfaces.RealOutput Westar annotation (
        Placement(transformation(extent = {{120, 50}, {140, 70}}), iconTransformation(extent = {{100, 50}, {120, 70}})));
      stAsmaPkg1819.Support.TorqueToDW tauToDW(Rr = Rr, pp = pp, Kw = Kw, Lstray = Lstray, wmBase = weBase / pp) annotation (
        Placement(transformation(extent = {{-100, 50}, {-80, 70}})));
      Modelica.Blocks.Math.Gain gain(k = pp) annotation (
        Placement(transformation(extent = {{62, 50}, {82, 70}})));
      Modelica.Blocks.Math.Add add1(k1 = Rs, k2 = Kw) annotation (
        Placement(transformation(extent = {{40, 10}, {60, -10}})));
      Modelica.Blocks.Nonlinear.Limiter limU(uMax = uBase / sqrt(3), uMin = 0) annotation (
        Placement(transformation(extent = {{76, -10}, {96, 10}})));
      Modelica.Blocks.Logical.GreaterThreshold toWeakening(threshold = limU.uMax) annotation (
        Placement(visible = true, transformation(origin = {66, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Logical.GreaterThreshold toMaxSpeed(threshold = limWm.uMax) annotation (
        Placement(visible = true, transformation(origin = {-10, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.RealExpression toIstar(y = sqrt(Tstar * tauToDW.y / (3 * Rs))) annotation (
        Placement(transformation(extent = {{-30, -18}, {8, 0}})));
    equation
      connect(toMaxSpeed.u, limWm.u) annotation (
        Line(points = {{-10, 40}, {-10, 40}, {-10, 60}, {-2, 60}, {-2, 60}, {-2, 60}}, color = {0, 0, 127}));
      connect(limWm.u, add.y) annotation (
        Line(points = {{-2, 60}, {-12, 60}, {-12, 72}, {-38, 72}, {-38, 67}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(Tstar, tauToDW.u) annotation (
        Line(points = {{-140, 60}, {-122, 60}, {-122, 66}, {-102, 66}}, color = {0, 0, 127}));
      connect(tauToDW.y, add.u1) annotation (
        Line(points = {{-79, 60}, {-79, 60}, {-74, 60}, {-74, 44}, {-44, 44}}, color = {0, 0, 127}));
      connect(add.u2, Wm) annotation (
        Line(points = {{-32, 44}, {-32, 44}, {-32, 14}, {-110, 14}, {-110, -18}, {-110, -18}, {-110, -60}, {-140, -60}}, color = {0, 0, 127}));
      connect(Westar, gain.y) annotation (
        Line(points = {{130, 60}, {106, 60}, {83, 60}}, color = {0, 0, 127}));
      connect(gain.u, limWm.y) annotation (
        Line(points = {{60, 60}, {50, 60}, {20, 60}, {21, 60}}, color = {0, 0, 127}));
      connect(add1.y, limU.u) annotation (
        Line(points = {{61, 0}, {74, 0}}, color = {0, 0, 127}));
      connect(limU.y, Ustar) annotation (
        Line(points = {{97, 0}, {102, 0}, {102, -40}, {130, -40}}, color = {0, 0, 127}));
      connect(tauToDW.Wm, Wm) annotation (
        Line(points = {{-102, 54}, {-110, 54}, {-110, -60}, {-140, -60}}, color = {0, 0, 127}));
      connect(add1.u2, limWm.y) annotation (
        Line(points = {{38, 6}, {34, 6}, {34, 60}, {21, 60}}, color = {0, 0, 127}));
      connect(toWeakening.u, limU.u) annotation (
        Line(points = {{66, -24}, {66, 0}, {74, 0}}, color = {0, 0, 127}));
      connect(toIstar.y, add1.u1) annotation (
        Line(points = {{9.9, -9}, {22, -9}, {22, -6}, {38, -6}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -80}, {120, 80}}, initialScale = 0.1), graphics={  Text(origin = {2, 0}, lineColor = {28, 108, 200}, extent = {{-48, -12}, {18, -22}}, textString = "E' la prima uguaglianza di 12.14 di FEPE")}),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                   FillPattern.Solid), Line(points = {{-40, -50}, {-40, 76}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-48, 66}, {-40, 78}, {-34, 66}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-54, -42}, {90, -42}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-7, -6}, {1, 6}, {7, -6}}, color = {0, 0, 127}, smooth = Smooth.None, origin = {87, -42}, rotation = 270), Line(points = {{-46, -28}, {24, 40}, {76, 40}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-47, -23}, {-31, -23}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-82, -6}, {-51, -34}}, lineColor = {0, 0, 127}, textString = "Uo"), Text(extent = {{-84, 54}, {-48, 26}}, lineColor = {0, 0, 127}, textString = "Un"), Line(points = {{-47, 39}, {-31, 39}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{9, -47}, {52, -78}}, lineColor = {0, 0, 127}, textString = "Wn"), Line(points = {{26, -14}, {26, -46}, {26, -36}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "%name")}),
        Documentation(info = "<html>
<p>This class produces a three-phase voltage system to variable-frequency control of an asynchronous motor.</p>
<p>The output voltages constitute a three-phase system of quasi-sinusoidal shapes, created according to the following equations:</p>
<p>Wel=Wmecc*PolePairs+DeltaWel</p>
<p>U=U0+(Un-U0)*(Wel)/Wnom</p>
<p>where:</p>
<p><ul>
<li>U0, Un U, are initial, nominal actual voltage amplitudes</li>
<li>Wmecc, Wel are machine (mechanical) and supply (electrical) angular speeds</li>
<li>PolePairs are the number of machine pole pairs</li>
<li>DeltaWel is an input variable and depends on the desired torque</li>
</ul></p>
</html>"),
        experiment(StopTime = 500, Interval = 0.1));
    end ControlLogic;

    model TorqueToDW "Torque to Delta Omega"
      parameter Modelica.SIunits.Resistance Rr "Rotor resistance in stato units";
      parameter Integer pp "Pole pairs";
      parameter Real Kw "Constant Komega of FEPE Book";
      parameter Modelica.SIunits.AngularVelocity wmBase = 314.16 "Base electric frequency";
      parameter Modelica.SIunits.Inductance Lstray "Combined stray inductance";
      //The following is 12.11 of FEPE book, when U1=Kw*W (LS stands for low speed)
      Modelica.SIunits.Torque Tmax;
    public
      Modelica.Blocks.Interfaces.RealInput u annotation (
        Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealInput Wm annotation (
        Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
      Modelica.Blocks.Interfaces.BooleanOutput tauIsMax annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {0, -110})));
    equation
      if Wm < wmBase then
        Tmax = 3 * Kw ^ 2 / (2 * pp * Lstray);
      else
        //The following is 12.11 of FEPE book
        Tmax = 3 * (Kw * wmBase) ^ 2 / (2 * pp * Wm ^ 2 * Lstray);
      end if;
      //Se la coppia richiesta supera la massima mi attesto al deltaW
      //che corrisponde al picco di coppia
      if u > Tmax then
        Tmax = 3 * Rr * y * Kw ^ 2 / ((pp * y * Lstray) ^ 2 + Rr ^ 2);
        //    y = Rr / (pp*Lstray);
        tauIsMax = true;
      elseif u < (-Tmax) then
        -Tmax = 3 * Rr * y * Kw ^ 2 / ((pp * y * Lstray) ^ 2 + Rr ^ 2);
        //    y = -Rr / (pp * Lstray);
        tauIsMax = true;
      else
        /* La seguente riga è eq. 12.14 di FEPE Book. Naturalmente essa 
        determina una richiesta di coppia corretta a pieno flusso, zona nella quale 
        vale la 12.14, mentre è approssimata in deflussaggio. Peraltro essendo 
        normalmente il controllo in velocità in retroazione, in questo modello 
        semplificato si accetta questo tipo di delta_omega, che determina una 
        potenza decrescente invece che costante come potrebbe essere.       
      */
        u = 3 * Rr * y * Kw ^ 2 / ((pp * y * Lstray) ^ 2 + Rr ^ 2);
        /*  Si potrebbe completare il controllo facendo in modo che al di sopra della 
        velocità base si applichi la formula 12.10 di FEPE in cui U1=Kw*wmBase.
        Al posto di W0 si può mettere Wm+y.
        Le formule si complicano e quindi per ragioni didattiche non lo facciamo.
        
        Si riporta comunque qui sotto un'implementazione provvisoria con coppia 
        valida in tutte le regioni, da ultimare e verificare:
        */
        //u=3*(Kw*wmBase)^2*Rr*y/(y^2*pp^2*(Wm+y)^2*Lstray^2+Rr^2*(Wm+y));
        tauIsMax = false;
      end if;
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                   FillPattern.Solid), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "%name"), Line(points = {{-67, -26}, {-51, -26}, {-51, -22}, {-49, -15}, {-40, -8}, {18, 25}, {26, 32}, {29, 37}, {29, 42}, {49, 42}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-66, 8}, {78, 8}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-12, -44}, {-12, 82}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-20, 72}, {-12, 84}, {-6, 72}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{16, 72}, {52, 44}}, lineColor = {0, 0, 127}, textString = "DW"), Line(points = {{-7, -6}, {1, 6}, {7, -6}}, color = {0, 0, 127}, smooth = Smooth.None, origin = {75, 8}, rotation = 270), Text(extent = {{60, -6}, {96, -34}}, lineColor = {0, 0, 127}, textString = "T")}));
    end TorqueToDW;
  end Support;
  annotation (
    uses(Modelica(version = "3.2.2")),
    Documentation(info = "<html>
<p>Package to simulate asynchronous-machine behaviour, mainly evaluated on start-ups.</p>
<p>It contains a Drives subpackage, which illustrates advantage and performance of U/f asma-based drives.</p>
<p><br>Drives are fist used with time-domain ASMA models. Then it is seen that for drives Phasor ASMA models are adequate, then they are used.</p>
</html>"));
end stAsmaPkg1819;
