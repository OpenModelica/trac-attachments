model Connections_
  Modelica.Icons.SignalBus signalBus1 annotation (
    Placement(visible = true, transformation(origin = {-42, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-42, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Icons.SignalBus signalBus2 annotation (
    Placement(visible = true, transformation(origin = {38, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {38, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1 annotation (
    Placement(visible = true, transformation(origin = {-50, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator1 annotation (
    Placement(visible = true, transformation(origin = {32, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Icons.SignalBus signalBus3 annotation (
    Placement(visible = true, transformation(origin = {-38, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-38, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Icons.SignalBus signalBus4 annotation (
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step2 annotation (
    Placement(visible = true, transformation(origin = {-42, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator2 annotation (
    Placement(visible = true, transformation(origin = {36, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step1.y, integrator1.u) annotation (
    Line(points={{-39,-56},{-11,-56},{-11,-66},{20,-66}},          color = {0, 0, 127}));
  connect(step2.y, integrator2.u) annotation (
    Line(points={{-31,-20},{24,-20},{24,-20},{24,-20}},          color = {0, 0, 127}));
  connect(signalBus3, signalBus4) annotation (
    Line(points = {{-38, 18}, {40, 18}, {40, 20}, {40, 20}}, color = {255, 204, 51}, thickness = 0.5));
  connect(signalBus1, signalBus2) annotation (
    Line(points={{-42,72},{-4,72},{-4,62},{38,62}},          color = {255, 204, 51}, thickness = 0.5));
annotation (
    uses(Modelica(version = "3.2.2")));
end Connections_;
