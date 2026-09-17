model FB "Versione dell'antiwindup con PID (back-calculation)"
  Modelica.Blocks.Continuous.FirstOrder plant(T = 10) annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-32, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Continuous.PI PI annotation(
    Placement(visible = true, transformation(origin = {4, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Sources.Step step annotation(
    Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Continuous.PI PI1 annotation(
    Placement(visible = true, transformation(origin = {4, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-32, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Continuous.FirstOrder plant1(T = 10) annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
connect(PI1.u, feedback1.u1) annotation(
    Line(points = {{-8, -30}, {-42, -30}, {-42, -30}, {-40, -30}}, color = {0, 0, 127}));
connect(feedback1.u1, step.y) annotation(
    Line(points = {{-40, -30}, {-50, -30}, {-50, 0}, {-66, 0}, {-66, 0}}, color = {0, 0, 127}));
connect(feedback1.u2, plant1.y) annotation(
    Line(points = {{-32, -38}, {-32, -38}, {-32, -50}, {70, -50}, {70, -30}, {62, -30}, {62, -30}}, color = {0, 0, 127}));
  connect(feedback.u2, plant.y) annotation(
    Line(points = {{-32, 22}, {-32, 22}, {-32, 4}, {72, 4}, {72, 30}, {62, 30}, {62, 30}}, color = {0, 0, 127}));
  connect(feedback.u1, step.y) annotation(
    Line(points = {{-40, 30}, {-50, 30}, {-50, 0}, {-68, 0}, {-68, 0}, {-66, 0}}, color = {0, 0, 127}));
connect(PI1.y, plant1.u) annotation(
    Line(points = {{15, -30}, {37, -30}, {37, -30}, {37, -30}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation(
    Line(points = {{-23, 30}, {-11, 30}, {-11, 30}, {-9, 30}}, color = {0, 0, 127}));
  connect(PI.y, plant.u) annotation(
    Line(points = {{15, 30}, {25, 30}, {25, 30}, {35, 30}, {35, 30}, {36, 30}, {36, 30}, {37, 30}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -60}, {80, 60}})),
    uses(Modelica(version = "3.2.3")),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.4));
end FB;
