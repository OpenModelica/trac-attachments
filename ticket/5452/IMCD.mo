within ;
model IMCD "Induction machine with transformer and cable"

  import Modelica.Constants.pi;
  import SI = Modelica.SIunits;
  parameter Integer m=3 "Number of phases";
  parameter Integer mBase=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)
    "Number of base systems";
  parameter SI.Frequency fN = 50 "Nominal frequency";
  final parameter SI.AngularVelocity omegaN = 2 * pi * fN "Nominal angular frequency";

  // Transformer
  parameter SI.Voltage U1N = 10000 "Nominal primary voltage of transformer";
  final parameter SI.Voltage U1strN = U1N / sqrt(3) "Nominal transformer phase voltage of primary";
  parameter SI.ApparentPower SN = 100E3 "Nominal transformer apparent power";
  final parameter SI.Current I1strN = SN / 3 / U1strN "Nominal transformer phase current of primary";
  parameter SI.Power Pk = 1750 "Short circuit power";
  parameter Real uk = 0.04 "Per unit short curcit voltage";
  parameter Real n12 = U1N / UMN "Voltage ratio of transformer";
  parameter SI.Resistance Rk = Pk / 3 / I1strN^2 "Phase short circuit resistance";
  parameter SI.Resistance R1 = Rk / 2 "Primary winding resistance";
  parameter SI.Resistance R2 = R1 / n12^2 "Secondary winding resistance";
  parameter SI.Impedance Zk = uk * U1N / I1strN "Magnitude of short circuit impedance";
  parameter SI.Reactance Xk = sqrt(Zk^2 - Rk^2) "Short circuit reactance";
  final parameter SI.Inductance L1sigma = Xk / 2 / omegaN "Primary winding stray indutance";
  final parameter SI.Inductance L2sigma = L1sigma / n12^2 "Secondary winding stray indutance";

  parameter SI.ApparentPower SMN = 20091.8 "Nominal apparent power of motor";
  parameter SI.Voltage UMN = 400 "Nominal RMS voltage of motor";
  parameter SI.Voltage UMstrN = UMN "Nominal phase RMS voltage per phase";
  parameter SI.Current IMstrN = SMN / 3 / UMstrN "Nominal RMS phase current per phase";
  parameter SI.Impedance ZMstrN = UMstrN / IMstrN "Reference phase impedance";
  parameter Integer p = 1 "Number of pole pairs";

  parameter Real rs = 0.031562090934112 "Per unit stator resistance";
  parameter SI.Resistance Rs = rs * ZMstrN "Stator resistance";
  parameter Real xh = 3.60843401335745 "Per unit main fiel reactance";
  parameter SI.Inductance Lh = xh * ZMstrN / omegaN "Main field reactance";
  parameter Real xrsigma = 0.258805468594768 "Per unit rotor reactance = total reactance";
  parameter SI.Inductance Lssigma = xrsigma / 2 * ZMstrN / omegaN "Stator stray inductance";
  parameter SI.Inductance Lrsigma = Lssigma "Rotor stray inductance";
  parameter Real rr = 0.026789902784874 "Per unit rotor resistance";
  parameter SI.Resistance Rr = rr * ZMstrN "Rotor phase resistance";
  parameter SI.Inertia Jr = 0.04 "Rotor inertia";
  parameter Real pmN = 0.79290068101565 "Per unit mechanical nominal power";
  final parameter SI.Power PmN = pmN * SMN "Mechnical nominal power";
  parameter Real sN = 0.025 "Nominal slip";
  final parameter SI.AngularVelocity wN = 2 * pi * fN / p * (1 - sN) "Nominal mechanical angular velocity";
  final parameter SI.Torque MN = PmN / wN "Nominal torque";

  parameter Real RperL(unit = "Ohm/m") = 0.20E-3 "Resistance of cable in a unit of length";
  parameter Real XperL(unit = "Ohm/m") = 0.08E-3 "Reactance of cable in a unit of length";
  parameter SI.Length L = 150 "Length of cable";
  final parameter SI.Resistance RL = RperL * L "Resistance of cable";
  final parameter SI.Reactance XL = XperL * L "Reactance of cable";
  final parameter SI.Inductance LL = XL / omegaN "Inductance of cable";

  parameter SI.ApparentPower Snetz = 100E6 "Short circuit gird power";
  final parameter SI.Reactance Xnetz = U1N^2 / Snetz "Mains reactance";
  final parameter SI.Inductance Lnetz = Xnetz / omegaN "Mains inductance";

  parameter SI.Time tOn=1 "Start time of machine";
  parameter SI.Torque tauLoad=-MN "Nominal load torque";
  parameter SI.AngularVelocity w_Load(displayUnit="rev/min")=wN "Nominal load speed";
  parameter SI.Inertia JLoad=0.5 "Load inertia";
  // SI.Current I=currentRMSSensor.I "Transient RMS current";
  SI.Current Iqs=currentRMSSensor.I "QS RMS current";
  Modelica.Electrical.MultiPhase.Basic.Star starQS(m=3)
    annotation (Placement(transformation(origin={-50,-90},
                                                         extent={{10,10},{-10,-10}},rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-20,-90})));
  Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensor(m=3) annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=3) annotation (Placement(transformation(extent={{10,80},{30,60}})));
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-40,70},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Blocks.Sources.BooleanStep
    booleanStepOn[m](each startTime=tOn, each startValue=false)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,-28})));
  Modelica.Electrical.MultiPhase.Basic.Star starMachine(m=3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,22})));
  Modelica.Electrical.Machines.BasicMachines.Transformers.Yy.Yy00                 transformer(n=n12,
    R1=R1,
    T1Ref=343.15,
    L1sigma=L1sigma,
    R2=R2,
    T2Ref=343.15,
    L2sigma=L2sigma,
    T1Operational=343.15,
    T2Operational=343.15)                                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-10})));
  Modelica.Electrical.MultiPhase.Basic.Inductor  inductor(m=3, L=fill(LL, 3))
                                                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,60})));
  Modelica.Electrical.MultiPhase.Basic.Resistor  resistor(m=3, R=fill(RL, 3))
                                                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,30})));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductorGrid(m=3, L=fill(Lnetz, 3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-40})));
  Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageTransformer(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,10})));
  Modelica.Electrical.MultiPhase.Basic.Delta deltaTransformer(m=3)
                                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,40})));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    m=3,
    V=fill(sqrt(2)*U1strN, 3),
    freqHz=fill(fN, 3))                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-70})));
  Modelica.Electrical.MultiPhase.Basic.Resistor  resistor1(m=3, R=fill(0E-4, 3))
                                                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-30})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=JLoad)
               annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorqueQS(
    w_nominal=w_Load,
    tau_nominal=tauLoad,
    TorqueDirection=false,
    useSupport=false) annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
  Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage imc(
    Jr=Jr,
    p=p,
    fsNominal=fN,
    TsRef=378.15,
    alpha20s(displayUnit="1/K"),
    TrRef=378.15,
    alpha20r(displayUnit="1/K"),
    Rs=Rs,
    Lssigma=Lssigma,
    Lm=Lh,
    Lrsigma=Lrsigma,
    Rr=Rr,
    m=3,
    wMechanical(fixed=true),
    TsOperational=378.15,
    effectiveStatorTurns=1,
    TrOperational=378.15) annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageMachine(m=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,10})));
  Modelica.Electrical.MultiPhase.Basic.Delta deltaMachine annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,40})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(m=m,
      terminalConnection="D")                                                                 annotation (Placement(transformation(extent={{20,-64},
            {40,-44}})));
