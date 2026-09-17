package TestConn

  package Submodels
    model QSensor
    Modelica.Electrical.Analog.Interfaces.PositivePin pv annotation(
        Placement(visible = true, transformation(origin = {20, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pc annotation(
        Placement(visible = true, transformation(origin = {-140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin nc annotation(
        Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv annotation(
        Placement(visible = true, transformation(origin = {20, -138}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
        Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
        Placement(visible = true, transformation(origin = {20, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime = 0.005)  annotation(
        Placement(visible = true, transformation(origin = {-30, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
        Placement(visible = true, transformation(origin = {-74, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(visible = true, transformation(origin = {-72, -146}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(pc, currentSensor.p) annotation(
        Line(points = {{-140, 0}, {-62, 0}}, color = {0, 0, 255}));
      connect(currentSensor.n, nc) annotation(
        Line(points = {{-42, 0}, {140, 0}}, color = {0, 0, 255}));
  connect(currentSensor.i, product.u2) annotation(
        Line(points = {{-52, -10}, {-80, -10}, {-80, -62}}, color = {0, 0, 127}));
  connect(product.u1, fixedDelay.u) annotation(
        Line(points = {{-68, -62}, {-68, -38}, {-18, -38}}, color = {0, 0, 127}));
      connect(nv, voltageSensor.n) annotation(
        Line(points = {{20, -138}, {20, -48}}, color = {0, 0, 255}));
  connect(voltageSensor.v, fixedDelay.y) annotation(
        Line(points = {{9, -38}, {-41, -38}}, color = {0, 0, 127}));
      connect(voltageSensor.p, pv) annotation(
        Line(points = {{20, -28}, {20, 118}}, color = {0, 0, 255}));
  connect(y, product.y) annotation(
        Line(points = {{-72, -146}, {-72, -115}, {-74, -115}, {-74, -85}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-140, 120}, {140, -140}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));end QSensor;
    
    model QSensorGood
    Modelica.Electrical.Analog.Interfaces.PositivePin pv annotation(
        Placement(visible = true, transformation(origin = {20, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.PositivePin pc annotation(
        Placement(visible = true, transformation(origin = {-140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nc annotation(
        Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin nv annotation(
        Placement(visible = true, transformation(origin = {20, -138}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
        Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
        Placement(visible = true, transformation(origin = {20, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime = 0.005)  annotation(
        Placement(visible = true, transformation(origin = {-30, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
        Placement(visible = true, transformation(origin = {-74, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(visible = true, transformation(origin = {-72, -146}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(pc, currentSensor.p) annotation(
        Line(points = {{-140, 0}, {-62, 0}}, color = {0, 0, 255}));
      connect(currentSensor.n, nc) annotation(
        Line(points = {{-42, 0}, {140, 0}}, color = {0, 0, 255}));
    connect(currentSensor.i, product.u2) annotation(
        Line(points = {{-52, -10}, {-80, -10}, {-80, -62}}, color = {0, 0, 127}));
      connect(nv, voltageSensor.n) annotation(
        Line(points = {{20, -138}, {20, -48}}, color = {0, 0, 255}));
      connect(voltageSensor.p, pv) annotation(
        Line(points = {{20, -28}, {20, 118}}, color = {0, 0, 255}));
    connect(y, product.y) annotation(
        Line(points = {{-72, -146}, {-72, -115}, {-74, -115}, {-74, -85}}, color = {0, 0, 127}));
  connect(fixedDelay.y, product.u1) annotation(
        Line(points = {{-40, -38}, {-68, -38}, {-68, -62}}, color = {0, 0, 127}));
  connect(voltageSensor.v, fixedDelay.u) annotation(
        Line(points = {{10, -38}, {-18, -38}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-140, 120}, {140, -140}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));end QSensorGood;
  end Submodels;
  
  model RL_PQ
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 100, freqHz = 50) annotation(
      Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(
      Placement(visible = true, transformation(origin = {-4, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {64, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(
      Placement(visible = true, transformation(origin = {64, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-4, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Mean mean(f = 50) annotation(
      Placement(visible = true, transformation(origin = {-34, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Submodels.QSensor qSensor annotation(
      Placement(visible = true, transformation(origin = {30, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sineVoltage.n, powerSensor.pc) annotation(
      Line(points = {{-58, 10}, {-58, 32}, {-14, 32}}, color = {0, 0, 255}));
    connect(resistor.n, inductor.p) annotation(
      Line(points = {{64, 2}, {64, -16}}, color = {0, 0, 255}));
    connect(inductor.n, ground.p) annotation(
      Line(points = {{64, -36}, {64, -50}, {-4, -50}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.p) annotation(
      Line(points = {{-4, -50}, {-58, -50}, {-58, -10}}, color = {0, 0, 255}));
    connect(powerSensor.nv, ground.p) annotation(
      Line(points = {{-4, 22}, {-4, -50}}, color = {0, 0, 255}));
    connect(powerSensor.pc, powerSensor.pv) annotation(
      Line(points = {{-16, 32}, {-16, 42}, {-6, 42}}, color = {0, 0, 255}));
    connect(powerSensor.power, mean.u) annotation(
      Line(points = {{-14, 21}, {-14, 9}, {-22, 9}}, color = {0, 0, 127}));
  connect(powerSensor.nc, qSensor.pc) annotation(
      Line(points = {{6, 32}, {20, 32}}, color = {0, 0, 255}));
  connect(qSensor.pv, powerSensor.nc) annotation(
      Line(points = {{30, 42}, {30, 50}, {12, 50}, {12, 32}, {6, 32}}, color = {0, 0, 255}));
  connect(qSensor.nc, resistor.p) annotation(
      Line(points = {{40, 32}, {64, 32}, {64, 22}}, color = {0, 0, 255}));
  connect(qSensor.nv, ground.p) annotation(
      Line(points = {{30, 22}, {30, -50}, {-4, -50}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(extent = {{-80, 60}, {80, -80}})),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end RL_PQ;
  
  model RL_PQgood
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 100, freqHz = 50) annotation(
      Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(
      Placement(visible = true, transformation(origin = {-4, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {64, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(
      Placement(visible = true, transformation(origin = {64, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-4, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Mean mean(f = 50) annotation(
      Placement(visible = true, transformation(origin = {-34, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Submodels.QSensorGood qSensor annotation(
      Placement(visible = true, transformation(origin = {30, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sineVoltage.n, powerSensor.pc) annotation(
      Line(points = {{-58, 10}, {-58, 32}, {-14, 32}}, color = {0, 0, 255}));
    connect(resistor.n, inductor.p) annotation(
      Line(points = {{64, 2}, {64, -16}}, color = {0, 0, 255}));
    connect(inductor.n, ground.p) annotation(
      Line(points = {{64, -36}, {64, -50}, {-4, -50}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.p) annotation(
      Line(points = {{-4, -50}, {-58, -50}, {-58, -10}}, color = {0, 0, 255}));
    connect(powerSensor.nv, ground.p) annotation(
      Line(points = {{-4, 22}, {-4, -50}}, color = {0, 0, 255}));
    connect(powerSensor.pc, powerSensor.pv) annotation(
      Line(points = {{-16, 32}, {-16, 42}, {-6, 42}}, color = {0, 0, 255}));
    connect(powerSensor.power, mean.u) annotation(
      Line(points = {{-14, 21}, {-14, 9}, {-22, 9}}, color = {0, 0, 127}));
  connect(powerSensor.nc, qSensor.pc) annotation(
      Line(points = {{6, 32}, {20, 32}}, color = {0, 0, 255}));
  connect(qSensor.pv, powerSensor.nc) annotation(
      Line(points = {{30, 42}, {30, 50}, {12, 50}, {12, 32}, {6, 32}}, color = {0, 0, 255}));
  connect(qSensor.nc, resistor.p) annotation(
      Line(points = {{40, 32}, {64, 32}, {64, 22}}, color = {0, 0, 255}));
  connect(qSensor.nv, ground.p) annotation(
      Line(points = {{30, 22}, {30, -50}, {-4, -50}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(extent = {{-80, 60}, {80, -80}})),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  end RL_PQgood;
  annotation(
    uses(Modelica(version = "4.0.0")));
end TestConn;
