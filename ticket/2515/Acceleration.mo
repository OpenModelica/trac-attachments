model Acceleration
  parameter Modelica.SIunits.Mass m = 900 "Mass of half the cart";
  parameter Modelica.SIunits.Force FHorseMax = 800 "Maximum force of one horse";
  parameter Modelica.SIunits.Force FFrictionRef = 400 "Friction force at refrence speed";
  parameter Modelica.SIunits.Force FMotor = 100 "Friction force at refrence speed";
  parameter Modelica.SIunits.Velocity vRef = 1.111 "Reference speed";
  constant Modelica.SIunits.Angle alpha = 0.195 "Angle of ramp (rad)";
  Modelica.Mechanics.Translational.Components.Mass cart(m = m) annotation(Placement(visible = true, transformation(origin = {89.9713,29.7994}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force horse annotation(Placement(visible = true, transformation(origin = {49.8567,49.5702}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce quadraticspeeddependentforce1(f_nominal = -FFrictionRef, v_nominal = vRef) annotation(Placement(visible = true, transformation(origin = {89.6848,-10.3152}, extent = {{10,-10},{-10,10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(height = FHorseMax, duration = 10, startTime = 0) annotation(Placement(visible = true, transformation(origin = {9.66011,50.0894}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force motor annotation(Placement(visible = true, transformation(origin = {50.4472,-10.0179}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = FMotor) annotation(Placement(visible = true, transformation(origin = {10.3757,-9.90656}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(const.y,motor.f) annotation(Line(points = {{21.3757,-9.90656},{38.2826,-9.90656},{38.2826,-10.7335},{38.2826,-10.7335}}));
  connect(motor.flange,cart.flange_a) annotation(Line(points = {{60.4472,-10.0179},{70.483,-10.0179},{70.483,29.6959},{80.1431,29.6959},{80.1431,29.6959}}));
  connect(ramp1.y,horse.f) annotation(Line(points = {{20.6601,50.0894},{36.4937,50.0894},{36.4937,49.7317},{36.4937,49.7317}}));
  connect(quadraticspeeddependentforce1.flange,cart.flange_a) annotation(Line(points = {{79.6848,-10.3152},{70.7736,-10.3152},{70.7736,29.2264},{80.8023,29.2264},{80.8023,29.2264}}));
  connect(horse.flange,cart.flange_a) annotation(Line(points = {{59.8567,49.5702},{70.7736,49.5702},{70.7736,29.2264},{79.6562,29.2264},{79.6562,29.2264}}));
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), experiment(StartTime = 0, StopTime = 20, Tolerance = 0.000001));
end Acceleration;

