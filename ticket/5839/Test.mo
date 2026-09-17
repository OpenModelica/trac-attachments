model Test
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 1, freqHz = 50)  annotation(
    Placement(visible = true, transformation(origin = {-80, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 2)  annotation(
    Placement(visible = true, transformation(origin = {-18, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 20) annotation(
    Placement(visible = true, transformation(origin = {-50, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(resistor.n, ground.p) annotation(
    Line(points = {{-18, -18}, {-18, -26}, {-50, -26}}, color = {0, 0, 255}));
  connect(resistor1.n, ground.p) annotation(
    Line(points = {{-50, -18}, {-50, -26}}, color = {0, 0, 255}));
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-80, -16}, {-80, -26}, {-50, -26}}, color = {0, 0, 255}));
  connect(sineVoltage.p, resistor.p) annotation(
    Line(points = {{-80, 4}, {-80, 12}, {-18, 12}, {-18, 2}}, color = {0, 0, 255}));
  connect(resistor1.p, sineVoltage.p) annotation(
    Line(points = {{-50, 2}, {-50, 12}, {-80, 12}, {-80, 4}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "3.2.3")),
    Diagram(coordinateSystem(extent = {{-100, 20}, {0, -60}})),
    version = "",
  experiment(StartTime = 0, StopTime = 0.05, Tolerance = 1e-6, Interval = 0.0001));
end Test;
