package Extending
  model Model1
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(constantVoltage.n, ground.p) annotation(
      Line(points = {{0, -10}, {0, -20}}, color = {0, 0, 255}));
  end Model1;

  model Model2
    extends Extending.Model1(constantVoltage.V = 10);
  equation

  end Model2;

  model Model3
    extends Extending.Model2;
  equation

  end Model3;
  annotation(
    uses(Modelica(version = "3.2.3")));
end Extending;