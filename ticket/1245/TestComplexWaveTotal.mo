package Modelica "Modelica Standard Library"
  extends Icons.Library;
  annotation(preferedView="info", version="2.2.1", versionDate="2006-03-24", conversion(from(version="1.6", ModelicaAdditions(version="1.5"), MultiBody(version="1.0.1"), MultiBody(version="1.0"), Matrices(version="0.8"), script="Scripts/ConvertModelica_from_1.6_to_2.1.mos"), from(version="2.1 Beta1", script="Scripts/ConvertModelica_from_2.1Beta1_to_2.1.mos"), noneFromVersion="2.1", noneFromVersion="2.2"), Dymola(checkSum="539989979:1143034484"), Settings(NewStateSelection=true), Documentation(info="<HTML>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
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
</p><br>
</HTML>
"));
  package Math "Mathematical functions (e.g., sin, cos) and operations on matrices (e.g., norm, solve, eig, exp)"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Invisible=true, Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(extent={{-59,-9},{42,-56}}, textString="f(x)", fillColor={0,0,0})}), Documentation(info="<HTML>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on <b>matrices</b>.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
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
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
    function sin "sine"
      extends baseIcon1;
      input SI.Angle u;
      output Real y;
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(points={{90,0},{68,8},{68,-8},{90,0}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,0}),Text(extent={{12,84},{84,36}}, textString="sin", fillColor={192,192,192})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,0},{84,0}}, color={192,192,192}),Polygon(points={{100,0},{84,6},{84,-6},{100,0}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,0}),Text(extent={{-105,72},{-85,88}}, textString="1"),Text(extent={{70,25},{90,5}}, textString="2*pi"),Text(extent={{-105,-72},{-85,-88}}, textString="-1"),Text(extent={{92,-2},{112,-22}}, textString="u", fillColor={160,160,160})}), Documentation(info="<html>
 
</html>"));

      external "C" y=sin(u) ;

    end sin;

    function asin "inverse sine (-1 <= u <= 1)"
      extends baseIcon2;
      input Real u;
      output SI.Angle y;
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-90,0},{68,0}}, color={192,192,192}),Polygon(points={{90,0},{68,8},{68,-8},{90,0}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),Text(extent={{-88,78},{-16,30}}, textString="asin", fillColor={192,192,192})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(extent={{-40,-72},{-15,-88}}, textString="-pi/2"),Text(extent={{-38,88},{-13,72}}, textString=" pi/2"),Text(extent={{70,25},{90,5}}, textString="+1"),Text(extent={{-90,21},{-70,1}}, textString="-1"),Line(points={{-100,0},{84,0}}, color={192,192,192}),Polygon(points={{100,0},{84,6},{84,-6},{100,0}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),Text(extent={{92,-2},{112,-22}}, textString="u", fillColor={160,160,160})}), Documentation(info="<html>
 
</html>"));

      external "C" y=asin(u) ;

    end asin;

    function exp "exponential, base e"
      extends baseIcon2;
      input Real u;
      output Real y;
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),Polygon(points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),Text(extent={{-86,50},{-14,2}}, textString="exp", fillColor={192,192,192})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,-80.3976},{84,-80.3976}}, color={192,192,192}),Polygon(points={{100,-80.3976},{84,-74.3976},{84,-86.3976},{100,-80.3976}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),Text(extent={{-31,72},{-11,88}}, textString="20"),Text(extent={{-92,-83},{-72,-103}}, textString="-3"),Text(extent={{70,-83},{90,-103}}, textString="3"),Text(extent={{-18,-53},{2,-73}}, textString="1"),Text(extent={{96,-82},{116,-102}}, textString="u", fillColor={160,160,160})}));

      external "C" y=exp(u) ;

    end exp;

    partial function baseIcon1 "Basic icon for mathematical function with y-axis on left side"
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}}, fillPattern=FillPattern.Solid, lineColor={0,0,0}, fillColor={255,255,255}),Line(points={{-80,-80},{-80,68}}, color={192,192,192}),Polygon(points={{-80,90},{-88,68},{-72,68},{-80,90}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Text(extent={{-150,150},{150,110}}, textString="%name")}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={192,192,192}),Line(points={{-80,-80},{-88,-80}}, color={192,192,192}),Line(points={{-80,-90},{-80,84}}, color={192,192,192}),Text(extent={{-75,110},{-55,90}}, textString="y", fillColor={160,160,160}),Polygon(points={{-80,100},{-86,84},{-74,84},{-80,100}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192})}));
    end baseIcon1;

    partial function baseIcon2 "Basic icon for mathematical function with y-axis in middle"
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}}, fillPattern=FillPattern.Solid, lineColor={0,0,0}, fillColor={255,255,255}),Line(points={{0,-80},{0,68}}, color={192,192,192}),Polygon(points={{0,90},{-8,68},{8,68},{0,90}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192}),Text(extent={{-150,150},{150,110}}, textString="%name")}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(points={{0,-90},{0,84}}, color={192,192,192}),Text(extent={{5,110},{25,90}}, textString="y", fillColor={160,160,160}),Polygon(points={{0,100},{-6,84},{6,84},{0,100}}, fillPattern=FillPattern.Solid, lineColor={192,192,192}, fillColor={192,192,192})}));
    end baseIcon2;

  end Math;

  package SIunits "Type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Invisible=true, Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(extent={{-63,-13},{45,-67}}, textString="[kg.m2]", fillColor={0,0,0})}), Documentation(info="<html>
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
</html>"), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{169,86},{349,236}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{169,236},{189,256},{369,256},{349,236},{169,236}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{369,256},{369,106},{349,86},{349,236},{369,256}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(extent={{179,226},{339,196}}, textString="Library", fillColor={160,160,160}),Text(extent={{206,173},{314,119}}, textString="[kg.m2]", fillColor={0,0,0}),Text(extent={{163,320},{406,264}}, textString="Modelica.SIunits", fillColor={255,0,0})}));
    package Conversions "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Library2;
      annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(extent={{-33,-7},{-92,-67}}, textString="°C", fillColor={0,0,0}, lineThickness=1.0),Text(extent={{82,-7},{22,-67}}, textString="K", fillColor={0,0,0}),Line(points={{-26,-36},{6,-36}}, color={0,0,0}),Polygon(points={{6,-28},{6,-45},{26,-37},{6,-28}}, fillPattern=FillPattern.Solid, pattern=LinePattern.None, fillColor={0,0,0})}), Documentation(info="<HTML>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output 
argument):</p>
<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>
 
