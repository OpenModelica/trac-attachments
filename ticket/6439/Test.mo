package Test
  model Discont2 "Discontinuous current: analysis"
    extends Modelica.Icons.Example;
    import Modelica.Electrical.Analog.Ideal;
    parameter Modelica.SIunits.Current iStart = 1000 "Initial current: flows in load and source";
    //Note that setting an initial current, if we do not want wrong initial voltage, must be combined with initial SCR state.
    parameter Modelica.SIunits.Frequency f = 50 "line frequency";
    parameter Modelica.SIunits.Resistance Ron = 0.00001 "Thyristor forward resistance";
    parameter Modelica.SIunits.Conductance Goff = 0.00001 "Thyristor backward conductance";
    parameter Modelica.SIunits.Voltage Vknee = 0.8 "Thyristor threshold voltage";
    parameter Modelica.SIunits.Capacitance CDC = 1.5e-05 "DC capacitance";
    parameter Modelica.SIunits.Current IDC = 500 "load current";
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(freqHz = 50, V = 400e3 * sqrt(2 / 3)) annotation(
      Placement(visible = true, transformation(extent = {{-90, 32}, {-110, 52}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage2(freqHz = f, phase = -2 / 3 * Modelica.Constants.pi, V = sineVoltage1.V) annotation(
      Placement(visible = true, transformation(extent = {{-90, 12}, {-110, 32}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage3(freqHz = f, phase = -4 / 3 * Modelica.Constants.pi, V = sineVoltage1.V) annotation(
      Placement(visible = true, transformation(extent = {{-90, -8}, {-110, 12}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor L2(i(start = -iStart), L = L1.L) annotation(
      Placement(visible = true, transformation(extent = {{-48, 12}, {-28, 32}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground Ground1 annotation(
      Placement(visible = true, transformation(extent = {{94, -12}, {114, 8}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor L1(L = 0.25) annotation(
      Placement(visible = true, transformation(origin = {-38.1378, 41.6276}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor L3(i(start = iStart), L = L1.L) annotation(
      Placement(visible = true, transformation(origin = {-37.0613, 2.1246}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.PotentialSensor uDC_ annotation(
      Placement(visible = true, transformation(extent = {{58, 60}, {78, 80}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor i1 annotation(
      Placement(visible = true, transformation(extent = {{-82, 52}, {-62, 32}}, rotation = 0)));
    Modelica.Blocks.Math.RootMeanSquare I1rmsM(f = 50) annotation(
      Placement(visible = true, transformation(origin = {-72, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Mean mean(f = 100) annotation(
      Placement(visible = true, transformation(origin = {100, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2mPulse p(useConstantFiringAngle = false, useFilter = false) annotation(
      Placement(visible = true, transformation(origin = {6, -36}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p toPin1(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p toPin2(k = 2) annotation(
      Placement(visible = true, transformation(origin = {-70, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p toPin3(k = 3) annotation(
      Placement(visible = true, transformation(origin = {-52, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Bridge bridge(iniOff = {false, false, false, false, true, true}, Vknee = 0.1) annotation(
      Placement(visible = true, transformation(origin = {6, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage outFem(V = 5e3) annotation(
      Placement(visible = true, transformation(origin = {104, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 10) annotation(
      Placement(visible = true, transformation(extent = {{64, 24}, {84, 44}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor Ldc(L = 0.5, i(start = iStart)) annotation(
      Placement(visible = true, transformation(extent = {{38, 24}, {58, 44}}, rotation = 0)));
    Modelica.Blocks.Math.UnitConversions.From_deg from_deg annotation(
      Placement(transformation(extent = {{-38, -68}, {-18, -48}})));
    Modelica.Blocks.Sources.Constant const(k = 95) annotation(
      Placement(transformation(extent = {{-82, -68}, {-62, -48}})));
  equation
    connect(L3.p, sineVoltage3.p) annotation(
      Line(points = {{-47, 2}, {-90, 2}}));
    connect(sineVoltage1.n, sineVoltage2.n) annotation(
      Line(points = {{-110, 42}, {-110, 22}}, color = {0, 0, 255}));
    connect(sineVoltage2.n, sineVoltage3.n) annotation(
      Line(points = {{-110, 22}, {-110, 2}}, color = {0, 0, 255}));
    connect(sineVoltage2.p, L2.p) annotation(
      Line(points = {{-90, 22}, {-48, 22}}, color = {0, 0, 255}));
    connect(sineVoltage1.p, i1.p) annotation(
      Line(points = {{-90, 42}, {-82, 42}}, color = {0, 0, 255}));
    connect(L1.p, i1.n) annotation(
      Line(points = {{-48, 42}, {-62, 42}}, color = {0, 0, 255}));
    connect(I1rmsM.u, i1.i) annotation(
      Line(points = {{-72, 56}, {-72, 53}}, color = {0, 0, 127}));
    connect(mean.u, uDC_.phi) annotation(
      Line(points = {{88, 70}, {79, 70}}, color = {0, 0, 127}));
    connect(p.ac, toPin3.plug_p) annotation(
      Line(points = {{-4, -36}, {-52, -36}, {-52, -26}}, color = {0, 0, 255}));
    connect(p.ac, toPin2.plug_p) annotation(
      Line(points = {{-4, -36}, {-70, -36}, {-70, -26}}, color = {0, 0, 255}));
    connect(p.ac, toPin1.plug_p) annotation(
      Line(points = {{-4, -36}, {-90, -36}, {-90, -26}}, color = {0, 0, 255}));
    connect(toPin2.pin_p, L2.p) annotation(
      Line(points = {{-70, -22}, {-70, 22}, {-48, 22}}, color = {0, 0, 255}));
    connect(toPin1.pin_p, i1.p) annotation(
      Line(points = {{-90, -22}, {-90, -10}, {-82, -10}, {-82, 42}}, color = {0, 0, 255}));
    connect(toPin3.pin_p, sineVoltage3.p) annotation(
      Line(points = {{-52, -22}, {-52, -9.9377}, {-60, -9.9377}, {-60, 2.1246}, {-65.6462, 2.1246}, {-65.6462, 2}, {-90, 2}}, color = {0, 0, 255}));
    connect(bridge.pin1, L1.n) annotation(
      Line(points = {{-5, 26}, {-13.6, 26}, {-13.6, 42}, {-28, 42}}, color = {0, 0, 255}));
    connect(bridge.pin3, L3.n) annotation(
      Line(points = {{-5, 18}, {-13.6, 18}, {-13.6, 2}, {-27, 2}}, color = {0, 0, 255}));
    connect(bridge.pin2, L2.n) annotation(
      Line(points = {{-5, 22}, {-28, 22}}, color = {0, 0, 255}));
    connect(bridge.pin_p, uDC_.p) annotation(
      Line(points = {{16, 28}, {30, 28}, {30, 70}, {58, 70}}, color = {0, 0, 255}));
    connect(bridge.k, p.fire_p) annotation(
      Line(points = {{-0.2, 10}, {-0.2, -9}, {4.76837e-08, -9}, {4.76837e-08, -25}}, color = {255, 0, 255}));
    connect(bridge.a, p.fire_n) annotation(
      Line(points = {{12, 10}, {12, -25}}, color = {255, 0, 255}));
    connect(outFem.n, Ground1.p) annotation(
      Line(points = {{104, 16}, {104, 8}}, color = {0, 0, 255}));
    connect(outFem.n, bridge.pin_n) annotation(
      Line(points = {{104, 16}, {16, 16}}, color = {0, 0, 255}));
    connect(Ldc.n, resistor.p) annotation(
      Line(points = {{58, 34}, {64, 34}}, color = {0, 0, 255}));
    connect(resistor.n, outFem.p) annotation(
      Line(points = {{84, 34}, {94, 34}, {94, 36}, {104, 36}}, color = {0, 0, 255}));
    connect(Ldc.p, uDC_.p) annotation(
      Line(points = {{38, 34}, {30, 34}, {30, 70}, {58, 70}}, color = {0, 0, 255}));
    connect(from_deg.y, p.firingAngle) annotation(
      Line(points = {{-17, -58}, {0, -58}, {0, -62}, {6, -62}, {6, -48}}, color = {0, 0, 127}));
    connect(from_deg.u, const.y) annotation(
      Line(points = {{-40, -58}, {-61, -58}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -80}, {120, 100}}), graphics = {Text(lineColor = {28, 108, 200}, extent = {{-42, 90}, {10, 80}}, textString = "PER FIGURA ARTICOLO
  parametri simili a quelli di Grita
  (arrotondati)")}),
      experiment(StopTime = 0.01, Interval = 4e-06, Tolerance = 1e-06, StartTime = 0),
      Documentation(info = "<html>
  <p>Questo modello consente di valutare la conduzione discontinua.</p>
  <p>Dalla teoria la conduzione con 400 kV AC e 30 kV DC diviene discontinua a partire da 87 gradi</p>
  </html>", revisions = "<html>
    <p><b>Release Notes:</b></p>
    <ul>
    <li><i>Mai 7, 2004   </i>
           by Anton Haumer<br> realized<br>
           </li>
    </ul>
    </html>"),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false)));
  end Discont2;
  
  model Bridge "Thyristor bridge con mean e rms"
    import Modelica.Electrical.Analog.Ideal;
    parameter Integer n = 1 "Number of thyristors in series per valve";
    parameter Boolean iniOff[6] = fill(true, 6);
    parameter Modelica.SIunits.Resistance Ron = 1e-5 "Thyristor forward resistance";
    parameter Modelica.SIunits.Conductance Goff = 1e-5 "Thyristor backward conductance";
    parameter Modelica.SIunits.Voltage Vknee = 0.8 "Thyristor threshold voltage";
    Real Vrs = pin1.v - pin2.v;
    Real Vrt = pin1.v - pin3.v;
    Real Vst = pin2.v - pin3.v;
    Real Vsr = pin2.v - pin1.v;
    Real Vtr = pin3.v - pin1.v;
    Real Vts = pin3.v - pin2.v;
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor1(Ron = n * Ron, Goff = Goff / n, Vknee = n * Vknee, off(start = iniOff[1], fixed = true)) annotation(
      Placement(visible = true, transformation(origin = {-14, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor3(Ron = n * Ron, Goff = Goff / n, Vknee = n * Vknee, off(fixed = true, start = iniOff[3])) annotation(
      Placement(visible = true, transformation(origin = {8, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor5(Ron = n * Ron, Goff = Goff / n, Vknee = n * Vknee, off(start = iniOff[5])) annotation(
      Placement(visible = true, transformation(origin = {26, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor4(Ron = n * Ron, Goff = Goff / n, Vknee = n * Vknee, off(start = iniOff[4], fixed = true)) annotation(
      Placement(visible = true, transformation(origin = {-14, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor6(Ron = n * Ron, Goff = n * Goff, Vknee = n * Vknee, off(start = iniOff[6], fixed = true)) annotation(
      Placement(visible = true, transformation(origin = {8, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Ideal.IdealThyristor Thyristor2(Ron = n * Ron, Goff = Goff / n, Vknee = n * Vknee, off(fixed = true, start = iniOff[2])) annotation(
      Placement(visible = true, transformation(origin = {26, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(
      Placement(visible = true, transformation(origin = {120, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
      Placement(visible = true, transformation(origin = {120, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.Pin pin1 annotation(
      Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-106, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.Pin pin2 annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-106, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.Pin pin3 annotation(
      Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-106, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanInput k[3] "cathode-related firing signals" annotation(
      Placement(visible = true, transformation(origin = {-60, -98}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-62, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Blocks.Sources.BooleanExpression f1(y = k[1]) annotation(
      Placement(visible = true, transformation(extent = {{-64, 44}, {-46, 64}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression f5(y = k[3]) annotation(
      Placement(visible = true, transformation(extent = {{-64, 72}, {-46, 92}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression f3(y = k[2]) annotation(
      Placement(visible = true, transformation(extent = {{-64, 58}, {-46, 78}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression f2(y = a[3]) annotation(
      Placement(visible = true, transformation(extent = {{-56, -14}, {-40, 6}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression f6(y = a[2]) annotation(
      Placement(visible = true, transformation(extent = {{-56, -30}, {-40, -10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanExpression f4(y = a[1]) annotation(
      Placement(visible = true, transformation(origin = {-47, -36}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanInput a[3] "anode-related firing signals" annotation(
      Placement(visible = true, transformation(origin = {60, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor uSens annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {80, 14})));
  equation
    connect(Thyristor5.p, Thyristor2.n) annotation(
      Line(points = {{26, 32}, {26, -36}}, color = {0, 0, 255}));
    connect(Thyristor1.n, Thyristor3.n) annotation(
      Line(points = {{-14, 52}, {-14, 62}, {8, 62}, {8, 52}}, color = {0, 0, 255}));
    connect(Thyristor3.n, Thyristor5.n) annotation(
      Line(points = {{8, 52}, {8, 62}, {26, 62}, {26, 52}}, color = {0, 0, 255}));
    connect(Thyristor4.p, Thyristor6.p) annotation(
      Line(points = {{-14, -56}, {8, -56}}, color = {0, 0, 255}));
    connect(Thyristor6.p, Thyristor2.p) annotation(
      Line(points = {{8, -56}, {26, -56}}, color = {0, 0, 255}));
    connect(Thyristor3.p, Thyristor6.n) annotation(
      Line(points = {{8, 32}, {8, -36}}, color = {0, 0, 255}));
    connect(Thyristor1.p, Thyristor4.n) annotation(
      Line(points = {{-14, 32}, {-14, -36}}, color = {0, 0, 255}));
    connect(pin1, Thyristor1.p) annotation(
      Line(points = {{-120, 40}, {-84, 40}, {-84, 32}, {-14, 32}}, color = {0, 0, 255}));
    connect(pin2, Thyristor3.p) annotation(
      Line(points = {{-120, 0}, {-84, 0}, {-84, 28}, {8, 28}, {8, 32}}, color = {0, 0, 255}));
    connect(pin3, Thyristor5.p) annotation(
      Line(points = {{-120, -40}, {-78, -40}, {-78, 22}, {26, 22}, {26, 32}}, color = {0, 0, 255}));
    connect(f1.y, Thyristor1.fire) annotation(
      Line(points = {{-45.1, 54}, {-26, 54}, {-26, 52}}, color = {255, 0, 255}));
    connect(f3.y, Thyristor3.fire) annotation(
      Line(points = {{-45.1, 68}, {-4, 68}, {-4, 52}}, color = {255, 0, 255}));
    connect(f5.y, Thyristor5.fire) annotation(
      Line(points = {{-45.1, 82}, {14, 82}, {14, 52}}, color = {255, 0, 255}));
    connect(Thyristor4.fire, f4.y) annotation(
      Line(points = {{-26, -36}, {-37.1, -36}}, color = {255, 0, 255}));
    connect(f6.y, Thyristor6.fire) annotation(
      Line(points = {{-39.2, -20}, {-4, -20}, {-4, -36}}, color = {255, 0, 255}));
    connect(f2.y, Thyristor2.fire) annotation(
      Line(points = {{-39.2, -4}, {14, -4}, {14, -36}}, color = {255, 0, 255}));
    connect(pin_p, Thyristor5.n) annotation(
      Line(points = {{120, 60}, {26, 60}, {26, 52}}, color = {0, 0, 255}));
    connect(pin_n, Thyristor2.p) annotation(
      Line(points = {{120, -44}, {62, -44}, {62, -56}, {26, -56}}, color = {0, 0, 255}));
    connect(uSens.p, Thyristor5.n) annotation(
      Line(points = {{80, 24}, {80, 60}, {26, 60}, {26, 52}}, color = {0, 0, 255}));
    connect(uSens.n, Thyristor2.p) annotation(
      Line(points = {{80, 4}, {80, -44}, {62, -44}, {62, -56}, {26, -56}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -80}, {120, 100}})),
      experiment(StopTime = 0.6, StartTime = 0, Tolerance = 1e-06, Interval = 2.4e-05),
      Documentation(info = "<html>
  <p>Questo ponte &egrave; simile a quello della MSL, ma &egrave; stato necessario introdurlo perch&eacute; con quello simulazioni con induttanza di commutazione diversa da 0 non andavano.</p>
  <p>Per default gli SCR partono tutti spenti. Dall&apos;esterno se ne possono forzare alcuni accesi, ad es. quando si vuole dare come condizione iniziale un valore di corrente nell&apos;induttanza di uscita diverso da 0, per ridurre la lunghezza dei transitori.</p>
  </html>", revisions = "<html>
      <p><b>Release Notes:</b></p>
      <ul>
      <li><i>Mai 7, 2004   </i>
           by Anton Haumer<br> realized<br>
           </li>
      </ul>
      </html>"),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false), graphics = {Rectangle(origin = {0.26, -0.16}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100.26, 100.16}, {100.26, -100.16}}), Polygon(origin = {-2, 0}, points = {{0, 34}, {-36, -34}, {36, -34}, {0, 34}}), Line(origin = {-1.31196, 33.4986}, points = {{-41, 0}, {41, 0}, {41, 0}}), Line(origin = {26.5, 2}, points = {{-12.5, 0}, {13.5, 0}, {11.5, 0}}), Text(extent = {{-98, 138}, {100, 120}}, lineColor = {0, 0, 255}, textString = "%name"), Line(points = {{-2, 62}, {-2, -66}}, color = {0, 0, 0})}));
  end Bridge;
end Test;
