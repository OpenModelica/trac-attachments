model LeadLagDynIEEE "Lag-lead block with non-windup limits according to IEEE 421.5"
  parameter Modelica.SIunits.Time Tu = 1, Td = 1;
  parameter Real yMax = 1, yMin = 1;
  parameter Real K = 1;
  constant Real One = 1;
  parameter Real initialOutput(final fixed = false);
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y(start = 1) annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = One, k2 = One) annotation(
    Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = Tu / Td) annotation(
    Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = yMax, uMin = yMin) annotation(
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = Td / Tu - 1) annotation(
    Placement(visible = true, transformation(origin = {-62, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Continuous.Integrator integrator(k = 1 / Tu, initType = Modelica.Blocks.Types.Init.InitialState, y_start = initialOutput) annotation(
    Placement(transformation(extent = {{0, -56}, {-20, -36}})));
  Modelica.Blocks.Math.Add add1(k1 = One, k2 = -One) annotation(
    Placement(visible = true, transformation(origin = {54, -46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = K) annotation(
    Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  initialOutput = y;
equation
  connect(y, limiter.y) annotation(
    Line(points = {{110, 0}, {61, 0}}, color = {0, 0, 127}));
  connect(gain.u, add.y) annotation(
    Line(points = {{6, 0}, {-11, 0}}, color = {0, 0, 127}));
  connect(limiter.u, gain.y) annotation(
    Line(points = {{38, 0}, {29, 0}}, color = {0, 0, 127}));
  connect(gain1.y, add.u2) annotation(
    Line(points = {{-62, -21}, {-62, -6}, {-34, -6}}, color = {0, 0, 127}));
  connect(add1.u1, limiter.y) annotation(
    Line(points = {{66, -40}, {84, -40}, {84, 0}, {61, 0}}, color = {0, 0, 127}));
  connect(add1.y, integrator.u) annotation(
    Line(points = {{43, -46}, {2, -46}}, color = {0, 0, 127}));
  connect(integrator.y, add1.u2) annotation(
    Line(points = {{-21, -46}, {-34, -46}, {-34, -68}, {78, -68}, {78, -52}, {66, -52}}, color = {0, 0, 127}));
  connect(integrator.y, gain1.u) annotation(
    Line(points = {{-21, -46}, {-42, -46}, {-42, -56}, {-62, -56}, {-62, -44}}, color = {0, 0, 127}));
  connect(gain2.u, u) annotation(
    Line(points = {{-90, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(gain2.y, add.u1) annotation(
    Line(points = {{-67, 0}, {-50, 0}, {-50, 6}, {-34, 6}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-72, -130}, {-12, -130}, {46, 128}, {100, 128}}, color = {0, 0, 0}), Text(extent = {{-128, 142}, {42, 116}}, lineColor = {0, 0, 255}, textString = "%name"), Rectangle(extent = {{-100, 102}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(lineColor = {0, 0, 127}, extent = {{-68, 20}, {110, 58}}, textString = "1+sTu"), Line(points = {{-46, 2}, {90, 2}}, color = {0, 0, 127}), Text(lineColor = {0, 0, 127}, extent = {{-64, -54}, {108, -18}}, textString = "1+sTd"), Text(lineColor = {0, 0, 127}, extent = {{-92, -16}, {-54, 20}}, textString = "K"), Text(lineColor = {238, 46, 47}, extent = {{4, -90}, {100, -82}}, textString = "IEEE")}),
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 20}})),
    Documentation(info = "<html>
<p>Nota:</p>
<p>Le costnati degli Add sono state assegnate attraverso la costante One, invece che lasciarle come valore numerico in modo che esse non saranno visibili nella FMU una volta creata (con Dymola).</p>
<p>Infatti correttamente Dymola non espone a maschera nella FMU le grandezze internamente assegnate con formule matematiche; sono invece esposti tutti i parametri asegnati in modo numerico.</p>
</html>"));
end LeadLagDynIEEE;
