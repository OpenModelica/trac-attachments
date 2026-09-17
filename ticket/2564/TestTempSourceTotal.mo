package Modelica "Modelica Standard Library - Version 3.2.1 (Build 2)"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Interfaces
    "Library of connectors and partial models for input/output blocks"
      import Modelica.SIunits;
      extends Modelica.Icons.InterfacesPackage;

      connector RealInput = input Real "'input Real' as connector" annotation (
        defaultComponentName="u",
        Icon(graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
          coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{-10.0,60.0},{-10.0,85.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));

      connector RealOutput = output Real "'output Real' as connector" annotation (
        defaultComponentName="y",
        Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{30.0,60.0},{30.0,110.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));
      annotation (Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</html>",     revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces.
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
</html>"));
    end Interfaces;

    package Sources
    "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

      block RealExpression
      "Set output signal to a time varying Real expression"

        Modelica.Blocks.Interfaces.RealOutput y=0.0 "Value of Real output"
          annotation (Dialog(group="Time varying output signal"), Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));

        annotation (Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,40},{100,-40}},
                lineColor={0,0,0},
                lineThickness=5.0,
                fillColor={235,235,235},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised),
              Text(
                extent={{-96,15},{96,-15}},
                lineColor={0,0,0},
                textString="%y"),
              Text(
                extent={{-150,90},{140,50}},
                textString="%name",
                lineColor={0,0,255})}), Documentation(info="<html>
<p>
The (time varying) Real output signal of this block can be defined in its
parameter menu via variable <b>y</b>. The purpose is to support the
easy definition of Real expressions in a block diagram. For example,
in the y-menu the definition \"if time &lt; 1 then 0 else 1\" can be given in order
to define that the output signal is one, if time &ge; 1 and otherwise
it is zero. Note, that \"time\" is a built-in variable that is always
accessible and represents the \"model time\" and that
Variable <b>y</b> is both a variable and a connector.
</p>
</html>"));

      end RealExpression;
      annotation (Documentation(info="<HTML>
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
  <tr><td valign=\"top\"><b>offset</b></td>
      <td valign=\"top\">Value which is added to the signal</td>
  </tr>
  <tr><td valign=\"top\"><b>startTime</b></td>
      <td valign=\"top\">Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Sources;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}, initialScale=0.1), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(
          origin={-51.25,0.0},
          points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(
          origin={51.25,0.0},
          points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
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
<p>
Copyright &copy; 1998-2013, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapted all blocks to the new connectors.
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
</html>"));
  end Blocks;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
              {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
              -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
              -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
              {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
              0,0,0}, smooth=Smooth.Bezier)}), Documentation(info="<HTML>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<dl>
<dt><b>Main Authors:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
    Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2013, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
  end Math;

  package Icons "Library of icons"
    extends Icons.Package;

    partial package Package "Icon for standard packages"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              fillPattern=FillPattern.None,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0)}),   Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package InterfacesPackage "Icon for packages containing interfaces"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={20.0,0.0},
              lineColor={64,64,64},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              points={{-10.0,70.0},{10.0,70.0},{40.0,20.0},{80.0,20.0},{80.0,-20.0},{40.0,-20.0},{10.0,-70.0},{-10.0,-70.0}}),
            Polygon(fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-100.0,20.0},{-60.0,20.0},{-30.0,70.0},{-10.0,70.0},{-10.0,-70.0},{-30.0,-70.0},{-60.0,-20.0},{-100.0,-20.0}})}),
                                Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
    end InterfacesPackage;

    partial package SourcesPackage "Icon for packages containing sources"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={23.3333,0.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
            Rectangle(
              fillColor = {128,128,128},
              pattern = LinePattern.None,
              fillPattern = FillPattern.Solid,
              extent = {{-70,-4.5},{0,4.5}})}),
                                Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
    end SourcesPackage;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}},
              lineColor={0,0,0})}), Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>

<h4>Main Authors:</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
    <dd>Oberpfaffenhofen</dd>
    <dd>Postfach 1116</dd>
    <dd>D-82230 Wessling</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
