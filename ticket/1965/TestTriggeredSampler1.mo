model TestTriggeredSampler1
  model EqualConstantI "output is true, if integer input is equal to parameter"
    parameter Integer k = 0;
    Modelica.Blocks.Interfaces.IntegerInput u annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput y annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-90,100},{90,-100}}, lineColor = {0,0,0}, lineThickness = 1),Text(extent = {{-80,-50},{80,50}}, lineColor = {0,0,0}, textString = " == k")}));
  equation
    y = u == k;
  end EqualConstantI;
  annotation(experiment(StartTime = 0.0, StopTime = 4.0, Tolerance = 0.000001));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredsampler1 annotation(Placement(visible = true, transformation(origin = {25.3561,64.1026}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.1) annotation(Placement(visible = true, transformation(origin = {-18.2337,64.3875}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  EqualConstantI equalconstanti1(k = 2) annotation(Placement(visible = true, transformation(origin = {9.11684,22.2222}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Math.RealToInteger realtointeger1 annotation(Placement(visible = true, transformation(origin = {-24.2165,22.5071}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Clock clock1 annotation(Placement(visible = true, transformation(origin = {-61.5385,22.792}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(clock1.y,realtointeger1.u) annotation(Line(points = {{-48.3385,22.792},{-39.0313,22.792},{-39.0313,22.5071},{-38.6165,22.5071}}));
  connect(realtointeger1.y,equalconstanti1.u) annotation(Line(points = {{-11.0165,22.5071},{-2.849,22.5071},{-2.849,22.2222},{-2.88316,22.2222}}));
  connect(equalconstanti1.y,triggeredsampler1.trigger) annotation(Line(points = {{21.1168,22.2222},{25.0712,22.2222},{25.0712,49.9426},{25.3561,49.9426}}));
  connect(const.y,triggeredsampler1.u) annotation(Line(points = {{-5.03366,64.3875},{10.5413,64.3875},{10.5413,64.1026},{10.9561,64.1026}}));
end TestTriggeredSampler1;

