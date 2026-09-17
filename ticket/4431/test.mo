model test "Simulates a very basic Electric Vehicle"
  import Modelica;
  Modelica.Mechanics.Rotational.Components.IdealGear myGear(ratio = 6) annotation(
    Placement(visible = true, transformation(origin = {8, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(visible = true, transformation(extent = {{-58, -10}, {-38, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1400) annotation(
    Placement(visible = true, transformation(extent = {{60, -10}, {80, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.5715) annotation(
    Placement(visible = true, transformation(extent = {{26, -10}, {46, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 5) annotation(
    Placement(visible = true, transformation(extent = {{-30, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1 annotation(
    Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step1.y, torque.tau) annotation(
    Line(points = {{-71, 0}, {-63, 0}, {-63, 0}, {-61, 0}}, color = {0, 0, 127}));
  connect(inertia.flange_a, torque.flange) annotation(
    Line(points = {{-30, 0}, {-34, 0}, {-38, 0}}));
  connect(inertia.flange_b, myGear.flange_a) annotation(
    Line(points = {{-10, 0}, {-2, 0}}));
  connect(myGear.flange_b, wheel.flangeR) annotation(
    Line(points = {{18, 0}, {18, 0}, {26, 0}}));
  connect(mass.flange_a, wheel.flangeT) annotation(
    Line(points = {{60, 0}, {46, 0}}, color = {0, 127, 0}));
  annotation(
    experimentSetupOutput(derivatives = false),
    Documentation(info = "<html>
             <p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2015-16.</p>
              <p>OM 23136 OK </p>
             </html>"),
    Commands,
    experiment(StartTime = 0, StopTime = 200, Tolerance = 0.0001, Interval = 0.1),
  Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}}, preserveAspectRatio = false)),
    Icon(coordinateSystem(extent = {{-120, -40}, {120, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version = "3.2.2")),
  version = "",
  __OpenModelica_commandLineOptions = "");
end test;
