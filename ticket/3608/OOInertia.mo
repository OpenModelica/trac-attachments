within ;
package OOInertia
  "Package without if inside the battery, and without explicit loss"
  //La ragione di questo package sta nel fatto che il conteggio dell'efficienza attraverso l'if crea difficoltà che appiono insormontabili
  //all'algoritmo di ottimizzazione. Con questa modifica si pensa di superare l'ostacolo.
  //Rispetto a bat2 qui non si calcolano le perdite durante la simulazione ma esse vencono implicitamente
  //conteggiate con il fatto che a fine simulazione si impne che esa meno energia di quanta ne è entrata.
  //Per semplicità il loe iniziale è posto pari a 0

  package Components
    model AddPcLosses
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u "input fuel power" annotation(Placement(visible = true, transformation(extent = {{-138, -20}, {-98, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      //  Modelica.SIunits.Power losses annotation(Placement(visible = true, transformation(origin = {120, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{48, -10}, {68, 10}})));
      Modelica.Blocks.Tables.CombiTable1D consTable(table = [0, 5000; 9990, 19500; 10000, 19520; 40000, 75000], smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments) annotation(Placement(transformation(extent = {{-52, -30}, {-32, -10}})));
    equation
      connect(y, add.y) annotation(Line(points = {{110, 0}, {90, 0}, {69, 0}}, color = {0, 0, 127}));
      connect(add.u1, u) annotation(Line(points = {{46, 6}, {0, 6}, {0, 40}, {-80, 40}, {-80, 0}, {-118, 0}}, color = {0, 0, 127}));
      connect(add.u2, losses) annotation(Line(points = {{46, -6}, {0, -6}, {0, -110}}, color = {0, 0, 127}));
      connect(consTable.y[1], add.u2) annotation(Line(points = {{-31, -20}, {-16, -20}, {0, -20}, {0, -6}, {46, -6}}, color = {0, 0, 127}));
      connect(consTable.u[1], u) annotation(Line(points = {{-54, -20}, {-68, -20}, {-80, -20}, {-80, 0}, {-118, 0}}, color = {0, 0, 127}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Text(lineColor=  {0, 0, 255}, fillColor=  {0, 0, 127}, fillPattern=  FillPattern.Solid, extent=  {{-100, 145}, {98, 105}}, textString=  "%name"), Polygon(origin=  {-0.9, 2.05}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, points=  {{-23.1, 53.95}, {22.9, 53.95}, {20.9045, -22.0499}, {56.9, -24.05}, {0.9, -58.05}, {-55.1, -26.05}, {-21.0955, -24.0499}, {-23.1, 53.95}}, lineColor=  {0, 0, 0}), Text(extent=  {{-100, 44}, {100, -40}}, lineColor=  {0, 0, 0}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, textString=  "PC")}));
    end AddPcLosses;

    model AddPcLossesOld
      "Simplified losses of a generalised ICE. First release: two straight line segments"
      // Le perdite sono calcolate come dall'analisi della mappa della Prius che porta a mostrare
      // come sia possibile rappresentarle come una spezzata. Il primo segmento deriva
      // dal tratto verticale dei punti di lavoro ottimale e può ragionevolmente
      // essere rappresentata dalla relazione:
      // L(W)=5000+1.45Pu(W)= loss0+slope*u
      // Il secondo segmento è una retta che passa per l'origine e mostra perdite
      // proporzionali alla potenza erogata
      // il che corrisponde ad avere una curva dei punti di funzionamento ottimali
      // orizzontale (a coppia costante).
      // Nel caso della Prius questo è ragionevole e la coppia vale 79.6 Nm.
      //
      // La potenza di uscita è pari a quella di ingresso a cui si sono aggiunte le perdite calcolate.
      // Le perdite sono anche fornite in uscita.
      parameter Real loss0 = 5000 "watts when the delivered power is zero";
      parameter Real slope = 1.45
        "watts of losses per delivered watt avobe the corner point";
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u "input fuel power" annotation(Placement(visible = true, transformation(extent = {{-138, -20}, {-98, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      //  Modelica.SIunits.Power losses annotation(Placement(visible = true, transformation(origin = {120, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      losses = loss0 + slope * u;
      y = u + losses;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Text(lineColor=  {0, 0, 255}, fillColor=  {0, 0, 127}, fillPattern=  FillPattern.Solid, extent=  {{-100, 145}, {98, 105}}, textString=  "%name"), Polygon(origin=  {-0.9, 2.05}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, points=  {{-23.1, 53.95}, {22.9, 53.95}, {20.9045, -22.0499}, {56.9, -24.05}, {0.9, -58.05}, {-55.1, -26.05}, {-21.0955, -24.0499}, {-23.1, 53.95}}, lineColor=  {0, 0, 0}), Text(extent=  {{-100, 44}, {100, -40}}, lineColor=  {0, 0, 0}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, textString=  "PC")}));
    end AddPcLossesOld;

    model AddLosses
      "Simplified losses of a generalised ICE. First release: two straight line segments"
      // Le perdite sono calcolate come dall'analisi della mappa della Prius che porta a mostrare
      // come sia possibile rappresentarle come una spezzata. Il primo segmento deriva dal tratto verticale
      // dei punti di lavoro ottimale e può ragionevolmente essere rappresentata dalla relazione:
      // L(W)=5000+1.45Pu(W)= loss0+slope*u
      // Il secondo segmento è una retta che passa per l'rogine e mostra perdite proporzionali alla potenza erogata
      // il che corrisponde ad avere una curva dei punti di funzionamento ottimali orizzontale (a coppia costante).
      // Nel caso della Prius questo è ragionevole e la coppia vale 79.6 Nm.
      //
      // La potenza di uscita è pari a quella di ingresso a cui si csono agigunte le perdite calcolate.
      // Le perdite sono anche fornite in uscita.
      parameter Real loss0 = 5000 "watts when the delivered power is zero";
      parameter Real slope = 1.45
        "watts of losses per delivered watt avobe the corner point";
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u "input fuel power" annotation(Placement(visible = true, transformation(extent = {{-138, -20}, {-98, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      //  Modelica.SIunits.Power losses annotation(Placement(visible = true, transformation(origin = {120, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      losses = loss0 + slope * u;
      y = u + losses;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Text(lineColor=  {0, 0, 255}, fillColor=  {0, 0, 127}, fillPattern=  FillPattern.Solid, extent=  {{-100, 145}, {98, 105}}, textString=  "%name"), Polygon(origin=  {-0.9, 2.05}, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid, points=  {{-29.0955, 59.9501}, {26.9045, 59.9501}, {20.9045, -22.0499}, {60.9045, -30.0499}, {-1.09552, -60.0499}, {-61.0955, -28.0499}, {-21.0955, -24.0499}, {-29.0955, 59.9501}})}));
    end AddLosses;

    model AddRessLosses "Simplified RESS loss computation"
      //le perdite hanno un termine lineare
      parameter Real fLin = 0.03 "lossPower=flin*|P|+fQuad*P/nomPower^2";
      parameter Real fQuad = 0.04 "lossPower=flin*|P|+fQuad*P/nomPower^2";
      parameter Real nomPower = 1e4;
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput inFlow "input fuel power" annotation(Placement(visible = true, transformation(extent = {{-138, -20}, {-98, 20}}, rotation = 0), iconTransformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Real losses1, losses2;
    protected
      Real absInFlow;
      parameter Real smallPow = nomPower / 10;
    equation
      absInFlow = noEvent(abs(inFlow));
      losses1 = fLin * (absInFlow + smallPow * exp(-absInFlow / smallPow) - smallPow);
      losses2 = fQuad * inFlow * inFlow / nomPower;
      losses = losses1 + losses2;
      y = inFlow - losses;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Text(lineColor=  {0, 0, 255}, fillColor=  {0, 0, 127}, fillPattern=  FillPattern.Solid, extent=  {{-100, 145}, {98, 105}}, textString=  "%name"), Polygon(origin=  {-0.9, -3.95}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, points=  {{-23.1, 53.95}, {22.9, 53.95}, {20.9045, -22.0499}, {56.9, -24.05}, {0.9, -58.05}, {-55.1, -26.05}, {-21.0955, -24.0499}, {-23.1, 53.95}}, lineColor=  {0, 0, 0}), Text(extent=  {{-100, 36}, {98, -38}}, lineColor=  {0, 0, 0}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, textString=  "RESS")}));
    end AddRessLosses;

    model Driver
      parameter Real gain = 100;
      Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {60, 120})));
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, 110})));
      Modelica.Blocks.Math.Gain gain1(k = gain) annotation(Placement(visible = true, transformation(origin = {-60, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{42, 50}, {22, 30}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(amplitude = 10, rising = 5, width = 5, falling = 5, period = 20) annotation(Placement(transformation(extent = {{70, 30}, {50, 50}})));
    equation
      connect(gain1.y, y) annotation(Line(points = {{-60, 85}, {-60, 110}, {-60, 110}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain1.u, feedback.y) annotation(Line(points = {{-60, 62}, {-60, 40}, {23, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(u, feedback.u2) annotation(Line(points = {{60, 120}, {58, 120}, {58, 70}, {32, 70}, {32, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(trapezoid.y, feedback.u1) annotation(Line(points = {{49, 40}, {40, 40}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 0}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -20}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor=  {0, 0, 127}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -20}}), Text(fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 64}, {100, 26}}, textString=  "Driver")}));
    end Driver;

    model MechInterface "Ideal Drive"
      parameter Modelica.SIunits.MomentOfInertia J = 1;
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
      Modelica.Blocks.Interfaces.RealInput genTau annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -102}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -102})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J) annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{30, -10}, {50, 10}})));
      Modelica.Blocks.Interfaces.RealOutput pow annotation(Placement(transformation(extent = {{-100, -10}, {-120, 10}})));
    equation
      pow = torque.tau * der(flange.phi);
      connect(flange, inertia.flange_b) annotation(Line(points = {{100, 0}, {80, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(inertia.flange_a, torque.flange) annotation(Line(points = {{60, 0}, {50, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(torque.tau, genTau) annotation(Line(points = {{28, 0}, {0, 0}, {0, -102}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false), graphics), Documentation(info = "<html>
<p>This is a very simplified ideal electric drive. It is composed by a simple inertia and an ideal conversion between electrical and mechanical quantities</p>
<p>It is useful for usage in simplified models for dynamic optiimisation for electricd and hybrid vehicles.</p>
</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin=  {0, 102}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 30}, {98, -1}}, textString=  "%name"), Rectangle(origin=  {1, 1}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-101, 99}, {99, -101}}), Rectangle(origin=  {56, 1}, fillColor=  {204, 204, 204}, fillPattern=  FillPattern.Solid, extent=  {{-42, 6}, {42, -7}}), Ellipse(origin=  {11, 0}, fillColor=  {156, 156, 156}, fillPattern=  FillPattern.Solid, extent=  {{-26, 26}, {26, -26}}, endAngle=  360)}));
    end MechInterface;

    model DragForce "Vehicle rolling and aerodinamical drag force"
      import Modelica.Constants.g_n;
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
      Modelica.SIunits.Force f "Total drag force";
      Modelica.SIunits.Velocity v "vehicle velocity";
      Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
      Real Sign;
      parameter Modelica.SIunits.Mass m "vehicle mass";
      parameter Modelica.SIunits.Density rho(start = 1.226) "air density";
      parameter Modelica.SIunits.Area S "vehicle cross area";
      parameter Real fc(start = 0.01) "rolling friction coefficient";
      parameter Real Cx "aerodinamic drag coefficient";
    protected
      parameter Real A = fc * m * g_n;
      parameter Real B = 1 / 2 * rho * S * Cx;
      // Constant auxiliary variable
    equation
      //  s = flange.s;
      v = der(s);
      a = der(v);
      // Le seguenti definizioni seguono l'ordine e le ridchieste del modello "PartialFriction" di
      // Modelica.Mechanics.Translational.Interfaces"
      v_relfric = v;
      a_relfric = a;
      f0 = A "forza a velocit?  0 ma con scorrimento";
      f0_max = A "massima forza  velocit?  0 e senza scorrimento ";
      free = false "sarebbe true quando la ruota si stacca dalla strada";
      // Ora il calcolo di f, e la sua attribuzione alla flangia:
      flange.f - f = 0;
      // friction force
      if v > 0 then
        Sign = 1;
      else
        Sign = -1;
      end if;
      f - B * v ^ 2 * Sign = if locked then sa * unitForce else f0 * (if startForward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else if startBackward then -Modelica.Math.tempInterpol1(-v, [0, 1], 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else -Modelica.Math.tempInterpol1(-v, [0, 1], 2));
      annotation(Documentation(info = "<html>
            <p>This component modesl the total (rolling &egrave;+ aerrodynamic vehicle drag resistance: </p>
            <p>f=mgh+(1/2)*rho*Cx*S*v^2</p>
            <p>It models reliably the stuck phase. based on Modelica-Intrerfaces.PartialFriction model</p>
            </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points=  {{-98, 10}, {22, 10}, {22, 41}, {92, 0}, {22, -41}, {22, -10}, {-98, -10}, {-98, 10}}, lineColor=  {0, 127, 0}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Line(points=  {{-42, -50}, {87, -50}}, color=  {0, 0, 0}), Polygon(points=  {{-72, -50}, {-41, -40}, {-41, -60}, {-72, -50}}, lineColor=  {0, 0, 0}, fillColor=  {128, 128, 128}, fillPattern=  FillPattern.Solid), Line(points=  {{-90, -90}, {-70, -88}, {-50, -82}, {-30, -72}, {-10, -58}, {10, -40}, {30, -18}, {50, 8}, {70, 38}, {90, 72}, {110, 110}}, color=  {0, 0, 255}, thickness=  0.5), Text(extent=  {{-82, 90}, {80, 50}}, lineColor=  {0, 0, 255}, textString=  "%name")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics));
    end DragForce;

    model LossMechInterface "Ideal Drive"
      parameter Modelica.SIunits.MomentOfInertia J = 1;
      parameter Modelica.SIunits.Voltage uBase "base voltage (rms per phase)";
      parameter Modelica.SIunits.AngularVelocity wBase "base angular speed";
      parameter Modelica.SIunits.Power constLoss;
      //perdite di cummutazione (assunte costanti)
      parameter Modelica.SIunits.Voltage lossFact = 4;
      //perdite di on-state (W/A)
      Modelica.SIunits.Current current "estimated AC current";
      //  Modelica.SIunits.Power loss "lost power";
      Modelica.SIunits.AngularVelocity wMecc "base angular speed";
      Modelica.SIunits.Power mechPow "mechanical power";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
      Modelica.Blocks.Interfaces.RealInput genTau annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -102}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -102})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J) annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{30, -10}, {50, 10}})));
      Modelica.Blocks.Interfaces.RealOutput pow annotation(Placement(transformation(extent = {{-100, -10}, {-120, 10}})));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 110})));
    equation
      wMecc = der(flange.phi);
      mechPow = torque.tau * wMecc;
      current = noEvent(abs(mechPow * abs(wBase / (abs(wMecc) + 0.01) / uBase / 3)));
      losses = constLoss + lossFact * current;
      pow = losses + mechPow;
      connect(flange, inertia.flange_b) annotation(Line(points = {{100, 0}, {80, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(inertia.flange_a, torque.flange) annotation(Line(points = {{60, 0}, {50, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(torque.tau, genTau) annotation(Line(points = {{28, 0}, {0, 0}, {0, -102}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}}, preserveAspectRatio = false), graphics), Documentation(info = "<html>
<p>This is a very simplified ideal electric drive. It is composed by a simple inertia and an ideal conversion between electrical and mechanical quantities</p>
<p>It is useful for usage in simplified models for dynamic optiimisation for electricd and hybrid vehicles.</p>
</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Polygon(origin=  {-0.9, 36.05}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, points=  {{-19.1, -0.05}, {20.9, -0.05}, {20.9, 25.95}, {56.9, 24.05}, {0.9, 58.05}, {-55.1, 26.05}, {-19.1, 27.95}, {-19.1, -0.05}}), Text(fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, -32}, {98, -70}}, textString=  "%name"), Rectangle(origin=  {60, 1}, fillColor=  {204, 204, 204}, fillPattern=  FillPattern.Solid, extent=  {{-42, 6}, {42, -7}}), Ellipse(origin=  {15, 0}, fillColor=  {156, 156, 156}, fillPattern=  FillPattern.Solid, extent=  {{-26, 26}, {26, -26}}, endAngle=  360)}));
    end LossMechInterface;

    model PropDriver "Simple Proportional controller driver"
      parameter String CycleFileName = "MyCycleName.txt"
        "Drive Cycle Name ex: \"sort1.txt\"";
      parameter Real k "Controller gain";
      Modelica.Blocks.Interfaces.RealOutput tauRef(unit = "N.m") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 70}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 110})));
      Modelica.Blocks.Sources.CombiTimeTable driveCyc(tableOnFile = true, tableName = "Cycle", extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = CycleFileName, columns = {2}) annotation(Placement(transformation(extent = {{-86, -30}, {-66, -10}})));
      Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh annotation(Placement(transformation(extent = {{-48, -30}, {-28, -10}})));
      Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 0})));
      Modelica.Blocks.Math.Gain gain(k = k) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 40})));
      Modelica.Blocks.Interfaces.RealInput V annotation(Placement(visible = true, transformation(origin = {114, 2}, extent = {{-14, -14}, {14, 14}}, rotation = 180), iconTransformation(origin = {112, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
    equation
      connect(feedback.u2, V) annotation(Line(points = {{8, -8.88178e-016}, {8, 2}, {114, 2}}, color = {0, 0, 127}));
      connect(from_kmh.u, driveCyc.y[1]) annotation(Line(points = {{-50, -20}, {-65, -20}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(from_kmh.y, feedback.u1) annotation(Line(points = {{-27, -20}, {-14, -20}, {-14, -20}, {0, -20}, {0, -8}, {-8.88178e-016, -8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(feedback.y, gain.u) annotation(Line(points = {{0, 9}, {0, 10}, {0, 10}, {0, 8}, {0, 28}, {-8.88178e-016, 28}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.y, tauRef) annotation(Line(points = {{6.66134e-016, 51}, {0, 51}, {0, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Documentation(info = "<html>
            <p>Modello semplice di pilota.</p>
            <p>Esso contiene al suo interno il ciclo di riferimento, che insegue attraverso un regolatore solo proporzionale.</p>
            </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Ellipse(fillColor=  {255, 213, 170}, fillPattern=  FillPattern.Solid, extent=  {{-23, 46}, {-12, 20}}, endAngle=  360), Text(origin=  {2, -250.189}, lineColor=  {0, 0, 255}, extent=  {{-104, 142.189}, {98, 104}}, textString=  "%name"), Polygon(fillColor=  {215, 215, 215}, pattern=  LinePattern.None, fillPattern=  FillPattern.Solid, points=  {{-22, -36}, {-42, -64}, {-16, -64}, {16, -64}, {-22, -36}}), Polygon(fillColor=  {135, 135, 135}, pattern=  LinePattern.None, fillPattern=  FillPattern.Solid, points=  {{-32, 64}, {-62, -28}, {-30, -28}, {-30, -28}, {-32, 64}}, smooth=  Smooth.Bezier), Polygon(fillColor=  {135, 135, 135}, pattern=  LinePattern.None, fillPattern=  FillPattern.Solid, points=  {{-68, -12}, {-14, -66}, {10, -26}, {0, -26}, {-68, -12}}, smooth=  Smooth.Bezier), Polygon(fillColor=  {175, 175, 175}, fillPattern=  FillPattern.Solid, points=  {{-22, 34}, {-30, 30}, {-40, -24}, {2, -22}, {2, -10}, {0, 26}, {-22, 34}}, smooth=  Smooth.Bezier), Ellipse(fillColor=  {255, 213, 170}, fillPattern=  FillPattern.Solid, extent=  {{-30, 68}, {-3, 34}}, endAngle=  360), Polygon(pattern=  LinePattern.None, fillPattern=  FillPattern.Solid, points=  {{-38, 58}, {-16, 74}, {-2, 60}, {4, 60}, {6, 60}, {-38, 58}}, smooth=  Smooth.Bezier), Polygon(fillColor=  {95, 95, 95}, fillPattern=  FillPattern.Solid, points=  {{30, -20}, {-32, -4}, {-36, -20}, {-24, -34}, {30, -20}}, smooth=  Smooth.Bezier), Polygon(fillPattern=  FillPattern.Solid, points=  {{42, -46}, {36, -60}, {48, -54}, {52, -48}, {50, -44}, {42, -46}}, smooth=  Smooth.Bezier), Line(points=  {{48, 10}, {26, 24}, {26, 24}}, thickness=  0.5), Line(points=  {{20, 14}, {34, 34}, {34, 34}}, thickness=  0.5), Polygon(fillColor=  {255, 213, 170}, fillPattern=  FillPattern.Solid, points=  {{28, 28}, {32, 32}, {28, 26}, {34, 30}, {30, 26}, {34, 28}, {30, 24}, {26, 26}, {34, 24}, {26, 24}, {26, 26}, {28, 28}, {28, 28}, {26, 26}, {26, 26}, {26, 26}, {28, 32}, {28, 30}, {28, 28}}, smooth=  Smooth.Bezier), Polygon(fillColor=  {175, 175, 175}, fillPattern=  FillPattern.Solid, points=  {{-18, 24}, {28, 30}, {26, 22}, {-16, 8}, {-20, 8}, {-24, 18}, {-18, 24}}, smooth=  Smooth.Bezier), Polygon(fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid, points=  {{72, 18}, {48, 18}, {36, -2}, {58, -62}, {72, -62}, {72, 18}}), Polygon(fillColor=  {95, 95, 95}, fillPattern=  FillPattern.Solid, points=  {{49, -70}, {17, -16}, {7, -20}, {-1, -26}, {49, -70}}, smooth=  Smooth.Bezier), Line(points=  {{-7, 55}, {-3, 53}}), Line(points=  {{-9, 42}, {-5, 42}}), Line(points=  {{-7, 55}, {-3, 55}})}), Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics));
    end PropDriver;

    model Storage
      Real energy(min = 0, max = nomEnergy, start = energyIni, fixed = true);
      parameter Real nomEnergy = 500 "Nominal Energy (Wh)";
      parameter Real nomPower = 500 "Nominal Power (W)";
      parameter Real energyIni = 100 "Initial Energy (Wh)";
    protected
      Real energyJoule = 3600 * energy "Energy in joules";
    public
      Modelica.Blocks.Interfaces.RealInput inFlow annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.RealOutput loe annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
    equation
      der(energyJoule) = inFlow;
      loe = energy / nomEnergy;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor=  {85, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-68, 28}, {72, -70}}), Rectangle(extent=  {{-100, 100}, {100, -100}}), Line(points=  {{-68, 64}, {-68, -70}, {72, -70}, {72, 64}}), Line(points=  {{-68, 28}, {72, 28}}), Line(points=  {{-28, 20}, {34, 20}}), Line(points=  {{-10, 14}, {12, 14}}), Text(origin=  {5, 72.6667}, extent=  {{-105, 17.3334}, {93, -10.6667}}, textString=  "Pn=%nomPower"), Text(origin=  {7, -45.3333}, extent=  {{-105, 19.3334}, {93, -8.66668}}, textString=  "En=%nomEnergy"), Text(origin=  {1, 125}, lineColor=  {0, 0, 255}, extent=  {{-100, 20}, {100, -20}}, textString=  "%name")}));
    end Storage;

    model AddPcLossesOO
      "Adds Primary Converter Losses, considering On/Off input signal"
      Modelica.Blocks.Interfaces.BooleanInput n "On Signal" annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
      Modelica.Blocks.Interfaces.RealInput u "mechanical outpu PC power" annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
      Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {38, 0})));
      AddPcLosses addPcLosses annotation(Placement(transformation(extent = {{-60, 50}, {-40, 70}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealOutput losses annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {0, -110}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-4, -110})));
      Modelica.Blocks.Sources.Constant const annotation(Placement(transformation(extent = {{-10, -38}, {10, -18}})));
    equation
      connect(addPcLosses.losses, losses) annotation(Line(points = {{-50, 49}, {-50, -78}, {0, -78}, {0, -110}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(addPcLosses.u, u) annotation(Line(points = {{-62, 60}, {-120, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(const.y, switch2.u3) annotation(Line(points = {{11, -28}, {16, -28}, {16, -8}, {26, -8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(n, switch2.u2) annotation(Line(points = {{-120, -60}, {-72, -60}, {-72, 0}, {26, 0}}, color = {255, 0, 255}, smooth = Smooth.None));
      connect(switch2.u1, addPcLosses.y) annotation(Line(points = {{26, 8}, {0, 8}, {0, 59.8}, {-39, 59.8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(switch2.y, y) annotation(Line(points = {{49, 0}, {110, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-100, 100}, {100, -100}}), Polygon(origin=  {-0.9, 2.05}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, points=  {{-23.1, 53.95}, {22.9, 53.95}, {20.9045, -22.0499}, {56.9, -24.05}, {0.9, -58.05}, {-55.1, -26.05}, {-21.0955, -24.0499}, {-23.1, 53.95}}, lineColor=  {0, 0, 0}), Text(extent=  {{-100, 28}, {100, -44}}, lineColor=  {0, 0, 0}, fillColor=  {255, 85, 85}, fillPattern=  FillPattern.Solid, textString=  "PC
OO")}));
    end AddPcLossesOO;

    model AVG "Sensor to measure the average value of input"
      Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-138, -12}, {-98, 28}}), iconTransformation(extent = {{-140, -20}, {-100, 20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{100, 0}, {120, 20}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Continuous.Integrator integrator annotation(Placement(transformation(extent = {{-60, -2}, {-40, 18}})));
      Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(transformation(extent = {{12, 0}, {32, 20}})));
      Modelica.Blocks.Nonlinear.FixedDelay fixedDelay1(delayTime = 1 / Frequency) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-14, -22})));
      Modelica.Blocks.Math.Gain gain(k = Frequency) annotation(Placement(transformation(extent = {{52, 0}, {72, 20}})));
      parameter Modelica.SIunits.Frequency Frequency = 50.
        "Frequency of signals";
    equation
      connect(integrator.u, u) annotation(Line(points = {{-62, 8}, {-118, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add.u1, integrator.y) annotation(Line(points = {{10, 16}, {-14, 16}, {-14, 8}, {-39, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(fixedDelay1.y, add.u2) annotation(Line(points = {{-3, -22}, {4, -22}, {4, 4}, {10, 4}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(fixedDelay1.u, integrator.y) annotation(Line(points = {{-26, -22}, {-28, -22}, {-28, 8}, {-39, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.u, add.y) annotation(Line(points = {{50, 10}, {33, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain.y, y) annotation(Line(points = {{73, 10}, {110, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Text(extent=  {{150, 80}, {-150, 120}}, textString=  "%name", lineColor=  {0, 0, 255}), Rectangle(extent=  {{-100, 60}, {100, -60}}, lineColor=  {0, 0, 127}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid), Text(extent=  {{-100, 32}, {98, -24}}, lineColor=  {0, 0, 127}, textString=  "AVG")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics), Documentation(info = "<html><p>
This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
</p>
</html>", revisions = "<html>
<ul>
<li><i> January 12, 2006   </i>
       by Anton Haumer<br> implemented<br>
       </li>
</ul>
</html>"));
    end AVG;
  end Components;

  package DO "Dynamic Optimization models"
    model DOHev1
      //Sequenza righe: parametri, input, obiettivo, vincoli.
      parameter Real p = 1 "required for optimization";
      parameter Real loeInit = 0.5;
      input Real pcPower(min = 0, nominal = 1e4, max = 1e4);
      Real pcEnergy(nominal = 1000) = toPcEnergy.y "minimize pcEnergy(tf)" annotation(isLagrange = true);
      Real finalLOE(min = loeInit, max = loeInit) = p * storage.loe annotation(isFinalConstraint = true);
      //
      Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-58, 22})));
      Modelica.Blocks.Continuous.Integrator toEnFlow annotation(Placement(visible = true, transformation(extent = {{-84, 26}, {-104, 46}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tauRes(w_nominal(displayUnit = "rpm") = 104.71975511966, tau_nominal = -100, phi(nominal = 1e3)) annotation(Placement(transformation(extent = {{64, 18}, {44, 38}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(amplitude = 100, rising = 50, width = 50, falling = 50, period = 200) annotation(Placement(transformation(extent = {{62, -40}, {42, -20}})));
      Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{30, -20}, {10, -40}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wLoad annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {20, 8})));
      Modelica.Blocks.Math.Gain gain1(k = 50) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, -12})));
      Components.MechInterface idealDrive annotation(Placement(transformation(extent = {{-16, 18}, {4, 38}})));
      Components.Storage storage(nomPower = 1000, energyIni = 500, nomEnergy = 1000) annotation(Placement(visible = true, transformation(origin = {-94, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression pcPower_(y = pcPower) annotation(Placement(visible = true, transformation(origin = {-62, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Continuous.Integrator toPcEnergy annotation(Placement(visible = true, transformation(origin = {60, -58}, extent = {{-104, 26}, {-84, 46}}, rotation = 0)));
    equation
      connect(pcPower_.y, add.u1) annotation(Line(points = {{-62, -27}, {-62, -1.5}, {-38, -1.5}, {-38, 15.25}, {-46, 15.25}, {-46, 16}}, color = {0, 0, 127}));
      connect(toPcEnergy.u, pcPower_.y) annotation(Line(points = {{-46, -22}, {-62, -22}, {-62, -27}}, color = {0, 0, 127}));
      connect(toEnFlow.u, storage.inFlow) annotation(Line(points = {{-82, 36}, {-76, 36}, {-76, 22}, {-78, 22}, {-78, -4}, {-82, -4}}, color = {0, 0, 127}));
      connect(add.y, storage.inFlow) annotation(Line(points = {{-69, 22}, {-78, 22}, {-78, -4}, {-82, -4}}, color = {0, 0, 127}));
      connect(trapezoid.y, feedback.u1) annotation(Line(points = {{41, -30}, {28, -30}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(wLoad.w, feedback.u2) annotation(Line(points = {{20, -3}, {20, -22}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(gain1.u, feedback.y) annotation(Line(points = {{-6.66134e-016, -24}, {-6.66134e-016, -30}, {11, -30}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(idealDrive.flange, tauRes.flange) annotation(Line(points = {{4, 28}, {44, 28}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(wLoad.flange, tauRes.flange) annotation(Line(points = {{20, 18}, {20, 28}, {44, 28}}, color = {0, 0, 0}, smooth = Smooth.None));
      connect(gain1.y, idealDrive.genTau) annotation(Line(points = {{8.88178e-016, -1}, {8.88178e-016, 8}, {-6, 8}, {-6, 17.8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(idealDrive.pow, add.u2) annotation(Line(points = {{-17, 28}, {-46, 28}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(Icon(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), __Dymola_experimentSetupOutput, Documentation(info = "<html>
<p>Modello di sistema con rete-carico-accumulo per trovare la legge di ottimizzazione dinamica.</p>
<p>Le potenze sono in kW, le energie in kWh, i costi in &euro;/kh, il tempo in h.</p>
<p>Una simulazione di 24 h d&agrave; quindi conto di un andamento giornaliero.</p>
<p>La versione da usare effettivamente per l&apos;ttimizzazione &egrave; la SystemDO, che non ha  l&apos;inflow come input assegnato, ma lasciato in gestione all&apos;ottimizzatore. </p>
</html>"), Diagram(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin=  {-30, 10}, lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-82, -30}, {-38, -40}}, textString=  "battery:
1000W- 1000Wh")}), experiment(StartTime = 0, StopTime = 120, Tolerance = 0.0001, Interval = 0.5));
    end DOHev1;

    model OOInertia
    //Sequenza righe: parametri, input, obiettivo, vincoli.
      parameter Real p = 1 "required for optimization";
    parameter Real loeInit = 0.5;
    input Real pcPower(min = 0, nominal = 1e4, max = 1e4);
    Real pcEnergy(nominal = 1000) = toPcEnergy.y "minimize pcEnergy(tf)" annotation(isLagrange = true);
    Real finalLOE(min = loeInit, max = loeInit) = p * storage.loe annotation(isFinalConstraint = true);
    //
      Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-58, 22})));
    Modelica.Blocks.Continuous.Integrator toEnFlow annotation(Placement(visible = true, transformation(extent = {{-84, 26}, {-104, 46}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tauRes(w_nominal(displayUnit = "rpm") = 104.71975511966, tau_nominal = -100, phi(nominal = 1e3)) annotation(Placement(transformation(extent = {{64, 18}, {44, 38}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(amplitude = 100, rising = 50, width = 50, falling = 50, period = 200) annotation(Placement(transformation(extent = {{62, -40}, {42, -20}})));
    Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent = {{30, -20}, {10, -40}})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor wLoad annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {20, 8})));
    Modelica.Blocks.Math.Gain gain1(k = 50) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, -12})));
    Components.MechInterface idealDrive annotation(Placement(transformation(extent = {{-16, 18}, {4, 38}})));
    Components.Storage storage(nomPower = 1000, energyIni = 500, nomEnergy = 1000) annotation(Placement(visible = true, transformation(origin = {-94, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression pcPower_(y = pcPower) annotation(Placement(visible = true, transformation(origin = {-62, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Continuous.Integrator toPcEnergy annotation(Placement(visible = true, transformation(origin = {60, -58}, extent = {{-104, 26}, {-84, 46}}, rotation = 0)));
    equation
    connect(pcPower_.y, add.u1) annotation(Line(points = {{-62, -27}, {-62, -1.5}, {-38, -1.5}, {-38, 15.25}, {-46, 15.25}, {-46, 16}}, color = {0, 0, 127}));
    connect(toPcEnergy.u, pcPower_.y) annotation(Line(points = {{-46, -22}, {-62, -22}, {-62, -27}}, color = {0, 0, 127}));
    connect(toEnFlow.u, storage.inFlow) annotation(Line(points = {{-82, 36}, {-76, 36}, {-76, 22}, {-78, 22}, {-78, -4}, {-82, -4}}, color = {0, 0, 127}));
    connect(add.y, storage.inFlow) annotation(Line(points = {{-69, 22}, {-78, 22}, {-78, -4}, {-82, -4}}, color = {0, 0, 127}));
    connect(trapezoid.y, feedback.u1) annotation(Line(points = {{41, -30}, {28, -30}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(wLoad.w, feedback.u2) annotation(Line(points = {{20, -3}, {20, -22}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain1.u, feedback.y) annotation(Line(points = {{-6.66134e-016, -24}, {-6.66134e-016, -30}, {11, -30}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(idealDrive.flange, tauRes.flange) annotation(Line(points = {{4, 28}, {44, 28}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(wLoad.flange, tauRes.flange) annotation(Line(points = {{20, 18}, {20, 28}, {44, 28}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(gain1.y, idealDrive.genTau) annotation(Line(points = {{8.88178e-016, -1}, {8.88178e-016, 8}, {-6, 8}, {-6, 17.8}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(idealDrive.pow, add.u2) annotation(Line(points = {{-17, 28}, {-46, 28}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(Icon(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), __Dymola_experimentSetupOutput, Documentation(info = "<html>
<p>Modello di sistema con rete-carico-accumulo per trovare la legge di ottimizzazione dinamica.</p>
<p>Le potenze sono in kW, le energie in kWh, i costi in &euro;/kh, il tempo in h.</p>
<p>Una simulazione di 24 h d&agrave; quindi conto di un andamento giornaliero.</p>
<p>La versione da usare effettivamente per l&apos;ttimizzazione &egrave; la SystemDO, che non ha  l&apos;inflow come input assegnato, ma lasciato in gestione all&apos;ottimizzatore. </p>
</html>"), Diagram(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin=  {-30, 10}, lineColor=  {0, 0, 255}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid, extent=  {{-82, -30}, {-38, -40}}, textString=  "battery:
1000W- 1000Wh")}), experiment(StartTime = 0, StopTime = 120, Tolerance = 0.0001, Interval = 0.5));
    end OOInertia;

    model ThreeLosses
      //Sequenza righe: parametri, input, obiettivo, vincoli.
      parameter Real p = 1 "required for optimization";
      parameter Real loeInit = 0.5;
      input Real pcPower(min = 0, nominal = 1e4, max = 1e4);
      //  Real totEnergy(nominal = 1000) = to_kWh.y "minimize totEnergy(tf)" annotation(isLagrange = true);
      Real pcEnergy(nominal = 1000) = to_kWh.y "minimize pcEnergy(tf)" annotation(isLagrange = true);
      Real finalLOE(min = loeInit, max = loeInit) = p * storage.loe annotation(isFinalConstraint = true);
      Real pcLosses10 = addPcL.losses / 10 "PC losses divided by 10";
      //  Real enPC, enRESS, enEleDrive;
      //
      OOInertia.Components.PropDriver propdriver1(CycleFileName = "SimplifEce15.txt", k = 1000) annotation(Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor annotation(Placement(visible = true, transformation(origin = {18, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression pcPower_(y = pcPower) annotation(Placement(visible = true, transformation(origin = {-92, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.AddPcLosses addPcL annotation(Placement(visible = true, transformation(origin = {-88, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Components.LossMechInterface mechInterface(J = 4, uBase = 230, wBase = 157, constLoss = 50) annotation(Placement(visible = true, transformation(extent = {{-32, 32}, {-12, 52}}, rotation = 0)));
      Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(visible = true, transformation(origin = {-52, 24}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation(Placement(visible = true, transformation(origin = {24, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Translational.Components.Mass mass1(m = 1400) annotation(Placement(visible = true, transformation(origin = {54, 32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Continuous.Integrator to_kWh(k = 1 / 3.6e6) annotation(Placement(visible = true, transformation(origin = {-88, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Components.DragForce dragForce(m = 1400, rho = 1.226, S = 2.2, fc = 0.014, Cx = 0.26) annotation(Placement(visible = true, transformation(origin = {54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Components.Storage storage(nomPower = 1000, energyIni = 500, nomEnergy = 1000) annotation(Placement(visible = true, transformation(origin = {-48, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Components.AddRessLosses addRessL annotation(Placement(visible = true, transformation(origin = {-48, -8}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
    equation
      //  der(enPC) = addPcL.losses;
      //  der(enRESS) = addRessL.losses;
      //  der(enEleDrive) = mechInterface.losses;
      connect(addRessL.inFlow, add.y) annotation(Line(points = {{-48, 4}, {-52, 4}, {-52, 14}, {-52, 13}}, color = {0, 0, 127}));
      connect(addRessL.y, storage.inFlow) annotation(Line(points = {{-47.8, -19}, {-47.8, -22}, {-48, -22}, {-48, -26}}, color = {0, 0, 127}));
      connect(addPcL.u, add.u1) annotation(Line(points = {{-88, 32}, {-88, 32}, {-88, 44}, {-58, 44}, {-58, 36}}, color = {0, 0, 127}));
      connect(mass1.flange_b, dragForce.flange) annotation(Line(points = {{54, 22}, {54, 4}}, color = {0, 127, 0}));
      connect(mass1.flange_a, wheel.flangeT) annotation(Line(points = {{54, 42}, {34, 42}}, color = {0, 127, 0}));
      connect(speedSensor.flange, mass1.flange_b) annotation(Line(points = {{28, 8}, {54, 8}, {54, 22}, {54, 22}}, color = {0, 127, 0}));
      connect(wheel.flangeR, mechInterface.flange) annotation(Line(points = {{14, 42}, {-12, 42}}));
      connect(mechInterface.pow, add.u2) annotation(Line(points = {{-33, 42}, {-46, 42}, {-46, 36}}, color = {0, 0, 127}));
      connect(pcPower_.y, add.u1) annotation(Line(points = {{-81, 50}, {-58, 50}, {-58, 36}}, color = {0, 0, 127}));
      connect(propdriver1.tauRef, mechInterface.genTau) annotation(Line(points = {{-14, 19}, {-14, 25.5}, {-22, 25.5}, {-22, 31.8}}, color = {0, 0, 127}));
      connect(speedSensor.v, propdriver1.V) annotation(Line(points = {{7, 8}, {-2.8, 8}}, color = {0, 0, 127}));
      connect(addPcL.y, to_kWh.u) annotation(Line(points = {{-87.8, 9}, {-88, 9}, {-88, -10}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(__Dymola_experimentSetupOutput, Documentation(info = "<html>
<p>Modello di sistema con rete-carico-accumulo per trovare la legge di ottimizzazione dinamica.</p>
<p>Le potenze sono in kW, le energie in kWh, i costi in &euro;/kh, il tempo in h.</p>
<p>Una simulazione di 24 h d&agrave; quindi conto di un andamento giornaliero.</p>
<p>La versione da usare effettivamente per l&apos;ttimizzazione &egrave; la SystemDO, che non ha  l&apos;inflow come input assegnato, ma lasciato in gestione all&apos;ottimizzatore. </p>
</html>"), Icon(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics), experiment(StartTime = 0, StopTime = 195, Tolerance = 1e-07, Interval = 0.65));
    end ThreeLosses;

    model OneLoss
      //Sequenza righe: parametri, input, obiettivo, vincoli.
      parameter Real p = 1 "required for optimization";
      parameter Real loeInit = 0.5;
      input Real pcPower(min = 0, nominal = 1e4, max = 1e4);
      Real pcEnergy(nominal = 1000) = toPcEn.y "minimize pcEnergy(tf)" annotation(isLagrange = true);
      Real finalLOE(min = loeInit, max = loeInit) = p * storage.loe annotation(isFinalConstraint = true);
      //
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wLoad annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {28, 20})));
      Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(visible = true, transformation(origin = {-34, 20}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tauRes(w_nominal(displayUnit = "rpm") = 104.71975511966, tau_nominal = -100, phi(nominal = 1e3)) annotation(Placement(visible = true, transformation(extent = {{64, 28}, {44, 48}}, rotation = 0)));
      Components.Storage storage(nomPower = 1000, energyIni = 500, nomEnergy = 1000, fQuad = 0) annotation(Placement(visible = true, transformation(origin = {-34, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Components.MechInterface mechInterface(J = 4) annotation(Placement(visible = true, transformation(extent = {{-14, 28}, {6, 48}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression pcPower_(y = pcPower) annotation(Placement(visible = true, transformation(origin = {-102, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.AddPcLosses addPcL annotation(Placement(visible = true, transformation(origin = {-78, 16}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      Components.Driver driver annotation(Placement(transformation(extent = {{-4, -22}, {26, -8}})));
      Modelica.Blocks.Continuous.Integrator toPcEn(k = 1 / 3.6e6) "unit: kWh" annotation(Placement(visible = true, transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-78, -28})));
    equation
      connect(mechInterface.flange, tauRes.flange) annotation(Line(points = {{6, 38}, {44, 38}}));
      connect(wLoad.flange, tauRes.flange) annotation(Line(points = {{28, 30}, {28, 38}, {44, 38}}));
      connect(mechInterface.pow, add.u2) annotation(Line(points = {{-15, 38}, {-28, 38}, {-28, 32}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(pcPower_.y, add.u1) annotation(Line(points = {{-91, 38}, {-40, 38}, {-40, 32}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(addPcL.u, add.u1) annotation(Line(points = {{-78, 28}, {-78, 38}, {-40, 38}, {-40, 32}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(driver.y, mechInterface.genTau) annotation(Line(points = {{2, -6.83333}, {2, 8}, {-4, 8}, {-4, 27.8}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(driver.u, wLoad.w) annotation(Line(points = {{20, -5.66667}, {20, 4}, {28, 4}, {28, 9}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(addPcL.y, toPcEn.u) annotation(Line(points = {{-77.8, 5}, {-78, 5}, {-78, -16}}, color = {0, 0, 127}, smooth = Smooth.None));
      connect(add.y, storage.inFlow) annotation(Line(points = {{-34, 9}, {-34, -2}}, color = {0, 0, 127}, smooth = Smooth.None));
      annotation(__Dymola_experimentSetupOutput, Documentation(info = "<html>
<p>Modello di sistema con rete-carico-accumulo per trovare la legge di ottimizzazione dinamica.</p>
<p>Le potenze sono in kW, le energie in kWh, i costi in &euro;/kh, il tempo in h.</p>
<p>Una simulazione di 24 h d&agrave; quindi conto di un andamento giornaliero.</p>
<p>La versione da usare effettivamente per l&apos;ttimizzazione &egrave; la SystemDO, che non ha  l&apos;inflow come input assegnato, ma lasciato in gestione all&apos;ottimizzatore. </p>
</html>"), Icon(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-120, -60}, {80, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics), experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-3, Interval = 0.5));
    end OneLoss;
  end DO;

  annotation(uses(Modelica(version = "3.2.1")));
end OOInertia;
