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
  package Mechanics "Library to model 1-dim. and 3-dim. mechanical systems (multi-body, rotational, translational)"
    extends Modelica.Icons.Library2;
    annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.HorizontalCylinder, extent={{-5,-70},{45,-40}}),Ellipse(visible=true, extent={{-90,-60},{-80,-50}}),Line(visible=true, points={{-85,-55},{-60,-21}}, thickness=0.5),Ellipse(visible=true, extent={{-65,-26},{-55,-16}}),Line(visible=true, points={{-60,-21},{9,-55}}, thickness=0.5),Ellipse(visible=true, fillPattern=FillPattern.Solid, extent={{4,-60},{14,-50}}),Line(visible=true, points={{-10,-34},{72,-34},{72,-76},{-10,-76}})}), Documentation(info="<HTML>
<p>
This package contains components to model the movement
of 1-dim. rotational, 1-dim. translational, and
3-dim. <b>mechanical systems</b>.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       included the Mechanics.MultiBody library 1.0 and adapted it to the new
       Blocks connectors.</li>
<li><i>Oct. 27, 2003</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Bearing torque computation added to package <b>Rotational</b>.</li>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New components and examples in package <b>Rotational</b>.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Changes according to the Twente meeting introduced. Especially,
       package Rotational1D renamed to Rotational and package
       Translational1D renamed to Translational. For the particular
       changes in these packages, see the corresponding package
       release notes.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version for 1-dimensional rotational mechanical
       systems based on an existing Dymola library of Martin Otter and
       Hilding Elmqvist.</li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    package Translational "Library to model 1-dimensional, translational mechanical systems"
      import SI = Modelica.SIunits;
      extends Modelica.Icons.Library2;
      annotation(preferedView="info", Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-84,-73},{66,-73}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Sphere, extent={{-81,-65},{-8,-22}}),Line(visible=true, points={{-8,-43},{-1,-43},{6,-64},{17,-23},{29,-65},{40,-23},{50,-44},{61,-44}}),Line(visible=true, points={{-59,-73},{-84,-93}}),Line(visible=true, points={{-11,-73},{-36,-93}}),Line(visible=true, points={{-34,-73},{-59,-93}}),Line(visible=true, points={{14,-73},{-11,-93}}),Line(visible=true, points={{39,-73},{14,-93}}),Line(visible=true, points={{63,-73},{38,-93}})}), Documentation(info="<html>
<p>
This package contains components to model <i>1-dimensional translational
mechanical</i> systems.
</p>
<p>
The <i>filled</i> and <i>non-filled green squares</i> at the left and
right side of a component represent <i>mechanical flanges</i>.
Drawing a line between such squares means that the corresponding
flanges are <i>rigidly attached</i> to each other. The components of this
library can be usually connected together in an arbitrary way. E.g. it is
possible to connect two springs or two sliding masses with inertia directly
together.
<p> The only <i>connection restriction</i> is that the Coulomb friction
elements (Stop) should be only connected
together provided a compliant element, such as a spring, is in between.
The reason is that otherwise the frictional force is not uniquely
defined if the elements are stuck at the same time instant (i.e., there
does not exist a unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. It can only be resolved in a \"clean way\" by combining the
two connected friction elements into
one component and resolving the ambiguity of the frictional force in the
stuck mode.
</p>
<p> Another restriction arises if the hard stops in model Stop are used, i. e.
the movement of the mass is limited by a stop at smax or smin.
<font color=\"#ff0000\"> <b>This requires the states Stop.s and Stop.v</b> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided. </p>
<p>
In the <i>icon</i> of every component an <i>arrow</i> is displayed in grey
color. This arrow characterizes the coordinate system in which the vectors
of the component are resolved. It is directed into the positive
translational direction (in the mathematical sense).
In the flanges of a component, a coordinate system is rigidly attached
to the flange. It is called <i>flange frame</i> and is directed in parallel
to the component coordinate system. As a result, e.g., the positive
cut-force of a \"left\" flange (flange_a) is directed into the flange, whereas
the positive cut-force of a \"right\" flange (flange_b) is directed out of the
flange. A flange is described by a Modelica connector containing
the following variables:
</p>
<pre>
   SIunits.Position s  \"absolute position of flange\";
   <i>flow</i> Force f        \"cut-force in the flange\";
</pre>

<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g. direct connection of two springs or two shafts with inertia).
As a consequence, most models lead to a system of
differential-algebraic equations of <i>index 3</i> (= constraint
equations have to be differentiated twice in order to arrive at
a state space representation) and the Modelica translator or
the simulator has to cope with this system representation.
According to our present knowledge, this requires that the
Modelica translator is able to symbolically differentiate equations
(otherwise it is e.g. not possible to provide consistent initial
conditions; even if consistent initial conditions are present, most
numerical DAE integrators can cope at most with index 2 DAEs).
</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd>Peter Beater <br>
    Universit&auml;t Paderborn, Abteilung Soest<br>
    Fachbereich Maschinenbau/Automatisierungstechnik<br>
    L&uuml;becker Ring 2 <br>
    D 59494 Soest <br>
    Germany <br>
    email: <A HREF=\"mailto:Beater@mailso.uni-paderborn.de\">Beater@mailso.uni-paderborn.de</A><br>
</dd>
</dl>

<p>
Copyright &copy; 1998-2006, Modelica Association and Universit&auml;t Paderborn, FB 12.
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
<li><i>Version 1.0 (January 5, 2000)</i>
       by Peter Beater <br>
       Realized a first version based on Modelica library Mechanics.Rotational
       by Martin Otter and an existing Dymola library onedof.lib by Peter Beater.
       <br>
<li><i>Version 1.01 (July 18, 2001)</i>
       by Peter Beater <br>
       Assert statement added to \"Stop\", small bug fixes in examples.
       <br><br>
</li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      package Interfaces "Interfaces for 1-dim. translational mechanical components"
        extends Modelica.Icons.Library;
        connector Flange_a "(left) 1D translational flange (flange axis directed INTO cut plane, e. g. from left to right)"
          annotation(defaultComponentName="flange_a", Documentation(info="<html>
This is a flange for 1D translational mechanical systems. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
INTO the cut plane, i. e. from left to right. All vectors in the cut plane are
resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
<pre>
  s: Absolute position of the flange in [m]. A positive translation
     means that the flange is translated along the flange axis.
  f: Cut-force in direction of the flange axis in [N].
</pre>
</HTML>
"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,191,0}, fillColor={0,191,0}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,191,0}, fillColor={0,191,0}, fillPattern=FillPattern.Solid, extent={{-40,-40},{40,40}}),Text(visible=true, lineColor={0,191,0}, fillColor={0,191,0}, extent={{-160,50},{40,110}}, textString="%name", fontName="Arial")}));
          SI.Position s "absolute position of flange";
          flow SI.Force f "cut force directed into flange";
        end Flange_a;

        connector Flange_b "right 1D translational flange (flange axis directed OUT OF cut plane)"
          SI.Position s "absolute position of flange";
          flow SI.Force f "cut force directed into flange";
          annotation(defaultComponentName="flange_b", Documentation(info="<html>
This is a flange for 1D translational mechanical systems. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
OUT OF the cut plane. All vectors in the cut plane are resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
<pre>
  s: Absolute position of the flange in [m]. A positive translation
     means that the flange is translated along the flange axis.
  f: Cut-force in direction of the flange axis in [N].
</pre>
</HTML>
"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,191,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, lineColor={0,191,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-40,-40},{40,40}}),Text(visible=true, lineColor={0,191,0}, fillColor={0,191,0}, extent={{-40,50},{160,110}}, textString="%name", fontName="Arial")}));
        end Flange_b;

        partial model Rigid "Rigid connection of two translational 1D flanges "
          SI.Position s "absolute position of center of component (s = flange_a.s + L/2 = flange_b.s - L/2)";
          parameter SI.Length L=0 "length of component from left flange to right flange (= flange_b.s - flange_a.s)";
          annotation(Documentation(info="<html>
<p>
This is a 1D translational component with two <i>rigidly</i> connected flanges.
The distance between the left and the right flange is always constant, i. e. L.
The forces at the right and left flange can be different.
It is used e.g. to built up sliding masses.
</p>
</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater  (based on Rotational.Rigid)</i> </li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane, i. e. from left to right)" annotation(Placement(visible=true, transformation(origin={-100,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={-100,0}, extent={{-10,-10},{10,10}}, rotation=0)));
          Flange_b flange_b "(right) driven flange (flange axis directed OUT OF cut plane, i. e. from right to left)" annotation(Placement(visible=true, transformation(origin={100,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={100,0}, extent={{-10,-10},{10,10}}, rotation=0)));
        equation 
          flange_a.s=s - L/2;
          flange_b.s=s + L/2;
        end Rigid;

        partial model Compliant "Compliant connection of two translational 1D flanges"
          SI.Distance s_rel "relative distance (= flange_b.s - flange_a.s)";
          SI.Force f "forcee between flanges (positive in direction of flange axis R)";
          annotation(Documentation(info="<html>
<p>
This is a 1D translational component with a <i>compliant </i>connection of two
translational 1D flanges where inertial effects between the two
flanges are not included. The absolute value of the force at the left and the right
flange is the same. It is used to built up springs, dampers etc.
</p>

</HTML>
", revisions="<html>
<p>
<b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Compliant)</i> </li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}})}), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
          Flange_a flange_a "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)" annotation(Placement(visible=true, transformation(origin={-100,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={-100,0}, extent={{-10,-10},{10,10}}, rotation=0)));
          Flange_b flange_b "(right) driven flange (flange axis directed OUT OF cut plane)" annotation(Placement(visible=true, transformation(origin={100,0}, extent={{-10,-10},{10,10}}, rotation=0), iconTransformation(origin={100,0}, extent={{-10,-10},{10,10}}, rotation=0)));
        equation 
          s_rel=flange_b.s - flange_a.s;
          flange_b.f=f;
          flange_a.f=-f;
        end Compliant;

        annotation(Documentation(info="<html>
  
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
      end Interfaces;

      model SlidingMass "Sliding mass with inertia"
        extends Interfaces.Rigid;
        parameter SI.Mass m(min=0)=1 "mass of the sliding mass";
        SI.Velocity v "absolute velocity of component";
        SI.Acceleration a "absolute acceleration of component";
        annotation(Documentation(info="<html>
<p>
Sliding mass with <i>inertia, without friction</i> and two rigidly connected flanges.
</p>
<p>
The sliding mass has the length L, the position coordinate s is in the middle.
Sign convention: A positive force at flange flange_a moves the sliding mass in the positive direction.
A negative force at flange flange_a moves the sliding mass to the negative direction.
</p>

</html>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Shaft)</i> </li>
</ul>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,0},{-55,0}}, color={0,191,0}),Line(visible=true, points={{55,0},{100,0}}, color={0,191,0}),Rectangle(visible=true, fillColor={255,255,255}, fillPattern=FillPattern.Sphere, extent={{-55,-30},{56,30}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}}),Text(visible=true, fillColor={0,0,255}, extent={{0,40},{0,100}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,0},{-55,0}}, color={0,191,0}),Line(visible=true, points={{55,0},{100,0}}, color={0,191,0}),Rectangle(visible=true, fillColor={255,255,255}, fillPattern=FillPattern.Sphere, extent={{-55,-30},{55,30}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}}),Line(visible=true, points={{-100,-29},{-100,-61}}),Line(visible=true, points={{100,-61},{100,-28}}),Line(visible=true, points={{-98,-60},{98,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{100,-60},{95,-61},{95,-59},{100,-60}}),Text(visible=true, extent={{-44,-57},{51,-41}}, textString="Length L", fontName="Arial"),Line(visible=true, points={{0,30},{0,53}}),Line(visible=true, points={{-72,40},{1,40}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-7,42},{-7,38},{-1,40},{-7,42}}),Text(visible=true, extent={{-61,42},{-9,53}}, textString="Position s", fontName="Arial")}));
      equation 
        v=der(s);
        a=der(v);
        m*a=flange_a.f + flange_b.f;
      end SlidingMass;

      model Rod "Rod without inertia"
        extends Interfaces.Rigid;
        annotation(Documentation(info="<html>
<p>
Rod <i>without inertia</i> and two rigidly connected flanges.
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,0},{-55,0}}, color={0,191,0}),Line(visible=true, points={{53,0},{99,0}}, color={0,191,0}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}}),Rectangle(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-55,-10},{53,10}}),Text(visible=true, fillColor={0,0,255}, extent={{0,40},{0,100}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,0},{-55,0}}, color={0,191,0}),Line(visible=true, points={{55,0},{100,0}}, color={0,191,0}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}}),Rectangle(visible=true, lineColor={160,160,160}, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-55,-4},{53,3}}),Line(visible=true, points={{-100,-29},{-100,-61}}),Line(visible=true, points={{100,-61},{100,-28}}),Line(visible=true, points={{-98,-60},{98,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{100,-60},{95,-61},{95,-59},{100,-60}}),Text(visible=true, extent={{-44,-57},{51,-41}}, textString="Length L", fontName="Arial")}));
      equation 
        0=flange_a.f + flange_b.f;
      end Rod;

      model Damper "Linear 1D translational damper"
        extends Interfaces.Compliant;
        parameter Real d(final unit="N/ (m/s)", final min=0)=0 "damping constant [N/ (m/s)]";
        SI.Velocity v_rel "relative velocity between flange_a and flange_b";
        annotation(Documentation(info="<html>
<p>
<i>Linear, velocity dependent damper</i> element. It can be either connected
between a sliding mass and the housing (model Fixed), or
between two sliding masses.
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater (based on Rotational.Damper)</i> </li>
</ul>
</html>"), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-90,0},{-60,0}}),Line(visible=true, points={{-60,-30},{-60,30}}),Line(visible=true, points={{-60,-30},{60,-30}}),Line(visible=true, points={{-60,30},{60,30}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-60,-30},{30,30}}),Line(visible=true, points={{30,0},{90,0}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Line(visible=true, points={{-60,-90},{20,-90}}),Text(visible=true, fillColor={0,0,255}, extent={{0,46},{0,106}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-90,0},{-60,0}}),Line(visible=true, points={{-60,-30},{-60,30}}),Line(visible=true, points={{-60,-30},{60,-30}}),Line(visible=true, points={{-60,30},{60,30}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{-60,-30},{30,30}}),Line(visible=true, points={{30,0},{90,0}}),Line(visible=true, points={{-50,60},{50,60}}, color={128,128,128}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,63},{60,60},{50,57},{50,63}}),Text(visible=true, fillColor={128,128,128}, extent={{-40,68},{38,90}}, textString="der(s_rel)", fontName="Arial")}));
      equation 
        v_rel=der(s_rel);
        f=d*v_rel;
      end Damper;

      model ElastoGap "1D translational spring damper combination with gap"
        extends Interfaces.Compliant;
        parameter SI.Position s_rel0=0 "unstretched spring length";
        parameter Real c(final unit="N/m", final min=0)=1 "spring constant";
        parameter Real d(final unit="N/ (m/s)", final min=0)=1 "damping constant";
        SI.Velocity v_rel "relative velocity between flange_a and flange_b";
        Boolean Contact "false, if s_rel > l ";
        annotation(Documentation(info="<html>
<p>
A <i>linear translational spring damper combination that can lift off</i>.
The component can be connected
between
a sliding mass and the housing (model Fixed), to describe
the contact of a sliding mass with the housing.
</p>

</HTML>
", revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>First Version from August 26, 1999 by P. Beater</i> </li>
</ul>
</html>"), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-100,0},{-50,0}}, color={0,191,0}),Line(visible=true, points={{-48,34},{-48,-46}}, thickness=1),Line(visible=true, points={{8,40},{8,2}}),Line(visible=true, points={{-2,0},{38,0},{38,44},{-2,44}}),Line(visible=true, points={{38,22},{72,22}}),Line(visible=true, points={{-12,-38},{-12,20}}, thickness=1),Line(visible=true, points={{-12,22},{8,22}}),Line(visible=true, points={{-12,-38},{-2,-38}}),Line(visible=true, points={{72,0},{90,0}}, color={0,191,0}),Line(visible=true, points={{72,22},{72,-42}}),Line(visible=true, points={{-2,-38},{10,-28},{22,-48},{38,-28},{50,-48},{64,-28},{72,-40}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{8,0},{38,44}}),Text(visible=true, fillColor={0,0,255}, extent={{-28,-80},{12,-55}}, textString="s_rel", fontName="Arial"),Line(visible=true, points={{-100,-29},{-100,-61}}),Line(visible=true, points={{100,-61},{100,-28}}),Line(visible=true, points={{-98,-60},{98,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}}),Polygon(visible=true, fillPattern=FillPattern.Solid, points={{100,-60},{95,-61},{95,-59},{100,-60}})}), Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-98,0},{-48,0}}, color={0,191,0}),Line(visible=true, points={{-48,34},{-48,-46}}, thickness=1),Line(visible=true, points={{8,40},{8,2}}),Line(visible=true, points={{-2,0},{38,0},{38,44},{-2,44}}),Line(visible=true, points={{38,22},{72,22}}),Line(visible=true, points={{-12,-38},{-12,20}}, thickness=1),Line(visible=true, points={{-12,22},{8,22}}),Line(visible=true, points={{-12,-38},{-2,-38}}),Line(visible=true, points={{72,0},{98,0}}, color={0,191,0}),Line(visible=true, points={{72,22},{72,-42}}),Line(visible=true, points={{-2,-38},{10,-28},{22,-48},{38,-28},{50,-48},{64,-28},{72,-40}}),Rectangle(visible=true, fillColor={192,192,192}, fillPattern=FillPattern.Solid, extent={{8,0},{38,44}}),Line(visible=true, points={{-60,-90},{20,-90}}),Polygon(visible=true, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, points={{50,-90},{20,-80},{20,-100},{50,-90}}),Text(visible=true, fillColor={0,0,255}, extent={{0,60},{0,120}}, textString="%name", fontName="Arial")}));
      equation 
        v_rel=der(s_rel);
        Contact=s_rel < s_rel0;
        f=if Contact then c*(s_rel - s_rel0) + d*v_rel else 0;
      end ElastoGap;

    end Translational;

  end Mechanics;

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
    type Length= Real(final quantity="Length", final unit="m") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Position= Length annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Distance= Length(min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Diameter= Length(min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Volume= Real(final quantity="Volume", final unit="m3") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Velocity= Real(final quantity="Velocity", final unit="m/s") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Acceleration= Real(final quantity="Acceleration", final unit="m/s2") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Mass= Real(quantity="Mass", final unit="kg", min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Density= Real(final quantity="Density", final unit="kg/m3", displayUnit="g/cm3", min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Force= Real(final quantity="Force", final unit="N") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type Pressure= Real(final quantity="Pressure", final unit="Pa", displayUnit="bar") annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type AbsolutePressure= Pressure(min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type BulkModulus= AbsolutePressure annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    type KinematicViscosity= Real(final quantity="KinematicViscosity", final unit="m2/s", min=0) annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
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

    partial record Record "Icon for a record"
      annotation(Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={255,255,127}, fillPattern=FillPattern.Solid, extent={{-100,-100},{100,50}}),Text(visible=true, extent={{-127,55},{127,115}}, textString="%name", fontName="Arial"),Line(visible=true, points={{-100,-50},{100,-50}}),Line(visible=true, points={{-100,0},{100,0}}),Line(visible=true, points={{0,50},{0,-100}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end Record;

  end Icons;

end Modelica;
package Hydraulic "Hydraulic library developed by MathCore Engineering AB and Bosch Rexroth"
  annotation(preferedView="info", Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="<html>
<h1>Hydraulic</h1>
<h2>Description </h2>
This hydraulic library contains components to model hydraulic systems. Some of the components could be connected to other components in other Modelica libraries. The 
<a href=\"Modelica://Hydraulic.PumpsAndMotors\">pumps and motors</a> 
could be connected to the 
<a href=\"Modelica://Modelica.Mechanics.Rotational\">rotational</a> components. The 
<a href=\"Modelica://Hydraulic.Cylinders\">cylinders</a> could be connected to the
<a href=\"Modelica://Modelica.Mechanics.Translational\">translational</a> components. Many other models, for example the 
<a href=\"Modelica://Hydraulic.ProportionalValves\">proportional valves</a> could be connected to the 
<a href=\"Modelica://Modelica.Blocks\">blocks</a>. 

<h2> Package Structure </h2>

Most of the models in this library has lumped volumes to make it possible to connect them arbitrary. The models without volumes, in the <a href=\"Modelica://Hydraulic.StaticModels\">StaticModels</a> package, should therefore not be used when building systems. They are used as parts of the dymanic models. The Dynamic models are more complete models and could be connected almost arbitrary. Some combinations and circuits are not physically relevant and should therefore be avoided. The dynamic and static package has different icons. The static packages in this library has a grey icon and the dynamic packages has a blue icon. The dynamic models contains volumes.

<br>
<img src=\"./Images/PackageDynamic.png\"> 
<br>
<caption>Icon used for the dynamic packages. </caption> 
<br>
<br>
<img src=\"./Images/PackageStatic.png\">
<br>
<caption>Icon used for the static packages. </caption>  
<br>
<br>
All the static models also have a dotted frame to make it easy to identify them. The figures below show the icons for the dynamic and static version of an valve.
<br>
<img src=\"./Images/StaticDynamic.png\">
<br>
<caption>The dotted frame is used for the static models. </caption>  
<br>
<br>

<h2>Ports</h2>
The connectors in this library is defined in the 
<a href=\"Modelica://Hydraulic.Interfaces\">Interfaces</a>. The ports has a pressure variable <i>p</i> in [Pa] , and a flow variable <i>q</i>. The flow is the volume flow in [m^3/s], positive into the component. There are two types of ports in this library, Port_a and Port_b. The only difference between them is the icons.

<br>
<img src=\"./Images/ports.png\">
<br>
<caption>The connectors.</caption>  
<br>
<br>
<h2>Examples</h2>
In the <a href=\"Modelica://Hydraulic.Examples\">Examples</a> there are examples of how to use the components in the library to build hydraulic systems.

<h2>References</h2>
</html>




", revisions=""));
  extends Icons.PackageDynamic;
  import SI = Modelica.SIunits;
  package Media "Media properies package"
    extends Hydraulic.Icons.PackageStatic;
    annotation(preferedView="info", Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, origin={20,-15.83}, fillColor={255,255,127}, fillPattern=FillPattern.Solid, extent={{-36.87,-60.4},{36.87,60.4}}),Rectangle(visible=true, origin={-53.13,-15.8}, fillColor={255,255,127}, fillPattern=FillPattern.Solid, extent={{-36.87,-60.4},{36.87,60.4}}),Line(visible=true, origin={-16.9478,3.6245}, rotation=-90, points={{0,73.0522},{0,-73.0522}}),Line(visible=true, origin={-16.629,-36.7294}, rotation=-90, points={{1.69407e-21,73.371},{-1.69407e-21,-73.371}})}), Documentation(info="<html>
<h1>Media</h1>
 This package contains definitions of medium properties of the fluids. The properties of the medium is defined by the parameters &rho, &nu and &beta.</html>


", revisions=""));
    record Medium "General record for media properties"
      extends Modelica.Icons.Record;
      parameter Modelica.SIunits.Density rho=850 "Density";
      parameter Modelica.SIunits.KinematicViscosity nu=4.6e-05 "Kinematic viscosity";
      parameter Modelica.SIunits.BulkModulus beta=1400000000.0 "Bulk modulus";
      annotation(Documentation(info="<html>
<h1>Medium</h1>
General record for media properties.
</html>", revisions=""));
    end Medium;

  end Media;

  package Icons "Collection of icons used in hydraulic components"
    extends Hydraulic.Icons.PackageStatic;
    annotation(preferedView="info", Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="<html>
<h1>Icons</h1>
Collection of icons used in hydraulic components. The icons are used as base classes for the components, to make it easy to update the icons for several models in one place. 

<br>
There are two icons that are base classes for some of the other icons, the 
 <a href=\"Modelica://Hydraulic.Icons.IconBase\">IconBase</a> that makes tha name of the components look the same everywhere, and the <a href=\"Modelica://Hydraulic.Icons.ModelStatic\">ModelStatic</a> that is extended by all static components. Since the static components does not have lumped volumes it is important to identify them, and therefore they have the dotted frame.
</html>", revisions=""), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, origin={-10.0,-20.0}, fillColor={255,0,0}, fillPattern=FillPattern.Solid, extent={{-40.0,-40.0},{40.0,40.0}})}));
    partial package PackageStatic "Package icon used for libraries containing static models"
      annotation(preferredView="icon", Icon(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={235,235,235}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={210,210,210}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end PackageStatic;

    partial package PackageDynamic "Icon used for packages containing dynamic models"
      annotation(preferredView="icon", Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, fillColor={85,170,255}, fillPattern=FillPattern.Solid, extent={{-100,-100},{80,50}}),Polygon(visible=true, fillColor={85,170,255}, fillPattern=FillPattern.Solid, points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}}),Polygon(visible=true, fillColor={64,129,193}, fillPattern=FillPattern.Solid, points={{100,70},{100,-80},{80,-100},{80,50},{100,70}})}), Diagram(coordinateSystem(extent={{-100,100},{100,-100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
    end PackageDynamic;

    model CylinderEqualArea "Icon to be used for cylinders"
      annotation(preferredView="icon", Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5}), graphics={Rectangle(visible=true, origin={-27.5,12.5}, fillColor={255,255,255}, extent={{-17.5,-7.5},{17.5,7.5}}),Rectangle(visible=true, origin={-27.5,-12.5}, fillColor={255,255,255}, extent={{-17.5,-7.5},{17.5,7.5}}),Rectangle(visible=true, origin={27.5,-12.5}, fillColor={255,255,255}, extent={{-17.5,-7.5},{17.5,7.5}}),Rectangle(visible=true, origin={27.5,12.5}, fillColor={255,255,255}, extent={{-17.5,-7.5},{17.5,7.5}}),Line(visible=true, origin={-72.5,0}, points={{27.5,5},{-27.5,5},{-27.5,-5},{27.5,-5}}),Line(visible=true, origin={72.5,0}, points={{-27.5,5},{27.5,5},{27.5,-5},{-27.5,-5}}),Rectangle(visible=true, origin={0.116279,1.59872e-14}, fillColor={255,255,255}, extent={{-9.88372,-20},{9.88372,20}}),Line(visible=true, origin={-25,-30}, points={{0,10},{0,-10}}),Line(visible=true, origin={25,-30}, points={{0,10},{0,-10}})}));
      extends Hydraulic.Icons.IconBase;
    end CylinderEqualArea;

    model IconBase "Base for the icons that displays the name"
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, origin={-5.15143e-14,-156.98}, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-100,-16.98},{100,16.98}}, textString="%name", fontName="Arial")}));
    end IconBase;

  end Icons;

end Hydraulic;
package HydraulicTests_new
  annotation(Diagram(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})));
  model CylinderDouble1 "Double cylinder model"
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, points={{-50,-50},{-50,-100}}, color={0,170,255}),Line(visible=true, points={{50,-50},{50,-100}}, color={0,170,255}),Text(visible=true, fillPattern=FillPattern.Solid, extent={{-87.5,-112.4},{-62.5,-87.62}}, textString="a", fontName="Arial"),Text(visible=true, fillPattern=FillPattern.Solid, extent={{62.5,-112.5},{87.5,-87.5}}, textString="b", fontName="Arial"),Line(visible=true, origin={-41.5152,-43.3333}, points={{16.9695,3.33333},{-8.48477,3.33333},{-8.48477,-6.66667}}),Line(visible=true, origin={41.834,-43.3333}, points={{-16.332,3.33333},{8.166,3.33333},{8.166,-6.66667}}),Line(visible=true, origin={-50,46.6667}, points={{-40,13.3333},{20,13.3333},{20,-26.6667}})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10})), Documentation(info="<html>
<h1>CylinderDouble</h1>
A model of a double acting cylinder with mass, friction and internal leakage.</html>
", revisions=""));
    replaceable Hydraulic.Media.Medium medium;
    extends Hydraulic.Icons.CylinderEqualArea;
    parameter Real Gleakage=1e-20 "Leakage between cylinders";
    parameter Real cWall(final unit="N/m", final min=0)=10000000.0 "Spring constant for cylinder wall";
    parameter Real dWall(final unit="N/ (m/s)", final min=0)=10000000.0 "Damping constant for cylinder wall";
    parameter Modelica.SIunits.Diameter diameterRodA=0.036 "Diameter of rod at left side (a)";
    parameter Modelica.SIunits.Diameter diameterRodB=diameterRodA "Diameter of rod at right side (b)";
    parameter Modelica.SIunits.Diameter diameterPiston=0.05 "Diameter of piston";
    Modelica.Mechanics.Translational.Damper friction(d=frictionViscous) annotation(Placement(visible=true, transformation(origin={-45,15}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    Modelica.Mechanics.Translational.Rod housing(L=lengthHousing) annotation(Placement(visible=true, transformation(origin={-4.44089e-16,60}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    parameter Modelica.SIunits.Length lengthHousing=0.05 "Total length of cylinder" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Length lengthPiston=0 "Length of piston" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Length lengthRodA=0.1 "Length of left rod (a)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Length lengthRodB=lengthRodA "Length of right rod (b)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    Modelica.Mechanics.Translational.ElastoGap elastoGapA(c=cWall, d=dWall, s_rel0=sRel0) annotation(Placement(visible=true, transformation(origin={-45,-7.5}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    Modelica.Mechanics.Translational.ElastoGap elastoGapB(c=cWall, d=dWall, s_rel0=sRel0) annotation(Placement(visible=true, transformation(origin={45,-7.5}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flangeB annotation(Placement(visible=true, transformation(origin={105,0}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0), iconTransformation(origin={100,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flangeRef annotation(Placement(visible=true, transformation(origin={-105,60}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0), iconTransformation(origin={-100,60}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Mass mPiston=400 "Mass of piston" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Pressure pStartA=0 "Start pressure for left side of piston (a)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Pressure pStartB=pStartA "Start pressure for right side of piston (b)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    Modelica.Mechanics.Translational.Rod rodA(L=lengthRodA) annotation(Placement(visible=true, transformation(origin={-75,-52.5}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    parameter Modelica.SIunits.Length sRel0=0.0001 "Length of spring effect of wall" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Distance sStart=0.25 "Start position of piston" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Velocity vStart=0 "Start velocity of piston" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Volume VdeadA=0.006 "Dead volume for left part (a)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    parameter Modelica.SIunits.Volume VdeadB=0.006 "Dead volume for right part (b)" annotation(Placement(visible=false, transformation(origin={0,0}, extent={{-10,-10},{10,10}}, rotation=0)));
    Modelica.Mechanics.Translational.Rod rodB(L=lengthRodB) annotation(Placement(visible=true, transformation(origin={75,-52.5}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=-360)));
    Modelica.Mechanics.Translational.SlidingMass piston(L=lengthPiston, m=mPiston, s.start=sStart, v.start=vStart) annotation(Placement(visible=true, transformation(origin={0,-37.5}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0)));
    parameter Real frictionViscous(final unit="N/ (m/s)", final min=0)=1000 "Viscous friction";
    Modelica.Mechanics.Translational.Interfaces.Flange_a flangeA annotation(Placement(visible=true, transformation(origin={-105,0}, extent={{-7.5,-7.5},{7.5,7.5}}, rotation=0), iconTransformation(origin={-107.969,0}, extent={{-10,-10},{10,10}}, rotation=0)));
  equation 
    connect(piston.flange_b,housing.flange_b) annotation(Line(visible=true, origin={9.3755,11.25}, points={{-1.8755,-48.75},{1.8755,-48.75},{1.8755,48.75},{-1.8755,48.75}}, color={0,191,0}));
    connect(housing.flange_a,piston.flange_a) annotation(Line(visible=true, origin={-9.3755,11.25}, points={{1.8755,48.75},{-1.8755,48.75},{-1.8755,-48.75},{1.8755,-48.75}}, color={0,191,0}));
    connect(rodA.flange_a,flangeA) annotation(Line(visible=true, origin={-97.5,-35}, points={{15,-17.5},{-7.5,-17.5},{-7.5,35}}));
    connect(rodB.flange_a,piston.flange_b) annotation(Line(visible=true, origin={24.3755,-45}, points={{43.1245,-7.5},{-13.1245,-7.5},{-13.1245,7.5},{-16.8755,7.5}}));
    connect(friction.flange_b,piston.flange_a) annotation(Line(visible=true, points={{-37.5,15},{-15,15},{-15,-37.5},{-7.5,-37.5}}));
    connect(piston.flange_a,elastoGapA.flange_b) annotation(Line(visible=true, points={{-7.5,-37.5},{-22.5,-37.5},{-22.5,-7.5},{-37.5,-7.5}}));
    connect(piston.flange_b,elastoGapB.flange_a) annotation(Line(visible=true, points={{7.5,-37.5},{22.5,-37.5},{22.5,-7.5},{37.5,-7.5}}));
    connect(piston.flange_a,rodA.flange_b) annotation(Line(visible=true, points={{-7.5,-37.5},{-22.5,-37.5},{-22.5,-52.5},{-67.5,-52.5}}));
    connect(rodB.flange_b,flangeB) annotation(Line(visible=true, origin={97.5,-35}, points={{-15,-17.5},{7.5,-17.5},{7.5,35}}));
    connect(housing.flange_a,elastoGapA.flange_a) annotation(Line(visible=true, points={{-7.5,60},{-60,48.135},{-61.5236,-7.5},{-52.5,-7.5}}));
    connect(housing.flange_b,elastoGapB.flange_b) annotation(Line(visible=true, points={{7.5,60},{50,50},{60,-7.5},{52.5,-7.5}}));
    connect(housing.flange_a,flangeRef) annotation(Line(visible=true, origin={-56.25,60}, points={{48.75,0},{-48.75,0}}));
    connect(friction.flange_a,flangeRef) annotation(Line(visible=true, points={{-52.5,15},{-90,15},{-90,60},{-105,60}}));
  end CylinderDouble1;

end HydraulicTests_new;
model HydraulicTests_new_CylinderDouble1
  extends HydraulicTests_new.CylinderDouble1;
end HydraulicTests_new_CylinderDouble1;
