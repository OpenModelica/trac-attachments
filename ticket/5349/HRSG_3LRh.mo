model HRSG_3LRh
  "Heat Recovery Steam Generator with three pressure level and reheat"
  extends HRSG_3LRh_BaseClass;
  parameter Boolean SSInit=false "Steady-state initialization";

  ThermoPower.PowerPlants.HRSG.Examples.DG_3L_CC drums(
    HPd_rint=1.067,
    HPd_rext=1.167,
    HPd_L=11.920,
    HPd_Cm=0,
    IPd_rint=0.915,
    IPd_rext=1.015,
    IPd_L=7,
    IPd_Cm=0,
    LPd_rint=1.143,
    LPd_rext=1.243,
    LPd_L=11.503,
    LPd_Cm=0,
    RiserHPFlowRate=175.5,
    RiserIPFlowRate=67.5,
    RiserLPFlowRate=41.5,
    redeclare package FluidMedium = FluidMedium,
    SSInit=SSInit,
    fluidHPNomPressure=13060000,
    fluidIPNomPressure=3381600,
    fluidLPNomPressure=719048) annotation (Placement(transformation(
          extent={{-102,40},{98,160}}, rotation=0)));
  ThermoPower.PowerPlants.HRSG.Examples.HEG_3LRh HeatExchangersGroup(
    gasNomFlowRate=585.5,
    fluidHPNomFlowRate_Sh=70.59,
    fluidHPNomFlowRate_Ev=175.5,
    fluidHPNomFlowRate_Ec=70.10,
    fluidIPNomFlowRate_Rh=81.10,
    fluidIPNomFlowRate_Sh=13.5,
    fluidIPNomFlowRate_Ev=67.5,
    fluidIPNomFlowRate_Ec=21.8,
    fluidLPNomFlowRate_Sh=6.91,
    fluidLPNomFlowRate_Ev=41.49,
    fluidLPNomFlowRate_Ec=122.4,
    Sh2_HP_N_G=3,
    Sh2_HP_N_F=7,
    Sh2_HP_exchSurface_G=3636,
    Sh2_HP_exchSurface_F=421.844,
    Sh2_HP_extSurfaceTub=540.913,
    Sh2_HP_gasVol=10,
    Sh2_HP_fluidVol=2.615,
    Sh2_HP_metalVol=1.685,
    Sh1_HP_N_G=3,
    Sh1_HP_N_F=7,
    Sh1_HP_exchSurface_G=8137.2,
    Sh1_HP_exchSurface_F=612.387,
    Sh1_HP_extSurfaceTub=721.256,
    Sh1_HP_gasVol=10,
    Sh1_HP_fluidVol=4.134,
    Sh1_HP_metalVol=1.600,
    Ev_HP_N_G=4,
    Ev_HP_N_F=4,
    Ev_HP_exchSurface_G=30501.9,
    Ev_HP_exchSurface_F=2296.328,
    Ev_HP_extSurfaceTub=2704.564,
    Ev_HP_gasVol=10,
    Ev_HP_fluidVol=15.500,
    Ev_HP_metalVol=6.001,
    Ec2_HP_N_G=3,
    Ec2_HP_N_F=7,
    Ec2_HP_exchSurface_G=20335,
    Ec2_HP_exchSurface_F=1451.506,
    Ec2_HP_extSurfaceTub=1803.043,
    Ec2_HP_gasVol=10,
    Ec2_HP_fluidVol=9.290,
    Ec2_HP_metalVol=5.045,
    Ec1_HP_N_G=3,
    Ec1_HP_N_F=7,
    Ec1_HP_exchSurface_G=12201.2,
    Ec1_HP_exchSurface_F=870.904,
    Ec1_HP_extSurfaceTub=1081.826,
    Ec1_HP_gasVol=10,
    Ec1_HP_fluidVol=5.574,
    Ec1_HP_metalVol=3.027,
    Rh2_IP_N_F=7,
    Rh2_IP_exchSurface_G=4630.2,
    Rh2_IP_exchSurface_F=873.079,
    Rh2_IP_extSurfaceTub=1009.143,
    Rh2_IP_fluidVol=8.403,
    Rh2_IP_metalVol=2.823,
    Rh1_IP_N_F=7,
    Rh1_IP_exchSurface_G=4630,
    Rh1_IP_exchSurface_F=900.387,
    Rh1_IP_extSurfaceTub=1009.250,
    Rh1_IP_fluidVol=8.936,
    Rh1_IP_metalVol=2.292,
    Sh_IP_N_G=3,
    Sh_IP_N_F=7,
    Sh_IP_exchSurface_G=2314.8,
    Sh_IP_exchSurface_F=450.218,
    Sh_IP_extSurfaceTub=504.652,
    Sh_IP_gasVol=10,
    Sh_IP_fluidVol=4.468,
    Sh_IP_metalVol=1.146,
    Ev_IP_N_G=4,
    Ev_IP_N_F=4,
    Ev_IP_exchSurface_G=24402,
    Ev_IP_exchSurface_F=1837.063,
    Ev_IP_extSurfaceTub=2163.652,
    Ev_IP_gasVol=10,
    Ev_IP_fluidVol=12.400,
    Ev_IP_metalVol=4.801,
    Ec_IP_N_F=7,
    Ec_IP_exchSurface_G=4067.2,
    Ec_IP_exchSurface_F=306.177,
    Ec_IP_extSurfaceTub=360.609,
    Ec_IP_gasVol=10,
    Ec_IP_fluidVol=2.067,
    Ec_IP_metalVol=0.800,
    Sh_LP_N_G=3,
    Sh_LP_N_F=7,
    Sh_LP_exchSurface_G=1708.2,
    Sh_LP_exchSurface_F=225.073,
    Sh_LP_extSurfaceTub=252.286,
    Sh_LP_gasVol=10,
    Sh_LP_fluidVol=2.234,
    Sh_LP_metalVol=0.573,
    Ev_LP_N_G=4,
    Ev_LP_N_F=4,
    Ev_LP_exchSurface_G=24402,
    Ev_LP_exchSurface_F=2292.926,
    Ev_LP_extSurfaceTub=2592.300,
    Ev_LP_gasVol=10,
    Ev_LP_fluidVol=19.318,
    Ev_LP_metalVol=5.374,
    Ec_LP_N_G=3,
    Ec_LP_N_F=7,
    Ec_LP_exchSurface_G=40095.9,
    Ec_LP_exchSurface_F=3439.389,
    Ec_LP_extSurfaceTub=3888.449,
    Ec_LP_gasVol=10,
    Ec_LP_fluidVol=28.977,
    Ec_LP_metalVol=8.061,
    rhomcm=7900*578.05,
    lambda=20,
    redeclare package FlueGasMedium = FlueGasMedium,
    redeclare package FluidMedium = FluidMedium,
    SSInit=SSInit,
    Ec_LP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=4000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=46.8),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Ev_LP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=20000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=127),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Ev_IP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=20000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=58.5),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Sh_LP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=4000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=16.6),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Ev_HP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=20000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          ( gamma=46.5),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Sh1HP_Rh1IP(
      redeclare model HeatTransfer_FA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_FB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_GB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=80),
      redeclare model HeatTransfer_GA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=70),
      redeclare model HeatExchangerTopology_A =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow,
      redeclare model HeatExchangerTopology_B =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Sh2HP_Rh2IP(
      redeclare model HeatTransfer_FA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_FB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_GA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=83.97),
      redeclare model HeatTransfer_GB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=80),
      redeclare model HeatExchangerTopology_A =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow,
      redeclare model HeatExchangerTopology_B =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Ec2_HP(
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=56),
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Ec1HP_EcIP(
      redeclare model HeatTransfer_FA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_FB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_GA =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=42),
      redeclare model HeatTransfer_GB =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=45),
      redeclare model HeatExchangerTopology_A =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow,
      redeclare model HeatExchangerTopology_B =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow),
    Sh_IP(
      redeclare model HeatExchangerTopology =
          ThermoPower.Thermal.HeatExchangerTopologies.CounterCurrentFlow,
      redeclare model HeatTransfer_F =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient
          (gamma=4000),
      redeclare model HeatTransfer_G =
          ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficientTwoGrids
          (gamma=33)),
    Sh2_HP_Nw_G=6,
    Sh1_HP_Nw_G=6,
    Ec2_HP_Nw_G=6,
    Ec1_HP_Nw_G=6,
    Rh2_IP_N_G=3,
    Rh2_IP_Nw_G=6,
    Rh1_IP_N_G=3,
    Rh1_IP_Nw_G=6,
    Sh_IP_Nw_G=6,
    Ec_IP_N_G=3,
    Ec_IP_Nw_G=6,
    Sh_LP_Nw_G=6,
    Ec_LP_Nw_G=6,
    gasNomPressure=100000,
    fluidHPNomPressure_Sh=13430000,
    fluidHPNomPressure_Ev=13710000,
    fluidHPNomPressure_Ec=13890000,
    fluidIPNomPressure_Rh=2840000,
    fluidIPNomPressure_Sh=2950000,
    fluidIPNomPressure_Ev=3716000,
    fluidIPNomPressure_Ec=4860000,
    fluidLPNomPressure_Sh=660000,
    fluidLPNomPressure_Ev=1534000,
    fluidLPNomPressure_Ec=1980000,
    Sh2_HP_Tstartbar=873.15,
    Sh1_HP_Tstartbar=823.15,
    Ev_HP_Tstartbar=723.15,
    Ec2_HP_Tstartbar=573.15,
    Ec1_HP_Tstartbar=523.15,
    Sh_IP_Tstartbar=623.15,
    Ev_IP_Tstartbar=553.15,
    Sh_LP_Tstartbar=523.15,
    Ev_LP_Tstartbar=473.15,
    Ec_LP_Tstartbar=423.15)                                                  annotation (Placement(transformation(extent={
            {-102,-80},{98,0}}, rotation=0)));

