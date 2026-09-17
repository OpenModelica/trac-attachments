model Filter
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor Rf(R_ref = 1) annotation(
    Placement(visible = true, transformation(extent = {{-36, -4}, {-16, 16}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor Lf(L = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{0, -4}, {20, 16}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor Cf(C = 100e-6) annotation(
    Placement(visible = true, transformation(origin = {26, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor Rl(R_ref = 50) annotation(
    Placement(visible = true, transformation(origin = {56, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource variableVoltageSource annotation(
    Placement(visible = true, transformation(origin = {-58, -16}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.ComplexBlocks.Sources.ComplexConstant const(k = Complex(1, 0))  annotation(
    Placement(visible = true, transformation(extent = {{-96, 6}, {-76, 26}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-28, -64}, {-8, -44}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = time) annotation(
    Placement(visible = true, transformation(extent = {{-94, -46}, {-74, -26}}, rotation = 0)));
equation
  connect(const.y, variableVoltageSource.V) annotation(
    Line(points = {{-75, 16}, {-68, 16}, {-68, -12}}, color = {85, 170, 255}));
  connect(variableVoltageSource.pin_p, Rf.pin_p) annotation(
    Line(points = {{-58, -6}, {-58, 6}, {-36, 6}}, color = {85, 170, 255}));
  connect(Rf.pin_n, Lf.pin_p) annotation(
    Line(points = {{-16, 6}, {0, 6}}, color = {85, 170, 255}));
  connect(Lf.pin_n, Cf.pin_p) annotation(
    Line(points = {{20, 6}, {26, 6}, {26, -6}}, color = {85, 170, 255}));
  connect(Cf.pin_n, variableVoltageSource.pin_n) annotation(
    Line(points = {{26, -26}, {26, -38}, {-58, -38}, {-58, -26}}, color = {85, 170, 255}));
  connect(Rl.pin_p, Cf.pin_p) annotation(
    Line(points = {{56, -6}, {56, 6}, {26, 6}, {26, -6}}, color = {85, 170, 255}));
  connect(Rl.pin_n, variableVoltageSource.pin_n) annotation(
    Line(points = {{56, -26}, {56, -38}, {-58, -38}, {-58, -26}}, color = {85, 170, 255}));
  connect(ground.pin, variableVoltageSource.pin_n) annotation(
    Line(points = {{-18, -44}, {-18, -38}, {-58, -38}, {-58, -26}}, color = {85, 170, 255}));
  connect(realExpression.y, variableVoltageSource.f) annotation(
    Line(points = {{-73, -36}, {-68, -36}, {-68, -20}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {80, 60}}, initialScale = 0.1)),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {80, 40}}, initialScale = 0.1), graphics = {Text(origin = {174.8, -12.002}, lineColor = {238, 46, 47}, extent = {{-220.8, 46.002}, {-128.8, 34.002}}, textString = "tensioni sul carico\nprima in scala lineare, poi log", horizontalAlignment = TextAlignment.Left)}),
    experiment(StopTime = 10000, StartTime = 1, Tolerance = 1e-06, Interval = 9.999));
end Filter;
