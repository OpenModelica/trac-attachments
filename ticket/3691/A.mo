model A
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-76, -76}, {-56, -56}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{46, -76}, {66, -56}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation(Placement(transformation(extent = {{-34, 30}, {-14, 50}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {50, 8})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor annotation(Placement(transformation(extent = {{20, 32}, {40, 52}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1 annotation(Placement(transformation(extent = {{22, 56}, {42, 76}})));
  Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-66, -12})));
equation
  connect(ground.p, stepVoltage.n) annotation(Line(points = {{-66, -56}, {-66, -22}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(stepVoltage.p, resistor.p) annotation(Line(points = {{-66, -2}, {-64, -2}, {-64, 40}, {-34, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(resistor.n, capacitor.p) annotation(Line(points = {{-14, 40}, {-2, 40}, {-2, 38}, {20, 38}, {20, 42}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(capacitor.p, capacitor1.p) annotation(Line(points = {{20, 42}, {22, 42}, {22, 66}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(capacitor1.n, capacitor.n) annotation(Line(points = {{42, 66}, {44, 66}, {44, 42}, {40, 42}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(capacitor.n, resistor1.p) annotation(Line(points = {{40, 42}, {50, 42}, {50, 18}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(resistor1.n, ground1.p) annotation(Line(points = {{50, -2}, {50, -56}, {56, -56}}, color = {0, 0, 255}, smooth = Smooth.None));
  annotation(uses(Modelica(version = "3.2.1")), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end A;
