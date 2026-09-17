model InvSVPWM "Tri-phase multiphase lib with ideal switches"
  Modelica.SIunits.Power aronPower;
  Real unFiltered1 = Rf.plug_p.pin[1].v - star2.pin_n.v;
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
    Placement(visible = true, transformation(origin = {-42, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch upSW(Ron = fill(1e-5, 3), Goff = fill(1e-5, 3)) annotation(
    Placement(visible = true, transformation(origin = {-42, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-70, 44}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
    Placement(visible = true, transformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Control.Modulation.SVPWM svpwm annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-4, 54})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 314.15 * time) annotation(
    Placement(transformation(extent = {{36, 56}, {16, 76}})));
  Modelica.Blocks.Sources.Constant ampl(k = 0.7) annotation(
    Placement(visible = true, transformation(origin = {74, 68}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant phase(k = 0) annotation(
    Placement(visible = true, transformation(origin = {84, 36}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.BooleanExpression g1[3](y = {svpwm.gates[1], svpwm.gates[3], svpwm.gates[5]}) annotation(
    Placement(transformation(extent = {{-4, 18}, {-24, 38}})));
  Modelica.Blocks.Sources.BooleanExpression g2[3](y = {svpwm.gates[2], svpwm.gates[4], svpwm.gates[6]}) annotation(
    Placement(transformation(extent = {{-4, -26}, {-24, -6}})));
equation
  connect(Cf.plug_p, Rload.plug_p) annotation(
    Line(points = {{32, 6}, {78, 6}, {78, 6}, {78, 6}}, color = {0, 0, 255}));
  connect(ground2.p, V2.n) annotation(
    Line(points = {{-92, 8}, {-70, 8}, {-70, 34}}, color = {0, 0, 255}));
  connect(V2.p, star.pin_n) annotation(
    Line(points = {{-70, 54}, {-70, 70}, {-42, 70}, {-42, 66}}, color = {0, 0, 255}));
  connect(V2.n, V1.p) annotation(
    Line(points = {{-70, 34}, {-70, 34}, {-70, 0}}, color = {0, 0, 255}));
  connect(V1.n, star1.pin_n) annotation(
    Line(points = {{-70, -20}, {-70, -54}, {-42, -54}}, color = {0, 0, 255}));
  connect(upSW.plug_n, downSW.plug_p) annotation(
    Line(points = {{-42, 18}, {-42, -6}}, color = {0, 0, 255}));
  connect(upSW.plug_p, star.plug_p) annotation(
    Line(points = {{-42, 38}, {-42, 46}}, color = {0, 0, 255}));
  connect(Rf.plug_p, downSW.plug_p) annotation(
    Line(points = {{-18, 6}, {-42, 6}, {-42, -6}}, color = {0, 0, 255}));
  connect(downSW.plug_n, star1.plug_p) annotation(
    Line(points = {{-42, -26}, {-42, -34}}, color = {0, 0, 255}));
  connect(Rf.plug_n, Lf.plug_p) annotation(
    Line(points = {{2, 6}, {6, 6}}, color = {0, 0, 255}));
  connect(Cf.plug_p, Lf.plug_n) annotation(
    Line(points = {{32, 6}, {31, 6}, {31, 6}, {30, 6}, {26, 6}}, color = {0, 0, 255}));
  connect(Cf.plug_n, Rload.plug_n) annotation(
    Line(points = {{32, -14}, {78, -14}}, color = {0, 0, 255}));
  connect(Rload.plug_n, star2.plug_p) annotation(
    Line(points = {{78, -14}, {78, -20}}, color = {0, 0, 255}));
  aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
  connect(realExpression.y, svpwm.theta) annotation(
    Line(points = {{15, 66}, {12, 66}, {12, 60}, {6, 60}}, color = {0, 0, 127}));
  connect(phase.y, svpwm.vPhasor[2]) annotation(
    Line(points = {{73, 36}, {42, 36}, {42, 48}, {5.5, 48}}, color = {0, 0, 127}));
  connect(ampl.y, svpwm.vPhasor[1]) annotation(
    Line(points = {{63, 68}, {36, 68}, {36, 48}, {6.5, 48}}, color = {0, 0, 127}));
  connect(g1.y, upSW.control) annotation(
    Line(points = {{-25, 28}, {-35, 28}}, color = {255, 0, 255}));
  connect(g2.y, downSW.control) annotation(
    Line(points = {{-25, -16}, {-35, -16}}, color = {255, 0, 255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
    experimentSetupOutput,
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>", revisions = "<html><head></head><body>non newInst</body></html>"),
    experiment(StopTime = 0, Interval = 2e-05),
    __OpenModelica_commandLineOptions = "");
end InvSVPWM;