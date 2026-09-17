model Motor1Da
  import SI = Modelica.SIunits;
  // Motor parameters for: Portescap 22N78-311P.1001
  parameter SI.Resistance resCoil = 3.9;
  // Ohm
  parameter SI.Voltage appliedVoltage = 3.0;
  // v
  parameter SI.ElectricalTorqueConstant torqConst = 15.7 * 1.0e-3;
  // N.m/A (originally in mN.m/A)
  parameter SI.MomentOfInertia rotorInertia = 4.20 * 1.0e-3 * 1.0e-4;
  // kg.m^2 (originally in g.cm^2)
  Modelica.Electrical.Analog.Basic.EMF emf(k = torqConst) annotation(Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = resCoil)  annotation(Placement(visible = true, transformation(origin = {-28, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = rotorInertia, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(Placement(visible = true, transformation(origin = {34, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-38, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = appliedVoltage)  annotation(Placement(visible = true, transformation(origin = {-38, -8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(constantVoltage1.n, ground1.p) annotation(Line(points = {{-38, -18}, {-38, -18}, {-38, -28}, {-38, -28}}, color = {0, 0, 255}));
  connect(emf.n, constantVoltage1.n) annotation(Line(points = {{0, -12}, {0, -12}, {0, -18}, {-38, -18}, {-38, -18}}, color = {0, 0, 255}));
  connect(constantVoltage1.p, resistor1.p) annotation(Line(points = {{-38, 2}, {-38, 2}, {-38, 20}, {-38, 20}}, color = {0, 0, 255}));
  connect(emf.flange, inertia1.flange_a) annotation(Line(points = {{10, -2}, {24, -2}, {24, -2}, {24, -2}}));
  connect(resistor1.n, emf.p) annotation(Line(points = {{-18, 20}, {0, 20}, {0, 8}}, color = {0, 0, 255}));
  annotation(uses(Modelica(version = "3.2.2")), experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 0.0002));
end Motor1Da;
