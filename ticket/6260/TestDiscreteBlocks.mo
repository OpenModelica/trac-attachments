model TestDiscreteBlocks
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod = 0.025)  annotation(
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.TransferFunction transferFunction(a = {1, 0.9}, b = {1}, samplePeriod = 0.025)  annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine(freqHz = 1)  annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sine.y, sampler.u) annotation(
    Line(points = {{-39, -10}, {-22, -10}}, color = {0, 0, 127}));
  connect(sampler.y, transferFunction.u) annotation(
    Line(points = {{1, -10}, {18, -10}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")));
end TestDiscreteBlocks;
