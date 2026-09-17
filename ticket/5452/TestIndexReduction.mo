within ;
model TestIndexReduction
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Electrical.MultiPhase.Functions.factorY2DC;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=400
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Resistance RGrid=10e-3 "Grid choke resistance";
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

  Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,50})));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L=0.001) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,16})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(
        transformation(origin={-30,-14}, extent={{-10,-10},{10,10}})));
equation
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-80,-40},{-80,-50}},   color={0,0,255}));
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p)
    annotation (Line(points={{-80,40},{-80,50}},   color={0,0,255}));
  connect(resistor.plug_p, gridCurrent.plug_p)
    annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(gridCurrent.plug_n, sineVoltage.plug_p)
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(inductor.plug_n, star1.plug_p) annotation (Line(points={{-80,70},{-80,
          74},{-30,74},{-30,60}}, color={0,0,255}));
  connect(star1.pin_n, inductor1.p)
    annotation (Line(points={{-30,40},{-30,26}}, color={0,0,255}));
  connect(inductor1.n, ground1.p)
    annotation (Line(points={{-30,6},{-30,-4}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1.5,
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
end TestIndexReduction;
