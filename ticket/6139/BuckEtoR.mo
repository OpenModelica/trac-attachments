model BuckEtoR
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation(
    Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor SW annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(visible = true, transformation(origin = {-50, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.5) annotation(
    Placement(visible = true, transformation(extent = {{8, 10}, {28, 30}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.03) annotation(
    Placement(visible = true, transformation(extent = {{38, 10}, {58, 30}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 100e-6) annotation(
    Placement(visible = true, transformation(origin = {64, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Resistor Load(R = 30) annotation(
    Placement(visible = true, transformation(origin = {82, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.SawTooth sawTooth(period = 1 / 1000) annotation(
    Placement(visible = true, transformation(origin = {30, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold = 0.35) annotation(
    Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-94, -64}, {-74, -44}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PotentialSensor vLoad annotation(
    Placement(visible = true, transformation(origin = {82, 38}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Math.Mean meanU(f = 1000) annotation(
    Placement(visible = true, transformation(origin = {82, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powSens annotation(
    Placement(visible = true, transformation(extent = {{-20, 10}, {0, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Mean meanP(f = 1000) annotation(
    Placement(visible = true, transformation(origin = {-24, -14}, extent = {{8, -8}, {-8, 8}}, rotation = 90)));
equation
  connect(sawTooth.y, lessThreshold.u) annotation(
    Line(points = {{41, 58}, {46, 58}, {46, 40}, {10, 40}, {10, 60}, {2, 60}}, color = {0, 0, 127}));
  connect(lessThreshold.y, SW.fire) annotation(
    Line(points = {{-21, 60}, {-30, 60}, {-30, 40}, {-38, 40}}, color = {255, 0, 255}));
  connect(diode.n, SW.n) annotation(
    Line(points = {{-50, -8}, {-50, 40}}, color = {0, 0, 255}));
  connect(SW.p, V1.p) annotation(
    Line(points = {{-50, 60}, {-50, 68}, {-84, 68}, {-84, 30}}, color = {0, 0, 255}));
  connect(V1.n, diode.p) annotation(
    Line(points = {{-84, 10}, {-84, -40}, {-50, -40}, {-50, -28}}, color = {0, 0, 255}));
  connect(Lf.p, Rf.n) annotation(
    Line(points = {{38, 20}, {28, 20}}, color = {0, 0, 255}));
  connect(Cf.p, Lf.n) annotation(
    Line(points = {{64, 0}, {64, 20}, {58, 20}, {58, 20}}, color = {0, 0, 255}));
  connect(Cf.n, diode.p) annotation(
    Line(points = {{64, -20}, {64, -40}, {-50, -40}, {-50, -28}}, color = {0, 0, 255}));
  connect(ground.p, V1.n) annotation(
    Line(points = {{-84, -44}, {-84, 10}}, color = {0, 0, 255}));
  connect(vLoad.p, Load.p) annotation(
    Line(points = {{82, 30}, {82, -2}}, color = {0, 0, 255}));
  connect(meanU.u, vLoad.phi) annotation(
    Line(points = {{82, 50}, {82, 46.8}}, color = {0, 0, 127}));
  connect(powSens.pv, powSens.pc) annotation(
    Line(points = {{-10, 28}, {-10, 28}, {-20, 28}, {-20, 18}}, color = {0, 0, 255}));
  connect(Load.n, diode.p) annotation(
    Line(points = {{82, -22}, {82, -40}, {-50, -40}, {-50, -28}}, color = {0, 0, 255}));
  connect(meanP.u, powSens.power) annotation(
    Line(points = {{-24, -4.4}, {-24, -4.4}, {-24, 9}, {-20, 9}}, color = {0, 0, 127}));
  connect(powSens.nc, Rf.p) annotation(
    Line(points = {{0, 20}, {0, 20}, {8, 20}}, color = {0, 0, 255}));
  connect(powSens.pc, SW.n) annotation(
    Line(points = {{-20, 20}, {-20, 20}, {-50, 20}, {-50, 40}}, color = {0, 0, 255}));
  connect(powSens.nv, diode.p) annotation(
    Line(points = {{-10, 10}, {-10, 10}, {-10, -40}, {-50, -40}, {-50, -28}}, color = {0, 0, 255}));
  connect(vLoad.p, Lf.n) annotation(
    Line(points = {{82, 30}, {82, 20}, {58, 20}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}}, initialScale = 0.1), graphics = {Text(lineColor = {238, 46, 47}, extent = {{-34, -48}, {72, -74}}, textString = "Es. proposto:    valutare efficienza 
sia così che con 0.8V e 1mOhm di Ron
Potenza utile: su Load", horizontalAlignment = TextAlignment.Right)}),
    experimentSetupOutput,
    experiment(StopTime = 0.03, __Dymola_NumberOfIntervals = 5000),
    Documentation(info = "<html>
<p>Frazionatore abbassatore su carico resistivo con fitro L-C per la regolarizzazione della tensione sul carico.</p>
</html>"));
end BuckEtoR;
