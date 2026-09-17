package Windows
  model Wiindow1
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage annotation(
      Placement(visible = true, transformation(origin = {-172, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation(
      Placement(visible = true, transformation(origin = {152, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(constantVoltage.p, ground.p) annotation(
      Line(points = {{-172, -10}, {-172, -10}, {-172, -26}, {-172, -26}}, color = {0, 0, 255}));
  connect(ground.p, resistor.n) annotation(
      Line(points = {{-172, -26}, {152, -26}, {152, -10}, {152, -10}}, color = {0, 0, 255}));
  connect(resistor.p, constantVoltage.n) annotation(
      Line(points = {{152, 10}, {152, 10}, {152, 20}, {-172, 20}, {-172, 10}, {-172, 10}}, color = {0, 0, 255}));
  annotation(
      Diagram(coordinateSystem(extent = {{-180, -100}, {160, 100}})));end Wiindow1;

  model Window2
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-46, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage annotation(
      Placement(visible = true, transformation(origin = {-46, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor annotation(
      Placement(visible = true, transformation(origin = {66, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(resistor.p, constantVoltage.n) annotation(
      Line(points = {{66, 22}, {66, 28}, {-46, 28}, {-46, 20}}, color = {0, 0, 255}));
    connect(ground.p, resistor.n) annotation(
      Line(points = {{-46, -16}, {66, -16}, {66, 2}}, color = {0, 0, 255}));
    connect(constantVoltage.p, ground.p) annotation(
      Line(points = {{-46, 0}, {-46, -16}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(extent = {{-60, -40}, {80, 40}})));end Window2;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(Modelica(version = "3.2.3")));
end Windows;
