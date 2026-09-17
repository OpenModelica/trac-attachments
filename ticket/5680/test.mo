model test
  Modelica__Blocks__Continuous__Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica__Blocks__Continuous__PI pi annotation(
    Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica__Electrical__Machines__BasicMachines__DCMachines__DC_PermanentMagnet dcpm annotation(
    Placement(visible = true, transformation(origin = {-42, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    uses(Modelica(version = "3.2.3")));
end test;
