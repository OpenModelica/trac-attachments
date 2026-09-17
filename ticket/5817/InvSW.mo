model InvSW "Three-phase (multiphase) with bidirectional switches"
  Modelica.SIunits.Power aronPower;
  Modelica.Electrical.MultiPhase.Basic.Star star2 annotation(
    Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation(
    Placement(visible = true, transformation(origin = {78, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation(
    Placement(visible = true, transformation(origin = {32, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation(
    Placement(visible = true, transformation(origin = {16, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.05, 3)) annotation(
    Placement(visible = true, transformation(origin = {-8, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Star star1 annotation(
    Placement(visible = true, transformation(origin = {-42, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch downSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation(
    Placement(visible = true, transformation(origin = {-42, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation(
    Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-70, -18}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-70, 26}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
    Placement(visible = true, transformation(origin = {-92, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse[3](width = fill(50, 3), period = fill(1 / 50, 3), startTime = 1 / 50 * {-1 / 3, 0, 1 / 3}) annotation(
    Placement(visible = true, transformation(extent = {{16, 40}, {-4, 60}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.Not myNot[3] annotation(
    Placement(visible = true, transformation(origin = {-24, 20}, extent = {{-4, -4}, {4, 4}}, rotation = 270)));
equation
  connect(upSW.plug_p, star.plug_p) annotation(
    Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
  connect(V2.p, star.pin_n) annotation(
    Line(points = {{-70, 36}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
  connect(ground2.p, V2.n) annotation(
    Line(points = {{-92, 0}, {-70, 0}, {-70, 16}}, color = {0, 0, 255}));
  connect(V2.n, V1.p) annotation(
    Line(points = {{-70, 16}, {-70, -8}}, color = {0, 0, 255}));
  connect(V1.n, star1.pin_n) annotation(
    Line(points = {{-70, -28}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
  connect(upSW.plug_n, downSW.plug_p) annotation(
    Line(points = {{-42, 18}, {-42, -4}}, color = {0, 0, 255}));
  connect(Rf.plug_p, downSW.plug_p) annotation(
    Line(points = {{-18, 6}, {-42, 6}, {-42, -4}}, color = {0, 0, 255}));
  connect(downSW.plug_n, star1.plug_p) annotation(
    Line(points = {{-42, -24}, {-42, -34}}, color = {0, 0, 255}));
  connect(Rf.plug_n, Lf.plug_p) annotation(
    Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
  connect(Cf.plug_p, Lf.plug_n) annotation(
    Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
  connect(Cf.plug_n, Rload.plug_n) annotation(
    Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
  connect(Rload.plug_n, star2.plug_p) annotation(
    Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
  aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
  connect(booleanPulse.y, upSW.control) annotation(
    Line(points = {{-5, 50}, {-30, 50}, {-30, 28}}, color = {255, 0, 255}));
  connect(myNot.u, booleanPulse.y) annotation(
    Line(points = {{-24, 25.6}, {-24, 50}, {-5, 50}}, color = {255, 0, 255}));
  connect(myNot.y, downSW.control) annotation(
    Line(points = {{-24, 15.2}, {-26, 15.2}, {-26, -14}, {-30, -14}}, color = {255, 0, 255}));
  connect(Cf.plug_p, Rload.plug_p) annotation(
    Line(points = {{32, 6}, {78, 6}, {78, 6}, {78, 6}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
    experimentSetupOutput,
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
    experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 0.0002),
    __OpenModelica_commandLineOptions = "");
end InvSW;
