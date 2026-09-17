package ModelicaServices
  "(version = 3.2.1, target = \"Dymola\") Models and functions used in the Modelica Standard Library requiring a tool specific implementation"

package Machine

  final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";
  annotation (Documentation(info="<html>
<p>
Package in which processor specific constants are defined that are needed
by numerical algorithms. Typically these constants are not directly used,
but indirectly via the alias definition in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
</p>
</html>"));
end Machine;
annotation (
  Protection(access=Access.hide),
  preferredView="info",
  version="3.2.1",
  versionDate="2013-01-17",
  versionBuild=1,
  uses(Modelica(version="3.2.1")),
  conversion(
    noneFromVersion="1.0",
    noneFromVersion="1.1",
    noneFromVersion="1.2"),
  Documentation(info="<html>
<p>
This package contains a set of functions and models to be used in the
Modelica Standard Library that requires a tool specific implementation.
These are:
</p>

<ul>
<li> <a href=\"modelica://ModelicaServices.Animation.Shape\">Shape</a>
     provides a 3-dim. visualization of elementary
     mechanical objects. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Animation.Surface\">Surface</a>
     provides a 3-dim. visualization of
     moveable parameterized surface. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.ExternalReferences.loadResource\">loadResource</a>
     provides a function to return the absolute path name of an URI or a local file name. It is used in
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Files.loadResource</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Machine\">ModelicaServices.Machine</a>
     provides a package of machine constants. It is used in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.</li>

<li> <a href=\"modelica://ModelicaServices.Types.SolverMethod\">Types.SolverMethod</a>
     provides a string defining the integration method to solve differential equations in
     a clocked discretized continuous-time partition (see Modelica 3.3 language specification).
     It is not yet used in the Modelica Standard Library, but in the Modelica_Synchronous library
     that provides convenience blocks for the clock operators of Modelica version &ge; 3.3.</li>
</ul>

<p>
This implementation is targeted for Dymola.
</p>

<p>
<b>Licensed by DLR and Dassault Syst&egrave;mes AB under the Modelica License 2</b><br>
Copyright &copy; 2009-2013, DLR and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
end ModelicaServices;

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

      connector IntegerInput = input Integer "'input Integer' as connector"
        annotation (
        defaultComponentName="u",
        Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}, coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={255,127,0},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Integer.
</p>
</html>"));

      connector IntegerOutput = output Integer "'output Integer' as connector"
        annotation (
        defaultComponentName="y",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
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

  package Electrical
  "Library of electrical models (analog, digital, machines, multi-phase)"
  extends Modelica.Icons.Package;

    package Analog "Library for analog electrical models"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Package;

      package Interfaces
      "Connectors and partial models for Analog electrical components"
        extends Modelica.Icons.InterfacesPackage;

        connector Pin "Pin of an electrical component"
          Modelica.SIunits.Voltage v "Potential at the pin" annotation (
              unassignedMessage="An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
          flow Modelica.SIunits.Current i "Current flowing into the pin" annotation (
              unassignedMessage="An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
          annotation (defaultComponentName="pin",
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Rectangle(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-160,110},{40,50}},
                  lineColor={0,0,255},
                  textString="%name")}),
            Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",       info="<html>
<p>Pin is the basic electric connector. It includes the voltage which consists between the pin and the ground node. The ground node is the node of (any) ground device (Modelica.Electrical.Basic.Ground). Furthermore, the pin includes the current, which is considered to be <b>positive</b> if it is flowing at the pin<b> into the device</b>.</p>
</html>"));
        end Pin;
        annotation (Documentation(info="<html>
<p>This package contains connectors and interfaces (partial models) for analog electrical components. The partial models contain typical combinations of pins, and internal variables which are often used. Furthermore, the thermal heat port is in this package which can be included by inheritance.</p>
</html>",revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
<dt>
<b>Copyright:</b>
</dt>
<dd>
Copyright &copy; 1998-2013, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i>
</dd>
</dl>

<ul>
<li><i> 1998</i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
      end Interfaces;
    annotation (Documentation(info="<html>
<p>
This package contains packages for analog electrical components:</p>
<ul>
<li>Basic: basic components (resistor, capacitor, conductor, inductor, transformer, gyrator)</li>
<li>Semiconductors: semiconductor devices (diode, bipolar and MOS transistors)</li>
<li>Lines: transmission lines (lossy and lossless)</li>
<li>Ideal: ideal elements (switches, diode, transformer, idle, short, ...)</li>
<li>Sources: time-dependent and controlled voltage and current sources</li>
<li>Sensors: sensors to measure potential, voltage, and current</li>
</ul>
<dl>
<dt>
<b>Main Authors:</b>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden, Germany
</dd>
</dl>
</html>"),     Icon(graphics={
            Line(
              points={{12,60},{12,-60}},
              color={0,0,0}),
            Line(
              points={{-12,60},{-12,-60}},
              color={0,0,0}),
            Line(points={{-80,0},{-12,0}}, color={0,0,0}),
            Line(points={{12,0},{80,0}}, color={0,0,0})}));
    end Analog;
  annotation (
    Documentation(info="<html>
<p>
This library contains electrical components to build up analog and digital circuits,
as well as machines to model electrical motors and generators,
especially three phase induction machines such as an asynchronous motor.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Rectangle(
        origin={20.3125,82.8571},
        extent={{-45.3125,-57.8571},{4.6875,-27.8571}}),
      Line(
        origin={8.0,48.0},
        points={{32.0,-58.0},{72.0,-58.0}}),
      Line(
        origin={9.0,54.0},
        points={{31.0,-49.0},{71.0,-49.0}}),
      Line(
        origin={-2.0,55.0},
        points={{-83.0,-50.0},{-33.0,-50.0}}),
      Line(
        origin={-3.0,45.0},
        points={{-72.0,-55.0},{-42.0,-55.0}}),
      Line(
        origin={1.0,50.0},
        points={{-61.0,-45.0},{-61.0,-10.0},{-26.0,-10.0}}),
      Line(
        origin={7.0,50.0},
        points={{18.0,-10.0},{53.0,-10.0},{53.0,-45.0}}),
      Line(
        origin={6.2593,48.0},
        points={{53.7407,-58.0},{53.7407,-93.0},{-66.2593,-93.0},{-66.2593,-58.0}})}));
  end Electrical;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  package Icons "Icons for Math"
    extends Modelica.Icons.IconsPackage;

    partial function AxisCenter
    "Basic icon for mathematical function with y-axis in the center"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-80},{0,68}}, color={192,192,192}),
            Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(graphics={Line(points={{0,80},{-8,80}}, color={95,95,95}),Line(
              points={{0,-80},{-8,-80}}, color={95,95,95}),Line(points={{0,-90},{
              0,84}}, color={95,95,95}),Text(
                  extent={{5,104},{25,84}},
                  lineColor={95,95,95},
                  textString="y"),Polygon(
                  points={{0,98},{-6,82},{6,82},{0,98}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
    end AxisCenter;
  end Icons;

  function asin "Inverse sine (-1 <= u <= 1)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u;
    output SI.Angle y;

  external "builtin" y=  asin(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
                -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
                52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),
          Text(
            extent={{-88,78},{-16,30}},
            lineColor={192,192,192},
            textString="asin")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-40,-72},{-15,-88}},
              textString="-pi/2",
              lineColor={0,0,255}),Text(
              extent={{-38,88},{-13,72}},
              textString=" pi/2",
              lineColor={0,0,255}),Text(
              extent={{68,-9},{88,-29}},
              textString="+1",
              lineColor={0,0,255}),Text(
              extent={{-90,21},{-70,1}},
              textString="-1",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{98,0},{82,6},{82,-6},{98,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
              -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
              52.7},{75.2,62.2},{77.6,67.5},{80,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{82,24},{102,4}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{0,80},{86,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{80,86},{80,-10}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = asin(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</p>
</html>"));
  end asin;

  function atan2 "Four quadrant inverse tangent"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u1;
    input Real u2;
    output SI.Angle y;

  external "builtin" y=  atan2(u1, u2);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
                {69.9,-45.8},{80,-45.1}}, color={0,0,0}),
          Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
                -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
                62.1,33.5},{80,34.9}}, color={0,0,0}),
          Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
                65.8},{-1.82,77.2},{0,80}}, color={0,0,0}),
          Text(
            extent={{-90,-46},{-18,-94}},
            lineColor={192,192,192},
            textString="atan2")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{96,0},{80,6},{80,-6},{96,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}},
              color={0,0,255},
              thickness=0.5),Line(
              points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}},
              color={0,0,255},
              thickness=0.5),Line(
              points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-32,89},{-10,74}},
              textString="pi",
              lineColor={0,0,255}),Text(
              extent={{-32,-72},{-4,-88}},
              textString="-pi",
              lineColor={0,0,255}),Text(
              extent={{0,55},{20,42}},
              textString="pi/2",
              lineColor={0,0,255}),Line(points={{0,40},{-8,40}}, color={192,192,
            192}),Line(points={{0,-40},{-8,-40}}, color={192,192,192}),Text(
              extent={{0,-23},{20,-42}},
              textString="-pi/2",
              lineColor={0,0,255}),Text(
              extent={{62,-4},{94,-26}},
              lineColor={95,95,95},
              textString="u1, u2"),Line(
              points={{-88,40},{86,40}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{-86,-40},{86,-40}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<HTML>
<p>
This function returns y = atan2(u1,u2) such that tan(y) = u1/u2 and
y is in the range -pi &lt; y &le; pi. u2 may be zero, provided
u1 is not zero. Usually u1, u2 is provided in such a form that
u1 = sin(y) and u2 = cos(y):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\">
</p>

</html>"));
  end atan2;
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

  package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    final constant Real pi=2*Modelica.Math.asin(1.0);

    final constant Real eps=ModelicaServices.Machine.eps
    "Biggest number such that 1.0 + eps = 1.0";
    annotation (
      Documentation(info="<html>
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
Copyright &copy; 1998-2013, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
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
</html>"),
      Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Polygon(
          origin={-9.2597,25.6673},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={-19.9923,-8.3993},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={23.753,-11.5422},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
          smooth=Smooth.Bezier)}));
  end Constants;

  package Icons "Library of icons"
    extends Icons.Package;

    partial package ExamplesPackage
    "Icon for packages containing runnable examples"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              origin={8.0,14.0},
              lineColor={78,138,73},
              fillColor={78,138,73},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}), Documentation(info="<html>
<p>This icon indicates a package that contains executable examples.</p>
</html>"));
    end ExamplesPackage;

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

    partial package BasesPackage "Icon for packages containing base classes"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              extent={{-30.0,-30.0},{30.0,30.0}},
              lineColor={128,128,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon shall be used for a package/library that contains base models and classes, respectively.</p>
</html>"));
    end BasesPackage;

    partial package VariantsPackage "Icon for package containing variants"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),       graphics={
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
<p>This icon shall be used for a package/library that contains several variants of one components.</p>
</html>"));
    end VariantsPackage;

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
              fillColor=  {128,128,128},
              pattern=  LinePattern.None,
              fillPattern=  FillPattern.Solid,
              extent=  {{-70,-4.5},{0,4.5}})}),
                                Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
    end SourcesPackage;

    partial package SensorsPackage "Icon for packages containing sensors"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(origin={0.0,-30.0},
              fillColor={255,255,255},
              extent={{-90.0,-90.0},{90.0,90.0}},
              startAngle=20.0,
              endAngle=160.0),
            Ellipse(origin={0.0,-30.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-20.0,-20.0},{20.0,20.0}}),
            Line(origin={0.0,-30.0},
              points={{0.0,60.0},{0.0,90.0}}),
            Ellipse(origin={-0.0,-30.0},
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-10.0,-10.0},{10.0,10.0}}),
            Polygon(
              origin={-0.0,-30.0},
              rotation=-35.0,
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-7.0,0.0},{-3.0,85.0},{0.0,90.0},{3.0,85.0},{7.0,0.0}})}),
                                Documentation(info="<html>
<p>This icon indicates a package containing sensors.</p>
</html>"));
    end SensorsPackage;

    partial package IconsPackage "Icon for packages containing icons"
      extends Modelica.Icons.Package;
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
              lineColor={0,0,0})}));
    end IconsPackage;

    partial package MaterialPropertiesPackage
    "Icon for package containing property classes"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              lineColor={102,102,102},
              fillColor={204,204,204},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere,
              extent={{-60.0,-60.0},{60.0,60.0}})}),
                                Documentation(info="<html>
<p>This icon indicates a package that contains properties</p>
</html>"));
    end MaterialPropertiesPackage;

    partial function Function "Icon for functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-150,105},{150,145}},
              textString="%name"),
            Ellipse(
              lineColor=  {108,88,49},
              fillColor=  {255,215,136},
              fillPattern=  FillPattern.Solid,
              extent=  {{-100,-100},{100,100}}),
            Text(
              lineColor={108,88,49},
              extent={{-90.0,-90.0},{90.0,90.0}},
              textString="f")}),
    Documentation(info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
    end Function;

    partial record Record "Icon for records"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-150,60},{150,100}},
              textString="%name"),
            Rectangle(
              origin={0.0,-25.0},
              lineColor={64,64,64},
              fillColor={255,215,136},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-75.0},{100.0,75.0}},
              radius=25.0),
            Line(
              points={{-100.0,0.0},{100.0,0.0}},
              color={64,64,64}),
            Line(
              origin={0.0,-50.0},
              points={{-100.0,0.0},{100.0,0.0}},
              color={64,64,64}),
            Line(
              origin={0.0,-25.0},
              points={{0.0,75.0},{0.0,-75.0}},
              color={64,64,64})}),                        Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
    end Record;
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

    package Conversions
    "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Package;
        annotation (Documentation(info="<HTML>
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
</html>"),   Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          origin={15.0,51.8518},
          extent={{-105.0,-86.8518},{75.0,-16.8518}},
          lineColor={0,0,0},
          textString="[km/h]")}));
      end NonSIunits;
      annotation (                              Documentation(info="<HTML>
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

</html>"));
    end Conversions;

    type Angle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");

    type Time = Real (final quantity="Time", final unit="s");

    type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");

    type AngularAcceleration = Real (final quantity="AngularAcceleration", final unit=
               "rad/s2");

    type Frequency = Real (final quantity="Frequency", final unit="Hz");

    type AngularFrequency = Real (final quantity="AngularFrequency", final unit=
            "rad/s");

    type Power = Real (final quantity="Power", final unit="W");

    type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A");

    type Current = ElectricCurrent;

    type ElectricPotential = Real (final quantity="ElectricPotential", final unit=
           "V");

    type Voltage = ElectricPotential;

    type Inductance = Real (
        final quantity="Inductance",
        final unit="H");

    type Resistance = Real (
        final quantity="Resistance",
        final unit="Ohm");

    type ActivePower = Real (final quantity="Power", final unit="W");

    type ApparentPower = Real (final quantity="Power", final unit="VA");
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

package PowerSystems "Library for electrical power systems"
  extends Modelica.Icons.Package;
  import Modelica.Constants.pi;
  import SI = Modelica.SIunits;
  import PowerSystems.Basic.Types.SIpu "Per-Unit types for user interface";
  import PowerSystems.Basic.Types;

  model System "System reference"
    parameter SI.Frequency f_nom=50 "nom frequency"
     annotation(Evaluate=true, Dialog(group="System"), choices(choice=50 "50 Hz", choice=60 "60 Hz"));
    parameter SI.Frequency f=f_nom
    "frequency (initial if fType_par = false (average))"
     annotation(Evaluate=true, Dialog(group="System"));
    parameter Boolean fType_par = true
    "= true, if system frequency defined by parameter f, else average frequency"
      annotation(Evaluate=true, Dialog(group="System"));
    parameter SI.Frequency f_lim[2]={0.5*f_nom, 2*f_nom}
    "limit frequencies (for average definition)"
     annotation(Evaluate=true, Dialog(group="System",enable=not fType_par));
    parameter SI.Angle alpha0=0 "phase angle"
     annotation(Evaluate=true, Dialog(group="System"));
    parameter String     ref = "synchron" "reference frame (3-phase)"
      annotation(Evaluate=true, Dialog(group="System", enable=sim=="tr"), choices(
        choice="synchron",
        choice="inertial"));
    parameter String     ini = "st" "transient or steady-state initialisation"
     annotation(Evaluate=true, Dialog(group="Mode", enable=sim=="tr"), choices(
       choice="tr" "transient",
       choice="st" "steady"));
    parameter String     sim = "tr" "transient or steady-state simulation"
     annotation(Evaluate=true, Dialog(group="Mode"), choices(
       choice="tr" "transient",
       choice="st" "steady"));
    final parameter SI.AngularFrequency omega_nom=2*pi*f_nom
    "nom angular frequency"   annotation(Evaluate=true);
    final parameter Types.AngularVelocity  w_nom=2*pi*f_nom "nom r.p.m."
                   annotation(Evaluate=true, Dialog(group="Nominal"));
    final parameter Boolean synRef=if transientSim then ref=="synchron" else true
      annotation(Evaluate=true);

    final parameter Boolean steadyIni = ini=="st"
    "steady state initialisation of electric equations"   annotation(Evaluate=true);
    final parameter Boolean transientSim = sim=="tr"
    "transient mode of electric equations"   annotation(Evaluate=true);
    final parameter Boolean steadyIni_t = steadyIni and transientSim
      annotation(Evaluate=true);
    discrete SI.Time initime;
    SI.Angle theta(final start=0, final fixed=true, stateSelect=StateSelect.always);
    SI.AngularFrequency omega(final start=2*pi*f);
  /*
  Modelica.Blocks.Interfaces.RealInput omega_inp(min=0)
    "system ang frequency (optional, fType=sig)"
    annotation (extent=[90,-10; 110,10],    rotation=-180);

  Removed, since not input connector of inner/outer class not allowed in Modelica 3.
*/
    Interfaces.Frequency receiveFreq
    "receives weighted frequencies from generators"
     annotation (Placement(transformation(extent={{-96,64},{-64,96}}, rotation=0)));
  equation
    when initial() then
      initime = time;
    end when;
    if fType_par then
      omega = 2*pi*f;
      /*
   elseif fType == Types.FreqType.sig then
     omega = omega_inp;
     Removed, since input connector of inner/outer class not allowed in Modelica 3
    */
    else
      omega = if initial() then 2*pi*f else receiveFreq.w_H/receiveFreq.H;
      when (omega < 2*pi*f_lim[1]) or (omega > 2*pi*f_lim[2]) then
        terminate("FREQUENCY EXCEEDS BOUNDS!");
      end when;
    end if;
    der(theta) = omega;
    // set dummy values (to achieve balanced model)
    receiveFreq.h = 0.0;
    receiveFreq.w_h = 0.0;
    annotation (
    preferedView="info",
    defaultComponentName="system",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"system\" component is defined.
    Drag PowerSystems.System into the top level of your model.",
    Window(
      x=0.13,
      y=0.1,
      width=0.81,
      height=0.83),
    Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,120,120},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,100},{100,60}},
            lineColor={0,120,120},
            fillColor={0,120,120},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-60,100},{100,60}},
            lineColor={215,215,215},
            textString =                      "%name"),
          Text(
            extent={{-100,50},{100,20}},
            lineColor={0,0,0},
            textString =                      "f_nom=%f_nom"),
          Text(
            extent={{-100,-20},{100,10}},
            lineColor={0,0,0},
            textString=
               "f par:%fType_par"),
          Text(
            extent={{-100,-30},{100,-60}},
            lineColor={0,120,120},
            textString=
               "%ref"),
          Text(
            extent={{-100,-70},{100,-100}},
            lineColor={176,0,0},
            textString =                         "ini:%ini  sim:%sim")}),
    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
    Documentation(info="<html>
<p>The model <b>System</b> represents a global reference for the following purposes:</p>
<p>It allows the choice of </p>
<ul>
<li> nominal frequency (default 50 or 60 Hertz, but arbitrary positive choice allowed)
<li> system frequency or initial system frequency, depending on frequency type</li>
<li> frequency type: parameter, signal, or average (machine-dependent) system frequency</li>
<li> lower and upper limit-frequencies</li>
<li> common phase angle for AC-systems</li>
<li> synchronous or inertial reference frame for AC-3phase-systems</li>
<li> transient or steady-state initialisation and simulation modes<br>
     For 'transient' initialisation no specific initial equations are defined.<br>
     This case allows also to use Dymola's steady-state initialisation, that is DIFFERENT from ours.<br>
     <b>Note:</b> the parameter 'sim' only affects AC three-phase components.</li>
</ul>
<p>It provides</p>
<ul>
<li> the system angular-frequency omega<br>
     For frequency-type 'parameter' this is simply a parameter value.<br>
     For frequency-type 'signal' it is a positive input signal.<br>
     For frequency-type 'average' it is a weighted average over the relevant generator frequencies.
<li> the system angle theta by integration of
<pre> der(theta) = omega </pre><br>
     This angle allows the definition of a rotating electrical <b>coordinate system</b><br>
     for <b>AC three-phase models</b>.<br>
     Root-nodes defining coordinate-orientation will choose a reference angle theta_ref (connector-variable theta[2]) according to the parameter <tt>ref</tt>:<br><br>
     <tt>theta_ref = theta if ref = \"synchron\"</tt> (reference frame is synchronously rotating with theta).<br>
     <tt>theta_ref = 0 if ref = \"inertial\"</tt> (inertial reference frame, not rotating).<br>

     where<br>
     <tt>theta = 1 :</tt> reference frame is synchronously rotating.<br>
     <tt>ref=0 :</tt> reference frame is at rest.<br>
     Note: Steady-state simulation is only possible for <tt>ref = \"synchron\"</tt>.<br><br>
     <tt>ref</tt> is determined by the parameter <tt>refFrame</tt> in the following way:

     </li>
</ul>
<p><b>Note</b>: Each model using <b>System</b> must use it with an <b>inner</b> declaration and instance name <b>system</b> in order that it can be accessed from all objects in the model.<br>When dragging the 'System' from the package browser into the diagram layer, declaration and instance name are automatically generated.</p>
<p><a href=\"Spot3.UsersGuide.Overview\">up users guide</a></p>
</html>
"));
  end System;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    package Spot "Examples from Modelica Power Systems Library Spot"
      extends Modelica.Icons.ExamplesPackage;

      package AC3ph "AC 3-phase components dqo"
        extends Modelica.Icons.ExamplesPackage;

        model Transformer "Transformer"

          inner PowerSystems.System system
            annotation (Placement(transformation(extent={{-80,60},{-60,80}}, rotation=
                   0)));
          /*
          PowerSystems.Blocks.Signals.TransientPhasor transPh
                          annotation (Placement(transformation(extent={{-100,10},{-80,
                    30}}, rotation=0)));
          PowerSystems.AC3ph.Sources.Voltage voltage(scType_par=false)
            annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
                  rotation=0)));
          PowerSystems.AC3ph.Sensors.PVImeter meter1
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
                  rotation=0)));*/
          replaceable PowerSystems.AC3ph.Transformers.TrafoStray trafo(par(
            v_tc1={1,1.1},
            v_tc2={1,1.2},
            V_nom={1,10}),
            redeclare PowerSystems.AC3ph.Ports.Topology.Y top_p "Y",
            redeclare PowerSystems.AC3ph.Ports.Topology.Delta top_n "Delta")
                                 annotation (Placement(transformation(extent={{0,-10},
                    {20,10}}, rotation=0)));
          /*
          PowerSystems.AC3ph.Sensors.PVImeter meter2(V_nom=10)
            annotation (Placement(transformation(extent={{50,-10},{70,10}}, rotation=
                    0)));
          PowerSystems.AC3ph.ImpedancesYD.Resistor res(V_nom=10, r=100)
                                                 annotation (Placement(transformation(
                  extent={{80,-10},{100,10}}, rotation=0)));
          PowerSystems.Control.Relays.TapChangerRelay TapChanger(
            preset_1={0,1,2},
            preset_2={0,1,2},
            t_switch_1={0.9,1.9},
            t_switch_2={1.1,2.1})
            annotation (Placement(transformation(
                origin={10,60},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          PowerSystems.AC3ph.Nodes.GroundOne grd annotation (Placement(transformation(
                  extent={{-80,-10},{-100,10}}, rotation=0)));

        equation
          connect(transPh.y, voltage.vPhasor)
                                          annotation (Line(points={{-80,20},{-64,20},
                  {-64,10}}, color={0,0,127}));
          connect(voltage.term, meter1.term_p) annotation (Line(points={{-60,0},{-50,
                  0}}, color={0,110,110}));
          connect(meter1.term_n, trafo.term_p)
            annotation (Line(points={{-30,0},{0,0}}, color={0,110,110}));
          connect(trafo.term_n, meter2.term_p)
            annotation (Line(points={{20,0},{50,0}}, color={0,110,110}));
          connect(meter2.term_n, res.term)
            annotation (Line(points={{70,0},{80,0}}, color={0,110,110}));
          connect(grd.term, voltage.neutral)
            annotation (Line(points={{-80,0},{-80,0}}, color={0,0,255}));
          connect(TapChanger.tap_p, trafo.tap_p)
            annotation (Line(points={{6,50},{6,10}}, color={255,127,0}));
          connect(TapChanger.tap_n, trafo.tap_n) annotation (Line(points={{14,50},{14,
                  10}}, color={255,127,0}));
          annotation (
            Documentation(
                    info="<html>
</html>
"),         Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
            Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
            Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
            experiment(StopTime=3),
            experimentSetupOutput); */
        end Transformer;
        annotation (preferedView="info",
      Window(
        x=0.05,
        y=0.41,
        width=0.4,
        height=0.42,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<p>This package contains small models for testing single components from ACdqo.
The replaceable component can be replaced by a user defined component of similar type.</p>
<p><a href=\"PowerSystems.UsersGuide.Examples\">up users guide</a></p>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
                    preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.41,
        width=0.4,
        height=0.42,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<pre>
Models for testing components from PowerSystems.AC3ph.
</pre>
</html>
"),       Icon);
      end AC3ph;
    annotation (
     classOrder={"Data","*"},
    Documentation(info="<html>
<h3><font color=\"#000080\" size=5>Modelica Power Systems Library SPOT: Examples</font></h3>
<p><a href=\"PowerSystems.UsersGuide\">up users guide</a></p>
<p>Copyright &copy; 2004-2008, H.J. Wiesmann.</p>
<p><i>This Modelica package is free software and the use is completely at your own risk. It can be redistributed and/or modified under the terms of the Modelica License 2.<br>
For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i><br></p>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i></p>
</html>"));
    end Spot;
  end Examples;

  package PhaseSystems "Phase systems used in power connectors"
    extends Modelica.Icons.Package;
    import SI = Modelica.SIunits;
    import Modelica.Constants.pi;

    partial package PartialPhaseSystem "Base package of all phase systems"
      extends Modelica.Icons.Package;
      constant String phaseSystemName = "UnspecifiedPhaseSystem";
      constant Integer n "Number of independent voltage and current components";
      constant Integer m "Number of reference angles";

      type Voltage = Real(unit = "V", quantity = "Voltage." + phaseSystemName)
      "voltage for connector";
      type Current = Real(unit = "A", quantity = "Current." + phaseSystemName)
      "current for connector";
      type ReferenceAngle "Reference angle for connector"
        extends SI.Angle;

        function equalityConstraint
          input ReferenceAngle theta1[:];
          input ReferenceAngle theta2[:];
          output Real[0] residue "No constraints";
        algorithm
          for i in 1:size(theta1, 1) loop
            assert(abs(theta1[i] - theta2[i]) < Modelica.Constants.eps, "angles theta1 and theta2 not equal over connection!");
          end for;
        end equalityConstraint;
      end ReferenceAngle;

      replaceable partial function j "Return vector rotated by 90 degrees"
        extends Modelica.Icons.Function;
        input Real x[n];
        output Real y[n];
      end j;

      replaceable function jj "Vectorized version of j"
        input Real[:,:] xx "array of voltage or current vectors";
        output Real[size(xx,1),size(xx,2)] yy "array of rotated vectors";
      algorithm
        //yy := {j(xx[:,k]) for k in 1:size(xx,2)};
        // Note: Dymola 2013 fails to expand
        for k in 1:size(xx,2) loop
          yy[:,k] := j(xx[:,k]);
        end for;
      end jj;

      replaceable partial function thetaRel
      "Return absolute angle of rotating system as offset to thetaRef"
        input SI.Angle theta[m];
        output SI.Angle thetaRel;
      end thetaRel;

      replaceable partial function thetaRef
      "Return absolute angle of rotating reference system"
        input SI.Angle theta[m];
        output SI.Angle thetaRef;
      end thetaRef;

      replaceable partial function phase "Return phase"
        extends Modelica.Icons.Function;
        input Real x[n];
        output SI.Angle phase;
      end phase;

      replaceable partial function phaseVoltages
      "Return phase to neutral voltages"
        extends Modelica.Icons.Function;
        input SI.Voltage V "system voltage";
        input SI.Angle phi = 0 "phase angle";
        output SI.Voltage v[n] "phase to neutral voltages";
      end phaseVoltages;

      replaceable partial function phaseCurrents "Return phase currents"
        extends Modelica.Icons.Function;
        input SI.Current I "system current";
        input SI.Angle phi = 0 "phase angle";
        output SI.Current i[n] "phase currents";
      end phaseCurrents;

      replaceable partial function phasePowers "Return phase powers"
        extends Modelica.Icons.Function;
        input SI.ActivePower P "active system power";
        input SI.Angle phi = 0 "phase angle";
        output SI.Power p[n] "phase powers";
      end phasePowers;

      replaceable partial function phasePowers_vi "Return phase powers"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n] "phase voltages";
        input SI.Current i[n] "phase currents";
        output SI.Power p[n] "phase powers";
      end phasePowers_vi;

      replaceable partial function systemVoltage
      "Return system voltage as function of phase voltages"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n];
        output SI.Voltage V;
      end systemVoltage;

      replaceable partial function systemCurrent
      "Return system current as function of phase currents"
        extends Modelica.Icons.Function;
        input SI.Current i[n];
        output SI.Current I;
      end systemCurrent;

      replaceable partial function activePower
      "Return total power as function of phase powers"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n] "phase voltages";
        input SI.Current i[n] "phase currents";
        output SI.ActivePower P "active system power";
      end activePower;

      annotation (Icon(graphics));
    end PartialPhaseSystem;

    package ThreePhase_dqo "AC system in dqo representation"
      extends PartialPhaseSystem(phaseSystemName="ThreePhase_dqo", n=3, m=2);

      redeclare function j
      "Rotation(pi/2) of vector around {0,0,1} and projection on orth plane"
        extends Modelica.Icons.Function;
        input Real x[:];
        output Real y[size(x,1)];
      algorithm
        y := cat(1, {-x[2], x[1]}, zeros(size(x,1)-2));
      end j;

      redeclare function jj "Vectorized version of j"
        input Real[:,:] xx "array of voltage or current vectors";
        output Real[size(xx,1),size(xx,2)] yy "array of rotated vectors";
      algorithm
        yy := cat(1, {-xx[2,:], xx[1,:]}, zeros(size(xx,1)-2, size(xx,2)));
      end jj;

      redeclare function thetaRel
      "Return absolute angle of rotating system as offset to thetaRef"
        input SI.Angle theta[m];
        output SI.Angle thetaRel;
      algorithm
        thetaRel := theta[1];
      end thetaRel;

      redeclare function thetaRef
      "Return absolute angle of rotating reference system"
        input SI.Angle theta[m];
        output SI.Angle thetaRef;
      algorithm
        thetaRef := theta[2];
      end thetaRef;

      redeclare function phase "Return phase"
        extends Modelica.Icons.Function;
        input Real x[n];
        output SI.Angle phase;
      algorithm
        phase := atan2(x[2], x[1]);
      end phase;

      redeclare function phaseVoltages "Return phase to neutral voltages"
        extends Modelica.Icons.Function;
        input SI.Voltage V "system voltage";
        input SI.Angle phi = 0 "phase angle";
        output SI.Voltage v[n] "phase to neutral voltages";
    protected
        Voltage neutral_v = 0;
      algorithm
        v := {V*cos(phi), V*sin(phi), sqrt(3)*neutral_v}/sqrt(3);
      end phaseVoltages;

      redeclare function phaseCurrents "Return phase currents"
        extends Modelica.Icons.Function;
        input Current I "system current";
        input SI.Angle phi = 0 "phase angle";
        output SI.Current i[n] "phase currents";
      algorithm
        i := {I*cos(phi), I*sin(phi), 0};
      end phaseCurrents;

      redeclare function phasePowers "Return phase powers"
        extends Modelica.Icons.Function;
        input SI.ActivePower P "active system power";
        input SI.Angle phi = 0 "phase angle";
        output SI.Power p[n] "phase powers";
      algorithm
        p := {P, P*tan(phi), 0};
      end phasePowers;

      redeclare function phasePowers_vi "Return phase powers"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n] "phase voltages";
        input SI.Current i[n] "phase currents";
        output SI.Power p[n] "phase powers";
      algorithm
        p := {v[1:2]*i[1:2], -j(v[1:2])*i[1:2], v[3]*i[3]};
      end phasePowers_vi;

      redeclare function systemVoltage
      "Return system voltage as function of phase voltages"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n];
        output SI.Voltage V;
      algorithm
        V := sqrt(v*v);
      end systemVoltage;

      redeclare function systemCurrent
      "Return system current as function of phase currents"
        extends Modelica.Icons.Function;
        input SI.Current i[n];
        output SI.Current I;
      algorithm
        I := sqrt(i*i);
      end systemCurrent;

      redeclare function activePower
      "Return total power as function of phase powers"
        extends Modelica.Icons.Function;
        input SI.Voltage v[n] "phase voltages";
        input SI.Current i[n] "phase currents";
        output SI.ActivePower P "active system power";
      algorithm
        P := v[1]*i[1];
      end activePower;

      annotation (Icon(graphics={
            Line(
              points={{-70,28},{-58,48},{-38,68},{-22,48},{-10,28},{2,8},{22,-12},
                  {40,8},{50,28}},
              color={95,95,95},
              smooth=Smooth.Bezier),
            Line(
              points={{-70,-54},{50,-54}},
              color={95,95,95},
              smooth=Smooth.None),
            Line(
              points={{-70,-78},{50,-78}},
              color={95,95,95},
              smooth=Smooth.None),
            Line(
              points={{-70,-28},{50,-28}},
              color={95,95,95},
              smooth=Smooth.None)}));
    end ThreePhase_dqo;
    annotation (Icon(graphics={Line(
            points={{-70,-52},{50,-52}},
            color={95,95,95},
            smooth=Smooth.None), Line(
            points={{-70,8},{-58,28},{-38,48},{-22,28},{-10,8},{2,-12},{22,-32},{
                40,-12},{50,8}},
            color={95,95,95},
            smooth=Smooth.Bezier)}));
  end PhaseSystems;

  package AC3ph "AC three phase components from Spot ACdqo"
    extends Modelica.Icons.VariantsPackage;

    package ImpedancesYD
    "Impedance and admittance one terminal, Y and Delta topology"
      extends Modelica.Icons.VariantsPackage;

      model Resistor "Resistor, 3-phase dqo"
        extends Partials.ImpedYDBase(final f_nom=0, final stIni_en=false);

        parameter SIpu.Resistance r=1 "resistance";
    protected
        final parameter SI.Resistance R=r*Basic.Precalculation.baseR(puUnits, V_nom, S_nom, top.scale);

      equation
        R*i = v;
        annotation (
          defaultComponentName="resYD1",
      Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
      Documentation(
              info="<html>
<p>Info see package ACdqo.ImpedancesYD.</p>
</html>
"),   Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Rectangle(
                extent={{-80,30},{70,-30}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255})}),
      Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{-70,20},{30,13}},
                lineColor={0,0,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,3},{30,-4}},
                lineColor={0,0,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-70,-13},{30,-20}},
                lineColor={0,0,255},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end Resistor;

      package Partials "Partial models"
        extends Modelica.Icons.BasesPackage;

        partial model ImpedYDBase "One terminal impedance base, 3-phase dqo"
          extends Ports.YDport_p;
          extends Basic.Nominal.NominalAC;

          parameter Boolean stIni_en=true
          "enable steady-state initial equation"                               annotation(evaluate=true);
          parameter SIpu.Resistance r_n=1 "resistance neutral to grd"
            annotation(Dialog(enable));
      protected
          final parameter Boolean steadyIni_t=system.steadyIni_t and stIni_en;
          final parameter SI.Resistance R_n=r_n*Basic.Precalculation.baseR(puUnits, V_nom, S_nom);
          SI.AngularFrequency[2] omega;

        equation
          omega = der(term.theta);
          v_n = R_n*i_n "equation neutral to ground (if Y-topology)";
          annotation (
            Window(
              x=0.45,
              y=0.01,
              width=0.44,
              height=0.65),
            Documentation(
          info="<html>
<p>Y-topology: contains an equation for neutral to ground</p>
<p>Delta-topology: <tt>i[3] = 0</tt></p>
</html>"),  Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{70,20},{76,-20}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid)}),
            Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{70,30},{80,-30}},
                  lineColor={135,135,135},
                  lineThickness=0.5,
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid)}));
        end ImpedYDBase;
        annotation (            Window(
            x=0.05,
            y=0.44,
            width=0.31,
            height=0.23,
            library=1,
            autolayout=1));
      end Partials;
    annotation (preferedView="info",
        Window(
    x=0.05,
    y=0.41,
    width=0.4,
    height=0.44,
    library=1,
    autolayout=1),
        Documentation(info="<html>
<p>Contains lumped impedance models for Y and Delta topology.</p>
<p>General relations see 'Impedances'.</p>
<p>All elements allow the choice between Y- and Delta-topology.<br>
The impedance parameters are defined 'as seen from the terminals', directly relating terminal voltage and terminal current. With this definition same parameters lead to same network properties, independent of topology. The necessary scaling is performed automatically.</p>
<p>In Delta-topology the conductor voltage is sqrt(3) higher, the current sqrt(3) lower,
compared to the terminal voltage and current. Therefore the impedance relating conductor current and voltage is a factor 3 larger, the admittance a factor 1/3 smaller than the impedance and admittance as seen from the terminal.</p>
<p>If impedance parameters are known for the WINDINGS, choose:</p>
<pre>  input values impedance parameters = (winding values of impedance parameters)/3</pre>
<p>In dqo-representation the following relations hold between<br>
terminal-voltage term.v and -current term.i on the one hand<br>
and conductor-voltage v and -current i on the other:</p>
<p><b>Y-topology</b>:</p>
<pre>
  v = term.v - {0, 0, sqrt(3)*v_n}: voltage between terminal and neutral point
  term.i = i
  i_n = sqrt(3)*term.i[3]
</pre>
<p><b>Delta-topology</b>:</p>
<pre>
  v[1:2] = sqrt(3)*R30*term.v[1:2]: voltage between phase-terminals
  v[3] = 0
  term.i[1:2] = sqrt(3)*transpose(R30)*i[1:2]
  term.i[3] = 0
</pre>
<p>with <tt>R30 = rotation_30deg</tt><br>
(Alternative solutions corresponding to permuted phases are <tt>R-90</tt> and <tt>R150</tt> instead of <tt>R30</tt>).</p>
</html>"),
      Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end ImpedancesYD;

    package Nodes "Nodes and adaptors"
      extends Modelica.Icons.VariantsPackage;

      model GroundOne "Ground, one conductor"

        Interfaces.Electric_p term "positive scalar terminal"
                                   annotation (Placement(transformation(extent={{
                  -110,-10},{-90,10}}, rotation=0)));

      equation
        term.v = 0;
        annotation (
          defaultComponentName="grd1",
      Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
      Documentation(
              info="<html>
<p>Zero voltage on terminal.</p>
</html>
"),   Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Text(
                extent={{-100,-90},{100,-130}},
                lineColor={0,0,0},
                textString=
             "%name"),
              Rectangle(
                extent={{-4,50},{4,-50}},
                lineColor={128,128,128},
                fillColor={160,160,164},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{-4,0}}, color={0,0,255})}),
      Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Line(points={{-60,0},{-80,0}}, color={0,0,255}),
                Rectangle(
                extent={{-60,20},{-54,-20}},
                lineColor={128,128,128},
                fillColor={160,160,164},
                fillPattern=FillPattern.Solid)}));
      end GroundOne;
    annotation (preferedView="info",
        Window(
    x=0.05,
    y=0.41,
    width=0.4,
    height=0.32,
    library=1,
    autolayout=1),
        Documentation(info="<html>
</html>
"),   Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Nodes;

    package Transformers "Transformers 3-phase"
      extends Modelica.Icons.VariantsPackage;

      model TrafoStray "Ideal magnetic coupling transformer, 3-phase dqo"
        extends Partials.TrafoStrayBase;

      initial equation
        if steadyIni_t then
          der(i1) = omega[1]*j_dqo(i1);
        end if;

      equation
        i1 + i2 = zeros(3);
        if system.transientSim then
          diagonal({sum(L),sum(L),sum(L0)})*der(i1) + omega[2]*sum(L)*j_dqo(i1) + sum(R)
          *i1 = v1 - v2;
        else
          omega[2]*sum(L)*j_dqo(i1) + sum(R)*i1 = v1 - v2;
        end if;
        annotation (
          defaultComponentName="trafo",
      Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
      Documentation(
              info="<html>
<p>Stray-impedance, but ideal magnetic coupling, i.e. zero magnetisation current.<br>
Delta topology: impedance is defined as winding-impedance (see info package Transformers).</p>
<p>SI-input: values for stray and coupling impedances are winding dependent.</p>
<pre>
  r[k]  = R[k]
  x[k]  = omega_nom*L[k]
  x0[k] = omega_nom*L0[k]
</pre>
<p>pu-input: values for stray and coupling impedances are <b>winding</b>-reduced to primary side.</p>
<pre>
  r[k]  = R[k]/R_nom[k]
  x[k]  = omega_nom*L[k]/R_nom[k]
  x0[k] = omega_nom*L0[k]/R_nom[k]
</pre>
<p>with</p>
<pre>  R_nom[k] = V_nom[k]^2/S_nom,  k = 1(primary), 2(secondary)</pre>
</html>"),
      Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
      Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end TrafoStray;

      package Partials "Partial models"
        extends Modelica.Icons.BasesPackage;

          partial model TrafoIdealBase
        "Base for ideal transformer, 3-phase dqo"

            /*
  extends Ports.YDportTrafo_p_n(
    w1(start=w1_set), w2(start=w2_set),
    final term_p(v(start={cos(system.alpha0),sin(system.alpha0),0}*par.V_nom[1])),
    final term_n(v(start={cos(system.alpha0),sin(system.alpha0),0}*par.V_nom[2])));

  Start values not correct since no parameter expressions;
  Can be removed without having an effect on the model since
  if dynTC=true, w1,w2 are initialized in the initial equation section and
  otherwise, there is an algebraic equation for w1 and w2.
  */
            extends Ports.YDportTrafo_p_n(
              final term_p(v(start={cos(system.alpha0),sin(system.alpha0),0}*par.V_nom[1])),
              final term_n(v(start={cos(system.alpha0),sin(system.alpha0),0}*par.V_nom[2])));

            parameter Boolean stIni_en=true
          "enable steady-state initial equation"                                 annotation(evaluate=true, choices(__Dymola_checkBox=true));
            parameter Boolean dynTC=false "enable dynamic tap-changing" annotation(evaluate=true, choices(__Dymola_checkBox=true));

            parameter Boolean use_tap_p = false
          "= true, if input tap_p is enabled"
                                annotation(evaluate=true, choices(__Dymola_checkBox=true));
            parameter Boolean use_tap_n = false
          "= true, if input tap_n is enabled"
                                annotation(evaluate=true, choices(__Dymola_checkBox=true));

            Modelica.Blocks.Interfaces.IntegerInput tap_p if use_tap_p
          "1: index of voltage level"
              annotation (Placement(transformation(
                origin={-40,100},
                extent={{-10,-10},{10,10}},
                rotation=270)));
            Modelica.Blocks.Interfaces.IntegerInput tap_n if use_tap_n
          "2: index of voltage level"
              annotation (Placement(transformation(
                origin={40,100},
                extent={{-10,-10},{10,10}},
                rotation=270)));

            replaceable parameter Parameters.TrafoIdeal par
                    constrainedby Parameters.TrafoIdeal "trafo parameter"
                                      annotation (Placement(transformation(extent={
                    {-80,60},{-60,80}}, rotation=0)));
      protected
            Modelica.Blocks.Interfaces.IntegerInput tap_p_internal
          "Needed to connect to conditional connector";
            Modelica.Blocks.Interfaces.IntegerInput tap_n_internal
          "Needed to connect to conditional connector";

            outer System system;
            constant Real tc=0.01 "time constant tap-chg switching";
            final parameter Boolean steadyIni_t=system.steadyIni_t and stIni_en;
            final parameter SI.Voltage[2] V_base=Basic.Precalculation.baseTrafoV(par.puUnits, par.V_nom);
            final parameter SI.Resistance[2, 2] RL_base=Basic.Precalculation.baseTrafoRL(par.puUnits, par.V_nom, par.S_nom, 2*pi*par.f_nom);
            final parameter Real W_nom=par.V_nom[2]/par.V_nom[1]
              annotation(Evaluate=true);
            final parameter Real[:] W1=cat(1, {1}, par.v_tc1*V_base[1]/par.V_nom[1])*sqrt(scale[1])
              annotation(evaluate=true);
            final parameter Real[:] W2=cat(1, {1}, par.v_tc2*V_base[2]/par.V_nom[2])*W_nom*sqrt(scale[2])
              annotation(evaluate=true);
            final parameter SI.Resistance R_n1=par.r_n1*RL_base[1,1];
            final parameter SI.Resistance R_n2=par.r_n2*RL_base[2,1];
            SI.AngularFrequency[2] omega;
            Real w1_set=if not use_tap_p then W1[1] else W1[1 + tap_p_internal]
          "1: set voltage ratio to nominal primary";
            Real w2_set=if not use_tap_n then W2[1] else W2[1 + tap_n_internal]
          "2: set voltage ratio to nominal secondary";

          initial equation
            if dynTC then
              w1 = w1_set;
              w2 = w2_set;
            end if;

          equation
            connect(tap_p, tap_p_internal);
            connect(tap_n, tap_n_internal);
            if not use_tap_p then
               tap_p_internal = 0;
            end if;
            if not use_tap_n then
               tap_n_internal = 0;
            end if;

            omega = der(term_p.theta);
            if system.transientSim and dynTC then
              der(w1) + (w1 - w1_set)/tc = 0;
              der(w2) + (w2 - w2_set)/tc = 0;
            else
              w1 = w1_set;
              w2 = w2_set;
            end if;

            v_n1 = R_n1*i_n1
          "1: equation neutral to ground (relevant if Y-topology)";
            v_n2 = R_n2*i_n2
          "2: equation neutral to ground (relevant if Y-topology)";
            annotation (
              Window(
                x=0.45,
                y=0.01,
                width=0.44,
                height=0.65),
              Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-80,60},{40,-60}},
                  lineColor={44,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-40,60},{80,-60}},
                  lineColor={0,120,120},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-80,60},{40,-60}},
                  lineColor={0,120,120},
                  lineThickness=0.5),
                Text(
                  extent={{-120,80},{-80,40}},
                  lineColor={0,0,0},
                  textString="1"),
                Text(
                  extent={{80,80},{120,40}},
                  lineColor={0,0,0},
                  textString="2"),
                Line(
                  points={{-80,0},{-40,0}},
                  color={176,0,0},
                  thickness=0.5),
                Line(
                  points={{40,0},{80,0}},
                  color={176,0,0},
                  thickness=0.5)}),
              Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Rectangle(
                  extent={{-20,60},{-14,-60}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{14,60},{20,-60}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Line(points={{-40,0},{-40,-80}}, color={0,0,255}),
                Line(points={{40,0},{40,-80}}, color={0,0,255}),
                Rectangle(
                  extent={{-50,-80},{-30,-84}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{30,-80},{50,-84}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid)}),
              Documentation(
              info="<html>
<p>Terminology (formal, the models are symmetric).<br>
&nbsp; - index 1 (term_p)     \"primary\"<br>
&nbsp; - index 2 (term_n)     \"secondary\"</p>
<p>Contains choice of topology (Delta or Y connection primary and secondary).<br>
Note that transformers with topology 'Delta-Y' and 'Y-Delta' exhibit a phase-shift
of the voltage signals Delta-side versus the signals Y-side of -30 deg.<br>
&nbsp; Delta (prim) - Y (sec): Y is 30 deg shifted versus Delta<br>
&nbsp; Y (prim) - Delta (sec): Delta is -30 deg shifted versus Y<br>
&nbsp; Setting the parameter <tt>sh = +-1</tt> shifts the secondary side by <tt>+-120 deg</tt>.</p>
<p>Transformer ratio.<br>
The winding ratio is determined indirectly by the choice of nominal voltages and the topology of both primary and secondary side.<br>
It may be &gt 1 or &lt 1.</p>
<p>Tap changers.<br>
For constant transformer ratio no tap changer input needed.<br>
For variable transformer ratio tap changer input needed.</p>
<p>The sequence of the parameters</p>
<pre>  v_tc     tc voltage levels v_tc[1], v_tc[2], v_tc[3], ...</pre>
<p>must be defined in accordance with the input-signals of </p>
<pre>  tap     index of tap voltage levels, v_tc[tap]</pre>
<p>Set <tt>dynTC = true</tt> if tap-index changes during simulation.</p>
</html>"));
          end TrafoIdealBase;

        partial model TrafoStrayBase
        "Base for ideal magnetic coupling transformer, 3-phase dqo"
          extends TrafoIdealBase(redeclare replaceable parameter
            PowerSystems.AC3ph.Transformers.Parameters.TrafoStray par)
            annotation (extent=[-80,60; -60,80], Placement(transformation(extent={{
                    -80,60},{-60,80}}, rotation=0)));
      protected
          final parameter SI.Resistance[2] R=par.r.*RL_base[:, 1];
          final parameter SI.Inductance[2] L=par.x.*RL_base[:, 2];
          final parameter SI.Inductance[2] L0=par.x0.*RL_base[:, 2];
          annotation (
            Window(
        x=0.45,
              y=0.01,
              width=0.44,
        height=0.65),
            Documentation(
            info="<html>
<p>Precalculation of coefficients for ideal magnetic coupling transformer</p>
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{-10,62},{10,-62}},
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{-26,60},{-20,-60}},
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid), Rectangle(
                  extent={{20,60},{26,-60}},
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid)}));
        end TrafoStrayBase;
        annotation (            Window(
            x=0.05,
            y=0.44,
            width=0.31,
            height=0.32,
            library=1,
            autolayout=1));
      end Partials;

    package Parameters "Parameter data for interactive use"
      extends Modelica.Icons.MaterialPropertiesPackage;

    record TrafoIdeal "Parameters for ideal transformer, 3-phase"
      parameter SIpu.Voltage[:] v_tc1=fill(1, 0) "1: v-levels tap-changer"
                                  annotation(Dialog(group="Options"));
      parameter SIpu.Voltage[:] v_tc2=fill(1, 0) "2: v-levels tap-changer"
                                  annotation(Dialog(group="Options"));
      extends Basic.Nominal.NominalDataTrafo;
      parameter SIpu.Resistance r_n1=1 "1: resistance neutral to grd (if Y)";
      parameter SIpu.Resistance r_n2=1 "2: resistance neutral to grd (if Y)";
      annotation (defaultComponentName="data",
        Window(
    x=0.45,
          y=0.01,
          width=0.44,
    height=0.65),
        Documentation(
        info="<html>
</html>"),
        Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
        Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
    end TrafoIdeal;

    record TrafoStray
      "Parameters for ideal magnetic coupling transformer, 3-phase"
      extends TrafoIdeal;
      parameter SIpu.Resistance[2] r={0.05,0.05} "{1,2}: resistance";
      parameter SIpu.Reactance[2] x={0.05,0.05} "{1,2}: stray reactance";
      parameter SIpu.Reactance[2] x0={x[1],x[2]}
        "{1,2}: stray reactance zero-comp";

      annotation (defaultComponentName="data",
        Window(
    x=0.45,
          y=0.01,
          width=0.44,
    height=0.65),
        Documentation(
        info="<html>
</html>"),
        Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
        Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
    end TrafoStray;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.38,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>Records containing parameters of the corresponding components.</p>
</html>"),
        Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end Parameters;
    annotation (preferedView="info",
        Window(
    x=0.05,
    y=0.41,
    width=0.4,
    height=0.32,
    library=1,
    autolayout=1),
        Documentation(info="<html>
<p>Transformer models in different abstraction levels.</p>
<p>All transformers allow the choice between Y- and Delta-topology both at primary and secondary side.<br>
For Delta an additional phase-shift may be chosen in order to adapt to a given phase-numbering scheme.<br>
The impedance parameters are defined 'as seen from the terminals', directly relating terminal voltage and terminal current. With this definition same parameters lead to same network properties, independent of topology. The necessary scaling is performed automatically.</p>
<p>In Delta-topology the conductor voltage is sqrt(3) higher, the current sqrt(3) lower,
compared to the terminal voltage and current. Therefore the impedance relating conductor current and voltage is a factor 3 larger, the admittance a factor 1/3 smaller than the impedance and admittance as seen from the terminal.</p>
<p>If impedance parameters are given for the Deta-connected WINDINGS, choose:</p>
<pre>  input values impedance parameters = 1/3 * (impedance parameters of windings)</pre>
<p>In the dqo-representation the following relations hold between terminal-voltage <tt>v_term</tt> and -current <tt>i_term</tt> on the one hand and conductor-voltage <tt>v_cond</tt> and -current <tt>i_cond</tt> on the other.</p>
<p>A) Y-topology.</p>
<pre>
  v_cond = v_term - {0, 0, sqrt(3)*v_n};
  i_term = i_cond;
  i_n = sqrt(3)*i_term[3];
</pre>
<p>where <tt>v_n</tt> denotes the voltage at the neutral point and <tt>i_n</tt> the current neutral to ground.</p>
<p>B) Delta-topology.</p>
<pre>
  v_cond[1:2] = sqrt(3)*R30*v_term[1:2];
  i_term[1:2] = sqrt(3)*transpose(R30)*i_cond[1:2];
  v_cond[3] = 0;
  i_term[3] = 0;
</pre>
<p>where <tt>R30</tt> denotes a rotation by 30deg in positive sense.<br>
(Alternative solutions corresponding to permuted phases are <tt>R-90</tt> and <tt>R150</tt> instead of <tt>R30</tt>).</p>
<p>The winding scaled voltage- and current-variables <tt>v</tt> and <tt>i</tt> are related to the corresponding conductor quantities through the relation:
<pre>
  v = v_cond/w
  i = i_cond*w
</pre>
The equations are written in winding-scaled form.</p>
</html>
"),   Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Transformers;

    package Sensors "Sensors and meters 3-phase"
      extends Modelica.Icons.SensorsPackage;

      model PVImeter "Power-voltage-current meter, 3-phase dqo"
        extends Partials.Meter2Base;

        parameter Boolean av=false "time average power"  annotation(evaluate=true,Dialog(group="Options"));
        parameter SI.Time tcst(min=1e-9)=1 "average time-constant"
                                                        annotation(Evaluate=true, Dialog(group="Options",enable=av));

        output SIpu.Power[3] p(each stateSelect=StateSelect.never);
        output SIpu.Power[3] p_av=pav if av;
        output SIpu.Voltage[3] v(each stateSelect=StateSelect.never);
        output SIpu.Voltage[2] vpp(each stateSelect=StateSelect.never);
        output SIpu.Current[3] i(each stateSelect=StateSelect.never);

        output SIpu.Voltage[3] v_abc(each stateSelect=StateSelect.never)=transpose(Park)*v if abc;
        output SIpu.Voltage[3] vpp_abc(each stateSelect=StateSelect.never)=
          {v_abc[2],v_abc[3],v_abc[1]} - {v_abc[3],v_abc[1],v_abc[2]} if abc;
        output SIpu.Current[3] i_abc(each stateSelect=StateSelect.never)=transpose(Park)*i if abc;

        output SIpu.Voltage v_norm(stateSelect=StateSelect.never)=sqrt(v*v) if phasor;
        output SI.Angle alpha_v(stateSelect=StateSelect.never)=atan2(Rot_dq[:,2]*v[1:2], Rot_dq[:,1]*v[1:2]) if phasor;
        output SIpu.Current i_norm(stateSelect=StateSelect.never)=sqrt(i*i) if phasor;
        output SI.Angle alpha_i(stateSelect=StateSelect.never)=atan2(Rot_dq[:,2]*i[1:2], Rot_dq[:,1]*i[1:2]) if phasor;
        output Real cos_phi(stateSelect=StateSelect.never)=cos(alpha_v - alpha_i) if phasor;
    protected
        outer System system;
        final parameter SI.Voltage V_base=Basic.Precalculation.baseV(puUnits, V_nom);
        final parameter SI.Current I_base=Basic.Precalculation.baseI(puUnits, V_nom, S_nom);
        SIpu.Power[3] pav;

      initial equation
        if av then
          pav = p;
        end if;

      equation
        v = term_p.v/V_base;
        vpp = sqrt(3)*{v[2],-v[1]};
        i = term_p.i/I_base;
        p = {v[1:2]*i[1:2], -j_dqo(v[1:2])*i[1:2], v[3]*i[3]};
        if av then
          der(pav) = (p - pav)/tcst;
        else
          pav = zeros(3);
        end if;
        annotation (defaultComponentName = "PVImeter1",
          Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{-20,24},{20,20}},
                lineColor={135,135,135},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-8,8},{8,-8}},
                lineColor={135,135,135},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Line(
                points={{0,0},{20,0}},
                color={0,100,100},
                thickness=0.5),
              Line(points={{-15,50},{15,64}}, color={135,135,135}),
              Line(points={{-15,40},{15,54}}, color={135,135,135}),
              Line(points={{-15,30},{15,44}}, color={135,135,135})}),
          Documentation(
                  info="<html>
<p>'Meters' are intended as diagnostic instruments. They allow displaying signals in alternative representations, both in SI-units or in 'pu'.<br>
As they use time-dependent coordinate transforms, use them only when and where needed. Otherwise use 'Sensors'.</p>
<p>Output variables in the chosen reference system:</p>
<pre>
  p         {AC active, AC reactive, DC} power term_p to term_n
  v          voltage phase-to-ground dqo
  vpp        voltage phase-to-phase dq
  i          current dqo, term_p to term_n
</pre>
<p>Optional output variables:</p>
<pre>
  p_av       power term_p to term_n, time tau average of p
  v_abc      voltage phase-to-ground,  abc-inertial system
  vpp_abc    voltage phase-to-phase,   abc-inertial system
  i_abc      current term_p to term_n, abc-inertial system
  v_norm     norm(v)
  i_norm     norm(i)
  alpha_v    phase(v)
  alpha_i    phase(i)
  cos_phi    cos(alpha_v - alpha_i)
</pre>
<p><i>Comment on the sign-definition of reactive power see</i> ACdqo.Sensors.</p>
</html>
"),       Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end PVImeter;

      package Partials "Partial models"
        extends Modelica.Icons.BasesPackage;

        partial model Sensor2Base "Sensor 2 terminal base, 3-phase dqo"
          extends Ports.Port_pn;

          parameter Integer signalTrsf=0 "signal in which reference frame?"
           annotation(Evaluate=true,Dialog(group="Options"), choices(
             choice=0 "0: actual ref frame",
             choice=1 "1: dqo synchronous",
             choice=2 "2: alpha_beta_o",
             choice=3 "3: abc inertial"));
      protected
          function park = Basic.Transforms.park;
          function rot_dq = Basic.Transforms.rotation_dq;

        equation
          term_p.v = term_n.v;
        annotation (
          Window(
            x=0.45,
            y=0.01,
            width=
          0.44,
            height=
           0.65),
          Documentation(
                info="<html>
</html>"),Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-70,70},{70,-70}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{0,20},{0,90}}, color={135,135,135}),
                Line(
                  points={{-90,0},{-20,0}},
                  color={0,100,100},
                  thickness=0.5),
                Line(
                  points={{0,0},{90,0}},
                  color={0,100,100},
                  thickness=0.5),
                Line(
                  points={{30,20},{70,0},{30,-20}},
                  color={0,100,100},
                  thickness=0.5),
                Ellipse(extent={{-20,20},{20,-20}}, lineColor={135,135,135})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
        end Sensor2Base;

        partial model Meter2Base "Meter 2 terminal base, 3-phase dqo"
          extends Sensor2Base(final signalTrsf=0);

          parameter Boolean abc=false "abc inertial"
            annotation(evaluate=true,Dialog(group="Options"));
          parameter Boolean phasor=false "phasor"  annotation(evaluate=true,Dialog(group="Options"));
          extends Basic.Nominal.Nominal;
      protected
          Real[3,3] Park = park(term_p.theta[2]) if abc;
          Real[2,2] Rot_dq = rot_dq(term_p.theta[1]) if phasor;
          function atan2 = Modelica.Math.atan2;
          annotation (
            Window(
              x=
        0.45, y=
        0.01, width=
            0.44,
              height=
             0.65),
            Documentation(
                  info="<html>
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Ellipse(extent={{-70,70},{70,-70}},
                    lineColor={135,135,135})}),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
        end Meter2Base;
        annotation (       Window(
      x=0.05,
      y=0.44,
      width=0.31,
      height=0.23,
      library=1,
      autolayout=1));
      end Partials;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.32,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>Sensors output terminal signals (voltage, current, power) in a defined reference system chosen by the user.</p>
<p>Meters allow choosing base-units for output variables.</p>
<p><i>Comment on the sign-definition of reactive power:</i></p>
<p>From a mathematical point of view, it would be desirable to define power in the following way:
<pre>
  p_active = v*i
  p_reactive = (J*v)*i
</pre>
<p>with</p>
<pre>  J = [0,-1,0; 1,0,0; 0,0,0]</pre>
<p>the rotation of pi/2 in the positive sense.</p>
<p>This definition keeps all coordinate systems positively oriented.
The power-vector then can be interpreted as current-vector, normalised by voltage and transformed into a positively oriented coordinate system, whose first axis is given by the voltage vector <tt>v</tt>, and second axis by <tt>J*v</tt>.</p>
<p>From a practical point of view it is more convenient to use the inverse sign for reactive power, in order to obtain positive reactive power in the standard-situation of power-transfer
across an inductive line.
We adapt the sign-definition to this practical convention:</p>
<pre>  p_reactive = -(J*v)*i</pre>
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Sensors;

    package Sources "Voltage and Power Sources"
      extends Modelica.Icons.SourcesPackage;

      model Voltage "Ideal voltage, 3-phase dqo"
        extends Partials.VoltageBase;

        parameter SIpu.Voltage v0=1 "voltage" annotation(Dialog(enable=scType_par));
        parameter SI.Angle alpha0=0 "phase angle" annotation(Dialog(enable=scType_par));
    protected
        SI.Voltage V;
        SI.Angle alpha;
        SI.Angle phi;

      equation
        if scType_par then
          V = v0*V_base;
          alpha = alpha0;
        else
          V = vPhasor_internal[1]*V_base;
          alpha = vPhasor_internal[2];
        end if;
        phi = term.theta[1] + alpha + system.alpha0;
        term.v = {V*cos(phi), V*sin(phi), sqrt(3)*neutral.v};
        annotation (defaultComponentName = "voltage1",
          Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65),
          Documentation(
                  info="<html>
<p>Voltage with constant amplitude and phase when 'vType' is 'parameter',<br>
with variable amplitude and phase when 'vType' is 'signal'.</p>
<p>Optional input:
<pre>
  omega           angular frequency (choose fType == \"sig\")
  vPhasor         {norm(v), phase(v)}, amplitude(v_abc)=sqrt(2/3)*vPhasor[1]
   vPhasor[1]     in SI or pu, depending on choice of 'units'
   vPhasor[2]     in rad
</pre></p>
</html>
"),       Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end Voltage;

      package Partials "Partial models"
        extends Modelica.Icons.BasesPackage;

        partial model SourceBase "Voltage base, 3-phase dqo"
          extends Ports.Port_n;
          extends Basic.Nominal.Nominal;

          Interfaces.Electric_p neutral "(use for grounding)"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
      protected
          outer System system;
          final parameter Real V_base=Basic.Precalculation.baseV(puUnits, V_nom);
          SI.Angle theta(stateSelect=StateSelect.prefer) "absolute angle";

        equation
          Connections.potentialRoot(term.theta);
          if Connections.isRoot(term.theta) then
            term.theta = if system.synRef then {0, theta} else {theta, 0};
          end if;

          sqrt(3)*term.i[3] + neutral.i = 0;
          annotation (
            Window(
              x=
        0.45, y=
        0.01, width=
            0.44,
              height=
             0.65),
            Documentation(
                  info="<html>
<p>If the connector 'neutral' remains unconnected, then the source has an isolated neutral point. In all other cases connect 'neutral' to the desired circuit or ground.</p>
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
        end SourceBase;

        partial model VoltageBase "Voltage base, 3-phase dqo"
          extends SourceBase(final S_nom=1);

          parameter Boolean fType_sys = true
          "= true, if source has system frequency"   annotation(Evaluate=true, choices(__Dymola_checkBox=true));
          parameter Boolean fType_par = true
          "= true, if source has parameter frequency, otherwise defined by input omega"
                                        annotation(Evaluate=true, Dialog(enable=not fType_sys));
          parameter SI.Frequency f=system.f "frequency"
            annotation(Dialog(enable=fType_par));

          parameter Boolean scType_par = true
          "= true: voltage defined by parameter otherwise by input signal"
           annotation(Evaluate=true, choices(__Dymola_checkBox=true));

          Modelica.Blocks.Interfaces.RealInput omega(final unit="rad/s") if not fType_par
          "ang frequency"
            annotation (Placement(transformation(
                origin={-60,100},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Modelica.Blocks.Interfaces.RealInput[2] vPhasor if not scType_par
          "({abs(voltage), phase})"
            annotation (Placement(transformation(
                origin={60,100},
                extent={{-10,-10},{10,10}},
                rotation=270)));
      protected
          parameter Types.FreqType fType = if fType_sys then Types.FreqType.sys else
                                               if fType_par then Types.FreqType.par else Types.FreqType.sig
          "frequency type";
          Modelica.Blocks.Interfaces.RealInput omega_internal
          "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput[2] vPhasor_internal
          "Needed to connect to conditional connector";

        initial equation
          if fType == Types.FreqType.sig then
            theta = 0;
          end if;

        equation
          connect(omega, omega_internal);
          connect(vPhasor, vPhasor_internal);
          if fType <> Types.FreqType.sig then
             omega_internal = 0.0;
          end if;
          if scType_par then
             vPhasor_internal = {0,0};
          end if;

          if fType == Types.FreqType.sys then
            theta = system.theta;
          elseif fType == Types.FreqType.par then
            theta = 2*pi*f*(time - system.initime);
          elseif fType == Types.FreqType.sig then
            der(theta) = omega_internal;
          end if;
          annotation (
            Window(
              x=
        0.45, y=
        0.01, width=
            0.44,
              height=
             0.65),
            Documentation(
                  info="<html>
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-70,-70},{70,70}},
                  lineColor={0,100,100},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-70,0},{70,0}},
                  color={176,0,0},
                  thickness=0.5),
                Text(
                  extent={{-50,30},{50,-70}},
                  lineColor={176,0,0},
                  lineThickness=0.5,
                  fillColor={127,0,255},
                  fillPattern=FillPattern.Solid,
                  textString="~")}),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
        end VoltageBase;
        annotation (       Window(
      x=0.05,
      y=0.44,
      width=0.31,
      height=0.23,
      library=1,
      autolayout=1));
      end Partials;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.32,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>The sources have optional inputs:</p>
<pre>
  vPhasor:   voltage {norm, phase}
  omega:     angular frequency
  pv:        {active power, abs(voltage)}  (only PVsource)
  p:         {active power, rective power} (only PQsource)
</pre>
<p>To use signal inputs, choose parameters vType=signal and/or fType=signal.</p>
<p>General relations between voltage-norms, effective- and peak-values is shown in the table, both
relative to each other (pu, norm = 1) and as example (SI, 400 V).</p>
<table border=1 cellspacing=0 cellpadding=4>
<tr> <th></th> <th></th> <th><b>pu</b></th> <th><b>V</b></th> </tr>
<tr><td>Three-phase norm</td><td>|v_abc|</td><td><b>1</b></td><td><b>400</b></td></tr>
<tr><td>Single-phase amplitude</td><td>ampl (v_a), ..</td><td>sqrt(2/3)</td> <td>326</td> </tr>
<tr><td>Single-phase effective</td><td>eff (v_a), ..</td><td><b>1/sqrt(3)</b></td><td><b>230</b></td></tr>
<tr><td>Phase to phase amplitude</td><td>ampl (v_b - v_c), ..</td><td>sqrt(2)</td><td>565</td></tr>
<tr><td>Phase to phase effective</td><td>eff (v_b - v_c), ..</td><td><b>1</b></td><td><b>400</b></td></tr>
<tr><td>Three-phase norm</td><td>|v_dqo|</td><td><b>1</b></td><td><b>400</b></td> </tr>
<tr><td>Phase to phase dq-norm</td><td>|vpp_dq|</td><td>sqrt(2)</td><td>565</td></tr>
</table>
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Sources;

    package Ports "AC three-phase ports dqo representation"
      extends Modelica.Icons.InterfacesPackage;

    partial model PortBase "base model adapting Spot to PowerSystems"
      function j_dqo = PhaseSystems.ThreePhase_dqo.j;
      function jj_dqo = PhaseSystems.ThreePhase_dqo.jj;
    end PortBase;

    connector ACdqo_p "AC terminal, 3-phase dqo ('positive')"
      extends Interfaces.Terminal(redeclare package PhaseSystem =
              PhaseSystems.ThreePhase_dqo);
      annotation (defaultComponentName = "term_p",
          Documentation(info="<html>
<p>AC connector with vector variables in dqo-representation, positive.</p>
</html>"),Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
          Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,120,120},
                  fillColor={0,120,120},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-60,60},{60,-60}},
                  lineColor={255,255,255},
                  textString="dqo")}),
          Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{0,50},{100,-50}},
                  lineColor={0,120,120},
                  fillColor={0,120,120},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{12,40},{90,-40}},
                  lineColor={255,255,255},
                  pattern=LinePattern.None,
                  textString="dqo"),
                Text(
                  extent={{-120,120},{100,60}},
                  lineColor={0,120,120},
                  textString="%name")}));
    end ACdqo_p;

    connector ACdqo_n "AC terminal, 3-phase dqo ('negative')"
      extends Interfaces.Terminal(redeclare package PhaseSystem =
              PhaseSystems.ThreePhase_dqo);
      annotation (defaultComponentName = "term_n",
          Documentation(info="<html>
<p>AC connector with vector variables in dqo-representation, negative.</p>
</html>"),Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
          Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,120,120},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-60,60},{60,-60}},
                  lineColor={0,120,120},
                  textString="dqo")}),
          Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-100,50},{0,-50}},
                  lineColor={0,120,120},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-90,40},{-10,-40}},
                  lineColor={0,120,120},
                  textString="dqo"),
                Text(
                  extent={{-100,120},{120,60}},
                  lineColor={0,120,120},
                  fillColor={0,100,100},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}));
    end ACdqo_n;

    partial model Port_p "AC one port 'positive', 3-phase"
      extends PortBase;

      Ports.ACdqo_p term "positive terminal"
                              annotation (Placement(transformation(extent={{-110,
                  -10},{-90,10}}, rotation=0)));
      annotation (
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                extent={{-100,-90},{100,-130}},
                lineColor={0,0,0},
                textString="%name")}),
        Documentation(info="<html></html>"),
                    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics));
    end Port_p;

    partial model Port_n "AC one port 'negative', 3-phase"
      extends PortBase;

      Ports.ACdqo_n term "negative terminal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      annotation (
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Text(
                extent={{-100,-90},{100,-130}},
                lineColor={0,0,0},
                textString="%name")}),
        Documentation(info="<html></html>"),
                   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                           graphics));
    end Port_n;

    partial model Port_p_n "AC two port, 3-phase"
      extends PortBase;

      Ports.ACdqo_p term_p "positive terminal"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Ports.ACdqo_n term_n "negative terminal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      Connections.branch(term_p.theta, term_n.theta);
      term_n.theta = term_p.theta;
      annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                extent={{-100,-90},{100,-130}},
                lineColor={0,0,0},
                textString="%name")}),
    Documentation(info="<html>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
            graphics));
    end Port_p_n;

    partial model Port_pn "AC two port 'current_in = current_out', 3-phase"
      extends Port_p_n;

    equation
      term_p.i + term_n.i = zeros(3);
      annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
