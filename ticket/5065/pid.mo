package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
    annotation(Documentation(info = "<html>
  <p>
  Package in which processor specific constants are defined that are needed
  by numerical algorithms. Typically these constants are not directly used,
  but indirectly via the alias definition in
  <a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
  </p>
  </html>")); 
  end Machine;
  annotation(Protection(access = Access.hide), preferredView = "info", version = "3.2.2", versionBuild = 0, versionDate = "2016-01-15", dateModified = "2016-01-15 08:44:41Z", revisionId = "$Id::                                       $", uses(Modelica(version = "3.2.2")), conversion(noneFromVersion = "1.0", noneFromVersion = "1.1", noneFromVersion = "1.2", noneFromVersion = "3.2.1"), Documentation(info = "<html>
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
This is the default implementation, if no tool-specific implementation is available.
This ModelicaServices package provides only \"dummy\" models that do nothing.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 2009-2016, DLR and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>")); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Package;

    package Continuous  "Library of continuous control blocks with internal states" 
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Package;

      block Integrator  "Output the integral of the input signal" 
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit = "1") = 1 "Integrator gain";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.InitialState "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation(Evaluate = true, Dialog(group = "Initialization"));
        parameter Real y_start = 0 "Initial or guess value of output (= state)" annotation(Dialog(group = "Initialization"));
        extends Interfaces.SISO(y(start = y_start));
      initial equation
        if initType == Init.SteadyState then
          der(y) = 0;
        elseif initType == Init.InitialState or initType == Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = k * u;
        annotation(Documentation(info = "<html>
      <p>
      This blocks computes output <b>y</b> (element-wise) as
      <i>integral</i> of the input <b>u</b> multiplied with
      the gain <i>k</i>:
      </p>
      <pre>
               k
           y = - u
               s
      </pre>

      <p>
      It might be difficult to initialize the integrator in steady state.
      This is discussed in the description of package
      <a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
      </p>

      </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), Text(lineColor = {192, 192, 192}, extent = {{0.0, -70.0}, {60.0, -10.0}}, textString = "I"), Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, textString = "k=%k"), Line(points = {{-80.0, -80.0}, {80.0, 80.0}}, color = {0, 0, 127})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}, lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}), Text(extent = {{-36, 60}, {32, 2}}, lineColor = {0, 0, 0}, textString = "k"), Text(extent = {{-32, 0}, {36, -58}}, lineColor = {0, 0, 0}, textString = "s"), Line(points = {{-46, 0}, {46, 0}})})); 
      end Integrator;

      block Derivative  "Approximated derivative block" 
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit = "1") = 1 "Gains";
        parameter SIunits.Time T(min = Modelica.Constants.small) = 0.01 "Time constants (T>0 required; T=0 is ideal derivative block)";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true, Dialog(group = "Initialization"));
        parameter Real x_start = 0 "Initial or guess value of state" annotation(Dialog(group = "Initialization"));
        parameter Real y_start = 0 "Initial value of output (= state)" annotation(Dialog(enable = initType == Init.InitialOutput, group = "Initialization"));
        extends Interfaces.SISO;
        output Real x(start = x_start) "State of block";
      protected
        parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
      initial equation
        if initType == Init.SteadyState then
          der(x) = 0;
        elseif initType == Init.InitialState then
          x = x_start;
        elseif initType == Init.InitialOutput then
          if zeroGain then
            x = u;
          else
            y = y_start;
          end if;
        end if;
      equation
        der(x) = if zeroGain then 0 else (u - x) / T;
        y = if zeroGain then 0 else k / T * (u - x);
        annotation(Documentation(info = "<html>
      <p>
      This blocks defines the transfer function between the
      input u and the output y
      (element-wise) as <i>approximated derivative</i>:
      </p>
      <pre>
                   k * s
           y = ------------ * u
                  T * s + 1
      </pre>
      <p>
      If you would like to be able to change easily between different
      transfer functions (FirstOrder, SecondOrder, ... ) by changing
      parameters, use the general block <b>TransferFunction</b> instead
      and model a derivative block with parameters<br>
      b = {k,0}, a = {T, 1}.
      </p>

      <p>
      If k=0, the block reduces to y=0.
      </p>
      </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), Line(origin = {-24.667, -27.333}, points = {{-55.333, 87.333}, {-19.333, -40.667}, {86.667, -52.667}}, color = {0, 0, 127}, smooth = Smooth.Bezier), Text(lineColor = {192, 192, 192}, extent = {{-30.0, 14.0}, {86.0, 60.0}}, textString = "DT1"), Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, textString = "k=%k")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-54, 52}, {50, 10}}, lineColor = {0, 0, 0}, textString = "k s"), Text(extent = {{-54, -6}, {52, -52}}, lineColor = {0, 0, 0}, textString = "T s + 1"), Line(points = {{-50, 0}, {50, 0}}), Rectangle(extent = {{-60, 60}, {60, -60}}, lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255})})); 
      end Derivative;

      block PID  "PID-controller in additive description form" 
        import Modelica.Blocks.Types.InitPID;
        import Modelica.Blocks.Types.Init;
        extends Interfaces.SISO;
        parameter Real k(unit = "1") = 1 "Gain";
        parameter SIunits.Time Ti(min = Modelica.Constants.small, start = 0.5) "Time Constant of Integrator";
        parameter SIunits.Time Td(min = 0, start = 0.1) "Time Constant of Derivative block";
        parameter Real Nd(min = Modelica.Constants.small) = 10 "The higher Nd, the more ideal the derivative block";
        parameter Modelica.Blocks.Types.InitPID initType = Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true, Dialog(group = "Initialization"));
        parameter Real xi_start = 0 "Initial or guess value value for integrator output (= integrator state)" annotation(Dialog(group = "Initialization"));
        parameter Real xd_start = 0 "Initial or guess value for state of derivative block" annotation(Dialog(group = "Initialization"));
        parameter Real y_start = 0 "Initial value of output" annotation(Dialog(enable = initType == InitPID.InitialOutput, group = "Initialization"));
        constant SI.Time unitTime = 1 annotation(HideResult = true);
        Blocks.Math.Gain P(k = 1) "Proportional part of PID controller" annotation(Placement(transformation(extent = {{-60, 60}, {-20, 100}})));
        Blocks.Continuous.Integrator I(k = unitTime / Ti, y_start = xi_start, initType = if initType == InitPID.SteadyState then Init.SteadyState else if initType == InitPID.InitialState or initType == InitPID.DoNotUse_InitialIntegratorState then Init.InitialState else Init.NoInit) "Integral part of PID controller" annotation(Placement(transformation(extent = {{-60, -20}, {-20, 20}})));
        Blocks.Continuous.Derivative D(k = Td / unitTime, T = max([Td / Nd, 100 * Modelica.Constants.eps]), x_start = xd_start, initType = if initType == InitPID.SteadyState or initType == InitPID.InitialOutput then Init.SteadyState else if initType == InitPID.InitialState then Init.InitialState else Init.NoInit) "Derivative part of PID controller" annotation(Placement(transformation(extent = {{-60, -100}, {-20, -60}})));
        Blocks.Math.Gain Gain(k = k) "Gain of PID controller" annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
        Blocks.Math.Add3 Add annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));
      initial equation
        if initType == InitPID.InitialOutput then
          y = y_start;
        end if;
      equation
        connect(u, P.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, 80}, {-64, 80}}, color = {0, 0, 127}));
        connect(u, I.u) annotation(Line(points = {{-120, 0}, {-64, 0}}, color = {0, 0, 127}));
        connect(u, D.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, -80}, {-64, -80}}, color = {0, 0, 127}));
        connect(P.y, Add.u1) annotation(Line(points = {{-18, 80}, {0, 80}, {0, 8}, {18, 8}}, color = {0, 0, 127}));
        connect(I.y, Add.u2) annotation(Line(points = {{-18, 0}, {18, 0}}, color = {0, 0, 127}));
        connect(D.y, Add.u3) annotation(Line(points = {{-18, -80}, {0, -80}, {0, -8}, {18, -8}}, color = {0, 0, 127}));
        connect(Add.y, Gain.u) annotation(Line(points = {{41, 0}, {58, 0}}, color = {0, 0, 127}));
        connect(Gain.y, y) annotation(Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
        annotation(defaultComponentName = "PID", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), Line(points = {{-80, -80}, {-80, -20}, {60, 80}}, color = {0, 0, 127}), Text(lineColor = {192, 192, 192}, extent = {{-20.0, -60.0}, {80.0, -20.0}}, textString = "PID"), Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, textString = "Ti=%Ti")}), Documentation(info = "<html>
      <p>
      This is the text-book version of a PID-controller.
      For a more practically useful PID-controller, use
      block LimPID.
      </p>

      <p>
      The PID block can be initialized in different
      ways controlled by parameter <b>initType</b>. The possible
      values of initType are defined in
      <a href=\"modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>.
      This type is identical to
      <a href=\"modelica://Modelica.Blocks.Types.Init\">Types.Init</a>,
      with the only exception that the additional option
      <b>DoNotUse_InitialIntegratorState</b> is added for
      backward compatibility reasons (= integrator is initialized with
      InitialState whereas differential part is initialized with
      NoInit which was the initialization in version 2.2 of the Modelica
      standard library).
      </p>

      <p>
      Based on the setting of initType, the integrator (I) and derivative (D)
      blocks inside the PID controller are initialized according to the following table:
      </p>

      <table border=1 cellspacing=0 cellpadding=2>
        <tr><td valign=\"top\"><b>initType</b></td>
            <td valign=\"top\"><b>I.initType</b></td>
            <td valign=\"top\"><b>D.initType</b></td></tr>

        <tr><td valign=\"top\"><b>NoInit</b></td>
            <td valign=\"top\">NoInit</td>
            <td valign=\"top\">NoInit</td></tr>

        <tr><td valign=\"top\"><b>SteadyState</b></td>
            <td valign=\"top\">SteadyState</td>
            <td valign=\"top\">SteadyState</td></tr>

        <tr><td valign=\"top\"><b>InitialState</b></td>
            <td valign=\"top\">InitialState</td>
            <td valign=\"top\">InitialState</td></tr>

        <tr><td valign=\"top\"><b>InitialOutput</b><br>
                and initial equation: y = y_start</td>
            <td valign=\"top\">NoInit</td>
            <td valign=\"top\">SteadyState</td></tr>

        <tr><td valign=\"top\"><b>DoNotUse_InitialIntegratorState</b></td>
            <td valign=\"top\">InitialState</td>
            <td valign=\"top\">NoInit</td></tr>
      </table>

      <p>
      In many cases, the most useful initial condition is
      <b>SteadyState</b> because initial transients are then no longer
      present. If initType = InitPID.SteadyState, then in some
      cases difficulties might occur. The reason is the
      equation of the integrator:
      </p>

      <pre>
         <b>der</b>(y) = k*u;
      </pre>

      <p>
      The steady state equation \"der(x)=0\" leads to the condition that the input u to the
      integrator is zero. If the input u is already (directly or indirectly) defined
      by another initial condition, then the initialization problem is <b>singular</b>
      (has none or infinitely many solutions). This situation occurs often
      for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
      since speed is both a state and a derivative, it is natural to
      initialize it with zero. As sketched this is, however, not possible.
      The solution is to not initialize u or the variable that is used
      to compute u by an algebraic equation.
      </p>

      </html>")); 
      end PID;
      annotation(Documentation(info = "<html>
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

    </html>"), Icon(graphics = {Line(origin = {0.061, 4.184}, points = {{81.939, 36.056}, {65.362, 36.056}, {14.39, -26.199}, {-29.966, 113.485}, {-65.374, -61.217}, {-78.061, -78.184}}, color = {95, 95, 95}, smooth = Smooth.Bezier)})); 
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      import Modelica.SIunits;
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}, coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{0.0, 50.0}, {100.0, 0.0}, {0.0, -50.0}, {0.0, 50.0}}), Text(lineColor = {0, 0, 127}, extent = {{-10.0, 60.0}, {-10.0, 85.0}}, textString = "%name")}), Documentation(info = "<html>
      <p>
      Connector with one input signal of type Real.
      </p>
      </html>"));
      connector RealOutput = output Real "'output Real' as connector" annotation(defaultComponentName = "y", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}}), Text(lineColor = {0, 0, 127}, extent = {{30.0, 60.0}, {30.0, 110.0}}, textString = "%name")}), Documentation(info = "<html>
      <p>
      Connector with one output signal of type Real.
      </p>
      </html>"));

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
        annotation(Documentation(info = "<html>
      <p>
      Block has one continuous Real input and one continuous Real output signal.
      </p>
      </html>")); 
      end SISO;
      annotation(Documentation(info = "<html>
    <p>
    This package contains interface definitions for
    <b>continuous</b> input/output blocks with Real,
    Integer and Boolean signals. Furthermore, it contains
    partial models for continuous and discrete blocks.
    </p>

    </html>", revisions = "<html>
    <ul>
    <li><i>Oct. 21, 2002</i>
           by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
           and Christian Schweiger:<br>
           Added several new interfaces.</li>
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

    package Math  "Library of Real mathematical functions as input/output blocks" 
      import Modelica.SIunits;
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Gain  "Output the product of a gain value with the input signal" 
        parameter Real k(start = 1, unit = "1") "Gain value multiplied with input signal";
        Interfaces.RealInput u "Input signal connector" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        Interfaces.RealOutput y "Output signal connector" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
      equation
        y = k * u;
        annotation(Documentation(info = "<html>
      <p>
      This block computes output <i>y</i> as
      <i>product</i> of gain <i>k</i> with the
      input <i>u</i>:
      </p>
      <pre>
          y = k * u;
      </pre>

      </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-100, -100}, {-100, 100}, {100, 0}, {-100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-150, -140}, {150, -100}}, lineColor = {0, 0, 0}, textString = "k=%k"), Text(extent = {{-150, 140}, {150, 100}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-100, -100}, {-100, 100}, {100, 0}, {-100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-76, 38}, {0, -34}}, textString = "k", lineColor = {0, 0, 255})})); 
      end Gain;

      block Add3  "Output the sum of the three inputs" 
        extends Modelica.Blocks.Icons.Block;
        parameter Real k1 = +1 "Gain of upper input";
        parameter Real k2 = +1 "Gain of middle input";
        parameter Real k3 = +1 "Gain of lower input";
        Interfaces.RealInput u1 "Connector 1 of Real input signals" annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
        Interfaces.RealInput u2 "Connector 2 of Real input signals" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        Interfaces.RealInput u3 "Connector 3 of Real input signals" annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
        Interfaces.RealOutput y "Connector of Real output signals" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
      equation
        y = k1 * u1 + k2 * u2 + k3 * u3;
        annotation(Documentation(info = "<html>
      <p>
      This blocks computes output <b>y</b> as <i>sum</i> of the
      three input signals <b>u1</b>, <b>u2</b> and <b>u3</b>:
      </p>
      <pre>
          <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b> + k3*<b>u3</b>;
      </pre>
      <p>
      Example:
      </p>
      <pre>
           parameter:   k1= +2, k2= -3, k3=1;

        results in the following equations:

           y = 2 * u1 - 3 * u2 + u3;
      </pre>

      </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-100, 50}, {5, 90}}, lineColor = {0, 0, 0}, textString = "%k1"), Text(extent = {{-100, -20}, {5, 20}}, lineColor = {0, 0, 0}, textString = "%k2"), Text(extent = {{-100, -50}, {5, -90}}, lineColor = {0, 0, 0}, textString = "%k3"), Text(extent = {{2, 36}, {100, -44}}, lineColor = {0, 0, 0}, textString = "+")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-100, 50}, {5, 90}}, lineColor = {0, 0, 0}, textString = "k1"), Text(extent = {{-100, -20}, {5, 20}}, lineColor = {0, 0, 0}, textString = "k2"), Text(extent = {{-100, -50}, {5, -90}}, lineColor = {0, 0, 0}, textString = "k3"), Text(extent = {{2, 46}, {100, -34}}, lineColor = {0, 0, 0}, textString = "+")})); 
      end Add3;
      annotation(Documentation(info = "<html>
    <p>
    This package contains basic <b>mathematical operations</b>,
    such as summation and multiplication, and basic <b>mathematical
    functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
    input/output blocks. All blocks of this library can be either
    connected with continuous blocks or with sampled-data blocks.
    </p>
    </html>", revisions = "<html>
    <ul>
    <li><i>October 21, 2002</i>
           by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
           and Christian Schweiger:<br>
           New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
    <li><i>August 7, 1999</i>
           by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
           Realized (partly based on an existing Dymola library
           of Dieter Moormann and Hilding Elmqvist).
    </li>
    </ul>
    </html>"), Icon(graphics = {Line(points = {{-80, -2}, {-68.7, 32.2}, {-61.5, 51.1}, {-55.1, 64.4}, {-49.4, 72.6}, {-43.8, 77.1}, {-38.2, 77.8}, {-32.6, 74.6}, {-26.9, 67.7}, {-21.3, 57.4}, {-14.9, 42.1}, {-6.83, 19.2}, {10.1, -32.8}, {17.3, -52.2}, {23.7, -66.2}, {29.3, -75.1}, {35, -80.4}, {40.6, -82}, {46.2, -79.6}, {51.9, -73.5}, {57.5, -63.9}, {63.9, -49.2}, {72, -26.8}, {80, -2}}, color = {95, 95, 95}, smooth = Smooth.Bezier)})); 
    end Math;

    package Types  "Library of constants and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true, Documentation(info = "<html>
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
      type InitPID = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)", DoNotUse_InitialIntegratorState "Do not use, only for backward compatibility (initialize only integrator state)") "Enumeration defining initialization of PID and LimPID blocks" annotation(Evaluate = true, Documentation(info = "<html>
      <p>
      This initialization type is identical to <a href=\"modelica://Modelica.Blocks.Types.Init\">Types.Init</a> and has just one
      additional option <strong><code>DoNotUse_InitialIntegratorState</code></strong>. This option
      is introduced in order that the default initialization for the
      <code>Continuous.PID</code> and <code>Continuous.LimPID</code> blocks are backward
      compatible. In Modelica 2.2, the integrators have been initialized
      with their given states where as the D-part has not been initialized.
      The option <strong><code>DoNotUse_InitialIntegratorState</code></strong> leads to this
      initialization definition.
      </p>

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
          <dt><code><strong>DoNotUse_InitialIntegratorState</strong></code></dt>
            <dd>Do not use, only for backward compatibility (initialize only integrator state)</dd>
        </dl>
      </html>"));
      annotation(Documentation(info = "<html>
    <p>
    In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
    in library Modelica.Blocks. The types have additional annotation choices
    definitions that define the menus to be built up in the graphical
    user interface when the type is used as parameter in a declaration.
    </p>
    </html>")); 
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Documentation(info = "<html>
      <p>
      Block that has only the basic icon for an input/output
      block (no declarations, no equations). Most blocks
      of package Modelica.Blocks inherit directly or indirectly
      from this block.
      </p>
      </html>")); end Block;
    end Icons;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}), Documentation(info = "<html>
  <p>
  This library contains input/output blocks to build up block diagrams.
  </p>

  <dl>
  <dt><b>Main Author:</b></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
      Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
      Oberpfaffenhofen<br>
      Postfach 1116<br>
      D-82230 Wessling<br>
      email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
  </dl>
  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
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
         and Christian Schweiger:<br>
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

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), Polygon(points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(graphics = {Line(points = {{0, 80}, {-8, 80}}, color = {95, 95, 95}), Line(points = {{0, -80}, {-8, -80}}, color = {95, 95, 95}), Line(points = {{0, -90}, {0, 84}}, color = {95, 95, 95}), Text(extent = {{5, 104}, {25, 84}}, lineColor = {95, 95, 95}, textString = "y"), Polygon(points = {{0, 98}, {-6, 82}, {6, 82}, {0, 98}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
      <p>
      Icon for a mathematical function, consisting of an y-axis in the middle.
      It is expected, that an x-axis is added and a plot of the function.
      </p>
      </html>")); end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output SI.Angle y;
      external "builtin" y = asin(u) annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}), Text(extent = {{-88, 78}, {-16, 30}}, lineColor = {192, 192, 192}, textString = "asin")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-40, -72}, {-15, -88}}, textString = "-pi/2", lineColor = {0, 0, 255}), Text(extent = {{-38, 88}, {-13, 72}}, textString = " pi/2", lineColor = {0, 0, 255}), Text(extent = {{68, -9}, {88, -29}}, textString = "+1", lineColor = {0, 0, 255}), Text(extent = {{-90, 21}, {-70, 1}}, textString = "-1", lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{98, 0}, {82, 6}, {82, -6}, {98, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{82, 24}, {102, 4}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {86, 80}}, color = {175, 175, 175}), Line(points = {{80, 86}, {80, -10}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = asin(u), with -1 &le; u &le; +1:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
    </p>
    </html>"));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}), Text(extent = {{-88, 78}, {-16, 30}}, lineColor = {192, 192, 192}, textString = "asin")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-40, -72}, {-15, -88}}, textString = "-pi/2", lineColor = {0, 0, 255}), Text(extent = {{-38, 88}, {-13, 72}}, textString = " pi/2", lineColor = {0, 0, 255}), Text(extent = {{68, -9}, {88, -29}}, textString = "+1", lineColor = {0, 0, 255}), Text(extent = {{-90, 21}, {-70, 1}}, textString = "-1", lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{98, 0}, {82, 6}, {82, -6}, {98, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{82, 24}, {102, 4}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {86, 80}}, color = {175, 175, 175}), Line(points = {{80, 86}, {80, -10}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = asin(u), with -1 &le; u &le; +1:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
    </p>
    </html>")); 
    end asin;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u) annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, -80.3976}, {68, -80.3976}}, color = {192, 192, 192}), Polygon(points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}), Text(extent = {{-86, 50}, {-14, 2}}, lineColor = {192, 192, 192}, textString = "exp")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, -80.3976}, {84, -80.3976}}, color = {95, 95, 95}), Polygon(points = {{98, -80.3976}, {82, -74.3976}, {82, -86.3976}, {98, -80.3976}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-31, 72}, {-11, 88}}, textString = "20", lineColor = {0, 0, 255}), Text(extent = {{-92, -81}, {-72, -101}}, textString = "-3", lineColor = {0, 0, 255}), Text(extent = {{66, -81}, {86, -101}}, textString = "3", lineColor = {0, 0, 255}), Text(extent = {{2, -69}, {22, -89}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{78, -54}, {98, -74}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {88, 80}}, color = {175, 175, 175}), Line(points = {{80, 84}, {80, -84}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
    </p>
    </html>"));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, -80.3976}, {68, -80.3976}}, color = {192, 192, 192}), Polygon(points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}), Text(extent = {{-86, 50}, {-14, 2}}, lineColor = {192, 192, 192}, textString = "exp")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, -80.3976}, {84, -80.3976}}, color = {95, 95, 95}), Polygon(points = {{98, -80.3976}, {82, -74.3976}, {82, -86.3976}, {98, -80.3976}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-31, 72}, {-11, 88}}, textString = "20", lineColor = {0, 0, 255}), Text(extent = {{-92, -81}, {-72, -101}}, textString = "-3", lineColor = {0, 0, 255}), Text(extent = {{66, -81}, {86, -101}}, textString = "3", lineColor = {0, 0, 255}), Text(extent = {{2, -69}, {22, -89}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{78, -54}, {98, -74}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {88, 80}}, color = {175, 175, 175}), Line(points = {{80, 84}, {80, -84}}, color = {175, 175, 175})}), Documentation(info = "<html>
    <p>
    This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
    </p>

    <p>
    <img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
    </p>
    </html>")); 
    end exp;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.4}, {-49.4, 74.6}, {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {-26.9, 69.7}, {-21.3, 59.4}, {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, -64.2}, {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, {51.9, -71.5}, {57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, color = {0, 0, 0}, smooth = Smooth.Bezier)}), Documentation(info = "<html>
  <p>
  This package contains <b>basic mathematical functions</b> (such as sin(..)),
  as well as functions operating on
  <a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
  <a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
  <a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
  <a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
  </p>

  <dl>
  <dt><b>Main Authors:</b></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
      Marcus Baur<br>
      Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
      Institut f&uuml;r Robotik und Mechatronik<br>
      Postfach 1116<br>
      D-82230 Wessling<br>
      Germany<br>
      email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
  </dl>

  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
  <ul>
  <li><i>October 21, 2002</i>
         by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
         and Christian Schweiger:<br>
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

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Modelica.Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant SI.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7 "Magnetic constant";
    annotation(Documentation(info = "<html>
  <p>
  This package provides often needed constants from mathematics, machine
  dependent constants and constants from nature. The latter constants
  (name, value, description) are from the following source:
  </p>

  <dl>
  <dt>Peter J. Mohr, David B. Newell, and Barry N. Taylor:</dt>
  <dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 2014</b>.
  <a href= \"http://dx.doi.org/10.5281/zenodo.22826\">http://dx.doi.org/10.5281/zenodo.22826</a>, 2015. See also <a href=
  \"http://physics.nist.gov/cuu/Constants/index.html\">http://physics.nist.gov/cuu/Constants/index.html</a></dd>
  </dl>

  <p>CODATA is the Committee on Data for Science and Technology.</p>

  <dl>
  <dt><b>Main Author:</b></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
      Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
      Oberpfaffenhofen<br>
      Postfach 1116<br>
      D-82230 We&szlig;ling<br>
      email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
  </dl>

  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
  <ul>
  <li><i>Nov 4, 2015</i>
         by Thomas Beutlich:<br>
         Constants updated according to 2014 CODATA values.</li>
  <li><i>Nov 8, 2004</i>
         by Christian Schweiger:<br>
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
  </html>"), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-9.2597, 25.6673}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{48.017, 11.336}, {48.017, 11.336}, {10.766, 11.336}, {-25.684, 10.95}, {-34.944, -15.111}, {-34.944, -15.111}, {-32.298, -15.244}, {-32.298, -15.244}, {-22.112, 0.168}, {11.292, 0.234}, {48.267, -0.097}, {48.267, -0.097}}, smooth = Smooth.Bezier), Polygon(origin = {-19.9923, -8.3993}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{3.239, 37.343}, {3.305, 37.343}, {-0.399, 2.683}, {-16.936, -20.071}, {-7.808, -28.604}, {6.811, -22.519}, {9.986, 37.145}, {9.986, 37.145}}, smooth = Smooth.Bezier), Polygon(origin = {23.753, -11.5422}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.873, 41.478}, {-10.873, 41.478}, {-14.048, -4.162}, {-9.352, -24.8}, {7.912, -24.469}, {16.247, 0.27}, {16.247, 0.27}, {13.336, 0.071}, {13.336, 0.071}, {7.515, -9.983}, {-3.134, -7.271}, {-2.671, 41.214}, {-2.671, 41.214}}, smooth = Smooth.Bezier)})); 
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
    <p>Standard package icon.</p>
    </html>")); end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {20.0, 0.0}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-10.0, 70.0}, {10.0, 70.0}, {40.0, 20.0}, {80.0, 20.0}, {80.0, -20.0}, {40.0, -20.0}, {10.0, -70.0}, {-10.0, -70.0}}), Polygon(fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-100.0, 20.0}, {-60.0, 20.0}, {-30.0, 70.0}, {-10.0, 70.0}, {-10.0, -70.0}, {-30.0, -70.0}, {-60.0, -20.0}, {-100.0, -20.0}})}), Documentation(info = "<html>
    <p>This icon indicates packages containing interfaces.</p>
    </html>")); 
    end InterfacesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-12.167, -23}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{12.167, 65}, {14.167, 93}, {36.167, 89}, {24.167, 20}, {4.167, -30}, {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, -30}, {4.167, 20}, {12.167, 65}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Polygon(origin = {2.7403, 1.6673}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{49.2597, 22.3327}, {31.2597, 24.3327}, {7.2597, 18.3327}, {-26.7403, 10.3327}, {-46.7403, 14.3327}, {-48.7403, 6.3327}, {-32.7403, 0.3327}, {-6.7403, 4.3327}, {33.2597, 14.3327}, {49.2597, 14.3327}, {49.2597, 22.3327}}, smooth = Smooth.Bezier)})); 
    end TypesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})})); 
    end IconsPackage;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})}), Documentation(info = "<html>
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

      <dd>  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  </dd>
      <dd>1060 Vienna, Austria</dd>
      <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
  <dt>Johan Andreasson</dt>
      <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
      <dd>Ideon Science Park</dd>
      <dd>22370 Lund, Sweden</dd>
      <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
  </dl>

  <p>Copyright &copy; 1998-2016, Modelica Association, DLR, AIT, and Modelon AB. </p>
  <p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
  </html>")); 
  end Icons;

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units" 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
        annotation(Documentation(info = "<html>
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
      </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {15.0, 51.8518}, extent = {{-105.0, -86.8518}, {75.0, -16.8518}}, lineColor = {0, 0, 0}, textString = "[km/h]")})); 
      end NonSIunits;
      annotation(Documentation(info = "<html>
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

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Time = Real(final quantity = "Time", final unit = "s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-80, -40}, {-80, -40}, {-55, 50}, {-52.5, 62.5}, {-65, 60}, {-65, 65}, {-35, 77.5}, {-32.5, 60}, {-50, 0}, {-50, 0}, {-30, 15}, {-20, 27.5}, {-32.5, 27.5}, {-32.5, 27.5}, {-32.5, 32.5}, {-32.5, 32.5}, {2.5, 32.5}, {2.5, 32.5}, {2.5, 27.5}, {2.5, 27.5}, {-7.5, 27.5}, {-30, 7.5}, {-30, 7.5}, {-25, -25}, {-17.5, -28.75}, {-10, -25}, {-5, -26.25}, {-5, -32.5}, {-16.25, -41.25}, {-31.25, -43.75}, {-40, -33.75}, {-45, -5}, {-45, -5}, {-52.5, -10}, {-52.5, -10}, {-60, -40}, {-60, -40}}, smooth = Smooth.Bezier), Polygon(fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{87.5, 30}, {62.5, 30}, {62.5, 30}, {55, 33.75}, {36.25, 35}, {16.25, 25}, {7.5, 6.25}, {11.25, -7.5}, {22.5, -12.5}, {22.5, -12.5}, {6.25, -22.5}, {6.25, -35}, {16.25, -38.75}, {16.25, -38.75}, {21.25, -41.25}, {21.25, -41.25}, {45, -48.75}, {47.5, -61.25}, {32.5, -70}, {12.5, -65}, {7.5, -51.25}, {21.25, -41.25}, {21.25, -41.25}, {16.25, -38.75}, {16.25, -38.75}, {6.25, -41.25}, {-6.25, -50}, {-3.75, -68.75}, {30, -76.25}, {65, -62.5}, {63.75, -35}, {27.5, -26.25}, {22.5, -20}, {27.5, -15}, {27.5, -15}, {30, -7.5}, {30, -7.5}, {27.5, -2.5}, {28.75, 11.25}, {36.25, 27.5}, {47.5, 30}, {53.75, 22.5}, {51.25, 8.75}, {45, -6.25}, {35, -11.25}, {30, -7.5}, {30, -7.5}, {27.5, -15}, {27.5, -15}, {43.75, -16.25}, {65, -6.25}, {72.5, 10}, {70, 20}, {70, 20}, {80, 20}}, smooth = Smooth.Bezier)}), Documentation(info = "<html>
  <p>This package provides predefined types, such as <i>Mass</i>,
  <i>Angle</i>, <i>Time</i>, based on the international standard
  on units, e.g.,
  </p>

  <pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                       <b>final</b> unit     = \"rad\",
                       displayUnit    = \"deg\");
  </pre>

  <p>
  Some of the types are derived SI units that are utilized in package Modelica
  (such as ComplexCurrent, which is a complex number where both the real and imaginary
  part have the SI unit Ampere).
  </p>

  <p>
  Furthermore, conversion functions from non SI-units to SI-units and vice versa
  are provided in subpackage
  <a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
  </p>

  <p>
  For an introduction how units are used in the Modelica standard library
  with package SIunits, have a look at:
  <a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
  </p>

  <p>
  Copyright &copy; 1998-2016, Modelica Association and DLR.
  </p>
  <p>
  <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
  </p>
  </html>", revisions = "<html>
  <ul>
  <li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
  <li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
  <li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
  <li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
  <li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
  <li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
  <li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
  <li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
  <li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
  <li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
  <li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br/>Some chapters realized.</li>
  </ul>
  </html>")); 
  end SIunits;
  annotation(preferredView = "info", version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z", revisionId = "$Id::                                       $", uses(Complex(version = "3.2.2"), ModelicaServices(version = "3.2.2")), conversion(noneFromVersion = "3.2.1", noneFromVersion = "3.2", noneFromVersion = "3.1", noneFromVersion = "3.0.1", noneFromVersion = "3.0", from(version = "2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-6.9888, 20.048}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-93.0112, 10.3188}, {-93.0112, 10.3188}, {-73.011, 24.6}, {-63.011, 31.221}, {-51.219, 36.777}, {-39.842, 38.629}, {-31.376, 36.248}, {-25.819, 29.369}, {-24.232, 22.49}, {-23.703, 17.463}, {-15.501, 25.135}, {-6.24, 32.015}, {3.02, 36.777}, {15.191, 39.423}, {27.097, 37.306}, {32.653, 29.633}, {35.035, 20.108}, {43.501, 28.046}, {54.085, 35.19}, {65.991, 39.952}, {77.897, 39.688}, {87.422, 33.338}, {91.126, 21.696}, {90.068, 9.525}, {86.099, -1.058}, {79.749, -10.054}, {71.283, -21.431}, {62.816, -33.337}, {60.964, -32.808}, {70.489, -16.14}, {77.368, -2.381}, {81.072, 10.054}, {79.749, 19.05}, {72.605, 24.342}, {61.758, 23.019}, {49.587, 14.817}, {39.003, 4.763}, {29.214, -6.085}, {21.012, -16.669}, {13.339, -26.458}, {5.401, -36.777}, {-1.213, -46.037}, {-6.24, -53.446}, {-8.092, -52.387}, {-0.684, -40.746}, {5.401, -30.692}, {12.81, -17.198}, {19.424, -3.969}, {23.658, 7.938}, {22.335, 18.785}, {16.514, 23.283}, {8.047, 23.019}, {-1.478, 19.05}, {-11.267, 11.113}, {-19.734, 2.381}, {-29.259, -8.202}, {-38.519, -19.579}, {-48.044, -31.221}, {-56.511, -43.392}, {-64.449, -55.298}, {-72.386, -66.939}, {-77.678, -74.612}, {-79.53, -74.083}, {-71.857, -61.383}, {-62.861, -46.037}, {-52.278, -28.046}, {-44.869, -15.346}, {-38.784, -2.117}, {-35.344, 8.731}, {-36.403, 19.844}, {-42.488, 23.813}, {-52.013, 22.49}, {-60.744, 16.933}, {-68.947, 10.054}, {-76.884, 2.646}, {-93.0112, -12.1707}, {-93.0112, -12.1707}}, smooth = Smooth.Bezier), Ellipse(origin = {40.8208, -37.7602}, fillColor = {161, 0, 4}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-17.8562, -17.8563}, {17.8563, 17.8562}})}), Documentation(info = "<html>
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
<li><b>1600</b> models and blocks, and</li>
<li><b>1350</b> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2016, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, ESI ITI, Fraunhofer,
A.&nbsp;Haumer, C.&nbsp;Kral, Modelon, TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>
<b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
</p>
</html>")); 
end Modelica;

model PID_total  "PID-controller in additive description form"
  extends Modelica.Blocks.Continuous.PID;
 annotation(defaultComponentName = "PID", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), Line(points = {{-80, -80}, {-80, -20}, {60, 80}}, color = {0, 0, 127}), Text(lineColor = {192, 192, 192}, extent = {{-20.0, -60.0}, {80.0, -20.0}}, textString = "PID"), Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, textString = "Ti=%Ti")}), Documentation(info = "<html>
<p>
This is the text-book version of a PID-controller.
For a more practically useful PID-controller, use
block LimPID.
</p>

<p>
The PID block can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>.
This type is identical to
<a href=\"modelica://Modelica.Blocks.Types.Init\">Types.Init</a>,
with the only exception that the additional option
<b>DoNotUse_InitialIntegratorState</b> is added for
backward compatibility reasons (= integrator is initialized with
InitialState whereas differential part is initialized with
NoInit which was the initialization in version 2.2 of the Modelica
standard library).
</p>

<p>
Based on the setting of initType, the integrator (I) and derivative (D)
blocks inside the PID controller are initialized according to the following table:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>initType</b></td>
      <td valign=\"top\"><b>I.initType</b></td>
      <td valign=\"top\"><b>D.initType</b></td></tr>

  <tr><td valign=\"top\"><b>NoInit</b></td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">NoInit</td></tr>

  <tr><td valign=\"top\"><b>SteadyState</b></td>
      <td valign=\"top\">SteadyState</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>InitialState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">InitialState</td></tr>

  <tr><td valign=\"top\"><b>InitialOutput</b><br>
          and initial equation: y = y_start</td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>DoNotUse_InitialIntegratorState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">NoInit</td></tr>
</table>

<p>
In many cases, the most useful initial condition is
<b>SteadyState</b> because initial transients are then no longer
present. If initType = InitPID.SteadyState, then in some
cases difficulties might occur. The reason is the
equation of the integrator:
</p>

<pre>
   <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation \"der(x)=0\" leads to the condition that the input u to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is natural to
initialize it with zero. As sketched this is, however, not possible.
The solution is to not initialize u or the variable that is used
to compute u by an algebraic equation.
</p>

</html>"));
end PID_total;
