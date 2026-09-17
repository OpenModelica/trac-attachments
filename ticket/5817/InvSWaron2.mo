model InvSWaron2 "Three-phase (multiphase) with bidirectional switches"
  Modelica.SIunits.Power aronPower;
  Modelica.Electrical.MultiPhase.Basic.Star star2 annotation(
    Placement(visible = true, transformation(origin = {60, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(2, 3)) annotation(
    Placement(visible = true, transformation(origin = {60, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation(
    Placement(visible = true, transformation(origin = {14, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation(
    Placement(visible = true, transformation(origin = {-2,16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {-32, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
    Placement(visible = true, transformation(origin = {-60, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.AronSensor aronSensor1 annotation(
    Placement(visible = true, transformation(extent = {{26, 6}, {46, 26}}, rotation = 0)));
equation
  connect(Cf.plug_p, Lf.plug_n) annotation(
    Line(points = {{14, 16}, {8, 16}}, color = {0, 0, 255}));
  connect(Cf.plug_n, Rload.plug_n) annotation(
    Line(points = {{14, -4}, {60, -4}}, color = {0, 0, 255}));
  connect(Rload.plug_n, star2.plug_p) annotation(
    Line(points = {{60, -4}, {60, -10}}, color = {0, 0, 255}));
  aronPower = Rload.plug_p.pin[1].v * Rload.plug_p.pin[1].i + Rload.plug_p.pin[2].v * Rload.plug_p.pin[2].i + Rload.plug_p.pin[3].v * Rload.plug_p.pin[3].i;
  connect(aronSensor1.plug_p, Cf.plug_p) annotation(
    Line(points = {{26, 16}, {14, 16}}, color = {0, 0, 255}));
  connect(aronSensor1.plug_n, Rload.plug_p) annotation(
    Line(points = {{46, 16}, {60, 16}}, color = {0, 0, 255}));
  connect(star.plug_p, Lf.plug_p) annotation(
    Line(points = {{-22, 16}, {-12, 16}}, color = {0, 0, 255}));
  connect(ground2.p, star.pin_n) annotation(
    Line(points = {{-60, 16}, {-42, 16}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {100, 80}})),
    experimentSetupOutput,
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
    experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001, Interval = 0.0002),
    __OpenModelica_commandLineOptions = "",
  uses(Modelica(version = "3.2.3")));
end InvSWaron2;
