model VarLenLine "Variable-length Two-wire line trunk (resistances, inductances with coupling)"
  Modelica.Blocks.Interfaces.RealInput len "line length (m)" annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -100}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -80})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pPin[N] annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 12}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin nPin[N] annotation(
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Real x;
  parameter Real p=1;
equation
  x=p;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Ellipse(extent = {{-60, -55}, {-30, -25}}, lineColor = {85, 170, 255}), 
    Ellipse(extent = {{-30, -55}, {0, -25}}, lineColor = {85, 170, 255}),
        Ellipse(extent = {{0, -55}, {30, -25}}, lineColor = {85, 170, 255}), Ellipse(extent = {{30, -55}, {60, -25}}, lineColor = {85, 170, 255}), 
        Rectangle(extent = {{-60, -70}, {60, -40}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), 
        Line(points = {{60, -40}, {74, -40}}, color = {85, 170, 255}), Line(points = {{-74, -40}, {-60, -40}}, color = {85, 170, 255}),
        Ellipse(extent = {{-60, 55}, {-30, 25}}, lineColor = {85, 170, 255}), Ellipse(extent = {{-30, 55}, {0, 25}}, lineColor = {85, 170, 255}), 
        Ellipse(extent = {{0, 55}, {30, 25}}, lineColor = {85, 170, 255}),         
        Ellipse(extent = {{30, 55}, {60, 25}}, lineColor = {85, 170, 255}),         
        Rectangle(extent = {{-60, 40}, {60, 70}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), 
        Line(points = {{60, 40}, {74, 40}}, color = {85, 170, 255}), 
        Line(points = {{-74, -40}, {-74, 40}}, color = {85, 170, 255}), Line(points = {{-74, 40}, {-60, 40}}, color = {85, 170, 255}), 
        Line(points = {{74, -40}, {74, 40}}, color = {85, 170, 255}), 
        Line(points = {{-98, 0}, {-74, 0}}, color = {85, 170, 255}), Line(points = {{74, 0}, {98, 0}}, color = {85, 170, 255}),
        Ellipse(extent = {{-68, 10}, {68, -10}}, lineColor = {85, 170, 255}, linePattern = LinePattern.Dash, pattern = LinePattern.Dash), Text(extent = {{-100, 96}, {100, 60}}, lineColor = {0, 0, 255}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html>
<p>Modello sescrivente in approssimazione quasi stationary untronco di linea 2x25.</p>
<p>I plug di estremit&agrave; contentono due elementi, che sono:</p>
<p>[1] il filo di contatto</p>
<p>[2] il feeder.</p>
<p>Il terreno &egrave; il riferimento per le tensioni e la corrente che transita nel terreno e pari a i[1]+i[2].</p>
</html>"));
end VarLenLine;
