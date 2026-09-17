model test
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
    Placement(visible = true, transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1 annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

  Real a,b;
equation
  /*
  for i in 1:2 loop
    a = b;
  end for;*/
  connect(resistor1.n, ground2.p) annotation(
    Line(points = {{30, 0}, {30, 0}, {30, -20}, {30, -20}}, color = {0, 0, 255}));
  connect(capacitor1.p, resistor1.p) annotation(
    Line(points = {{-30, 20}, {-30, 20}, {-30, 30}, {30, 30}, {30, 20}, {30, 20}}, color = {0, 0, 255}));
  connect(capacitor1.n, ground1.p) annotation(
    Line(points = {{-30, 0}, {-30, 0}, {-30, -20}, {-30, -20}}, color = {0, 0, 255}));
  
  annotation(
    uses(Modelica(version = "3.2.2")));
end test;
