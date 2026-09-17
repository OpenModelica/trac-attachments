package Test
  model RL_Q
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(
      Placement(visible = true, transformation(origin = {64, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(
      Placement(visible = true, transformation(origin = {64, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Test.QSensor qMeas(frequency = 50) annotation(
      Placement(visible = true, transformation(extent = {{-10, 18}, {10, 38}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(extent = {{-10, -62}, {10, -42}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(
      Placement(visible = true, transformation(origin = {-60, 4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  equation
    connect(qMeas.pv, qMeas.pc) annotation(
      Line(points = {{0, 38}, {-10, 38}, {-10, 28}}, color = {0, 0, 255}));
    connect(qMeas.nc, resistor1.p) annotation(
      Line(points = {{10, 28}, {64, 28}}, color = {0, 0, 255}));
    connect(resistor1.n, inductor.p) annotation(
      Line(points = {{64, 8}, {64, -2}}, color = {0, 0, 255}));
    connect(sineVoltage.n, inductor.n) annotation(
      Line(points = {{-60, -6}, {-60, -6}, {-60, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    connect(ground.p, inductor.n) annotation(
      Line(points = {{0, -42}, {0, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    connect(qMeas.nv, inductor.n) annotation(
      Line(points = {{0, 18}, {0, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    connect(sineVoltage.p, qMeas.pc) annotation(
      Line(points = {{-60, 14}, {-60, 28}, {-10, 28}}, color = {0, 0, 255}));
    annotation(
      experiment(StopTime = 0.1),
      experimentSetupOutput,
      Documentation(info = "<html>
   <p>Misura di potenza attiva e reattiva istantanea su carico RLC</p>
   </html>", revisions = "<html><head></head><body>Non va newInst (non va avg)</body></html>"),
      Diagram(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1)),
      Icon(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1)));
  end RL_Q;

  model QSensor "Sensor to measure the reactive power"
    Modelica.Electrical.Analog.Interfaces.PositivePin pc "Positive pin, current path" annotation(
      Placement(transformation(extent = {{-90, -10}, {-110, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nc "Negative pin, current path" annotation(
      Placement(transformation(extent = {{110, -10}, {90, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin pv "Positive pin, voltage path" annotation(
      Placement(transformation(extent = {{-10, 110}, {10, 90}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nv "Negative pin, voltage path" annotation(
      Placement(transformation(extent = {{10, -110}, {-10, -90}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
      Placement(transformation(extent = {{-74, -10}, {-54, 10}}, rotation = 0)));
    parameter Modelica.SIunits.Frequency frequency = 50.0 "Frequency of signals";
    Modelica.Blocks.Interfaces.RealOutput power annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 270), iconTransformation(origin = {-80, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
      Placement(visible = true, transformation(origin = {0, -52}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-58, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime = 1 / (4 * frequency)) annotation(
      Placement(visible = true, transformation(origin = {-30, -32}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  equation
    connect(voltageSensor.n, nv) annotation(
      Line(points = {{-4.44089e-016, -62}, {-4.44089e-016, -63}, {0, -63}, {0, -100}}, color = {0, 0, 255}));
    connect(pc, currentSensor.p) annotation(
      Line(points = {{-100, 0}, {-74, 0}}, color = {0, 0, 255}));
    connect(currentSensor.n, nc) annotation(
      Line(points = {{-54, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(product.y, power) annotation(
      Line(points = {{-58, -71}, {-58, -80}, {-80, -80}, {-80, -110}}, color = {0, 0, 127}));
    connect(pv, voltageSensor.p) annotation(
      Line(points = {{0, 100}, {6.66134e-016, 100}, {6.66134e-016, -42}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.v, fixedDelay.u) annotation(
      Line(points = {{11, -52}, {26, -52}, {26, -32}, {-18, -32}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(currentSensor.i, product.u1) annotation(
      Line(points = {{-64, -11}, {-64, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay.y, product.u2) annotation(
      Line(points = {{-41, -32}, {-52, -32}, {-52, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 255}, extent = {{150, 120}, {-150, 160}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}, endAngle = 360), Line(points = {{0, 70}, {0, 40}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}, endAngle = 360), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}, endAngle = 360), Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 255}), Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 255}), Line(points = {{-80, -100}, {-80, -80}, {-46, -52}}, color = {0, 0, 127}), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 255}), Line(points = {{0, 70}, {0, 40}}), Text(origin = {-38, 18}, extent = {{-29, -70}, {30, -11}}, textString = "Q"), Text(origin = {-32, 50}, extent = {{14, -66}, {104, -98}}, textString = "%frequency", lineColor = {0, 0, 0})}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
      Documentation(info = "<html>
  <p>This power sensor measures the &quot;instantaneous reactive power&quot; of a singlephase system.</p>
  <p>This power is defined as the product of current times voltage delayed by a quarter period. This definition is such that in case of sine waves its average equals to the standard definition of reactive power <i>Q</i>=<i>UI</i>cos<span style=\"font-family: Symbol;\">j</span>.</p>
  </html>", revisions = "<html>
   <ul>
   <li><i> January 12, 2006   </i>
          by Anton Haumer<br> implemented<br>
          </li>
   </ul>
   </html>"));
  end QSensor;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end Test;
