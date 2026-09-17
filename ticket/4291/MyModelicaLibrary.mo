package MyModelicaLibrary
  model SSD_PeakDetect
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 250.0E-9, nperiod = -1, period = 50.0E-6, width = 0.038) annotation(
      Placement(visible = true, transformation(origin = {-286, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth1(f = 4.5E6) annotation(
      Placement(visible = true, transformation(origin = {-222, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample1 annotation(
      Placement(visible = true, transformation(origin = {-126, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica_Synchronous.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period = 5.0E-9) annotation(
      Placement(visible = true, transformation(origin = {-156, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction1(a = {1, 0, 0}) annotation(
      Placement(visible = true, transformation(origin = {-96, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {-64, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add2 annotation(
      Placement(visible = true, transformation(origin = {2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction2(a = {1, 0}) annotation(
      Placement(visible = true, transformation(origin = {-28, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction3(a = {1, 0, 0, 0, 0, 0}) annotation(
      Placement(visible = true, transformation(origin = {34, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {66, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Noise.NormalNoise normalNoise1(samplePeriod = 1.0E-12, sigma = 1.4E-7)  annotation(
      Placement(visible = true, transformation(origin = {-284, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = true)  annotation(
      Placement(visible = true, transformation(origin = {-282, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add3 annotation(
      Placement(visible = true, transformation(origin = {-250, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 2.4E6)  annotation(
      Placement(visible = true, transformation(origin = {-188, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(periodicClock1.y, sample1.clock) annotation(
      Line(points = {{-145, -36}, {-126, -36}, {-126, -9}}, color = {175, 175, 175}));
    connect(gain1.y, sample1.u) annotation(
      Line(points = {{-176, -2}, {-134, -2}, {-134, -2}, {-134, -2}}, color = {0, 0, 127}));
    connect(lowpassButterworth1.y, gain1.u) annotation(
      Line(points = {{-210, -2}, {-200, -2}, {-200, -2}, {-200, -2}}, color = {0, 0, 127}));
    connect(pulse1.y, add3.u1) annotation(
      Line(points = {{-275, 4}, {-262, 4}}, color = {0, 0, 127}));
    connect(add2.y, feedback1.u2) annotation(
      Line(points = {{13, 10}, {28.5, 10}, {28.5, 10}, {42, 10}, {42, 10}, {67, 10}, {67, 14}, {68, 14}, {68, 14}, {69.5, 14}, {69.5, 14}, {65, 14}}, color = {0, 0, 127}));
    connect(transferFunction3.y, feedback1.u1) annotation(
      Line(points = {{45, 32}, {52, 32}, {52, 22}, {58, 22}}, color = {0, 0, 127}));
    connect(add2.y, transferFunction3.u) annotation(
      Line(points = {{13, 10}, {15, 10}, {15, 32}, {21, 32}, {21, 32}, {23, 32}, {23, 32}, {21, 32}, {21, 32}}, color = {0, 0, 127}));
    connect(transferFunction2.y, add2.u1) annotation(
      Line(points = {{-17, 26}, {-14.5, 26}, {-14.5, 26}, {-14, 26}, {-14, 26}, {-13, 26}, {-13, 16}, {-11.5, 16}, {-11.5, 16}, {-10.75, 16}, {-10.75, 16}, {-10, 16}}, color = {0, 0, 127}));
    connect(add1.y, transferFunction2.u) annotation(
      Line(points = {{-53, 4}, {-48, 4}, {-48, 26}, {-44, 26}, {-44, 26}, {-40, 26}}, color = {0, 0, 127}));
    connect(add2.u2, add1.y) annotation(
      Line(points = {{-10, 4}, {-53, 4}}, color = {0, 0, 127}));
    connect(add1.u2, sample1.y) annotation(
      Line(points = {{-76, -2}, {-120, -2}}, color = {0, 0, 127}));
    connect(transferFunction1.y, add1.u1) annotation(
      Line(points = {{-85, 28}, {-85, 30}, {-81, 30}, {-81, 10}, {-76, 10}}, color = {0, 0, 127}));
    connect(sample1.y, transferFunction1.u) annotation(
      Line(points = {{-119.4, -2}, {-117.4, -2}, {-117.4, 28}, {-107.4, 28}}, color = {0, 0, 127}));
    connect(normalNoise1.y, add3.u2) annotation(
      Line(points = {{-272, -36}, {-268, -36}, {-268, -8}, {-262, -8}, {-262, -8}}, color = {0, 0, 127}));
    connect(add3.y, lowpassButterworth1.u) annotation(
      Line(points = {{-238, -2}, {-232, -2}, {-232, -2}, {-234, -2}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.1"), Modelica_Synchronous(version = "0.92.1")),
      Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
      Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
      __OpenModelica_commandLineOptions = "");
  end SSD_PeakDetect;

  model Test
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 250.0E-9, nperiod = -1, period = 50.0E-6, width = 0.038) annotation(
      Placement(visible = true, transformation(origin = {-108, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth1(f = 4.5E6) annotation(
      Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Noise.NormalNoise normalNoise1(samplePeriod = 100.0E-9, sigma = 5.25E-15) annotation(
      Placement(visible = true, transformation(origin = {-106, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = false) annotation(
      Placement(visible = true, transformation(origin = {-104, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add3 annotation(
      Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 2.4E6) annotation(
      Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(lowpassButterworth1.y, gain1.u) annotation(
      Line(points = {{-33, 0}, {-28, 0}, {-28, 0}, {-23, 0}, {-23, 0}, {-23, 0}}, color = {0, 0, 127}));
    connect(add3.y, lowpassButterworth1.u) annotation(
      Line(points = {{-61, 0}, {-55, 0}, {-55, 0}, {-57, 0}}, color = {0, 0, 127}));
    connect(normalNoise1.y, add3.u2) annotation(
      Line(points = {{-95, -34}, {-91, -34}, {-91, -6}, {-85, -6}, {-85, -6}, {-85, -6}, {-85, -6}}, color = {0, 0, 127}));
    connect(pulse1.y, add3.u1) annotation(
      Line(points = {{-97, 6}, {-84, 6}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.1"), Modelica_Synchronous(version = "0.92.1")),
      Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
      Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
      __OpenModelica_commandLineOptions = "");
  end Test;
  annotation(
    uses(Modelica(version = "3.2.2")));
end MyModelicaLibrary;
