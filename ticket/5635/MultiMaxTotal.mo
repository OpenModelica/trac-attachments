package Modelica "Modelica Standard Library - Version 3.2.3"
extends Modelica.Icons.Package;

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
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0)}), Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package VariantsPackage "Icon for package containing variants"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}), graphics={
            Ellipse(
              origin={10.0,10.0},
              fillColor={76,76,76},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-80.0,-80.0},{-20.0,-20.0}}),
            Ellipse(
              origin={10.0,10.0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{0.0,-80.0},{60.0,-20.0}}),
            Ellipse(
              origin={10.0,10.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{0.0,0.0},{60.0,60.0}}),
            Ellipse(
              origin={10.0,10.0},
              lineColor={128,128,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-80.0,0.0},{-20.0,60.0}})}),
                                Documentation(info="<html>
<p>This icon shall be used for a package/library that contains several variants of one component.</p>
</html>"));
    end VariantsPackage;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}})}), Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer.</p>

<h4>Main Authors:</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
    <dd>Oberpfaffenhofen</dd>
    <dd>Postfach 1116</dd>
    <dd>D-82230 Wessling</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
<dt>Christian Kral</dt>

    <dd>  <a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
</dd>
    <dd>1060 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>
Copyright &copy; 1998-2019, Modelica Association and contributors
</p>
</html>"));
  end Icons;
