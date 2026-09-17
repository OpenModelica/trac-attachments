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
  package Math "Mathematical functions (e.g., sin, cos) and operations on matrices (e.g., norm, solve, eig, exp)"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Invisible=true, Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, extent={{-59,-56},{42,-9}}, textString="f(x)", fontName="Arial")}), Documentation(info="<HTML>
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

</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    function asin "inverse sine (-1 <= u <= 1)"
      extends baseIcon2;
      input Real u;
      output SI.Angle y;
      annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-90,0},{68,0}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,0},{68,8},{68,-8},{90,0}}),Line(visible=true, points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}, smooth=Smooth.Bezier),Text(visible=true, fillColor={192,192,192}, extent={{-88,30},{-16,78}}, textString="asin", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, extent={{-40,-88},{-15,-72}}, textString="-pi/2", fontName="Arial"),Text(visible=true, extent={{-38,72},{-13,88}}, textString=" pi/2", fontName="Arial"),Text(visible=true, extent={{70,5},{90,25}}, textString="+1", fontName="Arial"),Text(visible=true, extent={{-90,1},{-70,21}}, textString="-1", fontName="Arial"),Line(visible=true, points={{-100,0},{84,0}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{100,0},{84,6},{84,-6},{100,0}}),Line(visible=true, points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{75.2,62.2},{77.6,67.5},{80,80}}, smooth=Smooth.Bezier),Text(visible=true, fillColor={160,160,160}, extent={{92,-22},{112,-2}}, textString="u", fontName="Arial")}), Documentation(info="<html>
 
</html>"));

      external "C" y=asin(u) ;

    end asin;

    function exp "exponential, base e"
      extends baseIcon2;
      input Real u;
      output Real y;
      annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}}),Line(visible=true, points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}, smooth=Smooth.Bezier),Text(visible=true, fillColor={192,192,192}, extent={{-86,2},{-14,50}}, textString="exp", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,-80.3976},{84,-80.3976}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{100,-80.3976},{84,-74.3976},{84,-86.3976},{100,-80.3976}}),Line(visible=true, points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,18.6},{72,38.2},{76,57.6},{80,80}}, smooth=Smooth.Bezier),Text(visible=true, extent={{-31,72},{-11,88}}, textString="20", fontName="Arial"),Text(visible=true, extent={{-92,-103},{-72,-83}}, textString="-3", fontName="Arial"),Text(visible=true, extent={{70,-103},{90,-83}}, textString="3", fontName="Arial"),Text(visible=true, extent={{-18,-73},{2,-53}}, textString="1", fontName="Arial"),Text(visible=true, fillColor={160,160,160}, extent={{96,-102},{116,-82}}, textString="u", fontName="Arial")}));

      external "C" y=exp(u) ;

    end exp;

    partial function baseIcon2 "Basic icon for mathematical function with y-axis in middle"
      annotation(Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{0,80},{-8,80}}, color={192,192,192}),Line(visible=true, points={{0,-80},{-8,-80}}, color={192,192,192}),Line(visible=true, points={{0,-90},{0,84}}, color={192,192,192}),Text(visible=true, fillColor={160,160,160}, extent={{5,90},{25,110}}, textString="y", fontName="Arial"),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{0,100},{-6,84},{6,84},{0,100}})}), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,100}}),Line(visible=true, points={{0,-80},{0,68}}, color={192,192,192}),Polygon(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{0,90},{-8,68},{8,68},{0,90}}),Text(visible=true, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-150,110},{150,150}}, textString="%name", fontName="Arial")}));
    end baseIcon2;

  end Math;

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
    package Conversions "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Library2;
      annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, lineThickness=1, extent={{-92,-67},{-33,-7}}, textString="°C", fontName="Arial"),Text(visible=true, extent={{22,-67},{82,-7}}, textString="K", fontName="Arial"),Line(visible=true, points={{-26,-36},{6,-36}}),Polygon(visible=true, pattern=LinePattern.None, fillPattern=FillPattern.Solid, points={{6,-28},{6,-45},{26,-37},{6,-28}})}), Documentation(info="<HTML>
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
"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Library2;
        type Temperature_degC= Real(final quantity="ThermodynamicTemperature", final unit="degC") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
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
"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, extent={{-66,-67},{52,-13}}, textString="[rev/min]", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end NonSIunits;

    end Conversions;

    type Angle= Real(final quantity="Angle", final unit="rad", displayUnit="deg") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Velocity= Real(final quantity="Velocity", final unit="m/s") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Acceleration= Real(final quantity="Acceleration", final unit="m/s2") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    defineunit m;
    defineunit kg;
    defineunit s;
    defineunit A;
    defineunit K;
    defineunit mol;
    defineunit cd;
    defineunit rad (exp="m/m");
    defineunit sr (exp="m2/m2");
    defineunit Hz (exp="s-1", weight=0.8);
    defineunit N (exp="m.kg.s-2");
    defineunit Pa (exp="N/m2");
    defineunit W (exp="J/s");
    defineunit J (exp="N.m");
    defineunit C (exp="s.A");
    defineunit V (exp="W/A");
    defineunit F (exp="C/V");
    defineunit Ohm (exp="V/A");
    defineunit S (exp="A/V");
    defineunit Wb (exp="V.s");
    defineunit S (exp="A/V");
    defineunit Wb (exp="V.s");
    defineunit T (exp="Wb/m2");
    defineunit H (exp="Wb/A");
    defineunit lm (exp="cd.sr");
    defineunit lx (exp="lm/m2");
    defineunit Bq (exp="s-1");
    defineunit Gy (exp="J/kg");
    defineunit Sv (exp="J/kg");
    defineunit kat (exp="s-1.mol");
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
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-34,-38},{12,-38}}, thickness=0.5),Line(visible=true, points={{-20,-38},{-24,-48},{-28,-56},{-34,-64}}, thickness=0.5),Line(visible=true, points={{-2,-38},{2,-46},{8,-56},{14,-64}}, thickness=0.5)}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  end Constants;

