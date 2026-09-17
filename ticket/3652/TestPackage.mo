within ;
package TestPackage

  model Test
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
    Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    RC rC annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  equation
    connect(ground.p, sineVoltage.n) annotation (Line(points={{-40,-40},{-40,-25},{-40,-10}}, color={0,0,255}));
    connect(sineVoltage.p, rC.p1) annotation (Line(points={{-40,10},{-40,10},{-40,20},{-10,20},{-10,8},{0,8}}, color={0,0,255}));
    connect(rC.n1, sineVoltage.n) annotation (Line(points={{-0.2,-8},{-10,-8},{-10,-20},{-40,-20},{-40,-10}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Test;

  model RC
    Modelica.Electrical.Analog.Basic.Resistor resistor annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,0})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,0})));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1 "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 "Negative pin" annotation (Placement(transformation(extent={{-112,-90},{-92,-70}})));
  equation
    connect(resistor.p, p1) annotation (Line(points={{-20,10},{-20,10},{-20,40},{-20,80},{-100,80}}, color={0,0,255}));
    connect(resistor.n, n1) annotation (Line(points={{-20,-10},{-20,-10},{-20,-58},{-20,-80},{-102,-80}}, color={0,0,255}));
    connect(capacitor.n, n1) annotation (Line(points={{20,-10},{20,-20},{-20,-20},{-20,-80},{-102,-80}}, color={0,0,255}));
    connect(capacitor.p, p1) annotation (Line(points={{20,10},{20,20},{-20,20},{-20,80},{-100,80}}, color={0,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end RC;
  annotation (uses(Modelica(version="3.2.1")));
end TestPackage;