<dt>Christian Kral</dt>
    <dd><a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a></dd>
    <dd>Mobility Department</dd><dd>Giefinggasse 2</dd>
    <dd>1210 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>Copyright &copy; 1998-2013, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
    "Absolute temperature (use type TemperatureDifference for relative temperatures)"
                                                                                                        annotation(absoluteValue=true);

    type Temperature = ThermodynamicTemperature;

    type HeatFlux = Real (final quantity="HeatFlux", final unit="W/m2");
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-66,78},{-66,-40}},
            color={64,64,64},
            smooth=Smooth.None),
          Ellipse(
            extent={{12,36},{68,-38}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,78},{-66,-40}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
            lineColor={64,64,64},
            smooth=Smooth.None,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
            lineColor={64,64,64},
            smooth=Smooth.None,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,26},{58,-28}},
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
                {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{68,
                2}},
            lineColor={64,64,64},
            smooth=Smooth.Bezier,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
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
<a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2013, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
<li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
<li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br/>Some chapters realized.</li>
</ul>
</html>"));
  end SIunits;
annotation (
preferredView="info",
version="3.2.1",
versionBuild=2,
versionDate="2013-08-14",
dateModified = "2013-08-14 08:44:41Z",
revisionId="$Id:: package.mo 6947 2013-08-23 07:41:37Z #$",
uses(Complex(version="3.2.1"), ModelicaServices(version="3.2.1")),
conversion(
 noneFromVersion="3.2",
 noneFromVersion="3.1",
 noneFromVersion="3.0.1",
 noneFromVersion="3.0",
 from(version="2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")),
Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
  Polygon(
    origin={-6.9888,20.048},
    fillColor={0,0,0},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    points={{-93.0112,10.3188},{-93.0112,10.3188},{-73.011,24.6},{-63.011,31.221},{-51.219,36.777},{-39.842,38.629},{-31.376,36.248},{-25.819,29.369},{-24.232,22.49},{-23.703,17.463},{-15.501,25.135},{-6.24,32.015},{3.02,36.777},{15.191,39.423},{27.097,37.306},{32.653,29.633},{35.035,20.108},{43.501,28.046},{54.085,35.19},{65.991,39.952},{77.897,39.688},{87.422,33.338},{91.126,21.696},{90.068,9.525},{86.099,-1.058},{79.749,-10.054},{71.283,-21.431},{62.816,-33.337},{60.964,-32.808},{70.489,-16.14},{77.368,-2.381},{81.072,10.054},{79.749,19.05},{72.605,24.342},{61.758,23.019},{49.587,14.817},{39.003,4.763},{29.214,-6.085},{21.012,-16.669},{13.339,-26.458},{5.401,-36.777},{-1.213,-46.037},{-6.24,-53.446},{-8.092,-52.387},{-0.684,-40.746},{5.401,-30.692},{12.81,-17.198},{19.424,-3.969},{23.658,7.938},{22.335,18.785},{16.514,23.283},{8.047,23.019},{-1.478,19.05},{-11.267,11.113},{-19.734,2.381},{-29.259,-8.202},{-38.519,-19.579},{-48.044,-31.221},{-56.511,-43.392},{-64.449,-55.298},{-72.386,-66.939},{-77.678,-74.612},{-79.53,-74.083},{-71.857,-61.383},{-62.861,-46.037},{-52.278,-28.046},{-44.869,-15.346},{-38.784,-2.117},{-35.344,8.731},{-36.403,19.844},{-42.488,23.813},{-52.013,22.49},{-60.744,16.933},{-68.947,10.054},{-76.884,2.646},{-93.0112,-12.1707},{-93.0112,-12.1707}},
    smooth=Smooth.Bezier),
  Ellipse(
    origin={40.8208,-37.7602},
    fillColor={161,0,4},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    extent={{-17.8562,-17.8563},{17.8563,17.8562}})}),
Documentation(info="<HTML>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  provides an overview of the Modelica Standard Library
  inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  lists the contributors of the Modelica Standard Library.</li>
<li> The <b>Examples</b> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li><b>1360</b> models and blocks, and</li>
<li><b>1280</b> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2013, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.Haumer, ITI, Modelon,
TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>
<b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
</p>
</html>"));
end Modelica;

package ThermoPower "Open library for thermal power plant simulation"
extends Modelica.Icons.Package;
import Modelica.Math.*;
import Modelica.SIunits.*;

package Icons "Icons for ThermoPower library"
  extends Modelica.Icons.Package;

  partial model HeatFlow

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward)}));
  end HeatFlow;
