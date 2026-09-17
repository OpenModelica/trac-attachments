within ;
package Polyphase
  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model PolyphaseRectifier "Demonstrate a polyphase diode rectifier"
      extends Modelica.Icons.Example;
      import Polyphase.Examples.Utilities.Connection;
      parameter Polyphase.Examples.Utilities.PolyphaseRectifierData data
        annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        m=data.m,
        V=sqrt(2)*fill(data.VrmsY, data.m),
        freqHz=fill(data.f, data.m)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-60})));
      Components.MultiStarResistance multiStar(m=data.m, R=data.RGnd)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-60,-90})));
      Modelica.Electrical.Analog.Basic.Resistor resistor2ground(R=data.RGnd)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,-90})));
      Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-90})));
      Polyphase.Examples.Utilities.AnalysatorAC analysatorAC(m=data.m, f=data.f)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-30})));
      Components.SplitToSubsystems splitToSubsystems(m=data.m)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1[data.mSystems](
        each m=data.mBasic,
        each Ron=fill(1e-6, data.mBasic),
        each Goff=fill(1e-6, data.mBasic),
        each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,20})));
      Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode[data.mSystems](
        each m=data.mBasic,
        each Ron=fill(1e-6, data.mBasic),
        each Goff=fill(1e-6, data.mBasic),
        each Vknee=fill(0, data.mBasic)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-20})));
      Modelica.Electrical.MultiPhase.Basic.Star star1[data.mSystems](each m=data.mBasic)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Modelica.Electrical.MultiPhase.Basic.Star star2[data.mSystems](each m=data.mBasic)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-50})));
      Modelica.Electrical.Analog.Basic.Resistor resistorDC1[data.mSystems](
          each R=data.RDC/2)
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Modelica.Electrical.Analog.Basic.Inductor inductorDC1[data.mSystems](
          each i(fixed=true, start=0), each L=data.LDC/2)
        annotation (Placement(transformation(extent={{20,50},{40,70}})));
      Polyphase.Examples.Utilities.AnalysatorDC analysatorDC[data.mSystems](
          each f=data.f)
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Modelica.Electrical.Analog.Basic.Resistor resistorDC2[data.mSystems](
          each R=data.RDC/2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,-60})));
      Modelica.Electrical.Analog.Basic.Inductor inductorDC2[data.mSystems](
          each i(fixed=true, start=0), each L=data.LDC/2) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={30,-60})));
      Polyphase.Examples.Utilities.AnalysatorDC analysatorDCload(f=data.f)
        annotation (Placement(transformation(extent={{60,50},{80,70}})));
      Modelica.Electrical.Analog.Basic.Resistor loadResistor1(R=data.RLoad/2)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,30})));
      Modelica.Electrical.Analog.Basic.Resistor loadResistor2(R=data.RLoad/2)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,-30})));
      Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,0})));
    equation
      if data.connection == Connection.Series then
        connect(inductorDC1[1].n, analysatorDCload.p);
        connect(inductorDC2[data.mSystems].p, loadResistor2.n);
        for k in 1:data.mSystems - 1 loop
          connect(inductorDC2[k].p, inductorDC1[k + 1].n);
        end for;
      else
        for k in 1:data.mSystems loop
          connect(inductorDC1[k].n, analysatorDCload.p);
          connect(inductorDC2[k].p, loadResistor2.n);
        end for;
      end if;
      connect(sineVoltage.plug_n, multiStar.plug)
        annotation (Line(points={{-90,-70},{-90,-90},{-70,-90}},
                                                       color={0,0,255}));
      connect(star1.plug_p, diode1.plug_n)
        annotation (Line(points={{-50,40},{-50,30}},          color={0,0,255}));
      connect(diode.plug_p, star2.plug_p)
        annotation (Line(points={{-50,-30},{-50,-40}}, color={0,0,255}));
      connect(loadResistor1.n, groundDC.p)
        annotation (Line(points={{90,20},{90,0}}, color={0,0,255}));
      connect(groundDC.p, loadResistor2.p)
        annotation (Line(points={{90,0},{90,-20}}, color={0,0,255}));
      connect(multiStar.pin, resistor2ground.p)
        annotation (Line(points={{-50,-90},{-40,-90}}, color={0,0,255}));
      connect(resistor2ground.n, groundAC.p)
        annotation (Line(points={{-20,-90},{-10,-90}}, color={0,0,255}));
      connect(diode1.plug_p, diode.plug_n)
        annotation (Line(points={{-50,10},{-50,-10}}, color={0,0,255}));
      connect(analysatorAC.plug_p, sineVoltage.plug_p)
        annotation (Line(points={{-90,-40},{-90,-50}}, color={0,0,255}));
      connect(analysatorAC.plug_nv, multiStar.plug)
        annotation (Line(points={{-80,-30},{-70,-30},{-70,-90}}, color={0,0,255}));
      connect(analysatorDCload.n, loadResistor1.p)
        annotation (Line(points={{80,60},{90,60},{90,40}}, color={0,0,255}));
      connect(loadResistor2.n, analysatorDCload.nv) annotation (Line(points={{90,-40},
              {90,-60},{70,-60},{70,50}}, color={0,0,255}));
      connect(analysatorAC.plug_n, splitToSubsystems.plug_p)
        annotation (Line(points={{-90,-20},{-90,0}}, color={0,0,255}));
      connect(splitToSubsystems.plugs_n, diode1.plug_p)
        annotation (Line(points={{-70,0},{-50,0},{-50,10}}, color={0,0,255}));
      connect(star1.pin_n, analysatorDC.p)
        annotation (Line(points={{-50,60},{-40,60}}, color={0,0,255}));
      connect(analysatorDC.n, resistorDC1.p)
        annotation (Line(points={{-20,60},{-10,60}}, color={0,0,255}));
      connect(resistorDC1.n, inductorDC1.p)
        annotation (Line(points={{10,60},{20,60}}, color={0,0,255}));
      connect(star2.pin_n, resistorDC2.n)
        annotation (Line(points={{-50,-60},{-10,-60}}, color={0,0,255}));
      connect(resistorDC2.p, inductorDC2.n)
        annotation (Line(points={{10,-60},{20,-60}}, color={0,0,255}));
      connect(star2.pin_n, analysatorDC.nv)
        annotation (Line(points={{-50,-60},{-30,-60},{-30,50}}, color={0,0,255}));
      annotation (experiment(StopTime=0.2, Interval=5e-05),  Documentation(info="<html>
<p>
This example demonstrates a polyphase system with a rectifier per subsystem.
</p>
<p>
Note that the interaction between the subsystems is damped by the DC resistors and inductors.
</p>
<p>
You may try different number of phases 2&le;m, as well as connect the rectifiers in series or in parallel, and investigate AC values:
</p>
<ul>
<li>AC power analysatorAC.pTotal (sum of all phases)</li>
<li>AC current analysatorAC.iFeed[m] (1st harmonice rms)</li>
<li>AC voltage analysatorAC.vLN[m] (1st harmonice rms, line to neutral)</li>
<li>AC voltage analysatorAC.vLL[m] (1st harmonice rms, line to line)</li>
</ul>
<p>
as well as DC values per subsystem (rectifier) and total (load):
</p>
<ul>
<li>DC power   total analysatorAC.pDC (mean)<li>
<li>DC current total analysatorAC.iDC (mean)<li>
<li>DC voltage total analysatorAC.vDC (mean)<li>
</ul>
</html>"),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
              extent={{-62,72},{42,-70}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              radius=5),                      Text(
              extent={{-24,10},{36,-10}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.None,
              textString="rectifiers[mSystems]"),
            Text(
              extent={{-58,10},{58,-10}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              origin={50,0},
              rotation=90,
              textString="connected in series or in parallel"),
            Line(points={{60,60},{40,60}}, color={175,175,175}),
            Line(points={{70,-60},{40,-60}}, color={175,175,175})}),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
    end PolyphaseRectifier;

    package Utilities "Utilities for Examples"
      extends Modelica.Icons.UtilitiesPackage;

      record PolyphaseRectifierData "Data record for polyphase rectifier"
        extends Modelica.Icons.Record;
        import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
        import Polyphase.Examples.Utilities.Connection;
        parameter Integer m(final min=2)=6 "Number of phases";
        parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
          "Number of base systems"
          annotation(Dialog(enable=false));
        parameter Integer mBasic=integer(m/mSystems)
          "Number of phases per base system"
          annotation(Dialog(enable=false));
        final parameter Integer kPolygon=max(1, integer((mBasic - 1)/2))
          "Alternative of largest polygon voltage";
        parameter Connection connection=Connection.Series
          "Specify connection of subsystems in case of mSystems>1";
        parameter Modelica.SIunits.Voltage VrmsY=100 "RMS voltage line to starpoint";
        parameter Modelica.SIunits.Frequency f=50 "Source frequency";
        parameter Modelica.SIunits.Resistance RLoad=2*(if connection==Connection.Series then mSystems else 1/mSystems) "Load resistance";
        parameter Modelica.SIunits.Resistance RDC=1e-3 "DC resistance";
        parameter Modelica.SIunits.Inductance LDC=3e-3 "DC inductance";
        parameter Modelica.SIunits.Resistance RGnd=1e5 "Resistance to ground";
        annotation(defaultComponentPrefixes="parameter");
      end PolyphaseRectifierData;

    type Connection = enumeration(
          Series "Subsystems connected in series",
          Parallel "Subsystems connected in parallel")
      "Enumeration defining the connection of subsystems";

      model AnalysatorAC "Analyze AC voltage, current and power"
        extends Modelica.Icons.RotationalSensor;
        extends Modelica.Electrical.MultiPhase.Interfaces.TwoPlug;
        import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
        parameter Modelica.SIunits.Frequency f=50 "Mains frequency";
        final parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
          "Number of base systems";
        final parameter Integer mBasic=integer(m/mSystems)
          "Phase number of base systems";
        final parameter Integer kPolygon=if m==2 then 1 else integer((mBasic - 1)/2)
          "Alternative of largest polygon voltage";
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_nv(final m=m)
          "Negative polyphase electrical plug with m pins"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Blocks.Interfaces.RealOutput pTotal "Total power, mean"  annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={110,-60})));
        Modelica.Blocks.Interfaces.RealOutput iFeed[m]
          "RMS feed currents, first harmonic" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-110})));
        Modelica.Blocks.Interfaces.RealOutput vLL1[m]
          "RMS voltages line-to-line, first harmonic" annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-110,-60})));
        Modelica.Blocks.Interfaces.RealOutput vLN[m]
          "RMS voltages line-to-neutral, first harmonic" annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={60,-110})));
        Modelica.Electrical.MultiPhase.Sensors.MultiSensor multiSensorAC(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,0})));
        Components.MultiDelta multiDelta(m=m, kPolygon=kPolygon) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-90,30})));
        Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-70,30})));
        Modelica.Blocks.Math.Harmonic iH1[m](each f=f, each k=1) annotation (
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=90,
              origin={-20,-50})));
        Modelica.Blocks.Math.Harmonic vH1[m](each f=f, each k=1) annotation (
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=90,
              origin={20,-50})));
        Modelica.Blocks.Math.Mean powerTotal(f=f) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,-30})));
        Modelica.Blocks.Math.Harmonic voltageLine2Line[m](each f=f, each k=1)
          "Line-to-line voltage" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,-30})));
      equation
        connect(plug_p, multiSensorAC.pc)
          annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
        connect(multiSensorAC.pc, multiSensorAC.pv)
          annotation (Line(points={{-10,0},{-10,10},{0,10}}, color={0,0,255}));
        connect(multiSensorAC.nc, plug_n)
          annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
        connect(multiSensorAC.nv, plug_nv)
          annotation (Line(points={{0,-10},{0,-100}}, color={0,0,255}));
        connect(multiDelta.plug_p, voltageSensor.plug_p)
          annotation (Line(points={{-90,20},{-70,20}}, color={0,0,255}));
        connect(multiDelta.plug_n, voltageSensor.plug_n)
          annotation (Line(points={{-90,40},{-70,40}}, color={0,0,255}));
        connect(plug_p, multiDelta.plug_p)
          annotation (Line(points={{-100,0},{-90,0},{-90,20}}, color={0,0,255}));
        connect(voltageLine2Line.y_rms, vLL1) annotation (Line(points={{-44,-41},{-44,
                -60},{-110,-60}}, color={0,0,127}));
        connect(voltageSensor.v, voltageLine2Line.u)
          annotation (Line(points={{-59,30},{-50,30},{-50,-18}}, color={0,0,127}));
        connect(multiSensorAC.powerTotal,powerTotal. u)
          annotation (Line(points={{11,-6},{50,-6},{50,-18}}, color={0,0,127}));
        connect(powerTotal.y, pTotal)
          annotation (Line(points={{50,-41},{50,-60},{110,-60}}, color={0,0,127}));
        connect(multiSensorAC.i, iH1.u) annotation (Line(points={{-6,-11},{-6,-20},{-20,
                -20},{-20,-38}}, color={0,0,127}));
        connect(iH1.y_rms, iFeed) annotation (Line(points={{-14,-61},{-16,-61},{-16,-80},
                {-60,-80},{-60,-110}}, color={0,0,127}));
        connect(vH1.y_rms, vLN) annotation (Line(points={{26,-61},{26,-80},{60,-80},{60,
                -110}}, color={0,0,127}));
        connect(multiSensorAC.v, vH1.u) annotation (Line(points={{6,-11},{6,-20},{20,-20},
                {20,-38}}, color={0,0,127}));
        annotation (Icon(graphics={
              Text(
                extent={{-152,80},{148,120}},
                textString="%name",
                textColor={0,0,255}),
              Text(
                extent={{60,-40},{100,-80}},
                  textColor={64,64,64},
                  textString="W"),
              Text(
                extent={{-80,-60},{-40,-100}},
                  textColor={64,64,64},
                  textString="A"),
              Text(
                extent={{40,-60},{80,-100}},
                  textColor={64,64,64},
                  textString="V"),
              Text(
                extent={{-100,-40},{-60,-80}},
                  textColor={64,64,64},
                textString="V")}), Documentation(info="<html>
<p>
Provides mean of total power over one period as well as the following values for each phase:
</p>
<ul>
<li>RMS of first harmonic of line-to-line voltage</li>
<li>RMS of first harmonic of line-to-neutral voltage</li>
<li>RMS of first harmonic of feed current</li>
</ul>
</html>"));
      end AnalysatorAC;

      model AnalysatorDC "Analyze DC voltage, current and power"
        extends Modelica.Icons.RotationalSensor;
        extends Modelica.Electrical.Analog.Interfaces.TwoPin;
        import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
        parameter Modelica.SIunits.Frequency f=50 "Mains frequency";
        Modelica.Electrical.Analog.Interfaces.NegativePin nv
          "Negative electrical pin"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Blocks.Interfaces.RealOutput pDC "Mean power" annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={-110,-58})));
        Modelica.Blocks.Interfaces.RealOutput iMean "Mean current" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-110})));
        Modelica.Blocks.Interfaces.RealOutput vMean "Mean voltage" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={60,-110})));
        Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorDC
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,0})));
        Modelica.Blocks.Math.Mean powerTotal(f=f) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,-30})));
        Modelica.Blocks.Math.Mean meanCurrent(f=f) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-20,-50})));
        Modelica.Blocks.Math.Mean meanVoltage(f=f) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={20,-50})));
      equation
        connect(multiSensorDC.pc,multiSensorDC. pv)
          annotation (Line(points={{-10,0},{-10,10},{0,10}}, color={0,0,255}));
        connect(multiSensorDC.nv, nv)
          annotation (Line(points={{0,-10},{0,-100}}, color={0,0,255}));
        connect(powerTotal.y, pDC) annotation (Line(points={{-50,-41},{-50,-58},{-110,
                -58}}, color={0,0,127}));
        connect(multiSensorDC.power, powerTotal.u)
          annotation (Line(points={{-11,-6},{-50,-6},{-50,-18}}, color={0,0,127}));
        connect(meanCurrent.y, iMean) annotation (Line(points={{-20,-61},{-20,-80},{-60,
                -80},{-60,-110}}, color={0,0,127}));
        connect(multiSensorDC.i, meanCurrent.u) annotation (Line(points={{-6,-11},{-6,
                -20},{-20,-20},{-20,-38}}, color={0,0,127}));
        connect(multiSensorDC.v, meanVoltage.u) annotation (Line(points={{6,-11},{6,-20},
                {20,-20},{20,-38}}, color={0,0,127}));
        connect(meanVoltage.y, vMean) annotation (Line(points={{20,-61},{20,-80},{60,-80},
                {60,-110}}, color={0,0,127}));
        connect(multiSensorDC.pc, p)
          annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
        connect(multiSensorDC.nc, n)
          annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
        annotation (Icon(graphics={
              Text(
                extent={{-152,80},{148,120}},
                textString="%name",
                textColor={0,0,255}),
              Text(
                extent={{-100,-40},{-60,-80}},
                  textColor={64,64,64},
                  textString="W"),
              Text(
                extent={{-80,-60},{-40,-100}},
                  textColor={64,64,64},
                  textString="A"),
              Text(
                extent={{40,-60},{80,-100}},
                  textColor={64,64,64},
                  textString="V")}), Documentation(info="<html>
<p>
Provides mean values over one period:
</p>
<ul>
<li>power</li>
<li>voltage</li>
<li>current</li>
</ul>
</html>"));
      end AnalysatorDC;
    end Utilities;
  end Examples;

  package Components
    function factorY2D "Calculates factor Y voltage to polygon (delta) voltage"
      extends Modelica.Icons.Function;
      import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
      import Modelica.Utilities.Streams.print;
      import Modelica.Constants.pi;
      input Integer m=3 "Number of phases";
      input Integer kPolygon=1 "Alternative of polygon";
      output Real y "Factor Y to D";
    protected
      parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m));
    algorithm
      if mBasic==2 then
        y := sqrt(2);
      else
        if kPolygon<1 or kPolygon>(mBasic - 1)/2 then
          y := 2*sin(pi/mBasic);
          print("factorY2D: kPolygon out of range, evaluating for kPolygon=1");
        else
          y := 2*sin(kPolygon*pi/mBasic);
        end if;
      end if;
    end factorY2D;

    function factorY2DC "Calculates factor of DC-voltage from RMS Y-voltage"
      extends Modelica.Icons.Function;
      import Modelica.Constants.pi;
      import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
      input Integer m=3 "Number of phases";
      output Real y "Factor Yrms to DC";
    protected
      parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m));
    algorithm
      if mBasic==2 then
        y := 4/pi;
      else
        y := 2*sin((mBasic - 1)/2*pi/mBasic)*sqrt(2)*sin(pi/(2*m))/(pi/(2*m));
      end if;
    end factorY2DC;

    model MultiDelta
      "Delta (polygon) connection of polyphase systems consisting of multiple base systems"
      import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
      import Modelica.Utilities.Streams.print;
      parameter Integer m(final min=2) = 3 "Number of phases";
      parameter Integer kPolygon=1 "Alternative of polygon";
      final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) "Number of base systems";
      final parameter Integer mBasic=integer(m/mSystems) "Phase number of base systems";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    protected
      parameter Integer kP=if (mBasic<=2 or kPolygon<1 or kPolygon>integer(mBasic - 1)/2) then 1 else kPolygon;
    equation
      when initial() then
        if (mBasic<=2 or kPolygon<1 or kPolygon>integer(mBasic - 1)/2) then
          print("MultiDelta: replaced erroneous kPolygon = "+String(kPolygon)+" by kPolygon = 1");
        end if;
      end when;
      for k in 1:mSystems loop
        for j in 1:(mBasic -kP) loop
          connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 1)*mBasic + j + kP]);
        end for;
        for j in (mBasic - kP + 1):mBasic loop
          connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 2)*mBasic + j + kP]);
        end for;
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-46,0}}, color={0,0,255}),
            Line(
              points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}},
              thickness=0.5,
              color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255}),
            Line(
              points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}},
              thickness=0.5,
              color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              textColor={0,0,255})}),
                                  Documentation(info="<html>
<p>
Delta (polygon) connection of a polyphase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>).
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiStar\">MultiStar</a>
</p>
</html>"));
    end MultiDelta;

    model MultiStarResistance "Resistance connection of star points"
      import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
      parameter Integer m(final min=2) = 3 "Number of phases";
      final parameter Integer mBasic=numberOfSymmetricBaseSystems(m) "Number of symmetric base systems";
      parameter Modelica.SIunits.Resistance R=1e6 "Insulation resistance between base systems";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug(m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Basic.MultiStar multiStar(m=m) annotation (
          Placement(transformation(extent={{-10,-10},{10,10}}, origin={-50,0})));
      Modelica.Electrical.MultiPhase.Basic.Resistor resistor(m=mBasic, R=fill(R,
            mBasic))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.MultiPhase.Basic.Star star(m=mBasic) annotation (
          Placement(transformation(extent={{-10,-10},{10,10}}, origin={50,0})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={100,0})));
    equation
      connect(plug, multiStar.plug_p) annotation (Line(
          points={{-100,0},{-100,0},{-60,0},{-60,0}}, color={0,0,255}));
      connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
          points={{-40,0},{-40,0},{-10,0}}, color={0,0,255}));
      connect(resistor.plug_n, star.plug_p) annotation (Line(
          points={{10,0},{10,0},{34,0},{34,0},{40,0},{40,0}}, color={0,0,255}));
      connect(star.pin_n, pin) annotation (Line(
          points={{60,0},{60,0},{98,0},{98,0},{100,0},{100,
              0}}, color={0,0,255}));
      annotation (defaultComponentName="multiStar",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={0,0,255},
              origin={-60,0},
              rotation=90),
            Rectangle(
              extent={{-10,20},{10,-20}},
              lineColor={0,0,255},
              rotation=90),
            Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={0,0,255},
              origin={60,0},
              rotation=90),
            Text(
              extent={{-150,-90},{150,-50}},
              textString="R=%R"),
            Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255})}),
        Documentation(info="<html>
<p>
Multi star points are connected by resistors. This model is required to operate polyphase systems with even phase numbers to avoid ideal connections of start points of base systems; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">polyphase guidelines</a>.
</p>
</html>"));
    end MultiStarResistance;

    model SplitToSubsystems "Split m phases to subsystems"
      import Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems;
      parameter Integer m(min=1) = 3 "Number of phases";
      final parameter Integer mSystems=numberOfSymmetricBaseSystems(m)
        "Number of base systems";
      final parameter Integer mBasic=integer(m/mSystems)
        "Phase number of base systems";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "Positive polyphase electrical plug with m pins"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plugs_n[mSystems](
          each final m=mBasic)
        "mSystems negative polyphase electrical plugs with mBasic pins each"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      for k in 1:mSystems loop
        for j in 1:mBasic loop
          connect(plug_p.pin[(k - 1)*mBasic + j], plugs_n[k].pin[j]);
        end for;
      end for;
      annotation (Documentation(info="<html>
<p>
Splits the m phases in plug_p into subsystems, i.e. mSystems plugs with mBasic pins according to 
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">phase orientation</a> described in the users guide. 
</p>
</html>"),     Icon(graphics={
            Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              textColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Line(points={{-90,0},{-20,0}}, color={0,0,255}),
            Line(points={{-90,2},{-20,2}}, color={0,0,255}),
            Line(points={{-90,-2},{-20,-2}},
                                           color={0,0,255}),
            Line(points={{-20,0},{90,0}},  color={0,0,255},
              pattern=LinePattern.Dot),
            Line(points={{-20,2},{-0.78125,10},{100,10}},
                                           color={0,0,255}),
            Line(points={{-20,-2},{-0.7812,-10},{100,-10}},
                                           color={0,0,255})}));
    end SplitToSubsystems;
  end Components;
  annotation (uses(Modelica(version="3.2.3")));
end Polyphase;