</HTML>
"));
      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Library2;
        type Temperature_degC= Real(final quantity="ThermodynamicTemperature", final unit="degC");
        annotation(preferedView="info", Documentation(info="<HTML>
<p>
This package provides predefined types, such as <b>Angle_deg</b> (angle in
degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <b>Scientific Unit Conversion - A
Practical Guide to Metrication</b> (Springer 1997).</p>
<p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>
</HTML>
"), Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(extent={{-66,-13},{52,-67}}, textString="[rev/min]", fillColor={0,0,0})}));
      end NonSIunits;

    end Conversions;

    type Angle= Real(final quantity="Angle", final unit="rad", displayUnit="deg");
    type Velocity= Real(final quantity="Velocity", final unit="m/s");
    type Acceleration= Real(final quantity="Acceleration", final unit="m/s2");
    type Frequency= Real(final quantity="Frequency", final unit="Hz");
  end SIunits;

  package Icons "Icon definitions"
    annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,-100},{80,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(extent={{-120,135},{120,70}}, textString="%name", fillColor={255,0,0}),Text(extent={{-90,40},{70,10}}, textString="Library", fillColor={160,160,160}),Rectangle(extent={{-100,-100},{80,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(extent={{-90,40},{70,10}}, textString="Library", fillColor={160,160,160}),Polygon(points={{-64,-20},{-50,-4},{50,-4},{36,-20},{-64,-20},{-64,-20}}, lineColor={0,0,0}, fillColor={192,192,192}, fillPattern=FillPattern.Solid),Rectangle(extent={{-64,-20},{36,-84}}, lineColor={0,0,0}, fillColor={192,192,192}, fillPattern=FillPattern.Solid),Text(extent={{-60,-24},{32,-38}}, textString="Library", fillColor={128,128,128}),Polygon(points={{50,-4},{50,-70},{36,-84},{36,-20},{50,-4}}, lineColor={0,0,0}, fillColor={192,192,192}, fillPattern=FillPattern.Solid)}), Documentation(info="<html>
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
</html>"));
    partial package Library "Icon for library"
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,-100},{80,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(extent={{-85,35},{65,-85}}, textString="Library", fillColor={0,0,255}),Text(extent={{-120,122},{120,73}}, textString="%name", fillColor={255,0,0})}));
    end Library;

    partial package Library2 "Icon for library where additional icon elements shall be added"
      annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,-100},{80,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Polygon(points={{100,70},{100,-80},{80,-100},{80,50},{100,70}}, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(extent={{-120,125},{120,70}}, textString="%name", fillColor={255,0,0}),Text(extent={{-90,40},{70,10}}, textString="Library", fillColor={160,160,160})}));
    end Library2;

  end Icons;

  package Constants "Mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Library2;
    constant Real e=Modelica.Math.exp(1.0);
    constant Real pi=2*Modelica.Math.asin(1.0);
    constant Real D2R=pi/180 "Degree to Radian";
    constant Real R2D=180/pi "Radian to Degree";
    constant Real eps=1e-15 "Biggest number such that 1.0 + eps = 1.0";
    constant Real small=1e-60 "Smallest number such that small and -small are representable on the machine";
    constant Real inf=1e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    constant Integer Integer_inf=1073741823 "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
    constant SI.Velocity c=299792458 "Speed of light in vacuum";
    constant SI.Acceleration g_n=9.80665 "Standard acceleration of gravity on earth";
    constant Real G(final unit="m3/(kg.s2)")=6.6742e-11 "Newtonian constant of gravitation";
    constant Real h(final unit="J.s")=6.6260693e-34 "Planck constant";
    constant Real k(final unit="J/K")=1.3806505e-23 "Boltzmann constant";
    constant Real R(final unit="J/(mol.K)")=8.314472 "Molar gas constant";
    constant Real sigma(final unit="W/(m2.K4)")=5.6704e-08 "Stefan-Boltzmann constant";
    constant Real N_A(final unit="1/mol")=6.0221415e+23 "Avogadro constant";
    constant Real mue_0(final unit="N/A2")=4*pi*1e-07 "Magnetic constant";
    constant Real epsilon_0(final unit="F/m")=1/(mue_0*c*c) "Electric constant";
    constant NonSI.Temperature_degC T_zero=-273.15 "Absolute zero temperature";
    annotation(Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr and Barry N. Taylor (1999):</dt>
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 1998</b>.
    Journal of Physical and Chemical Reference Data, Vol. 28, No. 6, 1999 and
    Reviews of Modern Physics, Vol. 72, No. 2, 2000. See also <a href=
\"http://physics.nist.gov/cuu/Constants/\">http://physics.nist.gov/cuu/Constants/</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 11 16<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>


<p>
Copyright &copy; 1998-2006, Modelica Association and DLR.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</html>
", revisions="<html>
<ul>
<li><i>Nov 8, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><i>Dec 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sep 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><i>Nov 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"), Invisible=true, Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={coordinateSystem(),graphics()}));
  end Constants;

end Modelica;
package BookExamples
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}})), Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}})));
  package Icons
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}})), Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}})));
    model RunnableExample
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={Rectangle(extent={{-100.0,100.0},{100.0,-100.0}}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineColor={0,0,255}),Line(points={{-80.0,-84.0},{-80.0,34.0}}, color={0,0,0}),Line(points={{-80.0,-84.0},{80.0,-84.0}}, color={0,0,0}),Line(points={{-80.0,-44.0},{-60.0,-44.0},{-58.0,-36.0},{-52.0,-30.0},{-44.0,-28.0},{-38.0,-32.0},{-34.0,-38.0},{-30.0,-40.0},{-28.0,-40.0},{-24.0,-38.0},{-20.0,-26.0},{-16.0,-12.0},{-12.0,8.0},{-6.0,12.0},{0.0,6.0},{0.0,4.0},{4.0,-8.0},{6.0,-24.0},{6.0,-26.0},{8.0,-40.0},{10.0,-58.0},{16.0,-70.0},{26.0,-70.0},{32.0,-64.0},{36.0,-52.0},{38.0,-46.0},{44.0,-42.0},{54.0,-40.0},{62.0,-42.0},{64.0,-46.0},{66.0,-46.0},{72.0,-46.0},{74.0,-44.0},{80.0,-44.0}}, color={0,0,0}),Text(extent={{-96.0,90.0},{96.0,50.0}}, textString="%name", fillColor={0,0,255}),Polygon(points={{88.0,-84.0},{68.0,-76.0},{68.0,-92.0},{88.0,-84.0}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Polygon(points={{-80.0,44.0},{-88.0,24.0},{-72.0,24.0},{-80.0,44.0}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}})));
    end RunnableExample;

    class BookExample
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={Ellipse(extent={{-100.0,100.0},{-60.0,80.0}}, lineColor={0,0,0}, lineThickness=0.5, pattern=LinePattern.None, fillColor={160,160,160}, fillPattern=FillPattern.Sphere),Rectangle(extent={{-100.0,88.0},{-62.0,-90.0}}, lineColor={0,0,0}, pattern=LinePattern.None, fillColor={160,160,160}, fillPattern=FillPattern.VerticalCylinder),Ellipse(extent={{-100.0,-80.0},{-60.0,-100.0}}, lineColor={0,0,0}, lineThickness=0.5, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{-80.0,-80.0},{60.0,-100.0}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Line(points={{-100.0,90.0},{-100.0,-88.0}}, color={0,0,0}, thickness=0.5),Line(points={{-96.0,-84.0},{56.0,-84.0}}, color={192,192,192}),Line(points={{-98.0,-88.0},{56.0,-88.0}}, color={192,192,192}),Line(points={{-100.0,-92.0},{56.0,-92.0}}, color={192,192,192}),Line(points={{-96.0,-96.0},{56.0,-96.0}}, color={192,192,192}),Ellipse(extent={{50.0,-80.0},{70.0,-100.0}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{100.0,100.0},{62.0,-100.0}}, lineColor={255,255,255}, lineThickness=1.0, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Line(points={{-80.0,-100.0},{60.0,-100.0}}, color={0,0,0}, thickness=0.5),Rectangle(extent={{-80.0,100.0},{60.0,-80.0}}, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid),Line(points={{-80.0,100.0},{-80.0,-80.0}}, color={0,0,0}),Line(points={{-80.0,100.0},{60.0,100.0},{60.0,-80.0},{-80.0,-80.0}}, color={0,0,0}, thickness=0.5),Text(extent={{-146.0,178.0},{126.0,106.0}}, textString="%name", fillColor={255,0,0}),Line(points={{-100.0,90.0},{-100.0,-92.0}}, color={0,0,0}, thickness=0.5)}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}})));
    end BookExample;

  end Icons;

  package Chapter5
    extends BookExamples.Icons.BookExample;
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}})), Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}})));
    function ComplexWave
      record Data
        constant Integer num "Number of waves";
        Real a[num] "Wave amplitudes";
        Modelica.SIunits.Frequency f[num] "Wave frequencies";
        Modelica.SIunits.Angle phase[num] "Wave phase offset";
      end Data;

      input Real x "Independent variable";
      input Data d "Wave data";
      output Real y "Sum of sine waves";
    protected 
      Integer n;
      Real s;
    algorithm 
      n:=d.num;
      y:=0;
      for i in 1:n loop
        s:=Modelica.Math.sin(2*Modelica.Constants.pi*d.f[i]*x + d.phase[i]);
        y:=y + d.a[i]*s;
      end for;
    end ComplexWave;

    model TestComplexWave
      extends BookExamples.Icons.RunnableExample;
      parameter ComplexWave.Data wdata(num=3, a={1.3,2.2,5.8}, f={2.0,3.0,7.0}, phase={0,Modelica.Constants.pi,0});
      Real signal;
      constant Real pi=Modelica.Constants.pi;
      Real ver;
      annotation(experiment(StopTime=3));
    equation 
      signal=ComplexWave(time, wdata);
      ver=1.3*Modelica.Math.sin(pi*2.0*time) + 2.2*Modelica.Math.sin(pi*3.0*time + pi) + 5.8*Modelica.Math.sin(pi*7.0*time);
    end TestComplexWave;

  end Chapter5;

end BookExamples;
model BookExamples_Chapter5_TestComplexWave
  extends BookExamples.Chapter5.TestComplexWave;
end BookExamples_Chapter5_TestComplexWave;
