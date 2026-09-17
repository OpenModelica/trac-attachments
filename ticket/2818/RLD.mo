model RLD
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 10) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-52, 22})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {28, 34})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-82, -14}, {-62, 6}})));
  Modelica.Electrical.Analog.Basic.Resistor Rload(R = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {28, 4})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Ron = 1e-05, Goff = 0.0001) annotation(Placement(transformation(extent = {{-20, 44}, {0, 64}})));
equation
  connect(idealDiode.p, sineVoltage.p) annotation(Line(points = {{-20, 54}, {-52, 54}, {-52, 32}}, color = {0, 0, 255}));
  connect(ground.p, sineVoltage.n) annotation(Line(points = {{-72, 6}, {-72, 12}, {-52, 12}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(Rload.p, inductor.n) annotation(Line(points = {{28, 14}, {28, 24}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(Rload.n, sineVoltage.n) annotation(Line(points = {{28, -6}, {28, -12}, {-52, -12}, {-52, 12}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(idealDiode.n, inductor.p) annotation(Line(points = {{0, 54}, {28, 54}, {28, 44}}, color = {0, 0, 255}, smooth = Smooth.None));
  annotation(uses(Modelica(version = "3.2")), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 0.1, NumberOfIntervals = 5000));
end RLD;