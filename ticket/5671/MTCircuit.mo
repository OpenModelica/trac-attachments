within GFA_ThermoModel.IdealCoolantCircuitTRex.Circuits;
model MTCircuit
  extends PartialMTCircuit;

  parameter Modelica.SIunits.Temperature T_Env_Init(displayUnit = "K") = 298.8 "Initial environment temperature";

  Modelica.Blocks.Sources.Constant f_fan(k=0)
    annotation (Placement(transformation(extent={{-152,44},{-140,56}})));
  Modelica.Blocks.Sources.Constant f_radiator(k=0)
    annotation (Placement(transformation(extent={{-152,24},{-140,36}})));

  Modelica.Blocks.Sources.Constant f_pump(
                                         k=0)
    annotation (Placement(transformation(extent={{-52,-26},{-40,-14}})));
  IdealCoolantFlow.Components.IdealCoolantPump pump(T(start=env.T))
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Controller.FlowControllerMTCircuit controller
    annotation (Placement(transformation(extent={{-70,-130},{-50,-110}})));
  IdealCoolantFlow.Components.CoolantSink coolantSink
    annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
  IdealCoolantFlow.Components.IdealPipeHeatCapacityWithHeatTransferCpInCpOut
    pipeInvGen(T(start=env.T, fixed=true))
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  IdealCoolantFlow.Components.IdealPipeHeatCapacityWithHeatTransferCpInCpOut
    pipeInvMotor(T(start=env.T, fixed=true))
    annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  IdealCoolantFlow.Components.IdealPipeHeatCapacityWithHeatTransferCpInCpOut
    pipeGenerator(T(start=env.T, fixed=true))
    annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  IdealCoolantFlow.Components.IdealPipeHeatCapacityWithHeatTransferCpInCpOut
    pipeMotor(T(start=env.T, fixed=true))
    annotation (Placement(transformation(extent={{-80,40},{-100,60}})));
  HeatSources.ElectricMachineHeatFlow motor(T_Init=env.T)
    annotation (Placement(transformation(extent={{-100,90},{-80,70}})));
  HeatSources.ElectricMachineHeatFlow generator
    annotation (Placement(transformation(extent={{-60,90},{-40,70}})));
  HeatSources.InverterHeatFlow inverterMotor
    annotation (Placement(transformation(extent={{-20,90},{0,70}})));
  HeatSources.InverterHeatFlow inverterGenerator
    annotation (Placement(transformation(extent={{20,90},{40,70}})));
  IdealCoolantFlow.Components.IdealPipeHeatCapacityWithHeatTransferCpInCpOut pipeTempSensor(T(start=
          env.T, fixed=true)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,-40})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  outer Environment.EnvironmentalConditions env
    annotation (Placement(transformation(extent={{120,140},{160,180}})));
  Components.Radiator radiator(redeclare model CoolantModel =
        GFA_ThermoModel.IdealCoolantFlow.Media.IdealCoolant (T(fixed=true,
            start=env.T)))     annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-120,0})));
