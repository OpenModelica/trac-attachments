within ;
model test_Ext

  Modelica_DeviceDrivers.Blocks.Communication.SerialPortReceive serialReceive(
    baud=Modelica_DeviceDrivers.Utilities.Types.SerialBaudRate.B9600,
    parity=0,
    enableExternalTrigger=false,
    startTime=0.0,
    autoBufferSize=false,
    userBufferSize=6,
    sampleTime=0.1,
    Serial_Port="COM3")
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.UnpackUnsignedInteger unpackInt(bitOffset=
       0, width=16,
    nu=1)
    annotation (Placement(transformation(extent={{-176,48},{-156,68}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.UnpackUnsignedInteger unpackInt1(
                                                                                         bitOffset=
       0, width=16)
    annotation (Placement(transformation(extent={{-176,16},{-156,36}})));
equation

  connect(serialReceive.pkgOut,unpackInt. pkgIn) annotation (Line(
      points={{-179.2,70},{-166,70},{-166,68.8}}));
  connect(unpackInt.pkgOut[1], unpackInt1.pkgIn) annotation (Line(
      points={{-166,47.2},{-166,36.8}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=15,
      Tolerance=0.001,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-200,-100},{100,100}})),
    uses(Modelica_DeviceDrivers(version="1.4.4"), Modelica(version="3.2.1")));
end test_Ext;
