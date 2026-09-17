within ;
model CrossingLines
  Modelica.Electrical.Analog.Basic.Resistor resistor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,8})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,18})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-50,18})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,18})));
equation

  connect(constantVoltage.p, resistor1.p) annotation (Line(points={{-50,28},{
          -50,50},{1.77636e-015,50},{1.77636e-015,28}}, color={0,0,255}));
  connect(constantVoltage.n, resistor1.n) annotation (Line(points={{-50,8},{-50,
          -14},{-1.77636e-015,-14},{-1.77636e-015,8}}, color={0,0,255}));
  connect(resistor.p, resistor2.p) annotation (Line(points={{-20,18},{-20,38},{
          34,38},{34,28}}, color={0,0,255}));
  connect(resistor.n, resistor2.n) annotation (Line(points={{-20,-2},{28,-2},{
          28,-2},{28,-2},{34,-2},{34,8}}, color={0,0,255}));
  annotation (uses(Modelica(version="3.2.2")));
end CrossingLines;
