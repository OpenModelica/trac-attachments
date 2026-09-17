within ;
package TestExample
  model SimpleLossTable "Test of simple DC loss model"
    extends Modelica.Icons.Example;
    TestExample.Loss loss annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(transformation(extent={{50,-52},{70,-32}})));
    Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={60,0})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=100) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,0})));
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1 annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor2 annotation (Placement(transformation(extent={{30,10},{50,30}})));
    Modelica.Blocks.Tables.CombiTable1Ds combiTable(table=[0,10; 2000,200]) annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
    Modelica.Blocks.Sources.Ramp ramp(duration=1, height=10) annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  equation
    connect(ground1.p, constantVoltage.n) annotation (Line(points={{-70,-30},{-70,-10}}, color={0,0,255}));
    connect(loss.n1, constantVoltage.n) annotation (Line(points={{-10,-10},{-20,-10},
            {-20,-20},{-70,-20},{-70,-10}}, color={0,0,255}));
    connect(loss.n2, signalCurrent.n) annotation (Line(points={{10,-10},{20,-10},{
            20,-20},{60,-20},{60,-10}}, color={0,0,255}));
    connect(ground2.p, signalCurrent.n) annotation (Line(points={{60,-32},{60,-10}}, color={0,0,255}));
    connect(loss.p2, powerSensor2.pc) annotation (Line(points={{10,10},{20,10},{20,
            20},{30,20}}, color={0,0,255}));
    connect(powerSensor2.pc, powerSensor2.pv) annotation (Line(points={{30,20},{30,30},{40,30}}, color={0,0,255}));
    connect(powerSensor2.nc, signalCurrent.p) annotation (Line(points={{50,20},{60,20},{60,10}}, color={0,0,255}));
    connect(powerSensor2.nv, ground2.p) annotation (Line(points={{40,10},{40,-20},{60,-20},{60,-32}}, color={0,0,255}));
    connect(powerSensor1.nv, ground1.p) annotation (Line(points={{-40,10},{-40,-20},{-70,-20},{-70,-30}}, color={0,0,255}));
    connect(powerSensor1.nc, loss.p1) annotation (Line(points={{-30,20},{-20,20},{
            -20,10},{-10,10}}, color={0,0,255}));
    connect(constantVoltage.p, powerSensor1.pc) annotation (Line(points={{-70,10},{-70,20},{-50,20}}, color={0,0,255}));
    connect(powerSensor1.pc, powerSensor1.pv) annotation (Line(points={{-50,20},{-50,30},{-40,30}}, color={0,0,255}));
    connect(ramp.y, signalCurrent.i) annotation (Line(points={{79,0},{72,0}}, color={0,0,127}));
    connect(combiTable.y[1], loss.lossPower) annotation (Line(points={{13,-50},{20,-50},{20,-30},{6,-30},{6,-12}},
                                            color={0,0,127}));
    connect(loss.outputPower, combiTable.u) annotation (Line(points={{-6,-11},{-6,
            -30},{-20,-30},{-20,-50},{-10,-50}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end SimpleLossTable;

  model Loss "Efficiency model considering variable efficiency"
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    Modelica.SIunits.Current i_loss "Loss current considering equal voltages on both sides";
    Modelica.Blocks.Interfaces.RealInput lossPower(unit="W") "Loss power" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={60,-120})));
    Modelica.Blocks.Interfaces.RealOutput outputPower(unit="W") "Output power" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,-110})));
  equation
    // Equal voltages on both sides
    v1 = v2;
    // Currents take loss into account
    i1 + i2 = i_loss;
    i_loss * v1 = lossPower;
    outputPower = smooth(0, if v1*i1 < 0 then -v1*i1 else -v2*i2);
    annotation(defaultComponentName="efficiency",Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 255}, textString = "%%")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Documentation(info="<html>
    <p>Model variable loss dependent on output power.</p>
</html>"));
  end Loss;
  annotation (uses(Modelica(version="3.2.3")));
end TestExample;
