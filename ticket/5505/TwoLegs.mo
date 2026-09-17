model TwoLegs "Switch-diode pais, two-legs, square wave"
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{82, -54}, {102, -34}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 225.0) annotation(
    Placement(visible = true, transformation(origin = {-70, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 50) annotation(
    Placement(visible = true, transformation(extent = {{100, 54}, {80, 74}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.Not nor1 annotation(
    Placement(visible = true, transformation(origin = {-8, -14}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, 40})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, 40})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, -18})));
  Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, -18})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 67.36e-3) annotation(
    Placement(visible = true, transformation(origin = {92, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor Load(R = 42.32) annotation(
    Placement(visible = true, transformation(origin = {92, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode uD1(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {12, 40})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW1(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {32, 40})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW1(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {32, -18})));
  Modelica.Electrical.Analog.Ideal.IdealDiode dD1(Vknee = 0.1) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {12, -18})));
  Modelica.Blocks.MathBoolean.Not nor2 annotation(
    Placement(visible = true, transformation(origin = {42, 50}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(
    Placement(transformation(extent = {{62, 24}, {82, 44}})));
  Modelica.Blocks.Math.Mean meanP(f = 50) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {64, -30})));
equation
  connect(nor1.u, nor2.u) annotation(
    Line(points = {{-8, -8.4}, {-8, 64}, {42, 64}, {42, 56}}, color = {255, 0, 255}));
  connect(uSW.fire, nor2.u) annotation(
    Line(points = {{-19, 33}, {-14, 33}, {-14, 64}, {42, 64}, {42, 56}}, color = {255, 0, 255}));
  connect(dSW1.fire, nor2.u) annotation(
    Line(points = {{43, -25}, {50, -25}, {50, 64}, {42, 64}, {42, 56}}, color = {255, 0, 255}));
  connect(booleanPulse.y, nor2.u) annotation(
    Line(points = {{79, 64}, {42, 64}, {42, 56}}, color = {255, 0, 255}));
  connect(nor2.y, uSW1.fire) annotation(
    Line(points = {{42, 45}, {42, 33}, {43, 33}}, color = {255, 0, 255}));
  connect(inductor.n, Load.p) annotation(
    Line(points = {{92, 8}, {92, 0}}, color = {0, 0, 255}));
  connect(uSW.p, uD.n) annotation(
    Line(points = {{-30, 50}, {-30, 54}, {-50, 54}, {-50, 50}}, color = {0, 0, 255}));
  connect(uD.p, uSW.n) annotation(
    Line(points = {{-50, 30}, {-50, 22}, {-30, 22}, {-30, 30}}, color = {0, 0, 255}));
  connect(dD.n, dSW.p) annotation(
    Line(points = {{-50, -8}, {-30, -8}}, color = {0, 0, 255}));
  connect(dSW.n, dD.p) annotation(
    Line(points = {{-30, -28}, {-30, -42}, {-50, -42}, {-50, -28}}, color = {0, 0, 255}));
  connect(V1.p, uD.n) annotation(
    Line(points = {{-70, 28}, {-70, 60}, {-40, 60}, {-40, 54}, {-50, 54}, {-50, 50}}, color = {0, 0, 255}));
  connect(uD.p, dSW.p) annotation(
    Line(points = {{-50, 30}, {-50, 22}, {-40, 22}, {-40, -8}, {-30, -8}}, color = {0, 0, 255}));
  connect(uSW1.p, uD1.n) annotation(
    Line(points = {{32, 50}, {32, 54}, {12, 54}, {12, 50}}, color = {0, 0, 255}));
  connect(uD1.p, uSW1.n) annotation(
    Line(points = {{12, 30}, {12, 22}, {32, 22}, {32, 30}}, color = {0, 0, 255}));
  connect(dD1.n, dSW1.p) annotation(
    Line(points = {{12, -8}, {32, -8}}, color = {0, 0, 255}));
  connect(dSW1.n, dD1.p) annotation(
    Line(points = {{32, -28}, {32, -42}, {12, -42}, {12, -28}}, color = {0, 0, 255}));
  connect(V1.p, uD1.n) annotation(
    Line(points = {{-70, 28}, {-70, 60}, {22, 60}, {22, 54}, {12, 54}, {12, 50}}, color = {0, 0, 255}));
  connect(uD1.p, dSW1.p) annotation(
    Line(points = {{12, 30}, {12, 22}, {22, 22}, {22, -8}, {32, -8}}, color = {0, 0, 255}));
  connect(Load.n, dSW1.p) annotation(
    Line(points = {{92, -20}, {92, -24}, {78, -24}, {78, 2}, {32, 2}, {32, -8}}, color = {0, 0, 255}));
  connect(ground.p, dSW1.p) annotation(
    Line(points = {{92, -34}, {92, -24}, {78, -24}, {78, 2}, {32, 2}, {32, -8}}, color = {0, 0, 255}));
  connect(V1.n, dD.p) annotation(
    Line(points = {{-70, 8}, {-70, -42}, {-50, -42}, {-50, -28}}, color = {0, 0, 255}));
  connect(nor1.y, dSW.fire) annotation(
    Line(points = {{-8, -18.8}, {-8, -25}, {-19, -25}}, color = {255, 0, 255}));
  connect(V1.n, dD1.p) annotation(
    Line(points = {{-70, 8}, {-70, -42}, {12, -42}, {12, -28}}, color = {0, 0, 255}));
  connect(powerSensor.pv, powerSensor.nc) annotation(
    Line(points = {{72, 44}, {82, 44}, {82, 34}}, color = {0, 0, 255}));
  connect(powerSensor.nc, inductor.p) annotation(
    Line(points = {{82, 34}, {92, 34}, {92, 28}}, color = {0, 0, 255}));
  connect(powerSensor.pc, dSW.p) annotation(
    Line(points = {{62, 34}, {62, 16}, {-40, 16}, {-40, -8}, {-30, -8}}, color = {0, 0, 255}));
  connect(meanP.u, powerSensor.power) annotation(
    Line(points = {{64, -18}, {64, 23}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -60}, {120, 80}})),
    experiment(StopTime = 0.1, StartTime = 0, Tolerance = 1e-06, Interval = 0.0002),
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>no newInst</body></html>"),
    Icon(coordinateSystem(extent = {{-80, -60}, {120, 80}}, preserveAspectRatio = false)));
end TwoLegs;
