encapsulated package RLCPkg "RLC with P-Q"
  import Modelica;

  model RLC
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 1, freqHz = 50) annotation(
      Placement(visible = true, transformation(origin = {-42, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(extent = {{-10, 30}, {10, 50}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 10e-6) annotation(
      Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.01) annotation(
      Placement(visible = true, transformation(origin = {50, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(extent = {{-72, -46}, {-52, -26}}, rotation = 0)));
  equation
    connect(ground.p, sineVoltage.n) annotation(
      Line(points = {{-62, -26}, {-62, -8}, {-42, -8}}, color = {0, 0, 255}));
    connect(inductor.n, capacitor.p) annotation(
      Line(points = {{50, -2}, {50, -20}}, color = {0, 0, 255}));
    connect(inductor.p, resistor.n) annotation(
      Line(points = {{50, 18}, {50, 40}, {10, 40}}, color = {0, 0, 255}));
    connect(sineVoltage.n, capacitor.n) annotation(
      Line(points = {{-42, -8}, {-42, -40}, {50, -40}}, color = {0, 0, 255}));
    connect(resistor.p, sineVoltage.p) annotation(
      Line(points = {{-10, 40}, {-42, 40}, {-42, 12}}, color = {0, 0, 255}));
    annotation(
      experiment(StopTime = 0.1, __Dymola_NumberOfIntervals = 5000),
      experimentSetupOutput,
      Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
      Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end RLC;
  annotation(
    uses(Modelica(version = "3.2.2")));
end RLCPkg;
