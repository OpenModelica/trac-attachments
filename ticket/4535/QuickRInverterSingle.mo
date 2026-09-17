model QuickRInverterSingle "single phase: singularity when ground between inductors"
  import Modelica.SIunits.{Frequency,Voltage,Resistance,Inductance};
  parameter Frequency f_grid = 50 "grid frequency";
  parameter Voltage Vg = 230 * sqrt(2) "Grid amplitude voltage";
  parameter Resistance Rf = 100e-3 "filter resistance";
  parameter Inductance Lf = 0.2 "filter inductance";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 100) annotation(
    Placement(visible = true, transformation(origin = {-80, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor Lfa(L = Lf) annotation(
    Placement(visible = true, transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground neutral annotation(
    Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Inductor Lfb(L = Lf) annotation(
    Placement(visible = true, transformation(origin = {36, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor R2(R = 1e5) annotation(
    Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor R3(R = 1e5) annotation(
    Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor R4(R = 1e5) annotation(
    Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(neutral.p, Lfa.n) annotation(
    Line(points = {{74, 0}, {60, 0}, {60, 10}, {46, 10}, {46, 10}, {46, 10}}, color = {0, 0, 255}));
  connect(Lfb.p, R3.n) annotation(
    Line(points = {{26, -10}, {0, -10}, {0, 20}, {0, 20}}, color = {0, 0, 255}));
  connect(Lfa.p, R1.n) annotation(
    Line(points = {{26, 10}, {-40, 10}, {-40, 20}, {-40, 20}}, color = {0, 0, 255}));
  connect(R3.n, R4.p) annotation(
    Line(points = {{0, 20}, {0, 20}, {0, -20}, {0, -20}}, color = {0, 0, 255}));
  connect(R1.n, R2.p) annotation(
    Line(points = {{-40, 20}, {-40, 20}, {-40, -20}, {-40, -20}}, color = {0, 0, 255}));
  connect(R2.n, constantVoltage1.n) annotation(
    Line(points = {{-40, -40}, {-40, -40}, {-40, -60}, {-80, -60}, {-80, -20}, {-80, -20}}, color = {0, 0, 255}));
  connect(constantVoltage1.n, R4.n) annotation(
    Line(points = {{-80, -20}, {-80, -20}, {-80, -60}, {0, -60}, {0, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(R1.p, constantVoltage1.p) annotation(
    Line(points = {{-40, 40}, {-40, 40}, {-40, 50}, {-80, 50}, {-80, 0}, {-80, 0}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, R3.p) annotation(
    Line(points = {{-80, 0}, {-80, 0}, {-80, 50}, {0, 50}, {0, 40}, {0, 40}}, color = {0, 0, 255}));
  connect(Lfb.n, Lfa.n) annotation(
    Line(points = {{46, -10}, {60, -10}, {60, 10}, {46, 10}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {150, 100}}, initialScale = 0.1), graphics = {Text(origin = {23, 83}, extent = {{-113, 9}, {113, -9}}, textString = "singularity for R1.p.v 
 when ground is placed between the two inductors")}),
    Icon(coordinateSystem(extent = {{-100, -100}, {150, 100}})),
    __OpenModelica_commandLineOptions = "",
    uses(Modelica(version = "3.2.2")));
end QuickRInverterSingle;