package SemiTest
  extends PowerSystems.Semiconductors;
  import Modelica.Electrical;
  model Switch
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 10) annotation(Placement(visible = true, transformation(origin = {-4, 37}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  PowerSystems.Semiconductors.Ideal.SCswitch GTO1 annotation(Placement(visible = true, transformation(origin = {-39, 37}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCond bdCond1 annotation(Placement(visible = true, transformation(origin = {-4, 61}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground g1 annotation(Placement(visible = true, transformation(origin = {13, -11}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1 annotation(Placement(visible = true, transformation(origin = {-76, 19}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
    connect(R1.heatPort, bdCond1.heat) annotation(Line(points = {{-4, 47}, {-4, 51}}, color = {191, 0, 0}));
    connect(R1.n, g1.p) annotation(Line(points = {{6, 37}, {6, 43.75}, {9, 43.75}, {9, 43.5}, {13, 43.5}, {13, -1}}, color = {0, 0, 255}));
    connect(GTO1.term_n, R1.p) annotation(Line(points = {{-29, 37}, {-14, 37}}, color = {0, 0, 255}));
    connect(GTO1.term_p, V1.p) annotation(Line(points = {{-49, 37}, {-76, 37}, {-76, 29}}, color = {0, 0, 255}));
    connect(V1.n, g1.p) annotation(Line(points = {{-76, 9}, {13, 9}, {13, -1}}, color = {0, 0, 255}));
    annotation(Icon(coordinateSystem(grid = {1, 1})), Diagram(coordinateSystem(grid = {1, 1})));
  end Switch;
equation

  annotation(Icon(coordinateSystem(grid = {1, 1})), Diagram(coordinateSystem(grid = {1, 1})));
end SemiTest;