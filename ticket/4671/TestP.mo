package TestP
  import Modelica;

  model IdOnePwm "Switches ideali, una gamba pwm"
    Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation(
      Placement(visible = true, transformation(origin = {32, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant phase(k = 0) annotation(
      Placement(visible = true, transformation(origin = {58, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    TestP.PwmPulser pwmPulser annotation(
      Placement(visible = true, transformation(origin = {-15, 42}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation(
      Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation(
      Placement(visible = true, transformation(origin = {-52, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(
      Placement(visible = true, transformation(origin = {-84, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation(
      Placement(visible = true, transformation(origin = {-2, -4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(
      Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {-2, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pwmPulser.up, SWd.control) annotation(
      Line(points = {{-29, 51}, {-36, 51}, {-36, -36}, {-43, -36}}, color = {255, 0, 255}));
    connect(ampl.y, pwmPulser.ampl) annotation(
      Line(points = {{21, 60}, {12, 60}, {12, 50}, {1, 50}}, color = {0, 0, 127}));
    connect(phase.y, pwmPulser.ph_deg) annotation(
      Line(points = {{47, 40}, {16, 40}, {16, 35}, {1, 35}}, color = {0, 0, 127}));
    connect(pwmPulser.down, SWu.control) annotation(
      Line(points = {{-29, 34}, {-40, 34}, {-40, 42}, {-45, 42}}, color = {255, 0, 255}));
    connect(Load.p, SWu.n) annotation(
      Line(points = {{-2, 6}, {-52, 6}, {-52, 30}, {-52, 30}, {-52, 30}}, color = {0, 0, 255}));
    connect(Load.n, ground1.p) annotation(
      Line(points = {{-2, -14}, {-2, -14}, {-2, -22}, {-2, -22}}, color = {0, 0, 255}));
    connect(SWu.n, SWd.p) annotation(
      Line(points = {{-52, 32}, {-52, -26}, {-50, -26}}, color = {0, 0, 255}));
    connect(SWu.p, V1.p) annotation(
      Line(points = {{-52, 52}, {-52, 60}, {-84, 60}, {-84, 30}}, color = {0, 0, 255}));
    connect(ground.p, V1.n) annotation(
      Line(points = {{-70, 4}, {-70, 10}, {-84, 10}}, color = {0, 0, 255}));
    connect(V1.n, V2.p) annotation(
      Line(points = {{-84, 10}, {-84, -14}, {-84, -14}}, color = {0, 0, 255}));
    connect(SWd.n, V2.n) annotation(
      Line(points = {{-50, -46}, {-50, -56}, {-84, -56}, {-84, -34}}, color = {0, 0, 255}));
    annotation(
      experiment(StopTime = 0.1),
      experimentSetupOutput,
      Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
      Diagram(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false)),
      Icon(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false)));
  end IdOnePwm;

  model PwmPulser
    Modelica.Blocks.Interfaces.RealInput ampl annotation(
      Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
    Modelica.Blocks.Interfaces.RealInput ph_deg annotation(
      Placement(transformation(extent = {{-138, -76}, {-98, -36}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
    parameter Modelica.SIunits.Frequency fCar = 1000 "Carrier Frequency";
    import PI = Modelica.Constants.pi;
  protected
    Modelica.Blocks.Sources.Trapezoid carrier(rising = 1 / (2 * fCar), width = 0, falling = 1 / (2 * fCar), period = 1 / fCar, amplitude = 2, offset = -1) annotation(
      Placement(transformation(extent = {{14, -56}, {34, -36}})));
    Modelica.Blocks.Math.Sin sin annotation(
      Placement(transformation(extent = {{-20, -28}, {0, -8}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(transformation(extent = {{-50, 16}, {-32, 34}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * PI * fMod) annotation(
      Placement(transformation(extent = {{-90, 14}, {-64, 36}})));
  public
    Modelica.Blocks.Math.Add add annotation(
      Placement(transformation(extent = {{-54, -28}, {-34, -8}})));
    Modelica.Blocks.Math.Gain ToRAD(k = PI / 180) annotation(
      Placement(transformation(extent = {{-66, -62}, {-54, -50}})));
    Modelica.Blocks.Math.Product moduler annotation(
      Placement(transformation(extent = {{14, -22}, {32, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput up annotation(
      Placement(transformation(extent = {{100, 10}, {120, 30}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
    Modelica.Blocks.Logical.Greater greater annotation(
      Placement(transformation(extent = {{46, -24}, {66, -4}})));
    Modelica.Blocks.Interfaces.BooleanOutput down annotation(
      Placement(transformation(extent = {{100, -62}, {120, -42}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
    Modelica.Blocks.Logical.Not not1 annotation(
      Placement(transformation(extent = {{60, -60}, {80, -40}})));
    parameter Modelica.SIunits.Frequency fMod = 50 "Modulating wave Frequency";
  equation
    connect(ToRAD.u, ph_deg) annotation(
      Line(points = {{-67.2, -56}, {-118, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(sin.u, add.y) annotation(
      Line(points = {{-22, -18}, {-33, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u2, sin.y) annotation(
      Line(points = {{12.2, -18.4}, {14, -18.4}, {14, -18}, {1, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u1, integrator.y) annotation(
      Line(points = {{-56, -12}, {-64, -12}, {-64, 2}, {-24, 2}, {-24, 25}, {-31.1, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(moduler.u1, ampl) annotation(
      Line(points = {{12.2, -7.6}, {12.2, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u2, ToRAD.y) annotation(
      Line(points = {{-56, -24}, {-64, -24}, {-64, -34}, {-46, -34}, {-46, -56}, {-53.4, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u1, moduler.y) annotation(
      Line(points = {{44, -14}, {46.45, -14}, {46.45, -13}, {32.9, -13}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(greater.u2, carrier.y) annotation(
      Line(points = {{44, -22}, {44, -46}, {35, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(up, greater.y) annotation(
      Line(points = {{110, 20}, {74, 20}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.y, down) annotation(
      Line(points = {{81, -50}, {84, -50}, {84, -52}, {110, -52}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(not1.u, greater.y) annotation(
      Line(points = {{58, -50}, {52, -50}, {52, -32}, {74, -32}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
    connect(integrator.u, realExpression.y) annotation(
      Line(points = {{-51.8, 25}, {-62.7, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-98, 88}, {-40, 60}}, lineColor = {0, 0, 127}, textString = "ampl"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "ph(?)"), Text(extent = {{28, 86}, {100, 60}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{42, -62}, {96, -88}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5), Text(extent = {{-100, 140}, {100, 110}}, lineColor = {0, 0, 255}, textString = "%name")}));
  end PwmPulser;
  annotation(
    uses(Modelica(version = "3.2.2")),
    Documentation(info = "<html>
<p>Dati di riferimento per i vari inverter:</p>
<p>Tensione DC complessiva 100 V</p>
<p>Nel caso di alimentazione di caricopassivo: resistenza di carico 1 ohm, induttanza 5mH</p>
<p>Resistenza del filtro 0.05 ohm</p>
<p>Con questi dati, nel caso di m=0.7 ho una potenza di circa 550 W monofase, 1650 W trifase. Infatti il valore di picco della tensione &egrave; 0.7*50=35V, quindi P1=35^2/2=612W che a valle delle perdite divengono circa 600.</p>
</html>"));
end TestP;