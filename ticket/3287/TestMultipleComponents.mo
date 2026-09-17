within ;
model TestMultipleComponents
  Modelica.Electrical.Analog.Basic.Resistor R1(R=10)
    annotation (Placement(transformation(extent={{-34,10},{-14,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Electrical.Analog.Basic.Conductor G1(G=10)
    annotation (Placement(transformation(extent={{-4,10},{16,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
equation
  connect(ground1.p, R1.p) annotation (Line(
      points={{-50,0},{-50,20},{-34,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(G1.n, ground2.p) annotation (Line(
      points={{16,20},{30,20},{30,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R1.n, G1.p) annotation (Line(
      points={{-14,20},{-4,20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (uses(Modelica(version="3.2.1")), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end TestMultipleComponents;
