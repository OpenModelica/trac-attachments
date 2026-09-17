package Test "PM SMA package"
  //package Propulsion
  extends Modelica.Icons.Package;
  //end Propulsion;

  package Support "Useful addtional models"
    extends Modelica.Icons.Package;
    // extends EHPowerTrain.Icons.SupportIcon;

    model MTPAiLim "MTPA logic for a generic (anisotropic) machine"
      // Non-Ascii Symbol to cause UTF-8 saving by Dymola: €
      parameter Modelica.SIunits.Current Ipm = 1.5 "Permanent magnet current";
      parameter Integer pp = 1 "Pole pairs";
      parameter Modelica.SIunits.Resistance Rs = 0.02 "Stator resistance";
      parameter Modelica.SIunits.Inductance Ld = 1 "Basic direct-axis inductance";
      parameter Modelica.SIunits.Voltage Umax = 100 "Max rms voltage per phase to the motor";
      parameter Modelica.SIunits.Current Ilim = 100 "max current (rms)";
      Modelica.SIunits.Voltage Ulim = min(uDC / sqrt(3), UmaxPk) "tensione limite (fase-picco) fa attivare il deflussaggio;";
      Modelica.SIunits.Angle gammaStar(start = 0);
      //  Real Is "corrente rapportata al valore nominale (es. rms/rms)";
      Modelica.SIunits.Voltage Vd, Vq;
      Modelica.SIunits.Current IdFF "Id FullFlux (i.e. before flux weaking evalation)";
      Modelica.SIunits.Current IqFF "Iq FullFlux (i.e. before flux weaking evalation)";
      Modelica.SIunits.Voltage VdFF "Vd FullFlux (i.e. before flux weaking evalation)";
      Modelica.SIunits.Voltage VqFF "Vq FullFlux (i.e. before flux weaking evalation)";
      Modelica.SIunits.Current IparkFF(start = 0) "Ipark amplitude FullFlux (i.e. before flux weaking evalation)";
      Modelica.SIunits.Voltage VparkFF "Vpark amplitude FullFlux (i.e. before flux weaking evalation)";
      //  Real Ipark(start = 70) "Ipark amplitude (=sqrt(Id^2+Iq^2))";
      Modelica.SIunits.Voltage Vpark "Vpark amplitude (=sqrt(Vd^2+Vq^2))";
      Modelica.SIunits.AngularVelocity w = pp * wMech;
      Modelica.SIunits.Current Id0, Iq0;
      Real weakening, limiting;
      Real overLoad;
      Modelica.Blocks.Interfaces.RealInput torqueReq annotation(
        Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
      Modelica.Blocks.Interfaces.RealInput wMech annotation(
        Placement(transformation(extent = {{-140, -80}, {-100, -40}}), iconTransformation(extent = {{-140, -80}, {-100, -40}})));
      Modelica.Blocks.Interfaces.RealOutput Id "direct-axix park current" annotation(
        Placement(transformation(extent = {{100, 50}, {120, 70}}), iconTransformation(extent = {{100, 50}, {120, 70}})));
      Modelica.Blocks.Interfaces.RealOutput Iq "quadrature-axis park current" annotation(
        Placement(transformation(extent = {{100, -70}, {120, -50}}), iconTransformation(extent = {{100, -70}, {120, -50}})));
      Modelica.Blocks.Interfaces.RealInput uDC "DC voltage" annotation(
        Placement(transformation(extent = {{-140, -20}, {-100, 20}}), iconTransformation(extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.RealOutput Ipark annotation(
        Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    protected
      parameter Modelica.SIunits.Voltage UmaxPk = sqrt(2) * Umax "nominal voltage (peak per phase)";
      parameter Real IsqLim = Ilim ^ 2 * 2;
    protected
      parameter Real Psi = Ipm * Ld "psi=Ipm*Ld";
    equation
      torqueReq = 1.5 * pp * Psi * IparkFF;
      IdFF = 0;
      IqFF = IparkFF;
      VdFF = Rs * IdFF - w * Ld * IqFF;
      VqFF = Rs * IqFF + w * (Psi + Ld * IdFF);
      VparkFF = sqrt(VdFF ^ 2 + VqFF ^ 2);
      if VparkFF < Ulim then
        weakening = 0;
        gammaStar = 0;
        Id0 = IdFF;
        Iq0 = IqFF;
        Vd = VdFF;
        Vq = VqFF;
        Vpark = VparkFF;
      else
        weakening = 1;
        Id0 = -Ipark * sin(gammaStar);
        Iq0 = Ipark * cos(gammaStar);
        Vd = Rs * Id - w * Ld * Iq;
        Vq = Rs * Iq + w * (Psi + Ld * Id);
        Vpark = sqrt(Vd ^ 2 + Vq ^ 2);
        Vpark = Ulim;
      end if;
      if Id0 ^ 2 + Iq0 ^ 2 < IsqLim then
        limiting = 0;
        Id = Id0;
        Iq = Iq0;
      else
        limiting = 1;
        if IsqLim - Id0 ^ 2 > 0 then
          overLoad = 0;
          Id = Id0;
          Iq = sqrt(IsqLim - Id0 ^ 2);
        else
          overLoad = 1;
          Id = Id0;
          Iq = Iq0;
        end if;
      end if;
      torqueReq = 1.5 * pp * Psi * Ipark * cos(gammaStar);
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 127}, extent = {{-98, -110}, {102, -146}}, textString = "%name"), Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {0, 0, 127}, extent = {{-100, 26}, {100, -26}}, textString = "MTPAiL")}),
        Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
        experiment(StartTime = 0, StopTime = 8, Tolerance = 0.0001, Interval = 0.0016),
        Documentation(info = "<html>
    <p>Performs a sychronous drive Maximum Torque Per Ampere (MTPA) control for isotropic and anisotropic machines</p>
    </html>"));
    end MTPAiLim;

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
    annotation(
      Icon(graphics = {Ellipse(extent = {{-36, 40}, {40, -36}}, lineColor = {0, 0, 0}), Line(points = {{4, 82}, {-6, 82}, {-10, 72}, {-24, 68}, {-34, 78}, {-46, 70}, {-42, 58}, {-54, 46}, {-66, 50}, {-74, 36}, {-66, 30}, {-68, 16}, {-78, 12}, {-78, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{4, -78}, {-6, -78}, {-10, -68}, {-24, -64}, {-34, -74}, {-46, -66}, {-42, -54}, {-54, -42}, {-66, -46}, {-74, -32}, {-66, -26}, {-68, -12}, {-78, -8}, {-78, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{2, -78}, {12, -78}, {16, -68}, {30, -64}, {40, -74}, {52, -66}, {48, -54}, {60, -42}, {72, -46}, {80, -32}, {72, -26}, {74, -12}, {84, -8}, {84, 2}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{2, 82}, {12, 82}, {16, 72}, {30, 68}, {40, 78}, {52, 70}, {48, 58}, {60, 46}, {72, 50}, {80, 36}, {72, 30}, {74, 16}, {84, 12}, {84, 2}}, color = {0, 0, 0}, smooth = Smooth.None)}));
  end Support;

  model iDriveiLim2
    //  extends Modelica.Icons.Example;
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.29, phi(fixed = true, start = 0), w(fixed = true, start = 0)) annotation(
      Placement(visible = true, transformation(extent = {{72, -36}, {92, -16}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(extent = {{88, 12}, {108, 32}}, rotation = 0)));
    Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm1(useDamperCage = false, Lmd = 1.91e-3, Lmq = 1.91e-3) annotation(
      Placement(visible = true, transformation(extent = {{30, -36}, {50, -16}}, rotation = 0)));
    Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox1(terminalConnection = "Y") annotation(
      Placement(visible = true, transformation(extent = {{30, -8}, {50, 12}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurr1(final m = 3) annotation(
      Placement(visible = true, transformation(origin = {40, 26}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    Modelica.Electrical.MultiPhase.Basic.Star star1(final m = 3) annotation(
      Placement(visible = true, transformation(origin = {72, 36}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant uDC(k = 200) annotation(
      Placement(visible = true, transformation(extent = {{-96, 16}, {-76, 36}}, rotation = 0)));
    Support.FromPark fromPark(p = smpm1.p) annotation(
      Placement(visible = true, transformation(extent = {{-20, 16}, {0, 36}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground groundM1 annotation(
      Placement(visible = true, transformation(origin = {14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Support.MTPAiLim myMTPA(Umax = 100, Ipm = smpm1.permanentMagnet.Ie, pp = smpm1.p, Rs = smpm1.Rs, Ld = smpm1.Lmd) annotation(
      Placement(visible = true, transformation(extent = {{-48, 16}, {-28, 36}}, rotation = 0)));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1[3](T = 0.2e-4 * {1, 1, 1}) annotation(
      Placement(visible = true, transformation(origin = {18, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Sources.Trapezoid tqRef(rising = 2, width = 2, period = 1e6, amplitude = 180, falling = 2, startTime = 1) annotation(
      Placement(visible = true, transformation(extent = {{-96, -20}, {-76, 0}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tRes(tau_nominal = -150, w_nominal(displayUnit = "rpm") = 157.07963267949) annotation(
      Placement(visible = true, transformation(extent = {{118, -36}, {98, -16}}, rotation = 0)));
    Modelica.Blocks.Continuous.Der der1 annotation(
      Placement(visible = true, transformation(origin = {-38, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.AngleSensor angleS annotation(
      Placement(visible = true, transformation(origin = {62, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(angleS.flange, smpm1.flange) annotation(
      Line(points = {{62, -32}, {62, -32}, {62, -32}, {62, -32}, {62, -26}, {50, -26}, {50, -26}}));
    connect(angleS.phi, fromPark.phi) annotation(
      Line(points = {{62, -53}, {26, -53}, {26, -53}, {-10, -53}, {-10, 14}, {-10, 14}, {-10, 14}, {-10, 14}}, color = {0, 0, 127}));
    connect(der1.u, fromPark.phi) annotation(
      Line(points = {{-26, -6}, {-10, -6}, {-10, 14}}, color = {0, 0, 127}));
    connect(myMTPA.wMech, der1.y) annotation(
      Line(points = {{-50, 20}, {-58, 20}, {-58, -6}, {-49, -6}}, color = {0, 0, 127}));
    connect(inertia.flange_b, tRes.flange) annotation(
      Line(points = {{92, -26}, {98, -26}}));
    connect(tqRef.y, myMTPA.torqueReq) annotation(
      Line(points = {{-75, -10}, {-66, -10}, {-66, 32}, {-50, 32}}, color = {0, 0, 127}));
    connect(firstOrder1.y, signalCurr1.i) annotation(
      Line(points = {{26.8, 26}, {33, 26}}, color = {0, 0, 127}));
    connect(firstOrder1.u, fromPark.y) annotation(
      Line(points = {{8.4, 26}, {1, 26}}, color = {0, 0, 127}));
    connect(myMTPA.uDC, uDC.y) annotation(
      Line(points = {{-50, 26}, {-75, 26}}, color = {0, 0, 127}));
    connect(fromPark.Xd, myMTPA.Id) annotation(
      Line(points = {{-22, 32}, {-27, 32}}, color = {0, 0, 127}));
    connect(fromPark.Xq, myMTPA.Iq) annotation(
      Line(points = {{-22, 20}, {-27, 20}}, color = {0, 0, 127}));
    connect(groundM1.p, terminalBox1.starpoint) annotation(
      Line(points = {{24, -2}, {31, -2}}, color = {0, 0, 255}));
    connect(star1.pin_n, ground.p) annotation(
      Line(points = {{82, 36}, {90, 36}, {90, 36}, {98, 36}, {98, 32}}, color = {0, 0, 255}));
    connect(star1.plug_p, signalCurr1.plug_p) annotation(
      Line(points = {{62, 36}, {40, 36}}, color = {0, 0, 255}));
    connect(signalCurr1.plug_n, terminalBox1.plugSupply) annotation(
      Line(points = {{40, 16}, {40, -2}}, color = {0, 0, 255}));
    connect(terminalBox1.plug_sp, smpm1.plug_sp) annotation(
      Line(points = {{46, -4}, {46, -16}}, color = {0, 0, 255}));
    connect(terminalBox1.plug_sn, smpm1.plug_sn) annotation(
      Line(points = {{34, -4}, {34, -16}}, color = {0, 0, 255}));
    connect(inertia.flange_a, smpm1.flange) annotation(
      Line(points = {{72, -26}, {50, -26}}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -60}, {120, 60}}), graphics = {Rectangle(origin = {2, -120}, lineColor = {238, 46, 47}, pattern = LinePattern.Dash, extent = {{2, 166}, {52, 130}}), Text(origin = {2, -120}, lineColor = {238, 46, 47}, pattern = LinePattern.Dash, extent = {{50, 172}, {6, 168}}, textString = "simulates inverter")}),
      __Dymola_experimentSetupOutput,
      Documentation(info = "<html><head></head><body><p>Az. brushless con controllo automatico per macchine ANISOTROPE&nbsp;</p><p>Il transitorio ha una prima fase a pieno flusso, poi interviene duna limiazione della tensione per effetto della uDC. Se portiamo la uDC a 400 V interviene la limitazione della tensione per limite di macchina.</p><p>Con Udc=200V non si può soddisfare tutta la richiesta di coppia per raggiunto limite di corrente</p><p>Con Udc=400V e limite di tensione dovuto alla macchina ci si avvicina di più alla possibilità di erogare tutta la coppia richiesta, ma si sbatte comunque nel limite di corrente.</p><ul>
    </ul>
    </body></html>"),
      Icon(coordinateSystem(extent = {{-100, -60}, {120, 60}}, preserveAspectRatio = false)),
      experiment(StartTime = 0, StopTime = 8, Tolerance = 0.0001, Interval = 0.001),
      __OpenModelica_commandLineOptions = "");
  end iDriveiLim2;
  annotation(
    uses(Modelica(version = "3.2.2")),
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1)),
    Documentation(info = "<html>
<p>Library containing models of components, subsystems and full vehicle examples for simulation of electric and Hybrid vehicular power trains.</p>
<p>A general description of the library composition and on how to use it effectively is in the compaion paper:</p>
<p>M. Ceraolo &QUOT;Modelica Electric and hybrid power trains library&QUOT; submitted for publication at the 11th International Modelica Conference, 2015, September 21-23, Palais des congr&egrave;s de Versailles, 23-23 September, France</p>
</html>"));
end Test;