end Icons;

  package Thermal "Thermal models of heat transfer"
    extends Modelica.Icons.Package;

    connector DHT "Distributed Heat Terminal"
      parameter Integer N(min=1) = 2 "Number of nodes";
      AbsoluteTemperature T[N] "Temperature at the nodes";
      flow HeatFlux phi[N] "Heat flux at the nodes";
      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}));
    end DHT;

    model TempSource1Dlin "Linearly Distributed Temperature Source"
      extends Icons.HeatFlow;
      parameter Integer N=2 "Number of nodes";
      replaceable Thermal.DHT wall(N=N) annotation (Placement(transformation(
              extent={{-40,-40},{40,-20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput temperature_node1 annotation (
          Placement(transformation(
            origin={-40,30},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput temperature_nodeN annotation (
          Placement(transformation(
            origin={40,28},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      wall.T = linspace(
          temperature_node1,
          temperature_nodeN,
          N);
      annotation (
        Documentation(info="<HTML>
<p>Model of an ideal 1D temperature source with a linear distribution. The values of the temperature at the two ends of the source are provided by the <tt>temperature_node1</tt> and <tt>temperature_nodeN</tt> signal connectors.
</HTML>",   revisions="<html>
<ul>
<li><i>10 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>
"),     Icon(graphics={Text(
              extent={{-100,-46},{100,-72}},
              lineColor={191,95,0},
              textString="%name")}));
    end TempSource1Dlin;
    annotation (Documentation(info="<HTML>
This package contains models of physical processes and components related to heat transfer phenomena.
<p>All models with dynamic equations provide initialisation support. Set the <tt>initOpt</tt> parameter to the appropriate value:
<ul>
<li><tt>Choices.Init.Options.noInit</tt>: no initialisation
<li><tt>Choices.Init.Options.steadyState</tt>: full steady-state initialisation
</ul>
The latter options can be useful when two or more components are connected directly so that they will have the same pressure or temperature, to avoid over-specified systems of initial equations.

</HTML>"));
  end Thermal;

type AbsoluteTemperature = Temperature (start=300, nominal=500)
  "generic temperature";
annotation (
  Documentation(info="<html>
<b>General Information</b>
<p>The ThermoPower library is an open-source <a href=\"http://www.modelica.org/libraries\">Modelica library</a>for the dynamic modelling of thermal power plants and energy conversion systems. It provides basic components for system-level modelling, in particular for the study of control systems in traditional and innovative power plants and energy conversion systems.</p>
<p>The library is hosted by <a href=\"http://sourceforge.net/projects/thermopower/\">sourceforge.net</a> and has been under continuous development at Politecnico di Milano since 2002. It has been applied to the dynamic modelling of steam generators, combined-cycle power plants, III- and IV-generation nuclear power plants, direct steam generation solar plants, organic Rankine cycle plants, and cryogenic circuits for nuclear fusion applications. The main author is Francesco Casella, with contributions from Alberto Leva, Matilde Ratti, Luca Savoldelli, Roberto Bonifetto, Stefano Boni, and many others. The library is licensed under the <b><a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">Modelica License 2</a></b>. The library has been developed as a tool for research in the field of energy system control at the Dipartimento di Elettronica, Informazione e Bioingegneria of Politecnico di Milano and progressively enhanced as new projects were undertaken there. It has been released as open source for the benefit of the community, but without any guarantee of support or completeness of documentation.</p>
<p>The latest official release of the library is ThermoPower 2.1, which is compatible with Modelica 2.2 and Modelica Standard Library 2.2.x. This release is now quite old. From 2009 to 2012, the development of the library focused on: </p>
<ul>
<li>Conversion to Modelica 3.x (new graphical annotations, use of enumerations) </li>
<li>Use of stream connectors, compatible with the Modelica.Fluid library, allowing multiple-way connections (see <a href=\"http://dx.doi.org/10.3384/ecp09430078\">paper</a>) </li>
<li>Use of the homotopy operator for improved initialization (see <a href=\"https://www.modelica.org/events/modelica2011/Proceedings/pages/papers/04_2_ID_131_a_fv.pdf\">paper</a>) </li>
<li>Bugfixing</li>
</ul>
<p>Until 2012, the library was developed using the tool <a href=\"http://www.3ds.com/products/catia/portfolio/dymola\">Dymola</a>, and could only be used within that tool, due to limitations of other Modelica tools available at the time. An official version was never released during that period, because we kept on experimenting new features, some of them experimental (e.g., homotopy-based initialization), so the library never reached a stable state. The plan is to release a revision 3.0, which will run in Dymola, and will incorporate all these changes. In the meantime, you can obtain this version of the library by anonymous SVN checkout from this URL:<br><br><a href=\"svn://svn.code.sf.net/p/thermopower/svn/branches/release.3.0\">svn://svn.code.sf.net/p/thermopower/svn/branches/release.3.0</a><br><br>
If you are running Windows, we recommend using the excellent <a href=\"http://tortoisesvn.net/\">TortoiseSVN</a> client to checkout the library.</p>
<p>Since 2013, the development started focusing on three main lines. 
<ol>
<li>We are working towards making the library fully compliant to Modelica 3.2rev2 and to the Modelica Standard Library 3.2.1, in order to be usable with other Modelica tools. The library is currently being tested with OpenModelica, and is expected to run satisfactorily in that tool within the year 2013. </li>
<li>The second development line is to improve the structure of the Flow1D models, for greater flexibility and ease of use. In particular, we are changing the design of the distributed heat ports, which had several shortcomings in the original design, and adding replaceable models for the heat transfer and friction models. The new Flow1D models will be incompatible with the old ones, which will be kept (but deprecated) for backwards compatibility. </li>
<li>The last development is to change the way initial conditions are specified. The current design relies on initial equations being automatically generated by the tool, based on start attributes, which has several problems if you want to use the library with different Modelica tools and get the same results everywhere. Doing this right might eventually lead to a library which is not backwards-compatible with earlier versions.</li>
</ol></p>
<p>Eventually, these improvements will be incorporated in the 3.1 release. You can have a look at the work in progress by anonymous SVN checkout from this URL:<br><br><a href=\"svn://svn.code.sf.net/p/thermopower/svn/trunk\">svn://svn.code.sf.net/p/thermopower/svn/trunk</a></p>
<p>To give you an idea on the structure and content of the library, the automatically generated&nbsp;documentation of the 2.1 release can be browsed on-line <a href=\"http://thermopower.sourceforge.net/help/ThermoPower.html\">here</a>.</p>
<p>If you want to get involved in the development, or you need some information, please contact the main developer <a href=\"mailto://francesco.casella@polimi.it\">francesco.casella@polimi.it</a>.</p>
<p><b>References</b></p>
<p>A general description of the library and on the modelling principles can be found in the papers: </p>
<p><ul>
<li>F. Casella, A. Leva, &QUOT;Modelling of distributed thermo-hydraulic processes using Modelica&QUOT;, <i>Proceedings of the MathMod &apos;03 Conference</i>, Wien , Austria, February 2003. </li>
<li>F. Casella, A. Leva, &QUOT;Modelica open library for power plant simulation: design and experimental validation&QUOT;, <i>Proceedings of the 2003 Modelica Conference</i>, Link&ouml;ping, Sweden, November 2003, pp. 41-50. (<a href=\"http://www.modelica.org/Conference2003/papers/h08_Leva.pdf\">Available online</a>) </li>
<li>F. Casella, A. Leva, &QUOT;Simulazione di impianti termoidraulici con strumenti object-oriented&QUOT;, <i>Atti convegno ANIPLA Enersis 2004,</i> Milano, Italy, April 2004 (in Italian). </li>
<li>F. Casella, A. Leva, &QUOT;Object-oriented library for thermal power plant simulation&QUOT;, <i>Proceedings of the Eurosis Industrial Simulation Conference 2004 (ISC-2004)</i>, Malaga, Spain, June 2004. </li>
<li>F. Casella, A. Leva, &QUOT;Simulazione object-oriented di impianti di generazione termoidraulici per studi di sistema&QUOT;, <i>Atti convegno nazionale ANIPLA 2004</i>, Milano, Italy, September 2004 (in Italian).</li>
<li>Francesco Casella and Alberto Leva, &ldquo;Modelling of Thermo-Hydraulic Power Generation Processes Using Modelica&rdquo;. <i>Mathematical and Computer Modeling of Dynamical Systems</i>, vol. 12, n. 1, pp. 19-33, Feb. 2006. <a href=\"http://dx.doi.org/10.1080/13873950500071082\">Online</a>. </li>
<li>Francesco Casella, J. G. van Putten and Piero Colonna, &ldquo;Dynamic Simulation of a Biomass-Fired Power Plant: a Comparison Between Causal and A-Causal Modular Modeling&rdquo;. In <i>Proceedings of 2007 ASME International Mechanical Engineering Congress and Exposition</i>, Seattle, Washington, USA, Nov. 11-15, 2007, paper IMECE2007-41091 (Best paper award). </li>
</ul></p>
<p><br/>Other papers about the library and its applications:</p>
<p><ul>
<li>F. Casella, F. Schiavo, &QUOT;Modelling and Simulation of Heat Exchangers in Modelica with Finite Element Methods&QUOT;, <i>Proceedings of the 2003 Modelica Conference</i>, Link&ouml;ping, Sweden, 2003, pp. 343-352. (<a href=\"http://www.modelica.org/Conference2003/papers/h22_Schiavo.pdf\">Available online</a>) </li>
<li>A. Cammi, M.E. Ricotti, F. Casella, F. Schiavo, &QUOT;New modelling strategy for IRIS dynamic response simulation&QUOT;, <i>Proc. 5th International Conference on Nuclear Option in Countries with Small and Medium Electricity Grids</i>, Dubrovnik, Croatia, May 2004.</li>
<li>A. Cammi, F. Casella, M.E. Ricotti, F. Schiavo, &QUOT;Object-oriented Modelling for Integral Nuclear Reactors Dynamic Dimulation&QUOT;, <i>Proceedings of the International Conference on Integrated Modeling &AMP; Analysis in Applied Control &AMP; Automation</i>, Genova, Italy, October 2004. </li>
<li>Antonio Cammi, Francesco Casella, Marco Ricotti and Francesco Schiavo, &ldquo;Object-Oriented Modeling, Simulation and Control of the IRIS Nuclear Power Plant with Modelica&rdquo;. In <i>Proceedings 4th International Modelica Conference</i>, Hamburg, Germany,Mar. 7-8, 2005, pp. 423-432. <a href=\"http://www.modelica.org/events/Conference2005/online_proceedings/Session5/Session5b3.pdf\">Online</a>. </li>
<li>A. Cammi, F. Casella, M. E. Ricotti, F. Schiavo, G. D. Storrick, &QUOT;Object-oriented Simulation for the Control of the IRIS Nuclear Power Plant&QUOT;, <i>Proceedings of the IFAC World Congress, </i>Prague, Czech Republic, July 2005 </li>
<li>Francesco Casella and Francesco Pretolani, &ldquo;Fast Start-up of a Combined-Cycle Power Plant: a Simulation Study with Modelica&rdquo;. In <i>Proceedings 5th International Modelica Conference</i>, Vienna, Austria, Sep. 6-8, 2006, pp. 3-10. <a href=\"http://www.modelica.org/events/modelica2006/Proceedings/sessions/Session1a1.pdf\">Online</a>. </li>
<li>Francesco Casella, &ldquo;Object-Oriented Modelling of Two-Phase Fluid Flows by the Finite Volume Method&rdquo;. In <i>Proceedings 5th Mathmod Vienna</i>, Vienna, Austria, Feb. 8-10, 2006. </li>
<li>Andrea Bartolini, Francesco Casella, Alberto Leva and Valeria Motterle, &ldquo;A Simulation Study of the Flue Gas Path Control System in a Coal-Fired Power Plant&rdquo;. In <i>Proceedings ANIPLA International Congress 2006</i>, Rome, Italy,vNov. 13-15, 2006. </li>
<li>Francesco Schiavo and Francesco Casella, &ldquo;Object-oriented modelling and simulation of heat exchangers with finite element methods&rdquo;. <i>Mathematical and Computer Modeling of Dynamical Sytems</i>, vol. 13, n. 3, pp. 211-235, Jun. 2007. <a href=\"http://dx.doi.org/10.1080/13873950600821766\">Online</a>. </li>
<li>Laura Savoldi Richard, Francesco Casella, Barbara Fiori and Roberto Zanino, &ldquo;Development of the Cryogenic Circuit Conductor and Coil (4C) Code for thermal-hydraulic modelling of ITER superconducting coils&rdquo;. In <i>Presented at the 22nd International Cryogenic Engineering Conference ICEC22</i>, Seoul, Korea, July 21-25, 2008. </li>
<li>Francesco Casella, &ldquo;Object-Oriented Modelling of Power Plants: a Structured Approach&rdquo;. In <i>Proceedings of the IFAC Symposium on Power Plants and Power Systems Control</i>, Tampere, Finland, July 5-8, 2009. </li>
<li>Laura Savoldi Richard, Francesco Casella, Barbara Fiori and Roberto Zanino, &ldquo;The 4C code for the cryogenic circuit conductor and coil modeling in ITER&rdquo;. <i>Cryogenics</i>, vol. 50, n. 3, pp. 167-176, Mar 2010. <a href=\"http://dx.doi.org/10.1016/j.cryogenics.2009.07.008\">Online</a>. </li>
<li>Antonio Cammi, Francesco Casella, Marco Enrico Ricotti and Francesco Schiavo, &ldquo;An object-oriented approach to simulation of IRIS dynamic response&rdquo;. <i>Progress in Nuclear Energy</i>, vol. 53, n. 1, pp. 48-58, Jan. 2011. <a href=\"http://dx.doi.org/10.1016/j.pnucene.2010.09.004\">Online</a>. </li>
<li>Francesco Casella and Piero Colonna, &ldquo;Development of a Modelica dynamic model of solar supercritical CO2 Brayton cycle power plants for control studies&rdquo;. In <i>Proceedings of the Supercritical CO2 Power Cycle Symposium</i>, Boulder, Colorado, USA, May 24-25, 2011, pp. 1-7. <a href=\"http://www.sco2powercyclesymposium.org/resource_center/system_modeling_control\">Online</a>. </li>
<li>Roberto Bonifetto, Francesco Casella, Laura Savoldi Richard and Roberto Zanino, &ldquo;Dynamic modeling of a SHe closed loop with the 4C code&rdquo;. In <i>Transactions of the Cryogenic Engineering Conference - CEC: Advances in Cryogenic Engineering</i>, Spokane, Washington, USA, Jun. 13-17, 2011, pp. 1-8. </li>
<li>Roberto Zanino, Roberto Bonifetto, Francesco Casella and Laura Savoldi Richard, &ldquo;Validation of the 4C code against data from the HELIOS loop at CEA Grenoble&rdquo;. <i>Cryogenics</i>, vol. 0, pp. 1-6, 2012. In press; available online 6 May 2012. <a href=\"http://dx.doi.org/10.1016/j.cryogenics.2012.04.010\">Online</a>. </li>
<li>Francesco Casella and Piero Colonna, &ldquo;Dynamic modelling of IGCC power plants&rdquo;. <i>Applied Thermal Engineering</i>, vol. 35, pp. 91-111, 2012. <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2011.10.011\">Online</a>. </li>
</ul></p>

<b>Release notes:</b>
<p><b></font><font style=\"font-size: 10pt; \">Version 2.1 (<i>6 Jul 2009</i>)</b></p>
<p>The 2.1 release of ThermoPower contains several additions and a few bug fixes with respect to version 2.0. We tried to keep the new version backwards-compatible with the old one, but there might be a few cases where small adaptations could be required.</p><p>ThermoPower 2.1 requires the Modelica Standard Library version 2.2.1 or 2.2.2. It has been tested with Dymola 6.1 (using MSL 2.2.1) and with Dymola 7.1 (using MSL 2.2.2). It is planned to be usable also with other tools, in particular OpenModelica, MathModelica and SimulationX, but this is not possible with the currently released versions of those tools. It is expected that this should become at least partially possible within the year 2009. </p><p>ThermoPower 2.1 is the last major revision compatible with Modelica 2.1 and the Modelica Standard Library 2.2.x. The next version is planned to use Modelica 3.1 and the Modelica Standard Library 3.1. It will use use stream connectors, which generalize the concept of Flange connectors, lifting the restrictions that only two complementary connectors can be bound.</p><p>This is a list of the main changes with respect to v. 2.0</p>
<li><ul>
<li>New PowerPlants package, containing a library of high-level reusable components for the modelling of combined-cycle power plants, including full models that can be simulated. </li>
<li>New examples cases in the Examples package. </li>
<li>New components in the Electrical package, to model the generator-grid connection by the swing equation </li>
<li>Three-way junctions (FlowJoin and FlowSplit) now have an option to describe unidirectional flow at each flange. This feature can substantially enhance numerical robustness and simulation performance in all cases when it is known a priori that no flow reversal will occur. </li>
<li>The Flow1D and Flow1D2ph models are now restricted to positive flow direction, since it was found that it is not possible to describe flow reversal consistently with the average-density approach adopted in this library. For full flow reversal support please use the Flow1Dfem model, which does not have any restriction in this respect. </li>
<li>A bug in Flow1D and Flow1D2ph has been corrected, which caused significant errors in the mass balance under dynamic conditions; this was potentially critical in closed-loop models, but has now been resolved.&nbsp; </li>
<li>The connectors for lumped- and distribute-parameters heat transfer with variable heat transfer coefficients have been split: HThtc and DHThtc now have an output qualifier on the h.t.c., while HThtc_in and DHThtc_in have an input qualifier. This was necessary to avoid incorrect connections, and is also required by tools to correctly checked if a model is balanced. This change should have no impact on most user-developed models. </li>
</ul></li>
</ul></p>
<p><b>Version 2.0 (<i>10 Jun 2005</i>)</b></p>
<li><ul>
<li>The new Modelica 2.2 standard library is used. </li>
<li>The ThermoPower library is now based on the Modelica.Media standard library for fluid property calculations. All the component models use a Modelica.Media compliant interface to specify the medium model. Standard water and gas models from the Modelica.Media library can be used, as well as custom-built water and gas models, compliant with the Modelica.Media interfaces. </li>
<li>Fully functional gas components are now available, including model for gas compressors and turbines, as well as compact gas turbine unit models. </li>
<li>Steady-state initialisation support has been added to all dynamic models. </li>
<li>Some components are still under development, and could be changed in the final 2.0 release: </li>
<li><ul>
<li>Moving boundary model for two-phase flow in once-through evaporators. </li>
<li>Stress models for headers and turbines. </li>
</ul></li>
</ul></li>
</ul></p>
<p><b>Version 1.2 (<i>18 Nov 2004</i>)</b></p>
<li><ul>
<li>Valve and pump models restructured using inheritance. </li>
<li>Simple model of a steam turbine unit added (requires the Modelica.Media library). </li>
<li>CISE example restructured and moved to the <code>Examples</code> package. </li>
<li>Preliminary version of gas components added in the <code>Gas</code> package. </li>
<li>Finite element model of thermohydraulic two-phase flow added. </li>
<li>Simplified models for the connection to the power system added in the <code>Electrical</code> package. </li>
</ul></li>
</ul></p>
<p><b>Version 1.1 (<i>15 Feb 2004</i>)</b></p>
<li><ul>
<li>No default values for parameters whose values must be set explicitly by the user. </li>
<li>Description of the meaning of the model variables added. </li>
<li><code>Pump</code>, <code>PumpMech</code>, <code>Accumulator</code> models added. </li>
<li>More rational geometric parameters for <code>Flow1D*</code> models. </li>
<li><code>Flow1D</code> model corrected to avoid numerical problems when the phase transition boundaries cross the nodes. </li>
<li><code>Flow1D2phDB</code> model updated. </li>
<li><code>Flow1D2phChen</code> models with two-phase heat transfer added. </li>
</ul></li>
</ul></p>
<p><b>Version 1.0 (<i>20 Oct 2003</i>)</b></p>
<li><ul>
<li>First release in the public domain</li>
</ul></li>
</ul></p>
<p><b></font><font style=\"font-size: 12pt; \">License agreement</b></p>
<p>The ThermoPower package is licensed by Politecnico di Milano under the <b><a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">Modelica License 2</a></b>. </p>
<p><h4>Copyright &copy; 2002-2013, Politecnico di Milano.</h4></p>
</html>"),
  uses(Modelica(version="3.2.1")),
  version="3.1");
end ThermoPower;

model TestTempSource

  ThermoPower.Thermal.TempSource1Dlin tempSource1Dlin
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=1.0)
    annotation (Placement(transformation(extent={{-36,70},{-16,90}})));
equation
  connect(realExpression.y, tempSource1Dlin.temperature_node1) annotation (Line(
      points={{-15,54},{-6,54},{-6,43}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression1.y, tempSource1Dlin.temperature_nodeN) annotation (
      Line(
      points={{-15,80},{2,80},{2,42.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (uses(ThermoPower(version="3.1"), Modelica(version="3.2.1")),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end TestTempSource;