</html>"),
    Diagram(graphics));
    end Port_pn;

    partial model YDport_p "AC one port Y or Delta topology 'positive'"
      extends Port_p;

    /*
  replaceable Topology.Y top "Y or Delta topology"
    annotation (                        choices(
    choice(redeclare PowerSystems.AC3ph.Ports.Topology.Y top "Y"),
    choice(redeclare PowerSystems.AC3ph.Ports.Topology.Delta top "Delta")),
        Placement(transformation(extent={{30,-20},{70,20}}, rotation=0)));
*/

      replaceable Topology.Y top(v_cond=v, i_cond=i, v_n=v_n)
            constrainedby Topology.TopologyBase(v_cond=v, i_cond=i, v_n=v_n)
        annotation (                        choices(
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Y top "Y"),
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Delta top "Delta")),
            Placement(transformation(extent={{30,-20},{70,20}}, rotation=0)));

      SI.Voltage[3] v "voltage conductor";
      SI.Current[3] i "current conductor";
      SI.Voltage[n_n] v_n "voltage neutral";
      SI.Current[n_n] i_n=top.i_n "current neutral to ground";
    protected
      final parameter Integer n_n=top.n_n
                                  annotation(evaluate=true);

    equation
      term.v = top.v_term;
      term.i = top.i_term;
      annotation (
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),
                   graphics),
                    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics),
        Documentation(info="<html>
<p>Defines Y- and Delta-topology transform of voltage and current variables.</p>
<p>Definitions</p>
<pre>
  v:     voltage across conductor
  i:     current through conductor
  v_n:   voltage neutral point if Y-topology
  i_n:   current neutral to ground if Y-topology
</pre>
<p>Relations Y-topology, (<tt>v, i</tt>: terminal to neutral point)</p>
<pre>
  v = term.v - {0, 0, sqrt(3)*v_n}
  term.i = i
  i_n = sqrt(3)*term.i[3]
</pre>
<p>Relations Delta-topology, (<tt>v, i</tt>: phase terminal to phase terminal)</p>
<pre>
  v[1:2] = sqrt(3)*Rot*term.v[1:2]
  v[3] = 0
  term.i[1:2] = sqrt(3)*transpose(Rot)*i[1:2]
  term.i[3] = 0
  with Rot = rotation_30deg
</pre>
</html>
"));
    end YDport_p;

    partial model YDportTrafo_p_n
      "AC two port with Y or Delta topology for transformers"
      extends Port_p_n;

      replaceable Topology.Y top_p(v_cond=v1*w1, i_cond=i1/w1, v_n=v_n1)
            constrainedby Topology.TopologyBase(v_cond=v1*w1, i_cond=i1/w1, v_n=v_n1)
        "p: Y or Delta topology"
        annotation (                         choices(
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Y top_p "Y"),
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Delta top_p "Delta")),
            Placement(transformation(extent={{-80,-20},{-40,20}}, rotation=0)));

      replaceable Topology.Y top_n(v_cond=v2*w2, i_cond=i2/w2, v_n=v_n2)
            constrainedby Topology.TopologyBase(v_cond=v2*w2, i_cond=i2/w2, v_n=v_n2)
        "n: Y or Delta topology"
        annotation (                        choices(
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Y top_n "Y"),
        choice(redeclare PowerSystems.AC3ph.Ports.Topology.Delta top_n "Delta")),
            Placement(transformation(extent={{80,-20},{40,20}}, rotation=0)));

      SI.Voltage[3] v1 "voltage conductor";
      SI.Current[3] i1 "current conductor";
      SI.Voltage[n_n1] v_n1 "voltage neutral";
      SI.Current[n_n1] i_n1=top_p.i_n "current neutral to ground";

      SI.Voltage[3] v2 "voltage conductor";
      SI.Current[3] i2 "current conductor";
      SI.Voltage[n_n2] v_n2 "voltage neutral";
      SI.Current[n_n2] i_n2=top_n.i_n "current neutral to ground";

    protected
      constant Integer[2] scale={top_p.scale, top_n.scale};
      final parameter Integer n_n1=top_p.n_n
                                            annotation(evaluate=true);
      final parameter Integer n_n2=top_n.n_n
                                            annotation(evaluate=true);
      Real w1 "1: voltage ratio to nominal";
      Real w2 "2: voltage ratio to nominal";

    equation
      term_p.v = top_p.v_term;
      term_p.i = top_p.i_term;
      term_n.v = top_n.v_term;
      term_n.i = top_n.i_term;
      annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
