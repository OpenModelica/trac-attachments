package Test1
  
  model ScTT
    extends Modelica.Icons.Example;
    import PI = Modelica.Constants.pi;
    inner PowerGrids.Electrical.System systemPowerGrids(fNom = 50) annotation(
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.BusFault bus(R = 0.05, SNom(displayUnit = "V.A") = 500000000, UNom(displayUnit = "V") = 21000, UStart = 1.050 * 380e3, X = 0, portVariablesPhases = true, portVariablesPu = true, startTime = 0.1, stopTime = 990.2) annotation(
      Placement(visible = true, transformation(origin = {14, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression ufPu(y = 1) annotation(
      Placement(visible = true, transformation(extent = {{-52, 16}, {-32, 36}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression pmPu annotation(
      Placement(visible = true, transformation(extent = {{-52, 36}, {-32, 56}}, rotation = 0)));
    PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 1000, PStart(displayUnit = "W") = -4.75e+08, QStart = -1.56e+08, SNom(displayUnit = "V.A") = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom(displayUnit = "V") = 21000, UPhaseStart = 0.161146, UStart = 21e3 * 0.992, neglectTransformerTerms = false, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation(
      Placement(visible = true, transformation(origin = {2, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.050 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true) annotation(
      Placement(visible = true, transformation(origin = {86, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161146, UPhaseStartB = 0, UStartA = 0.992 * 21e3, UStartB = 1.050 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21) annotation(
      Placement(visible = true, transformation(origin = {34, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Loads.LoadImpedancePQ GRIDL(PRef = 4.75e+08, QRef = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true) annotation(
      Placement(visible = true, transformation(origin = {64, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.Bus bus1(SNom(displayUnit = "V.A") = 500000000, UNom(displayUnit = "V") = 380000, portVariablesPhases = true, portVariablesPu = true) annotation(
      Placement(visible = true, transformation(origin = {58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(pmPu.y, GEN.PmPu) annotation(
      Line(points = {{-31, 46}, {-22, 46}, {-22, 42}, {-8, 42}}, color = {0, 0, 127}));
    connect(GEN.ufPuIn, ufPu.y) annotation(
      Line(points = {{-8.2, 34}, {-22.2, 34}, {-22.2, 26}, {-31, 26}}, color = {0, 0, 127}));
    connect(TGEN.terminalB, bus1.terminal) annotation(
      Line(points = {{44, -24}, {58, -24}}));
    connect(bus1.terminal, GRID.terminal) annotation(
      Line(points = {{58, -24}, {86, -24}}));
    connect(GRIDL.terminal, GRID.terminal) annotation(
      Line(points = {{64, -38}, {64, -24}, {86, -24}}));
    connect(TGEN.terminalA, bus.terminal) annotation(
      Line(points = {{24, -24}, {14, -24}}));
  connect(GEN.terminal, bus.terminal) annotation(
      Line(points = {{2, 38}, {2, -24}, {14, -24}}));
    annotation(
      experiment(StopTime = 0.1, Interval = 0.001, Tolerance = 1e-06, StartTime = 0),
      Documentation(info = "<html><head></head><body><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Modello derivato da PowerGrids.Electrical.Machines.Test.SynchronousMachine4WindingsNoLoad per valutare l'andamento nel tempo di correnti di corto circuito trifase franco a partire da macchina a vuoto.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Questo modello non converge se si sceglie di inserire anche i TransformerTerms nel modello della macchina.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Per valutare il comportamento della macchina con i TransformerTerms si può usare il modello contenente \"TT\" nel nome del mesedesimo package do qiesto modello.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Per ottenere una velocità socostante qui si è scelta una enorme costante d'inerzia H=1000s.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></p>
      </body></html>"),
      Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}})));
  end ScTT;

  model ScTT1
    extends Modelica.Icons.Example;
    import PI = Modelica.Constants.pi;
    inner PowerGrids.Electrical.System systemPowerGrids(fNom = 50) annotation (
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.BusFault bus(R = 0.05, SNom (displayUnit = "V.A") = 500000000, UNom (displayUnit = "V") = 21000, UStart = 1.050 * 380e3, X = 0, portVariablesPhases = true, portVariablesPu = true, startTime = 0.1, stopTime = 990.2) annotation (
      Placement(visible = true, transformation(origin = {14, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression ufPu(y = 1) annotation (
      Placement(visible = true, transformation(extent = {{-52, 16}, {-32, 36}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression pmPu annotation (
      Placement(visible = true, transformation(extent = {{-52, 36}, {-32, 56}}, rotation = 0)));
    PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 1000, PStart(displayUnit = "W") = -4.75e+08, QStart = -1.56e+08, SNom(displayUnit = "V.A") = 5e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom(displayUnit = "V") = 21000, UPhaseStart = 0.161146, UStart = 21e3 * 0.992, neglectTransformerTerms = false, portVariablesPhases = true, raPu = 0, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation (
      Placement(visible = true, transformation(origin = {2, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.050 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {86, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Branches.TransformerFixedRatio TGEN(PStartA = 4.75e+08, PStartB = -4.75e+08, QStartA = 1.56e+08, QStartB = -7.6e+07, R = 0.15e-2 * 419 ^ 2 / 500, SNom = 5e+08, UNomA = 21000, UNomB = 419000, UPhaseStartA = 0.161146, UPhaseStartB = 0, UStartA = 0.992 * 21e3, UStartB = 1.050 * 380e3, X = 16e-2 * 419 ^ 2 / 500, portVariablesPhases = true, portVariablesPu = true, rFixed = 419 / 21) annotation (
      Placement(visible = true, transformation(origin = {34, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Loads.LoadImpedancePQ GRIDL(PRef = 4.75e+08, QRef = 7.6e+07, SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {64, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PowerGrids.Electrical.Buses.Bus bus1(SNom (displayUnit = "V.A") = 500000000, UNom (displayUnit = "V") = 380000, portVariablesPhases = true, portVariablesPu = true) annotation (
      Placement(visible = true, transformation(origin = {58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Support.GetCurrent iMach annotation (
      Placement(visible = true, transformation(origin = {2, -2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    Support.FromPark fromPark(p = 1) annotation (
      Placement(visible = true, transformation(extent = {{-28, -14}, {-48, 6}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression theta(y = 2 * PI * 50 * time) annotation (
      Placement(visible = true, transformation(origin = {-72, -28}, extent = {{-16, -10}, {16, 10}}, rotation = 0)));
  equation
    connect(pmPu.y, GEN.PmPu) annotation (
      Line(points = {{-31, 46}, {-22, 46}, {-22, 42}, {-8, 42}}, color = {0, 0, 127}));
    connect(GEN.ufPuIn, ufPu.y) annotation (
      Line(points = {{-8.2, 34}, {-22.2, 34}, {-22.2, 26}, {-31, 26}}, color = {0, 0, 127}));
  connect(TGEN.terminalB, bus1.terminal) annotation(
      Line(points = {{44, -24}, {58, -24}}));
  connect(bus1.terminal, GRID.terminal) annotation(
      Line(points = {{58, -24}, {86, -24}}));
    connect(GRIDL.terminal, GRID.terminal) annotation (
      Line(points = {{64, -38}, {64, -24}, {86, -24}}));
    connect(TGEN.terminalA, bus.terminal) annotation (
      Line(points = {{24, -24}, {14, -24}}));
    connect(GEN.terminal, iMach.term_p) annotation (
      Line(points={{2,38},{2,24},{2,8.1},{1.9,8.1}}));
    connect(iMach.term_n, bus.terminal) annotation (
      Line(points={{1.9,-11.9},{1.9,-24},{14,-24}}));
    connect(fromPark.Xd, iMach.i_d) annotation (
      Line(points={{-26,2},{-9,2}},      color = {0, 0, 127}));
    connect(iMach.i_q, fromPark.Xq) annotation (
      Line(points={{-9,-6},{-16,-6},{-16,-10},{-26,-10}},          color = {0, 0, 127}));
    connect(fromPark.phi, theta.y) annotation (
      Line(points={{-38,-16},{-38,-28},{-54.4,-28}},      color = {0, 0, 127}));
    annotation (
      experiment(
        StopTime=0.1,
        Interval=0.001,
        Tolerance=1e-06, StartTime = 0),
      Documentation(info = "<html><head></head><body><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Modello derivato da PowerGrids.Electrical.Machines.Test.SynchronousMachine4WindingsNoLoad per valutare l'andamento nel tempo di correnti di corto circuito trifase franco a partire da macchina a vuoto.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Questo modello non converge se si sceglie di inserire anche i TransformerTerms nel modello della macchina.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Per valutare il comportamento della macchina con i TransformerTerms si può usare il modello contenente \"TT\" nel nome del mesedesimo package do qiesto modello.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\">Per ottenere una velocità socostante qui si è scelta una enorme costante d'inerzia H=1000s.</p><p style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><br></p>
    </body></html>"),
      Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}})));
  end ScTT1;

  package Support
    extends Modelica.Icons.Package;

    model FromPark "Semplice PMM con modello funzionale inverter"
      parameter Integer p "Number or pole pairs";
      Modelica.Electrical.Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor annotation (
        Placement(transformation(extent = {{60, 0}, {80, 20}})));
      Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator annotation (
        Placement(transformation(extent = {{0, 6}, {20, 26}})));
      Modelica.Blocks.Routing.Multiplex2 multiplex2_1 annotation (
        Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y[3] annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealInput Xd annotation (
        Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
      Modelica.Blocks.Interfaces.RealInput Xq annotation (
        Placement(transformation(extent = {{-140, -80}, {-100, -40}}), iconTransformation(extent = {{-140, -80}, {-100, -40}})));
      Modelica.Blocks.Interfaces.RealInput phi annotation (
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120})));
      Modelica.Blocks.Math.Gain gain(k = -p) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {10, -50})));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {50, -30})));
    equation
      connect(multiplex2_1.y, rotator.u) annotation (
        Line(points = {{-19, 10}, {-10, 10}, {-10, 16}, {-2, 16}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(fromSpacePhasor.u, rotator.y) annotation (
        Line(points = {{58, 10}, {40, 10}, {40, 16}, {21, 16}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(fromSpacePhasor.y, y) annotation (
        Line(points = {{81, 10}, {94, 10}, {94, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(multiplex2_1.u1[1], Xd) annotation (
        Line(points = {{-42, 16}, {-60, 16}, {-60, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(multiplex2_1.u2[1], Xq) annotation (
        Line(points = {{-42, 4}, {-60, 4}, {-60, -60}, {-120, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(rotator.angle, gain.y) annotation (
        Line(points = {{10, 4}, {10, -39}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.u, phi) annotation (
        Line(points = {{10, -62}, {10, -120}, {0, -120}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(fromSpacePhasor.zero, const.y) annotation (
        Line(points = {{58, 2}, {50, 2}, {50, -19}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})),
        experiment(StopTime = 5, Interval = 0.001),
        Documentation(info = "<html>
<p>Converts variables form Park into phase quantities</p>
</html>"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {0, 0, 127}, extent = {{-96, 28}, {96, -26}}, textString = "P=>"), Text(lineColor = {0, 0, 255}, extent = {{-108, 150}, {102, 110}}, textString = "%name")}));
    end FromPark;

    model GetCurrent
      Modelica.Blocks.Interfaces.RealOutput i_d annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-40, 110}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-40, 110})));
      Modelica.Blocks.Interfaces.RealOutput i_q annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 110}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {40, 110})));
      PowerGrids.Interfaces.TerminalAC term_p annotation (
        Placement(transformation(extent = {{-110, -8}, {-92, 10}}), iconTransformation(extent = {{-110, -8}, {-92, 10}})));
      PowerGrids.Interfaces.TerminalAC term_n annotation (
        Placement(transformation(extent = {{90, -8}, {108, 10}}), iconTransformation(extent = {{90, -8}, {108, 10}})));
    equation
      i_d = -term_p.i.im;
      i_q = term_p.i.re;
      connect(term_p, term_n) annotation (
        Line(points = {{-101, 1}, {-0.5, 1}, {-0.5, 1}, {99, 1}}, color = {0, 0, 0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Ellipse(extent = {{-60, 16}, {60, -16}}, lineColor = {28, 108, 200}), Line(points = {{-40, 100}, {-20, 14}}, color = {28, 108, 200}), Line(points = {{42, 100}, {20, 16}}, color = {28, 108, 200}), Line(points = {{-100, 0}, {92, 0}}, color = {28, 108, 200}), Text(extent = {{-98, -36}, {100, -54}}, lineColor = {0, 0, 255}, textString = "%name")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Ellipse(lineColor = {28, 108, 200}, extent = {{-60, 16}, {60, -16}}, endAngle = 360), Line(points = {{-40, 100}, {-20, 14}}, color = {28, 108, 200}), Line(points = {{42, 100}, {20, 16}}, color = {28, 108, 200}), Line(points = {{-100, 0}, {92, 0}}), Text(lineColor = {0, 0, 255}, extent = {{-98, -36}, {100, -54}}, textString = "%name")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end GetCurrent;
    annotation (
      Icon(graphics={  Ellipse(extent = {{-38, 40}, {38, -36}}, lineColor = {0, 0, 0}), Line(points = {{2, 82}, {-8, 82}, {-12, 72}, {-26, 68}, {-36, 78}, {-48, 70}, {-44, 58}, {-56, 46}, {-68, 50}, {-76, 36}, {-68, 30}, {-70, 16}, {-80, 12}, {-80, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{2, -78}, {-8, -78}, {-12, -68}, {-26, -64}, {-36, -74}, {-48, -66}, {-44, -54}, {-56, -42}, {-68, -46}, {-76, -32}, {-68, -26}, {-70, -12}, {-80, -8}, {-80, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, -78}, {10, -78}, {14, -68}, {28, -64}, {38, -74}, {50, -66}, {46, -54}, {58, -42}, {70, -46}, {78, -32}, {70, -26}, {72, -12}, {82, -8}, {82, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 82}, {10, 82}, {14, 72}, {28, 68}, {38, 78}, {50, 70}, {46, 58}, {58, 46}, {70, 50}, {78, 36}, {70, 30}, {72, 16}, {82, 12}, {82, 2}}, color = {0, 0, 0}, smooth = Smooth.None)}));
  end Support;
equation

  annotation (
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(PowerGrids(version = "1.0.0"), Modelica(version = "3.2.3")));
end Test1;
