model TestTurboJetInertia_edit

  extends Modelica.Icons.Example;
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;
  import ThermoPower.*;
  parameter SI.SpecificEnthalpy HH(fixed = false, start = 40e6) "Fuel lower heat value";
protected
  parameter Real tableEtaC[6, 4]=[0, 95, 100, 105; 1, 82.5e-2, 81e-2,
      80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4,
      82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4]=[0, 95, 100, 105; 1, 38.3e-3, 43e-3,
      46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3;
      4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];

  parameter Real tablePR[6, 4]=[0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22,
      26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
public
  ThermoPower.Gas.Compressor Compressor1(
    redeclare package Medium = Media.Air,
    pstart_in=0.343e5,
    Tstart_in=244.4,
    explicitIsentropicEnthalpy=true,
    Tstart_out=600,
    pstart_out=8.29e5,
    Ndesign=523.3,
    Tdes_in=244.4,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    tablePhic=tablePhicC,
    tableEta=tableEtaC,
    tablePR=tablePR) annotation (Placement(transformation(extent={{-46,-24},
            {-26,-4}}, rotation=0)));
  ThermoPower.Gas.TurbineStodola Turbine1(
    redeclare package Medium = Media.FlueGas,
    pstart_in=7.85e5,
    pstart_out=1.52e5,
    Tstart_out=800,
    Tstart_in=1390,
    Ndesign=523.3,
    Tdes_in=1400,
    fixedEta=false,
    wnom=104,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    tableEta=tableEtaT) annotation (Placement(transformation(extent={{58,-24},
            {78,-4}}, rotation=0)));
  ThermoPower.Gas.CombustionChamber CombustionChamber1(
    gamma=1,
    Cm=1,
    pstart=8.11e5,
    V=0.05,
    S=0.05,
    Tstart=1370,
    initOpt=ThermoPower.Choices.Init.Options.steadyState,
    HH=HH) annotation (Placement(transformation(extent={{8,0},{28,20}},
          rotation=0)));
  ThermoPower.Gas.SourcePressure
                          SourceP1(
    redeclare package Medium = Media.Air,
    T=244.4,
    p0=0.3447e5) annotation (Placement(transformation(extent={{-100,-16},{-80,
            4}}, rotation=0)));
  ThermoPower.Gas.SinkPressure
                        SinkP1(
    redeclare package Medium = Media.FlueGas,
    p0=1.52e5,
    T=800) annotation (Placement(transformation(extent={{82,-16},{102,4}},
          rotation=0)));
  ThermoPower.Gas.SourceMassFlow
                          SourceW1(
    redeclare package Medium = Media.NaturalGas,
    w0=2.02,
    p0=8.11e5,
    T=300) annotation (Placement(transformation(extent={{-20,34},{0,54}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia1(J=50)
    annotation (Placement(transformation(extent={{6,-24},{26,-4}}, rotation=
           0)));
  Gas.PressDrop PressDrop1(
    redeclare package Medium = Media.FlueGas,
    FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
    A=1,
    wnom=102,
    rhonom=2,
    dpnom=26000,
    pstart=811000,
    Tstart=1370) annotation (Placement(transformation(extent={{34,0},{54,20}},
          rotation=0)));
  Gas.PressDrop PressDrop2(
    FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
    A=1,
    redeclare package Medium = Media.Air,
    wnom=100,
    rhonom=4.7,
    dpnom=18000,
    pstart=829000,
    Tstart=600) annotation (Placement(transformation(extent={{-20,0},{0,20}},
          rotation=0)));
  Gas.PressDrop PressDrop3(
    FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
    A=1,
    redeclare package Medium = Media.Air,
    wnom=100,
    rhonom=0.48,
    dpnom=170,
    pstart=34470,
    Tstart=244.4) annotation (Placement(transformation(extent={{-72,-16},{-52,
            4}}, rotation=0)));
  Modelica.Blocks.Sources.Step Step1(
    height=-0.2,
    offset=2.02,
    startTime=1) annotation (Placement(transformation(extent={{-60,50},{-40,
            70}}, rotation=0)));
  inner System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(SourceW1.flange, CombustionChamber1.inf) annotation (Line(
      points={{0,44},{18,44},{18,20}},
      color={159,159,223},
      thickness=0.5));
  connect(Compressor1.shaft_b, Inertia1.flange_a) annotation (Line(
      points={{-30,-14},{6,-14}},
      color={0,0,0},
      thickness=0.5));
  connect(Inertia1.flange_b, Turbine1.shaft_a) annotation (Line(
      points={{26,-14},{62,-14}},
      color={0,0,0},
      thickness=0.5));
  connect(CombustionChamber1.out, PressDrop1.inlet) annotation (Line(
      points={{28,10},{34,10}},
      color={159,159,223},
      thickness=0.5));
  connect(PressDrop1.outlet, Turbine1.inlet) annotation (Line(
      points={{54,10},{60,10},{60,-6}},
      color={159,159,223},
      thickness=0.5));
  connect(Compressor1.outlet, PressDrop2.inlet) annotation (Line(
      points={{-28,-6},{-28,10},{-20,10}},
      color={159,159,223},
      thickness=0.5));
  connect(PressDrop2.outlet, CombustionChamber1.ina)
    annotation (Line(points={{0,10},{8,10}}, color={159,159,223}));
  connect(PressDrop3.outlet, Compressor1.inlet) annotation (Line(
      points={{-52,-6},{-44,-6}},
      color={159,159,223},
      thickness=0.5));
  connect(SourceP1.flange, PressDrop3.inlet) annotation (Line(
      points={{-80,-6},{-72,-6}},
      color={159,159,223},
      thickness=0.5));
  connect(Turbine1.outlet, SinkP1.flange) annotation (Line(
      points={{76,-6},{82,-6}},
      color={159,159,223},
      thickness=0.5));
initial equation
  Inertia1.phi = 0;
  Inertia1.w = 523;
  der(Inertia1.w) = 0;

equation
  connect(Step1.y, SourceW1.in_w0) annotation (Line(points={{-39,60},{-16,
          60},{-16,49}}, color={0,0,127}));
  annotation (Documentation(info="<html>
This is the full model of a turbojet-type engine at 11.000m [1].

<p>Simulate the model for 20s. At time t = 1 the fuel flow rate is reduced by 10%; the engine slows down accordingly.
<p><b>References:</b></p>
<ol>
<li>P. P. Walsh, P. Fletcher: <i>Gas Turbine Performance</i>, 2nd ed., Oxford, Blackwell, 2004, pp. 646.
</ol>
</html>"), experiment(StopTime=5));end TestTurboJetInertia_edit;