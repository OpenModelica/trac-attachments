model CoupledInductance
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Area A = 0.0004 "Area of cross section";
  parameter Modelica.SIunits.Length lFe = 0.04 "Iron length";
  parameter Real mur = 500 "Relative permeability of iron";
  parameter Real N1 = 200 "Number of turns of primary side";
  parameter Real N2 = 400 "Number of turns of secondary side";
  parameter Modelica.SIunits.Inductance L11 = N1 * N1 / lFe / mur / Modelica.Constants.mue_0 / A "Self inductance of primary side";
  parameter Modelica.SIunits.Inductance L12 = N1 * N2 / lFe / mur / Modelica.Constants.mue_0 / A "Mutual inductance of primary and secondary side";
  parameter Modelica.SIunits.Inductance L22 = N2 * N2 / lFe / mur / Modelica.Constants.mue_0 / A "Self inductance of secondary side";
  Modelica.Magnetic.FluxTubes.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-19.9288,-40.5694}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(visible = true, transformation(origin = {-59.7865,-39.5018}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.PulseVoltage pulsevoltage1(V = 1, width = 50, period = 0.1, offset = -0.5) annotation(Placement(visible = true, transformation(origin = {-59.4306,-0.711744}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter1(N = N1) annotation(Placement(visible = true, transformation(origin = {-29.395,0.142348}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter2(N = N2) annotation(Placement(visible = true, transformation(origin = {29.6086,-0.64057}, extent = {{-10,-10},{10,10}}, rotation = 180)));
  Modelica.Magnetic.FluxTubes.Shapes.FixedShape.Cuboid iron(l = lFe, a = sqrt(A), b = sqrt(A), nonLinearPermeability = false, mu_rConst = 500) annotation(Placement(visible = true, transformation(origin = {-0.000000119103,20.2981}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor1 annotation(Placement(visible = true, transformation(origin = {60.4982,-0.000000000000000222045}, extent = {{-10,10},{10,-10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation(Placement(visible = true, transformation(origin = {40.2847,-40.1424}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(converter2.p,voltagesensor1.n) annotation(Line(points = {{39.6086,-6.64057},{40.2135,-6.64057},{40.2135,-19.573},{60.1423,-19.573},{60.1423,-9.96441},{60.1423,-9.96441}}));
  connect(converter2.p,ground3.p) annotation(Line(points = {{39.6086,-6.64057},{40.2135,-6.64057},{40.2135,-30.2491},{40.2135,-30.2491}}));
  connect(converter2.n,voltagesensor1.p) annotation(Line(points = {{39.6086,5.35943},{40.2135,5.35943},{40.2135,19.9288},{60.1423,19.9288},{60.1423,10.6762},{60.1423,10.6762}}));
  connect(converter1.port_n,converter2.port_p) annotation(Line(points = {{-19.395,-5.85765},{-19.573,-5.85765},{-19.573,-19.573},{19.9288,-19.573},{19.9288,-7.11744},{19.9288,-7.11744}}));
  connect(converter1.port_n,ground1.port) annotation(Line(points = {{-19.395,-5.85765},{-19.573,-5.85765},{-19.573,-30.605},{-19.573,-30.605}}));
  connect(iron.port_n,converter2.port_n) annotation(Line(points = {{10,20.2981},{19.9288,20.2981},{19.9288,4.62633},{19.9288,4.62633}}));
  connect(converter1.port_p,iron.port_p) annotation(Line(points = {{-19.395,6.14235},{-19.9288,6.14235},{-19.9288,19.9288},{-9.25267,19.9288},{-9.25267,19.9288}}));
  connect(pulsevoltage1.n,converter1.n) annotation(Line(points = {{-59.4306,-10.7117},{-59.4306,-19.9288},{-39.1459,-19.9288},{-39.1459,-5.69395},{-39.1459,-5.69395}}));
  connect(pulsevoltage1.p,converter1.p) annotation(Line(points = {{-59.4306,9.28826},{-59.4306,19.9288},{-38.79,19.9288},{-38.79,6.04982},{-38.79,6.04982}}));
  connect(pulsevoltage1.n,ground2.p) annotation(Line(points = {{-59.4306,-10.7117},{-59.4306,-29.8932},{-59.4306,-29.8932},{-59.4306,-29.8932}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
end CoupledInductance;

