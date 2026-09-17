model PI_discreet
  Modelica.Blocks.Interfaces.RealInput e annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput PI_out annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real Kp = 0 "Proportional gain";
  parameter Real Ki = 0 "Integral gain";
  parameter Real Init = 0 "Initial output of the controller";
  Real I(start=Init) "Integral accumulator";

equation

  when Clock(0.001) then
    I = previous(I) + Ki * e;
    PI_out = Kp * e + I;
  end when
  annotation(
    uses(Modelica(version = "3.2.2")),
    Diagram(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}));
end PI_discreet;
