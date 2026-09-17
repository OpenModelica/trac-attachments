package IssueFem
model testOM "Real valves, one leg P-Q measure"
  Modelica.Electrical.Analog.Sources.SineVoltage fem(V=40, freqHz=50)
    annotation (Placement(visible=true, transformation(
        origin={66,-16},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode dD(Vknee = 0.1) annotation (
    Placement(visible = true, transformation(origin = {-60, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor dSW(Vknee = 0.1) annotation (
    Placement(visible = true, transformation(origin = {-40, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode uD(Vknee = 0.1) annotation (
    Placement(visible = true, transformation(origin = {-68, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor uSW(Vknee = 0.1) annotation (
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.Constant Ampl(k = 0.9) annotation (
    Placement(visible = true, transformation(origin = {67, 41}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant phase(k = +10) annotation (
    Placement(visible = true, transformation(origin = {47, 55}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  PwmPulser pwmPulser annotation (
    Placement(visible = true, transformation(origin = {15, 48}, extent = {{-13, -12}, {13, 12}}, rotation = 180)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(visible = true, transformation(extent = {{2, -54}, {22, -34}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation (
    Placement(visible = true, transformation(origin = {-84, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent = {{-84, -12}, {-64, 8}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cf(C = 634e-6) annotation (
    Placement(visible = true, transformation(origin = {30, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation (
    Placement(visible = true, transformation(extent = {{-6, -6}, {14, 14}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor Rf(R = 0.125) annotation (
    Placement(visible = true, transformation(extent={{-42,-4},{-22,16}},      rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation (
    Placement(visible = true, transformation(origin = {-84, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
equation
  connect(Lf.n, fem.p)
    annotation (Line(points={{14,4},{66,4},{66,-6}}, color={0,0,255}));
  connect(fem.n, Cf.n)
    annotation (Line(points={{66,-26},{30,-26}}, color={0,0,255}));
connect(uD.p, dD.n) annotation (
    Line(points = {{-68, 50}, {-68, 34}, {-60, 34}, {-60, -24}}, color = {0, 0, 255}));
connect(V2.n, dD.p) annotation (
    Line(points = {{-84, -30}, {-84, -58}, {-60, -58}, {-60, -44}}, color = {0, 0, 255}));
connect(Rf.p, dD.n) annotation (
    Line(points={{-42,6},{-60,6},{-60,-24}},        color = {0, 0, 255}));
connect(dD.n, dSW.p) annotation (
    Line(points={{-60,-24},{-60,-20},{-40,-20},{-40,-24}},          color = {0, 0, 255}));
connect(dSW.n, dD.p) annotation (
    Line(points = {{-40, -44}, {-40, -58}, {-60, -58}, {-60, -44}}, color = {0, 0, 255}));
connect(pwmPulser.down, dSW.fire) annotation (
    Line(points = {{0.7, 54.96}, {-12, 54.96}, {-12, -40}, {-29, -40}, {-29, -41}}, color = {255, 0, 255}));
connect(V1.p, uD.n) annotation (
    Line(points = {{-84, 34}, {-84, 76}, {-68, 76}, {-68, 70}}, color = {0, 0, 255}));
connect(uSW.n, uD.p) annotation (
    Line(points = {{-50, 50}, {-50, 42}, {-68, 42}, {-68, 50}}, color = {0, 0, 255}));
  connect(uD.n, uSW.p) annotation (
    Line(points={{-68,70},{-68,74},{-50,74},{-50,70}},          color = {0, 0, 255}));
  connect(uSW.fire, pwmPulser.up) annotation (
    Line(points={{-39,53},{-22,53},{-22,40.08},{0.7,40.08}},          color = {255, 0, 255}));
  connect(Ampl.y, pwmPulser.ampl) annotation (
    Line(points={{59.3,41},{43.65,41},{43.65,40.32},{30.6,40.32}},          color = {0, 0, 127}));
  connect(phase.y, pwmPulser.ph_deg) annotation (
    Line(points={{39.3,55},{37.65,55},{37.65,54.48},{30.6,54.48}},          color = {0, 0, 127}));
connect(ground1.p, Cf.n) annotation (
    Line(points={{12,-34},{12,-34},{12,-26},{30,-26}},          color = {0, 0, 255}));
connect(V1.n, V2.p) annotation (
    Line(points = {{-84, 14}, {-84, -10}, {-84, -10}}, color = {0, 0, 255}));
connect(ground.p, V1.n) annotation (
    Line(points={{-74,8},{-74,14},{-84,14}},        color = {0, 0, 255}));
connect(Cf.p, Lf.n) annotation (
    Line(points={{30,-6},{30,-6},{30,2},{14,2},{14,4}},            color = {0, 0, 255}));
connect(Lf.p, Rf.n) annotation (
    Line(points={{-6,4},{-10,4},{-10,6},{-22,6}},
                                       color = {0, 0, 255}));
  annotation (
    experiment(StopTime = 0.06, Interval = 5e-005),
    Documentation(info = "<html><head></head><body><p><br></p>
</body></html>"),
Diagram(coordinateSystem(extent = {{-100, -60}, {80, 80}}, preserveAspectRatio = false)),
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
__OpenModelica_commandLineOptions = "");
end testOM;
model PwmPulser
  Modelica.Blocks.Interfaces.RealInput ampl annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(
          extent={{-140,44},{-100,84}})));
  Modelica.Blocks.Interfaces.RealInput ph_deg annotation (Placement(
        transformation(extent={{-138,-76},{-98,-36}}), iconTransformation(
          extent={{-140,-74},{-100,-34}})));
  parameter Modelica.SIunits.Frequency fCar=1000 "Carrier Frequency";
  import PI = Modelica.Constants.pi;
protected
  Modelica.Blocks.Sources.Trapezoid carrier(
    rising=1/(2*fCar),
    width=0,
    falling=1/(2*fCar),
    period=1/fCar,
    amplitude=2,
    offset=-1)
    annotation (Placement(transformation(extent={{14,-56},{34,-36}})));
  Modelica.Blocks.Math.Sin sin
    annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-50,16},{-32,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=2*PI*fMod)
    annotation (Placement(transformation(extent={{-90,14},{-64,36}})));
public
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-54,-28},{-34,-8}})));
  Modelica.Blocks.Math.Gain ToRAD(k=PI/180)
    annotation (Placement(transformation(extent={{-66,-62},{-54,-50}})));
  Modelica.Blocks.Math.Product moduler
    annotation (Placement(transformation(extent={{14,-22},{32,-4}})));
  Modelica.Blocks.Interfaces.BooleanOutput up annotation (Placement(
        transformation(extent={{100,10},{120,30}}), iconTransformation(extent=
           {{100,56},{120,76}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{46,-24},{66,-4}})));
  Modelica.Blocks.Interfaces.BooleanOutput down annotation (Placement(
        transformation(extent={{100,-62},{120,-42}}), iconTransformation(
          extent={{100,-68},{120,-48}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  parameter Modelica.SIunits.Frequency fMod=50 "Modulating wave Frequency";
equation
  connect(ToRAD.u, ph_deg) annotation (Line(
      points={{-67.2,-56},{-118,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sin.u, add.y) annotation (Line(
      points={{-22,-18},{-33,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(moduler.u2, sin.y) annotation (Line(
      points={{12.2,-18.4},{14,-18.4},{14,-18},{1,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u1, integrator.y) annotation (Line(
      points={{-56,-12},{-64,-12},{-64,2},{-24,2},{-24,25},{-31.1,25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(moduler.u1, ampl) annotation (Line(
      points={{12.2,-7.6},{12.2,60},{-120,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.u2, ToRAD.y) annotation (Line(
      points={{-56,-24},{-64,-24},{-64,-34},{-46,-34},{-46,-56},{-53.4,-56}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(greater.u1, moduler.y) annotation (Line(
      points={{44,-14},{46.45,-14},{46.45,-13},{32.9,-13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greater.u2, carrier.y) annotation (Line(
      points={{44,-22},{44,-46},{35,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(up, greater.y) annotation (Line(
      points={{110,20},{74,20},{74,-14},{67,-14}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.y, down) annotation (Line(
      points={{81,-50},{84,-50},{84,-52},{110,-52}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(not1.u, greater.y) annotation (Line(
      points={{58,-50},{52,-50},{52,-32},{74,-32},{74,-14},{67,-14}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(integrator.u, realExpression.y) annotation (Line(
      points={{-51.8,25},{-62.7,25}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{
            100,80}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Text(
          extent={{-98,88},{-40,60}},
          lineColor={0,0,127},
          textString="ampl"),
        Text(
          extent={{-98,-62},{-28,-88}},
          lineColor={0,0,127},
          textString="ph(°)"),
        Text(
          extent={{28,86},{100,60}},
          lineColor={255,0,255},
          textString="u"),
        Text(
          extent={{42,-62},{96,-88}},
          lineColor={255,0,255},
          textString="d",
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-60},{-40,62},{-20,-60},{0,60},{20,-62},{40,60},{60,-62},
              {80,58}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-80,20},{-38,40},{0,44},{42,40},{80,20}},
          color={0,0,127},
          smooth=Smooth.None,
          thickness=0.5),
        Text(
          extent={{-100,140},{100,110}},
          lineColor={0,0,255},
          textString="%name")}),
    __OpenModelica_commandLineOptions="");
end PwmPulser;

  annotation(
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end IssueFem;
