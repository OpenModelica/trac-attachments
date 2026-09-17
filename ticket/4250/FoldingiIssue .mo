within ;
package FoldingIssue
  // €

  package SubPkg

    block NotFoldingModel "Constant U/f ratio plus U0"
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Voltage Ubase(start = 400) "Base phase-to-phase RMS voltage";
      parameter Modelica.SIunits.AngularVelocity WeBase(start = 314.15) "Base electric frequency";
      parameter Modelica.SIunits.AngularVelocity WeMax(start = 314.15) "Maximum Electric frequency";
      parameter Integer pp(min = 1, start = 2) "number of pole pairs (Integer)";
      Modelica.Blocks.Interfaces.RealInput Wm annotation(Placement(transformation(extent = {{-180, 40}, {-140, 80}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 90, origin = {63, -113})));
      Modelica.Blocks.Interfaces.RealOutput U[3] annotation(Placement(transformation(extent = {{140, 50}, {160, 70}}), iconTransformation(extent = {{100, 30}, {120, 50}})));
    protected
      Modelica.Blocks.Math.Gain PolePairsG(k = pp) annotation(Placement(transformation(extent = {{-130, 50}, {-110, 70}})));
    public
      Modelica.Blocks.Interfaces.RealInput DWe annotation(Placement(transformation(extent = {{-180, -40}, {-140, 0}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 90, origin = {-59, -113})));
    protected
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMin = 0, uMax = Ubase) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, -28})));
    protected
      Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMin = 0, uMax = WeMax) annotation(Placement(transformation(extent = {{-72, 40}, {-52, 60}})));
      Modelica.Blocks.Math.Add add1[3] annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
      Modelica.Blocks.Math.Sin sin[3] annotation(Placement(transformation(extent = {{74, 60}, {94, 80}})));
      Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-32, 60}, {-12, 80}})));
      Modelica.Blocks.Routing.Replicator replicator(nout = 3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 30})));
      Modelica.Blocks.Math.Product product[3] annotation(Placement(transformation(extent = {{112, 50}, {132, 70}})));
      Modelica.Blocks.Math.Gain ToPeak(k = sqrt(2 / 3)) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {100, 0})));
      Modelica.Blocks.Sources.Constant phase[3](k = 2 * pi / 3 * {0, -1, 1}) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, 30})));
      Modelica.Blocks.Routing.Replicator replicator1(nout = 3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {10, 70})));
    public
      Modelica.Blocks.Interfaces.RealOutput Wel annotation(Placement(transformation(extent = {{140, -70}, {160, -50}}), iconTransformation(extent = {{100, -50}, {120, -30}})));
      Modelica.Blocks.Sources.RealExpression amplitude(y = alBreak.y + (Ubase - alBreak.y) * Wel / WeBase) annotation(Placement(transformation(extent = {{32, -56}, {86, -34}})));
    public
      Modelica.Blocks.Interfaces.RealInput U0 annotation(Placement(transformation(extent = {{-180, -100}, {-140, -60}}), iconTransformation(extent = {{-126, -12}, {-100, 14}})));
      Modelica.Blocks.Continuous.FirstOrder alBreak(T = 0.01) annotation(Placement(transformation(extent = {{-128, -90}, {-108, -70}})));
    equation
      connect(add.u1, PolePairsG.y) annotation(Line(points = {{-102, 56}, {-102, 60}, {-109, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(limiter.u, add.y) annotation(Line(points = {{-74, 50}, {-79, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(sin.u, add1.y) annotation(Line(points = {{72, 70}, {61, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(integrator.u, limiter.y) annotation(Line(points = {{-34, 70}, {-34, 50}, {-51, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(product.y, U) annotation(Line(points = {{133, 60}, {150, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(product.u2, replicator.y) annotation(Line(points = {{110, 54}, {100, 54}, {100, 41}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ToPeak.y, replicator.u) annotation(Line(points = {{100, 11}, {100, 18}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(sin.y, product.u1) annotation(Line(points = {{95, 70}, {102, 70}, {102, 66}, {110, 66}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add1.u1, replicator1.y) annotation(Line(points = {{38, 76}, {30, 76}, {30, 70}, {21, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add1.u2, phase.y) annotation(Line(points = {{38, 64}, {30, 64}, {30, 41}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(Wel, limiter.y) annotation(Line(points = {{150, -60}, {-42, -60}, {-42, 50}, {-51, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(Wel, Wel) annotation(Line(points = {{150, -60}, {150, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(PolePairsG.u, Wm) annotation(Line(points = {{-132, 60}, {-160, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(replicator1.u, integrator.y) annotation(Line(points = {{-2, 70}, {-11, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(DWe, add.u2) annotation(Line(points = {{-160, -20}, {-102, -20}, {-102, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(ToPeak.u, limiter1.y) annotation(Line(points = {{100, -12}, {100, -17}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(amplitude.y, limiter1.u) annotation(Line(points = {{88.7, -45}, {90, -44}, {100, -44}, {100, -40}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(U0, alBreak.u) annotation(Line(points = {{-160, -80}, {-146, -80}, {-130, -80}}, color = {0, 0, 127}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-11, 3}, {11, -3}}, lineColor = {0, 0, 255}, textString = "Omega", origin = {-47, 1}, rotation = 90)}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-40, -50}, {-40, 76}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-48, 66}, {-40, 78}, {-34, 66}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-54, -42}, {90, -42}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-7, -6}, {1, 6}, {7, -6}}, color = {0, 0, 127}, smooth = Smooth.None, origin = {87, -42}, rotation = 270), Line(points = {{-46, -28}, {24, 40}, {76, 40}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-47, -23}, {-31, -23}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-82, -6}, {-51, -34}}, lineColor = {0, 0, 127}, textString = "Uo"), Text(extent = {{-84, 54}, {-48, 26}}, lineColor = {0, 0, 127}, textString = "Un"), Line(points = {{-47, 39}, {-31, 39}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{9, -47}, {52, -78}}, lineColor = {0, 0, 127}, textString = "Wn"), Line(points = {{26, -14}, {26, -46}, {26, -36}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "%name")}), Documentation(info = "<html>
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
    end NotFoldingModel;

    block FoldingModel "Follows upper fig. 12.15 from FEPE Book"
    import Modelica.Constants.pi;
      parameter Modelica.SIunits.Resistance Rr(start = 0.04) "Rotor resistance";
      parameter Modelica.SIunits.Resistance Rs(start = 0.03) "Stator resistance";
      parameter Modelica.SIunits.Voltage Ubase(start = 400) "Base phase-to-phase RMS voltage";
      parameter Modelica.SIunits.Current Imax(start = 150) "Maximum value of rms current";
      parameter Modelica.SIunits.AngularVelocity WeBase(start = 314.16) "Base electric frequency";
      parameter Modelica.SIunits.Inductance Lstray(start = 0.2036 / WeBase) "Combined stray inductance";
      parameter Modelica.SIunits.AngularVelocity WmMax(start = 314.16) "Maximum Electric frequency";
      parameter Integer pp(min = 1, start = 2) "number of pole pairs (Integer)";
      //La seguente keyword final consente fra l'altro di far scomparire questi parametri dalla maschera.
      final parameter Real Kw(fixed = true) = Ubase / sqrt(3) / (WeBase / pp) "Ratio U/Wmecc";
    public
      Modelica.Blocks.Interfaces.RealInput Wm annotation(
        Placement(transformation(extent = {{-160, -80}, {-120, -40}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 90, origin = {1, -113})));
      Modelica.Blocks.Interfaces.RealOutput Ustar annotation(
        Placement(transformation(extent = {{120, -50}, {140, -30}}), iconTransformation(extent = {{100, -70}, {120, -50}})));
      Modelica.Blocks.Interfaces.RealInput Tstar annotation(
        Placement(transformation(extent = {{-160, 40}, {-120, 80}}), iconTransformation(extent = {{-13, -13}, {13, 13}}, rotation = 0, origin = {-113, -1})));
    protected
      Modelica.Blocks.Math.Add add annotation(
        Placement(transformation(extent = {{-100, -26}, {-80, -6}})));
      Modelica.Blocks.Nonlinear.Limiter limWm(uMax = WmMax, uMin = Ubase / sqrt(3) / 10) annotation(
        Placement(transformation(extent = {{-54, -26}, {-34, -6}})));
    public
      Modelica.Blocks.Interfaces.RealOutput Westar annotation(
        Placement(transformation(extent = {{120, 50}, {140, 70}}), iconTransformation(extent = {{100, 50}, {120, 70}})));
      TorqueToDW torqueToDW(Rr = Rr, pp = pp, Kw = Kw, Lstray = Lstray) annotation(
        Placement(transformation(extent = {{-100, 50}, {-80, 70}})));
      Modelica.Blocks.Math.Gain gain(k = pp) annotation(
        Placement(transformation(extent = {{62, 50}, {82, 70}})));
      Modelica.Blocks.Math.Add add1(k1 = Rs, k2 = Kw) annotation(
        Placement(transformation(extent = {{40, -10}, {60, 10}})));
      DWToI dWToI(Rr = Rr, pp = pp, Kw = Kw, Imax = Imax, Lstray = Lstray) annotation(
        Placement(transformation(extent = {{-12, 20}, {8, 40}})));
      Modelica.Blocks.Math.Gain gain1(k = Kw) annotation(
        Placement(transformation(extent = {{34, -42}, {54, -22}})));
    protected
      Modelica.Blocks.Nonlinear.Limiter limU(uMin = 0, uMax = Ubase / sqrt(3)) annotation(
        Placement(transformation(extent = {{76, -10}, {96, 10}})));
    equation
      connect(limWm.u, add.y) annotation(
        Line(points = {{-56, -16}, {-79, -16}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(Tstar, torqueToDW.u) annotation(
        Line(points = {{-140, 60}, {-102, 60}}, color = {0, 0, 127}));
      connect(torqueToDW.y, add.u1) annotation(
        Line(points = {{-79, 60}, {-79, 60}, {-60, 60}, {-60, 40}, {-102, 40}, {-102, -10}}, color = {0, 0, 127}));
      connect(add.u2, Wm) annotation(
        Line(points = {{-102, -22}, {-110, -22}, {-110, -60}, {-140, -60}}, color = {0, 0, 127}));
      connect(dWToI.u, add.u1) annotation(
        Line(points = {{-14, 30}, {-14, 30}, {-40, 30}, {-102, 30}, {-102, -10}}, color = {0, 0, 127}));
      connect(dWToI.y, add1.u1) annotation(
        Line(points = {{9, 30}, {9, 28}, {34, 28}, {34, 6}, {38, 6}}, color = {0, 0, 127}));
      connect(Westar, gain.y) annotation(
        Line(points = {{130, 60}, {106, 60}, {83, 60}}, color = {0, 0, 127}));
      connect(gain.u, limWm.y) annotation(
        Line(points = {{60, 60}, {50, 60}, {20, 60}, {20, -16}, {-33, -16}}, color = {0, 0, 127}));
      connect(add1.u2, limWm.y) annotation(
        Line(points = {{38, -6}, {-4, -6}, {-4, -16}, {-33, -16}}, color = {0, 0, 127}));
      connect(gain1.u, limWm.y) annotation(
        Line(points = {{32, -32}, {20, -32}, {20, -16}, {-33, -16}}, color = {0, 0, 127}));
      connect(add1.y, limU.u) annotation(
        Line(points = {{61, 0}, {74, 0}}, color = {0, 0, 127}));
      connect(limU.y, Ustar) annotation(
        Line(points = {{97, 0}, {102, 0}, {102, -40}, {130, -40}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -80}, {120, 80}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-40, -50}, {-40, 76}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-48, 66}, {-40, 78}, {-34, 66}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-54, -42}, {90, -42}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-7, -6}, {1, 6}, {7, -6}}, color = {0, 0, 127}, smooth = Smooth.None, origin = {87, -42}, rotation = 270), Line(points = {{-46, -28}, {24, 40}, {76, 40}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-47, -23}, {-31, -23}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-82, -6}, {-51, -34}}, lineColor = {0, 0, 127}, textString = "Uo"), Text(extent = {{-84, 54}, {-48, 26}}, lineColor = {0, 0, 127}, textString = "Un"), Line(points = {{-47, 39}, {-31, 39}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{9, -47}, {52, -78}}, lineColor = {0, 0, 127}, textString = "Wn"), Line(points = {{26, -14}, {26, -46}, {26, -36}}, color = {0, 0, 127}, smooth = Smooth.None), Text(extent = {{-100, 144}, {98, 106}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "%name")}),
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
    end FoldingModel;
  end SubPkg;
  annotation(uses(Modelica(version = "3.2.1")));
end FoldingIssue;
