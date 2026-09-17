package TestEachDisplayUnit
  model M
    parameter Modelica.SIunits.Density d[3];
    annotation(
      Icon(graphics = {Rectangle(origin = {-1, 0}, extent = {{-99, 100}, {101, -100}}), Text(origin = {4, 11}, extent = {{-66, 53}, {66, -53}}, textString = "M")}));
  end M;

  model S
  M m(d(displayUnit = "kg/m3") = {1000, 900, 950})  annotation(
      Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end S;
end TestEachDisplayUnit;
