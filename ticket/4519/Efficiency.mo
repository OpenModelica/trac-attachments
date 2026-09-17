package Efficiency
extends Modelica.Icons.Package;
  model Drive "Hoist drive static operation"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Ramp ramp(duration = 0.8, height = 10, startTime = 0.1)  annotation (
      Placement(visible = true, transformation(origin={-40,0},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
      Placement(visible = true, transformation(origin={-10,0},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
    ConstantEfficiency constantEfficiency annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  equation
    connect(ramp.y, torque.tau) annotation (Line(points={{-29,0},{-22,0}}, color = {0, 0, 127}));
    connect(torque.flange, constantEfficiency.flange_a) annotation (Line(points={{0,0},{10,0}}, color={0,0,0}));
    connect(constantEfficiency.flange_b, inertia.flange_a) annotation (Line(points={{30,0},{40,0}}, color={0,0,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})));
  end Drive;

  model ConstantEfficiency "Efficiency model considering constant efficiency"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
    parameter Real efficiency = 0.9 "Efficiency coefficient";
    Modelica.SIunits.Angle phi "Angle of flange_a";
    Modelica.SIunits.AngularVelocity w
      "Absolute angular velocity of flange_a and flange_b";
    Modelica.SIunits.AngularAcceleration a
      "Absolute acceleration of flange_a and flange_b";
    Modelica.SIunits.Power power_a(start=0) = flange_a.tau * w
      "Power input of flange_a";
    Modelica.SIunits.Power power_b = flange_b.tau * w
      "Power input of flange_b";
    Modelica.SIunits.Torque tau_loss(final start = 0) "Friction torque";
    extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  equation
    phi = flange_a.phi - phi_support;
    flange_a.phi = flange_b.phi;
    // Velocity and acceleration
    w = der(phi);
    a = der(w);
    // Torque balance
    flange_a.tau + flange_b.tau - tau_loss = 0;
  //  power_b = smooth(1, if power_a > 0 then -power_a * efficiency else -power_a / efficiency);
    flange_b.tau = smooth(0, if power_a > 0 then -flange_a.tau * efficiency else -flange_a.tau / efficiency);
    lossPower = tau_loss * w;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0},
            fillPattern = FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0},
            fillPattern = FillPattern.Sphere, fillColor = {255, 255, 255}, textString = "%%")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      Documentation(info="<html>
<p>Model of constant efficiency independent of speed and torque.</p>
</html>"));
  end ConstantEfficiency;

  annotation (uses(Modelica(version="3.2.2")));
end Efficiency;
