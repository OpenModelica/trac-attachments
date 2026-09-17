package TestUpdate "PM SMA package"
  //package Propulsion
  extends Modelica.Icons.Package;
  //end Propulsion;

  model FromPark "Semplice PMM con modello funzionale inverter"
    parameter Integer p "Number or pole pairs";
    Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor annotation(
      Placement(transformation(extent = {{60, 0}, {80, 20}})));
    Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator annotation(
      Placement(transformation(extent = {{0, 6}, {20, 26}})));
    Modelica.Blocks.Routing.Multiplex2 multiplex2_1 annotation(
      Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y[3] annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Interfaces.RealInput Xd annotation(
      Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
    Modelica.Blocks.Interfaces.RealInput Xq annotation(
      Placement(transformation(extent = {{-140, -80}, {-100, -40}}), iconTransformation(extent = {{-140, -80}, {-100, -40}})));
    Modelica.Blocks.Interfaces.RealInput phi annotation(
      Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120})));
    Modelica.Blocks.Math.Gain gain(k = -p) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {10, -50})));
    Modelica.Blocks.Sources.Constant const annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {50, -30})));
  equation
    connect(multiplex2_1.y, rotator.u) annotation(
      Line(points = {{-19, 10}, {-10, 10}, {-10, 16}, {-2, 16}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fromSpacePhasor.u, rotator.y) annotation(
      Line(points = {{58, 10}, {40, 10}, {40, 16}, {21, 16}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fromSpacePhasor.y, y) annotation(
      Line(points = {{81, 10}, {94, 10}, {94, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(multiplex2_1.u1[1], Xd) annotation(
      Line(points = {{-42, 16}, {-60, 16}, {-60, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(multiplex2_1.u2[1], Xq) annotation(
      Line(points = {{-42, 4}, {-60, 4}, {-60, -60}, {-120, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(rotator.angle, gain.y) annotation(
      Line(points = {{10, 4}, {10, -39}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.u, phi) annotation(
      Line(points = {{10, -62}, {10, -120}, {0, -120}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(fromSpacePhasor.zero, const.y) annotation(
      Line(points = {{58, 2}, {50, 2}, {50, -19}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})),
      experiment(StopTime = 5, Interval = 0.001),
      Documentation(info = "<html>
  <p>Converts variables form Park into phase quantities</p>
  </html>"),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {0, 0, 127}, extent = {{-96, 28}, {96, -26}}, textString = "P=>"), Text(lineColor = {0, 0, 255}, extent = {{-108, 150}, {102, 110}}, textString = "%name")}));
  end FromPark;

  model FullFlux
    //  extends Modelica.Icons.Example;
    Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(useDamperCage = false) annotation(
      Placement(visible = true, transformation(extent = {{-6, -50}, {14, -30}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurr(final m = 3) annotation(
      Placement(visible = true, transformation(origin = {28, 6}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Star star(final m = 3) annotation(
      Placement(visible = true, transformation(origin = {56, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {82, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.Analog.Basic.Ground groundM annotation(
      Placement(visible = true, transformation(origin = {-20, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleS annotation(
      Placement(visible = true, transformation(origin = {24, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 0.29, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
      Placement(visible = true, transformation(extent = {{32, -50}, {52, -30}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tRes1(w_nominal(displayUnit = "rpm") = 157.07963267949, tau_nominal = -150) annotation(
      Placement(visible = true, transformation(extent = {{84, -50}, {64, -30}}, rotation = 0)));
    FromPark fromPark(p = smpm.p) annotation(
      Placement(visible = true, transformation(extent = {{-18, 10}, {2, 30}}, rotation = 0)));
    Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection = "Y") annotation(
      Placement(visible = true, transformation(extent = {{-6, -22}, {14, -2}}, rotation = 0)));
    Modelica.Blocks.Math.Gain toIq(k = 0.659) annotation(
      Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 90, origin = {-40, -4})));
    Modelica.Blocks.Sources.Ramp tqRef(duration = 2, startTime = 1, offset = 20, height = 120) annotation(
      Placement(transformation(extent = {{-76, -36}, {-56, -16}})));
    Modelica.Blocks.Sources.Ramp IdRef(duration = 1, height = 0, startTime = 2) annotation(
      Placement(transformation(extent = {{-68, 12}, {-48, 32}})));
  equation
    connect(tRes1.flange, inertia1.flange_b) annotation(
      Line(points = {{64, -40}, {52, -40}}));
    connect(terminalBox.plug_sp, smpm.plug_sp) annotation(
      Line(points = {{10, -18}, {12, -18}, {12, -24}, {10, -24}, {10, -30}}, color = {0, 0, 255}));
    connect(terminalBox.plug_sn, smpm.plug_sn) annotation(
      Line(points = {{-2, -18}, {-2, -30}}, color = {0, 0, 255}));
    connect(signalCurr.plug_n, terminalBox.plugSupply) annotation(
      Line(points = {{18, 6}, {4, 6}, {4, -16}}, color = {0, 0, 255}));
    connect(groundM.p, terminalBox.starpoint) annotation(
      Line(points = {{-10, -22}, {-7.5, -22}, {-7.5, -16}, {-5, -16}}, color = {0, 0, 255}));
    connect(inertia1.flange_a, smpm.flange) annotation(
      Line(points = {{32, -40}, {14, -40}}));
    connect(angleS.flange, smpm.flange) annotation(
      Line(points = {{24, -36}, {24, -40}, {14, -40}}));
    connect(fromPark.y, signalCurr.i) annotation(
      Line(points = {{3, 20}, {28, 20}, {28, 13}}, color = {0, 0, 127}));
    connect(signalCurr.plug_p, star.plug_p) annotation(
      Line(points = {{38, 6}, {46, 6}}, color = {0, 0, 255}));
    connect(star.pin_n, ground1.p) annotation(
      Line(points = {{66, 6}, {72, 6}}, color = {0, 0, 255}));
    connect(angleS.phi, fromPark.phi) annotation(
      Line(points = {{24, -15}, {24, -8}, {-8, -8}, {-8, 8}}, color = {0, 0, 127}));
    connect(toIq.y, fromPark.Xq) annotation(
      Line(points = {{-40, 4.8}, {-40, 14}, {-20, 14}}, color = {0, 0, 127}));
    connect(tqRef.y, toIq.u) annotation(
      Line(points = {{-55, -26}, {-40, -26}, {-40, -13.6}}, color = {0, 0, 127}));
    connect(IdRef.y, fromPark.Xd) annotation(
      Line(points = {{-47, 22}, {-36, 22}, {-36, 26}, {-20, 26}}, color = {0, 0, 127}));
    annotation(
      experiment(StopTime = 5, Interval = 0.001),
      __Dymola_experimentSetupOutput,
      Documentation(info = "<html><head></head><body><p>Az. brushless con controllo manuale. Propedeutico a quelli con l'MTPA che fanno tutto automaticamente&nbsp;</p><p>Prima si simula con Id=0, poi si mette un po' di Id negativa per portare la tensione di picco entro i 141V, senza superare il limite di corrente di 141 A di picco.</p><p>Torque constant=0.659 Nm/A</p><p>Ok OM 1.11</p><ul>
  </ul>
  </body></html>"),
      Icon(coordinateSystem(extent = {{-100, -80}, {100, 60}})),
      Diagram(coordinateSystem(extent = {{-80, -60}, {100, 40}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(origin = {35, 39}, extent = {{-23, 3}, {45, -19}}, textString = "Aggiungere deflussaggio per tenere la tensione nei limiti\nsenza superare i limiti di corrent. Es. 50 A", horizontalAlignment = TextAlignment.Left)}),
      __OpenModelica_commandLineOptions = "");
  end FullFlux;
  annotation(
    uses(Modelica(version = "3.2.2")),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1)),
    Documentation(info = "<html>
<p>Library containing models of components, subsystems and full vehicle examples for simulation of electric and Hybrid vehicular power trains.</p>
<p>A general description of the library composition and on how to use it effectively is in the compaion paper:</p>
<p>M. Ceraolo &QUOT;Modelica Electric and hybrid power trains library&QUOT; submitted for publication at the 11th International Modelica Conference, 2015, September 21-23, Palais des congr&egrave;s de Versailles, 23-23 September, France</p>
</html>"));
end TestUpdate;
