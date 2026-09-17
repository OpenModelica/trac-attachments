model test
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polartocomplex1 annotation(Placement(visible = true, transformation(origin = {-37.4291,43.8563}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {6.77362,8.19964}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-93.2112,51.5687}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-93.2112,51.5687}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput realinput2 annotation(Placement(visible = true, transformation(origin = {-31.3725,77.7184}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-31.3725,77.7184}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource variablevoltagesource1 annotation(Placement(visible = true, transformation(origin = {6.41711,48.4848}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor1 annotation(Placement(visible = true, transformation(origin = {39.9287,49.5544}, extent = {{-12,12},{12,-12}}, rotation = -90)));
  annotation(Icon(), Diagram());
  Modelica.Blocks.Interfaces.RealInput realinput1 annotation(Placement(visible = true, transformation(origin = {-93.0481,34.9376}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-93.0481,34.9376}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(polartocomplex1.phi,realinput1) annotation(Line(points = {{-50.6291,36.6563},{-85.5615,36.6563},{-85.5615,34.9376},{-93.0481,34.9376}}));
  connect(realinput2,variablevoltagesource1.f) annotation(Line(points = {{-31.3725,77.7184},{-6.77362,77.7184},{-6.77362,53.2848},{-5.58289,53.2848}}));
  connect(polartocomplex1.len,u) annotation(Line(points = {{-50.6291,51.0563},{-85.4442,51.0563},{-85.4442,51.5687},{-93.2112,51.5687}}));
  connect(ground1.pin,variablevoltagesource1.pin_p) annotation(Line(points = {{6.77362,20.1996},{6.41711,20.1996},{6.41711,36.4848},{6.41711,36.4848}}));
  connect(variablevoltagesource1.pin_n,resistor1.pin_p) annotation(Line(points = {{6.41711,60.4848},{39.5722,60.4848},{39.5722,61.5544},{39.9287,61.5544}}));
  connect(variablevoltagesource1.pin_p,resistor1.pin_n) annotation(Line(points = {{6.41711,36.4848},{39.5722,36.4848},{39.5722,37.5544},{39.9287,37.5544}}));
  connect(polartocomplex1.y,variablevoltagesource1.V) annotation(Line(points = {{-24.2291,43.8563},{-6.77362,43.8563},{-6.77362,43.6848},{-5.58289,43.6848}}));
end test;

