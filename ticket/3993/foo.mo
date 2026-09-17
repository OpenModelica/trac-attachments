model foo
  Modelica.Blocks.Sources.TimeTable table(table = [0, 1.0; 3600, 10]) annotation(Placement(visible = true, transformation(origin = {-60, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
  Real v;
  equation
  der(table.y) = v;
end foo;
