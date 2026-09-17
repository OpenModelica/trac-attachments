encapsulated package TestSave
  import Modelica;

  model RLC
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-42, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(Placement(visible = true, transformation(extent = {{-10, 30}, {10, 50}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 10e-6) annotation(Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 0.01) annotation(Placement(visible = true, transformation(origin = {50, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-72, -46}, {-52, -26}}, rotation = 0)));
  equation
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-62, -26}, {-62, -8}, {-42, -8}}, color = {0, 0, 255}));
    connect(inductor.n, capacitor.p) annotation(Line(points = {{50, -2}, {50, -20}}, color = {0, 0, 255}));
    connect(inductor.p, resistor.n) annotation(Line(points = {{50, 18}, {50, 40}, {10, 40}}, color = {0, 0, 255}));
    connect(sineVoltage.n, capacitor.n) annotation(Line(points = {{-42, -8}, {-42, -40}, {50, -40}}, color = {0, 0, 255}));
    connect(resistor.p, sineVoltage.p) annotation(Line(points = {{-10, 40}, {-42, 40}, {-42, 12}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end RLC;

  model RLD
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(Placement(visible = true, transformation(origin = {-30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 1e-3, i(fixed = true)) annotation(Placement(visible = true, transformation(origin = {30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-60, -40}, {-40, -20}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rload(R = 1) annotation(Placement(visible = true, transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(Placement(visible = true, transformation(extent = {{-10, 24}, {10, 44}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Resistor Rload1(R = 1e5) annotation(Placement(visible = true, transformation(origin = {58, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  equation
    connect(Rload1.n, inductor.n) annotation(Line(points = {{58, 2}, {30, 2}}, color = {0, 0, 255}));
    connect(Rload1.p, inductor.p) annotation(Line(points = {{58, 22}, {30, 22}}, color = {0, 0, 255}));
    connect(idealDiode.p, sineVoltage.p) annotation(Line(points = {{-10, 34}, {-20, 34}, {-20, 34}, {-30, 34}, {-30, 23}, {-30, 23}, {-30, 14}}, color = {0, 0, 255}));
    connect(idealDiode.n, inductor.p) annotation(Line(points = {{10, 34}, {20, 34}, {20, 34}, {30, 34}, {30, 27}, {30, 27}, {30, 22}}, color = {0, 0, 255}));
    connect(Rload.n, sineVoltage.n) annotation(Line(points = {{30, -30}, {30, -35}, {30, -35}, {30, -38}, {-30, -38}, {-30, -23}, {-30, -23}, {-30, -6}}, color = {0, 0, 255}));
    connect(Rload.p, inductor.n) annotation(Line(points = {{30, -10}, {30, -6}, {30, -6}, {30, -2}, {30, 2}, {30, 2}, {30, 2}, {30, 2}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-50, -20}, {-50, -6}, {-30, -6}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.06), __Dymola_experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end RLD;
  annotation(uses(Modelica(version = "3.2.1")));
end TestSave;