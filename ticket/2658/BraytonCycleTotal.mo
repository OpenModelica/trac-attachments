within ;
package ModelicaServices
  "(version = 3.2.1, target = \"Dymola\") Models and functions used in the Modelica Standard Library requiring a tool specific implementation"

package Machine

  final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

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

      connector BooleanInput = input Boolean "'input Boolean' as connector"
        annotation (
        defaultComponentName="u",
        Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid)}, coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={255,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Boolean.
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

    package Tables
      "Library of blocks to interpolate in one and two-dimensional tables"
      extends Modelica.Icons.Package;

      block CombiTable2D "Table look-up in two dimensions (matrix/file)"
        extends Modelica.Blocks.Interfaces.SI2SO;
        parameter Boolean tableOnFile=false
          "= true, if table is defined on file or in function usertab"
          annotation (Dialog(group="Table data definition"));
        parameter Real table[:, :] = fill(0.0, 0, 2)
          "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])"
          annotation (Dialog(group="Table data definition",enable=not tableOnFile));
        parameter String tableName="NoName"
          "Table name on file or in function usertab (see docu)"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter String fileName="NoName" "File where matrix is stored"
          annotation (Dialog(
            group="Table data definition",
            enable=tableOnFile,
            loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
                caption="Open file in which table is present")));
        parameter Boolean verboseRead=true
          "= true, if info message that file is loading is to be printed"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
          "Smoothness of table interpolation"
          annotation (Dialog(group="Table data interpretation"));
      protected
        Modelica.Blocks.Types.ExternalCombiTable2D tableID=
            Modelica.Blocks.Types.ExternalCombiTable2D(
              if tableOnFile then tableName else "NoName",
              if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
              table,
              smoothness) "External table object";
        parameter Real tableOnFileRead(fixed=false)
          "= 1, if table was successfully read from file";

        function readTableData
          "Read table data from ASCII text or MATLAB MAT-file"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
          input Boolean forceRead = false
            "= true: Force reading of table data; = false: Only read, if not yet read.";
          input Boolean verboseRead
            "= true: Print info message; = false: No info message";
          output Real readSuccess "Table read success";
          external"C" readSuccess = ModelicaStandardTables_CombiTable2D_read(tableID, forceRead, verboseRead)
            annotation (Library={"ModelicaStandardTables"});
        end readTableData;

        function getTableValue "Interpolate 2-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
          input Real u1;
          input Real u2;
          input Real tableAvailable
            "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
            annotation (Library={"ModelicaStandardTables"});
          annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
        end getTableValue;

        function getTableValueNoDer
          "Interpolate 2-dim. table defined by matrix (but do not provide a derivative function)"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
          input Real u1;
          input Real u2;
          input Real tableAvailable
            "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
            annotation (Library={"ModelicaStandardTables"});
        end getTableValueNoDer;

        function getDerTableValue
          "Derivative of interpolated 2-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
          input Real u1;
          input Real u2;
          input Real tableAvailable
            "Dummy input to ensure correct sorting of function calls";
          input Real der_u1;
          input Real der_u2;
          output Real der_y;
          external"C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
            annotation (Library={"ModelicaStandardTables"});
        end getDerTableValue;

      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          y = getTableValueNoDer(tableID, u1, u2, tableOnFileRead);
        else
          y = getTableValue(tableID, u1, u2, tableOnFileRead);
        end if;
        annotation (
          Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>two</b> dimensions of a <b>table</b>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>
<ul>
<li> the first column \"table[2:,1]\" contains the u[1] grid points,</li>
<li> the first row \"table[1,2:]\" contains the u[2] grid points,</li>
<li> the other rows and columns contain the data to be interpolated.</li>
</ul>
<p>
Example:
</p>
<pre>
           |       |       |       |
           |  1.0  |  2.0  |  3.0  |  // u2
       ----*-------*-------*-------*
       1.0 |  1.0  |  3.0  |  5.0  |
       ----*-------*-------*-------*
       2.0 |  2.0  |  4.0  |  6.0  |
       ----*-------*-------*-------*
     // u1
   is defined as
      table = [0.0,   1.0,   2.0,   3.0;
               1.0,   1.0,   3.0,   5.0;
               2.0,   2.0,   4.0,   6.0]
   If, e.g., the input u is [1.0;1.0], the output y is 1.0,
       e.g., the input u is [2.0;1.5], the output y is 3.0.
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new
     interpolation starts at the interval used in the last call.</li>
<li> If the table has only <b>one element</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u1</b> or <b>u2</b> is <b>outside</b> of the defined
     <b>interval</b>, the corresponding value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column and first row) have to be strictly
     increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.
      See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
      documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double table2D_1(3,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0

double table2D_2(4,4)   # comment line
0.0  1.0  2.0  3.0  # u[2] grid points
1.0  1.0  3.0  5.0
2.0  2.0  4.0  6.0
3.0  3.0  5.0  7.0
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
The matrix elements are interpreted in exactly the same way
as if the matrix is given as a parameter. For example, the first
column \"table2D_1[2:,1]\" contains the u[1] grid points,
and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
</p>

<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
          Line(points={{0.0,40.0},{0.0,-40.0}}),
          Line(points={{-60.0,40.0},{-30.0,20.0}}),
          Line(points={{-30.0,40.0},{-60.0,20.0}}),
          Rectangle(origin={2.3077,-0.0},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-62.3077,0.0},{-32.3077,20.0}}),
          Rectangle(origin={2.3077,-0.0},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-62.3077,-20.0},{-32.3077,0.0}}),
          Rectangle(origin={2.3077,-0.0},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-30.0,20.0},{0.0,40.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{0.0,20.0},{30.0,40.0}}),
          Rectangle(origin={-2.3077,-0.0},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{32.3077,20.0},{62.3077,40.0}})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-60,60},{60,-60}},
                fillColor={235,235,235},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{-100,100},{100,64}},
                textString="2 dimensional linear table interpolation",
                lineColor={0,0,255}),
              Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                    -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                    {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                    0,0,0}),
              Line(points={{0,40},{0,-40}}, color={0,0,0}),
              Rectangle(
                extent={{-54,20},{-28,0}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,0},{-28,-20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,-20},{-28,-40}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-28,40},{0,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,40},{28,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{28,40},{54,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-54,40},{-28,20}}, color={0,0,0}),
              Line(points={{-28,40},{-54,20}}, color={0,0,0}),
              Text(
                extent={{-54,-40},{-30,-56}},
                textString="u1",
                lineColor={0,0,255}),
              Text(
                extent={{28,58},{52,44}},
                textString="u2",
                lineColor={0,0,255}),
              Text(
                extent={{-2,12},{32,-22}},
                textString="y",
                lineColor={0,0,255})}));
      end CombiTable2D;
      annotation (Documentation(info="<html>
<p>This package contains blocks for one- and two-dimensional interpolation in tables. </p>
<h4>Special interest topic: Statically stored tables for real-time simulation targets</h4>
<p>Especially for use on real-time platform targets (e.g., HIL-simulators) with <b>no file system</b>, it is possible to statically
store tables using a function &quot;usertab&quot; in a file conventionally named &quot;usertab.c&quot;. This can be more efficient than providing the tables as Modelica parameter arrays.</p>
<p>This is achieved by providing the tables in a specific structure as C-code and compiling that C-code together with the rest of the simulation model into a binary
that can be executed on the target platform. The &quot;Resources/Data/Tables/&quot; subdirectory of the MSL installation directory contains the files
<a href=\"modelica://Modelica/Resources/Data/Tables/usertab.c\">&quot;usertab.c&quot;</a> and <a href=\"modelica://Modelica/Resources/Data/Tables/usertab.h\">&quot;usertab.h&quot;</a>
that can be used as a template for own developments. While &quot;usertab.c&quot; would be typically used unmodified, the
&quot;usertab.h&quot; needs to adapted for the own needs.</p>
<p>In order to work it is necessary that the compiler pulls in the &quot;usertab.c&quot; file. Different Modelica tools might provide different mechanisms to do so.
Please consult the respective documentation/support for your Modelica tool.</p>
<p>A possible (though a bit &quot;hackish&quot;) Modelica standard conformant approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to pull in the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<pre>
model Test25_usertab \"Test utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
public
  Modelica.Blocks.Sources.RealExpression realExpression(y=getUsertab(t_new.y))
    annotation (Placement(transformation(extent={{-40,-34},{-10,-14}})));
  Modelica.Blocks.Tables.CombiTable1D t_new(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated function getUsertab
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y=  mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
 double mydummyfunc(const double* dummy_in) {
        return 0;
}
\");
  end getUsertab;
equation
  connect(clock.y,t_new. u[1]) annotation (Line(
      points={{-59,10},{-42,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (experiment(StartTime=0, StopTime=5), uses(Modelica(version=\"3.2.1\")));
end Test25_usertab;
</pre>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-76,-26},{80,-76}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-76,24},{80,-26}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-76,74},{80,24}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-28,74},{-28,-76}},
              color={95,95,95}),
            Line(
              points={{24,74},{24,-76}},
              color={95,95,95})}));
    end Tables;

    package Types
      "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.TypesPackage;

      type Smoothness = enumeration(
          LinearSegments "Table points are linearly interpolated",
          ContinuousDerivative
            "Table points are interpolated such that the first derivative is continuous",

          ConstantSegments
            "Table points are not interpolated, but the value from the previous abscissa point is returned")
        "Enumeration defining the smoothness of table interpolation";

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

      class ExternalCombiTable2D
        "External object of 2-dim. table defined by matrix"
        extends ExternalObject;

        function constructor "Initialize 2-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input String tableName "Table name";
          input String fileName "File name";
          input Real table[:, :];
          input Modelica.Blocks.Types.Smoothness smoothness;
          output ExternalCombiTable2D externalCombiTable2D;
        external"C" externalCombiTable2D = ModelicaStandardTables_CombiTable2D_init(
                tableName,
                fileName,
                table,
                size(table, 1),
                size(table, 2),
                smoothness) annotation (Library={"ModelicaStandardTables"});
        end constructor;

        function destructor "Terminate 2-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input ExternalCombiTable2D externalCombiTable2D;
        external"C" ModelicaStandardTables_CombiTable2D_close(externalCombiTable2D)
            annotation (Library={"ModelicaStandardTables"});
        end destructor;

      end ExternalCombiTable2D;
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

  package Mechanics
    "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)"
  extends Modelica.Icons.Package;

    package Rotational
      "Library to model 1-dimensional, rotational mechanical systems"
      extends Modelica.Icons.Package;
      import SI = Modelica.SIunits;

      package Sensors
        "Sensors to measure variables in 1D rotational mechanical components"
        extends Modelica.Icons.SensorsPackage;

        model PowerSensor
          "Ideal sensor to measure the power between two flanges (= flange_a.tau*der(flange_a.phi))"

          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput power(unit="W")
            "Power in flange flange_a as output signal"
            annotation (Placement(transformation(
                origin={-80,-110},
                extent={{10,-10},{-10,10}},
                rotation=90)));

        equation
          flange_a.phi = flange_b.phi;
          power = flange_a.tau*der(flange_a.phi);
          annotation (Documentation(info="<html>
<p>
Measures the <b>power between two flanges</b> in an ideal way
and provides the result as output signal <b>power</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),     Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100.0,-100.0},{100.0,100.0}},
              initialScale=0.1),
              graphics={
            Text(extent={{-50.0,-120.0},{100.0,-80.0}},
              textString="power"),
            Line(points={{-80.0,-100.0},{-80.0,0.0}},
              color={0,0,127})}));
        end PowerSensor;
        annotation (Documentation(info="<html>
<p>
This package contains ideal sensor components that provide
the connector variables as signals for further processing with the
Modelica.Blocks library.
</p>
</html>"));
      end Sensors;

      package Interfaces
        "Connectors and partial models for 1D rotational mechanical components"
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a
          "1-dim. rotational flange of a shaft (filled square icon)"
          SI.Angle phi "Absolute rotation angle of flange";
          flow SI.Torque tau "Cut torque in the flange";
          annotation (
            defaultComponentName="flange_a",
            Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models
the mechanical flange of a shaft. The following variables are defined in this connector:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"> <b>phi</b></td>
      <td valign=\"top\"> Absolute rotation angle of the shaft flange in [rad] </td>
  </tr>
  <tr><td valign=\"top\"> <b>tau</b></td>
      <td valign=\"top\"> Cut-torque in the shaft flange in [Nm] </td>
  </tr>
</table>

<p>
There is a second connector for flanges: Flange_b. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see section
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a>
in the user's guide of Rotational.
</p>

<p>
If needed, the absolute angular velocity w and the
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi:
</p>
<pre>
     w = der(phi);    a = der(w)
</pre>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}), graphics={Text(
                      extent={{-160,90},{40,50}},
                      lineColor={0,0,0},
                      textString="%name"),Ellipse(
                      extent={{-40,40},{40,-40}},
                      lineColor={0,0,0},
                      fillColor={135,135,135},
                      fillPattern=FillPattern.Solid)}));
        end Flange_a;

        connector Flange_b
          "1-dim. rotational flange of a shaft (non-filled square icon)"
          SI.Angle phi "Absolute rotation angle of flange";
          flow SI.Torque tau "Cut torque in the flange";
          annotation (
            defaultComponentName="flange_b",
            Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models
the mechanical flange of a shaft. The following variables are defined in this connector:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"> <b>phi</b></td>
      <td valign=\"top\"> Absolute rotation angle of the shaft flange in [rad] </td>
  </tr>
  <tr><td valign=\"top\"> <b>tau</b></td>
      <td valign=\"top\"> Cut-torque in the shaft flange in [Nm] </td>
  </tr>
</table>

<p>
There is a second connector for flanges: Flange_a. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see section
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a>
in the user's guide of Rotational.
</p>

<p>
If needed, the absolute angular velocity w and the
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi:
</p>
<pre>
     w = der(phi);    a = der(w)
</pre>
</html>"),  Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}), graphics={Ellipse(
                      extent={{-98,100},{102,-100}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}), graphics={Ellipse(
                      extent={{-40,40},{40,-40}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{-40,90},{160,50}},
                      lineColor={0,0,0},
                      textString="%name")}));
        end Flange_b;

        partial model PartialRelativeSensor
          "Partial model to measure a single relative variable between two flanges"
          extends Modelica.Icons.RotationalSensor;

          Flange_a flange_a "Left flange of shaft" annotation (Placement(
                transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
          Flange_b flange_b "Right flange of shaft" annotation (Placement(
                transformation(extent={{90,-10},{110,10}}, rotation=0)));

        equation
          0 = flange_a.tau + flange_b.tau;
          annotation (Documentation(info="<html>
<p>
This is a partial model for 1-dim. rotational components with two rigidly connected
flanges in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"),     Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100.0,-100.0},{100.0,100.0}},
              initialScale=0.1),
              graphics={
            Line(points={{-70.0,0.0},{-90.0,0.0}}),
            Line(points={{70.0,0.0},{90.0,0.0}}),
            Text(lineColor={0,0,255},
              extent={{-150.0,73.0},{150.0,113.0}},
              textString="%name")}));
        end PartialRelativeSensor;
        annotation (Documentation(info="<html>
<p>
This package contains connectors and partial models for 1-dim.
rotational mechanical components. The components of this package can
only be used as basic building elements for models.
</p>
</html>"));
      end Interfaces;
      annotation (Documentation(info="<html>

<p>
Library <b>Rotational</b> is a <b>free</b> Modelica package providing
1-dimensional, rotational mechanical components to model in a convenient way
drive trains with frictional losses. A typical, simple example is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveExample.png\">

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide\">Rotational.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Examples\">Rotational.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>

<p>
In version 3.0 of the Modelica Standard Library, the basic design of the
library has changed: Previously, bearing connectors could or could not be connected.
In 3.0, the bearing connector is renamed to \"<b>support</b>\" and this connector
is enabled via parameter \"useSupport\". If the support connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
</p>

<p>
In version 3.2 of the Modelica Standard Library, all <b>dissipative</b> components
of the Rotational library got an optional <b>heatPort</b> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from the new variable \"<b>lossPower</b>\" (which is
positive if heat is flowing out of the heatPort). For an example, see
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.HeatLosses\">Examples.HeatLosses</a>.
</p>

<p>
Copyright &copy; 1998-2013, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",     revisions=""), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}},
          initialScale=0.1),
          graphics={
        Line(visible=true,
          origin={-2.0,46.0},
          points={{-83.0,-66.0},{-63.0,-66.0}}),
        Line(visible=true,
          origin={29.0,48.0},
          points={{36.0,-68.0},{56.0,-68.0}}),
        Line(visible=true,
          origin={-2.0,49.0},
          points={{-83.0,-29.0},{-63.0,-29.0}}),
        Line(visible=true,
          origin={29.0,52.0},
          points={{36.0,-32.0},{56.0,-32.0}}),
        Line(visible=true,
          origin={-2.0,49.0},
          points={{-73.0,-9.0},{-73.0,-29.0}}),
        Line(visible=true,
          origin={29.0,52.0},
          points={{46.0,-12.0},{46.0,-32.0}}),
        Line(visible=true,
          origin={-0.0,-47.5},
          points={{-75.0,27.5},{-75.0,-27.5},{75.0,-27.5},{75.0,27.5}}),
        Rectangle(visible=true,
          origin={13.5135,76.9841},
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-63.5135,-126.9841},{36.4865,-26.9841}},
          radius=10.0),
        Rectangle(visible=true,
          origin={13.5135,76.9841},
          lineColor={64,64,64},
          fillPattern=FillPattern.None,
          extent={{-63.5135,-126.9841},{36.4865,-26.9841}},
          radius=10.0),
        Rectangle(visible=true,
          origin={-3.0,73.0769},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-87.0,-83.0769},{-47.0,-63.0769}}),
        Rectangle(visible=true,
          origin={22.3077,70.0},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{27.6923,-80.0},{67.6923,-60.0}})}));
    end Rotational;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}, initialScale=0.1), graphics={
        Rectangle(
          origin={8.6,63.3333},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-4.6,-93.3333},{41.4,-53.3333}}),
        Ellipse(
          origin={9.0,46.0},
          extent={{-90.0,-60.0},{-80.0,-50.0}}),
        Line(
          origin={9.0,46.0},
          points={{-85.0,-55.0},{-60.0,-21.0}},
          thickness=0.5),
        Ellipse(
          origin={9.0,46.0},
          extent={{-65.0,-26.0},{-55.0,-16.0}}),
        Line(
          origin={9.0,46.0},
          points={{-60.0,-21.0},{9.0,-55.0}},
          thickness=0.5),
        Ellipse(
          origin={9.0,46.0},
          fillPattern=FillPattern.Solid,
          extent={{4.0,-60.0},{14.0,-50.0}}),
        Line(
          origin={9.0,46.0},
          points={{-10.0,-26.0},{72.0,-26.0},{72.0,-86.0},{-10.0,-86.0}})}),
    Documentation(info="<HTML>
<p>
This package contains components to model the movement
of 1-dim. rotational, 1-dim. translational, and
3-dim. <b>mechanical systems</b>.
</p>

<p>
Note, all <b>dissipative</b> components of the Modelica.Mechanics library have
an optional <b>heatPort</b> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from variable \"<b>lossPower</b>\" (which is
positive if heat is flowing out of the heatPort).
</p>
</html>"));
  end Mechanics;

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

      type DerDensityByTemperature = SI.DerDensityByTemperature
          "Type for partial derivative of density with respect to temperature with medium specific attributes";

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

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO2(
                               chemicalFormula =        "CO2",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "124-38-9",
                               meltingPoint =           216.58,
                               normalBoilingPoint =     -1.0,
                               criticalTemperature =    304.12,
                               criticalPressure =        73.74e5,
                               criticalMolarVolume =     94.07e-6,
                               acentricFactor =           0.225,
                               dipoleMoment =             0.0,
                               molarMass =              SingleGasesData.CO2.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2O(
                               chemicalFormula =        "H2O",
                               iupacName =              "oxidane",
                               structureFormula =       "H2O",
                               casRegistryNumber =      "7732-18-5",
                               meltingPoint =           273.15,
                               normalBoilingPoint =     373.124,
                               criticalTemperature =    647.096,
                               criticalPressure =       220.64e5,
                               criticalMolarVolume =     55.95e-6,
                               acentricFactor =           0.344,
                               dipoleMoment =             1.8,
                               molarMass =              SingleGasesData.H2O.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants Ar(
                               chemicalFormula =        "Ar",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "7440-37-1",
                               meltingPoint =            83.80,
                               normalBoilingPoint =      87.27,
                               criticalTemperature =    150.86,
                               criticalPressure =        48.98e5,
                               criticalMolarVolume =     74.57e-6,
                               acentricFactor =          -0.002,
                               dipoleMoment =             0.0,
                               molarMass =              SingleGasesData.Ar.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);

          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CH4(
                               chemicalFormula =        "CH4",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "74-82-8",
                               meltingPoint =            90.69,
                               normalBoilingPoint =     111.66,
                               criticalTemperature =    190.56,
                               criticalPressure =        45.99e5,
                               criticalMolarVolume =     98.60e-6,
                               acentricFactor =           0.011,
                               dipoleMoment =             0.0,
                               molarMass =              SingleGasesData.CH4.MM,
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

          constant IdealGases.Common.DataRecord Ar(
            name="Ar",
            MM=0.039948,
            Hf=0,
            H0=155137.3785921698,
            Tlimit=1000,
            alow={0,0,2.5,0,0,0,0},
            blow={-745.375,4.37967491},
            ahigh={20.10538475,-0.05992661069999999,2.500069401,-3.99214116e-008,
                1.20527214e-011,-1.819015576e-015,1.078576636e-019},
            bhigh={-744.993961,4.37918011},
            R=208.1323720837088);

          constant IdealGases.Common.DataRecord CH4(
            name="CH4",
            MM=0.01604246,
            Hf=-4650159.63885838,
            H0=624355.7409524474,
            Tlimit=1000,
            alow={-176685.0998,2786.18102,-12.0257785,0.0391761929,-3.61905443e-005,
                2.026853043e-008,-4.976705489999999e-012},
            blow={-23313.1436,89.0432275},
            ahigh={3730042.76,-13835.01485,20.49107091,-0.001961974759,4.72731304e-007,
                -3.72881469e-011,1.623737207e-015},
            bhigh={75320.6691,-121.9124889},
            R=518.2791167938085);

          constant IdealGases.Common.DataRecord CO2(
            name="CO2",
            MM=0.0440095,
            Hf=-8941478.544405185,
            H0=212805.6215135368,
            Tlimit=1000,
            alow={49436.5054,-626.411601,5.30172524,0.002503813816,-2.127308728e-007,-7.68998878e-010,
                2.849677801e-013},
            blow={-45281.9846,-7.04827944},
            ahigh={117696.2419,-1788.791477,8.29152319,-9.22315678e-005,4.86367688e-009,
                -1.891053312e-012,6.330036589999999e-016},
            bhigh={-39083.5059,-26.52669281},
            R=188.9244822140674);

          constant IdealGases.Common.DataRecord H2O(
            name="H2O",
            MM=0.01801528,
            Hf=-13423382.81725291,
            H0=549760.6476280135,
            Tlimit=1000,
            alow={-39479.6083,575.573102,0.931782653,0.00722271286,-7.34255737e-006,
                4.95504349e-009,-1.336933246e-012},
            blow={-33039.7431,17.24205775},
            ahigh={1034972.096,-2412.698562,4.64611078,0.002291998307,-6.836830479999999e-007,
                9.426468930000001e-011,-4.82238053e-015},
            bhigh={-13842.86509,-7.97814851},
            R=461.5233290850878);

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

  function sin "Sine"
    extends Modelica.Math.Icons.AxisLeft;
    input Modelica.SIunits.Angle u;
    output Real y;

  external "builtin" y=  sin(u);
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
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
                {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
                {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
                {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
                57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,0}),
          Text(
            extent={{12,84},{84,36}},
            lineColor={192,192,192},
            textString="sin")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{100,0},{84,6},{84,-6},{100,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
              {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,
              44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{29.3,-73.1},
              {35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,-61.9},{63.9,
              -47.2},{72,-24.8},{80,0}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{-105,72},{-85,88}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="2*pi",
              lineColor={0,0,255}),Text(
              extent={{-103,-72},{-83,-88}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{82,-6},{102,-26}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{-80,80},{-28,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{-80,-80},{50,-80}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = sin(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\">
</p>
</html>"));
  end sin;

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

    package Strings "Operations on strings"
      extends Modelica.Icons.Package;

      function length "Returns length of string"
        extends Modelica.Icons.Function;
        input String string;
        output Integer result "Number of characters of string";
      external "C" result = ModelicaStrings_length(string) annotation(Library="ModelicaExternalC");
        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>length</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of characters of \"string\".
</p>
</html>"));
      end length;

      function isEmpty
        "Return true if a string is empty (has only white space characters)"
        extends Modelica.Icons.Function;
        input String string;
        output Boolean result "True, if string is empty";
      protected
        Integer nextIndex;
        Integer len;
      algorithm
        nextIndex := Strings.Advanced.skipWhiteSpace(string);
        len := Strings.length(string);
        if len < 1 or nextIndex > len then
          result := true;
        else
          result := false;
        end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>isEmpty</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns true if the string has no characters or if the string consists
only of white space characters. Otherwise, false is returned.
</p>

<h4>Example</h4>
<blockquote><pre>
  isEmpty(\"\");       // returns true
  isEmpty(\"   \");    // returns true
  isEmpty(\"  abc\");  // returns false
  isEmpty(\"a\");      // returns false
</pre></blockquote>
</html>"));
      end isEmpty;

      package Advanced "Advanced scanning functions"
      extends Modelica.Icons.Package;

        function skipWhiteSpace "Scans white space"
          extends Modelica.Icons.Function;
          input String string;
          input Integer startIndex(min=1)=1;
          output Integer nextIndex;
          external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex) annotation(Library="ModelicaExternalC");
          annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
nextIndex = <b>skipWhiteSpace</b>(string, startIndex);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\" and
skips white space. The function returns nextIndex = index of character
of the first non white space character.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"));
        end skipWhiteSpace;
        annotation (Documentation(info="<html>
<h4>Library content</h4>
<p>
Package <b>Strings.Advanced</b> contains basic scanning
functions. These functions should be <b>not called</b> directly, because
it is much simpler to utilize the higher level functions \"Strings.scanXXX\".
The functions of the \"Strings.Advanced\" library provide
the basic interface in order to implement the higher level
functions in package \"Strings\".
</p>
<p>
Library \"Advanced\" provides the following functions:
</p>
<pre>
  (nextIndex, realNumber)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>        (string, startIndex, unsigned=false);
  (nextIndex, integerNumber) = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>     (string, startIndex, unsigned=false);
  (nextIndex, string2)       = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>      (string, startIndex);
  (nextIndex, identifier)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipWhiteSpace\">skipWhiteSpace</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a>(string, startIndex);
</pre>
<p>
All functions perform the following actions:
</p>
<ol>
<li> Scanning starts at character position \"startIndex\" of
     \"string\" (startIndex has a default of 1).
<li> First, white space is skipped, such as blanks (\" \"), tabs (\"\\t\"), or newline (\"\\n\")</li>
<li> Afterwards, the required token is scanned.</li>
<li> If successful, on return nextIndex = index of character
     directly after the found token and the token value is returned
     as second output argument.<br>
     If not successful, on return nextIndex = startIndex.
     </li>
</ol>
<p>
The following additional rules apply for the scanning:
</p>
<ul>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>:<br>
     Scans a full number including one optional leading \"+\" or \"-\" (if unsigned=false)
     according to the Modelica grammar. For example, \"+1.23e-5\", \"0.123\" are
     Real numbers, but \".1\" is not.
     Note, an Integer number, such as \"123\" is also treated as a Real number.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>:<br>
     Scans an Integer number including one optional leading \"+\"
     or \"-\" (if unsigned=false) according to the Modelica (and C/C++) grammar.
     For example, \"+123\", \"20\" are Integer numbers.
     Note, a Real number, such as \"123.4\" is not an Integer and
     scanInteger returns nextIndex = startIndex.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>:<br>
     Scans a String according to the Modelica (and C/C++) grammar, e.g.,
     \"This is a \"string\"\" is a valid string token.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>:<br>
     Scans a Modelica identifier, i.e., the identifier starts either
     with a letter, followed by letters, digits or \"_\".
     For example, \"w_rel\", \"T12\".<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a><br>
     Skips white space and Modelica (C/C++) line comments iteratively.
     A line comment starts with \"//\" and ends either with an
     end-of-line (\"\\n\") or the end of the \"string\". </li>
</ul>
</html>"));
      end Advanced;
      annotation (
        Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Strings</b> contains functions to manipulate strings.
</p>
<p>
In the table below an example
call to every function is given using the <b>default</b> options.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\">len = <a href=\"modelica://Modelica.Utilities.Strings.length\">length</a>(string)</td>
      <td valign=\"top\">Returns length of string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.substring\">substring</a>(string1,startIndex,endIndex)
       </td>
      <td valign=\"top\">Returns a substring defined by start and end index</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n)<br>
 result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n,string)</td>
      <td valign=\"top\">Repeat a blank or a string n times.</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.compare\">compare</a>(string1, string2)</td>
      <td valign=\"top\">Compares two substrings with regards to alphabetical order</td></tr>
  <tr><td valign=\"top\">identical =
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">isEqual</a>(string1,string2)</td>
      <td valign=\"top\">Determine whether two strings are identical</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.count\">count</a>(string,searchString)</td>
      <td valign=\"top\">Count the number of occurrences of a string</td></tr>
  <tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.find\">find</a>(string,searchString)</td>
      <td valign=\"top\">Find first occurrence of a string in another string</td></tr>
<tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.findLast\">findLast</a>(string,searchString)</td>
      <td valign=\"top\">Find last occurrence of a string in another string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.replace\">replace</a>(string,searchString,replaceString)</td>
      <td valign=\"top\">Replace one or all occurrences of a string</td></tr>
  <tr><td valign=\"top\">stringVector2 = <a href=\"modelica://Modelica.Utilities.Strings.sort\">sort</a>(stringVector1)</td>
      <td valign=\"top\">Sort vector of strings in alphabetic order</td></tr>
  <tr><td valign=\"top\">(token, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanToken\">scanToken</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a token (Real/Integer/Boolean/String/Identifier/Delimiter/NoToken)</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">scanReal</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Real constant</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanInteger\">scanInteger</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an Integer constant</td></tr>
  <tr><td valign=\"top\">(boolean, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanBoolean\">scanBoolean</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Boolean constant</td></tr>
  <tr><td valign=\"top\">(string2, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanString\">scanString</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a String constant</td></tr>
  <tr><td valign=\"top\">(identifier, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanIdentifier\">scanIdentifier</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an identifier</td></tr>
  <tr><td valign=\"top\">(delimiter, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanDelimiter\">scanDelimiter</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for delimiters</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.scanNoToken\">scanNoToken</a>(string,startIndex)</td>
      <td valign=\"top\">Check that remaining part of string consists solely of <br>
          white space or line comments (\"// ...\\n\").</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.syntaxError\">syntaxError</a>(string,index,message)</td>
      <td valign=\"top\"> Print a \"syntax error message\" as well as a string and the <br>
           index at which scanning detected an error</td></tr>
</table>
<p>
The functions \"compare\", \"isEqual\", \"count\", \"find\", \"findLast\", \"replace\", \"sort\"
have the optional
input argument <b>caseSensitive</b> with default <b>true</b>.
If <b>false</b>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</HTML>"));
    end Strings;
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

    final constant Real inf=ModelicaServices.Machine.inf
      "Biggest Real number such that inf and -inf are representable on the machine";

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

    partial class RotationalSensor
      "Icon representing a round measurement device"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              fillColor={245,245,245},
              fillPattern=FillPattern.Solid,
              extent={{-70.0,-70.0},{70.0,70.0}}),
            Line(points={{0.0,70.0},{0.0,40.0}}),
            Line(points={{22.9,32.8},{40.2,57.3}}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}),
            Line(points={{37.6,13.7},{65.8,23.9}}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}),
            Ellipse(
              lineColor={64,64,64},
              fillColor={255,255,255},
              extent={{-12.0,-12.0},{12.0,12.0}}),
            Polygon(
              origin={0,0},
              rotation=-17.5,
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
            Ellipse(
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-7.0,-7.0},{7.0,7.0}})}),
        Documentation(info="<html>
<p>
This icon is designed for a <b>rotational sensor</b> model.
</p>
</html>"));
    end RotationalSensor;

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

        type AngularVelocity_rpm = Real (final quantity="AngularVelocity", final unit=
                   "1/min")
          "Angular velocity in revolutions per minute. Alias unit names that are outside of the SI system: rpm, r/min, rev/min";

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

      function to_rpm
        "Convert from radian per second to revolutions per minute"
        extends Modelica.SIunits.Icons.Conversion;
        input AngularVelocity rs "radian per second value";
        output NonSIunits.AngularVelocity_rpm rpm
          "revolutions per minute value";
      algorithm
        rpm := (30/Modelica.Constants.pi)*rs;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{30,100},{-100,50}},
                lineColor={0,0,0},
                textString="rad/s"), Text(
                extent={{100,-52},{-40,-98}},
                lineColor={0,0,0},
                textString="1/min")}));
      end to_rpm;

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

    type Area = Real (final quantity="Area", final unit="m2");

    type Volume = Real (final quantity="Volume", final unit="m3");

    type Time = Real (final quantity="Time", final unit="s");

    type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");

    type Velocity = Real (final quantity="Velocity", final unit="m/s");

    type Frequency = Real (final quantity="Frequency", final unit="Hz");

    type Mass = Real (
        quantity="Mass",
        final unit="kg",
        min=0);

    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0.0);

    type MomentOfInertia = Real (final quantity="MomentOfInertia", final unit=
            "kg.m2");

    type Torque = Real (final quantity="Torque", final unit="N.m");

    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");

    type AbsolutePressure = Pressure (min=0.0, nominal = 1e5);

    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);

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

    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");

    type IsothermalCompressibility = Compressibility;

    type Heat = Real (final quantity="Energy", final unit="J");

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");

    type CoefficientOfHeatTransfer = Real (final quantity=
            "CoefficientOfHeatTransfer", final unit="W/(m2.K)");

    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");

    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");

    type SpecificEntropy = Real (final quantity="SpecificEntropy",
                                 final unit="J/(kg.K)");

    type InternalEnergy = Heat;

    type SpecificEnergy = Real (final quantity="SpecificEnergy",
                                final unit="J/kg");

    type SpecificEnthalpy = SpecificEnergy;

    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");

    type DerDensityByPressure = Real (final unit="s2/m2");

    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");

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

    partial model Mixer

      annotation (Icon(graphics={Ellipse(
              extent={{80,80},{-80,-80}},
              lineColor={128,128,128},
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid), Text(extent={{-100,-84},{100,-110}},
                textString="%name")}), Diagram(graphics));
    end Mixer;

    partial model Compressor

      annotation (Icon(graphics={
            Polygon(
              points={{24,26},{30,26},{30,76},{60,76},{60,82},{24,82},{24,26}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-30,76},{-30,56},{-24,56},{-24,82},{-60,82},{-60,76},{-30,
                  76}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,8},{60,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-30,60},{-30,-60},{30,-26},{30,26},{-30,60}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));

    end Compressor;

    partial model Turbine

      annotation (Icon(graphics={
            Polygon(
              points={{-28,76},{-28,28},{-22,28},{-22,82},{-60,82},{-60,76},{-28,
                  76}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{26,56},{32,56},{32,76},{60,76},{60,82},{26,82},{26,56}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,8},{60,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Polygon(
              points={{-28,28},{-28,-26},{32,-60},{32,60},{-28,28}},
              lineColor={128,128,128},
              lineThickness=0.5,
              fillColor={159,159,223},
              fillPattern=FillPattern.Solid)}), Diagram(graphics));

    end Turbine;
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
  annotation (Documentation(info="<HTML>
This package contains general-purpose functions and models
</HTML>"));
end Functions;

package Electrical "Simplified models of electric power components"
  extends Modelica.Icons.Package;

  connector PowerConnection "Electrical power connector"
    flow Power W "Active power";
    Frequency f "Frequency";
    annotation (Icon(graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                lineThickness=0.5,
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid)}));
  end PowerConnection;

  model Generator "Active power generator"
    import Modelica.SIunits.Conversions.NonSIunits.*;
    parameter Real eta=1 "Conversion efficiency";
    parameter Modelica.SIunits.MomentOfInertia J=0 "Moment of inertia";
    parameter Integer Np=2 "Number of electrical poles";
    parameter Modelica.SIunits.Frequency fstart=50
        "Start value of the electrical frequency"
      annotation (Dialog(tab="Initialization"));
    parameter ThermoPower.Choices.Init.Options initOpt=ThermoPower.Choices.Init.Options.noInit
        "Initialization option"
                              annotation (Dialog(tab="Initialization"));
    Modelica.SIunits.Power Pm "Mechanical power";
    Modelica.SIunits.Power Pe "Electrical Power";
    Modelica.SIunits.Power Ploss "Inertial power Loss";
    Modelica.SIunits.Torque tau "Torque at shaft";
    Modelica.SIunits.AngularVelocity omega_m(start=2*Modelica.Constants.pi*
          fstart/Np) "Angular velocity of the shaft";
    Modelica.SIunits.AngularVelocity omega_e
        "Angular velocity of the e.m.f. rotating frame";
    AngularVelocity_rpm n "Rotational speed";
    Modelica.SIunits.Frequency f "Electrical frequency";
    PowerConnection powerConnection annotation (Placement(transformation(extent=
             {{72,-14},{100,14}}, rotation=0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (
        Placement(transformation(extent={{-100,-14},{-72,14}}, rotation=0)));
  equation
    omega_m = der(shaft.phi) "Mechanical boundary condition";
    omega_e = omega_m*Np;
    f = omega_e/(2*Modelica.Constants.pi) "Electrical frequency";
    n = Modelica.SIunits.Conversions.to_rpm(omega_m) "Rotational speed in rpm";
    Pm = omega_m*tau;
    if J > 0 then
      Ploss = J*der(omega_m)*omega_m;
    else
      Ploss = 0;
    end if annotation (Diagram);
    Pm = Pe/eta + Ploss "Energy balance";
    // Boundary conditions
    f = powerConnection.f;
    Pe = -powerConnection.W;
    tau = shaft.tau;
  initial equation
    if initOpt == ThermoPower.Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == ThermoPower.Choices.Init.Options.steadyState then
      der(omega_m) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Icon(graphics={Rectangle(
                extent={{-72,6},{-48,-8}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={160,160,164}),Ellipse(
                extent={{50,-50},{-50,50}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{50,0},{72,0}},
            color={0,0,0}),Text(
                extent={{-26,24},{28,-28}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString="G")}),
      Documentation(info="<html>
<p>This model describes the conversion between mechanical power and electrical power in an ideal synchronous generator. 
The frequency in the electrical connector is the e.m.f. of generator.
<p>It is possible to consider the generator inertia in the model, by setting the parameter <tt>J > 0</tt>. 
</html>"));
  end Generator;

  partial model Network1portBase "Base class for one-port network"
    parameter Boolean hasBreaker=false
        "Model includes a breaker controlled by external input";
    parameter Modelica.SIunits.Angle deltaStart=0
        "Start value of the load angle"
                                      annotation (Dialog(tab="Initialization"));
    parameter ThermoPower.Choices.Init.Options initOpt=ThermoPower.Choices.Init.Options.noInit
        "Initialization option"
                              annotation (Dialog(tab="Initialization"));
    parameter Modelica.SIunits.Power C "Max. power transfer";
    Modelica.SIunits.Power Pe "Net electrical power";
    Modelica.SIunits.Power Ploss "Electrical power loss";
    Modelica.SIunits.AngularVelocity omega "Angular velocity";
    Modelica.SIunits.AngularVelocity omegaRef "Angular velocity reference";
    Modelica.SIunits.Angle delta(stateSelect=StateSelect.prefer, start=
          deltaStart) "Load angle";

    PowerConnection powerConnection annotation (Placement(transformation(extent=
             {{-114,-14},{-86,14}}, rotation=0)));
    Modelica.Blocks.Interfaces.BooleanInput closed if hasBreaker annotation (
        Placement(transformation(
          origin={0,97},
          extent={{-15,-16},{15,16}},
          rotation=270)));
    protected
    Modelica.Blocks.Interfaces.BooleanInput closedInternal annotation (
        Placement(transformation(
          origin={0,49},
          extent={{-9,-8},{9,8}},
          rotation=270)));
    public
    Modelica.Blocks.Interfaces.RealOutput delta_out annotation (Placement(
          transformation(
          origin={0,-90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    // Load angle
    der(delta) = omega - omegaRef;
    // Power flow
    if closedInternal then
      Pe = homotopy(C*Modelica.Math.sin(delta), C*delta);
    else
      Pe = 0;
    end if;
    // Boundary conditions
    Pe + Ploss = powerConnection.W;
    omega = 2*Modelica.Constants.pi*powerConnection.f;
    if not hasBreaker then
      closedInternal = true;
    end if;
    connect(closed, closedInternal);
    //Output signal
    delta_out = delta;
  initial equation
    if initOpt == ThermoPower.Choices.Init.Options.noInit then
      // do nothing
    elseif initOpt == ThermoPower.Choices.Init.Options.steadyState then
      der(delta) = 0;
    else
      assert(false, "Unsupported initialisation option");
    end if;
    annotation (
      Diagram(graphics),
      Icon(graphics={Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>Basic interface of the Network models with one electrical port for the connection to the generator, containing the common parameters, variables and connectors.</p>
<p><b>Modelling options</b>
<p>The net electrical power is defined by the following relationship:
<ul><tt>Pe = C*sin(delta)</tt></ul> 
<p><tt>delta</tt> is the load angle, defined by the following relationship:
<ul><tt>der(delta) = omega - omegaRef</tt></ul>
<p>where <tt>omega</tt> is related to the frequency on the power connector (generator frequency), and <tt>omegaRef</tt> is the reference angular velocity of the network embedded in the model.
<p>The electrical power losses are described by the variable <tt>Ploss</tt>.
<p>If <tt>hasBreaker</tt> is true, the model provides a circuit breaker, controlled by the boolean input signal, to describe the connection/disconnection of the electrical port from the grid; otherwise it is assumed that the electrical port is always connected to the grid. 
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end Network1portBase;

  model NetworkGrid_Pmax
    extends ThermoPower.Electrical.Network1portBase(final C=Pmax);
    parameter Modelica.SIunits.Power Pmax "Maximum power transfer";
    parameter Modelica.SIunits.Frequency fnom=50 "Nominal frequency of network";
    parameter Modelica.SIunits.MomentOfInertia J=0
        "Moment of inertia of the generator/shaft system (for damping term calculation)"
      annotation (Dialog(group="Generator"));
    parameter Real r=0.2 "Electrical damping of generator/shaft system"
      annotation (dialog(enable=if J > 0 then true else false, group=
            "Generator"));
    parameter Integer Np=2 "Number of electrical poles" annotation (dialog(
          enable=if J > 0 then true else false, group="Generator"));
    Real D "Electrical damping coefficient";
  equation
    // Definition of the reference
    omegaRef = 2*Modelica.Constants.pi*fnom;
    // Definition of damping power loss
    if J > 0 then
      D = 2*r*sqrt(C*J*(2*Modelica.Constants.pi*fnom*Np)/(Np^2));
    else
      D = 0;
    end if;
    if closedInternal then
      Ploss = D*der(delta);
    else
      Ploss = 0;
    end if;
    annotation (Icon(graphics={Rectangle(
                extent={{-54,6},{-28,-6}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Line(points={{-54,0},{-92,0}},
            color={0,0,0}),Line(points={{-28,0},{-10,0},{18,16}}, color={0,0,0}),
            Line(points={{20,0},{46,0}}, color={0,0,0}),Line(
                points={{46,40},{46,-40}},
                color={0,0,0},
                thickness=0.5)}), Documentation(info="<html>
<p>This model extends <tt>Network1portBase</tt> partial model, by directly defining the maximum power that can be transferred between the electrical port and the grid <tt>Pmax</tt>.
<p>The power losses are represented by a linear dissipative term. It is possible to directly set the damping coefficient <tt>r</tt> of the generator/shaft system. 
If <tt>J</tt> is zero, zero damping is assumed. Note that <tt>J</tt> is only used to compute the dissipative term and should refer to the total inertia of the generator-shaft system; the network model does not add any inertial effects.
</html>", revisions="<html>
<ul>
<li><i>15 Jul 2008</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco
Casella</a> and <a> Luca Savoldelli </a>:<br>
       First release.</li>
</ul>
</html>"));
  end NetworkGrid_Pmax;
  annotation (Documentation(info="<html>
<p>This package allows to describe the flow of active power between a synchronous generator and a grid, through simplified power transmission line models, assuming ideal voltage control. </p>
<p>These models are meant to be used as simplified boundary conditions for a thermal power plant model, rather than for fully modular description of three-phase networks. Specialized libraries should be used for this purpose; bear in mind, however, that full three-phase models of electrical machinery and power lines could make the power plant simulation substantially heavier, if special numeric integration strategies are not adopted.
</html>"));
end Electrical;

  package Choices "Choice enumerations for ThermoPower models"
    extends Modelica.Icons.Package;

    package PressDrop

      type FFtypes = enumeration(
          Kf "Kf friction factor",
          OpPoint "Friction factor defined by operating point",
          Kinetic "Kinetic friction factor")
        "Type, constants and menu choices to select the friction factor";
    end PressDrop;

    package TurboMachinery

      type TableTypes = enumeration(
          matrix "Explicitly supplied as parameter matrix table",
          file "Read from a file")
        "Type, constants and menu choices to select the representation of table matrix";
    end TurboMachinery;

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
  end Choices;

  package Examples "Application examples"
    extends Modelica.Icons.ExamplesPackage;

    package RankineCycle "Steam power plant"
      extends Modelica.Icons.Package;

      package Models
        extends Modelica.Icons.Package;

        model PID "PID controller with anti-windup"
          parameter Real Kp "Proportional gain (normalised units)";
          parameter Modelica.SIunits.Time Ti "Integral time";
          parameter Boolean integralAction = true "Use integral action";
          parameter Modelica.SIunits.Time Td=0 "Derivative time";
          parameter Real Nd=1 "Derivative action up to Nd / Td rad/s";
          parameter Real Ni=1
            "Ni*Ti is the time constant of anti-windup compensation";
          parameter Real b=1 "Setpoint weight on proportional action";
          parameter Real c=0 "Setpoint weight on derivative action";
          parameter Real PVmin "Minimum value of process variable for scaling";
          parameter Real PVmax "Maximum value of process variable for scaling";
          parameter Real CSmin "Minimum value of control signal for scaling";
          parameter Real CSmax "Maximum value of control signal for scaling";
          parameter Real PVstart=0.5 "Start value of PV (scaled)";
          parameter Real CSstart=0.5 "Start value of CS (scaled)";
          parameter Boolean holdWhenSimplified=false
            "Hold CSs at start value when homotopy=simplified";
          parameter Boolean steadyStateInit=false "Initialize in steady state";
          Real CSs_hom
            "Control signal scaled in per units, used when homotopy=simplified";

          Real P "Proportional action / Kp";
          Real I(start=CSstart/Kp) "Integral action / Kp";
          Real D "Derivative action / Kp";
          Real Dx(start=c*PVstart - PVstart) "State of approximated derivator";
          Real PVs "Process variable scaled in per unit";
          Real SPs "Setpoint variable scaled in per unit";
          Real CSs(start=CSstart) "Control signal scaled in per unit";
          Real CSbs(start=CSstart)
            "Control signal scaled in per unit before saturation";
          Real track "Tracking signal for anti-windup integral action";

          Modelica.Blocks.Interfaces.RealInput PV "Process variable signal"
            annotation (Placement(transformation(extent={{-112,-52},{-88,-28}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput CS "Control signal" annotation (
              Placement(transformation(extent={{88,-12},{112,12}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealInput SP "Set point signal" annotation (
              Placement(transformation(extent={{-112,28},{-88,52}}, rotation=0)));
        equation
          // Scaling
          SPs = (SP - PVmin)/(PVmax - PVmin);
          PVs = (PV - PVmin)/(PVmax - PVmin);
          CS = CSmin + CSs*(CSmax - CSmin);
          // Controller actions
          P = b*SPs - PVs;
          if integralAction then
            assert(Ti>0, "Integral time must be positive");
            Ti*der(I) = SPs - PVs + track;
          else
            I = 0;
          end if;
          if Td > 0 then
            Td/Nd*der(Dx) + Dx = c*SPs - PVs
              "State equation of approximated derivator";
            D = Nd*((c*SPs - PVs) - Dx)
              "Output equation of approximated derivator";
          else
            Dx = 0;
            D = 0;
          end if;
          if holdWhenSimplified then
            CSs_hom = CSstart;
          else
            CSs_hom = CSbs;
          end if;
          CSbs = Kp*(P + I + D) "Control signal before saturation";
          CSs = homotopy(smooth(0, if CSbs > 1 then 1 else if CSbs < 0 then 0 else
            CSbs), CSs_hom) "Saturated control signal";
          track = (CSs - CSbs)/(Kp*Ni);
        initial equation
          if steadyStateInit then
            if Ti > 0 then
              der(I) = 0;
            end if;
            if Td > 0 then
              D = 0;
            end if;
          end if;
          annotation (Diagram(graphics), Icon(graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-54,40},{52,-34}},
                  lineColor={0,0,255},
                  textString="PID"),
                Text(
                  extent={{-110,-108},{110,-142}},
                  lineColor={0,0,255},
                  lineThickness=0.5,
                  textString="%name")}));
        end PID;
      end Models;
      annotation (Documentation(info="<html>
<p>This package contains models of a simple Rankine cycle and its main components.
</html>",   revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Package created.</li>
</ul>
</html>"));
    end RankineCycle;

    package BraytonCycle "Gas power plant"
      extends Modelica.Icons.Package;

      model Plant
        parameter Real tableEtaC[6, 4]=[0, 95, 100, 105; 1, 82.5e-2, 81e-2,
            80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4,
            82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
        parameter Real tablePhicC[6, 4]=[0, 95, 100, 105; 1, 38.3e-3, 43e-3,
            46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3;
            4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
        parameter Real tablePR[6, 4]=[0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22,
            26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
        parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
            4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
            4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
        parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
            89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
            90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
        Electrical.Generator generator(initOpt=ThermoPower.Choices.Init.Options.steadyState, J=30)
          annotation (Placement(transformation(extent={{92,-80},{132,-40}},
                rotation=0)));
        Electrical.NetworkGrid_Pmax network(
          deltaStart=0.4,
          initOpt=ThermoPower.Choices.Init.Options.steadyState,
          Pmax=10e6,
          J=30000) annotation (Placement(transformation(extent={{148,-72},{172,-48}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput fuelFlowRate        annotation (
            Placement(transformation(extent={{-210,-10},{-190,10}}, rotation=0)));
        Modelica.Blocks.Interfaces.RealOutput generatedPower annotation (
            Placement(transformation(extent={{196,-10},{216,10}}, rotation=0)));
        Gas.Compressor compressor(
          redeclare package Medium = Media.Air,
          tablePhic=tablePhicC,
          tableEta=tableEtaC,
          pstart_in=0.343e5,
          pstart_out=8.3e5,
          Tstart_in=244.4,
          tablePR=tablePR,
          Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
          Tstart_out=600.4,
          explicitIsentropicEnthalpy=true,
          Tdes_in=244.4,
          Ndesign=157.08) annotation (Placement(transformation(extent={{-158,-90},
                  {-98,-30}}, rotation=0)));
        Gas.Turbine turbine(
          redeclare package Medium = Media.FlueGas,
          pstart_in=7.85e5,
          pstart_out=1.52e5,
          tablePhic=tablePhicT,
          tableEta=tableEtaT,
          Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
          Tstart_out=800,
          Tdes_in=1400,
          Tstart_in=1370,
          Ndesign=157.08) annotation (Placement(transformation(extent={{-6,-90},{
                  54,-30}}, rotation=0)));
        Gas.CombustionChamber CombustionChamber1(
          gamma=1,
          Cm=1,
          pstart=8.11e5,
          Tstart=1370,
          V=0.05,
          S=0.05,
          initOpt=ThermoPower.Choices.Init.Options.steadyState,
          HH=41.6e6) annotation (Placement(transformation(extent={{-72,20},{-32,
                  60}}, rotation=0)));
        Gas.SourcePressure
                    SourceP1(
          redeclare package Medium = Media.Air,
          p0=0.343e5,
          T=244.4) annotation (Placement(transformation(extent={{-188,-30},{-168,
                  -10}}, rotation=0)));
        Gas.SinkPressure
                  SinkP1(
          redeclare package Medium = Media.FlueGas,
          p0=1.52e5,
          T=800) annotation (Placement(transformation(extent={{94,-10},{114,10}},
                rotation=0)));
        Gas.SourceMassFlow
                    SourceW1(
          redeclare package Medium = Media.NaturalGas,
          w0=2.02,
          p0=811000,
          T=300,
          use_in_w0=true)
                 annotation (Placement(transformation(extent={{-100,70},{-80,90}},
                rotation=0)));
        Gas.PressDrop PressDrop1(
          redeclare package Medium = Media.FlueGas,
          FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
          wnom=102,
          rhonom=2,
          dpnom=26000,
          pstart=811000,
          Tstart=1370)
                    annotation (Placement(transformation(
              origin={0,8},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Gas.PressDrop PressDrop2(
          pstart=8.3e5,
          FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
          A=1,
          redeclare package Medium = Media.Air,
          dpnom=0.19e5,
          wnom=100,
          rhonom=4.7,
          Tstart=600) annotation (Placement(transformation(
              origin={-104,10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
           Placement(transformation(extent={{60,-70},{80,-50}}, rotation=0)));
        Modelica.Blocks.Continuous.FirstOrder gasFlowActuator(
          k=1,
          T=4,
          y_start=500,
          initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
              transformation(extent={{-138,92},{-122,108}}, rotation=0)));
        Modelica.Blocks.Continuous.FirstOrder powerSensor1(
          k=1,
          T=1,
          y_start=56.8e6,
          initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
              transformation(extent={{146,-118},{162,-102}}, rotation=0)));
        PowerPlants.HRSG.Components.StateReader_gas stateInletCC(
          redeclare package Medium = Media.Air) annotation (Placement(transformation(
                extent={{-100,30},{-80,50}}, rotation=0)));
        PowerPlants.HRSG.Components.StateReader_gas stateOutletCC(
          redeclare package Medium = Media.FlueGas) annotation (Placement(transformation(
                extent={{-24,30},{-4,50}}, rotation=0)));
        inner System system(allowFlowReversal=false)
          annotation (Placement(transformation(extent={{158,160},{178,180}})));
      equation
        connect(network.powerConnection, generator.powerConnection) annotation (
            Line(
            points={{148,-60},{129.2,-60}},
            pattern=LinePattern.None,
            thickness=0.5));
        connect(SourceW1.flange, CombustionChamber1.inf) annotation (Line(
            points={{-80,80},{-52,80},{-52,60}},
            color={159,159,223},
            thickness=0.5));
        connect(turbine.outlet, SinkP1.flange) annotation (Line(
            points={{48,-36},{48,0},{94,0}},
            color={159,159,223},
            thickness=0.5));
        connect(SourceP1.flange, compressor.inlet) annotation (Line(
            points={{-168,-20},{-152,-20},{-152,-36}},
            color={159,159,223},
            thickness=0.5));
        connect(PressDrop1.outlet, turbine.inlet) annotation (Line(
            points={{-1.83697e-015,-2},{-1.83697e-015,-36},{0,-36}},
            color={159,159,223},
            thickness=0.5));
        connect(compressor.outlet, PressDrop2.inlet) annotation (Line(
            points={{-104,-36},{-104,0}},
            color={159,159,223},
            thickness=0.5));
        connect(compressor.shaft_b, turbine.shaft_a) annotation (Line(
            points={{-110,-60},{6,-60}},
            color={0,0,0},
            thickness=0.5));
        connect(powerSensor.flange_a, turbine.shaft_b) annotation (Line(
            points={{60,-60},{42,-60}},
            color={0,0,0},
            thickness=0.5));
        connect(gasFlowActuator.u, fuelFlowRate)        annotation (Line(points={
                {-139.6,100},{-166,100},{-166,0},{-200,0}}, color={0,0,127}));
        connect(gasFlowActuator.y, SourceW1.in_w0) annotation (Line(points={{-121.2,
                100},{-96,100},{-96,85}}, color={0,0,127}));
        connect(powerSensor.power, powerSensor1.u) annotation (Line(points={{62,-71},
                {62,-110},{144.4,-110}}, color={0,0,127}));
        connect(powerSensor1.y, generatedPower) annotation (Line(points={{162.8,-110},
                {184.4,-110},{184.4,0},{206,0}}, color={0,0,127}));
        connect(CombustionChamber1.ina, stateInletCC.outlet) annotation (Line(
            points={{-72,40},{-84,40}},
            color={159,159,223},
            thickness=0.5));
        connect(stateInletCC.inlet, PressDrop2.outlet) annotation (Line(
            points={{-96,40},{-104,40},{-104,20}},
            color={159,159,223},
            thickness=0.5));
        connect(stateOutletCC.inlet, CombustionChamber1.out) annotation (Line(
            points={{-20,40},{-32,40}},
            color={159,159,223},
            thickness=0.5));
        connect(stateOutletCC.outlet, PressDrop1.inlet) annotation (Line(
            points={{-8,40},{1.83697e-015,40},{1.83697e-015,18}},
            color={159,159,223},
            thickness=0.5));
        connect(generator.shaft, powerSensor.flange_b) annotation (Line(
            points={{94.8,-60},{80,-60}},
            color={0,0,0},
            thickness=0.5));
        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-200,-200},{200,200}},
              initialScale=0.1), graphics),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-200,-200},{200,200}},
              initialScale=0.1), graphics={Rectangle(
                extent={{-200,200},{200,-200}},
                lineColor={170,170,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-140,140},{140,-140}},
                lineColor={170,170,255},
                textString="P")}),
          Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",   info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"));
      end Plant;

      model Plant2
        parameter Real tableEtaC[6, 4]=[0, 95, 100, 105; 1, 82.5e-2, 81e-2,
            80.5e-2; 2, 84e-2, 82.9e-2, 82e-2; 3, 83.2e-2, 82.2e-2, 81.5e-2; 4,
            82.5e-2, 81.2e-2, 79e-2; 5, 79.5e-2, 78e-2, 76.5e-2];
        parameter Real tablePhicC[6, 4]=[0, 95, 100, 105; 1, 38.3e-3, 43e-3,
            46.8e-3; 2, 39.3e-3, 43.8e-3, 47.9e-3; 3, 40.6e-3, 45.2e-3, 48.4e-3;
            4, 41.6e-3, 46.1e-3, 48.9e-3; 5, 42.3e-3, 46.6e-3, 49.3e-3];
        parameter Real tablePR[6, 4]=[0, 95, 100, 105; 1, 22.6, 27, 32; 2, 22,
            26.6, 30.8; 3, 20.8, 25.5, 29; 4, 19, 24.3, 27.1; 5, 17, 21.5, 24.2];
        parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
            4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
            4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
        parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
            89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
            90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
        Electrical.Generator generator(initOpt=ThermoPower.Choices.Init.Options.steadyState, J=30)
          annotation (Placement(transformation(extent={{92,-80},{132,-40}},
                rotation=0)));
        Electrical.NetworkGrid_Pmax network(
          deltaStart=0.4,
          initOpt=ThermoPower.Choices.Init.Options.steadyState,
          Pmax=10e6,
          J=30000) annotation (Placement(transformation(extent={{148,-72},{172,-48}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput fuelFlowRate        annotation (
            Placement(transformation(extent={{-210,-10},{-190,10}}, rotation=0)));
        Modelica.Blocks.Interfaces.RealOutput generatedPower annotation (
            Placement(transformation(extent={{196,-10},{216,10}}, rotation=0)));
        Gas.Compressor compressor(
          redeclare package Medium = Media.Air,
          tablePhic=tablePhicC,
          tableEta=tableEtaC,
          pstart_in=0.343e5,
          pstart_out=8.3e5,
          Tstart_in=244.4,
          tablePR=tablePR,
          Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
          Tstart_out=600.4,
          explicitIsentropicEnthalpy=true,
          Tdes_in=244.4,
          Ndesign=157.08) annotation (Placement(transformation(extent={{-158,-90},
                  {-98,-30}}, rotation=0)));
        Gas.Turbine turbine(
          redeclare package Medium = Media.FlueGas,
          pstart_in=7.85e5,
          pstart_out=1.52e5,
          tablePhic=tablePhicT,
          tableEta=tableEtaT,
          Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
          Tstart_out=800,
          Tdes_in=1400,
          Tstart_in=1370,
          Ndesign=157.08) annotation (Placement(transformation(extent={{-6,-90},{
                  54,-30}}, rotation=0)));
        Gas.CombustionChamber CombustionChamber1(
          gamma=1,
          Cm=1,
          pstart=8.11e5,
          Tstart=1370,
          V=0.05,
          S=0.05,
          initOpt=ThermoPower.Choices.Init.Options.steadyState,
          HH=41.6e6) annotation (Placement(transformation(extent={{-72,20},{-32,
                  60}}, rotation=0)));
        Gas.SourcePressure
                    SourceP1(
          redeclare package Medium = Media.Air,
          p0=0.343e5,
          T=244.4) annotation (Placement(transformation(extent={{-188,-30},{-168,
                  -10}}, rotation=0)));
        Gas.SinkPressure
                  SinkP1(
          redeclare package Medium = Media.FlueGas,
          p0=1.52e5,
          T=800) annotation (Placement(transformation(extent={{94,-10},{114,10}},
                rotation=0)));
        Gas.SourceMassFlow
                    SourceW1(
          redeclare package Medium = Media.NaturalGas,
          w0=2.02,
          p0=811000,
          T=300,
          use_in_w0=true)
                 annotation (Placement(transformation(extent={{-100,70},{-80,90}},
                rotation=0)));
        Gas.PressDrop PressDrop1(
          redeclare package Medium = Media.FlueGas,
          FFtype=ThermoPower.Choices.PressDrop.FFtypes.OpPoint,
          wnom=102,
          rhonom=2,
          dpnom=26000,
          pstart=811000,
          Tstart=1370)
                    annotation (Placement(transformation(
              origin={0,8},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor annotation (
           Placement(transformation(extent={{60,-70},{80,-50}}, rotation=0)));
        Modelica.Blocks.Continuous.FirstOrder gasFlowActuator(
          k=1,
          T=4,
          y_start=500,
          initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
              transformation(extent={{-138,92},{-122,108}}, rotation=0)));
        Modelica.Blocks.Continuous.FirstOrder powerSensor1(
          k=1,
          T=1,
          y_start=56.8e6,
          initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
              transformation(extent={{146,-118},{162,-102}}, rotation=0)));
        PowerPlants.HRSG.Components.StateReader_gas stateInletCC(
          redeclare package Medium = Media.Air) annotation (Placement(transformation(
                extent={{-100,30},{-80,50}}, rotation=0)));
        PowerPlants.HRSG.Components.StateReader_gas stateOutletCC(
          redeclare package Medium = Media.FlueGas) annotation (Placement(transformation(
                extent={{-24,30},{-4,50}}, rotation=0)));
        inner System system(allowFlowReversal=false)
          annotation (Placement(transformation(extent={{158,160},{178,180}})));
      equation
        connect(network.powerConnection, generator.powerConnection) annotation (
            Line(
            points={{148,-60},{129.2,-60}},
            pattern=LinePattern.None,
            thickness=0.5));
        connect(SourceW1.flange, CombustionChamber1.inf) annotation (Line(
            points={{-80,80},{-52,80},{-52,60}},
            color={159,159,223},
            thickness=0.5));
        connect(turbine.outlet, SinkP1.flange) annotation (Line(
            points={{48,-36},{48,0},{94,0}},
            color={159,159,223},
            thickness=0.5));
        connect(SourceP1.flange, compressor.inlet) annotation (Line(
            points={{-168,-20},{-152,-20},{-152,-36}},
            color={159,159,223},
            thickness=0.5));
        connect(PressDrop1.outlet, turbine.inlet) annotation (Line(
            points={{-1.83697e-015,-2},{-1.83697e-015,-36},{0,-36}},
            color={159,159,223},
            thickness=0.5));
        connect(compressor.shaft_b, turbine.shaft_a) annotation (Line(
            points={{-110,-60},{6,-60}},
            color={0,0,0},
            thickness=0.5));
        connect(powerSensor.flange_a, turbine.shaft_b) annotation (Line(
            points={{60,-60},{42,-60}},
            color={0,0,0},
            thickness=0.5));
        connect(gasFlowActuator.u, fuelFlowRate)        annotation (Line(points={
                {-139.6,100},{-166,100},{-166,0},{-200,0}}, color={0,0,127}));
        connect(gasFlowActuator.y, SourceW1.in_w0) annotation (Line(points={{-121.2,
                100},{-96,100},{-96,85}}, color={0,0,127}));
        connect(powerSensor.power, powerSensor1.u) annotation (Line(points={{62,-71},
                {62,-110},{144.4,-110}}, color={0,0,127}));
        connect(powerSensor1.y, generatedPower) annotation (Line(points={{162.8,-110},
                {184.4,-110},{184.4,0},{206,0}}, color={0,0,127}));
        connect(CombustionChamber1.ina, stateInletCC.outlet) annotation (Line(
            points={{-72,40},{-84,40}},
            color={159,159,223},
            thickness=0.5));
        connect(stateOutletCC.inlet, CombustionChamber1.out) annotation (Line(
            points={{-20,40},{-32,40}},
            color={159,159,223},
            thickness=0.5));
        connect(stateOutletCC.outlet, PressDrop1.inlet) annotation (Line(
            points={{-8,40},{1.83697e-015,40},{1.83697e-015,18}},
            color={159,159,223},
            thickness=0.5));
        connect(generator.shaft, powerSensor.flange_b) annotation (Line(
            points={{94.8,-60},{80,-60}},
            color={0,0,0},
            thickness=0.5));
        connect(compressor.outlet, stateInletCC.inlet) annotation (Line(
            points={{-104,-36},{-104,36},{-96,36},{-96,40}},
            color={159,159,223},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-200,-200},{200,200}},
              initialScale=0.1), graphics),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-200,-200},{200,200}},
              initialScale=0.1), graphics={Rectangle(
                extent={{-200,200},{200,-200}},
                lineColor={170,170,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-140,140},{140,-140}},
                lineColor={170,170,255},
                textString="P")}),
          Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",   info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"));
      end Plant2;

      model OpenLoopSimulator

        Plant plant annotation (Placement(transformation(extent={{20,-20},{60,20}},
                rotation=0)));
        Modelica.Blocks.Sources.Step fuelFlowRate(
          offset=2.02,
          height=0.3,
          startTime=500) annotation (Placement(transformation(extent={{-40,-10},{
                  -20,10}}, rotation=0)));
        inner System system
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
      equation
        connect(plant.fuelFlowRate, fuelFlowRate.y)
          annotation (Line(points={{20,0},{-19,0}}, color={0,0,127}));
        annotation (
          Diagram(graphics),
          experiment(
            StopTime=1000,
            __Dymola_NumberOfIntervals=5000,
            Tolerance=1e-006),
          Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",   info="<html>
<p>This model allows to simulate an open loop transients.
</html>"),__Dymola_experimentSetupOutput);
      end OpenLoopSimulator;

      model OpenLoopSimulator2

        Plant2 plant
                    annotation (Placement(transformation(extent={{20,-20},{60,20}},
                rotation=0)));
        Modelica.Blocks.Sources.Step fuelFlowRate(
          offset=2.02,
          height=0.3,
          startTime=500) annotation (Placement(transformation(extent={{-40,-10},{
                  -20,10}}, rotation=0)));
        inner System system
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
      equation
        connect(plant.fuelFlowRate, fuelFlowRate.y)
          annotation (Line(points={{20,0},{-19,0}}, color={0,0,127}));
        annotation (
          Diagram(graphics),
          experiment(
            StopTime=1000,
            __Dymola_NumberOfIntervals=5000,
            Tolerance=1e-006),
          Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",   info="<html>
<p>This model allows to simulate an open loop transients.
</html>"),__Dymola_experimentSetupOutput);
      end OpenLoopSimulator2;
      annotation (Documentation(revisions="<html>
<ul>
<li><i>12 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       Package created.</li>
</ul>
</html>",   info="<html>
<p>This package contains models of a open Brayton cycle and its main components.
</html>"));
    end BraytonCycle;
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

    model SourcePressure "Pressure source for gas flows"
      extends Icons.Gas.SourceP;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(
        p(start=p0),
        T(start=T),
        Xi(start=Xnom[1:Medium.nXi]));
      parameter Pressure p0=101325 "Nominal pressure";
      parameter HydraulicResistance R=0 "Hydraulic resistance";
      parameter AbsoluteTemperature T=300 "Nominal temperature";
      parameter MassFraction Xnom[Medium.nX]=Medium.reference_X
        "Nominal gas composition";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false
        "Use connector input for the pressure"                                   annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_T = false
        "Use connector input for the temperature"                                  annotation(Dialog(group="External inputs"));
      parameter Boolean use_in_X = false
        "Use connector input for the composition"                                  annotation(Dialog(group="External inputs"));

      outer ThermoPower.System system "System wide properties";

      FlangeB flange(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation (Placement(
            transformation(
            origin={-60,64},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation (Placement(
            transformation(
            origin={0,90},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Interfaces.RealInput in_X[Medium.nX] if use_in_X annotation (Placement(
            transformation(
            origin={60,62},
            extent={{-10,-10},{10,10}},
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
      annotation (
        Icon(graphics),
        Diagram(graphics),
        Documentation(info="<html>
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.In the case of multiple componet, variable composition gases, the nominal gas composition is given by <tt>Xnom</tt>, whose default value is <tt>Medium.reference_X</tt> .
<p>If <tt>R</tt> is set to zero, the pressure source is ideal; otherwise, the outlet pressure decreases proportionally to the outgoing flowrate.</p>
<p>If the <tt>in_p</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
<p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T</tt>.</p>
<p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>Xnom</tt>.</p>
</html>",   revisions="<html>
<ul>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0fix</tt> and <tt>Tfix</tt> and <tt>Xfix</tt>; the connection of external signals is now detected automatically.</li> <br> Adapted to Modelica.Media
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"));
    end SourcePressure;

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

    model PressDrop "Pressure drop for gas flows"
      extends Icons.Gas.Tube;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(
        p(start=pstart),
        T(start=Tstart),
        Xi(start=Xstart[1:Medium.nXi]));
      parameter MassFlowRate wnom "Nominal mass flowrate";
      parameter Pressure dpnom "Nominal pressure drop";
      parameter ThermoPower.Choices.PressDrop.FFtypes FFtype= ThermoPower.Choices.PressDrop.FFtypes.Kf
        "Friction factor type";
      parameter Real Kf = 0
        "Hydraulic resistance coefficient (DP = Kf*w^2/rho)"
        annotation(Dialog(enable = (FFtype == ThermoPower.Choices.PressDrop.FFtypes.Kf)));
      parameter Density rhonom=0 "Nominal density"
        annotation(Dialog(enable = (FFtype == ThermoPower.Choices.PressDrop.FFtypes.OpPoint)));
      parameter Real K=0
        "Kinetic resistance coefficient (DP=K*rho*velocity2/2)"
        annotation(Dialog(enable = (FFtype == ThermoPower.Choices.PressDrop.FFtypes.Kinetic)));
      parameter Area A=0 "Cross-section"
        annotation(Dialog(enable = (FFtype == ThermoPower.Choices.PressDrop.FFtypes.Kinetic)));
      parameter Real wnf=0.01
        "Fraction of nominal flow rate at which linear friction equals turbulent friction";
      parameter Real Kfc=1 "Friction factor correction coefficient";
      final parameter Real Kf_a(fixed = false)
        "Actual hydraulic resistance coefficient";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter Pressure pstart=101325 "Start pressure value"
        annotation (Dialog(tab="Initialisation"));
      parameter AbsoluteTemperature Tstart=300 "Start temperature value"
        annotation (Dialog(tab="Initialisation"));
      parameter MassFraction Xstart[Medium.nX]=Medium.reference_X
        "Start gas composition" annotation (Dialog(tab="Initialisation"));
      function squareReg = ThermoPower.Functions.squareReg;
      MassFlowRate w "Mass flow rate in the inlet";
      Pressure pin "Inlet pressure";
      Pressure pout "Outlet pressure";
      Pressure dp "Pressure drop";

      FlangeA inlet(redeclare package Medium = Medium, m_flow(start=wnom, min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(start=-wnom, max=
              if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=
               0)));
    initial equation
      if FFtype ==  ThermoPower.Choices.PressDrop.FFtypes.Kf then
        Kf_a = Kf*Kfc;
      elseif FFtype ==  ThermoPower.Choices.PressDrop.FFtypes.OpPoint then
        Kf_a = dpnom*rhonom/wnom^2*Kfc;
      elseif FFtype ==  ThermoPower.Choices.PressDrop.FFtypes.Kinetic then
        Kf_a = K/(2*A^2)*Kfc;
      else
        Kf_a = 0;
        assert(false, "Unsupported FFtype");
      end if;
    equation
      assert(dpnom > 0,
        "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
      // Set fluid properties
      gas.p = homotopy(if not allowFlowReversal then pin else if inlet.m_flow >=
        0 then pin else pout, pin);
      gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow)
         else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
      gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow)
         else actualStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));

      pin - pout = homotopy(smooth(1, Kf*squareReg(w, wnom*wnf))/gas.d, dpnom/
        wnom*w) "Flow characteristics";

      //Boundary conditions
      w = inlet.m_flow;
      pin = inlet.p;
      pout = outlet.p;
      dp = pin - pout;

      // Mass balance
      inlet.m_flow + outlet.m_flow = 0;

      // Energy balance
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;

      // Independent component mass balances
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);
      inStream(inlet.Xi_outflow) = outlet.Xi_outflow;
      annotation (
        Icon(graphics={Text(extent={{-100,-40},{100,-80}}, textString="%name")}),
        Diagram(graphics),
        Documentation(info="<html>
<p>The pressure drop across the inlet and outlet connectors is computed according to a turbulent friction model, i.e. is proportional to the squared velocity of the fluid. The friction coefficient can be specified directly, or by giving an operating point, or as a multiple of the kinetic pressure. The correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit some experimental operating point.</p>
<p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified; the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate).
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>The following options are available to specify the friction coefficient:
<ul><li><tt>FFtype = 0</tt>: the hydraulic friction coefficient <tt>Kf</tt> is used directly.</li>
<li><tt>FFtype = 1</tt>: the hydraulic friction coefficient is specified by the nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).</li>
<li><tt>FFtype = 2</tt>: the pressure drop is <tt>K</tt> times the kinetic pressure.</li></ul>
</html>",   revisions="<html>
<ul>
<li><i>19 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> <tt>Kfnom</tt> removed, <tt>Kf</tt> can now be set directly.</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end PressDrop;

    partial model CombustionChamberBase "Combustion Chamber"
      extends Icons.Gas.Mixer;
      replaceable package Air = Modelica.Media.Interfaces.PartialMedium;
      replaceable package Fuel = Modelica.Media.Interfaces.PartialMedium;
      replaceable package Exhaust = Modelica.Media.Interfaces.PartialMedium;
      parameter Volume V "Inner volume";
      parameter Area S=0 "Inner surface";
      parameter CoefficientOfHeatTransfer gamma=0 "Heat Transfer Coefficient"
        annotation (Evaluate=true);
      parameter HeatCapacity Cm=0 "Metal Heat Capacity" annotation (Evaluate=true);
      parameter Temperature Tmstart=300 "Metal wall start temperature"
        annotation (Dialog(tab="Initialisation"));
      parameter SpecificEnthalpy HH "Lower Heating value of fuel";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter Pressure pstart=101325 "Pressure start value"
        annotation (Dialog(tab="Initialisation"));
      parameter AbsoluteTemperature Tstart=300 "Temperature start value"
        annotation (Dialog(tab="Initialisation"));
      parameter MassFraction Xstart[Exhaust.nX]=Exhaust.reference_X
        "Start flue gas composition" annotation (Dialog(tab="Initialisation"));
      parameter Choices.Init.Options initOpt=Choices.Init.Options.noInit
        "Initialisation option" annotation (Dialog(tab="Initialisation"));
      Exhaust.BaseProperties fluegas(
        p(start=pstart),
        T(start=Tstart),
        Xi(start=Xstart[1:Exhaust.nXi]));
      Mass M "Gas total mass";
      Mass MX[Exhaust.nXi] "Partial flue gas masses";
      InternalEnergy E "Gas total energy";
      AbsoluteTemperature Tm(start=Tmstart) "Wall temperature";
      Air.SpecificEnthalpy hia "Air specific enthalpy";
      Fuel.SpecificEnthalpy hif "Fuel specific enthalpy";
      Exhaust.SpecificEnthalpy ho "Outlet specific enthalpy";
      Power HR "Heat rate";

      Time Tr "Residence time";
      FlangeA ina(redeclare package Medium = Air, m_flow(min=if allowFlowReversal
               then -Modelica.Constants.inf else 0)) "inlet air" annotation (
          Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
      FlangeA inf(redeclare package Medium = Fuel, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0))
        "inlet fuel" annotation (Placement(transformation(extent={{-20,80},{20,
                120}}, rotation=0)));
      FlangeB out(redeclare package Medium = Exhaust, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0))
        "flue gas"
        annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=
               0)));
    equation
      M = fluegas.d*V "Gas mass";
      E = fluegas.u*M "Gas energy";
      MX = fluegas.Xi*M "Component masses";
      HR = inf.m_flow*HH;
      der(M) = ina.m_flow + inf.m_flow + out.m_flow "Gas mass balance";
      der(E) = ina.m_flow*hia + inf.m_flow*hif + out.m_flow*ho + HR - gamma*S*(
        fluegas.T - Tm) "Gas energy balance";
      if Cm > 0 and gamma > 0 then
        Cm*der(Tm) = gamma*S*(fluegas.T - Tm) "Metal wall energy balance";
      else
        Tm = fluegas.T;
      end if;

      // Set gas properties
      out.p = fluegas.p;
      out.h_outflow = fluegas.h;
      out.Xi_outflow = fluegas.Xi;

      // Boundary conditions
      ina.p = fluegas.p;
      ina.h_outflow = 0;
      ina.Xi_outflow = Air.reference_X[1:Air.nXi];
      inf.p = fluegas.p;
      inf.h_outflow = 0;
      inf.Xi_outflow = Fuel.reference_X[1:Fuel.nXi];
      assert(ina.m_flow >= 0, "The model does not support flow reversal");
      hia = inStream(ina.h_outflow);
      assert(inf.m_flow >= 0, "The model does not support flow reversal");
      hif = inStream(inf.h_outflow);
      assert(out.m_flow <= 0, "The model does not support flow reversal");
      ho = fluegas.h;

      Tr = noEvent(M/max(abs(out.m_flow), Modelica.Constants.eps));
    initial equation
      // Initial conditions
      if initOpt == Choices.Init.Options.noInit then
        // do nothing
      elseif initOpt == Choices.Init.Options.steadyState then
        der(fluegas.p) = 0;
        der(fluegas.T) = 0;
        der(fluegas.Xi) = zeros(Exhaust.nXi);
        if (Cm > 0 and gamma > 0) then
          der(Tm) = 0;
        end if;
      elseif initOpt == Choices.Init.Options.steadyStateNoP then
        der(fluegas.T) = 0;
        der(fluegas.Xi) = zeros(Exhaust.nXi);
        if (Cm > 0 and gamma > 0) then
          der(Tm) = 0;
        end if;
      else
        assert(false, "Unsupported initialisation option");
      end if;

      annotation (Documentation(info="<html>
This is the model-base of a Combustion Chamber, with a constant volume.
<p>The metal wall temperature and the heat transfer coefficient between the wall and the fluid are uniform. The wall is thermally insulated from the outside. It has been assumed that inlet gases are premixed before entering in the volume.
<p><b>Modelling options</b></p>
<p>This model has three different Medium models to characterize the inlet air, fuel, and flue gas exhaust.
<p>If <tt>gamma = 0</tt>, the thermal effects of the surrounding walls are neglected.
</p>
</html>",   revisions="<html>
<ul>
<li><i>30 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Initialisation support added.</li>
<li><i>31 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
    CombustionChamber model restructured using inheritance.
<p> First release.</li>
</ul>
</html>
"),   Diagram(graphics));
    end CombustionChamberBase;

    model CombustionChamber "Combustion Chamber"
      extends CombustionChamberBase(
        redeclare package Air = Media.Air "O2, H2O, Ar, N2",
        redeclare package Fuel = Media.NaturalGas "N2, CO2, CH4",
        redeclare package Exhaust = Media.FlueGas "O2, Ar, H2O, CO2, N2");
      Real wcomb(final quantity="MolarFlowRate", unit="mol/s")
        "Molar Combustion rate (CH4)";
      Real lambda
        "Stoichiometric ratio (>1 if air flow is greater than stoichiometric)";
    protected
      Real ina_X[Air.nXi]=inStream(ina.Xi_outflow);
      Real inf_X[Fuel.nXi]=inStream(inf.Xi_outflow);

    equation
      wcomb = inf.m_flow*inf_X[3]/Fuel.data[3].MM "Combustion molar flow rate";
      lambda = (ina.m_flow*ina_X[1]/Air.data[1].MM)/(2*wcomb);
      assert(lambda >= 1, "Not enough oxygen flow");
      der(MX[1]) = ina.m_flow*ina_X[1] + out.m_flow*fluegas.X[1] - 2*wcomb*
        Exhaust.data[1].MM "oxygen";
      der(MX[2]) = ina.m_flow*ina_X[3] + out.m_flow*fluegas.X[2] "argon";
      der(MX[3]) = ina.m_flow*ina_X[2] + out.m_flow*fluegas.X[3] + 2*wcomb*
        Exhaust.data[3].MM "water";
      der(MX[4]) = inf.m_flow*inf_X[2] + out.m_flow*fluegas.X[4] + wcomb*Exhaust.data[
        4].MM "carbondioxide";
      der(MX[5]) = ina.m_flow*ina_X[4] + out.m_flow*fluegas.X[5] + inf.m_flow*
        inf_X[1] "nitrogen";
      annotation (Icon(graphics), Documentation(info="<html>
This model extends the CombustionChamber Base model, with the definition of the gases.
<p>In particular, the air inlet uses the <tt>Media.Air</tt> medium model, the fuel input uses the <tt>Media.NaturalGas</tt> medium model, and the flue gas outlet uses the <tt>Medium.FlueGas</tt> medium model.
<p>The composition of the outgoing gas is determined by the mass balance of every component, taking into account the combustion reaction CH4+2O2--->2H2O+CO2.</p>
<p>The model assumes complete combustion, so that it is only valid if the oxygen flow at the air inlet is greater than the stoichiometric flow corresponding to the flow at the fuel inlet.</p>

</html>",   revisions="<html>
<ul>
<li><i>31 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
 Combustion Chamber model restructured using inheritance.
     <p>  First release.
 </li>
</ul>
</html>"));
    end CombustionChamber;

    partial model CompressorBase "Gas compressor"
      extends ThermoPower.Icons.Gas.Compressor;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      parameter Boolean explicitIsentropicEnthalpy=true
        "isentropicEnthalpy function used";
      parameter Real eta_mech=0.98 "mechanical efficiency";
      parameter Modelica.SIunits.Pressure pstart_in "inlet start pressure"
        annotation (Dialog(tab="Initialisation"));
      parameter Modelica.SIunits.Pressure pstart_out "outlet start pressure"
        annotation (Dialog(tab="Initialisation"));
      parameter ThermoPower.AbsoluteTemperature Tdes_in
        "inlet design temperature";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter ThermoPower.AbsoluteTemperature Tstart_in=Tdes_in
        "inlet start temperature" annotation (Dialog(tab="Initialisation"));
      parameter ThermoPower.AbsoluteTemperature Tstart_out
        "outlet start temperature" annotation (Dialog(tab="Initialisation"));
      parameter Modelica.SIunits.MassFraction Xstart[Medium.nX]=Medium.reference_X
        "start gas composition" annotation (Dialog(tab="Initialisation"));
      Medium.BaseProperties gas_in(
        p(start=pstart_in),
        T(start=Tstart_in),
        Xi(start=Xstart[1:Medium.nXi]));
      Medium.BaseProperties gas_iso(
        p(start=pstart_out),
        T(start=Tstart_out),
        Xi(start=Xstart[1:Medium.nXi]));
      Medium.SpecificEnthalpy hout_iso "Outlet isentropic enthalpy";
      Medium.SpecificEnthalpy hout "Outlet enthaply";
      Medium.SpecificEntropy s_in "Inlet specific entropy";
      Medium.AbsolutePressure pout(start=pstart_out) "Outlet pressure";

      Modelica.SIunits.MassFlowRate w "Gas flow rate";
      Modelica.SIunits.Angle phi "shaft rotation angle";
      Modelica.SIunits.AngularVelocity omega "shaft angular velocity";
      Modelica.SIunits.Torque tau "net torque acting on the compressor";

      Real eta "isentropic efficiency";
      Real PR "pressure ratio";

      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-100,60},{-60,100}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{60,60},{100,100}}, rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
          Placement(transformation(extent={{-72,-12},{-48,12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
          Placement(transformation(extent={{48,-12},{72,12}}, rotation=0)));

    equation
      w = inlet.m_flow;
      assert(w >= 0, "The compressor model does not support flow reversal");
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";

      // Set inlet gas properties
      gas_in.p = inlet.p;
      gas_in.h = inStream(inlet.h_outflow);
      gas_in.Xi = inStream(inlet.Xi_outflow);

      // Set outlet gas properties
      outlet.p = pout;
      outlet.h_outflow = hout;
      outlet.Xi_outflow = gas_in.Xi;

      // Equations for reverse flow (not used)
      inlet.h_outflow = inStream(outlet.h_outflow);
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);

      // Component mass balances
      gas_iso.Xi = gas_in.Xi;

      if explicitIsentropicEnthalpy then
        hout_iso = Medium.isentropicEnthalpy(outlet.p, gas_in.state)
          "Approximated isentropic enthalpy";
        hout - gas_in.h = 1/eta*(hout_iso - gas_in.h);
        // dummy assignments
        s_in = 0;
        gas_iso.p = 1e5;
        gas_iso.T = 300;
      else
        // Properties of the gas after isentropic transformation
        gas_iso.p = pout;
        s_in = Medium.specificEntropy(gas_in.state);
        s_in = Medium.specificEntropy(gas_iso.state);
        hout - gas_in.h = 1/eta*(gas_iso.h - gas_in.h);
        // dummy assignment
        hout_iso = 0;
      end if;

      w*(hout - gas_in.h) = tau*omega*eta_mech "Energy balance";
      PR = pout/gas_in.p "Pressure ratio";

      // Mechanical boundary conditions
      shaft_a.phi = phi;
      shaft_b.phi = phi;
      shaft_a.tau + shaft_b.tau = tau;
      der(phi) = omega;
      annotation (
        Documentation(info="<html>
<p>This is the base model for a compressor, including the interface and all equations except the actual computation of the performance characteristics. Reverse flow conditions are not supported.</p>
<p>This model does not include any shaft inertia by itself; if that is needed, connect a Modelica.Mechanics.Rotational.Inertia model to one of the shaft connectors.</p>
<p>As a base-model, it can be used both for axial and centrifugal compressors.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>The following options are available to calculate the enthalpy of the outgoing gas:
<ul><li><tt>explicitIsentropicEnthalpy = true</tt>: the isentropic enthalpy <tt>hout_iso</tt> is calculated by the <tt>Medium.isentropicEnthalpy</tt> function. <li><tt>explicitIsentropicEnthalpy = false</tt>: the isentropic enthalpy is obtained by equating the specific entropy of the inlet gas <tt>gas_in</tt> and of a fictious gas state <tt>gas_iso</tt>, with the same pressure of the outgoing gas; both are computed with the function <tt>Medium.specificEntropy</tt>.</pp></ul>
</html>",   revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium.BaseProperties <tt>gas_out</tt>removed.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Compressor model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),     Diagram(graphics),
        Icon(graphics={Text(
              extent={{-128,-60},{128,-100}},
              lineColor={0,0,255},
              textString="%name")}));
    end CompressorBase;

    model Compressor "Gas compressor"
      extends CompressorBase;
      import ThermoPower.Choices.TurboMachinery.TableTypes;
      parameter AngularVelocity Ndesign "Design velocity";
      parameter Real tablePhic[:, :]=fill(
            0,
            0,
            2) "Table for phic(N_T,beta)";
      parameter Real tableEta[:, :]=fill(
            0,
            0,
            2) "Table for eta(N_T,beta)";
      parameter Real tablePR[:, :]=fill(
            0,
            0,
            2) "Table for eta(N_T,beta)";
      parameter String fileName="noName" "File where matrix is stored";
      parameter TableTypes Table
        "Selection of the way of definition of table matrix";
      Modelica.Blocks.Tables.CombiTable2D Eta(
        tableOnFile=if (Table == TableTypes.matrix) then false else true,
        table=tableEta,
        tableName=if (Table == TableTypes.matrix) then "NoName" else "tabEta",
        fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
        annotation (Placement(transformation(extent={{-12,60},{8,80}}, rotation=0)));
      Modelica.Blocks.Tables.CombiTable2D PressRatio(
        tableOnFile=if (Table == TableTypes.matrix) then false else true,
        table=tablePR,
        tableName=if (Table == TableTypes.matrix) then "NoName" else "tabPR",
        fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
        annotation (Placement(transformation(extent={{-12,0},{8,20}}, rotation=0)));
      Modelica.Blocks.Tables.CombiTable2D Phic(
        tableOnFile=if (Table == TableTypes.matrix) then false else true,
        table=tablePhic,
        tableName=if (Table == TableTypes.matrix) then "NoName" else "tabPhic",
        fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
        annotation (Placement(transformation(extent={{-12,30},{8,50}}, rotation=0)));
      Real N_T "Referred speed ";
      Real N_T_design "Referred design velocity";
      Real phic "Flow number ";
      Real beta(start=integer(size(tablePhic, 1)/2)) "Number of beta line";

    equation
      N_T_design = Ndesign/sqrt(Tdes_in) "Referred design velocity";
      N_T = 100*omega/(sqrt(gas_in.T)*N_T_design)
        "Referred speed definition, as percentage of design velocity";
      phic = w*sqrt(gas_in.T)/(gas_in.p) "Flow number definition";

      // phic = Phic(beta, N_T)
      Phic.u1 = beta;
      Phic.u2 = N_T;
      phic = Phic.y;

      // eta = Eta(beta, N_T)
      Eta.u1 = beta;
      Eta.u2 = N_T;
      eta = Eta.y;

      // PR = PressRatio(beta, N_T)
      PressRatio.u1 = beta;
      PressRatio.u2 = N_T;
      PR = PressRatio.y;
      annotation (Documentation(info="<html>
This model adds the performance characteristics to the Compressor_Base model, by means of 2D interpolation tables.</p>
<p>The perfomance characteristics are specified by two characteristic equations: the first relates the flow number <tt>phic</tt>, the pressure ratio <tt>PR</tt> and the referred speed <tt>N_T</tt>; the second relates the efficiency <tt>eta</tt>, the flow number <tt>phic</tt>, and the referred speed <tt>N_T</tt> [1]. To avoid singularities, the two characteristic equations are expressed in parametric form by adding a further variable <tt>beta</tt> (method of beta lines [2]).
<p>The performance maps are thus tabulated into three differents tables, <tt>tablePhic</tt>,  <tt>tablePR</tt> and <tt>tableEta</tt>, which express <tt>phic</tt>, <tt>PR</tt> and <tt>eta</tt> as a function of <tt>N_T</tt> and <tt>beta</tt>, respectively, where <tt>N_T</tt> is the first row while <tt>beta</tt> is the first column. The referred speed <tt>N_T</tt> is defined as a percentage of the design referred speed and <tt>beta</tt> are arbitrary lines, usually drawn parallel to the surge-line on the performance maps.
<p><tt>Modelica.Blocks.Tables.CombiTable2D</tt> interpolates the tables to obtain values of referred flow, pressure ratio and efficiency at given levels of referred speed and beta.
<p><b>Modelling options</b></p>
<p>The following options are available to determine how the table is defined:
<ul><li><tt>Table = 0</tt>: the table is explicitly supplied as matrix parameter.
<li><tt>Table = 1</tt>: the table is read from a file; the string <tt>fileName</tt> contains the path to the files where the tables are stored, either in ASCII or Matlab binary format.
</ul>
<p><b>References:</b></p>
<ol>
<li>S. L. Dixon: <i>Fluid mechanics, thermodynamics of turbomachinery</i>, Oxford, Pergamon press, 1966, pp. 213.
<li>P. P. Walsh, P. Fletcher: <i>Gas Turbine Performance</i>, 2nd ed., Oxford, Blackwell, 2004, pp. 646.
</ol>
</html>",   revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       New method for calculating performance parameters using tables.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Compressor model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end Compressor;

    partial model TurbineBase "Gas Turbine"
      extends ThermoPower.Icons.Gas.Turbine;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation(choicesAllMatching = true);
      parameter Boolean explicitIsentropicEnthalpy=true
        "isentropicEnthalpy function used";
      parameter Real eta_mech=0.98 "mechanical efficiency";
      parameter ThermoPower.AbsoluteTemperature Tdes_in
        "inlet design temperature";
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter Modelica.SIunits.Pressure pstart_in "inlet start pressure"
        annotation (Dialog(tab="Initialisation"));
      parameter Modelica.SIunits.Pressure pstart_out "outlet start pressure"
        annotation (Dialog(tab="Initialisation"));
      parameter ThermoPower.AbsoluteTemperature Tstart_in=Tdes_in
        "inlet start temperature" annotation (Dialog(tab="Initialisation"));
      parameter ThermoPower.AbsoluteTemperature Tstart_out
        "outlet start temperature" annotation (Dialog(tab="Initialisation"));
      parameter Modelica.SIunits.MassFraction Xstart[Medium.nX]=Medium.reference_X
        "start gas composition" annotation (Dialog(tab="Initialisation"));

      Medium.BaseProperties gas_in(
        p(start=pstart_in),
        T(start=Tstart_in),
        Xi(start=Xstart[1:Medium.nXi]));
      Medium.BaseProperties gas_iso(
        p(start=pstart_out),
        T(start=Tstart_out),
        Xi(start=Xstart[1:Medium.nXi]));

      Modelica.SIunits.Angle phi "shaft rotation angle";
      Modelica.SIunits.Torque tau "net torque acting on the turbine";
      Modelica.SIunits.AngularVelocity omega "shaft angular velocity";
      Modelica.SIunits.MassFlowRate w "Gas flow rate";
      Medium.SpecificEntropy s_in "Inlet specific entropy";
      Medium.SpecificEnthalpy hout_iso "Outlet isentropic enthalpy";
      Medium.SpecificEnthalpy hout "Outlet enthalpy";
      Medium.AbsolutePressure pout(start=pstart_out) "Outlet pressure";
      Real PR "pressure ratio";
      Real eta "isoentropic efficiency";

      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
          Placement(transformation(extent={{-72,-12},{-48,12}}, rotation=0)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
          Placement(transformation(extent={{48,-12},{72,12}}, rotation=0)));
      FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
              allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{-100,60},{-60,100}}, rotation=0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
              allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
         Placement(transformation(extent={{60,60},{100,100}}, rotation=0)));
    equation
      w = inlet.m_flow;
      assert(w >= 0, "The turbine model does not support flow reversal");
      inlet.m_flow + outlet.m_flow = 0 "Mass balance";

      // Set inlet gas properties
      gas_in.p = inlet.p;
      gas_in.h = inStream(inlet.h_outflow);
      gas_in.Xi = inStream(inlet.Xi_outflow);

      // Set outlet gas properties
      outlet.p = pout;
      outlet.h_outflow = hout;
      outlet.Xi_outflow = gas_in.Xi;

      // Equations for reverse flow (not used)
      inlet.h_outflow = inStream(outlet.h_outflow);
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);

      // Component mass balances
      gas_iso.Xi = gas_in.Xi;

      if explicitIsentropicEnthalpy then
        hout_iso = Medium.isentropicEnthalpy(outlet.p, gas_in.state)
          "Approximated isentropic enthalpy";
        hout - gas_in.h = eta*(hout_iso - gas_in.h) "Enthalpy change";
        //dummy assignments
        s_in = 0;
        gas_iso.p = 1e5;
        gas_iso.T = 300;
      else
        // Properties of the gas after isentropic transformation
        gas_iso.p = pout;
        s_in = Medium.specificEntropy(gas_in.state);
        s_in = Medium.specificEntropy(gas_iso.state);
        hout - gas_in.h = eta*(gas_iso.h - gas_in.h) "Enthalpy change";
        //dummy assignment
        hout_iso = 0;
      end if;

      w*(hout - gas_in.h)*eta_mech = tau*omega "Energy balance";
      PR = gas_in.p/pout "Pressure ratio";

      // Mechanical boundary conditions
      shaft_a.phi = phi;
      shaft_b.phi = phi;
      shaft_a.tau + shaft_b.tau = tau;
      der(phi) = omega;
      annotation (
        Documentation(info="<html>
<p>This is the base model for a turbine, including the interface and all equations except the actual computation of the performance characteristics. Reverse flow conditions are not supported.</p>
<p>This model does not include any shaft inertia by itself; if that is needed, connect a Modelica.Mechanics.Rotational.Inertia model to one of the shaft connectors.</p>
<p>As a base-model, it can be used both for axial and radial turbines.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>The following options are available to calculate the enthalpy of the outgoing gas:
<ul><li><tt>explicitIsentropicEnthalpy = true</tt>: the isentropic enthalpy <tt>hout_iso</tt> is calculated by the <tt>Medium.isentropicEnthalpy</tt> function. <li><tt>explicitIsentropicEnthalpy = false</tt>: the isentropic enthalpy is determined by equating the specific entropy of the inlet gas <tt>gas_in</tt> and of a fictious gas state <tt>gas_iso</tt>, with the same pressure of the outgoing gas; both are computed with the function <tt>Medium.specificEntropy</tt>.</pp></ul>
</html>",   revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium.BaseProperties <tt>gas_out</tt>removed.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Turbine model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
        Icon(graphics={Text(
              extent={{-128,-60},{128,-100}},
              lineColor={0,0,255},
              textString="%name")}),
        Diagram(graphics));
    end TurbineBase;

    model Turbine "Gas Turbine"
      extends TurbineBase;
      import ThermoPower.Choices.TurboMachinery.TableTypes;
      parameter AngularVelocity Ndesign "Design speed";
      parameter Real tablePhic[:, :]=fill(
            0,
            0,
            2) "Table for phic(N_T,PR)";
      parameter Real tableEta[:, :]=fill(
            0,
            0,
            2) "Table for eta(N_T,PR)";
      parameter String fileName="NoName" "File where matrix is stored";
      parameter TableTypes Table
        "Selection of the way of definition of table matrix";

      Real N_T "Referred speed";
      Real N_T_design "Referred design speed";
      Real phic "Flow number";
      Modelica.Blocks.Tables.CombiTable2D Phic(
        tableOnFile=if (Table == TableTypes.matrix) then false else true,
        table=tablePhic,
        tableName=if (Table == TableTypes.matrix) then "NoName" else "tabPhic",
        fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
        annotation (Placement(transformation(extent={{-10,10},{10,30}}, rotation=
                0)));
      Modelica.Blocks.Tables.CombiTable2D Eta(
        tableOnFile=if (Table == TableTypes.matrix) then false else true,
        table=tableEta,
        tableName=if (Table == TableTypes.matrix) then "NoName" else "tabEta",
        fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
        annotation (Placement(transformation(extent={{-10,50},{10,70}}, rotation=
                0)));
    equation
      N_T_design = Ndesign/sqrt(Tdes_in) "Referred design velocity";
      N_T = 100*omega/(sqrt(gas_in.T)*N_T_design)
        "Referred speed definition as percentage of design velocity";
      phic = w*sqrt(gas_in.T)/(gas_in.p) "Flow number definition";

      // phic = Phic(PR, N_T)
      Phic.u1 = PR;
      Phic.u2 = N_T;
      phic = (Phic.y);

      // eta = Eta(PR, N_T)
      Eta.u1 = PR;
      Eta.u2 = N_T;
      eta = Eta.y;
      annotation (Documentation(info="<html>
This model adds the performance characteristics to the Turbine_Base model, by means of 2D interpolation tables.
<p>The performance characteristics are described by two characteristic equations: the first relates the flow number <tt>phic</tt>, the pressure ratio <tt>PR</tt> and the referred speed <tt>N_T</tt>; the second relates the efficiency <tt>eta</tt>, the flow number <tt>phic</tt>, and the referred speed <tt>N_T</tt> [1]. </p>
<p>The performance maps are tabulated into two differents tables, <tt>tablePhic</tt> and <tt>tableEta</tt> which express <tt>phic</tt> and <tt>eta</tt> as a function of <tt>N_T</tt> and <tt>PR</tt> respectively, where <tt>N_T</tt> represents the first row and <tt>PR</tt> the first column [2]. The referred speed <tt>N_T</tt> is defined as a percentage of the design referred speed.
<p>The <tt>Modelica.Blocks.Tables.CombiTable2D</tt> interpolates the tables to obtain values of referred flow and efficiency at given levels of referred speed.
<p><b>Modelling options</b></p>
<p>The following options are available to determine how the table is defined:
<ul><li><tt>Table = 0</tt>: the table is explicitly supplied as matrix parameter.
<li><tt>Table = 1</tt>: the table is read from a file; the string <tt>fileName</tt> contains the path to the files where tables are stored, either in ASCII or Matlab binary format.
</ul>
<p><b>References:</b></p>
<ol>
<li>S. L. Dixon: <i>Fluid mechanics, thermodynamics of turbomachinery</i>, Oxford, Pergamon press, 1966, pp. 213.
<li>P. P. Walsh, P. Fletcher: <i>Gas Turbine Performance</i>, 2nd ed., Oxford, Blackwell, 2004, pp. 646.
</ol>
</html>",   revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       New method for calculating performance parameters using tables.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Turbine model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),   Diagram(graphics));
    end Turbine;
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

  package Media "Medium models for the ThermoPower library"
    extends Modelica.Icons.Package;

    package Air "Air as mixture of O2, N2, Ar and H2O"
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
        mediumName="Air",
        data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
              Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
              Modelica.Media.IdealGases.Common.SingleGasesData.Ar,
              Modelica.Media.IdealGases.Common.SingleGasesData.N2},
        fluidConstants={
              Modelica.Media.IdealGases.Common.FluidData.O2,
              Modelica.Media.IdealGases.Common.FluidData.H2O,
              Modelica.Media.IdealGases.Common.FluidData.Ar,
              Modelica.Media.IdealGases.Common.FluidData.N2},
        substanceNames={"Oxygen","Water","Argon","Nitrogen"},
        reference_X={0.23,0.015,0.005,0.75});
    end Air;

    package NaturalGas "Mixture of N2, CO2, and CH4"
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
        mediumName="NaturalGas",
        data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,
              Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
              Modelica.Media.IdealGases.Common.SingleGasesData.CH4},
        fluidConstants={
              Modelica.Media.IdealGases.Common.FluidData.N2,
              Modelica.Media.IdealGases.Common.FluidData.CO2,
              Modelica.Media.IdealGases.Common.FluidData.CH4},
        substanceNames={"Nitrogen","Carbondioxide","Methane"},
        reference_X={0.02,0.012,0.968});

    end NaturalGas;

    package FlueGas "flue gas"
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
        mediumName="FlueGas",
        data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
              Modelica.Media.IdealGases.Common.SingleGasesData.Ar,
              Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
              Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
              Modelica.Media.IdealGases.Common.SingleGasesData.N2},
        fluidConstants={
              Modelica.Media.IdealGases.Common.FluidData.O2,
              Modelica.Media.IdealGases.Common.FluidData.Ar,
              Modelica.Media.IdealGases.Common.FluidData.H2O,
              Modelica.Media.IdealGases.Common.FluidData.CO2,
              Modelica.Media.IdealGases.Common.FluidData.N2},
        substanceNames={"Oxygen","Argon","Water","Carbondioxide","Nitrogen"},
        reference_X={0.23,0.02,0.01,0.04,0.7});

    end FlueGas;
  end Media;

  package PowerPlants "Models of thermoelectrical power plants components"
    extends Modelica.Icons.Package;
    import SI = Modelica.SIunits;
    import ThermoPower.Choices.Init.Options;

    package HRSG "Models and tests of the HRSG and its main components"
      extends Modelica.Icons.Package;

      package Components "HRSG component models"
        extends Modelica.Icons.Package;

        model BaseReader_gas
          "Base reader for the visualization of the state in the simulation (gas)"
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          parameter Boolean allowFlowReversal=system.allowFlowReversal
            "= true to allow flow reversal, false restricts to design direction";
          outer ThermoPower.System system "System wide properties";
          Gas.FlangeA inlet(redeclare package Medium = Medium, m_flow(min=if
                  allowFlowReversal then -Modelica.Constants.inf else 0))
            annotation (Placement(transformation(extent={{-80,-20},{-40,20}},
                  rotation=0)));
          Gas.FlangeB outlet(redeclare package Medium = Medium, m_flow(max=if
                  allowFlowReversal then +Modelica.Constants.inf else 0))
            annotation (Placement(transformation(extent={{40,-20},{80,20}},
                  rotation=0)));
        equation
          inlet.m_flow + outlet.m_flow = 0 "Mass balance";
          inlet.p = outlet.p "Momentum balance";
          // Energy balance
          inlet.h_outflow = inStream(outlet.h_outflow);
          inStream(inlet.h_outflow) = outlet.h_outflow;
          // Independent composition mass balances
          inlet.Xi_outflow = inStream(outlet.Xi_outflow);
          inStream(inlet.Xi_outflow) = outlet.Xi_outflow;
          annotation (Diagram(graphics), Icon(graphics={Polygon(
                        points={{-80,0},{0,30},{80,0},{0,-30},{-80,0}},
                        lineColor={170,170,255},
                        fillColor={170,170,255},
                        fillPattern=FillPattern.Solid),Text(
                        extent={{-80,20},{80,-20}},
                        lineColor={255,255,255},
                        fillColor={170,170,255},
                        fillPattern=FillPattern.Solid,
                        textString="S")}));
        end BaseReader_gas;

        model StateReader_gas
          "State reader for the visualization of the state in the simulation (gas)"
          extends BaseReader_gas;
          Medium.BaseProperties gas;
          SI.Temperature T "Temperature";
          SI.Pressure p "Pressure";
          SI.SpecificEnthalpy h "Specific enthalpy";
          SI.MassFlowRate w "Mass flow rate";

        equation
          // Set gas properties
          inlet.p = gas.p;

          gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow)
             else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
          gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow)
             else actualStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));

          T = gas.T;
          p = gas.p;
          h = gas.h;
          w = inlet.m_flow;
        end StateReader_gas;
      end Components;
      annotation (Documentation(revisions="<html>
<ul>
<li><i>15 Apr 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>"));
    end HRSG;
    annotation (Documentation(revisions="<html>
</html>"));
  end PowerPlants;

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

package ThermoPower_Examples_BraytonCycle
 extends ThermoPower.Examples.BraytonCycle;
  annotation(experiment(
    StopTime=1,
    __Dymola_NumberOfIntervals=500,
    Tolerance=0.0001,
    __Dymola_Algorithm="dassl"),uses(ThermoPower(version="3.1")));
end ThermoPower_Examples_BraytonCycle;
