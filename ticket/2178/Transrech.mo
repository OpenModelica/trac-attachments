within ;
package Transrech
  model Modell
  parameter Modelica.SIunits.Voltage U_dc_soll = 750;
  parameter Modelica.SIunits.Inductance L_load = 20e-3;
  parameter Modelica.SIunits.Capacitance C_load = 5e-3;
  parameter Boolean enableBremsChopper = true;

   Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent={{-100,
              -20},{-80,0}})));
   Modelica.Electrical.Analog.Sources.SignalCurrent I_Q           annotation(Placement(transformation(
    origin={-90,30},
    extent={{-10,-10},{10,10}},
    rotation=90)));
   Modelica.Electrical.Analog.Basic.Capacitor C1(                          C=10e-3, v(fixed=
            true, start=750))
             annotation(Placement(transformation(
    origin={-54,26},
    extent={{10,-10},{-10,10}},
    rotation=90)));
   Modelica.Electrical.Analog.Basic.Inductor L1(
            i(fixed=true, start=0), L=L_load)
            annotation(Placement(transformation(extent={{-20,60},{0,80}})));
   Modelica.Electrical.Analog.Basic.Capacitor C2(         v(fixed=true, start=750), C=
          C_load)
             annotation(Placement(transformation(
    origin={10,28},
    extent={{10,-10},{-10,10}},
    rotation=90)));
   Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(transformation(
    origin={-30,30},
    extent={{10,-10},{-10,10}},
    rotation=90)));
   Modelica.Blocks.Continuous.PI U_Reg(
      initType=Modelica.Blocks.Types.Init.InitialState,
      x_start=0,
      k=9.816719,
      T=5.067408e-002)
           annotation(Placement(transformation(extent={{-40,-80},{-20,-60}})));
   Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-70,-80},
              {-50,-60}})));
   Modelica.Electrical.Analog.Sources.SignalCurrent I_L            annotation(Placement(transformation(
    origin={80,30},
    extent={{10,10},{-10,-10}},
    rotation=90)));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=2000)
      annotation (Placement(transformation(extent={{50,-80},{70,-60}})));
    Modelica.Electrical.Analog.Basic.Resistor R1(v(start=0), R=20e-3) annotation (
       Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-54,52})));
    Modelica.Electrical.Analog.Basic.Resistor R2(R=20e-3) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={10,54})));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch(Ron=1)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={52,46})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(
      pre_y_start=false,
      uLow=850,
      uHigh=900)
      annotation (Placement(transformation(extent={{82,76},{102,96}})));
   Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1
                                                                  annotation(Placement(transformation(
    origin={30,40},
    extent={{10,-10},{-10,10}},
    rotation=90)));
    Modelica.Blocks.Continuous.FirstOrder stromVerzoegerung(
      k=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0,
      T=5e-3) annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
    Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=0.5e-3)
      annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
   Modelica.Blocks.Math.Feedback feedback1 annotation(Placement(transformation(extent={{-10,-80},
              {10,-60}})));
   Modelica.Blocks.Continuous.PI I_Reg(
      initType=Modelica.Blocks.Types.Init.InitialState,
      x_start=0,
      k=8.705430,
      T=2.559267e-003)
             annotation(Placement(transformation(extent={{20,-80},{40,-60}})));
   Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-82,60},
              {-62,80}})));
    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{140,10},{100,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=U_dc_soll)
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{104,50},{84,70}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
          enableBremsChopper)
      annotation (Placement(transformation(extent={{140,42},{120,62}})));
  equation
    connect(ground.p, I_Q.p)          annotation(Line(points={{-90,0},{-90,20}}));
    connect(feedback.y,U_Reg.u) annotation(Line(
     points={{-51,-70},{-42,-70}},
     color={0,0,127}));
    connect(voltageSensor.v,feedback.u2) annotation(Line(
     points={{-20,30},{-10,30},{-10,4},{100,4},{100,-100},{-60,-100},{-60,-78}},
     color={0,0,127}));
    connect(voltageSensor.p,L1.p) annotation(Line(points={{-30,40},{-30,70},{
            -20,70}}));
    connect(I_L.p, L1.n)           annotation(Line(points={{80,40},{80,70},{0,
            70}}));
    connect(I_L.n, C2.n)           annotation(Line(points={{80,20},{80,10},{10,
            10},{10,18}}));
    connect(C2.n,voltageSensor.n) annotation(Line(points={{10,18},{10,10},{-30,
            10},{-30,20}}));
    connect(I_Q.p, C1.n)          annotation(Line(points={{-90,20},{-90,10},{
            -54,10},{-54,16}}));
    connect(C1.n,voltageSensor.n) annotation(Line(points={{-54,16},{-54,10},{
            -30,10},{-30,20}}));
    connect(C1.p, R1.n) annotation (Line(
        points={{-54,36},{-54,42}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(R2.n, C2.p) annotation (Line(
        points={{10,44},{10,38}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(R2.p, L1.n) annotation (Line(
        points={{10,64},{10,70},{0,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealClosingSwitch.p, R2.p) annotation (Line(
        points={{52,56},{52,70},{10,70},{10,64}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(idealClosingSwitch.n, C2.n) annotation (Line(
        points={{52,36},{52,10},{10,10},{10,18}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor1.p, R2.p) annotation (Line(
        points={{30,50},{30,70},{10,70},{10,64}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor1.n, C2.n) annotation (Line(
        points={{30,30},{30,10},{10,10},{10,18}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(voltageSensor1.v, hysteresis.u) annotation (Line(
        points={{40,40},{40,86},{80,86}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(stromVerzoegerung.y, I_Q.i) annotation (Line(
        points={{-11,-20},{-100,-20},{-100,30},{-97,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fixedDelay.y, stromVerzoegerung.u) annotation (Line(
        points={{29,-20},{12,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(limiter.y, fixedDelay.u) annotation (Line(
        points={{71,-70},{80,-70},{80,-20},{52,-20}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(U_Reg.y, feedback1.u1) annotation (Line(
        points={{-19,-70},{-8,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(feedback1.y, I_Reg.u) annotation (Line(
        points={{9,-70},{18,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(I_Reg.y, limiter.u) annotation (Line(
        points={{41,-70},{48,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(currentSensor.n, L1.p) annotation (Line(
        points={{-62,70},{-20,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(R1.p, currentSensor.n) annotation (Line(
        points={{-54,62},{-54,70},{-62,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(I_Q.n, currentSensor.p) annotation (Line(
        points={{-90,40},{-90,70},{-82,70}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(currentSensor.i, feedback1.u2) annotation (Line(
        points={{-72,60},{-72,-2},{92,-2},{92,-94},{0,-94},{0,-78}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(u, I_L.i) annotation (Line(
        points={{120,30},{87,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, feedback.u1) annotation (Line(
        points={{-79,-70},{-68,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hysteresis.y, and1.u1) annotation (Line(
        points={{103,86},{120,86},{120,60},{106,60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and1.y, idealClosingSwitch.control) annotation (Line(
        points={{83,60},{72,60},{72,46},{59,46}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(booleanExpression.y, and1.u2) annotation (Line(
        points={{119,52},{106,52}},
        color={255,0,255},
        smooth=Smooth.None));
   annotation (
    voltageSensor(v(flags=2)),
    currentSensor(i(flags=2)),
    Diagram(coordinateSystem(
     extent={{-120,-120},{160,120}},
     preserveAspectRatio=false), graphics),
    experiment(
     StopTime=2,
     StartTime=0),
        Commands(
          editCall=Design.Optimization.optimize(
              Design.Internal.Records.RecordsWithUnits.OptimizationSetup(
                Model="Vater",
                tunerParameters={Design.Internal.Records.RecordsWithUnits.TunerParameter(name="U_Reg.k", Value=10, min=0.01, max=10, unit="1"),
                                 Design.Internal.Records.RecordsWithUnits.TunerParameter(name="U_Reg.T", Value=0.1, min=1e-2, max=10, unit="s"),
                                 Design.Internal.Records.RecordsWithUnits.TunerParameter(name="I_Reg.k", Value=1, min=0.01, max=100, unit="1"),
                                 Design.Internal.Records.RecordsWithUnits.TunerParameter(name="I_Reg.T", Value=0.01, min=1e-3, max=10, unit="s")},
                caseParameters={Design.Internal.Records.RecordsWithUnits.CaseParameter(name="Uset", unit="V")},
                caseCriteria={Design.Internal.Records.RecordsWithUnits.Criterion(name="integratedSquaredDeviation.y", unit="")},
                caseNames={Design.Internal.Records.CaseName()},
                cases=[750],
                demands=[0.01],
                integrator=Design.Internal.Records.Integrator(stopTime=2)))
          "Finde optimale Reglerparameter"),
      Icon(coordinateSystem(extent={{-120,-120},{160,120}})));
  end Modell;

  package Versuche
    package RampeHoch
      model mitBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          startTime=1,
          offset=0,
          height=1600)
                    annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L_load=5e-3,
          C_load=15e-3)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L_load=2e-3,
          C_load=50e-3)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics),
          experiment(StopTime=5, Interval=0.001),
          __Dymola_experimentSetupOutput);
      end mitBremsChopper;

      model ohneBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          startTime=1,
          offset=0,
          height=1600)
                    annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L_load=5e-3,
          C_load=15e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L_load=2e-3,
          C_load=50e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics),
          experiment(StopTime=5, Interval=0.001),
          __Dymola_experimentSetupOutput);
      end ohneBremsChopper;
    end RampeHoch;

    package RampeRunter
      model mitBremsChopper
        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          height=-1600,
          offset=1600,
          startTime=1)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics));
      end mitBremsChopper;

      model ohneBremsChopper
        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          height=-1600,
          offset=1600,
          startTime=1)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics));
      end ohneBremsChopper;
    end RampeRunter;

    package RampeRunterNegativ
      model mitBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          height=-1600,
          startTime=1,
          offset=0) annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L_load=5e-3,
          C_load=15e-3)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L_load=2e-3,
          C_load=50e-3)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end mitBremsChopper;

      model ohneBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          height=-1600,
          startTime=1,
          offset=0) annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L_load=5e-3,
          C_load=15e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L_load=2e-3,
          C_load=50e-3,
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end ohneBremsChopper;
    end RampeRunterNegativ;

    package RampeHochNegativ
      model mitBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));

        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          startTime=1,
          height=1600,
          offset=-1600)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));

        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));

      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end mitBremsChopper;

      model ohneBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));

        Modelica.Blocks.Sources.Ramp ramp(
          duration=0.5,
          startTime=1,
          height=1600,
          offset=-1600)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));

        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));

      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end ohneBremsChopper;
    end RampeHochNegativ;

    package SprungRunter
      model mitBremsChopper
        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Step ramp(
          height=-1600,
          offset=1600,
          startTime=1)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics));
      end mitBremsChopper;

      model ohneBremsChopper
        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_1.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
        Modelica.Blocks.Sources.Step ramp(
          height=-1600,
          offset=1600,
          startTime=1)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_2.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=1600/
                DC1_3.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                  {{-100,-100},{100,100}}), graphics));
      end ohneBremsChopper;
    end SprungRunter;

    package SprungHochNegativ
      model mitBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));

        Modelica.Blocks.Sources.Step ramp(
          startTime=1,
          height=1600,
          offset=-1600)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));

        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.I_Reg.k))
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));

      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end mitBremsChopper;

      model ohneBremsChopper

        Modell DC1_1(
          U_dc_soll=750,
          L_load=20e-3,
          C_load=5e-3,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_1.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,56},{-30,76}})));

        Modelica.Blocks.Sources.Step ramp(
          startTime=1,
          height=1600,
          offset=-1600)
          annotation (Placement(transformation(extent={{30,56},{10,76}})));
        Modell DC1_2(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=5e-3,
          C_load=15e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_2.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));

        Modell DC1_3(
          U_dc_soll=750,
          L1(i(start=-1600)),
          stromVerzoegerung(initType=Modelica.Blocks.Types.Init.InitialOutput,
              y_start=-1600),
          L_load=2e-3,
          C_load=50e-3,
          U_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.U_Reg.k),
          I_Reg(initType=Modelica.Blocks.Types.Init.InitialState, x_start=-1600/DC1_3.I_Reg.k),
          enableBremsChopper=false)
          annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));

      equation
        connect(ramp.y, DC1_1.u) annotation (Line(
            points={{9,66},{-8,66},{-8,71},{-26,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_2.u) annotation (Line(
            points={{9,66},{-8,66},{-8,25},{-26,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(ramp.y, DC1_3.u) annotation (Line(
            points={{9,66},{-8,66},{-8,-13},{-26,-13}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics));
      end ohneBremsChopper;
    end SprungHochNegativ;
  end Versuche;
  annotation (uses(Modelica(version="3.2"), Design(version="1.0.2")));
end Transrech;
