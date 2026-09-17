within ;
encapsulated package testOM
  import Modelica;

  model test "Trifase con switches ideali individuali OM dev490 BAD"
    parameter Real Rf=0.125;
    parameter Real Lf=0.001;
    parameter Real Cf=0.000634;
    parameter Real Rld=30.0;
    Modelica.Blocks.Sources.Constant ampl[3](k=0.7) annotation (Placement(
          visible=true, transformation(
          origin={78,70},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    Modelica.Blocks.Sources.Constant phase[3](k=-array(120*(j - 1) for j in 1:3))
      annotation (Placement(visible=true, transformation(
          origin={55,49},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V=100) annotation (
        Placement(visible=true, transformation(
          origin={-94,20},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    PwmPulser pwmPulser[3] annotation (Placement(visible=true, transformation(
          origin={18,56},
          extent={{-13,13},{13,-13}},
          rotation=180)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S1 annotation (
        Placement(visible=true, transformation(
          origin={-74,60},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S5 annotation (
        Placement(visible=true, transformation(
          origin={-34,60},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S4 annotation (
        Placement(visible=true, transformation(
          origin={-74,-20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S6 annotation (
        Placement(visible=true, transformation(
          origin={-54,-20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S2 annotation (
        Placement(visible=true, transformation(
          origin={-34,-20},
          extent={{-10,-10},{10,10}},
          rotation=-90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch S3 annotation (
        Placement(visible=true, transformation(
          origin={-54,60},
          extent={{-10,-15},{10,15}},
          rotation=-90)));
    Modelica.Electrical.Analog.Basic.Resistor Rf1(R=Rf)
      annotation (Placement(transformation(extent={{4,14},{24,34}})));
    Modelica.Electrical.Analog.Basic.Inductor Lf1(L=Lf)
      annotation (Placement(transformation(extent={{30,14},{50,34}})));
    Modelica.Electrical.Analog.Basic.Capacitor Ff1(C=Cf) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={62,14})));
    Modelica.Electrical.Analog.Basic.Resistor Rld1(R=Rld) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,15})));
    Modelica.Electrical.Analog.Basic.Resistor Rf2(R=Rf)
      annotation (Placement(transformation(extent={{1,-20},{21,0}})));
    Modelica.Electrical.Analog.Basic.Inductor Lf2(L=Lf)
      annotation (Placement(transformation(extent={{27,-20},{47,0}})));
    Modelica.Electrical.Analog.Basic.Capacitor Ff2(C=Cf) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={59,-20})));
    Modelica.Electrical.Analog.Basic.Resistor Rld2(R=Rld) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={81,-19})));
    Modelica.Electrical.Analog.Basic.Resistor Rf3(R=Rf)
      annotation (Placement(transformation(extent={{3,-54},{23,-34}})));
    Modelica.Electrical.Analog.Basic.Inductor Lf3(L=Lf)
      annotation (Placement(transformation(extent={{29,-54},{49,-34}})));
    Modelica.Electrical.Analog.Basic.Capacitor Ff3(C=Cf) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={61,-54})));
    Modelica.Electrical.Analog.Basic.Resistor Rld3(R=Rld) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={83,-53})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{110,-47},{130,-27}})));
  equation
    connect(S1.n, S4.p) annotation (Line(
        points={{-74,50},{-74,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S3.n, S6.p) annotation (Line(
        points={{-54,50},{-54,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S5.n, S2.p) annotation (Line(
        points={{-34,50},{-34,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S5.p, S1.p) annotation (Line(
        points={{-34,70},{-34,79},{-74,79},{-74,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S3.p, S1.p) annotation (Line(
        points={{-54,70},{-54,79},{-74,79},{-74,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S4.n, S2.n) annotation (Line(
        points={{-74,-30},{-74,-40},{-34,-40},{-34,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(S6.n, S2.n) annotation (Line(
        points={{-54,-30},{-54,-40},{-34,-40},{-34,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[1].up, S1.control) annotation (Line(
        points={{3.7,64.58},{-8,64.58},{-8,74},{-67,74},{-67,60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[2].up, S3.control) annotation (Line(
        points={{3.7,64.58},{-16,64.58},{-16,67},{-43.5,67},{-43.5,60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[3].up, S5.control) annotation (Line(
        points={{3.7,64.58},{-15,64.58},{-15,60},{-27,60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[1].down, S4.control) annotation (Line(
        points={{3.7,48.46},{-5,48.46},{-5,-36},{-67,-36},{-67,-20}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[2].down, S6.control) annotation (Line(
        points={{3.7,48.46},{-5,48.46},{-5,-36},{-47,-36},{-47,-20}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(pwmPulser[3].down, S2.control) annotation (Line(
        points={{3.7,48.46},{-5,48.46},{-5,-36},{-27,-36},{-27,-20}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(V1.p, S1.p) annotation (Line(
        points={{-94,30},{-94,80},{-73,80},{-73,79},{-74,79},{-74,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(V1.n, S2.n) annotation (Line(
        points={{-94,10},{-94,-41},{-73,-41},{-73,-39},{-74,-39},{-74,-40},{-34,
            -40},{-34,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rf1.n, Lf1.p) annotation (Line(
        points={{24,24},{30,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Lf1.n, Ff1.p) annotation (Line(
        points={{50,24},{62,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rld1.p, Ff1.p) annotation (Line(
        points={{84,25},{62,25},{62,24}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rf2.n, Lf2.p) annotation (Line(
        points={{21,-10},{27,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Lf2.n, Ff2.p) annotation (Line(
        points={{47,-10},{59,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rld2.p, Ff2.p) annotation (Line(
        points={{81,-9},{71,-9},{71,-10},{59,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rf3.n, Lf3.p) annotation (Line(
        points={{23,-44},{29,-44}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Lf3.n, Ff3.p) annotation (Line(
        points={{49,-44},{61,-44}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rld3.p, Ff3.p) annotation (Line(
        points={{83,-43},{73,-43},{73,-44},{61,-44}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rf1.p, S4.p) annotation (Line(
        points={{4,24},{4,24},{-14,24},{-14,24},{-14,37},{-74,37},{-74,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rf2.p, S6.p) annotation (Line(
        points={{1,-10},{-7,-10},{-7,-10},{-14,-10},{-14,14},{-54,14},{-54,-10}},

        color={0,0,255},
        smooth=Smooth.None));

    connect(Rf3.p, S2.p) annotation (Line(
        points={{3,-44},{3,-22},{-21,-22},{-21,4},{-34,4},{-34,-10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Ff1.n, Rld1.n) annotation (Line(
        points={{62,4},{62,5},{84,5}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, Rld1.n) annotation (Line(
        points={{120,-27},{120,5},{84,5}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, Rld2.n) annotation (Line(
        points={{120,-27},{102,-27},{102,-29},{81,-29}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rld2.n, Ff2.n) annotation (Line(
        points={{81,-29},{71,-29},{71,-30},{59,-30}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ground.p, Rld3.n) annotation (Line(
        points={{120,-27},{106,-27},{106,-63},{83,-63}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Rld3.n, Ff3.n) annotation (Line(
        points={{83,-63},{73,-63},{73,-64},{61,-64}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(ampl.y, pwmPulser.ampl) annotation (Line(points={{67,70},{55,70},{
            41,70},{41,64.32},{33.6,64.32}}, color={0,0,127}));
    connect(phase.y, pwmPulser.ph_deg) annotation (Line(points={{44,49},{40,49},
            {40,48.98},{33.6,48.98}}, color={0,0,127}));
    annotation (
      experimentSetupOutput,
      Documentation(info="<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=0.1,
        Tolerance=0.0001),
      Diagram(coordinateSystem(
          extent={{-100,-80},{140,100}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={1,1})),
      Icon(coordinateSystem(
          extent={{-100,-80},{140,100}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={1,1})));
  end test;

  model PwmPulser
    Modelica.Blocks.Interfaces.RealInput ampl annotation (Placement(
          transformation(extent={{-140,40},{-100,80}}), iconTransformation(
            extent={{-140,44},{-100,84}})));
    Modelica.Blocks.Interfaces.RealInput ph_deg annotation (Placement(
          transformation(extent={{-138,-76},{-98,-36}}), iconTransformation(
            extent={{-140,-74},{-100,-34}})));
    parameter Real Fcar=1000 "Carrier Frequency";
    import PI = Modelica.Constants.pi;
  protected
    Modelica.Blocks.Sources.Trapezoid carrier(
      rising=1/(2*Fcar),
      width=0,
      falling=1/(2*Fcar),
      period=1/Fcar,
      amplitude=2,
      offset=-1)
      annotation (Placement(transformation(extent={{14,-56},{34,-36}})));
    Modelica.Blocks.Math.Sin sin
      annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-50,16},{-32,34}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=2*PI*Fmod)
      annotation (Placement(transformation(extent={{-90,14},{-64,36}})));
  public
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-54,-28},{-34,-8}})));
    Modelica.Blocks.Math.Gain ToRAD(k=PI/180)
      annotation (Placement(transformation(extent={{-66,-62},{-54,-50}})));
    Modelica.Blocks.Math.Product moduler
      annotation (Placement(transformation(extent={{14,-22},{32,-4}})));
    Modelica.Blocks.Interfaces.BooleanOutput up annotation (Placement(
          transformation(extent={{100,10},{120,30}}), iconTransformation(extent
            ={{100,56},{120,76}})));
    Modelica.Blocks.Logical.Greater greater
      annotation (Placement(transformation(extent={{46,-24},{66,-4}})));
    Modelica.Blocks.Interfaces.BooleanOutput down annotation (Placement(
          transformation(extent={{100,-62},{120,-42}}), iconTransformation(
            extent={{100,-68},{120,-48}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
    parameter Real Fmod=50 "Moduler Frequency";
  equation
    connect(ToRAD.u, ph_deg) annotation (Line(
        points={{-67.2,-56},{-118,-56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(sin.u, add.y) annotation (Line(
        points={{-22,-18},{-33,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(moduler.u2, sin.y) annotation (Line(
        points={{12.2,-18.4},{14,-18.4},{14,-18},{1,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.u1, integrator.y) annotation (Line(
        points={{-56,-12},{-64,-12},{-64,2},{-24,2},{-24,25},{-31.1,25}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(moduler.u1, ampl) annotation (Line(
        points={{12.2,-7.6},{12.2,60},{-120,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.u2, ToRAD.y) annotation (Line(
        points={{-56,-24},{-64,-24},{-64,-34},{-46,-34},{-46,-56},{-53.4,-56}},

        color={0,0,127},
        smooth=Smooth.None));

    connect(greater.u1, moduler.y) annotation (Line(
        points={{44,-14},{46.45,-14},{46.45,-13},{32.9,-13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(greater.u2, carrier.y) annotation (Line(
        points={{44,-22},{44,-46},{35,-46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(up, greater.y) annotation (Line(
        points={{110,20},{74,20},{74,-14},{67,-14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.y, down) annotation (Line(
        points={{81,-50},{84,-50},{84,-52},{110,-52}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(not1.u, greater.y) annotation (Line(
        points={{58,-50},{52,-50},{52,-32},{74,-32},{74,-14},{67,-14}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(integrator.u, realExpression.y) annotation (Line(
        points={{-51.8,25},{-62.7,25}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})), Icon(graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Text(
            extent={{-100,88},{-42,60}},
            lineColor={0,0,127},
            textString="ampl"),
          Text(
            extent={{-98,-62},{-28,-88}},
            lineColor={0,0,127},
            textString="ph(?)"),
          Text(
            extent={{28,86},{100,60}},
            lineColor={255,0,255},
            textString="u"),
          Text(
            extent={{42,-62},{96,-88}},
            lineColor={255,0,255},
            textString="d",
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-60,-60},{-40,62},{-20,-60},{0,60},{20,-62},{40,60},{60,-62},
                {80,58}},
            color={0,0,127},
            smooth=Smooth.None),
          Line(
            points={{-80,20},{-38,40},{0,44},{42,40},{80,20}},
            color={0,0,127},
            smooth=Smooth.None,
            thickness=0.5)}));
  end PwmPulser;

  annotation (uses(Modelica(version="3.2.1")));
end testOM;
