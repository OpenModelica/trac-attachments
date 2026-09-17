model PowerUnit
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1000) annotation (
    Placement(visible = true, transformation(origin = {40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Math.Mean meanP(f = 50) annotation (
    Placement(visible = true, transformation(extent={{-22,48},{-2,68}},       rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor pMeas annotation (
    Placement(visible = true, transformation(extent = {{-26, 20}, {-6, 40}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent = {{-78, -52}, {-58, -32}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation (
    Placement(visible = true, transformation(origin = {-68, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{14,48},{34,68}})));
equation
  connect(resistor1.n, sineVoltage.n) annotation (
    Line(points = {{40, -6}, {40, -20}, {-68, -20}, {-68, -6}}, color = {0, 0, 255}));
  connect(pMeas.nc, resistor1.p) annotation (
    Line(points = {{-6, 30}, {40, 30}, {40, 14}}, color = {0, 0, 255}));
  connect(pMeas.nv, sineVoltage.n) annotation (
    Line(points = {{-16, 20}, {-16, -6}, {-68, -6}}, color = {0, 0, 255}));
  connect(pMeas.pc, sineVoltage.p) annotation (
    Line(points = {{-26, 30}, {-68, 30}, {-68, 14}}, color = {0, 0, 255}));
  connect(ground.p, sineVoltage.n) annotation (
    Line(points = {{-68, -32}, {-68, -6}}, color = {0, 0, 255}));
  connect(meanP.u, pMeas.power) annotation (
    Line(points={{-24,58},{-30,58},{-30,19},{-24,19}},          color = {0, 0, 127}));
  connect(pMeas.pv, pMeas.pc) annotation (
    Line(points = {{-16, 40}, {-26, 40}, {-26, 30}}, color = {0, 0, 255}));
  connect(meanP.y, integrator.u)
    annotation (Line(points={{-1,58},{6,58},{12,58}}, color={0,0,127}));
  annotation (
    experiment(StopTime = 0.1),
    experimentSetupOutput,
    Documentation(info = "<html>
 <p>Misura di potenza attiva e reattiva istantanea su carico RLC</p>
 </html>"),
    Diagram(coordinateSystem(extent = {{-100, -60}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Icon(coordinateSystem(extent = {{-100, -60}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version="3.2.2")));
end PowerUnit;
