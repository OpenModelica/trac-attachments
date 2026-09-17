encapsulated package simpleTrain
  import Modelica;
  model ReteNew "Modello della rete di alimentazione DC a 3 SSE - ALIM. BILATERA E MONOLATERA"
    Modelica.Blocks.Interfaces.RealInput Posizione "Posizione del tram durante la marcia (BINARIO PARI) [m]" annotation(Placement(transformation(extent = {{-280,38},{-240,78}}), iconTransformation(extent = {{-280,36},{-240,76}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(Placement(transformation(extent = {{290,-270},{310,-250}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin annotation(Placement(transformation(extent = {{-180,90},{-160,110}}), iconTransformation(extent = {{-180,92},{-160,112}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin1 annotation(Placement(transformation(extent = {{52,90},{72,110}}), iconTransformation(extent = {{70,92},{90,112}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin2 annotation(Placement(transformation(extent = {{322,90},{342,110}}), iconTransformation(extent = {{320,92},{340,112}})));
    parameter Real Posizione_SSE[n] = {580,1744,3141} "Posizione assoluta delle SSE lungo l'intera tratta del convoglio ferroviario [m]";
    Real R_spec[2] = {0.000108,0.000143} "Resistenza specifica della linea di alimentazione e binario [Ohm/m](da 0 a 1744 � 0.000108 ohm/m e da 1744 in poi di 0.000143 ";
    Real R_SSE[2 * n - 1] "Vettore di gestione delle resistenze destra e sinistra tra le varie sottostazioni [Ohm](BINARIO PARI)";
    Real R_SSE_1[2 * n - 1] "Vettore di gestione delle resistenze destra e sinistra tra le varie sottostazioni [Ohm](BINARIO DISPARI)";
    Real alfa "Variabile utilizzata per il calcolo della resistenza destra e sinistra tra le due sottostazioni attuali [Rxy_s=Rtot*alfa e Rxy_d=Rtot*(1-alfa)](BINARIO PARI)";
    Real alfa1 "Variabile utilizzata per il calcolo della resistenza destra e sinistra tra le due sottostazioni attuali [Rxy_s=Rtot*alfa1 e Rxy_d=Rtot*(1-alfa1)](BINARIO DISPARI)";
    Real Ltot[n] "Distanza totale tra le coppie di SSE contigue (es.SS1-SSE2 SS2-SSE3 etc...) [m] NOTA: L'INDICE 1 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";
    Real Rtot[n] "Resistenza totale tra le coppie di SSE contigue (es.SS1-SSE2 SS2-SSE3 etc...)[Ohm]. NOTA: L'INDICE 1 E' USATO PER LA GESTIONE DELLA RESISTENZA PER ALIM. MONOLATERA";
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation(Placement(transformation(extent = {{-70,30},{-50,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE2(y = R_SSE[2]) annotation(Placement(transformation(extent = {{-21,-16},{21,16}}, rotation = 270, origin = {-60,81})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor1 annotation(Placement(transformation(extent = {{-8,30},{12,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE3(y = R_SSE[3]) annotation(Placement(transformation(extent = {{-20,-13},{20,13}}, rotation = 270, origin = {3,80})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor2 annotation(Placement(transformation(extent = {{220,30},{240,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE4(y = R_SSE[4]) annotation(Placement(transformation(extent = {{-20,-13},{20,13}}, rotation = 270, origin = {231,80})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor3 annotation(Placement(transformation(extent = {{280,30},{300,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE5(y = R_SSE[5]) annotation(Placement(transformation(extent = {{-20,-14},{20,14}}, rotation = 270, origin = {290,80})));
    Integer z "Indice di tratta (z=1 tratto monolatero, z>1 tratte bilatere (BINARIO PARI)";
    Integer z1 "Indice di tratta (z=1 tratto monolatero, z>1 tratte bilatere (BINARIO DISPARI)";
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor15 annotation(Placement(transformation(extent = {{-198,30},{-178,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE1(y = R_SSE[1]) annotation(Placement(transformation(extent = {{-21,-14},{21,14}}, rotation = 270, origin = {-214,81})));
    Modelica.Blocks.Interfaces.RealInput Posizione1 "Posizione del tram durante la marcia (BINARIO DISPARI) [m]" annotation(Placement(transformation(extent = {{-280,-82},{-240,-42}}), iconTransformation(extent = {{-278,-82},{-238,-42}})));
    Modelica.Blocks.Sources.RealExpression R_SSE12(y = R_SSE_1[1]) annotation(Placement(transformation(extent = {{-22,-14},{22,14}}, rotation = 270, origin = {-186,-98})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor6 annotation(Placement(transformation(extent = {{-70,-150},{-50,-130}})));
    Modelica.Blocks.Sources.RealExpression R_SSE13(y = R_SSE_1[2]) annotation(Placement(transformation(extent = {{-21,-16},{21,16}}, rotation = 270, origin = {-60,-99})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor7 annotation(Placement(transformation(extent = {{-8,-150},{12,-130}})));
    Modelica.Blocks.Sources.RealExpression R_SSE14(y = R_SSE_1[3]) annotation(Placement(transformation(extent = {{-20,-13},{20,13}}, rotation = 270, origin = {3,-100})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor8 annotation(Placement(transformation(extent = {{220,-150},{240,-130}})));
    Modelica.Blocks.Sources.RealExpression R_SSE15(y = R_SSE_1[4]) annotation(Placement(transformation(extent = {{-20,-13},{20,13}}, rotation = 270, origin = {231,-100})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor13 annotation(Placement(transformation(extent = {{280,-150},{300,-130}})));
    Modelica.Blocks.Sources.RealExpression R_SSE16(y = R_SSE_1[5]) annotation(Placement(transformation(extent = {{-20,-14},{20,14}}, rotation = 270, origin = {290,-100})));
    Modelica.Blocks.Sources.IntegerExpression tratta1(y = z1) annotation(Placement(transformation(extent = {{-11.5,-14.5},{11.5,14.5}}, rotation = 90, origin = {79.5,-196.5})));
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor20 annotation(Placement(transformation(extent = {{-196,-150},{-176,-130}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p1 annotation(Placement(transformation(extent = {{-88,-270},{-68,-250}}), iconTransformation(extent = {{-88,-270},{-68,-250}})));
    parameter Integer n = 3 "Numero di Sottostazioni (SSE): Nella pratica si usa come indice per la gestione dei cicli all'interno del codice";
    //BINARIO PARI:
    condNodeZ condNodeZ1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-214,30})));
    condNodeZ condNodeZ2(index = 2) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-24,30})));
    condNodeZ condNodeZ3(index = 3) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {264,30})));
    Modelica.Blocks.Sources.IntegerExpression tratta(y = z) annotation(Placement(transformation(extent = {{-11,-16},{11,16}}, rotation = 90, origin = {-97,-14})));
    condNodeZ condNodeZ4(index = 1) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-218,-150})));
    condNodeZ condNodeZ5(index = 2) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-26,-150})));
    condNodeZ condNodeZ6(index = 3) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {262,-150})));
  equation
    //Incremento del contatore di tratta (z):
  algorithm
    z:=1;
    for i in 1:n - 1 loop
          if Posizione > Posizione_SSE[i] then 
        z:=z + 1;
      else

      end if;
    end for;
  equation
    for i in 1:n loop
    if i <> 1 then
      Ltot[i] = Posizione_SSE[i] - Posizione_SSE[i - 1];
    else
      Ltot[i] = Posizione_SSE[i] - 0;
    end if;
    if i <= 2 then
      Rtot[i] = R_spec[1] * Ltot[i];
    else
      Rtot[i] = R_spec[2] * Ltot[i];
    end if;
    if i <> 1 then
      R_SSE[2 * i - 2] = if z <> i then Rtot[i] else (1 - alfa) * Rtot[i];
      R_SSE[2 * i - 1] = if z <> i then 0 else alfa * Rtot[i];
    else
      R_SSE[i] = if z <> i then Rtot[1] else alfa * Rtot[i];
    end if;

    end for;
    //Calcolo della distanza totale tra le due SSE (Ltot) contigue necessaria per calcolare la resistenza totale (Rtot) tra le due SSE
    //Lunghezza tratti bilateri (i>1):
    //Lunghezza tratto monolatero (i=1):
    //Gestione della resistenza specifica e calcolo di Rtot nei vari tratti (R_spec vale da 0 a 1744 � 0.000108 ohm/m e da 1744 in poi 0.000143):
    //Calcolo delle resistenza totale (Rtot) da 0 alla seconda sottostazione (ascissa pari a 1744):
    //Calcolo della resistenza totale (Rtot) tra due SSE dalla seconda SSE in poi (da 1744 in avanti):
    //Gestione degli elementi del vettore R_SSE, ossia del vettore delle resistenze longitudinali tra le sottostazioni (SSE):
    //Gestione degli elementi per i tratti bilateri (z>1):
    //Gestione per il tratto monolatero (z=1):
    //Gestione dell'alfa tra le varie sottostazioni e nel caso di velocit� positive e negative:
    alfa = (Posizione_SSE[z] - Posizione) / Ltot[z];
    //BINARIO DISPARI:
  algorithm
    //Incremento del contatore di tratta (z):
    z1:=1;
    for i in 1:n - 1 loop
          if Posizione1 > Posizione_SSE[i] then 
        z1:=z1 + 1;
      else

      end if;
    end for;
  equation
    for i in 1:n loop
    if i <> 1 then
      R_SSE_1[2 * i - 2] = if z1 <> i then Rtot[i] else (1 - alfa1) * Rtot[i];
      R_SSE_1[2 * i - 1] = if z1 <> i then 0 else alfa1 * Rtot[i];
    else
      R_SSE_1[i] = if z1 <> i then Rtot[1] else alfa1 * Rtot[i];
    end if;

    end for;
    //Gestione degli elementi del vettore R_SSE, ossia del vettore delle resistenze longitudinali tra le sottostazioni (SSE):
    //Gestione degli elementi per i tratti bilateri (z1>1):
    //Gestione per il tratto monolatero (z=1):
    //Gestione dell'alfa tra le varie sottostazioni e nel caso di velocit� positive e negative:
    alfa1 = (Posizione_SSE[z1] - Posizione1) / Ltot[z1];
    connect(variableResistor.p,pin) annotation(Line(points = {{-70,40},{-170,40},{-170,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE2.y,variableResistor.R) annotation(Line(points = {{-60,57.9},{-60,54.45},{-60,54.45},{-60,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE3.y,variableResistor1.R) annotation(Line(points = {{3,58},{3,54},{2,54},{2,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor2.p,variableResistor1.n) annotation(Line(points = {{220,40},{12,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE4.y,variableResistor2.R) annotation(Line(points = {{231,58},{231,54},{230,54},{230,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE5.y,variableResistor3.R) annotation(Line(points = {{290,58},{290,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(pin1,variableResistor1.n) annotation(Line(points = {{62,100},{62,40},{12,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin2,variableResistor3.n) annotation(Line(points = {{332,100},{332,40},{300,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor15.n,pin) annotation(Line(points = {{-178,40},{-170,40},{-170,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE1.y,variableResistor15.R) annotation(Line(points = {{-214,57.9},{-214,54},{-188,54},{-188,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE13.y,variableResistor6.R) annotation(Line(points = {{-60,-122.1},{-60,-125.55},{-60,-125.55},{-60,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE14.y,variableResistor7.R) annotation(Line(points = {{3,-122},{3,-126},{2,-126},{2,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor8.p,variableResistor7.n) annotation(Line(points = {{220,-140},{12,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE15.y,variableResistor8.R) annotation(Line(points = {{231,-122},{231,-126},{230,-126},{230,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE16.y,variableResistor13.R) annotation(Line(points = {{290,-122},{290,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor15.n,pin) annotation(Line(points = {{-178,40},{-170,40},{-170,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE12.y,variableResistor20.R) annotation(Line(points = {{-186,-122.2},{-186,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor20.n,variableResistor6.p) annotation(Line(points = {{-176,-140},{-70,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor6.p,pin) annotation(Line(points = {{-70,-140},{-136,-140},{-136,40},{-170,40},{-170,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor7.n,pin1) annotation(Line(points = {{12,-140},{62,-140},{62,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin2,variableResistor13.n) annotation(Line(points = {{332,100},{332,-140},{300,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ1.n2,variableResistor15.p) annotation(Line(points = {{-208,39.8},{-202,39.8},{-202,40},{-198,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.n1,variableResistor.n) annotation(Line(points = {{-30,40},{-41.6,40},{-41.6,40},{-50,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.n2,variableResistor1.p) annotation(Line(points = {{-18,39.8},{-13,39.8},{-13,40},{-8,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ3.n1,variableResistor2.n) annotation(Line(points = {{258,40},{250.4,40},{250.4,40},{240,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ3.n2,variableResistor3.p) annotation(Line(points = {{270,39.8},{275,39.8},{275,40},{280,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p,condNodeZ3.p) annotation(Line(points = {{300,-260},{300,-200},{320,-200},{320,10},{264,10},{264,30.2}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.p,condNodeZ3.p) annotation(Line(points = {{-24,30.2},{-24,12},{264,12},{264,30.2}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.p,condNodeZ1.p) annotation(Line(points = {{-24,30.2},{-24,12},{-214,12},{-214,30.2}}, color = {0,0,255}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ1.z) annotation(Line(points = {{-97,-1.9},{-164,0},{-228,0},{-228,30.2}}, color = {255,127,0}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ2.z) annotation(Line(points = {{-97,-1.9},{-38,-1.9},{-38,30.2}}, color = {255,127,0}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ3.z) annotation(Line(points = {{-97,-1.9},{246,-2},{252,-2},{252,30.2},{250,30.2}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ4.n2,variableResistor20.p) annotation(Line(points = {{-212,-140.2},{-204,-140.2},{-204,-140},{-196,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor6.n,condNodeZ5.n1) annotation(Line(points = {{-50,-140},{-40.6,-140},{-40.6,-140},{-32,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ5.n2,variableResistor7.p) annotation(Line(points = {{-20,-140.2},{-14,-140.2},{-14,-140},{-8,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor8.n,condNodeZ6.n1) annotation(Line(points = {{240,-140},{248.4,-140},{248.4,-140},{256,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ6.n2,variableResistor13.p) annotation(Line(points = {{268,-140.2},{274,-140.2},{274,-140},{280,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p1,condNodeZ4.p) annotation(Line(points = {{-78,-260},{-78,-168},{-218,-168},{-218,-149.8}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p1,condNodeZ5.p) annotation(Line(points = {{-78,-260},{-78,-206},{-26,-206},{-26,-149.8}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ6.p,pin_p1) annotation(Line(points = {{262,-149.8},{262,-168},{-78,-168},{-78,-260}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ4.z,tratta1.y) annotation(Line(points = {{-232,-149.8},{-230,-149.8},{-230,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ5.z,tratta1.y) annotation(Line(points = {{-40,-149.8},{-40,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ6.z,tratta1.y) annotation(Line(points = {{248,-149.8},{248,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(extent = {{-240,-260},{400,100}}, preserveAspectRatio = true), graphics), Icon(coordinateSystem(extent = {{-240,-260},{400,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(extent = {{-240,100},{402,-98}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-368,-96},{-198,-116}}, textString = "Dispari", textStyle = {TextStyle.Italic}),Line(points = {{-78,-102},{-78,-262},{-78,-262}}, color = {0,0,255}),Line(points = {{300,-102},{300,-266},{298,-264}}, color = {0,0,255}),Text(extent = {{-360,28},{-226,8}}, textString = "Pari"),Text(origin = {284,-170}, rotation = 90, extent = {{-84,12},{84,-12}}, textString = "Pari"),Text(origin = {-102,-176}, rotation = 90, extent = {{-48,2},{48,-2}}, textString = "Dispari"),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-212,64},{-192,54}}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-130,64},{-110,54}}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{20,64},{40,54}}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{120,64},{140,54}}),Rectangle(origin = {-76,0}, lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{360,64},{380,54}}),Line(points = {{320,62},{320,64}}, color = {215,215,215}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-210,-34},{-190,-44}}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{-132,-34},{-112,-44}}),Line(points = {{-40,-38},{-40,-36}}, color = {215,215,215}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{20,-34},{40,-44}}),Rectangle(lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{120,-34},{140,-44}}),Rectangle(origin = {-76,0}, lineColor = {215,215,215}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, extent = {{360,-34},{380,-44}}),Line(points = {{320,-38},{320,-36}}, color = {215,215,215}),Line(points = {{-192,60},{-140,60},{-128,60}}, color = {215,215,215}),Line(points = {{-170,92},{-170,-40},{-130,-40},{-130,-40}}, color = {215,215,215}),Line(points = {{-168,-40},{-190,-40},{-190,-40}}, color = {215,215,215}),Line(points = {{-108,60},{20,60}}, color = {215,215,215}),Line(points = {{40,60},{120,60},{120,60}}, color = {215,215,215}),Line(points = {{140,60},{220,60},{248,60}}, color = {215,215,215}),Line(points = {{238,60},{286,60}}, color = {215,215,215}),Line(origin = {0,0}, points = {{304,60},{330,60}}, color = {215,215,215}),Line(points = {{80,100},{80,60},{80,-40}}, color = {215,215,215}),Line(origin = {-90,0}, points = {{420,100},{420,-40},{392,-40},{392,-40}}, color = {215,215,215}),Line(points = {{284,-40},{240,-40},{240,-40}}, color = {215,215,215}),Line(points = {{250,-40},{140,-40},{140,-40}}, color = {215,215,215}),Line(points = {{120,-40},{60,-40},{40,-40}}, color = {215,215,215}),Line(points = {{-120,-40},{-60,-40},{-26,-40}}, color = {215,215,215}),Line(points = {{-40,-40},{20,-40},{20,-40}}, color = {215,215,215})}));
  end ReteNew;
  model condNodeZ "Ideal commuting switch"
    Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(Placement(transformation(extent = {{-60,-10},{-40,10}}, rotation = 0), iconTransformation(extent = {{-9,-10},{11,10}})));
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 annotation(Placement(transformation(extent = {{40,20},{60,40}}, rotation = 0)));
  public
    Modelica.Electrical.Analog.Interfaces.NegativePin n2 annotation(Placement(transformation(extent = {{39,-40},{59,-20}}, rotation = 0), iconTransformation(extent = {{39,-40},{59,-20}})));
    parameter Integer index = 1 "node numerical index";
    Modelica.Blocks.Interfaces.IntegerInput z annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {17,51}), iconTransformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {1,70})));
  equation
    n1.v = n2.v;
    if z == index then
      n1.i + n2.i + p.i = 0;
      p.v = n1.v;
    else
      n1.i + n2.i = 0;
      p.i = 0;
    end if;
    //connection active
    //connection inactive
    annotation(Documentation(info = "<html>
<p>Nodo condizionale.</p>
<p>I due nodi n1 e n2 sono sempre connessi fra loro. Se command &egrave; true, al nodo &egrave; anche connesso p.</p>
</html>", revisions = "<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-50,-50},{50,50}}, grid = {1,1}), graphics = {Line(visible = useHeatPort, points = {{0,-100},{0,25}}, color = {127,0,0}, smooth = Smooth.None, pattern = LinePattern.Dot),Line(points = {{50,30},{50,-29}}, color = {0,0,255}, smooth = Smooth.None),Line(points = {{0,50},{0,29},{50,0}}, color = {255,128,0}),Line(points = {{4,0},{52,0}}, color = {0,0,255}),Ellipse(extent = {{44,5},{56,-7}}, lineColor = {0,0,255}, fillPattern = FillPattern.Solid, fillColor = {0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-50,-50},{50,50}}, grid = {1,1}), graphics));
  end condNodeZ;
  model aaa
    annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
  end aaa;
end simpleTrain;

