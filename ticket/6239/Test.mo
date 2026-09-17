model Test
Modelica.Electrical.Analog.Sources.SineVoltage E1(V = 100, freqHz = 0.5, phase = 0)  annotation(
    Placement(visible = true, transformation(origin = {-26, 24}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
Modelica.Electrical.Analog.Sources.SineVoltage E2(V = 100, freqHz = 0.5, phase = 2.094395102393195)  annotation(
    Placement(visible = true, transformation(origin = {-26, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
Modelica.Electrical.Analog.Sources.SineVoltage E3(V = 100, freqHz = 0.5, phase = 4.188790204786391)  annotation(
    Placement(visible = true, transformation(origin = {-26, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {34, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1) annotation(
    Placement(visible = true, transformation(origin = {2, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R3(R = 1) annotation(
    Placement(visible = true, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R2(R = 1) annotation(
    Placement(visible = true, transformation(origin = {2, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(E1.n, E2.n) annotation(
    Line(points = {{-36, 24}, {-36, -2}}, color = {0, 0, 255}));
  connect(E2.n, E3.n) annotation(
    Line(points = {{-36, -2}, {-36, -28}}, color = {0, 0, 255}));
  connect(E1.p, R1.p) annotation(
    Line(points = {{-16, 24}, {-8, 24}}, color = {0, 0, 255}));
  connect(E2.p, R2.p) annotation(
    Line(points = {{-16, -2}, {-8, -2}}, color = {0, 0, 255}));
  connect(E3.p, R3.p) annotation(
    Line(points = {{-16, -28}, {-10, -28}}, color = {0, 0, 255}));
  connect(R1.n, R2.n) annotation(
    Line(points = {{12, 24}, {22, 24}, {22, -2}, {12, -2}}, color = {0, 0, 255}));
  connect(R3.n, R2.n) annotation(
    Line(points = {{10, -28}, {22, -28}, {22, -2}, {12, -2}}, color = {0, 0, 255}));
  connect(R3.n, ground.p) annotation(
    Line(points = {{10, -28}, {34, -28}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.002),
    uses(Modelica(version = "3.2.3")));
end Test;
