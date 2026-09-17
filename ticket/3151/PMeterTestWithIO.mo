within ;
model PMeterTestWithIO "This is a doc string
  with embedded DOS line ending"
  inner PowerSystems.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  PowerSystems.Generic.FixedVoltageSource source
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  PowerSystems.Generic.Sensors.PMeter pMeter
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  PowerSystems.Generic.PrescribedPowerLoad load(phi=atan(1000/3000))                          annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Interfaces.RealOutput Pout
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput Pin(start=2.7076e6)
    annotation (Placement(transformation(extent={{64,0},{44,20}})));
equation
connect(source.terminal, pMeter.terminal_p)
  annotation (Line(points={{-60,10},{-40,10}}, color={0,120,120}));
connect(pMeter.terminal_n, load.terminal)
  annotation (Line(points={{-20,10},{0,10}}, color={0,120,120}));
  connect(pMeter.P, Pout) annotation (Line(
      points={{-30,21},{-30,0},{0,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Pin, load.P) annotation (Line(
      points={{54,10},{21,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (                  experiment(StopTime=1),
    uses(Modelica(version="3.2.1"), PowerSystems(version="0.3")),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end PMeterTestWithIO;
