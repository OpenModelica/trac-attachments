model test_pwm_driver
  Modelica.Blocks.Sources.Constant const1(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-72, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PI_discreet pI_discreet1(Init = 50, Ki = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {-18, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const1.y, pI_discreet1.e) annotation(
    Line(points = {{-60, 16}, {-30, 16}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.2"), Modelica_Synchronous(version = "0.92.1")),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.001),
  __OpenModelica_simulationFlags(jacobian = "", s = "dassl", lv = "LOG_STATS"));
end test_pwm_driver;
