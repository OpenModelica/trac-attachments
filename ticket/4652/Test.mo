package Test
  model A
    parameter Boolean flag "boolean flag";
    parameter Integer numInt "integer number";
    parameter Real numReal "real nunmber";
    parameter Modelica.SIunits.Voltage V "voltage";
  end A;

  model B
    Test.A a1 annotation(
      Placement(visible = true, transformation(origin = {-142, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end B;

end Test;
