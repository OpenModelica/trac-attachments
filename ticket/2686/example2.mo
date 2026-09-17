within ;
package example2
  record ConnectorRecord

    Integer signal;
    example2.dataTypes signalType;

  end ConnectorRecord;

  connector OutputConnector = output ConnectorRecord;
  annotation (uses(Modelica(version="3.2.1")));
  connector InputConnector = input ConnectorRecord;
  type dataTypes = enumeration(
      S8 "signed integer 8 bit",
      U8 "unsigned integer 8 bit",
      S16 "signed integer 16 bit",
      U16 "unsigned integer 16 bit",
      S32 "signed integer 32 bit",
      U32 "unsigned integer 32 bit",
      error);
  model Source

    parameter Integer signal = 3;
    parameter example2.dataTypes signalType=example2.dataTypes.S8;

    OutputConnector outputConnector
      annotation (Placement(transformation(extent={{90,-12},{110,8}})));

  equation
    outputConnector.signal = signal;
    outputConnector.signalType = signalType;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}), Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            textString="Source")}));
  end Source;

  block WriteSomeOutput

    InputConnector inputConnector[2] annotation (Placement(transformation(extent={{-110,-12},{-90,
              8}}), iconTransformation(extent={{-110,-12},{-90,8}})));
    OutputConnector outputConnector annotation (Placement(transformation(extent={{90,-12},{110,
              8}}), iconTransformation(extent={{90,-12},{110,8}})));

  algorithm
     // first write input to output
    outputConnector:=inputConnector[1];

    // change output signal values
    for i in 1:2 loop
      if not
            (inputConnector[i].signal==0) then
      outputConnector.signal:= outputConnector.signal+1;
      end if;
    end for;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={Text(
            extent={{-120,40},{-62,20}},
            lineColor={0,0,255},
            textString="ArrayInput Size2"), Text(
            extent={{60,40},{118,20}},
            lineColor={0,0,255},
            textString="ArrayOutput Size2"),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
          Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            textString="ChangeValuesOfSignals")}));

  end WriteSomeOutput;

  model testmodel
    Source source annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Source source1 annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
    WriteSomeOutput writeSomeOutput annotation (Placement(transformation(extent={{-20,-40},{60,40}})));
  equation
    connect(source.outputConnector, writeSomeOutput.inputConnector[1]) annotation (Line(
        points={{-80,29.8},{-60,29.8},{-60,30},{-60,30},{-60,0},{-20,0},{-20,-2},{-20,-2},{-20,-2},{-20,-2.8}},

        color={0,0,0},
        smooth=Smooth.None));
    connect(source1.outputConnector, writeSomeOutput.inputConnector[2]) annotation (Line(
        points={{-80,-30.2},{-60,-30.2},{-60,-2},{-20,-2},{-20,1.2}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
  end testmodel;
end example2;
