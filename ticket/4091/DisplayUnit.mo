within ;
package DisplayUnit
  type Voltage = Modelica.SIunits.Voltage(displayUnit = "kV");
  model Component
    parameter Voltage V;
  end Component;
  model Test
    Component component1(V = 110000)  annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  end Test;
end DisplayUnit;