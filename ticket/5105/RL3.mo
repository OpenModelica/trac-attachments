model RL3
  Modelica.Electrical.MultiPhase.Sources.ConstantVoltage constV(V = fill(1, 3))  annotation(
    Placement(visible = true, transformation(origin = {-40, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Star star1 annotation(
    Placement(visible = true, transformation(origin = {-40, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(R = fill(1, 3))  annotation(
    Placement(visible = true, transformation(origin = {10, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductor1(L = fill(0.01, 3))  annotation(
    Placement(visible = true, transformation(origin = {40, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-16, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(star1.pin_n, ground1.p) annotation(
    Line(points = {{-40, -38}, {-16, -38}, {-16, -38}, {-16, -38}}, color = {0, 0, 255}));
  connect(inductor1.plug_n, constV.plug_n) annotation(
    Line(points = {{40, -14}, {-40, -14}, {-40, -2}, {-40, -2}}, color = {0, 0, 255}));
  connect(resistor1.plug_n, inductor1.plug_p) annotation(
    Line(points = {{20, 26}, {40, 26}, {40, 6}, {40, 6}}, color = {0, 0, 255}));
  connect(constV.plug_p, resistor1.plug_p) annotation(
    Line(points = {{-40, 18}, {-40, 18}, {-40, 26}, {0, 26}, {0, 26}}, color = {0, 0, 255}));
  connect(constV.plug_n, star1.plug_p) annotation(
    Line(points = {{-40, -2}, {-40, -2}, {-40, -18}, {-40, -18}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "trunk")),
    Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
    end RL3;
