model TestTriggeredSampler2
  model EqualConstantI "output is true, if integer input is equal to parameter"
    parameter Integer k = 0;
    Modelica.Blocks.Interfaces.IntegerInput u annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput y annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-90,100},{90,-100}}, lineColor = {0,0,0}, lineThickness = 1),Text(extent = {{-80,-50},{80,50}}, lineColor = {0,0,0}, textString = " == k")}));
  equation
    y = u == k;
  end EqualConstantI;
  Modelica.Blocks.Discrete.TriggeredSampler triggeredsampler1 annotation(Placement(visible = true, transformation(origin = {-11.396,62.3932}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.1) annotation(Placement(visible = true, transformation(origin = {-54.9858,62.6781}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  annotation(experiment(StartTime = 0.0, StopTime = 4.0, Tolerance = 0.000001));
  EqualConstantI equalconstanti1(k = 2) annotation(Placement(visible = true, transformation(origin = {-27.6353,20.5128}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerStep integerstep1(height = 2, startTime = 1) annotation(Placement(visible = true, transformation(origin = {-70.9402,20.7977}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(integerstep1.y,equalconstanti1.u) annotation(Line(points = {{-57.7402,20.7977},{-39.3162,20.7977},{-39.3162,20.5128},{-39.6353,20.5128}}));
  connect(equalconstanti1.y,triggeredsampler1.trigger) annotation(Line(points = {{-15.6353,20.5128},{-11.6809,20.5128},{-11.6809,48.2332},{-11.396,48.2332}}));
  connect(const.y,triggeredsampler1.u) annotation(Line(points = {{-41.7858,62.6781},{-26.2108,62.6781},{-26.2108,62.3932},{-25.796,62.3932}}));
end TestTriggeredSampler2;
