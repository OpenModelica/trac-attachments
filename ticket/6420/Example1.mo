model Example1
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-30, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ground.p, constantVoltage.n) annotation(
    Line(points = {{-30, -32}, {-30, -10}}, color = {0, 0, 255}));
  connect(constantVoltage.p, currentSensor.p) annotation(
    Line(points = {{-30, 10}, {-30, 20}, {-10, 20}}, color = {0, 0, 255}));
  connect(currentSensor.n, resistor.p) annotation(
    Line(points = {{10, 20}, {30, 20}, {30, 10}}, color = {0, 0, 255}));
  connect(currentSensor.p, currentSensor.n) annotation(
    Line(points = {{-10, 20}, {10, 20}}, color = {0, 0, 255}));
  connect(ground.p, resistor.p) annotation(
    Line(points = {{-30, -32}, {-30, -20}, {30, -20}, {30, 10}}, color = {0, 0, 255}));
annotation(
    uses(Modelica(version = "3.2.3")));
end Example1;