initial equation
  // Commenting transient case
  // sum(imc.is) = 0;
  // imc.is[1:2] = zeros(2);
  // imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);

equation
  connect(booleanStepOn.y, idealCloser.control) annotation (Line(points={{-59,90},{-40,90},{-40,82}}, color={255,0,255}));
  connect(inductor.plug_n, idealCloser.plug_p) annotation (Line(points={{-70,70},{-50,70}}, color={0,0,255}));
  connect(transformer.plug2, resistor.plug_p) annotation (Line(points={{-70,0},{-70,20}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) annotation (Line(points={{-70,40},{-70,50}}, color={0,0,255}));
  connect(voltageTransformer.plug_n, deltaTransformer.plug_n) annotation (Line(points={{-30,10},{-20,10},{-20,40},{-30,40}}, color={0,0,255}));
  connect(deltaTransformer.plug_p, voltageTransformer.plug_p) annotation (Line(points={{-50,40},{-60,40},{-60,10},{-50,10}}, color={0,0,255}));
  connect(voltageTransformer.plug_p, transformer.plug2) annotation (Line(points={{-50,10},{-70,10},{-70,0}}, color={0,0,255}));
  connect(sineVoltage.plug_p, inductorGrid.plug_p) annotation (Line(points={{-70,-60},{-70,-50}}, color={0,0,255}));
  connect(sineVoltage.plug_n, starQS.plug_p) annotation (Line(points={{-70,-80},{-70,-90},{-60,-90}}, color={0,0,255}));
  connect(starQS.pin_n, ground.p) annotation (Line(points={{-40,-90},{-30,-90}}, color={0,0,255}));
  connect(idealCloser.plug_n, powerSensor.pc) annotation (Line(points={{-30,70},{-20,70}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{-20,70},{-20,80},{-10,80}}, color={0,0,255}));
  connect(powerSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{0,70},{10,70}}, color={0,0,255}));
  connect(powerSensor.nv, starMachine.plug_p) annotation (Line(points={{-10,60},{-10,40},{0,40},{0,32},{1.77636e-15,32}}, color={0,0,255}));
  connect(starMachine.pin_n, groundMachine.p) annotation (Line(points={{-1.77636e-15,12},{-1.77636e-15,10},{0,10},{0,-18}}, color={0,0,255}));
  connect(transformer.starpoint1, starQS.pin_n) annotation (Line(points={{-60,-15},{-40,-15},{-40,-90}}, color={0,0,255}));
  connect(transformer.starpoint2, groundMachine.p) annotation (Line(points={{-60,-5},{0,-5},{0,-18}},   color={0,0,255}));
  connect(inductorGrid.plug_n, resistor1.plug_p) annotation (Line(points={{-70,-30},{-86,-30},{-86,-40},{-100,-40}}, color={0,0,255}));
  connect(resistor1.plug_n, transformer.plug1) annotation (Line(points={{-100,-20},{-70,-20}}, color={0,0,255}));
  connect(imc.flange,loadInertiaQS. flange_a) annotation (Line(points={{40,-80},{50,-80}}, color={0,0,255}));
  connect(loadInertiaQS.flange_b,quadraticLoadTorqueQS. flange) annotation (Line(points={{70,-80},{80,-80}},
                                                                                                           color={0,0,255}));
  connect(deltaMachine.plug_p,voltageMachine. plug_p) annotation (Line(points={{50,40},
          {40,40},{40,10},{50,10}},                                                                              color={0,0,255}));
  connect(deltaMachine.plug_n,voltageMachine. plug_n) annotation (Line(points={{70,40},
          {80,40},{80,10},{70,10}},                                                                              color={0,0,255}));
  connect(voltageMachine.plug_p, currentRMSSensor.plug_n) annotation (Line(points={{50,10},
          {30,10},{30,70}},                                                                          color={0,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn)
    annotation (Line(points={{24,-60},{24,-70}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp)
    annotation (Line(points={{36,-60},{36,-70}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n)
    annotation (Line(points={{30,-58},{30,70}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
        experiment(
      StopTime=120,
      Interval=0.0005,
      Tolerance=1e-06),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This example compares a time transient and a quasi static model of a multi phase induction machine. 
At start time <code>tOn</code> a transient and a quasi static multi phase voltage source are 
connected to an induction machine. The machines starts from standstill, accelerating inertias 
against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>imc.tauElectrical</code>: transient torque</li>
<li><code>imc.wMechanical</code>: transient speed</li>
<li><code>imc.tauElectrical</code> against <code>imc.wMechanical</code>: transient torque speed characteristic</li>
<li><code>imcQS.tauElectrical</code>: quasi static torque</li>
<li><code>imcQS.wMechanical</code>: quasi static speed</li>
<li><code>imcQS.tauElectrical</code> against <code>imcQS.wMechanical</code>: quasi static torque speed characteristic</li>
<li><code>currentRMSsensor.I</code>: quasi RMS stator current of transient machine</li>
<li><code>currentSensorQS.abs_i[1]</code>: RMS stator current of phase 1 of quasi static machine</li>
<li><code>imc.stator.electroMagneticConverter.abs_Phi</code>: magnitude of stator flux of transient machine</li>
<li><code>imcQS.stator.electroMagneticConverter.abs_Phi</code>: magnitude of stator flux of quasi static machine</li>
</ul>
</html>"),
    uses(Modelica(version="3.2.3")));
end IMCD;