equation
  connect(ActuatorsBus, drums.ActuatorsBus) annotation (Line(points={{200,
          100},{158,100},{158,104},{98,104}}, color={213,255,170}));
  connect(drums.SensorsBus, SensorsBus) annotation (Line(points={{98,116},
          {140,116},{140,160},{200,160}}, color={255,170,213}));
  connect(HeatExchangersGroup.GasIn, GasIn) annotation (Line(
      points={{-102,-40},{-200,-40}},
      color={159,159,223},
      thickness=0.5));
  connect(HeatExchangersGroup.GasOut, GasOut) annotation (Line(
      points={{98,-40},{200,-40}},
      color={159,159,223},
      thickness=0.5));
  connect(Sh_HP_Out, HeatExchangersGroup.Sh_HP_Out) annotation (Line(
      points={{-160,-200},{-160,-106},{-62,-106},{-62,-80}},
      thickness=0.5,
      color={0,0,255}));
  connect(Sh_LP_Out, HeatExchangersGroup.Sh_LP_Out) annotation (Line(
      points={{80,-200},{80,-160},{58,-160},{58,-79.6}},
      thickness=0.5,
      color={0,0,255}));
  connect(Rh_IP_Out, HeatExchangersGroup.Rh_IP_Out) annotation (Line(
      points={{-40,-200},{-40,-80}},
      thickness=0.5,
      color={0,0,255}));
  connect(Rh_IP_In, HeatExchangersGroup.Rh_IP_In) annotation (Line(
      points={{-100,-200},{-100,-120},{-28,-120},{-28,-80}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.SensorsBus, drums.SensorsBus) annotation (
      Line(points={{98,-12},{140,-12},{140,116},{98,116}}, color={255,170,
          213}));
  connect(HeatExchangersGroup.ActuatorsBus, drums.ActuatorsBus)
    annotation (Line(points={{98,-24},{128,-24},{128,104},{98,104}},
        color={213,255,170}));
  connect(HeatExchangersGroup.Sh_HP_In, drums.Steam_HP_Out) annotation (
      Line(
      points={{-78,0},{-78,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ev_HP_Out, drums.Riser_HP) annotation (Line(
      points={{-70,0},{-70,0},{-70,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ev_HP_In, drums.Downcomer_HP) annotation (
      Line(
      points={{-62,0},{-62,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ec_HP_Out, drums.Feed_HP) annotation (Line(
      points={{-54,0},{-54,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ec_HP_In, drums.WaterForHP) annotation (
      Line(
      points={{-46,0},{-46,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Sh_IP_In, drums.Steam_IP_Out) annotation (
      Line(
      points={{-18,0},{-18,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ev_IP_Out, drums.Riser_IP) annotation (Line(
      points={{-10,0},{-10,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ec_IP_Out, drums.Feed_IP) annotation (Line(
      points={{6,0},{6,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ec_IP_In, drums.WaterForIP) annotation (
      Line(
      points={{14,0},{14,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Sh_LP_In, drums.Steam_LP_Out) annotation (
      Line(
      points={{42,0},{42,0},{42,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ev_LP_Out, drums.Riser_LP) annotation (Line(
      points={{50,0},{50,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ev_LP_In, drums.Downcomer_LP) annotation (
      Line(
      points={{58,0},{58,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(HeatExchangersGroup.Ec_LP_Out, drums.Feed_LP) annotation (Line(
      points={{66,0},{66,40}},
      thickness=0.5,
      color={0,0,255}));
  connect(drums.Downcomer_IP, HeatExchangersGroup.Ev_IP_In) annotation (
      Line(
      points={{-2,40},{-2,0}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(WaterIn, HeatExchangersGroup.Ec_LP_In) annotation (Line(
      points={{160,-200},{160,20},{74,20},{74,0}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={
            {-200,-200},{200,200}}), graphics));
end HRSG_3LRh;
