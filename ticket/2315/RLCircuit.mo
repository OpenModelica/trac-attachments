model RLCircuit
  Modelica.Electrical.Analog.Basic.Ground G1 annotation(Placement(visible = true, transformation(origin = {-66.2093,-10.2916}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor L1(L = 1) annotation(Placement(visible = true, transformation(origin = {3.77358,49.3997}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage AC annotation(Placement(visible = true, transformation(origin = {-66.0333,27.0784}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 100) annotation(Placement(visible = true, transformation(origin = {-26.072,49.0566}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(G1.p,AC.n) annotation(Line(points = {{-66.2093,-0.2916},{-66.2093,-0.2916},{-66.2093,17.4957},{-66.2093,17.4957}}));
  connect(L1.n,AC.n) annotation(Line(points = {{13.7736,49.3997},{18.8679,49.3997},{18.8679,16.8096},{-66.2093,16.8096},{-66.2093,16.8096}}));
  connect(R1.n,L1.p) annotation(Line(points = {{-16.072,49.0566},{-6.86106,49.0566},{-6.86106,49.7427},{-6.86106,49.7427}}));
  connect(AC.p,R1.p) annotation(Line(points = {{-66.0333,37.0784},{-66.0333,49.0566},{-36.7067,49.0566},{-36.7067,49.0566}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end RLCircuit;

