within ;
model FromPark "Semplice PMM con modello funzionale inverter"
  parameter Integer p "Number or pole pairs";
  Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor
    fromSpacePhasor   annotation (Placement(transformation(extent={{60,0},{80,
            20}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator   annotation (Placement(transformation(extent={{0,0},{
            20,20}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_1   annotation (Placement(transformation(extent={{-40,0},
            {-20,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[3]   annotation (Placement(transformation(extent={{96,0},{
            116,20}}), iconTransformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput Xd   annotation (Placement(transformation(extent={{-128,32},
            {-88,72}}), iconTransformation(extent={{-140,32},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput Xq   annotation (Placement(transformation(extent={{-128,
            -74},{-88,-34}}), iconTransformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput phi annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={10,-110}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={10,-120})));
  Modelica.Blocks.Math.Gain gain(k=-p) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-50})));
  Modelica.Blocks.Sources.Constant const annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-30})));
equation

  connect(multiplex2_1.y, rotator.u) annotation (Line(
      points={{-19,10},{-2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fromSpacePhasor.u, rotator.y) annotation (Line(
      points={{58,10},{21,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fromSpacePhasor.y, y) annotation (Line(
      points={{81,10},{106,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex2_1.u1[1], Xd) annotation (Line(
      points={{-42,16},{-60,16},{-60,52},{-108,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex2_1.u2[1],Xq)  annotation (Line(
      points={{-42,4},{-60,4},{-60,-54},{-108,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(rotator.angle, gain.y) annotation (Line(
      points={{10,-2},{10,-39}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.u, phi) annotation (Line(
      points={{10,-62},{10,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fromSpacePhasor.zero, const.y) annotation (Line(
      points={{58,2},{50,2},{50,-19}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics),
    experiment(StopTime=5, Interval=0.001),
    Documentation(info="<html>
<p><br/><b>Test example: Permanent magnet synchronous induction machine fed by a current source</b></p>


<p><i><span style='color:red'>NOTA: la macchina ha Lmd=Lmq=0.3(2*pi*f) come definito internamente.</p>
<i><span style='color:red'>E&apos; pertanto una macchina isotropa. la miglior maniera di controllarla, quindi, dovrebbe essere di mettere la corrente tutta sull&apos;asse q e mantenere a 0 la componente sull&apos;asse d.</p></i>


<p><br/><br/>A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill. The rms values of d- and q-current in rotor fixed coordinate system are converted to threephase currents, and fed to the machine. The result shows that the torque is influenced by the q-current, whereas the stator voltage is influenced by the d-current.</p><p><br/><br/>Default machine parameters of model <i>SM_PermanentMagnet</i> are used. </p>
</html>"),
    uses(Modelica(version="3.2")),
    __Dymola_experimentSetupOutput,
    Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
          Text(
          extent={{-96,32},{96,-22}},
          lineColor={0,0,255},
          textString="P=>"),
        Text(
          extent={{-108,148},{102,110}},
          lineColor={0,0,255},
          textString="%name")}));
end FromPark;