<p>Defines Y- and Delta-topology transform of voltage and current variables and contains additionally voltage and current scaling.</p>
<p>Below</p>
<pre>  term, v, i, w</pre>
<p>denote either the 'primary' or 'secondary' side</p>
<pre>
  term_p, v1, i1, w1
  term_n, v2, i2, w2
</pre>
<p>Definitions</p>
<pre>
  v:     scaled voltage across conductor
  i:     scaled current through conductor
  v_n:   voltage neutral point if Y-topology
  i_n:   current neutral to ground if Y-topology
  w:     voltage ratio to nominal (any value, but common for primary and secondary)
</pre>
<p>Relations Y-topology, (<tt>v, i</tt>: terminal to neutral point)</p>
<pre>
  v = (term.v - {0, 0, sqrt(3)*v_n})/w
  term.i = i/w
  i_n = sqrt(3)*term.i[3]
</pre>
<p>Relations Delta-topology, (<tt>v, i</tt>: phase terminal to phase terminal)</p>
<pre>
  v[1:2] = sqrt(3)*Rot*term.v[1:2]/w
  v[3] = 0
  term.i[1:2] = sqrt(3)*transpose(Rot)*i[1:2]/w
  term.i[3] = 0
  with Rot = rotation_30deg
</pre>
</html>
"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
            graphics));
    end YDportTrafo_p_n;

    package Topology "Topology transforms "
      extends Modelica.Icons.BasesPackage;

      partial model TopologyBase "Topology transform base"

        parameter Integer n_n(min=0,max=1)=1 "1 for Y, 0 for Delta";
        parameter Integer sh(min=-1,max=1)=0 "(-1,0,+1)*120deg phase shift"
                                                                          annotation(Evaluate=true);
        SI.Voltage[3] v_term "terminal voltage";
        SI.Current[3] i_term "terminal current";
        input SI.Voltage[3] v_cond "conductor voltage";
        input SI.Current[3] i_cond "conductor current";
        input SI.Voltage[n_n] v_n(start=fill(0,n_n)) "voltage neutral";
        SI.Current[n_n] i_n(start=fill(0,n_n)) "current neutral to ground";
    protected
        constant Real s3=sqrt(3);
          annotation (
            defaultComponentName="Y",
      Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
      Documentation(
              info="<html>
</html>
  "), Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-100,-90},{100,-130}},
                  lineColor={0,0,0},
                  textString="%name")}),
      Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
      end TopologyBase;

      model Y "Y transform"
        extends TopologyBase(final n_n=1, final sh=0);

        constant Integer scale=1 "for scaling of impedance values";

      equation
        v_cond = v_term - {0, 0, s3*v_n[1]};
        i_term = i_cond;
        i_n[1] = s3*i_term[3];
        annotation (defaultComponentName="Y",
      Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
      Documentation(
              info="<html>
<p><b>Structurally incomplete model</b>. Use only as component within appropriate complete model.<br>
Defines Y-topology transform of voltage and current variables.</p>
<p>Definitions</p>
<pre>
  v_term, i_term:   terminal voltage and current
  v_cond, i_cond:   voltage and current across conductor, (terminal to neutral point)
</pre>
<p>Relations, zero-component and neutral point (grounding)</p>
<pre>
  v_cond = v_term - {0, 0, sqrt(3)*v_n}
  i_term = i_cond
  i_n = sqrt(3)*i_term[3]
</pre>
<p>Note: parameter sh (phase shift) not used.</p>
</html>"),
      Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(
                  points={{-60,0},{60,0}},
                  color={255,0,0},
                  thickness=0.5),
                Line(points={{60,0},{100,0}}, color={0,0,255}),
                Line(
                  points={{-60,80},{10,80},{60,0},{10,-80},{-60,-80}},
                  color={255,0,0},
                  thickness=0.5),
                Line(points={{-100,80},{-60,80}}, color={0,0,255}),
                Line(points={{-100,0},{-60,0}}, color={0,0,255}),
                Line(points={{-100,-80},{-60,-80}}, color={0,0,255})}),
      Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{-88,80},{-60,80}}, color={0,0,255}),
                Line(points={{-90,0},{-60,0}}, color={0,0,255}),
                Line(points={{-90,-80},{-60,-80}}, color={0,0,255}),
                Line(
                  points={{-60,80},{10,80},{60,0},{10,-80},{-60,-80}},
                  color={255,0,0},
                  thickness=0.5),
                Line(
                  points={{-60,0},{60,0}},
                  color={255,0,0},
                  thickness=0.5),
                Line(points={{60,0},{90,0}}, color={0,0,255})}));
      end Y;

      model Delta "Delta transform"
        extends TopologyBase(final n_n=0);

        constant Integer scale=3 "for scaling of impedance values";
    protected
        final parameter Real[2,2] Rot=Basic.Transforms.rotation_dq(
                                                                  (1-4*sh)*pi/6);

      equation
        v_cond[1:2] = s3*Rot*v_term[1:2];
        v_cond[3] = 0;
        i_term[1:2] = s3*transpose(Rot)*i_cond[1:2];
        i_term[3] = 0;
        annotation (structurallyIncomplete=true,defaultComponentName="Delta",
            Window(
        x=0.45,
          y=0.01,
          width=
      0.44,
        height=
       0.65),
            Documentation(
            info="<html>
<p><b>Structurally incomplete model</b>. Use only as component within appropriate complete model.<br>
Defines Delta-topology transform of voltage and current variables.</p>
<p>Definitions</p>
<pre>
  v_term, i_term:   terminal voltage and current
  v_cond, i_cond:   voltage and current across conductor, (phase terminal to phase terminal)
</pre>
<p>Relations, zero-component<br>
<tt>v_n</tt> and <tt>i_n</tt> are not defined, as there is no neutral point.</p>
<pre>
  v_cond[1:2] = sqrt(3)*Rot*v_term[1:2];
  v_cond[3] = 0
  i_term[1:2] = sqrt(3)*transpose(Rot)*i_cond[1:2];
  i_term[3] = 0
</pre>
<p>with <tt>Rot = rotation_30deg</tt></p>
</html>
"),         Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{-100,80},{80,80}}, color={0,0,255}),
                Line(points={{-100,0},{-60,0}}, color={0,0,255}),
                Line(points={{-100,-80},{80,-80}}, color={0,0,255}),
                Polygon(
                  points={{-60,0},{80,80},{80,-80},{-60,0}},
                  lineColor={255,0,0},
                  lineThickness=0.5)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{-90,80},{80,80}}, color={0,0,255}),
                Line(points={{-90,0},{-60,0}}, color={0,0,255}),
                Line(points={{-90,-80},{80,-80}}, color={0,0,255}),
                Polygon(
                  points={{-60,0},{80,80},{80,-80},{-60,0}},
                  lineColor={255,0,0},
                  lineThickness=0.5)}));
      end Delta;
      annotation (preferedView="info",
        Window(
          x=0.05,
          y=0.41,
          width=0.4,
          height=0.32,
          library=1,
          autolayout=1),
        Documentation(info="<HTML>
<p>
Contains transforms for Y and Delta topology dqo.
</p>
</HTML>"),
        Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end Topology;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.03,
      width=0.4,
      height=0.38,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p>Electrical ports with connectors ACdqo:</p>
<p>The index notation <tt>_p_n</tt> and <tt>_pn</tt> is used for</p>
<pre>
  _p_n:     no conservation of current
  _pn:      with conservation of current
</pre>
</html>
"),   Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Ports;
  end AC3ph;

  package Blocks "Blocks"
    extends Modelica.Icons.Package;

    package Signals "Special signals"
      extends Modelica.Icons.VariantsPackage;

      block TransientPhasor "Transient {norm, phase} of vector"
        extends Partials.MO(final n=2);

        parameter SI.Time t_change=0.5 "time when change";
        parameter SI.Time t_duration=1 "transition duration";
        parameter Real a_ini=1 "initial norm |y|";
        parameter Real a_fin=1 "final norm |y|";
        parameter SI.Angle ph_ini=0 "initial phase (y)";
        parameter SI.Angle ph_fin=0 "final phase (y)";
    protected
        final parameter SI.Frequency coef=2*exp(1)/t_duration;

      equation
        y = 0.5*({a_fin+a_ini, ph_fin+ph_ini} + {a_fin-a_ini, ph_fin-ph_ini}*tanh(coef*(time - t_change)));
         annotation (defaultComponentName = "transPh1",
          Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65),
          Documentation(
                  info="<html>
<p>The signal is a two-dimensional vector in polar representation.<br>
Norm and phase change from <tt>{a_ini, ph_ini}</tt> to <tt>{a_fin, ph_fin}</tt><br>
at time <tt>t_change</tt> with a transition duration <tt>t_duration</tt>.<br><br>
The transition function is a hyperbolic tangent for both norm and phase.</p>
</html>
"),       Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Text(
                extent={{-100,100},{100,60}},
                lineColor={175,175,175},
                textString=
                     "phasor"),
              Text(
                extent={{-110,-10},{10,-50}},
                lineColor={160,160,164},
                textString=
                     "ini"),
              Text(
                extent={{-10,50},{110,10}},
                lineColor={160,160,164},
                textString=
                     "fin"),
              Line(points={{-80,-60},{-64,-60},{-44,-58},{-34,-54},{-26,-48},{-20,
                    -40},{-14,-30},{-8,-18},{-2,-6},{2,4},{8,18},{14,30},{20,40},{
                    26,48},{34,54},{44,58},{64,60},{80,60}}, color={95,0,191})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end TransientPhasor;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.38,
      library=1,
      autolayout=1),
    Documentation(info="<html>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Signals;

    package Partials "Partial models"
      extends Modelica.Icons.BasesPackage;

      partial block MO
        extends PowerSystems.Basic.Icons.Block0;

        Modelica.Blocks.Interfaces.RealOutput[n] y "output signal-vector"
          annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=
                 0)));
        parameter Integer n=1 "dim of output signal-vector";
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Window(
      x=0.55,
      y=0.01,
      width=0.44,
      height=0.65),
          Documentation(
                  info="<html>
</html>"),Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end MO;
      annotation (Documentation(info="<html>
</html>"));
    end Partials;
  annotation (preferedView="info",
  Window(
    x=0.05,
    y=0.03,
    width=0.4,
    height=0.27,
    library=1,
    autolayout=1),
  Documentation(info="<html>
<p><a href=\"Spot3.UsersGuide.Overview\">up users guide</a></p>
</html>"));
  end Blocks;

  package Control "Control blocks"
    extends Modelica.Icons.Package;

    package Relays "Relays"
      extends Modelica.Icons.VariantsPackage;

      block TapChangerRelay "Relay for setting tap-changer "
        extends PowerSystems.Basic.Icons.Block0;

        parameter Integer preset_1[:](min=0)={0}
        "1: index v-levels tap-chg, 0 is nom";
        parameter Integer preset_2[:](min=0)={0}
        "2: index v-levels tap-chg, 0 is nom";
        parameter SI.Time t_switch_1[:]={1} "1: switching times";
        parameter SI.Time t_switch_2[:]={1} "2:switching times";
        Modelica.Blocks.Interfaces.IntegerOutput tap_p
        "index of voltage level of tap changer 1"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}},
                rotation=0)));
        Modelica.Blocks.Interfaces.IntegerOutput tap_n
        "index of voltage level of tap changer 2"
          annotation (Placement(transformation(extent={{90,30},{110,50}}, rotation=
                  0)));
    protected
        Integer cnt_1(start=1,fixed=true);
        Integer cnt_2(start=1,fixed=true);

      algorithm
        when time > t_switch_1[min(cnt_1, size(t_switch_1, 1))] then
          cnt_1 := cnt_1 + 1;
          tap_p := preset_1[min(cnt_1, size(preset_1, 1))];
        end when;
        when time > t_switch_2[min(cnt_2, size(t_switch_2, 1))] then
          cnt_2 := cnt_2 + 1;
          tap_n := preset_2[min(cnt_2, size(preset_2, 1))];
        end when;
        annotation (defaultComponentName = "tapRelay1",
          Window(
      x=0.01,
      y=0.01,
      width=0.44,
      height=0.65),
          Documentation(
                  info="<html>
<p>The voltage level indices are pre-selected. They correspond to the index of the tap voltage levels
of the transformer model. Level 0 is nominal voltage.</p>
<p>The switching times can be chosen arbitrarily.</p>
</html>
"),       Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Text(
                extent={{50,50},{70,30}},
                lineColor={255,128,0},
                textString=
                     "2"),
              Text(
                extent={{50,-30},{70,-50}},
                lineColor={255,128,0},
                textString=
                     "1"),
              Text(
                extent={{-80,20},{80,-20}},
                lineColor={128,128,128},
                textString=
                     "tap")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
      end TapChangerRelay;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.38,
      library=1,
      autolayout=1),
    Documentation(info="<html>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Relays;
  annotation (preferedView="info",
  Window(
    x=0.05,
    y=0.03,
    width=0.4,
    height=0.27,
    library=1,
    autolayout=1),
  Documentation(info="<html>
<p><a href=\"Spot3.UsersGuide.Overview\">up users guide</a></p>
</html>
"));
  end Control;

  package Basic "Basic utility classes"
    extends Modelica.Icons.BasesPackage;

    package Nominal "Units and nominal values"
      extends Modelica.Icons.BasesPackage;

    partial model Nominal "Units and nominal values"

      parameter Boolean puUnits = true
        "= true, if scaled with nom. values (pu), else scaled with 1 (SI)"
        annotation(Evaluate=true, Dialog(group="Parameter Scaling"));

      parameter SI.Voltage V_nom(final min=0)=1
        "nominal Voltage (= base for pu)"
        annotation(Evaluate=true, Dialog(enable=puUnits, group="Nominal"));

      parameter SI.ApparentPower S_nom(final min=0)=1
        "nominal Power (= base for pu)"
        annotation(Evaluate=true, Dialog(enable=puUnits, group="Nominal"));
      annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Documentation(info="<html>
<p>'Nominal' values that are used to define 'base'-values in the case where input is in 'pu'-units</p>
<p>The parameter 'units' allows choosing between SI ('Amp Volt') and pu ('per unit') for input-parameters of components and output-variables of meters.<br>
The default setting is 'pu'.</p>
<p>pu ('per unit'):</p>
<pre>
  V_base = V_nom
  S_base = S_nom
  R_base = V_nom*V_nom/S_nom
  I_base = S_nom/V_nom
</pre>
<p>SI ('Amp Volt'):</p>
<pre>
  V_base = 1
  S_base = 1
  R_base = 1
  I_base = 1
</pre>
<p>Note that the choice between SI and pu does <b>not</b> affect state- and connector variables.
These remain <b>always</b> in SI-units. It only affects input of parameter values and output variables.</p>
</html>
"),            Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end Nominal;

    partial model NominalAC "Units and nominal values AC"
      extends Nominal;

      parameter SI.Frequency f_nom=system.f_nom "nominal frequency"
      annotation(Evaluate=true, Dialog(group="Nominal"), choices(choice=50 "50 Hz", choice=60 "60 Hz"));
    protected
      outer PowerSystems.System system;
      annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Documentation(info="<html>
<p>Same as 'Nominal', but with additional parameter 'nominal frequency'.</p>
</html>
"),            Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end NominalAC;

    record NominalDataTrafo "Units and nominal data transformer"
      extends Modelica.Icons.Record;

      final parameter Boolean puUnits = true
        "= true, if scaled with nom. values (pu), else scaled with 1 (SI)"
        annotation(Evaluate=true, Dialog(group="Parameter Scaling"));
      parameter SI.Voltage[:] V_nom(final min={0,0})={1,1}
        "{prim,sec} nom Voltage (= base of pu)"
        annotation(Evaluate=true, Dialog(group="Nominal"));
      parameter SI.ApparentPower S_nom(final min=0)=1
        "nominal Power (= base of pu)"
        annotation(Evaluate=true, Dialog(group="Nominal"));
      parameter SI.Frequency f_nom=system.f_nom "nominal frequency"
        annotation(Evaluate=true, Dialog(group="Nominal"), choices(choice=50 "50 Hz", choice=60 "60 Hz"));
    protected
      outer PowerSystems.System system;
      annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Documentation(info="<html>
<p>'Nominal' values for transformers. Same as 'NominalAC, but with two components for voltage: {primary, secondary}. The winding ratio is indirectly defined through the voltage ratio.</p>
</html>"),     Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end NominalDataTrafo;
      annotation (preferedView="info",
    Window(
      x=0.05,
      y=0.41,
      width=0.4,
      height=0.38,
      library=1,
      autolayout=1),
    Documentation(info="<html>
</html>
"),     Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics));
    end Nominal;

    package Precalculation "Precalculation functions"
        extends Modelica.Icons.Package;

      function baseV "Base voltage"
        extends PowerSystems.Basic.Icons.Function;

        input Boolean puUnits "= true if pu else SI units";
        input SI.Voltage V_nom "nom voltage";
        output SI.Voltage V_base "base voltage";

      algorithm
        if puUnits then
          V_base := V_nom;
        else
          V_base := 1;
        end if;
      annotation(Documentation(info="<html>
<p>Calculates base-voltage depending on the choice of units.</p>
<p>\"pu\":
<pre>
  V_base = V_nom
</pre>
\"SI\":
<pre>
  V_base = 1
</pre></p>
</html>
"));
      end baseV;

      function baseI "Base current"
        extends PowerSystems.Basic.Icons.Function;

        input Boolean puUnits "= true if pu else SI units";
        input SI.Voltage V_nom "nom voltage";
        input SI.ApparentPower S_nom "apparent power";
        output SI.Current I_base "base current";

      algorithm
        if puUnits then
          I_base := S_nom/V_nom;
        else
          I_base := 1;
        end if;
      annotation(Documentation(info="<html>
<p>Calculates base-current depending on the choice of units.</p>
<p>\"pu\":
<pre>
  I_base = S_nom/V_nom;
</pre>
\"SI\":
<pre>
  I_base = 1;
</pre></p>
</html>
"));
      end baseI;

      function baseR "Base resistance"
        extends PowerSystems.Basic.Icons.Function;

        input Boolean puUnits "= true if pu else SI units";
        input SI.Voltage V_nom "nom voltage";
        input SI.ApparentPower S_nom "apparent power";
        input Integer scale=1 "scaling factor topology (Y:1, Delta:3)";
        output SI.Resistance R_base "base resistance";

      algorithm
        if puUnits then
          R_base := scale*V_nom*V_nom/S_nom;
        else
          R_base := scale;
        end if;
      annotation (Documentation(info="<html>
<p>Calculates base-resistance depending on the choice of units.</p>
<p>\"pu\":
<pre>
  R_base = V_nom*V_nom/S_nom
</pre>
\"SI\":
<pre>
  R_base = 1
</pre></p>
</html>
"));
      end baseR;

      function baseTrafoV "Base voltage transformers"
        extends PowerSystems.Basic.Icons.Function;

        input Boolean puUnits "= true if pu else SI units";
        input SI.Voltage[:] V_nom
        "nom voltage {prim, sec} or {prim, sec1, sec2}";
        output SI.Voltage[size(V_nom,1)] V_base
        "base voltage {prim,sec} or {prim, sec1, sec2}";

      algorithm
        if puUnits then
          V_base := V_nom;
        else
          V_base := ones(size(V_nom,1));
        end if;
      annotation(Documentation(info="<html>
<p>Calculates transformer base-voltage depending on the choice of units.</p>
<p>\"pu\":
<pre>
  V_base[k] = V_nom[k], k=1,2
</pre>
\"SI\":
<pre>
  V_base[k] = 1,    k=1,2
</pre></p>
</html>
"));
      end baseTrafoV;

      function baseTrafoRL "Base resistance and inductance transformers"
        extends PowerSystems.Basic.Icons.Function;

        input Boolean puUnits "= true if pu else SI units";
        input SI.Voltage[:] V_nom
        "nom voltage {prim, sec} or {prim, sec1, sec2}";
        input SI.ApparentPower S_nom "apparent power";
        input SI.AngularFrequency omega_nom "angular frequency";
        output Real[size(V_nom,1), 2] RL_base "base [prim res, prim ind; sec res, sec ind] or
   [prim res, prim ind; sec1 res, sec1 ind; sec2 res, sec2 ind]";

      algorithm
        if puUnits then
          RL_base := fill(V_nom[1]^2/S_nom, size(V_nom,1), 1)*[1, 1/omega_nom];
        else
          RL_base := [(fill(V_nom[1],size(V_nom,1))./ V_nom).^2]*[1, 1/omega_nom];
        end if;
      annotation (Documentation(info="<html>
<p>Calculates transformer base-resistance and -inductance depending on the choice of units (first index: primary, secondary, second index: R, L).<br>
The secondary side is winding-reduced to the primary, as the equations are written in reduced form.</p>
<p>\"pu\":
<pre>
  RL_base = [V_nom[1]^2/S_nom          ] * [1, 1/omega_nom]
           [(V_nom[2]^2/S_nom)/W_nom^2]
</pre>
\"SI\":
<pre>
  RL_base[k] = [1        ] * [1, 1/omega_nom]
              [1/W_nom^2]
</pre></p>
<p>The winding ratio <tt>W_nom</tt> is given by the nominal voltages:
<pre>  W_nom = V_nom[2]/V_nom[1]</pre></p>
</html>"));
      end baseTrafoRL;
        annotation (preferedView="info",
                           Window(
      x=0.05,
      y=0.44,
      width=0.31,
      height=0.23,
      library=1,
      autolayout=1),
          Documentation(info="<html>
<p>Functions needed for the determination of coefficient-matrices from a set of phenomenological input parameters.</p>
<p><a href=\"PowerSystems.UsersGuide.Introduction.Precalculation\">up users guide</a></p>
<p>The second part of this package has been written in honour of <b>I. M. Canay</b>, one of the important electrical engeneers of the 20th century. He understood, what he wrote, and his results were exact. The package is based on his ideas and formulated in full mathematical generality.</p>
<p>Literature:
<ul>
<li>Canay, I. M.: Modelling of Alternating-Current Machines Having Multiple Rotor Circuits.<br>
IEEE Transactions on Energy Conversion, Vol. 8, No. 2, June 1993.</li>
<li>Canay, I. M.: Determination of the Model Parameters of Machines from the Reactance Operators x_d(p), x_q(p).<br>
IEEE Transactions on Energy Conversion, Vol. 8, No. 2, June 1993.</li>
</ul></p>
</html>"));
    end Precalculation;

    package Transforms "Transform functions"
        extends Modelica.Icons.Package;

        function park "Park transform"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta "transformation angle";
          output Real[3,3] P "Park transformation matrix";
    protected
          constant Real s13=sqrt(1/3);
          constant Real s23=sqrt(2/3);
          constant Real dph_b=2*Modelica.Constants.pi
                                  /3;
          constant Real dph_c=4*Modelica.Constants.pi
                                  /3;
          Real[3] c;
          Real[3] s;

        algorithm
          c := cos({theta, theta - dph_b, theta - dph_c});
          s := sin({theta, theta - dph_b, theta - dph_c});
          P := transpose([s23*c, -s23*s, {s13, s13, s13}]);
          annotation (derivative = PowerSystems.Basic.Transforms.der_park,
        Documentation(info="<html>
<p>The function <tt>park</tt> calculates the matrix <tt>P</tt> that transforms abc variables into dqo variables with arbitrary angular orientation <tt>theta</tt>.<br>
<tt>P</tt> can be factorised into a constant, angle independent orthogonal matrix <tt>P0</tt> and an angle-dependent rotation <tt>R</tt></p>
<pre>
  P(theta) = R'(theta)*P0
</pre>
<p>Using the definition</p>
<pre>
  c_k = cos(theta - k*2*pi/3),  k=0,1,2 (phases a, b, c)
  s_k = sin(theta - k*2*pi/3),  k=0,1,2 (phases a, b, c)
</pre>
<p>it takes the form
<pre>
                       [ c_0,  c_1, c_2]
  P(theta) = sqrt(2/3)*[-s_0, -s_1,-s_2]
                       [ w,    w,   w  ]
</pre>
with
<pre>
                        [ 1,      -1/2,       -1/2]
  P0 = P(0) = sqrt(2/3)*[ 0, sqrt(3)/2, -sqrt(3)/2]
                        [ w,         w,          w]
</pre>
and
<pre>
             [c_0, -s_0, 0]
  R(theta) = [s_0,  c_0, 0]
             [  0,  0,   1]
</pre></p>
<p><a href=\"PowerSystems.UsersGuide.Introduction.Transforms\">up users guide</a></p>
</html>"));
        end park;

        function der_park "Derivative of Park transform"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta "transformation angle";
          input Modelica.SIunits.AngularFrequency omega "d/dt theta";
          output Real[3, 3] der_P "d/dt park";
    protected
          constant Real s23=sqrt(2/3);
          constant Real dph_b=2*Modelica.Constants.pi
                                  /3;
          constant Real dph_c=4*Modelica.Constants.pi
                                  /3;
          Real[3] c;
          Real[3] s;
          Real s23omega;

        algorithm
          s23omega := s23*omega;
          c := cos({theta, theta - dph_b, theta - dph_c});
          s := sin({theta, theta - dph_b, theta - dph_c});
          der_P := transpose([-s23omega*s, -s23omega*c, {0, 0, 0}]);
        annotation(derivative(order=2) = PowerSystems.Basic.Transforms.der2_park,
        Documentation(info="<html>
<p>First derivative of function park(theta) with respect to time.</p>
</html>"));
        end der_park;

        function der2_park "2nd derivative of Park transform"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta "transformation angle";
          input Modelica.SIunits.AngularFrequency omega "d/dt theta";
          input Modelica.SIunits.AngularAcceleration omega_dot "d/dt omega";
          output Real[3, 3] der2_P "d2/dt2 park";
    protected
          constant Real s23=sqrt(2/3);
          constant Real dph_b=2*Modelica.Constants.pi
                                  /3;
          constant Real dph_c=4*Modelica.Constants.pi
                                  /3;
          Real[3] c;
          Real[3] s;
          Real s23omega_dot;
          Real s23omega2;

        algorithm
          s23omega_dot := s23*omega_dot;
          s23omega2 := s23*omega*omega;
          c := cos({theta, theta - dph_b, theta - dph_c});
          s := sin({theta, theta - dph_b, theta - dph_c});
          der2_P := transpose([-s23omega_dot*s - s23omega2*c, -s23omega_dot*c + s23omega2*s, {0, 0, 0}]);
        annotation(Documentation(info="<html>
<p>Second derivative of function park(theta) with respect to time.</p>
</html>"));
        end der2_park;

        function rotation_dq "Rotation matrix dq"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta "rotation angle";
          output Real[2, 2] R_dq "rotation matrix";
    protected
          Real c;
          Real s;

        algorithm
          c :=  cos(theta);
          s :=  sin(theta);
          R_dq :=  [c, -s; s, c];
          annotation (derivative = PowerSystems.Basic.Transforms.der_rotation_dq,
        Documentation(info="<html>
<p>The function <tt>rotation_dq</tt> calculates the matrix <tt>R_dq</tt> that is the restriction of <tt>R_dqo</tt> from dqo to dq.</p>
<p>The matrix <tt>R_dqo</tt> rotates dqo variables around the o-axis in dqo-space with arbitrary angle <tt>theta</tt>.
<p>It takes the form
<pre>
                 [cos(theta), -sin(theta), 0]
  R_dqo(theta) = [sin(theta),  cos(theta), 0]
                 [  0,           0,        1]
</pre>
and has the real eigenvector
<pre>  {0, 0, 1}</pre>
in the dqo reference-frame.</p>
<p>Coefficient matrices of the form (symmetrical systems)
<pre>
      [x, 0, 0 ]
  X = [0, x, 0 ]
      [0, 0, xo]
</pre>
are invariant under transformations R_dqo</p>
<p>The connection between R_dqo and R_abc is the following
<pre>  R_dqo = P0*R_abc*P0'.</pre>
with P0 the orthogonal transform 'Transforms.P0'.</p>
<p><a href=\"PowerSystems.UsersGuide.Introduction.Transforms\">up users guide</a></p>
</html>
"));
        end rotation_dq;

        function der_rotation_dq "Derivative of rotation matrix dq"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta;
          input Modelica.SIunits.AngularFrequency omega "d/dt theta";
          output Real[2, 2] der_R_dq "d/dt rotation_dq";
    protected
          Real dc;
          Real ds;

        algorithm
          dc :=  -omega*sin(theta);
          ds :=   omega*cos(theta);
          der_R_dq :=  [dc, -ds; ds, dc];
        annotation(derivative(order=2) = PowerSystems.Basic.Transforms.der2_rotation_dq,
        Documentation(info="<html>
<p>First derivative of function rotation_dq(theta) with respect to time.</p>
</html>"));
        end der_rotation_dq;

        function der2_rotation_dq "2nd derivative of rotation matrix dq"
          extends PowerSystems.Basic.Icons.Function;

          input Modelica.SIunits.Angle theta;
          input Modelica.SIunits.AngularFrequency omega "d/dt theta";
          input Modelica.SIunits.AngularAcceleration omega_dot "d/dt omega";
          output Real[2, 2] der2_R_dq "d/2dt2 rotation_dq";
    protected
          Real c;
          Real s;
          Real d2c;
          Real d2s;
          Real omega2=omega*omega;

        algorithm
          c := cos(theta);
          s := sin(theta);
          d2c := -omega_dot*s - omega2*c;
          d2s :=  omega_dot*c - omega2*s;
          der2_R_dq := [d2c, -d2s; d2s, d2c];
        annotation(Documentation(info="<html>
<p>Second derivative of function rotation_dq(theta) with respect to time.</p>
</html>"));
        end der2_rotation_dq;
        annotation (preferedView="info",
      Window(
        x=0.05,
        y=0.41,
        width=0.4,
        height=0.38,
        library=1,
        autolayout=1),
      Documentation(info="<html>
<p><a href=\"PowerSystems.UsersGuide.Introduction.Transforms\">up users guide</a></p>
</html>
"),       Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics));
    end Transforms;

    package Types
        extends Modelica.Icons.Package;

      package SIpu "Additional types for power systems"
        extends Modelica.Icons.Package;

        type Voltage = Real (final quantity="Voltage", unit="V/V");

        type Current = Real (final quantity="Current", unit="A/A");

        type Resistance = Real (
            final quantity="Resistance",
            unit="Ohm/(V.V/VA)",
            final min=0);

        type Reactance = Real (final quantity="Reactance", unit="Ohm/(V.V/VA)");

        type Power = Real (final quantity="Power", unit="W/W");
       annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65,
          library=1,
          autolayout=1),
        Invisible=true,
        Documentation(info="<html>
</html>
"));
      end SIpu;

      type FreqType = enumeration(
        par "parameter",
        sig "signal",
        sys "system") "Frequency type"
          annotation(Documentation(info="<html>
<p><pre>
  par:  source has parameter frequency
  sig:  source has signal frequency
  sys:  source has system frequency
</pre></p>
</html>"));

        type AngularVelocity = SI.AngularVelocity(displayUnit = "rpm");
    end Types;

    package Icons "Icons"
        extends Modelica.Icons.Package;

        partial block Block "Block icon"

          annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Documentation(info="
"),     Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                  extent={{-80,60},{80,-60}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
        end Block;

        partial block Block0 "Block icon 0"
          extends Block;
          annotation (
        Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65),
        Documentation(info="
"),     Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Text(
                  extent={{-100,-80},{100,-120}},
                  lineColor={0,0,0},
                  textString=
                   "%name")}));
        end Block0;

      partial function Function "Function icon"

        annotation (
          Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-100,60},{100,-60}},
                  lineColor={255,85,85},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-100,30},{100,-50}},
                  lineColor={255,85,85},
                  textString="f"),
                Text(
                  extent={{-100,120},{100,80}},
                  lineColor={0,0,0},
                  textString="%name")}),
          Documentation(
                  info="
"),       Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65),
          Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
      end Function;
      annotation (preferedView="info",
        Window(
          x=0.05,
          y=0.41,
          width=0.4,
          height=0.32,
          library=1,
          autolayout=1),
        Documentation(info="<html>
</html>
"));
    end Icons;
  end Basic;

  package Interfaces
    extends Modelica.Icons.InterfacesPackage;

    connector Terminal "General power terminal"
      replaceable package PhaseSystem = PhaseSystems.PartialPhaseSystem
      "Phase system"
        annotation (choicesAllMatching=true);
      PhaseSystem.Voltage v[PhaseSystem.n] "voltage vector";
      flow PhaseSystem.Current i[PhaseSystem.n] "current vector";
      PhaseSystem.ReferenceAngle theta[PhaseSystem.m] if PhaseSystem.m > 0
      "optional vector of phase angles";
    end Terminal;

    connector Electric_p "Electric terminal ('positive')"
      extends Modelica.Electrical.Analog.Interfaces.Pin;
      annotation (defaultComponentName = "term_p",
    Documentation(info="<html>
</html>
"), Window(
      x=0.45,
      y=0.01,
      width=0.44,
      height=0.65),
    Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Rectangle(
              extent={{0,50},{100,-50}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-120,120},{100,60}},
              lineColor={0,0,255},
              textString="%name")}));
    end Electric_p;

    connector Frequency "Weighted frequency"
      flow SI.Time H "inertia constant";
      flow SI.Angle w_H "angular velocity, inertia-weighted";
      Real h "Dummy potential-variable to balance flow-variable H";
      Real w_h "Dummy potential-variable to balance flow-variable w_H";

    annotation (defaultComponentName = "frequency",
      Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={120,0,120},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-60,30},{60,-30}},
              lineColor={120,0,120},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="f")}),
      Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={Text(
              extent={{-120,120},{120,60}},
              lineColor={120,0,120},
              textString=
                 "%name"), Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={120,0,120},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
      Documentation(info="<html>
<p>System frequency reference.<br>
Used in 'System' for sending/receiving weighted frequency-data.</p>
<pre>
  H:        weight, i.e. inertia constant of machine (dimension time)
  H_omega:  weighted angular frequency H*omega
</pre>
</html>"));
    end Frequency;
  end Interfaces;
  annotation (preferedView="info",
  version="0.2.1",
  versionDate="2014-08-15",
  Documentation(info="<html>
<h3><font color=\"#000080\" size=5>Modelica PowerSystems library</font></h3>
<p>The library is intended to model electrical <b>power systems</b> at different <b>levels of detail</b> both in <b>transient</b> and <b>steady-state</b> mode.</p>
<p>The Users Guide to the library is <a href=\"PowerSystems.UsersGuide\"><b>here</b></a>.</p>
<p><br/>Copyright &copy; 2007-2013, Modelica Association. </p>
<p><i>This Modelica package is <b>Open Source</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license, version 2.0, see the license conditions and
the accompanying disclaimer <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</b></i> </p>
<p><i>This work was in parts supported by the ITEA2 MODRIO project by funding of BMBF under contract
number ITEA 2 - 11004. Work on the predecessor PowerFlow library was in parts supported by
the ITEA2 EUROSYSLIB project by funding of BMBF under contract number ITEA 2 - 06020.
Work on the predecessor Spot library was in parts supported by the RealSim project
by funding of the IST Programme, Contract No. IST-1999-11979. </i></p>
<p/>
</html>
"),
  uses(Modelica(version="3.2.1")),
  Icon(graphics={
      Line(
        points={{-60,-16},{38,-16}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-60,-16},{-60,-42}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{38,-16},{38,-42}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-10,10},{-10,-16}},
        color={0,0,0},
        smooth=Smooth.None),
      Ellipse(extent={{-20,30},{0,10}}, lineColor={0,0,0}),
      Ellipse(extent={{-20,42},{0,22}}, lineColor={0,0,0}),
      Ellipse(extent={{-70,-42},{-50,-62}}, lineColor={0,0,0}),
      Ellipse(extent={{28,-42},{48,-62}}, lineColor={0,0,0}),
      Line(
        points={{-10,52},{-10,42}},
        color={0,0,0},
        smooth=Smooth.None)}));
end PowerSystems;
model PowerSystems_Examples_Spot_AC3ph_Transformer
 extends PowerSystems.Examples.Spot.AC3ph.Transformer;
  annotation(experiment(StopTime=3),uses(PowerSystems(version="0.2.1")));
end PowerSystems_Examples_Spot_AC3ph_Transformer;
