model TestConnection
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capacitor annotation(
    Placement(visible = true, transformation(origin = {30, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(resistor.n, capacitor.port) annotation(
    Line(points = {{10, 0}, {30, 0}, {30, 12}, {30, 12}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "3.2.3")));end TestConnection;
