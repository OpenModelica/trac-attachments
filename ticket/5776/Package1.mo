within ;
package Package1
  model Model1
    SubModel1 subMod
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-10})));
    Modelica.Electrical.Analog.Basic.Resistor resistor annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={40,-10})));
  equation
    connect(sineVoltage.p, subMod.pin_p)
      annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
    connect(resistor.p, subMod.pin_n)
      annotation (Line(points={{40,0},{10,0}}, color={0,0,255}));
    connect(sineVoltage.n, resistor.n) annotation (Line(points={{-40,-20},{-40,
            -32},{40,-32},{40,-20}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Model1;

  model SubModel1
    Modelica.Electrical.Analog.Basic.Resistor resistor
      annotation (Placement(transformation(extent={{26,-10},{46,10}})));
    Modelica.Electrical.Analog.Basic.Resistor resistor1
      annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    connect(resistor1.n, resistor.p)
      annotation (Line(points={{-18,0},{26,0}}, color={0,0,255}));
    connect(resistor1.p, pin_p)
      annotation (Line(points={{-38,0},{-100,0}}, color={0,0,255}));
    connect(pin_n, resistor.n)
      annotation (Line(points={{100,0},{46,0}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SubModel1;

  package SubPackage1
    model SubModel2
      Modelica.Electrical.Analog.Basic.Resistor resistor
        annotation (Placement(transformation(extent={{26,-10},{46,10}})));
      Modelica.Electrical.Analog.Basic.Resistor resistor1
        annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      connect(resistor1.n, resistor.p)
        annotation (Line(points={{-18,0},{26,0}}, color={0,0,255}));
      connect(resistor1.p, pin_p)
        annotation (Line(points={{-38,0},{-100,0}}, color={0,0,255}));
      connect(pin_n, resistor.n)
        annotation (Line(points={{100,0},{46,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SubModel2;
  end SubPackage1;

  model Model2
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-40,-10})));
    Modelica.Electrical.Analog.Basic.Resistor resistor annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={40,-10})));
    SubPackage1.SubModel2 subMod
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(sineVoltage.n, resistor.n) annotation (Line(points={{-40,-20},{-40,
            -32},{40,-32},{40,-20}}, color={0,0,255}));
    connect(sineVoltage.p, subMod.pin_p)
      annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
    connect(subMod.pin_n, resistor.p)
      annotation (Line(points={{10,0},{40,0}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Model2;
  annotation (uses(Modelica(version="3.2.3")));
end Package1;
