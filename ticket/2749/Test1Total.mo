package foo
package Modelica "Modelica Standard Library (Version 3.2)"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Interfaces
    "Library of connectors and partial models for input/output blocks"
      import Modelica.SIunits;
        extends Modelica.Icons.InterfacesPackage;

    connector RealOutput = output Real "'output Real' as connector"
      annotation (defaultComponentName="y",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));

    connector IntegerOutput = output Integer "'output Integer' as connector"
                                      annotation (defaultComponentName="y",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={255,127,0},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Integer.
</p>
</html>"));
        annotation (
          Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</HTML>
",     revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces. <a href=\"modelica://Modelica/Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
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
"));
    end Interfaces;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(extent={{-32,-6},{16,-35}}, lineColor={0,0,0}),
        Rectangle(extent={{-32,-56},{16,-85}}, lineColor={0,0,0}),
        Line(points={{16,-20},{49,-20},{49,-71},{16,-71}}, color={0,0,0}),
        Line(points={{-32,-72},{-64,-72},{-64,-21},{-32,-21}}, color={0,0,0}),
        Polygon(
          points={{16,-71},{29,-67},{29,-74},{16,-71}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-21},{-46,-17},{-46,-25},{-32,-21}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
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
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
",   revisions="<html>
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
</html>"));
  end Blocks;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  function log "Natural (base e) logarithm (u shall be > 0)"
    extends baseIcon1;
    input Real u;
    output Real y;

  external "builtin" y=  log(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
                {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
                {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
              color={0,0,0}),
          Text(
            extent={{-6,-24},{66,-72}},
            lineColor={192,192,192},
            textString="log")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-78,-80},{-77.2,-50.6},{-76.4,-37},{-75.6,-28},{-74.8,-21.3},
                {-73.2,-11.4},{-70.8,-1.31},{-67.5,8.08},{-62.7,17.9},{-55.5,28},
                {-45,38.1},{-29.8,48.1},{-8.1,58},{24.1,68},{70.7,78.1},{82,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-105,72},{-85,88}},
            textString="3",
            lineColor={0,0,255}),
          Text(
            extent={{60,-3},{80,-23}},
            textString="20",
            lineColor={0,0,255}),
          Text(
            extent={{-78,-7},{-58,-27}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{84,26},{104,6}},
            lineColor={95,95,95},
            textString="u"),
          Text(
            extent={{-100,9},{-80,-11}},
            textString="0",
            lineColor={0,0,255}),
          Line(
            points={{-80,80},{84,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{82,82},{82,-6}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = log(10) (the natural logarithm of u),
with u &gt; 0:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end log;

  partial function baseIcon1
    "Basic icon for mathematical function with y-axis on left side"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                          Diagram(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,80},{-88,80}}, color={95,95,95}),
          Line(points={{-80,-80},{-88,-80}}, color={95,95,95}),
          Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
          Text(
            extent={{-75,104},{-55,84}},
            lineColor={95,95,95},
            textString="y"),
          Polygon(
            points={{-80,98},{-86,82},{-74,82},{-80,98}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis on the left side.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
  end baseIcon1;
  annotation (
    Invisible=true,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-59,-9},{42,-56}},
          lineColor={0,0,0},
          textString="f(x)")}),
    Documentation(info="<HTML>
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
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
",   revisions="<html>
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

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package InterfacesPackage "Icon for packages containing interfaces"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,50},{20,50},{50,10},{80,10},{80,-30},{50,-30},{20,-70},{
                  0,-70},{0,50}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,10},{-70,10},{-40,50},{-20,50},{-20,-70},{-40,-70},{
                  -70,-30},{-100,-30},{-100,10}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
    end InterfacesPackage;
    annotation(Documentation(__Dymola_DocumentationClass=true, info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>
<dl>
<dt><b>Main Authors:</b> </dt>
    <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dd><dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd><dd>Oberpfaffenhofen</dd><dd>Postfach 1116</dd><dd>D-82230 Wessling</dd><dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd><br>
    <dd>Christian Kral</dd><dd><a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a></dd><dd>Mobility Department</dd><dd>Giefinggasse 2</dd><dd>1210 Vienna, Austria</dd><dd>email: <a href=\"mailto:christian.kral@ait.ac.at\">christian.kral@ait.ac.at</a></dd><br>
    <dd align=\"justify\">Johan Andreasson</dd><dd align=\"justify\"><a href=\"http://www.modelon.se/\">Modelon AB</a></dd><dd align=\"justify\">Ideon Science Park</dd><dd align=\"justify\">22370 Lund, Sweden</dd><dd align=\"justify\">email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>
<p>Copyright &copy; 1998-2010, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;
    annotation (
      Invisible=true,
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-63,-13},{45,-67}},
            lineColor={0,0,0},
            textString="[kg.m2]")}),
      Documentation(info="<html>
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
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
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
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{169,86},{349,236}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{169,236},{189,256},{369,256},{349,236},{169,236}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{369,256},{369,106},{349,86},{349,236},{369,256}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{179,226},{339,196}},
            lineColor={160,160,164},
            textString="Library"),
          Text(
            extent={{206,173},{314,119}},
            lineColor={0,0,0},
            textString="[kg.m2]"),
          Text(
            extent={{163,320},{406,264}},
            lineColor={255,0,0},
            textString="Modelica.SIunits")}));
  end SIunits;