end Modelica;
package ATplus
  annotation(uses(Modelica(version="1.6"), ModelicaAdditions(version="1.5")), Diagram(coordinateSystem(extent={{0.0,0.0},{442.0,394.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,0,255}, extent={{-100.0,-100.0},{80.0,50.0}}),Polygon(visible=true, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-100.0,50.0},{-80.0,70.0},{100.0,70.0},{80.0,50.0},{-100.0,50.0}}),Polygon(visible=true, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{100.0,70.0},{100.0,-80.0},{80.0,-100.0},{80.0,50.0},{100.0,70.0}}),Text(visible=true, origin={-0.6897,-45.2874}, lineColor={0,0,255}, fillColor={0,0,255}, extent={{-99.3103,-54.7126},{80.6897,-14.7126}}, textString="Library", fontName="Arial"),Text(visible=true, origin={0.0,-30.0}, lineColor={0,0,255}, extent={{-6.0,64.0},{-6.0,116.0}}, textString="%name", fontName="Arial")}));
  package Icons
    annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{402.0,261.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,0,255}, extent={{-100.0,-100.0},{80.0,50.0}}),Polygon(visible=true, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-100.0,50.0},{-80.0,70.0},{100.0,70.0},{80.0,50.0},{-100.0,50.0}}),Polygon(visible=true, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{100.0,70.0},{100.0,-80.0},{80.0,-100.0},{80.0,50.0},{100.0,70.0}}),Text(visible=true, origin={-0.6897,-45.2874}, lineColor={0,0,255}, fillColor={0,0,255}, extent={{-99.3103,-54.7126},{80.6897,-14.7126}}, textString="Library", fontName="Arial"),Text(visible=true, origin={0.0,-30.0}, lineColor={0,0,255}, extent={{-6.0,64.0},{-6.0,116.0}}, textString="%name", fontName="Arial")}));
    model Package
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, origin={0.0,0.0}, lineColor={0,0,255}, extent={{-100.0,-100.0},{80.0,50.0}}),Polygon(visible=true, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-100.0,50.0},{-80.0,70.0},{100.0,70.0},{80.0,50.0},{-100.0,50.0}}),Polygon(visible=true, origin={0.0,-0.0}, lineColor={0,0,255}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{100.0,70.0},{100.0,-80.0},{80.0,-100.0},{80.0,50.0},{100.0,70.0}}),Text(visible=true, origin={-0.6897,-45.2874}, lineColor={0,0,255}, fillColor={0,0,255}, extent={{-99.3103,-54.7126},{80.6897,-14.7126}}, textString="Library", fontName="Arial"),Text(visible=true, origin={0.0,-30.0}, lineColor={0,0,255}, extent={{-6.0,64.0},{-6.0,116.0}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end Package;

  end Icons;

  package Weather
    extends Icons.Package;
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, lineColor={255,0,0}, fillColor={255,255,0}, fillPattern=FillPattern.Solid, extent={{-36.0,2.0},{-16.0,20.0}}),Ellipse(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-46.0,-10.0},{-18.0,10.0}}),Ellipse(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-48.0,-20.0},{-20.0,0.0}}),Ellipse(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-26.0,-6.0},{6.0,16.0}}),Ellipse(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-26.0,-16.0},{6.0,6.0}}),Ellipse(visible=true, lineColor={192,192,192}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-8.0,-10.0},{22.0,10.0}}),Line(visible=true, points={{-20.0,18.0},{-10.0,26.0}}, color={255,127,0}),Line(visible=true, points={{-24.0,20.0},{-22.0,32.0}}, color={255,127,0}),Line(visible=true, points={{-30.0,20.0},{-34.0,30.0}}, color={255,127,0}),Line(visible=true, points={{-36.0,16.0},{-46.0,20.0}}, color={255,127,0}),Line(visible=true, points={{-36.0,10.0},{-48.0,8.0}}, color={255,127,0}),Line(visible=true, points={{-28.0,-18.0},{-18.0,-48.0}}, pattern=LinePattern.Dot),Line(visible=true, points={{-20.0,-14.0},{-10.0,-44.0}}, pattern=LinePattern.Dot),Line(visible=true, points={{-10.0,-16.0},{0.0,-46.0}}, pattern=LinePattern.Dot),Line(visible=true, points={{0.0,-14.0},{10.0,-44.0}}, pattern=LinePattern.Dot),Line(visible=true, points={{8.0,-8.0},{18.0,-38.0}}, pattern=LinePattern.Dot)}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    package t_and_sl_rad
      extends Icons.Package;
      extends icons.logos.logo_icon_1;
      constant String none="NoName" ";
  constant Integer n_of_surf_orient_def=TOOLS.surf_orient.surf_orient_alias_def.
       n_of_surf_orient_def";
      constant Integer n_of_surf_orient_def=5 "Changed by kargu to make it possible to test, change back when fixed";
      constant Real conv_deg_to_rad=Constants.pi/180;
      constant Real conv_rad_to_deg=180/Constants.pi;
      constant Integer true_boolean_disp=100;
      constant Integer false_boolean_disp=0;
      annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      import Modelica.SIunits;
      import Modelica.Constants;
      package TOOLS
        extends icons.universals.icon_folder;
        annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{317.0,382.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
        package surf_orient
          class surf_orient_alias_def "Surface orientation alias definitions"
            extends usr_settings.usr_settings_sel;
            constant Integer n_of_surf_orient_def=size(surf_orient_def, 1);
            annotation(Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          algorithm 
            if initial() then 
              assert(size(surf_orient_alias, 1) == size(surf_orient_def, 1), "Error in class 'surf_orient_alias_def': orientation_alias should have as many elements as surface orientation definitions");
              for i in 1:n_of_surf_orient_def loop
                assert(surf_orient_def[i,2] <= 180, "Error in class 'surf_orient_alias_def': surface slope angle is greater than 180°. Please review user settings.");
                assert(surf_orient_def[i,2] >= 0, "Error in class 'surf_orient_alias_def': surface slope angle is negative. Please review user settings.");
                assert(surf_orient_def[i,1] <= 180, "Error in class 'surf_orient_alias_def': surface azimuth angle is greater than 180°. Please review user settings.");
                assert(surf_orient_def[i,1] >= -180, "Error in class 'surf_orient_alias_def': surface azimuth angle is less than -180°. Please review user settings.");
              end for;
            end if;
          end surf_orient_alias_def;

          package usr_settings
            extends icons.universals.icon_usr_folder;
            annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{442.0,394.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{0.0,0.0},{442.0,394.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
            package usr_settings_sel "Surface orientation alias set selector"
              extends usr;
              annotation(Invisible=true, Diagram(coordinateSystem(extent={{0.0,0.0},{442.0,394.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{0.0,0.0},{442.0,394.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
            end usr_settings_sel;

            model usr "User defined surface orientation alias set"
              constant Real surf_orient_def[:,2]=[0,90;-180,90;90,90;-90,90;0,45];
              constant String surf_orient_alias[:]={"sv","nv","ov","wv","sd"};
              annotation(Invisible=true, Diagram(coordinateSystem(extent={{0.0,0.0},{1024.0,670.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{0.0,0.0},{1024.0,670.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
            end usr;

          end usr_settings;

          annotation(Icon(coordinateSystem(extent={{0.0,0.0},{320.0,292.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, extent={{-54.0,-75.4},{88.0,62.6}}),Rectangle(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, extent={{-38.0,-69.4},{94.0,58.6}}),Polygon(visible=true, lineColor={255,127,0}, fillColor={223,223,159}, fillPattern=FillPattern.Solid, lineThickness=1, points={{-58.0,-69.4},{-58.0,70.6},{-44.0,80.6},{-8.0,80.6},{0.0,72.6},{0.0,66.6},{70.0,66.6},{88.0,56.6},{88.0,-69.4},{-58.0,-69.4}}),Polygon(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-42.0,27.6},{26.0,95.6},{116.0,4.6},{50.0,-62.4},{-42.0,27.6}}),Polygon(visible=true, lineColor={192,192,192}, fillColor={255,255,255}, fillPattern=FillPattern.CrossDiag, points={{-49.0,28.6},{19.0,96.6},{109.0,5.6},{43.0,-61.4},{-49.0,28.6}}),Line(visible=true, points={{4.0,58.6},{1.0,71.6},{13.0,67.6}}),Line(visible=true, points={{3.0,64.6},{8.0,69.6}}),Line(visible=true, points={{16.0,70.6},{9.0,78.6}}),Line(visible=true, points={{5.0,74.6},{12.0,81.6}}),Line(visible=true, points={{17.0,79.6},{23.0,85.6}}),Line(visible=true, points={{17.0,85.6},{23.0,79.6}}),Line(visible=true, points={{-32.0,27.6},{-8.0,51.6}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{-21.0,17.6},{27.0,65.6}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{-11.0,6.6},{32.0,49.6}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{3.0,-5.4},{53.0,44.6}}, color={0,0,255}, thickness=0.5),Polygon(visible=true, lineColor={255,127,0}, fillColor={255,255,127}, fillPattern=FillPattern.Solid, lineThickness=1, points={{88.0,-69.4},{-62.0,-69.4},{-74.0,-17.4},{-80.0,36.6},{68.0,36.6},{82.0,-11.4},{88.0,-69.4}}),Text(visible=true, lineColor={0,0,255}, extent={{-63.0,-54.4},{77.0,3.6}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
        end surf_orient;

      end TOOLS;

      package icons
        extends universals.icon_folder;
        package universals
          package base_icons " 
            extends icon_folder;"
            annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{248.0,292.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{0.0,0.0},{248.0,292.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
            model base_icon_folder
              annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, extent={{-70.0,-90.0},{72.0,48.0}}),Rectangle(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, extent={{-54.0,-84.0},{78.0,44.0}}),Polygon(visible=true, lineColor={255,127,0}, fillColor={223,223,159}, fillPattern=FillPattern.Solid, lineThickness=1, points={{-74.0,-84.0},{-74.0,56.0},{-60.0,66.0},{-24.0,66.0},{-16.0,58.0},{-16.0,52.0},{54.0,52.0},{72.0,42.0},{72.0,-84.0},{-74.0,-84.0}}),Polygon(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, points={{-58.0,13.0},{10.0,81.0},{100.0,-10.0},{34.0,-77.0},{-58.0,13.0}}),Polygon(visible=true, lineColor={192,192,192}, fillColor={255,255,255}, fillPattern=FillPattern.CrossDiag, points={{-65.0,14.0},{3.0,82.0},{93.0,-9.0},{27.0,-76.0},{-65.0,14.0}}),Line(visible=true, points={{-12.0,44.0},{-15.0,57.0},{-3.0,53.0}}),Line(visible=true, points={{-13.0,50.0},{-8.0,55.0}}),Line(visible=true, points={{0.0,56.0},{-7.0,64.0}}),Line(visible=true, points={{-11.0,60.0},{-4.0,67.0}}),Line(visible=true, points={{1.0,65.0},{7.0,71.0}}),Line(visible=true, points={{1.0,71.0},{7.0,65.0}}),Line(visible=true, points={{-48.0,13.0},{-24.0,37.0}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{-37.0,3.0},{11.0,51.0}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{-27.0,-8.0},{16.0,35.0}}, color={0,0,255}, thickness=0.5),Line(visible=true, points={{-13.0,-20.0},{37.0,30.0}}, color={0,0,255}, thickness=0.5),Polygon(visible=true, lineColor={255,127,0}, fillColor={255,255,127}, fillPattern=FillPattern.Solid, lineThickness=1, points={{72.0,-84.0},{-78.0,-84.0},{-90.0,-32.0},{-96.0,22.0},{52.0,22.0},{66.0,-26.0},{72.0,-84.0}})}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
            end base_icon_folder;

          end base_icons;

          model icon_folder
            extends base_icons.base_icon_folder;
            annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, lineColor={0,0,255}, extent={{-79.0,-69.0},{61.0,-11.0}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          end icon_folder;

          model icon_usr_folder
            extends base_icons.base_icon_folder;
            annotation(Icon(coordinateSystem(extent={{-78.5,-84.0},{-28.0,-15.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={128,128,128}, fillColor={191,95,0}, pattern=LinePattern.Dot, fillPattern=FillPattern.Solid, points={{-67.0,-63.5},{-62.0,-48.5},{-49.0,-54.0},{-45.0,-66.5},{-40.5,-74.5},{-36.0,-78.5},{-37.5,-81.5},{-65.5,-81.0},{-67.0,-63.5}}),Polygon(visible=true, fillColor={0,0,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, points={{-76.5,-84.0},{-74.5,-74.0},{-66.5,-63.0},{-58.5,-63.5},{-52.0,-71.0},{-47.0,-83.5},{-76.5,-84.0}}),Polygon(visible=true, fillColor={0,0,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, points={{-47.0,-84.0},{-45.0,-75.5},{-43.5,-69.0},{-34.0,-75.5},{-28.0,-84.0},{-47.0,-84.0}}),Line(visible=true, points={{-43.0,-50.5},{-47.0,-50.5},{-49.5,-48.5}}),Ellipse(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-49.0,-37.0},{-43.0,-35.5}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={255,191,127}, fillPattern=FillPattern.Solid, points={{-39.5,-25.5},{-39.0,-31.5},{-39.5,-34.5},{-41.0,-36.5},{-37.0,-44.0},{-42.0,-44.5},{-41.0,-48.5},{-42.5,-50.0},{-41.0,-52.0},{-41.0,-55.0},{-41.5,-59.0},{-47.0,-60.0},{-56.0,-58.5},{-65.5,-56.0},{-69.5,-32.0},{-58.5,-17.5},{-45.0,-19.5},{-39.5,-25.5}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-67.5,-60.5},{-76.0,-53.5},{-78.5,-38.5},{-77.0,-25.0},{-70.5,-17.0},{-60.5,-15.0},{-46.5,-15.5},{-42.0,-20.0},{-39.5,-26.5},{-53.0,-29.0},{-59.5,-33.0},{-64.0,-44.0},{-62.5,-61.5},{-67.5,-60.5}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={255,191,127}, fillPattern=FillPattern.Solid, points={{-39.5,-25.5},{-39.0,-31.5},{-39.5,-34.5},{-41.0,-36.5},{-37.0,-44.0},{-42.0,-44.5},{-41.0,-48.5},{-42.5,-50.0},{-41.0,-52.0},{-41.0,-55.0},{-41.5,-59.0},{-47.0,-60.0},{-56.0,-58.5},{-65.5,-56.0},{-69.5,-32.0},{-58.5,-17.5},{-45.0,-19.5},{-39.5,-25.5}}),Ellipse(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-49.0,-37.0},{-43.0,-35.5}}),Line(visible=true, points={{-43.0,-50.5},{-47.0,-50.5},{-49.5,-48.5}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-68.0,-58.5},{-76.5,-51.5},{-79.0,-36.5},{-77.5,-23.0},{-71.0,-15.0},{-61.0,-13.0},{-47.0,-13.5},{-42.5,-18.0},{-40.0,-24.5},{-53.5,-27.0},{-60.0,-31.0},{-64.5,-42.0},{-63.0,-59.5},{-68.0,-58.5}})}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          end icon_usr_folder;

          annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{320.0,292.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          extends icon_folder;
        end universals;

        package logos
          extends universals.icon_folder;
          annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{320.0,292.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          model logo_icon_1
            annotation(Icon(coordinateSystem(extent={{-59.6,-56.0},{76.4,70.4}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, lineColor={255,127,0}, fillColor={255,255,127}, fillPattern=FillPattern.Solid, lineThickness=1, extent={{14.4,-13.0},{52.6,25.8}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-58.8,-44.8},{18.0,-34.6}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-55.8,-17.2},{18.0,-3.4}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-59.0,-31.2},{21.2,-17.0}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-45.6,-66.2},{6.6,15.6}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-30.6,-66.0},{-8.0,15.4}}),Ellipse(visible=true, lineColor={0,0,255}, lineThickness=0.5, extent={{-59.0,-66.0},{21.2,15.6}})}), Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          end logo_icon_1;

        end logos;

        annotation(Diagram(coordinateSystem(extent={{0.0,0.0},{319.0,384.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end icons;

    end t_and_sl_rad;

  end Weather;

end ATplus;
model ATplus_Weather_t_and_sl_rad_TOOLS_surf_orient_surf_orient_alias_def
  extends ATplus.Weather.t_and_sl_rad.TOOLS.surf_orient.surf_orient_alias_def;
end ATplus_Weather_t_and_sl_rad_TOOLS_surf_orient_surf_orient_alias_def;
