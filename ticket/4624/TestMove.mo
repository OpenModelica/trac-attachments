encapsulated package TestMove
  import Modelica;
  import RLCPkg;

  model RL_P
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(
      Placement(visible = true, transformation(origin = {64, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Basic.Inductor inductor(L = 10e-3) annotation(
      Placement(visible = true, transformation(origin = {64, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Electrical.Analog.Sensors.PowerSensor pMeas annotation(
      Placement(visible = true, transformation(extent = {{-14, 20}, {6, 40}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(extent = {{-10, -66}, {10, -46}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(
      Placement(visible = true, transformation(origin = {-60, 4}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  equation
    connect(pMeas.pv, pMeas.pc) annotation(
      Line(points = {{-4, 38}, {-14, 38}, {-14, 28}}, color = {0, 0, 255}));
    connect(sineVoltage.p, pMeas.pc) annotation(
      Line(points = {{-60, 14}, {-60, 28}, {-14, 28}}, color = {0, 0, 255}));
    connect(pMeas.nv, inductor.n) annotation(
      Line(points = {{-4, 18}, {-4, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    connect(pMeas.nc, resistor1.p) annotation(
      Line(points = {{6, 28}, {6, 28}, {64, 28}}, color = {0, 0, 255}));
    connect(resistor1.n, inductor.p) annotation(
      Line(points = {{64, 8}, {64, -2}}, color = {0, 0, 255}));
    connect(sineVoltage.n, inductor.n) annotation(
      Line(points = {{-60, -6}, {-60, -6}, {-60, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    connect(ground.p, inductor.n) annotation(
      Line(points = {{0, -46}, {0, -36}, {64, -36}, {64, -22}}, color = {0, 0, 255}));
    annotation(
      experiment(StopTime = 0.1),
      experimentSetupOutput,
      Documentation(info = "<html>
 <p>Misura di potenza attiva e reattiva istantanea su carico RLC</p>
 </html>"),
      Diagram(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1)),
      Icon(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1)));
  end RL_P;

  package ConDiodo
    model RLD
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = 50, V = 100) annotation(
        Placement(visible = true, transformation(origin = {-30, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L = 1e-3, i(fixed = true)) annotation(
        Placement(visible = true, transformation(origin = {30, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation(
        Placement(visible = true, transformation(extent = {{-60, -40}, {-40, -20}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rload(R = 1) annotation(
        Placement(visible = true, transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation(
        Placement(visible = true, transformation(extent = {{-10, 24}, {10, 44}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Resistor Rload1(R = 1e5) annotation(
        Placement(visible = true, transformation(origin = {58, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    equation
      connect(Rload1.n, inductor.n) annotation(
        Line(points = {{58, 2}, {30, 2}}, color = {0, 0, 255}));
      connect(Rload1.p, inductor.p) annotation(
        Line(points = {{58, 22}, {30, 22}}, color = {0, 0, 255}));
      connect(idealDiode.p, sineVoltage.p) annotation(
        Line(points = {{-10, 34}, {-20, 34}, {-30, 34}, {-30, 23}, {-30, 14}}, color = {0, 0, 255}));
      connect(idealDiode.n, inductor.p) annotation(
        Line(points = {{10, 34}, {20, 34}, {30, 34}, {30, 27}, {30, 22}}, color = {0, 0, 255}));
      connect(Rload.n, sineVoltage.n) annotation(
        Line(points = {{30, -30}, {30, -35}, {30, -35}, {30, -38}, {-30, -38}, {-30, -23}, {-30, -23}, {-30, -6}}, color = {0, 0, 255}));
      connect(Rload.p, inductor.n) annotation(
        Line(points = {{30, -10}, {30, -6}, {30, -2}, {30, 2}}, color = {0, 0, 255}));
      connect(ground.p, sineVoltage.n) annotation(
        Line(points = {{-50, -20}, {-50, -6}, {-30, -6}}, color = {0, 0, 255}));
      annotation(
        experiment(StopTime = 0.06),
        __Dymola_experimentSetupOutput,
        Diagram(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
        Icon(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end RLD;
  end ConDiodo;
  annotation(
    uses(Modelica(version = "3.2.2")));
end TestMove;
