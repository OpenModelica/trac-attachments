encapsulated package simpleTest
  import Modelica;
  import prova;
  import Tesi;
  import simpleTrain1;
  import simpleTrain_11;
  import Commutatore_PlugToPin_p;
  model component "Modello della rete di alimentazione DC a 3 SSE - ALIM. BILATERA E MONOLATERA"
    Modelica.Blocks.Interfaces.RealInput Posizione "Posizione del tram durante la marcia (BINARIO PARI) [m]" annotation(Placement(transformation(extent = {{-280,38},{-240,78}}), iconTransformation(extent = {{-280,36},{-240,76}})));
    Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(Placement(transformation(extent = {{290,-270},{310,-250}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin annotation(Placement(transformation(extent = {{-170,90},{-150,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin1 annotation(Placement(transformation(extent = {{90,90},{110,110}})));
    Modelica.Electrical.Analog.Interfaces.Pin pin2 annotation(Placement(transformation(extent = {{370,90},{390,110}})));
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
    Modelica.Electrical.Analog.Basic.VariableResistor variableResistor15 annotation(Placement(transformation(extent = {{-196,30},{-176,50}})));
    Modelica.Blocks.Sources.RealExpression R_SSE1(y = R_SSE[1]) annotation(Placement(transformation(extent = {{-21,-14},{21,14}}, rotation = 270, origin = {-186,81})));
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
    Modelica.Blocks.Sources.IntegerExpression tratta(y = z) annotation(Placement(transformation(extent = {{-11,-16},{11,16}}, rotation = 90, origin = {-97,-16})));
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
    alfa = (Posizione_SSE[z] - Posizione) / Ltot[z];
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
    alfa1 = (Posizione_SSE[z1] - Posizione1) / Ltot[z1];
    connect(variableResistor.p,pin) annotation(Line(points = {{-70,40},{-160,40},{-160,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE2.y,variableResistor.R) annotation(Line(points = {{-60,57.9},{-60,54.45},{-60,54.45},{-60,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE3.y,variableResistor1.R) annotation(Line(points = {{3,58},{3,54},{2,54},{2,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor2.p,variableResistor1.n) annotation(Line(points = {{220,40},{12,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE4.y,variableResistor2.R) annotation(Line(points = {{231,58},{231,54},{230,54},{230,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE5.y,variableResistor3.R) annotation(Line(points = {{290,58},{290,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(pin1,variableResistor1.n) annotation(Line(points = {{100,100},{100,40},{12,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin2,variableResistor3.n) annotation(Line(points = {{380,100},{380,40},{300,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor15.n,pin) annotation(Line(points = {{-176,40},{-160,40},{-160,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE1.y,variableResistor15.R) annotation(Line(points = {{-186,57.9},{-186,51}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE13.y,variableResistor6.R) annotation(Line(points = {{-60,-122.1},{-60,-125.55},{-60,-125.55},{-60,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE14.y,variableResistor7.R) annotation(Line(points = {{3,-122},{3,-126},{2,-126},{2,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor8.p,variableResistor7.n) annotation(Line(points = {{220,-140},{12,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE15.y,variableResistor8.R) annotation(Line(points = {{231,-122},{231,-126},{230,-126},{230,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(R_SSE16.y,variableResistor13.R) annotation(Line(points = {{290,-122},{290,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor15.n,pin) annotation(Line(points = {{-176,40},{-160,40},{-160,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(R_SSE12.y,variableResistor20.R) annotation(Line(points = {{-186,-122.2},{-186,-129}}, color = {0,0,127}, smooth = Smooth.None));
    connect(variableResistor20.n,variableResistor6.p) annotation(Line(points = {{-176,-140},{-70,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor6.p,pin) annotation(Line(points = {{-70,-140},{-136,-140},{-136,-20},{-136,-20},{-136,40},{-160,40},{-160,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor7.n,pin1) annotation(Line(points = {{12,-140},{100,-140},{100,100}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin2,variableResistor13.n) annotation(Line(points = {{380,100},{380,-140},{300,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ1.n2,variableResistor15.p) annotation(Line(points = {{-209,40},{-196,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.n1,variableResistor.n) annotation(Line(points = {{-29.2,39.9},{-41.6,39.9},{-41.6,40},{-50,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.n2,variableResistor1.p) annotation(Line(points = {{-19,40},{-8,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ3.n1,variableResistor2.n) annotation(Line(points = {{258.8,39.9},{250.4,39.9},{250.4,40},{240,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ3.n2,variableResistor3.p) annotation(Line(points = {{269,40},{280,40}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p,condNodeZ3.p) annotation(Line(points = {{300,-260},{300,-260},{300,-200},{360,-200},{360,10},{264,10},{264,30}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.p,condNodeZ3.p) annotation(Line(points = {{-24,30},{-24,12},{264,10},{264,30}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ2.p,condNodeZ1.p) annotation(Line(points = {{-24,30},{-24,12},{-222,10},{-214,30}}, color = {0,0,255}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ1.z) annotation(Line(points = {{-97,-3.9},{-162,-4},{-162,-4},{-228,-4},{-228,34},{-221.4,34}}, color = {255,127,0}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ2.z) annotation(Line(points = {{-97,-3.9},{-31.4,-3.9},{-31.4,34}}, color = {255,127,0}, smooth = Smooth.None));
    connect(tratta.y,condNodeZ3.z) annotation(Line(points = {{-97,-3.9},{246,-2},{252,-2},{252,34},{256.6,34}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ4.n2,variableResistor20.p) annotation(Line(points = {{-213,-140},{-196,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor6.n,condNodeZ5.n1) annotation(Line(points = {{-50,-140},{-40.6,-140},{-40.6,-140.1},{-31.2,-140.1}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ5.n2,variableResistor7.p) annotation(Line(points = {{-21,-140},{-8,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(variableResistor8.n,condNodeZ6.n1) annotation(Line(points = {{240,-140},{248.4,-140},{248.4,-140.1},{256.8,-140.1}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ6.n2,variableResistor13.p) annotation(Line(points = {{267,-140},{280,-140}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p1,condNodeZ4.p) annotation(Line(points = {{-78,-260},{-78,-168},{-218,-168},{-218,-150}}, color = {0,0,255}, smooth = Smooth.None));
    connect(pin_p1,condNodeZ5.p) annotation(Line(points = {{-78,-260},{-78,-206},{-26,-206},{-26,-150}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ6.p,pin_p1) annotation(Line(points = {{262,-150},{262,-168},{-78,-168},{-78,-260}}, color = {0,0,255}, smooth = Smooth.None));
    connect(condNodeZ4.z,tratta1.y) annotation(Line(points = {{-225.4,-146},{-230,-146},{-230,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ5.z,tratta1.y) annotation(Line(points = {{-33.4,-146},{-33.4,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    connect(condNodeZ6.z,tratta1.y) annotation(Line(points = {{254.6,-146},{254.6,-183.85},{79.5,-183.85}}, color = {255,127,0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(extent = {{-240,-260},{440,100}}, preserveAspectRatio = true), graphics), Icon(coordinateSystem(extent = {{-240,-260},{440,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {100.5,-81}, extent = {{-338.25,179.25},{338.25,-179.25}})}));
  end component;
  model runnable "Esempio con blocchi A-F e alimentazione bilatera e monolatera"
    //   import SimpleDriver;
    import Modelica.Constants.pi;
    parameter Modelica.SIunits.Mass vMass = 60000 "Vehicle mass";
    component rete_di_Alimentazione annotation(Placement(visible = true, transformation(origin = {10.6152,49.8472}, extent = {{-33.1765,-36.1111},{60.8235,13.8889}}, rotation = 0)));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-180,-80},{160,140}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-180,-80},{160,140}}), graphics = {Ellipse(extent = {{-102,130},{98,-70}}, lineColor = {95,95,95}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Polygon(points = {{-34,92},{66,32},{-34,-28},{-34,92}}, lineColor = {0,0,255}, pattern = LinePattern.None, fillColor = {95,95,95}, fillPattern = FillPattern.Solid)}), experimentSetupOutput(derivatives = false), Documentation(info = "<html>
</html>"), experiment(StartTime = 0.0, StopTime = 1100.0, Tolerance = 0.000001));
  end runnable;
  annotation(uses(Modelica(version = "3.2")));
end simpleTest;

