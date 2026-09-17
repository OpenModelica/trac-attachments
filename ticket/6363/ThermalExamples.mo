within ;
package ThermalExamples
  extends Modelica.Icons.Package;
  package Examples
    extends Modelica.Icons.ExamplesPackage;
    partial model PartialBoiler
      Modelica.Electrical.Analog.Basic.Resistor resistor(
        R=7.5,
        T_ref=293.15,
        alpha=0.004,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{40,10},{60,30}})));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=sqrt(2)*230, f=
            50) annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={80,30})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=700, T(
            fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={30,0})));
      Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=
            0.0015) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,-20})));
      Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.03,
        T0=293.15,
        T0fixed=true,
        V_flowLaminar(displayUnit="l/min") = 3.3333333333333e-05,
        dpLaminar=1000,
        V_flowNominal(displayUnit="l/min") = 6.6666666666667e-05,
        dpNominal=10000,
        useHeatPort=true,
        h_g=0) annotation (Placement(transformation(extent={{40,-40},{60,-60}})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        constantAmbientPressure=100000,
        constantAmbientTemperature=293.15)
        annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
      Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.03,
        T0=293.15,
        T0fixed=true,
        constantVolumeFlow(displayUnit="l/min") = 6.3333333333333e-05)
        annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
      Modelica.Thermal.FluidHeatFlow.Sensors.TemperatureSensor temperatureSensor(
          medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,-60})));
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        constantAmbientPressure=100000,
        constantAmbientTemperature=293.15)
        annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
    equation
      connect(sineVoltage.n, ground.p)
        annotation (Line(points={{60,40},{70,40},{70,30}}, color={0,0,255}));
      connect(ground.p, resistor.n)
        annotation (Line(points={{70,30},{70,20},{60,20}}, color={0,0,255}));
      connect(resistor.heatPort, thermalResistor.port_a)
        annotation (Line(points={{50,10},{50,-10}},color={191,0,0}));
      connect(thermalResistor.port_b, pipe.heatPort)
        annotation (Line(points={{50,-30},{50,-40}}, color={191,0,0}));
      connect(pipe.flowPort_a, volumeFlow.flowPort_b)
        annotation (Line(points={{40,-50},{30,-50}}, color={255,0,0}));
      connect(ambient1.flowPort, volumeFlow.flowPort_a)
        annotation (Line(points={{0,-50},{10,-50}},    color={255,0,0}));
      connect(pipe.flowPort_b, ambient2.flowPort)
        annotation (Line(points={{60,-50},{80,-50}}, color={255,0,0}));
      connect(pipe.flowPort_b, temperatureSensor.flowPort)
        annotation (Line(points={{60,-50},{70,-50}},          color={255,0,0}));
      connect(resistor.heatPort, heatCapacitor.port)
        annotation (Line(points={{50,10},{50,0},{40,0}},   color={191,0,0}));
    end PartialBoiler;

    model BoilerMaxT
      extends Modelica.Icons.Example;
      extends PartialBoiler;
    equation
      connect(sineVoltage.p, resistor.p) annotation (Line(points={{40,40},{30,
              40},{30,20},{40,20}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerMaxT;

    model BoilerOnOff
      extends Modelica.Icons.Example;
      extends PartialBoiler;
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={30,30})));
      Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2,
          pre_y_start=false)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=15,
        duration=15,
        offset=20,
        startTime=5)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      Blocks.K2deg k2deg annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,-50})));
    equation
      connect(onOffController.y, switch.control)
        annotation (Line(points={{1,30},{18,30}},   color={255,0,255}));
      connect(ramp.y, onOffController.reference) annotation (Line(points={{-49,40},{
              -40,40},{-40,36},{-22,36}},  color={0,0,127}));
      connect(k2deg.y, onOffController.u) annotation (Line(points={{-40,-39},{
              -40,24},{-22,24}}, color={0,0,127}));
      connect(switch.p, sineVoltage.p)
        annotation (Line(points={{30,40},{40,40}}, color={0,0,255}));
      connect(switch.n, resistor.p)
        annotation (Line(points={{30,20},{40,20}}, color={0,0,255}));
      connect(temperatureSensor.y, k2deg.u) annotation (Line(points={{70,-71},{
              70,-76},{-40,-76},{-40,-62}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerOnOff;

    model BoilerTriac
      extends Modelica.Icons.Example;
      extends PartialBoiler;
      Modelica.Blocks.Sources.Ramp ramp(
        height=15,
        duration=15,
        offset=20,
        startTime=5)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Blocks.K2deg k2deg annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-50})));
      Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac triac
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,30})));
      Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse adaptor(m=
            1, useConstantFiringAngle=false) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,30})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
        annotation (Placement(transformation(extent={{40,70},{60,50}})));
      Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle
        voltageToAngle(VNominal=230, voltage2Angle=Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.RMS)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=100,
        Ti=4,
        yMax=230,
        yMin=0)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
    equation
      connect(adaptor.fire_p[1], triac.fire1)
        annotation (Line(points={{11,36},{18,36}}, color={255,0,255}));
      connect(adaptor.fire_n[1], triac.fire2)
        annotation (Line(points={{11,24},{18,24}}, color={255,0,255}));
      connect(voltageSensor.v, adaptor.v[1]) annotation (Line(points={{50,71},{
              50,80},{0,80},{0,42}}, color={0,0,127}));
      connect(voltageToAngle.firingAngle, adaptor.firingAngle)
        annotation (Line(points={{-19,30},{-12,30}}, color={0,0,127}));
      connect(k2deg.y, PID.u_m)
        annotation (Line(points={{-60,-39},{-60,18}},color={0,0,127}));
      connect(ramp.y, PID.u_s)
        annotation (Line(points={{-79,30},{-72,30}}, color={0,0,127}));
      connect(PID.y, voltageToAngle.vRef)
        annotation (Line(points={{-49,30},{-42,30}}, color={0,0,127}));
      connect(triac.p, sineVoltage.p)
        annotation (Line(points={{30,40},{40,40}}, color={0,0,255}));
      connect(triac.n, resistor.p)
        annotation (Line(points={{30,20},{40,20}}, color={0,0,255}));
      connect(sineVoltage.p, voltageSensor.p)
        annotation (Line(points={{40,40},{40,60}}, color={0,0,255}));
      connect(sineVoltage.n, voltageSensor.n)
        annotation (Line(points={{60,40},{60,60}}, color={0,0,255}));
      connect(temperatureSensor.y, k2deg.u) annotation (Line(points={{70,-71},{
              70,-76},{-60,-76},{-60,-62}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerTriac;

    model FMUBoilerTriac
      extends PartialBoiler;
      Blocks.K2deg k2deg annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-50})));
      Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac triac
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,30})));
      Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse adaptor(m=
            1, useConstantFiringAngle=false) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,30})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
        annotation (Placement(transformation(extent={{40,70},{60,50}})));
      Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle
        voltageToAngle(VNominal=230, voltage2Angle=Modelica.Electrical.PowerConverters.Types.Voltage2AngleType.RMS)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Interfaces.RealOutput Tout
        "Connector of Real output signal" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-80,-20}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={110,0})));
      Modelica.Blocks.Interfaces.RealInput vRef "Reference voltage" annotation (
         Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-80,30}),
            iconTransformation(extent={{-140,-20},{-100,20}})));
    equation
      connect(adaptor.fire_p[1], triac.fire1)
        annotation (Line(points={{11,36},{18,36}}, color={255,0,255}));
      connect(adaptor.fire_n[1], triac.fire2)
        annotation (Line(points={{11,24},{18,24}}, color={255,0,255}));
      connect(voltageSensor.v, adaptor.v[1]) annotation (Line(points={{50,71},{
              50,80},{0,80},{0,42}}, color={0,0,127}));
      connect(voltageToAngle.firingAngle, adaptor.firingAngle)
        annotation (Line(points={{-19,30},{-12,30}}, color={0,0,127}));
      connect(triac.p, sineVoltage.p)
        annotation (Line(points={{30,40},{40,40}}, color={0,0,255}));
      connect(triac.n, resistor.p)
        annotation (Line(points={{30,20},{40,20}}, color={0,0,255}));
      connect(sineVoltage.p, voltageSensor.p)
        annotation (Line(points={{40,40},{40,60}}, color={0,0,255}));
      connect(sineVoltage.n, voltageSensor.n)
        annotation (Line(points={{60,40},{60,60}}, color={0,0,255}));
      connect(temperatureSensor.y, k2deg.u) annotation (Line(points={{70,-71},{
              70,-76},{-60,-76},{-60,-62}}, color={0,0,127}));
      connect(k2deg.y, Tout)
        annotation (Line(points={{-60,-39},{-60,-20},{-80,-20}},
                                                       color={0,0,127}));
      connect(voltageToAngle.vRef, vRef)
        annotation (Line(points={{-42,30},{-80,30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end FMUBoilerTriac;

    model BoilerSampled
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Ramp ramp(
        height=15,
        duration=15,
        offset=20,
        startTime=5)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=100,
        Ti=4,
        yMax=230,
        yMin=0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      FMUBoilerTriac fMUBoilerTriac
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler1(y_start=20)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler2(y_start=0)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler3(y_start=20)
        annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
      Modelica.Blocks.Sources.SampleTrigger sampleTrigger(period=0.02)
        annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
    equation
      connect(ramp.y, triggeredSampler1.u)
        annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
      connect(triggeredSampler1.y, PID.u_s)
        annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
      connect(PID.y, triggeredSampler2.u)
        annotation (Line(points={{11,0},{18,0}},
                                               color={0,0,127}));
      connect(triggeredSampler2.y, fMUBoilerTriac.vRef)
        annotation (Line(points={{41,0},{58,0}}, color={0,0,127}));
      connect(fMUBoilerTriac.Tout, triggeredSampler3.u) annotation (Line(points={{81,0},{
              90,0},{90,-20},{62,-20}},         color={0,0,127}));
      connect(triggeredSampler3.y, PID.u_m) annotation (Line(points={{39,-20},{
              0,-20},{0,-12}},     color={0,0,127}));
      connect(sampleTrigger.y, triggeredSampler1.trigger) annotation (Line(
            points={{-69,-40},{-50,-40},{-50,-11.8}}, color={255,0,255}));
      connect(sampleTrigger.y, triggeredSampler2.trigger) annotation (Line(
            points={{-69,-40},{30,-40},{30,-11.8}}, color={255,0,255}));
      connect(sampleTrigger.y, triggeredSampler3.trigger) annotation (Line(
            points={{-69,-40},{50,-40},{50,-31.8}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerSampled;

    model BoilerClocked
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Ramp ramp(
        height=15,
        duration=15,
        offset=20,
        startTime=5)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=100,
        Ti=4,
        yMax=230,
        yMin=0)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      FMUBoilerTriac fMUBoilerTriac
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                sample1
        annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
      Modelica.Clocked.RealSignals.Sampler.Hold hold2
        annotation (Placement(transformation(extent={{24,-6},{36,6}})));
      Modelica.Clocked.RealSignals.Sampler.Sample sample3
        annotation (Placement(transformation(extent={{56,-26},{44,-14}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period=0.02,
        useSolver=true,
        solverMethod="ImplicitEuler")
        annotation (Placement(transformation(extent={{-86,-36},{-74,-24}})));
    equation
      connect(ramp.y, sample1.u)
        annotation (Line(points={{-69,0},{-57.2,0}}, color={0,0,127}));
      connect(sample1.y, PID.u_s)
        annotation (Line(points={{-43.4,0},{-12,0}}, color={0,0,127}));
      connect(PID.y, hold2.u)
        annotation (Line(points={{11,0},{22.8,0}},color={0,0,127}));
      connect(hold2.y, fMUBoilerTriac.vRef)
        annotation (Line(points={{36.6,0},{58,0}}, color={0,0,127}));
      connect(fMUBoilerTriac.Tout, sample3.u) annotation (Line(points={{81,0},{
              90,0},{90,-20},{57.2,-20}}, color={0,0,127}));
      connect(sample3.y, PID.u_m) annotation (Line(points={{43.4,-20},{0,-20},{
              0,-12}},    color={0,0,127}));
      connect(periodicClock1.y, sample1.clock) annotation (Line(
          points={{-73.4,-30},{-50,-30},{-50,-7.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerClocked;

    model BoilerDiscrete
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Ramp ramp(
        height=15,
        duration=15,
        offset=20,
        startTime=5)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Clocked.RealSignals.NonPeriodic.PI
                                        PI1(
        k=100,
        T=4,
        x(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      FMUBoilerTriac fMUBoilerTriac
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                sample1
        annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
      Modelica.Clocked.RealSignals.Sampler.Hold hold2
        annotation (Placement(transformation(extent={{24,-6},{36,6}})));
      Modelica.Clocked.RealSignals.Sampler.Sample sample3
        annotation (Placement(transformation(extent={{56,-26},{44,-14}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(period=0.02,
        useSolver=false,
        solverMethod="ImplicitEuler")
        annotation (Placement(transformation(extent={{-86,-36},{-74,-24}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    equation
      connect(ramp.y, sample1.u)
        annotation (Line(points={{-69,0},{-57.2,0}}, color={0,0,127}));
      connect(PI1.y, hold2.u)
        annotation (Line(points={{11,0},{22.8,0}},color={0,0,127}));
      connect(hold2.y, fMUBoilerTriac.vRef)
        annotation (Line(points={{36.6,0},{58,0}}, color={0,0,127}));
      connect(fMUBoilerTriac.Tout, sample3.u) annotation (Line(points={{81,0},{
              90,0},{90,-20},{57.2,-20}}, color={0,0,127}));
      connect(periodicClock1.y, sample1.clock) annotation (Line(
          points={{-73.4,-30},{-50,-30},{-50,-7.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample1.y, feedback.u1)
        annotation (Line(points={{-43.4,0},{-38,0}}, color={0,0,127}));
      connect(feedback.y, PI1.u)
        annotation (Line(points={{-21,0},{-12,0}}, color={0,0,127}));
      connect(sample3.y, feedback.u2) annotation (Line(points={{43.4,-20},{-30,
              -20},{-30,-8}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=30,
          Interval=0.0005,
          Tolerance=1e-06,
          __Dymola_Algorithm="Dassl"));
    end BoilerDiscrete;
  end Examples;

  package Blocks
    extends Modelica.Icons.Package;
    block K2deg
      extends Modelica.Blocks.Interfaces.SISO;
      import Modelica.Units.Conversions.to_degC;
    equation
      y=to_degC(u);
    end K2deg;
  end Blocks;
  annotation (uses(Modelica(version="4.0.0")));
end ThermalExamples;
