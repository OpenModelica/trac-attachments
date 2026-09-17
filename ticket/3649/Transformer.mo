package Transformer

  model SC1
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor2 annotation(Placement(visible = true, transformation(origin = {-32, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor2 annotation(Placement(visible = true, transformation(origin = {-20, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor1 annotation(Placement(visible = true, transformation(origin = {76, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground2 annotation(Placement(visible = true, transformation(origin = {18, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor1 annotation(Placement(visible = true, transformation(origin = {86, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Transformer.SinglePhaseTransformerQS singlePhaseTransformerQS1(N1 = 500, R1 = 2.5, N2 = 250, R2 = 0.6, Gc = 1 / 1942, Lm = 1.79, L1sigma = 0.0636, L2sigma = 0.0165) annotation(Placement(visible = true, transformation(origin = {8, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-2, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor2 annotation(Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource1(f = 50, V = 98.5) annotation(Placement(visible = true, transformation(origin = {-81, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor1 annotation(Placement(visible = true, transformation(origin = {42, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(currentSensor1.pin_p, voltageSensor1.pin_n) annotation(Line(points = {{86, 44}, {110, 44}, {110, -14}, {86, -14}, {86, -14}}, color = {85, 170, 255}));
    connect(powerSensor2.voltageN, ground1.pin) annotation(Line(points = {{-32, 34}, {-32, 34}, {-32, -16}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_p2, powerSensor1.currentP) annotation(Line(points = {{18, 24}, {20, 24}, {20, 40}, {32, 40}, {32, 40}}, color = {85, 170, 255}));
    connect(ground2.pin, powerSensor1.voltageN) annotation(Line(points = {{18, -14}, {42, -14}, {42, 30}, {42, 30}}, color = {85, 170, 255}));
    connect(powerSensor1.currentN, currentSensor1.pin_n) annotation(Line(points = {{52, 40}, {59, 40}, {59, 44}, {66, 44}}, color = {85, 170, 255}));
    connect(powerSensor1.currentP, powerSensor1.voltageP) annotation(Line(points = {{32, 40}, {32, 50}, {42, 50}}, color = {85, 170, 255}));
    connect(voltageSensor1.pin_n, ground2.pin) annotation(Line(points = {{86, -14}, {18, -14}, {18, -14}, {18, -14}}, color = {85, 170, 255}));
    connect(currentSensor1.pin_p, voltageSensor1.pin_p) annotation(Line(points = {{86, 44}, {86, 44}, {86, 6}, {86, 6}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_n2, ground2.pin) annotation(Line(points = {{18, 8}, {18, 8}, {18, -14}, {18, -14}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_n1, ground1.pin) annotation(Line(points = {{-2, 8}, {-2, 8}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSensor2.pin_n, ground1.pin) annotation(Line(points = {{-20, 6}, {-20, 6}, {-20, -16}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSource1.pin_n, ground1.pin) annotation(Line(points = {{-81, 0}, {-80, 0}, {-80, -18}, {-2, -18}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSensor2.pin_p, powerSensor2.currentN) annotation(Line(points = {{-20, 26}, {-20, 26}, {-20, 44}, {-22, 44}, {-22, 44}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_p1, powerSensor2.currentN) annotation(Line(points = {{-2, 24}, {-2, 24}, {-2, 44}, {-22, 44}, {-22, 44}}, color = {85, 170, 255}));
    connect(currentSensor2.pin_p, powerSensor2.currentP) annotation(Line(points = {{-60, 40}, {-42, 40}, {-42, 44}, {-42, 44}}, color = {85, 170, 255}));
    connect(voltageSource1.pin_p, currentSensor2.pin_n) annotation(Line(points = {{-81, 20}, {-80, 20}, {-80, 40}, {-80, 40}}, color = {85, 170, 255}));
    connect(powerSensor2.currentP, powerSensor2.voltageP) annotation(Line(points = {{-42, 44}, {-42, 44}, {-42, 54}, {-32, 54}, {-32, 54}}, color = {85, 170, 255}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end SC1;

  model SC2
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor2 annotation(Placement(visible = true, transformation(origin = {-32, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor2 annotation(Placement(visible = true, transformation(origin = {-20, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor1 annotation(Placement(visible = true, transformation(origin = {76, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground2 annotation(Placement(visible = true, transformation(origin = {18, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor1 annotation(Placement(visible = true, transformation(origin = {86, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Transformer.SinglePhaseTransformerQS singlePhaseTransformerQS1(N1 = 500, R1 = 2.5, N2 = 250, R2 = 0.6, Gc = 1 / 1942, Lm = 1.79, L1sigma = 0.0636, L2sigma = 0.0165) annotation(Placement(visible = true, transformation(origin = {8, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-2, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor2 annotation(Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource voltageSource1(f = 50, V = 98.5) annotation(Placement(visible = true, transformation(origin = {-81, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor1 annotation(Placement(visible = true, transformation(origin = {42, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(currentSensor1.pin_p, ground2.pin) annotation(Line(points = {{86, 44}, {108, 44}, {108, -14}, {18, -14}, {18, -14}, {18, -14}}, color = {85, 170, 255}));
    connect(powerSensor2.voltageN, ground1.pin) annotation(Line(points = {{-32, 34}, {-32, 34}, {-32, -16}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_p2, powerSensor1.currentP) annotation(Line(points = {{18, 24}, {20, 24}, {20, 40}, {32, 40}, {32, 40}}, color = {85, 170, 255}));
    connect(ground2.pin, powerSensor1.voltageN) annotation(Line(points = {{18, -14}, {42, -14}, {42, 30}, {42, 30}}, color = {85, 170, 255}));
    connect(powerSensor1.currentN, currentSensor1.pin_n) annotation(Line(points = {{52, 40}, {59, 40}, {59, 44}, {66, 44}}, color = {85, 170, 255}));
    connect(powerSensor1.currentP, powerSensor1.voltageP) annotation(Line(points = {{32, 40}, {32, 50}, {42, 50}}, color = {85, 170, 255}));
    connect(voltageSensor1.pin_n, ground2.pin) annotation(Line(points = {{86, -14}, {18, -14}, {18, -14}, {18, -14}}, color = {85, 170, 255}));
    connect(currentSensor1.pin_p, voltageSensor1.pin_p) annotation(Line(points = {{86, 44}, {86, 44}, {86, 6}, {86, 6}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_n2, ground2.pin) annotation(Line(points = {{18, 8}, {18, 8}, {18, -14}, {18, -14}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_n1, ground1.pin) annotation(Line(points = {{-2, 8}, {-2, 8}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSensor2.pin_n, ground1.pin) annotation(Line(points = {{-20, 6}, {-20, 6}, {-20, -16}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSource1.pin_n, ground1.pin) annotation(Line(points = {{-81, 0}, {-80, 0}, {-80, -18}, {-2, -18}, {-2, -16}, {-2, -16}}, color = {85, 170, 255}));
    connect(voltageSensor2.pin_p, powerSensor2.currentN) annotation(Line(points = {{-20, 26}, {-20, 26}, {-20, 44}, {-22, 44}, {-22, 44}}, color = {85, 170, 255}));
    connect(singlePhaseTransformerQS1.pin_p1, powerSensor2.currentN) annotation(Line(points = {{-2, 24}, {-2, 24}, {-2, 44}, {-22, 44}, {-22, 44}}, color = {85, 170, 255}));
    connect(currentSensor2.pin_p, powerSensor2.currentP) annotation(Line(points = {{-60, 40}, {-42, 40}, {-42, 44}, {-42, 44}}, color = {85, 170, 255}));
    connect(voltageSource1.pin_p, currentSensor2.pin_n) annotation(Line(points = {{-81, 20}, {-80, 20}, {-80, 40}, {-80, 40}}, color = {85, 170, 255}));
    connect(powerSensor2.currentP, powerSensor2.voltageP) annotation(Line(points = {{-42, 44}, {-42, 44}, {-42, 54}, {-32, 54}, {-32, 54}}, color = {85, 170, 255}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end SC2;

  model SinglePhaseTransformerQS "Quasi stationary transformer modeled in electric domain including core loss"
    parameter Real N1 "Number of turns of primary winding" annotation(Dialog(tab = "Primary"));
    parameter Modelica.SIunits.Resistance R1 "Primary resistance per phase at TRef" annotation(Dialog(tab = "Primary"));
    parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1 = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper "Temperature coefficient of primary resistance at 20 degC" annotation(Dialog(tab = "Primary"));
    parameter Modelica.SIunits.Inductance L1sigma "Primary stray inductance per phase" annotation(Dialog(tab = "Primary"));
    parameter Real N2 "Number of turns of secondary winding" annotation(Dialog(tab = "Secondary"));
    parameter Modelica.SIunits.Resistance R2 "Secondary resistance per phase at TRef" annotation(Dialog(tab = "Secondary"));
    parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2 = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper "Temperature coefficient of secondary resistance at 20 degC" annotation(Dialog(tab = "Secondary"));
    parameter Modelica.SIunits.Inductance L2sigma "Secondary stray inductance per phase" annotation(Dialog(tab = "Secondary"));
    parameter Modelica.SIunits.Temperature TRef "Reference temperature of primary resistance";
    parameter Modelica.SIunits.Temperature TOperational = 293.15 "Operational temperature of primary resistance";
    parameter Boolean useHeatPort = false "Enables or disables thermal heat port";
    parameter Modelica.SIunits.Conductance Gc = 0 "Total eddy current core loss conductance (w.r.t. primary side)" annotation(Evaluate = true, Dialog(tab = "Core"));
    parameter Modelica.SIunits.Inductance Lm "Magnetizing inductance" annotation(Evaluate = true, Dialog(tab = "Core"));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor1(final L = L1sigma) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-40, 30})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor2(final L = L2sigma) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {40, 30})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor1(final T_ref = TRef, final T = TOperational, final R_ref = R1, final alpha_ref = alpha20_1, final useHeatPort = useHeatPort) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-70, 30})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor2(final T_ref = TRef, final T = TOperational, final R_ref = R2, final alpha_ref = alpha20_2, final useHeatPort = useHeatPort) annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {70, 30})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductorh(final L = Lm) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-20, -30})));
    Transformer.IdealTransformer idealTransformer(final n = N1 / N2) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor conductor(final G_ref = Gc, final useHeatPort = useHeatPort) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-40, -30})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p1 annotation(Placement(transformation(extent = {{-110, 70}, {-90, 90}}), iconTransformation(extent = {{-110, 70}, {-90, 90}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p2 annotation(Placement(transformation(extent = {{90, 70}, {110, 90}}), iconTransformation(extent = {{90, 70}, {110, 90}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n1 annotation(Placement(transformation(extent = {{-110, -90}, {-90, -70}}), iconTransformation(extent = {{-110, -90}, {-90, -70}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n2 annotation(Placement(transformation(extent = {{90, -90}, {110, -70}}), iconTransformation(extent = {{90, -90}, {110, -70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  equation
    connect(pin_p1, resistor1.pin_p) annotation(Line(points = {{-100, 80}, {-80, 80}, {-80, 30}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(resistor1.pin_n, inductor1.pin_p) annotation(Line(points = {{-60, 30}, {-50, 30}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(inductor2.pin_p, resistor2.pin_n) annotation(Line(points = {{50, 30}, {60, 30}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(inductor1.pin_n, inductorh.pin_p) annotation(Line(points = {{-30, 30}, {-20, 30}, {-20, -20}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(inductorh.pin_n, pin_n1) annotation(Line(points = {{-20, -40}, {-20, -80}, {-100, -80}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(idealTransformer.pin_n1, pin_n1) annotation(Line(points = {{-0.000000000000000444089, 10}, {-0.000000000000000444089, -80}, {-100, -80}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(resistor1.heatPort, heatPort) annotation(Line(points = {{-70, 20}, {-70, -100}, {0, -100}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(resistor2.heatPort, heatPort) annotation(Line(points = {{70, 20}, {70, -100}, {0.000000000000000444089, -100}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(conductor.heatPort, heatPort) annotation(Line(points = {{-50, -30}, {-50, -30}, {-50, -54}, {-50, -54}, {-50, -100}, {0.000000000000000444089, -100}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(conductor.pin_n, inductorh.pin_n) annotation(Line(points = {{-40, -40}, {-40, -50}, {-20, -50}, {-20, -40}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(conductor.pin_p, inductorh.pin_p) annotation(Line(points = {{-40, -20}, {-40, -10}, {-20, -10}, {-20, -20}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(inductor1.pin_n, idealTransformer.pin_p1) annotation(Line(points = {{-30, 30}, {-4.44089e-16, 30}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(idealTransformer.pin_n2, pin_n2) annotation(Line(points = {{20, 10}, {20, -80}, {100, -80}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(idealTransformer.pin_p2, inductor2.pin_n) annotation(Line(points = {{20, 30}, {30, 30}}, color = {85, 170, 255}, smooth = Smooth.None));
    connect(resistor2.pin_p, pin_p2) annotation(Line(points = {{80, 30}, {80, 80}, {100, 80}}, color = {85, 170, 255}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Polygon(fillColor = {135, 135, 135}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 60}, {-20, 40}, {-20, -40}, {-40, -60}, {-40, 60}}), Polygon(fillColor = {135, 135, 135}, fillPattern = FillPattern.VerticalCylinder, points = {{42, 60}, {22, 40}, {22, -40}, {42, -60}, {42, 60}}), Polygon(fillColor = {135, 135, 135}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, 60}, {42, 60}, {22, 40}, {12, 40}, {2, 40}, {-8, 40}, {-20, 40}, {-40, 60}}), Polygon(fillColor = {135, 135, 135}, fillPattern = FillPattern.VerticalCylinder, points = {{-40, -60}, {42, -60}, {22, -40}, {14, -40}, {8, -40}, {0, -40}, {-20, -40}, {-40, -60}}), Rectangle(fillColor = {213, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-48, 36}, {-12, -36}}), Rectangle(fillColor = {213, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{12, 36}, {48, -36}}), Line(points = {{-100, 90}, {-100, 28}, {-54, 28}}, color = {0, 0, 255}), Line(points = {{-52, -28}, {-100, -28}, {-100, -90}}, color = {0, 0, 255}), Line(points = {{100, 90}, {100, 86}, {100, 36}, {48, 36}}, color = {0, 0, 255}), Line(points = {{48, -36}, {100, -36}, {100, -87.2826}}, color = {0, 0, 255}), Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-54, 28}, {-6, -28}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{6, 30}, {54, -26}})}));
  end SinglePhaseTransformerQS;
  
  model IdealTransformer "Ideal quasi stationary transformer"
    parameter Real n = 1 "Ratio of primary to secondary voltage";
    Modelica.SIunits.ComplexVoltage v1 = pin_p1.v - pin_n1.v "Voltage drop of side 1";
    Modelica.SIunits.ComplexCurrent i1 = pin_p1.i "Current into side 1";
    Modelica.SIunits.ComplexVoltage v2 = pin_p2.v - pin_n2.v "Voltage drop of side 2";
    Modelica.SIunits.ComplexCurrent i2 = pin_p2.i "Current into side 2";
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p1 annotation(Placement(transformation(extent = {{-110, 90}, {-90, 110}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p2 annotation(Placement(transformation(extent = {{90, 90}, {110, 110}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n1 annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n2 annotation(Placement(transformation(extent = {{90, -110}, {110, -90}})));
  equation
    // Current balance
    pin_p1.i + pin_n1.i = Complex(0, 0);
    pin_p2.i + pin_n2.i = Complex(0, 0);
    // Transformation ratios
    v1 = Complex(+n, 0) * v2;
    i2 = Complex(-n, 0) * i1;
    Connections.branch(pin_p1.reference, pin_n1.reference);
    pin_p1.reference.gamma = pin_n1.reference.gamma;
    Connections.branch(pin_n1.reference, pin_n2.reference);
    pin_p2.reference.gamma = pin_n2.reference.gamma;
    Connections.branch(pin_p1.reference, pin_p2.reference);
    pin_p1.reference.gamma = pin_p2.reference.gamma;
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{0, 60}, {40, 20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{0, 20}, {40, -20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{0, -20}, {40, -60}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-40, 60}, {0, 20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-40, 20}, {0, -20}}, lineColor = {0, 0, 255}), Ellipse(extent = {{-40, -20}, {0, -60}}, lineColor = {0, 0, 255}), Rectangle(extent = {{-20, 60}, {20, -60}}, pattern = LinePattern.None, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{20, 60}, {20, 100}, {100, 100}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{20, -60}, {20, -100}, {100, -100}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-20, 60}, {-20, 100}, {-100, 100}}, color = {0, 0, 255}, smooth = Smooth.None), Line(points = {{-20, -60}, {-20, -100}, {-100, -100}}, color = {0, 0, 255}, smooth = Smooth.None), Text(extent = {{-100, 20}, {-60, -20}}, lineColor = {0, 0, 255}, fillPattern = FillPattern.Solid, textString = "1
"), Text(extent = {{60, 20}, {100, -20}}, lineColor = {0, 0, 255}, fillPattern = FillPattern.Solid, textString = "2
"), Text(extent = {{-146, 155}, {154, 115}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-100, -120}, {100, -140}}, textString = "n=%n", lineColor = {0, 0, 0})}));
  end IdealTransformer;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Transformer;