annotation (
preferredView="info",
version="3.2.3",
versionBuild=2,
versionDate="2019-01-23",
dateModified = "2019-03-20 12:00:00Z",
revisionId="8f65f621a 2019-03-20 09:22:19 +0100",
uses(Complex(version="3.2.3"), ModelicaServices(version="3.2.3")),
conversion(
 noneFromVersion="3.2.2",
 noneFromVersion="3.2.1",
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
Documentation(info="<html>
<p>
Package <strong>Modelica&reg;</strong> is a <strong>standardized</strong> and <strong>free</strong> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
It is also called <strong>Modelica Standard Library</strong>.
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
<li> The <strong>Examples</strong> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li><strong>1288</strong> component models and blocks,</li>
<li><strong>404</strong> example models, and</li>
<li><strong>1227</strong> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial, non-internal and non-obsolete classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<strong>Licensed by the Modelica Association under the 3-Clause BSD License</strong><br>
Copyright &copy; 1998-2019, Modelica Association and <a href=\"modelica://Modelica.UsersGuide.Contact\">contributors</a>.
</p>

<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>

<p>
<strong>Modelica&reg;</strong> is a registered trademark of the Modelica Association.
</p>
</html>"));
end Modelica;

package Buildings "Library with models for building energy and control systems"
  extends Modelica.Icons.Package;

  package Controls "Package with models for controls"
    extends Modelica.Icons.Package;

    package OBC "Blocks and preconfigured control sequences"
      extends Modelica.Icons.VariantsPackage;

      package CDL
      "Package with blocks, examples and validation tests for control description language"

        package Continuous "Package with blocks for continuous variables"

          block MultiMax "Output the maximum element of the input vector"

            parameter Integer nin(min=0) = 0 "Number of input connections"
              annotation (Dialog(connectorSizing=true), HideResult=true);
            Interfaces.RealInput u[nin] "Connector of Real input signals"
              annotation (Placement(transformation(extent={{-140,20},{-100,-20}})));
            Interfaces.RealOutput y "Connector of Real output signals"
              annotation (Placement(transformation(extent={{100,-20},{140,20}})));

          equation
            y = max(u);

          annotation (Icon(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}),
                graphics={
                  Rectangle(
                      extent={{-100,-100},{100,100}},
                      lineColor={0,0,127},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-150,150},{150,110}},
                    textString="%name",
                    lineColor={0,0,255}),
                    Text(
                      extent={{-90,36},{90,-36}},
                      lineColor={160,160,164},
                      textString="max()")}),
                                           Documentation(info="<html>
<p>
Outputs the maximum element of the input vector.
</p>
</html>",           revisions="<html>
<ul>
<li>
September 14, 2017, by Jianjun Hu:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));
          end MultiMax;

          package Sources "Package with blocks that generate source signals"

            block Constant "Output constant signal of type Real"
              parameter Real k "Constant output value";

              Interfaces.RealOutput y
                "Connector of Real output signal"
                annotation (Placement(transformation(extent={{100,-20},{140,20}})));

            equation
              y = k;
              annotation (
                defaultComponentName="con",
                Icon(coordinateSystem(
                    preserveAspectRatio=true,
                    extent={{-100,-100},{100,100}}), graphics={
                    Rectangle(
                    extent={{-100,-100},{100,100}},
                    lineColor={0,0,127},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),
                    Text(
                      lineColor={0,0,255},
                      extent={{-150,110},{150,150}},
                      textString="%name"),
                    Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
                    Polygon(
                      points={{-80,90},{-88,68},{-72,68},{-80,90}},
                      lineColor={192,192,192},
                      fillColor={192,192,192},
                      fillPattern=FillPattern.Solid),
                    Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
                    Polygon(
                      points={{90,-70},{68,-62},{68,-78},{90,-70}},
                      lineColor={192,192,192},
                      fillColor={192,192,192},
                      fillPattern=FillPattern.Solid),
                    Line(points={{-80,0},{80,0}}),
                    Text(
                      extent={{-150,-150},{150,-110}},
                      lineColor={0,0,0},
                      textString="k=%k")}),
                Documentation(info="<html>
<p>
Block that outputs a constant signal <code>y = k</code>,
where <code>k</code> is a real-valued parameter.
</p>
<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Controls/OBC/CDL/Continuous/Constant.png\"
     alt=\"Constant.png\" />
</p>
</html>"));
            end Constant;
          annotation (
          Documentation(
          info="<html>
<p>
Package with blocks that generate signals.
</p>
</html>"),           Icon(graphics={
                  Rectangle(
                    lineColor={200,200,200},
                    fillColor={248,248,248},
                    fillPattern=FillPattern.HorizontalCylinder,
                    extent={{-100.0,-100.0},{100.0,100.0}},
                    radius=25.0),
                  Rectangle(
                    fillColor = {128,128,128},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    extent = {{-70,-4.5},{0,4.5}}),
                  Polygon(origin={23.3333,0.0},
                    fillColor={128,128,128},
                    pattern=LinePattern.None,
                    fillPattern=FillPattern.Solid,
                    points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
                  Rectangle(
                    lineColor={128,128,128},
                    extent={{-100.0,-100.0},{100.0,100.0}},
                    radius=25.0)}));
          end Sources;
        annotation (
        Documentation(
        info="<html>
<p>
Package with blocks for elementary mathematical functions
for continuous variables.
</p>
</html>",
        revisions="<html>
<ul>
<li>
December 22, 2016, by Michael Wetter:<br/>
Firt implementation, based on the blocks from the Modelica Standard Library.
</li>
</ul>
</html>"),
        Icon(graphics={
                Rectangle(
                  lineColor={200,200,200},
                  fillColor={248,248,248},
                  fillPattern=FillPattern.HorizontalCylinder,
                  extent={{-100.0,-100.0},{100.0,100.0}},
                  radius=25.0),
                       Text(
                extent={{-52,86},{52,-92}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                textString="R"),
                Rectangle(
                  lineColor={128,128,128},
                  extent={{-100.0,-100.0},{100.0,100.0}},
                  radius=25.0)}));
        end Continuous;

        package Interfaces
        "Package with connectors for input and output signals"

          connector RealInput = input Real "'input Real' as connector"
          annotation (
            defaultComponentName="u",
            Icon(graphics={
              Polygon(
                lineColor={0,0,127},
                fillColor={0,0,127},
                fillPattern=FillPattern.Solid,
                points={{0,50},{100,0},{0,-50}})},
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
</html>",           revisions="<html>
<ul>
<li>
March 1, 2019, by Michael Wetter:<br/>
On the icon layer, changed connector size and added the connector name.<br/>
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/1375\">issue 1375</a>.
</li>
<li>
January 6, 2017, by Michael Wetter:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));

          connector RealOutput = output Real "'output Real' as connector"
          annotation (
            defaultComponentName="y",
            Icon(
              coordinateSystem(preserveAspectRatio=true,
                initialScale=0.2,
                extent={{-100.0,-100.0},{100.0,100.0}}),
                graphics={
              Polygon(
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                points={{-100,50},{0,0},{-100,-50}})}),
            Diagram(
              coordinateSystem(preserveAspectRatio=true,
                initialScale=0.2,
                extent={{-100.0,-100.0},{100.0,100.0}}),
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
</html>",           revisions="<html>
<ul>
<li>
July 19, 2019, by Jianjun Hu:<br/>
On both icon and diagram layer, added the initialScale.<br/>
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/1375\">issue 1375</a>.
</li>
<li>
March 1, 2019, by Michael Wetter:<br/>
On the icon layer, changed connector size and added the connector name.<br/>
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/1375\">issue 1375</a>.
</li>
<li>
January 6, 2017, by Michael Wetter:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));
        annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains implementations of connectors for input
and output signals of blocks.
</p>
<p>
The connectors are compatible with, and equivalent to,
the connectors from the Modelica Standard Library.
They are here implemented to make the <code>CDL</code>
package a self-contained package.
</p>
</html>"),Icon(graphics={
                Rectangle(
                  lineColor={200,200,200},
                  fillColor={248,248,248},
                  fillPattern=FillPattern.HorizontalCylinder,
                  extent={{-100.0,-100.0},{100.0,100.0}},
                  radius=25.0),
                Rectangle(
                  lineColor={128,128,128},
                  extent={{-100.0,-100.0},{100.0,100.0}},
                  radius=25.0),
                Polygon(origin={20.0,0.0},
                  lineColor={64,64,64},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  points={{-10.0,70.0},{10.0,70.0},{40.0,20.0},{80.0,20.0},{80.0,-20.0},{40.0,-20.0},{10.0,-70.0},{-10.0,-70.0}}),
                Polygon(fillColor={102,102,102},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.Solid,
                  points={{-100.0,20.0},{-60.0,20.0},{-30.0,70.0},{-10.0,70.0},{-10.0,-70.0},{-30.0,-70.0},{-60.0,-20.0},{-100.0,-20.0}})}));
        end Interfaces;
      annotation (
      Documentation(info="<html>
<p>
Package that has elementary input-output blocks
that form the Control Description Language (CDL).
The implementation is structured into sub-packages.
The packages <code>Validation</code> and <code>Examples</code>
contain validation and example models.
These are not part of the CDL specification, but rather
implemented to provide reference responses computed by the CDL blocks.
For a specification of CDL, see
<a href=\"http://obc.lbl.gov/specification/cdl.html\">
http://obc.lbl.gov/specification/cdl.html</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
December 22, 2016, by Michael Wetter:<br/>
Firt implementation, based on the blocks from the Modelica Standard Library.
</li>
</ul>
</html>"),       Icon(graphics={
              Rectangle(
                lineColor={200,200,200},
                fillColor={248,248,248},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-100.0,-100.0},{100.0,100.0}},
                radius=25.0),
              Rectangle(
                lineColor={128,128,128},
                extent={{-100.0,-100.0},{100.0,100.0}},
                radius=25.0),
              Ellipse(
                origin={10.0,10.0},
                fillColor={76,76,76},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                extent={{-80.0,-80.0},{-20.0,-20.0}}),
              Ellipse(
                origin={10.0,10.0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                extent={{0.0,-80.0},{60.0,-20.0}}),
              Ellipse(
                origin={10.0,10.0},
                fillColor={128,128,128},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                extent={{0.0,0.0},{60.0,60.0}}),
              Ellipse(
                origin={10.0,10.0},
                lineColor={128,128,128},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                extent={{-80.0,0.0},{-20.0,60.0}})}));
      end CDL;
    annotation (
    Documentation(info="<html>
<p>
Package that contains a library of elementary control blocks
and a library that implements control sequences from the ASHRAE Guideline 36.
</p>
<p>
These implementations have been developed
through the OpenBuildingControl project
that aims to develop a process and tools for the
performance evaluation, specification and verification
of building control sequences.
See
<a href=\"http://obc.lbl.gov\">
http://obc.lbl.gov</a>
for further information.
</p>
</html>"));
    end OBC;
  annotation (
  preferredView="info", Documentation(info="<html>
This package contains component models for controls.
For additional models, see also
<a href=\"modelica://Modelica.Blocks\">
Modelica.Blocks</a>.
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
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
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
  end Controls;
annotation (
preferredView="info",
version="7.0.0",
versionDate="2019-07-15",
dateModified="2019-07-15",
uses(Modelica(version="3.2.3")),
conversion(
  from(version={"6.0.0"},
      script="modelica://Buildings/Resources/Scripts/Dymola/ConvertBuildings_from_6_to_7.0.0.mos")),
preferredView="info",
Documentation(info="<html>
<p>
The <code>Buildings</code> library is a free library
for modeling building energy and control systems.
Many models are based on models from the package
<code>Modelica.Fluid</code> and use
the same ports to ensure compatibility with the Modelica Standard
Library.
</p>
<p>
The figure below shows a section of the schematic view of the model
<a href=\"modelica://Buildings.Examples.HydronicHeating\">
Buildings.Examples.HydronicHeating</a>.
In the lower part of the figure, there is a dynamic model of a boiler, a pump and a stratified energy storage tank. Based on the temperatures of the storage tank, a finite state machine switches the boiler and its pump on and off.
The heat distribution is done using a hydronic heating system with a three way valve and a pump with variable revolutions. The upper right hand corner shows a room model that is connected to a radiator whose flow is controlled by a thermostatic valve.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/UsersGuide/HydronicHeating.png\" border=\"1\"/>
</p>
<p>
The web page for this library is
<a href=\"http://simulationresearch.lbl.gov/modelica\">http://simulationresearch.lbl.gov/modelica</a>,
and the development page is
<a href=\"https://github.com/lbl-srg/modelica-buildings\">https://github.com/lbl-srg/modelica-buildings</a>.
Contributions to further advance the library are welcomed.
Contributions may not only be in the form of model development, but also
through model use, model testing,
requirements definition or providing feedback regarding the model applicability
to solve specific problems.
</p>
</html>"));
end Buildings;

model MultiMax "Validation model for the MultiMax block"
  parameter Integer nZon=2 "Size of the input vector";

  Buildings.Controls.OBC.CDL.Continuous.MultiMax maxVal(nin=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con[nZon](k=1)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));

equation
  connect(con.y, maxVal.u[1:2])
    annotation (Line(points={{-36,0},{-24,0},{-24,-1},{-12,-1}}, color={0,0,127}));
end MultiMax;
