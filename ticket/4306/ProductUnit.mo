model ProductUnit
  Modelica.SIunits.ComplexVoltage vc = Complex(1, 2);
  Modelica.SIunits.ComplexCurrent ic = Complex(-1, -2);
  Complex pc = vc * ic;
  Modelica.SIunits.Voltage vr = 1;
  Modelica.SIunits.Current ir = -1;
  Real pr = vr * ir;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    uses(Modelica(version = "3.2.2"), Complex(version = "3.2.2")));
end ProductUnit;
