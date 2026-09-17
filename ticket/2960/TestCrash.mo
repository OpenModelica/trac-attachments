encapsulated package Test
  import Modelica;

  model IdTwoPwm "Id switches - TwoLegs OM dev490 ok"
    Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation(Placement(visible = true, transformation(origin = {83, 57}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant phase(k = 0) annotation(Placement(visible = true, transformation(origin = {61, 43}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
    PwmPulser pwmPulser annotation(Placement(visible = true, transformation(origin = {23, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation(Placement(visible = true, transformation(origin = {-48, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation(Placement(visible = true, transformation(origin = {-48, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(Placement(visible = true, transformation(origin = {-76, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor Load(R = 30) annotation(Placement(visible = true, transformation(origin = {82, -4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation(Placement(visible = true, transformation(origin = {60, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(Placement(visible = true, transformation(origin = {-76, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-94, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation(Placement(visible = true, transformation(origin = {12, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Mean mean1(f = 1000) annotation(Placement(visible = true, transformation(origin = {118, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu1 annotation(Placement(visible = true, transformation(origin = {-18, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu2 annotation(Placement(visible = true, transformation(origin = {-18, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Sources.BooleanExpression ul(y = pwmPulser.up) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-38, 66})));
    Modelica.Blocks.Sources.BooleanExpression ur(y = pwmPulser.down) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-10, 64})));
    Modelica.Blocks.Sources.BooleanExpression dl(y = pwmPulser.down) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-40, -66})));
    Modelica.Blocks.Sources.BooleanExpression dr(y = pwmPulser.up) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-8, -64})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vInv annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-34, 4})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vLoad annotation(Placement(visible = true, transformation(origin = {108, -2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  equation
    connect(mean1.u, vLoad.v) annotation(Line(points = {{118, -36}, {124, -36}, {124, -2}, {118, -2}, {118, -2}}, color = {0, 0, 127}));
    connect(vLoad.n, Load.n) annotation(Line(points = {{108, -12}, {108, -12}, {108, -30}, {82, -30}, {82, -14}, {82, -14}, {82, -14}}, color = {0, 0, 255}));
    connect(vLoad.p, Lf.n) annotation(Line(points = {{108, 8}, {108, 8}, {108, 20}, {50, 20}, {50, 20}}, color = {0, 0, 255}));
    connect(Lf.p, Rf.n) annotation(Line(points = {{30, 20}, {24, 20}, {22, 20}}, color = {0, 0, 255}));
    connect(Load.p, Lf.n) annotation(Line(points = {{82, 6}, {82, 20}, {50, 20}}, color = {0, 0, 255}));
    connect(Cf.p, Lf.n) annotation(Line(points = {{60, 2}, {60, 20}, {50, 20}}, color = {0, 0, 255}));
    connect(ground.p, V1.n) annotation(Line(points = {{-94, -8}, {-94, -4}, {-94, 0}, {-76, 0}, {-76, 10}}, color = {0, 0, 255}));
    connect(SWu.p, V1.p) annotation(Line(points = {{-48, 52}, {-48, 60}, {-76, 60}, {-76, 30}}, color = {0, 0, 255}));
    connect(V1.n, V2.p) annotation(Line(points = {{-76, 10}, {-76, 4}, {-76, -14}}, color = {0, 0, 255}));
    connect(Load.n, Cf.n) annotation(Line(points = {{82, -14}, {82, -30}, {60, -30}, {60, -18}}, color = {0, 0, 255}));
    connect(SWd.n, V2.n) annotation(Line(points = {{-48, -42}, {-48, -50}, {-76, -50}, {-76, -34}}, color = {0, 0, 255}));
    connect(SWu.n, SWd.p) annotation(Line(points = {{-48, 32}, {-48, -22}}, color = {0, 0, 255}));
    connect(SWu1.p, V1.p) annotation(Line(points = {{-18, 52}, {-18, 60}, {-76, 60}, {-76, 30}}, color = {0, 0, 255}));
    connect(SWu1.n, SWu2.p) annotation(Line(points = {{-18, 32}, {-18, -22}}, color = {0, 0, 255}));
    connect(SWu2.n, V2.n) annotation(Line(points = {{-18, -42}, {-18, -50}, {-76, -50}, {-76, -34}}, color = {0, 0, 255}));
    connect(Rf.p, SWd.p) annotation(Line(points = {{2, 20}, {-48, 20}, {-48, -22}}, color = {0, 0, 255}));
    connect(Cf.n, SWu2.p) annotation(Line(points = {{60, -18}, {60, -30}, {0, -30}, {0, -14}, {-18, -14}, {-18, -22}}, color = {0, 0, 255}));
    connect(SWu.control, ul.y) annotation(Line(points = {{-41, 42}, {-38, 42}, {-38, 55}}, color = {255, 0, 255}));
    connect(SWu1.control, ur.y) annotation(Line(points = {{-11, 42}, {-10, 42}, {-10, 53}}, color = {255, 0, 255}));
    connect(dl.y, SWd.control) annotation(Line(points = {{-40, -55}, {-39, -55}, {-39, -32}, {-41, -32}}, color = {255, 0, 255}));
    connect(dr.y, SWu2.control) annotation(Line(points = {{-8, -53}, {-11, -53}, {-11, -32}}, color = {255, 0, 255}));
    connect(phase.y, pwmPulser.ph_deg) annotation(Line(points = {{53.3, 43}, {47.65, 43}, {47.65, 42.98}, {38.6, 42.98}}, color = {0, 0, 127}));
    connect(ampl.y, pwmPulser.ampl) annotation(Line(points = {{75.3, 57}, {59.65, 57}, {59.65, 58.32}, {38.6, 58.32}}, color = {0, 0, 127}));
    connect(vInv.p, SWd.p) annotation(Line(points = {{-44, 4}, {-48, 4}, {-48, -22}}, color = {0, 0, 255}));
    connect(vInv.n, SWu2.p) annotation(Line(points = {{-24, 4}, {-18, 4}, {-18, -22}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"), Diagram(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(origin = {2, -4}, lineColor = {255, 0, 0}, extent = {{32, -44}, {80, -66}}, textString = "Es. proposto: TwoSQW", fontName = "MS Shell Dlg 2")}), Icon(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end IdTwoPwm;

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
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-100, 88}, {-42, 60}}, lineColor = {0, 0, 127}, textString = "ampl"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "ph(?)"), Text(extent = {{28, 86}, {100, 60}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{42, -62}, {96, -88}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5), Text(extent = {{-100, 140}, {100, 110}}, lineColor = {0, 0, 255}, textString = "%name")}));
  end PwmPulser;
  annotation(uses(Modelica(version = "3.2.2")));
end Test;
