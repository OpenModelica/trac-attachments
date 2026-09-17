model PwmPulser
  Modelica.Blocks.Interfaces.RealInput Ampl annotation(Placement(transformation(extent = {{-114,44},{-74,84}}), iconTransformation(extent = {{-140,44},{-100,84}})));
  Modelica.Blocks.Interfaces.RealInput Ph_deg annotation(Placement(transformation(extent = {{-118,-74},{-78,-34}}), iconTransformation(extent = {{-140,-74},{-100,-34}})));
  parameter Real Fcar = 1000 "Carrier Frequency";
  import PI = Modelica.Constants.pi;
  Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-54,-28},{-34,-8}})));
  Modelica.Blocks.Math.Gain ToRAD(k = PI / 180) annotation(Placement(transformation(extent = {{-64,-60},{-54,-50}})));
  Modelica.Blocks.Math.Product moduler annotation(Placement(transformation(extent = {{14,-22},{32,-4}})));
  Modelica.Blocks.Interfaces.BooleanOutput Top annotation(Placement(transformation(extent = {{80,6},{100,26}}), iconTransformation(extent = {{100,56},{120,76}})));
  Modelica.Blocks.Logical.Greater greater annotation(Placement(transformation(extent = {{46,-24},{66,-4}})));
  Modelica.Blocks.Interfaces.BooleanOutput Bot annotation(Placement(transformation(extent = {{84,-62},{104,-42}}), iconTransformation(extent = {{100,-68},{120,-48}})));
  Modelica.Blocks.Logical.Not not1 annotation(Placement(transformation(extent = {{60,-60},{74,-46}})));
  parameter Real Fmod = 50 "Moduler Frequency";
protected
  Modelica.Blocks.Sources.Trapezoid carrier(rising = 1 / (2 * Fcar), width = 0, falling = 1 / (2 * Fcar), period = 1 / Fcar, amplitude = 2, offset = -1) annotation(Placement(transformation(extent = {{14,-56},{34,-36}})));
  Modelica.Blocks.Math.Sin sin annotation(Placement(transformation(extent = {{-20,-28},{0,-8}})));
  Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-50,16},{-32,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 2 * PI * Fmod) annotation(Placement(transformation(extent = {{-90,14},{-64,36}})));
equation
  connect(ToRAD.u,Ph_deg) annotation(Line(points = {{-65,-55},{-76,-55},{-76,-54},{-98,-54}}, color = {0,0,127}, smooth = Smooth.None));
  connect(sin.u,add.y) annotation(Line(points = {{-22,-18},{-33,-18}}, color = {0,0,127}, smooth = Smooth.None));
  connect(moduler.u2,sin.y) annotation(Line(points = {{12.2,-18.4},{14,-18.4},{14,-18},{1,-18}}, color = {0,0,127}, smooth = Smooth.None));
  connect(add.u1,integrator.y) annotation(Line(points = {{-56,-12},{-64,-12},{-64,2},{-24,2},{-24,25},{-31.1,25}}, color = {0,0,127}, smooth = Smooth.None));
  connect(moduler.u1,Ampl) annotation(Line(points = {{12.2,-7.6},{12.2,64},{-94,64}}, color = {0,0,127}, smooth = Smooth.None));
  connect(add.u2,ToRAD.y) annotation(Line(points = {{-56,-24},{-64,-24},{-64,-34},{-46,-34},{-46,-55},{-53.5,-55}}, color = {0,0,127}, smooth = Smooth.None));
  connect(greater.u1,moduler.y) annotation(Line(points = {{44,-14},{46.45,-14},{46.45,-13},{32.9,-13}}, color = {0,0,127}, smooth = Smooth.None));
  connect(greater.u2,carrier.y) annotation(Line(points = {{44,-22},{44,-46},{35,-46}}, color = {0,0,127}, smooth = Smooth.None));
  connect(Top,greater.y) annotation(Line(points = {{90,16},{82,16},{82,14},{74,14},{74,-14},{67,-14}}, color = {255,0,255}, smooth = Smooth.None));
  connect(not1.y,Bot) annotation(Line(points = {{74.7,-53},{84,-53},{84,-52},{94,-52}}, color = {255,0,255}, smooth = Smooth.None));
  connect(not1.u,greater.y) annotation(Line(points = {{58.6,-53},{52,-53},{52,-32},{74,-32},{74,-14},{67,-14}}, color = {255,0,255}, smooth = Smooth.None));
  connect(integrator.u,realExpression.y) annotation(Line(points = {{-51.8,25},{-62.7,25}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,127}, fillPattern = FillPattern.Solid, fillColor = {255,255,255}),Text(extent = {{-100,88},{-42,60}}, lineColor = {0,0,127}, textString = "A"),Text(extent = {{-98,-62},{-28,-88}}, lineColor = {0,0,127}, textString = "Ph(?)"),Text(extent = {{28,86},{100,60}}, lineColor = {255,0,255}, textString = "u"),Text(extent = {{42,-62},{96,-88}}, lineColor = {255,0,255}, textString = "d", fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{-60,-60},{-40,62},{-20,-60},{0,60},{20,-62},{40,60},{60,-62},{80,58}}, color = {0,0,127}, smooth = Smooth.None),Line(points = {{-80,20},{-38,40},{0,44},{42,40},{80,20}}, color = {0,0,127}, smooth = Smooth.None, thickness = 0.5)}));
end PwmPulser;

