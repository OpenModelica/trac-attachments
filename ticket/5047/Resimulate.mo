package Resimulate



  model RL1
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1)  annotation(
      Placement(visible = true, transformation(origin = {-18, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {38, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 1)  annotation(
      Placement(visible = true, transformation(origin = {-66, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {-66, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor1.p, constantVoltage1.p) annotation(
      Line(points = {{-28, 36}, {-66, 36}, {-66, 28}}, color = {0, 0, 255}));
    connect(resistor1.n, inductor1.p) annotation(
      Line(points = {{-8, 36}, {38, 36}, {38, 16}}, color = {0, 0, 255}));
    connect(ground1.p, constantVoltage1.n) annotation(
      Line(points = {{-66, -22}, {-66, -22}, {-66, 8}, {-66, 8}}, color = {0, 0, 255}));
    connect(constantVoltage1.n, inductor1.n) annotation(
      Line(points = {{-66, 8}, {-66, 8}, {-66, -14}, {38, -14}, {38, -4}, {38, -4}}, color = {0, 0, 255}));
  annotation(
      Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-07, Interval = 0.002));end RL1;


  model RL2
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-18, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 0.1) annotation(
      Placement(visible = true, transformation(origin = {38, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 1)  annotation(
      Placement(visible = true, transformation(origin = {-66, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {-66, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor1.p, constantVoltage1.p) annotation(
      Line(points = {{-28, 36}, {-66, 36}, {-66, 28}}, color = {0, 0, 255}));
    connect(resistor1.n, inductor1.p) annotation(
      Line(points = {{-8, 36}, {38, 36}, {38, 16}}, color = {0, 0, 255}));
    connect(ground1.p, constantVoltage1.n) annotation(
      Line(points = {{-66, -22}, {-66, -22}, {-66, 8}, {-66, 8}}, color = {0, 0, 255}));
    connect(constantVoltage1.n, inductor1.n) annotation(
      Line(points = {{-66, 8}, {-66, 8}, {-66, -14}, {38, -14}, {38, -4}, {38, -4}}, color = {0, 0, 255}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
      experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-07, Interval = 0.004));
  end RL2;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(Modelica(version = "3.2.2")));
end Resimulate;
