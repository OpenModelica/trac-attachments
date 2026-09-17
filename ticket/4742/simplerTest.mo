model simplerTest "Real valves, one leg P-Q measure"
  Modelica.Electrical.Analog.Sources.SineVoltage fem(V = 40, freqHz = 50) annotation(
    Placement(visible = true, transformation(origin = {66, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-60, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-40, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-68, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(extent = {{2, -54}, {22, -34}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-84, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-84, -12}, {-64, 8}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation(
    Placement(visible = true, transformation(origin = {30, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation(
    Placement(visible = true, transformation(extent = {{-6, -6}, {14, 14}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation(
    Placement(visible = true, transformation(extent = {{-54, -6}, {-34, 14}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(
    Placement(visible = true, transformation(origin = {-84, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.BooleanPulse pulse(period = 1 / 50)  annotation(
    Placement(visible = true, transformation(origin = {-6, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-28, 26}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
equation
  connect(not1.y, dSW.fire) annotation(
    Line(points = {{-26, 19}, {-28, 19}, {-28, -44}}, color = {255, 0, 255}));
  connect(not1.u, uSW.fire) annotation(
    Line(points = {{-26, 33}, {-26, 50}, {-38, 50}}, color = {255, 0, 255}));
  connect(Lf.p, Rf.n) annotation(
    Line(points = {{-6, 4}, {-34, 4}}, color = {0, 0, 255}));
  connect(Rf.p, dD.n) annotation(
    Line(points = {{-54, 4}, {-60, 4}, {-60, -24}}, color = {0, 0, 255}));
  connect(pulse.y, uSW.fire) annotation(
    Line(points = {{-18, 50}, {-34, 50}, {-34, 50}, {-38, 50}, {-38, 50}}, color = {255, 0, 255}));
  connect(Lf.n, fem.p) annotation(
    Line(points = {{14, 4}, {66, 4}, {66, -6}}, color = {0, 0, 255}));
  connect(fem.n, Cf.n) annotation(
    Line(points = {{66, -26}, {30, -26}}, color = {0, 0, 255}));
  connect(uD.p, dD.n) annotation(
    Line(points = {{-68, 50}, {-68, 34}, {-60, 34}, {-60, -24}}, color = {0, 0, 255}));
  connect(V2.n, dD.p) annotation(
    Line(points = {{-84, -30}, {-84, -58}, {-60, -58}, {-60, -44}}, color = {0, 0, 255}));
  connect(dD.n, dSW.p) annotation(
    Line(points = {{-60, -24}, {-60, -20}, {-40, -20}, {-40, -24}}, color = {0, 0, 255}));
  connect(dSW.n, dD.p) annotation(
    Line(points = {{-40, -44}, {-40, -58}, {-60, -58}, {-60, -44}}, color = {0, 0, 255}));
  connect(V1.p, uD.n) annotation(
    Line(points = {{-84, 34}, {-84, 76}, {-68, 76}, {-68, 70}}, color = {0, 0, 255}));
  connect(uSW.n, uD.p) annotation(
    Line(points = {{-50, 50}, {-50, 42}, {-68, 42}, {-68, 50}}, color = {0, 0, 255}));
  connect(uD.n, uSW.p) annotation(
    Line(points = {{-68, 70}, {-68, 74}, {-50, 74}, {-50, 70}}, color = {0, 0, 255}));
  connect(ground1.p, Cf.n) annotation(
    Line(points = {{12, -34}, {12, -34}, {12, -26}, {30, -26}}, color = {0, 0, 255}));
  connect(V1.n, V2.p) annotation(
    Line(points = {{-84, 14}, {-84, -10}, {-84, -10}}, color = {0, 0, 255}));
  connect(ground.p, V1.n) annotation(
    Line(points = {{-74, 8}, {-74, 14}, {-84, 14}}, color = {0, 0, 255}));
  connect(Cf.p, Lf.n) annotation(
    Line(points = {{30, -6}, {30, -6}, {30, 2}, {14, 2}, {14, 4}}, color = {0, 0, 255}));
  annotation(
    experiment(StopTime = 0.06, Interval = 5e-005),
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
    Diagram(coordinateSystem(extent = {{-100, -60}, {80, 80}}, preserveAspectRatio = false)),
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    __OpenModelica_commandLineOptions = "",
    uses(Modelica(version = "trunk")));
end simplerTest;
