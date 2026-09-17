model testbug
  Modelica.Fluid.Pipes.StaticPipe pipe(allowFlowReversal = true, length = 100, height_ab = 50, diameter = 0.3, redeclare package Medium = Medium) annotation(Placement(transformation(origin = {-30, -51}, extent = {{-9, -10}, {11, 10}}, rotation = 90)));
  Modelica.Fluid.Pipes.StaticPipe pipe1(allowFlowReversal = true, length = 100, height_ab = 50, diameter = 0.3) annotation(Placement(visible = true, transformation(origin = {26, -50}, extent = {{-9, -10}, {11, 10}}, rotation = 90)));
end testbug;