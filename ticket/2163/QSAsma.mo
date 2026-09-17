within ;
model QSAsma
  import PI = Modelica.Constants.pi;
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor L1_(L=L1, i(re(
          start=0.001)))                                                      annotation (Placement(transformation(extent={{-8,8},{
            12,28}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor R1_(R_ref=R1)    annotation (Placement(transformation(extent={{-32,8},
            {-12,28}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor L2_(L=L2)    annotation (Placement(transformation(extent={{26,8},{
            46,28}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor Lm_(L=Lm)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,-4})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor Rmecc  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-2})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource
    uTerminals            annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-72,-2})));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex ToComplexUin      annotation (Placement(transformation(
        origin={-70,84},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput U    annotation (Placement(transformation(extent={{-160,40},
            {-120,80}}), iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,58})));
  Modelica.Blocks.Interfaces.RealInput f    annotation (Placement(transformation(extent={{-160,
            -80},{-120,-40}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{108,68},{128,88}}),iconTransformation(
          extent={{88,-10},{108,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque    annotation (Placement(transformation(extent={{14,68},
            {34,88}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor Wm annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={72,60})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor Pag    annotation (Placement(transformation(extent={{54,8},{
            74,28}})));
  Modelica.Blocks.Sources.RealExpression WmS1(y=3*toPag.re/W0)
                                                        annotation (Placement(transformation(extent={{-36,68},
            {-4,88}})));
  parameter Integer pp=2 "pole pairs";
  parameter Real R1=0.435 "stator's phase resistance (ohm)";
  parameter Real L1=4.0e-3 "stator's leakage inductance (H)";
  parameter Real Lm=69.3e-3 "stator's leakage inductance (H)";
  parameter Real R2=0.4 "rotor's phase resistance (ohm)";
  parameter Real L2=2.0e-3 "rotor's leakage inductance (H)";
  parameter Real J=2.0 "rotor's moment of inertia (kg.m^2)";
  Real W0; //velocità meccanica di soncronismo
  Real s; //scorrimento

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J)    annotation (Placement(transformation(extent={{82,68},{102,88}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toPag annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={52,-6})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground   annotation (Placement(transformation(extent={{-8,-40},
            {12,-20}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toPin annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-54,-10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor Pin    annotation (Placement(transformation(extent={{-56,8},
            {-36,28}})));
  Modelica.Blocks.Interfaces.RealOutput Pdc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-110})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor Ir_
                  annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=180,
        origin={29,-20})));
  Modelica.Blocks.Interfaces.RealOutput Ir  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor PmGen    annotation (Placement(transformation(extent={{46,68},{66,88}})));
  Modelica.Blocks.Math.Gain toPdc(k=3)      annotation (Placement(transformation(extent={{-8,-8},
            {8,8}},
        rotation=-90,
        origin={-80,-80})));
  Modelica.Blocks.Interfaces.RealOutput Pmecc
                                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-110})));
  Modelica.Blocks.Math.Gain toPmecc(k=3)    annotation (Placement(transformation(extent={{-8,-8},
            {8,8}},
        rotation=-90,
        origin={80,-80})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toIrre        annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={1,-73})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor Is
                  annotation (Placement(transformation(
        extent={{-9,8},{9,-8}},
        rotation=180,
        origin={-19,-20})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar toIs annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-19,-53})));
algorithm
  if abs(f)<10^(-3) then
    W0:=10^(-3);
  else
    W0:=f*2*PI/pp;
  end if;
  s:=(W0-Wm.w)/W0;
  Rmecc.R_ref:=R2/s;
equation

  connect(R1_.pin_n, L1_.pin_p) annotation (Line(
      points={{-12,18},{-8,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(L1_.pin_n, L2_.pin_p) annotation (Line(
      points={{12,18},{26,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Lm_.pin_p, L1_.pin_n) annotation (Line(
      points={{2,6},{2,14},{12,14},{12,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ToComplexUin.y, uTerminals.V)              annotation (Line(
      points={{-59,84},{-40,84},{-40,40},{-100,40},{-100,2},{-82,2}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ToComplexUin.len, U)   annotation (Line(
      points={{-82,90},{-100,90},{-100,60},{-140,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, ToComplexUin.phi)   annotation (Line(
      points={{-81,58},{-92,58},{-92,78},{-82,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Pag.currentP, L2_.pin_n) annotation (Line(
      points={{54,18},{46,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pag.voltageP, Pag.currentP) annotation (Line(
      points={{64,28},{54,28},{54,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pag.voltageN, Rmecc.pin_n)
                                   annotation (Line(
      points={{64,8},{64,-20},{90,-20},{90,-12}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(WmS1.y, torque.tau) annotation (Line(
      points={{-2.4,78},{12,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inertia.flange_b, flange_a) annotation (Line(
      points={{102,78},{118,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Pag.y, toPag.u) annotation (Line(
      points={{56,7},{52,7},{52,1.2}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pag.currentN, Rmecc.pin_p) annotation (Line(
      points={{74,18},{90,18},{90,8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground.pin, Lm_.pin_n) annotation (Line(
      points={{2,-20},{2,-17},{2,-14},{2,-14}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pin.currentN, R1_.pin_p) annotation (Line(
      points={{-36,18},{-32,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pin.currentP, uTerminals.pin_p) annotation (Line(
      points={{-56,18},{-72,18},{-72,8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pin.voltageP, Pin.currentP) annotation (Line(
      points={{-46,28},{-56,28},{-56,18}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pin.y, toPin.u) annotation (Line(
      points={{-54,7},{-54,-2.8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Pin.voltageN, uTerminals.pin_n) annotation (Line(
      points={{-46,8},{-46,0},{-34,0},{-34,-20},{-72,-20},{-72,-12}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(PmGen.flange_a, torque.flange) annotation (Line(
      points={{46,78},{34,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(PmGen.flange_b, inertia.flange_a) annotation (Line(
      points={{66,78},{82,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Wm.flange, PmGen.flange_b) annotation (Line(
      points={{72,70},{72,78},{66,78}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Pdc, toPdc.y)
                       annotation (Line(
      points={{-80,-110},{-80,-88.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toPin.re, toPdc.u)
                            annotation (Line(
      points={{-50.4,-17.2},{-50.4,-44},{-80,-44},{-80,-70.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(uTerminals.f, f) annotation (Line(
      points={{-82,-6},{-100,-6},{-100,-60},{-140,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toPmecc.y, Pmecc) annotation (Line(
      points={{80,-88.8},{80,-88.8},{80,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toPmecc.u, toPag.re) annotation (Line(
      points={{80,-70.4},{80,-46},{55.6,-46},{55.6,-13.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toIrre.re, Ir)         annotation (Line(
      points={{5.2,-81.4},{5.2,-92.7},{0,-92.7},{0,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toIrre.u, Ir_.y)                  annotation (Line(
      points={{1,-64.6},{1,-48},{29,-48},{29,-28.8}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(ground.pin, Ir_.pin_n) annotation (Line(
      points={{2,-20},{20,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Ir_.pin_p, Rmecc.pin_n) annotation (Line(
      points={{38,-20},{90,-20},{90,-12}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Is.pin_p, ground.pin) annotation (Line(
      points={{-10,-20},{2,-20}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(Is.pin_n, uTerminals.pin_n) annotation (Line(
      points={{-28,-20},{-72,-20},{-72,-12}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(toIs.u, Is.y) annotation (Line(
      points={{-19,-44.6},{-19,-28.8}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,-100},{
            120,100}}),
            graphics={        Rectangle(
          extent={{-80,34},{100,-36}},
          lineColor={255,0,0},
          pattern=LinePattern.Dash)}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-120,-100},{120,100}}),
         graphics={
        Line(
          points={{-100,60},{-48,32}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-100,-60},{-48,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-106,138},{106,112}},
          lineColor={0,0,127},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{-42,66},{78,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175}),
        Rectangle(
          extent={{78,10},{98,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-42,66},{-62,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Polygon(
          points={{-54,-84},{-44,-84},{-14,-14},{36,-14},{66,-84},{76,-84},{
              76,-94},{-54,-94},{-54,-84}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>This model models ans asynchronous machine based on a quasi-stationary approximation: the equivalent single-phase circuit.</p>
<p>This model is very fast and compact, and gives result with sufficient precision in most vehicular propulsion needs.</p>
</html>"),
    uses(Modelica(version="3.2")));
end QSAsma;
