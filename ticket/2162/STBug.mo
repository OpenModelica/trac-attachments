within ;
encapsulated package simpleTrain
  import Modelica;
  import prova;
  import Tesi;
  import simpleTrain1;
  import simpleTrain_11;

  model VhDragForce "Vehicle rolling and aerodinamical drag force"
    import Modelica.Constants.g_n "standard earth acceleration";

    extends
      Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
    extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;

    Modelica.SIunits.Force f "Total drag force";
    Modelica.SIunits.Velocity v "vehicle velocity";
    Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
    Real Sign;
    parameter Modelica.SIunits.Mass m "vehicle mass";
    parameter Modelica.SIunits.Density rho(start=1.226) "air density";
    parameter Modelica.SIunits.Area S "vehicle cross area";
    parameter Real fc(start=0.01) "rolling friction coefficient";
    parameter Real Cx "aerodinamic drag coefficient";

  protected
    parameter Real A=fc*m*g_n;
    parameter Real B=(1/2)*rho*S*Cx;

    // Constant auxiliary variable
  equation
    //  s = flange.s;
    v = der(s);
    a = der(v);

    // Le seguenti definizioni seguono l'ordine e le ridchieste del modello "PartialFriction" di
    // Modelica.Mechanics.Translational.Interfaces"
    v_relfric = v;
    a_relfric = a;
    f0 = A "forza a velocitÃ  0 ma con scorrimento";
    f0_max = A "massima forza  velocitÃ  0 e senza scorrimento ";
    free = false "sarebbe true quando la ruota si stacca dalla strada";

    // Ora il calcolo di f, e la sua attribuzione alla flangia:
    flange.f - f = 0;
    // friction force
    if v > 0 then
      Sign = 1;
    else
      Sign = -1;
    end if;
    f - B*v^2*Sign = if locked then sa*unitForce else f0*(if startForward then
      Modelica.Math.tempInterpol1(
        v,
        [0, 1],
        2) else if startBackward then -Modelica.Math.tempInterpol1(
        -v,
        [0, 1],
        2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(
        v,
        [0, 1],
        2) else -Modelica.Math.tempInterpol1(
        -v,
        [0, 1],
        2));
    annotation (
      Documentation(info="<html>
<p>This component modesl the total (rolling &egrave;+ aerrodynamic vehicle drag resistance: </p>
<p>f=mgh+(1/2)*rho*Cx*S*v^2</p>
<p>It models reliably the stuck phase. based on Modelica-Intrerfaces.PartialFriction model</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-98,10},{22,10},{22,41},{92,0},{22,-41},{22,-10},{-98,-10},
                {-98,10}},
            lineColor={0,127,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{-42,-50},{87,-50}}, color={0,0,0}),
          Polygon(
            points={{-72,-50},{-41,-40},{-41,-60},{-72,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-90,-90},{-70,-88},{-50,-82},{-30,-72},{-10,-58},{10,-40},
                {30,-18},{50,8},{70,38},{90,72},{110,110}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-82,90},{80,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics));
  end VhDragForce;


  block Inverse "Outputs the inverse of (input multiplied by k)"
    import Modelica.Constants.inf;
    import Modelica.Constants.eps;
    Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
            extent={{-128,-20},{-88,20}}), iconTransformation(extent={{-128,-18},
              {-92,18}})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
          transformation(extent={{98,-10},{118,10}}), iconTransformation(extent
            ={{96,-10},{116,10}})));
    parameter Real k;
  equation
    if abs(u) < (eps) then
      y = inf;
    else
      y = 1./(k*u);
    end if;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics
          ={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Text(
            extent={{-10,-4},{60,52}},
            lineColor={0,0,127},
            textString="1"),
          Text(
            extent={{-32,0},{76,-46}},
            lineColor={0,0,127},
            textString="k u"),
          Line(
            points={{-14,0},{66,0}},
            color={0,0,127},
            smooth=Smooth.None),
          Text(
            extent={{-86,-30},{-16,26}},
            lineColor={0,0,127},
            textString="y=")}));
  end Inverse;

  model DCLConstP "Constant Power DC Load"

    parameter Real k "inner PI follower proportional gain";
    parameter Modelica.SIunits.Time T
      "inner PI follower integral time constant";
    Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{-74,52},{-54,72}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
        Placement(transformation(extent={{-110,70},{-90,90}}),
          iconTransformation(extent={{-20,82},{0,102}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
        Placement(transformation(extent={{-110,-90},{-90,-70}}),
          iconTransformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-4,48})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=270,
          origin={-35,45})));
    Inverse inverse(k=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={18,74})));
    Modelica.Blocks.Interfaces.RealInput Pref "Reference power" annotation (
        Placement(transformation(
          extent={{-18,-18},{18,18}},
          rotation=180,
          origin={118,-20}), iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=0,
          origin={-94,0})));
    Modelica.Blocks.Continuous.PI PI(k=k, T=T) annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={28,-20})));
    Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={64,-20})));
    Modelica.Blocks.Math.Product product annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={24,48})));
    Modelica.SIunits.Voltage v;
  equation
    v = pin_p.v - pin_n.v;
    connect(powerSensor.pc, pin_p) annotation (Line(
        points={{-74,62},{-18,62},{-18,80},{-100,80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(powerSensor.pv, powerSensor.pc) annotation (Line(
        points={{-64,72},{-74,72},{-74,62}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(powerSensor.nc, signalCurrent.p) annotation (Line(
        points={{-54,62},{-4,62},{-4,58}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(signalCurrent.n, pin_n) annotation (Line(
        points={{-4,38},{-4,-80},{-100,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.p, powerSensor.nc) annotation (Line(
        points={{-35,54},{-35,62},{-54,62}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor.n, signalCurrent.n) annotation (Line(
        points={{-35,36},{-35,2},{-4,2},{-4,38}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(powerSensor.nv, pin_n) annotation (Line(
        points={{-64,52},{-64,-80},{-100,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(feedback1.u1, Pref) annotation (Line(
        points={{72,-20},{118,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.u2, powerSensor.power) annotation (Line(
        points={{64,-12},{64,16},{-72,16},{-72,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, PI.u) annotation (Line(
        points={{55,-20},{37.6,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(voltageSensor.v, inverse.u) annotation (Line(
        points={{-44,45},{-46,45},{-46,74},{7,74}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverse.y, product.u2) annotation (Line(
        points={{28.6,74},{48,74},{48,52.8},{33.6,52.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(PI.y, product.u1) annotation (Line(
        points={{19.2,-20},{10,-20},{10,24},{46,24},{46,43.2},{33.6,43.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.y, signalCurrent.i) annotation (Line(
        points={{15.2,48},{3,48}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
              100}}), graphics={
          Line(
            points={{-10,86},{-10,-88},{-12,-90}},
            color={0,0,0},
            smooth=Smooth.None),
          Rectangle(
            extent={{-30,54},{10,-56}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,10},{100,-10}},
            lineColor={0,0,255},
            textString="%name",
            origin={24,2},
            rotation=90),
          Line(
            points={{-80,0},{-30,0},{-30,0}},
            color={0,0,255},
            smooth=Smooth.None),
          Text(
            extent={{-74,14},{-34,2}},
            lineColor={0,0,255},
            textString="Potenza")}),
      Documentation(info="<html>
<p>Questo componente simula, mediante inseguimento di un riferimento esterno, un carico a potenza costante.</p>
<p>I parametri k e T sono i parametri del regolatore PI che insegue l&apos;input. TIpicamente si potr&agrave; utilizzare k=1 e T di un ordine di grandezza pi&ugrave; piccolo delle costanti di tempo del segnale di ingresso di potenza</p>
</html>"));
  end DCLConstP;

  model Sfioratore_di_Tensione
    "Sfioratore di Tensione: Taglia la potenza di frenatura per mantenere la tensione sulla linea di alimentazione al di sotto del valore massimo Vmax"

    Modelica.Blocks.Interfaces.RealInput Tensione
      "Tensione della linea di alimentazione DC" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={8,100})));
    Modelica.Blocks.Interfaces.RealInput Potenza
      "Potenza da tagliare (eventualmente)" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,-100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={8,-100})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    parameter Real Vmax=900
      "Tensione massima sulla linea di alimentazione (+20%Vnom per linee DC) [V]";
    parameter Real Kcontr=300000
      "Costante del controllore di tensione puramente proporzionale ";
    Modelica.Blocks.Continuous.FirstOrder Ritardo(T=0.01)
      "Ritardo utile per evitare errori della simulazione"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  equation
    if Tensione >= Vmax then
      Ritardo.u = Potenza - Kcontr*(Vmax - Tensione);
    else
      Ritardo.u = Potenza;
    end if;
    connect(Ritardo.y, y) annotation (Line(
        points={{81,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Line(
              points={{56,0},{40,0},{40,0}},
              color={0,0,0},
              smooth=Smooth.None),Rectangle(extent={{-12,6},{40,-6}}, lineColor
            ={0,0,127}),Text(
              extent={{-8,4},{36,-4}},
              lineColor={0,0,127},
              fillPattern=FillPattern.Solid,
              textString="Codice Interno")}), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(extent={{-78,80},{100,-80}}, lineColor={0,0,0}),
          Line(
            points={{66,66},{26,10},{26,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{66,66},{20,14},{20,14}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{20,14},{44,74},{44,74}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{44,74},{12,16},{12,16}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(extent={{-24,2},{-8,-8}}, lineColor={0,0,0}),
          Ellipse(extent={{8,-16},{24,-26}}, lineColor={0,0,0}),
          Line(
            points={{12,16},{8,-22},{8,-22}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,10},{-12,-8},{-12,-8}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-70,-36},{98,-78}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="Sfioratore"),
          Text(
            extent={{30,96},{66,96}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="V"),
          Text(
            extent={{26,-98},{70,-102}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="P")}));
  end Sfioratore_di_Tensione;






  model DriverAB_Mod
    "Controlla la forza di trazione con obiettivi di velocita' e spazio. (Accelerazione-Frenatura)"

    Modelica.StateGraph.InitialStep Accelerazione "Fase di Accelerazione"
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.StateGraph.TransitionWithSignal Trans_Acc_Fren
      "Transizione tra Accelerazione e Coasting"
      annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
    Modelica.Blocks.Interfaces.RealInput v "Velocità [m/s]" annotation (
        Placement(transformation(extent={{-140,-60},{-100,-20}}),
          iconTransformation(extent={{-140,-60},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealOutput f "Forza di Trazione [N]"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput s "Spazio [m]" annotation (Placement(
          transformation(extent={{-140,20},{-100,60}}), iconTransformation(
            extent={{-140,20},{-100,60}})));
    parameter Real Stot[:]={797,1464,2023,2375,2815,3237,3750,5173,6268,7251,
        6268,5173,3750,3237,2815,2375,2023,1464,797,30}
      "STAZIONI: Array delle ascisse di posizione (Assolute) in cui sono posizionate le varie stazioni [m]";
    parameter Real Vmax0[:]={70,50,70,70,50,70,30,70,70,70,70,70,70,30,70,50,70,
        70,50,70}
      "VELOCITA' MASSIMA: Array delle velocità massime del convoglio nei vari tratti [Km/h]";
    parameter Real Sfren[:]={697,1364,1923,2275,2715,3137,3650,5073,6168,7151,
        6368,5273,3850,3337,2915,2475,2123,1564,897,130}
      "ASCISSE DI FRENATURA: Array delle varie ascisse di frenatura del convoglio nei vari tratti che deve percorrere [m]";
    parameter Real Pmax=628000 "Potenza massima del Convoglio [W]";
    parameter Real Fmax=72100
      "Forza massima di trazione (limite di aderenza) [N]";
    parameter Real Kcontr=1000000
      "Costante del controllore puramente proporzionale per la fase di frenatura ";
    Real Vrif0 "Velocità di riferimento da seguire [m/s]";
    Real Vrif
      "Correzione di Vrif0 in modo che Vrif0 sia sempre maggiore o uguale a zero [m/s]";
    Real f0 "Forza di trazione fornita dal controllore [N]";
    Real f1
      "Forza di trazione corretta per tenere di conto della limitazione di forza di trazione [N]";
    Integer i "Indice per aggiornare Stot e Sfren via via che il treno avanza";
    Modelica.Blocks.Logical.GreaterEqual Mag_Ug
      annotation (Placement(transformation(extent={{-60,6},{-50,16}})));
    Modelica.Blocks.Sources.RealExpression Ascissa_Frenatura(y=Sfren[i])
      annotation (Placement(transformation(
          extent={{-9,-8},{9,8}},
          rotation=90,
          origin={-83,-16})));

    Modelica.StateGraph.TransitionWithSignal Trans_Ferm_Acc
      "Transizione tra Accelerazione e Coasting"
      annotation (Placement(transformation(extent={{70,60},{90,80}})));
    Modelica.StateGraph.StepWithSignal Fermata
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    parameter Integer Seme_Partenza=50000
      "Seme di partenza per la creazione di una sequenza di numeri random con il metodo del generatore random lineare congruenziale LCG";
    parameter Real Gain=120
      "Costante moltiplicativa (legata al tempo di fermata massimo) in quanto il numero random generato (x) è compreso tra 0 e 1";

    Modelica.Blocks.Logical.LessEqual Min_Ug
      annotation (Placement(transformation(extent={{-58,-16},{-48,-6}})));
    Modelica.Blocks.Logical.LogicalSwitch Switch annotation (Placement(
          transformation(
          extent={{-6,-8},{6,8}},
          rotation=90,
          origin={-40,44})));
    Modelica.Blocks.Sources.BooleanExpression Cond_Frenatura(y=vel) annotation
      (Placement(transformation(
          extent={{-5,-8},{5,8}},
          rotation=90,
          origin={-40,23})));
    Boolean vel
      "Parametro boolean per capire se la velocità durante la marcia è positiva (il conv. procede da sx. a dx.) o negativa (il conv. procede da dx. a sx.)";

    Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold
      annotation (Placement(transformation(extent={{-58,-44},{-48,-34}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(
        threshold=0)
      annotation (Placement(transformation(extent={{-58,-70},{-48,-60}})));
    Modelica.StateGraph.Step Frenatura
      annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    Modelica.StateGraph.TransitionWithSignal Trans_Fren_Ferm
      annotation (Placement(transformation(extent={{10,60},{30,80}})));
    Modelica.Blocks.Logical.LogicalSwitch Switch1 annotation (Placement(
          transformation(
          extent={{-5,-6},{5,6}},
          rotation=0,
          origin={1,-54})));
    Modelica.Blocks.Sources.BooleanExpression Condiz_Fermata(y=vel)
      annotation (Placement(transformation(extent={{-36,-64},{-18,-44}})));
    Real Vf_neg
      "Campionamento della velocità nell'istante di frenatura nel caso di velocità negative [m/s]";
    Real Vf_pos
      "Campionamento della velocità nell'istante di frenatura nel caso di velocità positive [m/s]";
    Real Sf_neg
      "Campionamento della posizione nell'istante di frenatura nel caso di velocità negative [m]";
    Real Sf_pos
      "Campionamento della posizione nell'istante di frenatura nel caso di velocità positive [m]";
    Real Tempof_neg
      "Campionamento del tempo trascorso nell'istante di frenatura nel caso di velocità negative [s]";
    Real Tempof_pos
      "Campionamento del tempo trascorso nell'istante di frenatura nel caso di velocità positive [s]";
    Real Vmax[size(Vmax0, 1)]
      "Array delle velocità massima del convoglio in m/s";
  initial equation
    i = 1;
    vel = true;
  equation
    //Trasformazione di Vmax da km/h in m/s:
    for i in 1:size(Vmax0, 1) loop
      Vmax[i] = Vmax0[i]/3.6;
    end for;
    if vel then
      // SIAMO NEL CASO DI VELOCITA' POSITIVE (OSSIA IL CONVOGLIO VA DA SX A DX):
      //Fase di Accelerazione:
      if Accelerazione.active then
        //f0 deriva dal controllo della velocità di tipo solo proporzionale:
        f0 = Kcontr*(Vmax[i] - v);
        //f1 altera f0 per considerare le limitazioni di forza:
        f1 = if f0 > Fmax then Fmax else f0;
        //f altera f0 per considerare le limitazioni di potenza:
        f = if f1*v > Pmax then Pmax/v else f1;
        Vrif0 = 0;
        Vrif = 0;
        //Fase di Frenatura:
      elseif Frenatura.active then
        Vrif0 = Vf_pos - Vf_pos^2/(2*(Stot[i] - Sf_pos))*(time - Tempof_pos);
        Vrif = if Vrif0 > 0 then Vrif0 else 0;
        f0 = Kcontr*(Vrif - v);
        // f1 altera f0 per considerare le limitazioni di forza:
        f1 = if f0 < -Fmax then -Fmax else f0;
        //f altera f0 per considerare le limitazioni di potenza:
        f = if f1*v < -Pmax then -Pmax/v else f1;
        //Fase di Fermata in stazione:
      else
        f = 0;
        Vrif0 = 0;
        Vrif = 0;
        f1 = 0;
        f0 = 0;
      end if;

    else
      // SIAMO NEL CASO DI VELOCITA' NEGATIVE (OSSIA IL CONVOGLIO VA DA DX A SX):
      //Fase di Accelerazione:
      if Accelerazione.active then
        //f0 deriva dal controllo della velocità di tipo solo proporzionale:
        f0 = Kcontr*(-Vmax[i] - v);
        //f1 altera f0 per considerare le limitazioni di forza:
        f1 = if f0 < -Fmax then -Fmax else f0;
        //f altera f0 per considerare le limitazioni di potenza:
        f = if f1*v > Pmax then Pmax/v else f1;
        Vrif0 = 0;
        Vrif = 0;
        //Fase di Frenatura:
      elseif Frenatura.active then
        Vrif0 = Vf_neg - Vf_neg^2/(2*(Stot[i] - Sf_neg))*(time - Tempof_neg);
        Vrif = if Vrif0 < 0 then Vrif0 else 0;
        f0 = Kcontr*(Vrif - v);
        // f1 altera f0 per considerare le limitazioni di forza:
        f1 = if f0 > Fmax then Fmax else f0;
        //f altera f0 per considerare le limitazioni di potenza:
        f = if f1*v < -Pmax then -Pmax/v else f1;
        //Fase di Fermata in stazione:
      else
        f = 0;
        Vrif0 = 0;
        Vrif = 0;
        f1 = 0;
        f0 = 0;
      end if;
    end if;
    //PER VELOCITA' POSITIVE: Campionamento dei parametri per il calcolo della retta di frenatura (il campionamento avviene quando s>=Sfren "attuale"):
    when Mag_Ug.y then
      Sf_pos = s;
      Vf_pos = v;
      Tempof_pos = time;
    end when;
    //PER VELOCITA' NEGATIVE: Campionamento dei parametri per il calcolo della retta di frenatura (il campionamento avviene quando s<=Sfren "attuale"):
    when Min_Ug.y then
      Sf_neg = s;
      Vf_neg = v;
      Tempof_neg = time;
    end when;
    //Incrementazione del contatore e variazione della variabile che considera se la prossima tratta sarà a velocità positiva o negativa (Per variare in modo opportuno la condizione di transizione Trans_Acc_Fren):
    when Fermata.active then
      i = pre(i) + 1;
      vel = if Stot[i] >= s then true else false;
    end when;

    connect(Accelerazione.outPort[1], Trans_Acc_Fren.inPort) annotation (Line(
        points={{-59.5,70},{-44,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Fermata.outPort[1], Trans_Ferm_Acc.inPort) annotation (Line(
        points={{60.5,70},{76,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Trans_Ferm_Acc.outPort, Accelerazione.inPort[1]) annotation (Line(
        points={{81.5,70},{96,70},{96,94},{-92,94},{-92,70},{-81,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(f, f) annotation (Line(
        points={{110,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Trans_Acc_Fren.outPort, Frenatura.inPort[1]) annotation (Line(
        points={{-38.5,70},{-21,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Frenatura.outPort[1], Trans_Fren_Ferm.inPort) annotation (Line(
        points={{0.5,70},{16,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(Trans_Fren_Ferm.outPort, Fermata.inPort[1]) annotation (Line(
        points={{21.5,70},{39,70}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(s, Mag_Ug.u1) annotation (Line(
        points={{-120,40},{-68,40},{-68,11},{-61,11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Min_Ug.u1, Mag_Ug.u1) annotation (Line(
        points={{-59,-11},{-68,-11},{-68,11},{-61,11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Mag_Ug.u2, Ascissa_Frenatura.y) annotation (Line(
        points={{-61,7},{-83,7},{-83,-6.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Min_Ug.u2, Ascissa_Frenatura.y) annotation (Line(
        points={{-59,-15},{-74,-15},{-74,-2},{-83,-2},{-83,-6.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Switch.y, Trans_Acc_Fren.condition) annotation (Line(
        points={{-40,50.6},{-40,58}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Switch.u2, Cond_Frenatura.y) annotation (Line(
        points={{-40,36.8},{-40,28.5}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Mag_Ug.y, Switch.u1) annotation (Line(
        points={{-49.5,11},{-46.4,11},{-46.4,36.8}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Min_Ug.y, Switch.u3) annotation (Line(
        points={{-47.5,-11},{-33.6,-11},{-33.6,36.8}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Condiz_Fermata.y, Switch1.u2) annotation (Line(
        points={{-17.1,-54},{-5,-54}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Switch1.u1, lessEqualThreshold.y) annotation (Line(
        points={{-5,-49.2},{-12,-49.2},{-12,-39},{-47.5,-39}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Switch1.u3, greaterEqualThreshold.y) annotation (Line(
        points={{-5,-58.8},{-12,-58.8},{-12,-65},{-47.5,-65}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Switch1.y, Trans_Fren_Ferm.condition) annotation (Line(
        points={{6.5,-54},{20,-54},{20,58}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(lessEqualThreshold.u, v) annotation (Line(
        points={{-59,-39},{-82.5,-39},{-82.5,-40},{-120,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(greaterEqualThreshold.u, v) annotation (Line(
        points={{-59,-65},{-82,-65},{-82,-40},{-120,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Fermata.active, Trans_Ferm_Acc.condition) annotation (Line(
        points={{50,59},{50,44},{80,44},{80,58}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Line(
            points={{88,0},{100,0},{100,-2}},
            color={0,0,0},
            smooth=Smooth.None),
          Rectangle(extent={{88,6},{52,-6}}, lineColor={0,0,0}),
          Text(
            extent={{54,6},{88,-6}},
            lineColor={0,0,0},
            textString="Codice Interno")}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
          Text(
            extent={{-60,-52},{56,-102}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="A-F"),
          Text(
            extent={{-188,84},{-126,70}},
            lineColor={0,0,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid,
            textString="Pos."),
          Text(
            extent={{-182,-70},{-128,-86}},
            lineColor={0,0,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid,
            textString="Vel."),
          Text(
            extent={{94,36},{134,10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="F"),
          Polygon(
            points={{-28,-20},{-48,-48},{-22,-48},{10,-48},{-28,-20}},
            smooth=Smooth.None,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-38,80},{-68,-12},{-36,-12},{-36,-12},{-38,80}},
            smooth=Smooth.Bezier,
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-74,4},{-20,-50},{4,-10},{-6,-10},{-74,4}},
            smooth=Smooth.Bezier,
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-28,74},{-46,-8},{-4,-6},{0,4},{2,10},{-28,74}},
            smooth=Smooth.Bezier,
            fillColor={0,171,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{-38,80},{-8,52}},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            startAngle=0,
            endAngle=360,
            pattern=LinePattern.None),
          Ellipse(
            extent={{-16,70},{-14,72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-14,60},{-20,60},{-20,58},{-14,60}},
            smooth=Smooth.Bezier,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Polygon(
            points={{-46,76},{-24,92},{-10,78},{-4,78},{-2,78},{-46,76}},
            smooth=Smooth.Bezier,
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{44,-54},{12,0},{2,-4},{-6,-10},{44,-54}},
            smooth=Smooth.Bezier,
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{24,-4},{-38,12},{-42,-4},{-30,-18},{24,-4}},
            smooth=Smooth.Bezier,
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{36,-30},{30,-44},{42,-38},{46,-32},{44,-28},{36,-30}},
            lineColor={0,0,0},
            smooth=Smooth.Bezier,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{68,-50},{66,36}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            radius=20),
          Line(
            points={{42,26},{20,40},{20,40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{14,30},{28,50},{28,50}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None),
          Polygon(
            points={{22,44},{26,48},{22,42},{28,46},{24,42},{28,44},{24,40},{20,
                42},{28,40},{20,40},{20,42},{22,44},{22,44},{20,42},{20,42},{20,
                42},{22,48},{22,46},{22,44}},
            smooth=Smooth.Bezier,
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Polygon(
            points={{-24,40},{22,46},{20,38},{-22,24},{-26,24},{-30,34},{-24,40}},

            smooth=Smooth.Bezier,
            fillColor={0,171,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{66,34},{42,34},{30,14},{66,-50},{66,-50},{66,34}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{50,-28},{48,-50}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            radius=30),
          Polygon(
            points={{-10,70},{-4,68},{-10,66},{-10,66},{-10,70}},
            smooth=Smooth.Bezier,
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Rectangle(
            extent={{-70,-50},{68,-48}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            radius=20)}),
      experiment(StopTime=500, __Dymola_NumberOfIntervals=2000),
      __Dymola_experimentSetupOutput);
  end DriverAB_Mod;






  model Sottostazione_SSE "Modello della Sottostazione Elettrica (SSE)"

    Modelica.Electrical.Analog.Basic.Resistor Res_Fittizia(R=R_Fitt)
      "Resistenza fittizia che tiene conto dell'abbassamento del valore medio di tensione a causa delle induttanze a monte [Ohm]"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-44})));
    Modelica.Electrical.Analog.Ideal.IdealDiode D_SSE
      "Diodo per garantire la non inversione della corrente" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-74})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage Vn_SSE(V=V_Nom)
      "Tensione nominale della SSE [V]" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,-16})));
    parameter Real V_Nom=750
      "Tensione Nominale della Sottostazione Elettrica [V]";
    parameter Real R_Fitt=0.01267
      "Resistenza fittizia che modellizza l'abbassamento del valore medio di tensione a causa delle induttanze a monte [Ohm]";
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
      annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  equation
    connect(D_SSE.p, Res_Fittizia.n) annotation (Line(
        points={{40,-64},{40,-54}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Res_Fittizia.p, Vn_SSE.p) annotation (Line(
        points={{40,-34},{40,-26}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Vn_SSE.n, pin_n) annotation (Line(
        points={{40,-6},{40,0},{100,0},{100,-100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(D_SSE.n, pin_p) annotation (Line(
        points={{40,-84},{-20,-84},{-20,-100}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-60,-100},{140,100}},
            preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent
            ={{-60,-100},{140,100}},preserveAspectRatio=false), graphics={
          Rectangle(extent={{-60,100},{140,-100}}, lineColor={0,0,0}),
          Rectangle(extent={{-14,38},{88,-62}}, lineColor={0,0,0}),
          Line(
            points={{40,16},{12,-42},{68,-42},{40,16},{40,16}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{40,16},{40,22},{40,24}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{40,-42},{40,-48},{40,-50}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,48},{0,38},{0,38}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{20,-62},{20,-80},{-20,-80},{-20,-92},{-20,-92}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{60,-62},{60,-80},{100,-80},{100,-90},{102,-96},{102,-96}},

            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(extent={{-4,56},{4,48}}, lineColor={0,0,0}),
          Line(
            points={{40,48},{40,38},{40,38}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(extent={{36,56},{44,48}}, lineColor={0,0,0}),
          Line(
            points={{80,48},{80,38},{80,38}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(extent={{76,56},{84,48}}, lineColor={0,0,0}),
          Text(
            extent={{-52,106},{134,56}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Line(
            points={{16,16},{62,16},{64,16}},
            color={0,0,0},
            smooth=Smooth.None),
          Ellipse(
            extent={{-44,-78},{-38,-84}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Sottostazione_SSE;

  model Convoglio "Modello del convoglio tramviario"

    Modelica.Mechanics.Translational.Components.Mass mass(m=vMass)
      annotation (Placement(transformation(extent={{-2,-16},{18,4}})));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP2
      "Misuratore della Potenza resistente" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={60,-6})));
    VhDragForce dragF(
      m=vMass,
      Cx=0.65,
      rho=1.226,
      S=6.0,
      fc=0.013) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={82,-16})));
    Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={28,32})));
    Modelica.Mechanics.Translational.Sources.Force Force annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,-6})));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP1
      "Misuratore della potenza trasmessa/erogata al/dal treno" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-20,-6})));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={28,-36})));
    Modelica.Electrical.Analog.Sensors.PotentialSensor Vmis annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=270,
          origin={-45,43})));
    Sfioratore_di_Tensione sfioratore_di_Tensione
      annotation (Placement(transformation(extent={{-56,6},{-36,28}})));
    DCLConstP dCLConstP(k=100, T=0.01)
      annotation (Placement(transformation(extent={{-10,18},{12,42}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
        Placement(transformation(extent={{94,0},{114,20}}), iconTransformation(
            extent={{94,-6},{114,14}})));
    Modelica.Blocks.Interfaces.RealInput Forza
      "Forza di trazione \"regolata\" dal Driver"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput Posizione
      "Posizione del convoglio [m]" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,60})));
    Modelica.Blocks.Interfaces.RealOutput Velocita
      "Velocità del convoglio [m/s]" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,-62})));
    parameter Real vMass=60000 "Massa del convoglio tramviario [Kg]";

  equation
    connect(mP2.flange_a, mass.flange_b) annotation (Line(
        points={{50,-6},{18,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(dragF.flange, mP2.flange_b) annotation (Line(
        points={{82,-6},{70,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(mP1.flange_b, mass.flange_a) annotation (Line(
        points={{-10,-6},{-2,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(speedSensor.flange, mass.flange_b) annotation (Line(
        points={{28,-46},{28,-6},{18,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(Vmis.phi, sfioratore_di_Tensione.Tensione) annotation (Line(
        points={{-45,33.1},{-45,28},{-45.2,28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sfioratore_di_Tensione.Potenza, mP1.power) annotation (Line(
        points={{-45.2,6},{-45.2,0},{-28,0},{-28,-17}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(dCLConstP.Pref, sfioratore_di_Tensione.y) annotation (Line(
        points={{-9.34,30},{-16,30},{-16,17},{-35,17}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Force.flange, mP1.flange_a) annotation (Line(
        points={{-60,-6},{-30,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(dCLConstP.pin_p, pin_p) annotation (Line(
        points={{-0.1,41.04},{-0.1,73.52},{0,73.52},{0,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Vmis.p, dCLConstP.pin_p) annotation (Line(
        points={{-45,52},{-0.1,52},{-0.1,41.04}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(dCLConstP.pin_n, pin_n) annotation (Line(
        points={{-0.1,19.2},{-0.1,10},{90,10},{90,10},{104,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Forza, Force.f) annotation (Line(
        points={{-120,0},{-92,0},{-92,-6},{-82,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(positionSensor.flange, mass.flange_b) annotation (Line(
        points={{28,42},{28,-6},{18,-6}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(positionSensor.s, Posizione) annotation (Line(
        points={{28,21},{28,60},{-110,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(speedSensor.v, Velocita) annotation (Line(
        points={{28,-25},{28,-62},{-110,-62}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Text(
            extent={{-152,-74},{-100,-94}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="Vel."),
          Text(
            extent={{-132,-16},{-104,-40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="F"),
          Polygon(
            points={{30,70},{106,28},{34,24},{30,34},{30,70}},
            smooth=Smooth.Bezier,
            fillPattern=FillPattern.Solid,
            fillColor={0,158,0},
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Rectangle(
            extent={{-82,60},{38,26}},
            fillPattern=FillPattern.Solid,
            fillColor={0,158,0},
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Polygon(
            points={{-80,60},{-78,26},{-86,28},{-86,56},{-82,60},{-80,60}},
            smooth=Smooth.Bezier,
            fillColor={0,158,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{-74,28},{-58,14}},
            lineColor={0,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,28},{-4,14}},
            lineColor={0,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{36,28},{52,14}},
            lineColor={0,0,0},
            fillColor={127,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-76,36},{42,34}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-72,54},{-62,48}},
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-48,54},{-38,48}},
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-24,54},{-14,48}},
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{0,54},{10,48}},
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{24,54},{34,48}},
            lineColor={0,0,0},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{88,32},{94,32},{94,32}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{94,32},{94,36},{94,28},{94,28}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-88,14},{76,14},{78,14}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{20,60},{0,80},{0,94},{0,94}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{78,14},{78,4},{94,4},{94,4}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-66,-20},{56,-72}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="Tram"),
          Text(
            extent={{-156,90},{-92,70}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="Pos."),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0})}));
  end Convoglio;





  model Rete_di_Alimentazione_Mono
    "Modello della rete di alimentazione DC - ALIM. BILATERA E MONOLATERA"

    Modelica.Blocks.Interfaces.RealInput Posizione
      "Posizione del treno durante la marcia [m]" annotation (Placement(
          transformation(extent={{-280,-20},{-240,20}}), iconTransformation(
            extent={{-240,-10},{-200,30}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
      annotation (Placement(transformation(extent={{130,-90},{150,-70}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin
      annotation (Placement(transformation(extent={{-170,90},{-150,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin1
      annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin2
      annotation (Placement(transformation(extent={{70,90},{90,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin3
      annotation (Placement(transformation(extent={{190,90},{210,110}})));
    parameter Real Posizione_SSE[6]={580,1744,3141,4488,5555,7521}
      "Posizione assoluta delle SSE lungo l'intera tratta del convoglio ferroviario [m]";

    Real R_spec[5] "Resistenza specifica della linea di alimentazione [Ohm/m]";

    Real R_SSE[5, 6]
      "Matrice di gestione delle resistenze destra e sinistra tra le varie sottostazioni [Ohm]";
    Real R_Comm[6]
      "Vettore delle resistenze \"fittizie\" di commutazione tra le sottostazioni [Ohm] NOTA: L'INDICE 6 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";
    parameter Real Val_R_Comm_Non_Att=10000000
      "Valore delle Resistenze di Commutazione non attive [Ohm] (VALORE ALTO)";
    parameter Real Val_R_Comm_Att=0.0001
      "Valore della Resistenza di Commutazione attiva [Ohm] (VALORE BASSO)";
    Real alfa[6]
      "Variabile utilizzata per il calcolo della resistenza destra e sinistra tra le due sottostazioni attuali [Rxy_s=Rtot*alfa e Rxy_d=Rtot*(1-alfa)] NOTA: L'INDICE 6 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";
    Real Ltot[6]
      "Distanza totale tra le coppie di SSE contigue (es.SS1-SSE2 SS2-SSE3 etc...) [m] NOTA: L'INDICE 6 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";
    Real Rtot[6]
      "Resistenza totale tra le coppie di SSE contigue (es.SS1-SSE2 SS2-SSE3 etc...)[Ohm]. NOTA: L'INDICE 6 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";

    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
      annotation (Placement(transformation(extent={{-142,30},{-122,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=R_SSE[1, 1])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-132,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor1
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=R_SSE[1, 2])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor2
      annotation (Placement(transformation(extent={{-20,30},{0,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=R_SSE[2, 2])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor3
      annotation (Placement(transformation(extent={{40,30},{60,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=R_SSE[2, 3])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor4
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=R_SSE[3, 3])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={110,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor5
      annotation (Placement(transformation(extent={{158,30},{178,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=R_SSE[3, 4])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={168,70})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=R_Comm[1])
      annotation (Placement(transformation(
          extent={{-20,-12},{20,12}},
          rotation=180,
          origin={-60,-1.77636e-015})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor6
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-100,0})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor7
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,0})));
    Modelica.Blocks.Sources.RealExpression realExpression7(y=R_Comm[2])
      annotation (Placement(transformation(
          extent={{-21,-12},{21,12}},
          rotation=180,
          origin={61,-1.77636e-015})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor8
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={140,0})));
    Modelica.Blocks.Sources.RealExpression realExpression8(y=R_Comm[3])
      annotation (Placement(transformation(
          extent={{-21,-12},{21,12}},
          rotation=180,
          origin={181,-1.77636e-015})));
    Real R[5, 6]
      "Matrice che da i valori delle resistenze destra e sinistra delle SSE attualmente attive (nel caso la velocità sia positiva o negativa) [Ohm]";
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-100,-32})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_2 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-32})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_3 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={140,-32})));
    Modelica.Electrical.Analog.Interfaces.Pin pin4
      annotation (Placement(transformation(extent={{310,90},{330,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin5
      annotation (Placement(transformation(extent={{430,90},{450,110}})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor9
      annotation (Placement(transformation(extent={{220,30},{240,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression9(y=R_SSE[4, 4])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={230,72})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor10
      annotation (Placement(transformation(extent={{280,30},{300,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression10(y=R_SSE[4, 5])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={290,72})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor11
      annotation (Placement(transformation(extent={{340,30},{360,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression11(y=R_SSE[5, 5])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={350,72})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor12
      annotation (Placement(transformation(extent={{400,30},{420,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression12(y=R_SSE[5, 6])
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={410,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor13
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={260,0})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_4 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={260,-32})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor14
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={380,0})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_5 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={380,-32})));
    Modelica.Blocks.Sources.RealExpression realExpression13(y=R_Comm[4])
      annotation (Placement(transformation(
          extent={{-20,-12},{20,12}},
          rotation=180,
          origin={300,0})));
    Modelica.Blocks.Sources.RealExpression realExpression14(y=R_Comm[5])
      annotation (Placement(transformation(
          extent={{-20,-12},{20,12}},
          rotation=180,
          origin={420,0})));

    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor15
      annotation (Placement(transformation(extent={{-200,30},{-180,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression15(y=R_SSE_sx)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-190,70})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor16
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-220,0})));
    Modelica.Blocks.Sources.RealExpression realExpression16(y=R_Comm[6])
      annotation (Placement(transformation(
          extent={{-20,-12},{20,12}},
          rotation=180,
          origin={-180,0})));
    Modelica.Electrical.Analog.Sensors.CurrentSensor Amp_R_Comm_6 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-220,-32})));

    Real R_SSE_sx
      "Resistenza longitudinale sinistra per alimentazione monolatera sinistra";

  equation
    //NOTA:GESTIONE DI TUTTE LE RESISTENZE LONGITUDINALI E TRASVERSALI TRANNE QUELLE ESTREME ATTIVE SOLO PER ALIMENTAZIONE MONOLATERA:
    for i in 1:5 loop
      //Calcolo della distanza totale tra le due SSE (Ltot) contigue necessaria per calcolare la resistenza totale (Rtot) tra le due SSE
      Ltot[i] = Posizione_SSE[i + 1] - Posizione_SSE[i];
      //Calcolo della resistenza totale tra due SSE contigue (Rtot):
      Rtot[i] = R_spec[i]*Ltot[i];
      //Impostazione dei coefficienti della matrice di gestione delle resistenze longitudinali tra le sottostazioni (SSE):
      R_SSE[i, i] = if Posizione >= Posizione_SSE[i] and Posizione <=
        Posizione_SSE[i + 1] then R[i, i] else Rtot[i];
      R_SSE[i, i + 1] = if Posizione >= Posizione_SSE[i] and Posizione <=
        Posizione_SSE[i + 1] then R[i, i + 1] else 0;
      //logica di gestione della R di destra e della R di sinistra se il tratto tra le due sottostazioni è quello percorso attualmente:
      R[i, i] = if der(Posizione) >= 0 then (1 - alfa[i])*Rtot[i] else alfa[i]*
        Rtot[i];
      R[i, i + 1] = if der(Posizione) >= 0 then alfa[i]*Rtot[i] else (1 - alfa[
        i])*Rtot[i];
      //Gestione dell'alfa tra le varie sottostazioni e nel caso di velocità positive e negative:
      if Posizione >= Posizione_SSE[i] and Posizione <= Posizione_SSE[i + 1]
           then
        alfa[i] = if der(Posizione) >= 0 then (Posizione_SSE[i + 1] - Posizione)
          /Ltot[i] else (Posizione - Posizione_SSE[i])/Ltot[i];
      else
        alfa[i] = alfa[i];
      end if;

      //GESTIONE DELLA RESISTENZA SPECIFICA (da 0 a 1744 è 0.0000867 ohm/m e da 1744 in poi di 0.0001215):
      if i <= 2 then
        R_spec[i] = 0.0000867;
      else
        R_spec[i] = 0.0001215;
      end if;

      //GESTIONE DELLE RESISTENZE TRASVERSALI DI COMMUTAZIONE:
      if i <> 5 then
        R_Comm[i] = if (Posizione >= Posizione_SSE[i] and Posizione <
          Posizione_SSE[i + 1]) then Val_R_Comm_Att else Val_R_Comm_Non_Att;
      else
        R_Comm[i] = if Posizione >= Posizione_SSE[i] then Val_R_Comm_Att else
          Val_R_Comm_Non_Att;
      end if;
      //Qui sopra ho scritto un if per essere sicuro che se la posizione del convoglio va oltre la posizione dell'ultima SSE comunque ci sia la R_Comm[5] pressochè nulla perchè altrimenti sarebbero tutte a valore altissimo.
    end for;

    //NOTA: GESTIONE DELLE RESISTENZE ESTREME PER ALIMENTAZIONE MONOLATERA:

    //GESTIONE RESISTENZE PARTE SINISTRA (indice 6):
    Ltot[6] = Posizione_SSE[1] - 0;
    Rtot[6] = R_spec[1]*Ltot[6];
    R_SSE_sx = if Posizione <= Posizione_SSE[1] and Posizione >= 0 then (alfa[6])
      *Rtot[6] else Rtot[6];
    alfa[6] = (Posizione_SSE[1] - Posizione)/Ltot[6];
    R_Comm[6] = if Posizione <= Posizione_SSE[1] then Val_R_Comm_Att else
      Val_R_Comm_Non_Att;
    //IMPORTANTE: Sopra IMPLICITAMENTE ho imposto anche che se Posizione diventa minore di zero (fine simulazione) è sempre attiva la R_Comm_[6] (sennò le R_Comm sarebbero tutte attive a valore altissimo).

    //Riempimento con zeri della matrice delle Resistenze longitudinali delle SSE [R_SSE] negli elementi non utilizzati (e anche della matrice R):
    R_SSE[1, 3] = 0;
    R_SSE[1, 4] = 0;
    R_SSE[1, 5] = 0;
    R_SSE[1, 6] = 0;
    R_SSE[2, 1] = 0;
    R_SSE[2, 4] = 0;
    R_SSE[2, 5] = 0;
    R_SSE[2, 6] = 0;
    R_SSE[3, 1] = 0;
    R_SSE[3, 2] = 0;
    R_SSE[3, 5] = 0;
    R_SSE[3, 6] = 0;
    R_SSE[4, 1] = 0;
    R_SSE[4, 2] = 0;
    R_SSE[4, 3] = 0;
    R_SSE[4, 6] = 0;
    R_SSE[5, 1] = 0;
    R_SSE[5, 2] = 0;
    R_SSE[5, 3] = 0;
    R_SSE[5, 4] = 0;
    R[1, 3] = 0;
    R[1, 4] = 0;
    R[1, 5] = 0;
    R[1, 6] = 0;
    R[2, 1] = 0;
    R[2, 4] = 0;
    R[2, 5] = 0;
    R[2, 6] = 0;
    R[3, 1] = 0;
    R[3, 2] = 0;
    R[3, 5] = 0;
    R[3, 6] = 0;
    R[4, 1] = 0;
    R[4, 2] = 0;
    R[4, 3] = 0;
    R[4, 6] = 0;
    R[5, 1] = 0;
    R[5, 2] = 0;
    R[5, 3] = 0;
    R[5, 4] = 0;

    connect(variableResistor.p, pin) annotation (Line(
        points={{-142,40},{-160,40},{-160,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression.y, variableResistor.R) annotation (Line(
        points={{-132,59},{-132,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(variableResistor1.p, variableResistor.n) annotation (Line(
        points={{-80,40},{-122,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression1.y, variableResistor1.R) annotation (Line(
        points={{-70,59},{-70,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(variableResistor5.n, pin3) annotation (Line(
        points={{178,40},{200,40},{200,100}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor5.p, variableResistor4.n) annotation (Line(
        points={{158,40},{120,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor4.p, variableResistor3.n) annotation (Line(
        points={{100,40},{60,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor3.p, variableResistor2.n) annotation (Line(
        points={{40,40},{0,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor2.p, variableResistor1.n) annotation (Line(
        points={{-20,40},{-60,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression2.y, variableResistor2.R) annotation (Line(
        points={{-10,59},{-10,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression3.y, variableResistor3.R) annotation (Line(
        points={{50,59},{50,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression4.y, variableResistor4.R) annotation (Line(
        points={{110,59},{110,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression5.y, variableResistor5.R) annotation (Line(
        points={{168,59},{168,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pin1, variableResistor1.n) annotation (Line(
        points={{-40,100},{-40,40},{-60,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(pin2, variableResistor3.n) annotation (Line(
        points={{80,100},{80,40},{60,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor6.p, variableResistor1.p) annotation (Line(
        points={{-100,10},{-100,40},{-80,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression7.y, variableResistor7.R) annotation (Line(
        points={{37.9,9.99201e-016},{37.9,1},{36,0},{36,-2.22045e-015},{31,-2.22045e-015}},

        color={0,0,127},
        smooth=Smooth.None));
    connect(variableResistor7.p, variableResistor3.p) annotation (Line(
        points={{20,10},{20,40},{40,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression6.y, variableResistor6.R) annotation (Line(
        points={{-82,8.88178e-016},{-84,8.88178e-016},{-84,-2.22045e-015},{-89,
            -2.22045e-015}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(variableResistor8.p, variableResistor4.n) annotation (Line(
        points={{140,10},{140,40},{120,40}},
        color={0,0,255},
        smooth=Smooth.None));

    connect(variableResistor8.n, Amp_R_Comm_3.p) annotation (Line(
        points={{140,-10},{140,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor7.n, Amp_R_Comm_2.p) annotation (Line(
        points={{20,-10},{20,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor6.n, Amp_R_Comm_1.p) annotation (Line(
        points={{-100,-10},{-100,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Amp_R_Comm_1.n, pin_p) annotation (Line(
        points={{-100,-42},{-100,-60},{140,-60},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Amp_R_Comm_2.n, pin_p) annotation (Line(
        points={{20,-42},{20,-60},{140,-60},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Amp_R_Comm_3.n, pin_p) annotation (Line(
        points={{140,-42},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor8.R, realExpression8.y) annotation (Line(
        points={{151,-2.22045e-015},{154,-2.22045e-015},{154,1.11022e-015},{
            157.9,1.11022e-015}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(variableResistor9.p, variableResistor5.n) annotation (Line(
        points={{220,40},{178,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor10.p, variableResistor9.n) annotation (Line(
        points={{280,40},{240,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor11.p, variableResistor10.n) annotation (Line(
        points={{340,40},{300,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor12.p, variableResistor11.n) annotation (Line(
        points={{400,40},{360,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(pin5, variableResistor12.n) annotation (Line(
        points={{440,100},{440,40},{420,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor13.R, realExpression13.y) annotation (Line(
        points={{271,0},{274,0},{274,2.66454e-015},{278,2.66454e-015}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression14.y, variableResistor14.R) annotation (Line(
        points={{398,2.66454e-015},{396,2.66454e-015},{396,-1.9984e-015},{391,-1.9984e-015}},

        color={0,0,127},
        smooth=Smooth.None));

    connect(variableResistor13.p, variableResistor9.n) annotation (Line(
        points={{260,10},{260,40},{240,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression9.y, variableResistor9.R) annotation (Line(
        points={{230,61},{230,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression10.y, variableResistor10.R) annotation (Line(
        points={{290,61},{290,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression11.y, variableResistor11.R) annotation (Line(
        points={{350,61},{350,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression12.y, variableResistor12.R) annotation (Line(
        points={{410,59},{410,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Amp_R_Comm_4.n, pin_p) annotation (Line(
        points={{260,-42},{260,-60},{140,-60},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Amp_R_Comm_5.n, pin_p) annotation (Line(
        points={{380,-42},{380,-60},{140,-60},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor14.n, Amp_R_Comm_5.p) annotation (Line(
        points={{380,-10},{380,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor14.p, variableResistor11.n) annotation (Line(
        points={{380,10},{380,40},{360,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor13.n, Amp_R_Comm_4.p) annotation (Line(
        points={{260,-10},{260,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(pin4, variableResistor10.n) annotation (Line(
        points={{320,100},{320,40},{300,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor15.n, variableResistor.p) annotation (Line(
        points={{-180,40},{-142,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression15.y, variableResistor15.R) annotation (Line(
        points={{-190,59},{-190,51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(variableResistor15.p, variableResistor16.p) annotation (Line(
        points={{-200,40},{-220,40},{-220,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(variableResistor16.n, Amp_R_Comm_6.p) annotation (Line(
        points={{-220,-10},{-220,-22}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Amp_R_Comm_6.n, pin_p) annotation (Line(
        points={{-220,-42},{-220,-60},{140,-60},{140,-80}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(realExpression16.y, variableResistor16.R) annotation (Line(
        points={{-202,0},{-209,0}},
        color={0,0,127},
        smooth=Smooth.None));

    annotation (Diagram(coordinateSystem(extent={{-240,-80},{480,100}},
            preserveAspectRatio=false), graphics), Icon(coordinateSystem(extent
            ={{-240,-80},{480,100}}, preserveAspectRatio=false), graphics={
          Rectangle(extent={{-200,100},{480,-80}}, lineColor={0,0,0}),
          Text(
            extent={{-274,50},{-174,32}},
            lineColor={0,0,0},
            textString="Pos."),
          Line(
            points={{-160,90},{-160,60},{-140,60},{-140,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(extent={{-140,66},{-120,56}}, lineColor={215,215,215}),
          Rectangle(extent={{-80,64},{-60,54}}, lineColor={215,215,215}),
          Line(
            points={{-40,92},{-40,60},{-60,60},{-60,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{-120,62},{-120,64}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{-120,60},{-80,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{-100,60},{-100,40},{-100,30},{-100,30}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(
            extent={{-10,5},{10,-5}},
            lineColor={215,215,215},
            origin={-100,21},
            rotation=90),
          Line(
            points={{-100,10},{-100,-12},{-100,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{-40,90},{-40,60},{-20,60},{-20,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(extent={{-20,66},{0,56}}, lineColor={215,215,215}),
          Rectangle(extent={{40,64},{60,54}}, lineColor={215,215,215}),
          Line(
            points={{80,92},{80,60},{60,60},{60,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{0,62},{0,64}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{0,60},{40,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{20,60},{20,40},{20,30},{20,30}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(
            extent={{-10,5},{10,-5}},
            lineColor={215,215,215},
            origin={20,21},
            rotation=90),
          Line(
            points={{20,10},{20,-12},{20,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{80,90},{80,60},{100,60},{100,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(extent={{100,66},{120,56}}, lineColor={215,215,215}),
          Rectangle(extent={{160,64},{180,54}}, lineColor={215,215,215}),
          Line(
            points={{200,92},{200,60},{180,60},{180,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{120,62},{120,64}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{120,60},{160,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{140,60},{140,40},{140,30},{140,30}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(
            extent={{-10,5},{10,-5}},
            lineColor={215,215,215},
            origin={140,21},
            rotation=90),
          Line(
            points={{140,10},{140,-12},{140,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{200,90},{200,60},{220,60},{220,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(extent={{220,66},{240,56}}, lineColor={215,215,215}),
          Rectangle(extent={{280,64},{300,54}}, lineColor={215,215,215}),
          Line(
            points={{320,92},{320,60},{300,60},{300,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{240,62},{240,64}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{240,60},{280,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{260,60},{260,40},{260,30},{260,30}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(
            extent={{-10,5},{10,-5}},
            lineColor={215,215,215},
            origin={260,21},
            rotation=90),
          Line(
            points={{260,10},{260,-12},{260,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{320,90},{320,60},{340,60},{340,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(extent={{340,66},{360,56}}, lineColor={215,215,215}),
          Rectangle(extent={{400,64},{420,54}}, lineColor={215,215,215}),
          Line(
            points={{440,92},{440,60},{420,60},{420,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{360,62},{360,64}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{360,60},{400,60}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{380,60},{380,40},{380,30},{380,30}},
            color={215,215,215},
            smooth=Smooth.None),
          Rectangle(
            extent={{-10,5},{10,-5}},
            lineColor={215,215,215},
            origin={380,21},
            rotation=90),
          Line(
            points={{380,10},{380,-12},{380,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{-100,-20},{380,-20},{380,-20}},
            color={215,215,215},
            smooth=Smooth.None),
          Line(
            points={{140,-20},{140,-96},{140,-96}},
            color={215,215,215},
            smooth=Smooth.None),
          Text(
            extent={{-154,164},{438,-154}},
            lineColor={0,0,0},
            textString="Rete di Alimentazione DC")}));
  end Rete_di_Alimentazione_Mono;

  model ExaAB_Blocchi_Mono
    "Esempio con blocchi A-F e alimentazione bilatera e monolatera"
    //   import SimpleDriver;
    import Modelica.Constants.pi;
    parameter Modelica.SIunits.Mass vMass=60000 "Vehicle mass";

    DriverAB_Mod Pilota_A_F
      annotation (Placement(transformation(extent={{-86,-42},{-56,-12}})));

    Convoglio convoglio
      annotation (Placement(transformation(extent={{-26,-48},{16,-6}})));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
          transformation(
          extent={{-9,-9},{9,9}},
          rotation=0,
          origin={35,-35})));
    Sottostazione_SSE SSE1
      annotation (Placement(transformation(extent={{-176,94},{-150,120}})));
    Sottostazione_SSE SSE2
      annotation (Placement(transformation(extent={{-116,94},{-90,120}})));
    Sottostazione_SSE SSE3
      annotation (Placement(transformation(extent={{-56,94},{-30,120}})));
    Sottostazione_SSE SSE4
      annotation (Placement(transformation(extent={{4,94},{30,120}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-166,70},{-146,90}})));
    Modelica.Electrical.Analog.Basic.Ground ground1
      annotation (Placement(transformation(extent={{-106,70},{-86,90}})));
    Modelica.Electrical.Analog.Basic.Ground ground3
      annotation (Placement(transformation(extent={{-46,70},{-26,90}})));
    Modelica.Electrical.Analog.Basic.Ground ground4
      annotation (Placement(transformation(extent={{14,70},{34,90}})));
    Sottostazione_SSE SSE5
      annotation (Placement(transformation(extent={{64,94},{90,120}})));
    Sottostazione_SSE SSE6
      annotation (Placement(transformation(extent={{124,94},{150,120}})));
    Modelica.Electrical.Analog.Basic.Ground ground5
      annotation (Placement(transformation(extent={{74,70},{94,90}})));
    Modelica.Electrical.Analog.Basic.Ground ground6
      annotation (Placement(transformation(extent={{134,70},{154,90}})));
    Rete_di_Alimentazione_Mono rete_di_Alimentazione
      annotation (Placement(transformation(extent={{-92,20},{74,40}})));
  equation
    connect(ground.p, SSE1.pin_n) annotation (Line(
        points={{-156,90},{-155.2,90},{-155.2,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground1.p, SSE2.pin_n) annotation (Line(
        points={{-96,90},{-95.2,90},{-95.2,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground3.p, SSE3.pin_n) annotation (Line(
        points={{-36,90},{-35.2,90},{-35.2,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground4.p, SSE4.pin_n) annotation (Line(
        points={{24,90},{24.8,90},{24.8,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(convoglio.pin_n, ground2.p) annotation (Line(
        points={{16.84,-26.16},{34.42,-26.16},{34.42,-26},{35,-26}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(convoglio.Posizione, Pilota_A_F.s) annotation (Line(
        points={{-28.1,-14.4},{-42,-14.4},{-42,-6},{-106,-6},{-106,-21},{-89,-21}},

        color={0,0,127},
        smooth=Smooth.None));
    connect(convoglio.Velocita, Pilota_A_F.v) annotation (Line(
        points={{-28.1,-40.02},{-44,-40.02},{-44,-48},{-106,-48},{-106,-33},{-89,
            -33}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SSE5.pin_n, ground5.p) annotation (Line(
        points={{84.8,94},{84.8,91},{84,91},{84,90}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(SSE6.pin_n, ground6.p) annotation (Line(
        points={{144.8,94},{144,94},{144,90}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(rete_di_Alimentazione.pin, SSE1.pin_p) annotation (Line(
        points={{-73.5556,40},{-74,40},{-74,56},{-170.8,56},{-170.8,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(rete_di_Alimentazione.pin1, SSE2.pin_p) annotation (Line(
        points={{-45.8889,40},{-46,40},{-46,60},{-110.8,60},{-110.8,94}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(SSE3.pin_p, rete_di_Alimentazione.pin2) annotation (Line(
        points={{-50.8,94},{-52,94},{-52,64},{-18.2222,64},{-18.2222,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(SSE5.pin_p, rete_di_Alimentazione.pin4) annotation (Line(
        points={{69.2,94},{69.2,60},{37.1111,60},{37.1111,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(SSE6.pin_p, rete_di_Alimentazione.pin5) annotation (Line(
        points={{129.2,94},{130,94},{130,56},{64.7778,56},{64.7778,40}},
        color={0,0,255},
        smooth=Smooth.None));

    connect(SSE4.pin_p, rete_di_Alimentazione.pin3) annotation (Line(
        points={{9.2,94},{9.44444,94},{9.44444,40}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(rete_di_Alimentazione.Posizione, Pilota_A_F.s) annotation (Line(
        points={{-87.3889,30},{-106,30},{-106,-21},{-89,-21}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Pilota_A_F.f, convoglio.Forza) annotation (Line(
        points={{-54.5,-27},{-30.2,-27}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(rete_di_Alimentazione.pin_p, convoglio.pin_p) annotation (Line(
        points={{-4.38889,20},{-4,20},{-4,-6},{-5,-6}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-160,-80},{
              180,140}}),graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-160,-80},{180,
              140}}),graphics={Ellipse(
            extent={{-102,100},{98,-100}},
            lineColor={95,95,95},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-34,62},{66,2},{-34,-58},{-34,62}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}),
      experiment(StopTime=2400, __Dymola_NumberOfIntervals=2000),
      experimentSetupOutput(derivatives=false),
      Documentation(info="<html>
<p>Il problema &egrave; che nomanca la frenata asservita allo spazio.</p>
<p>Il problema della fermata asservita allo spazio &egrave; che si ha un&apos;oscillazione di s con andata e ritorno che non &egrave; realistica.</p>
<p>Occorre fare un frenatore che quando la velocit&agrave; &egrave; moloto bassa abbandona la coppia e lascia cle la coppia resistente del veiocolo finla finisca.</p>
</html>"),
      Commands(file="Plot.mos" "plot"));
  end ExaAB_Blocchi_Mono;






  annotation (uses(Modelica(version="3.2")));
end simpleTrain;