annotation (
preferredView="info",
version="3.2",
versionBuild=9,
versionDate="2010-10-25",
dateModified = "2012-02-09 11:32:00Z",
revisionId="",
uses(Complex(version="1.0"), ModelicaServices(version="1.2")),
conversion(
 noneFromVersion="3.1",
 noneFromVersion="3.0.1",
 noneFromVersion="3.0",
 from(version="2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")),
__Dymola_classOrder={"UsersGuide","Blocks","StateGraph","Electrical","Magnetic","Mechanics","Fluid","Media","Thermal",
      "Math","Utilities","Constants", "Icons", "SIunits"},
Settings(NewStateSelection=true),
Documentation(info="<HTML>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">

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
<li> <b>1280</b> models and blocks, and</li>
<li> <b>910</b> functions
</ul>
<p>
that are directly usable (= number of public, non-partial classes).
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2010, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.Haumer, Modelon,
TU Hamburg-Harburg, Politecnico di Milano.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
"));
end Modelica;

package PNlib

  model PD "Discrete Place"
    discrete Integer t(start = startTokens) "marking";
    parameter Integer nIn = 0 "number of input transitions" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output transitions" annotation(Dialog(connectorSizing = true));
    //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
    parameter Integer startTokens = 0 "start tokens" annotation(Dialog(enable = true, group = "Tokens"));
    parameter Integer minTokens = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Tokens"));
    parameter Integer maxTokens = PNlib.Constants.Integer_inf
    "maximum capacity"                                                           annotation(Dialog(enable = true, group = "Tokens"));
    Boolean reStart = false "restart condition" annotation(Dialog(enable = true, group = "Tokens"));
    parameter Integer reStartTokens = startTokens "number of tokens at restart"
                                                                                annotation(Dialog(enable = true, group = "Tokens"));
    parameter Integer enablingType = 1
    "resolution type of actual conflict (type-1-conflict)"                                    annotation(Dialog(enable = true, group = "Enabling"), choices(choice = 1
        "Priority",                                                                                                    choice = 2
        "Probability",                                                                                                    __Dymola_radioButtons = true));
    parameter Real enablingProbIn[nIn] = fill(1 / nIn, nIn)
    "enabling probabilities of input transitions"                                                         annotation(Dialog(enable = if enablingType == 1 then false else true, group = "Enabling"));
    parameter Real enablingProbOut[nOut] = fill(1 / nOut, nOut)
    "enabling probabilities of output transitions"                                                             annotation(Dialog(enable = if enablingType == 1 then false else true, group = "Enabling"));
    parameter Integer N = settings1.N "N+1=amount of levels" annotation(Dialog(enable = true, group = "Level Concentrations"));
    //****MODIFIABLE PARAMETERS AND VARIABLES END****//
    Real levelCon
    "conversion of tokens to level concentration according to M and N of the settings box";
    Integer showPlaceName = settings1.showPlaceName
    "only for place animation and display (Do not change!)";
    Integer showCapacity = settings1.showCapacity
    "only for place animation and display (Do not change!)";
    Integer animateMarking = settings1.animateMarking
    "only for place animation and display (Do not change!)";
    Real color[3] "only for place animation and display (Do not change!)";
protected
    outer PNlib.Settings settings1 "global settings for animation and display";
    Real tokenscale "only for place animation and display";
    discrete Integer pret "pre marking";
    Integer arcWeightIn[nIn] "Integer weights of input arcs";
    Integer arcWeightOut[nOut] "Integer weights of output arcs";
    Boolean tokeninout "change of tokens?";
    Boolean fireIn[nIn] "Do input transtions fire?";
    Boolean fireOut[nOut] "Do output transitions fire?";
    Boolean disTransitionIn[nIn] "Are the input transitions discrete?";
    Boolean disTransitionOut[nOut] "Are the output transtions discrete?";
    Boolean activeIn[nIn] "Are delays passed of input transitions?";
    Boolean activeOut[nOut] "Are delay passed of output transitions?";
    Boolean enabledByInPlaces[nIn]
    "Are input transitions are enabled by all their input places?";
    //****BLOCKS BEGIN****// since no events are generated within functions!!!
    //change of activation of output transitions
    Blocks.anyChange activeConOut(vec = pre(activeOut) and not disTransitionOut);
    //Does any delay passed of a connected transition?
    Blocks.anyTrue delayPassedOut(vec = activeOut and disTransitionOut);
    Blocks.anyTrue delayPassedIn(vec = activeIn and disTransitionIn);
    //firing sum calculation
    Blocks.firingSumDis firingSumIn(fire = fireIn and disTransitionIn, arcWeight = arcWeightIn);
    Blocks.firingSumDis firingSumOut(fire = fireOut and disTransitionOut, arcWeight = arcWeightOut);
    //Enabling process
    Blocks.enablingOutDis enableOut(delayPassed = delayPassedOut.anytrue, activeCon = activeConOut.anychange, nOut = nOut, arcWeight = arcWeightOut, t = pret, minTokens = minTokens, TAout = activeOut, enablingType = enablingType, enablingProb = enablingProbOut, disTransition = disTransitionOut);
    Blocks.enablingInDis enableIn(delayPassed = delayPassedIn.anytrue, active = activeIn, nIn = nIn, arcWeight = arcWeightIn, t = pret, maxTokens = maxTokens, TAein = enabledByInPlaces, enablingType = enablingType, enablingProb = enablingProbIn, disTransition = disTransitionIn);
    //****BLOCKS END****//
public
    PNlib.Interfaces.PlaceIn inTransition[nIn](each t = pret, each tint = pret, each maxTokens = maxTokens, each maxTokensint = maxTokens, enable = enableIn.TEin_, each emptied = false, each decreasingFactor = 1, each disPlace = true, each speedSum = 0, fire = fireIn, disTransition = disTransitionIn, arcWeightint = arcWeightIn, active = activeIn, enabledByInPlaces = enabledByInPlaces)
    "connector for input transitions"                                                                                                     annotation(Placement(transformation(extent = {{-114, -10}, {-98, 10}}, rotation = 0), iconTransformation(extent = {{-116, -10}, {-100, 10}})));
    PNlib.Interfaces.PlaceOut outTransition[nOut](each t = pret, each tint = pret, each minTokens = minTokens, each minTokensint = minTokens, enable = enableOut.TEout_, each fed = false, each decreasingFactor = 1, each disPlace = true, each arcType = 1, each speedSum = 0, each tokenInOut = pre(tokeninout), fire = fireOut, disTransition = disTransitionOut, arcWeightint = arcWeightOut, active = activeOut, each testValue = -1, each testValueint = -1, each normalArc = 2)
    "connector for output transitions"                                                                                                     annotation(Placement(transformation(extent = {{100, -10}, {116, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.IntegerOutput pd_t = t
    "connector for Simulink connection"                                                   annotation(Placement(transformation(extent = {{-36, 68}, {-16, 88}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 106})));
  equation
    //****MAIN BEGIN****//
    //recalculation of tokens
    pret = pre(t);
    tokeninout = firingSumIn.firingSum > 0 or firingSumOut.firingSum > 0;
    when tokeninout or pre(reStart) then
      t = if tokeninout then pret + firingSumIn.firingSum - firingSumOut.firingSum else reStartTokens;
    end when;
    //Conversion of tokens to level concentrations
    levelCon = t * settings1.M / N;
    //****MAIN END****//
    //****ANIMATION BEGIN****//
    tokenscale = t * settings1.scale;
    color = if settings1.animatePlace == 1 then if tokenscale < 100 then {255, 255 - 2.55 * tokenscale, 255 - 2.55 * tokenscale} else {255, 0, 0} else {255, 255, 255};
    //****ANIMATION END****//
    //****ERROR MESSENGES BEGIN****//
    assert(sum(enablingProbIn) == 1 or nIn == 0 or enablingType == 1, "The sum of input enabling probabilities has to be equal to 1");
    assert(sum(enablingProbOut) == 1 or nOut == 0 or enablingType == 1, "The sum of output enabling probabilities has to be equal to 1");
    assert(startTokens >= minTokens and startTokens <= maxTokens, "minTokens<=startTokens<=maxTokens");
    //****ERROR MESSENGES END****//
    annotation(defaultComponentName = "P1", Icon(graphics={  Ellipse(extent = {{-100, 96}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = DynamicSelect({255, 255, 255}, color),
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-1.5, 25.5}, {-1.5, -21.5}}, lineColor = {0, 0, 0}, textString = DynamicSelect("%startTokens", if animateMarking == 1 then realString(t, 1, 0) else " ")), Text(extent = {{-90, 130}, {-90, 116}}, lineColor = {0, 0, 0}, textString = DynamicSelect(" ", if showCapacity == 1 then if maxTokens > 1073741822 then "[%minTokens, inf]" else "[%minTokens, %maxTokens]" else " ")), Text(extent = {{-74, -113}, {-74, -138}}, lineColor = {0, 0, 0}, textString = "%name")}), Diagram(graphics));
  end PD;

  model PC "Continuous Place"
    Real t = if t_ < 0 then 0 else t_ "marking";
    parameter Integer nIn = 0 "number of input transitions" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output transitions" annotation(Dialog(connectorSizing = true));
    //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
    parameter Real startMarks = 0 "start marks" annotation(Dialog(enable = true, group = "Marks"));
    parameter Real minMarks = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Marks"));
    parameter Real maxMarks = PNlib.Constants.inf "maximum capacity" annotation(Dialog(enable = true, group = "Marks"));
    Boolean reStart = false "restart condition" annotation(Dialog(enable = true, group = "Marks"));
    parameter Real reStartMarks = 0 "number of marks at restart" annotation(Dialog(enable = true, group = "Marks"));
    parameter Integer N = settings1.N "N+1=amount of levels" annotation(Dialog(enable = true, group = "Level Concentrations"));
    parameter Integer enablingType = 1
    "resolution type of actual conflict (type-1-conflict)"                                    annotation(Dialog(enable = true, group = "Enabling"), choices(choice = 1
        "Priority",                                                                                                    choice = 2
        "Probability",                                                                                                    __Dymola_radioButtons = true));
    parameter Real enablingProbIn[nIn] = fill(1 / nIn, nIn)
    "enabling probabilities of input transitions"                                                         annotation(Dialog(enable = if enablingType == 1 then false else true, group = "Enabling"));
    parameter Real enablingProbOut[nOut] = fill(1 / nOut, nOut)
    "enabling probabilities of output transitions"                                                             annotation(Dialog(enable = if enablingType == 1 then false else true, group = "Enabling"));
    //****MODIFIABLE PARAMETERS AND VARIABLES END****//
    Real levelCon
    "conversion of tokens to level concentration according to M and N of the settings box";
    Integer showPlaceName = settings1.showPlaceName
    "only for place animation and display (Do not change!)";
    Integer showCapacity = settings1.showCapacity
    "only for place animation and display (Do not change!)";
    Integer animateMarking = settings1.animateMarking
    "only for place animation and display (Do not change!)";
    Real color[3] "only for place animation and display (Do not change!)";
protected
    outer PNlib.Settings settings1 "global settings for animation and display";
    Real disMarkChange "discrete mark change";
    Real conMarkChange "continuous mark change";
    Real arcWeightIn[nIn] "weights of input arcs";
    Real arcWeightOut[nOut] "weights of output arcs";
    Real instSpeedIn[nIn] "instantaneous speed of input transitions";
    Real instSpeedOut[nOut] "instantaneous speed of output transitions";
    Real maxSpeedIn[nIn] "maximum speed of input transitions";
    Real maxSpeedOut[nOut] "maximum speed of output transitions";
    Real prelimSpeedIn[nIn] "preliminary speed of input transitions";
    Real prelimSpeedOut[nOut] "preliminary speed of output transitions";
    Real tokenscale "only for place animation and display";
    Real t_(start = startMarks) "marking";
    Boolean disMarksInOut "discrete marks change";
    Boolean preFireIn[nIn] "pre-value of fireIn";
    Boolean preFireOut[nOut] "pre-value of fireOut";
    Boolean fireIn[nIn] "Does any input transition fire?";
    Boolean fireOut[nOut] "Does any output transition fire?";
    Boolean disTransitionIn[nIn] "Are the input transitions discrete?";
    Boolean disTransitionOut[nOut] "Are the output transitions discrete?";
    Boolean activeIn[nIn] "Are the input transitions active?";
    Boolean activeOut[nOut] "Are the output transitions active?";
    Boolean enabledByInPlaces[nIn]
    "Are the input transitions enabled by all their input places?";
    //****BLOCKS BEGIN****// since no events are generated within functions!!!
    //enabling discrete transitions
    Blocks.enablingInCon enableIn(active = activeIn, delayPassed = delayPassedIn.anytrue, nIn = nIn, arcWeight = arcWeightIn, t = t_, maxMarks = maxMarks, TAein = enabledByInPlaces, enablingType = enablingType, enablingProb = enablingProbIn, disTransition = disTransitionIn);
    Blocks.enablingOutCon enableOut(delayPassed = delayPassedOut.anytrue, nOut = nOut, arcWeight = arcWeightOut, t_ = t_, minMarks = minMarks, TAout = activeOut, enablingType = enablingType, enablingProb = enablingProbOut, disTransition = disTransitionOut);
    //Does any delay passed of a connected transition?
    Blocks.anyTrue delayPassedOut(vec = activeOut and disTransitionOut);
    Blocks.anyTrue delayPassedIn(vec = activeIn and disTransitionIn);
    //Does any discrete transition fire?
    Blocks.anyTrue disMarksOut(vec = fireOut and disTransitionOut);
    Blocks.anyTrue disMarksIn(vec = fireIn and disTransitionIn);
    //Is the place fed by input transitions?
    Blocks.anyTrue feeding(vec = preFireIn and not disTransitionIn);
    //Is the place emptied by output transitions?"
    Blocks.anyTrue emptying(vec = preFireOut and not disTransitionOut);
    //firing sum calculation
    Blocks.firingSumCon firingSumIn(fire = preFireIn, arcWeight = arcWeightIn, instSpeed = instSpeedIn, disTransition = disTransitionIn);
    Blocks.firingSumCon firingSumOut(fire = preFireOut, arcWeight = arcWeightOut, instSpeed = instSpeedOut, disTransition = disTransitionOut);
    //decreasing factor calculation
    Blocks.decreasingFactor decreasingFactor(nIn = nIn, nOut = nOut, t = t_, minMarks = minMarks, maxMarks = maxMarks, speedIn = firingSumIn.conFiringSum, speedOut = firingSumOut.conFiringSum, maxSpeedIn = maxSpeedIn, maxSpeedOut = maxSpeedOut, prelimSpeedIn = prelimSpeedIn, prelimSpeedOut = prelimSpeedOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, firingIn = fireIn and not disTransitionIn, firingOut = fireOut and not disTransitionOut);
    //****BLOCKS END****//
public
    Interfaces.PlaceIn inTransition[nIn](each t = t_, each tint = 1, each maxTokens = maxMarks, each maxTokensint = 1, enable = enableIn.TEin_, each emptied = emptying.anytrue, decreasingFactor = decreasingFactor.decFactorIn, each disPlace = false, each speedSum = firingSumOut.conFiringSum, fire = fireIn, disTransition = disTransitionIn, active = activeIn, arcWeight = arcWeightIn, instSpeed = instSpeedIn, maxSpeed = maxSpeedIn, prelimSpeed = prelimSpeedIn, enabledByInPlaces = enabledByInPlaces)
    "connector for input transitions"                                                                                                     annotation(Placement(transformation(extent = {{-114, -10}, {-98, 10}}, rotation = 0), iconTransformation(extent = {{-116, -10}, {-100, 10}})));
    Interfaces.PlaceOut outTransition[nOut](each t = t_, each tint = 1, each minTokens = minMarks, each minTokensint = 1, enable = enableOut.TEout_, each fed = feeding.anytrue, decreasingFactor = decreasingFactor.decFactorOut, each disPlace = false, each arcType = 1, each speedSum = firingSumIn.conFiringSum, each tokenInOut = pre(disMarksInOut), fire = fireOut, disTransition = disTransitionOut, active = activeOut, arcWeight = arcWeightOut, instSpeed = instSpeedOut, maxSpeed = maxSpeedOut, prelimSpeed = prelimSpeedOut, each testValue = -1, each testValueint = -1, each normalArc = 2)
    "connector for output transitions"                                                                                                     annotation(Placement(transformation(extent = {{100, -10}, {116, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput pc_t = t
    "connector for Simulink connection"                                                annotation(Placement(transformation(extent = {{-36, 68}, {-16, 88}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 108})));
  equation
    //****MAIN END****//
    //calculation of continuous mark change
    conMarkChange = firingSumIn.conFiringSum - firingSumOut.conFiringSum;
    der(t_) = conMarkChange;
    //calculation of discrete mark change
    disMarkChange = firingSumIn.disFiringSum - firingSumOut.disFiringSum;
    disMarksInOut = disMarksOut.anytrue or disMarksIn.anytrue;
    when disMarksInOut then
      reinit(t_, t_ + disMarkChange);
    end when;
    when reStart then
      //restart the marking
      reinit(t_, reStartMarks);
    end when;
    //Conversion of tokens to level concentrations
    levelCon = t * settings1.M / N;
    for i in 1:nOut loop
      preFireOut[i] = if disTransitionOut[i] then fireOut[i] else pre(fireOut[i]);
    end for;
    for i in 1:nIn loop
      preFireIn[i] = if disTransitionIn[i] then fireIn[i] else pre(fireIn[i]);
    end for;
    //****MAIN END****//
    //****ANIMATION BEGIN****//
    //scaling of tokens for animation
    tokenscale = t * settings1.scale;
    color = if settings1.animatePlace == 1 then if tokenscale < 100 then {255, 255 - 2.55 * tokenscale, 255 - 2.55 * tokenscale} else {255, 0, 0} else {255, 255, 255};
    //****ANIMATION END****//
    //****ERROR MESSENGES BEGIN****//
    assert(sum(enablingProbIn) == 1 or nIn == 0 or enablingType == 1, "The sum of input enabling probabilities has to be equal to 1");
    assert(sum(enablingProbOut) == 1 or nOut == 0 or enablingType == 1, "The sum of output enabling probabilities has to be equal to 1");
    assert(startMarks >= minMarks and startMarks <= maxMarks, "minMarks<=startMarks<=maxMarks");
    //****ERROR MESSENGES END****//
    annotation(defaultComponentName = "P1", Icon(graphics={  Ellipse(extent = {{-100, 98}, {100, -96}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Ellipse(extent = {{-88, 86}, {88, -86}}, lineColor = {0, 0, 0}, fillColor = DynamicSelect({255, 255, 255}, color),
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-1.5, 25.5}, {-1.5, -21.5}}, lineColor = {0, 0, 0}, origin = {0.5, -0.5}, rotation = 0, textString = DynamicSelect("%startMarks", if animateMarking == 1 then if t > 0 then realString(t, 1, 2) else "0.0" else " ")), Text(extent = {{-90, 130}, {-90, 116}}, lineColor = {0, 0, 0}, textString = DynamicSelect(" ", if showCapacity == 1 then if maxMarks > 1e+30 then "[%minMarks, inf]" else "[%minMarks, %maxMarks]" else " ")), Text(extent = {{-74, -103}, {-74, -128}}, lineColor = {0, 0, 0}, textString = "%name")}), Diagram(graphics));
  end PC;

  model TD "Discrete Transition"
    parameter Integer nIn = 0 "number of input places" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output places" annotation(Dialog(connectorSizing = true));
    //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
    parameter Real delay = 1 "delay of timed transition" annotation(Dialog(enable = true, group = "Delay"));
    Real arcWeightIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
    Real arcWeightOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
    Boolean firingCon = true "additional firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
    //****MODIFIABLE PARAMETERS AND VARIABLES END****//
    Integer showTransitionName = settings1.showTransitionName
    "only for transition animation and display (Do not change!)";
    Integer showDelay = settings1.showDelay
    "only for transition animation and display (Do not change!)";
    Real color[3] "only for transition animation and display (Do not change!)";
protected
    outer PNlib.Settings settings1 "global settings for animation and display";
    Real tIn[nIn] "tokens of input places";
    Real tOut[nOut] "tokens of output places";
    Real testValue[nIn] "test values of input arcs";
    Real firingTime "next putative firing time";
    Real fireTime "for transition animation";
    Real minTokens[nIn] "minimum tokens of input places";
    Real maxTokens[nOut] "maximum tokens of output places";
    Real delay_ "due to problems if d==0";
    Integer tIntIn[nIn]
    "integer tokens of input places (for generating events!)";
    Integer tIntOut[nOut]
    "integer tokens of output places (for generating events!)";
    Integer arcType[nIn]
    "type of input arcs 1=normal, 2=test arc, 3=inhibitor arc, 4=read arc";
    Integer arcWeightIntIn[nIn]
    "Integer arc weights of discrete input places (for generating events!)";
    Integer arcWeightIntOut[nOut]
    "Integer arc weights of discrete output places (for generating events!)";
    Integer minTokensInt[nIn]
    "Integer minimum tokens of input places (for generating events!)";
    Integer maxTokensInt[nOut]
    "Integer maximum tokens of output places (for generating events!)";
    Integer testValueInt[nIn]
    "Integer test values of input arcs (for generating events!)";
    Integer normalArc[nIn]
    "1=no,2=yes, i.e. double arc: test and normal arc or inhibitor and normal arc";
    Boolean active "Is the transition active?";
    Boolean fire "Does the transition fire?";
    Boolean disPlaceIn[nIn]
    "Are the input places discrete or continuous? true=discrete";
    Boolean disPlaceOut[nOut]
    "Are the output places discrete or continuous? true=discrete";
    Boolean enableIn[nIn] "Is the transition enabled by input places?";
    Boolean enableOut[nOut] "Is the transition enabled by output places?";
    Boolean delayPassed "Is the delay passed?";
    Boolean ani "for transition animation";
    //****BLOCKS BEGIN****// since no events are generated within functions!!!
    //activation process
    Blocks.activationDis activation(testValue = testValue, testValueInt = testValueInt, normalArc = normalArc, nIn = nIn, nOut = nOut, tIn = tIn, tOut = tOut, tIntIn = tIntIn, tIntOut = tIntOut, arcType = arcType, arcWeightIn = arcWeightIn, arcWeightIntIn = arcWeightIntIn, arcWeightOut = arcWeightOut, arcWeightIntOut = arcWeightIntOut, minTokens = minTokens, maxTokens = maxTokens, minTokensInt = minTokensInt, maxTokensInt = maxTokensInt, firingCon = firingCon, disPlaceIn = disPlaceIn, disPlaceOut = disPlaceOut);
    //Is the transition enabled by all input places?
    Blocks.allTrue enabledByInPlaces(vec = enableIn);
    //Is the transition enabled by all output places?
    Blocks.allTrue enabledByOutPlaces(vec = enableOut);
    //****BLOCKS END****//
public
    PNlib.Interfaces.TransitionIn inPlaces[nIn](each active = delayPassed, arcWeight = arcWeightIn, arcWeightint = arcWeightIntIn, each fire = fire, each disTransition = true, each instSpeed = 0, each prelimSpeed = 0, each maxSpeed = 0, t = tIn, tint = tIntIn, arcType = arcType, minTokens = minTokens, minTokensint = minTokensInt, disPlace = disPlaceIn, enable = enableIn, testValue = testValue, testValueint = testValueInt, normalArc = normalArc)
    "connector for input places"                                                                                                     annotation(Placement(transformation(extent = {{-56, -10}, {-40, 10}}, rotation = 0)));
    PNlib.Interfaces.TransitionOut outPlaces[nOut](each active = delayPassed, arcWeight = arcWeightOut, arcWeightint = arcWeightIntOut, each fire = fire, each enabledByInPlaces = enabledByInPlaces.alltrue, each disTransition = true, each instSpeed = 0, each prelimSpeed = 0, each maxSpeed = 0, t = tOut, tint = tIntOut, maxTokens = maxTokens, maxTokensint = maxTokensInt, disPlace = disPlaceOut, enable = enableOut)
    "connector for output places"                                                                                                     annotation(Placement(transformation(extent = {{40, -10}, {56, 10}}, rotation = 0)));
  equation
    //****MAIN BEGIN****//
    delay_ = if delay <= 0 then 10 ^ (-6) else delay;
    //due to event problems if delay==0
    //reset active when delay passed
    active = activation.active and not pre(delayPassed);
    //save next putative firing time
    when active then
      firingTime = time + delay_;
    end when;
    //delay passed?
    delayPassed = active and time >= firingTime;
    //firing process
    fire = if nOut == 0 then enabledByInPlaces.alltrue else enabledByOutPlaces.alltrue;
    //****MAIN END****//
    //****ANIMATION BEGIN****//
    when fire then
      fireTime = time;
      ani = true;
    end when;
    color = if fireTime + settings1.timeFire >= time and settings1.animateTransition == 1 and ani then {255, 255, 0} else {0, 0, 0};
    //****ANIMATION END****//
    //****ERROR MESSENGES BEGIN****//
    for i in 1:nIn loop
      if disPlaceIn[i] then
        arcWeightIntIn[i] = integer(arcWeightIn[i]);
      else
        arcWeightIntIn[i] = 1;
      end if;
      assert(disPlaceIn[i] and arcWeightIn[i] - arcWeightIntIn[i] <= 0.0 or not disPlaceIn[i], "Input arcs connected to discrete places must have integer weights.");
      assert(arcWeightIn[i] >= 0, "Input arc weights must be positive.");
    end for;
    for i in 1:nOut loop
      if disPlaceOut[i] then
        arcWeightIntOut[i] = integer(arcWeightOut[i]);
      else
        arcWeightIntOut[i] = 1;
      end if;
      assert(disPlaceOut[i] and arcWeightOut[i] - arcWeightIntOut[i] <= 0.0 or not disPlaceOut[i], "Output arcs connected to discrete places must have integer weights.");
      assert(arcWeightOut[i] >= 0, "Output arc weights must be positive.");
    end for;
    //****ERROR MESSENGES END****//
    annotation(defaultComponentName = "T1", Icon(graphics={  Rectangle(extent = {{-40, 100}, {40, -100}}, lineColor = {0, 0, 0}, fillColor = DynamicSelect({0, 0, 0}, color),
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-2, -116}, {-2, -144}}, lineColor = {0, 0, 0}, textString = DynamicSelect("d=%delay", if showDelay == 1 then "d=%delay" else " ")), Text(extent = {{-4, 139}, {-4, 114}}, lineColor = {0, 0, 0}, textString = "%name")}), Diagram(graphics));
  end TD;

  model TS "Stochastic Transition"
    //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
    parameter Integer nIn = 0 "number of input places" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output places" annotation(Dialog(connectorSizing = true));
    Real h = 1 "user-defined hazard function" annotation(Dialog(enable = true, group = "Exponential Distribution"));
    Real arcWeightIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
    Real arcWeightOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
    Boolean firingCon = true "additional firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
    //****MODIFIABLE PARAMETERS AND VARIABLES END****//
    discrete Real putFireTime "putative firing time";
    Integer showTransitionName = settings1.showTransitionName
    "only for transition animation and display (Do not change!)";
    Integer animatePutFireTime = settings1.animatePutFireTime
    "only for transition animation and display (Do not change!)";
    Integer animateHazardFunc = settings1.animateHazardFunc
    "only for transition animation and display (Do not change!)";
    Real color[3] "only for transition animation and display (Do not change!)";
protected
    outer PNlib.Settings settings1 "global settings for animation and display";
    discrete Real fireTime "for transition animation";
    discrete Real hold "old value of hazard function";
    Real tIn[nIn] "tokens of input places";
    Real tOut[nOut] "tokens of output places";
    Real minTokens[nIn] "minimum tokens of input places";
    Real maxTokens[nOut] "maximum tokens of output places";
    Real testValue[nIn] "test values of input arcs";
    Integer arcWeightIntIn[nIn]
    "Integer arc weights of discrete input places (for generating events!)";
    Integer arcWeightIntOut[nOut]
    "Integer arc weights of discrete output places (for generating events!)";
    Integer minTokensInt[nIn]
    "Integer minimum tokens of input places (for generating events!)";
    Integer maxTokensInt[nOut]
    "Integer maximum tokens of output places (for generating events!)";
    Integer tIntIn[nIn]
    "Integer tokens of input places (for generating events!)";
    Integer tIntOut[nOut]
    "Integer tokens of output places (for generating events!)";
    Integer arcType[nIn]
    "type of input arcs 1=normal, 2=test arc, 3=inhibitor arc, 4=read arc";
    Integer testValueInt[nIn]
    "Integer test values of input arcs (for generating events!)";
    Integer normalArc[nIn]
    "1=no,2=yes, i.e. double arc: test and normal arc or inhibitor and normal arc";
    Boolean active "Is the transition active?";
    Boolean fire "Does the transition fire?";
    Boolean delayPassed "Is the delay passed?";
    Boolean ani "for transition animation";
    Boolean disPlaceIn[nIn]
    "Are the input places discrete or continuous? true=discrete";
    Boolean disPlaceOut[nOut]
    "Are the output places discrete or continuous? true=discrete";
    Boolean enableIn[nIn] "Is the transition enabled by input places?";
    Boolean enableOut[nOut] "Is the transition enabled by output places?";
    Boolean tokenInOut[nIn] "Have the tokens of input places changed?";
    //****BLOCKS BEGIN****// since no events are generated within functions!!!
    //activation process
    Blocks.activationDis activation(testValue = testValue, testValueInt = testValueInt, normalArc = normalArc, nIn = nIn, nOut = nOut, tIn = tIn, tOut = tOut, tIntIn = tIntIn, tIntOut = tIntOut, arcType = arcType, arcWeightIn = arcWeightIn, arcWeightIntIn = arcWeightIntIn, arcWeightOut = arcWeightOut, arcWeightIntOut = arcWeightIntOut, minTokens = minTokens, maxTokens = maxTokens, minTokensInt = minTokensInt, maxTokensInt = maxTokensInt, firingCon = firingCon, disPlaceIn = disPlaceIn, disPlaceOut = disPlaceOut);
    //Is the transition enabled by all input places?
    Blocks.allTrue enabledByInPlaces(vec = enableIn);
    //Is the transition enabled by all output places?
    Blocks.allTrue enabledByOutPlaces(vec = enableOut);
    //Has at least one input place changed its tokens?
    Blocks.anyTrue tokenChange(vec = tokenInOut);
    //****BLOCKS END****//
public
    PNlib.Interfaces.TransitionIn inPlaces[nIn](each active = delayPassed, arcWeight = arcWeightIn, arcWeightint = arcWeightIntIn, each fire = fire, each disTransition = true, each instSpeed = 0, each prelimSpeed = 0, each maxSpeed = 0, t = tIn, tint = tIntIn, arcType = arcType, minTokens = minTokens, minTokensint = minTokensInt, disPlace = disPlaceIn, enable = enableIn, tokenInOut = tokenInOut, testValue = testValue, testValueint = testValueInt, normalArc = normalArc)
    "connector for input places"                                                                                                     annotation(Placement(transformation(extent = {{-56, -10}, {-40, 10}}, rotation = 0)));
    PNlib.Interfaces.TransitionOut outPlaces[nOut](each active = delayPassed, arcWeight = arcWeightOut, arcWeightint = arcWeightIntOut, each fire = fire, each enabledByInPlaces = enabledByInPlaces.alltrue, each disTransition = true, each instSpeed = 0, each prelimSpeed = 0, each maxSpeed = 0, t = tOut, tint = tIntOut, maxTokens = maxTokens, maxTokensint = maxTokensInt, disPlace = disPlaceOut, enable = enableOut)
    "connector for output places"                                                                                                     annotation(Placement(transformation(extent = {{40, -10}, {56, 10}}, rotation = 0)));
  equation
    //****MAIN BEGIN****//
    //reset active when delay passed
    active = activation.active and not pre(delayPassed);
    //delay passed?
    delayPassed = active and time >= putFireTime;
    //firing process
    fire = if nOut == 0 then enabledByInPlaces.alltrue else enabledByOutPlaces.alltrue;
    //****MAIN END****//
    //****ANIMATION BEGIN****//
    when fire then
      fireTime = time;
      ani = true;
    end when;
    color = if fireTime + settings1.timeFire >= time and settings1.animateTransition == 1 and ani then {255, 255, 0} else {0, 0, 0};
    //****ANIMATION END****//
    //****ERROR MESSENGES BEGIN****//
    for i in 1:nIn loop
      if disPlaceIn[i] then
        arcWeightIntIn[i] = integer(arcWeightIn[i]);
      else
        arcWeightIntIn[i] = 1;
      end if;
      assert(disPlaceIn[i] and arcWeightIn[i] - arcWeightIntIn[i] <= 0.0 or not disPlaceIn[i], "Input arcs connected to discrete places must have integer weights.");
      assert(arcWeightIn[i] >= 0, "Input arc weights must be positive.");
    end for;
    for i in 1:nOut loop
      if disPlaceOut[i] then
        arcWeightIntOut[i] = integer(arcWeightOut[i]);
      else
        arcWeightIntOut[i] = 1;
      end if;
      assert(disPlaceOut[i] and arcWeightOut[i] - arcWeightIntOut[i] <= 0.0 or not disPlaceOut[i], "Output arcs connected to discrete places must have integer weights.");
      assert(arcWeightOut[i] >= 0, "Output arc weights must be positive.");
    end for;
    //****ERROR MESSENGES END****//
  algorithm
    //****MAIN BEGIN****//
    //generate random putative fire time accoring to Next-Reaction method of Gibson and Bruck
    when active then
      putFireTime := time + Functions.Random.randomexp(h);
      hold := h;
    elsewhen active and (h > hold or h < hold) then
      putFireTime := if h > 0 then time + hold / h * (putFireTime - time) else PNlib.Constants.inf;
      hold := h;
    end when;
    //17.06.11 Reihenfolge getauscht!
    ///  and tokenChange.anytrue
    //****MAIN END****//
  initial equation
    //to initialize the random generator otherwise the first random number is always the same in every simulation run
    hold = h;
    putFireTime = PNlib.Functions.Random.randomexp(h);
    annotation(defaultComponentName = "T1", Icon(graphics={  Rectangle(extent = {{-40, 100}, {40, -100}}, lineColor = {0, 0, 0}, fillColor = DynamicSelect({0, 0, 0}, color),
            fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{-40, 48}, {40, 74}, {-40, 8}, {-40, 10}, {-40, 6}, {-40, 8}, {-40, 48}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-2, -112}, {-2, -140}}, lineColor = {0, 0, 0}, textString = DynamicSelect(" ", if animateHazardFunc == 1 then "h=" + realString(h, 1, 2) else " ")), Text(extent = {{6, -152}, {6, -180}}, lineColor = {0, 0, 0}, textString = DynamicSelect(" ", if animatePutFireTime == 1 then "pt=" + realString(putFireTime, 1, 2) else " ")), Text(extent = {{-4, 139}, {-4, 114}}, lineColor = {0, 0, 0}, textString = "%name")}));
  end TS;

  model Settings "Global Settings for Animation and Display"
    parameter Integer showPlaceName = 1 "show names of places" annotation(Dialog(enable = true, group = "Display"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer showTransitionName = 1 "show names of transitions" annotation(Dialog(enable = true, group = "Display"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer showDelay = 1 "show delays of discrete transitions" annotation(Dialog(enable = true, group = "Display"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer showCapacity = 2 "show capacities of places" annotation(Dialog(enable = true, group = "Display"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animateMarking = 1 "animation of markings" annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animatePlace = 1 "animation of places" annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Real scale = 1 "scale factor for place animation 0-100" annotation(Dialog(enable = if animationPlace == 1 then true else false, group = "Animation"));
    parameter Integer animateTransition = 1 "animation of transitions" annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Real timeFire = 0.3 "time of transition animation" annotation(Dialog(enable = if animationTransition == 1 then true else false, group = "Animation"));
    parameter Integer animatePutFireTime = 1
    "animation of putative fire time of stochastic transitions"                                          annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animateHazardFunc = 1
    "animation of hazard functions of stochastic transitions"                                         annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animateSpeed = 1
    "animation speed of continuous transitions"                                    annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animateWeightTIarc = 1
    "show weights of test and inhibitor arcs"                                          annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer animateTIarc = 1 "animation of test and inhibition arcs" annotation(Dialog(enable = true, group = "Animation"), choices(choice = 1 "on", choice = 2 "off", __Dymola_radioButtons = true));
    parameter Integer N = 10 "N+1=amount of levels" annotation(Dialog(enable = true, group = "Level Concentrations"));
    parameter Real M = 1 "maximum concentration" annotation(Dialog(enable = true, group = "Level Concentrations"));
    annotation(defaultComponentName = "settings1", defaultComponentPrefixes = "inner", missingInnerMessage = "The settings object is missing", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-98, 98}, {98, -98}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                    FillPattern.Solid, fillColor = {255, 255, 255}), Text(extent = {{0, 22}, {0, -22}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, textString = "SETTINGS")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics));
  end Settings;

  package Interfaces
  "contains the connectors for the Petri net component models"

    connector PlaceOut
    "part of place model to connect places to output transitions"
      input Boolean active "Are the output transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the output transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of output transitions" annotation(HideResult = true);
      input Integer arcWeightint "Integer arc weights of output transitions" annotation(HideResult = true);
      input Boolean disTransition "Are the output transitions discrete?" annotation(HideResult = true);
      input Real instSpeed
      "Instantaneous speeds of continuous output transitions"                      annotation(HideResult = true);
      input Real prelimSpeed
      "Preliminary speeds of continuous output transitions"                        annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous output transitions" annotation(HideResult = true);
      output Real t "Marking of the place" annotation(HideResult = true);
      output Integer tint "Integer marking of the place" annotation(HideResult = true);
      output Real minTokens "Minimum capacity of the place" annotation(HideResult = true);
      output Integer minTokensint "Integer minimum capacity of the place" annotation(HideResult = true);
      output Boolean enable
      "Which of the output transitions are enabled by the place?"                       annotation(HideResult = true);
      output Real decreasingFactor
      "Factor for decreasing the speed of continuous input transitions"                              annotation(HideResult = true);
      output Boolean disPlace "Type of the place (discrete or continuous)" annotation(HideResult = true);
      output Integer arcType
      "Type of output arcs (normal, test,inhibition, or read)"                        annotation(HideResult = true);
      output Boolean fed "Is the continuous place fed by input transitions?" annotation(HideResult = true);
      output Real speedSum "Input speed of a continuous place" annotation(HideResult = true);
      output Boolean tokenInOut "Does the place have a discrete token change?" annotation(HideResult = true);
      output Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      output Integer testValueint
      "Integer test value of a test or inhibitor arc"                             annotation(HideResult = true);
      output Integer normalArc
      "Double arc: test and normal arc or inhibitor and normal arc"                          annotation(HideResult = true);
      annotation(Icon(graphics={  Polygon(points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid)}));
    end PlaceOut;

    connector TransitionIn
    "part of transition model to connect transitions to input places"
      input Real t "Markings of input places" annotation(HideResult = true);
      input Integer tint "Integer Markings of input places" annotation(HideResult = true);
      input Real minTokens "Minimum capacites of input places" annotation(HideResult = true);
      input Integer minTokensint "Integer minimum capacites of input places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by input places?" annotation(HideResult = true);
      input Real decreasingFactor
      "Factor of continuous input places for decreasing the speed"                             annotation(HideResult = true);
      input Boolean disPlace "Types of input places (discrete or continuous)" annotation(HideResult = true);
      input Integer arcType
      "Types of input arcs (normal, test,inhibition, or read)"                       annotation(HideResult = true);
      input Boolean fed "Are the continuous input places fed?" annotation(HideResult = true);
      input Real speedSum "Input speeds of continuous input places" annotation(HideResult = true);
      input Boolean tokenInOut
      "Do the input places have a discrete token change?"                          annotation(HideResult = true);
      input Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      input Integer testValueint
      "Integer test value of a test or inhibitor arc"                            annotation(HideResult = true);
      input Integer normalArc
      "Double arc: test and normal arc or inhibitor and normal arc"                         annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Input arc weights of the transition" annotation(HideResult = true);
      output Integer arcWeightint "Integer input arc weights of the transition"
                                                                                annotation(HideResult = true);
      output Boolean disTransition
      "Type of the transition(discrete/stochastic or continuous)"                              annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
      annotation(Icon(graphics={  Polygon(points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid)}));
    end TransitionIn;

    connector TransitionOut
    "part of transition model to connect transitions to output places"
      input Real t "Markings of output places" annotation(HideResult = true);
      input Integer tint "Integer markings of output places" annotation(HideResult = true);
      input Real maxTokens "Maximum capacities of output places" annotation(HideResult = true);
      input Integer maxTokensint "Integer maximum capacities of output places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by output places?" annotation(HideResult = true);
      input Real decreasingFactor
      "Factor of continuous output places for decreasing the speed"                             annotation(HideResult = true);
      input Boolean disPlace "Types of output places (discrete or continuous)" annotation(HideResult = true);
      input Boolean emptied "Are the continuous output places emptied?" annotation(HideResult = true);
      input Real speedSum "Output speeds of continuous output places" annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Output arc weights of the transition" annotation(HideResult = true);
      output Integer arcWeightint
      "Integer output arc weights of the transition"                             annotation(HideResult = true);
      output Boolean enabledByInPlaces
      "Is the transition enabled by all input places?"                                  annotation(HideResult = true);
      output Boolean disTransition
      "Type of the transition (discrete/stochastic or continuous)"                              annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
      annotation(Icon(graphics={  Polygon(points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid)}));
    end TransitionOut;

    connector PlaceIn
    "part of place model to connect places to input transitions"
      input Boolean active "Are the input transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the input transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of input transitions" annotation(HideResult = true);
      input Integer arcWeightint "Integer arc weights of input transitions" annotation(HideResult = true);
      input Boolean enabledByInPlaces
      "Are the input transitions enabled by all theier input places?"                                 annotation(HideResult = true);
      input Boolean disTransition
      "Types of input transitions (discrete/stochastic or continuous)"                             annotation(HideResult = true);
      input Real instSpeed
      "Instantaneous speeds of continuous input transitions"                      annotation(HideResult = true);
      input Real prelimSpeed
      "Preliminary speeds of continuous input transitions"                        annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous input transitions" annotation(HideResult = true);
      output Real t "Marking of the place" annotation(HideResult = true);
      output Integer tint "Integer marking of the place" annotation(HideResult = true);
      output Real maxTokens "Maximum capacity of the place" annotation(HideResult = true);
      output Integer maxTokensint "Integer maximum capacity of the place" annotation(HideResult = true);
      output Boolean enable
      "Which of the input transitions are enabled by the place?"                       annotation(HideResult = true);
      output Real decreasingFactor
      "Factor for decreasing the speed of continuous input transitions"                              annotation(HideResult = true);
      output Boolean disPlace "Type of the place (discrete or continuous)" annotation(HideResult = true);
      output Boolean emptied
      "Is the continuous place emptied by output transitions?"                        annotation(HideResult = true);
      output Real speedSum "Output speed of a continuous place" annotation(HideResult = true);
      annotation(Icon(graphics={  Polygon(points = {{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
              fillPattern =                                                                                                    FillPattern.Solid)}));
    end PlaceIn;
  end Interfaces;

  package Blocks "
        contains blocks with specific procedures that are used in the Petri net component models"

    block activationDis "Activation of a discrete transition"
      parameter input Integer nIn "number of input places";
      parameter input Integer nOut "number of output places";
      input Real tIn[:] "tokens of input places";
      input Real tOut[:] "tokens of output places";
      input Integer tIntIn[:] "tokens of input places";
      input Integer tIntOut[:] "tokens of output places";
      input Integer arcType[:] "arc type of input places";
      input Real arcWeightIn[:] "arc weights of input places";
      input Integer arcWeightIntIn[:] "arc weights of input places";
      input Real arcWeightOut[:] "arc weights of output places";
      input Integer arcWeightIntOut[:] "arc weights of output places";
      input Real minTokens[:] "minimum capacities of input places";
      input Integer minTokensInt[:] "minimum capacities of input places";
      input Real maxTokens[:] "maximum capacities of output places";
      input Integer maxTokensInt[:] "maximum capacities of output places";
      input Boolean firingCon "firing condition of transition";
      input Boolean disPlaceIn[:] "types of input places";
      input Boolean disPlaceOut[:] "types of output places";
      input Integer normalArc[:] "normal or double arc?";
      input Real testValue[:] "test values of test and inhibitor arcs";
      input Integer testValueInt[:]
      "integer test values of test and inhibitor arcs";
      output Boolean active "activation of transition";
    algorithm
      active := true;
      //check input places
      for i in 1:nIn loop
        if disPlaceIn[i] then
          if (arcType[i] == 1 or normalArc[i] == 2) and not tIntIn[i] - arcWeightIntIn[i] >= minTokensInt[i] then
            active := false;
          elseif arcType[i] == 2 and not tIntIn[i] > testValueInt[i] then
            active := false;
          elseif arcType[i] == 3 and not tIntIn[i] < testValueInt[i] then
            active := false;
          end if;
        else
          if (arcType[i] == 1 or normalArc[i] == 2) and not tIn[i] - arcWeightIn[i] >= minTokens[i] then
            if not tIn[i] + Constants.eps - arcWeightIn[i] >= minTokens[i] then
              active := false;
            end if;
          elseif arcType[i] == 2 and not tIn[i] > testValue[i] then
            active := false;
          elseif arcType[i] == 3 and not tIn[i] < testValue[i] then
            active := false;
          end if;
        end if;
      end for;
      //discrete
      //continuous
      //check output places
      for i in 1:nOut loop
        if disPlaceOut[i] then
          if not tIntOut[i] + arcWeightIntOut[i] <= maxTokensInt[i] then
            active := false;
          end if;
        else
          if not tOut[i] + arcWeightOut[i] <= maxTokens[i] then
            active := false;
          end if;
        end if;
      end for;
      //discrete
      //continuous
      active := active and firingCon;
    end activationDis;

    block allTrue "Are all entries of a Boolean vector true?"
      input Boolean vec[:];
      output Boolean alltrue;
    algorithm
      alltrue := true;
      for i in 1:size(vec, 1) loop
        alltrue := alltrue and vec[i];
      end for;
    end allTrue;

    block anyTrue "Is any entry of a Boolean vector true?"
      input Boolean vec[:];
      output Boolean anytrue;
      output Integer numtrue;
    algorithm
      anytrue := false;
      numtrue := 0;
      for i in 1:size(vec, 1) loop
        anytrue := anytrue or vec[i];
        if vec[i] then
          numtrue := numtrue + 1;
        end if;
      end for;
    end anyTrue;

    block anyChange "Does any entry of a Boolean vector change its value?"
      input Boolean vec[:];
      output Boolean anychange;
    algorithm
      anychange := false;
      for i in 1:size(vec, 1) loop
        anychange := anychange or change(vec[i]);
      end for;
    end anyChange;

    block decreasingFactor "calculation of decreasing factors"
      parameter input Integer nIn "number of input transitions";
      parameter input Integer nOut "number of output transitions";
      input Real t "marking";
      input Real minMarks "minimum capacity";
      input Real maxMarks "maximum capacity";
      input Real speedIn "input speed";
      input Real speedOut "output speed";
      input Real maxSpeedIn[:] "maximum speeds of input transitions";
      input Real maxSpeedOut[:] "maximum speeds of output transitions";
      input Real prelimSpeedIn[:] "preliminary speeds of input transitions";
      input Real prelimSpeedOut[:] "preliminary speeds of output transitions";
      input Real arcWeightIn[:] "arc weights of input transitions";
      input Real arcWeightOut[:] "arc weights of output transitions";
      input Boolean firingIn[:] "firability of input transitions";
      input Boolean firingOut[:] "firability of output transitions";
      output Real decFactorIn[nIn] "decreasing factors for input transitions";
      output Real decFactorOut[nOut]
      "decreasing factors for output transitions";
  protected
      Real maxSpeedSumIn;
      Real maxSpeedSumOut;
      Real prelimSpeedSumIn;
      Real prelimSpeedSumOut;
      Real prelimDecFactorIn;
      Real prelimDecFactorOut;
      Real modSpeedIn;
      Real modSpeedOut;
      Real minMarksMod;
      anyTrue anyFireOut(vec = firingOut);
      anyTrue anyFireIn(vec = firingIn);
      Boolean stop;
    algorithm
      decFactorIn := fill(-1, nIn);
      decFactorOut := fill(-1, nOut);
      modSpeedIn := speedIn;
      modSpeedOut := speedOut;
      stop := false;
      maxSpeedSumIn := 0;
      maxSpeedSumOut := 0;
      prelimSpeedSumIn := 0;
      prelimSpeedSumOut := 0;
      prelimDecFactorIn := 0;
      prelimDecFactorOut := 0;
      minMarksMod := minMarks;
      //-----------------------------------------------------------------------------------------------------------//
      //decreasing factor of input transitions
      if anyFireOut.numtrue > 0 and anyFireIn.numtrue > 1 then
        prelimSpeedSumIn := Functions.OddsAndEnds.conditionalSum(arcWeightIn .* prelimSpeedIn, firingIn);
        maxSpeedSumIn := Functions.OddsAndEnds.conditionalSum(arcWeightIn .* maxSpeedIn, firingIn);
        if maxSpeedSumIn > 0 then
          if not t < maxMarks and speedOut < prelimSpeedSumIn then
            prelimDecFactorIn := speedOut / maxSpeedSumIn;
            while not stop loop
              stop := true;
              for i in 1:nIn loop
                if firingIn[i] and prelimDecFactorIn * maxSpeedIn[i] > prelimSpeedIn[i] and decFactorIn[i] < 0 and prelimDecFactorIn < 1 then
                  decFactorIn[i] := prelimSpeedIn[i] / maxSpeedIn[i];
                  modSpeedOut := modSpeedOut - arcWeightIn[i] * prelimSpeedIn[i];
                  maxSpeedSumIn := maxSpeedSumIn - arcWeightIn[i] * maxSpeedIn[i];
                  stop := false;
                end if;
              end for;
              if maxSpeedSumIn > 0 then
                prelimDecFactorIn := modSpeedOut / maxSpeedSumIn;
              else
                prelimDecFactorIn := 1;
              end if;
            end while;
            for i in 1:nIn loop
              if decFactorIn[i] < 0 then
                decFactorIn[i] := prelimDecFactorIn;
              end if;
            end for;
          else
            decFactorIn := fill(1, nIn);
          end if;
        else
          decFactorIn := fill(1, nIn);
        end if;
      else
        decFactorIn := fill(1, nIn);
      end if;
      //     for i in 1:nIn loop
      //       if firingIn[i] then
      //          prelimSpeedSumIn:=prelimSpeedSumIn + arcWeightIn[i]*prelimSpeedIn[i];
      //          maxSpeedSumIn:=maxSpeedSumIn + arcWeightIn[i]*maxSpeedIn[i];
      //       end if;
      //     end for;
      // arcWeights can be zero and then is maxSpeedSumIn zero!!! and not maxSpeedSumIn<=0
      //       prelimDecFactorIn:=if not maxSpeedSumIn<=0 then modSpeedOut/maxSpeedSumIn else 1;  // arcWeights can be zero and then is maxSpeedSumIn zero!!!
      //-----------------------------------------------------------------------------------------------------------//
      //decreasing factor of output transitions
      stop := false;
      if anyFireOut.numtrue > 1 and anyFireIn.numtrue > 0 then
        prelimSpeedSumOut := Functions.OddsAndEnds.conditionalSum(arcWeightOut .* prelimSpeedOut, firingOut);
        maxSpeedSumOut := Functions.OddsAndEnds.conditionalSum(arcWeightOut .* maxSpeedOut, firingOut);
        if maxSpeedSumOut > 0 then
          if not t > minMarks and speedIn < prelimSpeedSumOut then
            prelimDecFactorOut := speedIn / maxSpeedSumOut;
            while not stop loop
              stop := true;
              for i in 1:nOut loop
                if firingOut[i] and prelimDecFactorOut * maxSpeedOut[i] > prelimSpeedOut[i] and decFactorOut[i] < 0 and prelimDecFactorOut < 1 then
                  decFactorOut[i] := prelimSpeedOut[i] / maxSpeedOut[i];
                  modSpeedIn := modSpeedIn - arcWeightOut[i] * prelimSpeedOut[i];
                  maxSpeedSumOut := maxSpeedSumOut - arcWeightOut[i] * maxSpeedOut[i];
                  stop := false;
                end if;
              end for;
              if maxSpeedSumOut > 0 then
                prelimDecFactorOut := modSpeedIn / maxSpeedSumOut;
              else
                prelimDecFactorIn := 1;
              end if;
            end while;
            for i in 1:nOut loop
              if decFactorOut[i] < 0 then
                decFactorOut[i] := prelimDecFactorOut;
              end if;
            end for;
          else
            decFactorOut := fill(1, nOut);
          end if;
        else
          decFactorOut := fill(1, nOut);
        end if;
      else
        decFactorOut := fill(1, nOut);
      end if;
    end decreasingFactor;

    block enablingInCon
    "enabling process of input transitions (continuous places)"
      parameter input Integer nIn "number of input transitions";
      input Real arcWeight[nIn] "arc weights of input transitions";
      input Real t "current marking";
      input Real maxMarks "maximum capacity";
      input Boolean TAein[nIn]
      "active input transitions which are already enabled by their input places";
      input Integer enablingType "resolution of actual conflicts";
      input Real enablingProb[nIn] "enabling probabilites of input transitions";
      input Boolean disTransition[nIn] "discrete transition?";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean active[nIn] "Are the input transitions active?";
      output Boolean TEin_[nIn] "enabled input transitions";
  protected
      Boolean TEin[nIn] "enabled input transitions";
      Boolean disTAin[nIn] "discret active input transitions";
      Integer remTAin[nIn] "remaining active input transitions";
      Real cumEnablingProb[nIn] "cumulated, scaled enabling probabilities";
      Real arcWeightSum "arc weight sum";
      Integer nremTAin "number of remaining active input transitions";
      Integer nTAin "number ofactive input transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAin
      "sum of the enabling probabilities of the active input transitions";
      Boolean endWhile;
    algorithm
      when delayPassed then
        if nIn > 0 then
          disTAin := TAein and disTransition;
          arcWeightSum := Functions.OddsAndEnds.conditionalSum(arcWeight, disTAin);
          if t + arcWeightSum <= maxMarks or arcWeightSum == 0 then
            TEin := TAein;
          else
            TEin := TAein and not disTransition;
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nIn loop
                if disTAin[i] and (t + arcWeightSum + arcWeight[i] <= maxMarks or arcWeight[i] == 0) then
                  TEin[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAin := zeros(nIn);
              nremTAin := 0;
              for i in 1:nIn loop
                if disTAin[i] then
                  nremTAin := nremTAin + 1;
                  remTAin[nremTAin] := i;
                end if;
              end for;
              nTAin := nremTAin;
              sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
              cumEnablingProb := zeros(nIn);
              cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
              for j in 2:nremTAin loop
                cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
              end for;
              randNum := PNlib.Functions.Random.random() / 32767;
              for i in 1:nTAin loop
                randNum := PNlib.Functions.Random.random() / 32767;
                endWhile := false;
                k := 1;
                while k <= nremTAin and not endWhile loop
                  if randNum <= cumEnablingProb[k] then
                    posTE := remTAin[k];
                    endWhile := true;
                  else
                    k := k + 1;
                  end if;
                end while;
                if t + arcWeightSum + arcWeight[posTE] <= maxMarks or arcWeight[i] == 0 then
                  arcWeightSum := arcWeightSum + arcWeight[posTE];
                  TEin[posTE] := true;
                end if;
                nremTAin := nremTAin - 1;
                if nremTAin > 0 then
                  remTAin := Functions.OddsAndEnds.deleteElementInt(remTAin, k);
                  cumEnablingProb := zeros(nIn);
                  sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
                  if sumEnablingProbTAin > 0 then
                    cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
                    for j in 2:nremTAin loop
                      cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
                    end for;
                  else
                    cumEnablingProb[1:nremTAin] := fill(1 / nremTAin, nremTAin);
                  end if;
                end if;
              end for;
            end if;
          end if;
        else
          TEin := fill(false, nIn);
          disTAin := fill(false, nIn);
          remTAin := fill(0, nIn);
          cumEnablingProb := fill(0.0, nIn);
          arcWeightSum := 0.0;
          nremTAin := 0;
          nTAin := 0;
          k := 0;
          posTE := 0;
          randNum := 0.0;
          sumEnablingProbTAin := 0.0;
          endWhile := false;
        end if;
      end when;
      //arc weight sum of all active input transitions which are already enabled by their input places
      //Place has no actual conflict; all active input transitions are enabled
      //Place has an actual conflict
      //deterministic enabling according to priorities
      //probabilistic enabling according to enabling probabilities
      //number of active input transitions
      //active input transitions
      //number of active input transitions
      //enabling probability sum of all active input transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      TEin_ := TEin and active;
    end enablingInCon;

    block enablingInDis "enabling process of discrete input transitions"
      parameter input Integer nIn "number of input transitions";
      input Integer arcWeight[:] "arc weights of input transitions";
      input Integer t "current token number";
      input Integer maxTokens "maximum capacity";
      input Boolean TAein[:]
      "active previous transitions which are already enabled by their input places";
      input Integer enablingType "resolution of actual conflicts";
      input Real enablingProb[:] "enabling probabilites of input transitions";
      input Boolean disTransition[:] "type of input transitions";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean active[:] "Are the input transitions active?";
      output Boolean TEin_[nIn] "enabled input transitions";
  protected
      Boolean TEin[nIn] "enabled input transitions";
      Integer remTAin[nIn] "remaining active input transitions";
      Real cumEnablingProb[nIn] "cumulated, scaled enabling probabilities";
      Integer arcWeightSum "arc weight sum";
      Integer nremTAin "number of remaining active input transitions";
      Integer nTAin "number ofactive input transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAin
      "sum of the enabling probabilities of the active input transitions";
      Boolean endWhile;
    algorithm
      when delayPassed then
        if nIn > 0 then
          TEin := fill(false, nIn);
          arcWeightSum := Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAein);
          if t + arcWeightSum <= maxTokens then
            TEin := TAein;
          else
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nIn loop
                if TAein[i] and disTransition[i] and t + arcWeightSum + arcWeight[i] <= maxTokens then
                  TEin[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAin := zeros(nIn);
              nremTAin := 0;
              for i in 1:nIn loop
                if TAein[i] and disTransition[i] then
                  nremTAin := nremTAin + 1;
                  remTAin[nremTAin] := i;
                end if;
              end for;
              nTAin := nremTAin;
              sumEnablingProbTAin := 0;
              for j in 1:nremTAin loop
                sumEnablingProbTAin := sumEnablingProbTAin + enablingProb[remTAin[j]];
              end for;
              cumEnablingProb := zeros(nIn);
              cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
              for j in 2:nremTAin loop
                cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
              end for;
              randNum := PNlib.Functions.Random.random() / 32767;
              for i in 1:nTAin loop
                randNum := PNlib.Functions.Random.random() / 32767;
                endWhile := false;
                k := 1;
                while k <= nremTAin and not endWhile loop
                  if randNum <= cumEnablingProb[k] then
                    posTE := remTAin[k];
                    endWhile := true;
                  else
                    k := k + 1;
                  end if;
                end while;
                if t + arcWeightSum + arcWeight[posTE] <= maxTokens then
                  arcWeightSum := arcWeightSum + arcWeight[posTE];
                  TEin[posTE] := true;
                end if;
                nremTAin := nremTAin - 1;
                if nremTAin > 0 then
                  remTAin := Functions.OddsAndEnds.deleteElementInt(remTAin, k);
                  cumEnablingProb := zeros(nIn);
                  sumEnablingProbTAin := 0;
                  for j in 1:nremTAin loop
                    sumEnablingProbTAin := sumEnablingProbTAin + enablingProb[remTAin[j]];
                  end for;
                  if sumEnablingProbTAin > 0 then
                    cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
                    for j in 2:nremTAin loop
                      cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
                    end for;
                  else
                    cumEnablingProb[1:nremTAin] := fill(1 / nremTAin, nremTAin);
                  end if;
                end if;
              end for;
            end if;
          end if;
        else
          TEin := fill(false, nIn);
          remTAin := fill(0, nIn);
          cumEnablingProb := fill(0.0, nIn);
          arcWeightSum := 0;
          nremTAin := 0;
          nTAin := 0;
          k := 0;
          posTE := 0;
          randNum := 0;
          sumEnablingProbTAin := 0;
          endWhile := false;
        end if;
      end when;
      //arc weight sum of all active input transitions which are already enabled by their input places
      //Place has no actual conflict; all active input transitions are enabled
      //Place has an actual conflict
      //deterministic enabling according to priorities
      ///new 07.03.2011
      //probabilistic enabling according to enabling probabilities
      //number of active input transitions
      //active input transitions
      //number of active input transitions
      //sumEnablingProbTAin:=sum(enablingProb[remTAin[1:nremTAin]]);  //enabling probability sum of all active input transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      //sumEnablingProbTAin:=sum(enablingProb[remTAin[1:nremTAin]]);
      TEin_ := TEin and active;
    end enablingInDis;

    block enablingOutCon
    "enabling process of output transitions (continuous places)"
      parameter input Integer nOut "number of output transitions";
      input Real arcWeight[:] "arc weights of output transitions";
      input Real t_ "current marks";
      input Real minMarks "minimum capacity";
      input Boolean TAout[:] "active output transitions with passed delay";
      input Integer enablingType "resolution of actual conflicts";
      input Real enablingProb[:] "enabling probabilites of output transitions";
      input Boolean disTransition[:] "discrete transition?";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      output Boolean TEout_[nOut] "enabled output transitions";
  protected
      Real t = t_ + Constants.eps
      "numeric to realize the correct simulation of some specific hybrid petri nets";
      Boolean TEout[nOut] "enabled output transitions";
      Boolean disTAout[nOut] "discret active output transitions";
      Integer remTAout[nOut] "remaining active output transitions";
      Real cumEnablingProb[nOut] "cumulated, scaled enabling probabilities";
      Real arcWeightSum "arc weight sum";
      Integer nremTAout "number of remaining active output transitions";
      Integer nTAout "number of active output transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAout
      "sum of the enabling probabilities of the active output transitions";
      Boolean endWhile;
    algorithm
      when delayPassed then
        if nOut > 0 then
          disTAout := TAout and disTransition;
          arcWeightSum := Functions.OddsAndEnds.conditionalSum(arcWeight, disTAout);
          if t - arcWeightSum >= minMarks or arcWeightSum == 0 then
            TEout := TAout;
          else
            TEout := TAout and not disTransition;
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nOut loop
                if disTAout[i] and (t - (arcWeightSum + arcWeight[i]) >= minMarks or arcWeight[i] == 0) then
                  TEout[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAout := zeros(nOut);
              nremTAout := 0;
              for i in 1:nOut loop
                if disTAout[i] then
                  nremTAout := nremTAout + 1;
                  remTAout[nremTAout] := i;
                end if;
              end for;
              nTAout := nremTAout;
              sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
              cumEnablingProb := zeros(nOut);
              cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
              for j in 2:nremTAout loop
                cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
              end for;
              randNum := PNlib.Functions.Random.random() / 32767;
              for i in 1:nTAout loop
                randNum := PNlib.Functions.Random.random() / 32767;
                endWhile := false;
                k := 1;
                while k <= nremTAout and not endWhile loop
                  if randNum <= cumEnablingProb[k] then
                    posTE := remTAout[k];
                    endWhile := true;
                  else
                    k := k + 1;
                  end if;
                end while;
                if t - (arcWeightSum + arcWeight[posTE]) >= minMarks or arcWeight[i] == 0 then
                  arcWeightSum := arcWeightSum + arcWeight[posTE];
                  TEout[posTE] := true;
                end if;
                nremTAout := nremTAout - 1;
                if nremTAout > 0 then
                  remTAout := Functions.OddsAndEnds.deleteElementInt(remTAout, k);
                  cumEnablingProb := zeros(nOut);
                  sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
                  if sumEnablingProbTAout > 0 then
                    cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
                    for j in 2:nremTAout loop
                      cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
                    end for;
                  else
                    cumEnablingProb[1:nremTAout] := fill(1 / nremTAout, nremTAout);
                  end if;
                end if;
              end for;
            end if;
          end if;
        else
          TEout := fill(false, nOut);
          disTAout := fill(false, nOut);
          remTAout := fill(0, nOut);
          cumEnablingProb := fill(0.0, nOut);
          arcWeightSum := 0.0;
          nremTAout := 0;
          nTAout := 0;
          k := 0;
          posTE := 0;
          randNum := 0.0;
          sumEnablingProbTAout := 0.0;
          endWhile := false;
        end if;
      end when;
      //arc weight sum of all active output transitions
      //Place has no actual conflict; all active output transitions are enabled
      //Place has an actual conflict;
      //deterministic enabling according to priorities
      //probabilistic enabling according to enabling probabilities
      //number of active output transitions
      //active output transitions
      //number of active output transitions
      //enabling probability sum of all active output transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      TEout_ := TEout and TAout;
    end enablingOutCon;

    block enablingOutDis "enabling process of output transitions"
      parameter input Integer nOut "number of output transitions";
      input Integer arcWeight[:] "arc weights of output transitions";
      input Integer t "current token number";
      input Integer minTokens "minimum capacity";
      input Boolean TAout[:] "active output transitions with passed delay";
      input Integer enablingType "resolution of actual conflicts";
      input Real enablingProb[:] "enabling probabilites of output transitions";
      input Boolean disTransition[:] "discrete output transition";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean activeCon "change of activation of output transitions";
      output Boolean TEout_[nOut] "enabled output transitions";
  protected
      Boolean TEout[nOut] "enabled output transitions";
      Integer remTAout[nOut] "remaining active output transitions";
      Real cumEnablingProb[nOut] "cumulated, scaled enabling probabilities";
      Integer arcWeightSum "arc weight sum";
      Integer nremTAout "number of remaining active output transitions";
      Integer nTAout "number of active output transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAout
      "sum of the enabling probabilities of the active output transitions";
      Boolean endWhile;
    algorithm
      when delayPassed or activeCon then
        if nOut > 0 then
          TEout := fill(false, nOut);
          arcWeightSum := Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAout);
          if t - arcWeightSum >= minTokens then
            TEout := TAout;
          else
            if enablingType == 1 then
              arcWeightSum := 0;
              for i in 1:nOut loop
                if TAout[i] and disTransition[i] and t - (arcWeightSum + arcWeight[i]) >= minTokens then
                  TEout[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
              for i in 1:nOut loop
                if TAout[i] and not disTransition[i] and t - (arcWeightSum + arcWeight[i]) >= minTokens then
                  TEout[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
            else
              arcWeightSum := 0;
              remTAout := zeros(nOut);
              nremTAout := 0;
              for i in 1:nOut loop
                if TAout[i] and disTransition[i] then
                  nremTAout := nremTAout + 1;
                  remTAout[nremTAout] := i;
                end if;
              end for;
              nTAout := nremTAout;
              if nTAout > 0 then
                sumEnablingProbTAout := 0;
                for j in 1:nremTAout loop
                  sumEnablingProbTAout := sumEnablingProbTAout + enablingProb[remTAout[j]];
                end for;
                cumEnablingProb := zeros(nOut);
                cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
                for j in 2:nremTAout loop
                  cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
                end for;
                randNum := PNlib.Functions.Random.random() / 32767;
                for i in 1:nTAout loop
                  randNum := PNlib.Functions.Random.random() / 32767;
                  endWhile := false;
                  k := 1;
                  while k <= nremTAout and not endWhile loop
                    if randNum <= cumEnablingProb[k] then
                      posTE := remTAout[k];
                      endWhile := true;
                    else
                      k := k + 1;
                    end if;
                  end while;
                  if t - (arcWeightSum + arcWeight[posTE]) >= minTokens then
                    arcWeightSum := arcWeightSum + arcWeight[posTE];
                    TEout[posTE] := true;
                  end if;
                  nremTAout := nremTAout - 1;
                  if nremTAout > 0 then
                    remTAout := Functions.OddsAndEnds.deleteElementInt(remTAout, k);
                    cumEnablingProb := zeros(nOut);
                    sumEnablingProbTAout := 0;
                    for j in 1:nremTAout loop
                      sumEnablingProbTAout := sumEnablingProbTAout + enablingProb[remTAout[j]];
                    end for;
                    if sumEnablingProbTAout > 0 then
                      cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
                      for j in 2:nremTAout loop
                        cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
                      end for;
                    else
                      cumEnablingProb[1:nremTAout] := fill(1 / nremTAout, nremTAout);
                    end if;
                  end if;
                end for;
              end if;
              for i in 1:nOut loop
                if TAout[i] and not disTransition[i] and t - (arcWeightSum + arcWeight[i]) >= minTokens then
                  TEout[i] := true;
                  arcWeightSum := arcWeightSum + arcWeight[i];
                end if;
              end for;
            end if;
          end if;
        else
          TEout := fill(false, nOut);
          remTAout := fill(0, nOut);
          cumEnablingProb := fill(0.0, nOut);
          arcWeightSum := 0;
          nremTAout := 0;
          nTAout := 0;
          k := 0;
          posTE := 0;
          randNum := 0;
          sumEnablingProbTAout := 0.0;
          endWhile := false;
        end if;
      end when;
      //arc weight sum of all active output transitions
      //Place has no actual conflict; all active output transitions are enabled
      //Place has an actual conflict;
      //deterministic enabling according to priorities
      //discrete transitions are proven at first
      //continuous transitions afterwards (discrete transitions have priority over continuous transitions)
      //probabilistic enabling according to enabling probabilities
      //number of active output transitions
      //active output transitions
      //number of active output transitions
      //sumEnablingProbTAout:=sum(enablingProb[remTAout[1:nremTAout]]);  //enabling probability sum of all active output transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      //sumEnablingProbTAout:=sum(enablingProb[remTAout[1:nremTAout]]);
      TEout_ := TEout and TAout;
    end enablingOutDis;

    block firingSumCon "calculates the firing sum of continuous places"
      input Boolean fire[:] "firability of transitions";
      input Real arcWeight[:] "arc weights";
      input Real instSpeed[:] "istantaneous speed of transitions";
      input Boolean disTransition[:] "types of transitions";
      output Real conFiringSum "continuous firing sum";
      output Real disFiringSum "discrete firing sum";
  protected
      Real vec1[size(fire, 1)];
      Real vec2[size(fire, 1)];
      //algorithm //changed 21.03.11 due to negative values
    equation
      for i in 1:size(fire, 1) loop
        if fire[i] and not disTransition[i] then
          vec1[i] = arcWeight[i] * instSpeed[i];
        else
          vec1[i] = 0;
        end if;
        if fire[i] and disTransition[i] then
          vec2[i] = arcWeight[i];
        else
          vec2[i] = 0;
        end if;
      end for;
      conFiringSum = sum(vec1);
      disFiringSum = sum(vec2);
    end firingSumCon;

    block firingSumDis "calculates the firing sum of discrete places"
      input Boolean fire[:] "firability of transitions";
      input Integer arcWeight[:] "arc weights";
      output Integer firingSum "firing sum";
    algorithm
      firingSum := 0;
      for i in 1:size(fire, 1) loop
        if fire[i] then
          firingSum := firingSum + arcWeight[i];
        end if;
      end for;
    end firingSumDis;
  end Blocks;

  package Functions
  "contains functions with specific algorithmic procedures which are used in the Petri net component models"

    package Random "random functions"

      impure function random
      "external C-function to generate uniform distributed random numbers"
        output Integer x;

        external "C" x = _random() annotation(Include = "#include <stdlib.h>
                                                                             int _random()
                                                                             {
                                                                               static int called=0;
                                                                               int i;
                                                                               if(!called)
                                                                               { 
                                                                                 srand((unsigned) time(NULL));
                                                                                 called=1;
                                                                               }
                                                                               return rand();
                                                                             }");
      end random;

      impure function randomexp
      "generates a exponential distributed random number according to lambda"
        input Real lambda;
        output Real delay;
    protected
        Real zg;
        Real h_lambda;
      algorithm
        zg := 0;
        h_lambda := lambda;
        while zg / 32767 < 10 ^ (-10) loop
          zg := random();
        end while;
        if lambda <= 0 then
          h_lambda := 10 ^ (-10);
        end if;
        delay := -Modelica.Math.log(zg / 32767) * 1 / h_lambda;
      end randomexp;
    end Random;

    package OddsAndEnds "help functions"

      function conditionalSum
      "calculates the conditional sum of real vector entries"
        input Real vec[:];
        input Boolean con[:];
        output Real conSum;
      algorithm
        conSum := 0;
        for i in 1:size(vec, 1) loop
          if con[i] then
            conSum := conSum + vec[i];
          end if;
        end for;
      end conditionalSum;

      function conditionalSumInt
      "calculates the conditional sum of integer vector entries"
        input Integer vec[:];
        input Boolean con[:];
        output Integer conSum;
      algorithm
        conSum := 0;
        for i in 1:size(vec, 1) loop
          if con[i] then
            conSum := conSum + vec[i];
          end if;
        end for;
      end conditionalSumInt;

      function deleteElementInt "deletes an element of an integer vector"
        input Integer vecin[:];
        input Integer idx;
        output Integer vecout[size(vecin, 1)];
    protected
        parameter Integer nVec = size(vecin, 1);
      algorithm
        vecout[1:idx - 1] := vecin[1:idx - 1];
        vecout[idx:nVec - 1] := vecin[idx + 1:nVec];
        vecout[nVec] := 0;
      end deleteElementInt;
    end OddsAndEnds;
  end Functions;

  package Constants "
        contains constants which are used in the Petri net component models"

    constant Real inf = 1e+60
    "Biggest Real number such that inf and -inf are representable on the machine";

    constant Integer Integer_inf = 1073741823
    "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";

    constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
  end Constants;

  model Test1
    PD P1(nOut = 1, nIn = 1) annotation(Placement(transformation(extent = {{-54, -10}, {-34, 10}})));
    TD T1(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-22, -10}, {-2, 10}})));
    PC P2(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{16, -10}, {36, 10}})));
    TS T3(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-50, 38}, {-70, 58}})));
    inner PNlib.Settings settings1 annotation(Placement(visible = true, transformation(origin = {60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(P2.outTransition[1], T3.inPlaces[1]) annotation(Line(points={{36.8,0},
          {49.265,0},{49.265,48},{-55.2,48}}));
    connect(P1.outTransition[1], T1.inPlaces[1]) annotation(Line(points = {{-33.2, 0}, {-16.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(T1.outPlaces[1], P2.inTransition[1]) annotation(Line(points = {{-7.2, 0}, {15.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(T3.outPlaces[1], P1.inTransition[1]) annotation(Line(points = {{-64.8, 48}, {-88, 48}, {-88, 0}, {-54.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end Test1;
  annotation(uses(ModelicaAdditions(version = "1.5"), Modelica(version = "3.2")), version = "1", conversion(noneFromVersion = ""));
end PNlib;
model PNlib_Test1
 extends PNlib.Test1;
  annotation(uses(PNlib(version="1")));
end PNlib_Test1;
end foo;