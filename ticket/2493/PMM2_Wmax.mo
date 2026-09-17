within ;
model PMM2_Wmax
  "Come PMM1, ma con step sulla corrente; blocchi per spezzare loop algebrici"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
protected
    Real[2] PsiR=smpm.airGapR.psi_mr;
    Real[2] PsiS=smpm.airGapR.psi_ms;
    Real[2] IpR=smpm.airGapR.i_sr;
    Real[2] IpS=smpm.airGapR.i_ss;
public
    Real TauS;
    Real TauR;

  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
    smpm(useDamperCage=false,
    Lmd=0.0009549,
    Lmq=0.0009549)
    annotation (Placement(transformation(extent={{-36,-60},{-16,-40}},
                                                                     rotation=0)));
  Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurr(final m=m)
    annotation (Placement(transformation(
        origin={22,20},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
        origin={50,20})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(
        origin={76,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground groundM
    annotation (Placement(transformation(
        origin={-50,-34},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y")
    annotation (Placement(transformation(
          extent={{-36,-32},{-16,-12}},
                                      rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleS
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-22})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.1)
    annotation (Placement(transformation(extent={{28,-60},{48,-40}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque Tres(
      tau_nominal=-5, w_nominal(displayUnit="rpm") = 200)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  FromPark FrPark(p=smpm.p)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Step Iq(
    height=-3,
    offset=3.5,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1e-3)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Step Id(
    offset=0,
    height=-141.42,
    startTime=0)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=1e-3)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor Pl
    annotation (Placement(transformation(extent={{54,-60},{74,-40}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor Psm
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
equation
  TauS=3*(IpS[2]*PsiS[1]-IpS[1]*PsiS[2]);  //coeff. 3/2*p=3 perché p=2
  TauR=3*(IpR[2]*PsiR[1]-IpR[1]*PsiR[2]);

  connect(star.pin_n, ground.p)
    annotation (Line(points={{60,20},{60,20},{66,20}},
                                                 color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn)   annotation (Line(
      points={{-32,-32},{-32,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(terminalBox.plug_sp, smpm.plug_sp)   annotation (Line(
      points={{-20,-32},{-20,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalCurr.plug_p, star.plug_p)    annotation (Line(
      points={{32,20},{40,20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalCurr.plug_n, terminalBox.plugSupply)    annotation (Line(
      points={{12,20},{-26,20},{-26,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(groundM.p, terminalBox.starpoint) annotation (Line(
      points={{-40,-34},{-38,-34},{-38,-30},{-35,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(angleS.flange, smpm.flange) annotation (Line(
      points={{-8,-32},{-8,-50},{-16,-50}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(FrPark.y, signalCurr.i) annotation (Line(
      points={{1,51},{22,51},{22,27}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(angleS.phi,FrPark. phi) annotation (Line(
      points={{-8,-11},{-8,4},{-9,4},{-9,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FrPark.Xq, firstOrder.y) annotation (Line(
      points={{-22,44.6},{-28,44.6},{-28,30},{-39,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder.u, Iq.y)   annotation (Line(
      points={{-62,30},{-79,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder1.u, Id.y)    annotation (Line(
      points={{-62,70},{-79,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder1.y,FrPark. Xd) annotation (Line(
      points={{-39,70},{-28,70},{-28,55.2},{-22,55.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Psm.flange_a, smpm.flange) annotation (Line(
      points={{0,-50},{-16,-50}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Psm.flange_b, inertiaLoad.flange_a) annotation (Line(
      points={{20,-50},{28,-50}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inertiaLoad.flange_b, Pl.flange_a) annotation (Line(
      points={{48,-50},{54,-50}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(Pl.flange_b, Tres.flange) annotation (Line(
      points={{74,-50},{80,-50}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    experiment(StopTime=16, Interval=0.0013),
    Documentation(info="<html>
<p><br/><b>Test example: Permanent magnet synchronous induction machine fed by a current source</b></p>


<p><i><span style='color:red'>NOTA: la macchina ha Lmd=Lmq=0.3(2*pi*f) come definito internamente.</p>
<i><span style='color:red'>E&apos; pertanto una macchina isotropa. la miglior maniera di controllarla, quindi, dovrebbe essere di mettere la corrente tutta sull&apos;asse q e mantenere a 0 la componente sull&apos;asse d.</p></i>


<p><br/><br/>A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill. The rms values of d- and q-current in rotor fixed coordinate system are converted to threephase currents, and fed to the machine. The result shows that the torque is influenced by the q-current, whereas the stator voltage is influenced by the d-current.</p><p><br/><br/>Default machine parameters of model <i>SM_PermanentMagnet</i> are used. </p>
</html>"),
    uses(Modelica(version="3.2")),
    __Dymola_experimentSetupOutput);
end PMM2_Wmax;
