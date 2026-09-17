model TestUnitMultiples
  Modelica.SIunits.PerUnit f = sin(time*10);
  Modelica.SIunits.Voltage v1 = 1e-12*f;
  Modelica.SIunits.Voltage v2 = 1e-11*f;
  Modelica.SIunits.Voltage v3 = 1e-10*f;
  Modelica.SIunits.Voltage v4 = 1e-9*f;
  Modelica.SIunits.Voltage v5 = 1e-8*f;
  Modelica.SIunits.Voltage v6 = 1e-7*f;
  Modelica.SIunits.Voltage v7 = 1e-6*f;
  Modelica.SIunits.Voltage v8 = 1e-5*f;
  Modelica.SIunits.Voltage v9 = 1e-4*f;
  Modelica.SIunits.Voltage v10 = 1e-3*f;
  Modelica.SIunits.Voltage v11 = 1e-2*f;
  Modelica.SIunits.Voltage v12 = 1e-1*f;
  Modelica.SIunits.Voltage v13 = 1*f;
  Modelica.SIunits.Voltage v14 = 1e1*f;
  Modelica.SIunits.Voltage v15 = 1e2*f;
  Modelica.SIunits.Voltage v16 = 1e3*f;
  Modelica.SIunits.Voltage v17 = 1e4*f;
  Modelica.SIunits.Voltage v18 = 1e5*f;
  Modelica.SIunits.Voltage v19 = 1e6*f;
  
annotation(
    uses(Modelica(version = "3.2.3")));
end TestUnitMultiples;
