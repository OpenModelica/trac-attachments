model Test
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-38, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor C(C = 1e-6)  annotation(
    Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineVoltage source(V = 1, freqHz = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-38, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(C.n, ground.p) annotation(
    Line(points = {{14, -10}, {14, -10}, {14, -26}, {-38, -26}, {-38, -26}}, color = {0, 0, 255}));
  connect(R.n, C.p) annotation(
    Line(points = {{0, 22}, {14, 22}, {14, 10}, {14, 10}}, color = {0, 0, 255}));
  connect(source.p, R.p) annotation(
    Line(points = {{-38, 4}, {-38, 4}, {-38, 22}, {-20, 22}, {-20, 22}}, color = {0, 0, 255}));
  connect(ground.p, source.n) annotation(
    Line(points = {{-38, -26}, {-38, -26}, {-38, -16}, {-38, -16}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.2")));
end Test;
