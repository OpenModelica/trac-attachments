within ;
package ModelicaServices
  "(version = 3.2.1, target = \"Dymola\") Models and functions used in the Modelica Standard Library requiring a tool specific implementation"

package Machine

  final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

  final constant Real small=1.e-60
      "Smallest number such that small and -small are representable on the machine";

  final constant Real inf=1.e+60
      "Biggest Real number such that inf and -inf are representable on the machine";
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

    package Continuous
      "Library of continuous control blocks with internal states"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Package;

      block FirstOrder "First order transfer function block (= 1 pole)"
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit="1")=1 "Gain";
        parameter SIunits.Time T(start=1) "Time Constant";
        parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
          "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
                                                                                          annotation(Evaluate=true,
            Dialog(group="Initialization"));
        parameter Real y_start=0 "Initial or guess value of output (= state)"
          annotation (Dialog(group="Initialization"));

        extends Interfaces.SISO(y(start=y_start));

      initial equation
        if initType == Init.SteadyState then
          der(y) = 0;
        elseif initType == Init.InitialState or initType == Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = (k*u - y)/T;
        annotation (
          Documentation(info="<HTML>
<p>
This blocks defines the transfer function between the input u
and the output y (element-wise) as <i>first order</i> system:
</p>
<pre>
               k
     y = ------------ * u
            T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>
<pre>
Example:
   parameter: k = 0.3, T = 0.4
   results in:
             0.3
      y = ----------- * u
          0.4 s + 1.0
</pre>

</html>"),       Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
          initialScale=0.1),
          graphics={
        Line(visible=true,
            points={{-80.0,78.0},{-80.0,-90.0}},
          color={192,192,192}),
        Polygon(visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
        Line(visible=true,
          points={{-90.0,-80.0},{82.0,-80.0}},
          color={192,192,192}),
        Polygon(visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
        Line(visible = true,
            origin = {-26.667,6.667},
            points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
            color = {0,0,127},
            smooth = Smooth.Bezier),
        Text(visible=true,
          lineColor={192,192,192},
          extent={{0.0,-60.0},{60.0,0.0}},
          textString="PT1"),
        Text(visible=true,
          extent={{-150.0,-150.0},{150.0,-110.0}},
          textString="T=%T")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-48,52},{50,8}},
                lineColor={0,0,0},
                textString="k"),
              Text(
                extent={{-54,-6},{56,-56}},
                lineColor={0,0,0},
                textString="T s + 1"),
              Line(points={{-50,0},{50,0}}, color={0,0,0}),
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
              Line(points={{-100,0},{-60,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255})}));
      end FirstOrder;
      annotation (
        Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks
described by differential equations.
</p>

<p>
All blocks of this package can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\"><b>Init.NoInit</b></td>
      <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

  <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
      <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialState</b></td>
      <td valign=\"top\">Initialization with initial states</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
      <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possible)</td></tr>
</table>

<p>
For backward compatibility reasons the default of all blocks is
<b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
where the default is <b>Init.InitialState</b> (this was the initialization
defined in version 2.2 of the Modelica standard library).
</p>

<p>
In many cases, the most useful initial condition is
<b>Init.SteadyState</b> because initial transients are then no longer
present. The drawback is that in combination with a non-linear
plant, non-linear algebraic equations occur that might be
difficult to solve if appropriate guess values for the
iteration variables are not provided (i.e., start values with fixed=false).
However, it is often already useful to just initialize
the linear blocks from the Continuous blocks library in SteadyState.
This is uncritical, because only linear algebraic equations occur.
If Init.NoInit is set, then the start values for the states are
interpreted as <b>guess</b> values and are propagated to the
states with fixed=<b>false</b>.
</p>

<p>
Note, initialization with Init.SteadyState is usually difficult
for a block that contains an integrator
(Integrator, LimIntegrator, PI, PID, LimPID).
This is due to the basic equation of an integrator:
</p>

<pre>
  <b>initial equation</b>
     <b>der</b>(y) = 0;   // Init.SteadyState
  <b>equation</b>
     <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation leads to the condition that the input to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is always defined by
Init.InitialState or Init.SteadyState initialization.
</p>

<p>
In such a case, <b>Init.NoInit</b> has to be selected for the integrator
and an additional initial equation has to be added to the system
to which the integrator is connected. E.g., useful initial conditions
for a 1-dim. rotational inertia controlled by a PI controller are that
<b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
</p>

</html>"),     Icon(graphics={Line(
              origin={0.061,4.184},
              points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
                  113.485},{-65.374,-61.217},{-78.061,-78.184}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Continuous;

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

      partial block SO "Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

      end SO;

      partial block SISO "Single Input Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u "Connector of Real input signal" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
      end SISO;

      partial block SI2SO
        "2 Single Input / 1 Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u1 "Connector of Real input signal 1" annotation (Placement(
              transformation(extent={{-140,40},{-100,80}}, rotation=0)));
        RealInput u2 "Connector of Real input signal 2" annotation (Placement(
              transformation(extent={{-140,-80},{-100,-40}}, rotation=0)));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));

        annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"));

      end SI2SO;

      partial block SignalSource "Base class for continuous signal source"
        extends SO;
        parameter Real offset=0 "Offset of output signal y";
        parameter SIunits.Time startTime=0
          "Output y = offset for time < startTime";
        annotation (Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
      end SignalSource;
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

    package Math
      "Library of Real mathematical functions as input/output blocks"
      import Modelica.SIunits;
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

          block Add "Output the sum of the two inputs"
            extends Interfaces.SI2SO;

            parameter Real k1=+1 "Gain of upper input";
            parameter Real k2=+1 "Gain of lower input";

          equation
            y = k1*u1 + k2*u2;
            annotation (
              Documentation(info="<html>
<p>
This blocks computes output <b>y</b> as <i>sum</i> of the
two input signals <b>u1</b> and <b>u2</b>:
</p>
<pre>
    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   k1= +2, k2= -3

  results in the following equations:

     y = 2 * u1 - 3 * u2
</pre>

</html>"),           Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, initialScale = 0.1), graphics={
                Text(
                  lineColor = {0,0,255},
                  extent = {{-150,110},{150,150}},
                  textString = "%name"),
                Line(
                  points = {{-100,60},{-74,24},{-44,24}},
                  color = {0,0,127}),
                Line(
                  points = {{-100,-60},{-74,-28},{-42,-28}},
                  color = {0,0,127}),
                Ellipse(
                  lineColor = {0,0,127},
                  extent = {{-50,-50},{50,50}}),
                Line(
                  points = {{50,0},{100,0}},
                  color = {0,0,127}),
                Text(
                  extent = {{-38,-34},{38,34}},
                  textString = "+"),
                Text(
                  extent = {{-100,52},{5,92}},
                  textString = "%k1"),
                Text(
                  extent = {{-100,-92},{5,-52}},
                  textString = "%k2")}),
              Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,-100},{100,100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{50,0},{100,0}}, color={0,0,255}),
              Line(points={{-100,60},{-74,24},{-44,24}}, color={0,0,127}),
              Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={0,0,127}),
              Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,127}),
              Line(points={{50,0},{100,0}}, color={0,0,127}),
              Text(
                extent={{-36,38},{40,-30}},
                lineColor={0,0,0},
                textString="+"),
              Text(
                extent={{-100,52},{5,92}},
                lineColor={0,0,0},
                textString="k1"),
              Text(
                extent={{-100,-52},{5,-92}},
                lineColor={0,0,0},
                textString="k2")}));
          end Add;
      annotation (
        Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"),     Icon(graphics={Line(
              points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
                  {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
                  {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
                  {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
                  57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Math;

    package Sources
      "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

      block Step "Generate step signal of type Real"
        parameter Real height=1 "Height of step";
        extends Interfaces.SignalSource;

      equation
        y = offset + (if time < startTime then 0 else height);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
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
              Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="startTime=%startTime")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,-18},{0,-18},{0,50},{80,50}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{70,-80},{94,-100}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-21,-72},{25,-90}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{0,-18},{0,-70}}, color={95,95,95}),
              Text(
                extent={{-68,-36},{-22,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
              Polygon(
                points={{0,50},{-21,50},{0,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-13,-18},{-16,-5},{-10,-5},{-13,-18},{-13,-18}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-13,50},{-16,37},{-10,37},{-13,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-68,26},{-22,8}},
                lineColor={0,0,0},
                textString="height"),
              Polygon(
                points={{-13,-70},{-16,-57},{-10,-57},{-13,-70},{-13,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
              Polygon(
                points={{-13,-18},{-16,-31},{-10,-31},{-13,-18}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,100},{-31,80}},
                lineColor={0,0,0},
                textString="y")}),
          Documentation(info="<html>
<p>
The Real output y is a step signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
     alt=\"Step.png\">
</p>

</html>"));
      end Step;

      block Ramp "Generate ramp signal"
        parameter Real height=1 "Height of ramps";
        parameter Modelica.SIunits.Time duration(min=0.0, start=2)
          "Duration of ramp (= 0.0 gives a Step)";
        parameter Real offset=0 "Offset of output signal";
        parameter Modelica.SIunits.Time startTime=0
          "Output = offset for time < startTime";
        extends Interfaces.SO;

      equation
        y = offset + (if time < startTime then 0 else if time < (startTime +
          duration) then (time - startTime)*height/duration else height);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
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
              Line(points={{-80,-70},{-40,-70},{31,38}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="duration=%duration"),
              Line(points={{31,38},{86,38}}, color={0,0,0})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,-20},{-20,-20},{50,50}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-40,-20},{-42,-30},{-38,-30},{-40,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,-20},{-40,-70}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Polygon(
                points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,-39},{-34,-50}},
                lineColor={0,0,0},
                textString="offset"),
              Text(
                extent={{-38,-72},{6,-83}},
                lineColor={0,0,0},
                textString="startTime"),
              Text(
                extent={{-78,92},{-37,72}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{70,-80},{94,-91}},
                lineColor={0,0,0},
                textString="time"),
              Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
              Line(
                points={{-19,-20},{50,-20}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Line(
                points={{50,50},{101,50}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{50,50},{50,-20}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Polygon(
                points={{50,-20},{42,-18},{42,-22},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,50},{48,40},{52,40},{50,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,-20},{48,-10},{52,-10},{50,-20},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{53,23},{82,10}},
                lineColor={0,0,0},
                textString="height"),
              Text(
                extent={{-2,-21},{37,-33}},
                lineColor={0,0,0},
                textString="duration")}),
          Documentation(info="<html>
<p>
The Real output y is a ramp signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\"
     alt=\"Ramp.png\">
</p>

<p>
If parameter duration is set to 0.0, the limiting case of a Step signal is achieved.
</p>
</html>"));
      end Ramp;
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

    package Types
      "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.TypesPackage;

      type Init = enumeration(
          NoInit
            "No initialization (start values are used as guess values with fixed=false)",

          SteadyState
            "Steady state initialization (derivatives of states are zero)",
          InitialState "Initialization with initial states",
          InitialOutput
            "Initialization with initial outputs (and steady state of the states if possible)")
        "Enumeration defining initialization of a block" annotation (Evaluate=true,
        Documentation(info="<html>
  <p>The following initialization alternatives are available:</p>
  <dl>
    <dt><code><strong>NoInit</strong></code></dt>
      <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
    <dt><code><strong>SteadyState</strong></code></dt>
      <dd>Steady state initialization (derivatives of states are zero)</dd>
    <dt><code><strong>InitialState</strong></code></dt>
      <dd>Initialization with initial states</dd>
    <dt><code><strong>InitialOutput</strong></code></dt>
      <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
  </dl>
</html>"));

      annotation (Documentation(info="<HTML>
<p>
In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
    end Types;

    package Icons "Icons for Blocks"
        extends Modelica.Icons.IconsPackage;

        partial block Block "Basic graphical layout of input/output block"

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-100,-100},{100,100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));

        end Block;
    end Icons;
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

  package Media "Library of media property models"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import Cv = Modelica.SIunits.Conversions;

  package Interfaces "Interfaces for media models"
    extends Modelica.Icons.InterfacesPackage;

    partial package PartialMedium
        "Partial medium properties (base package of all media packages)"
      extends Modelica.Media.Interfaces.Types;
      extends Modelica.Icons.MaterialPropertiesPackage;

      // Constants to be set in Medium
      constant Modelica.Media.Interfaces.Choices.IndependentVariables
        ThermoStates "Enumeration type for independent variables";
      constant String mediumName="unusablePartialMedium" "Name of the medium";
      constant String substanceNames[:]={mediumName}
          "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
      constant String extraPropertiesNames[:]=fill("", 0)
          "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
      constant Boolean singleState
          "= true, if u and d are not a function of pressure";
      constant Boolean reducedX=true
          "= true if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
      constant Boolean fixedX=false
          "= true if medium contains the equation X = reference_X";
      constant AbsolutePressure reference_p=101325
          "Reference pressure of Medium: default 1 atmosphere";
      constant Temperature reference_T=298.15
          "Reference temperature of Medium: default 25 deg Celsius";
      constant MassFraction reference_X[nX]=fill(1/nX, nX)
          "Default mass fractions of medium";
      constant AbsolutePressure p_default=101325
          "Default value for pressure of medium (for initialization)";
      constant Temperature T_default=Modelica.SIunits.Conversions.from_degC(20)
          "Default value for temperature of medium (for initialization)";
      constant SpecificEnthalpy h_default=specificEnthalpy_pTX(
              p_default,
              T_default,
              X_default)
          "Default value for specific enthalpy of medium (for initialization)";
      constant MassFraction X_default[nX]=reference_X
          "Default value for mass fractions of medium (for initialization)";

      final constant Integer nS=size(substanceNames, 1) "Number of substances"
        annotation (Evaluate=true);
      constant Integer nX=nS "Number of mass fractions" annotation (Evaluate=true);
      constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
          "Number of structurally independent mass fractions (see docu for details)"
        annotation (Evaluate=true);

      final constant Integer nC=size(extraPropertiesNames, 1)
          "Number of extra (outside of standard mass-balance) transported properties"
        annotation (Evaluate=true);
      constant Real C_nominal[nC](min=fill(Modelica.Constants.eps, nC)) = 1.0e-6*
        ones(nC) "Default for the nominal values for the extra properties";
      replaceable record FluidConstants =
          Modelica.Media.Interfaces.Types.Basic.FluidConstants
          "Critical, triple, molecular and other standard data of fluid";

      replaceable record ThermodynamicState
          "Minimal variable set that is available as input argument to every medium function"
        extends Modelica.Icons.Record;
      end ThermodynamicState;

      replaceable partial model BaseProperties
          "Base properties (p, d, T, h, u, R, MM and, if applicable, X and Xi) of a medium"
        InputAbsolutePressure p "Absolute pressure of medium";
        InputMassFraction[nXi] Xi(start=reference_X[1:nXi])
            "Structurally independent mass fractions";
        InputSpecificEnthalpy h "Specific enthalpy of medium";
        Density d "Density of medium";
        Temperature T "Temperature of medium";
        MassFraction[nX] X(start=reference_X)
            "Mass fractions (= (component mass)/total mass  m_i/m)";
        SpecificInternalEnergy u "Specific internal energy of medium";
        SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
        MolarMass MM "Molar mass (of mixture or single fluid)";
        ThermodynamicState state
            "Thermodynamic state record for optional functions";
        parameter Boolean preferredMediumStates=false
            "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean standardOrderComponents=true
            "If true, and reducedX = true, the last element of X will be computed from the other ones";
        SI.Conversions.NonSIunits.Temperature_degC T_degC=
            Modelica.SIunits.Conversions.to_degC(T)
            "Temperature of medium in [degC]";
        SI.Conversions.NonSIunits.Pressure_bar p_bar=
            Modelica.SIunits.Conversions.to_bar(p)
            "Absolute pressure of medium in [bar]";

        // Local connector definition, used for equation balancing check
        connector InputAbsolutePressure = input SI.AbsolutePressure
            "Pressure as input signal connector";
        connector InputSpecificEnthalpy = input SI.SpecificEnthalpy
            "Specific enthalpy as input signal connector";
        connector InputMassFraction = input SI.MassFraction
            "Mass fraction as input signal connector";

      equation
        if standardOrderComponents then
          Xi = X[1:nXi];

          if fixedX then
            X = reference_X;
          end if;
          if reducedX and not fixedX then
            X[nX] = 1 - sum(Xi);
          end if;
          for i in 1:nX loop
            assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
              String(i) + "] = " + String(X[i]) + "of substance " +
              substanceNames[i] + "\nof medium " + mediumName +
              " is not in the range 0..1");
          end for;

        end if;

        assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
          mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}), Text(
                extent={{-152,164},{152,102}},
                textString="%name",
                lineColor={0,0,255})}), Documentation(info="<html>
<p>
Model <b>BaseProperties</b> is a model within package <b>PartialMedium</b>
and contains the <b>declarations</b> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <b>BaseProperties</b> and provides
the equations for the basic properties.</p>
<p>
The BaseProperties model contains the following <b>7+nXi variables</b>
(nXi is the number of independent mass fractions defined in package
PartialMedium):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">absolute pressure</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">Xi[nXi]</td>
      <td valign=\"top\">kg/kg</td>
      <td valign=\"top\">independent mass fractions m_i/m</td></tr>
  <tr><td valign=\"top\">R</td>
      <td valign=\"top\">J/kg.K</td>
      <td valign=\"top\">gas constant</td></tr>
  <tr><td valign=\"top\">M</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>
In order to implement an actual medium model, one can extend from this
base model and add <b>5 equations</b> that provide relations among
these variables. Equations will also have to be added in order to
set all the variables within the ThermodynamicState record state.</p>
<p>
If standardOrderComponents=true, the full composition vector X[nX]
is determined by the equations contained in this base class, depending
on the independent mass fraction vector Xi[nXi].</p>
<p>Additional <b>2 + nXi</b> equations will have to be provided
when using the BaseProperties model, in order to fully specify the
thermodynamic conditions. The input connector qualifier applied to
p, h, and nXi indirectly declares the number of missing equations,
permitting advanced equation balance checking by Modelica tools.
Please note that this doesn't mean that the additional equations
should be connection equations, nor that exactly those variables
should be supplied, in order to complete the model.
For further information, see the Modelica.Media User's guide, and
Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</p>
</html>"));
      end BaseProperties;

      replaceable partial function setState_pTX
          "Return thermodynamic state as function of p, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      end setState_pTX;

      replaceable partial function setState_phX
          "Return thermodynamic state as function of p, h and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      end setState_phX;

      replaceable partial function setState_psX
          "Return thermodynamic state as function of p, s and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      end setState_psX;

      replaceable partial function setState_dTX
          "Return thermodynamic state as function of d, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      end setState_dTX;

      replaceable partial function setSmoothState
          "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        extends Modelica.Icons.Function;
        input Real x "m_flow or dp";
        input ThermodynamicState state_a "Thermodynamic state if x > 0";
        input ThermodynamicState state_b "Thermodynamic state if x < 0";
        input Real x_small(min=0)
            "Smooth transition in the region -x_small < x < x_small";
        output ThermodynamicState state
            "Smooth thermodynamic state for all x (continuous and differentiable)";
        annotation (Documentation(info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    state = <b>if</b> x &gt; 0 <b>then</b> state_a <b>else</b> state_b;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   state := <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> state_a <b>else</b>
                      <b>if</b> x &lt; -x_small <b>then</b> state_b <b>else</b> f(state_a, state_b));
</pre>

<p>
This is performed by applying function <b>Media.Common.smoothStep</b>(..)
on every element of the thermodynamic state record.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(state.X) = 1, provided sum(state_a.X) = sum(state_b.X) = 1.
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise state.X is either state_a.X or state_b.X):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>

</html>"));
      end setSmoothState;

      replaceable partial function dynamicViscosity "Return dynamic viscosity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output DynamicViscosity eta "Dynamic viscosity";
      end dynamicViscosity;

      replaceable partial function thermalConductivity
          "Return thermal conductivity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output ThermalConductivity lambda "Thermal conductivity";
      end thermalConductivity;

      replaceable function prandtlNumber "Return the Prandtl number"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output PrandtlNumber Pr "Prandtl number";
      algorithm
        Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/
          thermalConductivity(state);
      end prandtlNumber;

      replaceable partial function pressure "Return pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output AbsolutePressure p "Pressure";
      end pressure;

      replaceable partial function temperature "Return temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output Temperature T "Temperature";
      end temperature;

      replaceable partial function density "Return density"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output Density d "Density";
      end density;

      replaceable partial function specificEnthalpy "Return specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificEnthalpy h "Specific enthalpy";
      end specificEnthalpy;

      replaceable partial function specificInternalEnergy
          "Return specific internal energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificEnergy u "Specific internal energy";
      end specificInternalEnergy;

      replaceable partial function specificEntropy "Return specific entropy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificEntropy s "Specific entropy";
      end specificEntropy;

      replaceable partial function specificGibbsEnergy
          "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificEnergy g "Specific Gibbs energy";
      end specificGibbsEnergy;

      replaceable partial function specificHelmholtzEnergy
          "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificEnergy f "Specific Helmholtz energy";
      end specificHelmholtzEnergy;

      replaceable partial function specificHeatCapacityCp
          "Return specific heat capacity at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificHeatCapacity cp
            "Specific heat capacity at constant pressure";
      end specificHeatCapacityCp;

      function heatCapacity_cp = specificHeatCapacityCp
          "Alias for deprecated name";

      replaceable partial function specificHeatCapacityCv
          "Return specific heat capacity at constant volume"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SpecificHeatCapacity cv
            "Specific heat capacity at constant volume";
      end specificHeatCapacityCv;

      function heatCapacity_cv = specificHeatCapacityCv
          "Alias for deprecated name";

      replaceable partial function isentropicExponent
          "Return isentropic exponent"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output IsentropicExponent gamma "Isentropic exponent";
      end isentropicExponent;

      replaceable partial function isentropicEnthalpy
          "Return isentropic enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p_downstream "Downstream pressure";
        input ThermodynamicState refState "Reference state for entropy";
        output SpecificEnthalpy h_is "Isentropic enthalpy";
        annotation (Documentation(info="<html>
<p>
This function computes an isentropic state transformation:
</p>
<ol>
<li> A medium is in a particular state, refState.</li>
<li> The enthalpy at another state (h_is) shall be computed
     under the assumption that the state transformation from refState to h_is
     is performed with a change of specific entropy ds = 0 and the pressure of state h_is
     is p_downstream and the composition X upstream and downstream is assumed to be the same.</li>
</ol>

</html>"));
      end isentropicEnthalpy;

      replaceable partial function velocityOfSound "Return velocity of sound"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output VelocityOfSound a "Velocity of sound";
      end velocityOfSound;

      replaceable partial function isobaricExpansionCoefficient
          "Return overall the isobaric expansion coefficient beta"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output IsobaricExpansionCoefficient beta
            "Isobaric expansion coefficient";
        annotation (Documentation(info="<html>
<pre>
beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre>
</html>"));
      end isobaricExpansionCoefficient;

      function beta = isobaricExpansionCoefficient
          "Alias for isobaricExpansionCoefficient for user convenience";

      replaceable partial function isothermalCompressibility
          "Return overall the isothermal compressibility factor"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output SI.IsothermalCompressibility kappa "Isothermal compressibility";
        annotation (Documentation(info="<html>
<pre>

kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

</pre>
</html>"));
      end isothermalCompressibility;

      function kappa = isothermalCompressibility
          "Alias of isothermalCompressibility for user convenience";

      // explicit derivative functions for finite element models
      replaceable partial function density_derp_h
          "Return density derivative w.r.t. pressure at const specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
      end density_derp_h;

      replaceable partial function density_derh_p
          "Return density derivative w.r.t. specific enthalpy at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output DerDensityByEnthalpy ddhp
            "Density derivative w.r.t. specific enthalpy";
      end density_derh_p;

      replaceable partial function density_derp_T
          "Return density derivative w.r.t. pressure at const temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
      end density_derp_T;

      replaceable partial function density_derT_p
          "Return density derivative w.r.t. temperature at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output DerDensityByTemperature ddTp
            "Density derivative w.r.t. temperature";
      end density_derT_p;

      replaceable partial function density_derX
          "Return density derivative w.r.t. mass fraction"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
      end density_derX;

      replaceable partial function molarMass
          "Return the molar mass of the medium"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output MolarMass MM "Mixture molar mass";
      end molarMass;

      replaceable function specificEnthalpy_pTX
          "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_pTX(
                p,
                T,
                X));
        annotation (inverse(T=temperature_phX(
                      p,
                      h,
                      X)));
      end specificEnthalpy_pTX;

      replaceable function specificEntropy_pTX
          "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEntropy s "Specific entropy";
      algorithm
        s := specificEntropy(setState_pTX(
                p,
                T,
                X));

        annotation (inverse(T=temperature_psX(
                      p,
                      s,
                      X)));
      end specificEntropy_pTX;

      replaceable function density_pTX "Return density from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:] "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(
                p,
                T,
                X));
      end density_pTX;

      replaceable function temperature_phX
          "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_phX(
                p,
                h,
                X));
      end temperature_phX;

      replaceable function density_phX "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_phX(
                p,
                h,
                X));
      end density_phX;

      replaceable function temperature_psX
          "Return temperature from p,s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_psX(
                p,
                s,
                X));
        annotation (inverse(s=specificEntropy_pTX(
                      p,
                      T,
                      X)));
      end temperature_psX;

      replaceable function density_psX "Return density from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_psX(
                p,
                s,
                X));
      end density_psX;

      replaceable function specificEnthalpy_psX
          "Return specific enthalpy from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(
                p,
                s,
                X));
      end specificEnthalpy_psX;

      type MassFlowRate = SI.MassFlowRate (
          quantity="MassFlowRate." + mediumName,
          min=-1.0e5,
          max=1.e5) "Type for mass flow rate with medium specific attributes";

      // Only for backwards compatibility to version 3.2 (
      // (do not use these definitions in new models, but use Modelica.Media.Interfaces.Choices instead)
      package Choices = Modelica.Media.Interfaces.Choices annotation (obsolete=
            "Use Modelica.Media.Interfaces.Choices");

      annotation (Documentation(info="<html>
<p>
<b>PartialMedium</b> is a package and contains all <b>declarations</b> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <b>PartialMedium</b> and provides the
equations for the medium. The details of this package
are described in
<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>",   revisions="<html>

</html>"));
    end PartialMedium;

    partial package PartialPureSubstance
        "Base class for pure substances of one chemical substance"
      extends PartialMedium(final reducedX=true, final fixedX=true);

      replaceable function setState_pT
          "Return thermodynamic state from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_pTX(
                p,
                T,
                fill(0, 0));
      end setState_pT;

      replaceable function setState_ph
          "Return thermodynamic state from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_phX(
                p,
                h,
                fill(0, 0));
      end setState_ph;

      replaceable function setState_ps
          "Return thermodynamic state from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_psX(
                p,
                s,
                fill(0, 0));
      end setState_ps;

      replaceable function setState_dT
          "Return thermodynamic state from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_dTX(
                d,
                T,
                fill(0, 0));
      end setState_dT;

      replaceable function density_ph "Return density from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output Density d "Density";
      algorithm
        d := density_phX(
                p,
                h,
                fill(0, 0));
      end density_ph;

      replaceable function temperature_ph "Return temperature from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output Temperature T "Temperature";
      algorithm
        T := temperature_phX(
                p,
                h,
                fill(0, 0));
      end temperature_ph;

      replaceable function pressure_dT "Return pressure from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output AbsolutePressure p "Pressure";
      algorithm
        p := pressure(setState_dTX(
                d,
                T,
                fill(0, 0)));
      end pressure_dT;

      replaceable function specificEnthalpy_dT
          "Return specific enthalpy from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_dTX(
                d,
                T,
                fill(0, 0)));
      end specificEnthalpy_dT;

      replaceable function specificEnthalpy_ps
          "Return specific enthalpy from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy_psX(
                p,
                s,
                fill(0, 0));
      end specificEnthalpy_ps;

      replaceable function temperature_ps "Return temperature from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Temperature T "Temperature";
      algorithm
        T := temperature_psX(
                p,
                s,
                fill(0, 0));
      end temperature_ps;

      replaceable function density_ps "Return density from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Density d "Density";
      algorithm
        d := density_psX(
                p,
                s,
                fill(0, 0));
      end density_ps;

      replaceable function specificEnthalpy_pT
          "Return specific enthalpy from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy_pTX(
                p,
                T,
                fill(0, 0));
      end specificEnthalpy_pT;

      replaceable function density_pT "Return density from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(
                p,
                T,
                fill(0, 0)));
      end density_pT;

      redeclare replaceable partial model extends BaseProperties(final
          standardOrderComponents=true)
      end BaseProperties;
    end PartialPureSubstance;

    partial package PartialMixtureMedium
        "Base class for pure substances of several chemical substances"
      extends PartialMedium(redeclare replaceable record FluidConstants =
            Modelica.Media.Interfaces.Types.IdealGas.FluidConstants);

      redeclare replaceable record extends ThermodynamicState
          "Thermodynamic state variables"
        AbsolutePressure p "Absolute pressure of medium";
        Temperature T "Temperature of medium";
        MassFraction X[nX]
            "Mass fractions (= (component mass)/total mass  m_i/m)";
      end ThermodynamicState;

      constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

      replaceable function gasConstant
          "Return the gas constant of the mixture (also for liquids)"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state";
        output SI.SpecificHeatCapacity R "Mixture gas constant";
      end gasConstant;

      function moleToMassFractions
          "Return mass fractions X from mole fractions"
        extends Modelica.Icons.Function;
        input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
        input MolarMass[:] MMX "Molar masses of components";
        output SI.MassFraction X[size(moleFractions, 1)]
            "Mass fractions of gas mixture";
        protected
        MolarMass Mmix=moleFractions*MMX "Molar mass of mixture";
      algorithm
        for i in 1:size(moleFractions, 1) loop
          X[i] := moleFractions[i]*MMX[i]/Mmix;
        end for;
        annotation (smoothOrder=5);
      end moleToMassFractions;

      function massToMoleFractions
          "Return mole fractions from mass fractions X"
        extends Modelica.Icons.Function;
        input SI.MassFraction X[:] "Mass fractions of mixture";
        input SI.MolarMass[:] MMX "Molar masses of components";
        output SI.MoleFraction moleFractions[size(X, 1)]
            "Mole fractions of gas mixture";
        protected
        Real invMMX[size(X, 1)] "Inverses of molar weights";
        SI.MolarMass Mmix "Molar mass of mixture";
      algorithm
        for i in 1:size(X, 1) loop
          invMMX[i] := 1/MMX[i];
        end for;
        Mmix := 1/(X*invMMX);
        for i in 1:size(X, 1) loop
          moleFractions[i] := Mmix*X[i]/MMX[i];
        end for;
        annotation (smoothOrder=5);
      end massToMoleFractions;

    end PartialMixtureMedium;

    partial package PartialTwoPhaseMedium
        "Base class for two phase medium of one substance"
      extends PartialPureSubstance(redeclare record FluidConstants =
            Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);
      constant Boolean smoothModel=false
          "True if the (derived) model should not generate state events";
      constant Boolean onePhase=false
          "True if the (derived) model should never be called with two-phase inputs";

      constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

      redeclare replaceable record extends ThermodynamicState
          "Thermodynamic state of two phase medium"
        FixedPhase phase(min=0, max=2)
            "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
      end ThermodynamicState;

      redeclare replaceable partial model extends BaseProperties
          "Base properties (p, d, T, h, u, R, MM, sat) of two phase medium"
        SaturationProperties sat "Saturation properties at the medium pressure";
      end BaseProperties;

      replaceable partial function setDewState
          "Return the thermodynamic state on the dew line"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation point";
        input FixedPhase phase(
          min=1,
          max=2) = 1 "Phase: default is one phase";
        output ThermodynamicState state "Complete thermodynamic state info";
      end setDewState;

      replaceable partial function setBubbleState
          "Return the thermodynamic state on the bubble line"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation point";
        input FixedPhase phase(
          min=1,
          max=2) = 1 "Phase: default is one phase";
        output ThermodynamicState state "Complete thermodynamic state info";
      end setBubbleState;

      redeclare replaceable partial function extends setState_dTX
          "Return thermodynamic state as function of d, T and composition X or Xi"
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
      end setState_dTX;

      redeclare replaceable partial function extends setState_phX
          "Return thermodynamic state as function of p, h and composition X or Xi"
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
      end setState_phX;

      redeclare replaceable partial function extends setState_psX
          "Return thermodynamic state as function of p, s and composition X or Xi"
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
      end setState_psX;

      redeclare replaceable partial function extends setState_pTX
          "Return thermodynamic state as function of p, T and composition X or Xi"
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
      end setState_pTX;

      replaceable function setSat_T
          "Return saturation property record from temperature"
        extends Modelica.Icons.Function;
        input Temperature T "Temperature";
        output SaturationProperties sat "Saturation property record";
      algorithm
        sat.Tsat := T;
        sat.psat := saturationPressure(T);
      end setSat_T;

      replaceable function setSat_p
          "Return saturation property record from pressure"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        output SaturationProperties sat "Saturation property record";
      algorithm
        sat.psat := p;
        sat.Tsat := saturationTemperature(p);
      end setSat_p;

      replaceable partial function bubbleEnthalpy
          "Return bubble point specific enthalpy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output SI.SpecificEnthalpy hl "Boiling curve specific enthalpy";
      end bubbleEnthalpy;

      replaceable partial function dewEnthalpy
          "Return dew point specific enthalpy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output SI.SpecificEnthalpy hv "Dew curve specific enthalpy";
      end dewEnthalpy;

      replaceable partial function bubbleEntropy
          "Return bubble point specific entropy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output SI.SpecificEntropy sl "Boiling curve specific entropy";
      end bubbleEntropy;

      replaceable partial function dewEntropy
          "Return dew point specific entropy"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output SI.SpecificEntropy sv "Dew curve specific entropy";
      end dewEntropy;

      replaceable partial function bubbleDensity "Return bubble point density"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output Density dl "Boiling curve density";
      end bubbleDensity;

      replaceable partial function dewDensity "Return dew point density"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output Density dv "Dew curve density";
      end dewDensity;

      replaceable partial function saturationPressure
          "Return saturation pressure"
        extends Modelica.Icons.Function;
        input Temperature T "Temperature";
        output AbsolutePressure p "Saturation pressure";
      end saturationPressure;

      replaceable partial function saturationTemperature
          "Return saturation temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        output Temperature T "Saturation temperature";
      end saturationTemperature;

      replaceable function saturationPressure_sat
          "Return saturation temperature"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output AbsolutePressure p "Saturation pressure";
      algorithm
        p := sat.psat;
      end saturationPressure_sat;

      replaceable function saturationTemperature_sat
          "Return saturation temperature"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output Temperature T "Saturation temperature";
      algorithm
        T := sat.Tsat;
      end saturationTemperature_sat;

      replaceable partial function saturationTemperature_derp
          "Return derivative of saturation temperature w.r.t. pressure"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        output DerTemperatureByPressure dTp
            "Derivative of saturation temperature w.r.t. pressure";
      end saturationTemperature_derp;

      replaceable function saturationTemperature_derp_sat
          "Return derivative of saturation temperature w.r.t. pressure"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output DerTemperatureByPressure dTp
            "Derivative of saturation temperature w.r.t. pressure";
      algorithm
        dTp := saturationTemperature_derp(sat.psat);
      end saturationTemperature_derp_sat;

      replaceable partial function surfaceTension
          "Return surface tension sigma in the two phase region"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output SurfaceTension sigma
            "Surface tension sigma in the two phase region";
      end surfaceTension;

      redeclare replaceable function extends molarMass
          "Return the molar mass of the medium"
      algorithm
        MM := fluidConstants[1].molarMass;
      end molarMass;

      replaceable partial function dBubbleDensity_dPressure
          "Return bubble point density derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output DerDensityByPressure ddldp "Boiling curve density derivative";
      end dBubbleDensity_dPressure;

      replaceable partial function dDewDensity_dPressure
          "Return dew point density derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output DerDensityByPressure ddvdp "Saturated steam density derivative";
      end dDewDensity_dPressure;

      replaceable partial function dBubbleEnthalpy_dPressure
          "Return bubble point specific enthalpy derivative"
        extends Modelica.Icons.Function;
        input SaturationProperties sat "Saturation property record";
        output DerEnthalpyByPressure dhldp
            "Boiling curve specific enthalpy derivative";
      end dBubbleEnthalpy_dPressure;

      replaceable partial function dDewEnthalpy_dPressure
          "Return dew point specific enthalpy derivative"
        extends Modelica.Icons.Function;

        input SaturationProperties sat "Saturation property record";
        output DerEnthalpyByPressure dhvdp
            "Saturated steam specific enthalpy derivative";
      end dDewEnthalpy_dPressure;

      redeclare replaceable function specificEnthalpy_pTX
          "Return specific enthalpy from pressure, temperature and mass fraction"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy at p, T, X";
      algorithm
        h := specificEnthalpy(setState_pTX(
                p,
                T,
                X,
                phase));
      end specificEnthalpy_pTX;

      redeclare replaceable function temperature_phX
          "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_phX(
                p,
                h,
                X,
                phase));
      end temperature_phX;

      redeclare replaceable function density_phX
          "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density(setState_phX(
                p,
                h,
                X,
                phase));
      end density_phX;

      redeclare replaceable function temperature_psX
          "Return temperature from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_psX(
                p,
                s,
                X,
                phase));
      end temperature_psX;

      redeclare replaceable function density_psX
          "Return density from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density(setState_psX(
                p,
                s,
                X,
                phase));
      end density_psX;

      redeclare replaceable function specificEnthalpy_psX
          "Return specific enthalpy from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:] "Mass fractions";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(
                p,
                s,
                X,
                phase));
      end specificEnthalpy_psX;

      redeclare replaceable function setState_pT
          "Return thermodynamic state from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_pTX(
                p,
                T,
                fill(0, 0),
                phase);
      end setState_pT;

      redeclare replaceable function setState_ph
          "Return thermodynamic state from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_phX(
                p,
                h,
                fill(0, 0),
                phase);
      end setState_ph;

      redeclare replaceable function setState_ps
          "Return thermodynamic state from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_psX(
                p,
                s,
                fill(0, 0),
                phase);
      end setState_ps;

      redeclare replaceable function setState_dT
          "Return thermodynamic state from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_dTX(
                d,
                T,
                fill(0, 0),
                phase);
      end setState_dT;

      replaceable function setState_px
          "Return thermodynamic state from pressure and vapour quality"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input MassFraction x "Vapour quality";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_ph(
                p,
                (1 - x)*bubbleEnthalpy(setSat_p(p)) + x*dewEnthalpy(setSat_p(p)),
                2);
      end setState_px;

      replaceable function setState_Tx
          "Return thermodynamic state from temperature and vapour quality"
        extends Modelica.Icons.Function;
        input Temperature T "Temperature";
        input MassFraction x "Vapour quality";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := setState_ph(
                saturationPressure_sat(setSat_T(T)),
                (1 - x)*bubbleEnthalpy(setSat_T(T)) + x*dewEnthalpy(setSat_T(T)),
                2);
      end setState_Tx;

      replaceable function vapourQuality "Return vapour quality"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state record";
        output MassFraction x "Vapour quality";
        protected
        constant SpecificEnthalpy eps=1e-8;
      algorithm
        x := min(max((specificEnthalpy(state) - bubbleEnthalpy(setSat_p(pressure(
          state))))/(dewEnthalpy(setSat_p(pressure(state))) - bubbleEnthalpy(
          setSat_p(pressure(state))) + eps), 0), 1);
      end vapourQuality;

      redeclare replaceable function density_ph "Return density from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density_phX(
                p,
                h,
                fill(0, 0),
                phase);
      end density_ph;

      redeclare replaceable function temperature_ph
          "Return temperature from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature_phX(
                p,
                h,
                fill(0, 0),
                phase);
      end temperature_ph;

      redeclare replaceable function pressure_dT "Return pressure from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output AbsolutePressure p "Pressure";
      algorithm
        p := pressure(setState_dTX(
                d,
                T,
                fill(0, 0),
                phase));
      end pressure_dT;

      redeclare replaceable function specificEnthalpy_dT
          "Return specific enthalpy from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_dTX(
                d,
                T,
                fill(0, 0),
                phase));
      end specificEnthalpy_dT;

      redeclare replaceable function specificEnthalpy_ps
          "Return specific enthalpy from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy_psX(
                p,
                s,
                fill(0, 0));
      end specificEnthalpy_ps;

      redeclare replaceable function temperature_ps
          "Return temperature from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature_psX(
                p,
                s,
                fill(0, 0),
                phase);
      end temperature_ps;

      redeclare replaceable function density_ps "Return density from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density_psX(
                p,
                s,
                fill(0, 0),
                phase);
      end density_ps;

      redeclare replaceable function specificEnthalpy_pT
          "Return specific enthalpy from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy_pTX(
                p,
                T,
                fill(0, 0),
                phase);
      end specificEnthalpy_pT;

      redeclare replaceable function density_pT "Return density from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(
                p,
                T,
                fill(0, 0),
                phase));
      end density_pT;
    end PartialTwoPhaseMedium;

    partial package PartialSimpleMedium
        "Medium model with linear dependency of u, h from temperature. All other quantities, especially density, are constant."

      extends Interfaces.PartialPureSubstance(final ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
          final singleState=true);

      constant SpecificHeatCapacity cp_const
          "Constant specific heat capacity at constant pressure";
      constant SpecificHeatCapacity cv_const
          "Constant specific heat capacity at constant volume";
      constant Density d_const "Constant density";
      constant DynamicViscosity eta_const "Constant dynamic viscosity";
      constant ThermalConductivity lambda_const "Constant thermal conductivity";
      constant VelocityOfSound a_const "Constant velocity of sound";
      constant Temperature T_min "Minimum temperature valid for medium model";
      constant Temperature T_max "Maximum temperature valid for medium model";
      constant Temperature T0=reference_T "Zero enthalpy temperature";
      constant MolarMass MM_const "Molar mass";

      constant FluidConstants[nS] fluidConstants "Fluid constants";

      redeclare record extends ThermodynamicState "Thermodynamic state"
        AbsolutePressure p "Absolute pressure of medium";
        Temperature T "Temperature of medium";
      end ThermodynamicState;

      redeclare replaceable model extends BaseProperties(T(stateSelect=if
              preferredMediumStates then StateSelect.prefer else StateSelect.default),
          p(stateSelect=if preferredMediumStates then StateSelect.prefer else
              StateSelect.default)) "Base properties"
      equation
        assert(T >= T_min and T <= T_max, "
Temperature T (= "   + String(T) + " K) is not
in the allowed range ("   + String(T_min) + " K <= T <= " + String(T_max) + " K)
required from medium model \""   + mediumName + "\".
");

        // h = cp_const*(T-T0);
        h = specificEnthalpy_pTX(
                p,
                T,
                X);
        u = cv_const*(T - T0);
        d = d_const;
        R = 0;
        MM = MM_const;
        state.T = T;
        state.p = p;
        annotation (Documentation(info="<HTML>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
Note that the (small) influence of the pressure term p/d is neglected.
</p>
</HTML>"));
      end BaseProperties;

      redeclare function setState_pTX
          "Return thermodynamic state from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p, T=T);
      end setState_pTX;

      redeclare function setState_phX
          "Return thermodynamic state from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p, T=T0 + h/cp_const);
      end setState_phX;

      redeclare replaceable function setState_psX
          "Return thermodynamic state from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p, T=Modelica.Math.exp(s/cp_const +
          Modelica.Math.log(reference_T)))
            "Here the incompressible limit is used, with cp as heat capacity";
      end setState_psX;

      redeclare function setState_dTX
          "Return thermodynamic state from d, T, and X or Xi"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "Thermodynamic state record";
      algorithm
        assert(false,
          "Pressure can not be computed from temperature and density for an incompressible fluid!");
      end setState_dTX;

      redeclare function extends setSmoothState
          "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
        state := ThermodynamicState(p=Media.Common.smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small), T=Media.Common.smoothStep(
                x,
                state_a.T,
                state_b.T,
                x_small));
      end setSmoothState;

      redeclare function extends dynamicViscosity "Return dynamic viscosity"

      algorithm
        eta := eta_const;
      end dynamicViscosity;

      redeclare function extends thermalConductivity
          "Return thermal conductivity"

      algorithm
        lambda := lambda_const;
      end thermalConductivity;

      redeclare function extends pressure "Return pressure"

      algorithm
        p := state.p;
      end pressure;

      redeclare function extends temperature "Return temperature"

      algorithm
        T := state.T;
      end temperature;

      redeclare function extends density "Return density"

      algorithm
        d := d_const;
      end density;

      redeclare function extends specificEnthalpy "Return specific enthalpy"

      algorithm
        h := cp_const*(state.T - T0);
      end specificEnthalpy;

      redeclare function extends specificHeatCapacityCp
          "Return specific heat capacity at constant pressure"

      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
          "Return specific heat capacity at constant volume"

      algorithm
        cv := cv_const;
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent
          "Return isentropic exponent"

      algorithm
        gamma := cp_const/cv_const;
      end isentropicExponent;

      redeclare function extends velocityOfSound "Return velocity of sound"

      algorithm
        a := a_const;
      end velocityOfSound;

      redeclare function specificEnthalpy_pTX
          "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[nX] "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := cp_const*(T - T0);
        annotation (Documentation(info="<html>
<p>
This function computes the specific enthalpy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
      end specificEnthalpy_pTX;

      redeclare function temperature_phX
          "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := T0 + h/cp_const;
      end temperature_phX;

      redeclare function density_phX "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_phX(
                p,
                h,
                X));
      end density_phX;

      redeclare function extends specificInternalEnergy
          "Return specific internal energy"
        extends Modelica.Icons.Function;
      algorithm
        //  u := cv_const*(state.T - T0) - reference_p/d_const;
        u := cv_const*(state.T - T0);
        annotation (Documentation(info="<html>
<p>
This function computes the specific internal energy of the fluid, but neglects the (small) influence of the pressure term p/d.
</p>
</html>"));
      end specificInternalEnergy;

      redeclare function extends specificEntropy "Return specific entropy"
        extends Modelica.Icons.Function;
      algorithm
        s := cv_const*Modelica.Math.log(state.T/T0);
      end specificEntropy;

      redeclare function extends specificGibbsEnergy
          "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
      algorithm
        g := specificEnthalpy(state) - state.T*specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy
          "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
      algorithm
        f := specificInternalEnergy(state) - state.T*specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends isentropicEnthalpy
          "Return isentropic enthalpy"
      algorithm
        h_is := cp_const*(temperature(refState) - T0);
      end isentropicEnthalpy;

      redeclare function extends isobaricExpansionCoefficient
          "Returns overall the isobaric expansion coefficient beta"
      algorithm
        beta := 0.0;
      end isobaricExpansionCoefficient;

      redeclare function extends isothermalCompressibility
          "Returns overall the isothermal compressibility factor"
      algorithm
        kappa := 0;
      end isothermalCompressibility;

      redeclare function extends density_derp_T
          "Returns the partial derivative of density with respect to pressure at constant temperature"
      algorithm
        ddpT := 0;
      end density_derp_T;

      redeclare function extends density_derT_p
          "Returns the partial derivative of density with respect to temperature at constant pressure"
      algorithm
        ddTp := 0;
      end density_derT_p;

      redeclare function extends density_derX
          "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
      algorithm
        dddX := fill(0, nX);
      end density_derX;

      redeclare function extends molarMass
          "Return the molar mass of the medium"
      algorithm
        MM := MM_const;
      end molarMass;
    end PartialSimpleMedium;

    package Choices "Types, constants to define menu choices"
      extends Modelica.Icons.Package;

      type IndependentVariables = enumeration(
            T "Temperature",
            pT "Pressure, Temperature",
            ph "Pressure, Specific Enthalpy",
            phX "Pressure, Specific Enthalpy, Mass Fraction",
            pTX "Pressure, Temperature, Mass Fractions",
            dTX "Density, Temperature, Mass Fractions")
          "Enumeration defining the independent variables of a medium";

      type ReferenceEnthalpy = enumeration(
            ZeroAt0K
              "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",

            ZeroAt25C
              "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",

            UserDefined
              "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
          "Enumeration defining the reference enthalpy of a medium"
                                                                  annotation (
          Evaluate=true);

      annotation (Documentation(info="<html>
<p>
Enumerations and data types for all types of fluids
</p>

<p>
Note: Reference enthalpy might have to be extended with enthalpy of formation.
</p>
</html>"));
    end Choices;

    package Types "Types to be used in fluid models"
      extends Modelica.Icons.Package;

      type AbsolutePressure = SI.AbsolutePressure (
          min=0,
          max=1.e8,
          nominal=1.e5,
          start=1.e5)
          "Type for absolute pressure with medium specific attributes";

      type Density = SI.Density (
          min=0,
          max=1.e5,
          nominal=1,
          start=1) "Type for density with medium specific attributes";

      type DynamicViscosity = SI.DynamicViscosity (
          min=0,
          max=1.e8,
          nominal=1.e-3,
          start=1.e-3)
          "Type for dynamic viscosity with medium specific attributes";

      type MassFraction = Real (
          quantity="MassFraction",
          final unit="kg/kg",
          min=0,
          max=1,
          nominal=0.1) "Type for mass fraction with medium specific attributes";

      type MoleFraction = Real (
          quantity="MoleFraction",
          final unit="mol/mol",
          min=0,
          max=1,
          nominal=0.1) "Type for mole fraction with medium specific attributes";

      type MolarMass = SI.MolarMass (
          min=0.001,
          max=0.25,
          nominal=0.032) "Type for molar mass with medium specific attributes";

      type MolarVolume = SI.MolarVolume (
          min=1e-6,
          max=1.0e6,
          nominal=1.0) "Type for molar volume with medium specific attributes";

      type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
          min=1,
          max=500000,
          nominal=1.2,
          start=1.2)
          "Type for isentropic exponent with medium specific attributes";

      type SpecificEnergy = SI.SpecificEnergy (
          min=-1.0e8,
          max=1.e8,
          nominal=1.e6)
          "Type for specific energy with medium specific attributes";

      type SpecificInternalEnergy = SpecificEnergy
          "Type for specific internal energy with medium specific attributes";

      type SpecificEnthalpy = SI.SpecificEnthalpy (
          min=-1.0e10,
          max=1.e10,
          nominal=1.e6)
          "Type for specific enthalpy with medium specific attributes";

      type SpecificEntropy = SI.SpecificEntropy (
          min=-1.e7,
          max=1.e7,
          nominal=1.e3)
          "Type for specific entropy with medium specific attributes";

      type SpecificHeatCapacity = SI.SpecificHeatCapacity (
          min=0,
          max=1.e7,
          nominal=1.e3,
          start=1.e3)
          "Type for specific heat capacity with medium specific attributes";

      type SurfaceTension = SI.SurfaceTension
          "Type for surface tension with medium specific attributes";

      type Temperature = SI.Temperature (
          min=1,
          max=1.e4,
          nominal=300,
          start=300) "Type for temperature with medium specific attributes";

      type ThermalConductivity = SI.ThermalConductivity (
          min=0,
          max=500,
          nominal=1,
          start=1)
          "Type for thermal conductivity with medium specific attributes";

      type PrandtlNumber = SI.PrandtlNumber (
          min=1e-3,
          max=1e5,
          nominal=1.0)
          "Type for Prandtl number with medium specific attributes";

      type VelocityOfSound = SI.Velocity (
          min=0,
          max=1.e5,
          nominal=1000,
          start=1000)
          "Type for velocity of sound with medium specific attributes";

      type ExtraProperty = Real (min=0.0, start=1.0)
          "Type for unspecified, mass-specific property transported by flow";

      type IsobaricExpansionCoefficient = Real (
          min=0,
          max=1.0e8,
          unit="1/K")
          "Type for isobaric expansion coefficient with medium specific attributes";

      type DipoleMoment = Real (
          min=0.0,
          max=2.0,
          unit="debye",
          quantity="ElectricDipoleMoment")
          "Type for dipole moment with medium specific attributes";

      type DerDensityByPressure = SI.DerDensityByPressure
          "Type for partial derivative of density with respect to pressure with medium specific attributes";

      type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
          "Type for partial derivative of density with respect to enthalpy with medium specific attributes";

      type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
          "Type for partial derivative of enthalpy with respect to pressure with medium specific attributes";

      type DerDensityByTemperature = SI.DerDensityByTemperature
          "Type for partial derivative of density with respect to temperature with medium specific attributes";

      type DerTemperatureByPressure = Real (final unit="K/Pa")
          "Type for partial derivative of temperature with respect to pressure with medium specific attributes";

      replaceable record SaturationProperties
          "Saturation properties of two phase medium"
        extends Modelica.Icons.Record;
        AbsolutePressure psat "Saturation pressure";
        Temperature Tsat "Saturation temperature";
      end SaturationProperties;

      type FixedPhase = Integer (min=0, max=2)
          "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";

      package Basic
          "The most basic version of a record used in several degrees of detail"
        extends Icons.Package;

        record FluidConstants
            "Critical, triple, molecular and other standard data of fluid"
          extends Modelica.Icons.Record;
          String iupacName
              "Complete IUPAC name (or common name, if non-existent)";
          String casRegistryNumber
              "Chemical abstracts sequencing number (if it exists)";
          String chemicalFormula
              "Chemical formula, (brutto, nomenclature according to Hill";
          String structureFormula "Chemical structure formula";
          MolarMass molarMass "Molar mass";
        end FluidConstants;
      end Basic;

      package IdealGas
          "The ideal gas version of a record used in several degrees of detail"
        extends Icons.Package;

        record FluidConstants "Extended fluid constants"
          extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
          Temperature criticalTemperature "Critical temperature";
          AbsolutePressure criticalPressure "Critical pressure";
          MolarVolume criticalMolarVolume "Critical molar Volume";
          Real acentricFactor "Pitzer acentric factor";
          //   Temperature triplePointTemperature "Triple point temperature";
          //   AbsolutePressure triplePointPressure "Triple point pressure";
          Temperature meltingPoint "Melting point at 101325 Pa";
          Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
          DipoleMoment dipoleMoment
              "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
          Boolean hasIdealGasHeatCapacity=false
              "True if ideal gas heat capacity is available";
          Boolean hasCriticalData=false "True if critical data are known";
          Boolean hasDipoleMoment=false "True if a dipole moment known";
          Boolean hasFundamentalEquation=false "True if a fundamental equation";
          Boolean hasLiquidHeatCapacity=false
              "True if liquid heat capacity is available";
          Boolean hasSolidHeatCapacity=false
              "True if solid heat capacity is available";
          Boolean hasAccurateViscosityData=false
              "True if accurate data for a viscosity function is available";
          Boolean hasAccurateConductivityData=false
              "True if accurate data for thermal conductivity is available";
          Boolean hasVapourPressureCurve=false
              "True if vapour pressure data, e.g., Antoine coefficents are known";
          Boolean hasAcentricFactor=false
              "True if Pitzer accentric factor is known";
          SpecificEnthalpy HCRIT0=0.0
              "Critical specific enthalpy of the fundamental equation";
          SpecificEntropy SCRIT0=0.0
              "Critical specific entropy of the fundamental equation";
          SpecificEnthalpy deltah=0.0
              "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
          SpecificEntropy deltas=0.0
              "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
        end FluidConstants;
      end IdealGas;

      package TwoPhase
          "The two phase fluid version of a record used in several degrees of detail"
        extends Icons.Package;

        record FluidConstants "Extended fluid constants"
          extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
          Temperature criticalTemperature "Critical temperature";
          AbsolutePressure criticalPressure "Critical pressure";
          MolarVolume criticalMolarVolume "Critical molar Volume";
          Real acentricFactor "Pitzer acentric factor";
          Temperature triplePointTemperature "Triple point temperature";
          AbsolutePressure triplePointPressure "Triple point pressure";
          Temperature meltingPoint "Melting point at 101325 Pa";
          Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
          DipoleMoment dipoleMoment
              "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
          Boolean hasIdealGasHeatCapacity=false
              "True if ideal gas heat capacity is available";
          Boolean hasCriticalData=false "True if critical data are known";
          Boolean hasDipoleMoment=false "True if a dipole moment known";
          Boolean hasFundamentalEquation=false "True if a fundamental equation";
          Boolean hasLiquidHeatCapacity=false
              "True if liquid heat capacity is available";
          Boolean hasSolidHeatCapacity=false
              "True if solid heat capacity is available";
          Boolean hasAccurateViscosityData=false
              "True if accurate data for a viscosity function is available";
          Boolean hasAccurateConductivityData=false
              "True if accurate data for thermal conductivity is available";
          Boolean hasVapourPressureCurve=false
              "True if vapour pressure data, e.g., Antoine coefficents are known";
          Boolean hasAcentricFactor=false
              "True if Pitzer accentric factor is known";
          SpecificEnthalpy HCRIT0=0.0
              "Critical specific enthalpy of the fundamental equation";
          SpecificEntropy SCRIT0=0.0
              "Critical specific entropy of the fundamental equation";
          SpecificEnthalpy deltah=0.0
              "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
          SpecificEntropy deltas=0.0
              "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
        end FluidConstants;
      end TwoPhase;
    end Types;
    annotation (Documentation(info="<HTML>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</HTML>"));
  end Interfaces;

  package Common
      "Data structures and fundamental functions for fluid properties"
    extends Modelica.Icons.Package;

    type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
          final unit="Pa.m3/kg");

    type DerPressureByTemperature = Real (final quantity=
            "DerPressureByTemperature", final unit="Pa/K");

    record IF97BaseTwoPhase "Intermediate property data record for IF 97"
      extends Modelica.Icons.Record;
      Integer phase=0 "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
      Integer region(min=1, max=5) "IF 97 region";
      SI.Pressure p "Pressure";
      SI.Temperature T "Temperature";
      SI.SpecificEnthalpy h "Specific enthalpy";
      SI.SpecificHeatCapacity R "Gas constant";
      SI.SpecificHeatCapacity cp "Specific heat capacity";
      SI.SpecificHeatCapacity cv "Specific heat capacity";
      SI.Density rho "Density";
      SI.SpecificEntropy s "Specific entropy";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      Real vt "Derivative of specific volume w.r.t. temperature";
      Real vp "Derivative of specific volume w.r.t. pressure";
      Real x "Dryness fraction";
      Real dpT "dp/dT derivative of saturation curve";
    end IF97BaseTwoPhase;

    record IF97PhaseBoundaryProperties
        "Thermodynamic base properties on the phase boundary for IF97 steam tables"

      extends Modelica.Icons.Record;
      Boolean region3boundary "True if boundary between 2-phase and region 3";
      SI.SpecificHeatCapacity R "Specific heat capacity";
      SI.Temperature T "Temperature";
      SI.Density d "Density";
      SI.SpecificEnthalpy h "Specific enthalpy";
      SI.SpecificEntropy s "Specific entropy";
      SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
      DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      Real vt(unit="m3/(kg.K)")
          "Derivative of specific volume w.r.t. temperature";
      Real vp(unit="m3/(kg.Pa)")
          "Derivative of specific volume w.r.t. pressure";
    end IF97PhaseBoundaryProperties;

    record GibbsDerivs
        "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature"

      extends Modelica.Icons.Record;
      SI.Pressure p "Pressure";
      SI.Temperature T "Temperature";
      SI.SpecificHeatCapacity R "Specific heat capacity";
      Real pi(unit="1") "Dimensionless pressure";
      Real tau(unit="1") "Dimensionless temperature";
      Real g(unit="1") "Dimensionless Gibbs-function";
      Real gpi(unit="1") "Derivative of g w.r.t. pi";
      Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
      Real gtau(unit="1") "Derivative of g w.r.t. tau";
      Real gtautau(unit="1") "2nd derivative of g w.r.t. tau";
      Real gtaupi(unit="1") "Mixed derivative of g w.r.t. pi and tau";
    end GibbsDerivs;

    record HelmholtzDerivs
        "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature"
      extends Modelica.Icons.Record;
      SI.Density d "Density";
      SI.Temperature T "Temperature";
      SI.SpecificHeatCapacity R "Specific heat capacity";
      Real delta(unit="1") "Dimensionless density";
      Real tau(unit="1") "Dimensionless temperature";
      Real f(unit="1") "Dimensionless Helmholtz-function";
      Real fdelta(unit="1") "Derivative of f w.r.t. delta";
      Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
      Real ftau(unit="1") "Derivative of f w.r.t. tau";
      Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
      Real fdeltatau(unit="1") "Mixed derivative of f w.r.t. delta and tau";
    end HelmholtzDerivs;

    record PhaseBoundaryProperties
        "Thermodynamic base properties on the phase boundary"
      extends Modelica.Icons.Record;
      SI.Density d "Density";
      SI.SpecificEnthalpy h "Specific enthalpy";
      SI.SpecificEnergy u "Inner energy";
      SI.SpecificEntropy s "Specific entropy";
      SI.SpecificHeatCapacity cp "Heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv "Heat capacity at constant volume";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    end PhaseBoundaryProperties;

    record NewtonDerivatives_ph
        "Derivatives for fast inverse calculations of Helmholtz functions: p & h"

      extends Modelica.Icons.Record;
      SI.Pressure p "Pressure";
      SI.SpecificEnthalpy h "Specific enthalpy";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      Real hd "Derivative of specific enthalpy w.r.t. density";
      Real ht "Derivative of specific enthalpy w.r.t. temperature";
    end NewtonDerivatives_ph;

    record NewtonDerivatives_ps
        "Derivatives for fast inverse calculation of Helmholtz functions: p & s"

      extends Modelica.Icons.Record;
      SI.Pressure p "Pressure";
      SI.SpecificEntropy s "Specific entropy";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
      Real sd "Derivative of specific entropy w.r.t. density";
      Real st "Derivative of specific entropy w.r.t. temperature";
    end NewtonDerivatives_ps;

    record NewtonDerivatives_pT
        "Derivatives for fast inverse calculations of Helmholtz functions:p & T"

      extends Modelica.Icons.Record;
      SI.Pressure p "Pressure";
      DerPressureByDensity pd "Derivative of pressure w.r.t. density";
    end NewtonDerivatives_pT;

    function gibbsToBoundaryProps
        "Calculate phase boundary property record from dimensionless Gibbs function"

      extends Modelica.Icons.Function;
      input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
      output PhaseBoundaryProperties sat "Phase boundary properties";
      protected
      Real vt "Derivative of specific volume w.r.t. temperature";
      Real vp "Derivative of specific volume w.r.t. pressure";
    algorithm
      sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
      sat.h := g.R*g.T*g.tau*g.gtau;
      sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      sat.s := g.R*(g.tau*g.gtau - g.g);
      sat.cp := -g.R*g.tau*g.tau*g.gtautau;
      sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
        *g.gtaupi)/(g.gpipi));
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;

    function helmholtzToBoundaryProps
        "Calculate phase boundary property record from dimensionless Helmholtz function"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output PhaseBoundaryProperties sat "Phase boundary property record";
      protected
      SI.Pressure p "Pressure";
    algorithm
      p := f.R*f.d*f.T*f.delta*f.fdelta;
      sat.d := f.d;
      sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      sat.s := f.R*(f.tau*f.ftau - f.f);
      sat.u := f.R*f.T*f.tau*f.ftau;
      sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)
        ^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
      sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    end helmholtzToBoundaryProps;

    function cv2Phase
        "Compute isochoric specific heat capacity inside the two-phase region"

      extends Modelica.Icons.Function;
      input PhaseBoundaryProperties liq "Properties on the boiling curve";
      input PhaseBoundaryProperties vap "Properties on the condensation curve";
      input SI.MassFraction x "Vapour mass fraction";
      input SI.Temperature T "Temperature";
      input SI.Pressure p "Properties";
      output SI.SpecificHeatCapacity cv "Isochoric specific heat capacity";
      protected
      Real dpT "Derivative of pressure w.r.t. temperature";
      Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
      Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
      Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
      Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
      Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
      Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
    algorithm
      dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
      dpT := (vap.s - liq.s)*dxv;
      // wrong at critical point
      dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
      dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
      dxt := -dxv*(dvTl + x*(dvTv - dvTl));
      duTl := liq.cv + (T*liq.pt - p)*dvTl;
      duTv := vap.cv + (T*vap.pt - p)*dvTv;
      cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
    end cv2Phase;

    function Helmholtz_ph
        "Function to calculate analytic derivatives for computing d and t given p and h"
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output NewtonDerivatives_ph nderivs
          "Derivatives for Newton iteration to calculate d and t from p and h";
      protected
      SI.SpecificHeatCapacity cv "Isochoric heat capacity";
    algorithm
      cv := -f.R*(f.tau*f.tau*f.ftautau);
      nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
      nderivs.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      nderivs.ht := cv + nderivs.pt/f.d;
      nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
    end Helmholtz_ph;

    function Helmholtz_pT
        "Function to calculate analytic derivatives for computing d and t given p and t"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output NewtonDerivatives_pT nderivs
          "Derivatives for Newton iteration to compute d and t from p and t";
    algorithm
      nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
      nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    end Helmholtz_pT;

    function Helmholtz_ps
        "Function to calculate analytic derivatives for computing d and t given p and s"

      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
      output NewtonDerivatives_ps nderivs
          "Derivatives for Newton iteration to compute d and t from p and s";
      protected
      SI.SpecificHeatCapacity cv "Isochoric heat capacity";
    algorithm
      cv := -f.R*(f.tau*f.tau*f.ftautau);
      nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
      nderivs.s := f.R*(f.tau*f.ftau - f.f);
      nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      nderivs.st := cv/f.T;
      nderivs.sd := -nderivs.pt/(f.d*f.d);
    end Helmholtz_ps;

    function smoothStep
        "Approximation of a general step, such that the characteristic is continuous and differentiable"
      extends Modelica.Icons.Function;
      input Real x "Abscissa value";
      input Real y1 "Ordinate value for x > 0";
      input Real y2 "Ordinate value for x < 0";
      input Real x_small(min=0) = 1e-5
          "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
      output Real y
          "Ordinate value to approximate y = if x > 0 then y1 else y2";
    algorithm
      y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if
        abs(x_small) > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2 - y1)/4 + (y1
         + y2)/2 else (y1 + y2)/2);

      annotation (
        Inline=true,
        smoothOrder=1,
        Documentation(revisions="<html>
<ul>
<li><i>April 29, 2008</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><i>August 12, 2008</i>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>",   info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    y = <b>if</b> x &gt; 0 <b>then</b> y1 <b>else</b> y2;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   y = <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> y1 <b>else</b>
                 <b>if</b> x &lt; -x_small <b>then</b> y2 <b>else</b> f(y1, y2));
</pre>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(X) = 1, provided sum(X_a) = sum(X_b) = 1
(and y1=X_a[i], y2=X_b[i]).
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise X is either X_a or X_b):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>
</html>"));
    end smoothStep;

    package OneNonLinearEquation
        "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way"
      extends Modelica.Icons.Package;

      replaceable record f_nonlinear_Data
          "Data specific for function f_nonlinear"
        extends Modelica.Icons.Record;
      end f_nonlinear_Data;

      replaceable partial function f_nonlinear
          "Nonlinear algebraic equation in one unknown: y = f_nonlinear(x,p,X)"
        extends Modelica.Icons.Function;
        input Real x "Independent variable of function";
        input Real p=0.0
            "Disregarded variables (here always used for pressure)";
        input Real[:] X=fill(0, 0)
            "Disregarded variables (her always used for composition)";
        input f_nonlinear_Data f_nonlinear_data
            "Additional data for the function";
        output Real y "= f_nonlinear(x)";
        // annotation(derivative(zeroDerivative=y)); // this must hold for all replaced functions
      end f_nonlinear;

      replaceable function solve
          "Solve f_nonlinear(x_zero)=y_zero; f_nonlinear(x_min) - y_zero and f_nonlinear(x_max)-y_zero must have different sign"
        import Modelica.Utilities.Streams.error;
        extends Modelica.Icons.Function;
        input Real y_zero
            "Determine x_zero, such that f_nonlinear(x_zero) = y_zero";
        input Real x_min "Minimum value of x";
        input Real x_max "Maximum value of x";
        input Real pressure=0.0
            "Disregarded variables (here always used for pressure)";
        input Real[:] X=fill(0, 0)
            "Disregarded variables (here always used for composition)";
        input f_nonlinear_Data f_nonlinear_data
            "Additional data for function f_nonlinear";
        input Real x_tol=100*Modelica.Constants.eps
            "Relative tolerance of the result";
        output Real x_zero "f_nonlinear(x_zero) = y_zero";
        protected
        constant Real eps=Modelica.Constants.eps "Machine epsilon";
        constant Real x_eps=1e-10
            "Slight modification of x_min, x_max, since x_min, x_max are usually exactly at the borders T_min/h_min and then small numeric noise may make the interval invalid";
        Real x_min2=x_min - x_eps;
        Real x_max2=x_max + x_eps;
        Real a=x_min2 "Current best minimum interval value";
        Real b=x_max2 "Current best maximum interval value";
        Real c "Intermediate point a <= c <= b";
        Real d;
        Real e "b - a";
        Real m;
        Real s;
        Real p;
        Real q;
        Real r;
        Real tol;
        Real fa "= f_nonlinear(a) - y_zero";
        Real fb "= f_nonlinear(b) - y_zero";
        Real fc;
        Boolean found=false;
      algorithm
        // Check that f(x_min) and f(x_max) have different sign
        fa := f_nonlinear(
                x_min2,
                pressure,
                X,
                f_nonlinear_data) - y_zero;
        fb := f_nonlinear(
                x_max2,
                pressure,
                X,
                f_nonlinear_data) - y_zero;
        fc := fb;
        if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
          error(
            "The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n"
             + "do not bracket the root of the single non-linear equation:\n" +
            "  x_min  = " + String(x_min2) + "\n" + "  x_max  = " + String(x_max2)
             + "\n" + "  y_zero = " + String(y_zero) + "\n" +
            "  fa = f(x_min) - y_zero = " + String(fa) + "\n" +
            "  fb = f(x_max) - y_zero = " + String(fb) + "\n" +
            "fa and fb must have opposite sign which is not the case");
        end if;

        // Initialize variables
        c := a;
        fc := fa;
        e := b - a;
        d := e;

        // Search loop
        while not found loop
          if abs(fc) < abs(fb) then
            a := b;
            b := c;
            c := a;
            fa := fb;
            fb := fc;
            fc := fa;
          end if;

          tol := 2*eps*abs(b) + x_tol;
          m := (c - b)/2;

          if abs(m) <= tol or fb == 0.0 then
            // root found (interval is small enough)
            found := true;
            x_zero := b;
          else
            // Determine if a bisection is needed
            if abs(e) < tol or abs(fa) <= abs(fb) then
              e := m;
              d := e;
            else
              s := fb/fa;
              if a == c then
                // linear interpolation
                p := 2*m*s;
                q := 1 - s;
              else
                // inverse quadratic interpolation
                q := fa/fc;
                r := fb/fc;
                p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
                q := (q - 1)*(r - 1)*(s - 1);
              end if;

              if p > 0 then
                q := -q;
              else
                p := -p;
              end if;

              s := e;
              e := d;
              if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
                // interpolation successful
                d := p/q;
              else
                // use bi-section
                e := m;
                d := e;
              end if;
            end if;

            // Best guess value is defined as "a"
            a := b;
            fa := fb;
            b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
            fb := f_nonlinear(
                    b,
                    pressure,
                    X,
                    f_nonlinear_data) - y_zero;

            if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
              // initialize variables
              c := a;
              fc := fa;
              e := b - a;
              d := e;
            end if;
          end if;
        end while;
      end solve;

      annotation (Documentation(info="<html>
<p>
This function should currently only be used in Modelica.Media,
since it might be replaced in the future by another strategy,
where the tool is responsible for the solution of the non-linear
equation.
</p>

<p>
This library determines the solution of one non-linear algebraic equation \"y=f(x)\"
in one unknown \"x\" in a reliable way. As input, the desired value y of the
non-linear function has to be given, as well as an interval x_min, x_max that
contains the solution, i.e., \"f(x_min) - y\" and \"f(x_max) - y\" must
have a different sign. If possible, a smaller interval is computed by
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.</dd>
</dl>

<p>
Due to current limitations of the
Modelica language (not possible to pass a function reference to a function),
the construction to use this solver on a user-defined function is a bit
complicated (this method is from Hans Olsson, Dassault Syst&egrave;mes AB). A user has to
provide a package in the following way:
</p>

<pre>
  <b>package</b> MyNonLinearSolver
    <b>extends</b> OneNonLinearEquation;

    <b>redeclare record extends</b> Data
      // Define data to be passed to user function
      ...
    <b>end</b> Data;

    <b>redeclare function extends</b> f_nonlinear
    <b>algorithm</b>
       // Compute the non-linear equation: y = f(x, Data)
    <b>end</b> f_nonlinear;

    // Dummy definition that has to be present for current Dymola
    <b>redeclare function extends</b> solve
    <b>end</b> solve;
  <b>end</b> MyNonLinearSolver;

  x_zero = MyNonLinearSolver.solve(y_zero, x_min, x_max, data=data);
</pre>
</html>"));
    end OneNonLinearEquation;
    annotation (Documentation(info="<HTML><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
   </p>

</html>",   revisions="<html>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <i>December, 2002</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a> and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003 </li>
      </ul>

      <address>Author: Hubertus Tummescheit, <br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</html>"));
  end Common;

    package IdealGases
      "Data and models of ideal gases (single, fixed and dynamic mixtures) from NASA source"
      extends Modelica.Icons.VariantsPackage;

      package Common "Common packages and data for the ideal gas models"
      extends Modelica.Icons.Package;

      record DataRecord
          "Coefficient data record for properties of ideal gases based on NASA source"
        extends Modelica.Icons.Record;
        String name "Name of ideal gas";
        SI.MolarMass MM "Molar mass";
        SI.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
        SI.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
        SI.Temperature Tlimit
            "Temperature limit between low and high data sets";
        Real alow[7] "Low temperature coefficients a";
        Real blow[2] "Low temperature constants b";
        Real ahigh[7] "High temperature coefficients a";
        Real bhigh[2] "High temperature constants b";
        SI.SpecificHeatCapacity R "Gas constant";
        annotation (Documentation(info="<HTML>
<p>
This data record contains the coefficients for the
ideal gas equations according to:
</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>
The equations have the following structure:
</p>
<IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/singleEquations.png\">
<p>
The polynomials for h(T) and s0(T) are derived via integration from the one for cp(T)  and contain the integration constants b1, b2 that define the reference specific enthalpy and entropy. For entropy differences the reference pressure p0 is arbitrary, but not for absolute entropies. It is chosen as 1 standard atmosphere (101325 Pa).
</p>
<p>
For most gases, the region of validity is from 200 K to 6000 K.
The equations are split into two regions that are separated
by Tlimit (usually 1000 K). In both regions the gas is described
by the data above. The two branches are continuous and in most
gases also differentiable at Tlimit.
</p>
</HTML>"));
      end DataRecord;

        package Functions
          "Basic Functions for ideal gases: cp, h, s, thermal conductivity, viscosity"
          extends Modelica.Icons.Package;

          constant Boolean excludeEnthalpyOfFormation=true
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";

          constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice=Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K
            "Choice of reference enthalpy";

          constant Modelica.Media.Interfaces.Types.SpecificEnthalpy h_offset=0.0
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

          function cp_T
            "Compute specific heat capacity at constant pressure from temperature and gas data"
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input SI.Temperature T "Temperature";
            output SI.SpecificHeatCapacity cp
              "Specific heat capacity at temperature T";
          algorithm
            cp := smooth(0,if T < data.Tlimit then data.R*(1/(T*T)*(data.alow[1] + T*(
              data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
              *(data.alow[6] + data.alow[7]*T))))))) else data.R*(1/(T*T)*(data.ahigh[1]
               + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.
              ahigh[5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
            annotation (Inline=true,smoothOrder=2);
          end cp_T;

          function h_T "Compute specific enthalpy from temperature and gas data; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
            import Modelica.Media.Interfaces.Choices;
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input SI.Temperature T "Temperature";
            input Boolean exclEnthForm=excludeEnthalpyOfFormation
              "If true, enthalpy of formation Hf is not included in specific enthalpy h";
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                            refChoice=referenceChoice
              "Choice of reference enthalpy";
            input SI.SpecificEnthalpy h_off=h_offset
              "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
            output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";

          algorithm
            h := smooth(0,(if T < data.Tlimit then data.R*((-data.alow[1] + T*(data.
              blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
              alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
              /T) else data.R*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]*
              Math.log(T) + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*data.
              ahigh[5] + T*(0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (if
              exclEnthForm then -data.Hf else 0.0) + (if (refChoice
               == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if
              refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else
                    0.0));
            annotation (Inline=false,smoothOrder=2);
          end h_T;

          function s0_T
            "Compute specific entropy from temperature and gas data"
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input SI.Temperature T "Temperature";
            output SI.SpecificEntropy s "Specific entropy at temperature T";
          algorithm
            s := if T < data.Tlimit then data.R*(data.blow[2] - 0.5*data.alow[
              1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
              data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
              7]*T)))) else data.R*(data.bhigh[2] - 0.5*data.ahigh[1]/(T*T) - data.
              ahigh[2]/T + data.ahigh[3]*Math.log(T) + T*(data.ahigh[4]
               + T*(0.5*data.ahigh[5] + T*(1/3*data.ahigh[6] + 0.25*data.ahigh[7]*T))));
            annotation (Inline=true, smoothOrder=2);
          end s0_T;

          function dynamicViscosityLowPressure
            "Dynamic viscosity of low pressure gases"
            extends Modelica.Icons.Function;
            input SI.Temp_K T "Gas temperature";
            input SI.Temp_K Tc "Critical temperature of gas";
            input SI.MolarMass M "Molar mass of gas";
            input SI.MolarVolume Vc "Critical molar volume of gas";
            input Real w "Acentric factor of gas";
            input Interfaces.PartialMedium.DipoleMoment mu
              "Dipole moment of gas molecule";
            input Real k =  0.0
              "Special correction for highly polar substances";
            output SI.DynamicViscosity eta "Dynamic viscosity of gas";
          protected
            parameter Real Const1_SI=40.785*10^(-9.5)
              "Constant in formula for eta converted to SI units";
            parameter Real Const2_SI=131.3/1000.0
              "Constant in formula for mur converted to SI units";
            Real mur=Const2_SI*mu/sqrt(Vc*Tc)
              "Dimensionless dipole moment of gas molecule";
            Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k
              "Factor to account for molecular shape and polarities of gas";
            Real Tstar "Dimensionless temperature defined by equation below";
            Real Ov "Viscosity collision integral for the gas";

          algorithm
            Tstar := 1.2593*T/Tc;
            Ov := 1.16145*Tstar^(-0.14874) + 0.52487*Modelica.Math.exp(-0.7732*Tstar) + 2.16178*Modelica.Math.exp(-2.43787
              *Tstar);
            eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
            annotation (smoothOrder=2,
                        Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The Formula is given in non-SI units, the following conversion constants were used to
transform the formula to SI units:
</p>

<ul>
<li> <b>Const1_SI:</b> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the
     factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
      and the factor 1e-7 is due to conversion from microPoise->Pa.s.</li>
<li>  <b>Const2_SI:</b> The factor 1/3.335641e-27 = 1e-3/3.335641e-30
      where the factor 3.335641e-30 comes from debye->C.m and
      1e-3 is due to conversion from cm^3/mol->m^3/mol</li>
</ul>

<h4>References:</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>Author</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"));
          end dynamicViscosityLowPressure;

          function thermalConductivityEstimate
            "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)"
            extends Modelica.Icons.Function;
            input Interfaces.PartialMedium.SpecificHeatCapacity Cp
              "Constant pressure heat capacity";
            input Interfaces.PartialMedium.DynamicViscosity eta
              "Dynamic viscosity";
            input Integer method(min=1,max=2)=1
              "1: Eucken Method, 2: Modified Eucken Method";
            input IdealGases.Common.DataRecord data "Ideal gas data";
            output Interfaces.PartialMedium.ThermalConductivity lambda
              "Thermal conductivity [W/(m.k)]";
          algorithm
            lambda := if method == 1 then eta*(Cp - data.R + (9/4)*data.R) else eta*(Cp
               - data.R)*(1.32 + 1.77/((Cp/Modelica.Constants.R) - 1.0));
            annotation (smoothOrder=2,
                        Documentation(info="<html>
<p>
This function provides two similar methods for estimating the
thermal conductivity of polyatomic gases.
The Eucken method (input method == 1) gives good results for low temperatures,
but it tends to give an underestimated value of the thermal conductivity
(lambda) at higher temperatures.<br>
The Modified Eucken method (input method == 2) gives good results for
high-temperatures, but it tends to give an overestimated value of the
thermal conductivity (lambda) at low temperatures.
</p>
</html>"));
          end thermalConductivityEstimate;
        end Functions;

      partial package MixtureGasNasa
          "Medium model of a mixture of ideal gases based on NASA source"

        import Modelica.Math;
        import Modelica.Media.Interfaces.Choices.ReferenceEnthalpy;

        extends Modelica.Media.Interfaces.PartialMixtureMedium(
           ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX,
           substanceNames=data[:].name,
           reducedX = false,
           singleState=false,
           reference_X=fill(1/nX,nX),
           SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then 3e5 else
              if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
           Density(start=10, nominal=10),
           AbsolutePressure(start=10e5, nominal=10e5),
           Temperature(min=200, max=6000, start=500, nominal=500));

          redeclare record extends ThermodynamicState
            "Thermodynamic state variables"
          end ThermodynamicState;

      //   redeclare record extends FluidConstants "Fluid constants"
      //   end FluidConstants;

        constant Modelica.Media.IdealGases.Common.DataRecord[:] data
            "Data records of ideal gas substances";
          // ={Common.SingleGasesData.N2,Common.SingleGasesData.O2}

        constant Boolean excludeEnthalpyOfFormation=true
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
        constant ReferenceEnthalpy referenceChoice=ReferenceEnthalpy.ZeroAt0K
            "Choice of reference enthalpy";
        constant SpecificEnthalpy h_offset=0.0
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

      //   constant FluidConstants[nX] fluidConstants
      //     "Additional data needed for transport properties";
        constant MolarMass[nX] MMX=data[:].MM "Molar masses of components";
        constant Integer methodForThermalConductivity(min=1,max=2)=1;
        redeclare replaceable model extends BaseProperties(
          T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          final standardOrderComponents=true)
            "Base properties (p, d, T, h, u, R, MM, X, and Xi of NASA mixture gas"
        equation
          assert(T >= 200 and T <= 6000, "
Temperature T (="       + String(T) + " K = 200 K) is not in the allowed range
200 K <= T <= 6000 K
required from medium model \""       + mediumName + "\".");

          MM = molarMass(state);
          h = h_TX(T, X);
          R = data.R*X;
          u = h - R*T;
          d = p/(R*T);
          // connect state with BaseProperties
          state.T = T;
          state.p = p;
          state.X = if fixedX then reference_X else X;
        end BaseProperties;

          redeclare function setState_pTX
            "Return thermodynamic state as function of p, T and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input Temperature T "Temperature";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else
                   ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
          annotation(Inline=true,smoothOrder=2);
          end setState_pTX;

          redeclare function setState_phX
            "Return thermodynamic state as function of p, h and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEnthalpy h "Specific enthalpy";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_hX(h,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_hX(h,X),X=X) else
                   ThermodynamicState(p=p,T=T_hX(h,X), X=cat(1,X,{1-sum(X)}));
            annotation(Inline=true,smoothOrder=2);
          end setState_phX;

          redeclare function setState_psX
            "Return thermodynamic state as function of p, s and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEntropy s "Specific entropy";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X,1) == 0 then ThermodynamicState(p=p,T=T_psX(p,s,reference_X),X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=p,T=T_psX(p,s,X),X=X) else
                   ThermodynamicState(p=p,T=T_psX(p,s,X), X=cat(1,X,{1-sum(X)}));
            annotation(Inline=true,smoothOrder=2);
          end setState_psX;

          redeclare function setState_dTX
            "Return thermodynamic state as function of d, T and composition X"
            extends Modelica.Icons.Function;
            input Density d "Density";
            input Temperature T "Temperature";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X,1) == 0 then ThermodynamicState(p=d*(data.R*reference_X)*T,T=T,X=reference_X) else if size(X,1) == nX then ThermodynamicState(p=d*(data.R*X)*T,T=T,X=X) else
                   ThermodynamicState(p=d*(data.R*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
            annotation(Inline=true,smoothOrder=2);
          end setState_dTX;

            redeclare function extends setSmoothState
            "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
            algorithm
              state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                          T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small),
                                          X=Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
              annotation(Inline=true,smoothOrder=2);
            end setSmoothState;

          redeclare function extends pressure "Return pressure of ideal gas"
          algorithm
            p := state.p;
            annotation(Inline=true,smoothOrder=2);
          end pressure;

          redeclare function extends temperature
            "Return temperature of ideal gas"
          algorithm
            T := state.T;
            annotation(Inline=true,smoothOrder=2);
          end temperature;

          redeclare function extends density "Return density of ideal gas"
          algorithm
            d := state.p/((state.X*data.R)*state.T);
            annotation(Inline = true, smoothOrder = 3);
          end density;

        redeclare function extends specificEnthalpy "Return specific enthalpy"
          extends Modelica.Icons.Function;
        algorithm
          h := h_TX(state.T,state.X);
          annotation(Inline=true,smoothOrder=2);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy
            "Return specific internal energy"
          extends Modelica.Icons.Function;
        algorithm
          u := h_TX(state.T,state.X) - gasConstant(state)*state.T;
          annotation(Inline=true,smoothOrder=2);
        end specificInternalEnergy;

        redeclare function extends specificEntropy "Return specific entropy"
          protected
          Real[nX] Y(unit="mol/mol")=massToMoleFractions(state.X, data.MM)
              "Molar fractions";
        algorithm
        s :=  s_TX(state.T, state.X) - sum(state.X[i]*Modelica.Constants.R/MMX[i]*
            (if state.X[i]<Modelica.Constants.eps then Y[i] else
            Modelica.Math.log(Y[i]*state.p/reference_p)) for i in 1:nX);
          annotation(Inline=true,smoothOrder=2);
        end specificEntropy;

        redeclare function extends specificGibbsEnergy
            "Return specific Gibbs energy"
          extends Modelica.Icons.Function;
        algorithm
          g := h_TX(state.T,state.X) - state.T*specificEntropy(state);
          annotation(Inline=true,smoothOrder=2);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy
            "Return specific Helmholtz energy"
          extends Modelica.Icons.Function;
        algorithm
          f := h_TX(state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
          annotation(Inline=true,smoothOrder=2);
        end specificHelmholtzEnergy;

        function h_TX "Return specific enthalpy"
          import Modelica.Media.Interfaces.Choices;
           extends Modelica.Icons.Function;
           input SI.Temperature T "Temperature";
           input MassFraction X[:]=reference_X
              "Independent Mass fractions of gas mixture";
           input Boolean exclEnthForm=excludeEnthalpyOfFormation
              "If true, enthalpy of formation Hf is not included in specific enthalpy h";
           input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                           refChoice=referenceChoice
              "Choice of reference enthalpy";
           input SI.SpecificEnthalpy h_off=h_offset
              "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
           output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
        algorithm
          h :=(if fixedX then reference_X else X)*
               {Modelica.Media.IdealGases.Common.Functions.h_T(
                                  data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
          annotation(Inline=false,smoothOrder=2);
        end h_TX;

        function h_TX_der "Return specific enthalpy derivative"
          import Modelica.Media.Interfaces.Choices;
           extends Modelica.Icons.Function;
           input SI.Temperature T "Temperature";
           input MassFraction X[nX] "Independent Mass fractions of gas mixture";
           input Boolean exclEnthForm=excludeEnthalpyOfFormation
              "If true, enthalpy of formation Hf is not included in specific enthalpy h";
           input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                           refChoice=referenceChoice
              "Choice of reference enthalpy";
           input SI.SpecificEnthalpy h_off=h_offset
              "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          input Real dT "Temperature derivative";
          input Real dX[nX] "Independent mass fraction derivative";
          output Real h_der "Specific enthalpy at temperature T";
        algorithm
          h_der := if fixedX then
            dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                       data[i], T)*reference_X[i]) for i in 1:nX) else
            dT*sum((Modelica.Media.IdealGases.Common.Functions.cp_T(
                                       data[i], T)*X[i]) for i in 1:nX)+
            sum((Modelica.Media.IdealGases.Common.Functions.h_T(
                                   data[i], T)*dX[i]) for i in 1:nX);
          annotation (Inline = false, smoothOrder=1);
        end h_TX_der;

        redeclare function extends gasConstant "Return gasConstant"
        algorithm
          R := data.R*state.X;
          annotation(Inline = true, smoothOrder = 3);
        end gasConstant;

        redeclare function extends specificHeatCapacityCp
            "Return specific heat capacity at constant pressure"
        algorithm
          cp := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                                    data[i], state.T) for i in 1:nX}*state.X;
          annotation(Inline=true,smoothOrder=1);
        end specificHeatCapacityCp;

        redeclare function extends specificHeatCapacityCv
            "Return specific heat capacity at constant volume from temperature and gas data"
        algorithm
          cv := {Modelica.Media.IdealGases.Common.Functions.cp_T(
                                    data[i], state.T) for i in 1:nX}*state.X -data.R*state.X;
          annotation(Inline=true, smoothOrder = 1);
        end specificHeatCapacityCv;

        function MixEntropy "Return mixing entropy of ideal gases / R"
          extends Modelica.Icons.Function;
          input SI.MoleFraction x[:] "Mole fraction of mixture";
          output Real smix
              "Mixing entropy contribution, divided by gas constant";
        algorithm
          smix := sum(if x[i] > Modelica.Constants.eps then -x[i]*Modelica.Math.log(x[i]) else
                           x[i] for i in 1:size(x,1));
          annotation(Inline=true,smoothOrder=2);
        end MixEntropy;

        function s_TX
            "Return temperature dependent part of the entropy, expects full entropy vector"
          extends Modelica.Icons.Function;
          input Temperature T "Temperature";
          input MassFraction[nX] X "Mass fraction";
          output SpecificEntropy s "Specific entropy";
        algorithm
          s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(
                                      data[i], T)*X[i] for i in 1:size(X,1));
          annotation(Inline=true,smoothOrder=2);
        end s_TX;

        redeclare function extends isentropicExponent
            "Return isentropic exponent"
        algorithm
          gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
          annotation(Inline=true,smoothOrder=2);
        end isentropicExponent;

        redeclare function extends velocityOfSound "Return velocity of sound"
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Properties at upstream location";
        algorithm
          a := sqrt(max(0,gasConstant(state)*state.T*specificHeatCapacityCp(state)/specificHeatCapacityCv(state)));
          annotation(Inline=true,smoothOrder=2);
        end velocityOfSound;

        function isentropicEnthalpyApproximation
            "Approximate method of calculating h_is from upstream properties and downstream pressure"
          extends Modelica.Icons.Function;
          input AbsolutePressure p2 "Downstream pressure";
          input ThermodynamicState state
              "Thermodynamic state at upstream location";
          output SpecificEnthalpy h_is "Isentropic enthalpy";
          protected
          SpecificEnthalpy h "Specific enthalpy at upstream location";
          SpecificEnthalpy h_component[nX]
              "Specific enthalpy at upstream location";
          IsentropicExponent gamma =  isentropicExponent(state)
              "Isentropic exponent";
          protected
          MassFraction[nX] X "Complete X-vector";
        algorithm
          X := if reducedX then cat(1,state.X,{1-sum(state.X)}) else state.X;
          h_component :={Modelica.Media.IdealGases.Common.Functions.h_T(
                                           data[i], state.T, excludeEnthalpyOfFormation,
            referenceChoice, h_offset) for i in 1:nX};
          h :=h_component*X;
          h_is := h + gamma/(gamma - 1.0)*(state.T*gasConstant(state))*
            ((p2/state.p)^((gamma - 1)/gamma) - 1.0);
          annotation(smoothOrder=2);
        end isentropicEnthalpyApproximation;

        redeclare function extends isentropicEnthalpy
            "Return isentropic enthalpy"
          input Boolean exact = false
              "Flag whether exact or approximate version should be used";
        algorithm
          h_is := if exact then specificEnthalpy_psX(p_downstream,specificEntropy(refState),refState.X) else
                 isentropicEnthalpyApproximation(p_downstream,refState);
          annotation(Inline=true,smoothOrder=2);
        end isentropicEnthalpy;

      function gasMixtureViscosity
            "Return viscosities of gas mixtures at low pressures (Wilke method)"
        extends Modelica.Icons.Function;
        input MoleFraction[:] yi "Mole fractions";
        input MolarMass[:] M "Mole masses";
        input DynamicViscosity[:] eta "Pure component viscosities";
        output DynamicViscosity etam "Viscosity of the mixture";
          protected
        Real fi[size(yi,1),size(yi,1)];
      algorithm
        for i in 1:size(eta,1) loop
          assert(fluidConstants[i].hasDipoleMoment,"Dipole moment for " + fluidConstants[i].chemicalFormula +
             " not known. Can not compute viscosity.");
          assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
             " not known. Can not compute viscosity.");
          for j in 1:size(eta,1) loop
            if i==1 then
              fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
            elseif j<i then
                fi[i,j] := eta[i]/eta[j]*M[j]/M[i]*fi[j,i];
              else
                fi[i,j] := (1 + (eta[i]/eta[j])^(1/2)*(M[j]/M[i])^(1/4))^2/(8*(1 + M[i]/M[j]))^(1/2);
            end if;
          end for;
        end for;
        etam := sum(yi[i]*eta[i]/sum(yi[j]*fi[i,j] for j in 1:size(eta,1)) for i in 1:size(eta,1));

        annotation (smoothOrder=2,
                   Documentation(info="<html>

<p>
Simplification of the kinetic theory (Chapman and Enskog theory)
approach neglecting the second-order effects.<br>
<br>
This equation has been extensively tested (Amdur and Mason, 1958;
Bromley and Wilke, 1951; Cheung, 1958; Dahler, 1959; Gandhi and Saxena,
1964; Ranz and Brodowsky, 1962; Saxena and Gambhir, 1963a; Strunk, et
al., 1964; Vanderslice, et al. 1962; Wright and Gray, 1962). In most
cases, only nonpolar mixtures were compared, and very good results
obtained. For some systems containing hydrogen as one component, less
satisfactory agreement was noted. Wilke's method predicted mixture
viscosities that were larger than experimental for the H2-N2 system,
but for H2-NH3, it underestimated the viscosities. <br>
Gururaja, et al. (1967) found that this method also overpredicted in
the H2-O2 case but was quite accurate for the H2-CO2 system. <br>
Wilke's approximation has proved reliable even for polar-polar gas
mixtures of aliphatic alcohols (Reid and Belenyessy, 1960). The
principal reservation appears to lie in those cases where Mi&gt;&gt;Mj
and etai&gt;&gt;etaj.<br>
</p>

</html>"));
      end gasMixtureViscosity;

          redeclare replaceable function extends dynamicViscosity
            "Return mixture dynamic viscosity"
          protected
            DynamicViscosity[nX] etaX "Component dynamic viscosities";
          algorithm
            for i in 1:nX loop
          etaX[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                               state.T,
                             fluidConstants[i].criticalTemperature,
                             fluidConstants[i].molarMass,
                             fluidConstants[i].criticalMolarVolume,
                             fluidConstants[i].acentricFactor,
                             fluidConstants[i].dipoleMoment);
            end for;
            eta := gasMixtureViscosity(massToMoleFractions(state.X,
                                   fluidConstants[:].molarMass),
                       fluidConstants[:].molarMass,
                       etaX);
            annotation (smoothOrder=2);
          end dynamicViscosity;

        function mixtureViscosityChung
            "Return the viscosity of gas mixtures without access to component viscosities (Chung, et. al. rules)"
        extends Modelica.Icons.Function;

          input Temperature T "Temperature";
          input Temperature[:] Tc "Critical temperatures";
          input MolarVolume[:] Vcrit "Critical volumes (m3/mol)";
          input Real[:] w "Acentric factors";
          input Real[:] mu "Dipole moments (debyes)";
          input MolarMass[:] MolecularWeights "Molecular weights (kg/mol)";
          input MoleFraction[:] y "Molar Fractions";
          input Real[:] kappa =  zeros(nX) "Association Factors";
          output DynamicViscosity etaMixture "Mixture viscosity (Pa.s)";
          protected
        constant Real[size(y,1)] Vc =  Vcrit*1000000
              "Critical volumes (cm3/mol)";
        constant Real[size(y,1)] M =  MolecularWeights*1000
              "Molecular weights (g/mol)";
        Integer n = size(y,1) "Number of mixed elements";
        Real sigmam3 "Mixture sigma3 in Angstrom";
        Real sigma[size(y,1),size(y,1)];
        Real edivkm;
        Real edivk[size(y,1),size(y,1)];
        Real Mm;
        Real Mij[size(y,1),size(y,1)];
        Real wm "Accentric factor";
        Real wij[size(y,1),size(y,1)];
        Real kappam
              "Correlation for highly polar substances such as alcohols and acids";
        Real kappaij[size(y,1),size(y,1)];
        Real mum;
        Real Vcm;
        Real Tcm;
        Real murm "Dimensionless dipole moment of the mixture";
        Real Fcm "Factor to correct for shape and polarity";
        Real omegav;
        Real Tmstar;
        Real etam "Mixture viscosity in microP";
        algorithm
        //combining rules
        for i in 1:n loop
          for j in 1:n loop
            Mij[i,j] := 2*M[i]*M[j]/(M[i]+M[j]);
            if i==j then
              sigma[i,j] := 0.809*Vc[i]^(1/3);
              edivk[i,j] := Tc[i]/1.2593;
              wij[i,j] := w[i];
              kappaij[i,j] := kappa[i];
            else
              sigma[i,j] := (0.809*Vc[i]^(1/3)*0.809*Vc[j]^(1/3))^(1/2);
              edivk[i,j] := (Tc[i]/1.2593*Tc[j]/1.2593)^(1/2);
              wij[i,j] := (w[i] + w[j])/2;
              kappaij[i,j] := (kappa[i]*kappa[j])^(1/2);
            end if;
          end for;
        end for;
        //mixing rules
        sigmam3 := (sum(sum(y[i]*y[j]*sigma[i,j]^3 for j in 1:n) for i in 1:n));
        //(epsilon/k)m
        edivkm := (sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
        Mm := ((sum(sum(y[i]*y[j]*edivk[i,j]*sigma[i,j]^2*Mij[i,j]^(1/2) for j in 1:n) for i in 1:n))/(edivkm*sigmam3^(2/3)))^2;
        wm := (sum(sum(y[i]*y[j]*wij[i,j]*sigma[i,j]^3 for j in 1:n) for i in 1:n))/sigmam3;
        mum := (sigmam3*(sum(sum(y[i]*y[j]*mu[i]^2*mu[j]^2/sigma[i,j]^3 for j in 1:n) for i in 1:n)))^(1/4);
        Vcm := sigmam3/(0.809)^3;
        Tcm := 1.2593*edivkm;
        murm := 131.3*mum/(Vcm*Tcm)^(1/2);
        kappam := (sigmam3*(sum(sum(y[i]*y[j]*kappaij[i,j] for j in 1:n) for i in 1:n)));
        Fcm := 1 - 0.275*wm + 0.059035*murm^4 + kappam;
        Tmstar := T/edivkm;
        omegav := 1.16145*(Tmstar)^(-0.14874) + 0.52487*Math.exp(-0.77320*Tmstar) + 2.16178*Math.exp(-2.43787*Tmstar);
        etam := 26.69*Fcm*(Mm*T)^(1/2)/(sigmam3^(2/3)*omegav);
        etaMixture := etam*1e7;

          annotation (smoothOrder=2,
                    Documentation(info="<html>

<p>
Equation to estimate the viscosity of gas mixtures at low pressures.<br>
It is a simplification of an extension of the rigorous kinetic theory
of Chapman and Enskog to determine the viscosity of multicomponent
mixtures, at low pressures and with a factor to correct for molecule
shape and polarity.
</p>

<p>
The input argument Kappa is a special correction for highly polar substances such as
alcohols and acids.<br>
Values of kappa for a few such materials:
</p>

<table style=\"text-align: left; width: 302px; height: 200px;\" border=\"1\"
cellspacing=\"0\" cellpadding=\"2\">
<tbody>
<tr>
<td style=\"vertical-align: top;\">Compound <br>
</td>
<td style=\"vertical-align: top; text-align: center;\">Kappa<br>
</td>
<td style=\"vertical-align: top;\">Compound<br>
</td>
<td style=\"vertical-align: top;\">Kappa<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Methanol<br>
</td>
<td style=\"vertical-align: top;\">0.215<br>
</td>
<td style=\"vertical-align: top;\">n-Pentanol<br>
</td>
<td style=\"vertical-align: top;\">0.122<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">Ethanol<br>
</td>
<td style=\"vertical-align: top;\">0.175<br>
</td>
<td style=\"vertical-align: top;\">n-Hexanol<br>
</td>
<td style=\"vertical-align: top;\">0.114<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">n-Heptanol<br>
</td>
<td style=\"vertical-align: top;\">0.109<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Propanol<br>
</td>
<td style=\"vertical-align: top;\">0.143<br>
</td>
<td style=\"vertical-align: top;\">Acetic Acid<br>
</td>
<td style=\"vertical-align: top;\">0.0916<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">n-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132<br>
</td>
<td style=\"vertical-align: top;\">Water<br>
</td>
<td style=\"vertical-align: top;\">0.076<br>
</td>
</tr>
<tr>
<td style=\"vertical-align: top;\">i-Butanol<br>
</td>
<td style=\"vertical-align: top;\">0.132</td>
<td style=\"vertical-align: top;\"><br>
</td>
<td style=\"vertical-align: top;\"><br>
</td>
</tr>
</tbody>
</table>
<p>
Chung, et al. (1984) suggest that for other alcohols not shown in the
table:<br>
&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; kappa = 0.0682 + 4.704*[(number of -OH
groups)]/[molecular weight]<br>
<br>
<span style=\"font-weight: normal;\">S.I. units relation for the
debyes:&nbsp;</span><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 1 debye = 3.162e-25 (J.m^3)^(1/2)<br>
</p>
<h4>References</h4>
<p>
[1] THE PROPERTIES OF GASES AND LIQUIDS, Fifth Edition,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; Bruce E. Poling, John M.
Prausnitz, John P. O'Connell.<br>
[2] Chung, T.-H., M. Ajlan, L. L. Lee, and K. E. Starling: Ind. Eng.
Chem. Res., 27: 671 (1988).<br>
[3] Chung, T.-H., L. L. Lee, and K. E. Starling; Ing. Eng. Chem.
Fundam., 23: 3 ()1984).<br>
</p>
</html>"));
        end mixtureViscosityChung;

      function lowPressureThermalConductivity
            "Return thermal conductivities of low-pressure gas mixtures (Mason and Saxena Modification)"
        extends Modelica.Icons.Function;
        input MoleFraction[:] y
              "Mole fraction of the components in the gas mixture";
        input Temperature T "Temperature";
        input Temperature[:] Tc "Critical temperatures";
        input AbsolutePressure[:] Pc "Critical pressures";
        input MolarMass[:] M "Molecular weights";
        input ThermalConductivity[:] lambda
              "Thermal conductivities of the pure gases";
        output ThermalConductivity lambdam
              "Thermal conductivity of the gas mixture";
          protected
        MolarMass[size(y,1)] gamma;
        Real[size(y,1)] Tr "Reduced temperature";
        Real[size(y,1),size(y,1)] A "Mason and Saxena Modification";
        constant Real epsilon =  1.0 "Numerical constant near unity";
      algorithm
        for i in 1:size(y,1) loop
          gamma[i] := 210*(Tc[i]*M[i]^3/Pc[i]^4)^(1/6);
          Tr[i] := T/Tc[i];
        end for;
        for i in 1:size(y,1) loop
          for j in 1:size(y,1) loop
            A[i,j] := epsilon*(1 + (gamma[j]*(Math.exp(0.0464*Tr[i]) - Math.exp(-0.2412*Tr[i]))/
            (gamma[i]*(Math.exp(0.0464*Tr[j]) - Math.exp(-0.2412*Tr[j]))))^(1/2)*(M[i]/M[j])^(1/4))^2/
            (8*(1 + M[i]/M[j]))^(1/2);
          end for;
        end for;
        lambdam := sum(y[i]*lambda[i]/(sum(y[j]*A[i,j] for j in 1:size(y,1))) for i in 1:size(y,1));

        annotation (smoothOrder=2,
                    Documentation(info="<html>

<p>
This function applies the Masson and Saxena modification of the
Wassiljewa Equation for the thermal conductivity for gas mixtures of
n elements at low pressure.
</p>

<p>
For nonpolar gas mixtures errors will generally be less than 3 to 4%.
For mixtures of nonpolar-polar and polar-polar gases, errors greater
than 5 to 8% may be expected. For mixtures in which the sizes and
polarities of the constituent molecules are not greatly different, the
thermal conductivity can be estimated satisfactorily by a mole fraction
average of the pure component conductivities.
</p>

</html>"));
      end lowPressureThermalConductivity;

          redeclare replaceable function extends thermalConductivity
            "Return thermal conductivity for low pressure gas mixtures"
            input Integer method=methodForThermalConductivity
              "Method to compute single component thermal conductivity";
          protected
            ThermalConductivity[nX] lambdaX "Component thermal conductivities";
            DynamicViscosity[nX] eta "Component thermal dynamic viscosities";
            SpecificHeatCapacity[nX] cp "Component heat capacity";
          algorithm
            for i in 1:nX loop
          assert(fluidConstants[i].hasCriticalData, "Critical data for "+ fluidConstants[i].chemicalFormula +
             " not known. Can not compute thermal conductivity.");
          eta[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(
                                                              state.T,
                             fluidConstants[i].criticalTemperature,
                             fluidConstants[i].molarMass,
                             fluidConstants[i].criticalMolarVolume,
                             fluidConstants[i].acentricFactor,
                             fluidConstants[i].dipoleMoment);
          cp[i] := Modelica.Media.IdealGases.Common.Functions.cp_T(
                                      data[i],state.T);
          lambdaX[i] :=Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(
                                                                 Cp=cp[i], eta=
                eta[i], method=method,data=data[i]);
            end for;
            lambda := lowPressureThermalConductivity(massToMoleFractions(state.X,
                                         fluidConstants[:].molarMass),
                                 state.T,
                                 fluidConstants[:].criticalTemperature,
                                 fluidConstants[:].criticalPressure,
                                 fluidConstants[:].molarMass,
                                 lambdaX);
            annotation (smoothOrder=2);
          end thermalConductivity;

        redeclare function extends isobaricExpansionCoefficient
            "Return isobaric expansion coefficient beta"
        algorithm
          beta := 1/state.T;
          annotation(Inline=true,smoothOrder=2);
        end isobaricExpansionCoefficient;

        redeclare function extends isothermalCompressibility
            "Return isothermal compressibility factor"
        algorithm
          kappa := 1.0/state.p;
          annotation(Inline=true,smoothOrder=2);
        end isothermalCompressibility;

        redeclare function extends density_derp_T
            "Return density derivative by pressure at constant temperature"
        algorithm
          ddpT := 1/(state.T*gasConstant(state));
          annotation(Inline=true,smoothOrder=2);
        end density_derp_T;

        redeclare function extends density_derT_p
            "Return density derivative by temperature at constant pressure"
        algorithm
          ddTp := -state.p/(state.T*state.T*gasConstant(state));
          annotation(Inline=true,smoothOrder=2);
        end density_derT_p;

        redeclare function density_derX
            "Return density derivative by mass fraction"
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
        algorithm
          dddX := {-state.p/(state.T*gasConstant(state))*molarMass(state)/data[
            i].MM for i in 1:nX};
          annotation(Inline=true,smoothOrder=2);
        end density_derX;

        redeclare function extends molarMass "Return molar mass of mixture"
        algorithm
          MM := 1/sum(state.X[j]/data[j].MM for j in 1:size(state.X, 1));
          annotation(Inline=true,smoothOrder=2);
        end molarMass;

        function T_hX
            "Return temperature from specific enthalpy and mass fraction"
          extends Modelica.Icons.Function;
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X "Mass fractions of composition";
           input Boolean exclEnthForm=excludeEnthalpyOfFormation
              "If true, enthalpy of formation Hf is not included in specific enthalpy h";
           input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                           refChoice=referenceChoice
              "Choice of reference enthalpy";
           input SI.SpecificEnthalpy h_off=h_offset
              "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          output Temperature T "Temperature";
          protected
          MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
        package Internal
              "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
          extends Modelica.Media.Common.OneNonLinearEquation;
          redeclare record extends f_nonlinear_Data
                "Data to be passed to non-linear function"
            extends Modelica.Media.IdealGases.Common.DataRecord;
          end f_nonlinear_Data;

          redeclare function extends f_nonlinear
          algorithm
              y := h_TX(x,X);
          end f_nonlinear;

          // Dummy definition has to be added for current Dymola
          redeclare function extends solve
          end solve;
        end Internal;

        algorithm
          T := Internal.solve(h, 200, 6000, 1.0e5, Xfull, data[1]);
          annotation(inverse(h = h_TX(T,X,exclEnthForm,refChoice,h_off)));
        end T_hX;

        function T_psX
            "Return temperature from pressure, specific entropy and mass fraction"
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X "Mass fractions of composition";
          output Temperature T "Temperature";
          protected
          MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
        package Internal
              "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
          extends Modelica.Media.Common.OneNonLinearEquation;
          redeclare record extends f_nonlinear_Data
                "Data to be passed to non-linear function"
            extends Modelica.Media.IdealGases.Common.DataRecord;
          end f_nonlinear_Data;

          redeclare function extends f_nonlinear
                "Note that this function always sees the complete mass fraction vector"
              protected
          MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
          Real[nX] Y(unit="mol/mol")=massToMoleFractions(if size(X,1) == nX then X else cat(1,X,{1-sum(X)}), data.MM)
                  "Molar fractions";
          algorithm
            y := s_TX(x,Xfull) - sum(Xfull[i]*Modelica.Constants.R/MMX[i]*
            (if Xfull[i]<Modelica.Constants.eps then Y[i] else
            Modelica.Math.log(Y[i]*p/reference_p)) for i in 1:nX);
              // s_TX(x,X)- data[:].R*X*(Modelica.Math.log(p/reference_p)
              //       + MixEntropy(massToMoleFractions(X,data[:].MM)));
          end f_nonlinear;

          // Dummy definition has to be added for current Dymola
          redeclare function extends solve
          end solve;
        end Internal;

        algorithm
          T := Internal.solve(s, 200, 6000, p, Xfull, data[1]);
        end T_psX;

      //   redeclare function extends specificEnthalpy_psX
      //   protected
      //     Temperature T "Temperature";
      //   algorithm
      //     T := temperature_psX(p,s,X);
      //     h := specificEnthalpy_pTX(p,T,X);
      //   end extends;

      //   redeclare function extends density_phX
      //     "Compute density from pressure, specific enthalpy and mass fraction"
      //     protected
      //     Temperature T "Temperature";
      //     SpecificHeatCapacity R "Gas constant";
      //   algorithm
      //     T := temperature_phX(p,h,X);
      //     R := if (not reducedX) then
      //       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)) else
      //       sum(data[i].R*X[i] for i in 1:size(substanceNames, 1)-1) + data[end].R*(1-sum(X[i]));
      //     d := p/(R*T);
      //   end density_phX;

        annotation (Documentation(info="<HTML>
<p>
This model calculates the medium properties for single component ideal gases.
</p>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</b></br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library.
It has been developed by Hubertus Tummescheit.
</p>
</HTML>"));
      end MixtureGasNasa;

        package FluidData "Critical data, dipole moments and related data"
          extends Modelica.Icons.Package;
          import Modelica.Media.Interfaces.PartialMixtureMedium;
          import Modelica.Media.IdealGases.Common.SingleGasesData;

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants N2(
                               chemicalFormula =        "N2",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "7727-37-9",
                               meltingPoint =            63.15,
                               normalBoilingPoint =      77.35,
                               criticalTemperature =    126.20,
                               criticalPressure =        33.98e5,
                               criticalMolarVolume =     90.10e-6,
                               acentricFactor =           0.037,
                               dipoleMoment =             0.0,
                               molarMass =              SingleGasesData.N2.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants O2(
                               chemicalFormula =        "O2",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "7782-44-7",
                               meltingPoint =            54.36,
                               normalBoilingPoint =      90.17,
                               criticalTemperature =    154.58,
                               criticalPressure =        50.43e5,
                               criticalMolarVolume =     73.37e-6,
                               acentricFactor =         0.022,
                               dipoleMoment =           0.0,
                               molarMass =              SingleGasesData.O2.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);
          annotation (Documentation(info="<html>
<p>
This package contains FluidConstants data records for the following 37 gases
(see also the description in
<a href=\"modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>):
</p>
<pre>
Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
Acetylene         Ethylene         Ethanol        Ethane           Propylene
Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
Sulfur Dioxide    Sulfur Trioxide
</pre>

</html>"));
        end FluidData;

        package SingleGasesData
          "Ideal gas data based on the NASA Glenn coefficients"
          extends Modelica.Icons.Package;

          constant IdealGases.Common.DataRecord N2(
            name="N2",
            MM=0.0280134,
            Hf=0,
            H0=309498.4543111511,
            Tlimit=1000,
            alow={22103.71497,-381.846182,6.08273836,-0.00853091441,1.384646189e-005,-9.62579362e-009,
                2.519705809e-012},
            blow={710.846086,-10.76003744},
            ahigh={587712.406,-2239.249073,6.06694922,-0.00061396855,1.491806679e-007,-1.923105485e-011,
                1.061954386e-015},
            bhigh={12832.10415,-15.86640027},
            R=296.8033869505308);

          constant IdealGases.Common.DataRecord O2(
            name="O2",
            MM=0.0319988,
            Hf=0,
            H0=271263.4223783392,
            Tlimit=1000,
            alow={-34255.6342,484.700097,1.119010961,0.00429388924,-6.83630052e-007,-2.0233727e-009,
                1.039040018e-012},
            blow={-3391.45487,18.4969947},
            ahigh={-1037939.022,2344.830282,1.819732036,0.001267847582,-2.188067988e-007,
                2.053719572e-011,-8.193467050000001e-016},
            bhigh={-16890.10929,17.38716506},
            R=259.8369938872708);
          annotation ( Documentation(info="<HTML>
<p>This package contains ideal gas models for the 1241 ideal gases from</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>

<pre>
 Ag        BaOH+           C2H4O_ethylen_o DF      In2I4    Nb      ScO2
 Ag+       Ba_OH_2         CH3CHO_ethanal  DOCl    In2I6    Nb+     Sc2O
 Ag-       BaS             CH3COOH         DO2     In2O     Nb-     Sc2O2
 Air       Ba2             OHCH2COOH       DO2-    K        NbCl5   Si
 Al        Be              C2H5            D2      K+       NbO     Si+
 Al+       Be+             C2H5Br          D2+     K-       NbOCl3  Si-
 Al-       Be++            C2H6            D2-     KAlF4    NbO2    SiBr
 AlBr      BeBr            CH3N2CH3        D2O     KBO2     Ne      SiBr2
 AlBr2     BeBr2           C2H5OH          D2O2    KBr      Ne+     SiBr3
 AlBr3     BeCl            CH3OCH3         D2S     KCN      Ni      SiBr4
 AlC       BeCl2           CH3O2CH3        e-      KCl      Ni+     SiC
 AlC2      BeF             CCN             F       KF       Ni-     SiC2
 AlCl      BeF2            CNC             F+      KH       NiCl    SiCl
 AlCl+     BeH             OCCN            F-      KI       NiCl2   SiCl2
 AlCl2     BeH+            C2N2            FCN     Kli      NiO     SiCl3
 AlCl3     BeH2            C2O             FCO     KNO2     NiS     SiCl4
 AlF       BeI             C3              FO      KNO3     O       SiF
 AlF+      BeI2            C3H3_1_propynl  FO2_FOO KNa      O+      SiFCl
 AlFCl     BeN             C3H3_2_propynl  FO2_OFO KO       O-      SiF2
 AlFCl2    BeO             C3H4_allene     F2      KOH      OD      SiF3
 AlF2      BeOH            C3H4_propyne    F2O     K2       OD-     SiF4
 AlF2-     BeOH+           C3H4_cyclo      F2O2    K2+      OH      SiH
 AlF2Cl    Be_OH_2         C3H5_allyl      FS2F    K2Br2    OH+     SiH+
 AlF3      BeS             C3H6_propylene  Fe      K2CO3    OH-     SiHBr3
 AlF4-     Be2             C3H6_cyclo      Fe+     K2C2N2   O2      SiHCl
 AlH       Be2Cl4          C3H6O_propylox  Fe_CO_5 K2Cl2    O2+     SiHCl3
 AlHCl     Be2F4           C3H6O_acetone   FeCl    K2F2     O2-     SiHF
 AlHCl2    Be2O            C3H6O_propanal  FeCl2   K2I2     O3      SiHF3
 AlHF      Be2OF2          C3H7_n_propyl   FeCl3   K2O      P       SiHI3
 AlHFCl    Be2O2           C3H7_i_propyl   FeO     K2O+     P+      SiH2
 AlHF2     Be3O3           C3H8            Fe_OH_2 K2O2     P-      SiH2Br2
 AlH2      Be4O4           C3H8O_1propanol Fe2Cl4  K2O2H2   PCl     SiH2Cl2
 AlH2Cl    Br              C3H8O_2propanol Fe2Cl6  K2SO4    PCl2    SiH2F2
 AlH2F     Br+             CNCOCN          Ga      Kr       PCl2-   SiH2I2
 AlH3      Br-             C3O2            Ga+     Kr+      PCl3    SiH3
 AlI       BrCl            C4              GaBr    li       PCl5    SiH3Br
 AlI2      BrF             C4H2_butadiyne  GaBr2   li+      PF      SiH3Cl
 AlI3      BrF3            C4H4_1_3-cyclo  GaBr3   li-      PF+     SiH3F
 AlN       BrF5            C4H6_butadiene  GaCl    liAlF4   PF-     SiH3I
 AlO       BrO             C4H6_1butyne    GaCl2   liBO2    PFCl    SiH4
 AlO+      OBrO            C4H6_2butyne    GaCl3   liBr     PFCl-   SiI
 AlO-      BrOO            C4H6_cyclo      GaF     liCl     PFCl2   SiI2
 AlOCl     BrO3            C4H8_1_butene   GaF2    liF      PFCl4   SiN
 AlOCl2    Br2             C4H8_cis2_buten GaF3    liH      PF2     SiO
 AlOF      BrBrO           C4H8_isobutene  GaH     liI      PF2-    SiO2
 AlOF2     BrOBr           C4H8_cyclo      GaI     liN      PF2Cl   SiS
 AlOF2-    C               C4H9_n_butyl    GaI2    liNO2    PF2Cl3  SiS2
 AlOH      C+              C4H9_i_butyl    GaI3    liNO3    PF3     Si2
 AlOHCl    C-              C4H9_s_butyl    GaO     liO      PF3Cl2  Si2C
 AlOHCl2   CBr             C4H9_t_butyl    GaOH    liOF     PF4Cl   Si2F6
 AlOHF     CBr2            C4H10_n_butane  Ga2Br2  liOH     PF5     Si2N
 AlOHF2    CBr3            C4H10_isobutane Ga2Br4  liON     PH      Si3
 AlO2      CBr4            C4N2            Ga2Br6  li2      PH2     Sn
 AlO2-     CCl             C5              Ga2Cl2  li2+     PH2-    Sn+
 Al_OH_2   CCl2            C5H6_1_3cyclo   Ga2Cl4  li2Br2   PH3     Sn-
 Al_OH_2Cl CCl2Br2         C5H8_cyclo      Ga2Cl6  li2F2    PN      SnBr
 Al_OH_2F  CCl3            C5H10_1_pentene Ga2F2   li2I2    PO      SnBr2
 Al_OH_3   CCl3Br          C5H10_cyclo     Ga2F4   li2O     PO-     SnBr3
 AlS       CCl4            C5H11_pentyl    Ga2F6   li2O+    POCl3   SnBr4
 AlS2      CF              C5H11_t_pentyl  Ga2I2   li2O2    POFCl2  SnCl
 Al2       CF+             C5H12_n_pentane Ga2I4   li2O2H2  POF2Cl  SnCl2
 Al2Br6    CFBr3           C5H12_i_pentane Ga2I6   li2SO4   POF3    SnCl3
 Al2C2     CFCl            CH3C_CH3_2CH3   Ga2O    li3+     PO2     SnCl4
 Al2Cl6    CFClBr2         C6D5_phenyl     Ge      li3Br3   PO2-    SnF
 Al2F6     CFCl2           C6D6            Ge+     li3Cl3   PS      SnF2
 Al2I6     CFCl2Br         C6H2            Ge-     li3F3    P2      SnF3
 Al2O      CFCl3           C6H5_phenyl     GeBr    li3I3    P2O3    SnF4
 Al2O+     CF2             C6H5O_phenoxy   GeBr2   Mg       P2O4    SnI
 Al2O2     CF2+            C6H6            GeBr3   Mg+      P2O5    SnI2
 Al2O2+    CF2Br2          C6H5OH_phenol   GeBr4   MgBr     P3      SnI3
 Al2O3     CF2Cl           C6H10_cyclo     GeCl    MgBr2    P3O6    SnI4
 Al2S      CF2ClBr         C6H12_1_hexene  GeCl2   MgCl     P4      SnO
 Al2S2     CF2Cl2          C6H12_cyclo     GeCl3   MgCl+    P4O6    SnO2
 Ar        CF3             C6H13_n_hexyl   GeCl4   MgCl2    P4O7    SnS
 Ar+       CF3+            C6H14_n_hexane  GeF     MgF      P4O8    SnS2
 B         CF3Br           C7H7_benzyl     GeF2    MgF+     P4O9    Sn2
 B+        CF3Cl           C7H8            GeF3    MgF2     P4O10   Sr
 B-        CF4             C7H8O_cresol_mx GeF4    MgF2+    Pb      Sr+
 BBr       CH+             C7H14_1_heptene GeH4    MgH      Pb+     SrBr
 BBr2      CHBr3           C7H15_n_heptyl  GeI     MgI      Pb-     SrBr2
 BBr3      CHCl            C7H16_n_heptane GeO     MgI2     PbBr    SrCl
 BC        CHClBr2         C7H16_2_methylh GeO2    MgN      PbBr2   SrCl+
 BC2       CHCl2           C8H8_styrene    GeS     MgO      PbBr3   SrCl2
 BCl       CHCl2Br         C8H10_ethylbenz GeS2    MgOH     PbBr4   SrF
 BCl+      CHCl3           C8H16_1_octene  Ge2     MgOH+    PbCl    SrF+
 BClOH     CHF             C8H17_n_octyl   H       Mg_OH_2  PbCl2   SrF2
 BCl_OH_2  CHFBr2          C8H18_n_octane  H+      MgS      PbCl3   SrH
 BCl2      CHFCl           C8H18_isooctane H-      Mg2      PbCl4   SrI
 BCl2+     CHFClBr         C9H19_n_nonyl   HAlO    Mg2F4    PbF     SrI2
 BCl2OH    CHFCl2          C10H8_naphthale HAlO2   Mn       PbF2    SrO
 BF        CHF2            C10H21_n_decyl  HBO     Mn+      PbF3    SrOH
 BFCl      CHF2Br          C12H9_o_bipheny HBO+    Mo       PbF4    SrOH+
 BFCl2     CHF2Cl          C12H10_biphenyl HBO2    Mo+      PbI     Sr_OH_2
 BFOH      CHF3            Ca              HBS     Mo-      PbI2    SrS
 BF_OH_2   CHI3            Ca+             HBS+    MoO      PbI3    Sr2
 BF2       CH2             CaBr            HCN     MoO2     PbI4    Ta
 BF2+      CH2Br2          CaBr2           HCO     MoO3     PbO     Ta+
 BF2-      CH2Cl           CaCl            HCO+    MoO3-    PbO2    Ta-
 BF2Cl     CH2ClBr         CaCl+           HCCN    Mo2O6    PbS     TaCl5
 BF2OH     CH2Cl2          CaCl2           HCCO    Mo3O9    PbS2    TaO
 BF3       CH2F            CaF             HCl     Mo4O12   Rb      TaO2
 BF4-      CH2FBr          CaF+            HD      Mo5O15   Rb+     Ti
 BH        CH2FCl          CaF2            HD+     N        Rb-     Ti+
 BHCl      CH2F2           CaH             HDO     N+       RbBO2   Ti-
 BHCl2     CH2I2           CaI             HDO2    N-       RbBr    TiCl
 BHF       CH3             CaI2            HF      NCO      RbCl    TiCl2
 BHFCl     CH3Br           CaO             HI      ND       RbF     TiCl3
 BHF2      CH3Cl           CaO+            HNC     ND2      RbH     TiCl4
 BH2       CH3F            CaOH            HNCO    ND3      RbI     TiO
 BH2Cl     CH3I            CaOH+           HNO     NF       RbK     TiO+
 BH2F      CH2OH           Ca_OH_2         HNO2    NF2      Rbli    TiOCl
 BH3       CH2OH+          CaS             HNO3    NF3      RbNO2   TiOCl2
 BH3NH3    CH3O            Ca2             HOCl    NH       RbNO3   TiO2
 BH4       CH4             Cd              HOF     NH+      RbNa    U
 BI        CH3OH           Cd+             HO2     NHF      RbO     UF
 BI2       CH3OOH          Cl              HO2-    NHF2     RbOH    UF+
 BI3       CI              Cl+             HPO     NH2      Rb2Br2  UF-
 BN        CI2             Cl-             HSO3F   NH2F     Rb2Cl2  UF2
 BO        CI3             ClCN            H2      NH3      Rb2F2   UF2+
 BO-       CI4             ClF             H2+     NH2OH    Rb2I2   UF2-
 BOCl      CN              ClF3            H2-     NH4+     Rb2O    UF3
 BOCl2     CN+             ClF5            HBOH    NO       Rb2O2   UF3+
 BOF       CN-             ClO             HCOOH   NOCl     Rb2O2H2 UF3-
 BOF2      CNN             ClO2            H2F2    NOF      Rb2SO4  UF4
 BOH       CO              Cl2             H2O     NOF3     Rn      UF4+
 BO2       CO+             Cl2O            H2O+    NO2      Rn+     UF4-
 BO2-      COCl            Co              H2O2    NO2-     S       UF5
 B_OH_2    COCl2           Co+             H2S     NO2Cl    S+      UF5+
 BS        COFCl           Co-             H2SO4   NO2F     S-      UF5-
 BS2       COF2            Cr              H2BOH   NO3      SCl     UF6
 B2        COHCl           Cr+             HB_OH_2 NO3-     SCl2    UF6-
 B2C       COHF            Cr-             H3BO3   NO3F     SCl2+   UO
 B2Cl4     COS             CrN             H3B3O3  N2       SD      UO+
 B2F4      CO2             CrO             H3B3O6  N2+      SF      UOF
 B2H       CO2+            CrO2            H3F3    N2-      SF+     UOF2
 B2H2      COOH            CrO3            H3O+    NCN      SF-     UOF3
 B2H3      CP              CrO3-           H4F4    N2D2_cis SF2     UOF4
 B2H3_db   CS              Cs              H5F5    N2F2     SF2+    UO2
 B2H4      CS2             Cs+             H6F6    N2F4     SF2-    UO2+
 B2H4_db   C2              Cs-             H7F7    N2H2     SF3     UO2-
 B2H5      C2+             CsBO2           He      NH2NO2   SF3+    UO2F
 B2H5_db   C2-             CsBr            He+     N2H4     SF3-    UO2F2
 B2H6      C2Cl            CsCl            Hg      N2O      SF4     UO3
 B2O       C2Cl2           CsF             Hg+     N2O+     SF4+    UO3-
 B2O2      C2Cl3           CsH             HgBr2   N2O3     SF4-    V
 B2O3      C2Cl4           CsI             I       N2O4     SF5     V+
 B2_OH_4   C2Cl6           Csli            I+      N2O5     SF5+    V-
 B2S       C2F             CsNO2           I-      N3       SF5-    VCl4
 B2S2      C2FCl           CsNO3           IF5     N3H      SF6     VN
 B2S3      C2FCl3          CsNa            IF7     Na       SF6-    VO
 B3H7_C2v  C2F2            CsO             I2      Na+      SH      VO2
 B3H7_Cs   C2F2Cl2         CsOH            In      Na-      SH-     V4O10
 B3H9      C2F3            CsRb            In+     NaAlF4   SN      W
 B3N3H6    C2F3Cl          Cs2             InBr    NaBO2    SO      W+
 B3O3Cl3   C2F4            Cs2Br2          InBr2   NaBr     SO-     W-
 B3O3FCl2  C2F6            Cs2CO3          InBr3   NaCN     SOF2    WCl6
 B3O3F2Cl  C2H             Cs2Cl2          InCl    NaCl     SO2     WO
 B3O3F3    C2HCl           Cs2F2           InCl2   NaF      SO2-    WOCl4
 B4H4      C2HCl3          Cs2I2           InCl3   NaH      SO2Cl2  WO2
 B4H10     C2HF            Cs2O            InF     NaI      SO2FCl  WO2Cl2
 B4H12     C2HFCl2         Cs2O+           InF2    Nali     SO2F2   WO3
 B5H9      C2HF2Cl         Cs2O2           InF3    NaNO2    SO3     WO3-
 Ba        C2HF3           Cs2O2H2         InH     NaNO3    S2      Xe
 Ba+       C2H2_vinylidene Cs2SO4          InI     NaO      S2-     Xe+
 BaBr      C2H2Cl2         Cu              InI2    NaOH     S2Cl2   Zn
 BaBr2     C2H2FCl         Cu+             InI3    NaOH+    S2F2    Zn+
 BaCl      C2H2F2          Cu-             InO     Na2      S2O     Zr
 BaCl+     CH2CO_ketene    CuCl            InOH    Na2Br2   S3      Zr+
 BaCl2     O_CH_2O         CuF             In2Br2  Na2Cl2   S4      Zr-
 BaF       HO_CO_2OH       CuF2            In2Br4  Na2F2    S5      ZrN
 BaF+      C2H3_vinyl      CuO             In2Br6  Na2I2    S6      ZrO
 BaF2      CH2Br-COOH      Cu2             In2Cl2  Na2O     S7      ZrO+
 BaH       C2H3Cl          Cu3Cl3          In2Cl4  Na2O+    S8      ZrO2
 BaI       CH2Cl-COOH      D               In2Cl6  Na2O2    Sc
 BaI2      C2H3F           D+              In2F2   Na2O2H2  Sc+
 BaO       CH3CN           D-              In2F4   Na2SO4   Sc-
 BaO+      CH3CO_acetyl    DBr             In2F6   Na3Cl3   ScO
 BaOH      C2H4            DCl             In2I2   Na3F3    ScO+
</pre>
</HTML>"));
        end SingleGasesData;
      annotation (Documentation(info="<html>

</html>"));
      end Common;

      package MixtureGases
        "Medium models consisting of mixtures of ideal gases"
        extends Modelica.Icons.VariantsPackage;

        package CombustionAir "Air as mixture of N2 and O2"
          extends Common.MixtureGasNasa(
            mediumName="CombustionAirN2O2",
            data={Common.SingleGasesData.N2,
           Common.SingleGasesData.O2},
            fluidConstants={Common.FluidData.N2,
              Common.FluidData.O2},
            substanceNames = {"Nitrogen", "Oxygen"},
            reference_X={0.768,0.232});
          annotation (Documentation(info="<html>

</html>"));
        end CombustionAir;
        annotation (Documentation(info="<html>

</html>"));
      end MixtureGases;
    annotation (Documentation(info="<HTML>
<p>This package contains data for the 1241 ideal gases from</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>Medium models for some of these gases are available in package
<a href=\"modelica://Modelica.Media.IdealGases.SingleGases\">IdealGases.SingleGases</a>
and some examples for mixtures are available in package <a href=\"modelica://Modelica.Media.IdealGases.MixtureGases\">IdealGases.MixtureGases</a>
</p>
<h4>Using and Adapting Medium Models</h4>
<p>
The data records allow computing the ideal gas specific enthalpy, specific entropy and heat capacity of the substances listed below. From them, even the Gibbs energy and equilibrium constants for reactions can be computed. Critical data that is needed for computing the viscosity and thermal conductivity is not included. In order to add mixtures or single substance medium packages that are
subtypes of
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">Interfaces.PartialMedium</a>
(i.e., can be utilized at all places where PartialMedium is defined),
a few additional steps have to be performed:
</p>
<ol>
<li>
All single gas media need to define a constant instance of record
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium.FluidConstants\">IdealGases.Common.SingleGasNasa.FluidConstants</a>.
For 37 ideal gases such records are provided in package
<a href=\"modelica://Modelica.Media.IdealGases.Common.FluidData\">IdealGases.Common.FluidData</a>.
For the other gases, such a record instance has to be provided by the user, e.g., by getting
the data from a commercial or public data base. A public source of the needed data is for example the <a href=\"http://webbook.nist.gov/chemistry/\"> NIST Chemistry WebBook</a></li>

<li>When the data is available, and a user has an instance of a
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium.FluidConstants\">FluidConstants</a> record filled with data, a medium package has to be written. Note that only the dipole moment, the accentric factor and critical data are necessary for the viscosity and thermal conductivity functions.</li>
<li><ul>
<li>For single components, a new package following the pattern in
<a href=\"modelica://Modelica.Media.IdealGases.SingleGases\">IdealGases.SingleGases</a> has to be created, pointing both to a data record for cp and to a user-defined fluidContants record.</li>
<li>For mixtures of several components, a new package following the pattern in
<a href=\"modelica://Modelica.Media.IdealGases.MixtureGases\">IdealGases.MixtureGases</a> has to be created, building an array of data records for cp and an array of (partly) user-defined fluidContants records.</li>
</ul></li>
</ol>
<p>Note that many properties can computed for the full set of 1241 gases listed below, but due to the missing viscosity and thermal conductivity functions, no fully Modelica.Media-compliant media can be defined.</p>
<p>
Data records for heat capacity, specific enthalpy and specific entropy exist for the following substances and ions:
</p>
<pre>
 Ag        BaOH+           C2H4O_ethylen_o DF      In2I4    Nb      ScO2
 Ag+       Ba_OH_2         CH3CHO_ethanal  DOCl    In2I6    Nb+     Sc2O
 Ag-       BaS             CH3COOH         DO2     In2O     Nb-     Sc2O2
 Air       Ba2             OHCH2COOH       DO2-    K        NbCl5   Si
 Al        Be              C2H5            D2      K+       NbO     Si+
 Al+       Be+             C2H5Br          D2+     K-       NbOCl3  Si-
 Al-       Be++            C2H6            D2-     KAlF4    NbO2    SiBr
 AlBr      BeBr            CH3N2CH3        D2O     KBO2     Ne      SiBr2
 AlBr2     BeBr2           C2H5OH          D2O2    KBr      Ne+     SiBr3
 AlBr3     BeCl            CH3OCH3         D2S     KCN      Ni      SiBr4
 AlC       BeCl2           CH3O2CH3        e-      KCl      Ni+     SiC
 AlC2      BeF             CCN             F       KF       Ni-     SiC2
 AlCl      BeF2            CNC             F+      KH       NiCl    SiCl
 AlCl+     BeH             OCCN            F-      KI       NiCl2   SiCl2
 AlCl2     BeH+            C2N2            FCN     Kli      NiO     SiCl3
 AlCl3     BeH2            C2O             FCO     KNO2     NiS     SiCl4
 AlF       BeI             C3              FO      KNO3     O       SiF
 AlF+      BeI2            C3H3_1_propynl  FO2_FOO KNa      O+      SiFCl
 AlFCl     BeN             C3H3_2_propynl  FO2_OFO KO       O-      SiF2
 AlFCl2    BeO             C3H4_allene     F2      KOH      OD      SiF3
 AlF2      BeOH            C3H4_propyne    F2O     K2       OD-     SiF4
 AlF2-     BeOH+           C3H4_cyclo      F2O2    K2+      OH      SiH
 AlF2Cl    Be_OH_2         C3H5_allyl      FS2F    K2Br2    OH+     SiH+
 AlF3      BeS             C3H6_propylene  Fe      K2CO3    OH-     SiHBr3
 AlF4-     Be2             C3H6_cyclo      Fe+     K2C2N2   O2      SiHCl
 AlH       Be2Cl4          C3H6O_propylox  Fe_CO_5 K2Cl2    O2+     SiHCl3
 AlHCl     Be2F4           C3H6O_acetone   FeCl    K2F2     O2-     SiHF
 AlHCl2    Be2O            C3H6O_propanal  FeCl2   K2I2     O3      SiHF3
 AlHF      Be2OF2          C3H7_n_propyl   FeCl3   K2O      P       SiHI3
 AlHFCl    Be2O2           C3H7_i_propyl   FeO     K2O+     P+      SiH2
 AlHF2     Be3O3           C3H8            Fe_OH_2 K2O2     P-      SiH2Br2
 AlH2      Be4O4           C3H8O_1propanol Fe2Cl4  K2O2H2   PCl     SiH2Cl2
 AlH2Cl    Br              C3H8O_2propanol Fe2Cl6  K2SO4    PCl2    SiH2F2
 AlH2F     Br+             CNCOCN          Ga      Kr       PCl2-   SiH2I2
 AlH3      Br-             C3O2            Ga+     Kr+      PCl3    SiH3
 AlI       BrCl            C4              GaBr    li       PCl5    SiH3Br
 AlI2      BrF             C4H2_butadiyne  GaBr2   li+      PF      SiH3Cl
 AlI3      BrF3            C4H4_1_3-cyclo  GaBr3   li-      PF+     SiH3F
 AlN       BrF5            C4H6_butadiene  GaCl    liAlF4   PF-     SiH3I
 AlO       BrO             C4H6_1butyne    GaCl2   liBO2    PFCl    SiH4
 AlO+      OBrO            C4H6_2butyne    GaCl3   liBr     PFCl-   SiI
 AlO-      BrOO            C4H6_cyclo      GaF     liCl     PFCl2   SiI2
 AlOCl     BrO3            C4H8_1_butene   GaF2    liF      PFCl4   SiN
 AlOCl2    Br2             C4H8_cis2_buten GaF3    liH      PF2     SiO
 AlOF      BrBrO           C4H8_isobutene  GaH     liI      PF2-    SiO2
 AlOF2     BrOBr           C4H8_cyclo      GaI     liN      PF2Cl   SiS
 AlOF2-    C               C4H9_n_butyl    GaI2    liNO2    PF2Cl3  SiS2
 AlOH      C+              C4H9_i_butyl    GaI3    liNO3    PF3     Si2
 AlOHCl    C-              C4H9_s_butyl    GaO     liO      PF3Cl2  Si2C
 AlOHCl2   CBr             C4H9_t_butyl    GaOH    liOF     PF4Cl   Si2F6
 AlOHF     CBr2            C4H10_n_butane  Ga2Br2  liOH     PF5     Si2N
 AlOHF2    CBr3            C4H10_isobutane Ga2Br4  liON     PH      Si3
 AlO2      CBr4            C4N2            Ga2Br6  li2      PH2     Sn
 AlO2-     CCl             C5              Ga2Cl2  li2+     PH2-    Sn+
 Al_OH_2   CCl2            C5H6_1_3cyclo   Ga2Cl4  li2Br2   PH3     Sn-
 Al_OH_2Cl CCl2Br2         C5H8_cyclo      Ga2Cl6  li2F2    PN      SnBr
 Al_OH_2F  CCl3            C5H10_1_pentene Ga2F2   li2I2    PO      SnBr2
 Al_OH_3   CCl3Br          C5H10_cyclo     Ga2F4   li2O     PO-     SnBr3
 AlS       CCl4            C5H11_pentyl    Ga2F6   li2O+    POCl3   SnBr4
 AlS2      CF              C5H11_t_pentyl  Ga2I2   li2O2    POFCl2  SnCl
 Al2       CF+             C5H12_n_pentane Ga2I4   li2O2H2  POF2Cl  SnCl2
 Al2Br6    CFBr3           C5H12_i_pentane Ga2I6   li2SO4   POF3    SnCl3
 Al2C2     CFCl            CH3C_CH3_2CH3   Ga2O    li3+     PO2     SnCl4
 Al2Cl6    CFClBr2         C6D5_phenyl     Ge      li3Br3   PO2-    SnF
 Al2F6     CFCl2           C6D6            Ge+     li3Cl3   PS      SnF2
 Al2I6     CFCl2Br         C6H2            Ge-     li3F3    P2      SnF3
 Al2O      CFCl3           C6H5_phenyl     GeBr    li3I3    P2O3    SnF4
 Al2O+     CF2             C6H5O_phenoxy   GeBr2   Mg       P2O4    SnI
 Al2O2     CF2+            C6H6            GeBr3   Mg+      P2O5    SnI2
 Al2O2+    CF2Br2          C6H5OH_phenol   GeBr4   MgBr     P3      SnI3
 Al2O3     CF2Cl           C6H10_cyclo     GeCl    MgBr2    P3O6    SnI4
 Al2S      CF2ClBr         C6H12_1_hexene  GeCl2   MgCl     P4      SnO
 Al2S2     CF2Cl2          C6H12_cyclo     GeCl3   MgCl+    P4O6    SnO2
 Ar        CF3             C6H13_n_hexyl   GeCl4   MgCl2    P4O7    SnS
 Ar+       CF3+            C6H14_n_hexane  GeF     MgF      P4O8    SnS2
 B         CF3Br           C7H7_benzyl     GeF2    MgF+     P4O9    Sn2
 B+        CF3Cl           C7H8            GeF3    MgF2     P4O10   Sr
 B-        CF4             C7H8O_cresol_mx GeF4    MgF2+    Pb      Sr+
 BBr       CH+             C7H14_1_heptene GeH4    MgH      Pb+     SrBr
 BBr2      CHBr3           C7H15_n_heptyl  GeI     MgI      Pb-     SrBr2
 BBr3      CHCl            C7H16_n_heptane GeO     MgI2     PbBr    SrCl
 BC        CHClBr2         C7H16_2_methylh GeO2    MgN      PbBr2   SrCl+
 BC2       CHCl2           C8H8_styrene    GeS     MgO      PbBr3   SrCl2
 BCl       CHCl2Br         C8H10_ethylbenz GeS2    MgOH     PbBr4   SrF
 BCl+      CHCl3           C8H16_1_octene  Ge2     MgOH+    PbCl    SrF+
 BClOH     CHF             C8H17_n_octyl   H       Mg_OH_2  PbCl2   SrF2
 BCl_OH_2  CHFBr2          C8H18_n_octane  H+      MgS      PbCl3   SrH
 BCl2      CHFCl           C8H18_isooctane H-      Mg2      PbCl4   SrI
 BCl2+     CHFClBr         C9H19_n_nonyl   HAlO    Mg2F4    PbF     SrI2
 BCl2OH    CHFCl2          C10H8_naphthale HAlO2   Mn       PbF2    SrO
 BF        CHF2            C10H21_n_decyl  HBO     Mn+      PbF3    SrOH
 BFCl      CHF2Br          C12H9_o_bipheny HBO+    Mo       PbF4    SrOH+
 BFCl2     CHF2Cl          C12H10_biphenyl HBO2    Mo+      PbI     Sr_OH_2
 BFOH      CHF3            Ca              HBS     Mo-      PbI2    SrS
 BF_OH_2   CHI3            Ca+             HBS+    MoO      PbI3    Sr2
 BF2       CH2             CaBr            HCN     MoO2     PbI4    Ta
 BF2+      CH2Br2          CaBr2           HCO     MoO3     PbO     Ta+
 BF2-      CH2Cl           CaCl            HCO+    MoO3-    PbO2    Ta-
 BF2Cl     CH2ClBr         CaCl+           HCCN    Mo2O6    PbS     TaCl5
 BF2OH     CH2Cl2          CaCl2           HCCO    Mo3O9    PbS2    TaO
 BF3       CH2F            CaF             HCl     Mo4O12   Rb      TaO2
 BF4-      CH2FBr          CaF+            HD      Mo5O15   Rb+     Ti
 BH        CH2FCl          CaF2            HD+     N        Rb-     Ti+
 BHCl      CH2F2           CaH             HDO     N+       RbBO2   Ti-
 BHCl2     CH2I2           CaI             HDO2    N-       RbBr    TiCl
 BHF       CH3             CaI2            HF      NCO      RbCl    TiCl2
 BHFCl     CH3Br           CaO             HI      ND       RbF     TiCl3
 BHF2      CH3Cl           CaO+            HNC     ND2      RbH     TiCl4
 BH2       CH3F            CaOH            HNCO    ND3      RbI     TiO
 BH2Cl     CH3I            CaOH+           HNO     NF       RbK     TiO+
 BH2F      CH2OH           Ca_OH_2         HNO2    NF2      Rbli    TiOCl
 BH3       CH2OH+          CaS             HNO3    NF3      RbNO2   TiOCl2
 BH3NH3    CH3O            Ca2             HOCl    NH       RbNO3   TiO2
 BH4       CH4             Cd              HOF     NH+      RbNa    U
 BI        CH3OH           Cd+             HO2     NHF      RbO     UF
 BI2       CH3OOH          Cl              HO2-    NHF2     RbOH    UF+
 BI3       CI              Cl+             HPO     NH2      Rb2Br2  UF-
 BN        CI2             Cl-             HSO3F   NH2F     Rb2Cl2  UF2
 BO        CI3             ClCN            H2      NH3      Rb2F2   UF2+
 BO-       CI4             ClF             H2+     NH2OH    Rb2I2   UF2-
 BOCl      CN              ClF3            H2-     NH4+     Rb2O    UF3
 BOCl2     CN+             ClF5            HBOH    NO       Rb2O2   UF3+
 BOF       CN-             ClO             HCOOH   NOCl     Rb2O2H2 UF3-
 BOF2      CNN             ClO2            H2F2    NOF      Rb2SO4  UF4
 BOH       CO              Cl2             H2O     NOF3     Rn      UF4+
 BO2       CO+             Cl2O            H2O+    NO2      Rn+     UF4-
 BO2-      COCl            Co              H2O2    NO2-     S       UF5
 B_OH_2    COCl2           Co+             H2S     NO2Cl    S+      UF5+
 BS        COFCl           Co-             H2SO4   NO2F     S-      UF5-
 BS2       COF2            Cr              H2BOH   NO3      SCl     UF6
 B2        COHCl           Cr+             HB_OH_2 NO3-     SCl2    UF6-
 B2C       COHF            Cr-             H3BO3   NO3F     SCl2+   UO
 B2Cl4     COS             CrN             H3B3O3  N2       SD      UO+
 B2F4      CO2             CrO             H3B3O6  N2+      SF      UOF
 B2H       CO2+            CrO2            H3F3    N2-      SF+     UOF2
 B2H2      COOH            CrO3            H3O+    NCN      SF-     UOF3
 B2H3      CP              CrO3-           H4F4    N2D2_cis SF2     UOF4
 B2H3_db   CS              Cs              H5F5    N2F2     SF2+    UO2
 B2H4      CS2             Cs+             H6F6    N2F4     SF2-    UO2+
 B2H4_db   C2              Cs-             H7F7    N2H2     SF3     UO2-
 B2H5      C2+             CsBO2           He      NH2NO2   SF3+    UO2F
 B2H5_db   C2-             CsBr            He+     N2H4     SF3-    UO2F2
 B2H6      C2Cl            CsCl            Hg      N2O      SF4     UO3
 B2O       C2Cl2           CsF             Hg+     N2O+     SF4+    UO3-
 B2O2      C2Cl3           CsH             HgBr2   N2O3     SF4-    V
 B2O3      C2Cl4           CsI             I       N2O4     SF5     V+
 B2_OH_4   C2Cl6           Csli            I+      N2O5     SF5+    V-
 B2S       C2F             CsNO2           I-      N3       SF5-    VCl4
 B2S2      C2FCl           CsNO3           IF5     N3H      SF6     VN
 B2S3      C2FCl3          CsNa            IF7     Na       SF6-    VO
 B3H7_C2v  C2F2            CsO             I2      Na+      SH      VO2
 B3H7_Cs   C2F2Cl2         CsOH            In      Na-      SH-     V4O10
 B3H9      C2F3            CsRb            In+     NaAlF4   SN      W
 B3N3H6    C2F3Cl          Cs2             InBr    NaBO2    SO      W+
 B3O3Cl3   C2F4            Cs2Br2          InBr2   NaBr     SO-     W-
 B3O3FCl2  C2F6            Cs2CO3          InBr3   NaCN     SOF2    WCl6
 B3O3F2Cl  C2H             Cs2Cl2          InCl    NaCl     SO2     WO
 B3O3F3    C2HCl           Cs2F2           InCl2   NaF      SO2-    WOCl4
 B4H4      C2HCl3          Cs2I2           InCl3   NaH      SO2Cl2  WO2
 B4H10     C2HF            Cs2O            InF     NaI      SO2FCl  WO2Cl2
 B4H12     C2HFCl2         Cs2O+           InF2    Nali     SO2F2   WO3
 B5H9      C2HF2Cl         Cs2O2           InF3    NaNO2    SO3     WO3-
 Ba        C2HF3           Cs2O2H2         InH     NaNO3    S2      Xe
 Ba+       C2H2_vinylidene Cs2SO4          InI     NaO      S2-     Xe+
 BaBr      C2H2Cl2         Cu              InI2    NaOH     S2Cl2   Zn
 BaBr2     C2H2FCl         Cu+             InI3    NaOH+    S2F2    Zn+
 BaCl      C2H2F2          Cu-             InO     Na2      S2O     Zr
 BaCl+     CH2CO_ketene    CuCl            InOH    Na2Br2   S3      Zr+
 BaCl2     O_CH_2O         CuF             In2Br2  Na2Cl2   S4      Zr-
 BaF       HO_CO_2OH       CuF2            In2Br4  Na2F2    S5      ZrN
 BaF+      C2H3_vinyl      CuO             In2Br6  Na2I2    S6      ZrO
 BaF2      CH2Br-COOH      Cu2             In2Cl2  Na2O     S7      ZrO+
 BaH       C2H3Cl          Cu3Cl3          In2Cl4  Na2O+    S8      ZrO2
 BaI       CH2Cl-COOH      D               In2Cl6  Na2O2    Sc
 BaI2      C2H3F           D+              In2F2   Na2O2H2  Sc+
 BaO       CH3CN           D-              In2F4   Na2SO4   Sc-
 BaO+      CH3CO_acetyl    DBr             In2F6   Na3Cl3   ScO
 BaOH      C2H4            DCl             In2I2   Na3F3    ScO+
</pre></HTML>"));
    end IdealGases;

    package Water "Medium models for water"
    extends Modelica.Icons.VariantsPackage;
    import Modelica.Media.Water.ConstantPropertyLiquidWater.simpleWaterConstants;

    constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants[1]
      waterConstants(
      each chemicalFormula="H2O",
      each structureFormula="H2O",
      each casRegistryNumber="7732-18-5",
      each iupacName="oxidane",
      each molarMass=0.018015268,
      each criticalTemperature=647.096,
      each criticalPressure=22064.0e3,
      each criticalMolarVolume=1/322.0*0.018015268,
      each normalBoilingPoint=373.124,
      each meltingPoint=273.15,
      each triplePointTemperature=273.16,
      each triplePointPressure=611.657,
      each acentricFactor=0.344,
      each dipoleMoment=1.8,
      each hasCriticalData=true);

    package ConstantPropertyLiquidWater
        "Water: Simple liquid water medium (incompressible, constant data)"

      constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
        simpleWaterConstants(
        each chemicalFormula="H2O",
        each structureFormula="H2O",
        each casRegistryNumber="7732-18-5",
        each iupacName="oxidane",
        each molarMass=0.018015268);
      extends Interfaces.PartialSimpleMedium(
        mediumName="SimpleLiquidWater",
        cp_const=4184,
        cv_const=4184,
        d_const=995.586,
        eta_const=1.e-3,
        lambda_const=0.598,
        a_const=1484,
        T_min=Cv.from_degC(-1),
        T_max=Cv.from_degC(130),
        T0=273.15,
        MM_const=0.018015268,
        fluidConstants=simpleWaterConstants);
      annotation (Documentation(info="<html>

</html>"));
    end ConstantPropertyLiquidWater;

    package StandardWater = WaterIF97_ph
        "Water using the IF97 standard, explicit in p and h. Recommended for most applications";

    package WaterIF97_ph "Water using the IF97 standard, explicit in p and h"
      extends WaterIF97_base(
        ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
        final ph_explicit=true,
        final dT_explicit=false,
        final pT_explicit=false,
        smoothModel=false,
        onePhase=false);
      annotation (Documentation(info="<html>

</html>"));
    end WaterIF97_ph;

    partial package WaterIF97_base
        "Water: Steam properties as defined by IAPWS/IF97 standard"

      extends Interfaces.PartialTwoPhaseMedium(
        mediumName="WaterIF97",
        substanceNames={"water"},
        singleState=false,
        SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
        Density(start=150, nominal=500),
        AbsolutePressure(
          start=50e5,
          nominal=10e5,
          min=611.657,
          max=100e6),
        Temperature(
          start=500,
          nominal=500,
          min=273.15,
          max=2273.15),
        smoothModel=false,
        onePhase=false,
        fluidConstants=waterConstants);

      redeclare record extends ThermodynamicState "Thermodynamic state"
        SpecificEnthalpy h "Specific enthalpy";
        Density d "Density";
        Temperature T "Temperature";
        AbsolutePressure p "Pressure";
      end ThermodynamicState;

      constant Boolean ph_explicit
          "True if explicit in pressure and specific enthalpy";
      constant Boolean dT_explicit
          "True if explicit in density and temperature";
      constant Boolean pT_explicit
          "True if explicit in pressure and temperature";

      redeclare replaceable model extends BaseProperties(
        h(stateSelect=if ph_explicit and preferredMediumStates then StateSelect.prefer
               else StateSelect.default),
        d(stateSelect=if dT_explicit and preferredMediumStates then StateSelect.prefer
               else StateSelect.default),
        T(stateSelect=if (pT_explicit or dT_explicit) and preferredMediumStates
               then StateSelect.prefer else StateSelect.default),
        p(stateSelect=if (pT_explicit or ph_explicit) and preferredMediumStates
               then StateSelect.prefer else StateSelect.default))
          "Base properties of water"
        Integer phase(
          min=0,
          max=2,
          start=1,
          fixed=false) "2 for two-phase, 1 for one-phase, 0 if not known";
      equation
        MM = fluidConstants[1].molarMass;
        if smoothModel then
          if onePhase then
            phase = 1;
            if ph_explicit then
              assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
                fluidConstants[1].criticalPressure),
                "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
                 + "(p = " + String(p) + ", h = " + String(h) + ")");
            else
              if dT_explicit then
                assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
                   < fluidConstants[1].criticalTemperature),
                  "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!"
                   + "(d = " + String(d) + ", T = " + String(T) + ")");
              end if;
            end if;
          else
            phase = 0;
          end if;
        else
          if ph_explicit then
            phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
              fluidConstants[1].criticalPressure) then 1 else 2;
          elseif dT_explicit then
            phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
               < fluidConstants[1].criticalTemperature) then 1 else 2;
          else
            phase = 1;
            //this is for the one-phase only case pT
          end if;
        end if;
        if dT_explicit then
          p = pressure_dT(
                d,
                T,
                phase);
          h = specificEnthalpy_dT(
                d,
                T,
                phase);
          sat.Tsat = T;
          sat.psat = saturationPressure(T);
        elseif ph_explicit then
          d = density_ph(
                p,
                h,
                phase);
          T = temperature_ph(
                p,
                h,
                phase);
          sat.Tsat = saturationTemperature(p);
          sat.psat = p;
        else
          h = specificEnthalpy_pT(p, T);
          d = density_pT(p, T);
          sat.psat = p;
          sat.Tsat = saturationTemperature(p);
        end if;
        u = h - p/d;
        R = Modelica.Constants.R/fluidConstants[1].molarMass;
        h = state.h;
        p = state.p;
        T = state.T;
        d = state.d;
        phase = state.phase;
      end BaseProperties;

      redeclare function density_ph
          "Computes density as a function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := IF97_Utilities.rho_ph(
              p,
              h,
              phase);
        annotation (Inline=true);
      end density_ph;

      redeclare function temperature_ph
          "Computes temperature as a function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := IF97_Utilities.T_ph(
              p,
              h,
              phase);
        annotation (Inline=true);
      end temperature_ph;

      redeclare function temperature_ps
          "Compute temperature from pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := IF97_Utilities.T_ps(
              p,
              s,
              phase);
        annotation (Inline=true);
      end temperature_ps;

      redeclare function density_ps
          "Computes density as a function of pressure and specific enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := IF97_Utilities.rho_ps(
              p,
              s,
              phase);
        annotation (Inline=true);
      end density_ps;

      redeclare function pressure_dT
          "Computes pressure as a function of density and temperature"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output AbsolutePressure p "Pressure";
      algorithm
        p := IF97_Utilities.p_dT(
              d,
              T,
              phase);
        annotation (Inline=true);
      end pressure_dT;

      redeclare function specificEnthalpy_dT
          "Computes specific enthalpy as a function of density and temperature"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := IF97_Utilities.h_dT(
              d,
              T,
              phase);
        annotation (Inline=true);
      end specificEnthalpy_dT;

      redeclare function specificEnthalpy_pT
          "Computes specific enthalpy as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := IF97_Utilities.h_pT(p, T);
        annotation (Inline=true);
      end specificEnthalpy_pT;

      redeclare function specificEnthalpy_ps
          "Computes specific enthalpy as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := IF97_Utilities.h_ps(
              p,
              s,
              phase);
        annotation (Inline=true);
      end specificEnthalpy_ps;

      redeclare function density_pT
          "Computes density as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := IF97_Utilities.rho_pT(p, T);
        annotation (Inline=true);
      end density_pT;

      redeclare function extends setDewState
          "Set the thermodynamic state on the dew line"
      algorithm
        state := ThermodynamicState(
              phase=phase,
              p=sat.psat,
              T=sat.Tsat,
              h=dewEnthalpy(sat),
              d=dewDensity(sat));
        annotation (Inline=true);
      end setDewState;

      redeclare function extends setBubbleState
          "Set the thermodynamic state on the bubble line"
      algorithm
        state := ThermodynamicState(
              phase=phase,
              p=sat.psat,
              T=sat.Tsat,
              h=bubbleEnthalpy(sat),
              d=bubbleDensity(sat));
        annotation (Inline=true);
      end setBubbleState;

      redeclare function extends dynamicViscosity "Dynamic viscosity of water"
      algorithm
        eta := IF97_Utilities.dynamicViscosity(
              state.d,
              state.T,
              state.p,
              state.phase);
        annotation (Inline=true);
      end dynamicViscosity;

      redeclare function extends thermalConductivity
          "Thermal conductivity of water"
      algorithm
        lambda := IF97_Utilities.thermalConductivity(
              state.d,
              state.T,
              state.p,
              state.phase);
        annotation (Inline=true);
      end thermalConductivity;

      redeclare function extends surfaceTension
          "Surface tension in two phase region of water"
      algorithm
        sigma := IF97_Utilities.surfaceTension(sat.Tsat);
        annotation (Inline=true);
      end surfaceTension;

      redeclare function extends pressure "Return pressure of ideal gas"
      algorithm
        p := state.p;
        annotation (Inline=true);
      end pressure;

      redeclare function extends temperature "Return temperature of ideal gas"
      algorithm
        T := state.T;
        annotation (Inline=true);
      end temperature;

      redeclare function extends density "Return density of ideal gas"
      algorithm
        d := state.d;
        annotation (Inline=true);
      end density;

      redeclare function extends specificEnthalpy "Return specific enthalpy"
        extends Modelica.Icons.Function;
      algorithm
        h := state.h;
        annotation (Inline=true);
      end specificEnthalpy;

      redeclare function extends specificInternalEnergy
          "Return specific internal energy"
        extends Modelica.Icons.Function;
      algorithm
        u := state.h - state.p/state.d;
        annotation (Inline=true);
      end specificInternalEnergy;

      redeclare function extends specificGibbsEnergy
          "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
      algorithm
        g := state.h - state.T*specificEntropy(state);
        annotation (Inline=true);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy
          "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
      algorithm
        f := state.h - state.p/state.d - state.T*specificEntropy(state);
        annotation (Inline=true);
      end specificHelmholtzEnergy;

      redeclare function extends specificEntropy "Specific entropy of water"
      algorithm
        s := if dT_explicit then IF97_Utilities.s_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then IF97_Utilities.s_pT(state.p,
          state.T) else IF97_Utilities.s_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end specificEntropy;

      redeclare function extends specificHeatCapacityCp
          "Specific heat capacity at constant pressure of water"
      algorithm
        cp := if dT_explicit then IF97_Utilities.cp_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then IF97_Utilities.cp_pT(state.p,
          state.T) else IF97_Utilities.cp_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true, Documentation(info="<html>
                                <p>In the two phase region this function returns the interpolated heat capacity between the
                                liquid and vapour state heat capacities.</p>
                                </html>"));
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
          "Specific heat capacity at constant volume of water"
      algorithm
        cv := if dT_explicit then IF97_Utilities.cv_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then IF97_Utilities.cv_pT(state.p,
          state.T) else IF97_Utilities.cv_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent
          "Return isentropic exponent"
      algorithm
        gamma := if dT_explicit then IF97_Utilities.isentropicExponent_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then
          IF97_Utilities.isentropicExponent_pT(state.p, state.T) else
          IF97_Utilities.isentropicExponent_ph(
              state.p,
              state.h,
              state.phase);
      end isentropicExponent;

      redeclare function extends isothermalCompressibility
          "Isothermal compressibility of water"
      algorithm
        kappa := if dT_explicit then IF97_Utilities.kappa_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then IF97_Utilities.kappa_pT(state.p,
          state.T) else IF97_Utilities.kappa_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end isothermalCompressibility;

      redeclare function extends isobaricExpansionCoefficient
          "Isobaric expansion coefficient of water"
      algorithm
        beta := if dT_explicit then IF97_Utilities.beta_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then IF97_Utilities.beta_pT(state.p,
          state.T) else IF97_Utilities.beta_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end isobaricExpansionCoefficient;

      redeclare function extends velocityOfSound
          "Return velocity of sound as a function of the thermodynamic state record"
      algorithm
        a := if dT_explicit then IF97_Utilities.velocityOfSound_dT(
              state.d,
              state.T,
              state.phase) else if pT_explicit then
          IF97_Utilities.velocityOfSound_pT(state.p, state.T) else
          IF97_Utilities.velocityOfSound_ph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end velocityOfSound;

      redeclare function extends isentropicEnthalpy "Compute h(p,s)"
      algorithm
        h_is := IF97_Utilities.isentropicEnthalpy(
              p_downstream,
              specificEntropy(refState),
              0);
        annotation (Inline=true);
      end isentropicEnthalpy;

      redeclare function extends density_derh_p
          "Density derivative by specific enthalpy"
      algorithm
        ddhp := IF97_Utilities.ddhp(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end density_derh_p;

      redeclare function extends density_derp_h
          "Density derivative by pressure"
      algorithm
        ddph := IF97_Utilities.ddph(
              state.p,
              state.h,
              state.phase);
        annotation (Inline=true);
      end density_derp_h;

      //   redeclare function extends density_derT_p
      //     "Density derivative by temperature"
      //   algorithm
      //     ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
      //   end density_derT_p;
      //
      //   redeclare function extends density_derp_T
      //     "Density derivative by pressure"
      //   algorithm
      //     ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
      //   end density_derp_T;

      redeclare function extends bubbleEnthalpy
          "Boiling curve specific enthalpy of water"
      algorithm
        hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
        annotation (Inline=true);
      end bubbleEnthalpy;

      redeclare function extends dewEnthalpy
          "Dew curve specific enthalpy of water"
      algorithm
        hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
        annotation (Inline=true);
      end dewEnthalpy;

      redeclare function extends bubbleEntropy
          "Boiling curve specific entropy of water"
      algorithm
        sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
        annotation (Inline=true);
      end bubbleEntropy;

      redeclare function extends dewEntropy
          "Dew curve specific entropy of water"
      algorithm
        sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
        annotation (Inline=true);
      end dewEntropy;

      redeclare function extends bubbleDensity
          "Boiling curve specific density of water"
      algorithm
        dl := if ph_explicit then IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat)
           else IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
        annotation (Inline=true);
      end bubbleDensity;

      redeclare function extends dewDensity
          "Dew curve specific density of water"
      algorithm
        dv := if ph_explicit or pT_explicit then
          IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat) else
          IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
        annotation (Inline=true);
      end dewDensity;

      redeclare function extends saturationTemperature
          "Saturation temperature of water"
      algorithm
        T := IF97_Utilities.BaseIF97.Basic.tsat(p);
        annotation (Inline=true);
      end saturationTemperature;

      redeclare function extends saturationTemperature_derp
          "Derivative of saturation temperature w.r.t. pressure"
      algorithm
        dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
        annotation (Inline=true);
      end saturationTemperature_derp;

      redeclare function extends saturationPressure
          "Saturation pressure of water"
      algorithm
        p := IF97_Utilities.BaseIF97.Basic.psat(T);
        annotation (Inline=true);
      end saturationPressure;

      redeclare function extends dBubbleDensity_dPressure
          "Bubble point density derivative"
      algorithm
        ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
        annotation (Inline=true);
      end dBubbleDensity_dPressure;

      redeclare function extends dDewDensity_dPressure
          "Dew point density derivative"
      algorithm
        ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
        annotation (Inline=true);
      end dDewDensity_dPressure;

      redeclare function extends dBubbleEnthalpy_dPressure
          "Bubble point specific enthalpy derivative"
      algorithm
        dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
        annotation (Inline=true);
      end dBubbleEnthalpy_dPressure;

      redeclare function extends dDewEnthalpy_dPressure
          "Dew point specific enthalpy derivative"
      algorithm
        dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
        annotation (Inline=true);
      end dDewEnthalpy_dPressure;

      redeclare function extends setState_dTX
          "Return thermodynamic state of water as function of d and T"
      algorithm
        state := ThermodynamicState(
              d=d,
              T=T,
              phase=0,
              h=specificEnthalpy_dT(d, T),
              p=pressure_dT(d, T));
        annotation (Inline=true);
      end setState_dTX;

      redeclare function extends setState_phX
          "Return thermodynamic state of water as function of p and h"
      algorithm
        state := ThermodynamicState(
              d=density_ph(p, h),
              T=temperature_ph(p, h),
              phase=0,
              h=h,
              p=p);
        annotation (Inline=true);
      end setState_phX;

      redeclare function extends setState_psX
          "Return thermodynamic state of water as function of p and s"
      algorithm
        state := ThermodynamicState(
              d=density_ps(p, s),
              T=temperature_ps(p, s),
              phase=0,
              h=specificEnthalpy_ps(p, s),
              p=p);
        annotation (Inline=true);
      end setState_psX;

      redeclare function extends setState_pTX
          "Return thermodynamic state of water as function of p and T"
      algorithm
        state := ThermodynamicState(
              d=density_pT(p, T),
              T=T,
              phase=1,
              h=specificEnthalpy_pT(p, T),
              p=p);
        annotation (Inline=true);
      end setState_pTX;

      redeclare function extends setSmoothState
          "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        import Modelica.Media.Common.smoothStep;
      algorithm
        state := ThermodynamicState(
              p=smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small),
              h=smoothStep(
                x,
                state_a.h,
                state_b.h,
                x_small),
              d=density_ph(smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small), smoothStep(
                x,
                state_a.h,
                state_b.h,
                x_small)),
              T=temperature_ph(smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small), smoothStep(
                x,
                state_a.h,
                state_b.h,
                x_small)),
              phase=0);
        annotation (Inline=true);
      end setSmoothState;
      annotation (Documentation(info="<HTML>
<p>
This model calculates medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
For more details see <a href=\"modelica://Modelica.Media.Water.IF97_Utilities\">
Modelica.Media.Water.IF97_Utilities</a>. Three variable pairs can be the
independent variables of the model:
</p>
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are the most natural choice for general applications. This is the recommended choice for most general purpose applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural choice for applications where water is always in the same phase, both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit variables of the Helmholtz function in the near-critical region and can be the best choice for applications with super-critical or near-critical states.</li>
</ol>
<p>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a> and in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables, all first partial derivatives of the standard thermodynamic variables can be computed easily.</p>
</html>"));
    end WaterIF97_base;

      package IF97_Utilities
        "Low level and utility computation for high accuracy water properties according to the IAPWS/IF97 standard"
        extends Modelica.Icons.UtilitiesPackage;

        package BaseIF97
          "Modelica Physical Property Model: the new industrial formulation IAPWS-IF97"
          extends Modelica.Icons.Package;

          record IterationData
            "Constants for iterations internal to some functions"

            extends Modelica.Icons.Record;
            constant Integer IMAX=50
              "Maximum number of iterations for inverse functions";
            constant Real DELP=1.0e-6 "Maximum iteration error in pressure, Pa";
            constant Real DELS=1.0e-8
              "Maximum iteration error in specific entropy, J/{kg.K}";
            constant Real DELH=1.0e-8
              "Maximum iteration error in specific enthalpy, J/kg";
            constant Real DELD=1.0e-8
              "Maximum iteration error in density, kg/m^3";
          end IterationData;

          record data "Constant IF97 data and region limits"
            extends Modelica.Icons.Record;
            constant SI.SpecificHeatCapacity RH2O=461.526
              "Specific gas constant of water vapour";
            constant SI.MolarMass MH2O=0.01801528 "Molar weight of water";
            constant SI.Temperature TSTAR1=1386.0
              "Normalization temperature for region 1 IF97";
            constant SI.Pressure PSTAR1=16.53e6
              "Normalization pressure for region 1 IF97";
            constant SI.Temperature TSTAR2=540.0
              "Normalization temperature for region 2 IF97";
            constant SI.Pressure PSTAR2=1.0e6
              "Normalization pressure for region 2 IF97";
            constant SI.Temperature TSTAR5=1000.0
              "Normalization temperature for region 5 IF97";
            constant SI.Pressure PSTAR5=1.0e6
              "Normalization pressure for region 5 IF97";
            constant SI.SpecificEnthalpy HSTAR1=2.5e6
              "Normalization specific enthalpy for region 1 IF97";
            constant Real IPSTAR=1.0e-6
              "Normalization pressure for inverse function in region 2 IF97";
            constant Real IHSTAR=5.0e-7
              "Normalization specific enthalpy for inverse function in region 2 IF97";
            constant SI.Temperature TLIMIT1=623.15
              "Temperature limit between regions 1 and 3";
            constant SI.Temperature TLIMIT2=1073.15
              "Temperature limit between regions 2 and 5";
            constant SI.Temperature TLIMIT5=2273.15
              "Upper temperature limit of 5";
            constant SI.Pressure PLIMIT1=100.0e6
              "Upper pressure limit for regions 1, 2 and 3";
            constant SI.Pressure PLIMIT4A=16.5292e6
              "Pressure limit between regions 1 and 2, important for for two-phase (region 4)";
            constant SI.Pressure PLIMIT5=10.0e6
              "Upper limit of valid pressure in region 5";
            constant SI.Pressure PCRIT=22064000.0 "The critical pressure";
            constant SI.Temperature TCRIT=647.096 "The critical temperature";
            constant SI.Density DCRIT=322.0 "The critical density";
            constant SI.SpecificEntropy SCRIT=4412.02148223476
              "The calculated specific entropy at the critical point";
            constant SI.SpecificEnthalpy HCRIT=2087546.84511715
              "The calculated specific enthalpy at the critical point";
            constant Real[5] n=array(
                    0.34805185628969e3,
                    -0.11671859879975e1,
                    0.10192970039326e-2,
                    0.57254459862746e3,
                    0.13918839778870e2)
              "Polynomial coefficients for boundary between regions 2 and 3";
            annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
                           <p>Constants needed in the international steam properties IF97.
                           SCRIT and HCRIT are calculated from Helmholtz function for region 3.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by Hubertus Tummescheit
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</html>"));
          end data;

          record triple "Triple point data"
            extends Modelica.Icons.Record;
            constant SI.Temperature Ttriple=273.16
              "The triple point temperature";
            constant SI.Pressure ptriple=611.657 "The triple point temperature";
            constant SI.Density dltriple=999.792520031617642
              "The triple point liquid density";
            constant SI.Density dvtriple=0.485457572477861372e-2
              "The triple point vapour density";
            annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
 <p>Vapour/liquid/ice triple point data for IF97 steam properties.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</html>"));
          end triple;

          package Regions
            "Functions to find the current region for given pairs of input variables"
            extends Modelica.Icons.Package;

            function boundary23ofT
              "Boundary function for region boundary between regions 2 and 3 (input temperature)"

              extends Modelica.Icons.Function;
              input SI.Temperature t "Temperature (K)";
              output SI.Pressure p "Pressure";
            protected
              constant Real[5] n=data.n;
            algorithm
              p := 1.0e6*(n[1] + t*(n[2] + t*n[3]));
            end boundary23ofT;

            function boundary23ofp
              "Boundary function for region boundary between regions 2 and 3 (input pressure)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Temperature t "Temperature (K)";
            protected
              constant Real[5] n=data.n;
              Real pi "Dimensionless pressure";
            algorithm
              pi := p/1.0e6;
              assert(p > triple.ptriple,
                "IF97 medium function boundary23ofp called with too low pressure\n"
                 + "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              t := n[4] + ((pi - n[5])/n[3])^0.5;
            end boundary23ofp;

            function hlowerofp5
              "Explicit lower specific enthalpy limit of region 5 as function of pressure"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p/data.PSTAR5;
              assert(p > triple.ptriple,
                "IF97 medium function hlowerofp5 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              h := 461526.*(9.01505286876203 + pi*(-0.00979043490246092 + (-0.0000203245575263501
                 + 3.36540214679088e-7*pi)*pi));
            end hlowerofp5;

            function hupperofp5
              "Explicit upper specific enthalpy limit of region 5 as function of pressure"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p/data.PSTAR5;
              assert(p > triple.ptriple,
                "IF97 medium function hupperofp5 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              h := 461526.*(15.9838891400332 + pi*(-0.000489898813722568 + (-5.01510211858761e-8
                 + 7.5006972718273e-8*pi)*pi));
            end hupperofp5;

            function slowerofp5
              "Explicit lower specific entropy limit of region 5 as function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p/data.PSTAR5;
              assert(p > triple.ptriple,
                "IF97 medium function slowerofp5 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              s := 461.526*(18.4296209980112 + pi*(-0.00730911805860036 + (-0.0000168348072093888
                 + 2.09066899426354e-7*pi)*pi) - Modelica.Math.log(pi));
            end slowerofp5;

            function supperofp5
              "Explicit upper specific entropy limit of region 5 as function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p/data.PSTAR5;
              assert(p > triple.ptriple,
                "IF97 medium function supperofp5 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              s := 461.526*(22.7281531474243 + pi*(-0.000656650220627603 + (-1.96109739782049e-8
                 + 2.19979537113031e-8*pi)*pi) - Modelica.Math.log(pi));
            end supperofp5;

            function hlowerofp1
              "Explicit lower specific enthalpy limit of region 1 as function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p/data.PSTAR1;
              assert(p > triple.ptriple,
                "IF97 medium function hlowerofp1 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              o[1] := pi1*pi1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];

              h := 639675.036*(0.173379420894777 + pi1*(-0.022914084306349 + pi1*(-0.00017146768241932
                 + pi1*(-4.18695814670391e-6 + pi1*(-2.41630417490008e-7 + pi1*(
                1.73545618580828e-11 + o[1]*pi1*(8.43755552264362e-14 + o[2]*o[3]*pi1
                *(5.35429206228374e-35 + o[1]*(-8.12140581014818e-38 + o[1]*o[2]*(-1.43870236842915e-44
                 + pi1*(1.73894459122923e-45 + (-7.06381628462585e-47 +
                9.64504638626269e-49*pi1)*pi1)))))))))));
            end hlowerofp1;

            function hupperofp1
              "Explicit upper specific enthalpy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p/data.PSTAR1;
              assert(p > triple.ptriple,
                "IF97 medium function hupperofp1 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              o[1] := pi1*pi1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              h := 639675.036*(2.42896927729349 + pi1*(-0.00141131225285294 + pi1*(
                0.00143759406818289 + pi1*(0.000125338925082983 + pi1*(
                0.0000123617764767172 + pi1*(3.17834967400818e-6 + o[1]*pi1*(
                1.46754947271665e-8 + o[2]*o[3]*pi1*(1.86779322717506e-17 + o[1]*(-4.18568363667416e-19
                 + o[1]*o[2]*(-9.19148577641497e-22 + pi1*(4.27026404402408e-22 + (-6.66749357417962e-23
                 + 3.49930466305574e-24*pi1)*pi1)))))))))));
            end hupperofp1;

            function supperofp1
              "Explicit upper specific entropy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p/data.PSTAR1;
              assert(p > triple.ptriple,
                "IF97 medium function supperofp1 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              o[1] := pi1*pi1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              s := 461.526*(7.28316418503422 + pi1*(0.070602197808399 + pi1*(
                0.0039229343647356 + pi1*(0.000313009170788845 + pi1*(
                0.0000303619398631619 + pi1*(7.46739440045781e-6 + o[1]*pi1*(
                3.40562176858676e-8 + o[2]*o[3]*pi1*(4.21886233340801e-17 + o[1]*(-9.44504571473549e-19
                 + o[1]*o[2]*(-2.06859611434475e-21 + pi1*(9.60758422254987e-22 + (-1.49967810652241e-22
                 + 7.86863124555783e-24*pi1)*pi1)))))))))));
            end supperofp1;

            function hlowerofp2
              "Explicit lower specific enthalpy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
              Real q1 "Auxiliary variable";
              Real q2 "Auxiliary variable";
              Real[18] o "Vector of auxiliary variables";
            algorithm
              pi := p/data.PSTAR2;
              assert(p > triple.ptriple,
                "IF97 medium function hlowerofp2 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              q1 := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
              q2 := -0.5 + 540./q1;
              o[1] := q1*q1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              o[4] := pi*pi;
              o[5] := o[4]*o[4];
              o[6] := q2*q2;
              o[7] := o[6]*o[6];
              o[8] := o[6]*o[7];
              o[9] := o[5]*o[5];
              o[10] := o[7]*o[7];
              o[11] := o[9]*o[9];
              o[12] := o[10]*o[10];
              o[13] := o[12]*o[12];
              o[14] := o[7]*q2;
              o[15] := o[6]*q2;
              o[16] := o[10]*o[6];
              o[17] := o[13]*o[6];
              o[18] := o[13]*o[6]*q2;
              h := (4.63697573303507e9 + 3.74686560065793*o[2] + 3.57966647812489e-6*
                o[1]*o[2] + 2.81881548488163e-13*o[3] - 7.64652332452145e7*q1 -
                0.00450789338787835*o[2]*q1 - 1.55131504410292e-9*o[1]*o[2]*q1 + o[1]
                *(2.51383707870341e6 - 4.78198198764471e6*o[10]*o[11]*o[12]*o[13]*o[4]
                 + 49.9651389369988*o[11]*o[12]*o[13]*o[4]*o[5]*o[7] + o[15]*o[4]*(
                1.03746636552761e-13 - 0.00349547959376899*o[16] -
                2.55074501962569e-7*o[8])*o[9] + (-242662.235426958*o[10]*o[12] -
                3.46022402653609*o[16])*o[4]*o[5]*pi + o[4]*(0.109336249381227 -
                2248.08924686956*o[14] - 354742.725841972*o[17] - 24.1331193696374*o[
                6])*pi - 3.09081828396912e-19*o[11]*o[12]*o[5]*o[7]*pi -
                1.24107527851371e-8*o[11]*o[13]*o[4]*o[5]*o[6]*o[7]*pi +
                3.99891272904219*o[5]*o[8]*pi + 0.0641817365250892*o[10]*o[7]*o[9]*pi
                 + pi*(-4444.87643334512 - 75253.6156722047*o[14] - 43051.9020511789*
                o[6] - 22926.6247146068*q2) + o[4]*(-8.23252840892034 -
                3927.0508365636*o[15] - 239.325789467604*o[18] - 76407.3727417716*o[8]
                 - 94.4508644545118*q2) + 0.360567666582363*o[5]*(-0.0161221195808321
                 + q2)*(0.0338039844460968 + q2) + o[11]*(-0.000584580992538624*o[10]
                *o[12]*o[7] + 1.33248030241755e6*o[12]*o[13]*q2) + o[9]*(-7.38502736990986e7
                *o[18] + 0.0000224425477627799*o[6]*o[7]*q2) + o[4]*o[5]*(-2.08438767026518e8
                *o[17] - 0.0000124971648677697*o[6] - 8442.30378348203*o[10]*o[6]*o[7]
                *q2) + o[11]*o[9]*(4.73594929247646e-22*o[10]*o[12]*q2 -
                13.6411358215175*o[10]*o[12]*o[13]*q2 + 5.52427169406836e-10*o[13]*o[
                6]*o[7]*q2) + o[11]*o[5]*(2.67174673301715e-6*o[17] +
                4.44545133805865e-18*o[12]*o[6]*q2 - 50.2465185106411*o[10]*o[13]*o[6]
                *o[7]*q2)))/o[1];
            end hlowerofp2;

            function hupperofp2
              "Explicit upper specific enthalpy limit of region 2 as function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
              Real[2] o "Vector of auxiliary variables";
            algorithm
              pi := p/data.PSTAR2;
              assert(p > triple.ptriple,
                "IF97 medium function hupperofp2 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              o[1] := pi*pi;
              o[2] := o[1]*o[1]*o[1];
              h := 4.16066337647071e6 + pi*(-4518.48617188327 + pi*(-8.53409968320258
                 + pi*(0.109090430596056 + pi*(-0.000172486052272327 + pi*(
                4.2261295097284e-15 + pi*(-1.27295130636232e-10 + pi*(-3.79407294691742e-25
                 + pi*(7.56960433802525e-23 + pi*(7.16825117265975e-32 + pi*(
                3.37267475986401e-21 + (-7.5656940729795e-74 + o[1]*(-8.00969737237617e-134
                 + (1.6746290980312e-65 + pi*(-3.71600586812966e-69 + pi*(
                8.06630589170884e-129 + (-1.76117969553159e-103 +
                1.88543121025106e-84*pi)*pi)))*o[1]))*o[2]))))))))));
            end hupperofp2;

            function slowerofp2
              "Explicit lower specific entropy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
              Real q1 "Auxiliary variable";
              Real q2 "Auxiliary variable";
              Real[40] o "Vector of auxiliary variables";
            algorithm
              pi := p/data.PSTAR2;
              assert(p > triple.ptriple,
                "IF97 medium function slowerofp2 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              q1 := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
              q2 := -0.5 + 540.0/q1;
              o[1] := pi*pi;
              o[2] := o[1]*pi;
              o[3] := o[1]*o[1];
              o[4] := o[1]*o[3]*pi;
              o[5] := q1*q1;
              o[6] := o[5]*q1;
              o[7] := 1/o[5];
              o[8] := 1/q1;
              o[9] := o[5]*o[5];
              o[10] := o[9]*q1;
              o[11] := q2*q2;
              o[12] := o[11]*q2;
              o[13] := o[1]*o[3];
              o[14] := o[11]*o[11];
              o[15] := o[3]*o[3];
              o[16] := o[1]*o[15];
              o[17] := o[11]*o[14];
              o[18] := o[11]*o[14]*q2;
              o[19] := o[3]*pi;
              o[20] := o[14]*o[14];
              o[21] := o[11]*o[20];
              o[22] := o[15]*pi;
              o[23] := o[14]*o[20]*q2;
              o[24] := o[20]*o[20];
              o[25] := o[15]*o[15];
              o[26] := o[25]*o[3];
              o[27] := o[14]*o[24];
              o[28] := o[25]*o[3]*pi;
              o[29] := o[20]*o[24]*q2;
              o[30] := o[15]*o[25];
              o[31] := o[24]*o[24];
              o[32] := o[11]*o[31]*q2;
              o[33] := o[14]*o[31];
              o[34] := o[1]*o[25]*o[3]*pi;
              o[35] := o[11]*o[14]*o[31]*q2;
              o[36] := o[1]*o[25]*o[3];
              o[37] := o[1]*o[25];
              o[38] := o[20]*o[24]*o[31]*q2;
              o[39] := o[14]*q2;
              o[40] := o[11]*o[31];

              s := 461.526*(9.692768600217 + 1.22151969114703e-16*o[10] +
                0.00018948987516315*o[1]*o[11] + 1.6714766451061e-11*o[12]*o[13] +
                0.0039392777243355*o[1]*o[14] - 1.0406965210174e-19*o[14]*o[16] +
                0.043797295650573*o[1]*o[18] - 2.2922076337661e-6*o[18]*o[19] -
                2.0481737692309e-8*o[2] + 0.00003227767723857*o[12]*o[2] +
                0.0015033924542148*o[17]*o[2] - 1.1256211360459e-11*o[15]*o[20] +
                1.0018179379511e-9*o[11]*o[14]*o[16]*o[20] + 1.0234747095929e-13*o[16]
                *o[21] - 1.9809712802088e-8*o[22]*o[23] + 0.0021171472321355*o[13]*o[
                24] - 8.9185845355421e-25*o[26]*o[27] - 1.2790717852285e-8*o[11]*o[3]
                 - 4.8225372718507e-7*o[12]*o[3] - 7.3087610595061e-29*o[11]*o[20]*o[
                24]*o[30] - 0.10693031879409*o[11]*o[24]*o[25]*o[31] +
                4.2002467698208e-6*o[24]*o[26]*o[31] - 5.5414715350778e-17*o[20]*o[30]
                *o[31] + 9.436970724121e-7*o[11]*o[20]*o[24]*o[30]*o[31] +
                23.895741934104*o[13]*o[32] + 0.040668253562649*o[2]*o[32] -
                3.0629316876232e-13*o[26]*o[32] + 0.000026674547914087*o[1]*o[33] +
                8.2311340897998*o[15]*o[33] + 1.2768608934681e-15*o[34]*o[35] +
                0.33662250574171*o[37]*o[38] + 5.905956432427e-18*o[4] +
                0.038946842435739*o[29]*o[4] - 4.88368302964335e-6*o[5] -
                3.34901734177133e6/o[6] + 2.58538448402683e-9*o[6] + 82839.5726841115
                *o[7] - 5446.7940672972*o[8] - 8.40318337484194e-13*o[9] +
                0.0017731742473213*pi + 0.045996013696365*o[11]*pi +
                0.057581259083432*o[12]*pi + 0.05032527872793*o[17]*pi + o[8]*pi*(
                9.63082563787332 - 0.008917431146179*q1) + 0.00811842799898148*q1 +
                0.000033032641670203*o[1]*q2 - 4.3870667284435e-7*o[2]*q2 +
                8.0882908646985e-11*o[14]*o[20]*o[24]*o[25]*q2 + 5.9056029685639e-26*
                o[14]*o[24]*o[28]*q2 + 7.8847309559367e-10*o[3]*q2 -
                3.7826947613457e-6*o[14]*o[24]*o[31]*o[36]*q2 + 1.2621808899101e-6*o[
                11]*o[20]*o[4]*q2 + 540.*o[8]*(10.08665568018 - 0.000033032641670203*
                o[1] - 6.2245802776607e-15*o[10] - 0.015757110897342*o[1]*o[12] -
                5.0144299353183e-11*o[11]*o[13] + 4.1627860840696e-19*o[12]*o[16] -
                0.306581069554011*o[1]*o[17] + 9.0049690883672e-11*o[15]*o[18] +
                0.0000160454534363627*o[17]*o[19] + 4.3870667284435e-7*o[2] -
                0.00009683303171571*o[11]*o[2] + 2.57526266427144e-7*o[14]*o[20]*o[22]
                 - 1.40254511313154e-8*o[16]*o[23] - 2.34560435076256e-9*o[14]*o[20]*
                o[24]*o[25] - 1.24017662339842e-24*o[27]*o[28] - 7.8847309559367e-10*
                o[3] + 1.44676118155521e-6*o[11]*o[3] + 1.90027787547159e-27*o[29]*o[
                30] - 0.000960283724907132*o[1]*o[32] - 296.320827232793*o[15]*o[32]
                 - 4.97975748452559e-14*o[11]*o[14]*o[31]*o[34] +
                2.21658861403112e-15*o[30]*o[35] + 0.000200482822351322*o[14]*o[24]*o[
                31]*o[36] - 19.1874828272775*o[20]*o[24]*o[31]*o[37] -
                0.0000547344301999018*o[30]*o[38] - 0.0090203547252888*o[2]*o[39] -
                0.0000138839897890111*o[21]*o[4] - 0.973671060893475*o[20]*o[24]*o[4]
                 - 836.35096769364*o[13]*o[40] - 1.42338887469272*o[2]*o[40] +
                1.07202609066812e-11*o[26]*o[40] + 0.0000150341259240398*o[5] -
                1.8087714924605e-8*o[6] + 18605.6518987296*o[7] - 306.813232163376*o[
                8] + 1.43632471334824e-11*o[9] + 1.13103675106207e-18*o[5]*o[9] -
                0.017834862292358*pi - 0.172743777250296*o[11]*pi - 0.30195167236758*
                o[39]*pi + o[8]*pi*(-49.6756947920742 + 0.045996013696365*q1) -
                0.0003789797503263*o[1]*q2 - 0.033874355714168*o[11]*o[13]*o[14]*o[20]
                *q2 - 1.0234747095929e-12*o[16]*o[20]*q2 + 1.78371690710842e-23*o[11]
                *o[24]*o[26]*q2 + 2.558143570457e-8*o[3]*q2 + 5.3465159397045*o[24]*o[
                25]*o[31]*q2 - 0.000201611844951398*o[11]*o[14]*o[20]*o[26]*o[31]*q2)
                 - Modelica.Math.log(pi));
            end slowerofp2;

            function supperofp2
              "Explicit upper specific entropy limit of region 2 as function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
              Real[2] o "Vector of auxiliary variables";
            algorithm
              pi := p/data.PSTAR2;
              assert(p > triple.ptriple,
                "IF97 medium function supperofp2 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              o[1] := pi*pi;
              o[2] := o[1]*o[1]*o[1];
              s := 8505.73409708683 - 461.526*Modelica.Math.log(pi) + pi*(-3.36563543302584
                 + pi*(-0.00790283552165338 + pi*(0.0000915558349202221 + pi*(-1.59634706513e-7
                 + pi*(3.93449217595397e-18 + pi*(-1.18367426347994e-13 + pi*(
                2.72575244843195e-15 + pi*(7.04803892603536e-26 + pi*(
                6.67637687381772e-35 + pi*(3.1377970315132e-24 + (-7.04844558482265e-77
                 + o[1]*(-7.46289531275314e-137 + (1.55998511254305e-68 + pi*(-3.46166288915497e-72
                 + pi*(7.51557618628583e-132 + (-1.64086406733212e-106 +
                1.75648443097063e-87*pi)*pi)))*o[1]))*o[2]*o[2]))))))))));
            end supperofp2;

            function d1n "Density in region 1 as function of p and T"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.Density d "Density";
            protected
              Real pi "Dimensionless pressure";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
              Real gpi "Dimensionless Gibbs-derivative w.r.t. pi";
              Real[11] o "Auxiliary variables";
            algorithm
              pi := p/data.PSTAR1;
              tau := data.TSTAR1/T;
              pi1 := 7.1 - pi;
              tau1 := tau - 1.222;
              o[1] := tau1*tau1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              o[4] := o[1]*o[2];
              o[5] := o[1]*tau1;
              o[6] := o[2]*tau1;
              o[7] := pi1*pi1;
              o[8] := o[7]*o[7];
              o[9] := o[8]*o[8];
              o[10] := o[3]*o[3];
              o[11] := o[10]*o[10];
              gpi := pi1*(pi1*((0.000095038934535162 + o[2]*(8.4812393955936e-6 +
                2.55615384360309e-9*o[4]))/o[2] + pi1*((8.9701127632e-6 + (
                2.60684891582404e-6 + 5.7366919751696e-13*o[2]*o[3])*o[5])/o[6] + pi1
                *(2.02584984300585e-6/o[3] + o[7]*pi1*(o[8]*o[9]*pi1*(o[7]*(o[7]*o[8]
                *(-7.63737668221055e-22/(o[1]*o[11]*o[2]) + pi1*(pi1*(-5.65070932023524e-23
                /(o[11]*o[3]) + (2.99318679335866e-24*pi1)/(o[11]*o[3]*tau1)) +
                3.5842867920213e-22/(o[1]*o[11]*o[2]*tau1))) - 3.33001080055983e-19/(
                o[1]*o[10]*o[2]*o[3]*tau1)) + 1.44400475720615e-17/(o[10]*o[2]*o[3]*
                tau1)) + (1.01874413933128e-8 + 1.39398969845072e-9*o[6])/(o[1]*o[3]*
                tau1))))) + (0.00094368642146534 + o[5]*(0.00060003561586052 + (-0.000095322787813974
                 + o[1]*(8.8283690661692e-6 + 1.45389992595188e-15*o[1]*o[2]*o[3]))*
                tau1))/o[5]) + (-0.00028319080123804 + o[1]*(0.00060706301565874 + o[
                4]*(0.018990068218419 + tau1*(0.032529748770505 + (0.021841717175414
                 + 0.00005283835796993*o[1])*tau1))))/(o[3]*tau1);
              d := p/(data.RH2O*T*pi*gpi);
            end d1n;

            function d2n "Density in region 2 as function of p and T"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.Density d "Density";
            protected
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
              Real gpi "Dimensionless Gibbs-derivative w.r.t. pi";
              Real[12] o "Auxiliary variables";
            algorithm
              pi := p/data.PSTAR2;
              tau := data.TSTAR2/T;
              tau2 := tau - 0.5;
              o[1] := tau2*tau2;
              o[2] := o[1]*tau2;
              o[3] := o[1]*o[1];
              o[4] := o[3]*o[3];
              o[5] := o[4]*o[4];
              o[6] := o[3]*o[4]*o[5]*tau2;
              o[7] := o[3]*o[4]*tau2;
              o[8] := o[1]*o[3]*o[4];
              o[9] := pi*pi;
              o[10] := o[9]*o[9];
              o[11] := o[3]*o[5]*tau2;
              o[12] := o[5]*o[5];
              gpi := (1. + pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*
                (-0.045996013696365 + (-0.057581259083432 - 0.05032527872793*o[2])*
                tau2)) + pi*(tau2*(-0.000066065283340406 + (-0.0003789797503263 + o[1]
                *(-0.007878555448671 + o[2]*(-0.087594591301146 -
                0.000053349095828174*o[6])))*tau2) + pi*(6.1445213076927e-8 + (
                1.31612001853305e-6 + o[1]*(-0.00009683303171571 + o[2]*(-0.0045101773626444
                 - 0.122004760687947*o[6])))*tau2 + pi*(tau2*(-3.15389238237468e-9 +
                (5.116287140914e-8 + 1.92901490874028e-6*tau2)*tau2) + pi*(
                0.0000114610381688305*o[1]*o[3]*tau2 + pi*(o[2]*(-1.00288598706366e-10
                 + o[7]*(-0.012702883392813 - 143.374451604624*o[1]*o[5]*tau2)) + pi*
                (-4.1341695026989e-17 + o[1]*o[4]*(-8.8352662293707e-6 -
                0.272627897050173*o[8])*tau2 + pi*(o[4]*(9.0049690883672e-11 -
                65.8490727183984*o[3]*o[4]*o[5]) + pi*(1.78287415218792e-7*o[7] + pi*
                (o[3]*(1.0406965210174e-18 + o[1]*(-1.0234747095929e-12 -
                1.0018179379511e-8*o[3])*o[3]) + o[10]*o[9]*((-1.29412653835176e-9 +
                1.71088510070544*o[11])*o[6] + o[9]*(-6.05920510335078*o[12]*o[4]*o[5]
                *tau2 + o[9]*(o[3]*o[5]*(1.78371690710842e-23 + o[1]*o[3]*o[4]*(
                6.1258633752464e-12 - 0.000084004935396416*o[7])*tau2) + pi*(-1.24017662339842e-24
                *o[11] + pi*(0.0000832192847496054*o[12]*o[3]*o[5]*tau2 + pi*(o[1]*o[
                4]*o[5]*(1.75410265428146e-27 + (1.32995316841867e-15 -
                0.0000226487297378904*o[1]*o[5])*o[8])*pi - 2.93678005497663e-14*o[1]
                *o[12]*o[3]*tau2)))))))))))))))))/pi;
              d := p/(data.RH2O*T*pi*gpi);
            end d2n;

            function hl_p_R4b
              "Explicit approximation of liquid specific enthalpy on the boundary between regions 4 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real x "Auxiliary variable";
            algorithm
              // documentation of accuracy in notebook ~hubertus/props/IAPWS/R3Approx.nb
              // boundary between region IVa and III
              x := Modelica.Math.acos(p/data.PCRIT);
              h := (1 + x*(-0.4945586958175176 + x*(1.346800016564904 + x*(-3.889388153209752
                 + x*(6.679385472887931 + x*(-6.75820241066552 + x*(3.558919744656498
                 + (-0.7179818554978939 - 0.0001152032945617821*x)*x)))))))*data.HCRIT;
            end hl_p_R4b;

            function hv_p_R4b
              "Explicit approximation of vapour specific enthalpy on the boundary between regions 4 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real x "Auxiliary variable";
            algorithm
              // boundary between region IVa and III
              x := Modelica.Math.acos(p/data.PCRIT);
              h := (1 + x*(0.4880153718655694 + x*(0.2079670746250689 + x*(-6.084122698421623
                 + x*(25.08887602293532 + x*(-48.38215180269516 + x*(
                45.66489164833212 + (-16.98555442961553 + 0.0006616936460057691*x)*x)))))))
                *data.HCRIT;
            end hv_p_R4b;

            function sl_p_R4b
              "Explicit approximation of liquid specific entropy on the boundary between regions 4 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real x "Auxiliary variable";
            algorithm
              // boundary between region IVa and III
              x := Modelica.Math.acos(p/data.PCRIT);
              s := (1 + x*(-0.36160692245648063 + x*(0.9962778630486647 + x*(-2.8595548144171103
                 + x*(4.906301159555333 + x*(-4.974092309614206 + x*(
                2.6249651699204457 + (-0.5319954375299023 - 0.00008064497431880644*x)
                *x)))))))*data.SCRIT;
            end sl_p_R4b;

            function sv_p_R4b
              "Explicit approximation of vapour specific entropy on the boundary between regions 4 and 3"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s;
            protected
              Real x "Auxiliary variable";
            algorithm

              // documentation of accuracy in notebook ~hubertus/props/IAPWS/R3Approx.nb
              // boundary between region IVa and III
              x := Modelica.Math.acos(p/data.PCRIT);
              s := (1 + x*(0.35682641826674344 + x*(0.1642457027815487 + x*(-4.425350377422446
                 + x*(18.324477859983133 + x*(-35.338631625948665 + x*(
                33.36181025816282 + (-12.408711490585757 + 0.0004810049834109226*x)*x)))))))
                *data.SCRIT;
            end sv_p_R4b;

            function rhol_p_R4b
              "Explicit approximation of liquid density on the boundary between regions 4 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Density dl "Liquid density";
            protected
              Real x "Auxiliary variable";
            algorithm
              if (p < data.PCRIT) then
                x := Modelica.Math.acos(p/data.PCRIT);
                dl := (1 + x*(1.903224079094824 + x*(-2.5314861802401123 + x*(-8.191449323843552
                   + x*(94.34196116778385 + x*(-369.3676833623383 + x*(
                  796.6627910598293 + x*(-994.5385383600702 + x*(673.2581177021598 +
                  (-191.43077336405156 + 0.00052536560808895*x)*x)))))))))*data.DCRIT;
              else
                dl := data.DCRIT;
              end if;
            end rhol_p_R4b;

            function rhov_p_R4b
              "Explicit approximation of vapour density on the boundary between regions 4 and 2"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Density dv "Vapour density";
            protected
              Real x "Auxiliary variable";
            algorithm
              if (p < data.PCRIT) then
                x := Modelica.Math.acos(p/data.PCRIT);
                dv := (1 + x*(-1.8463850803362596 + x*(-1.1447872718878493 + x*(
                  59.18702203076563 + x*(-403.5391431811611 + x*(1437.2007245332388
                   + x*(-3015.853540307519 + x*(3740.5790348670057 + x*(-2537.375817253895
                   + (725.8761975803782 - 0.0011151111658332337*x)*x)))))))))*data.DCRIT;
              else
                dv := data.DCRIT;
              end if;
            end rhov_p_R4b;

            function boilingcurve_p "Properties on the boiling curve"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output Common.IF97PhaseBoundaryProperties bpro "Property record";
            protected
              Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives";
              Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives";
              SI.Pressure plim=min(p, data.PCRIT - 1e-7)
                "Pressure limited to critical pressure - epsilon";
            algorithm
              bpro.R := data.RH2O;
              bpro.T := Basic.tsat(plim);
              bpro.dpT := Basic.dptofT(bpro.T);
              bpro.region3boundary := bpro.T > data.TLIMIT1;
              if not bpro.region3boundary then
                g := Basic.g1(p, bpro.T);
                bpro.d := p/(bpro.R*bpro.T*g.pi*g.gpi);
                bpro.h := if p > plim then data.HCRIT else bpro.R*bpro.T*g.tau*g.gtau;
                bpro.s := g.R*(g.tau*g.gtau - g.g);
                bpro.cp := -bpro.R*g.tau*g.tau*g.gtautau;
                bpro.vt := bpro.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
                bpro.vp := bpro.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
                bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
                bpro.pd := -bpro.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
              else
                bpro.d := rhol_p_R4b(plim);
                f := Basic.f3(bpro.d, bpro.T);
                bpro.h := hl_p_R4b(plim);
                // bpro.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
                bpro.s := f.R*(f.tau*f.ftau - f.f);
                bpro.cv := bpro.R*(-f.tau*f.tau*f.ftautau);
                bpro.pt := bpro.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
                bpro.pd := bpro.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
              end if;
            end boilingcurve_p;

            function dewcurve_p "Properties on the dew curve"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output Common.IF97PhaseBoundaryProperties bpro "Property record";
            protected
              Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives";
              Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives";
              SI.Pressure plim=min(p, data.PCRIT - 1e-7)
                "Pressure limited to critical pressure - epsilon";
            algorithm
              bpro.R := data.RH2O;
              bpro.T := Basic.tsat(plim);
              bpro.dpT := Basic.dptofT(bpro.T);
              bpro.region3boundary := bpro.T > data.TLIMIT1;
              if not bpro.region3boundary then
                g := Basic.g2(p, bpro.T);
                bpro.d := p/(bpro.R*bpro.T*g.pi*g.gpi);
                bpro.h := if p > plim then data.HCRIT else bpro.R*bpro.T*g.tau*g.gtau;
                bpro.s := g.R*(g.tau*g.gtau - g.g);
                bpro.cp := -bpro.R*g.tau*g.tau*g.gtautau;
                bpro.vt := bpro.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
                bpro.vp := bpro.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
                bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
                bpro.pd := -bpro.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
              else
                bpro.d := rhov_p_R4b(plim);
                f := Basic.f3(bpro.d, bpro.T);
                bpro.h := hv_p_R4b(plim);
                // bpro.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
                bpro.s := f.R*(f.tau*f.ftau - f.f);
                bpro.cv := bpro.R*(-f.tau*f.tau*f.ftautau);
                bpro.pt := bpro.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
                bpro.pd := bpro.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
              end if;
            end dewcurve_p;

            function hvl_p
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := bpro.h;
              annotation (
                derivative(noDerivative=bpro) = hvl_p_der,
                Inline=false,
                LateInline=true);
            end hvl_p;

            function hl_p
              "Liquid specific enthalpy on the boundary between regions 4 and 3 or 1"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := hvl_p(p, boilingcurve_p(p));
              annotation (Inline=true);
            end hl_p;

            function hv_p
              "Vapour specific enthalpy on the boundary between regions 4 and 3 or 2"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := hvl_p(p, dewcurve_p(p));
              annotation (Inline=true);
            end hv_p;

            function hvl_p_der
              "Derivative function for the specific enthalpy along the phase boundary"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              input Real p_der "Derivative of pressure";
              output Real h_der
                "Time derivative of specific enthalpy along the phase boundary";
            algorithm
              if bpro.region3boundary then
                h_der := ((bpro.d*bpro.pd - bpro.T*bpro.pt)*p_der + (bpro.T*bpro.pt*
                  bpro.pt + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT*p_der)/(bpro.pd*
                  bpro.d*bpro.d);
              else
                h_der := (1/bpro.d - bpro.T*bpro.vt)*p_der + bpro.cp/bpro.dpT*p_der;
              end if;
              annotation (Inline=true);
            end hvl_p_der;

            function rhovl_p
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output SI.Density rho "Density";
            algorithm
              rho := bpro.d;
              annotation (
                derivative(noDerivative=bpro) = rhovl_p_der,
                Inline=false,
                LateInline=true);
            end rhovl_p;

            function rhol_p "Density of saturated water"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              output SI.Density rho
                "Density of steam at the condensation point";
            algorithm
              rho := rhovl_p(p, boilingcurve_p(p));
              annotation (Inline=true);
            end rhol_p;

            function rhov_p "Density of saturated vapour"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              output SI.Density rho
                "Density of steam at the condensation point";
            algorithm
              rho := rhovl_p(p, dewcurve_p(p));
              annotation (Inline=true);
            end rhov_p;

            function rhovl_p_der
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              input Real p_der "Derivative of pressure";
              output Real d_der
                "Time derivative of density along the phase boundary";
            algorithm
              d_der := if bpro.region3boundary then (p_der - bpro.pt*p_der/bpro.dpT)/
                bpro.pd else -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT)*p_der;
              annotation (Inline=true);
            end rhovl_p_der;

            function sl_p
              "Liquid specific entropy on the boundary between regions 4 and 3 or 1"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              SI.Temperature Tsat "Saturation temperature";
              SI.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              if (p < data.PLIMIT4A) then
                Tsat := Basic.tsat(p);
                (h,s) := Isentropic.handsofpT1(p, Tsat);
              elseif (p < data.PCRIT) then
                s := sl_p_R4b(p);
              else
                s := data.SCRIT;
              end if;
            end sl_p;

            function sv_p
              "Vapour specific entropy on the boundary between regions 4 and 3 or 2"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              SI.Temperature Tsat "Saturation temperature";
              SI.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              if (p < data.PLIMIT4A) then
                Tsat := Basic.tsat(p);
                (h,s) := Isentropic.handsofpT2(p, Tsat);
              elseif (p < data.PCRIT) then
                s := sv_p_R4b(p);
              else
                s := data.SCRIT;
              end if;
            end sv_p;

            function rhol_T "Density of saturated water"
              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature";
              output SI.Density d "Density of water at the boiling point";
            protected
              SI.Pressure p "Saturation pressure";
            algorithm
              p := Basic.psat(T);
              if T < data.TLIMIT1 then
                d := d1n(p, T);
              elseif T < data.TCRIT then
                d := rhol_p_R4b(p);
              else
                d := data.DCRIT;
              end if;
            end rhol_T;

            function rhov_T "Density of saturated vapour"
              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature";
              output SI.Density d "Density of steam at the condensation point";
            protected
              SI.Pressure p "Saturation pressure";
            algorithm

              // assert(T <= data.TCRIT,"input temperature has to be below the critical temperature");
              p := Basic.psat(T);
              if T < data.TLIMIT1 then
                d := d2n(p, T);
              elseif T < data.TCRIT then
                d := rhov_p_R4b(p);
              else
                d := data.DCRIT;
              end if;
            end rhov_T;

            function region_ph
              "Return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific enthalpy"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              input Integer phase=0
                "Phase: 2 for two-phase, 1 for one phase, 0 if not known";
              input Integer mode=0
                "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "Region (valid values: 1,2,3,4,5) in IF97";
              // If mode is different from 0, no checking for the region is done and
              // the mode is assumed to be the correct region. This can be used to
              // implement e.g., water-only steam tables when mode == 1
            protected
              Boolean hsubcrit;
              SI.Temperature Ttest;
              constant Real[5] n=data.n;
              SI.SpecificEnthalpy hl "Bubble enthalpy";
              SI.SpecificEnthalpy hv "Dew enthalpy";
            algorithm
              if (mode <> 0) then
                region := mode;
              else
                // check for regions 1, 2, 3 and 4
                hl := hl_p(p);
                hv := hv_p(p);
                if (phase == 2) then
                  region := 4;
                else
                  // phase == 1 or 0, now check if we are in the legal area
                  if (p < triple.ptriple) or (p > data.PLIMIT1) or (h < hlowerofp1(p))
                       or ((p < 10.0e6) and (h > hupperofp5(p))) or ((p >= 10.0e6)
                       and (h > hupperofp2(p))) then
                    // outside of valid range
                    region := -1;
                  else
                    //region 5 and -1 check complete
                    hsubcrit := (h < data.HCRIT);
                    // simple precheck: very simple if pressure < PLIMIT4A
                    if (p < data.PLIMIT4A) then
                      // we can never be in region 3, so test for others
                      if hsubcrit then
                        if (phase == 1) then
                          region := 1;
                        else
                          if (h < Isentropic.hofpT1(p, Basic.tsat(p))) then
                            region := 1;
                          else
                            region := 4;
                          end if;
                        end if;
                        // external or internal phase check
                      else
                        if (h > hlowerofp5(p)) then
                          // check for region 5
                          if ((p < data.PLIMIT5) and (h < hupperofp5(p))) then
                            region := 5;
                          else
                            region := -2;
                            // pressure and specific enthalpy too high, but this should
                          end if;
                          // never happen
                        else
                          if (phase == 1) then
                            region := 2;
                          else
                            if (h > Isentropic.hofpT2(p, Basic.tsat(p))) then
                              region := 2;
                            else
                              region := 4;
                            end if;
                          end if;
                          // external or internal phase check
                        end if;
                        // tests for region 2 or 5
                      end if;
                      // tests for sub or supercritical
                    else
                      // the pressure is over data.PLIMIT4A
                      if hsubcrit then
                        // region 1 or 3 or 4
                        if h < hupperofp1(p) then
                          region := 1;
                        else
                          if h < hl or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                        // end of test for region 1, 3 or 4
                      else
                        // region 2, 3 or 4
                        if (h > hlowerofp2(p)) then
                          region := 2;
                        else
                          if h > hv or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                        // test for 2 and 3
                      end if;
                      // tests above PLIMIT4A
                    end if;
                    // above or below PLIMIT4A
                  end if;
                  // check for grand limits of p and h
                end if;
                // all tests with phase == 1
              end if;
              // mode was == 0
              // assert(region > 0,"IF97 function called outside the valid range!");
            end region_ph;

            function region_ps
              "Return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific entropy"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              input Integer phase=0
                "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
              input Integer mode=0
                "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "Region (valid values: 1,2,3,4,5) in IF97";
              //  If mode is different from 0, no checking for the region is done and
              //    the mode is assumed to be the correct region. This can be used to
              //    implement e.g., water-only steam tables when mode == 1
            protected
              Boolean ssubcrit;
              SI.Temperature Ttest;
              constant Real[5] n=data.n;
              SI.SpecificEntropy sl "Bubble entropy";
              SI.SpecificEntropy sv "Dew entropy";
            algorithm
              if (mode <> 0) then
                region := mode;
              else
                // check for regions 1, 2, 3, and 4
                sl := sl_p(p);
                sv := sv_p(p);
                // check all cases two-phase
                if (phase == 2) or (phase == 0 and s > sl and s < sv and p < data.PCRIT) then
                  region := 4;
                else
                  // phase == 1
                  region := 0;
                  if (p < triple.ptriple) then
                    region := -2;
                  end if;
                  if (p > data.PLIMIT1) then
                    region := -3;
                  end if;
                  if ((p < 10.0e6) and (s > supperofp5(p))) then
                    region := -5;
                  end if;
                  if ((p >= 10.0e6) and (s > supperofp2(p))) then
                    region := -6;
                  end if;
                  if region < 0 then
                    assert(false,
                      "Region computation from p and s failed: function called outside the legal region");
                  else
                    ssubcrit := (s < data.SCRIT);
                    // simple precheck: very simple if pressure < PLIMIT4A
                    if (p < data.PLIMIT4A) then
                      // we can never be in region 3, so test for 1 and 2
                      if ssubcrit then
                        region := 1;
                      else
                        if (s > slowerofp5(p)) then
                          // check for region 5
                          if ((p < data.PLIMIT5) and (s < supperofp5(p))) then
                            region := 5;
                          else
                            region := -1;
                            // pressure and specific entropy too high, should never happen!
                          end if;
                        else
                          region := 2;
                        end if;
                        // tests for region 2 or 5
                      end if;
                      // tests for sub or supercritical
                    else
                      // the pressure is over data.PLIMIT4A
                      if ssubcrit then
                        // region 1 or 3
                        if s < supperofp1(p) then
                          region := 1;
                        else
                          if s < sl or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                        // test for region 1, 3 or 4
                      else
                        // region 2, 3 or 4
                        if (s > slowerofp2(p)) then
                          region := 2;
                        else
                          if s > sv or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                        // test for 2,3 and 4
                      end if;
                      // tests above PLIMIT4A
                    end if;
                    // above or below PLIMIT4A
                  end if;
                  // grand test for limits of p and s
                end if;
                // all tests with phase == 1
              end if;
              // mode was == 0
            end region_ps;

            function region_pT
              "Return the current region (valid values: 1,2,3,5) in IF97, given pressure and temperature"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              input Integer mode=0
                "Mode: 0 means check, otherwise assume region=mode";
              output Integer region
                "Region (valid values: 1,2,3,5) in IF97, region 4 is impossible!";
            algorithm
              if (mode <> 0) then
                region := mode;
              else
                if p < data.PLIMIT4A then
                  //test for regions 1,2,5
                  if T > data.TLIMIT2 then
                    region := 5;
                  elseif T > Basic.tsat(p) then
                    region := 2;
                  else
                    region := 1;
                  end if;
                else
                  //test for regions 1,2,3
                  if T < data.TLIMIT1 then
                    region := 1;
                  elseif T < boundary23ofp(p) then
                    region := 3;
                  else
                    region := 2;
                  end if;
                end if;
              end if;
              // mode was == 0
            end region_pT;

            function region_dT
              "Return the current region (valid values: 1,2,3,4,5) in IF97, given density and temperature"
              extends Modelica.Icons.Function;
              input SI.Density d "Density";
              input SI.Temperature T "Temperature (K)";
              input Integer phase=0
                "Phase: 2 for two-phase, 1 for one phase, 0 if not known";
              input Integer mode=0
                "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "(valid values: 1,2,3,4,5) in IF97";
            protected
              Boolean Tovercrit "Flag if overcritical temperature";
              SI.Pressure p23 "Pressure needed to know if region 2 or 3";
            algorithm
              Tovercrit := T > data.TCRIT;
              if (mode <> 0) then
                region := mode;
              else
                p23 := boundary23ofT(T);
                if T > data.TLIMIT2 then
                  if d < 20.5655874106483 then
                    // check for the density in the upper corner of validity!
                    region := 5;
                  else
                    assert(false,
                      "Out of valid region for IF97, pressure above region 5!");
                  end if;
                elseif Tovercrit then
                  //check for regions 1, 2 or 3
                  if d > d2n(p23, T) and T > data.TLIMIT1 then
                    region := 3;
                  elseif T < data.TLIMIT1 then
                    region := 1;
                  else
                    // d  < d2n(p23, T) and T > data.TLIMIT1
                    region := 2;
                  end if;
                  // below critical, check for regions 1, 2, 3 or 4
                elseif (d > rhol_T(T)) then
                  // either 1 or 3
                  if T < data.TLIMIT1 then
                    region := 1;
                  else
                    region := 3;
                  end if;
                elseif (d < rhov_T(T)) then
                  // not liquid, not 2-phase, and not region 5, so either 2 or 3 or illegal
                  if (d > d2n(p23, T) and T > data.TLIMIT1) then
                    region := 3;
                  else
                    region := 2;
                  end if;
                else
                  region := 4;
                end if;
              end if;
            end region_dT;

            function hvl_dp
              "Derivative function for the specific enthalpy along the phase boundary"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output Real dh_dp
                "Derivative of specific enthalpy along the phase boundary";
            algorithm
              if bpro.region3boundary then
                dh_dp := ((bpro.d*bpro.pd - bpro.T*bpro.pt) + (bpro.T*bpro.pt*bpro.pt
                   + bpro.d*bpro.d*bpro.pd*bpro.cv)/bpro.dpT)/(bpro.pd*bpro.d*bpro.d);
              else
                dh_dp := (1/bpro.d - bpro.T*bpro.vt) + bpro.cp/bpro.dpT;
              end if;
            end hvl_dp;

            function dhl_dp
              "Derivative of liquid specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.DerEnthalpyByPressure dh_dp
                "Specific enthalpy derivative w.r.t. pressure";
            algorithm
              dh_dp := hvl_dp(p, boilingcurve_p(p));
              annotation (Inline=true);
            end dhl_dp;

            function dhv_dp
              "Derivative of vapour specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.DerEnthalpyByPressure dh_dp
                "Specific enthalpy derivative w.r.t. pressure";
            algorithm
              dh_dp := hvl_dp(p, dewcurve_p(p));
              annotation (Inline=true);
            end dhv_dp;

            function drhovl_dp
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output Real dd_dp(unit="kg/(m3.Pa)")
                "Derivative of density along the phase boundary";
            algorithm
              dd_dp := if bpro.region3boundary then (1.0 - bpro.pt/bpro.dpT)/bpro.pd
                 else -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT);
              annotation (Inline=true);
            end drhovl_dp;

            function drhol_dp
              "Derivative of density of saturated water w.r.t. pressure"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              output SI.DerDensityByPressure dd_dp
                "Derivative of density of water at the boiling point";
            algorithm
              dd_dp := drhovl_dp(p, boilingcurve_p(p));
              annotation (Inline=true);
            end drhol_dp;

            function drhov_dp
              "Derivative of density of saturated steam w.r.t. pressure"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Saturation pressure";
              output SI.DerDensityByPressure dd_dp
                "Derivative of density of water at the boiling point";
            algorithm
              dd_dp := drhovl_dp(p, dewcurve_p(p));
              annotation (Inline=true);
            end drhov_dp;
            annotation (Documentation(info="<HTML><h4>Package description</h4>
 <p>Package <b>Regions</b> contains a large number of auxiliary functions which are needed to compute the current region
 of the IAPWS/IF97 for a given pair of input variables as quickly as possible. The focus of this implementation was on
 computational efficiency, not on compact code. Many of the function values calculated in these functions could be obtained
 using the fundamental functions of IAPWS/IF97, but with considerable overhead. If the region of IAPWS/IF97 is known in advance,
 the input variable mode can be set to the region, then the somewhat costly region checks are omitted.
 The checking for the phase has to be done outside the region functions because many properties are not
 differentiable at the region boundary. If the input phase is 2, the output region will be set to 4 immediately.</p>
 <h4>Package contents</h4>
 <p> The main 4 functions in this package are the functions returning the appropriate region for two input variables.</p>
 <ul>
 <li>Function <b>region_ph</b> compute the region of IAPWS/IF97 for input pair pressure and specific enthalpy.</li>
 <li>Function <b>region_ps</b> compute the region of IAPWS/IF97 for input pair pressure and specific entropy</li>
 <li>Function <b>region_dT</b> compute the region of IAPWS/IF97 for input pair density and temperature.</li>
 <li>Function <b>region_pT</b> compute the region of IAPWS/IF97 for input pair pressure and temperature (only in phase region).</li>
 </ul>
 <p>In addition, functions of the boiling and condensation curves compute the specific enthalpy, specific entropy, or density on these
 curves. The functions for the saturation pressure and temperature are included in the package <b>Basic</b> because they are part of
 the original <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IAPWS/IF97 standards document</a>. These functions are also aliased to
 be used directly from package <b>Water</b>.
</p>
 <ul>
 <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
 the critical specific enthalpy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
 the critical  specific entropy is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
 the critical density is returned. An approximation is used for temperatures > 623.15 K.</li>
 </ul>
 <p>All other functions are auxiliary functions called from the region functions to check a specific boundary.</p>
 <ul>
 <li>Function <b>boundary23ofT</b> computes the boundary pressure between regions 2 and 3 (input temperature)</li>
 <li>Function <b>boundary23ofp</b> computes the boundary temperature between regions 2 and 3 (input pressure)</li>
 <li>Function <b>hlowerofp5</b> computes the lower specific enthalpy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>hupperofp5</b> computes the upper specific enthalpy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>slowerofp5</b> computes the lower specific entropy limit of region 5 (input p, T=1073.15 K)</li>
 <li>Function <b>supperofp5</b> computes the upper specific entropy limit of region 5 (input p, T=2273.15 K)</li>
 <li>Function <b>hlowerofp1</b> computes the lower specific enthalpy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>hupperofp1</b> computes the upper specific enthalpy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>slowerofp1</b> computes the lower specific entropy limit of region 1 (input p, T=273.15 K)</li>
 <li>Function <b>supperofp1</b> computes the upper specific entropy limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>hlowerofp2</b> computes the lower specific enthalpy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>hupperofp2</b> computes the upper specific enthalpy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>slowerofp2</b> computes the lower specific entropy limit of region 2 (input p, T=623.15 K)</li>
 <li>Function <b>supperofp2</b> computes the upper specific entropy limit of region 2 (input p, T=1073.15 K)</li>
 <li>Function <b>d1n</b> computes the density in region 1 as function of pressure and temperature</li>
 <li>Function <b>d2n</b> computes the density in region 2 as function of pressure and temperature</li>
 <li>Function <b>dhot1ofp</b> computes the hot density limit of region 1 (input p, T=623.15 K)</li>
 <li>Function <b>dupper1ofT</b>computes the high pressure density limit of region 1 (input T, p=100MPa)</li>
 <li>Function <b>hl_p_R4b</b> computes a high accuracy approximation to the liquid enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>hv_p_R4b</b> computes a high accuracy approximation to the vapour enthalpy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sl_p_R4b</b> computes a high accuracy approximation to the liquid entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>sv_p_R4b</b> computes a high accuracy approximation to the vapour entropy for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhol_p_R4b</b> computes a high accuracy approximation to the liquid density for temperatures > 623.15 K (input p)</li>
 <li>Function <b>rhov_p_R4b</b> computes a high accuracy approximation to the vapour density for temperatures > 623.15 K (input p)</li>
 </ul>

<h4>Version Info and Revision history</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
<address>Authors: Hubertus Tummescheit, Jonas Eborn and Falko Jens Wagner<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
 <ul>
 <li>Initial version: July 2000</li>
 <li>Revised and extended for inclusion in Modelica.Thermal: December 2002</li>
</ul>
</html>"));
          end Regions;

          package Basic "Base functions as described in IAWPS/IF97"
            extends Modelica.Icons.Package;

            function g1 "Gibbs function for region 1: g(p,T)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real pi1 "Dimensionless pressure";
              Real tau1 "Dimensionless temperature";
              Real[45] o "Vector of auxiliary variables";
              Real pl "Auxiliary variable";
            algorithm
              pl := min(p, data.PCRIT - 1);
              assert(p > triple.ptriple,
                "IF97 medium function g1 called with too low pressure\n" + "p = " +
                String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              assert(p <= 100.0e6, "IF97 medium function g1: the input pressure (= "
                 + String(p) + " Pa) is higher than 100 Mpa");
              assert(T >= 273.15, "IF97 medium function g1: the temperature (= " +
                String(T) + " K) is lower than 273.15 K!");
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              g.pi := p/data.PSTAR1;
              g.tau := data.TSTAR1/T;
              pi1 := 7.1000000000000 - g.pi;
              tau1 := -1.22200000000000 + g.tau;
              o[1] := tau1*tau1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              o[4] := o[3]*tau1;
              o[5] := 1/o[4];
              o[6] := o[1]*o[2];
              o[7] := o[1]*tau1;
              o[8] := 1/o[7];
              o[9] := o[1]*o[2]*o[3];
              o[10] := 1/o[2];
              o[11] := o[2]*tau1;
              o[12] := 1/o[11];
              o[13] := o[2]*o[3];
              o[14] := 1/o[3];
              o[15] := pi1*pi1;
              o[16] := o[15]*pi1;
              o[17] := o[15]*o[15];
              o[18] := o[17]*o[17];
              o[19] := o[17]*o[18]*pi1;
              o[20] := o[15]*o[17];
              o[21] := o[3]*o[3];
              o[22] := o[21]*o[21];
              o[23] := o[22]*o[3]*tau1;
              o[24] := 1/o[23];
              o[25] := o[22]*o[3];
              o[26] := 1/o[25];
              o[27] := o[1]*o[2]*o[22]*tau1;
              o[28] := 1/o[27];
              o[29] := o[1]*o[2]*o[22];
              o[30] := 1/o[29];
              o[31] := o[1]*o[2]*o[21]*o[3]*tau1;
              o[32] := 1/o[31];
              o[33] := o[2]*o[21]*o[3]*tau1;
              o[34] := 1/o[33];
              o[35] := o[1]*o[3]*tau1;
              o[36] := 1/o[35];
              o[37] := o[1]*o[3];
              o[38] := 1/o[37];
              o[39] := 1/o[6];
              o[40] := o[1]*o[22]*o[3];
              o[41] := 1/o[40];
              o[42] := 1/o[22];
              o[43] := o[1]*o[2]*o[21]*o[3];
              o[44] := 1/o[43];
              o[45] := 1/o[13];
              g.g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.82707979853120e-6
                 - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.24252819080000e-6 + (-6.5171222895601e-7
                 - 1.43417299379240e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7*o[14]
                 + o[16]*((-1.27343017416410e-9 - 1.74248712306340e-10*o[11])*o[36]
                 + o[19]*(-6.8762131295531e-19*o[34] + o[15]*(1.44783078285210e-20*o[
                32] + o[20]*(2.63357816627950e-23*o[30] + pi1*(-1.19476226400710e-23*
                o[28] + pi1*(1.82280945814040e-24*o[26] - 9.3537087292458e-26*o[24]*
                pi1))))))))) + o[8]*(-0.00047184321073267 + o[7]*(-0.000300017807930260
                 + (0.000047661393906987 + o[1]*(-4.4141845330846e-6 -
                7.2694996297594e-16*o[9]))*tau1))) + o[5]*(0.000283190801238040 + o[1]
                *(-0.00060706301565874 + o[6]*(-0.0189900682184190 + tau1*(-0.032529748770505
                 + (-0.0218417171754140 - 0.000052838357969930*o[1])*tau1))))) + (
                0.146329712131670 + tau1*(-0.84548187169114 + tau1*(-3.7563603672040
                 + tau1*(3.3855169168385 + tau1*(-0.95791963387872 + tau1*(
                0.157720385132280 + (-0.0166164171995010 + 0.00081214629983568*tau1)*
                tau1))))))/o[1];

              g.gpi := pi1*(pi1*(o[10]*(0.000095038934535162 + o[2]*(
                8.4812393955936e-6 + 2.55615384360309e-9*o[6])) + pi1*(o[12]*(
                8.9701127632000e-6 + (2.60684891582404e-6 + 5.7366919751696e-13*o[13])
                *o[7]) + pi1*(2.02584984300585e-6*o[14] + o[16]*((1.01874413933128e-8
                 + 1.39398969845072e-9*o[11])*o[36] + o[19]*(1.44400475720615e-17*o[
                34] + o[15]*(-3.3300108005598e-19*o[32] + o[20]*(-7.6373766822106e-22
                *o[30] + pi1*(3.5842867920213e-22*o[28] + pi1*(-5.6507093202352e-23*o[
                26] + 2.99318679335866e-24*o[24]*pi1))))))))) + o[8]*(
                0.00094368642146534 + o[7]*(0.00060003561586052 + (-0.000095322787813974
                 + o[1]*(8.8283690661692e-6 + 1.45389992595188e-15*o[9]))*tau1))) + o[
                5]*(-0.000283190801238040 + o[1]*(0.00060706301565874 + o[6]*(
                0.0189900682184190 + tau1*(0.032529748770505 + (0.0218417171754140 +
                0.000052838357969930*o[1])*tau1))));

              g.gpipi := pi1*(o[10]*(-0.000190077869070324 + o[2]*(-0.0000169624787911872
                 - 5.1123076872062e-9*o[6])) + pi1*(o[12]*(-0.0000269103382896000 + (
                -7.8205467474721e-6 - 1.72100759255088e-12*o[13])*o[7]) + pi1*(-8.1033993720234e-6
                *o[14] + o[16]*((-7.1312089753190e-8 - 9.7579278891550e-9*o[11])*o[36]
                 + o[19]*(-2.88800951441230e-16*o[34] + o[15]*(7.3260237612316e-18*o[
                32] + o[20]*(2.13846547101895e-20*o[30] + pi1*(-1.03944316968618e-20*
                o[28] + pi1*(1.69521279607057e-21*o[26] - 9.2788790594118e-23*o[24]*
                pi1))))))))) + o[8]*(-0.00094368642146534 + o[7]*(-0.00060003561586052
                 + (0.000095322787813974 + o[1]*(-8.8283690661692e-6 -
                1.45389992595188e-15*o[9]))*tau1));

              g.gtau := pi1*(o[38]*(-0.00254871721114236 + o[1]*(0.0042494411096112
                 + (0.0189900682184190 + (-0.0218417171754140 - 0.000158515073909790*
                o[1])*o[1])*o[6])) + pi1*(o[10]*(0.00141552963219801 + o[2]*(
                0.000047661393906987 + o[1]*(-0.0000132425535992538 -
                1.23581493705910e-14*o[9]))) + pi1*(o[12]*(0.000126718579380216 -
                5.1123076872062e-9*o[37]) + pi1*(o[39]*(0.0000112126409540000 + (
                1.30342445791202e-6 - 1.43417299379240e-12*o[13])*o[7]) + pi1*(
                3.2413597488094e-6*o[5] + o[16]*((1.40077319158051e-8 +
                1.04549227383804e-9*o[11])*o[45] + o[19]*(1.99410180757040e-17*o[44]
                 + o[15]*(-4.4882754268415e-19*o[42] + o[20]*(-1.00075970318621e-21*o[
                28] + pi1*(4.6595728296277e-22*o[26] + pi1*(-7.2912378325616e-23*o[24]
                 + 3.8350205789908e-24*o[41]*pi1))))))))))) + o[8]*(-0.292659424263340
                 + tau1*(0.84548187169114 + o[1]*(3.3855169168385 + tau1*(-1.91583926775744
                 + tau1*(0.47316115539684 + (-0.066465668798004 + 0.0040607314991784*
                tau1)*tau1)))));

              g.gtautau := pi1*(o[36]*(0.0254871721114236 + o[1]*(-0.033995528876889
                 + (-0.037980136436838 - 0.00031703014781958*o[2])*o[6])) + pi1*(o[12]
                *(-0.0056621185287920 + o[6]*(-0.0000264851071985076 -
                1.97730389929456e-13*o[9])) + pi1*((-0.00063359289690108 -
                2.55615384360309e-8*o[37])*o[39] + pi1*(pi1*(-0.0000291722377392842*o[
                38] + o[16]*(o[19]*(-5.9823054227112e-16*o[32] + o[15]*(o[20]*(
                3.9029628424262e-20*o[26] + pi1*(-1.86382913185108e-20*o[24] + pi1*(
                2.98940751135026e-21*o[41] - (1.61070864317613e-22*pi1)/(o[1]*o[22]*o[
                3]*tau1)))) + 1.43624813658928e-17/(o[22]*tau1))) + (-1.68092782989661e-7
                 - 7.3184459168663e-9*o[11])/(o[2]*o[3]*tau1))) + (-0.000067275845724000
                 + (-3.9102733737361e-6 - 1.29075569441316e-11*o[13])*o[7])/(o[1]*o[2]
                *tau1))))) + o[10]*(0.87797827279002 + tau1*(-1.69096374338228 + o[7]
                *(-1.91583926775744 + tau1*(0.94632231079368 + (-0.199397006394012 +
                0.0162429259967136*tau1)*tau1))));

              g.gtaupi := o[38]*(0.00254871721114236 + o[1]*(-0.0042494411096112 + (-0.0189900682184190
                 + (0.0218417171754140 + 0.000158515073909790*o[1])*o[1])*o[6])) +
                pi1*(o[10]*(-0.00283105926439602 + o[2]*(-0.000095322787813974 + o[1]
                *(0.0000264851071985076 + 2.47162987411820e-14*o[9]))) + pi1*(o[12]*(
                -0.00038015573814065 + 1.53369230616185e-8*o[37]) + pi1*(o[39]*(-0.000044850563816000
                 + (-5.2136978316481e-6 + 5.7366919751696e-12*o[13])*o[7]) + pi1*(-0.0000162067987440468
                *o[5] + o[16]*((-1.12061855326441e-7 - 8.3639381907043e-9*o[11])*o[45]
                 + o[19]*(-4.1876137958978e-16*o[44] + o[15]*(1.03230334817355e-17*o[
                42] + o[20]*(2.90220313924001e-20*o[28] + pi1*(-1.39787184888831e-20*
                o[26] + pi1*(2.26028372809410e-21*o[24] - 1.22720658527705e-22*o[41]*
                pi1))))))))));
            end g1;

            function g2 "Gibbs function for region 2: g(p,T)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real tau2 "Dimensionless temperature";
              Real[55] o "Vector of auxiliary variables";
            algorithm
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              assert(p > 0.0,
                "IF97 medium function g2 called with too low pressure\n" + "p = " +
                String(p) + " Pa <=  0.0 Pa");
              assert(p <= 100.0e6, "IF97 medium function g2: the input pressure (= "
                 + String(p) + " Pa) is higher than 100 Mpa");
              assert(T >= 273.15, "IF97 medium function g2: the temperature (= " +
                String(T) + " K) is lower than 273.15 K!");
              assert(T <= 1073.15,
                "IF97 medium function g2: the input temperature (= " + String(T) +
                " K) is higher than the limit of 1073.15 K");
              g.pi := p/data.PSTAR2;
              g.tau := data.TSTAR2/T;
              tau2 := -0.5 + g.tau;
              o[1] := tau2*tau2;
              o[2] := o[1]*tau2;
              o[3] := -0.050325278727930*o[2];
              o[4] := -0.057581259083432 + o[3];
              o[5] := o[4]*tau2;
              o[6] := -0.045996013696365 + o[5];
              o[7] := o[6]*tau2;
              o[8] := -0.0178348622923580 + o[7];
              o[9] := o[8]*tau2;
              o[10] := o[1]*o[1];
              o[11] := o[10]*o[10];
              o[12] := o[11]*o[11];
              o[13] := o[10]*o[11]*o[12]*tau2;
              o[14] := o[1]*o[10]*tau2;
              o[15] := o[10]*o[11]*tau2;
              o[16] := o[1]*o[12]*tau2;
              o[17] := o[1]*o[11]*tau2;
              o[18] := o[1]*o[10]*o[11];
              o[19] := o[10]*o[11]*o[12];
              o[20] := o[1]*o[10];
              o[21] := g.pi*g.pi;
              o[22] := o[21]*o[21];
              o[23] := o[21]*o[22];
              o[24] := o[10]*o[12]*tau2;
              o[25] := o[12]*o[12];
              o[26] := o[11]*o[12]*o[25]*tau2;
              o[27] := o[10]*o[12];
              o[28] := o[1]*o[10]*o[11]*tau2;
              o[29] := o[10]*o[12]*o[25]*tau2;
              o[30] := o[1]*o[10]*o[25]*tau2;
              o[31] := o[1]*o[11]*o[12];
              o[32] := o[1]*o[12];
              o[33] := g.tau*g.tau;
              o[34] := o[33]*o[33];
              o[35] := -0.000053349095828174*o[13];
              o[36] := -0.087594591301146 + o[35];
              o[37] := o[2]*o[36];
              o[38] := -0.0078785554486710 + o[37];
              o[39] := o[1]*o[38];
              o[40] := -0.00037897975032630 + o[39];
              o[41] := o[40]*tau2;
              o[42] := -0.000066065283340406 + o[41];
              o[43] := o[42]*tau2;
              o[44] := 5.7870447262208e-6*tau2;
              o[45] := -0.301951672367580*o[2];
              o[46] := -0.172743777250296 + o[45];
              o[47] := o[46]*tau2;
              o[48] := -0.091992027392730 + o[47];
              o[49] := o[48]*tau2;
              o[50] := o[1]*o[11];
              o[51] := o[10]*o[11];
              o[52] := o[11]*o[12]*o[25];
              o[53] := o[10]*o[12]*o[25];
              o[54] := o[1]*o[10]*o[25];
              o[55] := o[11]*o[12]*tau2;

              g.g := g.pi*(-0.00177317424732130 + o[9] + g.pi*(tau2*(-0.000033032641670203
                 + (-0.000189489875163150 + o[1]*(-0.0039392777243355 + (-0.043797295650573
                 - 0.0000266745479140870*o[13])*o[2]))*tau2) + g.pi*(
                2.04817376923090e-8 + (4.3870667284435e-7 + o[1]*(-0.000032277677238570
                 + (-0.00150339245421480 - 0.040668253562649*o[13])*o[2]))*tau2 + g.pi
                *(g.pi*(2.29220763376610e-6*o[14] + g.pi*((-1.67147664510610e-11 + o[
                15]*(-0.00211714723213550 - 23.8957419341040*o[16]))*o[2] + g.pi*(-5.9059564324270e-18
                 + o[17]*(-1.26218088991010e-6 - 0.038946842435739*o[18]) + g.pi*(o[
                11]*(1.12562113604590e-11 - 8.2311340897998*o[19]) + g.pi*(
                1.98097128020880e-8*o[15] + g.pi*(o[10]*(1.04069652101740e-19 + (-1.02347470959290e-13
                 - 1.00181793795110e-9*o[10])*o[20]) + o[23]*(o[13]*(-8.0882908646985e-11
                 + 0.106930318794090*o[24]) + o[21]*(-0.33662250574171*o[26] + o[21]*
                (o[27]*(8.9185845355421e-25 + (3.06293168762320e-13 -
                4.2002467698208e-6*o[15])*o[28]) + g.pi*(-5.9056029685639e-26*o[24]
                 + g.pi*(3.7826947613457e-6*o[29] + g.pi*(-1.27686089346810e-15*o[30]
                 + o[31]*(7.3087610595061e-29 + o[18]*(5.5414715350778e-17 -
                9.4369707241210e-7*o[32]))*g.pi)))))))))))) + tau2*(-7.8847309559367e-10
                 + (1.27907178522850e-8 + 4.8225372718507e-7*tau2)*tau2))))) + (-0.0056087911830200
                 + g.tau*(0.071452738814550 + g.tau*(-0.40710498239280 + g.tau*(
                1.42408197144400 + g.tau*(-4.3839511194500 + g.tau*(-9.6927686002170
                 + g.tau*(10.0866556801800 + (-0.284086326077200 + 0.0212684635330700
                *g.tau)*g.tau) + Modelica.Math.log(g.pi)))))))/(o[34]*g.tau);

              g.gpi := (1.00000000000000 + g.pi*(-0.00177317424732130 + o[9] + g.pi*(
                o[43] + g.pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[1]*(-0.000096833031715710
                 + (-0.0045101773626444 - 0.122004760687947*o[13])*o[2]))*tau2 + g.pi
                *(g.pi*(0.0000114610381688305*o[14] + g.pi*((-1.00288598706366e-10 +
                o[15]*(-0.0127028833928130 - 143.374451604624*o[16]))*o[2] + g.pi*(-4.1341695026989e-17
                 + o[17]*(-8.8352662293707e-6 - 0.272627897050173*o[18]) + g.pi*(o[11]
                *(9.0049690883672e-11 - 65.849072718398*o[19]) + g.pi*(
                1.78287415218792e-7*o[15] + g.pi*(o[10]*(1.04069652101740e-18 + (-1.02347470959290e-12
                 - 1.00181793795110e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.29412653835176e-9
                 + 1.71088510070544*o[24]) + o[21]*(-6.0592051033508*o[26] + o[21]*(o[
                27]*(1.78371690710842e-23 + (6.1258633752464e-12 -
                0.000084004935396416*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[24]
                 + g.pi*(0.000083219284749605*o[29] + g.pi*(-2.93678005497663e-14*o[
                30] + o[31]*(1.75410265428146e-27 + o[18]*(1.32995316841867e-15 -
                0.0000226487297378904*o[32]))*g.pi)))))))))))) + tau2*(-3.15389238237468e-9
                 + (5.1162871409140e-8 + 1.92901490874028e-6*tau2)*tau2))))))/g.pi;

              g.gpipi := (-1.00000000000000 + o[21]*(o[43] + g.pi*(
                1.22890426153854e-7 + (2.63224003706610e-6 + o[1]*(-0.000193666063431420
                 + (-0.0090203547252888 - 0.244009521375894*o[13])*o[2]))*tau2 + g.pi
                *(g.pi*(0.000045844152675322*o[14] + g.pi*((-5.0144299353183e-10 + o[
                15]*(-0.063514416964065 - 716.87225802312*o[16]))*o[2] + g.pi*(-2.48050170161934e-16
                 + o[17]*(-0.000053011597376224 - 1.63576738230104*o[18]) + g.pi*(o[
                11]*(6.3034783618570e-10 - 460.94350902879*o[19]) + g.pi*(
                1.42629932175034e-6*o[15] + g.pi*(o[10]*(9.3662686891566e-18 + (-9.2112723863361e-12
                 - 9.0163614415599e-8*o[10])*o[20]) + o[23]*(o[13]*(-1.94118980752764e-8
                 + 25.6632765105816*o[24]) + o[21]*(-103.006486756963*o[26] + o[21]*(
                o[27]*(3.3890621235060e-22 + (1.16391404129682e-10 -
                0.00159609377253190*o[15])*o[28]) + g.pi*(-2.48035324679684e-23*o[24]
                 + g.pi*(0.00174760497974171*o[29] + g.pi*(-6.4609161209486e-13*o[30]
                 + o[31]*(4.0344361048474e-26 + o[18]*(3.05889228736295e-14 -
                0.00052092078397148*o[32]))*g.pi)))))))))))) + tau2*(-9.4616771471240e-9
                 + (1.53488614227420e-7 + o[44])*tau2)))))/o[21];

              g.gtau := (0.0280439559151000 + g.tau*(-0.285810955258200 + g.tau*(
                1.22131494717840 + g.tau*(-2.84816394288800 + g.tau*(4.3839511194500
                 + o[33]*(10.0866556801800 + (-0.56817265215440 + 0.063805390599210*g.tau)
                *g.tau))))))/(o[33]*o[34]) + g.pi*(-0.0178348622923580 + o[49] + g.pi
                *(-0.000033032641670203 + (-0.00037897975032630 + o[1]*(-0.0157571108973420
                 + (-0.306581069554011 - 0.00096028372490713*o[13])*o[2]))*tau2 + g.pi
                *(4.3870667284435e-7 + o[1]*(-0.000096833031715710 + (-0.0090203547252888
                 - 1.42338887469272*o[13])*o[2]) + g.pi*(-7.8847309559367e-10 + g.pi*
                (0.0000160454534363627*o[20] + g.pi*(o[1]*(-5.0144299353183e-11 + o[
                15]*(-0.033874355714168 - 836.35096769364*o[16])) + g.pi*((-0.0000138839897890111
                 - 0.97367106089347*o[18])*o[50] + g.pi*(o[14]*(9.0049690883672e-11
                 - 296.320827232793*o[19]) + g.pi*(2.57526266427144e-7*o[51] + g.pi*(
                o[2]*(4.1627860840696e-19 + (-1.02347470959290e-12 -
                1.40254511313154e-8*o[10])*o[20]) + o[23]*(o[19]*(-2.34560435076256e-9
                 + 5.3465159397045*o[24]) + o[21]*(-19.1874828272775*o[52] + o[21]*(o[
                16]*(1.78371690710842e-23 + (1.07202609066812e-11 -
                0.000201611844951398*o[15])*o[28]) + g.pi*(-1.24017662339842e-24*o[27]
                 + g.pi*(0.000200482822351322*o[53] + g.pi*(-4.9797574845256e-14*o[54]
                 + (1.90027787547159e-27 + o[18]*(2.21658861403112e-15 -
                0.000054734430199902*o[32]))*o[55]*g.pi)))))))))))) + (
                2.55814357045700e-8 + 1.44676118155521e-6*tau2)*tau2))));

              g.gtautau := (-0.168263735490600 + g.tau*(1.42905477629100 + g.tau*(-4.8852597887136
                 + g.tau*(8.5444918286640 + g.tau*(-8.7679022389000 + o[33]*(-0.56817265215440
                 + 0.127610781198420*g.tau)*g.tau)))))/(o[33]*o[34]*g.tau) + g.pi*(-0.091992027392730
                 + (-0.34548755450059 - 1.50975836183790*o[2])*tau2 + g.pi*(-0.00037897975032630
                 + o[1]*(-0.047271332692026 + (-1.83948641732407 - 0.033609930371750*
                o[13])*o[2]) + g.pi*((-0.000193666063431420 + (-0.045101773626444 -
                48.395221739552*o[13])*o[2])*tau2 + g.pi*(2.55814357045700e-8 +
                2.89352236311042e-6*tau2 + g.pi*(0.000096272720618176*o[10]*tau2 + g.pi
                *((-1.00288598706366e-10 + o[15]*(-0.50811533571252 -
                28435.9329015838*o[16]))*tau2 + g.pi*(o[11]*(-0.000138839897890111 -
                23.3681054614434*o[18])*tau2 + g.pi*((6.3034783618570e-10 -
                10371.2289531477*o[19])*o[20] + g.pi*(3.09031519712573e-6*o[17] + g.pi
                *(o[1]*(1.24883582522088e-18 + (-9.2112723863361e-12 -
                1.82330864707100e-7*o[10])*o[20]) + o[23]*(o[1]*o[11]*o[12]*(-6.5676921821352e-8
                 + 261.979281045521*o[24])*tau2 + o[21]*(-1074.49903832754*o[1]*o[10]
                *o[12]*o[25]*tau2 + o[21]*((3.3890621235060e-22 + (
                3.6448887082716e-10 - 0.0094757567127157*o[15])*o[28])*o[32] + g.pi*(
                -2.48035324679684e-23*o[16] + g.pi*(0.0104251067622687*o[1]*o[12]*o[
                25]*tau2 + g.pi*(o[11]*o[12]*(4.7506946886790e-26 + o[18]*(
                8.6446955947214e-14 - 0.00311986252139440*o[32]))*g.pi -
                1.89230784411972e-12*o[10]*o[25]*tau2))))))))))))))));

              g.gtaupi := -0.0178348622923580 + o[49] + g.pi*(-0.000066065283340406
                 + (-0.00075795950065260 + o[1]*(-0.0315142217946840 + (-0.61316213910802
                 - 0.00192056744981426*o[13])*o[2]))*tau2 + g.pi*(1.31612001853305e-6
                 + o[1]*(-0.000290499095147130 + (-0.0270610641758664 -
                4.2701666240781*o[13])*o[2]) + g.pi*(-3.15389238237468e-9 + g.pi*(
                0.000080227267181813*o[20] + g.pi*(o[1]*(-3.00865796119098e-10 + o[15]
                *(-0.203246134285008 - 5018.1058061618*o[16])) + g.pi*((-0.000097187928523078
                 - 6.8156974262543*o[18])*o[50] + g.pi*(o[14]*(7.2039752706938e-10 -
                2370.56661786234*o[19]) + g.pi*(2.31773639784430e-6*o[51] + g.pi*(o[2]
                *(4.1627860840696e-18 + (-1.02347470959290e-11 - 1.40254511313154e-7*
                o[10])*o[20]) + o[23]*(o[19]*(-3.7529669612201e-8 + 85.544255035272*o[
                24]) + o[21]*(-345.37469089099*o[52] + o[21]*(o[16]*(
                3.5674338142168e-22 + (2.14405218133624e-10 - 0.0040322368990280*o[15])
                *o[28]) + g.pi*(-2.60437090913668e-23*o[27] + g.pi*(
                0.0044106220917291*o[53] + g.pi*(-1.14534422144089e-12*o[54] + (
                4.5606669011318e-26 + o[18]*(5.3198126736747e-14 -
                0.00131362632479764*o[32]))*o[55]*g.pi)))))))))))) + (
                1.02325742818280e-7 + o[44])*tau2)));
            end g2;

            function f3 "Helmholtz function for region 3: f(d,T)"
              extends Modelica.Icons.Function;
              input SI.Density d "Density";
              input SI.Temperature T "Temperature (K)";
              output Modelica.Media.Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
            protected
              Real[40] o "Vector of auxiliary variables";
            algorithm
              f.T := T;
              f.d := d;
              f.R := data.RH2O;
              f.tau := data.TCRIT/T;
              f.delta := if (d == data.DCRIT and T == data.TCRIT) then 1 - Modelica.Constants.eps
                 else abs(d/data.DCRIT);
              o[1] := f.tau*f.tau;
              o[2] := o[1]*o[1];
              o[3] := o[2]*f.tau;
              o[4] := o[1]*f.tau;
              o[5] := o[2]*o[2];
              o[6] := o[1]*o[5]*f.tau;
              o[7] := o[5]*f.tau;
              o[8] := -0.64207765181607*o[1];
              o[9] := 0.88521043984318 + o[8];
              o[10] := o[7]*o[9];
              o[11] := -1.15244078066810 + o[10];
              o[12] := o[11]*o[2];
              o[13] := -1.26543154777140 + o[12];
              o[14] := o[1]*o[13];
              o[15] := o[1]*o[2]*o[5]*f.tau;
              o[16] := o[2]*o[5];
              o[17] := o[1]*o[5];
              o[18] := o[5]*o[5];
              o[19] := o[1]*o[18]*o[2];
              o[20] := o[1]*o[18]*o[2]*f.tau;
              o[21] := o[18]*o[5];
              o[22] := o[1]*o[18]*o[5];
              o[23] := 0.251168168486160*o[2];
              o[24] := 0.078841073758308 + o[23];
              o[25] := o[15]*o[24];
              o[26] := -6.1005234513930 + o[25];
              o[27] := o[26]*f.tau;
              o[28] := 9.7944563083754 + o[27];
              o[29] := o[2]*o[28];
              o[30] := -1.70429417648412 + o[29];
              o[31] := o[1]*o[30];
              o[32] := f.delta*f.delta;
              o[33] := -10.9153200808732*o[1];
              o[34] := 13.2781565976477 + o[33];
              o[35] := o[34]*o[7];
              o[36] := -6.9146446840086 + o[35];
              o[37] := o[2]*o[36];
              o[38] := -2.53086309554280 + o[37];
              o[39] := o[38]*f.tau;
              o[40] := o[18]*o[5]*f.tau;

              f.f := -15.7328452902390 + f.tau*(20.9443969743070 + (-7.6867707878716
                 + o[3]*(2.61859477879540 + o[4]*(-2.80807811486200 + o[1]*(
                1.20533696965170 - 0.0084566812812502*o[6]))))*f.tau) + f.delta*(o[14]
                 + f.delta*(0.38493460186671 + o[1]*(-0.85214708824206 + o[2]*(
                4.8972281541877 + (-3.05026172569650 + o[15]*(0.039420536879154 +
                0.125584084243080*o[2]))*f.tau)) + f.delta*(-0.279993296987100 + o[1]
                *(1.38997995694600 + o[1]*(-2.01899150235700 + o[16]*(-0.0082147637173963
                 - 0.47596035734923*o[17]))) + f.delta*(0.043984074473500 + o[1]*(-0.44476435428739
                 + o[1]*(0.90572070719733 + 0.70522450087967*o[19])) + f.delta*(f.delta
                *(-0.0221754008730960 + o[1]*(0.094260751665092 + 0.164362784479610*o[
                21]) + f.delta*(-0.0135033722413480*o[1] + f.delta*(-0.0148343453524720
                *o[22] + f.delta*(o[1]*(0.00057922953628084 + 0.0032308904703711*o[21])
                 + f.delta*(0.000080964802996215 - 0.000044923899061815*f.delta*o[22]
                 - 0.000165576797950370*f.tau))))) + (0.107705126263320 + o[1]*(-0.32913623258954
                 - 0.50871062041158*o[20]))*f.tau))))) + 1.06580700285130*
                Modelica.Math.log(f.delta);

              f.fdelta := (1.06580700285130 + f.delta*(o[14] + f.delta*(
                0.76986920373342 + o[31] + f.delta*(-0.83997989096130 + o[1]*(
                4.1699398708380 + o[1]*(-6.0569745070710 + o[16]*(-0.0246442911521889
                 - 1.42788107204769*o[17]))) + f.delta*(0.175936297894000 + o[1]*(-1.77905741714956
                 + o[1]*(3.6228828287893 + 2.82089800351868*o[19])) + f.delta*(f.delta
                *(-0.133052405238576 + o[1]*(0.56556450999055 + 0.98617670687766*o[21])
                 + f.delta*(-0.094523605689436*o[1] + f.delta*(-0.118674762819776*o[
                22] + f.delta*(o[1]*(0.0052130658265276 + 0.0290780142333399*o[21])
                 + f.delta*(0.00080964802996215 - 0.00049416288967996*f.delta*o[22]
                 - 0.00165576797950370*f.tau))))) + (0.53852563131660 + o[1]*(-1.64568116294770
                 - 2.54355310205790*o[20]))*f.tau))))))/f.delta;

              f.fdeltadelta := (-1.06580700285130 + o[32]*(0.76986920373342 + o[31]
                 + f.delta*(-1.67995978192260 + o[1]*(8.3398797416760 + o[1]*(-12.1139490141420
                 + o[16]*(-0.049288582304378 - 2.85576214409538*o[17]))) + f.delta*(
                0.52780889368200 + o[1]*(-5.3371722514487 + o[1]*(10.8686484863680 +
                8.4626940105560*o[19])) + f.delta*(f.delta*(-0.66526202619288 + o[1]*
                (2.82782254995276 + 4.9308835343883*o[21]) + f.delta*(-0.56714163413662
                *o[1] + f.delta*(-0.83072333973843*o[22] + f.delta*(o[1]*(
                0.041704526612220 + 0.232624113866719*o[21]) + f.delta*(
                0.0072868322696594 - 0.0049416288967996*f.delta*o[22] -
                0.0149019118155333*f.tau))))) + (2.15410252526640 + o[1]*(-6.5827246517908
                 - 10.1742124082316*o[20]))*f.tau)))))/o[32];

              f.ftau := 20.9443969743070 + (-15.3735415757432 + o[3]*(
                18.3301634515678 + o[4]*(-28.0807811486200 + o[1]*(14.4640436358204
                 - 0.194503669468755*o[6]))))*f.tau + f.delta*(o[39] + f.delta*(f.tau
                *(-1.70429417648412 + o[2]*(29.3833689251262 + (-21.3518320798755 + o[
                15]*(0.86725181134139 + 3.2651861903201*o[2]))*f.tau)) + f.delta*((
                2.77995991389200 + o[1]*(-8.0759660094280 + o[16]*(-0.131436219478341
                 - 12.3749692910800*o[17])))*f.tau + f.delta*((-0.88952870857478 + o[
                1]*(3.6228828287893 + 18.3358370228714*o[19]))*f.tau + f.delta*(
                0.107705126263320 + o[1]*(-0.98740869776862 - 13.2264761307011*o[20])
                 + f.delta*((0.188521503330184 + 4.2734323964699*o[21])*f.tau + f.delta
                *(-0.0270067444826960*f.tau + f.delta*(-0.38569297916427*o[40] + f.delta
                *(f.delta*(-0.000165576797950370 - 0.00116802137560719*f.delta*o[40])
                 + (0.00115845907256168 + 0.084003152229649*o[21])*f.tau)))))))));

              f.ftautau := -15.3735415757432 + o[3]*(109.980980709407 + o[4]*(-252.727030337580
                 + o[1]*(159.104479994024 - 4.2790807283126*o[6]))) + f.delta*(-2.53086309554280
                 + o[2]*(-34.573223420043 + (185.894192367068 - 174.645121293971*o[1])
                *o[7]) + f.delta*(-1.70429417648412 + o[2]*(146.916844625631 + (-128.110992479253
                 + o[15]*(18.2122880381691 + 81.629654758002*o[2]))*f.tau) + f.delta*
                (2.77995991389200 + o[1]*(-24.2278980282840 + o[16]*(-1.97154329217511
                 - 309.374232277000*o[17])) + f.delta*(-0.88952870857478 + o[1]*(
                10.8686484863680 + 458.39592557179*o[19]) + f.delta*(f.delta*(
                0.188521503330184 + 106.835809911747*o[21] + f.delta*(-0.0270067444826960
                 + f.delta*(-9.6423244791068*o[21] + f.delta*(0.00115845907256168 +
                2.10007880574121*o[21] - 0.0292005343901797*o[21]*o[32])))) + (-1.97481739553724
                 - 330.66190326753*o[20])*f.tau)))));

              f.fdeltatau := o[39] + f.delta*(f.tau*(-3.4085883529682 + o[2]*(
                58.766737850252 + (-42.703664159751 + o[15]*(1.73450362268278 +
                6.5303723806402*o[2]))*f.tau)) + f.delta*((8.3398797416760 + o[1]*(-24.2278980282840
                 + o[16]*(-0.39430865843502 - 37.124907873240*o[17])))*f.tau + f.delta
                *((-3.5581148342991 + o[1]*(14.4915313151573 + 73.343348091486*o[19]))
                *f.tau + f.delta*(0.53852563131660 + o[1]*(-4.9370434888431 -
                66.132380653505*o[20]) + f.delta*((1.13112901998110 +
                25.6405943788192*o[21])*f.tau + f.delta*(-0.189047211378872*f.tau + f.delta
                *(-3.08554383331418*o[40] + f.delta*(f.delta*(-0.00165576797950370 -
                0.0128482351316791*f.delta*o[40]) + (0.0104261316530551 +
                0.75602837006684*o[21])*f.tau))))))));
            end f3;

            function g5 "Base function for region 5: g(p,T)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real[11] o "Vector of auxiliary variables";
            algorithm
              assert(p > 0.0,
                "IF97 medium function g5 called with too low pressure\n" + "p = " +
                String(p) + " Pa <=  0.0 Pa");
              assert(p <= data.PLIMIT5, "IF97 medium function g5: input pressure (= "
                 + String(p) + " Pa) is higher than 10 Mpa in region 5");
              assert(T <= 2273.15, "IF97 medium function g5: input temperature (= "
                 + String(T) + " K) is higher than limit of 2273.15K in region 5");
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              g.pi := p/data.PSTAR5;
              g.tau := data.TSTAR5/T;
              o[1] := g.tau*g.tau;
              o[2] := -0.0045942820899910*o[1];
              o[3] := 0.00217746787145710 + o[2];
              o[4] := o[3]*g.tau;
              o[5] := o[1]*g.tau;
              o[6] := o[1]*o[1];
              o[7] := o[6]*o[6];
              o[8] := o[7]*g.tau;
              o[9] := -7.9449656719138e-6*o[8];
              o[10] := g.pi*g.pi;
              o[11] := -0.0137828462699730*o[1];

              g.g := g.pi*(-0.000125631835895920 + o[4] + g.pi*(-3.9724828359569e-6*o[
                8] + 1.29192282897840e-7*o[5]*g.pi)) + (-0.0248051489334660 + g.tau*(
                0.36901534980333 + g.tau*(-3.11613182139250 + g.tau*(-13.1799836742010
                 + (6.8540841634434 - 0.32961626538917*g.tau)*g.tau +
                Modelica.Math.log(g.pi)))))/o[5];

              g.gpi := (1.0 + g.pi*(-0.000125631835895920 + o[4] + g.pi*(o[9] +
                3.8757684869352e-7*o[5]*g.pi)))/g.pi;

              g.gpipi := (-1.00000000000000 + o[10]*(o[9] + 7.7515369738704e-7*o[5]*g.pi))
                /o[10];

              g.gtau := g.pi*(0.00217746787145710 + o[11] + g.pi*(-0.000035752345523612
                *o[7] + 3.8757684869352e-7*o[1]*g.pi)) + (0.074415446800398 + g.tau*(
                -0.73803069960666 + (3.11613182139250 + o[1]*(6.8540841634434 -
                0.65923253077834*g.tau))*g.tau))/o[6];

              g.gtautau := (-0.297661787201592 + g.tau*(2.21409209881998 + (-6.2322636427850
                 - 0.65923253077834*o[5])*g.tau))/(o[6]*g.tau) + g.pi*(-0.0275656925399460
                *g.tau + g.pi*(-0.000286018764188897*o[1]*o[6]*g.tau +
                7.7515369738704e-7*g.pi*g.tau));

              g.gtaupi := 0.00217746787145710 + o[11] + g.pi*(-0.000071504691047224*o[
                7] + 1.16273054608056e-6*o[1]*g.pi);
            end g5;

            function tph1 "Inverse function for region 1: T(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              Real eta1 "Dimensionless specific enthalpy";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              assert(p > triple.ptriple,
                "IF97 medium function tph1 called with too low pressure\n" + "p = "
                 + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              pi := p/data.PSTAR2;
              eta1 := h/data.HSTAR1 + 1.0;
              o[1] := eta1*eta1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              T := -238.724899245210 - 13.3917448726020*pi + eta1*(404.21188637945 +
                43.211039183559*pi + eta1*(113.497468817180 - 54.010067170506*pi +
                eta1*(30.5358922039160*pi + eta1*(-6.5964749423638*pi + o[1]*(-5.8457616048039
                 + o[2]*(pi*(0.0093965400878363 + (-0.0000258586412820730 +
                6.6456186191635e-8*pi)*pi) + o[2]*o[3]*(-0.000152854824131400 + o[1]*
                o[3]*(-1.08667076953770e-6 + pi*(1.15736475053400e-7 + pi*(-4.0644363084799e-9
                 + pi*(8.0670734103027e-11 + pi*(-9.3477771213947e-13 + (
                5.8265442020601e-15 - 1.50201859535030e-17*pi)*pi))))))))))));
            end tph1;

            function tps1 "Inverse function for region 1: T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temperature T "Temperature (K)";
            protected
              constant SI.Pressure pstar=1.0e6;
              constant SI.SpecificEntropy sstar=1.0e3;
              Real pi "Dimensionless pressure";
              Real sigma1 "Dimensionless specific entropy";
              Real[6] o "Vector of auxiliary variables";
            algorithm
              pi := p/pstar;
              assert(p > triple.ptriple,
                "IF97 medium function tps1 called with too low pressure\n" + "p = "
                 + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");

              sigma1 := s/sstar + 2.0;
              o[1] := sigma1*sigma1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              o[4] := o[3]*o[3];
              o[5] := o[4]*o[4];
              o[6] := o[1]*o[2]*o[4];

              T := 174.782680583070 + sigma1*(34.806930892873 + sigma1*(
                6.5292584978455 + (0.33039981775489 + o[3]*(-1.92813829231960e-7 -
                2.49091972445730e-23*o[2]*o[4]))*sigma1)) + pi*(-0.261076364893320 +
                pi*(0.00056608900654837 + pi*(o[1]*o[3]*(2.64004413606890e-13 +
                7.8124600459723e-29*o[6]) - 3.07321999036680e-31*o[5]*pi) + sigma1*(-0.00032635483139717
                 + sigma1*(0.000044778286690632 + o[1]*o[2]*(-5.1322156908507e-10 -
                4.2522657042207e-26*o[6])*sigma1))) + sigma1*(0.225929659815860 +
                sigma1*(-0.064256463395226 + sigma1*(0.0078876289270526 + o[3]*sigma1
                *(3.5672110607366e-10 + 1.73324969948950e-24*o[1]*o[4]*sigma1)))));
            end tps1;

            function tph2 "Reverse function for region 2: T(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              Real pi2b "Dimensionless pressure";
              Real pi2c "Dimensionless pressure";
              Real eta "Dimensionless specific enthalpy";
              Real etabc "Dimensionless specific enthalpy";
              Real eta2a "Dimensionless specific enthalpy";
              Real eta2b "Dimensionless specific enthalpy";
              Real eta2c "Dimensionless specific enthalpy";
              Real[8] o "Vector of auxiliary variables";
            algorithm
              pi := p*data.IPSTAR;
              eta := h*data.IHSTAR;
              etabc := h*1.0e-3;
              if (pi < 4.0) then
                eta2a := eta - 2.1;
                o[1] := eta2a*eta2a;
                o[2] := o[1]*o[1];
                o[3] := pi*pi;
                o[4] := o[3]*o[3];
                o[5] := o[3]*pi;
                T := 1089.89523182880 + (1.84457493557900 - 0.0061707422868339*pi)*pi
                   + eta2a*(849.51654495535 - 4.1792700549624*pi + eta2a*(-107.817480918260
                   + (6.2478196935812 - 0.310780466295830*pi)*pi + eta2a*(
                  33.153654801263 - 17.3445631081140*pi + o[2]*(-7.4232016790248 + pi
                  *(-200.581768620960 + 11.6708730771070*pi) + o[1]*(271.960654737960
                  *pi + o[1]*(-455.11318285818*pi + eta2a*(1.38657242832260*o[4] + o[
                  1]*o[2]*(3091.96886047550*pi + o[1]*(11.7650487243560 + o[2]*(-13551.3342407750
                  *o[5] + o[2]*(-62.459855192507*o[3]*o[4]*pi + o[2]*(o[4]*(
                  235988.325565140 + 7399.9835474766*pi) + o[1]*(19127.7292396600*o[3]
                  *o[4] + o[1]*(o[3]*(1.28127984040460e8 - 551966.97030060*o[5]) + o[
                  1]*(-9.8554909623276e8*o[3] + o[1]*(2.82245469730020e9*o[3] + o[1]*
                  (o[3]*(-3.5948971410703e9 + 3.7154085996233e6*o[5]) + o[1]*pi*(
                  252266.403578720 + pi*(1.72273499131970e9 + pi*(1.28487346646500e7
                   + (-1.31052365450540e7 - 415351.64835634*o[3])*pi))))))))))))))))))));
              elseif (pi < (0.12809002730136e-03*etabc - 0.67955786399241)*etabc +
                  0.90584278514723e3) then
                eta2b := eta - 2.6;
                pi2b := pi - 2.0;
                o[1] := pi2b*pi2b;
                o[2] := o[1]*pi2b;
                o[3] := o[1]*o[1];
                o[4] := eta2b*eta2b;
                o[5] := o[4]*o[4];
                o[6] := o[4]*o[5];
                o[7] := o[5]*o[5];
                T := 1489.50410795160 + 0.93747147377932*pi2b + eta2b*(
                  743.07798314034 + o[2]*(0.000110328317899990 - 1.75652339694070e-18
                  *o[1]*o[3]) + eta2b*(-97.708318797837 + pi2b*(3.3593118604916 +
                  pi2b*(-0.0218107553247610 + pi2b*(0.000189552483879020 + (
                  2.86402374774560e-7 - 8.1456365207833e-14*o[2])*pi2b))) + o[5]*(
                  3.3809355601454*pi2b + o[4]*(-0.108297844036770*o[1] + o[5]*(
                  2.47424647056740 + (0.168445396719040 + o[1]*(0.00308915411605370
                   - 0.0000107798573575120*pi2b))*pi2b + o[6]*(-0.63281320016026 +
                  pi2b*(0.73875745236695 + (-0.046333324635812 + o[1]*(-0.000076462712454814
                   + 2.82172816350400e-7*pi2b))*pi2b) + o[6]*(1.13859521296580 + pi2b
                  *(-0.47128737436186 + o[1]*(0.00135555045549490 + (
                  0.0000140523928183160 + 1.27049022719450e-6*pi2b)*pi2b)) + o[5]*(-0.47811863648625
                   + (0.150202731397070 + o[2]*(-0.0000310838143314340 + o[1]*(-1.10301392389090e-8
                   - 2.51805456829620e-11*pi2b)))*pi2b + o[5]*o[7]*(
                  0.0085208123431544 + pi2b*(-0.00217641142197500 + pi2b*(
                  0.000071280351959551 + o[1]*(-1.03027382121030e-6 + (
                  7.3803353468292e-8 + 8.6934156344163e-15*o[3])*pi2b))))))))))));
              else
                eta2c := eta - 1.8;
                pi2c := pi + 25.0;
                o[1] := pi2c*pi2c;
                o[2] := o[1]*o[1];
                o[3] := o[1]*o[2]*pi2c;
                o[4] := 1/o[3];
                o[5] := o[1]*o[2];
                o[6] := eta2c*eta2c;
                o[7] := o[2]*o[2];
                o[8] := o[6]*o[6];
                T := eta2c*((859777.22535580 + o[1]*(482.19755109255 +
                  1.12615974072300e-12*o[5]))/o[1] + eta2c*((-5.8340131851590e11 + (
                  2.08255445631710e10 + 31081.0884227140*o[2])*pi2c)/o[5] + o[6]*(o[8]
                  *(o[6]*(1.23245796908320e-7*o[5] + o[6]*(-1.16069211309840e-6*o[5]
                   + o[8]*(0.0000278463670885540*o[5] + (-0.00059270038474176*o[5] +
                  0.00129185829918780*o[5]*o[6])*o[8]))) - 10.8429848800770*pi2c) + o[
                  4]*(7.3263350902181e12 + o[7]*(3.7966001272486 + (-0.045364172676660
                   - 1.78049822406860e-11*o[2])*pi2c))))) + o[4]*(-3.2368398555242e12
                   + pi2c*(3.5825089945447e11 + pi2c*(-1.07830682174700e10 + o[1]*
                  pi2c*(610747.83564516 + pi2c*(-25745.7236041700 + (1208.23158659360
                   + 1.45591156586980e-13*o[5])*pi2c)))));
              end if;
            end tph2;

            function tps2a "Reverse function for region 2a: T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temperature T "Temperature (K)";
            protected
              Real[12] o "Vector of auxiliary variables";
              constant Real IPSTAR=1.0e-6 "Scaling variable";
              constant Real ISSTAR2A=1/2000.0 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2a "Dimensionless specific entropy";
            algorithm
              pi := p*IPSTAR;
              sigma2a := s*ISSTAR2A - 2.0;
              o[1] := pi^0.5;
              o[2] := sigma2a*sigma2a;
              o[3] := o[2]*o[2];
              o[4] := o[3]*o[3];
              o[5] := o[4]*o[4];
              o[6] := pi^0.25;
              o[7] := o[2]*o[4]*o[5];
              o[8] := 1/o[7];
              o[9] := o[3]*sigma2a;
              o[10] := o[2]*o[3]*sigma2a;
              o[11] := o[3]*o[4]*sigma2a;
              o[12] := o[2]*sigma2a;
              T := ((-392359.83861984 + (515265.73827270 + o[3]*(40482.443161048 + o[
                2]*o[3]*(-321.93790923902 + o[2]*(96.961424218694 - 22.8678463717730*
                sigma2a))))*sigma2a)/(o[4]*o[5]) + o[6]*((-449429.14124357 + o[3]*(-5011.8336020166
                 + 0.35684463560015*o[4]*sigma2a))/(o[2]*o[5]*sigma2a) + o[6]*(o[8]*(
                44235.335848190 + o[9]*(-13673.3888117080 + o[3]*(421632.60207864 + (
                22516.9258374750 + o[10]*(474.42144865646 - 149.311307976470*sigma2a))
                *sigma2a))) + o[6]*((-197811.263204520 - 23554.3994707600*sigma2a)/(o[
                2]*o[3]*o[4]*sigma2a) + o[6]*((-19070.6163020760 + o[11]*(
                55375.669883164 + (3829.3691437363 - 603.91860580567*o[2])*o[3]))*o[8]
                 + o[6]*((1936.31026203310 + o[2]*(4266.0643698610 + o[2]*o[3]*o[4]*(
                -5978.0638872718 - 704.01463926862*o[9])))/(o[2]*o[4]*o[5]*sigma2a)
                 + o[1]*((338.36784107553 + o[12]*(20.8627866351870 + (
                0.033834172656196 - 0.000043124428414893*o[12])*o[3]))*sigma2a + o[6]
                *(166.537913564120 + sigma2a*(-139.862920558980 + o[3]*(-0.78849547999872
                 + (0.072132411753872 + o[3]*(-0.0059754839398283 + (-0.0000121413589539040
                 + 2.32270967338710e-7*o[2])*o[3]))*sigma2a)) + o[6]*(-10.5384635661940
                 + o[3]*(2.07189254965020 + (-0.072193155260427 + 2.07498870811200e-7
                *o[4])*o[9]) + o[6]*(o[6]*(o[12]*(0.210375278936190 +
                0.000256812397299990*o[3]*o[4]) + (-0.0127990029337810 -
                8.2198102652018e-6*o[11])*o[6]*o[9]) + o[10]*(-0.0183406579113790 +
                2.90362723486960e-7*o[2]*o[4]*sigma2a)))))))))))/(o[1]*pi);
            end tps2a;

            function tps2b "Reverse function for region 2b: T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temperature T "Temperature (K)";
            protected
              Real[8] o "Vector of auxiliary variables";
              constant Real IPSTAR=1.0e-6 "Scaling variable";
              constant Real ISSTAR2B=1/785.3 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2b "Dimensionless specific entropy";
            algorithm
              pi := p*IPSTAR;
              sigma2b := 10.0 - s*ISSTAR2B;
              o[1] := pi*pi;
              o[2] := o[1]*o[1];
              o[3] := sigma2b*sigma2b;
              o[4] := o[3]*o[3];
              o[5] := o[4]*o[4];
              o[6] := o[3]*o[5]*sigma2b;
              o[7] := o[3]*o[5];
              o[8] := o[3]*sigma2b;
              T := (316876.65083497 + 20.8641758818580*o[6] + pi*(-398593.99803599 -
                21.8160585188770*o[6] + pi*(223697.851942420 + (-2784.17034458170 +
                9.9207436071480*o[7])*sigma2b + pi*(-75197.512299157 + (
                2970.86059511580 + o[7]*(-3.4406878548526 + 0.38815564249115*sigma2b))
                *sigma2b + pi*(17511.2950857500 + sigma2b*(-1423.71128544490 + (
                1.09438033641670 + 0.89971619308495*o[4])*o[4]*sigma2b) + pi*(-3375.9740098958
                 + (471.62885818355 + o[4]*(-1.91882419936790 + o[8]*(
                0.41078580492196 - 0.33465378172097*sigma2b)))*sigma2b + pi*(
                1387.00347775050 + sigma2b*(-406.63326195838 + sigma2b*(
                41.727347159610 + o[3]*(2.19325494345320 + sigma2b*(-1.03200500090770
                 + (0.35882943516703 + 0.0052511453726066*o[8])*sigma2b)))) + pi*(
                12.8389164507050 + sigma2b*(-2.86424372193810 + sigma2b*(
                0.56912683664855 + (-0.099962954584931 + o[4]*(-0.0032632037778459 +
                0.000233209225767230*sigma2b))*sigma2b)) + pi*(-0.153348098574500 + (
                0.0290722882399020 + 0.00037534702741167*o[4])*sigma2b + pi*(
                0.00172966917024110 + (-0.00038556050844504 - 0.000035017712292608*o[
                3])*sigma2b + pi*(-0.0000145663936314920 + 5.6420857267269e-6*sigma2b
                 + pi*(4.1286150074605e-8 + (-2.06846711188240e-8 +
                1.64093936747250e-9*sigma2b)*sigma2b))))))))))))/(o[1]*o[2]);
            end tps2b;

            function tps2c "Reverse function for region 2c: T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temperature T "Temperature (K)";
            protected
              constant Real IPSTAR=1.0e-6 "Scaling variable";
              constant Real ISSTAR2C=1/2925.1 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2c "Dimensionless specific entropy";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi := p*IPSTAR;
              sigma2c := 2.0 - s*ISSTAR2C;
              o[1] := pi*pi;
              o[2] := sigma2c*sigma2c;
              o[3] := o[2]*o[2];
              T := (909.68501005365 + 2404.56670884200*sigma2c + pi*(-591.62326387130
                 + pi*(541.45404128074 + sigma2c*(-270.983084111920 + (
                979.76525097926 - 469.66772959435*sigma2c)*sigma2c) + pi*(
                14.3992746047230 + (-19.1042042304290 + o[2]*(5.3299167111971 -
                21.2529753759340*sigma2c))*sigma2c + pi*(-0.311473344137600 + (
                0.60334840894623 - 0.042764839702509*sigma2c)*sigma2c + pi*(
                0.0058185597255259 + (-0.0145970082847530 + 0.0056631175631027*o[3])*
                sigma2c + pi*(-0.000076155864584577 + sigma2c*(0.000224403429193320
                 - 0.0000125610950134130*o[2]*sigma2c) + pi*(6.3323132660934e-7 + (-2.05419896753750e-6
                 + 3.6405370390082e-8*sigma2c)*sigma2c + pi*(-2.97598977892150e-9 +
                1.01366185297630e-8*sigma2c + pi*(5.9925719692351e-12 + sigma2c*(-2.06778701051640e-11
                 + o[2]*(-2.08742781818860e-11 + (1.01621668250890e-10 -
                1.64298282813470e-10*sigma2c)*sigma2c))))))))))))/o[1];
            end tps2c;

            function tps2 "Reverse function for region 2: T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              constant SI.SpecificEntropy SLIMIT=5.85e3
                "Subregion boundary specific entropy between regions 2a and 2b";
            algorithm
              if p < 4.0e6 then
                T := tps2a(p, s);
              elseif s > SLIMIT then
                T := tps2b(p, s);
              else
                T := tps2c(p, s);
              end if;
            end tps2;

            function tsat
              "Region 4 saturation temperature as a function of pressure"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Temperature t_sat "Temperature";
            protected
              Real pi "Dimensionless pressure";
              Real[20] o "Vector of auxiliary variables";
            algorithm
              assert(p > triple.ptriple,
                "IF97 medium function tsat called with too low pressure\n" + "p = "
                 + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              //  assert(p <= data.PCRIT,
              //    "tsat: input pressure is higher than the critical point pressure");
              pi := min(p, data.PCRIT)*data.IPSTAR;
              o[1] := pi^0.25;
              o[2] := -3.2325550322333e6*o[1];
              o[3] := pi^0.5;
              o[4] := -724213.16703206*o[3];
              o[5] := 405113.40542057 + o[2] + o[4];
              o[6] := -17.0738469400920*o[1];
              o[7] := 14.9151086135300 + o[3] + o[6];
              o[8] := -4.0*o[5]*o[7];
              o[9] := 12020.8247024700*o[1];
              o[10] := 1167.05214527670*o[3];
              o[11] := -4823.2657361591 + o[10] + o[9];
              o[12] := o[11]*o[11];
              o[13] := o[12] + o[8];
              o[14] := o[13]^0.5;
              o[15] := -o[14];
              o[16] := -12020.8247024700*o[1];
              o[17] := -1167.05214527670*o[3];
              o[18] := 4823.2657361591 + o[15] + o[16] + o[17];
              o[19] := 1/o[18];
              o[20] := 2.0*o[19]*o[5];

              t_sat := 0.5*(650.17534844798 + o[20] - (-4.0*(-0.238555575678490 +
                1300.35069689596*o[19]*o[5]) + (650.17534844798 + o[20])^2.0)^0.5);
              annotation (derivative=tsat_der);
            end tsat;

            function dtsatofp
              "Derivative of saturation temperature w.r.t. pressure"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output Real dtsat(unit="K/Pa") "Derivative of T w.r.t. p";
            protected
              Real pi "Dimensionless pressure";
              Real[49] o "Vector of auxiliary variables";
            algorithm
              pi := max(Modelica.Constants.small, p*data.IPSTAR);
              o[1] := pi^0.75;
              o[2] := 1/o[1];
              o[3] := -4.268461735023*o[2];
              o[4] := sqrt(pi);
              o[5] := 1/o[4];
              o[6] := 0.5*o[5];
              o[7] := o[3] + o[6];
              o[8] := pi^0.25;
              o[9] := -3.2325550322333e6*o[8];
              o[10] := -724213.16703206*o[4];
              o[11] := 405113.40542057 + o[10] + o[9];
              o[12] := -4*o[11]*o[7];
              o[13] := -808138.758058325*o[2];
              o[14] := -362106.58351603*o[5];
              o[15] := o[13] + o[14];
              o[16] := -17.073846940092*o[8];
              o[17] := 14.91510861353 + o[16] + o[4];
              o[18] := -4*o[15]*o[17];
              o[19] := 3005.2061756175*o[2];
              o[20] := 583.52607263835*o[5];
              o[21] := o[19] + o[20];
              o[22] := 12020.82470247*o[8];
              o[23] := 1167.0521452767*o[4];
              o[24] := -4823.2657361591 + o[22] + o[23];
              o[25] := 2.0*o[21]*o[24];
              o[26] := o[12] + o[18] + o[25];
              o[27] := -4.0*o[11]*o[17];
              o[28] := o[24]*o[24];
              o[29] := o[27] + o[28];
              o[30] := sqrt(o[29]);
              o[31] := 1/o[30];
              o[32] := (-o[30]);
              o[33] := -12020.82470247*o[8];
              o[34] := -1167.0521452767*o[4];
              o[35] := 4823.2657361591 + o[32] + o[33] + o[34];
              o[36] := o[30];
              o[37] := -4823.2657361591 + o[22] + o[23] + o[36];
              o[38] := o[37]*o[37];
              o[39] := 1/o[38];
              o[40] := -1.72207339365771*o[30];
              o[41] := 21592.2055343628*o[8];
              o[42] := o[30]*o[8];
              o[43] := -8192.87114842946*o[4];
              o[44] := -0.510632954559659*o[30]*o[4];
              o[45] := -3100.02526152368*o[1];
              o[46] := pi;
              o[47] := 1295.95640782102*o[46];
              o[48] := 2862.09212505088 + o[40] + o[41] + o[42] + o[43] + o[44] + o[
                45] + o[47];
              o[49] := 1/(o[35]*o[35]);
              dtsat := data.IPSTAR*0.5*((2.0*o[15])/o[35] - 2.*o[11]*(-3005.2061756175
                *o[2] - 0.5*o[26]*o[31] - 583.52607263835*o[5])*o[49] - (
                20953.46356643991*(o[39]*(1295.95640782102 + 5398.05138359071*o[2] +
                0.25*o[2]*o[30] - 0.861036696828853*o[26]*o[31] - 0.255316477279829*o[
                26]*o[31]*o[4] - 4096.43557421473*o[5] - 0.255316477279829*o[30]*o[5]
                 - 2325.01894614276/o[8] + 0.5*o[26]*o[31]*o[8]) - 2.0*(o[19] + o[20]
                 + 0.5*o[26]*o[31])*o[48]*o[37]^(-3)))/sqrt(o[39]*o[48]));
            end dtsatofp;

            function tsat_der "Derivative function for tsat"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input Real der_p(unit="Pa/s") "Pressure derivative";
              output Real der_tsat(unit="K/s") "Temperature derivative";
            protected
              Real dtp;
            algorithm
              dtp := dtsatofp(p);
              der_tsat := dtp*der_p;
            end tsat_der;

            function psat
              "Region 4 saturation pressure as a function of temperature"

              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature (K)";
              output SI.Pressure p_sat "Pressure";
            protected
              Real[8] o "Vector of auxiliary variables";
              Real Tlim=min(T, data.TCRIT);
            algorithm
              assert(T >= 273.16, "IF97 medium function psat: input temperature (= "
                 + String(triple.ptriple) + " K).\n" +
                "lower than the triple point temperature 273.16 K");
              o[1] := -650.17534844798 + Tlim;
              o[2] := 1/o[1];
              o[3] := -0.238555575678490*o[2];
              o[4] := o[3] + Tlim;
              o[5] := -4823.2657361591*o[4];
              o[6] := o[4]*o[4];
              o[7] := 14.9151086135300*o[6];
              o[8] := 405113.40542057 + o[5] + o[7];
              p_sat := 16.0e6*o[8]*o[8]*o[8]*o[8]*1/(3.2325550322333e6 -
                12020.8247024700*o[4] + 17.0738469400920*o[6] + (-4.0*(-724213.16703206
                 + 1167.05214527670*o[4] + o[6])*o[8] + (-3.2325550322333e6 +
                12020.8247024700*o[4] - 17.0738469400920*o[6])^2.0)^0.5)^4.0;
              annotation (derivative=psat_der);
            end psat;

            function dptofT
              "Derivative of pressure w.r.t. temperature along the saturation pressure curve"

              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature (K)";
              output Real dpt(unit="Pa/K") "Temperature derivative of pressure";
            protected
              Real[31] o "Vector of auxiliary variables";
              Real Tlim "Temperature limited to TCRIT";
            algorithm
              Tlim := min(T, data.TCRIT);
              o[1] := -650.17534844798 + Tlim;
              o[2] := 1/o[1];
              o[3] := -0.238555575678490*o[2];
              o[4] := o[3] + Tlim;
              o[5] := -4823.2657361591*o[4];
              o[6] := o[4]*o[4];
              o[7] := 14.9151086135300*o[6];
              o[8] := 405113.40542057 + o[5] + o[7];
              o[9] := o[8]*o[8];
              o[10] := o[9]*o[9];
              o[11] := o[1]*o[1];
              o[12] := 1/o[11];
              o[13] := 0.238555575678490*o[12];
              o[14] := 1.00000000000000 + o[13];
              o[15] := 12020.8247024700*o[4];
              o[16] := -17.0738469400920*o[6];
              o[17] := -3.2325550322333e6 + o[15] + o[16];
              o[18] := -4823.2657361591*o[14];
              o[19] := 29.8302172270600*o[14]*o[4];
              o[20] := o[18] + o[19];
              o[21] := 1167.05214527670*o[4];
              o[22] := -724213.16703206 + o[21] + o[6];
              o[23] := o[17]*o[17];
              o[24] := -4.0000000000000*o[22]*o[8];
              o[25] := o[23] + o[24];
              o[26] := sqrt(o[25]);
              o[27] := -12020.8247024700*o[4];
              o[28] := 17.0738469400920*o[6];
              o[29] := 3.2325550322333e6 + o[26] + o[27] + o[28];
              o[30] := o[29]*o[29];
              o[31] := o[30]*o[30];
              dpt := 1e6*((-64.0*o[10]*(-12020.8247024700*o[14] + 34.147693880184*o[
                14]*o[4] + (0.5*(-4.0*o[20]*o[22] + 2.00000000000000*o[17]*(
                12020.8247024700*o[14] - 34.147693880184*o[14]*o[4]) - 4.0*(
                1167.05214527670*o[14] + 2.0*o[14]*o[4])*o[8]))/o[26]))/(o[29]*o[31])
                 + (64.*o[20]*o[8]*o[9])/o[31]);
            end dptofT;

            function psat_der "Derivative function for psat"
              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature (K)";
              input Real der_T(unit="K/s") "Temperature derivative";
              output Real der_psat(unit="Pa/s") "Pressure";
            protected
              Real dpt;
            algorithm
              dpt := dptofT(T);
              der_psat := dpt*der_T;
            end psat_der;

            function h3ab_p "Region 3 a b boundary for pressure/enthalpy"
              extends Modelica.Icons.Function;
              output SI.SpecificEnthalpy h "Enthalpy";
              input SI.Pressure p "Pressure";
            protected
              constant Real[:] n={0.201464004206875e4,0.374696550136983e1,-0.219921901054187e-1,
                  0.875131686009950e-4};
              constant SI.SpecificEnthalpy hstar=1000 "Normalization enthalpy";
              constant SI.Pressure pstar=1e6 "Normalization pressure";
              Real pi=p/pstar "Normalized specific pressure";

            algorithm
              h := (n[1] + n[2]*pi + n[3]*pi^2 + n[4]*pi^3)*hstar;
              annotation (Documentation(info="<html>
      <p>
      &nbsp;Equation number 1 from:
      </p>
      <div style=\"text-align: center;\">&nbsp;[1] The international Association
      for the Properties of Water and Steam<br>
      &nbsp;Vejle, Denmark<br>
      &nbsp;August 2003<br>
      &nbsp;Supplementary Release on Backward Equations for the Functions
      T(p,h), v(p,h) and T(p,s), <br>
      &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
      the Thermodynamic Properties of<br>
      &nbsp;Water and Steam</div>
      </html>"));
            end h3ab_p;

            function T3a_ph "Region 3 a: inverse function T(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.Temp_K T "Temperature";
            protected
              constant Real[:] n={-0.133645667811215e-6,0.455912656802978e-5,-0.146294640700979e-4,
                  0.639341312970080e-2,0.372783927268847e3,-0.718654377460447e4,
                  0.573494752103400e6,-0.267569329111439e7,-0.334066283302614e-4,-0.245479214069597e-1,
                  0.478087847764996e2,0.764664131818904e-5,0.128350627676972e-2,
                  0.171219081377331e-1,-0.851007304583213e1,-0.136513461629781e-1,-0.384460997596657e-5,
                  0.337423807911655e-2,-0.551624873066791,0.729202277107470,-0.992522757376041e-2,
                  -0.119308831407288,0.793929190615421,0.454270731799386,
                  0.209998591259910,-0.642109823904738e-2,-0.235155868604540e-1,
                  0.252233108341612e-2,-0.764885133368119e-2,0.136176427574291e-1,-0.133027883575669e-1};
              constant Real[:] I={-12,-12,-12,-12,-12,-12,-12,-12,-10,-10,-10,-8,-8,-8,
                  -8,-5,-3,-2,-2,-2,-1,-1,0,0,1,3,3,4,4,10,12};
              constant Real[:] J={0,1,2,6,14,16,20,22,1,5,12,0,2,4,10,2,0,1,3,4,0,2,0,
                  1,1,0,1,0,3,4,5};
              constant SI.SpecificEnthalpy hstar=2300e3
                "Normalization enthalpy";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.Temp_K Tstar=760 "Normalization temperature";
              Real pi=p/pstar "Normalized specific pressure";
              Real eta=h/hstar "Normalized specific enthalpy";
            algorithm
              T := sum(n[i]*(pi + 0.240)^I[i]*(eta - 0.615)^J[i] for i in 1:31)*Tstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 2 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
 </html>"));
            end T3a_ph;

            function T3b_ph "Region 3 b: inverse function T(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.Temp_K T "Temperature";
            protected
              constant Real[:] n={0.323254573644920e-4,-0.127575556587181e-3,-0.475851877356068e-3,
                  0.156183014181602e-2,0.105724860113781,-0.858514221132534e2,
                  0.724140095480911e3,0.296475810273257e-2,-0.592721983365988e-2,-0.126305422818666e-1,
                  -0.115716196364853,0.849000969739595e2,-0.108602260086615e-1,
                  0.154304475328851e-1,0.750455441524466e-1,0.252520973612982e-1,-0.602507901232996e-1,
                  -0.307622221350501e1,-0.574011959864879e-1,0.503471360939849e1,-0.925081888584834,
                  0.391733882917546e1,-0.773146007130190e2,0.949308762098587e4,-0.141043719679409e7,
                  0.849166230819026e7,0.861095729446704,0.323346442811720,
                  0.873281936020439,-0.436653048526683,0.286596714529479,-0.131778331276228,
                  0.676682064330275e-2};
              constant Real[:] I={-12,-12,-10,-10,-10,-10,-10,-8,-8,-8,-8,-8,-6,-6,-6,
                  -4,-4,-3,-2,-2,-1,-1,-1,-1,-1,-1,0,0,1,3,5,6,8};
              constant Real[:] J={0,1,0,1,5,10,12,0,1,2,4,10,0,1,2,0,1,5,0,4,2,4,6,10,
                  14,16,0,2,1,1,1,1,1};
              constant SI.Temp_K Tstar=860 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEnthalpy hstar=2800e3
                "Normalization enthalpy";
              Real pi=p/pstar "Normalized specific pressure";
              Real eta=h/hstar "Normalized specific enthalpy";
            algorithm
              T := sum(n[i]*(pi + 0.298)^I[i]*(eta - 0.720)^J[i] for i in 1:33)*Tstar;
              annotation (Documentation(info="<html>
 <p>
 &nbsp;Equation number 3 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
 </html>"));
            end T3b_ph;

            function v3a_ph "Region 3 a: inverse function v(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n={0.529944062966028e-2,-0.170099690234461,
                  0.111323814312927e2,-0.217898123145125e4,-0.506061827980875e-3,
                  0.556495239685324,-0.943672726094016e1,-0.297856807561527,
                  0.939353943717186e2,0.192944939465981e-1,0.421740664704763,-0.368914126282330e7,
                  -0.737566847600639e-2,-0.354753242424366,-0.199768169338727e1,
                  0.115456297059049e1,0.568366875815960e4,0.808169540124668e-2,
                  0.172416341519307,0.104270175292927e1,-0.297691372792847,
                  0.560394465163593,0.275234661176914,-0.148347894866012,-0.651142513478515e-1,
                  -0.292468715386302e1,0.664876096952665e-1,0.352335014263844e1,-0.146340792313332e-1,
                  -0.224503486668184e1,0.110533464706142e1,-0.408757344495612e-1};
              constant Real[:] I={-12,-12,-12,-12,-10,-10,-10,-8,-8,-6,-6,-6,-4,-4,-3,
                  -2,-2,-1,-1,-1,-1,0,0,1,1,1,2,2,3,4,5,8};
              constant Real[:] J={6,8,12,18,4,7,10,5,12,3,4,22,2,3,7,3,16,0,1,2,3,0,1,
                  0,1,2,0,2,0,2,2,2};
              constant SI.Volume vstar=0.0028 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEnthalpy hstar=2100e3
                "Normalization enthalpy";
              Real pi=p/pstar "Normalized specific pressure";
              Real eta=h/hstar "Normalized specific enthalpy";
            algorithm
              v := sum(n[i]*(pi + 0.128)^I[i]*(eta - 0.727)^J[i] for i in 1:32)*vstar;
              annotation (Documentation(info="<html>
<p>
&nbsp;Equation number 4 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
 </html>"));
            end v3a_ph;

            function v3b_ph "Region 3 b: inverse function v(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n={-0.225196934336318e-8,0.140674363313486e-7,
                  0.233784085280560e-5,-0.331833715229001e-4,0.107956778514318e-2,-0.271382067378863,
                  0.107202262490333e1,-0.853821329075382,-0.215214194340526e-4,
                  0.769656088222730e-3,-0.431136580433864e-2,0.453342167309331,-0.507749535873652,
                  -0.100475154528389e3,-0.219201924648793,-0.321087965668917e1,
                  0.607567815637771e3,0.557686450685932e-3,0.187499040029550,
                  0.905368030448107e-2,0.285417173048685,0.329924030996098e-1,
                  0.239897419685483,0.482754995951394e1,-0.118035753702231e2,
                  0.169490044091791,-0.179967222507787e-1,0.371810116332674e-1,-0.536288335065096e-1,
                  0.160697101092520e1};
              constant Real[:] I={-12,-12,-8,-8,-8,-8,-8,-8,-6,-6,-6,-6,-6,-6,-4,-4,-4,
                  -3,-3,-2,-2,-1,-1,-1,-1,0,1,1,2,2};
              constant Real[:] J={0,1,0,1,3,6,7,8,0,1,2,5,6,10,3,6,10,0,2,1,2,0,1,4,5,
                  0,0,1,2,6};
              constant SI.Volume vstar=0.0088 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEnthalpy hstar=2800e3
                "Normalization enthalpy";
              Real pi=p/pstar "Normalized specific pressure";
              Real eta=h/hstar "Normalized specific enthalpy";
            algorithm
              v := sum(n[i]*(pi + 0.0661)^I[i]*(eta - 0.720)^J[i] for i in 1:30)*
                vstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 5 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
 </html>"));
            end v3b_ph;

            function T3a_ps "Region 3 a: inverse function T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temp_K T "Temperature";
            protected
              constant Real[:] n={0.150042008263875e10,-0.159397258480424e12,
                  0.502181140217975e-3,-0.672057767855466e2,0.145058545404456e4,-0.823889534888890e4,
                  -0.154852214233853,0.112305046746695e2,-0.297000213482822e2,
                  0.438565132635495e11,0.137837838635464e-2,-0.297478527157462e1,
                  0.971777947349413e13,-0.571527767052398e-4,0.288307949778420e5,-0.744428289262703e14,
                  0.128017324848921e2,-0.368275545889071e3,0.664768904779177e16,
                  0.449359251958880e-1,-0.422897836099655e1,-0.240614376434179,-0.474341365254924e1,
                  0.724093999126110,0.923874349695897,0.399043655281015e1,
                  0.384066651868009e-1,-0.359344365571848e-2,-0.735196448821653,
                  0.188367048396131,0.141064266818704e-3,-0.257418501496337e-2,
                  0.123220024851555e-2};
              constant Real[:] I={-12,-12,-10,-10,-10,-10,-8,-8,-8,-8,-6,-6,-6,-5,-5,
                  -5,-4,-4,-4,-2,-2,-1,-1,0,0,0,1,2,2,3,8,8,10};
              constant Real[:] J={28,32,4,10,12,14,5,7,8,28,2,6,32,0,14,32,6,10,36,1,
                  4,1,6,0,1,4,0,0,3,2,0,1,2};
              constant SI.Temp_K Tstar=760 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEntropy sstar=4.4e3 "Normalization entropy";
              Real pi=p/pstar "Normalized specific pressure";
              Real sigma=s/sstar "Normalized specific entropy";
            algorithm
              T := sum(n[i]*(pi + 0.240)^I[i]*(sigma - 0.703)^J[i] for i in 1:33)*
                Tstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 6 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
 </html>"));
            end T3a_ps;

            function T3b_ps "Region 3 b: inverse function T(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.Temp_K T "Temperature";
            protected
              constant Real[:] n={0.527111701601660,-0.401317830052742e2,
                  0.153020073134484e3,-0.224799398218827e4,-0.193993484669048,-0.140467557893768e1,
                  0.426799878114024e2,0.752810643416743,0.226657238616417e2,-0.622873556909932e3,
                  -0.660823667935396,0.841267087271658,-0.253717501764397e2,
                  0.485708963532948e3,0.880531517490555e3,0.265015592794626e7,-0.359287150025783,
                  -0.656991567673753e3,0.241768149185367e1,0.856873461222588,
                  0.655143675313458,-0.213535213206406,0.562974957606348e-2,-0.316955725450471e15,
                  -0.699997000152457e-3,0.119845803210767e-1,0.193848122022095e-4,-0.215095749182309e-4};
              constant Real[:] I={-12,-12,-12,-12,-8,-8,-8,-6,-6,-6,-5,-5,-5,-5,-5,-4,
                  -3,-3,-2,0,2,3,4,5,6,8,12,14};
              constant Real[:] J={1,3,4,7,0,1,3,0,2,4,0,1,2,4,6,12,1,6,2,0,1,1,0,24,0,
                  3,1,2};
              constant SI.Temp_K Tstar=860 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEntropy sstar=5.3e3 "Normalization entropy";
              Real pi=p/pstar "Normalized specific pressure";
              Real sigma=s/sstar "Normalized specific entropy";
            algorithm
              T := sum(n[i]*(pi + 0.760)^I[i]*(sigma - 0.818)^J[i] for i in 1:28)*
                Tstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 7 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</html>"));
            end T3b_ps;

            function v3a_ps "Region 3 a: inverse function v(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n={0.795544074093975e2,-0.238261242984590e4,
                  0.176813100617787e5,-0.110524727080379e-2,-0.153213833655326e2,
                  0.297544599376982e3,-0.350315206871242e8,0.277513761062119,-0.523964271036888,
                  -0.148011182995403e6,0.160014899374266e7,0.170802322663427e13,
                  0.246866996006494e-3,0.165326084797980e1,-0.118008384666987,
                  0.253798642355900e1,0.965127704669424,-0.282172420532826e2,
                  0.203224612353823,0.110648186063513e1,0.526127948451280,
                  0.277000018736321,0.108153340501132e1,-0.744127885357893e-1,
                  0.164094443541384e-1,-0.680468275301065e-1,0.257988576101640e-1,-0.145749861944416e-3};
              constant Real[:] I={-12,-12,-12,-10,-10,-10,-10,-8,-8,-8,-8,-6,-5,-4,-3,
                  -3,-2,-2,-1,-1,0,0,0,1,2,4,5,6};
              constant Real[:] J={10,12,14,4,8,10,20,5,6,14,16,28,1,5,2,4,3,8,1,2,0,1,
                  3,0,0,2,2,0};
              constant SI.Volume vstar=0.0028 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEntropy sstar=4.4e3 "Normalization entropy";
              Real pi=p/pstar "Normalized specific pressure";
              Real sigma=s/sstar "Normalized specific entropy";
            algorithm
              v := sum(n[i]*(pi + 0.187)^I[i]*(sigma - 0.755)^J[i] for i in 1:28)*
                vstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 8 from:
</p>
 <div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</html>"));
            end v3a_ps;

            function v3b_ps "Region 3 b: inverse function v(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              output SI.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n={0.591599780322238e-4,-0.185465997137856e-2,
                  0.104190510480013e-1,0.598647302038590e-2,-0.771391189901699,
                  0.172549765557036e1,-0.467076079846526e-3,0.134533823384439e-1,-0.808094336805495e-1,
                  0.508139374365767,0.128584643361683e-2,-0.163899353915435e1,
                  0.586938199318063e1,-0.292466667918613e1,-0.614076301499537e-2,
                  0.576199014049172e1,-0.121613320606788e2,0.167637540957944e1,-0.744135838773463e1,
                  0.378168091437659e-1,0.401432203027688e1,0.160279837479185e2,
                  0.317848779347728e1,-0.358362310304853e1,-0.115995260446827e7,
                  0.199256573577909,-0.122270624794624,-0.191449143716586e2,-0.150448002905284e-1,
                  0.146407900162154e2,-0.327477787188230e1};
              constant Real[:] I={-12,-12,-12,-12,-12,-12,-10,-10,-10,-10,-8,-5,-5,-5,
                  -4,-4,-4,-4,-3,-2,-2,-2,-2,-2,-2,0,0,0,1,1,2};
              constant Real[:] J={0,1,2,3,5,6,0,1,2,4,0,1,2,3,0,1,2,3,1,0,1,2,3,4,12,
                  0,1,2,0,2,2};
              constant SI.Volume vstar=0.0088 "Normalization temperature";
              constant SI.Pressure pstar=100e6 "Normalization pressure";
              constant SI.SpecificEntropy sstar=5.3e3 "Normalization entropy";
              Real pi=p/pstar "Normalized specific pressure";
              Real sigma=s/sstar "Normalized specific entropy";
            algorithm
              v := sum(n[i]*(pi + 0.298)^I[i]*(sigma - 0.816)^J[i] for i in 1:31)*
                vstar;
              annotation (Documentation(info="<html>
<p>
 &nbsp;Equation number 9 from:
</p>
<div style=\"text-align: center;\">&nbsp;[1] The international Association
 for the Properties of Water and Steam<br>
 &nbsp;Vejle, Denmark<br>
 &nbsp;August 2003<br>
 &nbsp;Supplementary Release on Backward Equations for the Functions
 T(p,h), v(p,h) and T(p,s), <br>
 &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
 the Thermodynamic Properties of<br>
 &nbsp;Water and Steam</div>
</html>"));
            end v3b_ps;
            annotation (Documentation(info="<HTML><h4>Package description</h4>
          <p>Package BaseIF97/Basic computes the the fundamental functions for the 5 regions of the steam tables
          as described in the standards document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. The code of these
          functions has been generated using <b><i>Mathematica</i></b> and the add-on packages \"Format\" and \"Optimize\"
          to generate highly efficient, expression-optimized C-code from a symbolic representation of the thermodynamic
          functions. The C-code has than been transformed into Modelica code. An important feature of this optimization was to
          simultaneously optimize the functions and the directional derivatives because they share many common subexpressions.</p>
          <h4>Package contents</h4>
          <ul>
          <li>Function <b>g1</b> computes the dimensionless Gibbs function for region 1 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2</b> computes the dimensionless Gibbs function  for region 2 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>g2metastable</b> computes the dimensionless Gibbs function for metastable vapour
          (adjacent to region 2 but 2-phase at equilibrium) and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>f3</b> computes the dimensionless Helmholtz function  for region 3 and all derivatives up
          to order 2 w.r.t. delta and tau. Inputs: d and T.</li>
          <li>Function <b>g5</b>computes the dimensionless Gibbs function for region 5 and all derivatives up
          to order 2 w.r.t. pi and tau. Inputs: p and T.</li>
          <li>Function <b>tph1</b> computes the inverse function T(p,h) in region 1.</li>
          <li>Function <b>tph2</b> computes the inverse function T(p,h) in region 2.</li>
          <li>Function <b>tps2a</b> computes the inverse function T(p,s) in region 2a.</li>
          <li>Function <b>tps2b</b> computes the inverse function T(p,s) in region 2b.</li>
          <li>Function <b>tps2c</b> computes the inverse function T(p,s) in region 2c.</li>
          <li>Function <b>tps2</b> computes the inverse function T(p,s) in region 2.</li>
          <li>Function <b>tsat</b> computes the saturation temperature as a function of pressure.</li>
          <li>Function <b>dtsatofp</b> computes the derivative of the saturation temperature w.r.t. pressure as
          a function of pressure.</li>
          <li>Function <b>tsat_der</b> computes the Modelica derivative function of tsat.</li>
          <li>Function <b>psat</b> computes the saturation pressure as a function of temperature.</li>
          <li>Function <b>dptofT</b>  computes the derivative of the saturation pressure w.r.t. temperature as
          a function of temperature.</li>
          <li>Function <b>psat_der</b> computes the Modelica derivative function of psat.</li>
          </ul>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
       <p>
       Equation from:
       </p>
       <div style=\"text-align: center;\">&nbsp;[1] The international Association
       for the Properties of Water and Steam<br>
       &nbsp;Vejle, Denmark<br>
       &nbsp;August 2003<br>
       &nbsp;Supplementary Release on Backward Equations for the Functions
       T(p,h), v(p,h) and T(p,s), <br>
       &nbsp;v(p,s) for Region 3 of the IAPWS Industrial Formulation 1997 for
       the Thermodynamic Properties of<br>
       &nbsp;Water and Steam</div>
       </html>"));
          end Basic;

          package Transport
            "Transport properties for water according to IAPWS/IF97"
            extends Modelica.Icons.Package;

            function visc_dTp
              "Dynamic viscosity eta(d,T,p), industrial formulation"
              extends Modelica.Icons.Function;
              input SI.Density d "Density";
              input SI.Temperature T "Temperature (K)";
              input SI.Pressure p
                "Pressure (only needed for region of validity)";
              input Integer phase=0
                "2 for two-phase, 1 for one-phase, 0 if not known";
              output SI.DynamicViscosity eta "Dynamic viscosity";
            protected
              constant Real n0=1.0 "Viscosity coefficient";
              constant Real n1=0.978197 "Viscosity coefficient";
              constant Real n2=0.579829 "Viscosity coefficient";
              constant Real n3=-0.202354 "Viscosity coefficient";
              constant Real[42] nn=array(
                        0.5132047,
                        0.3205656,
                        0.0,
                        0.0,
                        -0.7782567,
                        0.1885447,
                        0.2151778,
                        0.7317883,
                        1.241044,
                        1.476783,
                        0.0,
                        0.0,
                        -0.2818107,
                        -1.070786,
                        -1.263184,
                        0.0,
                        0.0,
                        0.0,
                        0.1778064,
                        0.460504,
                        0.2340379,
                        -0.4924179,
                        0.0,
                        0.0,
                        -0.0417661,
                        0.0,
                        0.0,
                        0.1600435,
                        0.0,
                        0.0,
                        0.0,
                        -0.01578386,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        -0.003629481,
                        0.0,
                        0.0) "Viscosity coefficients";
              constant SI.Density rhostar=317.763 "Scaling density";
              constant SI.DynamicViscosity etastar=55.071e-6
                "Scaling viscosity";
              constant SI.Temperature tstar=647.226 "Scaling temperature";
              Integer i "Auxiliary variable";
              Integer j "Auxiliary variable";
              Real delta "Dimensionless density";
              Real deltam1 "Dimensionless density";
              Real tau "Dimensionless temperature";
              Real taum1 "Dimensionless temperature";
              Real Psi0 "Auxiliary variable";
              Real Psi1 "Auxiliary variable";
              Real tfun "Auxiliary variable";
              Real rhofun "Auxiliary variable";
              Real Tc=T - 273.15 "Celsius temperature for region check";
              //      Integer region "Region of IF97";
            algorithm
              //      if phase == 0 then
              //        region := BaseIF97.Regions.region_dT(d,T,0);
              //      end if;
              //      if phase == 2 then
              //        region := 4;
              //      end if;
              // assert(phase <> 2, "Viscosity can not be computed for two-phase states");
              delta := d/rhostar;
              assert(d > triple.dvtriple,
                "IF97 medium function visc_dTp for viscosity called with too low density\n"
                 + "d = " + String(d) + " <= " + String(triple.dvtriple) +
                " (triple point density)");
              assert((p <= 500e6 and (Tc >= 0.0 and Tc <= 150)) or (p <= 350e6 and (
                Tc > 150.0 and Tc <= 600)) or (p <= 300e6 and (Tc > 600.0 and Tc <=
                900)),
                "IF97 medium function visc_dTp: viscosity computed outside the range\n"
                 + "of validity of the IF97 formulation: p = " + String(p) +
                " Pa, Tc = " + String(Tc) + " K");
              deltam1 := delta - 1.0;
              tau := tstar/T;
              taum1 := tau - 1.0;
              Psi0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
              Psi1 := 0.0;
              tfun := 1.0;
              for i in 1:6 loop
                if (i <> 1) then
                  tfun := tfun*taum1;
                end if;
                rhofun := 1.;
                for j in 0:6 loop
                  if (j <> 0) then
                    rhofun := rhofun*deltam1;
                  end if;
                  Psi1 := Psi1 + nn[i + j*6]*tfun*rhofun;
                end for;
              end for;
              eta := etastar*Psi0*Modelica.Math.exp(delta*Psi1);
            end visc_dTp;

            function cond_dTp
              "Thermal conductivity lam(d,T,p) (industrial use version) only in one-phase region"
              extends Modelica.Icons.Function;
              input SI.Density d "Density";
              input SI.Temperature T "Temperature (K)";
              input SI.Pressure p "Pressure";
              input Integer phase=0
                "2 for two-phase, 1 for one-phase, 0 if not known";
              input Boolean industrialMethod=true
                "If true, the industrial method is used, otherwise the scientific one";
              output SI.ThermalConductivity lambda "Thermal conductivity";
            protected
              Integer region(min=1, max=5)
                "IF97 region, valid values:1,2,3, and 5";
              constant Real n0=1.0 "Conductivity coefficient";
              constant Real n1=6.978267 "Conductivity coefficient";
              constant Real n2=2.599096 "Conductivity coefficient";
              constant Real n3=-0.998254 "Conductivity coefficient";
              constant Real[30] nn=array(
                        1.3293046,
                        1.7018363,
                        5.2246158,
                        8.7127675,
                        -1.8525999,
                        -0.40452437,
                        -2.2156845,
                        -10.124111,
                        -9.5000611,
                        0.9340469,
                        0.2440949,
                        1.6511057,
                        4.9874687,
                        4.3786606,
                        0.0,
                        0.018660751,
                        -0.76736002,
                        -0.27297694,
                        -0.91783782,
                        0.0,
                        -0.12961068,
                        0.37283344,
                        -0.43083393,
                        0.0,
                        0.0,
                        0.044809953,
                        -0.1120316,
                        0.13333849,
                        0.0,
                        0.0) "Conductivity coefficient";
              constant SI.ThermalConductivity lamstar=0.4945
                "Scaling conductivity";
              constant SI.Density rhostar=317.763 "Scaling density";
              constant SI.Temperature tstar=647.226 "Scaling temperature";
              constant SI.Pressure pstar=22.115e6 "Scaling pressure";
              constant SI.DynamicViscosity etastar=55.071e-6
                "Scaling viscosity";
              Integer i "Auxiliary variable";
              Integer j "Auxiliary variable";
              Real delta "Dimensionless density";
              Real tau "Dimensionless temperature";
              Real deltam1 "Dimensionless density";
              Real taum1 "Dimensionless temperature";
              Real Lam0 "Part of thermal conductivity";
              Real Lam1 "Part of thermal conductivity";
              Real Lam2 "Part of thermal conductivity";
              Real tfun "Auxiliary variable";
              Real rhofun "Auxiliary variable";
              Real dpitau "Auxiliary variable";
              Real ddelpi "Auxiliary variable";
              Real d2 "Auxiliary variable";
              Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              Modelica.Media.Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Real Tc=T - 273.15 "Celsius temperature for region check";
              Real Chi "Symmetrized compressibility";
              // slightly different variables for industrial use
              constant SI.Density rhostar2=317.7 "Reference density";
              constant SI.Temperature Tstar2=647.25 "Reference temperature";
              constant SI.ThermalConductivity lambdastar=1
                "Reference thermal conductivity";
              parameter Real TREL=T/Tstar2 "Relative temperature";
              parameter Real rhoREL=d/rhostar2 "Relative density";
              Real lambdaREL "Relative thermal conductivity";
              Real deltaTREL "Relative temperature increment";
              constant Real[:] C={0.642857,-4.11717,-6.17937,0.00308976,0.0822994,
                  10.0932};
              constant Real[:] dpar={0.0701309,0.0118520,0.00169937,-1.0200};
              constant Real[:] b={-0.397070,0.400302,1.060000};
              constant Real[:] B={-0.171587,2.392190};
              constant Real[:] a={0.0102811,0.0299621,0.0156146,-0.00422464};
              Real Q;
              Real S;
              Real lambdaREL2
                "Function, part of the interpolating equation of the thermal conductivity";
              Real lambdaREL1
                "Function, part of the interpolating equation of the thermal conductivity";
              Real lambdaREL0
                "Function, part of the interpolating equation of the thermal conductivity";
            algorithm
              // region := BaseIF97.Regions.region_dT(d,T,phase);
              // simplified region check, assuming that calling arguments are legal
              //  assert(phase <> 2,
              //   "ThermalConductivity can not be called with 2-phase inputs!");
              assert(d > triple.dvtriple,
                "IF97 medium function cond_dTp called with too low density\n" +
                "d = " + String(d) + " <= " + String(triple.dvtriple) +
                " (triple point density)");
              assert((p <= 100e6 and (Tc >= 0.0 and Tc <= 500)) or (p <= 70e6 and (Tc
                 > 500.0 and Tc <= 650)) or (p <= 40e6 and (Tc > 650.0 and Tc <= 800)),
                "IF97 medium function cond_dTp: thermal conductivity computed outside the range\n"
                 + "of validity of the IF97 formulation: p = " + String(p) +
                " Pa, Tc = " + String(Tc) + " K");
              if industrialMethod == true then
                deltaTREL := abs(TREL - 1) + C[4];
                Q := 2 + C[5]/deltaTREL^(3/5);
                if TREL >= 1 then
                  S := 1/deltaTREL;
                else
                  S := C[6]/deltaTREL^(3/5);
                end if;
                lambdaREL2 := (dpar[1]/TREL^10 + dpar[2])*rhoREL^(9/5)*
                  Modelica.Math.exp(C[1]*(1 - rhoREL^(14/5))) + dpar[3]*S*rhoREL^Q*
                  Modelica.Math.exp((Q/(1 + Q))*(1 - rhoREL^(1 + Q))) + dpar[4]*
                  Modelica.Math.exp(C[2]*TREL^(3/2) + C[3]/rhoREL^5);
                lambdaREL1 := b[1] + b[2]*rhoREL + b[3]*Modelica.Math.exp(B[1]*(
                  rhoREL + B[2])^2);
                lambdaREL0 := TREL^(1/2)*sum(a[i]*TREL^(i - 1) for i in 1:4);
                lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
                lambda := lambdaREL*lambdastar;
              else
                if p < data.PLIMIT4A then
                  //regions are 1 or 2,
                  if d > data.DCRIT then
                    region := 1;
                  else
                    region := 2;
                  end if;
                else
                  //region is 3, or illegal
                  assert(false,
                    "The scientific method works only for temperature up to 623.15 K");
                end if;
                tau := tstar/T;
                delta := d/rhostar;
                deltam1 := delta - 1.0;
                taum1 := tau - 1.0;
                Lam0 := 1/(n0 + (n1 + (n2 + n3*tau)*tau)*tau)/(tau^0.5);
                Lam1 := 0.0;
                tfun := 1.0;
                for i in 1:5 loop
                  if (i <> 1) then
                    tfun := tfun*taum1;
                  end if;
                  rhofun := 1.0;
                  for j in 0:5 loop
                    if (j <> 0) then
                      rhofun := rhofun*deltam1;
                    end if;
                    Lam1 := Lam1 + nn[i + j*5]*tfun*rhofun;
                  end for;
                end for;
                if (region == 1) then
                  g := Basic.g1(p, T);
                  // dp/dT @ cont d = -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
                  dpitau := -tstar/pstar*(data.PSTAR1*(g.gpi - data.TSTAR1/T*g.gtaupi)
                    /g.gpipi/T);
                  ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR1/data.PSTAR1*T*d*d*g.gpipi;
                  Chi := delta*ddelpi;
                elseif (region == 2) then
                  g := Basic.g2(p, T);
                  dpitau := -tstar/pstar*(data.PSTAR2*(g.gpi - data.TSTAR2/T*g.gtaupi)
                    /g.gpipi/T);
                  ddelpi := -pstar/rhostar*data.RH2O/data.PSTAR2/data.PSTAR2*T*d*d*g.gpipi;
                  Chi := delta*ddelpi;
                  //         elseif (region == 3) then
                  //           f := Basic.f3(T, d);
                  //            dpitau := tstar/pstar*(f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau));
                  //           ddelpi := pstar*d*d/(rhostar*p*p)/(f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta));
                  //    Chi := delta*ddelpi;
                else
                  assert(false,
                    "Thermal conductivity can only be called in the one-phase regions below 623.15 K\n"
                     + "(p = " + String(p) + " Pa, T = " + String(T) +
                    " K, region = " + String(region) + ")");
                end if;
                taum1 := 1/tau - 1;
                d2 := deltam1*deltam1;
                Lam2 := 0.0013848*etastar/visc_dTp(
                        d,
                        T,
                        p)/(tau*tau*delta*delta)*dpitau*dpitau*max(Chi, Modelica.Constants.small)
                  ^0.4678*(delta)^0.5*Modelica.Math.exp(-18.66*taum1*taum1 - d2*d2);
                lambda := lamstar*(Lam0*Modelica.Math.exp(delta*Lam1) + Lam2);
              end if;
            end cond_dTp;

            function surfaceTension
              "Surface tension in region 4 between steam and water"
              extends Modelica.Icons.Function;
              input SI.Temperature T "Temperature (K)";
              output SI.SurfaceTension sigma "Surface tension in SI units";
            protected
              Real Theta "Dimensionless temperature";
            algorithm
              Theta := min(1.0, T/data.TCRIT);
              sigma := 235.8e-3*(1 - Theta)^1.256*(1 - 0.625*(1 - Theta));
            end surfaceTension;
            annotation (Documentation(info="<HTML><h4>Package description</h4>
          <h4>Package contents</h4>
          <ul>
          <li>Function <b>visc_dTp</b> implements a function to compute the industrial formulation of the
          dynamic viscosity of water as a function of density and temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a>.</li>
          <li>Function <b>cond_dTp</b> implements a function to compute  the industrial formulation of the thermal conductivity of water as
          a function of density, temperature and pressure. <b>Important note</b>: Obviously only two of the three
          inputs are really needed, but using three inputs speeds up the computation and the three variables are known in most models anyways.
          The inputs d,T and p have to be consistent.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a>.</li>
          <li>Function <b>surfaceTension</b> implements a function to compute the surface tension between vapour
          and liquid water as a function of temperature.
          The details are described in the document <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a>.</li>
          </ul>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>October, 2002</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Authors: Hubertus Tummescheit and Jonas Eborn<br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: October 2002</li>
          </ul>
          </html>"));
          end Transport;

          package Isentropic
            "Functions for calculating the isentropic enthalpy from pressure p and specific entropy s"
            extends Modelica.Icons.Package;

            function hofpT1
              "Intermediate function for isentropic specific enthalpy in region 1"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real[13] o "Vector of auxiliary variables";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
            algorithm
              tau := data.TSTAR1/T;
              pi1 := 7.1 - p/data.PSTAR1;
              assert(p > triple.ptriple,
                "IF97 medium function hofpT1 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              tau1 := -1.222 + tau;
              o[1] := tau1*tau1;
              o[2] := o[1]*tau1;
              o[3] := o[1]*o[1];
              o[4] := o[3]*o[3];
              o[5] := o[1]*o[4];
              o[6] := o[1]*o[3];
              o[7] := o[3]*tau1;
              o[8] := o[3]*o[4];
              o[9] := pi1*pi1;
              o[10] := o[9]*o[9];
              o[11] := o[10]*o[10];
              o[12] := o[4]*o[4];
              o[13] := o[12]*o[12];

              h := data.RH2O*T*tau*(pi1*((-0.00254871721114236 + o[1]*(
                0.00424944110961118 + (0.018990068218419 + (-0.021841717175414 -
                0.00015851507390979*o[1])*o[1])*o[6]))/o[5] + pi1*((
                0.00141552963219801 + o[3]*(0.000047661393906987 + o[1]*(-0.0000132425535992538
                 - 1.2358149370591e-14*o[1]*o[3]*o[4])))/o[3] + pi1*((
                0.000126718579380216 - 5.11230768720618e-9*o[5])/o[7] + pi1*((
                0.000011212640954 + o[2]*(1.30342445791202e-6 - 1.4341729937924e-12*o[
                8]))/o[6] + pi1*(o[9]*pi1*((1.40077319158051e-8 + 1.04549227383804e-9
                *o[7])/o[8] + o[10]*o[11]*pi1*(1.9941018075704e-17/(o[1]*o[12]*o[3]*o[
                4]) + o[9]*(-4.48827542684151e-19/o[13] + o[10]*o[9]*(pi1*(
                4.65957282962769e-22/(o[13]*o[4]) + pi1*((3.83502057899078e-24*pi1)/(
                o[1]*o[13]*o[4]) - 7.2912378325616e-23/(o[13]*o[4]*tau1))) -
                1.00075970318621e-21/(o[1]*o[13]*o[3]*tau1))))) + 3.24135974880936e-6
                /(o[4]*tau1)))))) + (-0.29265942426334 + tau1*(0.84548187169114 + o[1]
                *(3.3855169168385 + tau1*(-1.91583926775744 + tau1*(0.47316115539684
                 + (-0.066465668798004 + 0.0040607314991784*tau1)*tau1)))))/o[2]);
            end hofpT1;

            function handsofpT1
              "Special function for specific enthalpy and specific entropy in region 1"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real[28] o "Vector of auxiliary variables";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
              Real g "Dimensionless Gibbs energy";
              Real gtau "Derivative of dimensionless Gibbs energy w.r.t. tau";
            algorithm
              assert(p > triple.ptriple,
                "IF97 medium function handsofpT1 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              tau := data.TSTAR1/T;
              pi1 := 7.1 - p/data.PSTAR1;
              tau1 := -1.222 + tau;
              o[1] := tau1*tau1;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              o[4] := o[3]*tau1;
              o[5] := 1/o[4];
              o[6] := o[1]*o[2];
              o[7] := o[1]*tau1;
              o[8] := 1/o[7];
              o[9] := o[1]*o[2]*o[3];
              o[10] := 1/o[2];
              o[11] := o[2]*tau1;
              o[12] := 1/o[11];
              o[13] := o[2]*o[3];
              o[14] := pi1*pi1;
              o[15] := o[14]*pi1;
              o[16] := o[14]*o[14];
              o[17] := o[16]*o[16];
              o[18] := o[16]*o[17]*pi1;
              o[19] := o[14]*o[16];
              o[20] := o[3]*o[3];
              o[21] := o[20]*o[20];
              o[22] := o[21]*o[3]*tau1;
              o[23] := 1/o[22];
              o[24] := o[21]*o[3];
              o[25] := 1/o[24];
              o[26] := o[1]*o[2]*o[21]*tau1;
              o[27] := 1/o[26];
              o[28] := o[1]*o[3];

              g := pi1*(pi1*(pi1*(o[10]*(-0.000031679644845054 + o[2]*(-2.8270797985312e-6
                 - 8.5205128120103e-10*o[6])) + pi1*(o[12]*(-2.2425281908e-6 + (-6.5171222895601e-7
                 - 1.4341729937924e-13*o[13])*o[7]) + pi1*(-4.0516996860117e-7/o[3]
                 + o[15]*(o[18]*(o[14]*(o[19]*(2.6335781662795e-23/(o[1]*o[2]*o[21])
                 + pi1*(-1.1947622640071e-23*o[27] + pi1*(1.8228094581404e-24*o[25]
                 - 9.3537087292458e-26*o[23]*pi1))) + 1.4478307828521e-20/(o[1]*o[2]*
                o[20]*o[3]*tau1)) - 6.8762131295531e-19/(o[2]*o[20]*o[3]*tau1)) + (-1.2734301741641e-9
                 - 1.7424871230634e-10*o[11])/(o[1]*o[3]*tau1))))) + o[8]*(-0.00047184321073267
                 + o[7]*(-0.00030001780793026 + (0.000047661393906987 + o[1]*(-4.4141845330846e-6
                 - 7.2694996297594e-16*o[9]))*tau1))) + o[5]*(0.00028319080123804 + o[
                1]*(-0.00060706301565874 + o[6]*(-0.018990068218419 + tau1*(-0.032529748770505
                 + (-0.021841717175414 - 0.00005283835796993*o[1])*tau1))))) + (
                0.14632971213167 + tau1*(-0.84548187169114 + tau1*(-3.756360367204 +
                tau1*(3.3855169168385 + tau1*(-0.95791963387872 + tau1*(
                0.15772038513228 + (-0.016616417199501 + 0.00081214629983568*tau1)*
                tau1))))))/o[1];

              gtau := pi1*((-0.00254871721114236 + o[1]*(0.00424944110961118 + (
                0.018990068218419 + (-0.021841717175414 - 0.00015851507390979*o[1])*o[
                1])*o[6]))/o[28] + pi1*(o[10]*(0.00141552963219801 + o[2]*(
                0.000047661393906987 + o[1]*(-0.0000132425535992538 -
                1.2358149370591e-14*o[9]))) + pi1*(o[12]*(0.000126718579380216 -
                5.11230768720618e-9*o[28]) + pi1*((0.000011212640954 + (
                1.30342445791202e-6 - 1.4341729937924e-12*o[13])*o[7])/o[6] + pi1*(
                3.24135974880936e-6*o[5] + o[15]*((1.40077319158051e-8 +
                1.04549227383804e-9*o[11])/o[13] + o[18]*(1.9941018075704e-17/(o[1]*o[
                2]*o[20]*o[3]) + o[14]*(-4.48827542684151e-19/o[21] + o[19]*(-1.00075970318621e-21
                *o[27] + pi1*(4.65957282962769e-22*o[25] + pi1*(-7.2912378325616e-23*
                o[23] + (3.83502057899078e-24*pi1)/(o[1]*o[21]*o[3])))))))))))) + o[8]
                *(-0.29265942426334 + tau1*(0.84548187169114 + o[1]*(3.3855169168385
                 + tau1*(-1.91583926775744 + tau1*(0.47316115539684 + (-0.066465668798004
                 + 0.0040607314991784*tau1)*tau1)))));

              h := data.RH2O*T*tau*gtau;
              s := data.RH2O*(tau*gtau - g);
            end handsofpT1;

            function hofpT2
              "Intermediate function for isentropic specific enthalpy in region 2"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real[16] o "Vector of auxiliary variables";
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
            algorithm
              assert(p > triple.ptriple,
                "IF97 medium function hofpT2 called with too low pressure\n" + "p = "
                 + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              pi := p/data.PSTAR2;
              tau := data.TSTAR2/T;
              tau2 := -0.5 + tau;
              o[1] := tau*tau;
              o[2] := o[1]*o[1];
              o[3] := tau2*tau2;
              o[4] := o[3]*tau2;
              o[5] := o[3]*o[3];
              o[6] := o[5]*o[5];
              o[7] := o[6]*o[6];
              o[8] := o[5]*o[6]*o[7]*tau2;
              o[9] := o[3]*o[5];
              o[10] := o[5]*o[6]*tau2;
              o[11] := o[3]*o[7]*tau2;
              o[12] := o[3]*o[5]*o[6];
              o[13] := o[5]*o[6]*o[7];
              o[14] := pi*pi;
              o[15] := o[14]*o[14];
              o[16] := o[7]*o[7];

              h := data.RH2O*T*tau*((0.0280439559151 + tau*(-0.2858109552582 + tau*(
                1.2213149471784 + tau*(-2.848163942888 + tau*(4.38395111945 + o[1]*(
                10.08665568018 + (-0.5681726521544 + 0.06380539059921*tau)*tau))))))/
                (o[1]*o[2]) + pi*(-0.017834862292358 + tau2*(-0.09199202739273 + (-0.172743777250296
                 - 0.30195167236758*o[4])*tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263
                 + o[3]*(-0.015757110897342 + o[4]*(-0.306581069554011 -
                0.000960283724907132*o[8])))*tau2 + pi*(4.3870667284435e-7 + o[3]*(-0.00009683303171571
                 + o[4]*(-0.0090203547252888 - 1.42338887469272*o[8])) + pi*(-7.8847309559367e-10
                 + (2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
                0.0000160454534363627*o[9] + pi*((-5.0144299353183e-11 + o[10]*(-0.033874355714168
                 - 836.35096769364*o[11]))*o[3] + pi*((-0.0000138839897890111 -
                0.973671060893475*o[12])*o[3]*o[6] + pi*((9.0049690883672e-11 -
                296.320827232793*o[13])*o[3]*o[5]*tau2 + pi*(2.57526266427144e-7*o[5]
                *o[6] + pi*(o[4]*(4.1627860840696e-19 + (-1.0234747095929e-12 -
                1.40254511313154e-8*o[5])*o[9]) + o[14]*o[15]*(o[13]*(-2.34560435076256e-9
                 + 5.3465159397045*o[5]*o[7]*tau2) + o[14]*(-19.1874828272775*o[16]*o[
                6]*o[7] + o[14]*(o[11]*(1.78371690710842e-23 + (1.07202609066812e-11
                 - 0.000201611844951398*o[10])*o[3]*o[5]*o[6]*tau2) + pi*(-1.24017662339842e-24
                *o[5]*o[7] + pi*(0.000200482822351322*o[16]*o[5]*o[7] + pi*(-4.97975748452559e-14
                *o[16]*o[3]*o[5] + o[6]*o[7]*(1.90027787547159e-27 + o[12]*(
                2.21658861403112e-15 - 0.0000547344301999018*o[3]*o[7]))*pi*tau2)))))))))))))))));
            end hofpT2;

            function handsofpT2
              "Function for isentropic specific enthalpy and specific entropy in region 2"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              output SI.SpecificEnthalpy h "Specific enthalpy";
              output SI.SpecificEntropy s "Specific entropy";
            protected
              Real[22] o "Vector of auxiliary variables";
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
              Real g "Dimensionless Gibbs energy";
              Real gtau "Derivative of dimensionless Gibbs energy w.r.t. tau";
            algorithm
              assert(p > triple.ptriple,
                "IF97 medium function handsofpT2 called with too low pressure\n" +
                "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
                " Pa (triple point pressure)");
              tau := data.TSTAR2/T;
              pi := p/data.PSTAR2;
              tau2 := tau - 0.5;
              o[1] := tau2*tau2;
              o[2] := o[1]*tau2;
              o[3] := o[1]*o[1];
              o[4] := o[3]*o[3];
              o[5] := o[4]*o[4];
              o[6] := o[3]*o[4]*o[5]*tau2;
              o[7] := o[1]*o[3]*tau2;
              o[8] := o[3]*o[4]*tau2;
              o[9] := o[1]*o[5]*tau2;
              o[10] := o[1]*o[3]*o[4];
              o[11] := o[3]*o[4]*o[5];
              o[12] := o[1]*o[3];
              o[13] := pi*pi;
              o[14] := o[13]*o[13];
              o[15] := o[13]*o[14];
              o[16] := o[3]*o[5]*tau2;
              o[17] := o[5]*o[5];
              o[18] := o[3]*o[5];
              o[19] := o[1]*o[3]*o[4]*tau2;
              o[20] := o[1]*o[5];
              o[21] := tau*tau;
              o[22] := o[21]*o[21];

              g := pi*(-0.0017731742473213 + tau2*(-0.017834862292358 + tau2*(-0.045996013696365
                 + (-0.057581259083432 - 0.05032527872793*o[2])*tau2)) + pi*(tau2*(-0.000033032641670203
                 + (-0.00018948987516315 + o[1]*(-0.0039392777243355 + o[2]*(-0.043797295650573
                 - 0.000026674547914087*o[6])))*tau2) + pi*(2.0481737692309e-8 + (
                4.3870667284435e-7 + o[1]*(-0.00003227767723857 + o[2]*(-0.0015033924542148
                 - 0.040668253562649*o[6])))*tau2 + pi*(tau2*(-7.8847309559367e-10 +
                (1.2790717852285e-8 + 4.8225372718507e-7*tau2)*tau2) + pi*(
                2.2922076337661e-6*o[7] + pi*(o[2]*(-1.6714766451061e-11 + o[8]*(-0.0021171472321355
                 - 23.895741934104*o[9])) + pi*(-5.905956432427e-18 + o[1]*(-1.2621808899101e-6
                 - 0.038946842435739*o[10])*o[4]*tau2 + pi*((1.1256211360459e-11 -
                8.2311340897998*o[11])*o[4] + pi*(1.9809712802088e-8*o[8] + pi*((
                1.0406965210174e-19 + o[12]*(-1.0234747095929e-13 -
                1.0018179379511e-9*o[3]))*o[3] + o[15]*((-8.0882908646985e-11 +
                0.10693031879409*o[16])*o[6] + o[13]*(-0.33662250574171*o[17]*o[4]*o[
                5]*tau2 + o[13]*(o[18]*(8.9185845355421e-25 + o[19]*(
                3.0629316876232e-13 - 4.2002467698208e-6*o[8])) + pi*(-5.9056029685639e-26
                *o[16] + pi*(3.7826947613457e-6*o[17]*o[3]*o[5]*tau2 + pi*(o[1]*(
                7.3087610595061e-29 + o[10]*(5.5414715350778e-17 - 9.436970724121e-7*
                o[20]))*o[4]*o[5]*pi - 1.2768608934681e-15*o[1]*o[17]*o[3]*tau2))))))))))))))))
                 + (-0.00560879118302 + tau*(0.07145273881455 + tau*(-0.4071049823928
                 + tau*(1.424081971444 + tau*(-4.38395111945 + tau*(-9.692768600217
                 + tau*(10.08665568018 + (-0.2840863260772 + 0.02126846353307*tau)*
                tau) + Modelica.Math.log(pi)))))))/(o[22]*tau);

              gtau := (0.0280439559151 + tau*(-0.2858109552582 + tau*(1.2213149471784
                 + tau*(-2.848163942888 + tau*(4.38395111945 + o[21]*(10.08665568018
                 + (-0.5681726521544 + 0.06380539059921*tau)*tau))))))/(o[21]*o[22])
                 + pi*(-0.017834862292358 + tau2*(-0.09199202739273 + (-0.172743777250296
                 - 0.30195167236758*o[2])*tau2) + pi*(-0.000033032641670203 + (-0.0003789797503263
                 + o[1]*(-0.015757110897342 + o[2]*(-0.306581069554011 -
                0.000960283724907132*o[6])))*tau2 + pi*(4.3870667284435e-7 + o[1]*(-0.00009683303171571
                 + o[2]*(-0.0090203547252888 - 1.42338887469272*o[6])) + pi*(-7.8847309559367e-10
                 + (2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
                0.0000160454534363627*o[12] + pi*(o[1]*(-5.0144299353183e-11 + o[8]*(
                -0.033874355714168 - 836.35096769364*o[9])) + pi*(o[1]*(-0.0000138839897890111
                 - 0.973671060893475*o[10])*o[4] + pi*((9.0049690883672e-11 -
                296.320827232793*o[11])*o[7] + pi*(2.57526266427144e-7*o[3]*o[4] + pi
                *(o[2]*(4.1627860840696e-19 + o[12]*(-1.0234747095929e-12 -
                1.40254511313154e-8*o[3])) + o[15]*(o[11]*(-2.34560435076256e-9 +
                5.3465159397045*o[16]) + o[13]*(-19.1874828272775*o[17]*o[4]*o[5] + o[
                13]*((1.78371690710842e-23 + o[19]*(1.07202609066812e-11 -
                0.000201611844951398*o[8]))*o[9] + pi*(-1.24017662339842e-24*o[18] +
                pi*(0.000200482822351322*o[17]*o[3]*o[5] + pi*(-4.97975748452559e-14*
                o[1]*o[17]*o[3] + (1.90027787547159e-27 + o[10]*(2.21658861403112e-15
                 - 0.0000547344301999018*o[20]))*o[4]*o[5]*pi*tau2))))))))))))))));

              h := data.RH2O*T*tau*gtau;
              s := data.RH2O*(tau*gtau - g);
            end handsofpT2;
            annotation (Documentation(info="<HTML><h4>Package description</h4>
          <h4>Package contents</h4>
          <ul>
          <li>Function <b>hofpT1</b> computes h(p,T) in region 1.</li>
          <li>Function <b>handsofpT1</b> computes (s,h)=f(p,T) in region 1, needed for two-phase properties.</li>
          <li>Function <b>hofps1</b> computes h(p,s) in region 1.</li>
          <li>Function <b>hofpT2</b> computes h(p,T) in region 2.</li>
          <li>Function <b>handsofpT2</b> computes (s,h)=f(p,T) in region 2, needed for two-phase properties.</li>
          <li>Function <b>hofps2</b> computes h(p,s) in region 2.</li>
          <li>Function <b>hofdT3</b> computes h(d,T) in region 3.</li>
          <li>Function <b>hofpsdt3</b> computes h(p,s,dguess,Tguess) in region 3, where dguess and Tguess are initial guess
          values for the density and temperature consistent with p and s.</li>
          <li>Function <b>hofps4</b> computes h(p,s) in region 4.</li>
          <li>Function <b>hofpT5</b> computes h(p,T) in region 5.</li>
          <li>Function <b>water_hisentropic</b> computes h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
          <li>Function <b>water_hisentropic_dyn</b> computes h(p,s,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
          </ul>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
          </html>"));
          end Isentropic;

          package Inverses "Efficient inverses for selected pairs of variables"
            extends Modelica.Icons.Package;

            function fixdT "Region limits for inverse iteration in region 3"

              extends Modelica.Icons.Function;
              input SI.Density din "Density";
              input SI.Temperature Tin "Temperature";
              output SI.Density dout "Density";
              output SI.Temperature Tout "Temperature";
            protected
              SI.Temperature Tmin "Approximation of minimum temperature";
              SI.Temperature Tmax "Approximation of maximum temperature";
            algorithm
              if (din > 765.0) then
                dout := 765.0;
              elseif (din < 110.0) then
                dout := 110.0;
              else
                dout := din;
              end if;
              if (dout < 390.0) then
                Tmax := 554.3557377 + dout*0.809344262;
              else
                Tmax := 1116.85 - dout*0.632948717;
              end if;
              if (dout < data.DCRIT) then
                Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)/
                  1.0e6);
              else
                Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)/
                  1.44e6);
              end if;
              if (Tin < Tmin) then
                Tout := Tmin;
              elseif (Tin > Tmax) then
                Tout := Tmax;
              else
                Tout := Tin;
              end if;
            end fixdT;

            function dofp13 "Density at the boundary between regions 1 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Density d "Density";
            protected
              Real p2 "Auxiliary variable";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              p2 := 7.1 - 6.04960677555959e-8*p;
              o[1] := p2*p2;
              o[2] := o[1]*o[1];
              o[3] := o[2]*o[2];
              d := 57.4756752485113/(0.0737412153522555 + p2*(0.00145092247736023 +
                p2*(0.000102697173772229 + p2*(0.0000114683182476084 + p2*(
                1.99080616601101e-6 + o[1]*p2*(1.13217858826367e-8 + o[2]*o[3]*p2*(
                1.35549330686006e-17 + o[1]*(-3.11228834832975e-19 + o[1]*o[2]*(-7.02987180039442e-22
                 + p2*(3.29199117056433e-22 + (-5.17859076694812e-23 +
                2.73712834080283e-24*p2)*p2))))))))));

            end dofp13;

            function dofp23 "Density at the boundary between regions 2 and 3"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              output SI.Density d "Density";
            protected
              SI.Temperature T;
              Real[13] o "Vector of auxiliary variables";
              Real taug "Auxiliary variable";
              Real pi "Dimensionless pressure";
              Real gpi23
                "Derivative of g w.r.t. pi on the boundary between regions 2 and 3";
            algorithm
              pi := p/data.PSTAR2;
              T := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
              o[1] := (-13.91883977887 + pi)^0.5;
              taug := -0.5 + 540.0/(572.54459862746 + 31.3220101646784*o[1]);
              o[2] := taug*taug;
              o[3] := o[2]*taug;
              o[4] := o[2]*o[2];
              o[5] := o[4]*o[4];
              o[6] := o[5]*o[5];
              o[7] := o[4]*o[5]*o[6]*taug;
              o[8] := o[4]*o[5]*taug;
              o[9] := o[2]*o[4]*o[5];
              o[10] := pi*pi;
              o[11] := o[10]*o[10];
              o[12] := o[4]*o[6]*taug;
              o[13] := o[6]*o[6];

              gpi23 := (1.0 + pi*(-0.0017731742473213 + taug*(-0.017834862292358 +
                taug*(-0.045996013696365 + (-0.057581259083432 - 0.05032527872793*o[3])
                *taug)) + pi*(taug*(-0.000066065283340406 + (-0.0003789797503263 + o[
                2]*(-0.007878555448671 + o[3]*(-0.087594591301146 -
                0.000053349095828174*o[7])))*taug) + pi*(6.1445213076927e-8 + (
                1.31612001853305e-6 + o[2]*(-0.00009683303171571 + o[3]*(-0.0045101773626444
                 - 0.122004760687947*o[7])))*taug + pi*(taug*(-3.15389238237468e-9 +
                (5.116287140914e-8 + 1.92901490874028e-6*taug)*taug) + pi*(
                0.0000114610381688305*o[2]*o[4]*taug + pi*(o[3]*(-1.00288598706366e-10
                 + o[8]*(-0.012702883392813 - 143.374451604624*o[2]*o[6]*taug)) + pi*
                (-4.1341695026989e-17 + o[2]*o[5]*(-8.8352662293707e-6 -
                0.272627897050173*o[9])*taug + pi*(o[5]*(9.0049690883672e-11 -
                65.8490727183984*o[4]*o[5]*o[6]) + pi*(1.78287415218792e-7*o[8] + pi*
                (o[4]*(1.0406965210174e-18 + o[2]*(-1.0234747095929e-12 -
                1.0018179379511e-8*o[4])*o[4]) + o[10]*o[11]*((-1.29412653835176e-9
                 + 1.71088510070544*o[12])*o[7] + o[10]*(-6.05920510335078*o[13]*o[5]
                *o[6]*taug + o[10]*(o[4]*o[6]*(1.78371690710842e-23 + o[2]*o[4]*o[5]*
                (6.1258633752464e-12 - 0.000084004935396416*o[8])*taug) + pi*(-1.24017662339842e-24
                *o[12] + pi*(0.0000832192847496054*o[13]*o[4]*o[6]*taug + pi*(o[2]*o[
                5]*o[6]*(1.75410265428146e-27 + (1.32995316841867e-15 -
                0.0000226487297378904*o[2]*o[6])*o[9])*pi - 2.93678005497663e-14*o[13]
                *o[2]*o[4]*taug)))))))))))))))))/pi;
              d := p/(data.RH2O*T*pi*gpi23);
            end dofp23;

            function dofpt3 "Inverse iteration in region 3: (d) = f(p,T)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.Temperature T "Temperature (K)";
              input SI.Pressure delp "Iteration converged if (p-pre(p) < delp)";
              output SI.Density d "Density";
              output Integer error=0
                "Error flag: iteration failed if different from 0";
            protected
              SI.Density dguess "Guess density";
              Integer i=0 "Loop counter";
              Real dp "Pressure difference";
              SI.Density deld "Density step";
              Modelica.Media.Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_pT nDerivs
                "Derivatives needed in Newton iteration";
              Boolean found=false "Flag for iteration success";
              Boolean supercritical "Flag, true for supercritical states";
              Boolean liquid "Flag, true for liquid states";
              SI.Density dmin "Lower density limit";
              SI.Density dmax "Upper density limit";
              SI.Temperature Tmax "Maximum temperature";
              Real damping "Damping factor";
            algorithm
              found := false;
              assert(p >= data.PLIMIT4A,
                "BaseIF97.dofpt3: function called outside of region 3! p too low\n"
                 + "p = " + String(p) + " Pa < " + String(data.PLIMIT4A) + " Pa");
              assert(T >= data.TLIMIT1,
                "BaseIF97.dofpt3: function called outside of region 3! T too low\n"
                 + "T = " + String(T) + " K < " + String(data.TLIMIT1) + " K");
              assert(p >= Regions.boundary23ofT(T),
                "BaseIF97.dofpt3: function called outside of region 3! T too high\n"
                 + "p = " + String(p) + " Pa, T = " + String(T) + " K");
              supercritical := p > data.PCRIT;
              damping := if supercritical then 1.0 else 1.0;
              Tmax := Regions.boundary23ofp(p);
              if supercritical then
                dmax := dofp13(p);
                dmin := dofp23(p);
                dguess := dmax - (T - data.TLIMIT1)/(data.TLIMIT1 - Tmax)*(dmax -
                  dmin);
                //this may need even further improvement!!
              else
                liquid := T < Basic.tsat(p);
                if liquid then
                  dmax := dofp13(p);
                  dmin := Regions.rhol_p_R4b(p);
                  dguess := 1.1*Regions.rhol_T(T)
                    "Guess: 10 percent more than on the phase boundary for same T";
                  //      dguess := 0.5*(dmax + dmin);
                else
                  dmax := Regions.rhov_p_R4b(p);
                  dmin := dofp23(p);
                  dguess := 0.9*Regions.rhov_T(T)
                    "Guess: 10% less than on the phase boundary for same T";
                  //      dguess := 0.5*(dmax + dmin);
                end if;
              end if;
              while ((i < IterationData.IMAX) and not found) loop
                d := dguess;
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
                dp := nDerivs.p - p;
                if (abs(dp/p) <= delp) then
                  found := true;
                end if;
                deld := dp/nDerivs.pd*damping;
                // Can be used for debugging in Dymola: not a standard function
                //          LogVariable(deld);
                d := d - deld;
                if d > dmin and d < dmax then
                  dguess := d;
                else
                  if d > dmax then
                    dguess := dmax - sqrt(Modelica.Constants.eps);
                    // put it on the correct spot just inside the boundary here instead
                  else
                    dguess := dmin + sqrt(Modelica.Constants.eps);
                  end if;
                end if;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              end if;
              assert(error <> 1, "Error in inverse function dofpt3: iteration failed");
            end dofpt3;

            function dtofph3 "Inverse iteration in region 3: (d,T) = f(p,h)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              input SI.Pressure delp "Iteration accuracy";
              input SI.SpecificEnthalpy delh "Iteration accuracy";
              output SI.Density d "Density";
              output SI.Temperature T "Temperature (K)";
              output Integer error
                "Error flag: iteration failed if different from 0";
            protected
              SI.Temperature Tguess "Initial temperature";
              SI.Density dguess "Initial density";
              Integer i "Iteration counter";
              Real dh "Newton-error in h-direction";
              Real dp "Newton-error in p-direction";
              Real det "Determinant of directional derivatives";
              Real deld "Newton-step in d-direction";
              Real delt "Newton-step in T-direction";
              Modelica.Media.Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_ph nDerivs
                "Derivatives needed in Newton iteration";
              Boolean found=false "Flag for iteration success";
              Integer subregion "1 for subregion 3a, 2 for subregion 3b";
            algorithm
              if p < data.PCRIT then
                // allow a 10 J margin inside the (well approximated) phase boundary
                subregion := if h < (Regions.hl_p(p) + 10.0) then 1 else if h > (
                  Regions.hv_p(p) - 10.0) then 2 else 0;
                assert(subregion <> 0,
                  "Inverse iteration of dt from ph called in 2 phase region: this can not work");
              else
                //supercritical
                subregion := if h < Basic.h3ab_p(p) then 1 else 2;
              end if;
              T := if subregion == 1 then Basic.T3a_ph(p, h) else Basic.T3b_ph(p, h);
              d := if subregion == 1 then 1/Basic.v3a_ph(p, h) else 1/Basic.v3b_ph(p,
                h);
              i := 0;
              error := 0;
              while ((i < IterationData.IMAX) and not found) loop
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
                dh := nDerivs.h - h;
                dp := nDerivs.p - p;
                if ((abs(dh/h) <= delh) and (abs(dp/p) <= delp)) then
                  found := true;
                end if;
                det := nDerivs.ht*nDerivs.pd - nDerivs.pt*nDerivs.hd;
                delt := (nDerivs.pd*dh - nDerivs.hd*dp)/det;
                deld := (nDerivs.ht*dp - nDerivs.pt*dh)/det;
                T := T - delt;
                d := d - deld;
                dguess := d;
                Tguess := T;
                i := i + 1;
                (d,T) := fixdT(dguess, Tguess);
              end while;
              if not found then
                error := 1;
              end if;
              assert(error <> 1,
                "Error in inverse function dtofph3: iteration failed");
            end dtofph3;

            function dtofps3 "Inverse iteration in region 3: (d,T) = f(p,s)"
              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              input SI.Pressure delp "Iteration accuracy";
              input SI.SpecificEntropy dels "Iteration accuracy";
              output SI.Density d "Density";
              output SI.Temperature T "Temperature (K)";
              output Integer error
                "Error flag: iteration failed if different from 0";
            protected
              SI.Temperature Tguess "Initial temperature";
              SI.Density dguess "Initial density";
              Integer i "Iteration counter";
              Real ds "Newton-error in s-direction";
              Real dp "Newton-error in p-direction";
              Real det "Determinant of directional derivatives";
              Real deld "Newton-step in d-direction";
              Real delt "Newton-step in T-direction";
              Modelica.Media.Common.HelmholtzDerivs f
                "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_ps nDerivs
                "Derivatives needed in Newton iteration";
              Boolean found "Flag for iteration success";
              Integer subregion "1 for subregion 3a, 2 for subregion 3b";
            algorithm
              i := 0;
              error := 0;
              found := false;
              if p < data.PCRIT then
                // allow a 1 J/K margin inside the (well approximated) phase boundary
                subregion := if s < (Regions.sl_p(p) + 10.0) then 1 else if s > (
                  Regions.sv_p(p) - 10.0) then 2 else 0;
                assert(subregion <> 0,
                  "Inverse iteration of dt from ps called in 2 phase region: this is illegal!");
              else
                subregion := if s < data.SCRIT then 1 else 2;
              end if;
              T := if subregion == 1 then Basic.T3a_ps(p, s) else Basic.T3b_ps(p, s);
              d := if subregion == 1 then 1/Basic.v3a_ps(p, s) else 1/Basic.v3b_ps(p,
                s);
              while ((i < IterationData.IMAX) and not found) loop
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
                ds := nDerivs.s - s;
                dp := nDerivs.p - p;
                if ((abs(ds/s) <= dels) and (abs(dp/p) <= delp)) then
                  found := true;
                end if;
                det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
                delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
                deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
                T := T - delt;
                d := d - deld;
                dguess := d;
                Tguess := T;
                i := i + 1;
                (d,T) := fixdT(dguess, Tguess);
              end while;
              if not found then
                error := 1;
              end if;
              assert(error <> 1,
                "Error in inverse function dtofps3: iteration failed");
            end dtofps3;

            function pofdt125
              "Inverse iteration in region 1,2 and 5: p = g(d,T)"
              extends Modelica.Icons.Function;
              input SI.Density d "Density";
              input SI.Temperature T "Temperature (K)";
              input SI.Pressure reldd "Relative iteration accuracy of density";
              input Integer region
                "Region in IAPWS/IF97 in which inverse should be calculated";
              output SI.Pressure p "Pressure";
              output Integer error
                "Error flag: iteration failed if different from 0";
            protected
              Integer i "Counter for while-loop";
              Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              Boolean found "Flag if iteration has been successful";
              Real dd
                "Difference between density for guessed p and the current density";
              Real delp "Step in p in Newton-iteration";
              Real relerr "Relative error in d";
              SI.Pressure pguess1=1.0e6 "Initial pressure guess in region 1";
              SI.Pressure pguess2 "Initial pressure guess in region 2";
              constant SI.Pressure pguess5=0.5e6
                "Initial pressure guess in region 5";
            algorithm
              i := 0;
              error := 0;
              pguess2 := 42800*d;
              found := false;
              if region == 1 then
                p := pguess1;
              elseif region == 2 then
                p := pguess2;
              else
                p := pguess5;
              end if;
              while ((i < IterationData.IMAX) and not found) loop
                if region == 1 then
                  g := Basic.g1(p, T);
                elseif region == 2 then
                  g := Basic.g2(p, T);
                else
                  g := Basic.g5(p, T);
                end if;
                dd := p/(data.RH2O*T*g.pi*g.gpi) - d;
                relerr := dd/d;
                if (abs(relerr) < reldd) then
                  found := true;
                end if;
                delp := dd*(-p*p/(d*d*data.RH2O*T*g.pi*g.pi*g.gpipi));
                p := p - delp;
                i := i + 1;
                if not found then
                  if p < triple.ptriple then
                    p := 2.0*triple.ptriple;
                  end if;
                  if p > data.PLIMIT1 then
                    p := 0.95*data.PLIMIT1;
                  end if;
                end if;
              end while;

              // print("i = " + i2s(i) + ", p = " + r2s(p/1.0e5) + ", delp = " + r2s(delp*1.0e-5) + "\n");
              if not found then
                error := 1;
              end if;
              assert(error <> 1,
                "Error in inverse function pofdt125: iteration failed");
            end pofdt125;

            function tofph5 "Inverse iteration in region 5: (p,T) = f(p,h)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEnthalpy h "Specific enthalpy";
              input SI.SpecificEnthalpy reldh "Iteration accuracy";
              output SI.Temperature T "Temperature (K)";
              output Integer error
                "Error flag: iteration failed if different from 0";

            protected
              Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              SI.SpecificEnthalpy proh "H for current guess in T";
              constant SI.Temperature Tguess=1500 "Initial temperature";
              Integer i "Iteration counter";
              Real relerr "Relative error in h";
              Real dh "Newton-error in h-direction";
              Real dT "Newton-step in T-direction";
              Boolean found "Flag for iteration success";
            algorithm
              i := 0;
              error := 0;
              T := Tguess;
              found := false;
              while ((i < IterationData.IMAX) and not found) loop
                g := Basic.g5(p, T);
                proh := data.RH2O*T*g.tau*g.gtau;
                dh := proh - h;
                relerr := dh/h;
                if (abs(relerr) < reldh) then
                  found := true;
                end if;
                dT := dh/(-data.RH2O*g.tau*g.tau*g.gtautau);
                T := T - dT;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              end if;
              assert(error <> 1, "Error in inverse function tofph5: iteration failed");
            end tofph5;

            function tofps5 "Inverse iteration in region 5: (p,T) = f(p,s)"

              extends Modelica.Icons.Function;
              input SI.Pressure p "Pressure";
              input SI.SpecificEntropy s "Specific entropy";
              input SI.SpecificEnthalpy relds "Iteration accuracy";
              output SI.Temperature T "Temperature (K)";
              output Integer error
                "Error flag: iteration failed if different from 0";

            protected
              Modelica.Media.Common.GibbsDerivs g
                "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              SI.SpecificEntropy pros "S for current guess in T";
              parameter SI.Temperature Tguess=1500 "Initial temperature";
              Integer i "Iteration counter";
              Real relerr "Relative error in s";
              Real ds "Newton-error in s-direction";
              Real dT "Newton-step in T-direction";
              Boolean found "Flag for iteration success";
            algorithm
              i := 0;
              error := 0;
              T := Tguess;
              found := false;
              while ((i < IterationData.IMAX) and not found) loop
                g := Basic.g5(p, T);
                pros := data.RH2O*(g.tau*g.gtau - g.g);
                ds := pros - s;
                relerr := ds/s;
                if (abs(relerr) < relds) then
                  found := true;
                end if;
                dT := ds*T/(-data.RH2O*g.tau*g.tau*g.gtautau);
                T := T - dT;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              end if;
              assert(error <> 1, "Error in inverse function tofps5: iteration failed");
            end tofps5;
            annotation (Documentation(info="<HTML><h4>Package description</h4>
          <h4>Package contents</h4>
          <ul>
          <li>Function <b>fixdT</b> constrains density and temperature to allowed region</li>
          <li>Function <b>dofp13</b> computes d as a function of p at boundary between regions 1 and 3</li>
          <li>Function <b>dofp23</b> computes d as a function of p at boundary between regions 2 and 3</li>
          <li>Function <b>dofpt3</b> iteration to compute d as a function of p and T in region 3</li>
          <li>Function <b>dtofph3</b> iteration to compute d and T as a function of p and h in region 3</li>
          <li>Function <b>dtofps3</b> iteration to compute d and T as a function of p and s in region 3</li>
          <li>Function <b>dtofpsdt3</b> iteration to compute d and T as a function of p and s in region 3,
          with initial guesses</li>
          <li>Function <b>pofdt125</b> iteration to compute p as a function of p and T in regions 1, 2 and 5</li>
          <li>Function <b>tofph5</b> iteration to compute T as a function of p and h in region 5</li>
          <li>Function <b>tofps5</b> iteration to compute T as a function of p and s in region 5</li>
          <li>Function <b>tofpst5</b> iteration to compute T as a function of p and s in region 5, with initial guess in T</li>
          </ul>
          <h4>Version Info and Revision history
          </h4>
          <ul>
          <li>First implemented: <i>July, 2000</i>
          by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
          </li>
          </ul>
          <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
          </address>
          <ul>
          <li>Initial version: July 2000</li>
          <li>Documentation added: December 2002</li>
          </ul>
          </html>"));
          end Inverses;
          annotation (Documentation(info="<HTML>
<style type=\"text/css\">
.nobr
{
white-space:nowrap;
}
</style>
    <h4>Version Info and Revision history</h4>
        <ul>
        <li>First implemented: <i>July, 2000</i>
        by Hubertus Tummescheit
        for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
        </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
        </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
        <p>In September 1997, the International Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) adopted a
        new formulation for the thermodynamic properties of water and steam for
        industrial use. This new industrial standard is called \"IAPWS Industrial
        Formulation for the Thermodynamic Properties of Water and Steam\" (IAPWS-IF97).
        The formulation IAPWS-IF97 replaces the previous industrial standard IFC-67.
        <p>Based on this new formulation, a new steam table, titled \"<a href=\"http://www.springer.de/cgi-bin/search_book.pl?isbn=3-540-64339-7\">Properties of Water and Steam</a>\" by W. Wagner and A. Kruse, was published by
        the Springer-Verlag, Berlin - New-York - Tokyo in April 1998. This
        steam table, ref. <a href=\"#steamprop\">[1]</a> is bilingual (English /
        German) and contains a complete description of the equations of
        IAPWS-IF97. This reference is the authoritative source of information
        for this implementation. A mostly identical version has been published by the International
        Association for the Properties
        of Water and Steam (<A HREF=\"http://www.iapws.org\">IAPWS</A>) with permission granted to re-publish the
        information if credit is given to IAPWS. This document is distributed with this library as
        <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>.
        In addition, the equations published by <A HREF=\"http://www.iapws.org\">IAPWS</A> for
        the transport properties dynamic viscosity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a>)
        and thermal conductivity (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a>)
        and equations for the surface tension (standards document: <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a>)
        are also implemented in this library and included for reference.</p>
        <p>
        The functions in BaseIF97.mo are low level functions which should
        only be used in those exceptions when the standard user level
        functions in Water.mo do not contain the wanted properties.
     </p>
<p>Based on IAPWS-IF97, Modelica functions are available for calculating
the most common thermophysical properties (thermodynamic and transport
properties). The implementation requires part of the common medium
property infrastructure of the Modelica.Thermal.Properties library in the file
Common.mo. There are a few extensions from the version of IF97 as
documented in <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> in order to improve performance for
dynamic simulations. Input variables for calculating the properties are
only implemented for a limited number of variable pairs which make sense as dynamic states: (p,h), (p,T), (p,s) and (d,T).
</p>
<hr size=3 width=\"70%\">
<h4><a name=\"regions\">1. Structure and Regions of IAPWS-IF97</a></h4>
<p>The IAPWS Industrial Formulation 1997 consists of
a set of equations for different regions which cover the following range
of validity:</p>
<table border=0 cellpadding=4>
<tr>
<td valign=\"top\">273,15 K &lt; <em>T</em> &lt; 1073,15 K</td>
<td valign=\"top\"><em>p</em> &lt; 100 MPa</td>
</tr>
<tr>
<td valign=\"top\">1073,15 K &lt; <em>T</em> &lt; 2273,15 K</td>
<td valign=\"top\"><em>p</em> &lt; 10 MPa</td>
</tr>
</table>
<p>
Figure 1 shows the 5 regions into which the entire range of validity of
IAPWS-IF97 is divided. The boundaries of the regions can be directly taken
from Fig. 1 except for the boundary between regions 2 and 3; this boundary,
which corresponds approximately to the isentropic line <span class=\"nobr\"><em>s</em> = 5.047 kJ kg
<sup>-1</sup>K<sup>-1</sup></span>, is defined
by a corresponding auxiliary equation. Both regions 1 and 2 are individually
covered by a fundamental equation for the specific Gibbs free energy <span class=\"nobr\"><em>g</em>( <em>p</em>,<em>T</em> )</span>, region 3 by a fundamental equation for the specific Helmholtz
free energy <span class=\"nobr\"><em>f </em>(<em> <font face=\"symbol\">r</font></em>,<em>T
</em>)</span>, and the saturation curve, corresponding to region 4, by a saturation-pressure
equation <span><em>p</em><sub>s</sub>( <em>T</em> )</span>. The high-temperature
region 5 is also covered by a <span class=\"nobr\"><em>g</em>( <em>p</em>,<em>T</em> )</span> equation. These
5 equations, shown in rectangular boxes in Fig. 1, form the so-called <em>basic
equations</em>.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Figure 1: Regions and equations of IAPWS-IF97</caption>
  <tr>
    <td>
    <img src=\"modelica://Modelica/Resources/Images/Media/Water/if97.png\" alt=\"Regions and equations of IAPWS-IF97\">
    </td>
  </tr>
</table>
<p>
In addition to these basic equations, so-called <em>backward
equations</em> are provided for regions 1, 2, and 4 in form of
<span class=\"nobr\"><em>T</em>( <em>p</em>,<em>h</em> )</span> and <span class=\"nobr\"><em>T</em>( <em>
p</em>,<em>s</em> )</span> for regions 1 and 2, and <span class=\"nobr\"><em>T</em><sub>s</sub>( <em>p</em> )</span> for region 4. These
backward equations, marked in grey in Fig. 1, were developed in such a
way that they are numerically very consistent with the corresponding
basic equation. Thus, properties as functions of&nbsp; <em>p</em>,<em>h
</em>and of&nbsp;<em> p</em>,<em>s </em>for regions 1 and 2, and of
<em>p</em> for region 4 can be calculated without any iteration. As a
result of this special concept for the development of the new
industrial standard IAPWS-IF97, the most important properties can be
calculated extremely quickly. All Modelica functions are optimized
with regard to short computing times.
</p>
<p>
The complete description of the individual equations of the new industrial
formulation IAPWS-IF97 is given in <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. Comprehensive information on
IAPWS-IF97 (requirements, concept, accuracy, consistency along region boundaries,
and the increase of computing speed in comparison with IFC-67, etc.) can
be taken from <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> or [2].
</p>
<p>
<a name=\"steamprop\">[1]<em>Wagner, W., Kruse, A.</em> Properties of Water
and Steam / Zustandsgr&ouml;&szlig;en von Wasser und Wasserdampf / IAPWS-IF97.
Springer-Verlag, Berlin, 1998.</a>
</p>
<p>
[2] <em>Wagner, W., Cooper, J. R., Dittmann, A., Kijima,
J., Kretzschmar, H.-J., Kruse, A., Mare&#353; R., Oguchi, K., Sato, H., St&ouml;cker,
I., &#352;ifner, O., Takaishi, Y., Tanishita, I., Tr&uuml;benbach, J., and Willkommen,
Th.</em> The IAPWS Industrial Formulation 1997 for the Thermodynamic Properties
of Water and Steam. ASME Journal of Engineering for Gas Turbines and Power 122 (2000), 150 - 182.
</p>
<HR size=3 width=\"90%\">
<h4>2. Calculable Properties      </h4>
<table border=\"1\" cellpadding=\"2\" cellspacing=\"0\">
       <tbody>
       <tr>
       <td valign=\"top\" bgcolor=\"#cccccc\"><br>
      </td>
      <td valign=\"top\" bgcolor=\"#cccccc\"><b>Common name</b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Abbreviation </b><br>
       </td>
       <td valign=\"top\" bgcolor=\"#cccccc\"><b>Unit</b><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;1<br>
      </td>
      <td valign=\"top\">Pressure</td>
       <td valign=\"top\">p<br>
        </td>
       <td valign=\"top\">Pa<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;2<br>
      </td>
      <td valign=\"top\">Temperature</td>
       <td valign=\"top\">T<br>
       </td>
       <td valign=\"top\">K<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;3<br>
      </td>
      <td valign=\"top\">Density</td>
        <td valign=\"top\">d<br>
        </td>
       <td valign=\"top\">kg/m<sup>3</sup><br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;4<br>
      </td>
      <td valign=\"top\">Specific volume</td>
        <td valign=\"top\">v<br>
        </td>
       <td valign=\"top\">m<sup>3</sup>/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;5<br>
      </td>
      <td valign=\"top\">Specific enthalpy</td>
       <td valign=\"top\">h<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;6<br>
      </td>
      <td valign=\"top\">Specific entropy</td>
       <td valign=\"top\">s<br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;7<br>
      </td>
      <td valign=\"top\">Specific internal energy<br>
       </td>
       <td valign=\"top\">u<br>
       </td>
       <td valign=\"top\">J/kg<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;8<br>
      </td>
      <td valign=\"top\">Specific isobaric heat capacity</td>
       <td valign=\"top\">c<sub>p</sub><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">&nbsp;9<br>
      </td>
      <td valign=\"top\">Specific isochoric heat capacity</td>
       <td valign=\"top\">c<sub>v</sub><br>
       </td>
       <td valign=\"top\">J/(kg K)<br>
       </td>
       </tr>
       <tr>
       <td valign=\"top\">10<br>
      </td>
      <td valign=\"top\">Isentropic exponent, kappa<span class=\"nobr\">=<font face=\"Symbol\">-</font>(v/p)
(dp/dv)<sub>s</sub></span></td>
     <td valign=\"top\">kappa (<font face=\"Symbol\">k</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">11<br>
      </td>
      <td valign=\"top\">Speed of sound<br>
     </td>
     <td valign=\"top\">a<br>
     </td>
     <td valign=\"top\">m/s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">12<br>
      </td>
      <td valign=\"top\">Dryness fraction<br>
     </td>
     <td valign=\"top\">x<br>
     </td>
     <td valign=\"top\">kg/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">13<br>
      </td>
      <td valign=\"top\">Specific Helmholtz free energy,     f = u - Ts</td>
     <td valign=\"top\">f<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">14<br>
      </td>
      <td valign=\"top\">Specific Gibbs free energy,     g = h - Ts</td>
     <td valign=\"top\">g<br>
     </td>
     <td valign=\"top\">J/kg<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">15<br>
      </td>
      <td valign=\"top\">Isenthalpic exponent, <span class=\"nobr\"> theta = -(v/p)(dp/dv)<sub>h</sub></span></td>
     <td valign=\"top\">theta (<font face=\"Symbol\">q</font>)<br>
     </td>
     <td valign=\"top\">1<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">16<br>
      </td>
      <td valign=\"top\">Isobaric volume expansion coefficient, alpha = v<sup>-1</sup>       (dv/dT)<sub>p</sub></td>
     <td valign=\"top\">alpha  (<font face=\"Symbol\">a</font>)<br>
     </td>
       <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">17<br>
      </td>
      <td valign=\"top\">Isochoric pressure coefficient,     <span class=\"nobr\">beta = p<sup><font face=\"Symbol\">-</font>1</sup>(dp/dT)<sub>v</sub></span></td>
     <td valign=\"top\">beta (<font face=\"Symbol\">b</font>)<br>
     </td>
     <td valign=\"top\">1/K<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">18<br>
     </td>
     <td valign=\"top\">Isothermal compressibility, <span class=\"nobr\">gamma = <font
 face=\"Symbol\">-</font>v<sup><font face=\"Symbol\">-</font>1</sup>(dv/dp)<sub>T</sub></span></td>
     <td valign=\"top\">gamma (<font face=\"Symbol\">g</font>)<br>
     </td>
     <td valign=\"top\">1/Pa<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">f</td><td valign=\"top\">Fugacity</td></tr> --> <tr>
     <td valign=\"top\">19<br>
      </td>
      <td valign=\"top\">Dynamic viscosity</td>
     <td valign=\"top\">eta (<font face=\"Symbol\">h</font>)<br>
     </td>
     <td valign=\"top\">Pa s<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">20<br>
      </td>
      <td valign=\"top\">Kinematic viscosity</td>
     <td valign=\"top\">nu (<font face=\"Symbol\">n</font>)<br>
     </td>
     <td valign=\"top\">m<sup>2</sup>/s<br>
     </td>
     </tr>
     <!-- <tr><td valign=\"top\">Pr</td><td valign=\"top\">Prandtl number</td></tr> --> <tr>
     <td valign=\"top\">21<br>
      </td>
      <td valign=\"top\">Thermal conductivity</td>
     <td valign=\"top\">lambda (<font face=\"Symbol\">l</font>)<br>
     </td>
     <td valign=\"top\">W/(m K)<br>
     </td>
     </tr>
     <tr>
     <td valign=\"top\">22 <br>
      </td>
      <td valign=\"top\">Surface tension</td>
     <td valign=\"top\">sigma (<font face=\"Symbol\">s</font>)<br>
     </td>
     <td valign=\"top\">N/m<br>
     </td>
     </tr>
  </tbody>
</table>
        <p>The properties 1-11 are calculated by default with the functions for dynamic
        simulation, 2 of these variables are the dynamic states and are the inputs
        to calculate all other properties. In addition to these properties
        of general interest, the entries to the thermodynamic Jacobian matrix which render
        the mass- and energy balances explicit in the input variables to the property calculation are also calculated.
        For an explanatory example using pressure and specific enthalpy as states, see the Examples sub-package.</p>
        <p>The high-level calls to steam properties are grouped into records comprising both the properties of general interest
        and the entries to the thermodynamic Jacobian. If additional properties are
        needed the low level functions in BaseIF97 provide more choice.</p>
        <HR size=3 width=\"90%\">
        <h4>Additional functions</h4>
        <ul>
        <li>Function <b>boundaryvals_p</b> computes the temperature and the specific enthalpy and
        entropy on both phase boundaries as a function of p</li>
        <li>Function <b>boundaryderivs_p</b> is the Modelica derivative function of <b>boundaryvals_p</b></li>
        <li>Function <b>extraDerivs_ph</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,h). All 336 directional derivatives of the
        thermodynamic surface can be computed as a ratio of two entries in the return data, see package Common
        for details.</li>
        <li>Function <b>extraDerivs_pT</b> computes all entries to Bridgmans tables for all
        one-phase regions of IF97 using inputs (p,T).</li>
        </ul>
        </HTML>"));
        end BaseIF97;

        function waterBaseProp_ph "Intermediate property record for water"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region=0
            "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
          SI.SpecificEnthalpy h_liq "Liquid specific enthalpy";
          SI.Density d_liq "Liquid density";
          SI.SpecificEnthalpy h_vap "Vapour specific enthalpy";
          SI.Density d_vap "Vapour density";
          Common.PhaseBoundaryProperties liq "Phase boundary property record";
          Common.PhaseBoundaryProperties vap "Phase boundary property record";
          Common.GibbsDerivs gl
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.GibbsDerivs gv
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          SI.Temperature t1
            "Temperature at phase boundary, using inverse from region 1";
          SI.Temperature t2
            "Temperature at phase boundary, using inverse from region 2";
        algorithm
          aux.region := if region == 0 then (if phase == 2 then 4 else
            BaseIF97.Regions.region_ph(
              p=p,
              h=h,
              phase=phase)) else region;
          aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
          aux.p := max(p, 611.657);
          aux.h := max(h, 1e3);
          aux.R := BaseIF97.data.RH2O;
          if (aux.region == 1) then
            aux.T := BaseIF97.Basic.tph1(aux.p, aux.h);
            g := BaseIF97.Basic.g1(p, aux.T);
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 0.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 2) then
            aux.T := BaseIF97.Basic.tph2(aux.p, aux.h);
            g := BaseIF97.Basic.g2(p, aux.T);
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 1.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 3) then
            (aux.rho,aux.T,error) := BaseIF97.Inverses.dtofph3(
                p=aux.p,
                h=aux.h,
                delp=1.0e-7,
                delh=1.0e-6);
            f := BaseIF97.Basic.f3(aux.rho, aux.T);
            aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta);
            aux.s := aux.R*(f.tau*f.ftau - f.f);
            aux.pd := aux.R*aux.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
            aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
            aux.cv := abs(aux.R*(-f.tau*f.tau*f.ftautau))
              "Can be close to neg. infinity near critical point";
            aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*
              aux.rho*aux.pd);
            aux.x := 0.0;
            aux.dpT := aux.pt;
            /*safety against div-by-0 in initialization*/
          elseif (aux.region == 4) then
            h_liq := hl_p(p);
            h_vap := hv_p(p);
            aux.x := if (h_vap <> h_liq) then (h - h_liq)/(h_vap - h_liq) else 1.0;
            if p < BaseIF97.data.PLIMIT4A then
              t1 := BaseIF97.Basic.tph1(aux.p, h_liq);
              t2 := BaseIF97.Basic.tph2(aux.p, h_vap);
              gl := BaseIF97.Basic.g1(aux.p, t1);
              gv := BaseIF97.Basic.g2(aux.p, t2);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
              aux.T := t1 + aux.x*(t2 - t1);
            else
              aux.T := BaseIF97.Basic.tsat(aux.p);
              // how to avoid ?
              d_liq := rhol_T(aux.T);
              d_vap := rhov_T(aux.T);
              fl := BaseIF97.Basic.f3(d_liq, aux.T);
              fv := BaseIF97.Basic.f3(d_vap, aux.T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
              //  aux.dpT := BaseIF97.Basic.dptofT(aux.T);
            end if;
            aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d -
              vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.s := liq.s + aux.x*(vap.s - liq.s);
            aux.rho := liq.d*vap.d/(vap.d + aux.x*(liq.d - vap.d));
            aux.cv := Common.cv2Phase(
                liq,
                vap,
                aux.x,
                aux.T,
                p);
            aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
          elseif (aux.region == 5) then
            (aux.T,error) := BaseIF97.Inverses.tofph5(
                p=aux.p,
                h=aux.h,
                reldh=1.0e-7);
            assert(error == 0, "Error in inverse iteration of steam tables");
            g := BaseIF97.Basic.g5(aux.p, aux.T);
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.dpT := -aux.vt/aux.vp;
          else
            assert(false, "Error in region computation of IF97 steam tables" +
              "(p = " + String(p) + ", h = " + String(h) + ")");
          end if;
        end waterBaseProp_ph;

        function waterBaseProp_ps "Intermediate property record for water"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Integer phase=0
            "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region=0
            "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
          SI.SpecificEntropy s_liq "Liquid specific entropy";
          SI.Density d_liq "Liquid density";
          SI.SpecificEntropy s_vap "Vapour specific entropy";
          SI.Density d_vap "Vapour density";
          Common.PhaseBoundaryProperties liq "Phase boundary property record";
          Common.PhaseBoundaryProperties vap "Phase boundary property record";
          Common.GibbsDerivs gl
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.GibbsDerivs gv
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          SI.Temperature t1
            "Temperature at phase boundary, using inverse from region 1";
          SI.Temperature t2
            "Temperature at phase boundary, using inverse from region 2";
        algorithm
          aux.region := if region == 0 then (if phase == 2 then 4 else
            BaseIF97.Regions.region_ps(
              p=p,
              s=s,
              phase=phase)) else region;
          aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
          aux.p := p;
          aux.s := s;
          aux.R := BaseIF97.data.RH2O;
          if (aux.region == 1) then
            aux.T := BaseIF97.Basic.tps1(p, s);
            g := BaseIF97.Basic.g1(p, aux.T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 0.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 2) then
            aux.T := BaseIF97.Basic.tps2(p, s);
            g := BaseIF97.Basic.g2(p, aux.T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 1.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 3) then
            (aux.rho,aux.T,error) := BaseIF97.Inverses.dtofps3(
                p=p,
                s=s,
                delp=1.0e-7,
                dels=1.0e-6);
            f := BaseIF97.Basic.f3(aux.rho, aux.T);
            aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta);
            aux.s := aux.R*(f.tau*f.ftau - f.f);
            aux.pd := aux.R*aux.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
            aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
            aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
            aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*
              aux.rho*aux.pd);
            aux.x := 0.0;
            aux.dpT := aux.pt;
            /*safety against div-by-0 in initialization*/
          elseif (aux.region == 4) then
            s_liq := BaseIF97.Regions.sl_p(p);
            s_vap := BaseIF97.Regions.sv_p(p);
            aux.x := if (s_vap <> s_liq) then (s - s_liq)/(s_vap - s_liq) else 1.0;
            if p < BaseIF97.data.PLIMIT4A then
              t1 := BaseIF97.Basic.tps1(p, s_liq);
              t2 := BaseIF97.Basic.tps2(p, s_vap);
              gl := BaseIF97.Basic.g1(p, t1);
              gv := BaseIF97.Basic.g2(p, t2);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
              aux.T := t1 + aux.x*(t2 - t1);
            else
              aux.T := BaseIF97.Basic.tsat(p);
              d_liq := rhol_T(aux.T);
              d_vap := rhov_T(aux.T);
              fl := BaseIF97.Basic.f3(d_liq, aux.T);
              fv := BaseIF97.Basic.f3(d_vap, aux.T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
            end if;
            aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d -
              vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.h := liq.h + aux.x*(vap.h - liq.h);
            aux.rho := liq.d*vap.d/(vap.d + aux.x*(liq.d - vap.d));
            aux.cv := Common.cv2Phase(
                liq,
                vap,
                aux.x,
                aux.T,
                p);
            aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
          elseif (aux.region == 5) then
            (aux.T,error) := BaseIF97.Inverses.tofps5(
                p=p,
                s=s,
                relds=1.0e-7);
            assert(error == 0, "Error in inverse iteration of steam tables");
            g := BaseIF97.Basic.g5(p, aux.T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.dpT := -aux.vt/aux.vp;
            aux.x := 1.0;
          else
            assert(false, "Error in region computation of IF97 steam tables" +
              "(p = " + String(p) + ", s = " + String(s) + ")");
          end if;
        end waterBaseProp_ps;

        function rho_props_ps
          "Density as function of pressure and specific entropy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output SI.Density rho "Density";
        algorithm
          rho := properties.rho;
          annotation (Inline=false, LateInline=true);
        end rho_props_ps;

        function rho_ps "Density as function of pressure and specific entropy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Density rho "Density";
        algorithm
          rho := rho_props_ps(
              p,
              s,
              waterBaseProp_ps(
                p,
                s,
                phase,
                region));
          annotation (Inline=true);
        end rho_ps;

        function T_props_ps
          "Temperature as function of pressure and specific entropy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output SI.Temperature T "Temperature";
        algorithm
          T := properties.T;
          annotation (Inline=false, LateInline=true);
        end T_props_ps;

        function T_ps
          "Temperature as function of pressure and specific entropy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Temperature T "Temperature";
        algorithm
          T := T_props_ps(
              p,
              s,
              waterBaseProp_ps(
                p,
                s,
                phase,
                region));
          annotation (Inline=true);
        end T_ps;

        function h_props_ps
          "Specific enthalpy as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation (Inline=false, LateInline=true);
        end h_props_ps;

        function h_ps
          "Specific enthalpy as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_ps(
              p,
              s,
              waterBaseProp_ps(
                p,
                s,
                phase,
                region));
          annotation (Inline=true);
        end h_ps;

        function rho_props_ph
          "Density as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output SI.Density rho "Density";
        algorithm
          rho := properties.rho;
          annotation (
            derivative(noDerivative=properties) = rho_ph_der,
            Inline=false,
            LateInline=true);
        end rho_props_ph;

        function rho_ph "Density as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Density rho "Density";
        algorithm
          rho := rho_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end rho_ph;

        function rho_ph_der "Derivative function of rho_ph"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real rho_der "Derivative of density";
        algorithm
          if (aux.region == 4) then
            rho_der := (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T))*p_der
               + (-aux.rho*aux.rho/(aux.dpT*aux.T))*h_der;
          elseif (aux.region == 3) then
            rho_der := ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho*aux.rho*aux.pd*
              aux.cv + aux.T*aux.pt*aux.pt))*p_der + (-aux.rho*aux.rho*aux.pt/(aux.rho
              *aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
          else
            //regions 1,2,5
            rho_der := (-aux.rho*aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt
              *aux.vt)/aux.cp)*p_der + (-aux.rho*aux.rho*aux.vt/(aux.cp))*h_der;
          end if;
        end rho_ph_der;

        function T_props_ph
          "Temperature as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output SI.Temperature T "Temperature";
        algorithm
          T := properties.T;
          annotation (
            derivative(noDerivative=properties) = T_ph_der,
            Inline=false,
            LateInline=true);
        end T_props_ph;

        function T_ph
          "Temperature as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Temperature T "Temperature";
        algorithm
          T := T_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end T_ph;

        function T_ph_der "Derivative function of T_ph"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real T_der "Derivative of temperature";
        algorithm
          if (aux.region == 4) then
            T_der := 1/aux.dpT*p_der;
          elseif (aux.region == 3) then
            T_der := ((-aux.rho*aux.pd + aux.T*aux.pt)/(aux.rho*aux.rho*aux.pd*aux.cv
               + aux.T*aux.pt*aux.pt))*p_der + ((aux.rho*aux.rho*aux.pd)/(aux.rho*aux.rho
              *aux.pd*aux.cv + aux.T*aux.pt*aux.pt))*h_der;
          else
            //regions 1,2 or 5
            T_der := ((-1/aux.rho + aux.T*aux.vt)/aux.cp)*p_der + (1/aux.cp)*h_der;
          end if;
        end T_ph_der;

        function s_props_ph
          "Specific entropy as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := properties.s;
          annotation (
            derivative(noDerivative=properties) = s_ph_der,
            Inline=false,
            LateInline=true);
        end s_props_ph;

        function s_ph
          "Specific entropy as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end s_ph;

        function s_ph_der
          "Specific entropy as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real s_der "Derivative of entropy";
        algorithm
          s_der := -1/(aux.rho*aux.T)*p_der + 1/aux.T*h_der;
          annotation (Inline=true);
        end s_ph_der;

        function cv_props_ph
          "Specific heat capacity at constant volume as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation (Inline=false, LateInline=true);
        end cv_props_ph;

        function cv_ph
          "Specific heat capacity at constant volume as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end cv_ph;

        function cp_props_ph
          "Specific heat capacity at constant pressure as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := aux.cp;
          annotation (Inline=false, LateInline=true);
        end cp_props_ph;

        function cp_ph
          "Specific heat capacity at constant pressure as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end cp_ph;

        function beta_props_ph
          "Isobaric expansion coefficient as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 or aux.region == 4 then aux.pt/(aux.rho*aux.pd)
             else aux.vt*aux.rho;
          annotation (Inline=false, LateInline=true);
        end beta_props_ph;

        function beta_ph
          "Isobaric expansion coefficient as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end beta_ph;

        function kappa_props_ph
          "Isothermal compressibility factor as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 or aux.region == 4 then 1/(aux.rho*aux.pd)
             else -aux.vp*aux.rho;
          annotation (Inline=false, LateInline=true);
        end kappa_props_ph;

        function kappa_ph
          "Isothermal compressibility factor as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end kappa_ph;

        function velocityOfSound_props_ph
          "Speed of sound as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          // dp/drho at constant s
          v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd*aux.rho*aux.rho*aux.cv
             + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv))) else if aux.region ==
            4 then sqrt(max(0, 1/((aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*
            aux.T)) - 1/aux.rho*aux.rho*aux.rho/(aux.dpT*aux.T)))) else sqrt(max(0, -
            aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*aux.T))));
          annotation (Inline=false, LateInline=true);
        end velocityOfSound_props_ph;

        function velocityOfSound_ph
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end velocityOfSound_ph;

        function isentropicExponent_props_ph
          "Isentropic exponent as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho
             + aux.pt*aux.pt*aux.T)/(aux.cv)) else if aux.region == 4 then 1/(aux.rho
            *p)*aux.dpT*aux.dpT*aux.T/aux.cv else -1/(aux.rho*aux.p)*aux.cp/(aux.vp*
            aux.cp + aux.vt*aux.vt*aux.T);
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_props_ph;

        function isentropicExponent_ph
          "Isentropic exponent as function of pressure and specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_ph(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_ph;

        function ddph_props "Density derivative by pressure"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.DerDensityByPressure ddph "Density derivative by pressure";
        algorithm
          ddph := if aux.region == 3 then ((aux.rho*(aux.cv*aux.rho + aux.pt))/(aux.rho
            *aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)) else if aux.region == 4
             then (aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT*aux.T)) else (-aux.rho
            *aux.rho*(aux.vp*aux.cp - aux.vt/aux.rho + aux.T*aux.vt*aux.vt)/aux.cp);
          annotation (Inline=false, LateInline=true);
        end ddph_props;

        function ddph "Density derivative by pressure"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.DerDensityByPressure ddph "Density derivative by pressure";
        algorithm
          ddph := ddph_props(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end ddph;

        function ddhp_props "Density derivative by specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.DerDensityByEnthalpy ddhp
            "Density derivative by specific enthalpy";
        algorithm
          ddhp := if aux.region == 3 then -aux.rho*aux.rho*aux.pt/(aux.rho*aux.rho*
            aux.pd*aux.cv + aux.T*aux.pt*aux.pt) else if aux.region == 4 then -aux.rho
            *aux.rho/(aux.dpT*aux.T) else -aux.rho*aux.rho*aux.vt/(aux.cp);
          annotation (Inline=false, LateInline=true);
        end ddhp_props;

        function ddhp "Density derivative by specific enthalpy"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.DerDensityByEnthalpy ddhp
            "Density derivative by specific enthalpy";
        algorithm
          ddhp := ddhp_props(
              p,
              h,
              waterBaseProp_ph(
                p,
                h,
                phase,
                region));
          annotation (Inline=true);
        end ddhp;

        function waterBaseProp_pT
          "Intermediate property record for water (p and T preferred states)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
        algorithm
          aux.phase := 1;
          aux.region := if region == 0 then BaseIF97.Regions.region_pT(p=p, T=T)
             else region;
          aux.R := BaseIF97.data.RH2O;
          aux.p := p;
          aux.T := T;
          if (aux.region == 1) then
            g := BaseIF97.Basic.g1(p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 0.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 2) then
            g := BaseIF97.Basic.g2(p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 1.0;
            aux.dpT := -aux.vt/aux.vp;
          elseif (aux.region == 3) then
            (aux.rho,error) := BaseIF97.Inverses.dofpt3(
                p=p,
                T=T,
                delp=1.0e-7);
            f := BaseIF97.Basic.f3(aux.rho, T);
            aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
            aux.s := aux.R*(f.tau*f.ftau - f.f);
            aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
            aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
            aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
            aux.x := 0.0;
            aux.dpT := aux.pt;
            /*safety against div-by-0 in initialization*/
          elseif (aux.region == 5) then
            g := BaseIF97.Basic.g5(p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 1.0;
            aux.dpT := -aux.vt/aux.vp;
          else
            assert(false, "Error in region computation of IF97 steam tables" +
              "(p = " + String(p) + ", T = " + String(T) + ")");
          end if;
        end waterBaseProp_pT;

        function rho_props_pT "Density as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.Density rho "Density";
        algorithm
          rho := aux.rho;
          annotation (
            derivative(noDerivative=aux) = rho_pT_der,
            Inline=false,
            LateInline=true);
        end rho_props_pT;

        function rho_pT "Density as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Density rho "Density";
        algorithm
          rho := rho_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end rho_pT;

        function h_props_pT
          "Specific enthalpy as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation (
            derivative(noDerivative=aux) = h_pT_der,
            Inline=false,
            LateInline=true);
        end h_props_pT;

        function h_pT
          "Specific enthalpy as function or pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end h_pT;

        function h_pT_der "Derivative function of h_pT"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          output Real h_der "Derivative of specific enthalpy";
        algorithm
          if (aux.region == 3) then
            h_der := ((-aux.rho*aux.pd + T*aux.pt)/(aux.rho*aux.rho*aux.pd))*p_der +
              ((aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*aux.rho
              *aux.pd))*T_der;
          else
            //regions 1,2 or 5
            h_der := (1/aux.rho - aux.T*aux.vt)*p_der + aux.cp*T_der;
          end if;
        end h_pT_der;

        function rho_pT_der "Derivative function of rho_pT"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          output Real rho_der "Derivative of density";
        algorithm
          if (aux.region == 3) then
            rho_der := (1/aux.pd)*p_der - (aux.pt/aux.pd)*T_der;
          else
            //regions 1,2 or 5
            rho_der := (-aux.rho*aux.rho*aux.vp)*p_der + (-aux.rho*aux.rho*aux.vt)*
              T_der;
          end if;
        end rho_pT_der;

        function s_props_pT
          "Specific entropy as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := aux.s;
          annotation (Inline=false, LateInline=true);
        end s_props_pT;

        function s_pT "Temperature as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end s_pT;

        function cv_props_pT
          "Specific heat capacity at constant volume as function of pressure and temperature"

          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation (Inline=false, LateInline=true);
        end cv_props_pT;

        function cv_pT
          "Specific heat capacity at constant volume as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end cv_pT;

        function cp_props_pT
          "Specific heat capacity at constant pressure as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := if aux.region == 3 then (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt
            *aux.pt)/(aux.rho*aux.rho*aux.pd) else aux.cp;
          annotation (Inline=false, LateInline=true);
        end cp_props_pT;

        function cp_pT
          "Specific heat capacity at constant pressure as function of pressure and temperature"

          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end cp_pT;

        function beta_props_pT
          "Isobaric expansion coefficient as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 then aux.pt/(aux.rho*aux.pd) else aux.vt*aux.rho;
          annotation (Inline=false, LateInline=true);
        end beta_props_pT;

        function beta_pT
          "Isobaric expansion coefficient as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end beta_pT;

        function kappa_props_pT
          "Isothermal compressibility factor as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 then 1/(aux.rho*aux.pd) else -aux.vp*aux.rho;
          annotation (Inline=false, LateInline=true);
        end kappa_props_pT;

        function kappa_pT
          "Isothermal compressibility factor as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end kappa_pT;

        function velocityOfSound_props_pT
          "Speed of sound as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          // dp/drho at constant s
          v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd*aux.rho*aux.rho*aux.cv
             + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv))) else sqrt(max(0, -aux.cp
            /(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*aux.T))));
          annotation (Inline=false, LateInline=true);
        end velocityOfSound_props_pT;

        function velocityOfSound_pT
          "Speed of sound as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=true);
        end velocityOfSound_pT;

        function isentropicExponent_props_pT
          "Isentropic exponent as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1/(aux.rho*p)*((aux.pd*aux.cv*aux.rho*aux.rho
             + aux.pt*aux.pt*aux.T)/(aux.cv)) else -1/(aux.rho*aux.p)*aux.cp/(aux.vp*
            aux.cp + aux.vt*aux.vt*aux.T);
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_props_pT;

        function isentropicExponent_pT
          "Isentropic exponent as function of pressure and temperature"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_pT(
              p,
              T,
              waterBaseProp_pT(
                p,
                T,
                region));
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_pT;

        function waterBaseProp_dT
          "Intermediate property record for water (d and T preferred states)"
          extends Modelica.Icons.Function;
          input SI.Density rho "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region=0
            "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          SI.SpecificEnthalpy h_liq "Liquid specific enthalpy";
          SI.Density d_liq "Liquid density";
          SI.SpecificEnthalpy h_vap "Vapour specific enthalpy";
          SI.Density d_vap "Vapour density";
          Common.GibbsDerivs g
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.PhaseBoundaryProperties liq
            "Phase boundary property record";
          Modelica.Media.Common.PhaseBoundaryProperties vap
            "Phase boundary property record";
          Modelica.Media.Common.GibbsDerivs gl
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.GibbsDerivs gv
            "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv
            "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
        algorithm
          aux.region := if region == 0 then (if phase == 2 then 4 else
            BaseIF97.Regions.region_dT(
              d=rho,
              T=T,
              phase=phase)) else region;
          aux.phase := if aux.region == 4 then 2 else 1;
          aux.R := BaseIF97.data.RH2O;
          aux.rho := rho;
          aux.T := T;
          if (aux.region == 1) then
            (aux.p,error) := BaseIF97.Inverses.pofdt125(
                d=rho,
                T=T,
                reldd=1.0e-8,
                region=1);
            g := BaseIF97.Basic.g1(aux.p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 0.0;
          elseif (aux.region == 2) then
            (aux.p,error) := BaseIF97.Inverses.pofdt125(
                d=rho,
                T=T,
                reldd=1.0e-8,
                region=2);
            g := BaseIF97.Basic.g2(aux.p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
            aux.x := 1.0;
          elseif (aux.region == 3) then
            f := BaseIF97.Basic.f3(rho, T);
            aux.p := aux.R*rho*T*f.delta*f.fdelta;
            aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
            aux.s := aux.R*(f.tau*f.ftau - f.f);
            aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
            aux.pt := aux.R*rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
            aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*
              aux.rho*aux.pd);
            aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
            aux.x := 0.0;
          elseif (aux.region == 4) then
            aux.p := BaseIF97.Basic.psat(T);
            d_liq := rhol_T(T);
            d_vap := rhov_T(T);
            h_liq := hl_p(aux.p);
            h_vap := hv_p(aux.p);
            aux.x := if (d_vap <> d_liq) then (1/rho - 1/d_liq)/(1/d_vap - 1/d_liq)
               else 1.0;
            aux.h := h_liq + aux.x*(h_vap - h_liq);
            if T < BaseIF97.data.TLIMIT1 then
              gl := BaseIF97.Basic.g1(aux.p, T);
              gv := BaseIF97.Basic.g2(aux.p, T);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
            else
              fl := BaseIF97.Basic.f3(d_liq, T);
              fv := BaseIF97.Basic.f3(d_vap, T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
            end if;
            aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d -
              vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.s := liq.s + aux.x*(vap.s - liq.s);
            aux.cv := Common.cv2Phase(
                liq,
                vap,
                aux.x,
                aux.T,
                aux.p);
            aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
          elseif (aux.region == 5) then
            (aux.p,error) := BaseIF97.Inverses.pofdt125(
                d=rho,
                T=T,
                reldd=1.0e-8,
                region=5);
            g := BaseIF97.Basic.g2(aux.p, T);
            aux.h := aux.R*aux.T*g.tau*g.gtau;
            aux.s := aux.R*(g.tau*g.gtau - g.g);
            aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
            aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
            aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
            aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
            aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
               - g.tau*g.gtaupi)/g.gpipi));
          else
            assert(false, "Error in region computation of IF97 steam tables" +
              "(rho = " + String(rho) + ", T = " + String(T) + ")");
          end if;
        end waterBaseProp_dT;

        function h_props_dT
          "Specific enthalpy as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation (
            derivative(noDerivative=aux) = h_dT_der,
            Inline=false,
            LateInline=true);
        end h_props_dT;

        function h_dT
          "Specific enthalpy as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end h_dT;

        function h_dT_der "Derivative function of h_dT"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real d_der "Derivative of density";
          input Real T_der "Derivative of temperature";
          output Real h_der "Derivative of specific enthalpy";
        algorithm
          if (aux.region == 3) then
            h_der := ((-d*aux.pd + T*aux.pt)/(d*d))*d_der + ((aux.cv*d + aux.pt)/d)*
              T_der;
          elseif (aux.region == 4) then
            h_der := T*aux.dpT/(d*d)*d_der + ((aux.cv*d + aux.dpT)/d)*T_der;
          else
            //regions 1,2 or 5
            h_der := (-(-1/d + T*aux.vt)/(d*d*aux.vp))*d_der + ((aux.vp*aux.cp - aux.vt
              /d + T*aux.vt*aux.vt)/aux.vp)*T_der;
          end if;
        end h_dT_der;

        function p_props_dT "Pressure as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.Pressure p "Pressure";
        algorithm
          p := aux.p;
          annotation (
            derivative(noDerivative=aux) = p_dT_der,
            Inline=false,
            LateInline=true);
        end p_props_dT;

        function p_dT "Pressure as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Pressure p "Pressure";
        algorithm
          p := p_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end p_dT;

        function p_dT_der "Derivative function of p_dT"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real d_der "Derivative of density";
          input Real T_der "Derivative of temperature";
          output Real p_der "Derivative of pressure";
        algorithm
          if (aux.region == 3) then
            p_der := aux.pd*d_der + aux.pt*T_der;
          elseif (aux.region == 4) then
            p_der := aux.dpT*T_der;
            /*density derivative is 0.0*/
          else
            //regions 1,2 or 5
            p_der := (-1/(d*d*aux.vp))*d_der + (-aux.vt/aux.vp)*T_der;
          end if;
        end p_dT_der;

        function s_props_dT
          "Specific entropy as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := aux.s;
          annotation (Inline=false, LateInline=true);
        end s_props_dT;

        function s_dT "Temperature as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end s_dT;

        function cv_props_dT
          "Specific heat capacity at constant volume as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation (Inline=false, LateInline=true);
        end cv_props_dT;

        function cv_dT
          "Specific heat capacity at constant volume as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end cv_dT;

        function cp_props_dT
          "Specific heat capacity at constant pressure as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := aux.cp;
          annotation (Inline=false, LateInline=true);
        end cp_props_dT;

        function cp_dT
          "Specific heat capacity at constant pressure as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end cp_dT;

        function beta_props_dT
          "Isobaric expansion coefficient as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 or aux.region == 4 then aux.pt/(aux.rho*aux.pd)
             else aux.vt*aux.rho;
          annotation (Inline=false, LateInline=true);
        end beta_props_dT;

        function beta_dT
          "Isobaric expansion coefficient as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.RelativePressureCoefficient beta
            "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end beta_dT;

        function kappa_props_dT
          "Isothermal compressibility factor as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 or aux.region == 4 then 1/(aux.rho*aux.pd)
             else -aux.vp*aux.rho;
          annotation (Inline=false, LateInline=true);
        end kappa_props_dT;

        function kappa_dT
          "Isothermal compressibility factor as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.IsothermalCompressibility kappa
            "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end kappa_dT;

        function velocityOfSound_props_dT
          "Speed of sound as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          // dp/drho at constant s
          v_sound := if aux.region == 3 then sqrt(max(0, ((aux.pd*aux.rho*aux.rho*aux.cv
             + aux.pt*aux.pt*aux.T)/(aux.rho*aux.rho*aux.cv)))) else if aux.region
             == 4 then sqrt(max(0, 1/((aux.rho*(aux.rho*aux.cv/aux.dpT + 1.0)/(aux.dpT
            *aux.T)) - 1/aux.rho*aux.rho*aux.rho/(aux.dpT*aux.T)))) else sqrt(max(0,
            -aux.cp/(aux.rho*aux.rho*(aux.vp*aux.cp + aux.vt*aux.vt*aux.T))));
          annotation (Inline=false, LateInline=true);
        end velocityOfSound_props_dT;

        function velocityOfSound_dT
          "Speed of sound as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=true);
        end velocityOfSound_dT;

        function isentropicExponent_props_dT
          "Isentropic exponent as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1/(aux.rho*aux.p)*((aux.pd*aux.cv*aux.rho*
            aux.rho + aux.pt*aux.pt*aux.T)/(aux.cv)) else if aux.region == 4 then 1/(
            aux.rho*aux.p)*aux.dpT*aux.dpT*aux.T/aux.cv else -1/(aux.rho*aux.p)*aux.cp
            /(aux.vp*aux.cp + aux.vt*aux.vt*aux.T);
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_props_dT;

        function isentropicExponent_dT
          "Isentropic exponent as function of density and temperature"
          extends Modelica.Icons.Function;
          input SI.Density d "Density";
          input SI.Temperature T "Temperature";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_dT(
              d,
              T,
              waterBaseProp_dT(
                d,
                T,
                phase,
                region));
          annotation (Inline=false, LateInline=true);
        end isentropicExponent_dT;

        function hl_p = BaseIF97.Regions.hl_p
          "Compute the saturated liquid specific h(p)";

        function hv_p = BaseIF97.Regions.hv_p
          "Compute the saturated vapour specific h(p)";

        function rhol_T = BaseIF97.Regions.rhol_T
          "Compute the saturated liquid d(T)";

        function rhov_T = BaseIF97.Regions.rhov_T
          "Compute the saturated vapour d(T)";

        function dynamicViscosity = BaseIF97.Transport.visc_dTp
          "Compute eta(d,T) in the one-phase region";

        function thermalConductivity = BaseIF97.Transport.cond_dTp
          "Compute lambda(d,T,p) in the one-phase region";

        function surfaceTension = BaseIF97.Transport.surfaceTension
          "Compute sigma(T) at saturation T";

        function isentropicEnthalpy
          "Isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Integer phase=0
            "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region=0
            "If 0, region is unknown, otherwise known and this input";
          output SI.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := isentropicEnthalpy_props(
              p,
              s,
              waterBaseProp_ps(
                p,
                s,
                phase,
                region));
          annotation (Inline=true);
        end isentropicEnthalpy;

        function isentropicEnthalpy_props
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output SI.SpecificEnthalpy h "Isentropic enthalpy";
        algorithm
          h := aux.h;
          annotation (
            derivative(noDerivative=aux) = isentropicEnthalpy_der,
            Inline=false,
            LateInline=true);
        end isentropicEnthalpy_props;

        function isentropicEnthalpy_der
          "Derivative of isentropic specific enthalpy from p,s"
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Pressure derivative";
          input Real s_der "Entropy derivative";
          output Real h_der "Specific enthalpy derivative";
        algorithm
          h_der := 1/aux.rho*p_der + aux.T*s_der;
          annotation (Inline=true);
        end isentropicEnthalpy_der;
        annotation (Documentation(info="<HTML>
      <h4>Package description:</h4>
      <p>This package provides high accuracy physical properties for water according
      to the IAPWS/IF97 standard. It has been part of the ThermoFluid Modelica library and been extended,
      reorganized and documented to become part of the Modelica Standard library.</p>
      <p>An important feature that distinguishes this implementation of the IF97 steam property standard
      is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
      performance has been of high importance. This means that there often exist several ways to get the same result
      from different functions if one of the functions is called often but can be optimized for that purpose.
      </p>
      <p>
      The original documentation of the IAPWS/IF97 steam properties can freely be distributed with computer
      implementations, so for curious minds the complete standard documentation is provided with the Modelica
      properties library. The following documents are included
      (in directory Modelica/Resources/Documentation/Media/Water/IF97documentation):
      </p>
      <ul>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (in IF97_Utilities.BaseIF97.IceBoundaries)</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
      <li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
      </ul>
      <h4>Package contents
      </h4>
      <ul>
      <li>Package <b>BaseIF97</b> contains the implementation of the IAPWS-IF97 as described in
      <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a>. The explicit backwards equations for region 3 from
      <a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> are implemented as initial values for an inverse iteration of the exact
      function in IF97 for the input pairs (p,h) and (p,s).
      The low-level functions in BaseIF97 are not needed for standard simulation usage,
      but can be useful for experts and some special purposes.</li>
      <li>Function <b>water_ph</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy enthalpy h as dynamic states in the record ThermoProperties_ph. </li>
      <li>Function <b>water_ps</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and specific entropy s as dynamic states in the record ThermoProperties_ps. </li>
      <li>Function <b>water_dT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using density d and temperature T as dynamic states in the record ThermoProperties_dT. </li>
      <li>Function <b>water_pT</b> returns all properties needed for a dynamic control volume model and properties of general
      interest using pressure p and temperature T as dynamic states in the record ThermoProperties_pT. Due to the coupling of
      pressure and temperature in the two-phase region, this model can obviously
      only be used for one-phase models or models treating both phases independently.</li>
      <li>Function <b>hl_p</b> computes the liquid specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>hv_p</b> computes the vapour specific enthalpy as a function of pressure. For overcritical pressures,
      the critical specific enthalpy is returned</li>
      <li>Function <b>sl_p</b> computes the liquid specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropy is returned</li>
      <li>Function <b>sv_p</b> computes the vapour  specific entropy as a function of pressure. For overcritical pressures,
      the critical  specific entropy is returned</li>
      <li>Function <b>rhol_T</b> computes the liquid density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>rhol_T</b> computes the vapour density as a function of temperature. For overcritical temperatures,
      the critical density is returned</li>
      <li>Function <b>dynamicViscosity</b> computes the dynamic viscosity as a function of density and temperature.</li>
      <li>Function <b>thermalConductivity</b> computes the thermal conductivity as a function of density, temperature and pressure.
      <b>Important note</b>: Obviously only two of the three
      inputs are really needed, but using three inputs speeds up the computation and the three variables
      are known in most models anyways. The inputs d,T and p have to be consistent.</li>
      <li>Function <b>surfaceTension</b> computes the surface tension between vapour
          and liquid water as a function of temperature.</li>
      <li>Function <b>isentropicEnthalpy</b> computes the specific enthalpy h(p,s,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary.</li>
      <li>Function <b>dynamicIsentropicEnthalpy</b> computes the specific enthalpy h(p,s,,dguess,Tguess,phase) in all regions.
          The phase input is needed due to discontinuous derivatives at the phase boundary. Tguess and dguess are initial guess
          values for the density and temperature consistent with p and s. This function should be preferred in
          dynamic simulations where good guesses are often available.</li>
      </ul>
      <h4>Version Info and Revision history
      </h4>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by Hubertus Tummescheit for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions:   <i>December, 2002</i>
      by <a href=\"mailto:Hubertus.Tummescheit@modelon.se\">Hubertus Tummescheit</a> and moved to Modelica
      properties library.</li>
      </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
      </address>
      </HTML>",       revisions="<h4>Intermediate release notes during development</h4>
<p>Currently the Events/noEvents switch is only implemented for p-h states. Only after testing that implementation, it will be extended to dT.</p>"));
      end IF97_Utilities;
    annotation (Documentation(info="<html>
<p>This package contains different medium models for water:</p>
<ul>
<li><b>ConstantPropertyLiquidWater</b><br>
    Simple liquid water medium (incompressible, constant data).</li>
<li><b>IdealSteam</b><br>
    Steam water medium as ideal gas from Media.IdealGases.SingleGases.H2O</li>
<li><b>WaterIF97 derived models</b><br>
    High precision water model according to the IAPWS/IF97 standard
    (liquid, steam, two phase region). Models with different independent
    variables are provided as well as models valid only
    for particular regions. The <b>WaterIF97_ph</b> model is valid
    in all regions and is the recommended one to use.</li>
</ul>
<h4>Overview of WaterIF97 derived water models</h4>
<p>
The WaterIF97 models calculate medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
It has been part of the ThermoFluid Modelica library and been extended,
reorganized and documented to become part of the Modelica Standard library.</p>
<p>An important feature that distinguishes this implementation of the IF97 steam property standard
is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
performance has been of high importance. This means that there often exist several ways to get the same result
from different functions if one of the functions is called often but can be optimized for that purpose.
</p>
<p>Three variable pairs can be the independent variables of the model:
</p>
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are
    the most natural choice for general applications.
    This is the recommended choice for most general purpose
    applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural
    choice for applications where water is always in the same phase,
    both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit
    variables of the Helmholtz function in the near-critical
    region and can be the best choice for applications with
    super-critical or near-critical states.</li>
</ol>
<p>
The following quantities are always computed in Medium.BaseProperties:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the following functions:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.dynamicViscosity(medium.state)</td>
      <td valign=\"top\">Pa.s</td>
      <td valign=\"top\">dynamic viscosity</td></tr>
  <tr><td valign=\"top\">Medium.thermalConductivity(medium.state)</td>
      <td valign=\"top\">W/(m.K)</td>
      <td valign=\"top\">thermal conductivity</td></tr>
  <tr><td valign=\"top\">Medium.prandtlNumber(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">Prandtl number</td></tr>
  <tr><td valign=\"top\">Medium.specificEntropy(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific entropy</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cp(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cv(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant density</td></tr>
  <tr><td valign=\"top\">Medium.isentropicExponent(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">isentropic exponent</td></tr>
  <tr><td valign=\"top\">Medium.isentropicEnthalpy(pressure, medium.state)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">isentropic enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.velocityOfSound(medium.state)</td>
      <td valign=\"top\">m/s</td>
      <td valign=\"top\">velocity of sound</td></tr>
  <tr><td valign=\"top\">Medium.isobaricExpansionCoefficient(medium.state)</td>
      <td valign=\"top\">1/K</td>
      <td valign=\"top\">isobaric expansion coefficient</td></tr>
  <tr><td valign=\"top\">Medium.isothermalCompressibility(medium.state)</td>
      <td valign=\"top\">1/Pa</td>
      <td valign=\"top\">isothermal compressibility</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_h(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.density_derh_p(medium.state)</td>
      <td valign=\"top\">kg2/(m3.J)</td>
      <td valign=\"top\">derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_T(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant temperature</td></tr>
  <tr><td valign=\"top\">Medium.density_derT_p(medium.state)</td>
      <td valign=\"top\">kg/(m3.K)</td>
      <td valign=\"top\">derivative of density by temperature at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derX(medium.state)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">derivative of density by mass fraction</td></tr>
  <tr><td valign=\"top\">Medium.molarMass(medium.state)</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>More details are given in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>.

Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature.
With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.saturationPressure(T)</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">Saturation pressure at temperature T</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature(p)</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Saturation temperature at pressure p</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature_derp(p)</td>
      <td valign=\"top\">K/Pa</td>
      <td valign=\"top\">Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEnthalpy(sat)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEnthalpy(sat)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEntropy(sat)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEntropy(sat)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleDensity(sat)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewDensity(sat)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at dew point</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleDensity_dPressure(sat)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewDensity_dPressure(sat)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleEnthalpy_dPressure(sat)</td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewEnthalpy_dPressure(sat)</td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.surfaceTension(sat)</td>
      <td valign=\"top\">N/m</td>
      <td valign=\"top\">Surface tension between liquid and vapour phase</td></tr>
</table>
<p>Details on usage and some examples are given in:
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>
<p>Many further properties can be computed. Using the well-known Bridgman's Tables,
all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
<p>
The documentation of the IAPWS/IF97 steam properties can be freely
distributed with computer implementations and are included here
(in directory Modelica/Resources/Documentation/Media/Water/IF97documentation):
</p>
<ul>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (not implemented)</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
</ul>
</html>"));
    end Water;
  annotation (preferredView="info",Documentation(info="<HTML>
<p>
This library contains <a href=\"modelica://Modelica.Media.Interfaces\">interface</a>
definitions for media and the following <b>property</b> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based
     on the same data.</li>
<li> <a href=\"modelica://Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"modelica://Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, ReferenceAir, MoistAir, ReferenceMoistAir.</li>
<li> <a href=\"modelica://Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased incompressible fluid models (properties are defined by tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
<li> <a href=\"modelica://Modelica.Media.CompressibleLiquids\">
     Compressible liquids:</a><br>
     Simple liquid models with linear compressibility</li>
<li> <a href=\"modelica://Modelica.Media.R134a\">Refrigerant Tetrafluoroethane (R134a)</a>.</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a>
     describes how to use a medium model in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a>
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 1998-2013, Modelica Association.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>",   revisions="<html>
<ul>
<li><i>May 16, 2013</i> by Stefan Wischhusen (XRG Simulation):<br/>
    Added new media models Air.ReferenceMoistAir, Air.ReferenceAir, R134a.</li>
<li><i>May 25, 2011</i> by Francesco Casella:<br/>Added min/max attributes to Water, TableBased, MixtureGasNasa, SimpleAir and MoistAir local types.</li>
<li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added individual settings for polynomial fittings of properties.</li>
</ul>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Line(
            points=  {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},{62,-8},{48,-50},{38,-80}},
            color={64,64,64},
            smooth=Smooth.Bezier),
          Line(
            points={{-40,20},{68,20}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-40,20},{-44,88},{-44,88}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{68,20},{86,-58}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-60,-28},{56,-28}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-60,-28},{-74,84},{-74,84}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{56,-28},{70,-80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-76,-80},{38,-80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-76,-80},{-94,-16},{-94,-16}},
            color={175,175,175},
            smooth=Smooth.None)}));
  end Media;

  package Math
    "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  package Icons "Icons for Math"
    extends Modelica.Icons.IconsPackage;

    partial function AxisLeft
        "Basic icon for mathematical function with y-axis on left side"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
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
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={95,
              95,95}),Line(points={{-80,-80},{-88,-80}}, color={95,95,95}),Line(
              points={{-80,-90},{-80,84}}, color={95,95,95}),Text(
                  extent={{-75,104},{-55,84}},
                  lineColor={95,95,95},
                  textString="y"),Polygon(
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
    end AxisLeft;

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

  function acos "Inverse cosine (-1 <= u <= 1)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u;
    output SI.Angle y;

  external "builtin" y=  acos(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,
                49.8},{-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
                {75.2,-62.2},{77.6,-67.5},{80,-80}}, color={0,0,0}),
          Text(
            extent={{-86,-14},{-14,-62}},
            lineColor={192,192,192},
            textString="acos")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,-80},{84,-80}}, color={95,95,
            95}),Polygon(
              points={{98,-80},{82,-74},{82,-86},{98,-80}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},
              {-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},{
              75.2,-62.2},{77.6,-67.5},{80,-80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-30,88},{-5,72}},
              textString=" pi",
              lineColor={0,0,255}),Text(
              extent={{-94,-57},{-74,-77}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{60,-81},{80,-101}},
              textString="+1",
              lineColor={0,0,255}),Text(
              extent={{82,-56},{102,-76}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{-2,80},{84,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{80,82},{80,-86}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = acos(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\">
</p>
</html>"));
  end acos;

  function exp "Exponential, base e"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u;
    output Real y;

  external "builtin" y=  exp(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
          Polygon(
            points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
                {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),
          Text(
            extent={{-86,50},{-14,2}},
            lineColor={192,192,192},
            textString="exp")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,-80.3976},{84,-80.3976}},
            color={95,95,95}),Polygon(
              points={{98,-80.3976},{82,-74.3976},{82,-86.3976},{98,-80.3976}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{
              34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{67.1,
              18.6},{72,38.2},{76,57.6},{80,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-31,72},{-11,88}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-92,-81},{-72,-101}},
              textString="-3",
              lineColor={0,0,255}),Text(
              extent={{66,-81},{86,-101}},
              textString="3",
              lineColor={0,0,255}),Text(
              extent={{2,-69},{22,-89}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{78,-54},{98,-74}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{0,80},{88,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{80,84},{80,-84}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</p>
</html>"));
  end exp;

  function log "Natural (base e) logarithm (u shall be > 0)"
    extends Modelica.Math.Icons.AxisLeft;
    input Real u;
    output Real y;

  external "builtin" y=  log(u);
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
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-78,-80},{-77.2,-50.6},{-76.4,-37},{-75.6,-28},{-74.8,-21.3},
              {-73.2,-11.4},{-70.8,-1.31},{-67.5,8.08},{-62.7,17.9},{-55.5,28},{-45,
              38.1},{-29.8,48.1},{-8.1,58},{24.1,68},{70.7,78.1},{82,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-105,72},{-85,88}},
              textString="3",
              lineColor={0,0,255}),Text(
              extent={{60,-3},{80,-23}},
              textString="20",
              lineColor={0,0,255}),Text(
              extent={{-78,-7},{-58,-27}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{84,26},{104,6}},
              lineColor={95,95,95},
              textString="u"),Text(
              extent={{-100,9},{-80,-11}},
              textString="0",
              lineColor={0,0,255}),Line(
              points={{-80,80},{84,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
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
</html>"));
  end log;
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

  package Utilities
    "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)"
    extends Modelica.Icons.Package;

    package Streams "Read from files and write to files"
      extends Modelica.Icons.Package;

      function error "Print error message and cancel all actions"
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string) annotation(Library="ModelicaExternalC");
        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>error</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Print the string \"string\" as error message and
cancel all actions. Line breaks are characterized
by \"\\n\" in the string.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"));
      end error;
      annotation (
        Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Streams</b> contains functions to input and output strings
to a message window or on files. Note that a string is interpreted
and displayed as html text (e.g., with print(..) or error(..))
if it is enclosed with the Modelica html quotation, e.g.,
</p>
<center>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</center>
<p>
It is a quality of implementation, whether (a) all tags of html are supported
or only a subset, (b) how html tags are interpreted if the output device
does not allow to display formatted text.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td valign=\"top\"> Print string \"string\" or vector of strings to message window or on
           file \"fileName\".</td>
  </tr>
  <tr><td valign=\"top\">stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td valign=\"top\"> Read complete text file and return it as a vector of strings.</td>
  </tr>
  <tr><td valign=\"top\">(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td valign=\"top\">Returns from the file the content of line lineNumber.</td>
  </tr>
  <tr><td valign=\"top\">lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td valign=\"top\">Returns the number of lines in a file.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td valign=\"top\"> Print error message \"string\" to message window
           and cancel all actions</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td valign=\"top\"> Close file if it is still open. Ignore call if
           file is already closed or does not exist. </td>
  </tr>
</table>
<p>
Use functions <b>scanXXX</b> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
to parse a string.
</p>
<p>
If Real, Integer or Boolean values shall be printed
or used in an error message, they have to be first converted
to strings with the builtin operator
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>(...).
Example:
</p>
<pre>
  <b>if</b> x &lt; 0 <b>or</b> x &gt; 1 <b>then</b>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <b>end if</b>;
</pre>
</html>"));
    end Streams;
      annotation (
  Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={1.3835,-4.1418},
        rotation=45.0,
        fillColor={64,64,64},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
      Polygon(
        origin={10.1018,5.218},
        rotation=-45.0,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}),
  Documentation(info="<html>
<p>
This package contains Modelica <b>functions</b> that are
especially suited for <b>scripting</b>. The functions might
be used to work with strings, read data from file, write data
to file or copy, move and remove files.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.UsersGuide\">Modelica.Utilities.User's Guide</a>
     discusses the most important aspects of this library.</li>
<li> <a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
The following main sublibraries are available:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.Files\">Files</a>
     provides functions to operate on files and directories, e.g.,
     to copy, move, remove files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>
     provides functions to read from files and write to files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
     provides functions to operate on strings. E.g.
     substring, find, replace, sort, scanToken.</li>
<li> <a href=\"modelica://Modelica.Utilities.System\">System</a>
     provides functions to interact with the environment.
     E.g., get or set the working directory or environment
     variables and to send a command to the default shell.</li>
</ul>

<p>
Copyright &copy; 1998-2013, Modelica Association, DLR, and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
  end Utilities;

  package Constants
    "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    final constant Real pi=2*Modelica.Math.asin(1.0);

    final constant Real eps=ModelicaServices.Machine.eps
      "Biggest number such that 1.0 + eps = 1.0";

    final constant Real small=ModelicaServices.Machine.small
      "Smallest number such that small and -small are representable on the machine";

    final constant Real inf=ModelicaServices.Machine.inf
      "Biggest Real number such that inf and -inf are representable on the machine";

    final constant SI.Acceleration g_n=9.80665
      "Standard acceleration of gravity on earth";

    final constant Real R(final unit="J/(mol.K)") = 8.314472
      "Molar gas constant";

    final constant NonSI.Temperature_degC T_zero=-273.15
      "Absolute zero temperature";
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

    partial package UtilitiesPackage "Icon for utility packages"
      extends Modelica.Icons.Package;
       annotation (Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={1.3835,-4.1418},
        rotation=45.0,
        fillColor={64,64,64},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
      Polygon(
        origin={10.1018,5.218},
        rotation=-45.0,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}),
      Documentation(info="<html>
<p>This icon indicates a package containing utility classes.</p>
</html>"));
    end UtilitiesPackage;

    partial package TypesPackage
      "Icon for packages containing type definitions"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-12.167,-23},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{12.167,65},{14.167,93},{36.167,89},{24.167,20},{4.167,-30},
                  {14.167,-30},{24.167,-30},{24.167,-40},{-5.833,-50},{-15.833,
                  -30},{4.167,20},{12.167,65}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Polygon(
              origin={2.7403,1.6673},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{49.2597,22.3327},{31.2597,24.3327},{7.2597,18.3327},{-26.7403,
                10.3327},{-46.7403,14.3327},{-48.7403,6.3327},{-32.7403,0.3327},{-6.7403,
                4.3327},{33.2597,14.3327},{49.2597,14.3327},{49.2597,22.3327}},
              smooth=Smooth.Bezier)}));
    end TypesPackage;

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

    partial package Library
      "This icon will be removed in future Modelica versions, use Package instead"
      // extends Modelica.Icons.ObsoleteModel;
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
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p>
</html>"));
    end Library;
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

    package Icons "Icons for SIunits"
      extends Modelica.Icons.IconsPackage;

      partial function Conversion "Base icon for conversion functions"

        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={191,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{30,0}}, color={191,0,0}),
              Polygon(
                points={{90,0},{30,20},{30,-20},{90,0}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-115,155},{115,105}},
                textString="%name",
                lineColor={0,0,255})}));
      end Conversion;
    end Icons;

    package Conversions
      "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Package;

        type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
              final unit="degC")
          "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)"
                                                                                                            annotation(absoluteValue=true);

        type Pressure_bar = Real (final quantity="Pressure", final unit="bar")
          "Absolute pressure in bar";
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

      function to_degC "Convert from Kelvin to degCelsius"
        extends Modelica.SIunits.Icons.Conversion;
        input Temperature Kelvin "Kelvin value";
        output NonSIunits.Temperature_degC Celsius "Celsius value";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-20,100},{-100,20}},
                lineColor={0,0,0},
                textString="K"), Text(
                extent={{100,-20},{20,-100}},
                lineColor={0,0,0},
                textString="degC")}));
      end to_degC;

      function from_degC "Convert from degCelsius to Kelvin"
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-20,100},{-100,20}},
                lineColor={0,0,0},
                textString="degC"),  Text(
                extent={{100,-20},{20,-100}},
                lineColor={0,0,0},
                textString="K")}));
      end from_degC;

      function to_bar "Convert from Pascal to bar"
        extends Modelica.SIunits.Icons.Conversion;
        input Pressure Pa "Pascal value";
        output NonSIunits.Pressure_bar bar "bar value";
      algorithm
        bar := Pa/1e5;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-12,100},{-100,56}},
                lineColor={0,0,0},
                textString="Pa"),     Text(
                extent={{98,-52},{-4,-100}},
                lineColor={0,0,0},
                textString="bar")}));
      end to_bar;
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

    type Length = Real (final quantity="Length", final unit="m");

    type Position = Length;

    type Distance = Length (min=0);

    type Area = Real (final quantity="Area", final unit="m2");

    type Volume = Real (final quantity="Volume", final unit="m3");

    type Time = Real (final quantity="Time", final unit="s");

    type Velocity = Real (final quantity="Velocity", final unit="m/s");

    type Acceleration = Real (final quantity="Acceleration", final unit="m/s2");

    type Mass = Real (
        quantity="Mass",
        final unit="kg",
        min=0);

    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0.0);

    type SpecificVolume = Real (
        final quantity="SpecificVolume",
        final unit="m3/kg",
        min=0.0);

    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");

    type AbsolutePressure = Pressure (min=0.0, nominal = 1e5);

    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);

    type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m");

    type Power = Real (final quantity="Power", final unit="W");

    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
      "Absolute temperature (use type TemperatureDifference for relative temperatures)"
                                                                                                        annotation(absoluteValue=true);

    type Temp_K = ThermodynamicTemperature;

    type Temperature = ThermodynamicTemperature;

    type RelativePressureCoefficient = Real (final quantity=
            "RelativePressureCoefficient", final unit="1/K");

    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");

    type IsothermalCompressibility = Compressibility;

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");

    type CoefficientOfHeatTransfer = Real (final quantity=
            "CoefficientOfHeatTransfer", final unit="W/(m2.K)");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");

    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");

    type SpecificEntropy = Real (final quantity="SpecificEntropy",
                                 final unit="J/(kg.K)");

    type SpecificEnergy = Real (final quantity="SpecificEnergy",
                                final unit="J/kg");

    type SpecificEnthalpy = SpecificEnergy;

    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");

    type DerDensityByPressure = Real (final unit="s2/m2");

    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");

    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");

    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0);

    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);

    type MassFraction = Real (final quantity="MassFraction", final unit="1",
                              min=0, max=1);

    type MoleFraction = Real (final quantity="MoleFraction", final unit="1",
                              min = 0, max = 1);

    type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1");
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

model System "System wide properties"
  // Assumptions
  parameter Boolean allowFlowReversal=true
      "= false to restrict to design flow direction (flangeA -> flangeB)"
    annotation (Evaluate=true);
  parameter ThermoPower.Choices.System.Dynamics Dynamics=ThermoPower.Choices.System.Dynamics.DynamicFreeInitial;
  annotation (
    defaultComponentName="system",
    defaultComponentPrefixes="inner",
    Icon(graphics={Polygon(
          points={{-100,60},{-60,100},{60,100},{100,60},{100,-60},{60,-100},{-60,
              -100},{-100,-60},{-100,60}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-80,40},{80,-20}},
          lineColor={0,0,255},
          textString="system")}));
end System;

package Icons "Icons for ThermoPower library"
  extends Modelica.Icons.Package;

  package Water "Icons for component using water/steam as working fluid"
    extends Modelica.Icons.Package;

    partial model SourceP

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-20,34},{28,-26}},
              lineColor={255,255,255},
              textString="P"),
            Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
    end SourceP;

    partial model Tube

      annotation (Icon(graphics={Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder)}), Diagram(graphics));
    end Tube;

    partial model Valve

      annotation (Icon(graphics={
            Line(
              points={{0,40},{0,0}},
              color={0,0,0},
              thickness=0.5),
            Polygon(
              points={{-80,40},{-80,-40},{0,0},{-80,40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Polygon(
              points={{80,40},{0,0},{80,-40},{80,40}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Rectangle(
              extent={{-20,60},{20,40}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));
    end Valve;

    model SensThrough

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,-20},{40,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-100,-76},{100,-100}}, textString="%name")}));

    end SensThrough;
  end Water;

  partial model HeatFlow

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward)}));
  end HeatFlow;

  partial model MetalWall

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid)}));
  end MetalWall;

  package Gas "Icons for component using water/steam as working fluid"
    extends Modelica.Icons.Package;

    partial model SourceP

      annotation (Icon(graphics={
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-20,34},{28,-26}},
              lineColor={255,255,255},
              textString="P"),
            Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
    end SourceP;

    partial model SourceW

      annotation (Icon(graphics={
            Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-12,-20},{66,0},{-12,20},{34,0},{-12,-20}},
              lineColor={128,128,128},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(extent={{-100,-52},{100,-80}}, textString="%name")}));
    end SourceW;

    partial model Tube

      annotation (Icon(graphics={Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={159,159,223})}), Diagram(graphics));
    end Tube;

    model SensThrough

      annotation (Icon(graphics={
            Rectangle(
              extent={{-40,-20},{40,-60}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Line(points={{0,20},{0,-20}}, color={0,0,0}),
            Ellipse(extent={{-40,100},{40,20}}, lineColor={0,0,0}),
            Line(points={{40,60},{60,60}}),
            Text(extent={{-100,-76},{100,-100}}, textString="%name")}));
    end SensThrough;
  end Gas;
end Icons;

package Functions "Miscellaneous functions"
  extends Modelica.Icons.Package;

  function squareReg
      "Anti-symmetric square approximation with non-zero derivative in the origin"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "Range of significant deviation from x^2*sgn(x)";
    output Real y;
  algorithm
    y := x*sqrt(x*x + delta*delta);

    annotation (Documentation(info="<html>
This function approximates x^2*sgn(x), such that the derivative is non-zero in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = regSquare(x)</td><td>y ~= x^2*sgn(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = regSquare(x)</td><td>y ~= x*delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between x^2 and regSquare(x) is 41% around x=0.01, 0.4% around x=0.1 and 0.005% around x=1.
</p>
</p>
</html>", revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
  end squareReg;

  function smoothSat "Smooth saturation function"
    input Real x;
    input Real xmin "Lower bound of range where y = x";
    input Real xmax "Upper bound of range where y = x";
    input Real dxmin "Width of lower smoothing range";
    input Real dxmax=dxmin "Width of upper smoothing range";
    output Real y;
  algorithm
    y := if x < xmin + dxmin then
           xmin + dxmin - dxmin*(xmin + dxmin - x)/(dxmin^4 + (xmin + dxmin - x)^4)^0.25
         else if x > xmax - dxmax then
           xmax - dxmax + dxmax*(x - xmax + dxmax)/(dxmax^4 + (x - xmax + dxmax)^4)^0.25
         else x;
    annotation (smoothOrder=4, InLine=true);
  end smoothSat;

  function linspaceExt "Extended linspace function handling also the N=1 case"
    input Real x1;
    input Real x2;
    input Integer N;
    output Real vec[N];
  algorithm
    vec := if N == 1 then {x1}
           else linspace(x1, x2, N);
  end linspaceExt;
  annotation (Documentation(info="<HTML>
This package contains general-purpose functions and models
</HTML>"));
end Functions;

  package Choices "Choice enumerations for ThermoPower models"
    extends Modelica.Icons.Package;

    package Flow1D

      type FFtypes = enumeration(
          Kfnom "Kfnom friction factor",
          OpPoint "Friction factor defined by operating point",
          Cfnom "Cfnom friction factor",
          Colebrook "Colebrook's equation",
          NoFriction "No friction")
        "Type, constants and menu choices to select the friction factor";

      type HCtypes = enumeration(
          Middle "Middle of the pipe",
          Upstream "At the inlet",
          Downstream "At the outlet")
        "Type, constants and menu choices to select the location of the hydraulic capacitance";
    end Flow1D;

    package Init "Options for initialisation"

      type Options = enumeration(
          noInit "No initial equations",
          steadyState "Steady-state initialisation",
          steadyStateNoP "Steady-state initialisation except pressures",
          steadyStateNoT "Steady-state initialisation except temperatures",
          steadyStateNoPT
            "Steady-state initialisation except pressures and temperatures")
        "Type, constants and menu choices to select the initialisation options";
    end Init;

    package System

      type Dynamics = enumeration(
          DynamicFreeInitial
            "DynamicFreeInitial -- Dynamic balance, Initial guess value",
          FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed",
          SteadyStateInitial
            "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value",

          SteadyState
            "SteadyState -- Steady state balance, Initial guess value")
        "Enumeration to define definition of balance equations";

    end System;

    package FluidPhase

      type FluidPhases = enumeration(
          Liquid "Liquid",
          Steam "Steam",
          TwoPhases "Two Phases")
        "Type, constants and menu choices to select the fluid phase";
    end FluidPhase;
  end Choices;

  package Examples "Application examples"
    extends Modelica.Icons.ExamplesPackage;

    package HRB "Heat recovery boiler models"
      extends Modelica.Icons.Library;

      package Models
        extends Modelica.Icons.Library;

        model HeatExchanger "Base class for heat exchanger fluid - gas"
          constant Real pi=Modelica.Constants.pi;
          replaceable package GasMedium =
              Modelica.Media.IdealGases.MixtureGases.CombustionAir constrainedby
            Modelica.Media.Interfaces.PartialMedium;
          replaceable package WaterMedium = Water.StandardWater constrainedby
            Modelica.Media.Interfaces.PartialMedium;
          parameter Boolean StaticGasBalances=false;
          parameter Integer Nr = 2 "Number of tube rows";
          parameter Integer Nt = 2 "Number of parallel tubes in each row";
          parameter Length Lt "Length of a tube in a row";
          parameter Length Dint "Internal diameter of each tube";
          parameter Length Dext "External diameter of each tube";
          parameter Density rhom "Density of the tube metal walls";
          parameter SpecificHeatCapacity cm
            "Specific heat capacity of the tube metal walls";
          parameter Area Sb "Cross-section of the boiler (including tubes)";
          final parameter Area Sb_net = Sb - Nr*Nt*Dext*pi*Lt
            "Net cross-section of the boiler";
          parameter Length Lb "Length of the boiler";
          parameter Area St=Dext*pi*Lt*Nt*Nr
            "Total area of the heat exchange surface";
          parameter CoefficientOfHeatTransfer gamma_nom=150
            "Nominal heat transfer coefficient";

          Gas.FlangeA gasIn(redeclare package Medium = GasMedium) annotation (
              Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
          Gas.FlangeB gasOut(redeclare package Medium = GasMedium) annotation (
              Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
          Water.FlangeA waterIn(redeclare package Medium = WaterMedium) annotation (
             Placement(transformation(extent={{-20,80},{20,120}}, rotation=0)));
          Water.FlangeB waterOut(redeclare package Medium = WaterMedium)
            annotation (Placement(transformation(extent={{-20,-120},{20,-80}},
                  rotation=0)));
          Water.Flow1DFV WaterSide(
            redeclare package Medium = WaterMedium,
            Nt=Nt,
            A=pi*Dint^2/4,
            omega=pi*Dint,
            Dhyd=Dint,
            wnom=20,
            Cfnom=0.005,
            L=Lt*Nr,
            N=Nr + 1,
            hstartin=1e5,
            hstartout=2.7e5,
            FFtype=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
            redeclare ThermoPower.Thermal.HeatTransfer.DittusBoelter heatTransfer,
            initOpt=ThermoPower.Choices.Init.Options.noInit,
            dpnom=1000) annotation (Placement(
                transformation(extent={{-20,-70},{20,-30}}, rotation=0)));
          Thermal.MetalTubeFV
                            TubeWalls(
            rint=Dint/2,
            rext=Dext/2,
            rhomcm=rhom*cm,
            lambda=20,
            L=Lt*Nr,
            Nw=Nr,
            Tstart1=300,
            TstartN=340,
            initOpt=ThermoPower.Choices.Init.Options.noInit) "Tube"
            annotation (Placement(transformation(extent={{-20,0},{20,-40}},
                  rotation=0)));
          Gas.Flow1DFV GasSide(
            redeclare package Medium = GasMedium,
            L=Lb,
            omega=St/Lb,
            wnom=10,
            A=Sb,
            Dhyd=St/Lb,
            N=Nr + 1,
            FFtype=ThermoPower.Choices.Flow1D.FFtypes.NoFriction,
            QuasiStatic=StaticGasBalances,
            redeclare
              ThermoPower.Thermal.HeatTransfer.FlowDependentHeatTransferCoefficient
              heatTransfer(gamma_nom=gamma_nom, alpha=0.6),
            initOpt=ThermoPower.Choices.Init.Options.noInit,
            Tstartin=670,
            Tstartout=370) annotation (Placement(transformation(extent={{-20,60},{20,20}},
                             rotation=0)));
          Thermal.CounterCurrentFV
                                 CounterCurrent1(Nw=Nr)    annotation (Placement(
                transformation(extent={{-20,-8},{20,32}},rotation=0)));
        equation
          connect(CounterCurrent1.side2, TubeWalls.ext)
            annotation (Line(points={{0,5.8},{0,5.8},{0,-13.8}},
                                                        color={255,127,0}));
          connect(GasSide.infl, gasIn) annotation (Line(
              points={{-20,40},{-60,40},{-60,0},{-100,0}},
              color={159,159,223},
              thickness=0.5));
          connect(GasSide.outfl, gasOut) annotation (Line(
              points={{20,40},{60,40},{60,0},{100,0}},
              color={159,159,223},
              thickness=0.5));
          connect(WaterSide.outfl, waterOut) annotation (Line(
              points={{20,-50},{40,-50},{40,-70},{0,-70},{0,-100}},
              thickness=0.5,
              color={0,0,255}));
          connect(WaterSide.infl, waterIn) annotation (Line(
              points={{-20,-50},{-40,-50},{-40,70},{0,70},{0,100}},
              thickness=0.5,
              color={0,0,255}));
          connect(GasSide.wall, CounterCurrent1.side1) annotation (Line(
              points={{0,30},{0,18}},
              color={255,127,0},
              smooth=Smooth.None));
          connect(TubeWalls.int, WaterSide.wall) annotation (Line(
              points={{0,-26},{0,-40}},
              color={255,127,0},
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}}),
                    graphics),
            Icon(graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={230,230,230},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{0,-80},{0,-40},{40,-20},{-40,20},{0,40},{0,80}},
                  color={0,0,255},
                  thickness=0.5),
                Text(
                  extent={{-100,-115},{100,-145}},
                  lineColor={85,170,255},
                  textString="%name")}),
            Documentation(revisions="<html>
<ul>
<li><i>12 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Model restructured.</li>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>",     info="<html>
This is the model of a very simple heat exchanger. The modelling assumptions are as follows:
<ul>
<li> The boiler contains <tt>Nr</tt> rows of tubes, connected in series; each one is made of <tt>Nt</tt> identical tubes in parallel. 
<li>Each tube has a length <tt>L</tt>, internal and external diameters <tt>Dint</tt> and <tt>Dext</tt>, and is made of a metal having density <tt>rhom</tt> and a specific heat capacity of <tt>cm</tt>. 
<li>The series connection of the tubes is discretised with <tt>Nr+1</tt> nodes, so that each cell between two nodes corresponds to a single row.
<li>The gas flow is also discretised with <tt>Nr+1</tt> nodes, so that each gas cell interacts with a single tube row. 
<li>The gas flows through a volume having a (net) cross-section <tt>Sb</tt> and a (net) lenght <tt>Lb</tt>. 
<li>Mass and energy dynamic balances are assumed for the water side.
<li>The mass and energy balances for the gas side are either static or dynamic, depending on the value of the <tt>StaticGasBalances</tt> parameter.
<li>The fluid in the water side remains liquid throughout the boiler.
<li>The heat transfer coefficient on the water side is computed by Dittus-Boelter's correlation.
<li>The external heat transfer coefficient is computed according to the simple law declared <tt>Flow1DGasHT</tt>. To change that correlation, it is only necessary to change equations in that model.
</ul>
</html>"));
        end HeatExchanger;

        model HRBPlant "Simple plant model with HRB"
          replaceable package GasMedium =
              Modelica.Media.IdealGases.MixtureGases.CombustionAir constrainedby
            Modelica.Media.Interfaces.PartialMedium;
          replaceable package WaterMedium = Modelica.Media.Water.WaterIF97_ph
            constrainedby Modelica.Media.Interfaces.PartialMedium;
          parameter Time Ts=4 "Temperature sensor time constant";
          Models.HeatExchanger
                        Boiler(
            redeclare package GasMedium = GasMedium,
            Lt=3,
            Dint=0.01,
            Dext=0.012,
            rhom=7800,
            cm=650,
            Sb=8,
            Lb=2,
            redeclare package WaterMedium = WaterMedium,
            StaticGasBalances=false,
            Nt=250,
          Nr=1)                      annotation (Placement(transformation(extent={{
                    -20,-20},{20,20}}, rotation=0)));
          Water.ValveLin Valve(Kv=20/4e5, redeclare package Medium =
              WaterMedium)
            annotation (Placement(transformation(extent={{36,-50},{56,-70}},
                  rotation=0)));
          Water.SinkPressure
                      SinkP1(redeclare package Medium = WaterMedium, p0=100000)
            annotation (Placement(transformation(extent={{70,-70},{90,-50}},
                  rotation=0)));
          Gas.SourceMassFlow
                      SourceW2(
            redeclare package Medium = GasMedium,
            w0=10,
            use_in_w0=true,
            p0=100000,
            T=670) annotation (Placement(transformation(extent={{-96,-10},{-76,10}},
                  rotation=0)));
          Gas.SinkPressure
                    SinkP2(redeclare package Medium = GasMedium, T=300) annotation (
             Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));
          Gas.PressDropLin PressDropLin1(redeclare package Medium = GasMedium, R=
                1000/10) annotation (Placement(transformation(extent={{60,-10},{80,
                    10}}, rotation=0)));
          Water.SensT WaterIn(redeclare package Medium = WaterMedium) annotation (
              Placement(transformation(extent={{-40,44},{-20,64}}, rotation=0)));
          Water.SensT WaterOut(redeclare package Medium = WaterMedium) annotation (
              Placement(transformation(extent={{6,-66},{26,-46}}, rotation=0)));
          Gas.SensT GasOut(redeclare package Medium = GasMedium) annotation (
              Placement(transformation(extent={{30,-6},{50,14}}, rotation=0)));
          Gas.SensT GasIn(redeclare package Medium = GasMedium) annotation (
              Placement(transformation(extent={{-60,-6},{-40,14}}, rotation=0)));
          Water.SourcePressure
                        SourceP1(redeclare package Medium = WaterMedium, p0=500000)
            annotation (Placement(transformation(extent={{-80,40},{-60,60}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput ValveOpening annotation (Placement(
                transformation(extent={{-170,-90},{-150,-70}}, rotation=0),
                iconTransformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Blocks.Interfaces.RealOutput WaterOut_T annotation (Placement(
                transformation(extent={{160,-50},{180,-30}}, rotation=0),
                iconTransformation(extent={{94,-30},{114,-10}})));
          Modelica.Blocks.Interfaces.RealOutput WaterIn_T annotation (Placement(
                transformation(extent={{160,-110},{180,-90}}, rotation=0),
                iconTransformation(extent={{94,-70},{114,-50}})));
          Modelica.Blocks.Interfaces.RealOutput GasOut_T annotation (Placement(
                transformation(extent={{160,90},{180,110}}, rotation=0),
                iconTransformation(extent={{92,50},{112,70}})));
          Modelica.Blocks.Interfaces.RealOutput GasIn_T annotation (Placement(
                transformation(extent={{160,30},{180,50}}, rotation=0),
                iconTransformation(extent={{94,10},{114,30}})));
          Modelica.Blocks.Interfaces.RealInput GasFlowRate annotation (Placement(
                transformation(extent={{-170,70},{-150,90}}, rotation=0),
                iconTransformation(extent={{-110,50},{-90,70}})));
          Modelica.Blocks.Continuous.FirstOrder GasFlowActuator(
            k=1,
            T=1,
            y_start=5,
            initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
                transformation(extent={{-130,70},{-110,90}}, rotation=0)));
          Modelica.Blocks.Continuous.FirstOrder WaterInTSensor(
            k=1,
            T=Ts,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=296) annotation (Placement(transformation(extent={{120,-110},{
                    140,-90}}, rotation=0)));
          Modelica.Blocks.Continuous.FirstOrder WaterOutTSensor(
            k=1,
            T=Ts,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=330) annotation (Placement(transformation(extent={{120,-50},{
                    140,-30}}, rotation=0)));
          Modelica.Blocks.Continuous.FirstOrder GasInTSensor(
            k=1,
            T=Ts,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=670) annotation (Placement(transformation(extent={{120,30},{140,
                    50}}, rotation=0)));
          Modelica.Blocks.Continuous.FirstOrder GasOutTSensor(
            k=1,
            T=Ts,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=350) annotation (Placement(transformation(extent={{120,90},{140,
                    110}}, rotation=0)));
          Modelica.Blocks.Continuous.FirstOrder ValveOpeningActuator(
            k=1,
            T=1,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=1) annotation (Placement(transformation(extent={{-130,-90},{-110,
                    -70}}, rotation=0)));
          inner System system(allowFlowReversal=false)
            annotation (Placement(transformation(extent={{140,140},{160,160}})));
        equation
          connect(GasFlowActuator.y, SourceW2.in_w0) annotation (Line(points={{-109,
                  80},{-92,80},{-92,5}}, color={0,0,127}));
          connect(GasInTSensor.u, GasIn.T) annotation (Line(points={{118,40},{-32,
                  40},{-32,10},{-43,10}}, color={0,0,127}));
          connect(GasOut.T, GasOutTSensor.u) annotation (Line(points={{47,10},{60,
                  10},{60,100},{118,100}}, color={0,0,127}));
          connect(GasOutTSensor.y, GasOut_T)
            annotation (Line(points={{141,100},{170,100}}, color={0,0,127}));
          connect(WaterIn.T, WaterInTSensor.u) annotation (Line(points={{-22,60},{
                  94,60},{94,-100},{118,-100}}, color={0,0,127}));
          connect(WaterOut.T, WaterOutTSensor.u) annotation (Line(points={{24,-50},
                  {24,-40},{118,-40}}, color={0,0,127}));
          connect(WaterOutTSensor.y, WaterOut_T)
            annotation (Line(points={{141,-40},{170,-40}}, color={0,0,127}));
          connect(GasInTSensor.y, GasIn_T)
            annotation (Line(points={{141,40},{170,40}}, color={0,0,127}));
          connect(Valve.cmd, ValveOpeningActuator.y) annotation (Line(points={{46,-68},
                  {46,-80},{-109,-80}}, color={0,0,127}));
          connect(WaterInTSensor.y, WaterIn_T)
            annotation (Line(points={{141,-100},{170,-100}}, color={0,0,127}));
          connect(WaterOut.inlet, Boiler.waterOut) annotation (Line(
              points={{10,-60},{0,-60},{0,-20}},
              thickness=0.5,
              color={0,0,255}));
          connect(Boiler.gasIn, GasIn.outlet) annotation (Line(
              points={{-20,0},{-44,0}},
              color={159,159,223},
              thickness=0.5));
          connect(GasOut.inlet, Boiler.gasOut) annotation (Line(
              points={{34,0},{20,0}},
              color={159,159,223},
              thickness=0.5));
          connect(Boiler.waterIn, WaterIn.outlet) annotation (Line(
              points={{0,20},{0,50},{-24,50}},
              thickness=0.5,
              color={0,0,255}));
          connect(SourceP1.flange, WaterIn.inlet) annotation (Line(
              points={{-60,50},{-36,50}},
              thickness=0.5,
              color={0,0,255}));
          connect(WaterOut.outlet, Valve.inlet) annotation (Line(
              points={{22,-60},{36,-60}},
              thickness=0.5,
              color={0,0,255}));
          connect(Valve.outlet, SinkP1.flange) annotation (Line(
              points={{56,-60},{70,-60}},
              thickness=0.5,
              color={0,0,255}));
          connect(PressDropLin1.outlet, SinkP2.flange) annotation (Line(
              points={{80,0},{100,0}},
              color={159,159,223},
              thickness=0.5));
          connect(GasOut.outlet, PressDropLin1.inlet) annotation (Line(
              points={{46,0},{60,0}},
              color={159,159,223},
              thickness=0.5));
          connect(SourceW2.flange, GasIn.inlet) annotation (Line(
              points={{-76,0},{-56,0}},
              color={159,159,223},
              thickness=0.5));
          connect(GasFlowActuator.u, GasFlowRate)
            annotation (Line(points={{-132,80},{-160,80}}, color={0,0,127}));
          connect(ValveOpeningActuator.u, ValveOpening)
            annotation (Line(points={{-132,-80},{-160,-80}}, color={0,0,127}));
          annotation (
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-160,-160},{160,160}},
                initialScale=0.1), graphics),
            Documentation(revisions="<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>
",       info=
            "<html>
Very simple plant model, providing boundary conditions to the <tt>HRB</tt> model.
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                initialScale=0.1), graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-72,74},{78,-60}},
                  lineColor={0,0,255},
                  lineThickness=0.5,
                  textString="P")}));
        end HRBPlant;
      end Models;

      package Simulators "Simulation models for the HRB example"
          extends Modelica.Icons.ExamplesPackage;

        model OpenLoopSimulator "Open loop plant simulator"

          Models.HRBPlant
                   Plant annotation (Placement(transformation(extent={{-10,-40},
                  {70,40}},  rotation=0)));
          Modelica.Blocks.Sources.Step ValveOpening(
            height=-0.1,
            offset=1,
            startTime=100)
                          annotation (Placement(transformation(extent={{-88,-40},
                    {-68,-20}},rotation=0)));
          Modelica.Blocks.Sources.Ramp GasFlowRate(
            offset=10,
            height=1,
            duration=0.1,
            startTime=200) annotation (Placement(transformation(extent={{-88,18},
                    {-68,38}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput TGoutOutput annotation (Placement(
                transformation(extent={{92,50},{112,70}}, rotation=0),
              iconTransformation(extent={{92,50},{112,70}})));
          Modelica.Blocks.Interfaces.RealOutput TWoutOutput annotation (Placement(
                transformation(extent={{90,-70},{110,-50}}, rotation=0)));
          inner System system
            annotation (Placement(transformation(extent={{40,80},{60,100}})));
        equation
          connect(Plant.GasOut_T, TGoutOutput) annotation (Line(points={{70.8,24},
                {80,24},{80,60},{102,60}},   color={0,0,127}));
          connect(Plant.WaterOut_T, TWoutOutput) annotation (Line(points={{71.6,-8},
                {80,-8},{80,-60},{100,-60}},  color={0,0,127}));
          connect(GasFlowRate.y, Plant.GasFlowRate) annotation (Line(
              points={{-67,28},{-38,28},{-38,24},{-10,24}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(ValveOpening.y, Plant.ValveOpening) annotation (Line(
              points={{-67,-30},{-40,-30},{-40,-24},{-10,-24}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                    graphics),
            experiment(StopTime=300, Tolerance=1e-006),
            Documentation(revisions="<html>
<ul>
<li><i>20 Sep 2013</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    Updated and improved models and documentation.</li>
<li><i>25 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
    First release.</li>
</ul>
</html>
",       info="<html>
<p>This model allows to simulate an open loop transient, using start attributes to select the initial values of the state variables. After about 50s, the plant reaches a steady state. </p>
<p>At time t =100 s, the water valve is closed by 10&percnt;. At time t = 200 s, the gas flow rate is increased by 10&percnt;.</p>
<p>The simulator is provided with external inputs to apply changes to the system input. If the system is simulated alone, these are taken to be zero by default, so the step responses can be computed. If the system is linearized at time t = 99, the A,B,C,D matrices of the linearized model around the initial steady state can be obtained.</p>
</html>"),  __Dymola_experimentSetupOutput,
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}},
                  lineColor={0,0,255})}));
        end OpenLoopSimulator;
      end Simulators;
      annotation (Documentation(revisions="<html>
<ul>
<li><i>26 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a>:<br>
       First release.</li>
</ul>
</html>",   info="<html>
This package contains models of a simple Heat Recovery Boiler. Different simulation models are provided, demonstrating how to initialise and run open-loop as well as closed loop simulations.
</html>"));
    end HRB;
  end Examples;

  package Gas "Models of components with ideal gases as working fluid"

    connector Flange "Flange connector for gas flows"
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
      flow Medium.MassFlowRate m_flow
        "Mass flow rate from the connection point into the component";
      Medium.AbsolutePressure p
        "Thermodynamic pressure in the connection point";
      stream Medium.SpecificEnthalpy h_outflow
        "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
      stream Medium.MassFraction Xi_outflow[Medium.nXi]
        "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      stream Medium.ExtraProperty C_outflow[Medium.nC]
        "Properties c_i/m close to the connection point if m_flow < 0";
      annotation (Icon(graphics), Documentation(info="<HTML>
</HTML>",   revisions="<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end Flange;

    connector FlangeA "A-type flange connector for gas flows"
      extends Flange;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={159,159,223},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}));
    end FlangeA;

    connector FlangeB "B-type flange connector for gas flows"
      extends Flange;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={159,159,223},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={159,159,223},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end FlangeB;
    extends Modelica.Icons.Package;

    model SinkPressure "Pressure sink for gas flows"
      extends Icons.Gas.SourceP;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(
        p(start=p0),
        T(start=T),
        Xi(start=Xnom[1:Medium.nXi]));
      parameter Pressure p0=101325 "Nominal pressure";
      parameter AbsoluteTemperature T=300 "Nominal temperature";
      parameter MassFraction Xnom[Medium.nX]=Medium.reference_X
        "Nominal gas composition";
      parameter HydraulicResistance R=0 "Hydraulic Resistance";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false
        "Use connector input for the pressure"                                   annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_T = false
        "Use connector input for the temperature"                                  annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_X = false
        "Use connector input for the composition"                                  annotation(Dialog(group="External inputs"));

      outer ThermoPower.System system "System wide properties";

      FlangeA flange(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation (Placement(
            transformation(
            origin={-64.5,59.5},
            extent={{-12.5,-12.5},{12.5,12.5}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation (Placement(
            transformation(
            origin={0,90},
            extent={{-10,-12},{10,12}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_X[Medium.nX] if use_in_X annotation (Placement(
            transformation(
            origin={66,59},
            extent={{-13,-14},{13,14}},
            rotation=270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput in_X_internal[Medium.nX];
    equation
      if R == 0 then
        flange.p = gas.p;
      else
        flange.p = gas.p + flange.m_flow*R;
      end if;

      gas.p = in_p0_internal;
      if not use_in_p0 then
        in_p0_internal = p0 "Pressure set by parameter";
      end if;

      gas.T = in_T_internal;
      if not use_in_T then
        in_T_internal = T "Temperature set by parameter";
      end if;

      gas.Xi = in_X_internal[1:Medium.nXi];
      if not use_in_X then
        in_X_internal = Xnom "Composition set by parameter";
      end if;

      flange.h_outflow = gas.h;
      flange.Xi_outflow = gas.Xi;

      // Connect protected connectors to public conditional connectors
      connect(in_p0, in_p0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);

      annotation (Documentation(info="<html>
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the nominal gas composition is given by <tt>Xnom</tt>, whose default value is <tt>Medium.reference_X</tt> .
<p>If <tt>R</tt> is set to zero, the pressure sink is ideal; otherwise, the inlet pressure increases proportionally to the outgoing flowrate.</p>
<p>If the <tt>in_p</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
<p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T</tt>.</p>
<p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>Xnom</tt>.</p>
</html>",   revisions="<html>
<ul>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0fix</tt> and <tt>Tfix</tt> and <tt>Xfix</tt>; the connection of external signals is now detected automatically.</li>
<br> Adapted to Modelica.Media
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end SinkPressure;

    model SourceMassFlow "Flow rate source for gas flows"
      extends Icons.Gas.SourceW;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(
        p(start=p0),
        T(start=T),
        Xi(start=Xnom[1:Medium.nXi]));
      parameter Pressure p0=101325 "Nominal pressure";
      parameter AbsoluteTemperature T=300 "Nominal temperature";
      parameter MassFraction Xnom[Medium.nX]=Medium.reference_X
        "Nominal gas composition";
      parameter MassFlowRate w0=0 "Nominal mass flowrate";
      parameter HydraulicConductance G=0 "HydraulicConductance";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_w0 = false
        "Use connector input for the nominal flow rate" annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_T = false
        "Use connector input for the temperature"                                  annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_X = false
        "Use connector input for the composition"                                  annotation(Dialog(group="External inputs"));
      outer ThermoPower.System system "System wide properties";

      MassFlowRate w "Nominal mass flow rate";

      FlangeB flange(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput in_w0 if use_in_w0 annotation (Placement(
            transformation(
            origin={-60,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation (Placement(
            transformation(
            origin={0,50},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealInput in_X[Medium.nX] if use_in_X annotation (Placement(
            transformation(
            origin={60,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_w0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput in_X_internal[Medium.nX];

    equation
      if G == 0 then
        flange.m_flow = -w;
      else
        flange.m_flow = -w + (flange.p - p0)*G;
      end if;

      w = in_w0_internal;

      if not use_in_w0 then
        in_w0_internal = w0 "Flow rate set by parameter";
      end if;

      gas.T = in_T_internal;
      if not use_in_T then
        in_T_internal = T "Temperature set by parameter";
      end if;

      gas.Xi = in_X_internal[1:Medium.nXi];
      if not use_in_X then
        in_X_internal = Xnom "Composition set by parameter";
      end if;

      flange.p = gas.p;
      flange.h_outflow = gas.h;
      flange.Xi_outflow = gas.Xi;

      // Connect protected connectors to public conditional connectors
      connect(in_w0, in_w0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);

      annotation (Documentation(info="<html>
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the nominal gas composition is given by <tt>Xnom</tt>,whose default value is <tt>Medium.reference_X</tt> .
<p>If <tt>G</tt> is set to zero, the flowrate source is ideal; otherwise, the outgoing flowrate decreases proportionally to the outlet pressure.</p>
<p>If the <tt>in_w0</tt> connector is wired, then the source massflowrate is given by the corresponding signal, otherwise it is fixed to <tt>w0</tt>.</p>
<p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T</tt>.</p>
<p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>Xnom</tt>.</p>
</html>",   revisions="<html>
<ul>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>w0fix</tt> and <tt>Tfix</tt> and <tt>Xfix</tt>; the connection of external signals is now detected automatically.</li> <br> Adapted to Modelica.Media
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),   Diagram(graphics));
    end SourceMassFlow;

    model Flow1DFV "1-dimensional fluid flow model for gas (finite volumes)"
      extends BaseClasses.Flow1DBase;

      Thermal.DHTVolumes wall(N=Nw) annotation (Dialog(enable=false),
          Placement(transformation(extent={{-60,40},{60,60}}, rotation=0)));

      replaceable Thermal.HeatTransfer.IdealHeatTransfer heatTransfer
        constrainedby ThermoPower.Thermal.BaseClasses.DistributedHeatTransferFV(
        redeclare package Medium = Medium,
        final Nf=N, final Nw = Nw, final Nt = Nt,
        final L = L, final A = A, final Dhyd = Dhyd,
        final omega = omega, final wnom = wnom/Nt,
        final w=w*ones(N), final fluidState=gas.state) "Heat transfer model"
        annotation(choicesAllMatching = true);

      Medium.BaseProperties gas[N] "Gas nodal properties";
      Pressure Dpfric "Pressure drop due to friction";
      Length omega_hyd "Wet perimeter (single tube)";
      Real Kf "Friction factor";
      Real Kfl "Linear friction factor";
      Real dwdt "Time derivative of mass flow rate";
      Real Cf "Fanning friction factor";
      MassFlowRate w(start=wnom/Nt) "Mass flowrate (single tube)";
      AbsoluteTemperature Ttilde[N - 1](start=ones(N - 1)*Tstartin + (1:(N - 1))/
            (N - 1)*(Tstartout - Tstartin), each stateSelect=StateSelect.prefer)
        "Temperature state variables";
      AbsoluteTemperature Tin(start=Tstartin);
      Real Xtilde[if UniformComposition or Medium.fixedX then 1 else N - 1, nX](
          start=ones(size(Xtilde, 1), size(Xtilde, 2))*diagonal(Xstart[1:nX]),
          each stateSelect=StateSelect.prefer) "Composition state variables";
      MassFlowRate wbar[N - 1](each start=wnom/Nt);
      Power Q_single[Nw]
        "Heat flows entering the volumes from the lateral boundary (single tube)";
      Velocity u[N] "Fluid velocity";
      Pressure p(start=pstart, stateSelect=StateSelect.prefer);
      Time Tr "Residence time";
      Mass M "Gas Mass (single tube)";
      Mass Mtot "Gas Mass (total)";
      Real Q "Total heat flow through the wall (all Nt tubes)";
    protected
      parameter Length l=L/(N - 1) "Length of a single volume";
      Density rhobar[N - 1] "Fluid average density";
      SpecificVolume vbar[N - 1] "Fluid average specific volume";
      DerDensityByPressure drbdp[N - 1]
        "Derivative of average density by pressure";
      DerDensityByTemperature drbdT1[N - 1]
        "Derivative of average density by left temperature";
      DerDensityByTemperature drbdT2[N - 1]
        "Derivative of average density by right temperature";
      Real drbdX1[N - 1, nX](each unit="kg/m3")
        "Derivative of average density by left composition";
      Real drbdX2[N - 1, nX](each unit="kg/m3")
        "Derivative of average density by right composition";
      Medium.SpecificHeatCapacity cvbar[N - 1] "Average cv";
      Real dMdt[N - 1] "Derivative of mass in a finite volume";
      Medium.SpecificHeatCapacity cv[N];
      Medium.DerDensityByTemperature dddT[N]
        "Derivative of density by temperature";
      Medium.DerDensityByPressure dddp[N] "Derivative of density by pressure";
      Real dddX[N, nX](each unit="kg/m3")
        "Derivative of density by composition";
    equation
      assert(FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction or dpnom > 0,
        "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
      //All equations are referred to a single tube
      // Friction factor selection
      omega_hyd = 4*A/Dhyd;
      if FFtype == ThermoPower.Choices.Flow1D.FFtypes.Kfnom then
        Kf = Kfnom*Kfc;
        Cf = 2*Kf*A^3/(omega_hyd*L);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.OpPoint then
        Kf = dpnom*rhonom/(wnom/Nt)^2*Kfc;
        Cf = 2*Kf*A^3/(omega_hyd*L);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.Cfnom then
        Kf = Cfnom*omega_hyd*L/(2*A^3)*Kfc;
        Cf = Cfnom*Kfc;
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.Colebrook then
        Cf = f_colebrook(
            w,
            Dhyd/A,
            e,
            Medium.dynamicViscosity(gas[integer(N/2)].state))*Kfc;
        Kf = Cf*omega_hyd*L/(2*A^3);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction then
        Cf = 0;
        Kf = 0;
      else
        assert(false, "Unsupported FFtype");
        Cf = 0;
        Kf = 0;
      end if;
      assert(Kf >= 0, "Negative friction coefficient");
      Kfl = wnom/Nt*wnf*Kf "Linear friction factor";

      // Dynamic momentum term
      dwdt = if DynamicMomentum and not QuasiStatic then der(w) else 0;

      sum(dMdt) = (infl.m_flow + outfl.m_flow)/Nt "Mass balance";
      L/A*dwdt + (outfl.p - infl.p) + Dpfric = 0 "Momentum balance";
      Dpfric = (if FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction then 0
                else homotopy((smooth(1, Kf*squareReg(w, wnom/Nt*wnf))*sum(vbar)/(N - 1)),
                               dpnom/(wnom/Nt)*w))
        "Pressure drop due to friction";
      for j in 1:N - 1 loop
        if not QuasiStatic then
          // Dynamic mass and energy balances
          A*l*rhobar[j]*cvbar[j]*der(Ttilde[j]) + wbar[j]*(gas[j + 1].h - gas[j].h)
            = Q_single[j] "Energy balance";
          dMdt[j] = A*l*(drbdp[j]*der(p) + drbdT1[j]*der(gas[j].T) + drbdT2[j]*
            der(gas[j + 1].T) + vector(drbdX1[j, :])*vector(der(gas[j].X)) +
            vector(drbdX2[j, :])*vector(der(gas[j + 1].X))) "Mass balance";
          /*
      dMdt[j] = A*l*(drbdT[j]*der(Ttilde[j]) + drbdp[j]*der(p) + vector(drbdX[j, :])*
      vector(der(Xtilde[if UniformComposition then 1 else j, :])))
      "Mass balance";
*/
          // Average volume quantities
          if avoidInletEnthalpyDerivative and j == 1 then
            // first volume properties computed by the volume outlet properties
            rhobar[j] = gas[j + 1].d;
            drbdp[j] = dddp[j + 1];
            drbdT1[j] = 0;
            drbdT2[j] = dddT[j + 1];
            drbdX1[j, :] = zeros(size(Xtilde, 2));
            drbdX2[j, :] = dddX[j + 1, :];
          else
            // volume properties computed by averaging
            rhobar[j] = (gas[j].d + gas[j + 1].d)/2;
            drbdp[j] = (dddp[j] + dddp[j + 1])/2;
            drbdT1[j] = dddT[j]/2;
            drbdT2[j] = dddT[j + 1]/2;
            drbdX1[j, :] = dddX[j, :]/2;
            drbdX2[j, :] = dddX[j + 1, :]/2;
          end if;
          vbar[j] = 1/rhobar[j];
          wbar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2,
            wnom/Nt);
          cvbar[j] = (cv[j] + cv[j + 1])/2;
        else
          // Static mass and energy balances
          wbar[j]*(gas[j + 1].h - gas[j].h) = Q_single[j] "Energy balance";
          dMdt[j] = 0 "Mass balance";
          // Dummy values for unused average quantities
          rhobar[j] = 0;
          drbdp[j] = 0;
          drbdT1[j] = 0;
          drbdT2[j] = 0;
          drbdX1[j, :] = zeros(nX);
          drbdX2[j, :] = zeros(nX);
          vbar[j] = 0;
          wbar[j] = infl.m_flow/Nt;
          cvbar[j] = 0;
        end if;
      end for;
      Q = Nt*sum(Q_single) "Total heat flow through the lateral boundary";
      if Medium.fixedX then
        Xtilde = fill(Medium.reference_X, 1);
      elseif QuasiStatic then
        Xtilde = fill(gas[1].X, size(Xtilde, 1))
          "Gas composition equal to actual inlet";
      elseif UniformComposition then
        der(Xtilde[1, :]) = homotopy(1/L*sum(u)/N*(gas[1].X - gas[N].X), 1/L*unom
          *(gas[1].X - gas[N].X)) "Partial mass balance for the whole pipe";
      else
        for j in 1:N - 1 loop
          der(Xtilde[j, :]) = homotopy((u[j + 1] + u[j])/(2*l)*(gas[j].X - gas[j
             + 1].X), 1/L*unom*(gas[j].X - gas[j + 1].X))
            "Partial mass balance for single volume";
        end for;
      end if;
      for j in 1:N loop
        u[j] = w/(gas[j].d*A) "Gas velocity";
        gas[j].p = p;
      end for;
      // Fluid property computations
      for j in 1:N loop
        if not QuasiStatic then
          cv[j] = Medium.heatCapacity_cv(gas[j].state);
          dddT[j] = Medium.density_derT_p(gas[j].state);
          dddp[j] = Medium.density_derp_T(gas[j].state);
          if nX > 0 then
            dddX[j, :] = Medium.density_derX(gas[j].state);
          end if;
        else
          // Dummy values (not needed by dynamic equations)
          cv[j] = 0;
          dddT[j] = 0;
          dddp[j] = 0;
          dddX[j, :] = zeros(nX);
        end if;
      end for;

      // Selection of representative pressure and flow rate variables
      if HydraulicCapacitance ==ThermoPower.Choices.Flow1D.HCtypes.Upstream then
        p = infl.p;
        w = -outfl.m_flow/Nt;
      else
        p = outfl.p;
        w = infl.m_flow/Nt;
      end if;

      // Boundary conditions
      Q_single = wall.Q/Nt;
      infl.h_outflow = gas[1].h;
      outfl.h_outflow = gas[N].h;
      infl.Xi_outflow = gas[1].Xi;
      outfl.Xi_outflow = gas[N].Xi;

      gas[1].h = inStream(infl.h_outflow);
      gas[2:N].T = Ttilde;
      gas[1].Xi = inStream(infl.Xi_outflow);
      for j in 2:N loop
        gas[j].Xi = Xtilde[if UniformComposition then 1 else j - 1, 1:nXi];
      end for;

      connect(wall,heatTransfer.wall);

      Tin = gas[1].T;
      M = sum(rhobar)*A*l "Fluid mass (single tube)";
      Mtot = M*Nt "Fluid mass (total)";
      Tr = noEvent(M/max(infl.m_flow/Nt, Modelica.Constants.eps))
        "Residence time";
    initial equation
      if initOpt == Choices.Init.Options.noInit or QuasiStatic then
        // do nothing
      elseif initOpt == Choices.Init.Options.steadyState then
        if (not Medium.singleState) then
          der(p) = 0;
        end if;
        der(Ttilde) = zeros(N - 1);
        if (not Medium.fixedX) then
          der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
        end if;
      elseif initOpt == Choices.Init.Options.steadyStateNoP then
        der(Ttilde) = zeros(N - 1);
        if (not Medium.fixedX) then
          der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
        end if;
      else
        assert(false, "Unsupported initialisation option");
      end if;

      annotation (
        Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
        Diagram(graphics),
        Documentation(info="<html>
<p>This model describes the flow of a gas in a rigid tube. The basic modelling assumptions are:
<ul>
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most power generation applications.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics).
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the pressure drop is lumped either at the inlet or at the outlet.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum and energy balance equation are discretised with the finite volume method. The state variables are one pressure, one flowrate (optional), N-1 temperatures, and either one or N-1 gas composition vectors.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical problems occur in tubes with very low pressure drops.
<p>Flow reversal is fully supported.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater than or equal to 2.
<p>if <tt>UniformComposition</tt> is true, then a uniform compostion is assumed for the gas through the entire tube lenght; otherwise, the gas compostion is computed in <tt>N</tt> equally spaced nodes, as in the case of thermal variables.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul>
<p>If <tt>QuasiStatic</tt> is set to true, the dynamic terms are neglected in the mass, momentum, and energy balances, i.e., quasi-static behaviour is modelled. It is also possible to neglect only the dynamic momentum term by setting <tt>DynamicMomentum = false</tt>.
<p>If <tt>HydraulicCapacitance = 2</tt> (default option) then the mass buildup term depending on the pressure is lumped at the outlet, while the optional momentum buildup term depending on the flowrate is lumped at the inlet; therefore, the state variables are the outlet pressure and the inlet flowrate. If <tt>HydraulicCapacitance = 1</tt> the reverse takes place.
<p>Start values for the pressure and flowrate state variables are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node temperatures are linearly distributed from <tt>Tstartin</tt> at the inlet to <tt>Tstartout</tt> at the outlet. The (uniform) start value of the gas composition is specified by <tt>Xstart</tt>.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions available to connected components through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</html>",   revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>QuasiStatic</tt> added.<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
        DymolaStoredErrors);
    end Flow1DFV;

    model PressDropLin "Linear pressure drop for gas flows"
      extends Icons.Gas.Tube;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      parameter HydraulicResistance R "Hydraulic resistance";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";

      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));

    equation
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";
      inlet.p - outlet.p = R*inlet.m_flow "Flow characteristics";

      // Boundary conditions
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);
      inStream(inlet.Xi_outflow) = outlet.Xi_outflow;
      annotation (
        Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
        Diagram(graphics),
        Documentation(info="<html>
<p>This very simple model provides a pressure drop which is proportional to the flowrate, without computing any fluid property.</p>
</html>",   revisions="<html>
<ul>
<li><i>20 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
        Icon);
    end PressDropLin;

    model SensT "Temperature sensor for gas"
      extends Icons.Gas.SensThrough;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";

      Medium.BaseProperties gas;
      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-80,-60},{-40,-20}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{40,-60},{80,-20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
            transformation(extent={{60,50},{80,70}}, rotation=0)));
    equation
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";
      inlet.p = outlet.p "Momentum balance";

      // Energy balance
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;

      // Independent composition mass balances
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);
      inStream(inlet.Xi_outflow) = outlet.Xi_outflow;

      // Set gas properties
      inlet.p = gas.p;
      gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow)
         else inStream(inlet.h_outflow), inStream(inlet.h_outflow));
      gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow)
         else inStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));

      T = gas.T "Sensor output";
      annotation (
        Documentation(info="<html>
<p>This component can be inserted in a hydraulic circuit to measure the temperature of the fluid flowing through it.
<p>Flow reversal is supported.
<p><b>Modelling options</p></b>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.
</html>",   revisions="<html>
<ul>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
        Diagram(graphics),
        Icon(graphics={Text(
              extent={{-40,84},{38,34}},
              lineColor={0,0,0},
              textString="T")}));
    end SensT;

    function f_colebrook "Fanning friction factor for water/steam flows"
      input MassFlowRate w;
      input Real D_A;
      input Real e;
      input DynamicViscosity mu;
      output Real f;
    protected
      Real Re;
    algorithm
      Re := w*D_A/mu;
      Re := if Re > 2100 then Re else 2100;
      f := 0.332/(log(e/3.7 + 5.47/Re^0.9)^2);
      annotation (Documentation(info="<HTML>
<p>The Fanning friction factor is computed by Colebrook's equation, assuming turbulent, one-phase flow. For low Reynolds numbers, the limit value for turbulent flow is returned.
<p><b>Revision history:</b></p>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
    end f_colebrook;

    package BaseClasses

      partial model Flow1DBase
        "Basic interface for 1-dimensional water/steam fluid flow models"
        extends Icons.Gas.Tube;
        import ThermoPower.Choices.Flow1D.FFtypes;
        import ThermoPower.Choices.Flow1D.HCtypes;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          annotation(choicesAllMatching = true);
        parameter Integer N(min=2) = 2 "Number of nodes for thermal variables";
        final parameter Integer Nw = N - 1
          "Number of volumes on the wall interface";
        parameter Integer Nt=1 "Number of tubes in parallel";
        parameter Distance L "Tube length";
        parameter Position H=0 "Elevation of outlet over inlet";
        parameter Area A "Cross-sectional area (single tube)";
        parameter Length omega
          "Perimeter of heat transfer surface (single tube)";
        parameter Length Dhyd "Hydraulic Diameter (single tube)";
        parameter MassFlowRate wnom "Nominal mass flowrate (total)";
        parameter ThermoPower.Choices.Flow1D.FFtypes FFtype=ThermoPower.Choices.Flow1D.FFtypes.NoFriction
          "Friction Factor Type"
          annotation(Evaluate=true);
        parameter Pressure dpnom = 0 "Nominal pressure drop";
        parameter Real Kfnom=0 "Nominal hydraulic resistance coefficient"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Kfnom)));
        parameter Density rhonom=0 "Nominal inlet density"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.OpPoint)));
        parameter Real Cfnom=0 "Nominal Fanning friction factor"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Cfnom)));
        parameter Real e=0 "Relative roughness (ratio roughness/diameter)";
        parameter Real Kfc=1 "Friction factor correction coefficient";
        parameter Boolean DynamicMomentum=false
          "Inertial phenomena accounted for"
          annotation (Evaluate=true);
        parameter Boolean UniformComposition=true
          "Uniform gas composition is assumed" annotation (Evaluate=true);
        parameter Boolean QuasiStatic=false
          "Quasi-static model (mass, energy and momentum static balances"
          annotation (Evaluate=true);
        parameter HCtypes HydraulicCapacitance=HCtypes.Downstream
          "1: Upstream, 2: Downstream";
        parameter Boolean avoidInletEnthalpyDerivative=true
          "Avoid inlet enthalpy derivative";
        parameter Boolean allowFlowReversal=system.allowFlowReversal
          "= true to allow flow reversal, false restricts to design direction";
        outer ThermoPower.System system "System wide properties";
        parameter Pressure pstart=1e5 "Pressure start value"
          annotation (Dialog(tab="Initialisation"));
        parameter AbsoluteTemperature Tstartbar=300
          "Avarage temperature start value"
          annotation (Dialog(tab="Initialisation"));
        parameter AbsoluteTemperature Tstartin=Tstartbar
          "Inlet temperature start value" annotation (Dialog(tab="Initialisation"));
        parameter AbsoluteTemperature Tstartout=Tstartbar
          "Outlet temperature start value" annotation (Dialog(tab="Initialisation"));
        parameter AbsoluteTemperature Tstart[N]=linspace(
              Tstartin,
              Tstartout,
              N) "Start value of temperature vector (initialized by default)"
          annotation (Dialog(tab="Initialisation"));
        final parameter Velocity unom=10
          "Nominal velocity for simplified equation";
        parameter Real wnf=0.01
          "Fraction of nominal flow rate at which linear friction equals turbulent friction";
        parameter MassFraction Xstart[nX]=Medium.reference_X
          "Start gas composition" annotation (Dialog(tab="Initialisation"));
        parameter Choices.Init.Options initOpt=Choices.Init.Options.noInit
          "Initialisation option" annotation (Dialog(tab="Initialisation"));
        function squareReg = ThermoPower.Functions.squareReg;
      protected
        parameter Integer nXi=Medium.nXi "number of independent mass fractions";
        parameter Integer nX=Medium.nX "total number of mass fractions";
      public
        FlangeA infl(redeclare package Medium = Medium, m_flow(start=wnom, min=if
                allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
           Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
        FlangeB outfl(redeclare package Medium = Medium, m_flow(start=-wnom, max=
                if allowFlowReversal then +Modelica.Constants.inf else 0))
          annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=
                 0)));
      equation
          assert(FFtype == FFtypes.NoFriction or dpnom > 0,
          "dpnom=0 not valid, it is also used in the homotopy trasformation during the inizialization");
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Colebrook)),
          Documentation(info="<HTML>
Basic interface of the <tt>Flow1D</tt> models, containing the common parameters and connectors.
</HTML>
",       revisions="<html>
<ul>
<li><i>7 Apr 2014</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added base class.</li>

</ul>
</html>"),Diagram(graphics),
          Icon(graphics));
      end Flow1DBase;
    end BaseClasses;
    annotation (Documentation(info="<HTML>
This package contains models of physical processes and components using ideal gases as working fluid.
<p>All models with dynamic equations provide initialisation support. Set the <tt>initOpt</tt> parameter to the appropriate value:
<ul>
<li><tt>Choices.Init.Options.noInit</tt>: no initialisation
<li><tt>Choices.Init.Options.steadyState</tt>: full steady-state initialisation
<li><tt>Choices.Init.Options.steadyStateNoP</tt>: steady-state initialisation (except pressure)
<li><tt>Choices.Init.Options.steadyStateNoT</tt>: steady-state initialisation (except temperature)
</ul>
The latter options can be useful when two or more components are connected directly so that they will have the same pressure or temperature, to avoid over-specified systems of initial equations.
</HTML>"));
  end Gas;

  package Thermal "Thermal models of heat transfer"
    extends Modelica.Icons.Package;

    connector DHTVolumes "Distributed Heat Terminal"
      parameter Integer N "Number of volumes";
      AbsoluteTemperature T[N] "Temperature at the volumes";
      flow Power Q[N] "Heat flow at the volumes";
      annotation (Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,127,0},
              fillPattern=FillPattern.Solid)}));
    end DHTVolumes;

    model MetalTubeFV "Cylindrical metal tube model with Nw finite volumes"
      extends Icons.MetalWall;
      parameter Integer Nw = 1 "Number of volumes on the wall ports";
      parameter Integer Nt = 1 "Number of tubes in parallel";
      parameter Length L "Tube length";
      parameter Length rint "Internal radius (single tube)";
      parameter Length rext "External radius (single tube)";
      parameter Real rhomcm "Metal heat capacity per unit volume [J/m^3.K]";
      parameter ThermalConductivity lambda "Thermal conductivity";
      parameter Boolean WallRes=true "Wall conduction resistance accounted for";
      parameter Temperature Tstartbar=300 "Avarage temperature"
        annotation (Dialog(tab="Initialisation"));
      parameter Temperature Tstart1=Tstartbar
        "Temperature start value - first volume"
        annotation (Dialog(tab="Initialisation"));
      parameter Temperature TstartN=Tstartbar
        "Temperature start value - last volume"
        annotation (Dialog(tab="Initialisation"));
     parameter Temperature Tvolstart[Nw]=
       Functions.linspaceExt(Tstart1, TstartN, Nw);
      parameter Choices.Init.Options initOpt=Choices.Init.Options.noInit
        "Initialisation option" annotation (Dialog(tab="Initialisation"));
      constant Real pi=Modelica.Constants.pi;
      //AbsoluteTemperature T[N](start=Tstart) "Node temperatures";
      AbsoluteTemperature Tvol[Nw](start=Tvolstart) "Volume temperatures";
      Area Am "Area of the metal tube cross-section";
      ThermoPower.Thermal.DHTVolumes int(final N=Nw, T(start=Tvolstart))
        "Internal surface"
         annotation (Placement(transformation(extent={{-40,20},{40,40}}, rotation=0)));
      ThermoPower.Thermal.DHTVolumes ext(final N=Nw, T(start=Tvolstart))
        "External surface"
         annotation (Placement(transformation(extent={{-40,-42},{40,-20}}, rotation=0)));
    equation
      assert(rext > rint, "External radius must be greater than internal radius");
      Am = (rext^2 - rint^2)*pi "Area of the metal cross section";
      (L/Nw*Nt)*rhomcm*Am*der(Tvol) = int.Q + ext.Q "Energy balance";
      if WallRes then
        // Thermal resistance of the tube walls accounted for
        int.Q = (lambda*(2*pi*L/Nw)*(int.T - Tvol))/(log((rint + rext)/(2*rint)))*Nt
          "Heat conduction through the internal half-thickness";
        ext.Q = (lambda*(2*pi*L/Nw)*(ext.T - Tvol))/(log((2*rext)/(rint + rext)))*Nt
          "Heat conduction through the external half-thickness";
      else
        // No temperature gradients across the thickness
        ext.T = Tvol;
        int.T = Tvol;
      end if;
    initial equation
      if initOpt == Choices.Init.Options.noInit then
        // do nothing
      elseif initOpt == Choices.Init.Options.steadyState then
        der(Tvol) = zeros(Nw);
      elseif initOpt == Choices.Init.Options.steadyStateNoT then
        // do nothing
      else
        assert(false, "Unsupported initialisation option");
      end if;
      annotation (
        Icon(graphics={
            Text(
              extent={{-100,60},{-40,20}},
              lineColor={0,0,0},
              fillColor={128,128,128},
              fillPattern=FillPattern.Forward,
              textString="Int"),
            Text(
              extent={{-100,-20},{-40,-60}},
              lineColor={0,0,0},
              fillColor={128,128,128},
              fillPattern=FillPattern.Forward,
              textString="Ext"),
            Text(
              extent={{-138,-60},{142,-100}},
              lineColor={191,95,0},
              textString="%name")}),
        Documentation(info="<HTML>
<p>This is the model of a cylindrical tube of solid material.
<p>The heat capacity (which is lumped at the center of the tube thickness) is accounted for, as well as the thermal resistance due to the finite heat conduction coefficient. Longitudinal heat conduction is neglected.
<p><b>Modelling options</b></p>
<p>The following options are available:
<ul>
<li><tt>WallRes = false</tt>: the thermal resistance of the tube wall is neglected.
<li><tt>WallRes = true</tt>: the thermal resistance of the tube wall is accounted for.
</ul>
</HTML>",   revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),     Diagram(graphics));
    end MetalTubeFV;

    model HeatExchangerTopologyFV
      "Connects two DHTVolumes ports according to a selected heat exchanger topology"
      extends Icons.HeatFlow;
      parameter Integer Nw "Number of volumes";
      replaceable HeatExchangerTopologies.CoCurrentFlow HET
        constrainedby ThermoPower.Thermal.BaseClasses.HeatExchangerTopologyData(final Nw = Nw)
        annotation(choicesAllMatching=true);

      Thermal.DHTVolumes side1(final N=Nw) annotation (Placement(transformation(extent={{-40,20},
                {40,40}}, rotation=0)));
      Thermal.DHTVolumes side2(final N=Nw) annotation (Placement(transformation(extent={{-40,-42},
                {40,-20}}, rotation=0)));

    equation
      for j in 1:Nw loop
        side2.T[HET.correspondingVolumes[j]] = side1.T[j];
        side2.Q[HET.correspondingVolumes[j]] + side1.Q[j] = 0;
      end for;
      annotation (
        Diagram(graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
             graphics));
    end HeatExchangerTopologyFV;

    model CounterCurrentFV
      "Connects two DHTVolume ports according to a counter-current flow configuration"
      extends ThermoPower.Thermal.HeatExchangerTopologyFV(
        redeclare HeatExchangerTopologies.CounterCurrentFlow HET);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                       graphics={
            Polygon(
              points={{-74,2},{-48,8},{-74,16},{-56,8},{-74,2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{74,-16},{60,-10},{74,-2},{52,-10},{74,-16}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
                                     Documentation(info="<HTML>
<p>This component can be used to model counter-current heat transfer. The temperature and flux vectors on one side are swapped with respect to the other side. This means that the temperature of node <tt>j</tt> on side 1 is equal to the temperature of note <tt>N-j+1</tt> on side 2; heat fluxes behave correspondingly.
<p>
The swapping is performed if the counterCurrent parameter is true (default value).
</HTML>",   revisions="<html>
<ul>
<li><i>25 Aug 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>counterCurrent</tt> parameter added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>

</html>
"));
    end CounterCurrentFV;

    package HeatTransfer "Heat transfer models"

      model IdealHeatTransfer
        "Delta T across the boundary layer is zero (infinite h.t.c.)"
        extends BaseClasses.DistributedHeatTransferFV(final useAverageTemperature=false);
         Medium.Temperature T[Nf] "Fluid temperature";
      equation
        assert(Nw ==  Nf - 1, "Number of volumes Nw on wall side should be equal to number of volumes fluid side Nf - 1");

        for j in 1:Nw loop
          wall.T[j] = T[j+1] "Ideal infinite heat transfer";
        end for;
      end IdealHeatTransfer;

      model FlowDependentHeatTransferCoefficient
        "Flow-dependent h.t.c. gamma = gamma_nom*(w/wnom)^alpha"
        extends BaseClasses.DistributedHeatTransferFV;

         parameter CoefficientOfHeatTransfer gamma_nom
          "Nominal heat transfer coefficient";
         parameter Real alpha(final unit="1")
          "Exponent in the flow-dependency law";
         parameter Real beta(final unit="1") = 0.1
          "Fraction of nominal flow rate below which the heat transfer is not reduced";
         Medium.Temperature Tvol[Nw] "Fluid temperature in the volumes";
         Power Q "Total heat flow through lateral boundary";
         CoefficientOfHeatTransfer gamma(start = gamma_nom)
          "Actual heat transfer coefficient";
         Real w_wnom(start = 1, final unit = "1")
          "Ratio between actual and nominal flow rate";
      equation
        assert(Nw ==  Nf - 1, "Number of volumes Nw on wall side should be equal to number of volumes fluid side Nf - 1");

        // Computation of actual UA value, with smooth lower saturation to avoid numerical singularities at low flows
        w_wnom = abs(w[1])/wnom
          "Inlet flow rate used for the computation of the conductance";
        gamma = gamma_nom*Functions.smoothSat(w_wnom, beta, 1e9, beta/2)^alpha;

        for j in 1:Nw loop
           Tvol[j] = if useAverageTemperature then (T[j] + T[j + 1])/2 else T[j+1];
           wall.Q[j] = (wall.T[j] - Tvol[j])*gamma*omega*l*Nt;
        end for;

        Q = sum(wall.Q);

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}),
                  graphics),
          Icon(graphics={Text(extent={{-100,-52},{100,-80}}, textString="%name")}));
      end FlowDependentHeatTransferCoefficient;

      model DittusBoelter "Dittus-Boelter heat transfer correlation"
        extends BaseClasses.DistributedHeatTransferFV;
        CoefficientOfHeatTransfer gamma[Nf]
          "Heat transfer coefficients at the nodes";
        CoefficientOfHeatTransfer gamma_vol[Nw]
          "Heat transfer coefficients at the volumes";
        Medium.Temperature Tvol[Nw] "Fluid temperature in the volumes";
        Medium.DynamicViscosity mu[Nf] "Dynamic viscosity";
        Medium.ThermalConductivity k[Nf] "Thermal conductivity";
        Medium.SpecificHeatCapacity cp[Nf] "Heat capacity at constant pressure";
        Power Q "Total heat flow through lateral boundary";

      equation
        assert(Nw == Nf - 1, "Number of volumes Nw on wall side should be equal to number of volumes fluid side Nf - 1");
        // Fluid properties at the nodes
        for j in 1:Nf loop
          mu[j] = Medium.dynamicViscosity(fluidState[j]);
          k[j] = Medium.thermalConductivity(fluidState[j]);
          cp[j] = Medium.heatCapacity_cp(fluidState[j]);
          gamma[j] = Water.f_dittus_boelter(
            w[j],
            Dhyd,
            A,
            mu[j],
            k[j],
            cp[j]);
        end for;

        for j in 1:Nw loop
           Tvol[j]      = if useAverageTemperature then (T[j] + T[j + 1])/2       else T[j + 1];
           gamma_vol[j] = if useAverageTemperature then (gamma[j] + gamma[j+1])/2 else gamma[j+1];
           wall.Q[j] = (wall.T[j] - Tvol[j])*omega*l*gamma_vol[j]*Nt;
        end for;

        Q = sum(wall.Q);

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}),
                  graphics),
          Icon(graphics={Text(extent={{-100,-52},{100,-80}}, textString="%name")}));
      end DittusBoelter;
    end HeatTransfer;

    package HeatExchangerTopologies

      model CoCurrentFlow "Co-current flow"
        extends BaseClasses.HeatExchangerTopologyData(
          final correspondingVolumes = 1:Nw);
      end CoCurrentFlow;

      model CounterCurrentFlow "Counter-current flow"
        extends BaseClasses.HeatExchangerTopologyData(
          final correspondingVolumes=  Nw:-1:1);
      end CounterCurrentFlow;
    end HeatExchangerTopologies;

    package BaseClasses

      partial model DistributedHeatTransferFV
        "Base class for distributed heat transfer models - finite volumes"
        extends ThermoPower.Icons.HeatFlow;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model";
        input Medium.ThermodynamicState fluidState[Nf];
        input MassFlowRate w[Nf];
        ThermoPower.Thermal.DHTVolumes wall(final N=Nw) annotation (Placement(transformation(extent={{-40,20},{40,
                  40}}, rotation=0)));
        parameter Integer Nf(min=2) = 2 "Number of nodes on the fluid side";
        parameter Integer Nw "Number of nodes on the wallside";
        parameter Integer Nt(min=1) "Number of tubes in parallel";
        parameter Distance L "Tube length";
        parameter Area A "Cross-sectional area (single tube)";
        parameter Length omega
          "Wet perimeter of heat transfer surface (single tube)";
        parameter Length Dhyd "Hydraulic Diameter (single tube)";
        parameter MassFlowRate wnom "Nominal mass flow rate (single tube)";
        parameter Boolean useAverageTemperature = true
          "= true to use average temperature for heat transfer";
        final parameter Length l=L/(Nw) "Length of a single volume";

        Medium.Temperature T[Nf] "Temperatures at the fluid side nodes";

      equation
        for j in 1:Nf loop
          T[j] = Medium.temperature(fluidState[j]);
        end for;
      end DistributedHeatTransferFV;

      partial model HeatExchangerTopologyData
        "Base class for heat exchanger topology data"
        parameter Integer Nw "Number of volumes on both sides";
        parameter Integer correspondingVolumes[Nw]
          "Indeces of corresponding volumes";
      end HeatExchangerTopologyData;
    end BaseClasses;
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

  package Water "Models of components with water/steam as working fluid"

    connector Flange "Flange connector for water/steam flows"
      replaceable package Medium = StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium model";
      flow Medium.MassFlowRate m_flow
        "Mass flow rate from the connection point into the component";
      Medium.AbsolutePressure p
        "Thermodynamic pressure in the connection point";
      stream Medium.SpecificEnthalpy h_outflow
        "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
      stream Medium.MassFraction Xi_outflow[Medium.nXi]
        "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      stream Medium.ExtraProperty C_outflow[Medium.nC]
        "Properties c_i/m close to the connection point if m_flow < 0";
      annotation (
        Documentation(info="<HTML>.
</HTML>",   revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
        Diagram(graphics),
        Icon(graphics));
    end Flange;

    connector FlangeA "A-type flange connector for water/steam flows"
      extends ThermoPower.Water.Flange;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}));
    end FlangeA;

    connector FlangeB "B-type flange connector for water/steam flows"
      extends ThermoPower.Water.Flange;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid), Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}));
    end FlangeB;
    extends Modelica.Icons.Package;

    package StandardWater = Modelica.Media.Water.StandardWater;

    model SourcePressure "Pressure source for water/steam flows"
      extends Icons.Water.SourceP;
      replaceable package Medium = StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium model"
        annotation(choicesAllMatching = true);
      parameter Pressure p0=1.01325e5 "Nominal pressure";
      parameter HydraulicResistance R=0 "Hydraulic resistance";
      parameter SpecificEnthalpy h=1e5 "Nominal specific enthalpy";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false
        "Use connector input for the pressure"                                   annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_h = false
        "Use connector input for the specific enthalpy" annotation(Dialog(group="External inputs"));
      outer ThermoPower.System system "System wide properties";
      Pressure p "Actual pressure";
      FlangeB flange(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation (Placement(
            transformation(
            origin={-40,92},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_h if use_in_h annotation (Placement(
            transformation(
            origin={40,90},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_h_internal;
    equation
      if R == 0 then
        flange.p = p;
      else
        flange.p = p + flange.m_flow*R;
      end if;

      p = in_p0_internal;
      if not use_in_p0 then
        in_p0_internal = p0 "Pressure set by parameter";
      end if;

      flange.h_outflow = in_h_internal;
      if not use_in_h then
        in_h_internal = h "Enthalpy set by parameter";
      end if;

      // Connect protected connectors to public conditional connectors
      connect(in_p0, in_p0_internal);
      connect(in_h, in_h_internal);

      annotation (
        Diagram(graphics),
        Icon(graphics={Text(extent={{-106,90},{-52,50}}, textString="p0"), Text(
                extent={{66,90},{98,52}}, textString="h")}),
        Documentation(info="<HTML>
<p><b>Modelling options</b></p>
<p>If <tt>R</tt> is set to zero, the pressure source is ideal; otherwise, the outlet pressure decreases proportionally to the outgoing flowrate.</p>
<p>If the <tt>in_p0</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
<p>If the <tt>in_h</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>h</tt>.</p>
</HTML>",   revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model and standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0_fix</tt> and <tt>hfix</tt>; the connection of external signals is now detected automatically.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end SourcePressure;

    model SinkPressure "Pressure sink for water/steam flows"
      extends Icons.Water.SourceP;
      replaceable package Medium = StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium model"
        annotation(choicesAllMatching = true);
      parameter Pressure p0=1.01325e5 "Nominal pressure";
      parameter HydraulicResistance R=0 "Hydraulic resistance"
        annotation (Evaluate=true);
      parameter SpecificEnthalpy h=1e5 "Nominal specific enthalpy";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false
        "Use connector input for the pressure"                                   annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_h = false
        "Use connector input for the specific enthalpy"                                  annotation(Dialog(group="External inputs"));
      outer ThermoPower.System system "System wide properties";
      Pressure p "Actual pressure";
      FlangeA flange(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation (Placement(
            transformation(
            origin={-40,88},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_h if use_in_h annotation (Placement(
            transformation(
            origin={40,88},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_h_internal;

    equation
      if R == 0 then
        flange.p = p;
      else
        flange.p = p + flange.m_flow*R;
      end if;

      p = in_p0_internal;
      if not use_in_p0 then
        in_p0_internal = p0 "Pressure set by parameter";
      end if;

      flange.h_outflow = in_h_internal;
      if not use_in_h then
        in_h_internal = h "Enthalpy set by parameter";
      end if;

      // Connect protected connectors to public conditional connectors
      connect(in_p0, in_p0_internal);
      connect(in_h, in_h_internal);

      annotation (
        Icon(graphics={Text(extent={{-106,92},{-56,50}}, textString="p0"), Text(
                extent={{54,94},{112,52}}, textString="h")}),
        Diagram(graphics),
        Documentation(info="<HTML>
<p><b>Modelling options</b></p>
<p>If <tt>R</tt> is set to zero, the pressure sink is ideal; otherwise, the inlet pressure increases proportionally to the incoming flowrate.</p>
<p>If the <tt>in_p0</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
<p>If the <tt>in_h</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>h</tt>.</p>
</HTML>",   revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model and standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0_fix</tt> and <tt>hfix</tt>; the connection of external signals is now detected automatically.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end SinkPressure;

    model Flow1DFV
      "1-dimensional fluid flow model for water/steam (finite volumes)"

      extends BaseClasses.Flow1DBase;
      import ThermoPower.Choices.Flow1D.FFtypes;
      import ThermoPower.Choices.Flow1D.HCtypes;
      Medium.ThermodynamicState fluidState[N]
        "Thermodynamic state of the fluid at the nodes";
      Length omega_hyd "Wet perimeter (single tube)";
      Pressure Dpfric "Pressure drop due to friction (total)";
      Pressure Dpfric1
        "Pressure drop due to friction (from inlet to capacitance)";
      Pressure Dpfric2
        "Pressure drop due to friction (from capacitance to outlet)";
      Pressure Dpstat "Pressure drop due to static head";
      MassFlowRate win "Flow rate at the inlet (single tube)";
      MassFlowRate wout "Flow rate at the outlet (single tube)";
      Real Kf "Hydraulic friction coefficient";
      Real dwdt "Dynamic momentum term";
      Real Cf "Fanning friction factor";
      Medium.AbsolutePressure p(start=pstart,stateSelect=StateSelect.prefer)
        "Fluid pressure for property calculations";
      MassFlowRate w(start=wnom/Nt) "Mass flow rate (single tube)";
      MassFlowRate wbar[N - 1](each start=wnom/Nt)
        "Average flow rate through volumes (single tube)";
      Power Q_single[Nw]
        "Heat flows entering the volumes from the lateral boundary (single tube)";
    //   MassFlowRate wstar[N];
      Velocity u[N] "Fluid velocity";
      Medium.Temperature T[N] "Fluid temperature";
      Medium.SpecificEnthalpy h[N](start=hstart)
        "Fluid specific enthalpy at the nodes";
      Medium.SpecificEnthalpy htilde[N - 1](start=hstart[2:N],each stateSelect=StateSelect.prefer)
        "Enthalpy state variables";
      Medium.Density rho[N] "Fluid nodal density";
      Mass M "Fluid mass (single tube)";
      Mass Mtot "Fluid mass (total)";
      Real dMdt[N - 1] "Time derivative of mass in each cell between two nodes";
      replaceable Thermal.HeatTransfer.IdealHeatTransfer heatTransfer constrainedby
        ThermoPower.Thermal.BaseClasses.DistributedHeatTransferFV(
        redeclare package Medium = Medium,
        final Nf=N, final Nw = Nw, final Nt = Nt,
        final L = L, final A = A, final Dhyd = Dhyd,
        final omega = omega, final wnom = wnom/Nt,
        final w=w*ones(N), final fluidState=fluidState) "Heat transfer model"
        annotation(choicesAllMatching = true);

      ThermoPower.Thermal.DHTVolumes wall(final N=Nw) annotation (Dialog(enable=
              false), Placement(transformation(extent={{-40,40},{40,60}},
              rotation=0)));
    protected
      Density rhobar[N - 1] "Fluid average density";
      SpecificVolume vbar[N - 1] "Fluid average specific volume";
      //HeatFlux phibar[N - 1] "Average heat flux";
      DerDensityByEnthalpy drdh[N] "Derivative of density by enthalpy";
      DerDensityByEnthalpy drbdh[N - 1]
        "Derivative of average density by enthalpy";
      DerDensityByPressure drdp[N] "Derivative of density by pressure";
      DerDensityByPressure drbdp[N - 1]
        "Derivative of average density by pressure";
    equation
      //All equations are referred to a single tube
      // Friction factor selection
      omega_hyd = 4*A/Dhyd;
      if FFtype == FFtypes.Kfnom then
        Kf = Kfnom*Kfc;
      elseif FFtype == FFtypes.OpPoint then
        Kf = dpnom*rhonom/(wnom/Nt)^2*Kfc;
      elseif FFtype == FFtypes.Cfnom then
        Cf = Cfnom*Kfc;
      elseif FFtype == FFtypes.Colebrook then
        Cf = f_colebrook(
            w,
            Dhyd/A,
            e,
            Medium.dynamicViscosity(fluidState[integer(N/2)]))*Kfc;
      else  // if FFtype == FFtypes.NoFriction then
        Cf = 0;
      end if;
      Kf = Cf*omega_hyd*L/(2*A^3)
        "Relationship between friction coefficient and Fanning friction factor";
      assert(Kf >= 0, "Negative friction coefficient");

      // Dynamic momentum term
      if DynamicMomentum then
        dwdt = der(w);
      else
        dwdt = 0;
      end if;

      sum(dMdt) = (infl.m_flow + outfl.m_flow)/Nt "Mass balance";
      L/A*dwdt + (outfl.p - infl.p) + Dpstat + Dpfric = 0 "Momentum balance";
      Dpfric = Dpfric1 + Dpfric2 "Total pressure drop due to friction";
      if FFtype == FFtypes.NoFriction then
        Dpfric1 = 0;
        Dpfric2 = 0;
      elseif HydraulicCapacitance == HCtypes.Middle then
        //assert((N-1)-integer((N-1)/2)*2 == 0, "N must be odd");
        Dpfric1 = homotopy(Kf*squareReg(win, wnom/Nt*wnf)*sum(vbar[1:integer((N
           - 1)/2)])/(N - 1), dpnom/2/(wnom/Nt)*win)
          "Pressure drop from inlet to capacitance";
        Dpfric2 = homotopy(Kf*squareReg(wout, wnom/Nt*wnf)*sum(vbar[1 + integer((
          N - 1)/2):N - 1])/(N - 1), dpnom/2/(wnom/Nt)*wout)
          "Pressure drop from capacitance to outlet";
      elseif HydraulicCapacitance == HCtypes.Upstream then
        Dpfric1 = 0 "Pressure drop from inlet to capacitance";
        Dpfric2 = homotopy(Kf*squareReg(wout, wnom/Nt*wnf)*sum(vbar)/(N - 1),
                           dpnom/(wnom/Nt)*wout)
          "Pressure drop from capacitance to outlet";
      else // if HydraulicCapacitance == HCtypes.Downstream then
        Dpfric1 = homotopy(Kf*squareReg(win, wnom/Nt*wnf)*sum(vbar)/(N - 1),
                           dpnom/(wnom/Nt)*win)
          "Pressure drop from inlet to capacitance";
        Dpfric2 = 0 "Pressure drop from capacitance to outlet";
      end if "Pressure drop due to friction";
      Dpstat = if abs(dzdx) < 1e-6 then 0 else g*l*dzdx*sum(rhobar)
        "Pressure drop due to static head";
      for j in 1:Nw loop
        if Medium.singleState then
          A*l*rhobar[j]*der(htilde[j]) + wbar[j]*(h[j + 1] - h[j]) = Q_single[j]
            "Energy balance (pressure effects neglected)";
            //Qvol = l*omega*phibar[j]
        else
          A*l*rhobar[j]*der(htilde[j]) + wbar[j]*(h[j + 1] - h[j]) - A*l*der(p) =
            Q_single[j] "Energy balance";  //Qvol = l*omega*phibar[j]
        end if;
        dMdt[j] = A*l*(drbdh[j]*der(htilde[j]) + drbdp[j]*der(p))
          "Mass derivative for each volume";
        // Average volume quantities
        rhobar[j] = (rho[j] + rho[j + 1])/2;
        drbdp[j] = (drdp[j] + drdp[j + 1])/2;
        drbdh[j] = (drdh[j] + drdh[j + 1])/2;
        vbar[j] = 1/rhobar[j];
        wbar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2, wnom/Nt);
      end for;

      // for j in 1:N loop
      //   wstar[j] = homotopy(infl.m_flow/Nt - sum(dMdt[1:j - 1]) - dMdt[j]/2, wnom/Nt);
      // end for;

      // Fluid property calculations
      for j in 1:N loop
        fluidState[j] = Medium.setState_ph(p, h[j]);
        T[j] = Medium.temperature(fluidState[j]);
        rho[j] = Medium.density(fluidState[j]);
        drdp[j] = if Medium.singleState then 0 else Medium.density_derp_h(
          fluidState[j]);
        drdh[j] = Medium.density_derh_p(fluidState[j]);
        u[j] = w/(rho[j]*A);
      end for;

      // Boundary conditions
      win = infl.m_flow/Nt;
      wout = -outfl.m_flow/Nt;
      Q_single = wall.Q/Nt;
      assert(HydraulicCapacitance == HCtypes.Upstream or
               HydraulicCapacitance == HCtypes.Middle or
               HydraulicCapacitance == HCtypes.Downstream,
               "Unsupported HydraulicCapacitance option");
      if HydraulicCapacitance == HCtypes.Middle then
        p = infl.p - Dpfric1 - Dpstat/2;
        w = win;
      elseif HydraulicCapacitance == HCtypes.Upstream then
        p = infl.p;
        w = -outfl.m_flow/Nt;
      else  // if HydraulicCapacitance == HCtypes.Downstream then
        p = outfl.p;
        w = win;
      end if;
      infl.h_outflow = htilde[1];
      outfl.h_outflow = htilde[N - 1];

       h[1] = inStream(infl.h_outflow);
       h[2:N] = htilde;

      connect(wall,heatTransfer.wall);

      Q = sum(heatTransfer.wall.Q) "Total heat flow through lateral boundary";
      M = sum(rhobar)*A*l "Fluid mass (single tube)";
      Mtot = M*Nt "Fluid mass (total)";
      Tr = noEvent(M/max(win, Modelica.Constants.eps)) "Residence time";
    initial equation
      if initOpt == Choices.Init.Options.noInit then
        // do nothing
      elseif initOpt == Choices.Init.Options.steadyState then
        der(htilde) = zeros(N - 1);
        if (not Medium.singleState) then
          der(p) = 0;
        end if;
      elseif initOpt == Choices.Init.Options.steadyStateNoP then
        der(htilde) = zeros(N - 1);
      elseif initOpt == Choices.Init.Options.steadyStateNoT and not Medium.singleState then
        der(p) = 0;
      else
        assert(false, "Unsupported initialisation option");
      end if;
      annotation (
        Diagram(graphics),
        Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
        Documentation(info="<HTML>
<p>This model describes the flow of water or steam in a rigid tube. The basic modelling assumptions are:
<ul><li>The fluid state is always one-phase (i.e. subcooled liquid or superheated steam).
<li>Uniform velocity is assumed on the cross section, leading to a 1-D distributed parameter model.
<li>Turbulent friction is always assumed; a small linear term is added to avoid numerical singularities at zero flowrate. The friction effects are not accurately computed in the laminar and transitional flow regimes, which however should not be an issue in most applications using water or steam as a working fluid.
<li>The model is based on dynamic mass, momentum, and energy balances. The dynamic momentum term can be switched off, to avoid the fast oscillations that can arise from its coupling with the mass balance (sound wave dynamics).
<li>The longitudinal heat diffusion term is neglected.
<li>The energy balance equation is written by assuming a uniform pressure distribution; the compressibility effects are lumped at the inlet, at the outlet, or at the middle of the pipe.
<li>The fluid flow can exchange thermal power through the lateral surface, which is represented by the <tt>wall</tt> connector. The actual heat flux must be computed by a connected component (heat transfer computation module).
</ul>
<p>The mass, momentum and energy balance equation are discretised with the finite volume method. The state variables are one pressure, one flowrate (optional) and N-1 specific enthalpies.
<p>The turbulent friction factor can be either assumed as a constant, or computed by Colebrook's equation. In the former case, the friction factor can be supplied directly, or given implicitly by a specified operating point. In any case, the multiplicative correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit experimental data.
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified: the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate). Increase <tt>wnf</tt> if numerical instabilities occur in tubes with very low pressure drops.
<p>Flow reversal is fully supported.
<p><b>Modelling options</b></p>
<p>Thermal variables (enthalpy, temperature, density) are computed in <tt>N</tt> equally spaced nodes, including the inlet (node 1) and the outlet (node N); <tt>N</tt> must be greater than or equal to 2.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = FFtypes.Kfnom</tt>: the hydraulic friction coefficient <tt>Kf</tt> is set directly to <tt>Kfnom</tt>.
<li><tt>FFtype = FFtypes.OpPoint</tt>: the hydraulic friction coefficient is specified by a nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).
<li><tt>FFtype = FFtypes.Cfnom</tt>: the friction coefficient is computed by giving the (constant) value of the Fanning friction factor <tt>Cfnom</tt>.
<li><tt>FFtype = FFtypes.Colebrook</tt>: the Fanning friction factor is computed by Colebrook's equation (assuming Re > 2100, e.g. turbulent flow).
<li><tt>FFtype = FFtypes.NoFriction</tt>: no friction is assumed across the pipe.</ul>
<p>The dynamic momentum term is included or neglected depending on the <tt>DynamicMomentum</tt> parameter.
<p>If <tt>HydraulicCapacitance = HCtypes.Downstream</tt> (default option) then the compressibility effect depending on the pressure derivative is lumped at the outlet, while the optional dynamic momentum term depending on the flowrate is lumped at the inlet; therefore, the state variables are the outlet pressure and the inlet flowrate. If <tt>HydraulicCapacitance = HCtypes.Upstream</tt> the reverse takes place.
 If <tt>HydraulicCapacitance = HCtypes.Middle</tt>, the compressibility effect is lumped at the middle of the pipe; to use this option, an odd number of nodes N is required.
<p>Start values for the pressure and flowrate state variables are specified by <tt>pstart</tt>, <tt>wstart</tt>. The start values for the node enthalpies are linearly distributed from <tt>hstartin</tt> at the inlet to <tt>hstartout</tt> at the outlet.
<p>A bank of <tt>Nt</tt> identical tubes working in parallel can be modelled by setting <tt>Nt > 1</tt>. The geometric parameters always refer to a <i>single</i> tube.
<p>This models makes the temperature and external heat flow distributions available to connected components through the <tt>wall</tt> connector. If other variables (e.g. the heat transfer coefficient) are needed by external components to compute the actual heat flow, the <tt>wall</tt> connector can be replaced by an extended version of the <tt>DHT</tt> connector.
</HTML>",   revisions="<html>
<ul>
<li><i>16 Sep 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Option to lump compressibility at the middle added.</li>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>8 Oct 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model now based on <tt>Flow1DBase</tt>.
<li><i>24 Sep 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>wstart</tt>, <tt>pstart</tt>. Added <tt>pstartin</tt>, <tt>pstartout</tt>.
<li><i>22 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Computation of fluid velocity <i>u</i> added. Improved treatment of geometric parameters</li>.
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
    end Flow1DFV;

    model SensT "Temperature sensor for water-steam"
      extends Icons.Water.SensThrough;
      replaceable package Medium = StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium model"
        annotation(choicesAllMatching = true);
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      SpecificEnthalpy h "Specific enthalpy of the fluid";
      Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";
      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-80,-60},{-40,-20}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{40,-60},{80,-20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput T annotation (Placement(
            transformation(extent={{60,40},{100,80}}, rotation=0)));
    equation
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";
      inlet.p = outlet.p "No pressure drop";
      // Set fluid properties
      h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else
        actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
      fluidState = Medium.setState_ph(inlet.p, h);
      T = Medium.temperature(fluidState);

      // Boundary conditions
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;
      annotation (
        Diagram(graphics),
        Icon(graphics={Text(
              extent={{-40,84},{38,34}},
              lineColor={0,0,0},
              textString="T")}),
        Documentation(info="<HTML>
<p>This component can be inserted in a hydraulic circuit to measure the temperature of the fluid flowing through it.
<p>Flow reversal is supported.
</HTML>",   revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end SensT;

    model ValveLin "Valve for water/steam flows with linear pressure drop"
      extends Icons.Water.Valve;
      replaceable package Medium = StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium model"
        annotation(choicesAllMatching = true);
      parameter HydraulicConductance Kv "Nominal hydraulic conductance";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      MassFlowRate w "Mass flowrate";
      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput cmd annotation (Placement(
            transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";
      w = Kv*cmd*(inlet.p - outlet.p) "Valve characteristics";

      // Boundary conditions
      w = inlet.m_flow;
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;

      annotation (
        Icon(graphics={Text(extent={{-100,-40},{100,-74}}, textString="%name")}),
        Diagram(graphics),
        Documentation(info="<HTML>
<p>This very simple model provides a pressure drop which is proportional to the flowrate and to the <tt>cmd</tt> signal, without computing any fluid property.</p>
</HTML>",   revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model and standard medium definition added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end ValveLin;

    function f_colebrook "Fanning friction factor for water/steam flows"
      input MassFlowRate w;
      input Real D_A;
      input Real e;
      input DynamicViscosity mu;
      output Real f;
    protected
      Real Re;
    algorithm
      Re := abs(w)*D_A/mu;
      Re := if Re > 2100 then Re else 2100;
      f := 0.332/(log(e/3.7 + 5.47/Re^0.9)^2);
      annotation (Documentation(info="<HTML>
<p>The Fanning friction factor is computed by Colebrook's equation, assuming turbulent, one-phase flow. For low Reynolds numbers, the limit value for turbulent flow is returned.
<p><b>Revision history:</b></p>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
    end f_colebrook;

    function f_dittus_boelter
      "Dittus-Boelter correlation for one-phase flow in a tube"

      input MassFlowRate w;
      input Length D;
      input Area A;
      input DynamicViscosity mu;
      input ThermalConductivity k;
      input SpecificHeatCapacity cp;
      output CoefficientOfHeatTransfer hTC;
    protected
      Real Re;
      Real Pr;
    algorithm
      Re := abs(w)*D/A/mu;
      Pr := cp*mu/k;
      hTC := 0.023*k/D*Re^0.8*Pr^0.4;
      annotation (Documentation(info="<HTML>
<p>Dittus-Boelter's correlation for the computation of the heat transfer coefficient in one-phase flows.
<p><b>Revision history:</b></p>
<ul>
<li><i>20 Dec 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
Input variables changed. This function now computes the heat transfer coefficient as a function of all the required fluid properties and flow parameters.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</HTML>"));
    end f_dittus_boelter;

    package BaseClasses "Contains partial models"

      partial model Flow1DBase
        "Basic interface for 1-dimensional water/steam fluid flow models"
        replaceable package Medium = StandardWater constrainedby
          Modelica.Media.Interfaces.PartialMedium "Medium model"
          annotation(choicesAllMatching = true);
        extends Icons.Water.Tube;
        constant Real pi = Modelica.Constants.pi;
        parameter Integer N(min=2) = 2 "Number of nodes for thermal variables";
        parameter Integer Nw = N - 1 "Number of volumes on the wall interface";
        parameter Integer Nt = 1 "Number of tubes in parallel";
        parameter Distance L "Tube length" annotation (Evaluate=true);
        parameter Position H=0 "Elevation of outlet over inlet";
        parameter Area A "Cross-sectional area (single tube)";
        parameter Length omega
          "Perimeter of heat transfer surface (single tube)";
        parameter Length Dhyd = omega/pi "Hydraulic Diameter (single tube)";
        parameter MassFlowRate wnom "Nominal mass flowrate (total)";
        parameter ThermoPower.Choices.Flow1D.FFtypes FFtype=ThermoPower.Choices.Flow1D.FFtypes.NoFriction
          "Friction Factor Type"
          annotation (Evaluate=true);
        parameter Pressure dpnom = 0
          "Nominal pressure drop (friction term only!)";
        parameter Real Kfnom = 0
          "Nominal hydraulic resistance coefficient (DP = Kfnom*w^2/rho)"
         annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Kfnom)));
        parameter Density rhonom=0 "Nominal inlet density"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.OpPoint)));
        parameter Real Cfnom=0 "Nominal Fanning friction factor"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Cfnom)));
        parameter Real e=0 "Relative roughness (ratio roughness/diameter)"
          annotation(Dialog(enable = (FFtype == ThermoPower.Choices.Flow1D.FFtypes.Colebrook)));
        parameter Real Kfc=1 "Friction factor correction coefficient";
        parameter Boolean DynamicMomentum=false
          "Inertial phenomena accounted for"
          annotation (Evaluate=true);
        parameter ThermoPower.Choices.Flow1D.HCtypes HydraulicCapacitance=ThermoPower.Choices.Flow1D.HCtypes.Downstream
          "Location of the hydraulic capacitance";
        parameter Boolean avoidInletEnthalpyDerivative=true
          "Avoid inlet enthalpy derivative";
        parameter Boolean allowFlowReversal=system.allowFlowReversal
          "= true to allow flow reversal, false restricts to design direction";
        outer ThermoPower.System system "System wide properties";
        parameter Choices.FluidPhase.FluidPhases FluidPhaseStart=Choices.FluidPhase.FluidPhases.Liquid
          "Fluid phase (only for initialization!)"
          annotation (Dialog(tab="Initialisation"));
        parameter Pressure pstart=1e5 "Pressure start value"
          annotation (Dialog(tab="Initialisation"));
        parameter SpecificEnthalpy hstartin=if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Liquid
             then 1e5 else if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Steam
             then 3e6 else 1e6 "Inlet enthalpy start value"
          annotation (Dialog(tab="Initialisation"));
        parameter SpecificEnthalpy hstartout=if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Liquid
             then 1e5 else if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Steam
             then 3e6 else 1e6 "Outlet enthalpy start value"
          annotation (Dialog(tab="Initialisation"));
        parameter SpecificEnthalpy hstart[N]=linspace(
                hstartin,
                hstartout,
                N) "Start value of enthalpy vector (initialized by default)"
          annotation (Dialog(tab="Initialisation"));
        parameter Real wnf=0.02
          "Fraction of nominal flow rate at which linear friction equals turbulent friction";
        parameter Choices.Init.Options initOpt=Choices.Init.Options.noInit
          "Initialisation option" annotation (Dialog(tab="Initialisation"));
        constant Real g=Modelica.Constants.g_n;
        function squareReg = ThermoPower.Functions.squareReg;

        FlangeA infl(
          h_outflow(start=hstartin),
          redeclare package Medium = Medium,
          m_flow(start=wnom, min=if allowFlowReversal then -Modelica.Constants.inf
                 else 0)) annotation (Placement(transformation(extent={{-120,-20},
                  {-80,20}}, rotation=0)));
        FlangeB outfl(
          h_outflow(start=hstartout),
          redeclare package Medium = Medium,
          m_flow(start=-wnom, max=if allowFlowReversal then +Modelica.Constants.inf
                 else 0)) annotation (Placement(transformation(extent={{80,-20},{
                  120,20}}, rotation=0)));
      //   replaceable ThermoPower.Thermal.DHT wall(N=N) annotation (Dialog(enable=
      //           false), Placement(transformation(extent={{-40,40},{40,60}},
      //           rotation=0)));
        Power Q "Total heat flow through the lateral boundary (all Nt tubes)";
        Time Tr "Residence time";
        final parameter Real dzdx=H/L "Slope" annotation (Evaluate=true);
        final parameter Length l=L/(N - 1) "Length of a single volume"
          annotation (Evaluate=true);
      equation
          assert(FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction or dpnom > 0,
          "dpnom=0 not valid, it is also used in the homotopy trasformation during the inizialization");

        annotation (
          Documentation(info="<HTML>
Basic interface of the <tt>Flow1D</tt> models, containing the common parameters and connectors.
</HTML>
",       revisions=
               "<html>
<ul>
<li><i>23 Jul 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Added hstart for more detailed initialization of enthalpy vector.</li>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>8 Oct 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),Diagram(graphics),
          Icon(graphics));
      end Flow1DBase;
    end BaseClasses;
    annotation (Documentation(info="<HTML>
This package contains models of physical processes and components using water or steam as working fluid.
<p>All models use the <tt>StandardWater</tt> medium model by default, which is in turn set to <tt>Modelica.Media.Water.StandardWater</tt> at the library level. It is of course possible to redeclare the medium model to any model extending <tt>Modelica.Media.Interfaces.PartialMedium</tt> (or <tt>PartialTwoPhaseMedium</tt> for 2-phase models). This can be done by directly setting Medium in the parameter dialog, or through a local package definition, as shown e.g. in <tt>Test.TestMixerSlowFast</tt>. The latter solution allows to easily replace the medium model for an entire set of components.
<p>All models with dynamic equations provide initialisation support. Set the <tt>initOpt</tt> parameter to the appropriate value:
<ul>
<li><tt>Choices.Init.Options.noInit</tt>: no initialisation
<li><tt>Choices.Init.Options.steadyState</tt>: full steady-state initialisation
<li><tt>Choices.Init.Options.steadyStateNoP</tt>: steady-state initialisation (except pressure)
<li><tt>Choices.Init.Options.steadyStateNoT</tt>: steady-state initialisation (except temperature)
</ul>
The latter options can be useful when two or more components are connected directly so that they will have the same pressure or temperature, to avoid over-specified systems of initial equations.
</HTML>"));
  end Water;

type HydraulicConductance = Real (final quantity="HydraulicConductance", final
      unit="(kg/s)/Pa");

type HydraulicResistance = Real (final quantity="HydraulicResistance", final
      unit="Pa/(kg/s)");

type Density = Modelica.SIunits.Density (start=40) "generic start value";

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

model ThermoPower_Examples_HRB_Simulators_OpenLoopSimulator
 extends ThermoPower.Examples.HRB.Simulators.OpenLoopSimulator;
  annotation(experiment(StopTime=300, Tolerance=1e-006),uses(ThermoPower(version="3.1"),
        Modelica(version="3.2.1")));
end ThermoPower_Examples_HRB_Simulators_OpenLoopSimulator;
