encapsulated package invPWMPkg
  import Modelica;

  model InvPwmPQ "WIth valve-diode couples"
    Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation(Placement(visible = true, transformation(extent = {{-42, -10}, {-22, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation(Placement(visible = true, transformation(extent = {{-6, -10}, {14, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 0.000634) annotation(Placement(visible = true, transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-84, -16}, {-64, 4}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(Placement(visible = true, transformation(origin = {-84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(extent = {{-14, -58}, {6, -38}}, rotation = 0)));
    invPWMPkg.PwmPulser pwmPulser annotation(Placement(visible = true, transformation(origin = {15, 44}, extent = {{-13, -12}, {13, 12}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant phase(k = +10) annotation(Placement(visible = true, transformation(origin = {67, 59}, extent = {{-9, -9}, {9, 9}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant Ampl(k = 0.9) annotation(Placement(visible = true, transformation(origin = {67, 29}, extent = {{-9, -9}, {9, 9}}, rotation = 180)));
    Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor(Vknee = 0.1) annotation(Placement(visible = true, transformation(origin = {-48, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Vknee = 0.1) annotation(Placement(visible = true, transformation(origin = {-68, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor1(Vknee = 0.1) annotation(Placement(visible = true, transformation(origin = {-40, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1(Vknee = 0.1) annotation(Placement(visible = true, transformation(origin = {-60, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sources.SineVoltage E(V = 40, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  equation
    connect(Ampl.y, pwmPulser.Ampl) annotation(
      Line(points = {{57, 29}, {43.65, 29}, {43.65, 36.32}, {30.6, 36.32}}, color = {0, 0, 127}));
    connect(phase.y, pwmPulser.Ph_deg) annotation(
      Line(points = {{57, 59}, {37.65, 59}, {37.65, 50.48}, {30.6, 50.48}}, color = {0, 0, 127}));
    connect(Lf.n, E.p) annotation(
      Line(points = {{14, 0}, {60, 0}, {60, -10}}, color = {0, 0, 255}));
    connect(E.n, Cf.n) annotation(
      Line(points = {{60, -30}, {30, -30}}, color = {0, 0, 255}));
    connect(Cf.p, Lf.n) annotation(
      Line(points = {{30, -10}, {30, -10}, {30, 0}, {14, 0}, {14, 0}}, color = {0, 0, 255}));
    connect(Rf.p, idealDiode1.n) annotation(
      Line(points = {{-42, 0}, {-51, 0}, {-51, 0}, {-60, 0}, {-60, -28}}, color = {0, 0, 255}));
    connect(idealDiode.p, idealDiode1.n) annotation(
      Line(points = {{-68, 44}, {-68, 30}, {-60, 30}, {-60, -28}}, color = {0, 0, 255}));
    connect(idealDiode1.n, idealGTOThyristor1.p) annotation(
      Line(points = {{-60, -28}, {-60, -22}, {-40, -22}, {-40, -28}}, color = {0, 0, 255}));
    connect(V2.n, idealDiode1.p) annotation(
      Line(points = {{-84, -34}, {-84, -62}, {-60, -62}, {-60, -48}}, color = {0, 0, 255}));
    connect(idealGTOThyristor1.n, idealDiode1.p) annotation(
      Line(points = {{-40, -48}, {-40, -62}, {-60, -62}, {-60, -48}}, color = {0, 0, 255}));
    connect(pwmPulser.Bot, idealGTOThyristor1.fire) annotation(
      Line(points = {{0.7, 50.96}, {-12, 50.96}, {-12, -44}, {-29, -44}, {-29, -45}}, color = {255, 0, 255}));
    connect(V1.p, idealDiode.n) annotation(
      Line(points = {{-84, 30}, {-84, 72}, {-68, 72}, {-68, 64}}, color = {0, 0, 255}));
    connect(idealGTOThyristor.n, idealDiode.p) annotation(
      Line(points = {{-48, 44}, {-48, 38}, {-68, 38}, {-68, 44}}, color = {0, 0, 255}));
    connect(idealDiode.n, idealGTOThyristor.p) annotation(
      Line(points = {{-68, 64}, {-68, 72}, {-48, 72}, {-48, 64}}, color = {0, 0, 255}));
    connect(idealGTOThyristor.fire, pwmPulser.Top) annotation(
      Line(points = {{-37, 47}, {-29.5, 47}, {-29.5, 47}, {-22, 47}, {-22, 36.08}, {-10.65, 36.08}, {-10.65, 36.08}, {0.7, 36.08}}, color = {255, 0, 255}));
    connect(ground1.p, Cf.n) annotation(
      Line(points = {{-4, -38}, {4, -38}, {4, -38}, {12, -38}, {12, -30}, {21, -30}, {21, -30}, {30, -30}}, color = {0, 0, 255}));
    connect(V1.n, V2.p) annotation(
      Line(points = {{-84, 10}, {-84, -14}, {-84, -14}}, color = {0, 0, 255}));
    connect(ground.p, V1.n) annotation(
      Line(points = {{-74, 4}, {-74, 10}, {-79, 10}, {-79, 10}, {-84, 10}}, color = {0, 0, 255}));
    connect(Lf.p, Rf.n) annotation(
      Line(points = {{-6, 0}, {-22, 0}}, color = {0, 0, 255}));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})), experiment(StopTime = 0.06, Interval = 5e-005), Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori useali se in controllo resta senza blanking time.</p>
<p>Il sistema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"),
      __OpenModelica_commandLineOptions = "");
  end InvPwmPQ;

  model PwmPulser
    Modelica.Blocks.Interfaces.RealInput Ampl annotation(Placement(transformation(extent = {{-114, 44}, {-74, 84}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
    Modelica.Blocks.Interfaces.RealInput Ph_deg annotation(Placement(transformation(extent = {{-118, -74}, {-78, -34}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
    parameter Real Fcar = 1000 "Carrier Frequency";
    import PI = Modelica.Constants.pi;
  protected
    Modelica.Blocks.Sources.Trapezoid carrier(rising = 1 / (2 * Fcar), width = 0, falling = 1 / (2 * Fcar), period = 1 / Fcar, amplitude = 2, offset = -1) annotation(Placement(transformation(extent = {{14, -56}, {34, -36}})));
    Modelica.Blocks.Math.Sin sin annotation(Placement(transformation(extent = {{-20, -28}, {0, -8}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-50, 16}, {-32, 34}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * PI * Fmod) annotation(Placement(transformation(extent = {{-90, 14}, {-64, 36}})));
  public
    Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-54, -28}, {-34, -8}})));
    Modelica.Blocks.Math.Gain ToRAD(k = PI / 180) annotation(Placement(transformation(extent = {{-64, -60}, {-54, -50}})));
    Modelica.Blocks.Math.Product moduler annotation(Placement(transformation(extent = {{14, -22}, {32, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput Top annotation(Placement(transformation(extent = {{80, 6}, {100, 26}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
    Modelica.Blocks.Logical.Greater greater annotation(Placement(transformation(extent = {{46, -24}, {66, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput Bot annotation(Placement(transformation(extent = {{84, -62}, {104, -42}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
    Modelica.Blocks.Logical.Not not1 annotation(Placement(transformation(extent = {{60, -60}, {74, -46}})));
    parameter Real Fmod = 50 "Moduler Frequency";
  equation
    connect(ToRAD.u, Ph_deg) annotation(Line(points = {{-65, -55}, {-76, -55}, {-76, -54}, {-98, -54}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.u, add.y) annotation(Line(points = {{-22, -18}, {-33, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u2, sin.y) annotation(Line(points = {{12.2, -18.4}, {14, -18.4}, {14, -18}, {1, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u1, integrator.y) annotation(Line(points = {{-56, -12}, {-64, -12}, {-64, 2}, {-24, 2}, {-24, 25}, {-31.1, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u1, Ampl) annotation(Line(points = {{12.2, -7.6}, {12.2, 64}, {-94, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u2, ToRAD.y) annotation(Line(points = {{-56, -24}, {-64, -24}, {-64, -34}, {-46, -34}, {-46, -55}, {-53.5, -55}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u1, moduler.y) annotation(Line(points = {{44, -14}, {46.45, -14}, {46.45, -13}, {32.9, -13}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u2, carrier.y) annotation(Line(points = {{44, -22}, {44, -46}, {35, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(Top, greater.y) annotation(Line(points = {{90, 16}, {82, 16}, {82, 14}, {74, 14}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.y, Bot) annotation(Line(points = {{74.7, -53}, {84, -53}, {84, -52}, {94, -52}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.u, greater.y) annotation(Line(points = {{58.6, -53}, {52, -53}, {52, -32}, {74, -32}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(integrator.u, realExpression.y) annotation(Line(points = {{-51.8, 25}, {-62.7, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-100, 88}, {-42, 60}}, lineColor = {0, 0, 127}, textString = "A"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "Ph(?)"), Text(extent = {{28, 86}, {100, 60}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{42, -62}, {96, -88}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5)}));
  end PwmPulser;
  annotation(uses(Modelica(version = "3.2.1")));
end invPWMPkg;