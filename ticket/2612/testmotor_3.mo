  model testmotor_3
    Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(Placement(transformation(extent = {{-4,68},{-24,88}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(origin = {-44,78}, extent = {{-10,-10},{10,10}}, rotation = 270)));
    Modelica.Blocks.Math.Feedback speederror annotation(Placement(transformation(extent = {{-82,40},{-62,60}}, rotation = 0)));
    Modelica.Blocks.Sources.Step Step1(startTime = 0.1, height = 10) annotation(Placement(transformation(extent = {{-100,40},{-80,60}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-4,4})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 10) annotation(Placement(transformation(extent = {{8,26},{28,46}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 0, origin = {66,36})));
    Modelica.Blocks.Sources.Step Step3(startTime = 0.5, height = 3) annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 0, origin = {90,36})));
    Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(alpha20a(displayUnit = "1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, useSupport = false, frictionParameters(PRef = 0, wRef = 0), coreParameters(PRef = 0, VRef = 0, wRef = 0), strayLoadParameters(PRef = 0, IRef = 0, wRef = 0, power_w = 0), brushParameters(V = 0.7), Jr = 0.001, VaNominal = 100, IaNominal = 100, Ra = 0.05, La = 0.0015, wNominal = 149.22565104552, TaNominal = 293.15, TaRef = 293.15) annotation(Placement(transformation(extent = {{-30,24},{-10,44}})));
    Modelica.Blocks.Continuous.PI PI(k = 0.1, T = 0.005) annotation(Placement(transformation(extent = {{-60,40},{-40,60}})));
    Modelica.Mechanics.Rotational.Components.Inertia loadInertia1(J = 1, phi(start = 0, fixed = true), w(start = 0, fixed = true)) annotation(Placement(transformation(extent = {{34,26},{54,46}}, rotation = 0)));
  equation
    connect(Step1.y,speederror.u1) annotation(Line(points = {{-79,50},{-80,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(ground.p,signalVoltage.n) annotation(Line(points = {{-34,78},{-24,78}}, color = {0,0,255}, smooth = Smooth.None));
    connect(speedSensor.w,speederror.u2) annotation(Line(points = {{-4,-7},{-72,-7},{-72,42}}, color = {0,0,127}, smooth = Smooth.None));
    connect(Step3.y,torque.tau) annotation(Line(points = {{79,36},{78,36}}, color = {0,0,127}, smooth = Smooth.None));
    connect(signalVoltage.n,dcpm.pin_an) annotation(Line(points = {{-24,78},{-26,78},{-26,44}}, color = {0,0,255}, smooth = Smooth.None));
    connect(signalVoltage.p,dcpm.pin_ap) annotation(Line(points = {{-4,78},{-8,78},{-8,44},{-14,44}}, color = {0,0,255}, smooth = Smooth.None));
    connect(dcpm.flange,idealGear.flange_a) annotation(Line(points = {{-10,34},{-2,34},{-2,36},{8,36}}, color = {0,0,0}, smooth = Smooth.None));
    connect(speedSensor.flange,dcpm.flange) annotation(Line(points = {{-4,14},{-4,34},{-10,34}}, color = {0,0,0}, smooth = Smooth.None));
    connect(speederror.y,PI.u) annotation(Line(points = {{-63,50},{-62,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PI.y,signalVoltage.v) annotation(Line(points = {{-39,50},{-38,50},{-38,68},{-52,68},{-52,94},{-14,94},{-14,85}}, color = {0,0,127}, smooth = Smooth.None));
    connect(idealGear.flange_b,loadInertia1.flange_a) annotation(Line(points = {{28,36},{34,36}}, color = {0,0,0}, smooth = Smooth.None));
    connect(loadInertia1.flange_b,torque.flange) annotation(Line(points = {{54,36},{56,36}}, color = {0,0,0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
  end testmotor_3;

