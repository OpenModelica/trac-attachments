model MotorControl
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dC_Machine1(Jr = 0.2, Ra = 2.1, La = 0.30, VaNominal = 240, IaNominal = 6, wNominal = 700 / 60 * 2 * Modelica.Constants.pi) annotation(
    Placement(visible = true, transformation(origin = {0, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1 annotation(
    Placement(visible = true, transformation(origin = {-26, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1 annotation(
    Placement(visible = true, transformation(origin = {20, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Electrical.PowerConverters.DCDC.HBridge hBridge1 annotation(
    Placement(visible = true, transformation(origin = {24, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 240) annotation(
    Placement(visible = true, transformation(origin = {-26, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-50, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(
    Placement(visible = true, transformation(origin = {-30, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM1(constantDutyCycle = 1, useConstantDutyCycle = false) annotation(
    Placement(visible = true, transformation(origin = {24, 92}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.VoltageToDutyCycle voltageToDutyCycle1(vMax = 240) annotation(
    Placement(visible = true, transformation(origin = {-30, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 2, startTime = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-96, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder Smoothing(T = 0.005, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-66, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Mean meanVoltage(f = 1000) annotation(
    Placement(visible = true, transformation(origin = {-62, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 0.16, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 26, yMax = 240) annotation(
    Placement(visible = true, transformation(origin = {-64, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Smoothing.y, PID.u_m) annotation(
    Line(points = {{-76, -28}, {-88, -28}, {-88, 66}, {-64, 66}, {-64, 80}, {-64, 80}}, color = {0, 0, 127}));
  connect(PID.y, voltageToDutyCycle1.v) annotation(
    Line(points = {{-52, 92}, {-44, 92}, {-44, 92}, {-42, 92}}, color = {0, 0, 127}));
  connect(step1.y, PID.u_s) annotation(
    Line(points = {{-84, 92}, {-76, 92}, {-76, 92}, {-76, 92}}, color = {0, 0, 127}));
  connect(voltageSensor1.v, meanVoltage.u) annotation(
    Line(points = {{20, -8}, {20, -8}, {20, 8}, {-50, 8}, {-50, 8}}, color = {0, 0, 127}));
  connect(currentSensor1.i, Smoothing.u) annotation(
    Line(points = {{-36, -28}, {-54, -28}, {-54, -28}, {-54, -28}}, color = {0, 0, 127}));
  connect(voltageToDutyCycle1.dutyCycle, signalPWM1.dutyCycle) annotation(
    Line(points = {{-18, 92}, {10, 92}, {10, 92}, {12, 92}}, color = {0, 0, 127}));
  connect(signalPWM1.notFire, hBridge1.fire_n) annotation(
    Line(points = {{30, 80}, {30, 80}, {30, 56}, {30, 56}}, color = {255, 0, 255}));
  connect(signalPWM1.fire, hBridge1.fire_p) annotation(
    Line(points = {{18, 80}, {18, 80}, {18, 56}, {18, 56}}, color = {255, 0, 255}));
  connect(fixed1.flange, dC_Machine1.flange) annotation(
    Line(points = {{-30, -70}, {-30, -70}, {-30, -64}, {-10, -64}, {-10, -64}}));
  connect(ground1.p, constantVoltage1.n) annotation(
    Line(points = {{-50, 48}, {-50, 48}, {-50, 52}, {-26, 52}, {-26, 52}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, hBridge1.dc_p1) annotation(
    Line(points = {{-26, 32}, {-26, 32}, {-26, 26}, {8, 26}, {8, 38}, {14, 38}, {14, 38}}, color = {0, 0, 255}));
  connect(constantVoltage1.n, hBridge1.dc_n1) annotation(
    Line(points = {{-26, 52}, {-26, 52}, {-26, 66}, {6, 66}, {6, 50}, {14, 50}, {14, 50}}, color = {0, 0, 255}));
  connect(dC_Machine1.pin_an, hBridge1.dc_n2) annotation(
    Line(points = {{6, -54}, {54, -54}, {54, 50}, {34, 50}, {34, 50}}, color = {0, 0, 255}));
  connect(dC_Machine1.pin_an, voltageSensor1.n) annotation(
    Line(points = {{6, -54}, {54, -54}, {54, -18}, {30, -18}, {30, -18}}, color = {0, 0, 255}));
  connect(dC_Machine1.pin_ap, currentSensor1.n) annotation(
    Line(points = {{-6, -54}, {-26, -54}, {-26, -38}, {-26, -38}}, color = {0, 0, 255}));
  connect(currentSensor1.p, voltageSensor1.p) annotation(
    Line(points = {{-26, -18}, {10, -18}, {10, -18}, {10, -18}}, color = {0, 0, 255}));
  connect(hBridge1.dc_p2, currentSensor1.p) annotation(
    Line(points = {{34, 38}, {46, 38}, {46, 22}, {-26, 22}, {-26, -18}, {-26, -18}}, color = {0, 0, 255}));
  annotation(experiment(StartTime = 0, StopTime = 1.5, Tolerance = 1e-06, Interval = 0.00075));
end MotorControl;