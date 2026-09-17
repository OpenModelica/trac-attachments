model epc4
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 10) annotation(Placement(visible = true, transformation(origin = {-26.4214,57.5251}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 1) annotation(Placement(visible = true, transformation(origin = {11.7057,57.1906}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C = 0.00001) annotation(Placement(visible = true, transformation(origin = {37.4582,30.4348}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanstep1 annotation(Placement(visible = true, transformation(origin = {53.8462,81.2709}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealopeningswitch1 annotation(Placement(visible = true, transformation(origin = {72.2408,30.4348}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage1(V = 311, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-56.5217,30.4348}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-81.6054,-2.67559}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(booleanstep1.y,idealopeningswitch1.control) annotation(Line(points = {{64.8462,81.2709},{88.2943,81.2709},{88.2943,30.1003},{79.2408,30.1003},{79.2408,30.4348}}, color = {255,0,255}));
  connect(ground1.p,sinevoltage1.n) annotation(Line(points = {{-81.6054,7.32441},{-81.2709,7.32441},{-81.2709,20.4013},{-56.5217,20.4013},{-56.5217,20.4013}}));
  connect(capacitor1.n,sinevoltage1.n) annotation(Line(points = {{37.4582,20.4348},{37.4582,-5.68562},{-56.5217,-5.68562},{-56.5217,4.71572},{-56.5217,20.4348}}));
  connect(sinevoltage1.p,resistor1.p) annotation(Line(points = {{-56.5217,40.4348},{-56.5217,57.5251},{-36.4214,57.5251},{-36.4214,57.5251}}));
  connect(idealopeningswitch1.n,capacitor1.n) annotation(Line(points = {{72.2408,20.4348},{72.2408,20.7358},{37.1237,20.7358},{37.1237,20.7358}}));
  connect(capacitor1.p,idealopeningswitch1.p) annotation(Line(points = {{37.4582,40.4348},{37.4582,40.4682},{72.9097,40.4682},{72.9097,40.4682}}));
  connect(inductor1.n,capacitor1.p) annotation(Line(points = {{21.7057,57.1906},{37.1237,57.1906},{37.1237,40.1338},{37.1237,40.1338}}));
  connect(resistor1.n,inductor1.p) annotation(Line(points = {{-16.4214,57.5251},{1.67224,57.5251},{1.67224,56.8562},{1.67224,56.8562}}));
end epc4;

