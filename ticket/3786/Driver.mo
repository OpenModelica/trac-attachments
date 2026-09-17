model Driver
  output Modelica.Blocks.Interfaces.RealOutput Velocity_setpoint annotation(Placement(visible = true, transformation(origin = {46, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {46, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep ACC_status_setting(startTime = 3) annotation(Placement(visible = true, transformation(origin = {-68, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  output Modelica.Blocks.Interfaces.BooleanOutput ACC_status annotation(Placement(visible = true, transformation(origin = {30, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp v_setpoint(height = 20, duration = 5, offset = 20, startTime = 4) annotation(Placement(visible = true, transformation(origin = {-74, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(v_setpoint.y, Velocity_setpoint) annotation(Line(points = {{-63, -28}, {38, -28}, {38, -28}, {38, -28}}, color = {0, 0, 127}));
  connect(ACC_status_setting.y, ACC_status) annotation(Line(points = {{-57, 32}, {22, 32}, {22, 32}, {22, 32}}, color = {255, 0, 255}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Driver;