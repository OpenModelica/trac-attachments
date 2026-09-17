encapsulated package Rpkg
  import Modelica;

  model ER
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-42, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1) annotation(Placement(visible = true, transformation(origin = {2, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(extent = {{-52, -50}, {-32, -30}}, rotation = 0)));
  equation
    connect(resistor.p, sineVoltage.p) annotation(Line(points = {{2, 12}, {3, 12}, {3, 28}, {-42, 28}, {-42, 12}}, color = {0, 0, 255}));
    connect(sineVoltage.n, resistor.n) annotation(Line(points = {{-42, -8}, {-42, -20}, {2, -20}, {2, -8}}, color = {0, 0, 255}));
    connect(ground.p, sineVoltage.n) annotation(Line(points = {{-42, -30}, {-42, -8}}, color = {0, 0, 255}));
    annotation(experiment(StopTime = 0.1), experimentSetupOutput, Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ER;

model SimpleR "Ideal resistor"
  parameter Modelica.SIunits.Resistance R(start = 1) "Resistance";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
equation
  v = R * i;
  annotation( 
  Icon(coordinateSystem(initialScale = 0.1),
   graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 30}, {70, -30}}), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(origin = {0, 6}, extent = {{-144, -40}, {142, -72}}, textString = "R=%R"), Text(origin = {-2, -6},lineColor = {0, 0, 255}, extent = {{-152, 87}, {148, 47}}, textString = "%name")}), 
    Diagram(coordinateSystem(initialScale = 0.1), 
      graphics = {Rectangle(lineColor = {0, 0, 255}, 
      fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid,
      extent = {{-70, 30}, {70, -30}}), Line(points = {{-96, 0}, {-70, 0}}, color = {0, 0, 255}), 
      Line(points = {{70, 0}, {96, 0}}, color = {0, 0, 255}), 
      Text(origin = {-13, 64}, lineColor = {0, 0, 255}, 
      fillColor = {0, 0, 255}, extent = {{-71, 20}, {87, -14}}, textString = "&name")}));
end SimpleR;
  annotation(uses(Modelica(version = "3.2.1")));
end Rpkg;