within ;
package HeatedRoom
  model HeatedRoom_BlockDiagram

    Modelica.Blocks.Sources.Constant const(k=5)
      annotation (Placement(transformation(extent={{-180,90},{-160,110}})));
    Modelica.Blocks.Sources.Constant Outside_Temperature(k=13)
      annotation (Placement(transformation(extent={{-180,10},{-160,30}})));
    Modelica.Blocks.Math.Add add(k1=-0.1, k2=+0.1)
      annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
    Modelica.Blocks.Continuous.Integrator integrator(y_start=17)
      annotation (Placement(transformation(extent={{-20,62},{0,82}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=15, uHigh=20)
      annotation (Placement(transformation(extent={{20,60},{40,80}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{100,60},{120,80}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
  equation
    connect(const.y, product.u2) annotation (Line(
        points={{-159,100},{-140,100},{-140,104},{-122,104}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Outside_Temperature.y, add.u2) annotation (Line(
        points={{-159,20},{-140,20},{-140,24},{-122,24}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.y, add1.u1) annotation (Line(
        points={{-99,110},{-80,110},{-80,76},{-62,76}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.y, add1.u2) annotation (Line(
        points={{-99,30},{-80,30},{-80,64},{-62,64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add1.y, integrator.u) annotation (Line(
        points={{-39,70},{-30,70},{-30,72},{-22,72}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integrator.y, hysteresis.u) annotation (Line(
        points={{1,72},{10,72},{10,70},{18,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(booleanToReal.y, product.u1) annotation (Line(
        points={{121,70},{140,70},{140,160},{-140,160},{-140,116},{-122,116}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integrator.y, add.u1) annotation (Line(
        points={{1,72},{10,72},{10,50},{-140,50},{-140,36},{-122,36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hysteresis.y, not1.u) annotation (Line(
        points={{41,70},{58,70}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, booleanToReal.u) annotation (Line(
        points={{81,70},{98,70}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
              -200,-200},{200,200}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-200,-200},{200,200}})));
  end HeatedRoom_BlockDiagram;

  model HeatedRoom_BlockDiagramStructured

    Modelica.Blocks.Sources.Constant const(k=5)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.Constant Outside_Temperature(k=13)
      annotation (Placement(transformation(extent={{-220,-70},{-200,-50}})));
    Modelica.Blocks.Math.Add add(k1=-0.1, k2=+0.1)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{0,30},{20,50}})));
    Modelica.Blocks.Continuous.Integrator integrator(y_start=17)
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=15, uHigh=20)
      annotation (Placement(transformation(extent={{-220,80},{-200,100}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-180,80},{-160,100}})));
  equation
    connect(const.y, product.u2) annotation (Line(
        points={{-39,30},{-20,30},{-20,34},{-2,34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Outside_Temperature.y, add.u2) annotation (Line(
        points={{-199,-60},{-20,-60},{-20,-56},{-2,-56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.y, add1.u1) annotation (Line(
        points={{21,40},{40,40},{40,6},{58,6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.y, add1.u2) annotation (Line(
        points={{21,-50},{40,-50},{40,-6},{58,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add1.y, integrator.u) annotation (Line(
        points={{81,0},{98,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integrator.y, add.u1) annotation (Line(
        points={{121,0},{180,0},{180,-30},{-20,-30},{-20,-44},{-2,-44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(integrator.y, hysteresis.u) annotation (Line(
        points={{121,0},{180,0},{180,140},{-260,140},{-260,90},{-222,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hysteresis.y, not1.u) annotation (Line(
        points={{-199,90},{-182,90}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, booleanToReal.u) annotation (Line(
        points={{-159,90},{-142,90}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(booleanToReal.y, product.u1) annotation (Line(
        points={{-119,90},{-20,90},{-20,46},{-2,46}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{
              -300,-200},{300,200}}), graphics={
          Rectangle(
            extent={{-80,60},{160,-100}},
            lineColor={0,0,255},
            fillColor={170,255,213},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-240,-20},{-100,-100}},
            lineColor={0,0,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-240,120},{-100,60}},
            lineColor={0,0,255},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-244,70},{-168,66}},
            lineColor={0,0,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="Heater controller"),
          Text(
            extent={{-232,-92},{-172,-92}},
            lineColor={0,0,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="Outside weather"),
          Text(
            extent={{-68,-90},{-18,-92}},
            lineColor={0,0,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            textString="Heated room")}), Icon(coordinateSystem(
            preserveAspectRatio=true, extent={{-300,-200},{300,200}})));
  end HeatedRoom_BlockDiagramStructured;

  model HeatedRoom_Equational

    HeatedRoom heatedRoom
      annotation (Placement(transformation(extent={{20,-6},{60,14}})));
    HeaterController heaterController
      annotation (Placement(transformation(extent={{-86,18},{-42,38}})));
    OutsideWeather outsideWeather
      annotation (Placement(transformation(extent={{-64,-20},{-20,0}})));
    Heater heater
      annotation (Placement(transformation(extent={{-22,18},{-2,38}})));
  equation
    connect(heatedRoom.RoomTemperature, heaterController.RoomTemperature)
      annotation (Line(
        points={{62,4},{80,4},{80,60},{-98,60},{-98,28},{-90.4,28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(outsideWeather.Outside_Temperature, heatedRoom.Outside_Temperature)
      annotation (Line(
        points={{-17.8,-10},{0,-10},{0,-2},{16,-2}},
        color={0,0,127},
        smooth=Smooth.Bezier));
    connect(heaterController.HeaterControl, heater.u) annotation (Line(
        points={{-39.8,28},{-24,28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heater.y, heatedRoom.HeaterControl) annotation (Line(
        points={{-1,28},{6,28},{6,10},{16,10}},
        color={0,0,127},
        smooth=Smooth.Bezier));
    annotation (Diagram(graphics),
      experiment(StopTime=1000),
      __Dymola_experimentSetupOutput);
  end HeatedRoom_Equational;

  model HeatedRoom
    parameter Real CoeffOutsideTemperature = 0.1
      "Coefficient to take into account the outside temperature (-)";
    parameter Real CoeffHeaterController = 5
      "Coefficient to take into account the heater controller (-)";
    parameter Real RoomTemperatureInit = 17
      "Initial temperature of the room (°C)";
    Real T(start=RoomTemperatureInit) "Room temperature";

    Real MeanTemperature[10]( start = 17* ones(10)); //creates bad results
   //  Real MeanTemperature[10];
    Real temper[10];
    Integer k(start=0);
    Integer i;

    Modelica.Blocks.Interfaces.RealInput HeaterControl
      annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
          iconTransformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput Outside_Temperature
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
    Modelica.Blocks.Interfaces.RealOutput RoomTemperature
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  equation
    der(T)= CoeffOutsideTemperature*(Outside_Temperature - T) + CoeffHeaterController*HeaterControl;
    RoomTemperature = T;

  algorithm

    when sample(0,100) then
      reinit( T,RoomTemperatureInit);
      k:=1+integer(time/100);
    end when;

    when  sample(0,10) then
      i:=1+integer((time-(k-1)*100)/ 10);
      temper[i]:=T + temper[i];
      MeanTemperature[i]:=temper[i]/k;
    end when;

     annotation (Diagram(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,255})}), Icon(graphics={Rectangle(extent={{-100,100},
                {100,-100}}, lineColor={0,0,255}), Text(
            extent={{-62,22},{54,-18}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}),
      experiment(StopTime=1000),
      __Dymola_experimentSetupOutput);
  end HeatedRoom;

  model HeaterController
    parameter Real TemperatureMin = 15
      "Minimal temperature from which the heater starts (°C)";
    parameter Real TemperatureMax = 20
      "Maximal temperature from which the heater stops (°C)";
    Modelica.Blocks.Interfaces.RealInput RoomTemperature
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput HeaterControl
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=TemperatureMin, uHigh=
          TemperatureMax)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(RoomTemperature, hysteresis.u) annotation (Line(
        points={{-120,0},{-62,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hysteresis.y, not1.u) annotation (Line(
        points={{-39,0},{-22,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, booleanToReal.u) annotation (Line(
        points={{1,0},{18,0}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(booleanToReal.y, HeaterControl) annotation (Line(
        points={{41,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,255})}), Icon(graphics={Rectangle(extent={{-100,100},
                {100,-100}}, lineColor={0,0,255}), Text(
            extent={{-62,22},{54,-18}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end HeaterController;

  model OutsideWeather
    parameter Real OutsideTemperature = 13 "Outside temperature (°C)";
    Modelica.Blocks.Interfaces.RealOutput Outside_Temperature
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Sources.Constant Outside_Temperature1(k=OutsideTemperature)
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  equation
    connect(Outside_Temperature1.y, Outside_Temperature) annotation (Line(
        points={{1,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(graphics={Rectangle(extent={{-100,100},{100,-100}},
              lineColor={0,0,255})}), Icon(graphics={Rectangle(extent={{-100,100},
                {100,-100}}, lineColor={0,0,255}), Text(
            extent={{-62,22},{54,-18}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end OutsideWeather;

  model Heater

    extends Modelica.Blocks.Interfaces.SISO;

  Boolean working(start = true);
  Real starttime_working( start = 0);
  Real starttime_notworking( start = 0);

  // In fact the 3 following parameters are integers, but they must be declared as real numbers because
  // the maximum value of an integer is 2^31 (?)
   // parameter Real m(start = 4294967296);  // m = 2^32, parameter of the pseudo-random generator
   // parameter Real a(start=214013);  // parameter of the pseudo-random generator
    //parameter Real c(start=2531011); // parameter of the pseudo-random generator
    Real x;
    Real x1;
    parameter Real lambda = 0.03;
    parameter Real mu = 0.1;

    //parameter Real seed( start = 1973272912);

  //Real F;  //The successive values of F will be a suite of pseudo-random numbers with a uniform distribution on [0,1]
  Real X;
  Real Y;
  parameter Integer[3] seed_vector( start={1,15,3});
  Integer[3] rand_vector;
  Integer[3] pre_rand_vector;
  algorithm

  //when initial() then
   // F := seed;
  //end when;
  when initial() then
   rand_vector:=seed_vector;
  end when;
  // Attention: the two following rules must not be merged in a single one!
  //when initial() then   //calculating the first random working time
     // F := mod(a*F+c, m);
     // x := F / m;
     // X:= (-log(1-x))/lambda;
  //end when;

  when  working then //random draw of the next working time
      //F := mod(a*F+c, m);
      pre_rand_vector:=pre(rand_vector);
      (x,rand_vector):=trials.GoodRandom(pre_rand_vector);
      //x := F / m;
      X:= (-log(1-x))/lambda;
  end when;

  when (not working) then  //random draw of the next failure time
      //F:= mod(a*F+c, m);
      //x1 := F / m;
      pre_rand_vector:=pre(rand_vector);
      (x1, rand_vector):=trials.GoodRandom(pre_rand_vector);
      Y:= (-log(1-x1))/mu;
  end when;

  // X is the working time
  when working and (time - starttime_working) > X then
      working := false;
      starttime_notworking := time;
  end when;

  // Y is the failure time
  when (not working) and (time - starttime_notworking) > Y then
      working := true;
      starttime_working := time;
  end when;

  // Reinitialization every 100 hours
  when  sample(0, 100) then
      working:=true;
      starttime_working := time;
  end when;

  // Input-output relation
  equation
  if working then
    y =  u;
   else
      y =  0.;
  end if;

    annotation (experiment(StopTime=1000, NumberOfIntervals=10),
                                          __Dymola_experimentSetupOutput,
      Icon(graphics={
          Text(
            extent={{-14,-8},{-18,2}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(extent={{-68,68},{-14,34}}, lineColor={0,0,255}),
          Text(
            extent={{-84,20},{92,-16}},
            lineColor={0,0,255},
            textString="%name")}),
      Diagram(graphics));
  end Heater;

  package trials

    function rand "rand"
      output Integer y;
    external "C" y = rand(0);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.35,
          height=0.49),
        Icon(
          Text(
            extent=[-84, 18; 84, -30],
            string="fonction",
            style(color=45)),
          Text(extent=[-134, 104; 142, 44], string="%name"),
          Ellipse(extent=[-100, 40; 100, -100], style(color=45, fillPattern=0)),
          Text(
            extent=[-82, -22; 86, -70],
            string="externe",
            style(color=45))),
        Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    end rand;

    function srand "rand"
      input Integer u;
    external "C" srand(u);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.26,
          y=0.28,
          width=0.6,
          height=0.6),
        Icon(
          Text(extent=[-134, 104; 142, 44], string="%name"),
          Ellipse(extent=[-100, 40; 100, -100], style(color=45, fillPattern=0)),
          Text(
            extent=[-84, 18; 84, -30],
            string="fonction",
            style(color=45)),
          Text(
            extent=[-82, -22; 86, -70],
            string="externe",
            style(color=45))),
        Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    end srand;

    function fmod "fmod"
      input Real u1;
      input Real u2;
      output Real y;
    external "C" y = fmod(u1, u2);
      annotation (Icon(
          Text(extent=[-134,104; 142,44],   string="%name"),
          Ellipse(extent=[-100,40; 100,-100],   style(color=45, fillPattern=0)),
          Text(
            extent=[-84,18; 84,-30],
            string="fonction",
            style(color=45)),
          Text(
            extent=[-82,-22; 86,-70],
            string="externe",
            style(color=45))), Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
    end fmod;

    function random
      annotation (DymolaStoredErrors(thetext="function random

algorithm
  
  parameter Integer seed=1 \"Source du générateur aléatoire\";
  parameter Real SampleOffset=0 \"Instant de départ de l'échantillonnage (s)\";
  parameter Real SampleInterval=0.01 \"Période d'échantillonnage (s)\";
  
equation 

  when initial() then
    Commun.srand(seed);
  end when;

  when sample(SampleOffset, SampleInterval) then
    y.signal = Commun.fmod(Commun.rand()/32768*10, 1);
  end when;


end random;
"));
    end random;

    model test_states
      Modelica.StateGraph.InitialStep initialStep
        annotation (Placement(transformation(extent={{-82,16},{-62,36}})));
      Modelica.StateGraph.Step step
        annotation (Placement(transformation(extent={{-68,-34},{-48,-14}})));
      Modelica.StateGraph.Transition transition(
        enableTimer=true,
        condition=true,
        waitTime=-10)
        annotation (Placement(transformation(extent={{-38,16},{-18,36}})));
      Modelica.StateGraph.Alternative alternative
        annotation (Placement(transformation(extent={{-16,-72},{52,-4}})));
      Modelica.StateGraph.Step step1
        annotation (Placement(transformation(extent={{-74,-80},{-54,-60}})));
    equation
      connect(transition.outPort, step.inPort[1]) annotation (Line(
          points={{-26.5,26},{12,26},{12,4},{-86,4},{-86,-24},{-69,-24}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(initialStep.outPort[1], transition.inPort) annotation (Line(
          points={{-61.5,26},{-32,26}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(step.outPort[1], alternative.inPort) annotation (Line(
          points={{-47.5,-24},{-34,-24},{-34,-38},{-17.02,-38}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(step1.outPort[1], alternative.inPort) annotation (Line(
          points={{-53.5,-70},{-32,-70},{-32,-38},{-17.02,-38}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(graphics));
    end test_states;

    function MyRandom
      "Attempt to define a \"global\" function that could be called from various classes"

      parameter Integer m(start = (2^31)-1);
      parameter Integer a(start=214013);
      parameter Integer c(start=2531011);                                       /// Microsoft Visual/Quick C/C++
      Integer x;
      Integer xiplus;
      Boolean first( start = true);
      output Real u; // pseudo random number in [0,1]
      parameter Integer seed( start = 12345);

    // the instructions below do not work because algorithm
    //  is repeatedly executed !!
    algorithm
      if first then
        xiplus := seed;
        first := false;
      else
        xiplus := mod(a*x+c, m);
      end if;

        x := xiplus;
        u := xiplus / m;

    end MyRandom;

    block MyHysteresis
      "Transform Real to Boolean signal with Hysteresis and periodic reinitialization"

      extends Modelica.Blocks.Interfaces.partialBooleanBlockIcon;
      parameter Real uLow(start=0) "if y=true and u<=uLow, switch to y=false";
      parameter Real uHigh(start=1) "if y=false and u>=uHigh, switch to y=true";
      parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

      Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
            transformation(extent={
            {-140,-20},{-100,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}},
          rotation=0)));

      //initial equation
      //  pre(y) = pre_y_start;

    equation
      when sample(0, 100) then
        reinit(y, pre_y_start);
      end when;
      y = u > uHigh or pre(y) and u >= uLow;
      annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{-65,89},{-73,67},{-57,67},{-65,89}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-65,67},{-65,-81}}, color={192,192,192}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{70,-80},{94,-100}},
          lineColor={160,160,164},
          textString="u"),
        Text(
          extent={{-65,93},{-12,75}},
          lineColor={160,160,164},
          textString="y"),
        Line(
          points={{-80,-70},{30,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-50,10},{80,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-50,10},{-50,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,10},{30,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-10,-65},{0,-70},{-10,-75}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-10,15},{-20,10},{-10,5}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-55,-20},{-50,-30},{-44,-20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{25,-30},{30,-19},{35,-30}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-99,2},{-70,18}},
          lineColor={160,160,164},
          textString="true"),
        Text(
          extent={{-98,-87},{-66,-73}},
          lineColor={160,160,164},
          textString="false"),
        Text(
          extent={{19,-87},{44,-70}},
          lineColor={0,0,0},
          textString="uHigh"),
        Text(
          extent={{-63,-88},{-38,-71}},
          lineColor={0,0,0},
          textString="uLow"),
        Line(points={{-69,10},{-60,10}}, color={160,160,164})}),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-29}}, color={192,192,192}),
        Polygon(
          points={{92,-29},{70,-21},{70,-37},{92,-29}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-79,-29},{84,-29}}, color={192,192,192}),
        Line(points={{-79,-29},{41,-29}}, color={0,0,0}),
        Line(points={{-15,-21},{1,-29},{-15,-36}}, color={0,0,0}),
        Line(points={{41,51},{41,-29}}, color={0,0,0}),
        Line(points={{33,3},{41,22},{50,3}}, color={0,0,0}),
        Line(points={{-49,51},{81,51}}, color={0,0,0}),
        Line(points={{-4,59},{-19,51},{-4,43}}, color={0,0,0}),
        Line(points={{-59,29},{-49,11},{-39,29}}, color={0,0,0}),
        Line(points={{-49,51},{-49,-29}}, color={0,0,0}),
        Text(
          extent={{-92,-49},{-9,-92}},
          lineColor={192,192,192},
          textString="%uLow"),
        Text(
          extent={{2,-49},{91,-92}},
          lineColor={192,192,192},
          textString="%uHigh"),
        Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
        Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
        Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
        Line(points={{41,-29},{41,-49}}, color={192,192,192})}),
    Documentation(info="<HTML>
<p>
This block transforms a <b>Real</b> input signal into a <b>Boolean</b>
output signal:
</p>
<ul>
<li> When the output was <b>false</b> and the input becomes
     <b>greater</b> than parameter <b>uHigh</b>, the output
     switches to <b>true</b>.</li>
<li> When the output was <b>true</b> and the input becomes
     <b>less</b> than parameter <b>uLow</b>, the output
     switches to <b>false</b>.</li>
</ul>
<p>
The start value of the output is defined via parameter
<b>pre_y_start</b> (= value of pre(y) at initial time).
The default value of this parameter is <b>false</b>.
</p>
</HTML>
"));
    end MyHysteresis;

    function GoodRandom "Pseudo random number generator"

      input Integer seedIn[3]
        "Integer vector defining random number sequence, e.g., {23,87,187}"                                 annotation (extent=[-85, 15; -15, 85]);
      output Real x "Random number between 0 and 1";
      output Integer seedOut[3]
        "Modified seed to be used for next call of random()"
                                     annotation (extent=[15, 15; 85, 85]);
    algorithm
      seedOut[1] := rem((171*seedIn[1]), 30269);
      seedOut[2] := rem((172*seedIn[2]), 30307);
      seedOut[3] := rem((170*seedIn[3]), 30323);
      // zero is a poor seed, therfore substitute 1;
      if seedOut[1] == 0 then
        seedOut[1] := 1;
      end if;
      if seedOut[2] == 0 then
        seedOut[2] := 1;
      end if;
      if seedOut[3] == 0 then
        seedOut[3] := 1;
      end if;
      x := rem((seedOut[1]/30269.0 + seedOut[2]/30307.0 + seedOut[3]/30323.0), 1.0);

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.45,
          y=0.01,
          width=0.35,
          height=0.49),
        Documentation(info="<HTML>
<p>
<i>Random</i> generates a sequence of uniform distributed
pseudo-random numbers. The algorithm is a variant of the
multiplicative congruential algorithm, known as the
Wichmann-Hill generator:
<pre>    x(k) = (a1*x(k-1)) mod m1
    y(k) = (a2*y(k-1)) mod m2
    z(k) = (a3*z(k-1)) mod m3
    U(k) = (x(k)/m1 + y(k)/m2 + z(k)/m3) mod 1
</pre>
This generates pseudo-random numbers U(k) uniformly distributed
in the interval (0,1). There are many forms of generators depending
on the parameters m (prime numbers) and a. The sequence needs an
initial Integer vector {x,y,z} known as the seed. The use of the same
seed will lead to the same sequence of numbers. 
</p>
<p>
<b>Remarks</b>
</p>
<p>Random number generators (RNG) are pseudo-functions which are not true
functions but algorithms which deliver a fixed sequence of (usually Integer) numbers
which should have a very large period before they repeat itself and
appropriate statistic properties such that the sequence appears to be
a random draw. For real-valued random numbers, the integers are scaled to
the real interval 0.0-1.0. They result in a uniformly distributed random variate
between 0-1, which has to be tranformed to give a random variate of a wanted
distribution. There are two types of techniques for transforming random variates:
</p>
<ul>
<li>Acceptance-Rejection techniques</li>
<li>Transformation techniques</li>
</ul>
<p>Acceptance-Rejection techniques throw away some of the generated variates and are thus less efficient. They can not be avoided for all distributions. A good summary about random number generation and most of the transformation techniques used below is given in:</p>
 <address> Discrete Event Simulation <br>
 Jerry Banks and John S. Carson II<br>
 Prentice Hall Inc.<br>
 Englewood Cliffs, New Jersey<br>
 </address>
<p>Some of the other references are quoted below.</p>
<pre>
        WICHMANN-HILL RANDOM NUMBER GENERATOR
        Wichmann, B. A. & Hill, I. D. (1982)
          Algorithm AS 183:
          An efficient and portable pseudo-random number generator
          Applied Statistics 31 (1982) 188-190
        see also:
          Correction to Algorithm AS 183
          Applied Statistics 33 (1984) 123
        McLeod, A. I. (1985)
          A remark on Algorithm AS 183
          Applied Statistics 34 (1985),198-200
        In order to completely avoid external functions, all seeds are
        set via parameters. For simulation purposes this is almost
        always the desired behaviour.
        Translated by Hubertus Tummescheit from Python source provided by
        Guido van Rossum translated from C source by Adrian Baddeley.
        http://www.python.org/doc/current/lib/module-random.html
        R A N D O M   V A R I A B L E   G E N E R A T O R S
        distributions on the real line:
        ------------------------------
            normal (Gaussian) 2 versions
</pre>
<h4>Reference Literature:</h4>
<ul>
<li>function random: Wichmann, B. A. & Hill, I. D. (1982), Algorithm AS 183:
  <br>
  An efficient and portable pseudo-random number generator, Applied Statistics 31 (1982) 188-190<br>
  see also: Correction to Algorithm AS 183, Applied Statistics 33 (1984) 123 <br>
  McLeod, A. I. (1985), A remark on Algorithm AS 183, Applied Statistics 34 (1985),198-200</li>
<li>function normalvariate: Kinderman, A.J. and Monahan, J.F., 'Computer generation of random
  variables using the ratio of uniform deviates', ACM Trans Math Software, 3, (1977),
  pp257-260.</li>
<li>function gaussianvariate: Discrete Event Simulation, Jerry Banks and John S. Carson II,
<br>
  Prentice Hall Inc. Englewood Cliffs, New Jersey, page 315/316</li>
</ul>
<p>
Copyright &copy; Hubertus Tummescheit and Department of Automatic Control, Lund University, Sweden.
</p>
<p>
<i>This Modelica function is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
</HTML>
"));
    end GoodRandom;

    model testGoodRandom

    parameter Integer[3] seed_vector( start={1,2,3});
    Integer[3] rand_vector;
    Integer[3] pre_rand_vector;
    output Real   x;

    algorithm
      when initial() then
        rand_vector:=seed_vector;
      end when;

    when  sample(0, 1) then

      pre_rand_vector:=pre(rand_vector);
        (x,rand_vector):=GoodRandom(pre_rand_vector);

    end when;
    end testGoodRandom;
    annotation (
      Coordsys(
        extent=[0, 0; 313, 206],
        grid=[2, 2],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern=1)),
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-90, 40; 70, 10],
          string="Unites",
          style(
            color=9,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-32, -6; 16, -35], style(color=0)),
        Rectangle(extent=[-32, -56; 16, -85], style(color=0)),
        Line(points=[16, -20; 49, -20; 49, -71; 16, -71], style(color=0)),
        Line(points=[-32, -72; -64, -72; -64, -21; -32, -21], style(color=0)),
        Text(
          extent=[-120, 135; 120, 70],
          string="%name",
          style(color=1))),
      Window(
        x=0.05,
        y=0.26,
        width=0.25,
        height=0.25,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<p><b>Version 1.1</b></p>
</HTML>
"));
  end trials;

  annotation (uses(Modelica(version="3.2")));
end HeatedRoom;
