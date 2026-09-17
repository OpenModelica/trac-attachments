within ;
model TestIndexReduction4
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Electrical.MultiPhase.Functions.factorY2DC;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=400
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Resistance RGrid=10e-3 "Grid choke resistance";
  parameter Modelica.SIunits.Resistance RLoad=1 "Load resistance";
  parameter Modelica.SIunits.Inductance LGrid=500e-6 "Grid choke inductance";
  parameter Modelica.SIunits.Voltage VDC=factorY2DC(m)*VNominal/sqrt(3) "Theoretical DC voltage";
  parameter Modelica.SIunits.Capacitance CDC=5e-3 "DC capacitor";
  parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
  parameter Modelica.SIunits.AngularVelocity wLoad=1440.45*2*pi/60 "Nominal load speed";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    final m=m,
    final phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
        m),
    final freqHz=fill(fNominal, m),
    final offset=zeros(m),
    final startTime=zeros(m),
    final V=fill(VNominal*sqrt(2/3), m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(origin={-80,-90}, extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor gridCurrent
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
    final m=m,
    final R=fill(RGrid, m),
    final T_ref=fill(20, m),
    final alpha=zeros(m),
    final T=fill(20, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductor(m=m, final L=fill(
        LGrid, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,60})));

  Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(fixed=true, start=VDC),
      C=CDC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  Modelica.Electrical.PowerConverters.DCAC.MultiPhase2Level inverter
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,
            70})));
  Modelica.Blocks.Sources.Ramp ramp(height=fNominal,
    startTime=0,
    duration=1.2)
    annotation (
     Placement(transformation(extent={{-10,-10},{10,10}},
        origin={-20,-50})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal,
    EconomyMode=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-20})));

  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
  Modelica.Electrical.PowerConverters.DCAC.Control.PWM pwm(uMax=VDC, f=2000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(
    final m=m,
    final R=fill(RLoad, m),
    final T_ref=fill(20, m),
    final alpha=zeros(m),
    final T=fill(20, m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={44,70})));
  Modelica.Electrical.MultiPhase.Basic.Delta delta
    annotation (Placement(transformation(extent={{34,36},{54,56}})));
equation
  connect(vfController.u, ramp.y)
    annotation (Line(points={{0,-32},{0,-50},{-9,-50}},
                                               color={0,0,127}));
  connect(toSpacePhasor.u, vfController.y)
    annotation (Line(points={{0,-2},{0,-9}},   color={0,0,127}));
  connect(pwm.u, toSpacePhasor.y)
    annotation (Line(points={{0,28},{0,21}},   color={0,0,127}));
  connect(inverter.fire_p, pwm.fire_p)
    annotation (Line(points={{-6,58},{-6,51}}, color={255,0,255}));
  connect(inverter.fire_n, pwm.fire_n)
    annotation (Line(points={{6,58},{6,51}}, color={255,0,255}));
  connect(capacitor.p, inverter.dc_p) annotation (Line(points={{-30,80},{-20,80},
          {-20,76},{-10,76}}, color={0,0,255}));
  connect(capacitor.n, inverter.dc_n) annotation (Line(points={{-30,60},{-20,60},
          {-20,64},{-10,64}}, color={0,0,255}));
  connect(rectifier.dc_p, capacitor.p) annotation (Line(points={{-48,76},{-40,76},
          {-40,80},{-30,80}}, color={0,0,255}));
  connect(rectifier.dc_n, capacitor.n) annotation (Line(points={{-48,64},{-40,64},
          {-40,60},{-30,60}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-80,-40},{-80,-50}},   color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p)
    annotation (Line(points={{-80,40},{-80,50}},   color={0,0,255}));
  connect(inductor.plug_n, rectifier.ac)
    annotation (Line(points={{-80,70},{-68,70}},  color={0,0,255}));
  connect(resistor.plug_p, gridCurrent.plug_p)
    annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(gridCurrent.plug_n, sineVoltage.plug_p)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(inverter.ac, resistor1.plug_p)
    annotation (Line(points={{10,70},{34,70}}, color={0,0,255}));
  connect(resistor1.plug_p, delta.plug_p)
    annotation (Line(points={{34,70},{34,46}}, color={0,0,255}));
  connect(delta.plug_n, resistor1.plug_n)
    annotation (Line(points={{54,46},{54,70}}, color={0,0,255}));
  annotation (experiment(
      StopTime=0.1,
      Interval=5e-05,
      Tolerance=1e-06), Documentation(
        info="<html>
<p>
This is a model of a complete inverter drive comprising:
</p>
<ul>
<li>a grid model and a line choke</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse\">a diode rectifier</a></li>
<li>a buffer capacitor</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.MultiPhase2Level\">a switching inverter</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.PWM\">a pulse width modulation</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">a voltage/frequency characteristic</a></li>
<li>the reference frequency ramped up</li>
<li>an induction machine with squirrel cage</li>
<li>a load inertia and quadratic speed dependent load torque (like a fan or pump)</li>
</ul>
<p>Please note: Be patient, two switching devices cause many event iteratons which cost performance.</p>
<p>Note that due to the voltage drop the voltage at the machine can't reach the full voltage which means torque reduction.</p>
<p>Default machine parameters are adapted to nominal phase voltage 400 V and nominal phase current 25 A.</p>
</html>"),
    uses(Modelica(version="3.2.3")));
end TestIndexReduction4;
