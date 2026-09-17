model Inverter
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1 annotation(Placement(visible = true, transformation(origin = {0, 4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1 annotation(Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 100) annotation(Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 100) annotation(Placement(visible = true, transformation(origin = {20, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-80, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 1) annotation(Placement(visible = true, transformation(origin = {20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Mean mean1(f = 1000) annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Mean mean2(f = 1000) annotation(Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.HBridge hBridge1 annotation(Placement(visible = true, transformation(origin = {-40, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM1(f = 1000, useConstantDutyCycle = false) annotation(Placement(visible = true, transformation(origin = {-40, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 0.5, freqHz = 10, offset = 0.5, phase(displayUnit = "rad")) annotation(Placement(visible = true, transformation(origin = {-80, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(hBridge1.dc_n2, currentSensor1.n) annotation(Line(points = {{-30, 4}, {-10, 4}}, color = {0, 0, 255}));
  connect(currentSensor1.p, voltageSensor1.n) annotation(Line(points = {{10, 4}, {50, 4}, {50, 20}}, color = {0, 0, 255}));
  connect(inductor1.n, currentSensor1.p) annotation(Line(points = {{20, 20}, {20, 4}, {10, 4}}, color = {0, 0, 255}));
  connect(currentSensor1.i, mean1.u) annotation(Line(points = {{0, -6}, {0, -6}, {0, -28}, {0, -28}}, color = {0, 0, 127}));
  connect(sine1.y, signalPWM1.dutyCycle) annotation(Line(points = {{-69, -62}, {-53, -62}}, color = {0, 0, 127}));
  connect(ground1.p, constantVoltage1.n) annotation(Line(points = {{-80, -12}, {-80, 0}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, hBridge1.dc_p1) annotation(Line(points = {{-80, 20}, {-62, 20}, {-62, 16}, {-50, 16}}, color = {0, 0, 255}));
  connect(constantVoltage1.n, hBridge1.dc_n1) annotation(Line(points = {{-80, 0}, {-62, 0}, {-62, 4}, {-50, 4}}, color = {0, 0, 255}));
  connect(resistor1.n, inductor1.p) annotation(Line(points = {{20, 52}, {20, 40}}, color = {0, 0, 255}));
  connect(resistor1.p, voltageSensor1.p) annotation(Line(points = {{20, 72}, {20, 80}, {50, 80}, {50, 40}}, color = {0, 0, 255}));
  connect(hBridge1.dc_p2, resistor1.p) annotation(Line(points = {{-30, 16}, {-20, 16}, {-20, 80}, {20, 80}, {20, 72}}, color = {0, 0, 255}));
  connect(voltageSensor1.v, mean2.u) annotation(Line(points = {{60, 30}, {78, 30}}, color = {0, 0, 127}));
  connect(hBridge1.fire_n, signalPWM1.notFire) annotation(Line(points = {{-34, -2}, {-34, -51}}, color = {255, 0, 255}));
  connect(hBridge1.fire_p, signalPWM1.fire) annotation(Line(points = {{-46, -2}, {-46, -51}}, color = {255, 0, 255}));
  annotation(uses(Modelica(version = "3.2.2")), experiment(StartTime = 0, StopTime = 0.3, Tolerance = 1e-06, Interval = 1.0001e-05));
end Inverter;