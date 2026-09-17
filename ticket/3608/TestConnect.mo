encapsulated package TestConnect
  import Modelica;

  model IdOnePwm "Switches ideali Una gamba pwm OM dev490 ok"
  Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation(Placement(visible = true, transformation(origin = {35, 49}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant phase(k = 0) annotation(Placement(visible = true, transformation(origin = {37, 25}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
  TestConnect.PwmPulser pwmPulser annotation(Placement(visible = true, transformation(origin = {-13, 40}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation(Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation(Placement(visible = true, transformation(origin = {-52, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(Placement(visible = true, transformation(origin = {-84, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor Load(R = 30) annotation(Placement(visible = true, transformation(origin = {54, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation(Placement(visible = true, transformation(origin = {26, -28}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-4, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation(Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation(Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(ampl.y, pwmPulser.ampl) annotation(Line(points = {{27, 49}, {12, 49}, {12, 48}, {3, 48}}, color = {0, 0, 127}));
    connect(phase.y, pwmPulser.ph_deg) annotation(Line(points = {{29, 25}, {16, 25}, {16, 33}, {3, 33}}, color = {0, 0, 127}));
    connect(pwmPulser.down, SWu.control) annotation(Line(points = {{-27, 32}, {-40, 32}, {-40, 42}, {-45, 42}}, color = {255, 0, 255}));
    connect(pwmPulser.up, SWd.control) annotation(Line(points = {{-27, 49}, {-36, 49}, {-36, -36}, {-43, -36}}, color = {255, 0, 255}));
    connect(Rf.p, SWu.n) annotation(Line(points = {{-32, 0}, {-52, 0}, {-52, 32}}, color = {0, 0, 255}));
    connect(Lf.p, Rf.n) annotation(Line(points = {{-4, 0}, {-10, 0}, {-12, 0}}, color = {0, 0, 255}));
    connect(Load.p, Lf.n) annotation(Line(points = {{54, -14}, {54, -8.88178e-16}, {16, -8.88178e-16}}, color = {0, 0, 255}));
    connect(Cf.p, Lf.n) annotation(Line(points = {{26, -18}, {26, -8.88178e-16}, {16, -8.88178e-16}}, color = {0, 0, 255}));
    connect(ground.p, V1.n) annotation(Line(points = {{-70, 4}, {-70, 10}, {-84, 10}}, color = {0, 0, 255}));
    connect(ground1.p, Cf.n) annotation(Line(points = {{-4, -38}, {26, -38}}, color = {0, 0, 255}));
    connect(SWu.p, V1.p) annotation(Line(points = {{-52, 52}, {-52, 60}, {-84, 60}, {-84, 30}}, color = {0, 0, 255}));
    connect(V1.n, V2.p) annotation(Line(points = {{-84, 10}, {-84, -14}, {-84, -14}}, color = {0, 0, 255}));
    connect(Load.n, Cf.n) annotation(Line(points = {{54, -34}, {54, -50}, {26, -50}, {26, -38}}, color = {0, 0, 255}));
    connect(SWd.n, V2.n) annotation(Line(points = {{-50, -46}, {-50, -56}, {-84, -56}, {-84, -34}}, color = {0, 0, 255}));
    connect(SWu.n, SWd.p) annotation(Line(points = {{-52, 32}, {-52, -26}, {-50, -26}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = false)), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = false)));
  end IdOnePwm;

  model AVG "Sensor to measure the average value of input"
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-118, -12}, {-78, 28}})));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{90, 0}, {110, 20}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-60, -2}, {-40, 18}})));
    Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(transformation(extent = {{12, 0}, {32, 20}})));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(delayTime = 1 / Frequency) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-14, -22})));
    Modelica.Blocks.Math.Gain gain(k = Frequency) annotation(Placement(transformation(extent = {{52, 0}, {72, 20}})));
    parameter Modelica.SIunits.Frequency Frequency = 50.0 "Frequency of signals";
  equation
    connect(integrator.u, u) annotation(Line(points = {{-62, 8}, {-98, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u1, integrator.y) annotation(Line(points = {{10, 16}, {-14, 16}, {-14, 8}, {-39, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay1.y, add.u2) annotation(Line(points = {{-3, -22}, {4, -22}, {4, 4}, {10, 4}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay1.u, integrator.y) annotation(Line(points = {{-26, -22}, {-28, -22}, {-28, 8}, {-39, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.u, add.y) annotation(Line(points = {{50, 10}, {33, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.y, y) annotation(Line(points = {{73, 10}, {100, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Text(extent = {{150, 120}, {-150, 160}}, textString = "%name", lineColor = {0, 0, 255}), Rectangle(extent = {{-82, 64}, {90, -42}}, lineColor = {0, 0, 255}), Text(extent = {{-72, 36}, {80, -20}}, lineColor = {0, 0, 255}, textString = "AVG")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics), Documentation(info = "<html><p>
This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
</p>
</html>", revisions = "<html>
<ul>
<li><i> January 12, 2006   </i>
       by Anton Haumer<br> implemented<br>
       </li>
</ul>
</html>"));
  end AVG;

  model PwmPulser
    Modelica.Blocks.Interfaces.RealInput ampl annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
    Modelica.Blocks.Interfaces.RealInput ph_deg annotation(Placement(transformation(extent = {{-138, -76}, {-98, -36}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
    parameter Real Fcar = 1000 "Carrier Frequency";
    import PI = Modelica.Constants.pi;
  protected
    Modelica.Blocks.Sources.Trapezoid carrier(rising = 1 / (2 * Fcar), width = 0, falling = 1 / (2 * Fcar), period = 1 / Fcar, amplitude = 2, offset = -1) annotation(Placement(transformation(extent = {{14, -56}, {34, -36}})));
    Modelica.Blocks.Math.Sin sin annotation(Placement(transformation(extent = {{-20, -28}, {0, -8}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-50, 16}, {-32, 34}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * PI * Fmod) annotation(Placement(transformation(extent = {{-90, 14}, {-64, 36}})));
  public
    Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-54, -28}, {-34, -8}})));
    Modelica.Blocks.Math.Gain ToRAD(k = PI / 180) annotation(Placement(transformation(extent = {{-66, -62}, {-54, -50}})));
    Modelica.Blocks.Math.Product moduler annotation(Placement(transformation(extent = {{14, -22}, {32, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput up annotation(Placement(transformation(extent = {{100, 10}, {120, 30}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
    Modelica.Blocks.Logical.Greater greater annotation(Placement(transformation(extent = {{46, -24}, {66, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput down annotation(Placement(transformation(extent = {{100, -62}, {120, -42}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
    Modelica.Blocks.Logical.Not not1 annotation(Placement(transformation(extent = {{60, -60}, {80, -40}})));
    parameter Real Fmod = 50 "Moduler Frequency";
  equation
    connect(ToRAD.u, ph_deg) annotation(Line(points = {{-67.2, -56}, {-118, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.u, add.y) annotation(Line(points = {{-22, -18}, {-33, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u2, sin.y) annotation(Line(points = {{12.2, -18.4}, {14, -18.4}, {14, -18}, {1, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u1, integrator.y) annotation(Line(points = {{-56, -12}, {-64, -12}, {-64, 2}, {-24, 2}, {-24, 25}, {-31.1, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u1, ampl) annotation(Line(points = {{12.2, -7.6}, {12.2, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u2, ToRAD.y) annotation(Line(points = {{-56, -24}, {-64, -24}, {-64, -34}, {-46, -34}, {-46, -56}, {-53.4, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u1, moduler.y) annotation(Line(points = {{44, -14}, {46.45, -14}, {46.45, -13}, {32.9, -13}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u2, carrier.y) annotation(Line(points = {{44, -22}, {44, -46}, {35, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(up, greater.y) annotation(Line(points = {{110, 20}, {74, 20}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.y, down) annotation(Line(points = {{81, -50}, {84, -50}, {84, -52}, {110, -52}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.u, greater.y) annotation(Line(points = {{58, -50}, {52, -50}, {52, -32}, {74, -32}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(integrator.u, realExpression.y) annotation(Line(points = {{-51.8, 25}, {-62.7, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-100, 88}, {-42, 60}}, lineColor = {0, 0, 127}, textString = "ampl"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "ph(?)"), Text(extent = {{28, 86}, {100, 60}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{42, -62}, {96, -88}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5)}));
  end PwmPulser;
  annotation(uses(Modelica(version = "3.2.1")));
end TestConnect;