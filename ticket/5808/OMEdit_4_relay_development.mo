model OMEdit_4_relay_development
  Modelica.Blocks.Sources.Sine sine0(amplitude = 1.5, freqHz = 50, offset = 1, phase = 0.349066)  annotation(
    Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 1.5, freqHz = 50, offset = 1, phase = 0.349066) annotation(
    Placement(visible = true, transformation(origin = {-50, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine2(amplitude = 1.5, freqHz = 50, offset = 1, phase = 0.349066) annotation(
    Placement(visible = true, transformation(origin = {-78, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.Sampler samplermd(samplePeriod = 1 / 10000) annotation(
    Placement(visible = true, transformation(origin = {6, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  md_filter filtermd(nin = 1, x = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {50, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  md_filter filter6(nin = 1, x = 3)  annotation(
    Placement(visible = true, transformation(origin = {40, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sine0.y, samplermd.u) annotation(
    Line(points = {{-69, 40}, {-58.5, 40}, {-58.5, 58}, {-6, 58}}, color = {0, 255, 0}));
  connect(sine1.y, filtermd.u[1]) annotation(
    Line(points = {{-39, -12}, {-16.5, -12}, {-16.5, 22}, {38, 22}}, color = {0, 0, 127}));
  connect(sine1.y, filter6.u[1]) annotation(
    Line(points = {{-38, -12}, {-16, -12}, {-16, -28}, {28, -28}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(coordinateSystem(extent = {{-10000, -10000}, {10000, 10000}})),
    uses(Modelica(version = "3.2.3")));
end OMEdit_4_relay_development;
