within ;
model BiChopper
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageLV(V=12)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-90,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorLV(R=0.01)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageHV(V=24)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorHV(R=0.01)
    annotation (Placement(transformation(extent={{90,40},{70,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=1,
    offset=0,
    startTime=0.5)
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3, useHeatPort=false)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true), L=4.7e-6)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeLS(useHeatPort=false) 
    "Free wheeling diode low side" annotation (Placement(
        transformation(
        origin={-20,0},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorLS(useHeatPort=false)
    "Switching transistor low side" annotation (
      Placement(transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeHS(useHeatPort=false)
    "Free wheeling diode high side" annotation (Placement(
        transformation(
        origin={30,70},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorHS(useHeatPort=false)
    "Switching transistor hugh side" annotation (
      Placement(transformation(
        origin={30,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(
    useConstantDutyCycle=false, f=10e3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,0})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorLV(v(fixed=true, start=12), C=470e-6) 
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorHV(v(fixed=true, start=24), C=100e-6) 
    annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,0})));
equation
  connect(constantVoltageLV.p, resistorLV.p)
    annotation (Line(points={{-90,10},{-90,50}}, color={0,0,255}));
  connect(constantVoltageLV.n, ground.p)
    annotation (Line(points={{-90,-10},{-90,-50}}, color={0,0,255}));
  connect(resistorHV.p, constantVoltageHV.p)
    annotation (Line(points={{90,50},{90,10}}, color={0,0,255}));
  connect(resistorLV.n, resistor.p)
    annotation (Line(points={{-70,50},{-50,50}}, color={0,0,255}));
  connect(inductor.n, transistorLS.p) 
    annotation (Line(points={{0,50},{0,14},{
          1.77636e-15,14},{1.77636e-15,10}},
                                 color={0,0,255}));
  connect(diodeLS.n, transistorLS.p)
    annotation (Line(points={{-20,10},{1.77636e-15,10}}, color={0,0,255}));
  connect(ground.p, transistorLS.n) 
    annotation (Line(points={{-90,-50},{
          -1.77636e-15,-50},{-1.77636e-15,-10}},
                            color={0,0,255}));
  connect(transistorLS.n, diodeLS.p) 
    annotation (Line(points={{-1.77636e-15,-10},
          {-20,-10}},                color={0,0,255}));
  connect(ground.p, constantVoltageHV.n)
    annotation (Line(points={{-90,-50},{90,-50},{90,-10}}, color={0,0,255}));
  connect(inductor.n, transistorHS.n)
    annotation (Line(points={{0,50},{20,50}}, color={0,0,255}));
  connect(transistorHS.p, resistorHV.n)
    annotation (Line(points={{40,50},{70,50}}, color={0,0,255}));
  connect(diodeHS.p, transistorHS.n)
    annotation (Line(points={{20,70},{20,50}}, color={0,0,255}));
  connect(pwm.notFire, transistorHS.fire)
    annotation (Line(points={{29,6},{20,6},{20,38}},   color={255,0,255}));
  connect(pwm.fire, transistorLS.fire)
    annotation (Line(points={{29,-6},{20,-6},{20,-10},{12,-10}},
                                                           color={255,0,255}));
  connect(ramp.y, pwm.dutyCycle)
    annotation (Line(points={{31,-30},{40,-30},{40,-12}},color={0,0,127}));
  connect(diodeHS.n, transistorHS.p)
    annotation (Line(points={{40,70},{40,50}}, color={0,0,255}));
  connect(transistorHS.p, capacitorHV.p)
    annotation (Line(points={{40,50},{60,50},{60,10}}, color={0,0,255}));
  connect(ground.p, capacitorHV.n) 
    annotation (Line(points={{-90,-50},{60,-50},
          {60,-10}},        color={0,0,255}));
  connect(ground.p, capacitorLV.n) 
    annotation (Line(points={{-90,-50},{-60,-50},
          {-60,-10}},          color={0,0,255}));
  connect(resistor.n, inductor.p) 
    annotation (Line(points={{-30,50},{-20,50}},
                         color={0,0,255}));
  connect(resistor.p, capacitorLV.p)
    annotation (Line(points={{-50,50},{-60,50},{-60,10}},
                                                 color={0,0,255}));
  annotation (experiment(
      StopTime=2,
      Interval=2e-06,
      Tolerance=1e-06, StartTime = 0),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{100,100}})),
    uses(Modelica(version="4.0.0")),
    Documentation(info="<html>
<p>
This is a model of a bidirectional DC/DC converter to couple a 12 V battery with a 48 V battery in automotive systems. 
</p>
<p>
&copy; Prof. A. Haumer / OTH Regensburg, Germaby
</p>
</html>"));
end BiChopper;
