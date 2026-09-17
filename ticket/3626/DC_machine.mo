within ;
model DC_machine

  Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(visible = true, transformation(origin = {50, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(TaOperational = 293.15, VaNominal = 24, IaNominal = 0.72, wNominal = 723.4, TaNominal = 293.15, Ra = 6.243, TaRef = 293.15, alpha20a = 0, La = 265E-6, Jr = 5.8E-7, brushParameters(V = 0.617), frictionParameters(PRef = 0.7162, power_w = 2, wRef = 723.4)) annotation(Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampLoad(height = -0.0108, duration = 2, startTime = 1.5) annotation(Placement(visible = true, transformation(origin = {90, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1 annotation(Placement(visible = true, transformation(origin = {-50, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampSource(height = 12, duration = 1) annotation(Placement(visible = true, transformation(origin = {-82, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-92, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear1(ratio = 3.71) annotation(Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(signalVoltage1.p, dcpm.pin_ap) annotation(Line(points = {{-40, 60}, {-30, 60}, {-30, 10}, {-46, 10}, {-46, 10}, {-46, 10}}, color = {0, 0, 255}));
  connect(idealGear1.flange_b, torque1.flange) annotation(Line(points = {{20, 0}, {40, 0}}));
  connect(dcpm.flange, idealGear1.flange_a) annotation(Line(points = {{-42, 0}, { 0, 0}}));
  connect(rampSource.y, signalVoltage1.v) annotation(Line(points = {{-71, 82}, {-50, 82}, {-50, 67}},  color = {0, 0, 127}));
  connect(signalVoltage1.n, dcpm.pin_an) annotation(Line(points = {{-60, 60}, {-70, 60}, {-70, 10}, {-58, 10}}, color = {0, 0, 255}));
  connect(signalVoltage1.n, ground1.p) annotation(Line(points = {{-60, 60}, {-92, 60}}, color = {0, 0, 255}));
  connect(rampLoad.y, torque1.tau) annotation(Line(points = {{79, 0}, {62, 0}},  color = {0, 0, 127}));
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem( initialScale = 0.1),  graphics={  Rectangle(origin = {-53, -6}, fillColor = {159, 173, 220}, pattern = LinePattern.Dash,
            fillPattern =                                                                                                    FillPattern.Solid, extent = {{-27, 26}, {33, -14}}), Text(origin = {12, -26}, extent = {{-24, 4}, {24, -4}}, textString = "gear"), Rectangle(origin = {5, 24}, fillColor = {220, 220, 121}, pattern = LinePattern.Dash,
            fillPattern =                                                                                                    FillPattern.Solid, extent = {{-15, -4}, {25, -44}})}), experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.0006),
    uses(Modelica(version="3.2.1")));
end DC_machine;
