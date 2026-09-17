encapsulated package InvPWM
  import Modelica;
  import PowerSystems;
  import PowerSystems_Control_Modulation_SVPWM;
  import ElettricoCeraolo;
  // euro symbol €

  package SinglePhase
    model OneSQWId "bidirectional switches, one-leg, square wave"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{-50, -18}, {-30, 2}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(extent = {{38, -60}, {58, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-56, 18}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {48, -22}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-56, -26}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation (
        Placement(visible = true, transformation(origin = {-20, 32}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation (
        Placement(visible = true, transformation(origin = {-20, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 50) annotation (
        Placement(visible = true, transformation(extent = {{36, 36}, {16, 56}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not nor1 annotation (
        Placement(visible = true, transformation(origin = {0, 22}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.005) annotation (
        Placement(visible = true, transformation(origin = {48, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(inductor.n, Load.p) annotation (
        Line(points = {{48, -4}, {48, -12}}, color = {0, 0, 255}));
      connect(inductor.p, SWu.n) annotation (
        Line(points = {{48, 16}, {12, 16}, {12, 4}, {-20, 4}, {-20, 22}}, color = {0, 0, 255}));
      connect(Load.n, ground1.p) annotation (
        Line(points = {{48, -32}, {48, -40}}, color = {0, 0, 255}));
      connect(nor1.u, booleanPulse.y) annotation (
        Line(points = {{0, 27.6}, {0, 46}, {15, 46}}, color = {255, 0, 255}));
      connect(nor1.y, SWd.control) annotation (
        Line(points = {{0, 17.2}, {0, -38}, {-8, -38}}, color = {255, 0, 255}));
      connect(SWu.p, V1.p) annotation (
        Line(points = {{-20, 42}, {-20, 58}, {-56, 58}, {-56, 28}}, color = {0, 0, 255}));
      connect(SWu.n, SWd.p) annotation (
        Line(points = {{-20, 22}, {-20, -28}}, color = {0, 0, 255}));
      connect(booleanPulse.y, SWu.control) annotation (
        Line(points = {{15, 46}, {-10.5, 46}, {-36, 46}, {-36, 32}, {-32, 32}}, color = {255, 0, 255}));
      connect(SWd.n, V2.n) annotation (
        Line(points = {{-20, -48}, {-20, -58}, {-56, -58}, {-56, -47}, {-56, -47}, {-56, -36}}, color = {0, 0, 255}));
      connect(V1.n, V2.p) annotation (
        Line(points = {{-56, 8}, {-56, -16}, {-56, -16}}, color = {0, 0, 255}));
      connect(ground.p, V1.n) annotation (
        Line(points = {{-40, 2}, {-40, 5}, {-40, 5}, {-40, 8}, {-48, 8}, {-48, 8}, {-56, 8}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {80, 60}})),
        experiment(StopTime = 0.1, StartTime = 0, Tolerance = 1e-06, Interval = 0.0002),
        Documentation(info = "<html><head></head><body><p>Il risultato è identico a quello che si ha con interruttori pilotati e diodi in antiparallelo entrambi ideali.</p>
<p>Questo perché con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sistema più fisico è superiore perché consente di valutare anche gli effetti del blanking time.</p>
</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        __OpenModelica_commandLineOptions = "");
    end OneSQWId;

    model OneSQWRe "switch-diode pairs, one leg, square wave"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{-82, -34}, {-62, -14}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-58, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-58, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 50) annotation (
        Placement(visible = true, transformation(extent = {{34, 30}, {14, 50}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not nor1 annotation (
        Placement(visible = true, transformation(origin = {6, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-38, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-18, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-18, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-38, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.005) annotation (
        Placement(visible = true, transformation(origin = {24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(extent = {{50, -52}, {70, -32}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {60, -16}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    equation
      connect(Load.n, ground1.p) annotation (
        Line(points = {{60, -26}, {60, -32}}, color = {0, 0, 255}));
      connect(inductor.n, Load.p) annotation (
        Line(points = {{34, 0}, {61, 0}, {61, -6}, {60, -6}}, color = {0, 0, 255}));
      connect(inductor.p, dSW.p) annotation (
        Line(points = {{14, 0}, {-28, 0}, {-28, -14}, {-18, -14}}, color = {0, 0, 255}));
      connect(V2.n, dD.p) annotation (
        Line(points = {{-58, -42}, {-58, -48}, {-38, -48}, {-38, -34}}, color = {0, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-18, -34}, {-18, -48}, {-38, -48}, {-38, -34}}, color = {0, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-38, -14}, {-38, -14}, {-18, -14}}, color = {0, 0, 255}));
      connect(uD.p, dSW.p) annotation (
        Line(points = {{-38, 16}, {-38, 8}, {-28, 8}, {-28, -14}, {-18, -14}}, color = {0, 0, 255}));
      connect(nor1.y, dSW.fire) annotation (
        Line(points = {{6, 9.2}, {6, -34}, {-6, -34}}, color = {255, 0, 255}));
      connect(uSW.fire, booleanPulse.y) annotation (
        Line(points = {{-6, 16}, {-6, 40}, {13, 40}}, color = {255, 0, 255}));
      connect(uD.p, uSW.n) annotation (
        Line(points = {{-38, 16}, {-38, 8}, {-18, 8}, {-18, 16}}, color = {0, 0, 255}));
      connect(uSW.p, uD.n) annotation (
        Line(points = {{-18, 36}, {-18, 36}, {-18, 40}, {-38, 40}, {-38, 36}}, color = {0, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-58, 14}, {-58, 46}, {-28, 46}, {-28, 40}, {-38, 40}, {-38, 36}}, color = {0, 0, 255}));
      connect(nor1.u, booleanPulse.y) annotation (
        Line(points = {{6, 19.6}, {6, 40}, {13, 40}}, color = {255, 0, 255}));
      connect(V1.n, V2.p) annotation (
        Line(points = {{-58, -6}, {-58, -22}}, color = {0, 0, 255}));
      connect(ground.p, V1.n) annotation (
        Line(points = {{-72, -14}, {-72, -8}, {-72, -6}, {-58, -6}, {-58, -6}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {80, 60}})),
        experiment(StopTime = 0.1),
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>newInst OK</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false)),
        __OpenModelica_commandLineOptions = "");
    end OneSQWRe;

    model TwoSQWRe "Switch-diode pais, two-legs, square wave"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{82, -54}, {102, -34}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-70, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 50) annotation (
        Placement(visible = true, transformation(extent = {{100, 54}, {80, 74}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not nor1 annotation (
        Placement(visible = true, transformation(origin = {-8, -14}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, 40})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, 40})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, -18})));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, -18})));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.005) annotation (
        Placement(visible = true, transformation(origin = {92, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 1) annotation (
        Placement(visible = true, transformation(origin = {92, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {12, 40})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {32, 40})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {32, -18})));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {12, -18})));
      Modelica.Blocks.MathBoolean.Not nor2 annotation (
        Placement(visible = true, transformation(origin = {42, 50}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
        Placement(transformation(extent = {{62, 24}, {82, 44}})));
      Modelica.Blocks.Math.Mean meanP(f = 50) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {64, -30})));
    equation
      connect(inductor.n, Load.p) annotation (
        Line(points = {{92, 8}, {92, 0}}, color = {0, 0, 255}));
      connect(uSW.p, uD.n) annotation (
        Line(points = {{-30, 50}, {-30, 54}, {-50, 54}, {-50, 50}}, color = {0, 0, 255}));
      connect(uD.p, uSW.n) annotation (
        Line(points = {{-50, 30}, {-50, 22}, {-30, 22}, {-30, 30}}, color = {0, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-50, -8}, {-30, -8}}, color = {0, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-30, -28}, {-30, -42}, {-50, -42}, {-50, -28}}, color = {0, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-70, 28}, {-70, 60}, {-40, 60}, {-40, 54}, {-50, 54}, {-50, 50}}, color = {0, 0, 255}));
      connect(uD.p, dSW.p) annotation (
        Line(points = {{-50, 30}, {-50, 22}, {-40, 22}, {-40, -8}, {-30, -8}}, color = {0, 0, 255}));
      connect(uSW1.p, uD1.n) annotation (
        Line(points = {{32, 50}, {32, 54}, {12, 54}, {12, 50}}, color = {0, 0, 255}));
      connect(uD1.p, uSW1.n) annotation (
        Line(points = {{12, 30}, {12, 22}, {32, 22}, {32, 30}}, color = {0, 0, 255}));
      connect(dD1.n, dSW1.p) annotation (
        Line(points = {{12, -8}, {32, -8}}, color = {0, 0, 255}));
      connect(dSW1.n, dD1.p) annotation (
        Line(points = {{32, -28}, {32, -42}, {12, -42}, {12, -28}}, color = {0, 0, 255}));
      connect(V1.p, uD1.n) annotation (
        Line(points = {{-70, 28}, {-70, 60}, {22, 60}, {22, 54}, {12, 54}, {12, 50}}, color = {0, 0, 255}));
      connect(uD1.p, dSW1.p) annotation (
        Line(points = {{12, 30}, {12, 22}, {22, 22}, {22, -8}, {32, -8}}, color = {0, 0, 255}));
      connect(Load.n, dSW1.p) annotation (
        Line(points = {{92, -20}, {92, -24}, {78, -24}, {78, 2}, {32, 2}, {32, -8}}, color = {0, 0, 255}));
      connect(ground.p, dSW1.p) annotation (
        Line(points = {{92, -34}, {92, -24}, {78, -24}, {78, 2}, {32, 2}, {32, -8}}, color = {0, 0, 255}));
      connect(V1.n, dD.p) annotation (
        Line(points = {{-70, 8}, {-70, -42}, {-50, -42}, {-50, -28}}, color = {0, 0, 255}));
      connect(nor1.y, dSW.fire) annotation (
        Line(points = {{-8, -18.8}, {-8, -28}, {-18, -28}}, color = {255, 0, 255}));
      connect(nor2.y, uSW1.fire) annotation (
        Line(points = {{42, 45.2}, {42, 30}, {44, 30}}, color = {255, 0, 255}));
      connect(booleanPulse.y, nor2.u) annotation (
        Line(points = {{79, 64}, {42, 64}, {42, 55.6}}, color = {255, 0, 255}));
      connect(dSW1.fire, nor2.u) annotation (
        Line(points = {{44, -28}, {50, -28}, {50, 64}, {42, 64}, {42, 55.6}}, color = {255, 0, 255}));
      connect(uSW.fire, nor2.u) annotation (
        Line(points = {{-18, 30}, {-14, 30}, {-14, 64}, {42, 64}, {42, 55.6}}, color = {255, 0, 255}));
      connect(nor1.u, nor2.u) annotation (
        Line(points = {{-8, -8.4}, {-8, 64}, {42, 64}, {42, 55.6}}, color = {255, 0, 255}));
      connect(V1.n, dD1.p) annotation (
        Line(points = {{-70, 8}, {-70, -42}, {12, -42}, {12, -28}}, color = {0, 0, 255}));
      connect(powerSensor.pv, powerSensor.nc) annotation (
        Line(points = {{72, 44}, {82, 44}, {82, 34}}, color = {0, 0, 255}));
      connect(powerSensor.nc, inductor.p) annotation (
        Line(points = {{82, 34}, {92, 34}, {92, 28}}, color = {0, 0, 255}));
      connect(powerSensor.pc, dSW.p) annotation (
        Line(points = {{62, 34}, {62, 16}, {-40, 16}, {-40, -8}, {-30, -8}}, color = {0, 0, 255}));
      connect(powerSensor.nv, dSW1.p) annotation (
        Line(points = {{72, 24}, {72, 2}, {32, 2}, {32, -8}}, color = {0, 0, 255}));
      connect(meanP.u, powerSensor.power) annotation (
        Line(points = {{64, -18}, {64, 2}, {64, 23}, {62, 23}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {120, 80}})),
        experiment(StopTime = 0.1),
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end TwoSQWRe;

    model VCRe "Voltage cancellation scheme"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{-96, -80}, {-76, -60}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanPulse basePulse(period = 1 / 50) annotation (
        Placement(visible = true, transformation(extent = {{96, 34}, {76, 54}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not nor1 annotation (
        Placement(visible = true, transformation(origin = {-34, -14}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-66, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1, off(start = false)) annotation (
        Placement(visible = true, transformation(origin = {-46, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-46, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-66, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 67.36e-3) annotation (
        Placement(visible = true, transformation(origin = {84, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 42.32) annotation (
        Placement(visible = true, transformation(origin = {84, -22}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-4, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {16, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW1(Vknee = 0.1, off(start = false)) annotation (
        Placement(visible = true, transformation(origin = {16, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-4, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.MathBoolean.Not nor2 annotation (
        Placement(visible = true, transformation(origin = {28, -6}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation (
        Placement(visible = true, transformation(extent = {{46, 10}, {66, 30}}, rotation = 0)));
      Modelica.Blocks.Math.Mean meanP(f = 50) annotation (
        Placement(visible = true, transformation(origin = {48, -44}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.BooleanPulse delPulse(period = 1 / 50, startTime = 0.006) annotation (
        Placement(visible = true, transformation(extent = {{58, 52}, {38, 72}}, rotation = 0)));
    equation
      connect(inductor.n, Load.p) annotation (
        Line(points = {{84, -6}, {84, -12}}, color = {0, 0, 255}));
      connect(uSW.p, uD.n) annotation (
        Line(points = {{-46, 36}, {-46, 40}, {-66, 40}, {-66, 36}}, color = {0, 0, 255}));
      connect(uD.p, uSW.n) annotation (
        Line(points = {{-66, 16}, {-66, 8}, {-46, 8}, {-46, 16}}, color = {0, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-66, -22}, {-46, -22}}, color = {0, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-46, -42}, {-46, -56}, {-66, -56}, {-66, -42}}, color = {0, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-86, 14}, {-86, 46}, {-56, 46}, {-56, 40}, {-66, 40}, {-66, 36}}, color = {0, 0, 255}));
      connect(uD.p, dSW.p) annotation (
        Line(points = {{-66, 16}, {-66, 8}, {-56, 8}, {-56, -22}, {-46, -22}}, color = {0, 0, 255}));
      connect(uSW1.p, uD1.n) annotation (
        Line(points = {{16, 36}, {16, 40}, {-4, 40}, {-4, 36}}, color = {0, 0, 255}));
      connect(uD1.p, uSW1.n) annotation (
        Line(points = {{-4, 16}, {-4, 8}, {16, 8}, {16, 16}}, color = {0, 0, 255}));
      connect(dD1.n, dSW1.p) annotation (
        Line(points = {{-4, -22}, {16, -22}}, color = {0, 0, 255}));
      connect(dSW1.n, dD1.p) annotation (
        Line(points = {{16, -42}, {16, -56}, {-4, -56}, {-4, -42}}, color = {0, 0, 255}));
      connect(V1.p, uD1.n) annotation (
        Line(points = {{-86, 14}, {-86, 46}, {6, 46}, {6, 40}, {-4, 40}, {-4, 36}}, color = {0, 0, 255}));
      connect(uD1.p, dSW1.p) annotation (
        Line(points = {{-4, 16}, {-4, 8}, {6, 8}, {6, -22}, {16, -22}}, color = {0, 0, 255}));
      connect(Load.n, dSW1.p) annotation (
        Line(points = {{84, -32}, {84, -38}, {68, -38}, {68, -12}, {16, -12}, {16, -22}}, color = {0, 0, 255}));
      connect(V1.n, dD.p) annotation (
        Line(points = {{-86, -6}, {-86, -56}, {-66, -56}, {-66, -42}}, color = {0, 0, 255}));
      connect(V1.n, dD1.p) annotation (
        Line(points = {{-86, -6}, {-86, -56}, {-4, -56}, {-4, -42}}, color = {0, 0, 255}));
      connect(powerSensor.pv, powerSensor.nc) annotation (
        Line(points = {{72, 44}, {82, 44}, {82, 34}}, color = {0, 0, 255}));
      connect(powerSensor.nc, inductor.p) annotation (
        Line(points = {{66, 20}, {84, 20}, {84, 14}}, color = {0, 0, 255}));
      connect(powerSensor.pc, dSW.p) annotation (
        Line(points = {{46, 20}, {46, 6}, {-56, 6}, {-56, -22}, {-46, -22}}, color = {0, 0, 255}));
      connect(powerSensor.nv, dSW1.p) annotation (
        Line(points = {{56, 10}, {56, -12}, {16, -12}, {16, -22}}, color = {0, 0, 255}));
      connect(meanP.u, powerSensor.power) annotation (
        Line(points = {{48, -32}, {48, -12}, {48, 9}, {46, 9}}, color = {0, 0, 127}));
      connect(basePulse.y, uSW.fire) annotation (
        Line(points = {{75, 44}, {-34, 44}, {-34, 16}}, color = {255, 0, 255}));
      connect(ground.p, dD.p) annotation (
        Line(points = {{-86, -60}, {-86, -56}, {-66, -56}, {-66, -42}}, color = {0, 0, 255}));
      connect(nor1.y, dSW.fire) annotation (
        Line(points = {{-34, -18.8}, {-34, -42}}, color = {255, 0, 255}));
      connect(nor1.u, uSW.fire) annotation (
        Line(points = {{-34, -8.4}, {-34, 16}}, color = {255, 0, 255}));
      connect(delPulse.y, uSW1.fire) annotation (
        Line(points = {{37, 62}, {28, 62}, {28, 16}}, color = {255, 0, 255}));
      connect(uSW1.fire, nor2.u) annotation (
        Line(points = {{28, 16}, {28, -0.4}}, color = {255, 0, 255}));
      connect(nor2.y, dSW1.fire) annotation (
        Line(points = {{28, -10.8}, {28, -42}}, color = {255, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
        experiment(StopTime = 0.04),
        Documentation(info = "<html>
<p>Questo inverter ad onda quadra ha la logica &quot;voltage cancellation&quot; di Mohan alla pag. 219.</p>
<p><br>Il tempo di cancellazione &egrave; mezzo periodo meno il ritardo di delPulse. Se ad es. il ritardo di delPulse &egrave; 6 ms, il tempo di cancellazione &egrave; di 4 e quindi ho un rapporto pieni/vuoti di 3/2.</p>
<p>L&apos;inverter monofase VC ha importanza in quanto &egrave; uno di quelli usati nella ricarica wireless.</p>
</html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end VCRe;

    model OnePwmId "bidirectional switches, one-leg, PWM"
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {32, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {58, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser annotation (
        Placement(visible = true, transformation(origin = {-15, 46}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation (
        Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation (
        Placement(visible = true, transformation(origin = {-52, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-84, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {92, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
        Placement(visible = true, transformation(origin = {64, -28}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(origin = {104, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.PotentialSensor vSens annotation (
        Placement(visible = true, transformation(origin = {107, 9}, extent = {{-9, -9}, {9, 9}}, rotation = 90)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(origin = {-70, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor pow annotation (
        Placement(transformation(extent = {{24, -10}, {44, 10}})));
      Modelica.Blocks.Math.Mean meanP(f = 100) annotation (
        Placement(visible = true, transformation(origin = {8, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.RootMeanSquare vRMS(f = 50) annotation (
        Placement(visible = true, transformation(origin = {106, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    equation
      connect(SWu.n, SWd.p) annotation (
        Line(points = {{-52, 30}, {-52, -26}, {-50, -26}}, color = {0, 0, 255}));
      connect(SWu.p, V1.p) annotation (
        Line(points = {{-52, 50}, {-52, 60}, {-84, 60}, {-84, 30}}, color = {0, 0, 255}));
      connect(Rf.p, SWu.n) annotation (
        Line(points = {{-32, 0}, {-52, 0}, {-52, 30}}, color = {0, 0, 255}));
      connect(pwmPulser.down, SWu.control) annotation (
        Line(points = {{-29.3, 38.46}, {-40, 38.46}, {-40, 40}, {-40, 40}}, color = {255, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{47, 40}, {16, 40}, {16, 38.98}, {0.6, 38.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{21, 60}, {12, 60}, {12, 54.32}, {0.6, 54.32}}, color = {0, 0, 127}));
      connect(pwmPulser.up, SWd.control) annotation (
        Line(points = {{-29.3, 54.58}, {-36, 54.58}, {-36, -36}, {-38, -36}}, color = {255, 0, 255}));
      connect(Lf.p, Rf.n) annotation (
        Line(points = {{-4, 0}, {-10, 0}, {-12, 0}}, color = {0, 0, 255}));
      connect(ground.p, V1.n) annotation (
        Line(points = {{-70, 4}, {-70, 10}, {-84, 10}}, color = {0, 0, 255}));
      connect(vSens.p, Load.p) annotation (
        Line(points = {{107, 1.77636e-015}, {92, 1.77636e-015}, {92, -14}}, color = {0, 0, 255}));
      connect(V1.n, V2.p) annotation (
        Line(points = {{-84, 10}, {-84, -14}, {-84, -14}}, color = {0, 0, 255}));
      connect(Load.n, Cf.n) annotation (
        Line(points = {{92, -34}, {92, -50}, {64, -50}, {64, -38}}, color = {0, 0, 255}));
      connect(SWd.n, V2.n) annotation (
        Line(points = {{-50, -46}, {-50, -56}, {-84, -56}, {-84, -34}}, color = {0, 0, 255}));
      connect(Lf.n, pow.pc) annotation (
        Line(points = {{16, 0}, {24, 0}}, color = {0, 0, 255}));
      connect(pow.pv, pow.pc) annotation (
        Line(points = {{34, 10}, {30, 10}, {24, 10}, {24, 0}}, color = {0, 0, 255}));
      connect(pow.nv, Cf.n) annotation (
        Line(points = {{34, -10}, {34, -50}, {64, -50}, {64, -38}}, color = {0, 0, 255}));
      connect(pow.nc, Load.p) annotation (
        Line(points = {{44, 0}, {92, 0}, {92, -14}}, color = {0, 0, 255}));
      connect(Cf.p, Load.p) annotation (
        Line(points = {{64, -18}, {64, 0}, {92, 0}, {92, -14}}, color = {0, 0, 255}));
      connect(ground1.p, Cf.n) annotation (
        Line(points = {{104, -42}, {92, -42}, {92, -50}, {64, -50}, {64, -38}}, color = {0, 0, 255}));
      connect(meanP.u, pow.power) annotation (
        Line(points = {{8, -24}, {8, -24}, {8, -16}, {24, -16}, {24, -11}}, color = {0, 0, 127}));
      connect(vRMS.u, vSens.phi) annotation (
        Line(points = {{106, 30}, {106, 24}, {108, 24}, {108, 18}}, color = {0, 0, 127}));
      annotation (
        experiment(StopTime = 0.1),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false)),
        Icon(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false)));
    end OnePwmId;

    model TwoPwmId "Id switches - TwoLegs"
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {109, 59}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {87, 45}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Support.PwmPulser pwmPulser annotation (
        Placement(visible = true, transformation(origin = {49, 52}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation (
        Placement(visible = true, transformation(origin = {-72, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation (
        Placement(visible = true, transformation(origin = {-72, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 25) annotation (
        Placement(visible = true, transformation(origin = {-100, -24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {82, -4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
        Placement(visible = true, transformation(origin = {60, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 25) annotation (
        Placement(visible = true, transformation(origin = {-100, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(origin = {-116, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {12, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu1 annotation (
        Placement(visible = true, transformation(origin = {-42, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu2 annotation (
        Placement(visible = true, transformation(origin = {-42, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanExpression ul(y = pwmPulser.up) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-62, 66})));
      Modelica.Blocks.Sources.BooleanExpression ur(y = pwmPulser.down) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-34, 64})));
      Modelica.Blocks.Sources.BooleanExpression dl(y = pwmPulser.down) annotation (
        Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-64, -66})));
      Modelica.Blocks.Sources.BooleanExpression dr(y = pwmPulser.up) annotation (
        Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-32, -64})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor vInv annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-58, 4})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor vLoad annotation (
        Placement(visible = true, transformation(origin = {108, -2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sensors.PowerSensor pow annotation (
        Placement(transformation(extent = {{-26, 14}, {-6, 34}})));
      Modelica.Blocks.Math.Mean meanP(f = 100) annotation (
        Placement(visible = true, transformation(origin = {20, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.RootMeanSquare vRMS(f = 50) annotation (
        Placement(visible = true, transformation(origin = {128, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    equation
      connect(vLoad.n, Load.n) annotation (
        Line(points = {{108, -12}, {108, -12}, {108, -30}, {82, -30}, {82, -14}}, color = {0, 0, 255}));
      connect(vLoad.p, Lf.n) annotation (
        Line(points = {{108, 8}, {108, 8}, {108, 20}, {50, 20}}, color = {0, 0, 255}));
      connect(Lf.p, Rf.n) annotation (
        Line(points = {{30, 20}, {24, 20}, {22, 20}}, color = {0, 0, 255}));
      connect(Load.p, Lf.n) annotation (
        Line(points = {{82, 6}, {82, 20}, {50, 20}}, color = {0, 0, 255}));
      connect(Cf.p, Lf.n) annotation (
        Line(points = {{60, 2}, {60, 20}, {50, 20}}, color = {0, 0, 255}));
      connect(ground.p, V1.n) annotation (
        Line(points = {{-116, -8}, {-116, -4}, {-116, 0}, {-100, 0}, {-100, 10}}, color = {0, 0, 255}));
      connect(SWu.p, V1.p) annotation (
        Line(points = {{-72, 52}, {-72, 60}, {-100, 60}, {-100, 30}}, color = {0, 0, 255}));
      connect(V1.n, V2.p) annotation (
        Line(points = {{-100, 10}, {-100, 4}, {-100, -14}}, color = {0, 0, 255}));
      connect(Load.n, Cf.n) annotation (
        Line(points = {{82, -14}, {82, -30}, {60, -30}, {60, -18}}, color = {0, 0, 255}));
      connect(SWd.n, V2.n) annotation (
        Line(points = {{-72, -42}, {-72, -50}, {-100, -50}, {-100, -34}}, color = {0, 0, 255}));
      connect(SWu.n, SWd.p) annotation (
        Line(points = {{-72, 32}, {-72, -22}}, color = {0, 0, 255}));
      connect(SWu1.p, V1.p) annotation (
        Line(points = {{-42, 52}, {-42, 60}, {-100, 60}, {-100, 30}}, color = {0, 0, 255}));
      connect(SWu1.n, SWu2.p) annotation (
        Line(points = {{-42, 32}, {-42, -22}}, color = {0, 0, 255}));
      connect(SWu2.n, V2.n) annotation (
        Line(points = {{-42, -42}, {-42, -50}, {-100, -50}, {-100, -34}}, color = {0, 0, 255}));
      connect(Cf.n, SWu2.p) annotation (
        Line(points = {{60, -18}, {60, -30}, {0, -30}, {0, -14}, {-42, -14}, {-42, -22}}, color = {0, 0, 255}));
      connect(SWu.control, ul.y) annotation (
        Line(points = {{-60, 42}, {-62, 42}, {-62, 55}}, color = {255, 0, 255}));
      connect(SWu1.control, ur.y) annotation (
        Line(points = {{-30, 42}, {-34, 42}, {-34, 53}}, color = {255, 0, 255}));
      connect(dl.y, SWd.control) annotation (
        Line(points = {{-64, -55}, {-63, -55}, {-63, -32}, {-60, -32}}, color = {255, 0, 255}));
      connect(dr.y, SWu2.control) annotation (
        Line(points = {{-32, -53}, {-30, -53}, {-30, -32}}, color = {255, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{79.3, 45}, {73.65, 45}, {73.65, 44.98}, {64.6, 44.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{101.3, 59}, {85.65, 59}, {85.65, 60.32}, {64.6, 60.32}}, color = {0, 0, 127}));
      connect(vInv.p, SWd.p) annotation (
        Line(points = {{-68, 4}, {-72, 4}, {-72, -22}}, color = {0, 0, 255}));
      connect(vInv.n, SWu2.p) annotation (
        Line(points = {{-48, 4}, {-42, 4}, {-42, -22}}, color = {0, 0, 255}));
      connect(pow.nv, SWu2.p) annotation (
        Line(points = {{-16, 14}, {-16, -14}, {-42, -14}, {-42, -22}}, color = {0, 0, 255}));
      connect(pow.pv, pow.pc) annotation (
        Line(points = {{-16, 34}, {-26, 34}, {-26, 24}}, color = {0, 0, 255}));
      connect(Rf.p, pow.nc) annotation (
        Line(points = {{2, 20}, {-4, 20}, {-4, 24}, {-6, 24}}, color = {0, 0, 255}));
      connect(pow.pc, SWd.p) annotation (
        Line(points = {{-26, 24}, {-52, 24}, {-72, 24}, {-72, -22}}, color = {0, 0, 255}));
      connect(meanP.u, pow.power) annotation (
        Line(points = {{20, 0}, {20, 4}, {-26, 4}, {-26, 13}}, color = {0, 0, 127}));
      connect(vRMS.u, vLoad.v) annotation (
        Line(points = {{128, -18}, {128, -18}, {128, -2}, {120, -2}, {120, -2}}, color = {0, 0, 127}));
      annotation (
        experiment(StopTime = 0.1),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p>Il risultato è identico a quello che si ha con interruttori pilotati e diodi in antiparallelo entrambi ideali.</p>
<p>Questo perché con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sistema più fisico è superiore perché consente di valutare anche gli effetti del blanking time.</p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-120, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(lineColor = {255, 0, 0}, extent = {{14, -52}, {78, -70}}, textString = "Es. proposto: TwoSQW")}),
        Icon(coordinateSystem(extent = {{-120, -80}, {140, 80}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end TwoPwmId;

    model TwoPwmRe "Switch-diode pairs, two-legs, square wave"
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 225.0) annotation (
        Placement(visible = true, transformation(origin = {-102, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-80, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-64, 36})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-64, -22})));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-80, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-34, 36})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-14, 36})));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-14, -22})));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD1(Vknee = 0.1) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-34, -22})));
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {111, 53}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {89, 39}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Support.PwmPulser pwmPulser annotation (
        Placement(visible = true, transformation(origin = {51, 46}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Blocks.Sources.BooleanExpression ul(y = pwmPulser.up) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-50, 44})));
      Modelica.Blocks.Sources.BooleanExpression ur(y = pwmPulser.down) annotation (
        Placement(visible = true, transformation(origin = {0, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.BooleanExpression dl(y = pwmPulser.down) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-48, -8})));
      Modelica.Blocks.Sources.BooleanExpression dr(y = pwmPulser.up) annotation (
        Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {2, -46})));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {88, -4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
        Placement(visible = true, transformation(origin = {66, -8}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(visible = true, transformation(origin = {52, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {24, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor vLoad annotation (
        Placement(visible = true, transformation(origin = {112, -2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(origin = {66, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.RootMeanSquare vRMS(f = 50) annotation (
        Placement(visible = true, transformation(origin = {128, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    equation
      connect(V1.n, dD1.p) annotation (
        Line(points = {{-102, -2}, {-102, -46}, {-34, -46}, {-34, -32}}, color = {0, 0, 255}));
      connect(V1.n, dD.p) annotation (
        Line(points = {{-102, -2}, {-102, -46}, {-80, -46}, {-80, -32}}, color = {0, 0, 255}));
      connect(V1.p, uD1.n) annotation (
        Line(points = {{-102, 18}, {-102, 56}, {-24, 56}, {-24, 50}, {-34, 50}, {-34, 46}}, color = {0, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-102, 18}, {-102, 56}, {-74, 56}, {-74, 50}, {-80, 50}, {-80, 46}}, color = {0, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-64, -32}, {-64, -46}, {-80, -46}, {-80, -32}}, color = {0, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-80, -12}, {-64, -12}}, color = {0, 0, 255}));
      connect(uD.p, dSW.p) annotation (
        Line(points = {{-80, 26}, {-80, 18}, {-74, 18}, {-74, -12}, {-64, -12}}, color = {0, 0, 255}));
      connect(uD.p, uSW.n) annotation (
        Line(points = {{-80, 26}, {-80, 18}, {-64, 18}, {-64, 26}}, color = {0, 0, 255}));
      connect(uSW.p, uD.n) annotation (
        Line(points = {{-64, 46}, {-64, 50}, {-80, 50}, {-80, 46}}, color = {0, 0, 255}));
      connect(ur.y, uSW1.fire) annotation (
        Line(points = {{0, 37}, {0, 26}, {-2, 26}}, color = {255, 0, 255}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{103.3, 53}, {99.3875, 53}, {99.3875, 53}, {99.475, 53}, {99.475, 53}, {87.65, 53}, {87.65, 54.32}, {77.125, 54.32}, {77.125, 54.32}, {66.6, 54.32}}, color = {0, 0, 127}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{81.3, 39}, {78.475, 39}, {78.475, 39}, {75.65, 39}, {75.65, 38.98}, {66.6, 38.98}}, color = {0, 0, 127}));
      connect(uSW1.p, uD1.n) annotation (
        Line(points = {{-14, 46}, {-14, 50}, {-34, 50}, {-34, 46}}, color = {0, 0, 255}));
      connect(uD1.p, uSW1.n) annotation (
        Line(points = {{-34, 26}, {-34, 18}, {-14, 18}, {-14, 26}}, color = {0, 0, 255}));
      connect(dD1.n, dSW1.p) annotation (
        Line(points = {{-34, -12}, {-14, -12}}, color = {0, 0, 255}));
      connect(dSW1.n, dD1.p) annotation (
        Line(points = {{-14, -32}, {-14, -46}, {-34, -46}, {-34, -32}}, color = {0, 0, 255}));
      connect(uD1.p, dSW1.p) annotation (
        Line(points = {{-34, 26}, {-34, 18}, {-24, 18}, {-24, -12}, {-14, -12}}, color = {0, 0, 255}));
      connect(ul.y, uSW.fire) annotation (
        Line(points = {{-50, 33}, {-50, 26}, {-52, 26}}, color = {255, 0, 255}));
      connect(dr.y, dSW1.fire) annotation (
        Line(points = {{2, -35}, {2, -32}, {-2, -32}}, color = {255, 0, 255}));
      connect(dl.y, dSW.fire) annotation (
        Line(points = {{-48, -19}, {-48, -32}, {-52, -32}}, color = {255, 0, 255}));
      connect(vLoad.n, Load.n) annotation (
        Line(points = {{112, -12}, {112, -30}, {88, -30}, {88, -14}}, color = {0, 0, 255}));
      connect(vLoad.p, Lf.n) annotation (
        Line(points = {{112, 8}, {112, 20}, {62, 20}}, color = {0, 0, 255}));
      connect(Lf.p, Rf.n) annotation (
        Line(points = {{42, 20}, {34, 20}}, color = {0, 0, 255}));
      connect(Load.p, Lf.n) annotation (
        Line(points = {{88, 6}, {88, 20}, {62, 20}}, color = {0, 0, 255}));
      connect(Cf.p, Lf.n) annotation (
        Line(points = {{66, 2}, {66, 20}, {62, 20}}, color = {0, 0, 255}));
      connect(Rf.p, dSW.p) annotation (
        Line(points = {{14, 20}, {6, 20}, {6, 10}, {-74, 10}, {-74, -12}, {-64, -12}}, color = {0, 0, 255}));
      connect(Cf.n, dSW1.p) annotation (
        Line(points = {{66, -18}, {6, -18}, {6, 2}, {-24, 2}, {-24, -12}, {-14, -12}}, color = {0, 0, 255}));
      connect(Cf.n, Load.n) annotation (
        Line(points = {{66, -18}, {66, -30}, {88, -30}, {88, -14}}, color = {0, 0, 255}));
      connect(ground.p, Load.n) annotation (
        Line(points = {{66, -38}, {66, -30}, {88, -30}, {88, -14}}, color = {0, 0, 255}));
      connect(vRMS.u, vLoad.v) annotation (
        Line(points = {{128, -28}, {128, -28}, {128, -2}, {124, -2}, {124, -2}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -60}, {140, 80}}, initialScale = 0.1)),
        experiment(StopTime = 0.08, StartTime = 0, Tolerance = 1e-06, Interval = 8e-06),
        Documentation(info = "<html>
<p>Notare che per avere adeguata precisione occorre scegliere un numero di step corretto.</p>
<p>Se ad es. si lasciano 500 step, l&apos;algoritmo in realt&agrave; ne metter&agrave; di pi&ugrave; in quanto vi sono molti eventi di swithing, ma insufficienti ad una buona precisione.</p>
<p>Ad es. la prima armonica della tensione di uscita dell&apos;innerter &egrave; attesa essere pari a 225x0.7=157.5.</p>
<p>Se si lasciano i 500 step il valore che si misura &egrave; invece pari a 176.3 (picco della prima armonica). Se per&ograve; si selezionano 5000 step il valore viene estremamente prossimo a quello atteso.</p>
</html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-120, -60}, {140, 80}}, preserveAspectRatio = false)));
    end TwoPwmRe;

    model OnePwmNet "Real valves, one leg P-Q measure"
      Modelica.Electrical.Analog.Sources.SineVoltage E(V = 40, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {90, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      InvPWM.Support.QMonoSensor Q annotation (Placement(visible=true,
            transformation(extent={{62,6},{78,22}}, rotation=0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor P annotation (
        Placement(visible = true, transformation(extent = {{38, 6}, {54, 22}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-60, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-40, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-66, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-48, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.Constant ampl(k = 0.9) annotation (
        Placement(visible = true, transformation(origin = {69, 43}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = +10) annotation (
        Placement(visible = true, transformation(origin = {49, 57}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
      InvPWM.Support.PwmPulser pwmPulser annotation (Placement(visible=true,
            transformation(
            origin={17,50},
            extent={{-13,-12},{13,12}},
            rotation=180)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(extent = {{2, -44}, {22, -24}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-84, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{-84, -2}, {-64, 18}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
        Placement(visible = true, transformation(origin = {30, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(visible = true, transformation(extent = {{-6, 4}, {14, 24}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation (
        Placement(visible = true, transformation(extent = {{-42, 4}, {-22, 24}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-84, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Math.Mean meanQ(f = 50) annotation (
        Placement(visible = true, transformation(origin = {74, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Mean meanP(f = 50) annotation (
        Placement(visible = true, transformation(origin = {40, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(uD.n, uSW.p) annotation (
        Line(points = {{-66, 72}, {-66, 78}, {-48, 78}, {-48, 72}}, color = {0, 0, 255}));
      connect(uSW.n, uD.p) annotation (
        Line(points = {{-48, 52}, {-48, 44}, {-66, 44}, {-66, 52}}, color = {0, 0, 255}));
      connect(uSW.fire, pwmPulser.up) annotation (
        Line(points = {{-36, 52}, {-20, 52}, {-20, 42.08}, {2.7, 42.08}}, color = {255, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-40, -34}, {-40, -48}, {-60, -48}, {-60, -34}}, color = {0, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-60, -14}, {-60, -8}, {-40, -8}, {-40, -14}}, color = {0, 0, 255}));
      connect(pwmPulser.down, dSW.fire) annotation (
        Line(points = {{2.7, 56.96}, {-12.3, 56.96}, {-12.3, -30.04}, {-28.3, -30.04}, {-28.3, -34.04}}, color = {255, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-84, 44}, {-84, 78}, {-66, 78}, {-66, 72}}, color = {0, 0, 255}));
      connect(V1.n, V2.p) annotation (
        Line(points = {{-84, 24}, {-84, 0}, {-84, 0}}, color = {0, 0, 255}));
      connect(ground.p, V1.n) annotation (
        Line(points = {{-74, 18}, {-74, 24}, {-84, 24}}, color = {0, 0, 255}));
      connect(Rf.p, dD.n) annotation (
        Line(points = {{-42, 14}, {-60, 14}, {-60, -14}}, color = {0, 0, 255}));
      connect(Lf.p, Rf.n) annotation (
        Line(points = {{-6, 14}, {-22, 14}}, color = {0, 0, 255}));
      connect(P.pc, Lf.n) annotation (
        Line(points = {{38, 14}, {14, 14}}, color = {0, 0, 255}));
      connect(P.nv, Cf.n) annotation (
        Line(points = {{46, 6}, {46, -16}, {30, -16}}, color = {0, 0, 255}));
      connect(E.n, Cf.n) annotation (
        Line(points = {{90, -16}, {30, -16}}, color = {0, 0, 255}));
      connect(Cf.p, P.pc) annotation (
        Line(points = {{30, 4}, {30, 14}, {38, 14}}, color = {0, 0, 255}));
      connect(ground1.p, Cf.n) annotation (
        Line(points = {{12, -24}, {12, -24}, {12, -16}, {30, -16}}, color = {0, 0, 255}));
      connect(V2.n, dD.p) annotation (
        Line(points = {{-84, -20}, {-84, -48}, {-60, -48}, {-60, -34}}, color = {0, 0, 255}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{61.3, 43}, {45.65, 43}, {45.65, 42.32}, {32.6, 42.32}}, color = {0, 0, 127}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{41.3, 57}, {39.65, 57}, {39.65, 56.48}, {32.6, 56.48}}, color = {0, 0, 127}));
      connect(uD.p, dD.n) annotation (
        Line(points = {{-66, 52}, {-66, 44}, {-60, 44}, {-60, -14}}, color = {0, 0, 255}));
      connect(Q.pc, P.nc) annotation (
        Line(points = {{62, 14}, {62, 14}, {54, 14}}, color = {0, 0, 255}));
      connect(P.pv, P.nc) annotation (
        Line(points = {{46, 10}, {54, 10}, {54, 2}}, color = {0, 0, 255}));
      connect(Q.nv, E.n) annotation (
        Line(points = {{70, 6}, {70, -16}, {90, -16}}, color = {0, 0, 255}));
      connect(E.p, Q.nc) annotation (
        Line(points = {{90, 4}, {90, 14}, {78, 14}}, color = {0, 0, 255}));
      connect(Q.pv, Q.nc) annotation (
        Line(points = {{70, 10}, {78, 10}, {78, 2}}, color = {0, 0, 255}));
      connect(meanP.u, P.power) annotation (
        Line(points = {{40, -26}, {40, -26}, {40, 5.2}, {38, 5.2}}, color = {0, 0, 127}));
      connect(meanQ.u, Q.power) annotation (
        Line(points = {{74, -28}, {74, -28}, {74, -24}, {63.6, -24}, {63.6, 5.2}}, color = {0, 0, 127}));
      annotation (
        experiment(StopTime = 0.06, Interval = 5e-005),
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-100, -60}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1)),
        Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
    end OnePwmNet;

    model TwoPwmDCFilt "Id switches - TwoLegs - DC filter"
      parameter Real Udir = 0.7;
      parameter Real LDF = 1e-006;
      parameter Real Rbat = 0.1;
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {102, 58}, extent = {{-8, 8}, {8, -8}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {80, 42}, extent = {{-8, 8}, {8, -8}}, rotation = 180)));
      InvPWM.Support.PwmPulser pwmPulser annotation (Placement(visible=true,
            transformation(
            origin={41,50},
            extent={{-13,13},{13,-13}},
            rotation=180)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWd annotation (
        Placement(visible = true, transformation(origin = {-30, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu annotation (
        Placement(visible = true, transformation(origin = {-30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 2) annotation (
        Placement(visible = true, transformation(origin = {104, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
        Placement(visible = true, transformation(origin = {84, -12}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(visible = true, transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {42, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu1 annotation (
        Placement(visible = true, transformation(origin = {-4, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch SWu2 annotation (
        Placement(visible = true, transformation(origin = {-4, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Sources.BooleanExpression ul(y = pwmPulser.up) annotation (
        Placement(visible = true, transformation(origin = {-20, 66}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.BooleanExpression ur(y = pwmPulser.down) annotation (
        Placement(visible = true, transformation(origin = {4, 66}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.BooleanExpression dl(y = pwmPulser.down) annotation (
        Placement(visible = true, transformation(origin = {-22, -66}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.BooleanExpression dr(y = pwmPulser.up) annotation (
        Placement(visible = true, transformation(origin = {6, -64}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{48, -60}, {68, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage VDC(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-104, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Rbat1(R = Rbat) annotation (
        Placement(visible = true, transformation(origin = {-104, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Resistor Rbat2(R = Rbat) annotation (
        Placement(visible = true, transformation(origin = {-104, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Capacitor dcCap(C = 0.01, v(fixed = true, start = 50)) annotation (
        Placement(visible = true, transformation(origin = {-62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = LDF) annotation (
        Placement(visible = true, transformation(extent = {{-92, 48}, {-72, 68}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = LDF) annotation (
        Placement(visible = true, transformation(extent = {{-94, -72}, {-74, -52}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor iDc0 annotation (
        Placement(visible = true, transformation(extent = {{-34, 68}, {-54, 48}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor pow annotation (
        Placement(visible = true, transformation(extent = {{6, 10}, {26, 30}}, rotation = 0)));
      Modelica.Blocks.Math.Mean meanP(f = 100) annotation (
        Placement(visible = true, transformation(origin = {44, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{71.2, 42}, {65.65, 42}, {65.65, 42.98}, {56.6, 42.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{93.2, 58}, {77.65, 58}, {77.65, 58.32}, {56.6, 58.32}}, color = {0, 0, 127}));
      connect(Lf.p, Rf.n) annotation (
        Line(points = {{60, 20}, {60, 20}, {52, 20}}, color = {0, 0, 255}));
      connect(Load.p, Lf.n) annotation (
        Line(points = {{104, 10}, {104, 20}, {80, 20}}, color = {0, 0, 255}));
      connect(Cf.p, Lf.n) annotation (
        Line(points = {{84, -2}, {84, 20}, {80, 20}}, color = {0, 0, 255}));
      connect(Load.n, Cf.n) annotation (
        Line(points = {{104, -10}, {104, -30}, {84, -30}, {84, -22}}, color = {0, 0, 255}));
      connect(SWu.n, SWd.p) annotation (
        Line(points = {{-30, 30}, {-30, -22}}, color = {0, 0, 255}));
      connect(SWu1.n, SWu2.p) annotation (
        Line(points = {{-4, 30}, {-4, 18}, {-4, 4}, {-4, -22}}, color = {0, 0, 255}));
      connect(Cf.n, SWu2.p) annotation (
        Line(points = {{84, -22}, {84, -30}, {18, -30}, {18, -14}, {-4, -14}, {-4, -22}}, color = {0, 0, 255}));
      connect(SWu.control, ul.y) annotation (
        Line(points = {{-18, 40}, {-20, 40}, {-20, 55}}, color = {255, 0, 255}));
      connect(SWu1.control, ur.y) annotation (
        Line(points = {{8, 40}, {4, 40}, {4, 55}}, color = {255, 0, 255}));
      connect(dl.y, SWd.control) annotation (
        Line(points = {{-22, -55}, {-21, -55}, {-21, -32}, {-18, -32}}, color = {255, 0, 255}));
      connect(dr.y, SWu2.control) annotation (
        Line(points = {{6, -53}, {6, -54}, {6, -32}, {8, -32}}, color = {255, 0, 255}));
      connect(VDC.n, Rbat2.p) annotation (
        Line(points = {{-104, -12}, {-104, -28}}, color = {0, 0, 255}));
      connect(Lf1.p, Rbat1.p) annotation (
        Line(points = {{-92, 58}, {-104, 58}, {-104, 42}}, color = {0, 0, 255}));
      connect(Lf2.p, Rbat2.n) annotation (
        Line(points = {{-94, -62}, {-104, -62}, {-104, -48}}, color = {0, 0, 255}));
      connect(ground.p, SWu2.p) annotation (
        Line(points = {{58, -40}, {58, -30}, {18, -30}, {18, -14}, {-4, -14}, {-4, -22}}, color = {0, 0, 255}));
      connect(SWu.p, SWu1.p) annotation (
        Line(points = {{-30, 50}, {-4, 50}}, color = {0, 0, 255}));
      connect(Lf2.n, SWd.n) annotation (
        Line(points = {{-74, -62}, {-40, -62}, {-40, -42}, {-30, -42}}, color = {0, 0, 255}));
      connect(SWd.n, SWu2.n) annotation (
        Line(points = {{-30, -42}, {-4, -42}}, color = {0, 0, 255}));
      connect(dcCap.n, SWd.n) annotation (
        Line(points = {{-62, -10}, {-62, -62}, {-40, -62}, {-40, -42}, {-30, -42}}, color = {0, 0, 255}));
      connect(VDC.p, Rbat1.n) annotation (
        Line(points = {{-104, 8}, {-104, 22}}, color = {0, 0, 255}));
      connect(dcCap.p, Lf1.n) annotation (
        Line(points = {{-62, 10}, {-62, 58}, {-72, 58}}, color = {0, 0, 255}));
      connect(iDc0.p, SWu.p) annotation (
        Line(points = {{-34, 58}, {-32, 58}, {-32, 50}, {-30, 50}}, color = {0, 0, 255}));
      connect(iDc0.n, Lf1.n) annotation (
        Line(points = {{-54, 58}, {-64, 58}, {-72, 58}}, color = {0, 0, 255}));
      connect(Rf.p, pow.nc) annotation (
        Line(points = {{32, 20}, {26, 20}}, color = {0, 0, 255}));
      connect(pow.nv, SWu2.p) annotation (
        Line(points = {{16, 10}, {16, -14}, {-4, -14}, {-4, -22}}, color = {0, 0, 255}));
      connect(pow.pv, pow.nc) annotation (
        Line(points = {{-8, 30}, {2, 30}, {2, 20}}, color = {0, 0, 255}));
      connect(pow.pc, SWd.p) annotation (
        Line(points = {{6, 20}, {-30, 20}, {-30, -22}}, color = {0, 0, 255}));
      connect(pow.power, meanP.u) annotation (
        Line(points = {{6, 9}, {8, 9}, {8, 4}, {44, 4}, {44, 0}}, color = {0, 0, 127}));
      annotation (
        experiment(StopTime = 0.1),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-120, -80}, {120, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        Icon(coordinateSystem(extent = {{-140, -80}, {120, 80}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end TwoPwmDCFilt;
  end SinglePhase;

  package ThreePhase
    model Id3SQW "Three-phase (multiphase) with bidirectional switches"
      Modelica.SIunits.Power aronPower;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, -18}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, 26}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-92, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse[3](width = fill(50, 3), period = fill(1 / 50, 3), startTime = 1 / 50 * {-1 / 3, 0, 1 / 3}) annotation (
        Placement(visible = true, transformation(extent = {{16, 40}, {-4, 60}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not myNot[3] annotation (
        Placement(visible = true, transformation(origin = {-24, 20}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor1 annotation (
        Placement(transformation(extent = {{44, -4}, {64, 16}})));
    equation
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 36}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(ground2.p, V2.n) annotation (
        Line(points = {{-92, 0}, {-70, 0}, {-70, 16}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 16}, {-70, -8}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -28}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      connect(booleanPulse.y, upSW.control) annotation (
        Line(points = {{-5, 50}, {-30, 50}, {-30, 28}}, color = {255, 0, 255}));
      connect(myNot.u, booleanPulse.y) annotation (
        Line(points = {{-24, 25.6}, {-24, 50}, {-5, 50}}, color = {255, 0, 255}));
      connect(myNot.y, downSW.control) annotation (
        Line(points = {{-24, 15.2}, {-26, 15.2}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(aronSensor1.plug_p, Cf.plug_p) annotation (
        Line(points = {{44, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(aronSensor1.plug_n, Rload.plug_p) annotation (
        Line(points = {{64, 6}, {78, 6}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 0.0002),
        __OpenModelica_commandLineOptions = "");
    end Id3SQW;

    model Id3Pwm "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power  loadPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      Modelica.SIunits.Voltage Uac0 = Rf.plug_p.pin[1].v - Rf.plug_p.pin[2].v;
      Modelica.SIunits.Voltage Uacf = Rload.plug_p.pin[1].v - Rload.plug_p.pin[2].v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(10, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(0.7, 3)) annotation (
        Placement(visible = true, transformation(origin = {80, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, -120, 120}) annotation (
        Placement(visible = true, transformation(origin = {48, 42}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fSig = fill(50, 3), fCar = fill(1000, 3)) annotation (
        Placement(visible = true, transformation(origin = {5, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-108, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rdc(R = 1e-5) annotation (
        Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Rdc.n, V2.n) annotation (
        Line(points = {{-80, 10}, {-70, 10}, {-70, 34}}, color = {0, 0, 255}));
      connect(Rdc.p, ground2.p) annotation (
        Line(points = {{-100, 10}, {-108, 10}, {-108, 8}}, color = {0, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{37, 42}, {28, 42}, {28, 42.98}, {20.6, 42.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{69, 50}, {66, 50}, {66, 58}, {50, 58}, {50, 58.32}, {20.6, 58.32}}, color = {0, 0, 127}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{-9.3, 42.46}, {-26, 42.46}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{-9.3, 58.58}, {-20, 58.58}, {-20, 58}, {-30, 58}, {-30, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      connect(
          Cf.plug_p, Rload.plug_p) annotation (
        Line(points = {{32, 6}, {78, 6}, {78, 6}, {78, 6}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -60}, {100, 80}}, initialScale = 0.1), graphics = {Text(extent = {{-18, -22}, {-18, -22}}, textString = "text"), Text(origin = {9.125, -33.3333}, extent = {{-13.125, 1.33333}, {36.875, -8.66667}}, textString = "Valori Rdc: v. info", fontName = "Arial")}),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p>Fra Rdc=1e-3 e =1e3 cambiano radicalmente le tensioni stellate sul carico ma poco le concatenate: la componente fondamentale è la stessa</p><p>&nbsp;La sol con Udc isolato dà tensione migliore sul carico</p>
    </body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3Pwm;

    model Id3PwmOF "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power  loadPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      Modelica.SIunits.Voltage Uac0 = Rf.plug_p.pin[1].v - Rf.plug_p.pin[2].v;
      Modelica.SIunits.Voltage Uacf = Rload.plug_p.pin[1].v - Rload.plug_p.pin[2].v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(10, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(0.7, 3)) annotation (
        Placement(visible = true, transformation(origin = {80, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, -120, 120}) annotation (
        Placement(visible = true, transformation(origin = {48, 42}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fSig = fill(50, 3), fCar = fill(1000, 3)) annotation (
        Placement(visible = true, transformation(origin = {5, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-108, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor annotation (
        Placement(visible = true, transformation(origin = {54, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rdc(R = 1e-5) annotation (
        Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Rdc.n, V2.n) annotation (
        Line(points = {{-80, 10}, {-70, 10}, {-70, 34}}, color = {0, 0, 255}));
      connect(Rdc.p, ground2.p) annotation (
        Line(points = {{-100, 10}, {-108, 10}, {-108, 8}}, color = {0, 0, 255}));
      connect(aronSensor.plug_n, Rload.plug_p) annotation (
        Line(points = {{64, 6}, {78, 6}, {78, 6}, {78, 6}}, color = {0, 0, 255}));
      connect(aronSensor.plug_p, Cf.plug_p) annotation (
        Line(points = {{44, 6}, {32, 6}, {32, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{37, 42}, {28, 42}, {28, 42.98}, {20.6, 42.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{69, 50}, {66, 50}, {66, 58}, {50, 58}, {50, 58.32}, {20.6, 58.32}}, color = {0, 0, 127}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{-9.3, 42.46}, {-26, 42.46}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{-9.3, 58.58}, {-20, 58.58}, {-20, 58}, {-30, 58}, {-30, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -60}, {100, 80}}, initialScale = 0.1), graphics = {Text(extent = {{-18, -22}, {-18, -22}}, textString = "text"), Text(origin = {-2.875, -19.3333}, extent = {{-13.125, 1.33333}, {36.875, -8.66667}}, textString = "Valori Rdc: v. info", fontName = "Arial"), Text(origin = {-8.19, -31.6}, extent = {{-27.81, 1.6}, {78.19, -10.4}}, textString = "Aron non va con NF
 (toglierlo e leggere loadPower\n o metterlo a monte del condensatore)", fontName = "Arial")}),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p>Fra Rdc=1e-3 e =1e3 cambiano radicalmente le tensioni stellate sul carico ma poco le concatenate: la componente fondamentale è la stessa</p><p>&nbsp;La sol con Udc isolato dà tensione migliore sul carico</p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3PwmOF;

    model Id3PwmNet "Tri-phase multiphase lib with ideal switches"
      parameter Real ampl_ = 0.8;
      parameter Real phase_ = 10;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {68, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(ampl_, 3)) annotation (
        Placement(visible = true, transformation(origin = {89, 71}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase0[3](k = {0, -120, 120}) annotation (
        Placement(visible = true, transformation(origin = {70, 52}, extent = {{-8, 8}, {8, -8}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fSig = fill(50, 3), fCar = fill(1050, 3)) annotation (
        Placement(visible = true, transformation(origin = {5, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor annotation (
        Placement(visible = true, transformation(origin = {44, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V = fill(40, 3), freqHz = fill(50, 3)) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {68, -4})));
      Modelica.Blocks.Math.Add add[3] annotation (
        Placement(transformation(extent = {{52, 32}, {32, 52}})));
      Modelica.Blocks.Sources.Constant phaseOffs[3](k = fill(phase_, 3)) annotation (
        Placement(visible = true, transformation(origin = {85, 25}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Modelica.Electrical.Analog.Basic.Resistor Rdc(R = 1e-5) annotation (
        Placement(visible = true, transformation(origin = {-90, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-112, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Rdc.n, V2.n) annotation (
        Line(points = {{-80, 18}, {-70, 18}, {-70, 30}, {-70, 30}}, color = {0, 0, 255}));
      connect(Rdc.p, ground2.p) annotation (
        Line(points = {{-100, 18}, {-112, 18}, {-112, 8}, {-112, 8}}, color = {0, 0, 255}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{81.3, 71}, {32, 71}, {32, 58}, {26, 58}, {26, 58.32}, {20.6, 58.32}}, color = {0, 0, 127}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{-9.3, 42.46}, {-26, 42.46}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{-9.3, 58.58}, {-20, 58.58}, {-20, 58}, {-30, 58}, {-30, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 50}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 30}, {-70, -10}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -30}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(aronSensor.plug_n, sineVoltage.plug_p) annotation (
        Line(points = {{54, 6}, {68, 6}}, color = {0, 0, 255}));
      connect(sineVoltage.plug_n, star2.plug_p) annotation (
        Line(points = {{68, -14}, {68, -20}}, color = {0, 0, 255}));
      connect(add.y, pwmPulser.ph_deg) annotation (
        Line(points = {{31, 42}, {28, 42}, {28, 42.98}, {20.6, 42.98}}, color = {0, 0, 127}));
      connect(phase0.y, add.u1) annotation (
        Line(points = {{61.2, 52}, {60, 52}, {60, 48}, {54, 48}}, color = {0, 0, 127}));
      connect(phaseOffs.y, add.u2) annotation (
        Line(points = {{77.3, 25}, {69.65, 25}, {69.65, 36}, {54, 36}}, color = {0, 0, 127}));
      connect(aronSensor.plug_p, Lf.plug_n) annotation (
        Line(points = {{34, 6}, {26, 6}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -60}, {100, 80}})),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StopTime = 0.2, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3PwmNet;

    model Id3PwmMach "Tri-phase multiphase lib with ideal switches"
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {92, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-58, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-58, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-58, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-58, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl(k = 0.95) annotation (
        Placement(visible = true, transformation(origin = {49, 65}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 150) annotation (
        Placement(visible = true, transformation(origin = {-86, -20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 150) annotation (
        Placement(visible = true, transformation(origin = {-86, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-78, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant phase(k = 20) annotation (
        Placement(visible = true, transformation(origin = {51, 37}, extent = {{-7, 7}, {7, -7}}, rotation = 180)));
      Support.PwmPulser3 pwmPulser3 annotation (
        Placement(transformation(extent = {{18, 34}, {-2, 54}})));
      Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(phiMechanical(fixed = false, start = 1.570796326794897), wMechanical(fixed = false, start = 157.0796326794897)) annotation (
        Placement(transformation(extent = {{68, -14}, {48, 6}})));
      Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor annotation (
        Placement(transformation(extent = {{14, 0}, {34, 20}})));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
        Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = -90, origin = {40, -24})));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.005, 3)) annotation (
        Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed(displayUnit = "rpm") = 157.07963267949) annotation (
        Placement(transformation(extent = {{-4, -28}, {12, -12}})));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-24, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(ground2.p, V2.n) annotation (
        Line(points = {{-78, 8}, {-78, 20}, {-86, 20}, {-86, 30}}, color = {0, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-86, 50}, {-86, 70}, {-58, 70}, {-58, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-86, 30}, {-86, -10}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-86, -30}, {-86, -54}, {-58, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-58, 18}, {-58, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-58, 38}, {-58, 46}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-58, -24}, {-58, -34}}, color = {0, 0, 255}));
      connect(phase.y, pwmPulser3.ph_deg) annotation (
        Line(points = {{43.3, 37}, {31.65, 37}, {31.65, 38.6}, {20, 38.6}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser3.ampl) annotation (
        Line(points = {{41.3, 65}, {33.65, 65}, {33.65, 50.4}, {20, 50.4}}, color = {0, 0, 127}));
      connect(pwmPulser3.up, upSW.control) annotation (
        Line(points = {{-3, 50.6}, {-46, 50.6}, {-46, 28}}, color = {255, 0, 255}));
      connect(pwmPulser3.down, downSW.control) annotation (
        Line(points = {{-3, 38.2}, {-40, 38.2}, {-40, -14}, {-46, -14}}, color = {255, 0, 255}));
      connect(powerSensor.pv, powerSensor.pc) annotation (
        Line(points = {{24, 20}, {14, 20}, {14, 10}}, color = {0, 0, 255}));
      connect(powerSensor.nv, smpm.plug_sn) annotation (
        Line(points = {{24, 0}, {42, 0}, {42, 16}, {64, 16}, {64, 6}}, color = {0, 0, 255}));
      connect(angleSensor.flange, smpm.flange) annotation (
        Line(points = {{40, -14}, {40, -4}, {48, -4}}, color = {0, 0, 0}));
      connect(Lf.plug_n, powerSensor.pc) annotation (
        Line(points = {{10, 10}, {14, 10}}, color = {0, 0, 255}));
      connect(powerSensor.nc, smpm.plug_sp) annotation (
        Line(points = {{34, 10}, {52, 10}, {52, 6}}, color = {0, 0, 255}));
      connect(constantSpeed.flange, angleSensor.flange) annotation (
        Line(points = {{12, -20}, {26, -20}, {26, -14}, {40, -14}}, color = {0, 0, 0}));
      connect(smpm.plug_sn, star2.plug_p) annotation (
        Line(points = {{64, 6}, {92, 6}, {92, 0}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-34, 10}, {-58, 10}, {-58, -4}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{-14, 10}, {-10, 10}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}}, initialScale = 0.1), graphics = {Text(origin = {-12.29, -52}, extent = {{-25.71, 6}, {94.29, -6}}, textString = "Guardare valori iniziali smpm\non va bene con 1.16-dev 648 e OF")}),
        experimentSetupOutput,
        Documentation(info = "<html>
<p>Rispetto a Id2Pwm questo modello &egrave; pi&ugrave; semplice da usare in quanto utilizza un impulsatore trifase. Per&ograve; non consente l&apos;introduzione di tensioni differenti sulle tre fasi.</p>
<p>SI pu&ograve; proporre agli studenti come miglioramento del precedente.</p>
</html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StopTime = 0.4, Interval = 5e-06),
        __OpenModelica_commandLineOptions = "");
    end Id3PwmMach;

    model Id3WithFiltDC "With Ideal Switches NO OM 1.9.4-dev-490"
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {31, -59}, extent = {{9, -9}, {-9, 9}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(1, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(5e-005, 3)) annotation (
        Placement(visible = true, transformation(origin = {0, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {24, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-2, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-34, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-34, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealOpeningSwitch downSW(Ron = fill(1e-4, 3), Goff = fill(1e-4, 3)) annotation (
        Placement(visible = true, transformation(origin = {-34, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealOpeningSwitch upSW(Ron = fill(1e-4, 3), Goff = fill(1e-4, 3)) annotation (
        Placement(visible = true, transformation(origin = {-34, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(0.7, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, 64}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, 120, -120}) annotation (
        Placement(visible = true, transformation(origin = {82, 16}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fCar = fill(2000, 3)) annotation (
        Placement(visible = true, transformation(origin = {18, 48}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-90, 18}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(origin = {-112, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rbat(R = 0.2) annotation (
        Placement(visible = true, transformation(origin = {-90, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = 1e-003) annotation (
        Placement(visible = true, transformation(origin = {-72, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Capacitor dcCap(C = 5e-5, v(fixed = true, start = 100)) annotation (
        Placement(visible = true, transformation(origin = {-56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = 1e-003) annotation (
        Placement(visible = true, transformation(origin = {-72, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 0.2) annotation (
        Placement(visible = true, transformation(origin = {-90, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-90, -14}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor annotation (
        Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(dcCap.n, star1.pin_n) annotation (
        Line(points = {{-56, -10}, {-56, -70}, {-34, -70}}, color = {0, 0, 255}));
      connect(dcCap.p, Lf1.n) annotation (
        Line(points = {{-56, 10}, {-56, 68}, {-62, 68}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-34, -40}, {-34, -50}}, color = {0, 0, 255}));
      connect(Lf2.n, star1.pin_n) annotation (
        Line(points = {{-62, -70}, {-34, -70}, {-34, -70}, {-34, -70}}, color = {0, 0, 255}));
      connect(resistor1.n, Lf2.p) annotation (
        Line(points = {{-90, -62}, {-90, -62}, {-90, -70}, {-82, -70}, {-82, -70}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-34, 40}, {-34, 48}}, color = {0, 0, 255}));
      connect(star.pin_n, Lf1.n) annotation (
        Line(points = {{-34, 68}, {-62, 68}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-12, 16}, {-34, 16}, {-34, -20}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-34, 20}, {-34, -20}}, color = {0, 0, 255}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{3.7, 40.46}, {-18, 40.46}, {-18, -30}, {-27, -30}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{3.7, 56.58}, {-22, 56.58}, {-22, 30}, {-27, 30}}, color = {255, 0, 255}));
      connect(V2.n, resistor1.p) annotation (
        Line(points = {{-90, -24}, {-90, -24}, {-90, -42}, {-90, -42}, {-90, -42}}, color = {0, 0, 255}));
      connect(ground1.p, V2.p) annotation (
        Line(points = {{-112, -14}, {-112, -14}, {-112, -4}, {-90, -4}, {-90, -4}}, color = {0, 0, 255}));
      connect(V2.p, V1.n) annotation (
        Line(points = {{-90, -4}, {-90, -4}, {-90, 8}, {-90, 8}}, color = {0, 0, 255}));
      connect(Lf1.p, Rbat.p) annotation (
        Line(points = {{-82, 68}, {-90, 68}, {-90, 56}}, color = {0, 0, 255}));
      connect(V1.p, Rbat.n) annotation (
        Line(points = {{-90, 28}, {-90, 36}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{32, -36}, {32, -39}, {31, -39}, {31, -50}}, color = {0, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{71, 16}, {60, 16}, {60, 40.98}, {33.6, 40.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{67, 64}, {60, 64}, {60, 56.32}, {33.6, 56.32}}, color = {0, 0, 127}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{8, 16}, {14, 16}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Rload.plug_p) annotation (
        Line(points = {{0, -16}, {32, -16}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{0, -36}, {32, -36}}, color = {0, 0, 255}));
    connect(Lf.plug_n, aronSensor.plug_p) annotation (
        Line(points = {{34, 16}, {42, 16}, {42, 10}, {42, 10}, {42, 10}}, color = {0, 0, 255}));
    connect(aronSensor.plug_n, Rload.plug_p) annotation (
        Line(points = {{42, -10}, {42, -10}, {42, -16}, {32, -16}, {32, -16}}, color = {0, 0, 255}));
      annotation (
        experimentSetupOutput,
        Documentation(info = "<html>
    <p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
    <p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
    <p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
    </html>"),
        experiment(StopTime = 0.04, Interval = 2e-005),
        Icon(coordinateSystem(extent = {{-120, -100}, {100, 100}})),
        Diagram(coordinateSystem(extent = {{-120, -80}, {100, 80}}, preserveAspectRatio = false)),
        __OpenModelica_commandLineOptions = "");
    end Id3WithFiltDC;

    model Id3PwmAronMod "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power  loadPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      Modelica.SIunits.Voltage Uac0 = Rf.plug_p.pin[1].v - Rf.plug_p.pin[2].v;
      Modelica.SIunits.Voltage Uacf = Rload.plug_p.pin[1].v - Rload.plug_p.pin[2].v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(10, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(0.7, 3)) annotation (
        Placement(visible = true, transformation(origin = {80, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, -120, 120}) annotation (
        Placement(visible = true, transformation(origin = {48, 42}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fSig = fill(50, 3), fCar = fill(1000, 3)) annotation (
        Placement(visible = true, transformation(origin = {5, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 250) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-108, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor annotation (
        Placement(visible = true, transformation(origin = {42, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rdc(R = 1e-5) annotation (
        Placement(visible = true, transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C=fill(0.000634, 3))
        annotation (
        Placement(visible = true, transformation(origin = {58, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(Rdc.n, V2.n) annotation (
        Line(points = {{-80, 10}, {-70, 10}, {-70, 34}}, color = {0, 0, 255}));
      connect(Rdc.p, ground2.p) annotation (
        Line(points = {{-100, 10}, {-108, 10}, {-108, 8}}, color = {0, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{37, 42}, {28, 42}, {28, 42.98}, {20.6, 42.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{69, 50}, {66, 50}, {66, 58}, {50, 58}, {50, 58.32}, {20.6, 58.32}}, color = {0, 0, 127}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{-9.3, 42.46}, {-26, 42.46}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{-9.3, 58.58}, {-20, 58.58}, {-20, 58}, {-30, 58}, {-30, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(
          Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      connect(
          Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{58, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(
          Lf.plug_n, aronSensor.plug_p) annotation (
        Line(points = {{26, 6}, {32, 6}, {32, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(
          aronSensor.plug_n, Cf.plug_p) annotation (
        Line(points = {{52, 6}, {58, 6}, {58, 6}, {58, 6}}, color = {0, 0, 255}));
      connect(
          Cf.plug_p, Rload.plug_p) annotation (
        Line(points = {{58, 6}, {78, 6}, {78, 6}, {78, 6}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -60}, {100, 80}}, initialScale = 0.1), graphics = {Text(extent = {{-18, -22}, {-18, -22}}, textString = "text")}),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p>Fra Rdc=1e-3 e =1e3 cambiano radicalmente le tensioni stellate sul carico ma poco le concatenate: la componente fondamentale è la stessa</p><p>&nbsp;La sol con Udc isolato dà tensione migliore sul carico</p>
    </body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3PwmAronMod;
  end ThreePhase;

  package ThreePhaseMultifilar
    model Id3Pwm1 "Trifase con switches ideali individuali"
      parameter Modelica.SIunits.Resistance Rf = 0.125;
      parameter Modelica.SIunits.Inductance Lf = 0.001;
      parameter Modelica.SIunits.Capacitance Cf = 0.000634;
      parameter Modelica.SIunits.Resistance Rld = 30.0;
      parameter Real Goff = 1e-3;
      parameter Real Ron = 1e-3;
      Modelica.Electrical.Analog.Basic.Resistor Rld3(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {111, -57}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf3(C = Cf, v(fixed = true, start = 0)) annotation (
        Placement(visible = true, transformation(origin = {89, -58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf3(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{57, -58}, {77, -38}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf3(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{31, -58}, {51, -38}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld2(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {109, -23}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf2(C = Cf, v(fixed = true, start = 0)) annotation (
        Placement(visible = true, transformation(origin = {87, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{55, -24}, {75, -4}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf2(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{29, -24}, {49, -4}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld1(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {112, 11}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Cf1(C = Cf, v(fixed = true, start = 0)) annotation (
        Placement(visible = true, transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{58, 10}, {78, 30}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf1(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{32, 10}, {52, 30}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S2(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-6, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S4(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-46, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-66, 10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, 120, 240}) annotation (
        Placement(visible = true, transformation(origin = {89, 45}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3] annotation (
        Placement(visible = true, transformation(origin = {48, 54}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant ampl[3](k = {0.7, 0.7, 0.7}) annotation (
        Placement(visible = true, transformation(origin = {124, 62}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S5(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S1(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-46, 54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S3(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-25.5, 54.3333}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S6(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-26, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-66, 48}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(extent = {{-98, -11}, {-78, 9}}, rotation = 0)));
    equation
      connect(ground1.p, V2.n) annotation (
        Line(points = {{-88, 9}, {-88, 27}, {-66, 27}, {-66, 38}}, color = {0, 0, 255}));
      connect(V2.p, S1.p) annotation (
        Line(points = {{-66, 58}, {-66, 58}, {-66, 74}, {-46, 74}, {-46, 64}, {-46, 64}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-66, 38}, {-66, 38}, {-66, 20}, {-66, 20}}, color = {0, 0, 255}));
      connect(S3.n, S6.p) annotation (
        Line(points = {{-25.5, 44.3333}, {-25.5, 7}, {-26, 7}, {-26, -14}}, color = {0, 0, 255}));
      connect(pwmPulser[2].down, S6.control) annotation (
        Line(points = {{33.7, 46.46}, {19, 46.46}, {19, -40}, {-14, -40}, {-14, -24}}, color = {255, 0, 255}));
      connect(S6.n, S2.n) annotation (
        Line(points = {{-26, -34}, {-26, -44}, {-6, -44}, {-6, -34}}, color = {0, 0, 255}));
      connect(Rf2.p, S6.p) annotation (
        Line(points = {{29, -14}, {14, -14}, {14, 10}, {-26, 10}, {-26, -14}}, color = {0, 0, 255}));
      connect(S3.control, pwmPulser[2].up) annotation (
        Line(points = {{-13.5, 54.3333}, {-5, 54.3333}, {-5, 60}, {33.7, 60}, {33.7, 62.58}}, color = {255, 0, 255}));
      connect(S3.p, S1.p) annotation (
        Line(points = {{-25.5, 64.3333}, {-25.5, 75}, {-46, 75}, {-46, 64}}, color = {0, 0, 255}));
      connect(pwmPulser[1].up, S1.control) annotation (
        Line(points = {{33.7, 62.58}, {-34, 62.58}, {-34, 54}}, color = {255, 0, 255}));
      connect(S1.n, S4.p) annotation (
        Line(points = {{-46, 44}, {-46, -14}}, color = {0, 0, 255}));
      connect(S5.p, S1.p) annotation (
        Line(points = {{0, 62}, {0, 75}, {-46, 75}, {-46, 64}}, color = {0, 0, 255}));
      connect(S5.control, pwmPulser[3].up) annotation (
        Line(points = {{12, 52}, {25, 52}, {25, 52}, {33.7, 52}, {33.7, 62.58}}, color = {255, 0, 255}));
      connect(S5.n, S2.p) annotation (
        Line(points = {{0, 42}, {0, 16}, {-6, 16}, {-6, -14}}, color = {0, 0, 255}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{113, 62}, {63.6, 62}, {63.6, 62.32}}, color = {0, 0, 127}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{78, 45}, {67, 45}, {67, 46.98}, {63.6, 46.98}}, color = {0, 0, 127}));
      connect(pwmPulser[1].down, S4.control) annotation (
        Line(points = {{33.7, 46.46}, {19, 46.46}, {19, -40}, {-34, -40}, {-34, -24}}, color = {255, 0, 255}));
      connect(pwmPulser[3].down, S2.control) annotation (
        Line(points = {{33.7, 46.46}, {19, 46.46}, {19, -40}, {6, -40}, {6, -24}}, color = {255, 0, 255}));
      connect(V1.n, S4.n) annotation (
        Line(points = {{-66, 0}, {-66, 0}, {-66, -44}, {-46, -44}, {-46, -34}, {-46, -34}}, color = {0, 0, 255}));
      connect(Rf1.p, S4.p) annotation (
        Line(points = {{32, 20}, {32, 20}, {14, 20}, {14, 33}, {-46, 33}, {-46, -14}}, color = {0, 0, 255}));
      connect(S4.n, S2.n) annotation (
        Line(points = {{-46, -34}, {-46, -44}, {-6, -44}, {-6, -34}}, color = {0, 0, 255}));
      connect(Rf3.p, S2.p) annotation (
        Line(points = {{31, -48}, {31, -26}, {7, -26}, {7, 0}, {-6, 0}, {-6, -14}}, color = {0, 0, 255}));
      connect(Rf1.n, Lf1.p) annotation (
        Line(points = {{52, 20}, {58, 20}}, color = {0, 0, 255}));
      connect(Lf1.n, Cf1.p) annotation (
        Line(points = {{78, 20}, {90, 20}}, color = {0, 0, 255}));
      connect(Rld1.p, Cf1.p) annotation (
        Line(points = {{112, 21}, {90, 21}, {90, 20}}, color = {0, 0, 255}));
      connect(Cf1.n, Rld1.n) annotation (
        Line(points = {{90, 0}, {90, 1}, {112, 1}}, color = {0, 0, 255}));
      connect(Rld1.n, Rld2.n) annotation (
        Line(points = {{112, 1}, {134, 1}, {134, -35}, {109, -35}, {109, -33}}, color = {0, 0, 255}));
      connect(Rf2.n, Lf2.p) annotation (
        Line(points = {{49, -14}, {55, -14}}, color = {0, 0, 255}));
      connect(Lf2.n, Cf2.p) annotation (
        Line(points = {{75, -14}, {87, -14}}, color = {0, 0, 255}));
      connect(Rld2.p, Cf2.p) annotation (
        Line(points = {{109, -13}, {99, -13}, {99, -14}, {87, -14}}, color = {0, 0, 255}));
      connect(Rld2.n, Cf2.n) annotation (
        Line(points = {{109, -33}, {99, -33}, {99, -34}, {87, -34}}, color = {0, 0, 255}));
      connect(Rld3.n, Rld2.n) annotation (
        Line(points = {{111, -67}, {133, -67}, {133, -33}, {107, -33}, {107, -33}, {109, -33}}, color = {0, 0, 255}));
      connect(Rf3.n, Lf3.p) annotation (
        Line(points = {{51, -48}, {57, -48}}, color = {0, 0, 255}));
      connect(Lf3.n, Cf3.p) annotation (
        Line(points = {{77, -48}, {89, -48}}, color = {0, 0, 255}));
      connect(Rld3.p, Cf3.p) annotation (
        Line(points = {{111, -47}, {101, -47}, {101, -48}, {89, -48}}, color = {0, 0, 255}));
      connect(Rld3.n, Cf3.n) annotation (
        Line(points = {{111, -67}, {101, -67}, {101, -68}, {89, -68}}, color = {0, 0, 255}));
      annotation (
        experimentSetupOutput,
        Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001),
        Diagram(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        Icon(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
    end Id3Pwm1;

    model Id3Pwm1VarAmpl "Trifase con switches ideali individuali OM dev490 BAD"
      parameter Modelica.SIunits.Resistance Rf = 0.125;
      parameter Modelica.SIunits.Inductance Lf = 0.001;
      parameter Modelica.SIunits.Capacitance Cf = 0.000634;
      parameter Modelica.SIunits.Resistance Rld = 30.0;
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{114, -53}, {134, -33}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld3(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {87, -59}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff3(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {65, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf3(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{33, -60}, {53, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf3(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{7, -60}, {27, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld2(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {85, -25}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff2(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {63, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{31, -26}, {51, -6}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf2(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{5, -26}, {25, -6}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld1(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {88, 9}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff1(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {66, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{34, 8}, {54, 28}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf1(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{8, 8}, {28, 28}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S2 annotation (
        Placement(visible = true, transformation(origin = {-30, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S4 annotation (
        Placement(visible = true, transformation(origin = {-70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-90, 14}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, 120, 240}) annotation (
        Placement(visible = true, transformation(origin = {63, 39}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3] annotation (
        Placement(visible = true, transformation(origin = {24, 52}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S5 annotation (
        Placement(visible = true, transformation(origin = {-24, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S1 annotation (
        Placement(visible = true, transformation(origin = {-70, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S3 annotation (
        Placement(visible = true, transformation(origin = {-49.5, 52.3333}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S6 annotation (
        Placement(visible = true, transformation(origin = {-50, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp[3](height = fill(0.5, 3), offset = fill(0.5, 3), startTime = fill(0.05, 3), duration = fill(0.2, 3)) annotation (
        Placement(transformation(extent = {{112, 50}, {92, 70}})));
    equation
      connect(Rf2.p, S6.p) annotation (
        Line(points = {{5, -16}, {-10, -16}, {-10, 8}, {-50, 8}, {-50, -16}}, color = {0, 0, 255}));
      connect(S6.n, S2.n) annotation (
        Line(points = {{-50, -36}, {-50, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(pwmPulser[2].down, S6.control) annotation (
        Line(points = {{9.7, 44.46}, {-5, 44.46}, {-5, -42}, {-43, -42}, {-43, -26}}, color = {255, 0, 255}));
      connect(S3.n, S6.p) annotation (
        Line(points = {{-49.5, 42.3333}, {-49.5, 5}, {-50, 5}, {-50, -16}}, color = {0, 0, 255}));
      connect(S3.p, S1.p) annotation (
        Line(points = {{-49.5, 62.3333}, {-49.5, 73}, {-70, 73}, {-70, 62}}, color = {0, 0, 255}));
      connect(V1.p, S1.p) annotation (
        Line(points = {{-90, 24}, {-90, 74}, {-69, 74}, {-69, 73}, {-70, 73}, {-70, 62}}, color = {0, 0, 255}));
      connect(S5.p, S1.p) annotation (
        Line(points = {{-24, 60}, {-24, 73}, {-70, 73}, {-70, 62}}, color = {0, 0, 255}));
      connect(S1.n, S4.p) annotation (
        Line(points = {{-70, 42}, {-70, -16}}, color = {0, 0, 255}));
      connect(S5.n, S2.p) annotation (
        Line(points = {{-24, 40}, {-24, 14}, {-30, 14}, {-30, -16}}, color = {0, 0, 255}));
      connect(pwmPulser[3].down, S2.control) annotation (
        Line(points = {{9.7, 44.46}, {-5, 44.46}, {-5, -42}, {-23, -42}, {-23, -26}}, color = {255, 0, 255}));
      connect(pwmPulser[1].down, S4.control) annotation (
        Line(points = {{9.7, 44.46}, {-5, 44.46}, {-5, -42}, {-63, -42}, {-63, -26}}, color = {255, 0, 255}));
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{52, 39}, {43, 39}, {43, 44.98}, {39.6, 44.98}}, color = {0, 0, 127}));
      connect(V1.n, S2.n) annotation (
        Line(points = {{-90, 4}, {-90, -47}, {-69, -47}, {-69, -45}, {-70, -45}, {-70, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(S4.n, S2.n) annotation (
        Line(points = {{-70, -36}, {-70, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(Rf1.p, S4.p) annotation (
        Line(points = {{8, 18}, {8, 18}, {-10, 18}, {-10, 31}, {-70, 31}, {-70, -16}}, color = {0, 0, 255}));
      connect(Rf3.p, S2.p) annotation (
        Line(points = {{7, -50}, {7, -28}, {-17, -28}, {-17, -2}, {-30, -2}, {-30, -16}}, color = {0, 0, 255}));
      connect(Rf1.n, Lf1.p) annotation (
        Line(points = {{28, 18}, {34, 18}}, color = {0, 0, 255}));
      connect(Lf1.n, Ff1.p) annotation (
        Line(points = {{54, 18}, {66, 18}}, color = {0, 0, 255}));
      connect(Ff1.n, Rld1.n) annotation (
        Line(points = {{66, -2}, {66, -1}, {88, -1}}, color = {0, 0, 255}));
      connect(Rld1.p, Ff1.p) annotation (
        Line(points = {{88, 19}, {66, 19}, {66, 18}}, color = {0, 0, 255}));
      connect(ground.p, Rld1.n) annotation (
        Line(points = {{124, -33}, {124, -1}, {88, -1}}, color = {0, 0, 255}));
      connect(Rf2.n, Lf2.p) annotation (
        Line(points = {{25, -16}, {31, -16}}, color = {0, 0, 255}));
      connect(Lf2.n, Ff2.p) annotation (
        Line(points = {{51, -16}, {63, -16}}, color = {0, 0, 255}));
      connect(Rld2.n, Ff2.n) annotation (
        Line(points = {{85, -35}, {75, -35}, {75, -36}, {63, -36}}, color = {0, 0, 255}));
      connect(Rld2.p, Ff2.p) annotation (
        Line(points = {{85, -15}, {75, -15}, {75, -16}, {63, -16}}, color = {0, 0, 255}));
      connect(ground.p, Rld2.n) annotation (
        Line(points = {{124, -33}, {106, -33}, {106, -35}, {85, -35}}, color = {0, 0, 255}));
      connect(Rf3.n, Lf3.p) annotation (
        Line(points = {{27, -50}, {33, -50}}, color = {0, 0, 255}));
      connect(Lf3.n, Ff3.p) annotation (
        Line(points = {{53, -50}, {65, -50}}, color = {0, 0, 255}));
      connect(Rld3.n, Ff3.n) annotation (
        Line(points = {{87, -69}, {77, -69}, {77, -70}, {65, -70}}, color = {0, 0, 255}));
      connect(Rld3.p, Ff3.p) annotation (
        Line(points = {{87, -49}, {77, -49}, {77, -50}, {65, -50}}, color = {0, 0, 255}));
      connect(ground.p, Rld3.n) annotation (
        Line(points = {{124, -33}, {110, -33}, {110, -69}, {87, -69}}, color = {0, 0, 255}));
      connect(pwmPulser[1].up, S1.control) annotation (
        Line(points = {{9.7, 60.58}, {-63, 60.58}, {-63, 52}}, color = {255, 0, 255}));
      connect(S3.control, pwmPulser[2].up) annotation (
        Line(points = {{-42.5, 52.3333}, {-34, 52.3333}, {-34, 58}, {9.7, 58}, {9.7, 60.58}}, color = {255, 0, 255}));
      connect(S5.control, pwmPulser[3].up) annotation (
        Line(points = {{-17, 50}, {-4, 50}, {-4, 50}, {9.7, 50}, {9.7, 60.58}}, color = {255, 0, 255}));
      connect(ramp.y, pwmPulser.ampl) annotation (
        Line(points = {{91, 60}, {39.6, 60}, {39.6, 60.32}}, color = {0, 0, 127}));
      annotation (
        experimentSetupOutput,
        Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"),
        experiment(StopTime = 0.2, __Dymola_NumberOfIntervals = 2500),
        Diagram(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        Icon(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
    end Id3Pwm1VarAmpl;

    model Test "Trifase con switches ideali individuali"
      parameter Modelica.SIunits.Resistance Rf = 0.125;
      parameter Modelica.SIunits.Inductance Lf = 0.001;
      parameter Modelica.SIunits.Capacitance Cf = 0.000634;
      parameter Modelica.SIunits.Resistance Rld = 30.0;
      parameter Real Goff = 1e-3;
      parameter Real Ron = 1e-3;
      Modelica.Electrical.Analog.Basic.Resistor Rld3(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {111, -61}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf3(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{57, -62}, {77, -42}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld2(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {109, -27}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{55, -28}, {75, -8}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld1(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {112, 7}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = Lf, i(fixed = true)) annotation (
        Placement(visible = true, transformation(extent = {{58, 6}, {78, 26}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S2(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-6, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S4(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-46, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-66, 6}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S5(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {0, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S1(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-46, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S3(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-25.5, 50.3333}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S6(Goff = Goff, Ron = Ron) annotation (
        Placement(visible = true, transformation(origin = {-26, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-66, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(extent = {{-98, -15}, {-78, 5}}, rotation = 0)));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse[3](width = fill(50, 3), period = fill(1 / 50, 3), startTime = 1 / 50 * {-1 / 3, 0, 1 / 3}) annotation (
        Placement(visible = true, transformation(extent = {{64, 52}, {44, 72}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not myNot[3] annotation (
        Placement(visible = true, transformation(origin = {10, -14}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
    equation
      connect(ground1.p, V2.n) annotation (
        Line(points = {{-88, 5}, {-88, 23}, {-66, 23}, {-66, 34}}, color = {0, 0, 255}));
      connect(V2.p, S1.p) annotation (
        Line(points = {{-66, 54}, {-66, 70}, {-46, 70}, {-46, 60}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-66, 34}, {-66, 16}}, color = {0, 0, 255}));
      connect(S3.n, S6.p) annotation (
        Line(points = {{-25.5, 40.3333}, {-25.5, 3}, {-26, 3}, {-26, -18}}, color = {0, 0, 255}));
      connect(S6.n, S2.n) annotation (
        Line(points = {{-26, -38}, {-26, -48}, {-6, -48}, {-6, -38}}, color = {0, 0, 255}));
      connect(S3.p, S1.p) annotation (
        Line(points = {{-25.5, 60.3333}, {-25.5, 71}, {-46, 71}, {-46, 60}}, color = {0, 0, 255}));
      connect(S1.n, S4.p) annotation (
        Line(points = {{-46, 40}, {-46, -18}}, color = {0, 0, 255}));
      connect(S5.p, S1.p) annotation (
        Line(points = {{0, 58}, {0, 71}, {-46, 71}, {-46, 60}}, color = {0, 0, 255}));
      connect(S5.n, S2.p) annotation (
        Line(points = {{0, 38}, {0, 12}, {-6, 12}, {-6, -18}}, color = {0, 0, 255}));
      connect(V1.n, S4.n) annotation (
        Line(points = {{-66, -4}, {-66, -48}, {-46, -48}, {-46, -38}}, color = {0, 0, 255}));
      connect(S4.n, S2.n) annotation (
        Line(points = {{-46, -38}, {-46, -48}, {-6, -48}, {-6, -38}}, color = {0, 0, 255}));
      connect(Rld1.n, Rld2.n) annotation (
        Line(points = {{112, -3}, {134, -3}, {134, -39}, {109, -39}, {109, -37}}, color = {0, 0, 255}));
      connect(Rld3.n, Rld2.n) annotation (
        Line(points = {{111, -71}, {133, -71}, {133, -37}, {109, -37}}, color = {0, 0, 255}));
      connect(Lf1.n, Rld1.p) annotation (
        Line(points = {{78, 16}, {110, 16}, {110, 17}, {112, 17}}, color = {0, 0, 255}));
      connect(Lf2.n, Rld2.p) annotation (
        Line(points = {{75, -18}, {108, -18}, {108, -17}, {109, -17}}, color = {0, 0, 255}));
      connect(Lf3.n, Rld3.p) annotation (
        Line(points = {{77, -52}, {90, -52}, {90, -50}, {111, -50}, {111, -51}}, color = {0, 0, 255}));
      connect(Lf1.p, S1.n) annotation (
        Line(points = {{58, 16}, {32, 16}, {32, 26}, {-46, 26}, {-46, 40}}, color = {0, 0, 255}));
      connect(Lf2.p, S3.n) annotation (
        Line(points = {{55, -18}, {36, -18}, {36, 8}, {-26, 8}, {-26, 40.3333}, {-25.5, 40.3333}}, color = {0, 0, 255}));
      connect(Lf3.p, S2.p) annotation (
        Line(points = {{57, -52}, {24, -52}, {24, -4}, {-6, -4}, {-6, -18}}, color = {0, 0, 255}));
      connect(myNot[1].y, S4.control) annotation (
        Line(points = {{10, -18.8}, {-12, -18.8}, {-12, -18}, {-39, -18}, {-39, -28}}, color = {255, 0, 255}));
      connect(myNot[2].y, S6.control) annotation (
        Line(points = {{10, -18.8}, {-4, -18.8}, {-4, -20}, {-19, -20}, {-19, -28}}, color = {255, 0, 255}));
      connect(myNot[3].y, S2.control) annotation (
        Line(points = {{10, -18.8}, {10, -28}, {1, -28}}, color = {255, 0, 255}));
      connect(booleanPulse[1].y, S1.control) annotation (
        Line(points = {{43, 62}, {4, 62}, {4, 64}, {-39, 64}, {-39, 50}}, color = {255, 0, 255}));
      connect(booleanPulse[2].y, S3.control) annotation (
        Line(points = {{43, 62}, {14, 62}, {14, 60}, {-18.5, 60}, {-18.5, 50.3333}}, color = {255, 0, 255}));
      connect(booleanPulse[3].y, S5.control) annotation (
        Line(points = {{43, 62}, {7, 62}, {7, 48}}, color = {255, 0, 255}));
      connect(myNot.u, booleanPulse.y) annotation (
        Line(points = {{10, -8.4}, {12, -8.4}, {12, 32}, {36, 32}, {36, 62}, {43, 62}}, color = {255, 0, 255}));
      annotation (
        experimentSetupOutput,
        Documentation(info = "<html>
    <p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
    <p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
    <p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
    </html>"),
        experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001),
        Diagram(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        Icon(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
    end Test;
    annotation (
      Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
  end ThreePhaseMultifilar;

  package SVPWM
    import SI = Modelica.SIunits;

    model Id3Pwm1SVPWMtotal "Trifase con switches ideali individuali OM dev490 BAD"
      parameter Modelica.SIunits.Resistance Rf = 0.125;
      parameter Modelica.SIunits.Inductance Lf = 0.001;
      parameter Modelica.SIunits.Capacitance Cf = 0.000634;
      parameter Modelica.SIunits.Resistance Rld = 30.0;
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{114, -53}, {134, -33}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld3(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {87, -59}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff3(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {65, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf3(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{33, -60}, {53, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf3(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{7, -60}, {27, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld2(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {85, -25}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff2(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {63, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf2(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{31, -26}, {51, -6}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf2(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{5, -26}, {25, -6}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rld1(R = Rld) annotation (
        Placement(visible = true, transformation(origin = {88, 9}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Capacitor Ff1(C = Cf, v(start = 0)) annotation (
        Placement(visible = true, transformation(origin = {66, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Inductor Lf1(L = Lf) annotation (
        Placement(visible = true, transformation(extent = {{34, 8}, {54, 28}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rf1(R = Rf) annotation (
        Placement(visible = true, transformation(extent = {{8, 8}, {28, 28}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S2 annotation (
        Placement(visible = true, transformation(origin = {-30, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S4 annotation (
        Placement(visible = true, transformation(origin = {-70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-90, 14}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S5 annotation (
        Placement(visible = true, transformation(origin = {-24, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S1 annotation (
        Placement(visible = true, transformation(origin = {-70, 58}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S3 annotation (
        Placement(visible = true, transformation(origin = {-49.5, 58.3333}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S6 annotation (
        Placement(visible = true, transformation(origin = {-50, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {104, 68}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {114, 36}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.BooleanExpression g1(y = svpwm.gates[1]) annotation (
        Placement(transformation(extent = {{-2, 40}, {-12, 60}})));
      Modelica.Blocks.Sources.BooleanExpression g2(y = svpwm.gates[2]) annotation (
        Placement(transformation(extent = {{-4, -56}, {-16, -36}})));
      Modelica.Blocks.Sources.BooleanExpression g3(y = svpwm.gates[3]) annotation (
        Placement(transformation(extent = {{6, -9}, {-6, 9}}, rotation = -90, origin = {-36, 41})));
      Modelica.Blocks.Sources.BooleanExpression g4(y = svpwm.gates[4]) annotation (
        Placement(transformation(extent = {{-6, -9}, {6, 9}}, rotation = -90, origin = {-42, -9})));
      Modelica.Blocks.Sources.BooleanExpression g5(y = svpwm.gates[5]) annotation (
        Placement(transformation(extent = {{6, -9}, {-6, 9}}, rotation = -90, origin = {-60, 41})));
      Modelica.Blocks.Sources.BooleanExpression g6(y = svpwm.gates[6]) annotation (
        Placement(transformation(extent = {{-6, -9}, {6, 9}}, rotation = -90, origin = {-62, -1})));
      PowerSystems_Control_Modulation_SVPWM svpwm annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {30, 42})));
      Modelica.Blocks.Sources.RealExpression realExpression(y = 314.15 * time) annotation (
        Placement(transformation(extent = {{66, 56}, {46, 76}})));
    equation
      connect(Rf2.p, S6.p) annotation (
        Line(points = {{5, -16}, {-10, -16}, {-10, 8}, {-50, 8}, {-50, -16}}, color = {0, 0, 255}));
      connect(S6.n, S2.n) annotation (
        Line(points = {{-50, -36}, {-50, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(S3.n, S6.p) annotation (
        Line(points = {{-49.5, 48.3333}, {-49.5, 5}, {-50, 5}, {-50, -16}}, color = {0, 0, 255}));
      connect(S3.p, S1.p) annotation (
        Line(points = {{-49.5, 68.3333}, {-49.5, 73}, {-70, 73}, {-70, 68}}, color = {0, 0, 255}));
      connect(V1.p, S1.p) annotation (
        Line(points = {{-90, 24}, {-90, 74}, {-69, 74}, {-69, 73}, {-70, 73}, {-70, 68}}, color = {0, 0, 255}));
      connect(S5.p, S1.p) annotation (
        Line(points = {{-24, 62}, {-24, 73}, {-70, 73}, {-70, 68}}, color = {0, 0, 255}));
      connect(S1.n, S4.p) annotation (
        Line(points = {{-70, 48}, {-70, -16}}, color = {0, 0, 255}));
      connect(S5.n, S2.p) annotation (
        Line(points = {{-24, 42}, {-24, 14}, {-30, 14}, {-30, -16}}, color = {0, 0, 255}));
      connect(V1.n, S2.n) annotation (
        Line(points = {{-90, 4}, {-90, -47}, {-69, -47}, {-69, -45}, {-70, -45}, {-70, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(S4.n, S2.n) annotation (
        Line(points = {{-70, -36}, {-70, -46}, {-30, -46}, {-30, -36}}, color = {0, 0, 255}));
      connect(Rf1.p, S4.p) annotation (
        Line(points = {{8, 18}, {8, 18}, {-10, 18}, {-10, 31}, {-70, 31}, {-70, -16}}, color = {0, 0, 255}));
      connect(Rf3.p, S2.p) annotation (
        Line(points = {{7, -50}, {7, -28}, {-17, -28}, {-17, -2}, {-30, -2}, {-30, -16}}, color = {0, 0, 255}));
      connect(Rf1.n, Lf1.p) annotation (
        Line(points = {{28, 18}, {34, 18}}, color = {0, 0, 255}));
      connect(Lf1.n, Ff1.p) annotation (
        Line(points = {{54, 18}, {66, 18}}, color = {0, 0, 255}));
      connect(Ff1.n, Rld1.n) annotation (
        Line(points = {{66, -2}, {66, -1}, {88, -1}}, color = {0, 0, 255}));
      connect(Rld1.p, Ff1.p) annotation (
        Line(points = {{88, 19}, {66, 19}, {66, 18}}, color = {0, 0, 255}));
      connect(ground.p, Rld1.n) annotation (
        Line(points = {{124, -33}, {124, -1}, {88, -1}}, color = {0, 0, 255}));
      connect(Rf2.n, Lf2.p) annotation (
        Line(points = {{25, -16}, {31, -16}}, color = {0, 0, 255}));
      connect(Lf2.n, Ff2.p) annotation (
        Line(points = {{51, -16}, {63, -16}}, color = {0, 0, 255}));
      connect(Rld2.n, Ff2.n) annotation (
        Line(points = {{85, -35}, {75, -35}, {75, -36}, {63, -36}}, color = {0, 0, 255}));
      connect(Rld2.p, Ff2.p) annotation (
        Line(points = {{85, -15}, {75, -15}, {75, -16}, {63, -16}}, color = {0, 0, 255}));
      connect(ground.p, Rld2.n) annotation (
        Line(points = {{124, -33}, {106, -33}, {106, -35}, {85, -35}}, color = {0, 0, 255}));
      connect(Rf3.n, Lf3.p) annotation (
        Line(points = {{27, -50}, {33, -50}}, color = {0, 0, 255}));
      connect(Lf3.n, Ff3.p) annotation (
        Line(points = {{53, -50}, {65, -50}}, color = {0, 0, 255}));
      connect(Rld3.n, Ff3.n) annotation (
        Line(points = {{87, -69}, {77, -69}, {77, -70}, {65, -70}}, color = {0, 0, 255}));
      connect(Rld3.p, Ff3.p) annotation (
        Line(points = {{87, -49}, {77, -49}, {77, -50}, {65, -50}}, color = {0, 0, 255}));
      connect(ground.p, Rld3.n) annotation (
        Line(points = {{124, -33}, {110, -33}, {110, -69}, {87, -69}}, color = {0, 0, 255}));
      connect(S5.control, g1.y) annotation (
        Line(points = {{-12, 52}, {-14, 52}, {-14, 50}, {-12.5, 50}}, color = {255, 0, 255}));
      connect(g2.y, S2.control) annotation (
        Line(points = {{-16.6, -46}, {-18, -46}, {-18, -26}}, color = {255, 0, 255}));
      connect(g3.y, S3.control) annotation (
        Line(points = {{-36, 47.6}, {-36, 58.5}, {-37.5, 58.5}, {-37.5, 58.3333}}, color = {255, 0, 255}));
      connect(g5.y, S1.control) annotation (
        Line(points = {{-60, 47.6}, {-58, 47.6}, {-58, 58}}, color = {255, 0, 255}));
      connect(g6.y, S4.control) annotation (
        Line(points = {{-62, -7.6}, {-62, -16}, {-62, -26}, {-58, -26}}, color = {255, 0, 255}));
      connect(g4.y, S6.control) annotation (
        Line(points = {{-42, -15.6}, {-42, -20}, {-42, -26}, {-38, -26}}, color = {255, 0, 255}));
      connect(ampl.y, svpwm.vPhasor[1]) annotation (
        Line(points = {{93, 68}, {80, 68}, {80, 36}, {40.5, 36}}, color = {0, 0, 127}));
      connect(phase.y, svpwm.vPhasor[2]) annotation (
        Line(points = {{103, 36}, {39.5, 36}}, color = {0, 0, 127}));
      connect(realExpression.y, svpwm.theta) annotation (
        Line(points = {{45, 66}, {42, 66}, {42, 48}, {40, 48}}, color = {0, 0, 127}));
      annotation (
        experimentSetupOutput,
        Documentation(info = "<html>
<p>Inverter SV-PWM  realizzato utilizzando il blocco SV_PWM della libreria Power Systems.</p>
<p>Il modello richiede quindi Power Systems.</p>
</html>"),
        experiment(StopTime = 0.2, __Dymola_NumberOfIntervals = 2500),
        Diagram(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(extent = {{-34, -52}, {-28, -56}}, lineColor = {28, 108, 200}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, textString = "a"), Text(extent = {{-52, -52}, {-46, -56}}, lineColor = {28, 108, 200}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, textString = "b"), Text(extent = {{-72, -52}, {-66, -56}}, lineColor = {28, 108, 200}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, textString = "c")}),
        Icon(coordinateSystem(extent = {{-100, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
    end Id3Pwm1SVPWMtotal;

    model Id3Pwm3SVPWMTotal "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power aronPower;
      Real unFiltered1 = Rf.plug_p.pin[1].v - star2.pin_n.v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      AronSensor aronSensor annotation (
        Placement(visible = true, transformation(extent = {{46, -4}, {66, 16}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerSystems_Control_Modulation_SVPWM svpwm annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-4, 54})));
      Modelica.Blocks.Sources.RealExpression realExpression(y = 314.15 * time) annotation (
        Placement(transformation(extent = {{36, 56}, {16, 76}})));
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {74, 68}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {84, 36}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.BooleanExpression g1[3](y = {svpwm.gates[1], svpwm.gates[3], svpwm.gates[5]}) annotation (
        Placement(transformation(extent = {{-4, 18}, {-24, 38}})));
      Modelica.Blocks.Sources.BooleanExpression g2[3](y = {svpwm.gates[2], svpwm.gates[4], svpwm.gates[6]}) annotation (
        Placement(transformation(extent = {{-4, -26}, {-24, -6}})));
    equation
      connect(ground2.p, V2.n) annotation (
        Line(points = {{-92, 8}, {-70, 8}, {-70, 34}}, color = {0, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(aronSensor.n, Rload.plug_p) annotation (
        Line(points = {{66, 6}, {69, 6}, {72, 6}, {78, 6}}, color = {0, 0, 255}));
      connect(aronSensor.p, Cf.plug_p) annotation (
        Line(points = {{46, 6}, {39, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -6}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -6}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -26}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      connect(realExpression.y, svpwm.theta) annotation (
        Line(points = {{15, 66}, {12, 66}, {12, 60}, {6, 60}}, color = {0, 0, 127}));
      connect(phase.y, svpwm.vPhasor[2]) annotation (
        Line(points = {{73, 36}, {42, 36}, {42, 48}, {5.5, 48}}, color = {0, 0, 127}));
      connect(ampl.y, svpwm.vPhasor[1]) annotation (
        Line(points = {{63, 68}, {36, 68}, {36, 48}, {6.5, 48}}, color = {0, 0, 127}));
      connect(g1.y, upSW.control) annotation (
        Line(points = {{-25, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(g2.y, downSW.control) annotation (
        Line(points = {{-25, -16}, {-30, -16}}, color = {255, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StopTime = 0, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3Pwm3SVPWMTotal;

    model Id3Pwm3 "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power aronPower;
      Real unFiltered1 = Rf.plug_p.pin[1].v - star2.pin_n.v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant ampl[3](k = fill(0.7, 3)) annotation (
        Placement(visible = true, transformation(origin = {80, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase[3](k = {0, -120, 120}) annotation (
        Placement(visible = true, transformation(origin = {48, 42}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Support.PwmPulser pwmPulser[3](fMod = fill(50, 3), fCar = fill(1000, 3)) annotation (
        Placement(visible = true, transformation(origin = {5, 50}, extent = {{-13, 13}, {13, -13}}, rotation = 180)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      AronSensor aronSensor annotation (
        Placement(visible = true, transformation(extent = {{46, -4}, {66, 16}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(phase.y, pwmPulser.ph_deg) annotation (
        Line(points = {{37, 42}, {28, 42}, {28, 42.98}, {20.6, 42.98}}, color = {0, 0, 127}));
      connect(ampl.y, pwmPulser.ampl) annotation (
        Line(points = {{69, 50}, {66, 50}, {66, 58}, {50, 58}, {50, 58.32}, {20.6, 58.32}}, color = {0, 0, 127}));
      connect(pwmPulser.down, downSW.control) annotation (
        Line(points = {{-9.3, 42.46}, {-26, 42.46}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
      connect(pwmPulser.up, upSW.control) annotation (
        Line(points = {{-9.3, 58.58}, {-20, 58.58}, {-20, 58}, {-30, 58}, {-30, 28}, {-30, 28}}, color = {255, 0, 255}));
      connect(ground2.p, V2.n) annotation (
        Line(points = {{-92, 8}, {-70, 8}, {-70, 34}}, color = {0, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(aronSensor.n, Rload.plug_p) annotation (
        Line(points = {{66, 6}, {69, 6}, {72, 6}, {78, 6}}, color = {0, 0, 255}));
      connect(aronSensor.p, Cf.plug_p) annotation (
        Line(points = {{46, 6}, {39, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StopTime = 0.2, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3Pwm3;

    model Id3Pwm3SVPWM_PS "Tri-phase multiphase lib with ideal switches"
      Modelica.SIunits.Power aronPower;
      Real unFiltered1 = Rf.plug_p.pin[1].v - star2.pin_n.v;
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation (
        Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation (
        Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation (
        Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation (
        Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star1 annotation (
        Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation (
        Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      AronSensor aronSensor annotation (
        Placement(visible = true, transformation(extent = {{46, -4}, {66, 16}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
        Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
        Placement(visible = true, transformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PowerSystems.Control.Modulation.SVPWM svpwm annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-4, 54})));
      Modelica.Blocks.Sources.RealExpression realExpression(y = 314.15 * time) annotation (
        Placement(transformation(extent = {{36, 56}, {16, 76}})));
      Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation (
        Placement(visible = true, transformation(origin = {74, 68}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant phase(k = 0) annotation (
        Placement(visible = true, transformation(origin = {84, 36}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
      Modelica.Blocks.Sources.BooleanExpression g1[3](y = {svpwm.gates[1], svpwm.gates[3], svpwm.gates[5]}) annotation (
        Placement(transformation(extent = {{-4, 18}, {-24, 38}})));
      Modelica.Blocks.Sources.BooleanExpression g2[3](y = {svpwm.gates[2], svpwm.gates[4], svpwm.gates[6]}) annotation (
        Placement(transformation(extent = {{-4, -26}, {-24, -6}})));
    equation
      connect(ground2.p, V2.n) annotation (
        Line(points = {{-92, 8}, {-70, 8}, {-70, 34}}, color = {0, 0, 255}));
      connect(V2.p, star.pin_n) annotation (
        Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
      connect(V2.n, V1.p) annotation (
        Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
      connect(aronSensor.n, Rload.plug_p) annotation (
        Line(points = {{66, 6}, {69, 6}, {72, 6}, {78, 6}}, color = {0, 0, 255}));
      connect(aronSensor.p, Cf.plug_p) annotation (
        Line(points = {{46, 6}, {39, 6}, {32, 6}}, color = {0, 0, 255}));
      connect(V1.n, star1.pin_n) annotation (
        Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
      connect(upSW.plug_n, downSW.plug_p) annotation (
        Line(points = {{-42, 18}, {-42, -6}}, color = {0, 0, 255}));
      connect(upSW.plug_p, star.plug_p) annotation (
        Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
      connect(Rf.plug_p, downSW.plug_p) annotation (
        Line(points = {{-18, 6}, {-42, 6}, {-42, -6}}, color = {0, 0, 255}));
      connect(downSW.plug_n, star1.plug_p) annotation (
        Line(points = {{-42, -26}, {-42, -34}}, color = {0, 0, 255}));
      connect(Rf.plug_n, Lf.plug_p) annotation (
        Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_p, Lf.plug_n) annotation (
        Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
      connect(Cf.plug_n, Rload.plug_n) annotation (
        Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
      connect(Rload.plug_n, star2.plug_p) annotation (
        Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
      aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
      connect(realExpression.y, svpwm.theta) annotation (
        Line(points = {{15, 66}, {12, 66}, {12, 60}, {6, 60}}, color = {0, 0, 127}));
      connect(phase.y, svpwm.vPhasor[2]) annotation (
        Line(points = {{73, 36}, {42, 36}, {42, 48}, {5.5, 48}}, color = {0, 0, 127}));
      connect(ampl.y, svpwm.vPhasor[1]) annotation (
        Line(points = {{63, 68}, {36, 68}, {36, 48}, {6.5, 48}}, color = {0, 0, 127}));
      connect(g1.y, upSW.control) annotation (
        Line(points = {{-25, 28}, {-35, 28}}, color = {255, 0, 255}));
      connect(g2.y, downSW.control) annotation (
        Line(points = {{-25, -16}, {-35, -16}}, color = {255, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
        experiment(StopTime = 0, Interval = 2e-05),
        __OpenModelica_commandLineOptions = "");
    end Id3Pwm3SVPWM_PS;
  end SVPWM;

  package Hyst
    model ReTwoHy "Switch-diode pais, two-legs, square wave"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{82, -60}, {102, -40}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 225.0) annotation (
        Placement(visible = true, transformation(origin = {-70, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.MathBoolean.Not nor1 annotation (
        Placement(visible = true, transformation(origin = {-8, -20}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-50, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-30, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-30, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {-50, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation (
        Placement(visible = true, transformation(origin = {92, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 10) annotation (
        Placement(visible = true, transformation(origin = {92, -16}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode uD1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {12, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {32, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {32, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode dD1(Vknee = 0.1) annotation (
        Placement(visible = true, transformation(origin = {12, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.MathBoolean.Not nor2 annotation (
        Placement(visible = true, transformation(origin = {42, 44}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Blocks.Logical.OnOffController onOffContr(bandwidth = 0.5) annotation (
        Placement(visible = true, transformation(origin = {72, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currtSens annotation (
        Placement(visible = true, transformation(origin = {72, 28}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Sine sine1(amplitude = 10, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {108, 62}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(ground.p, dSW1.p) annotation (
        Line(points = {{92, -40}, {92, -30}, {78, -30}, {78, -4}, {32, -4}, {32, -14}}, color = {0, 0, 255}));
      connect(V1.n, dD1.p) annotation (
        Line(points = {{-70, 2}, {-70, -48}, {12, -48}, {12, -34}}, color = {0, 0, 255}));
      connect(V1.n, dD.p) annotation (
        Line(points = {{-70, 2}, {-70, -48}, {-50, -48}, {-50, -34}}, color = {0, 0, 255}));
      connect(V1.p, uD1.n) annotation (
        Line(points = {{-70, 22}, {-70, 54}, {22, 54}, {22, 48}, {12, 48}, {12, 44}}, color = {0, 0, 255}));
      connect(V1.p, uD.n) annotation (
        Line(points = {{-70, 22}, {-70, 54}, {-40, 54}, {-40, 48}, {-50, 48}, {-50, 44}}, color = {0, 0, 255}));
      connect(nor1.u, nor2.u) annotation (
        Line(points = {{-8, -14.4}, {-8, 58}, {42, 58}, {42, 49.6}}, color = {255, 0, 255}));
      connect(nor1.y, dSW.fire) annotation (
        Line(points = {{-8, -24.8}, {-8, -34}, {-18, -34}}, color = {255, 0, 255}));
      connect(uSW.p, uD.n) annotation (
        Line(points = {{-30, 44}, {-30, 48}, {-50, 48}, {-50, 44}}, color = {0, 0, 255}));
      connect(uD.p, uSW.n) annotation (
        Line(points = {{-50, 24}, {-50, 16}, {-30, 16}, {-30, 24}}, color = {0, 0, 255}));
      connect(uD.p, dSW.p) annotation (
        Line(points = {{-50, 24}, {-50, 16}, {-40, 16}, {-40, -14}, {-30, -14}}, color = {0, 0, 255}));
      connect(currtSens.p, uD.p) annotation (
        Line(points = {{62, 28}, {58, 28}, {58, 12}, {-40, 12}, {-40, 16}, {-50, 16}, {-50, 24}}, color = {0, 0, 255}));
      connect(uSW.fire, nor2.u) annotation (
        Line(points = {{-18, 24}, {-14, 24}, {-14, 58}, {42, 58}, {42, 49.6}}, color = {255, 0, 255}));
      connect(dD.n, dSW.p) annotation (
        Line(points = {{-50, -14}, {-30, -14}}, color = {0, 0, 255}));
      connect(dSW.n, dD.p) annotation (
        Line(points = {{-30, -34}, {-30, -48}, {-50, -48}, {-50, -34}}, color = {0, 0, 255}));
      connect(inductor.n, Load.p) annotation (
        Line(points = {{92, 2}, {92, -6}}, color = {0, 0, 255}));
      connect(currtSens.n, inductor.p) annotation (
        Line(points = {{82, 28}, {92, 28}, {92, 22}}, color = {0, 0, 255}));
      connect(Load.n, dSW1.p) annotation (
        Line(points = {{92, -26}, {92, -30}, {78, -30}, {78, -4}, {32, -4}, {32, -14}}, color = {0, 0, 255}));
      connect(uSW1.p, uD1.n) annotation (
        Line(points = {{32, 44}, {32, 48}, {12, 48}, {12, 44}}, color = {0, 0, 255}));
      connect(uD1.p, uSW1.n) annotation (
        Line(points = {{12, 24}, {12, 16}, {32, 16}, {32, 24}}, color = {0, 0, 255}));
      connect(uD1.p, dSW1.p) annotation (
        Line(points = {{12, 24}, {12, 16}, {22, 16}, {22, -14}, {32, -14}}, color = {0, 0, 255}));
      connect(nor2.y, uSW1.fire) annotation (
        Line(points = {{42, 39.2}, {42, 24}, {44, 24}}, color = {255, 0, 255}));
      connect(dD1.n, dSW1.p) annotation (
        Line(points = {{12, -14}, {32, -14}}, color = {0, 0, 255}));
      connect(dSW1.n, dD1.p) annotation (
        Line(points = {{32, -34}, {32, -48}, {12, -48}, {12, -34}}, color = {0, 0, 255}));
      connect(dSW1.fire, nor2.u) annotation (
        Line(points = {{44, -34}, {50, -34}, {50, 58}, {42, 58}, {42, 49.6}}, color = {255, 0, 255}));
      connect(onOffContr.y, nor2.u) annotation (
        Line(points = {{61, 60}, {43, 60}, {43, 50}, {43, 50}}, color = {255, 0, 255}));
      connect(currtSens.i, onOffContr.u) annotation (
        Line(points = {{72, 39}, {72, 41}, {94, 41}, {94, 53}, {84, 53}}, color = {0, 0, 127}));
      connect(sine1.y, onOffContr.reference) annotation (
        Line(points = {{97, 62}, {91.5, 62}, {91.5, 66}, {84, 66}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {120, 80}})),
        experiment(StopTime = 0.1, StartTime = 0, Tolerance = 1e-06, Interval = 2e-05),
        Documentation(info = "<html><head></head><body><p><br></p>
    </body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end ReTwoHy;

    model IdTwoHy "Switch-diode pais, two-legs, square wave"
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{64, -50}, {84, -30}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 225.0) annotation (
        Placement(visible = true, transformation(origin = {-38, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation (
        Placement(visible = true, transformation(origin = {74, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 10) annotation (
        Placement(visible = true, transformation(origin = {74, -16}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Blocks.MathBoolean.Not nor2 annotation (
        Placement(visible = true, transformation(origin = {24, 48}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Blocks.Logical.OnOffController onOffContr(bandwidth = 0.7) annotation (
        Placement(visible = true, transformation(origin = {52, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currtSens annotation (
        Placement(visible = true, transformation(origin = {58, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Sine sine1(amplitude = 10, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {86, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation (
        Placement(visible = true, transformation(origin = {-22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (
        Placement(visible = true, transformation(origin = {-22, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2 annotation (
        Placement(visible = true, transformation(origin = {2, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch3 annotation (
        Placement(visible = true, transformation(origin = {2, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(Load.n, switch3.p) annotation (
        Line(points = {{74, -26}, {40, -26}, {40, 4}, {2, 4}, {2, -10}}, color = {0, 0, 255}));
      connect(Load.n, ground.p) annotation (
        Line(points = {{74, -26}, {74, -30}}, color = {0, 0, 255}));
      connect(inductor.n, Load.p) annotation (
        Line(points = {{74, -2}, {74, -6}}, color = {0, 0, 255}));
      connect(sine1.y, onOffContr.reference) annotation (
        Line(points = {{75, 60}, {73.5, 60}, {73.5, 64}, {64, 64}}, color = {0, 0, 127}));
      connect(switch3.control, onOffContr.y) annotation (
        Line(points = {{14, -20}, {34, -20}, {34, 58}, {41, 58}}, color = {255, 0, 255}));
      connect(switch1.control, onOffContr.y) annotation (
        Line(points = {{-10, 40}, {-10, 58}, {41, 58}}, color = {255, 0, 255}));
      connect(currtSens.i, onOffContr.u) annotation (
        Line(points = {{58, 35}, {58, 37}, {72, 37}, {72, 52}, {64, 52}}, color = {0, 0, 127}));
      connect(onOffContr.y, nor2.u) annotation (
        Line(points = {{41, 58}, {24, 58}, {24, 54}}, color = {255, 0, 255}));
      connect(V1.p, switch1.p) annotation (
        Line(points = {{-38, 20}, {-38, 50}, {-22, 50}}, color = {0, 0, 255}));
      connect(V1.n, switch.n) annotation (
        Line(points = {{-38, 0}, {-38, -30}, {-22, -30}}, color = {0, 0, 255}));
      connect(currtSens.p, switch1.n) annotation (
        Line(points = {{48, 24}, {-22, 24}, {-22, 30}}, color = {0, 0, 255}));
      connect(currtSens.n, inductor.p) annotation (
        Line(points = {{68, 24}, {74, 24}, {74, 18}}, color = {0, 0, 255}));
      connect(switch.control, nor2.y) annotation (
        Line(points = {{-10, -20}, {-4, -20}, {-4, 12}, {24, 12}, {24, 43}}, color = {255, 0, 255}));
      connect(nor2.y, switch2.control) annotation (
        Line(points = {{24, 43}, {24, 40}, {14, 40}}, color = {255, 0, 255}));
      connect(switch.n, switch3.n) annotation (
        Line(points = {{-22, -30}, {2, -30}}, color = {0, 0, 255}));
      connect(switch2.n, switch3.p) annotation (
        Line(points = {{2, 30}, {2, -10}}, color = {0, 0, 255}));
      connect(switch1.p, switch2.p) annotation (
        Line(points = {{-22, 50}, {2, 50}}, color = {0, 0, 255}));
      connect(switch1.n, switch.p) annotation (
        Line(points = {{-22, 30}, {-22, 30}, {-22, 32}, {-22, 32}, {-22, -8}, {-22, -8}, {-22, -10}, {-22, -10}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {120, 80}})),
        experiment(StopTime = 0.04, StartTime = 0, Tolerance = 1e-06, Interval = 8e-06),
        Documentation(info = "<html><head></head><body><p><br></p>
    </body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end IdTwoHy;

    model IdTwoRLE "Switch-diode pais, two-legs, square wave"
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-64, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 5e-3) annotation (
        Placement(visible = true, transformation(origin = {58, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {90, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.MathBoolean.Not nor2 annotation (
        Placement(visible = true, transformation(origin = {-2, 48}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
      Modelica.Blocks.Logical.OnOffController onOffContr(bandwidth = 0.7) annotation (
        Placement(visible = true, transformation(origin = {26, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currtSens annotation (
        Placement(visible = true, transformation(origin = {32, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Sine sine1(amplitude = 10, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {60, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation (
        Placement(visible = true, transformation(origin = {-48, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch4 annotation (
        Placement(visible = true, transformation(origin = {-48, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2 annotation (
        Placement(visible = true, transformation(origin = {-24, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch3 annotation (
        Placement(visible = true, transformation(origin = {-24, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.SineVoltage fem(V = 90, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {100, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(origin = {100, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fem.n, ground1.p) annotation (
        Line(points = {{100, -6}, {100, -6}, {100, -12}, {100, -12}}, color = {0, 0, 255}));
      connect(fem.n, switch3.p) annotation (
        Line(points = {{100, -6}, {-12, -6}, {-12, 2}, {-24, 2}, {-24, -10}, {-24, -10}}, color = {0, 0, 255}));
      connect(fem.p, Load.n) annotation (
        Line(points = {{100, 14}, {100, 14}, {100, 24}, {100, 24}}, color = {0, 0, 255}));
      connect(currtSens.n, inductor.p) annotation (
        Line(points = {{42, 24}, {42, 23}, {48, 23}, {48, 24}}, color = {0, 0, 255}));
      connect(inductor.n, Load.p) annotation (
        Line(points = {{68, 24}, {80, 24}}, color = {0, 0, 255}));
      connect(V1.n, switch4.n) annotation (
        Line(points = {{-64, 0}, {-64, -30}, {-48, -30}}, color = {0, 0, 255}));
      connect(V1.p, switch1.p) annotation (
        Line(points = {{-64, 20}, {-64, 50}, {-48, 50}}, color = {0, 0, 255}));
      connect(nor2.y, switch2.control) annotation (
        Line(points = {{-2, 43.2}, {-2, 40.2}, {-12, 40.2}}, color = {255, 0, 255}));
      connect(switch4.control, nor2.y) annotation (
        Line(points = {{-36, -20}, {-30, -20}, {-30, 12}, {-2, 12}, {-2, 43}}, color = {255, 0, 255}));
      connect(onOffContr.y, nor2.u) annotation (
        Line(points = {{15, 58}, {-2, 58}, {-2, 54}}, color = {255, 0, 255}));
      connect(currtSens.i, onOffContr.u) annotation (
        Line(points = {{32, 35}, {32, 37}, {46, 37}, {46, 52}, {38, 52}}, color = {0, 0, 127}));
      connect(switch1.control, onOffContr.y) annotation (
        Line(points = {{-36, 40}, {-36, 58}, {15, 58}}, color = {255, 0, 255}));
      connect(switch3.control, onOffContr.y) annotation (
        Line(points = {{-12, -20}, {8, -20}, {8, 58}, {15, 58}}, color = {255, 0, 255}));
      connect(sine1.y, onOffContr.reference) annotation (
        Line(points = {{49, 60}, {47.5, 60}, {47.5, 64}, {38, 64}}, color = {0, 0, 127}));
      connect(currtSens.p, switch1.n) annotation (
        Line(points = {{22, 24}, {-48, 24}, {-48, 30}}, color = {0, 0, 255}));
      connect(switch1.n, switch4.p) annotation (
        Line(points = {{-48, 30}, {-48, 30}, {-48, 32}, {-48, 32}, {-48, -8}, {-48, -8}, {-48, -10}, {-48, -10}}, color = {0, 0, 255}));
      connect(switch1.p, switch2.p) annotation (
        Line(points = {{-48, 50}, {-24, 50}}, color = {0, 0, 255}));
      connect(switch4.n, switch3.n) annotation (
        Line(points = {{-48, -30}, {-24, -30}}, color = {0, 0, 255}));
      connect(switch2.n, switch3.p) annotation (
        Line(points = {{-24, 30}, {-24, -10}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {120, 80}})),
        experiment(StopTime = 0.1, StartTime = 0, Tolerance = 1e-06, Interval = 2e-05),
        Documentation(info = "<html><head></head><body><p><br></p>
        </body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end IdTwoRLE;

    model WIP "Switch-diode pais, two-legs, square wave"
      Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation (
        Placement(visible = true, transformation(origin = {-64, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 5e-3) annotation (
        Placement(visible = true, transformation(origin = {-4, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Load(R = 0.05) annotation (
        Placement(visible = true, transformation(origin = {22, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation (
        Placement(visible = true, transformation(origin = {-48, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch4 annotation (
        Placement(visible = true, transformation(origin = {-48, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2 annotation (
        Placement(visible = true, transformation(origin = {-26, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch3 annotation (
        Placement(visible = true, transformation(origin = {-26, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Sources.SineVoltage fem(V = 90, freqHz = 50) annotation (
        Placement(visible = true, transformation(origin = {32, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
        Placement(visible = true, transformation(origin = {32, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fem.n, ground1.p) annotation (
        Line(points = {{32, -6}, {32, -6}, {32, -12}, {32, -12}}, color = {0, 0, 255}));
      connect(fem.p, Load.n) annotation (
        Line(points = {{32, 14}, {32, 14}, {32, 24}, {32, 24}}, color = {0, 0, 255}));
      connect(fem.n, switch3.p) annotation (
        Line(points = {{32, -6}, {-12, -6}, {-12, 2}, {-26, 2}, {-26, -10}}, color = {0, 0, 255}));
      connect(inductor.n, Load.p) annotation (
        Line(points = {{6, 24}, {12, 24}}, color = {0, 0, 255}));
      connect(switch2.n, switch3.p) annotation (
        Line(points = {{-26, 30}, {-26, -10}}, color = {0, 0, 255}));
      connect(switch4.n, switch3.n) annotation (
        Line(points = {{-48, -30}, {-26, -30}}, color = {0, 0, 255}));
      connect(inductor.p, switch1.n) annotation (
        Line(points = {{-14, 24}, {-48, 24}, {-48, 30}}, color = {0, 0, 255}));
      connect(switch1.p, switch2.p) annotation (
        Line(points = {{-48, 50}, {-26, 50}}, color = {0, 0, 255}));
      connect(V1.n, switch4.n) annotation (
        Line(points = {{-64, 0}, {-64, -30}, {-48, -30}}, color = {0, 0, 255}));
      connect(V1.p, switch1.p) annotation (
        Line(points = {{-64, 20}, {-64, 50}, {-48, 50}}, color = {0, 0, 255}));
      connect(switch1.n, switch4.p) annotation (
        Line(points = {{-48, 30}, {-48, 30}, {-48, 32}, {-48, 32}, {-48, -8}, {-48, -8}, {-48, -10}, {-48, -10}}, color = {0, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -40}, {60, 60}})),
        experiment(StopTime = 0.1, StartTime = 0, Tolerance = 1e-06, Interval = 2e-05),
        Documentation(info = "<html><head></head><body><p><br></p>
        </body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
        Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
    end WIP;
    annotation (
      Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
  end Hyst;

  package Support
    model PulseDelay
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end PulseDelay;

    model QMonoSensor "Sensor to measure the reactive power"
      Modelica.Electrical.Analog.Interfaces.PositivePin pc "Positive pin, current path" annotation (
        Placement(transformation(extent = {{-90, -10}, {-110, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin nc "Negative pin, current path" annotation (
        Placement(transformation(extent = {{110, -10}, {90, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin pv "Positive pin, voltage path" annotation (
        Placement(transformation(extent = {{-10, 110}, {10, 90}}, rotation = 0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin nv "Negative pin, voltage path" annotation (
        Placement(transformation(extent = {{10, -110}, {-10, -90}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput power annotation (
        Placement(transformation(origin = {-80, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
        Placement(transformation(origin = {0, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (
        Placement(transformation(extent = {{-50, -10}, {-30, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product annotation (
        Placement(transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Nonlinear.VariableDelay variableDelay(delayMax = 1.0) annotation (
        Placement(transformation(extent = {{32, -40}, {52, -20}})));
      Modelica.Blocks.Sources.Constant const(k = 1 / (50 * 4)) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {18, -66})));
    equation
      connect(pv, voltageSensor.p) annotation (
        Line(points = {{0, 100}, {0, -20}, {6.12323e-016, -20}}, color = {0, 0, 255}));
      connect(voltageSensor.n, nv) annotation (
        Line(points = {{-6.12323e-016, -40}, {-6.12323e-016, -63}, {0, -63}, {0, -100}}, color = {0, 0, 255}));
      connect(pc, currentSensor.p) annotation (
        Line(points = {{-100, 0}, {-50, 0}}, color = {0, 0, 255}));
      connect(currentSensor.n, nc) annotation (
        Line(points = {{-30, 0}, {100, 0}}, color = {0, 0, 255}));
      connect(currentSensor.i, product.u2) annotation (
        Line(points = {{-40, -11}, {-40, -30}, {-36, -30}, {-36, -38}}, color = {0, 0, 127}));
      connect(product.y, power) annotation (
        Line(points = {{-30, -61}, {-30, -80}, {-80, -80}, {-80, -110}}, color = {0, 0, 127}));
      connect(variableDelay.u, voltageSensor.v) annotation (
        Line(points = {{30, -30}, {11, -30}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(const.y, variableDelay.delayTime) annotation (
        Line(points = {{18, -55}, {18, -36}, {30, -36}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(variableDelay.y, product.u1) annotation (
        Line(points = {{53, -30}, {68, -30}, {68, 20}, {-24, 20}, {-24, -38}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-70, 70}, {70, -70}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, 100}, {0, 70}}, color = {0, 0, 255}), Line(points = {{0, -70}, {0, -100}}, color = {0, 0, 255}), Line(points = {{-80, -100}, {-80, 0}}, color = {0, 0, 255}), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 255}), Text(extent = {{150, 120}, {-150, 160}}, textString = "%name", lineColor = {0, 0, 255}), Line(points = {{0, 70}, {0, 40}}, color = {0, 0, 0}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}, color = {0, 0, 0}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}, color = {0, 0, 0}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}, color = {0, 0, 0}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}, color = {0, 0, 0}), Line(points = {{0, 0}, {9.02, 28.6}}, color = {0, 0, 0}), Polygon(points = {{-0.48, 31.6}, {18, 26}, {18, 57.2}, {-0.48, 31.6}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-5, 5}, {5, -5}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-29, -11}, {30, -70}}, lineColor = {0, 0, 0}, textString = "Q")}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics),
        Documentation(info = "<html>
<p>This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are pv and nv, the pins of the current path are pc and nc. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>
</html>", revisions = "<html>
<ul>
<li><i>January 12, 2006</i> by Anton Haumer implemented</li>
</ul>
</html>"));
    end QMonoSensor;

    block PwmPulser
      Modelica.Blocks.Interfaces.RealInput ampl annotation (
        Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
      Modelica.Blocks.Interfaces.RealInput ph_deg annotation (
        Placement(transformation(extent = {{-138, -76}, {-98, -36}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
      parameter Modelica.SIunits.Frequency fCar = 1050 "Carrier Frequency";
      parameter Modelica.SIunits.Time carStartTime = 0 "Carrier start time";
      import PI = Modelica.Constants.pi;
    protected
      Modelica.Blocks.Sources.Trapezoid carrier(rising = 1 / (2 * fCar), width = 0, falling = 1 / (2 * fCar), period = 1 / fCar, amplitude = 2, offset = -1, startTime = carStartTime) annotation (
        Placement(transformation(extent = {{14, -56}, {34, -36}})));
      Modelica.Blocks.Math.Sin sin annotation (
        Placement(transformation(extent = {{-20, -28}, {0, -8}})));
      Modelica.Blocks.Continuous.Integrator integrator annotation (
        Placement(transformation(extent = {{-50, 16}, {-32, 34}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * PI * fSig) annotation (
        Placement(transformation(extent = {{-90, 14}, {-64, 36}})));
    public
      Modelica.Blocks.Math.Add add annotation (
        Placement(transformation(extent = {{-54, -28}, {-34, -8}})));
      Modelica.Blocks.Math.Gain ToRAD(k = PI / 180) annotation (
        Placement(transformation(extent = {{-66, -62}, {-54, -50}})));
      Modelica.Blocks.Math.Product signal annotation (
        Placement(transformation(extent = {{14, -22}, {32, -4}})));
      Modelica.Blocks.Interfaces.BooleanOutput up annotation (
        Placement(transformation(extent = {{100, 10}, {120, 30}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
      Modelica.Blocks.Logical.Greater greater annotation (
        Placement(transformation(extent = {{46, -24}, {66, -4}})));
      Modelica.Blocks.Interfaces.BooleanOutput down annotation (
        Placement(transformation(extent = {{100, -62}, {120, -42}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
      Modelica.Blocks.Logical.Not not1 annotation (
        Placement(transformation(extent = {{60, -60}, {80, -40}})));
      parameter Modelica.SIunits.Frequency fSig = 50 "Signal Frequency";
    equation
      connect(ToRAD.u, ph_deg) annotation (
        Line(points = {{-67.2, -56}, {-118, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(sin.u, add.y) annotation (
        Line(points = {{-22, -18}, {-33, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(signal.u2, sin.y) annotation (
        Line(points = {{12.2, -18.4}, {14, -18.4}, {14, -18}, {1, -18}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add.u1, integrator.y) annotation (
        Line(points = {{-56, -12}, {-64, -12}, {-64, 2}, {-24, 2}, {-24, 25}, {-31.1, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(signal.u1, ampl) annotation (
        Line(points = {{12.2, -7.6}, {12.2, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add.u2, ToRAD.y) annotation (
        Line(points = {{-56, -24}, {-64, -24}, {-64, -34}, {-46, -34}, {-46, -56}, {-53.4, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(greater.u1, signal.y) annotation (
        Line(points = {{44, -14}, {46.45, -14}, {46.45, -13}, {32.9, -13}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(greater.u2, carrier.y) annotation (
        Line(points = {{44, -22}, {44, -46}, {35, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(up, greater.y) annotation (
        Line(points = {{110, 20}, {74, 20}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
      connect(not1.y, down) annotation (
        Line(points = {{81, -50}, {84, -50}, {84, -52}, {110, -52}}, color = {255, 0, 255}, smooth = Smooth.None));
      connect(not1.u, greater.y) annotation (
        Line(points = {{58, -50}, {52, -50}, {52, -32}, {74, -32}, {74, -14}, {67, -14}}, color = {255, 0, 255}, smooth = Smooth.None));
      connect(integrator.u, realExpression.y) annotation (
        Line(points = {{-51.8, 25}, {-62.7, 25}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-98, 88}, {-40, 60}}, lineColor = {0, 0, 127}, textString = "ampl"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "ph(°)"), Text(extent = {{28, 86}, {100, 60}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{42, -62}, {96, -88}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5), Text(extent = {{-100, 140}, {100, 110}}, lineColor = {0, 0, 255}, textString = "%name")}),
        __OpenModelica_commandLineOptions = "");
    end PwmPulser;

    block PwmPulser3
      Modelica.Blocks.Interfaces.RealInput ampl annotation (
        Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
      Modelica.Blocks.Interfaces.RealInput ph_deg annotation (
        Placement(transformation(extent = {{-138, -76}, {-98, -36}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
      parameter Modelica.SIunits.Frequency fCar = 1050 "Carrier Frequency";
      import PI = Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.BooleanOutput up[3] annotation (
        Placement(transformation(extent = {{100, 30}, {120, 50}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
      Modelica.Blocks.Interfaces.BooleanOutput down[3] annotation (
        Placement(transformation(extent = {{100, -50}, {120, -30}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
      parameter Modelica.SIunits.Frequency fSig = 50 "Modulating signal Frequency";
      PwmPulser pwmPulser[3](fCar = fill(fCar, 3), carStartTime = 3 / fCar * {-1, -2, 0}, fSig = fill(fSig, 3)) annotation (
        Placement(transformation(extent = {{36, -10}, {56, 10}})));
      Modelica.Blocks.Routing.Replicator replicator(nout = 3) annotation (
        Placement(transformation(extent = {{-58, 0}, {-38, 20}})));
      Modelica.Blocks.Routing.Replicator replicator1(nout = 3) annotation (
        Placement(transformation(extent = {{-88, -66}, {-68, -46}})));
      Modelica.Blocks.Math.Add add[3] annotation (
        Placement(transformation(extent = {{-10, -60}, {10, -40}})));
      Modelica.Blocks.Sources.Constant const[3](k = {0, -120, 120}) annotation (
        Placement(transformation(extent = {{-52, -38}, {-32, -18}})));
    equation
      connect(replicator.u, ampl) annotation (
        Line(points = {{-60, 10}, {-80, 10}, {-80, 60}, {-120, 60}}, color = {0, 0, 127}));
      connect(replicator.y, pwmPulser.ampl) annotation (
        Line(points = {{-37, 10}, {-26, 10}, {-26, 6.4}, {34, 6.4}}, color = {0, 0, 127}));
      connect(replicator1.u, ph_deg) annotation (
        Line(points = {{-90, -56}, {-118, -56}}, color = {0, 0, 127}));
      connect(add.u2, replicator1.y) annotation (
        Line(points = {{-12, -56}, {-67, -56}}, color = {0, 0, 127}));
      connect(const.y, add.u1) annotation (
        Line(points = {{-31, -28}, {-20, -28}, {-20, -44}, {-12, -44}}, color = {0, 0, 127}));
      connect(pwmPulser.ph_deg, add.y) annotation (
        Line(points = {{34, -5.4}, {28, -5.4}, {28, -6}, {22, -6}, {22, -50}, {11, -50}}, color = {0, 0, 127}));
      connect(pwmPulser.up, up) annotation (
        Line(points = {{57, 6.6}, {72, 6.6}, {72, 40}, {110, 40}}, color = {255, 0, 255}));
      connect(down, pwmPulser.down) annotation (
        Line(points = {{110, -40}, {66, -40}, {66, -5.8}, {57, -5.8}}, color = {255, 0, 255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-98, 88}, {-40, 60}}, lineColor = {0, 0, 127}, textString = "ampl"), Text(extent = {{-98, -62}, {-28, -88}}, lineColor = {0, 0, 127}, textString = "ph(°)"), Text(extent = {{48, 88}, {104, 62}}, lineColor = {255, 0, 255}, textString = "u"), Text(extent = {{56, -60}, {100, -86}}, lineColor = {255, 0, 255}, textString = "d", fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-60, -60}, {-40, 62}, {-20, -60}, {0, 60}, {20, -62}, {40, 60}, {60, -62}, {80, 58}}, color = {0, 0, 127}, smooth = Smooth.None), Line(points = {{-80, 20}, {-38, 40}, {0, 44}, {42, 40}, {80, 20}}, color = {0, 0, 127}, smooth = Smooth.None, thickness = 0.5), Text(extent = {{-100, 140}, {100, 110}}, lineColor = {0, 0, 255}, textString = "%name"), Text(extent = {{-26, 50}, {34, -54}}, lineColor = {238, 46, 47}, textString = "3")}),
        __OpenModelica_commandLineOptions = "");
    end PwmPulser3;

    model ToPark "Semplice PMM con modello funzionale inverter"
      parameter Integer p "number of pole pairs";
      Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator annotation (
        Placement(transformation(extent = {{0, 0}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y[2] annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealInput X[3] annotation (
        Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.RealInput phi annotation (
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {10, -110}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120})));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-30, 10})));
      Modelica.Blocks.Math.Gain gain(k = p) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {10, -42})));
    equation
      connect(toSpacePhasor.y, rotator.u) annotation (
        Line(points = {{-19, 10}, {-2, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(rotator.y, y) annotation (
        Line(points = {{21, 10}, {66, 10}, {66, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(toSpacePhasor.u, X) annotation (
        Line(points = {{-42, 10}, {-82, 10}, {-82, 0}, {-120, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.y, rotator.angle) annotation (
        Line(points = {{10, -31}, {10, -2}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.u, phi) annotation (
        Line(points = {{10, -54}, {10, -110}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics),
        experiment(StopTime = 5, Interval = 0.001),
        Documentation(info = "<html>
<p>Converts variables phase quantities into Park&apos;s</p>
</html>"),
        __Dymola_experimentSetupOutput,
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-96, 32}, {96, -22}}, lineColor = {0, 0, 127}, textString = "=>P"), Text(extent = {{-106, 144}, {104, 106}}, lineColor = {0, 0, 255}, textString = "%name")}));
    end ToPark;
  end Support;

  package Misc
    model acFiltQS
      import PI = Modelica.Constants.pi;
      parameter Real f0 = 200;
      final parameter Real W0 = 2 * PI * f0;
      final parameter Real X0 = W0 * Lf.L;
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor Rf(R_ref = 0.05) annotation (
        Placement(transformation(extent = {{-38, 30}, {-18, 50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor Lf(L = 0.001) annotation (
        Placement(transformation(extent = {{-2, 30}, {18, 50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C = 1 / (W0 ^ 2 * Lf.L)) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {24, 16})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor loadR(R_ref = 2.0) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {54, 16})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource variableVoltageSource annotation (
        Placement(visible = true, transformation(origin = {-56, 14}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      Modelica.ComplexBlocks.Sources.ComplexConstant const annotation (
        Placement(transformation(extent = {{-98, 36}, {-78, 56}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (
        Placement(transformation(extent = {{-30, -34}, {-10, -14}})));
      Modelica.Blocks.Sources.RealExpression time_(y = time) annotation (
        Placement(visible = true, transformation(origin = {-88, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(variableVoltageSource.f, time_.y) annotation (
        Line(points = {{-68, 8}, {-72, 8}, {-72, -14}, {-80, -14}, {-80, -16}, {-78, -16}, {-78, -14}, {-77, -14}}, color = {0, 0, 127}));
      connect(ground.pin, variableVoltageSource.pin_n) annotation (
        Line(points = {{-20, -14}, {-20, -8}, {-56, -8}, {-56, 4}}, color = {85, 170, 255}));
      connect(loadR.pin_n, variableVoltageSource.pin_n) annotation (
        Line(points = {{54, 6}, {54, -8}, {-56, -8}, {-56, 4}}, color = {85, 170, 255}));
      connect(capacitor.pin_n, variableVoltageSource.pin_n) annotation (
        Line(points = {{24, 6}, {24, -8}, {-56, -8}, {-56, 4}}, color = {85, 170, 255}));
      connect(variableVoltageSource.pin_p, Rf.pin_p) annotation (
        Line(points = {{-56, 24}, {-56, 40}, {-38, 40}}, color = {85, 170, 255}));
      connect(const.y, variableVoltageSource.V) annotation (
        Line(points = {{-77, 46}, {-68, 46}, {-68, 20}}, color = {85, 170, 255}));
      connect(Rf.pin_n, Lf.pin_p) annotation (
        Line(points = {{-18, 40}, {-2, 40}}, color = {85, 170, 255}));
      connect(Lf.pin_n, capacitor.pin_p) annotation (
        Line(points = {{18, 40}, {24, 40}, {24, 26}}, color = {85, 170, 255}));
      connect(loadR.pin_p, capacitor.pin_p) annotation (
        Line(points = {{54, 26}, {54, 40}, {24, 40}, {24, 26}}, color = {85, 170, 255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {80, 60}})),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {80, 60}}), graphics = {Text(extent = {{16, 76}, {58, 62}}, lineColor = {28, 108, 200}, textString = "cut-off f0=%f0 Hz
W0=%W0 ohm")}),
        experiment(StopTime = 1000));
    end acFiltQS;

    model AronPow "bidirectional switches, one-leg, PWM"
      Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = {1, 1, 1}) annotation (
        Placement(transformation(extent = {{22, -10}, {42, 10}})));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(transformation(extent = {{-40, -10}, {-60, 10}})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(transformation(extent = {{-80, -20}, {-60, 0}})));
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {58, -10})));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V = fill(100, 3), freqHz = fill(50, 3)) annotation (
        Placement(transformation(extent = {{-32, -10}, {-12, 10}})));
      Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor annotation (
        Placement(transformation(extent = {{-4, -10}, {16, 10}})));
    equation
      connect(star.pin_n, ground.p) annotation (
        Line(points = {{-60, 0}, {-70, 0}}, color = {0, 0, 255}));
      connect(resistor.plug_n, star2.plug_p) annotation (
        Line(points = {{42, 0}, {50, 0}, {58, 0}}, color = {0, 0, 255}));
      connect(star.plug_p, sineVoltage.plug_p) annotation (
        Line(points = {{-40, 0}, {-32, 0}}, color = {0, 0, 255}));
      connect(aronSensor.plug_p, sineVoltage.plug_n) annotation (
        Line(points = {{-4, 0}, {-12, 0}}, color = {0, 0, 255}));
      connect(aronSensor.plug_n, resistor.plug_p) annotation (
        Line(points = {{16, 0}, {22, 0}}, color = {0, 0, 255}));
      annotation (
        experiment(StopTime = 0.1),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-80, -40}, {80, 40}}, preserveAspectRatio = false)),
        Icon(coordinateSystem(extent = {{-80, -40}, {80, 40}}, preserveAspectRatio = false)));
    end AronPow;

    model MFPower "bidirectional switches, one-leg, PWM"
      Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor annotation (
        Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = {1, 1, 1}) annotation (
        Placement(visible = true, transformation(extent = {{16, -10}, {36, 10}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star annotation (
        Placement(visible = true, transformation(extent = {{-46, -10}, {-66, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (
        Placement(visible = true, transformation(extent = {{-86, -20}, {-66, 0}}, rotation = 0)));
      Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (
        Placement(visible = true, transformation(origin = {52, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V = fill(100, 3), freqHz = fill(50, 3)) annotation (
        Placement(visible = true, transformation(extent = {{-36, -10}, {-16, 10}}, rotation = 0)));
    equation
      connect(sineVoltage.plug_p, powerSensor.nv) annotation (
        Line(points = {{-36, 0}, {-36, -28}, {0, -28}, {0, -10}}, color = {0, 0, 255}));
      connect(star.plug_p, sineVoltage.plug_p) annotation (
        Line(points = {{-46, 0}, {-42, 0}, {-36, 0}}, color = {0, 0, 255}));
      connect(powerSensor.pc, sineVoltage.plug_n) annotation (
        Line(points = {{-10, 0}, {-12, 0}, {-12, 0}, {-14, 0}, {-16, 0}}, color = {0, 0, 255}));
      connect(resistor.plug_n, star2.plug_p) annotation (
        Line(points = {{36, 0}, {40, 0}, {44, 0}, {48, 0}, {52, 0}}, color = {0, 0, 255}));
      connect(star.pin_n, ground.p) annotation (
        Line(points = {{-66, 0}, {-76, 0}}, color = {0, 0, 255}));
      connect(powerSensor.nc, resistor.plug_p) annotation (
        Line(points = {{10, 0}, {16, 0}}, color = {0, 0, 255}));
      connect(powerSensor.pv, powerSensor.pc) annotation (
        Line(points = {{0, 10}, {-2.5, 10}, {-2.5, 10}, {-5, 10}, {-5, 10}, {-10, 10}, {-10, 5}, {-10, 5}, {-10, 0}}, color = {0, 0, 255}));
      annotation (
        experiment(StopTime = 0.1),
        experimentSetupOutput,
        Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
        Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}}, preserveAspectRatio = false)),
        Icon(coordinateSystem(extent = {{-100, -20}, {100, 60}}, preserveAspectRatio = false)),
        __OpenModelica_commandLineOptions = "");
    end MFPower;
  end Misc;
  annotation (
    uses(Modelica(version = "3.2.3"), PowerSystems(version = "0.6.0")),
    Documentation(info = "<html><head></head><body><p><font size=\"4\">Inverter reference data:</font></p>
<p><font size=\"4\">Total DC voltage 100 V</font></p>
<p><font size=\"4\">When a passive load is fed: resistance 1 ohm, inductance 5mH</font></p>
<p><font size=\"4\">Filter resistance 0.05 ohm</font></p>
</body></html>"));
end InvPWM;
