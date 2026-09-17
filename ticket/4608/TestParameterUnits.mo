package TestParameterUnits
  model M1
    package Medium = Modelica.Media.Water.StandardWater;
    parameter Modelica.SIunits.Pressure p1;
    parameter Modelica.SIunits.AbsolutePressure p2;
    parameter Medium.AbsolutePressure p3;
  end M1;



  
  model M2
    M1 m annotation(
      Placement(visible = true, transformation(origin = {-6, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end M2;
  
end TestParameterUnits;
