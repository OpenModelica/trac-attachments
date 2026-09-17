within ;
package AutoCreateBug






  model GridOneTrack
    "One track variable numbers of ESS's and trains, with inner grid (no commutator)"
    model SimpleVarResis "simple Variable resistor"
      /* La ridefinizione del resistore si rende necessaria per due ragioni:
                - consente di attribuire un valore direttamente a R dall'esterno senza
                 necessita' di un'equazione connect
                - consente di eliminare le equazioni relative alla gestione termica che non 
                 interessano
                */
      extends Modelica.Electrical.Analog.Interfaces.OnePort;
      Modelica.SIunits.Resistance R;
    equation
      v = R * i;
    end SimpleVarResis;

    Modelica.Blocks.Interfaces.RealInput trainPos[numOfTrains]
      "each train's position"   annotation(Placement(transformation(extent = {{-20, 20}, {20, -20}}, rotation = 0, origin = {-180, 0}), iconTransformation(extent = {{-15, -15}, {15, 15}}, origin = {-175, 1})));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug ep(m = numOfSect) annotation(Placement(transformation(extent = {{-10, 50}, {10, 70}}), iconTransformation(extent = {{-8, 52}, {8, 68}})));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug tp(m = numOfTrains) annotation(Placement(transformation(extent = {{-10, -50}, {10, -70}}), iconTransformation(extent = {{-8, -52}, {8, -68}})));
    constant Real resisSmall=1e-6, resisLarge=1e6;
    parameter Real iniSecPos[:] = {580, 1744, 3141}
      "Positions of section borders (typically ESS's abscissas)";
    parameter Real lineLength = 3500 "total length inclusind terminal trunks";
    final parameter Integer numOfSect = size(iniSecPos, 1)
      "Number of sections (typically number of ESS's)";
    parameter Modelica.SIunits.Resistivity resistivity[numOfSect + 1] = {0.000108, 0.000108, 0.00014, 0.00014}
      "resistivity of line trunks";
    //Il numero di resistenze da mmettere lungo la linea è pari al numero di
    // sezioni + 1 in quanto possono essere differenti le resistività delle due mezze
    // sezioni di estremità.
    /*Il numero di resistenze è pari a :
          2*(numOfSect-1) per i tratti fra le Ess: uno a SX  uno  DX del treno
          2               per i tratti a sbalzo, a SX della prima ESS e a DX dell'ultima
          */
    parameter Integer numOfTrains = 2 "number of trains";
    SimpleVarResis resisLeft[numOfSect] "Left section-side resistor", resisRight[numOfSect]
      "Right section-side resistor";
    /* Nota: resisRight[1] è la resistenza del primo tratto a sbalzo; resisLeft[1])
           è la resistenza di sinistra della prima sezione completa resisRight[2] è la 
           resistenza di destra della prima sezione completa. 
           Inoltre il pin positivo di tutti i resistori è messo a sinistra.
           In tal modo dentro la sezione resisLeft[i].n è connesso a resisRight[i+1].p, 
           e ai confini di sezione resisRight[i].n è connesso a resisLeft[i].p, 
           */
    SimpleVarResis resisConn[numOfTrains,numOfSect+1];
    Integer z[numOfTrains];
    Modelica.SIunits.Power lostPower;
    // Interfaccia della rete verso l'esterno: gli input con le posizioni dei treni
    // e i pin di connessione alle ESS e ai treni
    //Ora trovo la sezione z in cui si trova il treno:
  algorithm
    for train in 1:numOfTrains loop
      z[train] := 1;
      for sect in 1:numOfSect loop
        if trainPos[train] > iniSecPos[sect] then
          z[train] := z[train] + 1;
        end if;
      end for;
    end for;
  equation
    //Collegamenti delle resistenze di linea fra loro:
    for i in 1:numOfSect - 1 loop
      connect(resisRight[i].n, resisLeft[i].p);
      connect(resisLeft[i].n, resisRight[i + 1].p);
      connect(resisRight[i].n, ep.pin[i]);
    end for;
    connect(resisRight[numOfSect].n, resisLeft[numOfSect].p);
    connect(resisRight[numOfSect].n, ep.pin[numOfSect]);

    //Collegamenti dei treni alle sezioni di linea:
    for i in 1:numOfTrains loop
      for j in 1:numOfSect loop
        connect(resisConn[i,j].p,resisRight[j].p);
        connect(resisConn[i,j].n,tp.pin[i]);
      end for;
      connect(resisConn[i,numOfSect+1].p,resisLeft[numOfSect].n);
      connect(resisConn[i,numOfSect+1].n,tp.pin[i]);
    end for;

    //Scelgo i valori delle resistenze dei resistori di collegamento:
    for i in 1:numOfTrains loop
      for j in 1:numOfSect+1 loop
        if z[i]==j then
          resisConn[i,j].R = resisSmall;
        else
          resisConn[i,j].R = resisLarge;
        end if;
      end for;
    end for;
    /*Calcolo i valori delle resistenze. In questa versione preliminare divido equamente
   le resistenze di sezione fra i due lati left e right; poi aggiusto i valori
   della sola sezione in cui vi è il treno.
   La numerazione è conforme a quanto riportato nel file "Schema rete.docx".
  */
    for i in 1:numOfSect - 1 loop
      resisLeft[i].R = resistivity[i + 1] * (iniSecPos[i + 1] - iniSecPos[i]) / 2.0;
      if i == 1 then
        resisRight[1].R = resistivity[1] * iniSecPos[1];
      else
        resisRight[i].R = resisLeft[i - 1].R;
      end if;
    end for;
    resisLeft[numOfSect].R = resistivity[numOfSect + 1] * (lineLength - iniSecPos[numOfSect]);
    resisRight[numOfSect].R = resisLeft[numOfSect - 1].R;

    // #### Correzione delle resistenze per le sezioni z_k (da implementare
    //Potenza perduta:
  algorithm
    lostPower := 0;
    for i in 1:numOfSect loop
      lostPower := lostPower + resisLeft[i].v * resisLeft[i].i;
      lostPower := lostPower + resisRight[i].v * resisRight[i].i;
    end for;
    annotation(Documentation(info="<html>
<p>Modello di rete ad una linea per generazione di sistemi a semplice binario con numero variabile di treni e sottostazioni. </p>
<p>A sinistra della prima sottostazione e a destra dell&apos;ultima vi deve essere un tratto di linea, di lunghezza non nulla. La resistivit&agrave; della linea &egrave; la medesima per ogni tratta fra le ESS. </p>
<p>L&apos;intera linea viene divisa in <i>Sezioni</i>. Ogni sezione di linea &egrave; da due resistori in serie, un punto di contatto a SX, uno al centro, uno a DX. </p>
<p>Il treno &egrave; collegato al centro, i punti a SX e a DX alle estremit&agrave; di sezione. Quindi ogni sezione pu&ograve; contenere al pi&ugrave; un treno. </p>
<p>All&apos;interno d&apos;uso pi&ugrave; naturale di questa logica &egrave; di fare in modo che le sezioni coincidano con il tratto di linea fra due sottostazioni. Se per&ograve; le sottostazioni sono distanti e quindi vi possono essere due treni marcianti nel tratto fra due sottostazioni, fra di esse occorrer&agrave; mettere pi&ugrave; sezioni. </p>
<p>Essenso il caso standard costituito da confini di sezione i corrispondenza di sottostazioni, il &QUOT;numOfEss&QUOT; scritto come numero di dsottostazioni, &egrave; un realt&agrave; il numero di Sezioni. Qualora si volesse realizzare la rete con un numero di sezioni superiore al numero di sottostazioni reali, al corrispondente pin non si connetter&agrave; nulla. </p>
<p>Inoltre vi &egrave; una mezza sezione a sinistra della prima sottostazione e a destra dell&apos;ultima: in questi tratti l&apos;alimentazione sar&agrave; monolatera. </p>
<p>La tecnica con cui la rete &egrave; realizzata prevede la generazione all&apos;inizio della simulazione di tutte le sezioni con resistori a resistenza variabile con resistenza funzione della posizione del treno presente al centro di sezione (o, nel solo caso dei tratti a sbalzo all&apos;estremit&agrave; di sezione). </p>
<p>Il treno &egrave; connesso dinamicamente alle varie sezioni in funzione della sua posizione, attraverso ulteriori resistori che posso avere valori molto piccoli (1e-6) o molto grandi (1e6) rispettivamente per treno connesso o disconnesso.</p>
</html>"),   Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -60}, {160, 60}}), graphics), Icon(coordinateSystem(extent = {{-160, -60}, {160, 60}}, preserveAspectRatio = false), graphics={  Rectangle(extent = {{-160, 60}, {160, -60}}, lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
              fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{-158, 2}, {158, 2}}, color = {135, 135, 135}), Rectangle(lineColor = {135, 135, 135}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-116, 8}, {-96, -2}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-70, 8}, {-50, -2}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{50, 8}, {70, -2}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{98, 8}, {118, -2}}), Text(extent = {{-160, -12}, {158, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "%numOfTrains trains"), Text(extent = {{-160, -34}, {160, -44}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "ESS's in %iniSecPos"), Text(extent = {{-158, 42}, {158, 24}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, textString = "%name")}));
  end GridOneTrack;





  model gridTest21

    GridOneTrack gridOneTrack(
      iniSecPos={580,1744},
      lineLength=2500,
      resistivity={0.000108,0.000108,0.00014},
      numOfTrains=1)
      annotation (Placement(transformation(extent={{-20,-20},{80,20}})));
    Modelica.Blocks.Sources.Constant pos1(k = 1000) annotation(Placement(transformation(extent={{-60,-10},
              {-40,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent={{20,-88},
              {40,-68}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage ess1(V = 100) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-2, 58})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage ess2(V = 100) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, 58})));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{20, 96}, {40, 76}})));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p sTn1(m = 2, k = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-2, 38})));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p sTn2(m = 2, k = 2) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, 38})));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p tTn(m=1, k=1) annotation (
        Placement(visible=true, transformation(
          origin={30,-32},
          extent={{10,-10},{-10,10}},
          rotation=90)));
    Modelica.Electrical.Analog.Sources.ConstantCurrent tr1(I=100)   annotation(Placement(visible = true, transformation(origin={30,-50},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(tr1.n, ground.p) annotation(Line(points={{30,-60},{30,-68}}));
    connect(tTn.pin_p, tr1.p)
      annotation (Line(points={{30,-34},{30,-38},{30,-40}}, color={0,0,255}));
    connect(tTn.plug_p, gridOneTrack.tp)
      annotation (Line(points={{30,-30},{30,-30},{30,-20}}, color={0,0,255}));
    connect(ground1.p, ess1.n) annotation(Line(points = {{30, 76}, {30, 68}, {-2, 68}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ess2.n, ess1.n) annotation(Line(points = {{30, 68}, {-2, 68}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ground1.p, ess2.n) annotation(Line(points = {{30, 76}, {30, 68}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(ess1.p, sTn1.pin_p) annotation(Line(points = {{-2, 48}, {-2, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sTn2.pin_p, ess2.p) annotation(Line(points = {{30, 40}, {30, 48}}, color = {0, 0, 255}, smooth = Smooth.None));
    connect(sTn2.plug_p, gridOneTrack.ep) annotation (Line(
        points={{30,36},{30,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(sTn1.plug_p, gridOneTrack.ep) annotation (Line(
        points={{-2,36},{-2,28},{30,28},{30,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(gridOneTrack.trainPos[1], pos1.y) annotation (Line(
        points={{-24.6875,0.333333},{-32,0.333333},{-32,0},{-39,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
              -100},{100,100}}),                                                                           graphics));
  end gridTest21;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 1})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), uses(Modelica(version = "3.2.1")));
end AutoCreateBug;
