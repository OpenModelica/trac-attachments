model TestExtractor
  annotation(experiment(StartTime = 0.0, StopTime = 12.1, Tolerance = 0.000001));
  Modelica.Blocks.Sources.SawTooth sawtooth1(amplitude = 3.999, period = 4, offset = 0.5)
    annotation(Placement(visible = true, transformation(origin = {-71.51,-65.2422}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Math.RealToInteger realtointeger1 annotation(Placement(visible = true, transformation(origin = {-35.0427,-65.812}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.1) annotation(Placement(visible = true, transformation(origin = {-76.9231,81.1966}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 2.2) annotation(Placement(visible = true, transformation(origin = {-76.3533,46.1538}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 3.3) annotation(Placement(visible = true, transformation(origin = {-76.0684,11.9658}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 4.4) annotation(Placement(visible = true, transformation(origin = {-75.2137,-22.2222}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Routing.Multiplex4 multiplex41 annotation(Placement(visible = true, transformation(origin = {-29.3447,25.9259}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Routing.Extractor extractor1(nin = 4) annotation(Placement(visible = true, transformation(origin = {15.9544,25.9259}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(realtointeger1.y,extractor1.index) annotation(Line(points = {{-21.8427,-65.812},{15.9544,-65.812},{15.9544,11.5259},{15.9544,11.5259}}));
  connect(constant3.y,multiplex41.u4[1]) annotation(Line(points = {{-62.0137,-22.2222},{-51.8519,-22.2222},{-51.8519,15.6695},{-43.7447,15.6695},{-43.7447,15.1259}}));
  connect(constant2.y,multiplex41.u3[1]) annotation(Line(points = {{-62.8684,11.9658},{-56.4103,11.9658},{-56.4103,22.5071},{-43.7447,22.5071},{-43.7447,22.3259}}));
  connect(constant1.y,multiplex41.u2[1]) annotation(Line(points = {{-63.1533,46.1538},{-56.4103,46.1538},{-56.4103,29.6296},{-43.7447,29.6296},{-43.7447,29.5259}}));
  connect(const.y,multiplex41.u1[1]) annotation(Line(points = {{-63.7231,81.1966},{-51.8519,81.1966},{-51.8519,36.4672},{-43.7447,36.4672},{-43.7447,36.7259}}));
  connect(sawtooth1.y,realtointeger1.u) annotation(Line(points = {{-58.31,-65.2422},{-49.8575,-65.2422},{-49.8575,-65.812},{-49.4427,-65.812}}));
  connect(multiplex41.y,extractor1.u);
end TestExtractor;

