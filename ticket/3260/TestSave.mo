within ;
encapsulated package TestSave
  import Modelica;

  model RLC
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-42, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(Placement(visible = true, transformation(extent = {{-10, 30}, {10, 50}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 10e-6) annotation(Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.01) annotation(Placement(visible = true, transformation(origin = {50, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-72, -46}, {-52, -26}}, rotation = 0)));
  equation
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-62, -26}, {-62, -8}, {-42, -8}}, color = {0, 0, 255}));
    connect(inductor.n, capacitor.p) annotation(Line(points = {{50, -2}, {50, -20}}, color = {0, 0, 255}));
    connect(inductor.p, resistor.n) annotation(Line(points = {{50, 18}, {50, 40}, {10, 40}}, color = {0, 0, 255}));
    connect(sineVoltage.n, capacitor.n) annotation(Line(points = {{-42, -8}, {-42, -40}, {50, -40}}, color = {0, 0, 255}));
    connect(resistor.p, sineVoltage.p) annotation(Line(points = {{-10, 40}, {-42, 40}, {-42, 12}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end RLC;

  model RLC_PQ
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-52, 4})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-82, -40}, {-62, -20}})));
    Modelica.Electrical.Analog.Sensors.PowerSensor pMeas annotation(Placement(transformation(extent = {{-32, 30}, {-12, 50}})));
    QMonoSensor qMeas annotation(Placement(transformation(extent = {{10, 30}, {30, 50}})));
    Avg avg annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-70, 30})));
    Modelica.Blocks.Math.Mean mean(f = 50) annotation(Placement(transformation(extent = {{-60, 60}, {-80, 80}})));
    Avg avgQ annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 76})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(Placement(visible = true, transformation(origin = {50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 10e-6) annotation(Placement(visible = true, transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  equation
    connect(capacitor.n, sineVoltage.n) annotation(Line(points = {{50, -60}, {50, -58}, {-52, -58}, {-52, -6}}, color = {0, 0, 255}));
    connect(inductor.n, capacitor.p) annotation(Line(points = {{50, -30}, {50, -40}}, color = {0, 0, 255}));
    connect(qMeas.nc, resistor1.p) annotation(Line(points = {{30, 40}, {54, 40}, {50, 40}}, color = {0, 0, 255}));
    connect(resistor1.n, inductor.p) annotation(Line(points = {{50, 20}, {50, -10}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-72, -20}, {-72, -6}, {-52, -6}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pMeas.pv, pMeas.pc) annotation(Line(points = {{-22, 50}, {-32, 50}, {-32, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pMeas.pc, sineVoltage.p) annotation(Line(points = {{-32, 40}, {-52, 40}, {-52, 14}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(pMeas.nv, sineVoltage.n) annotation(Line(points = {{-22, 30}, {-22, -6}, {-52, -6}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMeas.pc, pMeas.nc) annotation(Line(points = {{10, 40}, {-12, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMeas.nv, sineVoltage.n) annotation(Line(points = {{20, 30}, {20, -6}, {-52, -6}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMeas.pv, qMeas.pc) annotation(Line(points = {{20, 50}, {10, 50}, {10, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(avg.u, pMeas.power) annotation(Line(points = {{-58, 30}, {-44, 30}, {-44, 29}, {-30, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(mean.u, pMeas.power) annotation(Line(points = {{-58, 70}, {-38, 70}, {-38, 29}, {-30, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(avgQ.u, qMeas.power) annotation(Line(points = {{-6.66134e-016, 64}, {-6.66134e-016, 24}, {12, 24}, {12, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Documentation(info = "<html>
 <p>Misura di potenza attiva e reattiva istantanea su carico RLC</p>
 </html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {1, 1})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {1, 1})));
  end RLC_PQ;

  model RLC_PQ2 "pq istantanee e medie"
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-52, 2})));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 2e-3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {54, -16})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-82, -42}, {-62, -22}})));
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 10) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {54, 16})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 50e-6) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {54, -48})));
    QMonoSensor qMonoSensor annotation(Placement(transformation(extent = {{18, 30}, {38, 50}})));
    Avg Pav annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-22, 10})));
    Avg Qav annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {12, 10})));
  equation
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-72, -22}, {-72, -8}, {-52, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(powerSensor.pv, powerSensor.pc) annotation(Line(points = {{-10, 50}, {-20, 50}, {-20, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(resistor1.n, inductor.p) annotation(Line(points = {{54, 6}, {54, -6}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(powerSensor.pc, sineVoltage.p) annotation(Line(points = {{-20, 40}, {-52, 40}, {-52, 12}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(powerSensor.nv, sineVoltage.n) annotation(Line(points = {{-10, 30}, {-10, -8}, {-52, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(inductor.n, capacitor.p) annotation(Line(points = {{54, -26}, {54, -38}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(capacitor.n, sineVoltage.n) annotation(Line(points = {{54, -58}, {54, -60}, {-52, -60}, {-52, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMonoSensor.pc, powerSensor.nc) annotation(Line(points = {{18, 40}, {0, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMonoSensor.nc, resistor1.p) annotation(Line(points = {{38, 40}, {54, 40}, {54, 26}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMonoSensor.nv, sineVoltage.n) annotation(Line(points = {{28, 30}, {28, -8}, {-52, -8}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(qMonoSensor.pv, qMonoSensor.pc) annotation(Line(points = {{28, 50}, {28, 50}, {18, 50}, {18, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Pav.u, powerSensor.power) annotation(Line(points = {{-22, 22}, {-22, 23.9}, {-18, 23.9}, {-18, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(Qav.u, qMonoSensor.power) annotation(Line(points = {{12, 22}, {12, 24.9}, {20, 24.9}, {20, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 0.1), experimentSetupOutput, Documentation(info = "<html>
 <p>Misura di potenza attiva e reattiva istantanea e media su carico RLC</p>
 </html>"));
  end RLC_PQ2;

  model RLD
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(Placement(visible = true, transformation(origin = {-30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 1e-3, i(fixed = true)) annotation(Placement(visible = true, transformation(origin = {30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-60, -40}, {-40, -20}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rload(R = 1) annotation(Placement(visible = true, transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(Placement(visible = true, transformation(extent = {{-10, 24}, {10, 44}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rload1(R = 1e5) annotation(Placement(visible = true, transformation(origin = {58, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  equation
    connect(Rload1.n, inductor.n) annotation(Line(points = {{58, 2}, {30, 2}}, color = {0, 0, 255}));
    connect(Rload1.p, inductor.p) annotation(Line(points = {{58, 22}, {30, 22}}, color = {0, 0, 255}));
    connect(idealDiode.p, sineVoltage.p) annotation(Line(points = {{-10, 34}, {-20, 34}, {-20, 34}, {-30, 34}, {-30, 23}, {-30, 23}, {-30, 14}}, color = {0, 0, 255}));
    connect(idealDiode.n, inductor.p) annotation(Line(points = {{10, 34}, {20, 34}, {20, 34}, {30, 34}, {30, 27}, {30, 27}, {30, 22}}, color = {0, 0, 255}));
    connect(Rload.n, sineVoltage.n) annotation(Line(points = {{30, -30}, {30, -35}, {30, -35}, {30, -38}, {-30, -38}, {-30, -23}, {-30, -23}, {-30, -6}}, color = {0, 0, 255}));
    connect(Rload.p, inductor.n) annotation(Line(points = {{30, -10}, {30, -6}, {30, -6}, {30, -2}, {30, 2}, {30, 2}, {30, 2}, {30, 2}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-50, -20}, {-50, -6}, {-30, -6}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.06), __Dymola_experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end RLD;

  block Avg "Sensor to measure the average value of input"

    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
    Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(transformation(extent = {{12, -10}, {32, 10}})));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(delayTime = 1 / frequency) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-14, -30})));
    Modelica.Blocks.Math.Gain gain(k = frequency) annotation(Placement(transformation(extent = {{52, -10}, {72, 10}})));
    parameter Real frequency = 50 "Frequency of the signals to be averaged";
  equation
    connect(integrator.u, u) annotation(Line(points = {{-62, 0}, {-120, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(add.u1, integrator.y) annotation(Line(points = {{10, 6}, {-14, 6}, {-14, 0}, {-39, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay1.y, add.u2) annotation(Line(points = {{-3, -30}, {4, -30}, {4, -6}, {10, -6}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay1.u, integrator.y) annotation(Line(points = {{-26, -30}, {-28, -30}, {-28, 0}, {-39, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.u, add.y) annotation(Line(points = {{50, 0}, {46, 0}, {46, 0}, {42, 0}, {42, 0}, {33, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.y, y) annotation(Line(points = {{73, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Text(extent = {{150, 66}, {-150, 106}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 50}, {100, -50}}, lineColor = {0, 0, 127}), Text(extent = {{-100, 32}, {100, -30}}, lineColor = {0, 0, 127}, textString = "AVG")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics), Documentation(info = "<html><p>
 This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
 </p>
 </html>", revisions = "<html>
 <ul>
 <li><i> January 12, 2006   </i>
        by Anton Haumer<br> implemented<br>
        </li>
 </ul>
 </html>"));
  end Avg;

  model QMonoSensor "Sensor to measure the reactive power"
    Modelica.Electrical.Analog.Interfaces.PositivePin pc
      "Positive pin, current path"                                                    annotation(Placement(transformation(extent = {{-90, -10}, {-110, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nc
      "Negative pin, current path"                                                    annotation(Placement(transformation(extent = {{110, -10}, {90, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin pv
      "Positive pin, voltage path"                                                    annotation(Placement(transformation(extent = {{-10, 110}, {10, 90}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nv
      "Negative pin, voltage path"                                                    annotation(Placement(transformation(extent = {{10, -110}, {-10, -90}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent = {{-74, -10}, {-54, 10}}, rotation = 0)));
    parameter Modelica.SIunits.Frequency Freq = 50.0 "Frequency of signals";
    Modelica.Blocks.Interfaces.RealOutput power annotation(Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 270), iconTransformation(origin = {-80, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(visible = true, transformation(origin = {0, -52}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Product product annotation(Placement(visible = true, transformation(origin = {-58, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime = 1 / (4 * Freq)) annotation(Placement(visible = true, transformation(origin = {-30, -32}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  equation
    connect(voltageSensor.n, nv) annotation(Line(points = {{-4.44089e-016, -62}, {-4.44089e-016, -63}, {0, -63}, {0, -100}}, color = {0, 0, 255}));
    connect(pc, currentSensor.p) annotation(Line(points = {{-100, 0}, {-74, 0}}, color = {0, 0, 255}));
    connect(currentSensor.n, nc) annotation(Line(points = {{-54, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(product.y, power) annotation(Line(points = {{-58, -71}, {-58, -80}, {-80, -80}, {-80, -110}}, color = {0, 0, 127}));
    connect(pv, voltageSensor.p) annotation(Line(points = {{0, 100}, {6.66134e-016, 100}, {6.66134e-016, -42}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(voltageSensor.v, fixedDelay.u) annotation(Line(points = {{10, -52}, {26, -52}, {26, -32}, {-18, -32}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(currentSensor.i, product.u1) annotation(Line(points = {{-64, -10}, {-64, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fixedDelay.y, product.u2) annotation(Line(points = {{-41, -32}, {-52, -32}, {-52, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 255}), Line(points = {{-80, -100}, {-80, 0}}, color = {0, 0, 255}), Text(extent = {{150, 120}, {-150, 160}}, textString = "%name", lineColor = {0, 0, 255}), Ellipse(fillColor = {245, 245, 245},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-70, -68}, {70, 72}}), Line(points = {{0, 72}, {0, 42}}), Line(points = {{22.9, 34.8}, {40.2, 59.3}}), Line(points = {{-22.9, 34.8}, {-40.2, 59.3}}), Line(points = {{37.6, 15.7}, {65.8, 25.9}}), Line(points = {{-37.6, 15.7}, {-65.8, 25.9}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -10}, {12, 14}}), Polygon(origin = {0, 2}, rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None,
              fillPattern =                                                                                                    FillPattern.Solid, points = {{-5.0, 0.0}, {-2.0, 60.0}, {0.0, 65.0}, {2.0, 60.0}, {5.0, 0.0}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None,
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-7, -5}, {7, 9}}), Line(points = {{0, 102}, {0, 72}}, color = {0, 0, 255}), Line(points = {{0, 72}, {0, 42}}), Text(extent = {{-29, -9}, {30, -68}}, lineColor = {0, 0, 0}, textString = "Q"), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 255})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics), Documentation(info = "<html><p>
   This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
 </p>
 </html>", revisions = "<html>
 <ul>
 <li><i> January 12, 2006   </i>
        by Anton Haumer<br> implemented<br>
        </li>
 </ul>
 </html>"));
  end QMonoSensor;

  model RLD_avg
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-72, 30})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-102, -14}, {-82, 6}})));
    Modelica.Electrical.Analog.Basic.Resistor Rload(R = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-12, 6})));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(Placement(transformation(extent = {{-52, 50}, {-32, 70}})));
    Modelica.Blocks.Math.Mean mean(f = 50) annotation(Placement(transformation(extent = {{60, 20}, {80, 40}})));
    Avg avg1 annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
    Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor annotation(Placement(transformation(extent = {{18, 0}, {38, 20}})));
  equation
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-92, 6}, {-92, 20}, {-72, 20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(Rload.n, sineVoltage.n) annotation(Line(points = {{-12, -4}, {-12, -12}, {-72, -12}, {-72, 20}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(idealDiode.p, sineVoltage.p) annotation(Line(points = {{-52, 60}, {-72, 60}, {-72, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(potentialSensor.p, Rload.p) annotation(Line(points = {{18, 10}, {4, 10}, {4, 16}, {-12, 16}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(potentialSensor.phi, mean.u) annotation(Line(points = {{39, 10}, {48, 10}, {48, 30}, {58, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(avg1.u, potentialSensor.phi) annotation(Line(points = {{58, 0}, {48, 0}, {48, 10}, {39, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(idealDiode.n, Rload.p) annotation(Line(points = {{-32, 60}, {-12, 60}, {-12, 16}}, color = {0, 0, 255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 0.06), __Dymola_experimentSetupOutput);
  end RLD_avg;
  annotation(uses(Modelica(version = "3.2.1")));
end TestSave;
