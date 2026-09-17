package ExampleModifiers
  package Types
    // nominal values definition
    constant Modelica.SIunits.Pressure Pressure_nominal = 1e6;
  
    // type definition
    type Pressure = Modelica.SIunits.Pressure(nominal = Pressure_nominal);
  
  end Types;

  model M1
    parameter Types.Pressure p1 "pressure";
  end M1;

  model Test
    parameter Types.Pressure p1 "pressure";
    M1 m1(p1 = p1)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end Test;
end ExampleModifiers;