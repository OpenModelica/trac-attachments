model ES1a "Versione a.a. 15-16"
  //La versione senza st contiene miglioramenti vari da usare dall'a.a. 16-17.
  // Euro symbol to force UTF-8 writing: €
  import Modelica.Constants.pi;
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox annotation(
    Placement(visible = true, transformation(extent = {{-18, 12}, {2, 32}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc annotation(
    Placement(visible = true, transformation(extent = {{-18, -18}, {2, 2}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-112, -32}, {-92, -12}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {-102, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
    Placement(visible = true, transformation(origin = {78, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant tauLoad(k = -150) annotation(
    Placement(visible = true, transformation(origin = {109, -9}, extent = {{-9, -9}, {9, 9}}, rotation = 180)));
  stAsmaPkg1819.Support.AronSensor pUp annotation(
    Placement(visible = true, transformation(extent = {{-60, 18}, {-42, 36}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage annotation(
    Placement(visible = true, transformation(origin = {-78, 27}, extent = {{-10, -9}, {10, 9}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
    Placement(visible = true, transformation(origin = {61, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 270)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor iUp annotation(
    Placement(visible = true, transformation(origin = {-30, 28}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.5) annotation(
    Placement(visible = true, transformation(extent = {{34, -18}, {54, 2}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant tauRef(k = 230) annotation(
    Placement(visible = true, transformation(origin = {-14, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  stAsmaPkg1819.Support.GenSines actuator annotation(
    Placement(visible = true, transformation(extent = {{-62, -52}, {-84, -32}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pMecc annotation(
    Placement(transformation(extent = {{10, -18}, {30, 2}})));
  stAsmaPkg1819.Support.ControlLogic logic(Rs = aimc.Rs, uBase = 100 * sqrt(3), iMax = 150, wmMax = 314.16, pp = aimc.p, Rr = aimc.Rr, Lstray = aimc.Lrsigma + aimc.Lssigma) annotation(
    Placement(transformation(extent = {{-32, -52}, {-52, -32}})));
equation
  connect(tauLoad.y, torque.tau) annotation(
    Line(points = {{99.1, -9}, {98, -9}, {98, -8}, {90, -8}}, color = {0, 0, 127}));
  connect(inertia.flange_b, torque.flange) annotation(
    Line(points = {{54, -8}, {62, -8}, {68, -8}}));
  connect(speedSensor.flange, torque.flange) annotation(
    Line(points = {{61, -20}, {61, -14}, {60, -14}, {60, -8}, {68, -8}}));
  connect(iUp.plug_n, terminalBox.plugSupply) annotation(
    Line(points = {{-22, 28}, {-22, 28}, {-8, 28}, {-8, 18}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation(
    Line(points = {{-2, 16}, {-2, 16}, {-2, 0}, {-2, 2}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation(
    Line(points = {{-14, 16}, {-14, 2}}, color = {0, 0, 255}));
  connect(ground.p, star.pin_n) annotation(
    Line(points = {{-102, -12}, {-102, 2}}, color = {0, 0, 255}));
  connect(iUp.plug_p, pUp.nc) annotation(
    Line(points = {{-38, 28}, {-42, 28}, {-42, 27}}, color = {0, 0, 255}));
  connect(actuator.U, signalVoltage.v) annotation(
    Line(points = {{-85.1, -42}, {-88, -42}, {-88, -14}, {-88, 14}, {-78, 14}, {-78, 20.7}}, color = {0, 0, 127}));
  connect(pUp.pc, signalVoltage.plug_p) annotation(
    Line(points = {{-60, 27}, {-68, 27}}, color = {0, 0, 255}));
  connect(signalVoltage.plug_n, star.plug_p) annotation(
    Line(points = {{-88, 27}, {-102, 27}, {-102, 22}}, color = {0, 0, 255}));
  connect(inertia.flange_a, pMecc.flange_b) annotation(
    Line(points = {{34, -8}, {32, -8}, {30, -8}}, color = {0, 0, 0}));
  connect(aimc.flange, pMecc.flange_a) annotation(
    Line(points = {{2, -8}, {6, -8}, {10, -8}}, color = {0, 0, 0}));
  connect(logic.Westar, actuator.Westar) annotation(
    Line(points = {{-53, -36}, {-56, -36}, {-56, -36.1}, {-60.57, -36.1}}, color = {0, 0, 127}));
  connect(logic.Ustar, actuator.Ustar) annotation(
    Line(points = {{-53, -48}, {-56, -48}, {-56, -47.9}, {-60.57, -47.9}}, color = {0, 0, 127}));
  connect(logic.Tstar, tauRef.y) annotation(
    Line(points = {{-30.7, -42.1}, {-28.35, -42.1}, {-28.35, -42}, {-25, -42}}, color = {0, 0, 127}));
  connect(logic.Wm, speedSensor.w) annotation(
    Line(points = {{-42.1, -53.3}, {-42.1, -60}, {61, -60}, {61, -34.7}}, color = {0, 0, 127}));
  annotation(
    experimentSetupOutput,
    Documentation(info = "<html>
<p>This system simulates variable-frequency start-up of an asyncronous motor.</p>
<p>Two different sources for the machine re compared.</p>
<p>The motor supply is constituted by a three-phase system of quasi-sinusoidal shapes, created according to the following equations:</p>
<p>WEl=WMecc*PolePairs+DeltaWEl</p>
<p>U=U0+(Un-U0)*WEl/WNom</p>
<p>where:</p>
<p><ul>
<li>U0, Un U, are initial, nominal actual voltage amplitudes</li>
<li>WMecc, WEl, are machine, mechanical and supply, electrical angular speeds</li>
<li>PolePairs are the machine pole pairs</li>
<li>delta WEl is a fixed parameter during the simulation, except when the final speed is reached</li>
</ul></p>
<p>When the final speed is reached, the feeding frequenccy and voltage are kept constant (no flux weaking simulated)</p>
</html>"),
    experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {95, 95, 95}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(extent = {{-120, -80}, {120, 60}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(extent = {{20, 44}, {98, 30}}, lineColor = {238, 46, 47}, textString = "richiede il caricamento di
stAsmaPkg")}),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 0.0001, Interval = 0.0006));
end ES1a;
