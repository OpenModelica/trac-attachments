package MyModelicaLibrary
  model SSD_PeakDetect
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 250.0E-9, nperiod = -1, period = 50.0E-6, width = 0.038) annotation(Placement(visible = true, transformation(origin = {-84, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LowpassButterworth lowpassButterworth1(f = 4.5E6) annotation(Placement(visible = true, transformation(origin = {-50, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica_Synchronous.RealSignals.Sampler.SampleClocked sample1 annotation(Placement(visible = true, transformation(origin = {-22, 56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica_Synchronous.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period = 5.0E-9)  annotation(Placement(visible = true, transformation(origin = {-52, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction1(a = {1, 0, 0})  annotation(Placement(visible = true, transformation(origin = {4, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(Placement(visible = true, transformation(origin = {38, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(Placement(visible = true, transformation(origin = {40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction2(a = {1, 0})  annotation(Placement(visible = true, transformation(origin = {6, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Synchronous.RealSignals.Periodic.TransferFunction transferFunction3(a = {1, 0, 0, 0, 0, 0})  annotation(Placement(visible = true, transformation(origin = {-48, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(Placement(visible = true, transformation(origin = {-20, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(feedback1.u2, add2.y) annotation(Line(points = {{-20, -50}, {-20, -50}, {-20, -64}, {-80, -64}, {-80, -12}, {58, -12}, {58, 12}, {52, 12}, {52, 12}}, color = {0, 0, 127}));
    connect(transferFunction3.y, feedback1.u1) annotation(Line(points = {{-36, -42}, {-26, -42}, {-26, -42}, {-28, -42}}, color = {0, 0, 127}));
    connect(add2.y, transferFunction3.u) annotation(Line(points = {{52, 12}, {58, 12}, {58, -18}, {-68, -18}, {-68, -42}, {-60, -42}, {-60, -42}}, color = {0, 0, 127}));
    connect(transferFunction2.y, add2.u2) annotation(Line(points = {{18, 6}, {26, 6}, {26, 6}, {28, 6}}, color = {0, 0, 127}));
    connect(add2.u1, add1.y) annotation(Line(points = {{28, 18}, {20, 18}, {20, 40}, {60, 40}, {60, 58}, {48, 58}, {48, 58}, {50, 58}}, color = {0, 0, 127}));
    connect(add1.y, transferFunction2.u) annotation(Line(points = {{50, 58}, {60, 58}, {60, 46}, {-16, 46}, {-16, 6}, {-6, 6}}, color = {0, 0, 127}));
    connect(add1.u2, sample1.y) annotation(Line(points = {{26, 52}, {20, 52}, {20, 56}, {-16, 56}, {-16, 56}, {-16, 56}, {-16, 56}}, color = {0, 0, 127}));
    connect(sample1.y, transferFunction1.u) annotation(Line(points = {{-16, 56}, {-14, 56}, {-14, 82}, {-8, 82}}, color = {0, 0, 127}));
    connect(transferFunction1.y, add1.u1) annotation(Line(points = {{16, 82}, {20, 82}, {20, 64}, {26, 64}, {26, 64}}, color = {0, 0, 127}));
    connect(periodicClock1.y, sample1.clock) annotation(Line(points = {{-41, 22}, {-22, 22}, {-22, 49}}, color = {175, 175, 175}));
    connect(lowpassButterworth1.y, sample1.u) annotation(Line(points = {{-39, 56}, {-29, 56}}, color = {0, 0, 127}));
    connect(lowpassButterworth1.u, pulse1.y) annotation(Line(points = {{-62, 56}, {-73, 56}}, color = {0, 0, 127}));
    annotation(uses(Modelica(version = "3.2.1"), Modelica_Synchronous(version = "0.92.1")), Diagram);
  end SSD_PeakDetect;
end MyModelicaLibrary;