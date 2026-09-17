model EVbasic "Simulates a very basic Electric Vehicle"
  Modelica.SIunits.Energy enDrag(start = 0), enDC(start = 0);
  wbEHPTlib.SupportModels.Miscellaneous.DragForce dragF(m = mass.m, rho(displayUnit = "kg/m3") = 1.226, fc = 0.014, Cx = 0.26, S = 2.2) annotation(
    Placement(visible = true, transformation(origin = {104, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 3.905) annotation(
    Placement(visible = true, transformation(origin = {-26, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  wbEHPTlib.SupportModels.Miscellaneous.PropDriver driver(yMax = 100000.0, CycleFileName = "WLTC3.txt", k = 100) annotation(
    Placement(visible = true, transformation(extent = {{-130, -28}, {-110, -8}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powDrag annotation(
    Placement(visible = true, transformation(origin = {104, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation(
    Placement(visible = true, transformation(origin = {28, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1300) annotation(
    Placement(visible = true, transformation(extent = {{46, -6}, {66, 14}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation(
    Placement(visible = true, transformation(origin = {78, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation(
    Placement(visible = true, transformation(extent = {{-8, -6}, {12, 14}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor motSpeed annotation(
    Placement(visible = true, transformation(origin = {-40, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  wbEHPTlib.MapBased.OneFlange mot(J = 0.2, effTableName = "effTable", mapsFileName = "EVmaps.txt", mapsOnFile = true, powMax = 50e3, tauMax = 200, wMax = 1000) annotation(
    Placement(visible = true, transformation(origin = {-62, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage iDC(V = 400) annotation(
    Placement(visible = true, transformation(origin = {-108, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-128, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor pDC annotation(
    Placement(visible = true, transformation(origin = {-88, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator toEnDrag annotation(
    Placement(visible = true, transformation(origin = {110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(toEnDrag.u, powDrag.power) annotation(
    Line(points = {{98, 24}, {92, 24}, {92, 2}, {94, 2}}, color = {0, 0, 127}));
  der(enDrag) = powDrag.power;
  der(enDC) = pDC.power;
  connect(pDC.nc, mot.pin_p) annotation(
    Line(points = {{-78, 36}, {-78, 22}, {-72, 22}, {-72, 7.33333}}, color = {0, 0, 255}));
  connect(pDC.nv, mot.pin_n) annotation(
    Line(points = {{-88, 26}, {-88, -1.55556}, {-72, -1.55556}}, color = {0, 0, 255}));
  connect(iDC.p, pDC.pv) annotation(
    Line(points = {{-108, 36}, {-108, 46}, {-88, 46}}, color = {0, 0, 255}));
  connect(iDC.p, pDC.pc) annotation(
    Line(points = {{-108, 36}, {-98, 36}}, color = {0, 0, 255}));
  connect(ground.p, iDC.n) annotation(
    Line(points = {{-128, 18}, {-118, 18}, {-118, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(iDC.n, mot.pin_n) annotation(
    Line(points = {{-108, 16}, {-99, 16}, {-99, -1.55556}, {-72, -1.55556}}, color = {0, 0, 255}));
  connect(driver.V, velSens.v) annotation(
    Line(points = {{-120, -29.2}, {-120, -52}, {78, -52}, {78, -37}}, color = {0, 0, 127}));
  connect(mot.flange_a, gear.flange_a) annotation(
    Line(points = {{-52, 2.88889}, {-38, 2.88889}, {-38, 4}, {-36, 4}, {-36, 4}, {-36, 4}}));
  connect(motSpeed.flange, gear.flange_a) annotation(
    Line(points = {{-40, -8}, {-40, 4}, {-36, 4}}));
  connect(gear.flange_b, wheel.flangeR) annotation(
    Line(points = {{-16, 4}, {-16, 4}, {-8, 4}}));
  connect(mP1.flange_a, wheel.flangeT) annotation(
    Line(points = {{18, 4}, {12, 4}}, color = {0, 127, 0}));
  connect(velSens.flange, powDrag.flange_a) annotation(
    Line(points = {{78, -16}, {78, 4}, {104, 4}}, color = {0, 127, 0}));
  connect(powDrag.flange_a, mass.flange_b) annotation(
    Line(points = {{104, 4}, {66, 4}}, color = {0, 127, 0}));
  connect(mass.flange_a, mP1.flange_b) annotation(
    Line(points = {{46, 4}, {38, 4}}, color = {0, 127, 0}));
  connect(dragF.flange, powDrag.flange_b) annotation(
    Line(points = {{104, -36}, {104, -16}}, color = {0, 127, 0}));
  connect(mot.tauRef, driver.tauRef) annotation(
    Line(points = {{-73.4, 2.88889}, {-73.4, 4}, {-82, 4}, {-82, -18}, {-109, -18}}, color = {0, 0, 127}));
  annotation(
    experimentSetupOutput(derivatives = false),
    Documentation(info = "<html>
             <p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2015-16.</p>
              <p>OM 23136 OK </p>
             </html>"),
    Commands,
    Icon(coordinateSystem(extent = {{-120, -60}, {120, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StopTime = 1800, Interval = 0.1, StartTime = 0, Tolerance = 1e-06),
    Diagram(coordinateSystem(extent = {{-140, -60}, {120, 60}}, preserveAspectRatio = false), graphics = {Text(extent = {{46, 52}, {98, 40}}, lineColor = {238, 46, 47}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, horizontalAlignment = TextAlignment.Left, textString = "120 Wh/km con NEDC
100 Wh/km su parte urbana NEDC
137 Wh/km su WLTC3"), Text(extent = {{-52, 46}, {10, 42}}, lineColor = {0, 0, 255}, textString = "Sort1: 150s;  NEDC: 1184 s;  WLTC3: 1800 s.")}),
    __OpenModelica_commandLineOptions = "");
end EVbasic;
