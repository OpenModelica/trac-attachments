model SMAChopper
  // parameter Real freq=1000;
  parameter Modelica.SIunits.Frequency freq=1000;
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V=150) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,12})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,58})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-14})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=0.66)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={14,50})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
      tau_constant=-80) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-10})));
  Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-48,14})));
  Modelica.Blocks.Sources.SawTooth sawTooth(period=1/freq)
                                                          annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,50})));
  parameter Real Fact=2;
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet
    dcpm(La=0.0015/Fact)
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  Modelica.Blocks.Math.Mean mUmach(f=freq) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-48,-14})));
equation
  connect(idealDiode.n, idealGTOThyristor.n) annotation (Line(
      points={{-20,-4},{-20,22},{-20,48},{-20,48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealGTOThyristor.p, V1.p) annotation (Line(
      points={{-20,68},{-80,68},{-80,22}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(V1.n, idealDiode.p) annotation (Line(
      points={{-80,2},{-80,-34},{-20,-34},{-20,-24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lessThreshold.y, idealGTOThyristor.fire) annotation (Line(
      points={{3,50},{4,50},{4,51},{-9,51}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ground.p, V1.n) annotation (Line(
      points={{-80,-46},{-80,2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(potentialSensor.p, idealGTOThyristor.n) annotation (Line(
      points={{-48,22},{-48,26},{-20,26},{-20,48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lessThreshold.u, sawTooth.y) annotation (Line(
      points={{26,50},{39,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dcpm.flange, constantTorque.flange) annotation (Line(
      points={{30,-10},{39,-10},{39,-10},{48,-10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(dcpm.pin_ap, idealGTOThyristor.n) annotation (Line(
      points={{26,0},{26,26},{-20,26},{-20,48}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dcpm.pin_an, idealDiode.p) annotation (Line(
      points={{14,0},{0,0},{0,-24},{-20,-24}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(potentialSensor.phi, mUmach.u)
    annotation (Line(points={{-48,5.2},{-48,-2}}, color={0,0,127}));
  annotation (
    experiment(StopTime=0.2),
    experimentSetupOutput,
    Commands(file="FA_DCM.mos" "FA_DCM"),
    Documentation(info="<html>
<p>Il modello mostra un aviamento contro coppia resistente costante con la macchina con eccitazione a magnete permanente.</p>
<p>I parametri della macchina sono quelli standard di MSL. </p>
<p>Si osserva che l&apos;andamento della coppia &egrave; molto differente da quello risultante dalle analisi algebriche essenzialmente per il transitorio di carica dell&apos;inuttanza di armatura. </p>
<p>Mostrare come riducendo artificialmente l&apos;induttanza di armatura l&apos;andamento diviene pi&ugrave; possimo a quello ottenibile da analisi quasi statiche. Al solito si pu&ograve; usare Fact.</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-80},{100,80}}), graphics={Text(
          extent={{-2,-44},{70,-62}},
          lineColor={28,108,200},
          textString="Aggiungere indice progressivo 
per ridurre coppia e corrente di spunto")}),
    Icon(coordinateSystem(extent={{-100,-80},{100,80}})),
    uses(Modelica(version="3.2.2")));
end SMAChopper;
