model GearWithExternalRatio
  Modelica.Mechanics.Rotational.Interfaces.Flange_a fla
    annotation (Placement(transformation(
      extent = {{-110, -10},{-90, 10}},rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flb 
    annotation (Placement(transformation(
      extent = {{90, -10},{110, 10}},rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ratio
    annotation (Placement(transformation(
    extent = {{-10, 90},{10, 110}},rotation = -90)));
equation
  fla.tau = -flb.tau / ratio;
  fla.phi = ratio * flb.phi;
end GearWithExternalRatio;
