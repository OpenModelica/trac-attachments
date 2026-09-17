package Modelica "Modelica Standard Library"
  extends Icons.Library;
  annotation(preferedView="info", version="2.2.1", versionDate="2006-03-24", conversion(from(version="1.6", ModelicaAdditions(version="1.5"), MultiBody(version="1.0.1"), MultiBody(version="1.0"), Matrices(version="0.8"), script="Scripts/ConvertModelica_from_1.6_to_2.1.mos"), from(version="2.1 Beta1", script="Scripts/ConvertModelica_from_2.1Beta1_to_2.1.mos"), noneFromVersion="2.1", noneFromVersion="2.2"), Dymola(checkSum="539989979:1143034484"), Settings(NewStateSelection=true), Documentation(info="<HTML>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica language from the
Modelica Association, see <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>. 
It is also called <b>Modelica Standard Library</b>. 
It provides model components in many domains that are based on 
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>
 
<p>
<img src=\"./Images/UsersGuide/ModelicaLibraries.png\">
</p>
 
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"Modelica://Modelica.UsersGuide\">Users Guide</a>
     discusses some aspects of the Modelica Standard Library, such as
     interface definitions and used conventions.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the changes of new versions of this package.</li>
<li> Packages <b>Examples</b> in the various subpackages, demonstrate
     how to use the components of the corresponding sublibrary.</li>
</ul>
 
<p>
Copyright &copy; 1998-2006, Modelica Association.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>
<p> <b>Note:</b> This is a <i>subset</i> of the official Modelica package with minor changes made by MathCore Engineering AB.
For a complete list of changes see the <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>.
</p> 
</HTML>
", revisions=""), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  package Blocks "Library for basic input/output control blocks (continuous, discrete, logical, table blocks)"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, extent={{-32,-35},{16,-6}}),Rectangle(visible=true, extent={{-32,-85},{16,-56}}),Line(visible=true, points={{16,-20},{49,-20},{49,-71},{16,-71}}),Line(visible=true, points={{-32,-72},{-64,-72},{-64,-21},{-32,-21}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{16,-71},{29,-67},{29,-74},{16,-71}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-32,-21},{-46,-17},{-46,-25},{-32,-21}})}), Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>
<br>

<p>
Copyright &copy; 1998-2006, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</HTML>
", revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapated all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New subpackage Examples, additional components.
       </li>
<li><i>June 20, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    package Sources "Signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Library;
      annotation(preferedView="info", Documentation(info="<HTML>
<p>
This package contains <b>source</b> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>offset</b></td>
      <td>Value which is added to the signal</td>
  </tr>
  <tr><td><b>startTime</b></td>
      <td>Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <A HREF=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</A>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <A HREF=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</A>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{0,0},{430,-442}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      block Step "Generate step signal of type Real"
        parameter Real height=1 "Height of step";
        extends Interfaces.SignalSource;
        annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-80,68},{-80,-80}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(visible=true, points={{-90,-70},{82,-70}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,-70},{68,-62},{68,-78},{90,-70}}),Line(visible=true, points={{-80,-70},{0,-70},{0,50},{80,50}}),Text(visible=true, extent={{-150,-150},{150,-110}}, textString="startTime=%startTime", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(visible=true, points={{-80,68},{-80,-80}}, color={192,192,192}),Line(visible=true, points={{-80,-18},{0,-18},{0,50},{80,50}}, thickness=0.5),Line(visible=true, points={{-90,-70},{82,-70}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,-70},{68,-62},{68,-78},{90,-70}}),Text(visible=true, fillColor={160,160,160}, extent={{70,-100},{94,-80}}, textString="time", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, extent={{-21,-90},{25,-72}}, textString="startTime", fontName="Arial"),Line(visible=true, points={{0,-17},{0,-71}}, color={192,192,192}, pattern=LinePattern.Dash),Text(visible=true, fillColor={160,160,160}, extent={{-68,-54},{-22,-36}}, textString="offset", fontName="Arial"),Line(visible=true, points={{-13,50},{-13,-17}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, pattern=LinePattern.Dash, points={{2,50},{-19,50},{2,50}}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-13,50},{-16,37},{-9,37},{-13,50}}),Text(visible=true, fillColor={160,160,160}, extent={{-68,8},{-22,26}}, textString="height", fontName="Arial"),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}}),Line(visible=true, points={{-13,-18},{-13,-70}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}}),Text(visible=true, fillColor={160,160,160}, extent={{-72,80},{-31,100}}, textString="y", fontName="Arial")}), Documentation(info="<html>

</html>"));
      equation 
        y=offset + (if time < startTime then 0 else height);
      end Step;

      block IntegerConstant "Generate constant signal of type Integer"
        parameter Integer k=1 "Constant output value";
        extends Interfaces.IntegerSO;
        annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-80,68},{-80,-80}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(visible=true, points={{-90,-70},{82,-70}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,-70},{68,-62},{68,-78},{90,-70}}),Line(visible=true, points={{-80,0},{80,0}}),Text(visible=true, extent={{-150,-150},{150,-110}}, textString="k=%k", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-80,90},{-88,68},{-72,68},{-80,90}}),Line(visible=true, points={{-80,68},{-80,-80}}, color={192,192,192}),Line(visible=true, points={{-80,0},{80,0}}, thickness=0.5),Line(visible=true, points={{-90,-70},{82,-70}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,-70},{68,-62},{68,-78},{90,-70}}),Text(visible=true, fillColor={160,160,160}, extent={{-75,76},{-22,94}}, textString="outPort", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, extent={{70,-100},{94,-80}}, textString="time", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, extent={{-101,-12},{-81,8}}, textString="k", fontName="Arial")}), Documentation(info="<html>

</html>"));
      equation 
        y=k;
      end IntegerConstant;

    end Sources;

    package Interfaces "Connectors and partial models for input/output blocks"
      import Modelica.SIunits;
      extends Modelica.Icons.Library;
      annotation(preferedView="info", Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</HTML>
", revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces. <a href=\"../Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>
"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{0,0},{733,-491}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      connector RealSignal "Real port (both input/output possible)"
        replaceable type SignalType= Real annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
        extends SignalType;
        annotation(Documentation(info="<html>
<p>
Connector with one signal of type Real (no icon, no input/output prefix).
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end RealSignal;

      connector IntegerSignal= Integer "Integer port (both input/output possible)" annotation(Documentation(info="<html>
<p>
Connector with one signal of type Icon (no icon, no input/output prefix).
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      connector RealInput= input RealSignal "'input Real' as connector" annotation(defaultComponentName="u", Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, points={{-100,100},{100,0},{-100,-100},{-100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, points={{0,50},{100,0},{0,-50},{0,50}}),Text(visible=true, fillColor={0,0,127}, extent={{-120,60},{100,105}}, textString="%name", fontName="Arial")}));
      connector RealOutput= output RealSignal "'output Real' as connector" annotation(defaultComponentName="y", Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, points={{-100,100},{100,0},{-100,-100},{-100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, points={{-100,50},{0,0},{-100,-50},{-100,50}}),Text(visible=true, fillColor={0,0,127}, extent={{-100,60},{130,140}}, textString="%name", fontName="Arial")}));
      connector IntegerInput= input IntegerSignal "'input Integer' as connector" annotation(defaultComponentName="u", Documentation(info="<html>
<p>
Connector with one input signal of type Integer.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={255,127,0}, fillColor={255,127,0}, fillPattern=FillPattern.Solid, points={{-100,100},{100,0},{-100,-100},{-100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={255,127,0}, fillColor={255,127,0}, fillPattern=FillPattern.Solid, points={{0,50},{100,0},{0,-50},{0,50}}),Text(visible=true, fillColor={255,127,0}, extent={{-120,60},{100,105}}, textString="%name", fontName="Arial")}));
      connector IntegerOutput= output IntegerSignal "'output Integer' as connector" annotation(defaultComponentName="y", Documentation(info="<html>
<p>
Connector with one output signal of type Integer.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={255,127,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, points={{-100,100},{100,0},{-100,-100},{-100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={255,127,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, points={{-100,50},{0,0},{-100,-50},{-100,50}}),Text(visible=true, fillColor={255,127,0}, extent={{-100,60},{130,140}}, textString="%name", fontName="Arial")}));
      partial block BlockIcon "Basic graphical layout of input/output block"
        annotation(Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,100}}),Text(visible=true, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-150,110},{150,150}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end BlockIcon;

      partial block SO "Single Output continuous control block"
        extends BlockIcon;
        annotation(Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
        RealOutput y "Connector of Real output signal" annotation(Placement(visible=true, transformation(origin={110,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={110,0}, extent={{-10,-10},{10,10}}, rotation=0)));
      end SO;

      partial block SignalSource "Base class for continuous signal source"
        extends SO;
        parameter Real offset=0 "offset of output signal";
        parameter SIunits.Time startTime=0 "output = offset for time < startTime";
        annotation(Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end SignalSource;

      partial block IntegerBlockIcon "Basic graphical layout of Integer block"
        annotation(Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Integer block (no declarations, no equations).
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={255,127,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,100}}),Text(visible=true, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-150,110},{150,150}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end IntegerBlockIcon;

      partial block IntegerSO "Single Integer Output continuous control block"
        extends IntegerBlockIcon;
        annotation(Documentation(info="<html>
<p>
Block has one continuous Integer output signal.
</p>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
        IntegerOutput y "Connector of Integer output signal" annotation(Placement(visible=true, transformation(origin={110,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={110,0}, extent={{-10,-10},{10,10}}, rotation=0)));
      end IntegerSO;

    end Interfaces;

  end Blocks;

  package SIunits "Type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Invisible=true, Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, extent={{-63,-67},{45,-13}}, textString="[kg.m2]", fontName="Arial")}), Documentation(info="<html>
<p>This package provides predefined types, such as <i>Mass</i>,
<i>Angle</i>, <i>Time</i>, based on the international standard
on units, e.g., 
</p>

<pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                     <b>final</b> unit     = \"rad\",
                     displayUnit    = \"deg\");
</pre>

<p>
as well as conversion functions from non SI-units to SI-units
and vice versa in subpackage 
<a href=\"Modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"Modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2006, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p>

</html>", revisions="<html>
<ul>
<li><i>Dec. 14, 2005</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Add users guide and removed \"min\" values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced the following new types<br>
       type Temperature = ThermodynamicTemperature;<br>
       types DerDensityByEnthalpy, DerDensityByPressure,
       DerDensityByTemperature, DerEnthalpyByPressure,
       DerEnergyByDensity, DerEnergyByPressure<br>
       Attribute \"final\" removed from min and max values
       in order that these values can still be changed to narrow
       the allowed range of values.<br>
       Quantity=\"Stress\" removed from type \"Stress\", in order
       that a type \"Stress\" can be connected to a type \"Pressure\".</li>
<li><i>Oct. 27, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New types due to electrical library: Transconductance, InversePotential,
       Damping.</li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed from SIunit to SIunits. Subpackages expanded, i.e., the
       SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Type \"Pressure\" renamed to \"AbsolutePressure\" and introduced a new
       type \"Pressure\" which does not contain a minimum of zero in order
       to allow convenient handling of relative pressure. Redefined
       BulkModulus as an alias to AbsolutePressure instead of Stress, since
       needed in hydraulics.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Bug-fix: Double definition of \"Compressibility\" removed
       and appropriate \"extends Heat\" clause introduced in
       package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Astrid Jaschinski:<br>
       Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br>
       Some chapters realized.</li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{169,86},{349,236}}),Polygon(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, points={{169,236},{189,256},{369,256},{349,236},{169,236}}),Polygon(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, points={{369,256},{369,106},{349,86},{349,236},{369,256}}),Text(visible=true, fillColor={160,160,160}, extent={{179,196},{339,226}}, textString="Library", fontName="Arial"),Text(visible=true, extent={{206,119},{314,173}}, textString="[kg.m2]", fontName="Arial"),Text(visible=true, fillColor={255,0,0}, extent={{163,264},{406,320}}, textString="Modelica.SIunits", fontName="Arial")}));
    type Time= Real(final quantity="Time", final unit="s") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  end SIunits;

  package Icons "Icon definitions"
    annotation(preferedView="info", Documentation(info="<html>
<p>
This package contains definitions for the graphical layout of
components which may be used in different libraries.
The icons can be utilized by inheriting them in the desired class
using \"extends\".
</p>
<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2006, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added new icons <b>Function</b>, <b>Enumerations</b> and <b>Record</b>.</li>
<li><i>June 6, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Replaced <b>model</b> keyword by <b>package</b> if the main
       usage is for inheriting from a package.<br>
       New icons <b>GearIcon</b> and <b>MotorIcon</b>.</li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renaming package Icon to Icons.
       Model Advanced removed (icon not accepted on the Modelica meeting).
       New model Library2, which is the Library icon with enough place
       to add library specific elements in the icon. Icon also used in diagram
       level for models Info, TranslationalSensor, RotationalSensor.</li>
<li><i>July 15, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Model Caution renamed to Advanced, model Sensor renamed to
       TranslationalSensor, new model RotationalSensor.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version.</li>
</ul>
<br>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}),Text(visible=true, fillColor={255,0,0}, extent={{-120,70},{120,135}}, textString="%name", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, extent={{-90,10},{70,40}}, textString="Library", fontName="Arial"),Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}),Text(visible=true, fillColor={160,160,160}, extent={{-90,10},{70,40}}, textString="Library", fontName="Arial"),Polygon(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-64,-20},{-50,-4},{50,-4},{36,-20},{-64,-20},{-64,-20}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-64,-84},{36,-20}}),Text(visible=true, fillColor={128,128,128}, extent={{-60,-38},{32,-24}}, textString="Library", fontName="Arial"),Polygon(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{50,-4},{50,-70},{36,-84},{36,-20},{50,-4}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    partial package Library "Icon for library"
      annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}),Text(visible=true, fillColor={0,0,255}, extent={{-85,-85},{65,35}}, textString="Library", fontName="Arial"),Text(visible=true, fillColor={255,0,0}, extent={{-120,73},{120,122}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end Library;

    partial package Library2 "Icon for library where additional icon elements shall be added"
      annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}),Text(visible=true, fillColor={255,0,0}, extent={{-120,70},{120,125}}, textString="%name", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, fillPattern=FillPattern.Solid, extent={{-90,10},{70,40}}, textString="Library", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end Library2;

  end Icons;

end Modelica;
package ControlLabL "Package comprising sub-packages of blocks serving 
   processes of analysis and synthesis of linear and non-linear (linearized 
   around operating point) control systems."
  annotation(uses(Modelica(version="2.2.1")), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This 1.2 version of the <b>ControlLabL</b> (TM) library serves as 
a source of software tools utilized in the processes of analysis and  synthesis of linear and non-linear (linearized around operating point)  control  systems.
<p>
The library comprises three (3) sub-packages containing blocks utilized 
for modelling of control systems and their analysis and synthesis.</p>

<h3><font color=\"#008000\"><b>Description</b></font></h3>
The library contains the following sub-packages: 
<blockquote><pre>
 <b>* SystemModelUtilities</b>, 
 <b>* Sinks</b>, and 
 <b>* UsageExamples</b>.
</pre></blockquote>
<p>
The <b>SystemModelUtilities</b> sub-package contains models of blocks 
utilized for modelling of a control system.</p>
<p>
The <b>Sinks</b> subpackage holds models of sink blocks utilized for 
termination of the output signals from the modelling blocks (mainly for reasons of preventing the system model singularity).</p>
<p>
The <b>UsageExamples</b> sub-package contains practical examples of 
utilization and operation of the various <b>ControlLabL</b> (TM) library 
blocks and their interaction with the <b>Modelica Standard Library</b> (R) blocks.</p> 
<p>
More detailed information on the above packages, and the models 
(blocks) contained in them, may be found in the on-line help (folder <b>
...\\hlp\\ControlLabL_v1.2.html</b>).</p> 
</pre></blockquote>
<blockquote><pre>
Author(s): Copyright 2005-2009 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.2           Date 2008/12/18
</pre></blockquote>
</p>
</html>"), version="2.2.1", conversion(from(version="", script="ConvertFromControlLabL_.mos"), noneFromVersion="1"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  extends Modelica.Icons.Library2;
  package UsageExamples "Sub-package presents practical usage of components (blocks) of 
   the ControlLabL(ight) (TM) library"
    model DiagonalBlockTest "An example of interaction of a number of the 
   ControlLabL(ight)(TM) library's blocks with a special emphasis on 
   the DiagonalBlock and the SinkBlock_1R_2R"
      annotation(uses(Modelica(version="1.6")), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This example shows interaction of some of the <b>ControlLabL</b> (TM) library's blocks with some of the <b>Modelica Standard Library</b> (R) blocks.
<p>
The model <b>DiagonalBlockTest</b> combines operation of the following 
<b>Modelica Standard Library</b> (R) blocks:</p> 
<p>
<blockquote><pre>
 <b>* IntegerConstant</b>,
 <b>* Step</b>, 
</pre><blockquote>
</p>
<p>
and the following <b>ControlLabL</b> (TM) library's blocks:</p> 
<p>
<blockquote><pre>
 <b>* DiagonalBlock</b>,
 <b>* MatrixSourceBlock2</b>,
 <b>* MatrixSourceBlock5</b>, and
 <b>* SinkBlock_1R_2R.
</pre><blockquote>
</p>
<h3><font color=\"#008000\"><b>Description</b></font></h3>
The <b>DiagonalBlockTest</b> presents how to use the  <b>MatrixSourceBlock2</b> and <b>MatrixSourceBlock5</b> blocks in order to  provide the test input data for the <b>DiagonalBlock</b> block.
It also shows how the <b>SinkBlock_1R_2R</b> is used to prevent singularity of the model.
<p>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      ControlLabL.SystemModelUtilities.MatrixSourceBlock5 MatrixSourceBlock5_1 annotation(Placement(visible=true, transformation(origin={-40.0,10.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Modelica.Blocks.Sources.IntegerConstant IntegerConstant1 annotation(Placement(visible=true, transformation(origin={-40.0,50.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      Modelica.Blocks.Sources.Step Step1 annotation(Placement(visible=true, transformation(origin={-40.0,-70.0}, extent={{10.0,-10.0},{-10.0,10.0}}, rotation=0)));
      ControlLabL.SystemModelUtilities.MatrixSourceBlock2 MatrixSourceBlock2_1(n1=3, n2=3, n3=3, n4=3, m2=9, X=[1.0666,0.5406,0.1415;-1.515,-0.3111,0.0991;0.0796,0,-1.6828]) annotation(Placement(visible=true, transformation(origin={-40.0,-30.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      ControlLabL.Sinks.SinkBlock_1R_2R SinkBlock_1R_2R1 annotation(Placement(visible=true, transformation(origin={40.0,12.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      ControlLabL.SystemModelUtilities.DiagonalBlock DiagonalBlock1 annotation(Placement(visible=true, transformation(origin={0.0,10.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    equation 
      connect(Step1.y,SinkBlock_1R_2R1.inPort1[1]) annotation(Line(visible=true, points={{-51.0,-70.0},{-60.0,-70.0},{-60.0,80.0},{20.0,80.0},{20.0,14.1},{29.4,14.1}}, color={0,0,255}));
      connect(DiagonalBlock1.outPort1,SinkBlock_1R_2R1.inPort2) annotation(Line(visible=true, points={{10.6,10.1},{20.3,10.1},{20.3,10.0},{29.4,10.0}}, color={0,0,255}));
      connect(MatrixSourceBlock2_1.outPort1,DiagonalBlock1.inPort1) annotation(Line(visible=true, points={{-29.2,-30.0},{-20.0,-30.0},{-20.0,6.0},{-10.6,6.0}}, color={0,0,255}));
      connect(MatrixSourceBlock5_1.integerOutPort1,DiagonalBlock1.integerInPort2) annotation(Line(visible=true, points={{-29.4,10.1},{-19.7,10.1},{-19.7,10.0},{-10.6,10.0}}, color={255,127,0}));
      connect(IntegerConstant1.y,DiagonalBlock1.integerInPort1[1]) annotation(Line(visible=true, points={{-29.0,50.0},{-20.0,50.0},{-20.0,14.0},{-10.6,14.0}}, color={255,127,0}));
      connect(Step1.y,MatrixSourceBlock2_1.inPort1[1]) annotation(Line(visible=true, points={{-51.0,-70.0},{-60.0,-70.0},{-60.0,-30.0},{-50.8,-30.0}}, color={0,0,255}));
      connect(Step1.y,MatrixSourceBlock5_1.inPort1[1]) annotation(Line(visible=true, points={{-51.0,-70.0},{-60.0,-70.0},{-60.0,10.0},{-50.6,10.0}}, color={0,0,255}));
    end DiagonalBlockTest;

    annotation(Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
The <b>UsageExamples</b> package of the version 1.1 of the <b>ControlLabL</b> (TM) library serves as a source of information on the practical utilization of the library blocks.
<h3><font color=\"#008000\"><b>Description</b></font></h3>
<p>
The <b>UsageExamples</b> sub-package contains practical examples of 
utilization and operation of the various <b>ControlLabL</b> (TM) library 
blocks and their interaction with the <b>Modelica Standard Library</b> (R) blocks.</p> 
<p>
More detailed information on the above package, and the models 
(blocks) contained in it, may be found in the on-line help (folder <b>
...\\hlp\\ControlLabL_v1.1.html</b>).</p> 
</pre></blockquote>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  end UsageExamples;

  package SystemModelUtilities "Sub-package that comprises utility blocks used in support of the 
   control system model development process."
    extends Modelica.Icons.Library2;
    block MatrixSourceBlock2 "Block provides data of  X matrix elements"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer n1=6 "rows dimension of X matrix";
      parameter Integer n2=6 "columns dimension of X matrix";
      parameter Integer n3=6 "rows dimension of Y matrix";
      parameter Integer n4=6 "columns dimension of Y matrix";
      parameter Integer m1=1 "dimension of Real input signal connector 1";
      parameter Integer m2=36 "dimension of Real output signals connector 1 
  (for Y matrix)";
      parameter Real X[n1,n2]=[0.4665,0.3122,-0.7822,0.2579,-0.0039,-0.0803;-0.0046,0.0049,-0.0008,-0.0105,-0.9998,0.0155;-0.037,-0.025,0.0636,-0.0207,-0.0152,-0.9966;0.6725,-0.7324,0.1057,-0.0092,-0.0067,0.0005;0.0952,0.0654,-0.2353,-0.965,0.0102,-0.0003;0.5653,0.601,0.5635,-0.0409,0.0004,0.0007];
      Modelica.Blocks.Interfaces.RealInput inPort1[m1] "Connector of 
  Real input signal" annotation(Placement(visible=true, transformation(origin={-108.0,0.0}, extent={{-8.0,-8.0},{8.0,8.0}}, rotation=0), iconTransformation(origin={-108.0,0.0}, extent={{-8.0,-8.0},{8.0,8.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput outPort1[m2] "Connector of 
  Real output signals(for Y matrix of X matrix)" annotation(Placement(visible=true, transformation(origin={108.0,0.0}, extent={{-8.0,-8.0},{8.0,8.0}}, rotation=0), iconTransformation(origin={108.0,0.0}, extent={{-8.0,-8.0},{8.0,8.0}}, rotation=0)));
      output Integer indexyi;
      output Integer indexyj;
      output Integer my;
      output Integer ny;
      output Integer mny;
      output Real Y[n3,n4];
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    algorithm 
      Y[:,:]:=X[:,:];
      my:=n3;
      ny:=n4;
      mny:=my*ny;
      indexyi:=my;
      indexyj:=ny;
      while (indexyi > 0 and indexyi <= my) loop
        while (indexyj > 0) loop
          outPort1[mny]:=Y[indexyi,indexyj];
          mny:=mny - 1;
          assert(indexyj > 0, "Index of columns out of bounds.");
          indexyj:=indexyj - 1;
        end while;
        if indexyi > 0 then 
          indexyi:=indexyi - 1;
          indexyj:=ny;
        end if;
      end while;
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}), Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This block serves as a source of element data of a matrix utilized by other blocks (e.g. <b>QRDecompositionBlock1</b>).
<p>
The row and column dimensions of the matrix may be changed by adjusting their sizes in the <b>Parameters...</b> dialogue window.</p>
<p>
The block serves as a convenient source of data in testing development models.</p>
<h3><font color=\"#008000\"><b>Description</b></font></h3>
The algorithm of the block comprises, first of all, an assignment statement using the output matrix <b>Y[:, :]</b> as its left-hand side and the <b>X[:, :]</b> matrix as its right-hand side. Elements of the <b>X</b> are user-supplied in the <b>Parameters...</b> dialogue window. <p>
Then, it writes out elements of the output matrix <b>Y</b> employing the <b>outPort1</b> connector for that purpose.</p>
<p>The input connector <b>inPort1</b> may be utilized for initiating block's operation if and when required.</p>
<p>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"));
    end MatrixSourceBlock2;

    block MatrixSourceBlock5 "Block provides data of  X matrix with integer valued elements"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer n1=8 "rows dimension of X matrix";
      parameter Integer n2=1 "columns dimension of X matrix";
      parameter Integer n3=8 "rows dimension of Y matrix";
      parameter Integer n4=1 "columns dimension of Y matrix";
      parameter Integer m1=1 "dimension of Real input signal connector 1";
      parameter Integer m2=8 "dimension of Integer output signals connector 1 
  (for Y matrix)";
      Modelica.Blocks.Interfaces.RealInput inPort1[m1] "Connector of 
  Real input signal" annotation(Placement(visible=true, transformation(origin={-106.0,0.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0), iconTransformation(origin={-106.0,0.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.IntegerOutput integerOutPort1[m2] "Connector of Integer output signal" annotation(Placement(visible=true, transformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      parameter Integer X[:,:]=[3;1;1;1;3;3;3;3];
      output Integer indexyi;
      output Integer indexyj;
      output Integer my;
      output Integer ny;
      output Integer mny;
      output Integer Y[n3,n4];
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    algorithm 
      Y[:,:]:=X[:,:];
      my:=n3;
      ny:=n4;
      mny:=my*ny;
      indexyi:=my;
      indexyj:=ny;
      while (indexyi > 0 and indexyi <= my) loop
        while (indexyj > 0) loop
          integerOutPort1[mny]:=Y[indexyi,indexyj];
          mny:=mny - 1;
          assert(indexyj > 0, "Index of columns out of bounds.");
          indexyj:=indexyj - 1;
        end while;
        if indexyi > 0 then 
          indexyi:=indexyi - 1;
          indexyj:=ny;
        end if;
      end while;
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}), Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This block serves as a source of element data of a matrix utilized by other blocks (e.g. <b>DiagonalBlock</b>).
<p>
The row and column dimensions of the matrix may be changed by adjusting their sizes in the <b>Parameters...</b> dialogue window.</p>
<p>
The block serves as a convenient source of data in testing development models.</p>
<h3><font color=\"#008000\"><b>Description</b></font></h3>
The algorithm of the block comprises, first of all, an assignment statement using the output matrix <b>Y[:, :]</b> as its left-hand side and the <b>X[:, :]</b> matrix as its right-hand side. Elements of the <b>X</b> are user-supplied in the <b>Parameters...</b> dialogue window. <p>
Then, it writes out elements of the output matrix <b>Y</b> employing the <b>outPort1</b> connector for that purpose.</p>
<p>The input connector <b>inPort1</b> may be utilized for initiating block's operation if and when required.</p>
<p>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"));
    end MatrixSourceBlock5;

    block DiagonalBlock "Extracts elements of symbolic diagonals of an input matrix"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer m1=1 "dimension of integer input signal connector 1";
      parameter Integer m2=8 "dimension of integer input signal connector 2";
      parameter Integer m3=9 "dimension of real input signal connector";
      parameter Integer m4=2 "dimension of real output signal connector";
      parameter Integer m5=3 "columns span of Xaux input matrix(vector)";
      parameter Integer m6=3 "rows span of Xaux input matrix(vector) - defined as a ratio of m3 and m5 (above)";
      parameter Integer m7=1 "columns span of diagonal matrix(vector)";
      parameter Integer m8=2 "rows span of diagonal matrix(vector) - defined as a ratio of m4 and m7 (above)";
      Modelica.Blocks.Interfaces.IntegerInput integerInPort1[m1] "Connector of Integer input signal(for diagonal offset value)" annotation(Placement(visible=true, transformation(origin={-106.0,40.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0), iconTransformation(origin={-106.0,40.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.IntegerInput integerInPort2[m2] "Connector of Integer input signals(for matrices row and column sizes)" annotation(Placement(visible=true, transformation(origin={-106.0,0.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0), iconTransformation(origin={-106.0,0.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput inPort1[m3] "Connector of Real input signals(for the Xaux input matrix)" annotation(Placement(visible=true, transformation(origin={-106.0,-40.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0), iconTransformation(origin={-106.0,-40.0}, extent={{-6.0,-6.0},{6.0,6.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput outPort1[m4] "Connector of Real output signals(for the Ydia diagonal matrix)" annotation(Placement(visible=true, transformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      output Real Xaux[m6,m5] "Matrix requiring definition of diagonal elements";
      output Real Ydia[m8,m7] "Matrix (vector) containing elements of diagonal";
      output Integer ninarg "Number of input arguments for the block";
      input Integer mb;
      input Integer nb;
      input Integer mr;
      input Integer nr;
      input Integer ms;
      input Integer ns;
      input Integer me;
      input Integer ne;
      input Integer offset;
      output Integer indexxi;
      output Integer indexxj;
      output Integer mx;
      output Integer nx;
      output Integer mnx;
      output Integer indexyi;
      output Integer indexyj;
      output Integer my;
      output Integer ny;
      output Integer mny;
      output Integer d;
      output Real tempd;
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    algorithm 
      offset:=integerInPort1[1] "Diagonal offset from the main diagonal(offset=0 (main diagonal), offset>0 (above main), offset<0 (below main))";
      if offset == 0 then 
        ninarg:=1;
      else
        ninarg:=2;
      end if;
      mb:=integerInPort2[1];
      nb:=integerInPort2[2];
      mr:=integerInPort2[3];
      nr:=integerInPort2[4];
      ms:=integerInPort2[5];
      ns:=integerInPort2[6];
      me:=integerInPort2[7];
      ne:=integerInPort2[8];
      mx:=m6;
      nx:=m5;
      mnx:=mx*nx;
      indexxi:=mx;
      indexxj:=nx;
      while (indexxi > 0 and indexxi <= mx) loop
        while (indexxj > 0) loop
          Xaux[indexxi,indexxj]:=inPort1[mnx];
          mnx:=mnx - 1;
          assert(indexxj > 0, "Index of columns out of bounds.");
          indexxj:=indexxj - 1;
        end while;
        if indexxi > 0 then 
          indexxi:=indexxi - 1;
          indexxj:=nx;
        end if;
      end while;
      if size(Xaux, 2) - 1 > -1e-06 and size(Xaux, 2) - 1 < 1e-06 then 
        tempd:=max(size(Xaux)) + abs(offset);
        d:=integer(tempd) "Dimension of the returned square matrix";
        my:=d;
        ny:=d;
        if offset >= 0 then 
          for k in 1:max(size(Xaux)) loop
            Ydia[k,k + offset]:=Xaux[k,1];
          end for;
        else
          for k in 1:max(size(Xaux)) loop
            Ydia[k + integer(abs(offset)),k]:=Xaux[k,1];
          end for;
        end if;
      else
        tempd:=max(size(Xaux)) - abs(offset);
        d:=integer(tempd) "Dimension of the returned matrix (vector)";
        my:=d;
        ny:=1;
        if offset >= 0 then 
          for k in 1:max(size(Xaux)) - offset loop
            Ydia[k,1]:=Xaux[k,k + offset];
          end for;
        else
          for k in 1:max(size(Xaux)) + offset loop
            Ydia[k,1]:=Xaux[k + integer(abs(offset)),k];
          end for;
        end if;
      end if;
      mny:=my*ny;
      indexyi:=my;
      indexyj:=ny;
      while (indexyi > 0 and indexyi <= my) loop
        while (indexyj > 0) loop
          outPort1[mny]:=Ydia[indexyi,indexyj];
          mny:=mny - 1;
          assert(indexyj > 0, "Index of columns out of bounds.");
          indexyj:=indexyj - 1;
        end while;
        if indexyi > 0 then 
          indexyi:=indexyi - 1;
          indexyj:=ny;
        end if;
      end while;
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}), Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This block returns a square matrix (a one-dimensional matrix - vector) defining elements of diagonals of an input matrix <b>X</b>.
The form of the output matrix (vector) depends on the dimension sizes of the input and an offset value - <b>offset</b>.
When an input is in the form of a vector of <b>n</b> elements the output is in the form of a square matrix <b>Ydia</b> of order <b>n + abs(offset)</b> with elements of the vector on the <b>offset-th</b> diagonal.
The quantity <b>offset</b> assumes values: <b>0</b> for the main diagonal, positive integer <b>(+)</B> values for diagonals above the main diagonal, and negative integer <b>(-)</b> values for the diagonals below the main diagonal.
<h3><font color=\"#008000\"><b>Description</b></font></h3>
The input of the block is supplied through the three(3) input connectors.
<p>The <b>inPort1</b> delivers element data for the <b>Xaux</b> matrix (vector) requiring definition of the diagonals.</p><p>
The <b>integerInPort1</b> provides row and column dimension sizes of the B,R,S and E matrices (input of the <b>RiccatiContinuousBlock</b> block).
</p><p>Note:Only sizes of the B matrix are used by this block!</p><p>
The <b>integerInPort2</b> provides the value of <b>offset</b> from the main diagonal of the <b>Ydia</b> output matrix.</p><p>
The main output of the block is in the form of <b>Ydia</b> matrix (vector) elements delivered through the <b>outPort1</b> connector.</p>
<h3><font color=\"#008000\">Examples:</font></h3>
<b>1.</b> Having the matrix <b>Ds</b> :
<blockquote><pre>
 -176.9650   73.3683  116.9336  -59.2698   14.6395   73.9988
         0  176.9650 -166.0914   34.1020   10.2518   82.2263
         0         0   -1.0382  -17.7229  -34.5375  286.8481
         0         0    3.5779   -1.0382 -254.8666  -53.2777
         0         0         0         0    1.0382  -29.8965
         0         0         0         0    2.1210    1.0382
</pre></blockquote>
and the value of <b>offset</b> = 1
<p>yields the diagonal vector:</p>
<blockquote><pre>
   73.3683
 -166.0914
  -17.7229
 -254.8666
  -29.8965
</pre></blockquote>
for value of <b>offset</b> = 0
<p>we have the diagonal vector :</p>
<blockquote><pre>
 -176.9650
  176.9650
   -1.0382
   -1.0382
    1.0382
    1.0382
</pre></blockquote>
and for value of <b>offset</b> = -1
<p>we have the diagonal vector :</p>
<blockquote><pre>
         0
         0
    3.5779
         0
    2.1210
</pre></blockquote>
<b>2.</b> Having the vector <b>R</b> :
<blockquote><pre>
     1
     0
     0
</pre></blockquote>
and the value of <b>offset</b> = 0
<p>
yields the <b>Ydia</b> diagonal matrix :</p>
<blockquote><pre>
     1     0     0
     0     0     0
     0     0     0
</pre></blockquote>
for the value of <b>offset</b> = 1
<p>
we have the <b>Ydia</b> diagonal matrix :</p>
<blockquote><pre>
     0     1     0     0
     0     0     0     0
     0     0     0     0
     0     0     0     0
</pre></blockquote>
for the value of <b>offset</b> = -1
<p>
we have the <b>Ydia</b> diagonal matrix :</p>
<blockquote><pre>
     0     0     0     0
     1     0     0     0
     0     0     0     0
     0     0     0     0
<p>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"));
    end DiagonalBlock;

    annotation(Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
The <b>SystemModelUtilities</b> package of the version 1.1 of the <b>ControlLabL</b> (TM) library constitutes the main package of the library. It provides building blocks of the control system models in the processes of the control systems analysis and synthesis.
<h3><font color=\"#008000\"><b>Description</b></font></h3>
<p>
The <b>SystemModelUtilities</b> sub-package contains the various building blocks of the <b>ControlLabL</b> (TM) library.</p> 
<p>
More detailed information on the above package, and the blocks contained in it, may be found in the on-line help (folder <b>
...\\hlp\\ControlLabL_v1.1.html</b>).</p> 
</pre></blockquote>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  end SystemModelUtilities;

  package Sinks "Sub-package that contains blocks for convenient termination 
   of Real, Integer and Boolean output signals"
    extends Modelica.Icons.Library2;
    block SinkBlock_1R_2R "Sink block with two Real type signal input connectors of which one 
   allows reading one-dimensional array (vector) content and with 
   optional three Real type signal output connectors"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      Modelica.Blocks.Interfaces.RealInput inPort1[n1] "Connector of Real input signals" annotation(Placement(visible=true, transformation(origin={-106.0,21.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={-106.0,21.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput inPort2[n2] annotation(Placement(visible=true, transformation(origin={-106.0,-20.0}, extent={{-6.0,-8.0},{6.0,8.0}}, rotation=0), iconTransformation(origin={-106.0,-20.0}, extent={{-6.0,-8.0},{6.0,8.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput outPort1[m1] "Connector of Real output signals" annotation(Placement(visible=true, transformation(origin={106.0,41.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={106.0,41.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput outPort2[m2] "Connector of Real output signals" annotation(Placement(visible=true, transformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={106.0,1.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput outPort3[m3] "Connector of Real output signals" annotation(Placement(visible=true, transformation(origin={106.0,-39.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0), iconTransformation(origin={106.0,-39.0}, extent={{-6.0,-7.0},{6.0,7.0}}, rotation=0)));
      parameter Integer n1=1 "dimension of input signal connector 1";
      parameter Integer n2=2 "dimension of input signal connector 2";
      parameter Integer m1=1 "dimension of output signal connector 1";
      parameter Integer m2=1 "dimension of output signal connector 2";
      parameter Integer m3=1 "dimension of output signal connector 3";
      output Real u1;
      output Real u2[n2];
      output Real y1;
      output Real y2;
      output Real y3;
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    algorithm 
      u1:=inPort1[1];
      u2[:]:=inPort2[:];
      y1:=u1;
      y2:=u2[1];
      y3:=u2[2];
      outPort1[1]:=y1;
      outPort2[1]:=y2;
      outPort3[1]:=y3;
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}), Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
This block serves as a sink for one (main) Real type signal and one additional (auxiliary) Real type multi-valued signal needed by output signals from another block (e.g. <b>MatrixSourceBlock2</b>).
<p>
The block serves as a convenient termination point for signals from another block's output connectors, which not being terminated would give rise to a  condition of model singularity.</p>
<h3><font color=\"#008000\"><b>Description</b></font></h3>
The algorithm of the block comprises of reading the Real input signals <b>u1</b> (auxiliary) and the <b>u2[:]</b> (main) two-valued Real input signal by the <b>inPort1</b> and the multiple <b>inPort2</b> input connectors respectively.
<p>
The block's algorithm also allows to output optionally and independently all the three signals (if required) employing the <b>outPort1</b>, <b>outPort2</b> and <b>outPort3</b> output connectors.</p>
<p>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"));
    end SinkBlock_1R_2R;

    annotation(Documentation(info="<html>
<html><h3><font color=\"#008000\"><b>INTRODUCTION</b></font></h3>
The <b>Sinks</b> package of the version 1.1 of the <b>ControlLabL</b> (TM) library constitutes a service package of the library. It provides sink blocks in the control system models in the processes of the control systems analysis and synthesis.
<h3><font color=\"#008000\"><b>Description</b></font></h3>
<p>
The <b>Sinks</b> sub-package contains the various sink blocks of the <b>ControlLabL</b> (TM) library.</p> 
<p>
More detailed information on the above package, and the blocks contained in it, may be found in the on-line help (folder <b>
...\\hlp\\ControlLabL_v1.1.html</b>).</p> 
</pre></blockquote>
<blockquote><pre>
Author(s): Copyright 2005-2006 <b> A.(Andy)M.W.Brauer</b>
           E-mail address:       <b>andy.brauer@gmail.com</b>
           Release 1.1           Date 2006/04/18
</pre></blockquote>
</p>
</html>"), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  end Sinks;

end ControlLabL;
model ControlLabL_UsageExamples_DiagonalBlockTest
  extends ControlLabL.UsageExamples.DiagonalBlockTest;
end ControlLabL_UsageExamples_DiagonalBlockTest;