equation
  connect(controller.V_flow, pump.V_flow) annotation (Line(points={{-49,-120},{
          -30,-120},{-30,-52}}, color={0,0,127}));
  connect(pwm_Pump, controller.w)
    annotation (Line(points={{-250,-120},{-72,-120}}, color={0,0,127}));
  connect(coolantSink.coolantInlet, pump.coolantInlet)
    annotation (Line(points={{-80,-40},{-40,-40}}, color={0,127,255}));
  connect(f_pump.y, pump.f_pump) annotation (Line(points={{-39.4,-20},{-26,-20},
          {-26,-28}}, color={0,0,127}));
  connect(pipeMotor.heatPort, motor.heatPort_a)
    annotation (Line(points={{-90,55},{-90,70}}, color={191,0,0}));
  connect(pipeGenerator.heatPort, generator.heatPort_a)
    annotation (Line(points={{-50,55},{-50,70}}, color={191,0,0}));
  connect(pipeInvMotor.heatPort, inverterMotor.heatPort_a)
    annotation (Line(points={{-10,55},{-10,70}}, color={191,0,0}));
  connect(pipeInvGen.heatPort, inverterGenerator.heatPort_a)
    annotation (Line(points={{30,55},{30,70}}, color={191,0,0}));
  connect(M_EM, motor.M)
    annotation (Line(points={{-250,160},{-94,160},{-94,91}}, color={0,0,127}));
  connect(M_EM, generator.M)
    annotation (Line(points={{-250,160},{-54,160},{-54,91}}, color={0,0,127}));
  connect(M_EM, inverterMotor.M)
    annotation (Line(points={{-250,160},{-14,160},{-14,91}}, color={0,0,127}));
  connect(M_EM, inverterGenerator.M)
    annotation (Line(points={{-250,160},{26,160},{26,91}}, color={0,0,127}));
  connect(n_EM, motor.n)
    annotation (Line(points={{-250,140},{-86,140},{-86,91}}, color={0,0,127}));
  connect(n_EM, generator.n)
    annotation (Line(points={{-250,140},{-46,140},{-46,91}}, color={0,0,127}));
  connect(n_EM, inverterMotor.n)
    annotation (Line(points={{-250,140},{-6,140},{-6,91}}, color={0,0,127}));
  connect(n_EM, inverterGenerator.n)
    annotation (Line(points={{-250,140},{34,140},{34,91}}, color={0,0,127}));
  connect(inverterMotor.T, T_Inv) annotation (Line(points={{1,80},{8,80},{8,100},
          {130,100},{130,100},{250,100}}, color={0,0,127}));
  connect(motor.T, T_EM) annotation (Line(points={{-79,80},{-72,80},{-72,120},{
          250,120}}, color={0,0,127}));
  connect(pump.coolantOutlet, pipeTempSensor.coolantInlet)
    annotation (Line(points={{-20,-40},{20,-40}}, color={0,127,255}));
  connect(pipeTempSensor.heatPort, temperatureSensor.port)
    annotation (Line(points={{30,-45},{30,-60},{40,-60}}, color={191,0,0}));
  connect(temperatureSensor.T, T_Cool) annotation (Line(points={{60,-60},{220,
          -60},{220,80},{250,80}}, color={0,0,127}));
  connect(f_radiator.y, radiator.f_radiator) annotation (Line(points={{-139.4,
          30},{-128,30},{-128,12}},    color={0,0,127}));
  connect(f_fan.y, radiator.f_fan) annotation (Line(points={{-139.4,50},{-124,
          50},{-124,12}},   color={0,0,127}));
  connect(v_Veh, radiator.v_Veh) annotation (Line(points={{-250,100},{-160,100},
          {-160,-4},{-132,-4}},
                              color={0,0,127}));
  connect(T_Env, radiator.T_air) annotation (Line(points={{-250,80},{-170,80},{
          -170,4},{-132,4}},   color={0,0,127}));
  connect(pipeTempSensor.coolantOutlet, pipeInvGen.coolantInlet) annotation (
      Line(points={{40,-40},{60,-40},{60,50},{40,50}}, color={0,127,255}));
  connect(pipeInvGen.coolantOutlet, pipeInvMotor.coolantInlet)
    annotation (Line(points={{20,50},{0,50}}, color={0,127,255}));
  connect(pipeInvMotor.coolantOutlet, pipeGenerator.coolantInlet)
    annotation (Line(points={{-20,50},{-40,50}}, color={0,127,255}));
  connect(pipeGenerator.coolantOutlet, pipeMotor.coolantInlet)
    annotation (Line(points={{-60,50},{-80,50}}, color={0,127,255}));
  connect(pwm_Fan2, radiator.pwm_fan_2) annotation (Line(points={{-250,20},{
          -220,20},{-220,-40},{-124,-40},{-124,-12}}, color={0,0,127}));
  connect(pwm_Fan1, radiator.pwm_fan_1) annotation (Line(points={{-250,40},{
          -210,40},{-210,-30},{-128,-30},{-128,-12}}, color={0,0,127}));
  connect(pipeMotor.coolantOutlet, radiator.coolantInlet) annotation (Line(
        points={{-100,50},{-120,50},{-120,10}}, color={0,127,255}));
  connect(radiator.coolantOutlet, coolantSink.coolantInlet) annotation (Line(
        points={{-120,-10},{-120,-40},{-80,-40}}, color={0,127,255}));
  annotation (Icon(graphics={Text(
          extent={{-36,-50},{40,-94}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="MT")}), __Dymola_Commands(file=
          "IdealCoolantCircuitTRex/Scenarios/scripts/plotToutMn.mos"
        "plotToutMn"));
end MTCircuit;
