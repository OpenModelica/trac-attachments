model Example
  parameter Modelica.SIunits.Area A = 0.0001 "Area of cross section";
  parameter Modelica.SIunits.Length lFe = 0.04 "Iron length";
  parameter Real mur = 500 "Relative permeability of iron";
  parameter Real N = 800 "Number of turns";
  Modelica.Magnetic.FluxTubes.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(visible = true, transformation(origin = {-61.7862, -29.2826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid iron(l = lFe, a = sqrt(A), b = sqrt(A), nonLinearPermeability = false, mu_rConst = mur) annotation(Placement(visible = true, transformation(origin = {33.0893, 19.9122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.RampCurrent rampcurrent1(I = 1, duration = 1) annotation(Placement(visible = true, transformation(origin = {-61.7862, 10.3924}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter(N = N) annotation(Placement(visible = true, transformation(origin = {-9.7906, 10.7072}, extent = {{-9.97804, -9.97804}, {9.97804, 9.97804}}, rotation = 0)));
equation
  connect(converter.n, rampcurrent1.p) annotation(Line(points = {{-19.7686, 4.72038}, {-19.7686, 4}, {-20, 4}, {-20, 0}, {-20, 0.43631}, {-61.7862, 0.43631}, {-61.7862, 0.3924}}));
  connect(rampcurrent1.n, converter.p) annotation(Line(points = {{-61.7862, 20.3924}, {-61.7862, 19.8126}, {-19.7687, 19.8126}, {-19.7687, 16.694}, {-19.7686, 16.694}}));
  connect(ground2.p, rampcurrent1.p) annotation(Line(points = {{-61.7862, -19.2826}, {-61.4934, -19.2826}, {-61.4934, 0.3924}, {-61.7862, 0.3924}}));
  connect(iron.port_n, converter.port_n) annotation(Line(points = {{43.0893, 19.9122}, {60, 19.9122}, {60, 0}, {0, 0}, {0, 4.72038}, {0.18744, 4.72038}}, color = {255, 127, 0}, smooth = Smooth.None));
  connect(converter.port_p, iron.port_p) annotation(Line(points = {{0.18744, 16.694}, {0.18744, 19.9122}, {23.0893, 19.9122}}, color = {255, 127, 0}, smooth = Smooth.None));
  connect(converter.port_n, ground1.port) annotation(Line(points = {{0.18744, 4.72038}, {0.18744, -10}, {6.66134e-16, -10}, {6.66134e-16, -20}}, color = {255, 127, 0}, smooth = Smooth.None));
  annotation(uses(Modelica(version = "3.2.1")), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Example;