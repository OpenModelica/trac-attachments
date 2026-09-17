package ThermoPower  "Open library for thermal power plant simulation" 
  extends Modelica.Icons.Package;

  model System  "System wide properties" 
    parameter Boolean allowFlowReversal = true "= false to restrict to design flow direction (flangeA -> flangeB)" annotation(Evaluate = true);
    parameter ThermoPower.Choices.System.Dynamics Dynamics = Choices.System.Dynamics.DynamicFreeInitial;
    annotation(defaultComponentName = "system", defaultComponentPrefixes = "inner", Icon(graphics = {Polygon(points = {{-100, 60}, {-60, 100}, {60, 100}, {100, 60}, {100, -60}, {60, -100}, {-60, -100}, {-100, -60}, {-100, 60}}, lineColor = {0, 0, 255}, smooth = Smooth.None, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-80, 40}, {80, -20}}, lineColor = {0, 0, 255}, textString = "system")})); 
  end System;

  package Icons  "Icons for ThermoPower library" 
    extends Modelica.Icons.Package;

    package Gas  "Icons for component using water/steam as working fluid" 
      extends Modelica.Icons.Package;

      partial model SourceP   annotation(Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Text(extent = {{-20, 34}, {28, -26}}, lineColor = {255, 255, 255}, textString = "P"), Text(extent = {{-100, -78}, {100, -106}}, textString = "%name")})); end SourceP;

      partial model Tube   annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {159, 159, 223})}), Diagram()); end Tube;

      partial model Fan   annotation(Icon(graphics = {Polygon(points = {{-38, -24}, {-58, -60}, {62, -60}, {42, -24}, {-38, -24}}, lineColor = {95, 95, 95}, lineThickness = 1, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, 80}, {60, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere, fillColor = {170, 170, 255}), Polygon(points = {{-30, 52}, {-30, -8}, {48, 20}, {-30, 52}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {255, 255, 255}), Text(extent = {{-100, -64}, {100, -90}}, lineColor = {95, 95, 95}, textString = "%name")})); end Fan;
    end Gas;
  end Icons;

  package Functions  "Miscellaneous functions" 
    extends Modelica.Icons.Package;

    function squareReg  "Anti-symmetric square approximation with non-zero derivative in the origin" 
      extends Modelica.Icons.Function;
      input Real x;
      input Real delta = 0.01 "Range of significant deviation from x^2*sgn(x)";
      output Real y;
    algorithm
      y := x * sqrt(x * x + delta * delta);
      annotation(Documentation(info = "<html>
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
       </html>", revisions = "<html>
       <ul>
       <li><i>15 Mar 2005</i>
           by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
              Created. </li>
       </ul>
       </html>")); 
    end squareReg;

    package FanCharacteristics  "Functions for fan characteristics" 
      partial function baseFlow  "Base class for fan flow characteristics" 
        extends Modelica.Icons.Function;
        input .Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        input Real bladePos = 1 "Blade position";
        output .Modelica.SIunits.SpecificEnergy H "Specific Energy";
      end baseFlow;

      partial function basePower  "Base class for fan power consumption characteristics" 
        extends Modelica.Icons.Function;
        input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        input Real bladePos = 1 "Blade position";
        output Modelica.SIunits.Power consumption "Power consumption";
      end basePower;

      partial function baseEfficiency  "Base class for efficiency characteristics" 
        extends Modelica.Icons.Function;
        input Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        input Real bladePos = 1 "Blade position";
        output Real eta "Efficiency";
      end baseEfficiency;

      function quadraticFlow  "Quadratic flow characteristic, fixed blades" 
        extends baseFlow;
        input Modelica.SIunits.VolumeFlowRate[3] q_nom "Volume flow rate for three operating points (single fan)" annotation();
        input Modelica.SIunits.Height[3] H_nom "Specific work for three operating points" annotation();
      protected
        parameter Real[3] q_nom2 = {q_nom[1] ^ 2, q_nom[2] ^ 2, q_nom[3] ^ 2} "Squared nominal flow rates";
        parameter Real[3] c = Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2], H_nom) "Coefficients of quadratic specific work characteristic";
      algorithm
        H := c[1] + q_flow * c[2] + q_flow ^ 2 * c[3];
      end quadraticFlow;

      function quadraticFlowBlades  "Quadratic flow characteristic, movable blades" 
        extends baseFlow;
        input Real[:] bladePos_nom;
        input Modelica.SIunits.VolumeFlowRate[3, :] q_nom "Volume flow rate for three operating points at N_pos blade positionings" annotation();
        input Modelica.SIunits.Height[3, :] H_nom "Specific work for three operating points at N_pos blade positionings" annotation();
        input Real slope_s(unit = "(J/kg)/(m3/s)", max = 0) = 0 "Slope of flow characteristic at stalling conditions (must be negative)" annotation();
      algorithm
        H := Utilities.quadraticFlowBlades(q_flow, bladePos, bladePos_nom, Utilities.quadraticFlowBladesCoeff(bladePos_nom, q_nom, H_nom), slope_s);
      end quadraticFlowBlades;

      function constantEfficiency  "Constant efficiency characteristic" 
        extends baseEfficiency;
        input Real eta_nom "Nominal efficiency" annotation();
      algorithm
        eta := eta_nom;
      end constantEfficiency;

      function constantPower  "Constant power consumption characteristic" 
        extends FanCharacteristics.basePower;
        input Modelica.SIunits.Power power = 0 "Constant power consumption" annotation();
      algorithm
        consumption := power;
      end constantPower;

      package Utilities  
        function quadraticFlowBlades  "Quadratic flow characteristic, movable blades" 
          extends Modelica.Icons.Function;
          input Modelica.SIunits.VolumeFlowRate q_flow;
          input Real bladePos;
          input Real[:] bladePos_nom;
          input Real[:, :] c "Coefficients of quadratic specific work characteristic";
          input Real slope_s(unit = "(J/kg)/(m3/s)", max = 0) = 0 "Slope of flow characteristic at stalling conditions (must be negative)";
          output .Modelica.SIunits.SpecificEnergy H "Specific Energy";
        protected
          Integer N_pos = size(bladePos_nom, 1);
          Integer i;
          Real alpha;
          Real q_s "Volume flow rate at stalling conditions";
        algorithm
          i := N_pos - 1;
          while bladePos <= bladePos_nom[i] and i > 1 loop
            i := i - 1;
          end while;
          alpha := (bladePos - bladePos_nom[i]) / (bladePos_nom[i + 1] - bladePos_nom[i]);
          q_s := (slope_s - ((1 - alpha) * c[2, i] + alpha * c[2, i + 1])) / (2 * ((1 - alpha) * c[3, i] + alpha * c[3, i + 1]));
          H := if q_flow > q_s then (1 - alpha) * c[1, i] + alpha * c[1, i + 1] + ((1 - alpha) * c[2, i] + alpha * c[2, i + 1]) * q_flow + ((1 - alpha) * c[3, i] + alpha * c[3, i + 1]) * q_flow ^ 2 else (1 - alpha) * c[1, i] + alpha * c[1, i + 1] + ((1 - alpha) * c[2, i] + alpha * c[2, i + 1]) * q_s + ((1 - alpha) * c[3, i] + alpha * c[3, i + 1]) * q_s ^ 2 + (q_flow - q_s) * slope_s;
        end quadraticFlowBlades;

        function quadraticFlowBladesCoeff  
          extends Modelica.Icons.Function;
          input Real[:] bladePos_nom;
          input Modelica.SIunits.VolumeFlowRate[3, :] q_nom "Volume flow rate for three operating points at N_pos blade positionings";
          input Modelica.SIunits.Height[3, :] H_nom "Specific work for three operating points at N_pos blade positionings";
          output Real[3, size(bladePos_nom, 1)] c "Coefficients of quadratic specific work characteristic";
        protected
          Integer N_pos = size(bladePos_nom, 1);
          Real[3] q_nom2;
        algorithm
          for j in 1:N_pos loop
            q_nom2 := {q_nom[1, j] ^ 2, q_nom[2, j] ^ 2, q_nom[3, j] ^ 2};
            c[:, j] := Modelica.Math.Matrices.solve([ones(3), q_nom[:, j], q_nom2], H_nom[:, j]);
          end for;
        end quadraticFlowBladesCoeff;
      end Utilities;
    end FanCharacteristics;
    annotation(Documentation(info = "<HTML>
     This package contains general-purpose functions and models
     </HTML>")); 
  end Functions;

  package Choices  "Choice enumerations for ThermoPower models" 
    extends Modelica.Icons.Package;

    package PressDrop  
      type FFtypes = enumeration(Kf "Kf friction factor", OpPoint "Friction factor defined by operating point", Kinetic "Kinetic friction factor") "Type, constants and menu choices to select the friction factor";
    end PressDrop;

    package Init  "Options for initialisation" 
      type Options = enumeration(noInit "No initial equations", steadyState "Steady-state initialisation", steadyStateNoP "Steady-state initialisation except pressures", steadyStateNoT "Steady-state initialisation except temperatures", steadyStateNoPT "Steady-state initialisation except pressures and temperatures") "Type, constants and menu choices to select the initialisation options";
    end Init;

    package System  
      type Dynamics = enumeration(DynamicFreeInitial "DynamicFreeInitial -- Dynamic balance, Initial guess value", FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed", SteadyStateInitial "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value", SteadyState "SteadyState -- Steady state balance, Initial guess value") "Enumeration to define definition of balance equations";
    end System;
  end Choices;

  package Gas  "Models of components with ideal gases as working fluid" 
    connector Flange  "Flange connector for gas flows" 
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
      flow Medium.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
      Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
      stream Medium.SpecificEnthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
      stream Medium.MassFraction[Medium.nXi] Xi_outflow "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      stream Medium.ExtraProperty[Medium.nC] C_outflow "Properties c_i/m close to the connection point if m_flow < 0";
      annotation(Icon(), Documentation(info = "<HTML>
       </HTML>", revisions = "<html>
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

    connector FlangeA  "A-type flange connector for gas flows" 
      extends Flange;
      annotation(Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)})); 
    end FlangeA;

    connector FlangeB  "B-type flange connector for gas flows" 
      extends Flange;
      annotation(Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)})); 
    end FlangeB;

    extends Modelica.Icons.Package;

    model SourcePressure  "Pressure source for gas flows" 
      extends Icons.Gas.SourceP;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(p(start = p0), T(start = T), Xi(start = Xnom[1:Medium.nXi]));
      parameter .Modelica.SIunits.Pressure p0 = 101325 "Nominal pressure";
      parameter HydraulicResistance R = 0 "Hydraulic resistance";
      parameter AbsoluteTemperature T = 300 "Nominal temperature";
      parameter .Modelica.SIunits.MassFraction[Medium.nX] Xnom = Medium.reference_X "Nominal gas composition";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false "Use connector input for the pressure" annotation(Dialog(group = "External inputs"));
      parameter Boolean use_in_T = false "Use connector input for the temperature" annotation(Dialog(group = "External inputs"));
      parameter Boolean use_in_X = false "Use connector input for the composition" annotation(Dialog(group = "External inputs"));
      outer ThermoPower.System system "System wide properties";
      FlangeB flange(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation(Placement(transformation(origin = {-60, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation(Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X if use_in_X annotation(Placement(transformation(origin = {60, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X_internal;
    equation
      if R == 0 then
        flange.p = gas.p;
      else
        flange.p = gas.p + flange.m_flow * R;
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
      connect(in_p0, in_p0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);
      annotation(Icon(), Diagram(), Documentation(info = "<html>
       <p><b>Modelling options</b></p>
       <p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.In the case of multiple componet, variable composition gases, the nominal gas composition is given by <tt>Xnom</tt>, whose default value is <tt>Medium.reference_X</tt> .
       <p>If <tt>R</tt> is set to zero, the pressure source is ideal; otherwise, the outlet pressure decreases proportionally to the outgoing flowrate.</p>
       <p>If the <tt>in_p</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
       <p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T</tt>.</p>
       <p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>Xnom</tt>.</p>
       </html>", revisions = "<html>
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

    model SinkPressure  "Pressure sink for gas flows" 
      extends Icons.Gas.SourceP;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(p(start = p0), T(start = T), Xi(start = Xnom[1:Medium.nXi]));
      parameter .Modelica.SIunits.Pressure p0 = 101325 "Nominal pressure";
      parameter AbsoluteTemperature T = 300 "Nominal temperature";
      parameter .Modelica.SIunits.MassFraction[Medium.nX] Xnom = Medium.reference_X "Nominal gas composition";
      parameter HydraulicResistance R = 0 "Hydraulic Resistance";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
      parameter Boolean use_in_p0 = false "Use connector input for the pressure" annotation(Dialog(group = "External inputs"));
      parameter Boolean use_in_T = false "Use connector input for the temperature" annotation(Dialog(group = "External inputs"));
      parameter Boolean use_in_X = false "Use connector input for the composition" annotation(Dialog(group = "External inputs"));
      outer ThermoPower.System system "System wide properties";
      FlangeA flange(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation(Placement(transformation(origin = {-64.5, 59.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation(Placement(transformation(origin = {0, 90}, extent = {{-10, -12}, {10, 12}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X if use_in_X annotation(Placement(transformation(origin = {66, 59}, extent = {{-13, -14}, {13, 14}}, rotation = 270)));
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X_internal;
    equation
      if R == 0 then
        flange.p = gas.p;
      else
        flange.p = gas.p + flange.m_flow * R;
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
      connect(in_p0, in_p0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);
      annotation(Documentation(info = "<html>
       <p><b>Modelling options</b></p>
       <p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the nominal gas composition is given by <tt>Xnom</tt>, whose default value is <tt>Medium.reference_X</tt> .
       <p>If <tt>R</tt> is set to zero, the pressure sink is ideal; otherwise, the inlet pressure increases proportionally to the outgoing flowrate.</p>
       <p>If the <tt>in_p</tt> connector is wired, then the source pressure is given by the corresponding signal, otherwise it is fixed to <tt>p0</tt>.</p>
       <p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T</tt>.</p>
       <p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>Xnom</tt>.</p>
       </html>", revisions = "<html>
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

    model PressDrop  "Pressure drop for gas flows" 
      extends Icons.Gas.Tube;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(p(start = pstart), T(start = Tstart), Xi(start = Xstart[1:Medium.nXi]));
      parameter .Modelica.SIunits.MassFlowRate wnom "Nominal mass flowrate";
      parameter .ThermoPower.Choices.PressDrop.FFtypes FFtype = .ThermoPower.Choices.PressDrop.FFtypes.Kf "Friction factor type";
      parameter Real Kf(fixed = if FFtype == .ThermoPower.Choices.PressDrop.FFtypes.Kf then true else false, unit = "Pa.kg/(m3.kg2/s2)") "Hydraulic resistance coefficient";
      parameter .Modelica.SIunits.Pressure dpnom = 0 "Nominal pressure drop";
      parameter Density rhonom = 0 "Nominal density";
      parameter Real K = 0 "Kinetic resistance coefficient (DP=K*rho*velocity^2/2)";
      parameter .Modelica.SIunits.Area A = 0 "Cross-section";
      parameter Real wnf = 0.01 "Fraction of nominal flow rate at which linear friction equals turbulent friction";
      parameter Real Kfc = 1 "Friction factor correction coefficient";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter .Modelica.SIunits.Pressure pstart = 101325 "Start pressure value" annotation(Dialog(tab = "Initialisation"));
      parameter AbsoluteTemperature Tstart = 300 "Start temperature value" annotation(Dialog(tab = "Initialisation"));
      parameter .Modelica.SIunits.MassFraction[Medium.nX] Xstart = Medium.reference_X "Start gas composition" annotation(Dialog(tab = "Initialisation"));
      function squareReg = ThermoPower.Functions.squareReg;
    protected
      parameter Real Kfl(fixed = false) "Linear friction coefficient";
    public
      .Modelica.SIunits.MassFlowRate w "Mass flow rate in the inlet";
      .Modelica.SIunits.Pressure pin "Inlet pressure";
      .Modelica.SIunits.Pressure pout "Outlet pressure";
      .Modelica.SIunits.Pressure dp "Pressure drop";
      FlangeA inlet(redeclare package Medium = Medium, m_flow(start = wnom, min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
      FlangeB outlet(redeclare package Medium = Medium, m_flow(start = -wnom, max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{80, -20}, {120, 20}}, rotation = 0)));
    initial equation
      if FFtype == .ThermoPower.Choices.PressDrop.FFtypes.OpPoint then
        Kf = dpnom * rhonom / wnom ^ 2 * Kfc;
      elseif FFtype == .ThermoPower.Choices.PressDrop.FFtypes.Kinetic then
        Kf = K / (2 * A ^ 2) * Kfc;
      end if;
      Kfl = wnom * wnf * Kf "Linear friction factor";
      assert(Kf >= 0, "Negative friction coefficient");
    equation
      assert(dpnom > 0, "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
      gas.p = homotopy(if not allowFlowReversal then pin else if inlet.m_flow >= 0 then pin else pout, pin);
      gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
      gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow) else actualStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));
      pin - pout = homotopy(smooth(1, Kf * squareReg(w, wnom * wnf)) / gas.d, dpnom / wnom * w) "Flow characteristics";
      w = inlet.m_flow;
      pin = inlet.p;
      pout = outlet.p;
      dp = pin - pout;
      inlet.m_flow + outlet.m_flow = 0;
      inlet.h_outflow = inStream(outlet.h_outflow);
      inStream(inlet.h_outflow) = outlet.h_outflow;
      inlet.Xi_outflow = inStream(outlet.Xi_outflow);
      inStream(inlet.Xi_outflow) = outlet.Xi_outflow;
      annotation(Icon(graphics = {Text(extent = {{-100, -40}, {100, -80}}, textString = "%name")}), Diagram(), Documentation(info = "<html>
       <p>The pressure drop across the inlet and outlet connectors is computed according to a turbulent friction model, i.e. is proportional to the squared velocity of the fluid. The friction coefficient can be specified directly, or by giving an operating point, or as a multiple of the kinetic pressure. The correction coefficient <tt>Kfc</tt> can be used to modify the friction coefficient, e.g. to fit some experimental operating point.</p>
       <p>A small linear pressure drop is added to avoid numerical singularities at low or zero flowrate. The <tt>wnom</tt> parameter must be always specified; the additional linear pressure drop is such that it is equal to the turbulent pressure drop when the flowrate is equal to <tt>wnf*wnom</tt> (the default value is 1% of the nominal flowrate).
       <p><b>Modelling options</b></p>
       <p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
       <p>The following options are available to specify the friction coefficient:
       <ul><li><tt>FFtype = 0</tt>: the hydraulic friction coefficient <tt>Kf</tt> is used directly.</li>
       <li><tt>FFtype = 1</tt>: the hydraulic friction coefficient is specified by the nominal operating point (<tt>wnom</tt>,<tt>dpnom</tt>, <tt>rhonom</tt>).</li>
       <li><tt>FFtype = 2</tt>: the pressure drop is <tt>K</tt> times the kinetic pressure.</li></ul>
       </html>", revisions = "<html>
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

    partial model FanBase  "Base model for fans" 
      extends Icons.Gas.Fan;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
      Medium.BaseProperties inletFluid(h(start = hstart)) "Fluid properties at the inlet";
      replaceable function flowCharacteristic = Functions.FanCharacteristics.quadraticFlow "Head vs. q_flow characteristic at nominal speed and density" annotation(Dialog(group = "Characteristics"), choicesAllMatching = true);
      parameter Boolean usePowerCharacteristic = false "Use powerCharacteristic (vs. efficiencyCharacteristic)" annotation(Dialog(group = "Characteristics"));
      replaceable function powerCharacteristic = Functions.FanCharacteristics.constantPower constrainedby Functions.FanCharacteristics.basePower;
      replaceable function efficiencyCharacteristic = Functions.FanCharacteristics.constantEfficiency(eta_nom = 0.8) constrainedby Functions.PumpCharacteristics.baseEfficiency;
      parameter Integer Np0(min = 1) = 1 "Nominal number of fans in parallel";
      parameter Real bladePos0 = 1 "Nominal blade position";
      parameter Density rho0 = 1.229 "Nominal Gas Density" annotation(Dialog(group = "Characteristics"));
      parameter .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n0 = 1500 "Nominal rotational speed" annotation(Dialog(group = "Characteristics"));
      parameter .Modelica.SIunits.Volume V = 0 "Fan Internal Volume" annotation(Evaluate = true);
      parameter Boolean CheckValve = false "Reverse flow stopped";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
      outer ThermoPower.System system "System wide properties";
      parameter .Modelica.SIunits.VolumeFlowRate q_single_start = q_single0 "Volume Flow Rate Start Value (single pump)" annotation(Dialog(tab = "Initialisation"));
      parameter .Modelica.SIunits.SpecificEnthalpy hstart = 100000.0 "Fluid Specific Enthalpy Start Value" annotation(Dialog(tab = "Initialisation"));
      parameter Density rho_start = rho0 "Inlet Density start value" annotation(Dialog(tab = "Initialisation"));
      parameter Choices.Init.Options initOpt = Choices.Init.Options.noInit "Initialisation option" annotation(Dialog(tab = "Initialisation"));
      parameter .Modelica.SIunits.MassFlowRate w0 "Nominal mass flow rate" annotation(Dialog(group = "Characteristics"));
      parameter .Modelica.SIunits.Pressure dp0 "Nominal pressure increase" annotation(Dialog(group = "Characteristics"));
      final parameter .Modelica.SIunits.VolumeFlowRate q_single0 = w0 / (Np0 * rho0) "Nominal volume flow rate (single pump)";
      final parameter .Modelica.SIunits.SpecificEnergy H0 = dp0 / rho0 "Nominal specific energy";
    protected
      function df_dqflow = der(flowCharacteristic, q_flow);
    public
      .Modelica.SIunits.MassFlowRate w_single(start = q_single_start * rho_start) "Mass flow rate (single fan)";
      .Modelica.SIunits.MassFlowRate w = Np * w_single "Mass flow rate (total)";
      .Modelica.SIunits.VolumeFlowRate q_single "Volume flow rate (single fan)";
      .Modelica.SIunits.VolumeFlowRate q = Np * q_single "Volume flow rate (totale)";
      .Modelica.SIunits.Pressure dp "Outlet pressure minus inlet pressure";
      .Modelica.SIunits.SpecificEnergy H "Specific energy";
      Medium.SpecificEnthalpy h(start = hstart) "Fluid specific enthalpy";
      Medium.SpecificEnthalpy hin(start = hstart) "Enthalpy of entering fluid";
      Medium.SpecificEnthalpy hout(start = hstart) "Enthalpy of outgoing fluid";
      LiquidDensity rho "Gas density";
      Medium.Temperature Tin "Gas inlet temperature";
      .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n "Shaft r.p.m.";
      Real bladePos "Blade position";
      Integer Np(min = 1) "Number of fans in parallel";
      .Modelica.SIunits.Power W_single "Power Consumption (single fan)";
      .Modelica.SIunits.Power W = Np * W_single "Power Consumption (total)";
      constant .Modelica.SIunits.Power W_eps = 1e-008 "Small coefficient to avoid numerical singularities";
      constant .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n_eps = 1e-006;
      Real eta "Fan efficiency";
      Real s "Auxiliary Variable";
      FlangeA infl(h_outflow(start = hstart), redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{-100, 2}, {-60, 42}}, rotation = 0)));
      FlangeB outfl(h_outflow(start = hstart), redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)) annotation(Placement(transformation(extent = {{40, 52}, {80, 92}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput in_Np "Number of  parallel pumps" annotation(Placement(transformation(origin = {28, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput in_bladePos annotation(Placement(transformation(origin = {-40, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    initial equation
      if initOpt == Choices.Init.Options.noInit then
      elseif initOpt == Choices.Init.Options.steadyState then
        if V > 0 then
          der(h) = 0;
        end if;
      else
        assert(false, "Unsupported initialisation option");
      end if;
    equation
      Np = in_Np;
      if cardinality(in_Np) == 0 then
        in_Np = Np0 "Number of fans selected by parameter";
      end if;
      bladePos = in_bladePos;
      if cardinality(in_bladePos) == 0 then
        in_bladePos = bladePos0 "Blade position selected by parameter";
      end if;
      inletFluid.p = infl.p;
      inletFluid.h = inStream(infl.h_outflow);
      rho = inletFluid.d;
      Tin = inletFluid.T;
      q_single = w_single / homotopy(rho, rho0);
      H = dp / homotopy(rho, rho0);
      if noEvent(s > 0 or not CheckValve) then
        q_single = s;
        H = homotopy((n / n0) ^ 2 * flowCharacteristic(q_single * n0 / (n + n_eps), bladePos), df_dqflow(q_single0) * (q_single - q_single0) + (2 / n0 * flowCharacteristic(q_single0) - q_single0 / n0 * df_dqflow(q_single0)) * (n - n0) + H0);
      else
        H = homotopy((n / n0) ^ 2 * flowCharacteristic(0) - s, df_dqflow(q_single0) * (q_single - q_single0) + (2 / n0 * flowCharacteristic(q_single0) - q_single0 / n0 * df_dqflow(q_single0)) * (n - n0) + H0);
        q_single = 0;
      end if;
      if usePowerCharacteristic then
        W_single = (n / n0) ^ 3 * rho / rho0 * powerCharacteristic(q_single * n0 / (n + n_eps), bladePos) "Power consumption (single fan)";
        eta = dp * q_single / (W_single + W_eps) "Hydraulic efficiency";
      else
        eta = efficiencyCharacteristic(q_single * n0 / (n + n_eps), bladePos);
        W_single = dp * q_single / eta;
      end if;
      dp = outfl.p - infl.p;
      w = infl.m_flow "Fan total flow rate";
      hin = homotopy(if not allowFlowReversal then inStream(infl.h_outflow) else if w >= 0 then inStream(infl.h_outflow) else h, inStream(infl.h_outflow));
      hout = homotopy(if not allowFlowReversal then h else if w >= 0 then h else inStream(outfl.h_outflow), h);
      infl.m_flow + outfl.m_flow = 0 "Mass balance";
      if V > 0 then
        rho * V * der(h) = outfl.m_flow / Np * hout + infl.m_flow / Np * hin + W_single "Dynamic energy balance (single fan)";
        outfl.h_outflow = h;
        infl.h_outflow = h;
      else
        outfl.h_outflow = inStream(infl.h_outflow) + W_single / w "Energy balance for w > 0";
        infl.h_outflow = inStream(outfl.h_outflow) + W_single / w "Energy balance for w < 0";
        h = homotopy(if not allowFlowReversal then outfl.h_outflow else if w >= 0 then outfl.h_outflow else infl.h_outflow, outfl.h_outflow) "Definition of h";
      end if;
      annotation(Icon(), Diagram(), Documentation(info = "<HTML>
       <p>This is the base model for the <tt>FanMech</tt> fan model.
       <p>The model describes a fan, or a group of <tt>Np</tt> identical fans, with optional blade angle regulation. The fan model is based on the theory of kinematic similarity: the fan characteristics are given for nominal operating conditions (rotational speed and fluid density), and then adapted to actual operating condition, according to the similarity equations.
       <p>In order to avoid singularities in the computation of the outlet enthalpy at zero flowrate, the thermal capacity of the fluid inside the fan body can be taken into account.
       <p>The model can either support reverse flow conditions or include a built-in check valve to avoid flow reversal.
       <p><b>Modelling options</b></p>
       <p> The nominal flow characteristic (specific energy vs. volume flow rate) is given by the the replaceable function <tt>flowCharacteristic</tt>. If the blade angles are fixed, it is possible to use implementations which ignore the <tt>bladePos</tt> input.
       <p> The fan energy balance can be specified in two alternative ways:
       <ul>
       <li><tt>usePowerCharacteristic = false</tt> (default option): the replaceable function <tt>efficiencyCharacteristic</tt> (efficiency vs. volume flow rate in nominal conditions) is used to determine the efficiency, and then the power consumption. The default is a constant efficiency of 0.8.
       <li><tt>usePowerCharacteristic = true</tt>: the replaceable function <tt>powerCharacteristic</tt> (power consumption vs. volume flow rate in nominal conditions) is used to determine the power consumption, and then the efficiency.
       </ul>
       <p>
       Several functions are provided in the package <tt>Functions.FanCharacteristics</tt> to specify the characteristics as a function of some operating points at nominal conditions.
       <p>Depending on the value of the <tt>checkValve</tt> parameter, the model either supports reverse flow conditions, or includes a built-in check valve to avoid flow reversal.
       <p>If the <tt>in_Np</tt> input connector is wired, it provides the number of fans in parallel; otherwise,  <tt>Np0</tt> parallel fans are assumed.</p>
       <p>It is possible to take into account the heat capacity of the fluid inside the fan by specifying its volume <tt>V</tt> at nominal conditions; this is necessary to avoid singularities in the computation of the outlet enthalpy in case of zero flow rate. If zero flow rate conditions are always avoided, this dynamic effect can be neglected by leaving the default value <tt>V = 0</tt>, thus avoiding a fast state variable in the model.
       <p>The <tt>CheckValve</tt> parameter determines whether the fan has a built-in check valve or not.
       </HTML>", revisions = "<html>
       <ul>
       <li><i>10 Nov 2005</i>
           by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
             Adapted from the <tt>Water.PumpBase</tt> model.</li>
       </ul>
       </html>")); 
    end FanBase;

    model FanMech  
      extends FanBase;
      .Modelica.SIunits.Angle phi "Shaft angle";
      .Modelica.SIunits.AngularVelocity omega "Shaft angular velocity";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a MechPort annotation(Placement(transformation(extent = {{78, 6}, {108, 36}}, rotation = 0)));
    equation
      n = Modelica.SIunits.Conversions.to_rpm(omega) "Rotational speed";
      phi = MechPort.phi;
      omega = der(phi);
      W_single = omega * MechPort.tau;
      annotation(Diagram(), Icon(graphics = {Rectangle(extent = {{60, 28}, {86, 12}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164})}), Documentation(info = "<HTML>
       <p>This model describes a fan (or a group of <tt>Np</tt> fans in parallel) with a mechanical rotational connector for the shaft, to be used when the pump drive has to be modelled explicitly. In the case of <tt>Np</tt> fans in parallel, the mechanical connector is relative to a single fan.
       <p>The model extends <tt>FanBase</tt>
        </HTML>", revisions = "<html>
       <ul>
       <li><i>10 Nov 2005</i>
           by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
             Adapted from the <tt>Water.PumpBase</tt> model.</li>
       </ul>
       </html>")); 
    end FanMech;
    annotation(Documentation(info = "<HTML>
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

  package Test  "Test cases for the ThermoPower models" 
    extends Modelica.Icons.Package;

    package GasComponents  "Tests for lumped-parameters Gas package components" 
      model TestFanMech  
        Gas.FanMech FanMech1(redeclare package Medium = Modelica.Media.Air.SimpleAir, rho0 = 1.23, n0 = 590, bladePos0 = 0.8, redeclare function flowCharacteristic = flowChar, q_single_start = 144, w0 = 144, dp0 = 6000) annotation(Placement(transformation(extent = {{-70, -24}, {-30, 16}}, rotation = 0)));
        Gas.SinkPressure SinkP1(redeclare package Medium = Modelica.Media.Air.SimpleAir) annotation(Placement(transformation(extent = {{0, 20}, {20, 40}}, rotation = 0)));
        Gas.SourcePressure SourceP1(redeclare package Medium = Modelica.Media.Air.SimpleAir) annotation(Placement(transformation(extent = {{-98, -10}, {-78, 10}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed ConstantSpeed1(w_fixed = Modelica.SIunits.Conversions.from_rpm(590), useSupport = false) annotation(Placement(transformation(extent = {{90, -10}, {70, 10}}, rotation = 0)));
        function flowChar = Functions.FanCharacteristics.quadraticFlowBlades(bladePos_nom = {0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85}, q_nom = [0, 0, 100, 300, 470, 620, 760, 900, 1000, 1100, 1300, 1500; 70, 125, 310, 470, 640, 820, 1000, 1200, 1400, 1570, 1700, 1900; 100, 200, 370, 530, 700, 900, 1100, 1300, 1500, 1750, 2000, 2300], H_nom = [3100, 3800, 3700, 3850, 4200, 4350, 4700, 4900, 5300, 5600, 5850, 6200; 2000, 3000, 3000, 3000, 3000, 3200, 3200, 3300, 3600, 4200, 5000, 5500; 1000, 2000, 2000, 2000, 2000, 1750, 1750, 2000, 2350, 2500, 2850, 3200]);
        Modelica.Blocks.Sources.Ramp Ramp1(startTime = 1, height = 0.55, duration = 9, offset = 0.3) annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}}, rotation = 0)));
        Modelica.Blocks.Sources.Step Step1(startTime = 15, height = -1, offset = 1) annotation(Placement(transformation(extent = {{-30, 54}, {-10, 74}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Components.Inertia Inertia1(w(start = Modelica.SIunits.Conversions.from_rpm(590)), J = 10000) annotation(Placement(transformation(extent = {{-20, -10}, {0, 10}}, rotation = 0)));
        Gas.PressDrop PressDrop1(wnom = 2000 * 1.229, FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, rhonom = 1.229, redeclare package Medium = Modelica.Media.Air.SimpleAir, dpnom = 6000) annotation(Placement(transformation(extent = {{-30, 20}, {-10, 40}}, rotation = 0)));
        Modelica.Mechanics.Rotational.Components.Clutch Clutch1(fn_max = 1000000.0) annotation(Placement(transformation(extent = {{30, -10}, {50, 10}}, rotation = 0)));
        inner System system annotation(Placement(transformation(extent = {{80, 80}, {100, 100}})));
      equation
        connect(SourceP1.flange, FanMech1.infl) annotation(Line(points = {{-78, 0}, {-78, 0.4}, {-66, 0.4}}, color = {159, 159, 223}, thickness = 0.5));
        connect(Ramp1.y, FanMech1.in_bladePos) annotation(Line(points = {{-79, 50}, {-58, 50}, {-58, 11.2}}, color = {0, 0, 127}));
        connect(FanMech1.MechPort, Inertia1.flange_a) annotation(Line(points = {{-31.4, 0.2}, {-26.425, 0.2}, {-26.425, 0}, {-20, 0}}, color = {0, 0, 0}, thickness = 0.5));
        connect(PressDrop1.outlet, SinkP1.flange) annotation(Line(points = {{-10, 30}, {0, 30}}, color = {159, 159, 223}, thickness = 0.5));
        connect(FanMech1.outfl, PressDrop1.inlet) annotation(Line(points = {{-38, 10.4}, {-40.4, 10.4}, {-40.4, 30}, {-30, 30}}, color = {159, 159, 223}, thickness = 0.5));
        connect(Inertia1.flange_b, Clutch1.flange_a) annotation(Line(points = {{0, 0}, {30, 0}}, color = {0, 0, 0}, thickness = 0.5));
        connect(Clutch1.flange_b, ConstantSpeed1.flange) annotation(Line(points = {{50, 0}, {70, 0}}, color = {0, 0, 0}, thickness = 0.5));
        connect(Step1.y, Clutch1.f_normalized) annotation(Line(points = {{-9, 64}, {40, 64}, {40, 11}}, color = {0, 0, 127}));
        annotation(Diagram(), experiment(StopTime = 50, Algorithm = "Dassl"), experimentSetupOutput(equdistant = false)); 
      end TestFanMech;
    end GasComponents;
    annotation(Documentation(info = "<HTML>
     This package contains test cases for the ThermoPower library.
     </HTML>")); 
  end Test;

  type HydraulicResistance = Real(final quantity = "HydraulicResistance", final unit = "Pa/(kg/s)");
  type Density = Modelica.SIunits.Density(start = 40) "generic start value";
  type LiquidDensity = Density(start = 1000) "start value for liquids";
  type AbsoluteTemperature = .Modelica.SIunits.Temperature(start = 300, nominal = 500) "generic temperature";
  annotation(Documentation(info = "<html>
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
   </html>"), uses(Modelica(version = "3.2.1")), version = "3.1"); 
end ThermoPower;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1e-015 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1e-060 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 9.999999999999999e+059 "Biggest Real number such that inf and -inf are representable on the machine";
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
  annotation(Protection(access = Access.hide), preferredView = "info", version = "3.2.1", versionBuild = 2, versionDate = "2013-08-14", dateModified = "2013-08-14 08:44:41Z", revisionId = "$Id:: package.mo 6931 2013-08-14 11:38:51Z #$", uses(Modelica(version = "3.2.1")), conversion(noneFromVersion = "1.0", noneFromVersion = "1.1", noneFromVersion = "1.2"), Documentation(info = "<html>
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
   <b>Licensed by DLR and Dassault Syst&egrave;mes AB under the Modelica License 2</b><br>
   Copyright &copy; 2009-2013, DLR and Dassault Syst&egrave;mes AB.
   </p>

   <p>
   <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
   </p>

   </html>")); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.1 (Build 2)" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}, coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{0.0, 50.0}, {100.0, 0.0}, {0.0, -50.0}, {0.0, 50.0}}), Text(lineColor = {0, 0, 127}, extent = {{-10.0, 60.0}, {-10.0, 85.0}}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one input signal of type Real.
        </p>
        </html>"));
      connector RealOutput = output Real "'output Real' as connector" annotation(defaultComponentName = "y", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}}), Text(lineColor = {0, 0, 127}, extent = {{30.0, 60.0}, {30.0, 110.0}}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one output signal of type Real.
        </p>
        </html>"));
      connector IntegerInput = input Integer "'input Integer' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, lineColor = {255, 127, 0}, fillColor = {255, 127, 0}, fillPattern = FillPattern.Solid)}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, lineColor = {255, 127, 0}, fillColor = {255, 127, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-10, 85}, {-10, 60}}, lineColor = {255, 127, 0}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one input signal of type Integer.
        </p>
        </html>"));

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
        annotation(Documentation(info = "<html>
         <p>
         Block has one continuous Real output signal.
         </p>
         </html>")); 
      end SO;

      partial block SignalSource  "Base class for continuous signal source" 
        extends SO;
        parameter Real offset = 0 "Offset of output signal y";
        parameter .Modelica.SIunits.Time startTime = 0 "Output y = offset for time < startTime";
        annotation(Documentation(info = "<html>
         <p>
         Basic block for Real sources of package Blocks.Sources.
         This component has one continuous Real output signal y
         and two parameters (offset, startTime) to shift the
         generated signal.
         </p>
         </html>")); 
      end SignalSource;
      annotation(Documentation(info = "<HTML>
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

    package Sources  "Library of signal source blocks generating Real and Boolean signals" 
      extends Modelica.Icons.SourcesPackage;

      block Step  "Generate step signal of type Real" 
        parameter Real height = 1 "Height of step";
        extends .Modelica.Blocks.Interfaces.SignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), Polygon(points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), Polygon(points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -70}, {0, -70}, {0, 50}, {80, 50}}, color = {0, 0, 0}), Text(extent = {{-150, -150}, {150, -110}}, lineColor = {0, 0, 0}, textString = "startTime=%startTime")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, 68}, {-80, -80}}, color = {95, 95, 95}), Line(points = {{-80, -18}, {0, -18}, {0, 50}, {80, 50}}, color = {0, 0, 255}, thickness = 0.5), Line(points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Polygon(points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Text(extent = {{70, -80}, {94, -100}}, lineColor = {0, 0, 0}, textString = "time"), Text(extent = {{-21, -72}, {25, -90}}, lineColor = {0, 0, 0}, textString = "startTime"), Line(points = {{0, -18}, {0, -70}}, color = {95, 95, 95}), Text(extent = {{-68, -36}, {-22, -54}}, lineColor = {0, 0, 0}, textString = "offset"), Line(points = {{-13, 50}, {-13, -17}}, color = {95, 95, 95}), Polygon(points = {{0, 50}, {-21, 50}, {0, 50}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{-13, -18}, {-16, -5}, {-10, -5}, {-13, -18}, {-13, -18}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{-13, 50}, {-16, 37}, {-10, 37}, {-13, 50}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Text(extent = {{-68, 26}, {-22, 8}}, lineColor = {0, 0, 0}, textString = "height"), Polygon(points = {{-13, -70}, {-16, -57}, {-10, -57}, {-13, -70}, {-13, -70}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-13, -18}, {-13, -70}}, color = {95, 95, 95}), Polygon(points = {{-13, -18}, {-16, -31}, {-10, -31}, {-13, -18}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Text(extent = {{-72, 100}, {-31, 80}}, lineColor = {0, 0, 0}, textString = "y")}), Documentation(info = "<html>
         <p>
         The Real output y is a step signal:
         </p>

         <p>
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\"
              alt=\"Step.png\">
         </p>

         </html>")); 
      end Step;

      block Ramp  "Generate ramp signal" 
        parameter Real height = 1 "Height of ramps";
        parameter Modelica.SIunits.Time duration(min = 0.0, start = 2) "Duration of ramp (= 0.0 gives a Step)";
        parameter Real offset = 0 "Offset of output signal";
        parameter Modelica.SIunits.Time startTime = 0 "Output = offset for time < startTime";
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = offset + (if time < startTime then 0 else if time < startTime + duration then (time - startTime) * height / duration else height);
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), Polygon(points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-90, -70}, {82, -70}}, color = {192, 192, 192}), Polygon(points = {{90, -70}, {68, -62}, {68, -78}, {90, -70}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -70}, {-40, -70}, {31, 38}}, color = {0, 0, 0}), Text(extent = {{-150, -150}, {150, -110}}, lineColor = {0, 0, 0}, textString = "duration=%duration"), Line(points = {{31, 38}, {86, 38}}, color = {0, 0, 0})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, 68}, {-80, -80}}, color = {95, 95, 95}), Line(points = {{-80, -20}, {-20, -20}, {50, 50}}, color = {0, 0, 255}, thickness = 0.5), Line(points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Polygon(points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{-40, -20}, {-42, -30}, {-38, -30}, {-40, -20}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-40, -20}, {-40, -70}}, color = {95, 95, 95}, thickness = 0.25, arrow = {Arrow.None, Arrow.None}), Polygon(points = {{-40, -70}, {-42, -60}, {-38, -60}, {-40, -70}, {-40, -70}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Text(extent = {{-72, -39}, {-34, -50}}, lineColor = {0, 0, 0}, textString = "offset"), Text(extent = {{-38, -72}, {6, -83}}, lineColor = {0, 0, 0}, textString = "startTime"), Text(extent = {{-78, 92}, {-37, 72}}, lineColor = {0, 0, 0}, textString = "y"), Text(extent = {{70, -80}, {94, -91}}, lineColor = {0, 0, 0}, textString = "time"), Line(points = {{-20, -20}, {-20, -70}}, color = {95, 95, 95}), Line(points = {{-19, -20}, {50, -20}}, color = {95, 95, 95}, thickness = 0.25, arrow = {Arrow.None, Arrow.None}), Line(points = {{50, 50}, {101, 50}}, color = {0, 0, 255}, thickness = 0.5), Line(points = {{50, 50}, {50, -20}}, color = {95, 95, 95}, thickness = 0.25, arrow = {Arrow.None, Arrow.None}), Polygon(points = {{50, -20}, {42, -18}, {42, -22}, {50, -20}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{-20, -20}, {-11, -18}, {-11, -22}, {-20, -20}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{50, 50}, {48, 40}, {52, 40}, {50, 50}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{50, -20}, {48, -10}, {52, -10}, {50, -20}, {50, -20}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Text(extent = {{53, 23}, {82, 10}}, lineColor = {0, 0, 0}, textString = "height"), Text(extent = {{-2, -21}, {37, -33}}, lineColor = {0, 0, 0}, textString = "duration")}), Documentation(info = "<html>
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
      annotation(Documentation(info = "<HTML>
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
       </html>", revisions = "<html>
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
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}), Documentation(info = "<html>
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

  package Mechanics  "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)" 
    extends Modelica.Icons.Package;

    package Rotational  "Library to model 1-dimensional, rotational mechanical systems" 
      extends Modelica.Icons.Package;

      package Components  "Components for 1D rotational mechanical drive trains" 
        extends Modelica.Icons.Package;

        model Inertia  "1D-rotational component with inertia" 
          Rotational.Interfaces.Flange_a flange_a "Left flange of shaft" annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
          Rotational.Interfaces.Flange_b flange_b "Right flange of shaft" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
          parameter .Modelica.SIunits.Inertia J(min = 0, start = 1) "Moment of inertia";
          parameter StateSelect stateSelect = StateSelect.default "Priority to use phi and w as states" annotation(HideResult = true, Dialog(tab = "Advanced"));
          .Modelica.SIunits.Angle phi(stateSelect = stateSelect) "Absolute rotation angle of component" annotation(Dialog(group = "Initialization", showStartAttribute = true));
          .Modelica.SIunits.AngularVelocity w(stateSelect = stateSelect) "Absolute angular velocity of component (= der(phi))" annotation(Dialog(group = "Initialization", showStartAttribute = true));
          .Modelica.SIunits.AngularAcceleration a "Absolute angular acceleration of component (= der(w))" annotation(Dialog(group = "Initialization", showStartAttribute = true));
        equation
          phi = flange_a.phi;
          phi = flange_b.phi;
          w = der(phi);
          a = der(w);
          J * a = flange_a.tau + flange_b.tau;
          annotation(Documentation(info = "<html>
           <p>
           Rotational component with <b>inertia</b> and two rigidly connected flanges.
           </p>

           </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -10.0}, {-50.0, 10.0}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{50.0, -10.0}, {100.0, 10.0}}), Line(points = {{-80.0, -25.0}, {-60.0, -25.0}}), Line(points = {{60.0, -25.0}, {80.0, -25.0}}), Line(points = {{-70.0, -25.0}, {-70.0, -70.0}}), Line(points = {{70.0, -25.0}, {70.0, -70.0}}), Line(points = {{-80.0, 25.0}, {-60.0, 25.0}}), Line(points = {{60.0, 25.0}, {80.0, 25.0}}), Line(points = {{-70.0, 45.0}, {-70.0, 25.0}}), Line(points = {{70.0, 45.0}, {70.0, 25.0}}), Line(points = {{-70.0, -70.0}, {70.0, -70.0}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-50.0, -50.0}, {50.0, 50.0}}, radius = 10.0), Text(lineColor = {0, 0, 255}, extent = {{-150.0, 60.0}, {150.0, 100.0}}, textString = "%name"), Text(extent = {{-150.0, -120.0}, {150.0, -80.0}}, textString = "J=%J"), Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-50, -50}, {50, 50}}, radius = 10)})); 
        end Inertia;

        model Clutch  "Clutch based on Coulomb friction" 
          extends Modelica.Mechanics.Rotational.Icons.Clutch;
          extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
          parameter Real[:, 2] mue_pos = [0, 0.5] "[w,mue] positive sliding friction coefficient (w_rel>=0)";
          parameter Real peak(final min = 1) = 1 "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
          parameter Real cgeo(final min = 0) = 1 "Geometry constant containing friction distribution assumption";
          parameter .Modelica.SIunits.Force fn_max(final min = 0, start = 1) "Maximum normal force";
          extends Rotational.Interfaces.PartialFriction;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
          Real mue0 "Friction coefficient for w=0 and forward sliding";
          .Modelica.SIunits.Force fn "Normal force (fn=fn_max*f_normalized)";
          Modelica.Blocks.Interfaces.RealInput f_normalized "Normalized force signal 0..1 (normal force = fn_max*f_normalized; clutch is engaged if > 0)" annotation(Placement(transformation(origin = {0, 110}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
        equation
          mue0 = Modelica.Math.tempInterpol1(0, mue_pos, 2);
          w_relfric = w_rel;
          a_relfric = a_rel;
          fn = fn_max * f_normalized;
          free = fn <= 0;
          tau0 = mue0 * cgeo * fn;
          tau0_max = peak * tau0;
          tau = if locked then sa * unitTorque else if free then 0 else cgeo * fn * (if startForward then Modelica.Math.tempInterpol1(w_rel, mue_pos, 2) else if startBackward then -Modelica.Math.tempInterpol1(-w_rel, mue_pos, 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(w_rel, mue_pos, 2) else -Modelica.Math.tempInterpol1(-w_rel, mue_pos, 2));
          lossPower = tau * w_relfric;
          annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-150, -110}, {150, -70}}, textString = "%name", lineColor = {0, 0, 255}), Line(visible = useHeatPort, points = {{-100, -100}, {-100, -40}, {0, -40}}, color = {191, 0, 0}, pattern = LinePattern.Dot, smooth = Smooth.None)}), Documentation(info = "<html>
           <p>
           This component models a <b>clutch</b>, i.e., a component with
           two flanges where friction is present between the two flanges
           and these flanges are pressed together via a normal force.
           The normal force fn has to be provided as input signal f_normalized in a normalized form
           (0 &le; f_normalized &le; 1),
           fn = fn_max*f_normalized, where fn_max has to be provided as parameter. Friction in the
           clutch is modelled in the following way:
           </p>
           <p>
           When the relative angular velocity is not zero, the friction torque is a
           function of the velocity dependent friction coefficient  mue(w_rel) , of
           the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
           account the geometry of the device and the assumptions on the friction
           distributions:
           </p>
           <pre>
                   frictional_torque = <b>cgeo</b> * <b>mue</b>(w_rel) * <b>fn</b>
           </pre>
           <p>
              Typical values of coefficients of friction:
           </p>
           <pre>
                 dry operation   :  <b>mue</b> = 0.2 .. 0.4
                 operating in oil:  <b>mue</b> = 0.05 .. 0.1
           </pre>
           <p>
              When plates are pressed together, where  <b>ri</b>  is the inner radius,
              <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
              the geometry constant is calculated in the following way under the
              assumption of a uniform rate of wear at the interfaces:
           </p>
           <pre>
                    <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2
           </pre>
           <p>
               The positive part of the friction characteristic <b>mue</b>(w_rel),
               w_rel >= 0, is defined via table mue_pos (first column = w_rel,
               second column = mue). Currently, only linear interpolation in
               the table is supported.
           </p>
           <p>
              When the relative angular velocity becomes zero, the elements
              connected by the friction element become stuck, i.e., the relative
              angle remains constant. In this phase the friction torque is
              calculated from a torque balance due to the requirement, that
              the relative acceleration shall be zero.  The elements begin
              to slide when the friction torque exceeds a threshold value,
              called the  maximum static friction torque, computed via:
           </p>
           <pre>
                  frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w_rel=0) * <b>fn</b>   (<b>peak</b> >= 1)
           </pre>
           <p>
           This procedure is implemented in a \"clean\" way by state events and
           leads to continuous/discrete systems of equations if friction elements
           are dynamically coupled. The method is described in:
           </p>
           <dl>
           <dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):
           <dd><b>Hybrid Modeling in Modelica based on the Synchronous
               Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.
           </dl>
           <p>
           More precise friction models take into account the elasticity of the
           material when the two elements are \"stuck\", as well as other effects,
           like hysteresis. This has the advantage that the friction element can
           be completely described by a differential equation without events. The
           drawback is that the system becomes stiff (about 10-20 times slower
           simulation) and that more material constants have to be supplied which
           requires more sophisticated identification. For more details, see the
           following references, especially (Armstrong and Canudas de Witt 1996):
           </p>
           <dl>
           <dt>Armstrong B. (1991):</dt>
           <dd><b>Control of Machines with Friction</b>. Kluwer Academic
               Press, Boston MA.<br></dd>
           <dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
           <dd><b>Friction Modeling and Compensation.</b>
               The Control Handbook, edited by W.S.Levine, CRC Press,
               pp. 1369-1382.<br></dd>
           <dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):</dt>
           <dd><b>A new model for control of systems with friction.</b>
               IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
           </dl>

           <p>
           See also the discussion
           <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
           in the User's Guide of the Rotational library.
           </p>
           </html>")); 
        end Clutch;
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Rectangle(origin = {13.5135, 76.9841}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-63.5135, -126.9841}, {36.4865, -26.9841}}, radius = 10.0), Rectangle(origin = {13.5135, 76.9841}, lineColor = {64, 64, 64}, fillPattern = FillPattern.None, extent = {{-63.5135, -126.9841}, {36.4865, -26.9841}}, radius = 10.0), Rectangle(origin = {-3.0, 73.07689999999999}, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-87.0, -83.07689999999999}, {-47.0, -63.0769}}), Rectangle(origin = {22.3077, 70.0}, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{27.6923, -80.0}, {67.6923, -60.0}})}), Documentation(info = "<html>
         <p>
         This package contains basic components 1D mechanical rotational drive trains.
         </p>
         </html>")); 
      end Components;

      package Sources  "Sources to drive 1D rotational mechanical components" 
        extends Modelica.Icons.SourcesPackage;

        model ConstantSpeed  "Constant speed, not dependent on torque" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
          Modelica.SIunits.AngularVelocity w "Angular velocity of flange with respect to support (= der(phi))";
          parameter Modelica.SIunits.AngularVelocity w_fixed "Fixed speed";
        equation
          w = der(phi);
          w = w_fixed;
          annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Line(points = {{0, -100}, {0, 100}}, color = {0, 0, 127}), Text(extent = {{-116.0, -40.0}, {128.0, -16.0}}, textString = "%w_fixed")}), Documentation(info = "<HTML>
           <p>
           Model of <b>fixed</b> angular velocity of flange, not dependent on torque.
           </p>
           </HTML>")); 
        end ConstantSpeed;
        annotation(Documentation(info = "<html>
         <p>
         This package contains ideal sources to drive 1D mechanical rotational drive trains.
         </p>
         </html>")); 
      end Sources;

      package Interfaces  "Connectors and partial models for 1D rotational mechanical components" 
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a  "1-dim. rotational flange of a shaft (filled square icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
          annotation(defaultComponentName = "flange_a", Documentation(info = "<html>
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
           </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-160, 90}, {40, 50}}, lineColor = {0, 0, 0}, textString = "%name"), Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid)})); 
        end Flange_a;

        connector Flange_b  "1-dim. rotational flange of a shaft (non-filled square icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
          annotation(defaultComponentName = "flange_b", Documentation(info = "<html>
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
           </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-98, 100}, {102, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, 90}, {160, 50}}, lineColor = {0, 0, 0}, textString = "%name")})); 
        end Flange_b;

        connector Support  "Support/housing of a 1-dim. rotational shaft" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of the support/housing";
          flow .Modelica.SIunits.Torque tau "Reaction torque in the support/housing";
          annotation(Documentation(info = "<html>
           <p>
           This is a connector for 1-dim. rotational mechanical systems and models
           the support or housing of a shaft. The following variables are defined in this connector:
           </p>

           <table border=1 cellspacing=0 cellpadding=2>
             <tr><td valign=\"top\"> <b>phi</b></td>
                 <td valign=\"top\"> Absolute rotation angle of the support/housing in [rad] </td>
             </tr>
             <tr><td valign=\"top\"> <b>tau</b></td>
                 <td valign=\"top\"> Reaction torque in the support/housing in [Nm] </td>
             </tr>
           </table>

           <p>
           The support connector is usually defined as conditional connector.
           It is most convenient to utilize it
           </p>

           <ul>
           <li> For models to be build graphically (i.e., the model is build up by drag-and-drop
                from elementary components):<br>
                <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br>
                <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>, <br> &nbsp; </li>

           <li> For models to be build textually (i.e., elementary models):<br>
                <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport\">PartialElementaryOneFlangeAndSupport</a>,<br>
                <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport\">PartialElementaryTwoFlangesAndSupport</a>,<br>
                <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
           </ul>
           </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-150, 150}, {150, -150}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-160, 100}, {40, 60}}, lineColor = {0, 0, 0}, textString = "%name"), Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid)})); 
        end Support;

        partial model PartialCompliantWithRelativeStates  "Partial model for the compliant connection of two rotational 1-dim. shaft flanges where the relative angle and speed are used as preferred states" 
          Modelica.SIunits.Angle phi_rel(start = 0, stateSelect = stateSelect, nominal = if phi_nominal >= Modelica.Constants.eps then phi_nominal else 1) "Relative rotation angle (= flange_b.phi - flange_a.phi)";
          Modelica.SIunits.AngularVelocity w_rel(start = 0, stateSelect = stateSelect) "Relative angular velocity (= der(phi_rel))";
          Modelica.SIunits.AngularAcceleration a_rel(start = 0) "Relative angular acceleration (= der(w_rel))";
          Modelica.SIunits.Torque tau "Torque between flanges (= flange_b.tau)";
          Flange_a flange_a "Left flange of compliant 1-dim. rotational component" annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
          Flange_b flange_b "Right flange of compliant 1-dim. rotational component" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
          parameter .Modelica.SIunits.Angle phi_nominal(displayUnit = "rad", min = 0.0) = 0.0001 "Nominal value of phi_rel (used for scaling)" annotation(Dialog(tab = "Advanced"));
          parameter StateSelect stateSelect = StateSelect.prefer "Priority to use phi_rel and w_rel as states" annotation(HideResult = true, Dialog(tab = "Advanced"));
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          w_rel = der(phi_rel);
          a_rel = der(w_rel);
          flange_b.tau = tau;
          flange_a.tau = -tau;
          annotation(Documentation(info = "<html>
           <p>
           This is a 1-dim. rotational component with a compliant connection of two
           rotational 1-dim. flanges where inertial effects between the two
           flanges are neglected. The basic assumption is that the cut-torques
           of the two flanges sum-up to zero, i.e., they have the same absolute value
           but opposite sign: flange_a.tau + flange_b.tau = 0. This base class
           is used to built up force elements such as springs, dampers, friction.
           </p>

           <p>
           The relative angle and the relative speed are defined as preferred states.
           The reason is that for some drive trains, such as drive
           trains in vehicles, the absolute angle is quickly increasing during operation.
           Numerically, it is better to use relative angles between drive train components
           because they remain in a limited size. For this reason, StateSelect.prefer
           is set for the relative angle of this component.
           </p>

           <p>
           In order to improve the numerics, a nominal value for the relative angle
           can be provided via parameter <b>phi_nominal</b> in the Advanced menu.
           The default is 1e-4 rad since relative angles are usually
           in this order and the step size control of an integrator would be
           practically switched off, if a default of 1 rad would be used.
           This nominal value might also be computed from other values, such
           as \"phi_nominal = tau_nominal / c\" for a rotational spring, if tau_nominal
           and c are more meaningful for the user.
           </p>

           <p>
           See also the discussion
           <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
           in the User's Guide of the Rotational library.
           </p>
           </html>")); 
        end PartialCompliantWithRelativeStates;

        partial model PartialElementaryOneFlangeAndSupport2  "Partial model for a component with one rotational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models" 
          parameter Boolean useSupport = false "= true, if support flange enabled, otherwise implicitly grounded" annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
          Flange_b flange "Flange of shaft" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
          Support support(phi = phi_support, tau = -flange.tau) if useSupport "Support/housing of component" annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
        protected
          Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
        equation
          if not useSupport then
            phi_support = 0;
          end if;
          annotation(Documentation(info = "<html>
           <p>
           This is a 1-dim. rotational component with one flange and a support/housing.
           It is used to build up elementary components of a drive train with
           equations in the text layer.
           </p>

           <p>
           If <i>useSupport=true</i>, the support connector is conditionally enabled
           and needs to be connected.<br>
           If <i>useSupport=false</i>, the support connector is conditionally disabled
           and instead the component is internally fixed to ground.
           </p>
           </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(visible = not useSupport, points = {{-50, -120}, {-30, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-30, -120}, {-10, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-10, -120}, {10, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{10, -120}, {30, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-30, -100}, {30, -100}}, color = {0, 0, 0})})); 
        end PartialElementaryOneFlangeAndSupport2;

        partial model PartialTorque  "Partial model of a torque acting at the flange (accelerates the flange)" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
          Modelica.SIunits.Angle phi "Angle of flange with respect to support (= flange.phi - support.phi)";
        equation
          phi = flange.phi - phi_support;
          annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-96, 96}, {96, -96}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -62}, {0, -100}}, color = {0, 0, 0}), Line(points = {{-92, 0}, {-76, 36}, {-54, 62}, {-30, 80}, {-14, 88}, {10, 92}, {26, 90}, {46, 80}, {64, 62}}, color = {0, 0, 0}, smooth = Smooth.Bezier), Text(extent = {{-150, 140}, {150, 100}}, lineColor = {0, 0, 255}, textString = "%name"), Polygon(points = {{94, 16}, {80, 74}, {50, 52}, {94, 16}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{-58, -82}, {-42, -68}, {-20, -56}, {0, -54}, {18, -56}, {34, -62}, {44, -72}, {54, -82}, {60, -94}}, color = {0, 0, 0}, smooth = Smooth.Bezier), Polygon(points = {{-65, -98}, {-46, -80}, {-58, -72}, {-65, -98}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(visible = not useSupport, points = {{-50, -120}, {-30, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-30, -120}, {-10, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-10, -120}, {10, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{10, -120}, {30, -100}}, color = {0, 0, 0}), Line(visible = not useSupport, points = {{-30, -100}, {30, -100}}, color = {0, 0, 0})}), Documentation(info = "<HTML>
           <p>
           Partial model of torque that accelerates the flange.
           </p>

           <p>
           If <i>useSupport=true</i>, the support connector is conditionally enabled
           and needs to be connected.<br>
           If <i>useSupport=false</i>, the support connector is conditionally disabled
           and instead the component is internally fixed to ground.
           </p>
           </html>")); 
        end PartialTorque;

        partial model PartialFriction  "Partial model of Coulomb friction elements" 
          parameter .Modelica.SIunits.AngularVelocity w_small = 10000000000.0 "Relative angular velocity near to zero if jumps due to a reinit(..) of the velocity can occur (set to low value only if such impulses can occur)" annotation(Dialog(tab = "Advanced"));
          .Modelica.SIunits.AngularVelocity w_relfric "Relative angular velocity between frictional surfaces";
          .Modelica.SIunits.AngularAcceleration a_relfric "Relative angular acceleration between frictional surfaces";
          .Modelica.SIunits.Torque tau0 "Friction torque for w=0 and forward sliding";
          .Modelica.SIunits.Torque tau0_max "Maximum friction torque for w=0 and locked";
          Boolean free "true, if frictional element is not active";
          Real sa(final unit = "1") "Path parameter of friction characteristic tau = f(a_relfric)";
          Boolean startForward(start = false, fixed = true) "true, if w_rel=0 and start of forward sliding";
          Boolean startBackward(start = false, fixed = true) "true, if w_rel=0 and start of backward sliding";
          Boolean locked(start = false) "true, if w_rel=0 and not sliding";
          constant Integer Unknown = 3 "Value of mode is not known";
          constant Integer Free = 2 "Element is not active";
          constant Integer Forward = 1 "w_rel > 0 (forward sliding)";
          constant Integer Stuck = 0 "w_rel = 0 (forward sliding, locked or backward sliding)";
          constant Integer Backward = -1 "w_rel < 0 (backward sliding)";
          Integer mode(final min = Backward, final max = Unknown, start = Unknown, fixed = true);
        protected
          constant .Modelica.SIunits.AngularAcceleration unitAngularAcceleration = 1 annotation(HideResult = true);
          constant .Modelica.SIunits.Torque unitTorque = 1 annotation(HideResult = true);
        equation
          startForward = pre(mode) == Stuck and (sa > tau0_max / unitTorque or pre(startForward) and sa > tau0 / unitTorque) or pre(mode) == Backward and w_relfric > w_small or initial() and w_relfric > 0;
          startBackward = pre(mode) == Stuck and (sa < -tau0_max / unitTorque or pre(startBackward) and sa < -tau0 / unitTorque) or pre(mode) == Forward and w_relfric < -w_small or initial() and w_relfric < 0;
          locked = not free and not (pre(mode) == Forward or startForward or pre(mode) == Backward or startBackward);
          a_relfric / unitAngularAcceleration = if locked then 0 else if free then sa else if startForward then sa - tau0_max / unitTorque else if startBackward then sa + tau0_max / unitTorque else if pre(mode) == Forward then sa - tau0_max / unitTorque else sa + tau0_max / unitTorque;
          mode = if free then Free else if (pre(mode) == Forward or pre(mode) == Free or startForward) and w_relfric > 0 then Forward else if (pre(mode) == Backward or pre(mode) == Free or startBackward) and w_relfric < 0 then Backward else Stuck;
          annotation(Documentation(info = "<html>
           <p>
           Basic model for Coulomb friction that models the stuck phase in a reliable way.
           </p>
           </html>")); 
        end PartialFriction;
        annotation(Documentation(info = "<html>
         <p>
         This package contains connectors and partial models for 1-dim.
         rotational mechanical components. The components of this package can
         only be used as basic building elements for models.
         </p>
         </html>")); 
      end Interfaces;

      package Icons  "Icons for Rotational package" 
        extends Modelica.Icons.IconsPackage;

        model Clutch  "Icon of a clutch"  annotation(Icon(graphics = {Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -10.0}, {-30.0, 10.0}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-30.0, -60.0}, {-10.0, 60.0}}), Rectangle(lineColor = {64, 64, 64}, fillPattern = FillPattern.None, extent = {{-30.0, -60.0}, {-10.0, 60.0}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{10.0, -60.0}, {30.0, 60.0}}), Rectangle(lineColor = {64, 64, 64}, fillPattern = FillPattern.None, extent = {{10.0, -60.0}, {30.0, 60.0}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{30.0, -10.0}, {100.0, 10.0}}), Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-30.0, 40.0}, {-60.0, 50.0}, {-60.0, 30.0}, {-30.0, 40.0}}), Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{30.0, 40.0}, {60.0, 50.0}, {60.0, 30.0}, {30.0, 40.0}}), Line(points = {{0.0, 90.0}, {90.0, 70.0}, {90.0, 40.0}, {30.0, 40.0}}, color = {0, 0, 127}), Line(points = {{0.0, 90.0}, {-90.0, 70.0}, {-90.0, 40.0}, {-30.0, 40.0}}, color = {0, 0, 127})}, coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1)), Documentation(info = "<html>
          <p>
          This is the icon of a clutch from the rotational package.
          </p>
          </html>")); end Clutch;
        annotation(Documentation(info = "<html>
         <p>
         This package contains icons for the Rotational library
         (that is, all the components have only graphical annotations
         without any equations).
         </p>
         </html>")); 
      end Icons;
      annotation(Documentation(info = "<html>

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
       </html>", revisions = ""), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Line(visible = true, origin = {-2.0, 46.0}, points = {{-83.0, -66.0}, {-63.0, -66.0}}), Line(visible = true, origin = {29.0, 48.0}, points = {{36.0, -68.0}, {56.0, -68.0}}), Line(visible = true, origin = {-2.0, 49.0}, points = {{-83.0, -29.0}, {-63.0, -29.0}}), Line(visible = true, origin = {29.0, 52.0}, points = {{36.0, -32.0}, {56.0, -32.0}}), Line(visible = true, origin = {-2.0, 49.0}, points = {{-73.0, -9.0}, {-73.0, -29.0}}), Line(visible = true, origin = {29.0, 52.0}, points = {{46.0, -12.0}, {46.0, -32.0}}), Line(visible = true, origin = {-0.0, -47.5}, points = {{-75.0, 27.5}, {-75.0, -27.5}, {75.0, -27.5}, {75.0, 27.5}}), Rectangle(visible = true, origin = {13.5135, 76.9841}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-63.5135, -126.9841}, {36.4865, -26.9841}}, radius = 10.0), Rectangle(visible = true, origin = {13.5135, 76.9841}, lineColor = {64, 64, 64}, fillPattern = FillPattern.None, extent = {{-63.5135, -126.9841}, {36.4865, -26.9841}}, radius = 10.0), Rectangle(visible = true, origin = {-3.0, 73.07689999999999}, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-87.0, -83.07689999999999}, {-47.0, -63.0769}}), Rectangle(visible = true, origin = {22.3077, 70.0}, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{27.6923, -80.0}, {67.6923, -60.0}})})); 
    end Rotational;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Rectangle(origin = {8.6, 63.3333}, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-4.6, -93.33329999999999}, {41.4, -53.3333}}), Ellipse(origin = {9.0, 46.0}, extent = {{-90.0, -60.0}, {-80.0, -50.0}}), Line(origin = {9.0, 46.0}, points = {{-85.0, -55.0}, {-60.0, -21.0}}, thickness = 0.5), Ellipse(origin = {9.0, 46.0}, extent = {{-65.0, -26.0}, {-55.0, -16.0}}), Line(origin = {9.0, 46.0}, points = {{-60.0, -21.0}, {9.0, -55.0}}, thickness = 0.5), Ellipse(origin = {9.0, 46.0}, fillPattern = FillPattern.Solid, extent = {{4.0, -60.0}, {14.0, -50.0}}), Line(origin = {9.0, 46.0}, points = {{-10.0, -26.0}, {72.0, -26.0}, {72.0, -86.0}, {-10.0, -86.0}})}), Documentation(info = "<HTML>
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

  package Media  "Library of media property models" 
    extends Modelica.Icons.Package;

    package Interfaces  "Interfaces for media models" 
      extends Modelica.Icons.InterfacesPackage;

      partial package PartialMedium  "Partial medium properties (base package of all media packages)" 
        extends Modelica.Media.Interfaces.Types;
        extends Modelica.Icons.MaterialPropertiesPackage;
        constant Modelica.Media.Interfaces.Choices.IndependentVariables ThermoStates "Enumeration type for independent variables";
        constant String mediumName = "unusablePartialMedium" "Name of the medium";
        constant String[:] substanceNames = {mediumName} "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
        constant String[:] extraPropertiesNames = fill("", 0) "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
        constant Boolean singleState "= true, if u and d are not a function of pressure";
        constant Boolean reducedX = true "= true if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
        constant Boolean fixedX = false "= true if medium contains the equation X = reference_X";
        constant AbsolutePressure reference_p = 101325 "Reference pressure of Medium: default 1 atmosphere";
        constant Temperature reference_T = 298.15 "Reference temperature of Medium: default 25 deg Celsius";
        constant MassFraction[nX] reference_X = fill(1 / nX, nX) "Default mass fractions of medium";
        constant AbsolutePressure p_default = 101325 "Default value for pressure of medium (for initialization)";
        constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20) "Default value for temperature of medium (for initialization)";
        constant MassFraction[nX] X_default = reference_X "Default value for mass fractions of medium (for initialization)";
        final constant Integer nS = size(substanceNames, 1) "Number of substances" annotation(Evaluate = true);
        constant Integer nX = nS "Number of mass fractions" annotation(Evaluate = true);
        constant Integer nXi = if fixedX then 0 else if reducedX then nS - 1 else nS "Number of structurally independent mass fractions (see docu for details)" annotation(Evaluate = true);
        final constant Integer nC = size(extraPropertiesNames, 1) "Number of extra (outside of standard mass-balance) transported properties" annotation(Evaluate = true);
        replaceable record FluidConstants = Modelica.Media.Interfaces.Types.Basic.FluidConstants "Critical, triple, molecular and other standard data of fluid";

        replaceable record ThermodynamicState  "Minimal variable set that is available as input argument to every medium function" 
          extends Modelica.Icons.Record;
        end ThermodynamicState;

        replaceable partial model BaseProperties  "Base properties (p, d, T, h, u, R, MM and, if applicable, X and Xi) of a medium" 
          InputAbsolutePressure p "Absolute pressure of medium";
          InputMassFraction[nXi] Xi(start = reference_X[1:nXi]) "Structurally independent mass fractions";
          InputSpecificEnthalpy h "Specific enthalpy of medium";
          Density d "Density of medium";
          Temperature T "Temperature of medium";
          MassFraction[nX] X(start = reference_X) "Mass fractions (= (component mass)/total mass  m_i/m)";
          SpecificInternalEnergy u "Specific internal energy of medium";
          SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
          MolarMass MM "Molar mass (of mixture or single fluid)";
          ThermodynamicState state "Thermodynamic state record for optional functions";
          parameter Boolean preferredMediumStates = false "= true if StateSelect.prefer shall be used for the independent property variables of the medium" annotation(Evaluate = true, Dialog(tab = "Advanced"));
          parameter Boolean standardOrderComponents = true "If true, and reducedX = true, the last element of X will be computed from the other ones";
          .Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC = Modelica.SIunits.Conversions.to_degC(T) "Temperature of medium in [degC]";
          .Modelica.SIunits.Conversions.NonSIunits.Pressure_bar p_bar = Modelica.SIunits.Conversions.to_bar(p) "Absolute pressure of medium in [bar]";
          connector InputAbsolutePressure = input .Modelica.SIunits.AbsolutePressure "Pressure as input signal connector";
          connector InputSpecificEnthalpy = input .Modelica.SIunits.SpecificEnthalpy "Specific enthalpy as input signal connector";
          connector InputMassFraction = input .Modelica.SIunits.MassFraction "Mass fraction as input signal connector";
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
              assert(X[i] >= -1e-005 and X[i] <= 1 + 1e-005, "Mass fraction X[" + String(i) + "] = " + String(X[i]) + "of substance " + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
            end for;
          end if;
          assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" + mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
          annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-152, 164}, {152, 102}}, textString = "%name", lineColor = {0, 0, 255})}), Documentation(info = "<html>
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

        replaceable partial function setState_pTX  "Return thermodynamic state as function of p, T and composition X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        end setState_pTX;

        replaceable partial function setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
          extends Modelica.Icons.Function;
          input Real x "m_flow or dp";
          input ThermodynamicState state_a "Thermodynamic state if x > 0";
          input ThermodynamicState state_b "Thermodynamic state if x < 0";
          input Real x_small(min = 0) "Smooth transition in the region -x_small < x < x_small";
          output ThermodynamicState state "Smooth thermodynamic state for all x (continuous and differentiable)";
          annotation(Documentation(info = "<html>
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

        replaceable partial function dynamicViscosity  "Return dynamic viscosity" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output DynamicViscosity eta "Dynamic viscosity";
        end dynamicViscosity;

        replaceable partial function thermalConductivity  "Return thermal conductivity" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output ThermalConductivity lambda "Thermal conductivity";
        end thermalConductivity;

        replaceable partial function pressure  "Return pressure" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output AbsolutePressure p "Pressure";
        end pressure;

        replaceable partial function temperature  "Return temperature" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output Temperature T "Temperature";
        end temperature;

        replaceable partial function density  "Return density" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output Density d "Density";
        end density;

        replaceable partial function specificEnthalpy  "Return specific enthalpy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnthalpy h "Specific enthalpy";
        end specificEnthalpy;

        replaceable partial function specificInternalEnergy  "Return specific internal energy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnergy u "Specific internal energy";
        end specificInternalEnergy;

        replaceable partial function specificEntropy  "Return specific entropy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEntropy s "Specific entropy";
        end specificEntropy;

        replaceable partial function specificGibbsEnergy  "Return specific Gibbs energy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnergy g "Specific Gibbs energy";
        end specificGibbsEnergy;

        replaceable partial function specificHelmholtzEnergy  "Return specific Helmholtz energy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnergy f "Specific Helmholtz energy";
        end specificHelmholtzEnergy;

        replaceable partial function specificHeatCapacityCp  "Return specific heat capacity at constant pressure" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificHeatCapacity cp "Specific heat capacity at constant pressure";
        end specificHeatCapacityCp;

        replaceable partial function specificHeatCapacityCv  "Return specific heat capacity at constant volume" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificHeatCapacity cv "Specific heat capacity at constant volume";
        end specificHeatCapacityCv;

        replaceable partial function isentropicExponent  "Return isentropic exponent" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output IsentropicExponent gamma "Isentropic exponent";
        end isentropicExponent;

        replaceable partial function isentropicEnthalpy  "Return isentropic enthalpy" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p_downstream "Downstream pressure";
          input ThermodynamicState refState "Reference state for entropy";
          output SpecificEnthalpy h_is "Isentropic enthalpy";
          annotation(Documentation(info = "<html>
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

        replaceable partial function velocityOfSound  "Return velocity of sound" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output VelocityOfSound a "Velocity of sound";
        end velocityOfSound;

        replaceable partial function isobaricExpansionCoefficient  "Return overall the isobaric expansion coefficient beta" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
          annotation(Documentation(info = "<html>
           <pre>
           beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
           </pre>
           </html>")); 
        end isobaricExpansionCoefficient;

        replaceable partial function isothermalCompressibility  "Return overall the isothermal compressibility factor" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility";
          annotation(Documentation(info = "<html>
           <pre>

           kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

           </pre>
           </html>")); 
        end isothermalCompressibility;

        replaceable partial function density_derp_T  "Return density derivative w.r.t. pressure at const temperature" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
        end density_derp_T;

        replaceable partial function density_derT_p  "Return density derivative w.r.t. temperature at constant pressure" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output DerDensityByTemperature ddTp "Density derivative w.r.t. temperature";
        end density_derT_p;

        replaceable partial function density_derX  "Return density derivative w.r.t. mass fraction" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
        end density_derX;

        replaceable partial function molarMass  "Return the molar mass of the medium" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output MolarMass MM "Mixture molar mass";
        end molarMass;

        replaceable function specificEnthalpy_pTX  "Return specific enthalpy from p, T, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[:] X = reference_X "Mass fractions";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy(setState_pTX(p, T, X));
          annotation(inverse(T = temperature_phX(p, h, X))); 
        end specificEnthalpy_pTX;

        type MassFlowRate = .Modelica.SIunits.MassFlowRate(quantity = "MassFlowRate." + mediumName, min = -100000.0, max = 100000.0) "Type for mass flow rate with medium specific attributes";
        annotation(Documentation(info = "<html>
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
         </html>", revisions = "<html>

         </html>")); 
      end PartialMedium;

      partial package PartialPureSubstance  "Base class for pure substances of one chemical substance" 
        extends PartialMedium(final reducedX = true, final fixedX = true);

        redeclare replaceable partial model extends BaseProperties  end BaseProperties;
      end PartialPureSubstance;

      partial package PartialSimpleIdealGasMedium  "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g., transport properties, are constant." 
        extends Interfaces.PartialPureSubstance(redeclare replaceable record FluidConstants = Modelica.Media.Interfaces.Types.Basic.FluidConstants, ThermoStates = Choices.IndependentVariables.pT, final singleState = false);
        constant SpecificHeatCapacity cp_const "Constant specific heat capacity at constant pressure";
        constant SpecificHeatCapacity cv_const = cp_const - R_gas "Constant specific heat capacity at constant volume";
        constant SpecificHeatCapacity R_gas "Medium specific gas constant";
        constant MolarMass MM_const "Molar mass";
        constant DynamicViscosity eta_const "Constant dynamic viscosity";
        constant ThermalConductivity lambda_const "Constant thermal conductivity";
        constant Temperature T_min "Minimum temperature valid for medium model";
        constant Temperature T_max "Maximum temperature valid for medium model";
        constant Temperature T0 = reference_T "Zero enthalpy temperature";
        constant FluidConstants[nS] fluidConstants "Fluid constants";

        redeclare record extends ThermodynamicState  "Thermodynamic state of ideal gas" 
          AbsolutePressure p "Absolute pressure of medium";
          Temperature T "Temperature of medium";
        end ThermodynamicState;

        redeclare replaceable model extends BaseProperties  "Base properties of ideal gas" 
        equation
          assert(T >= T_min and T <= T_max, "
          Temperature T (= " + String(T) + " K) is not
          in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K)
          required from medium model \"" + mediumName + "\".
          ");
          h = specificEnthalpy_pTX(p, T, X);
          u = h - R * T;
          R = R_gas;
          d = p / (R * T);
          MM = MM_const;
          state.T = T;
          state.p = p;
          annotation(Documentation(info = "<HTML>
           <p>
           This is the most simple incompressible medium model, where
           specific enthalpy h and specific internal energy u are only
           a function of temperature T and all other provided medium
           quantities are assumed to be constant.
           </p>
           </HTML>")); 
        end BaseProperties;

        redeclare function setState_pTX  "Return thermodynamic state from p, T, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := ThermodynamicState(p = p, T = T);
        end setState_pTX;

        redeclare function extends setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
        algorithm
          state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
        end setSmoothState;

        redeclare function extends pressure  "Return pressure of ideal gas" 
        algorithm
          p := state.p;
        end pressure;

        redeclare function extends temperature  "Return temperature of ideal gas" 
        algorithm
          T := state.T;
        end temperature;

        redeclare function extends density  "Return density of ideal gas" 
        algorithm
          d := state.p / (R_gas * state.T);
        end density;

        redeclare function extends specificEnthalpy  "Return specific enthalpy" 
          extends Modelica.Icons.Function;
        algorithm
          h := cp_const * (state.T - T0);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy  "Return specific internal energy" 
          extends Modelica.Icons.Function;
        algorithm
          u := (cp_const - R_gas) * (state.T - T0);
        end specificInternalEnergy;

        redeclare function extends specificEntropy  "Return specific entropy" 
          extends Modelica.Icons.Function;
        algorithm
          s := cp_const * Modelica.Math.log(state.T / T0) - R_gas * Modelica.Math.log(state.p / reference_p);
        end specificEntropy;

        redeclare function extends specificGibbsEnergy  "Return specific Gibbs energy" 
          extends Modelica.Icons.Function;
        algorithm
          g := cp_const * (state.T - T0) - state.T * specificEntropy(state);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy  "Return specific Helmholtz energy" 
          extends Modelica.Icons.Function;
        algorithm
          f := (cp_const - R_gas) * (state.T - T0) - state.T * specificEntropy(state);
        end specificHelmholtzEnergy;

        redeclare function extends dynamicViscosity  "Return dynamic viscosity" 
        algorithm
          eta := eta_const;
        end dynamicViscosity;

        redeclare function extends thermalConductivity  "Return thermal conductivity" 
        algorithm
          lambda := lambda_const;
        end thermalConductivity;

        redeclare function extends specificHeatCapacityCp  "Return specific heat capacity at constant pressure" 
        algorithm
          cp := cp_const;
        end specificHeatCapacityCp;

        redeclare function extends specificHeatCapacityCv  "Return specific heat capacity at constant volume" 
        algorithm
          cv := cv_const;
        end specificHeatCapacityCv;

        redeclare function extends isentropicExponent  "Return isentropic exponent" 
        algorithm
          gamma := cp_const / cv_const;
        end isentropicExponent;

        redeclare function extends velocityOfSound  "Return velocity of sound" 
        algorithm
          a := sqrt(cp_const / cv_const * R_gas * state.T);
        end velocityOfSound;

        redeclare function specificEnthalpy_pTX  "Return specific enthalpy from p, T, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[nX] X "Mass fractions";
          output SpecificEnthalpy h "Specific enthalpy at p, T, X";
        algorithm
          h := cp_const * (T - T0);
        end specificEnthalpy_pTX;

        redeclare function extends isentropicEnthalpy  "Return isentropic enthalpy" 
        algorithm
          h_is := cp_const * (refState.T * (p_downstream / refState.p) ^ (R_gas / cp_const) - T0);
        end isentropicEnthalpy;

        redeclare function extends isobaricExpansionCoefficient  "Returns overall the isobaric expansion coefficient beta" 
        algorithm
          beta := 1 / state.T;
        end isobaricExpansionCoefficient;

        redeclare function extends isothermalCompressibility  "Returns overall the isothermal compressibility factor" 
        algorithm
          kappa := 1 / state.p;
        end isothermalCompressibility;

        redeclare function extends density_derp_T  "Returns the partial derivative of density with respect to pressure at constant temperature" 
        algorithm
          ddpT := 1 / (R_gas * state.T);
        end density_derp_T;

        redeclare function extends density_derT_p  "Returns the partial derivative of density with respect to temperature at constant pressure" 
        algorithm
          ddTp := -state.p / (R_gas * state.T * state.T);
        end density_derT_p;

        redeclare function extends density_derX  "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature" 
        algorithm
          dddX := fill(0, nX);
        end density_derX;

        redeclare function extends molarMass  "Returns the molar mass of the medium" 
        algorithm
          MM := MM_const;
        end molarMass;
      end PartialSimpleIdealGasMedium;

      package Choices  "Types, constants to define menu choices" 
        extends Modelica.Icons.Package;
        type IndependentVariables = enumeration(T "Temperature", pT "Pressure, Temperature", ph "Pressure, Specific Enthalpy", phX "Pressure, Specific Enthalpy, Mass Fraction", pTX "Pressure, Temperature, Mass Fractions", dTX "Density, Temperature, Mass Fractions") "Enumeration defining the independent variables of a medium";
        annotation(Documentation(info = "<html>
         <p>
         Enumerations and data types for all types of fluids
         </p>

         <p>
         Note: Reference enthalpy might have to be extended with enthalpy of formation.
         </p>
         </html>")); 
      end Choices;

      package Types  "Types to be used in fluid models" 
        extends Modelica.Icons.Package;
        type AbsolutePressure = .Modelica.SIunits.AbsolutePressure(min = 0, max = 100000000.0, nominal = 100000.0, start = 100000.0) "Type for absolute pressure with medium specific attributes";
        type Density = .Modelica.SIunits.Density(min = 0, max = 100000.0, nominal = 1, start = 1) "Type for density with medium specific attributes";
        type DynamicViscosity = .Modelica.SIunits.DynamicViscosity(min = 0, max = 100000000.0, nominal = 0.001, start = 0.001) "Type for dynamic viscosity with medium specific attributes";
        type MassFraction = Real(quantity = "MassFraction", final unit = "kg/kg", min = 0, max = 1, nominal = 0.1) "Type for mass fraction with medium specific attributes";
        type MolarMass = .Modelica.SIunits.MolarMass(min = 0.001, max = 0.25, nominal = 0.032) "Type for molar mass with medium specific attributes";
        type IsentropicExponent = .Modelica.SIunits.RatioOfSpecificHeatCapacities(min = 1, max = 500000, nominal = 1.2, start = 1.2) "Type for isentropic exponent with medium specific attributes";
        type SpecificEnergy = .Modelica.SIunits.SpecificEnergy(min = -100000000.0, max = 100000000.0, nominal = 1000000.0) "Type for specific energy with medium specific attributes";
        type SpecificInternalEnergy = SpecificEnergy "Type for specific internal energy with medium specific attributes";
        type SpecificEnthalpy = .Modelica.SIunits.SpecificEnthalpy(min = -10000000000.0, max = 10000000000.0, nominal = 1000000.0) "Type for specific enthalpy with medium specific attributes";
        type SpecificEntropy = .Modelica.SIunits.SpecificEntropy(min = -10000000.0, max = 10000000.0, nominal = 1000.0) "Type for specific entropy with medium specific attributes";
        type SpecificHeatCapacity = .Modelica.SIunits.SpecificHeatCapacity(min = 0, max = 10000000.0, nominal = 1000.0, start = 1000.0) "Type for specific heat capacity with medium specific attributes";
        type Temperature = .Modelica.SIunits.Temperature(min = 1, max = 10000.0, nominal = 300, start = 300) "Type for temperature with medium specific attributes";
        type ThermalConductivity = .Modelica.SIunits.ThermalConductivity(min = 0, max = 500, nominal = 1, start = 1) "Type for thermal conductivity with medium specific attributes";
        type VelocityOfSound = .Modelica.SIunits.Velocity(min = 0, max = 100000.0, nominal = 1000, start = 1000) "Type for velocity of sound with medium specific attributes";
        type ExtraProperty = Real(min = 0.0, start = 1.0) "Type for unspecified, mass-specific property transported by flow";
        type IsobaricExpansionCoefficient = Real(min = 0, max = 100000000.0, unit = "1/K") "Type for isobaric expansion coefficient with medium specific attributes";
        type DerDensityByPressure = .Modelica.SIunits.DerDensityByPressure "Type for partial derivative of density with respect to pressure with medium specific attributes";
        type DerDensityByTemperature = .Modelica.SIunits.DerDensityByTemperature "Type for partial derivative of density with respect to temperature with medium specific attributes";

        package Basic  "The most basic version of a record used in several degrees of detail" 
          extends Icons.Package;

          record FluidConstants  "Critical, triple, molecular and other standard data of fluid" 
            extends Modelica.Icons.Record;
            String iupacName "Complete IUPAC name (or common name, if non-existent)";
            String casRegistryNumber "Chemical abstracts sequencing number (if it exists)";
            String chemicalFormula "Chemical formula, (brutto, nomenclature according to Hill";
            String structureFormula "Chemical structure formula";
            MolarMass molarMass "Molar mass";
          end FluidConstants;
        end Basic;
      end Types;
      annotation(Documentation(info = "<HTML>
       <p>
       This package provides basic interfaces definitions of media models for different
       kind of media.
       </p>
       </HTML>")); 
    end Interfaces;

    package Common  "Data structures and fundamental functions for fluid properties" 
      extends Modelica.Icons.Package;
      constant Real MINPOS = 1e-009 "Minimal value for physical variables which are always > 0.0";

      function smoothStep  "Approximation of a general step, such that the characteristic is continuous and differentiable" 
        extends Modelica.Icons.Function;
        input Real x "Abscissa value";
        input Real y1 "Ordinate value for x > 0";
        input Real y2 "Ordinate value for x < 0";
        input Real x_small(min = 0) = 1e-005 "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
        output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
      algorithm
        y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if abs(x_small) > 0 then x / x_small * ((x / x_small) ^ 2 - 3) * (y2 - y1) / 4 + (y1 + y2) / 2 else (y1 + y2) / 2);
        annotation(Inline = true, smoothOrder = 1, Documentation(revisions = "<html>
         <ul>
         <li><i>April 29, 2008</i>
             by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
             Designed and implemented.</li>
         <li><i>August 12, 2008</i>
             by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
             Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
         </ul>
         </html>", info = "<html>
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
      annotation(Documentation(info = "<HTML><h4>Package description</h4>
             <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
             High accuracy fluid property models share a lot of common structure, even if the actual models are different.
             Common data structures and computations shared by these property models are collected in this library.
          </p>

       </html>", revisions = "<html>
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

    package Air  "Medium models for air" 
      extends Modelica.Icons.VariantsPackage;

      package SimpleAir  "Air: Simple dry air model (0..100 degC)" 
        extends Modelica.Icons.MaterialProperty;
        extends Interfaces.PartialSimpleIdealGasMedium(mediumName = "SimpleAir", cp_const = 1005.45, MM_const = 0.0289651159, R_gas = .Modelica.Constants.R / 0.0289651159, eta_const = 1.82e-005, lambda_const = 0.026, T_min = .Modelica.SIunits.Conversions.from_degC(0), T_max = .Modelica.SIunits.Conversions.from_degC(100), fluidConstants = airConstants, Temperature(min = Modelica.SIunits.Conversions.from_degC(0), max = Modelica.SIunits.Conversions.from_degC(100)));
        constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[nS] airConstants = {Modelica.Media.Interfaces.Types.Basic.FluidConstants(iupacName = "simple air", casRegistryNumber = "not a real substance", chemicalFormula = "N2, O2", structureFormula = "N2, O2", molarMass = Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)} "Constant data for the fluid";
        annotation(Documentation(info = "<html>
                                     <h4>Simple Ideal gas air model for low temperatures</h4>
                                     <p>This model demonstrates how to use the PartialSimpleIdealGas base class to build a
                                     simple ideal gas model with a limited temperature validity range.</p>
                                     </html>")); 
      end SimpleAir;
      annotation(Documentation(info = "<html>
         <p>This package contains different medium models for air:</p>
       <ul>
       <li><b>SimpleAir</b><br>
           Simple dry air medium in a limited temperature range.</li>
       <li><b>DryAirNasa</b><br>
           Dry air as an ideal gas from Media.IdealGases.MixtureGases.Air.</li>
       <li><b>MoistAir</b><br>
           Moist air as an ideal gas mixture of steam and dry air with fog below and above the triple point temperature.</li>
       </ul>
       </html>")); 
    end Air;

    package IdealGases  "Data and models of ideal gases (single, fixed and dynamic mixtures) from NASA source" 
      extends Modelica.Icons.VariantsPackage;

      package Common  "Common packages and data for the ideal gas models" 
        extends Modelica.Icons.Package;

        record DataRecord  "Coefficient data record for properties of ideal gases based on NASA source" 
          extends Modelica.Icons.Record;
          String name "Name of ideal gas";
          .Modelica.SIunits.MolarMass MM "Molar mass";
          .Modelica.SIunits.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
          .Modelica.SIunits.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
          .Modelica.SIunits.Temperature Tlimit "Temperature limit between low and high data sets";
          Real[7] alow "Low temperature coefficients a";
          Real[2] blow "Low temperature constants b";
          Real[7] ahigh "High temperature coefficients a";
          Real[2] bhigh "High temperature constants b";
          .Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
          annotation(Documentation(info = "<HTML>
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

        package SingleGasesData  "Ideal gas data based on the NASA Glenn coefficients" 
          extends Modelica.Icons.Package;
          constant IdealGases.Common.DataRecord N2(name = "N2", MM = 0.0280134, Hf = 0, H0 = 309498.4543111511, Tlimit = 1000, alow = {22103.71497, -381.846182, 6.08273836, -0.00853091441, 1.384646189e-005, -9.62579362e-009, 2.519705809e-012}, blow = {710.846086, -10.76003744}, ahigh = {587712.406, -2239.249073, 6.06694922, -0.00061396855, 1.491806679e-007, -1.923105485e-011, 1.061954386e-015}, bhigh = {12832.10415, -15.86640027}, R = 296.8033869505308);
          annotation(Documentation(info = "<HTML>
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
        annotation(Documentation(info = "<html>

         </html>")); 
      end Common;
      annotation(Documentation(info = "<HTML>
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
    annotation(preferredView = "info", Documentation(info = "<HTML>
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
     </HTML>", revisions = "<html>
     <ul>
     <li><i>May 16, 2013</i> by Stefan Wischhusen (XRG Simulation):<br/>
         Added new media models Air.ReferenceMoistAir, Air.ReferenceAir, R134a.</li>
     <li><i>May 25, 2011</i> by Francesco Casella:<br/>Added min/max attributes to Water, TableBased, MixtureGasNasa, SimpleAir and MoistAir local types.</li>
     <li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added individual settings for polynomial fittings of properties.</li>
     </ul>
     </html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-76, -80}, {-62, -30}, {-32, 40}, {4, 66}, {48, 66}, {73, 45}, {62, -8}, {48, -50}, {38, -80}}, color = {64, 64, 64}, smooth = Smooth.Bezier), Line(points = {{-40, 20}, {68, 20}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{-40, 20}, {-44, 88}, {-44, 88}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{68, 20}, {86, -58}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{-60, -28}, {56, -28}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{-60, -28}, {-74, 84}, {-74, 84}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{56, -28}, {70, -80}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{-76, -80}, {38, -80}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{-76, -80}, {-94, -16}, {-94, -16}}, color = {175, 175, 175}, smooth = Smooth.None)})); 
  end Media;

  package Thermal  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow" 
    extends Modelica.Icons.Package;

    package HeatTransfer  "Library of 1-dimensional heat transfer with lumped elements" 
      extends Modelica.Icons.Package;

      package Interfaces  "Connectors and partial models" 
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  "Thermal port for 1-dim. heat transfer" 
          Modelica.SIunits.Temperature T "Port temperature";
          flow Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
          annotation(Documentation(info = "<html>

           </html>")); 
        end HeatPort;

        connector HeatPort_a  "Thermal port for 1-dim. heat transfer (filled rectangular icon)" 
          extends HeatPort;
          annotation(defaultComponentName = "port_a", Documentation(info = "<HTML>
           <p>This connector is used for 1-dimensional heat flow between components.
           The variables in the connector are:</p>
           <pre>
              T       Temperature in [Kelvin].
              Q_flow  Heat flow rate in [Watt].
           </pre>
           <p>According to the Modelica sign convention, a <b>positive</b> heat flow
           rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
           convention has to be used whenever this connector is used in a model
           class.</p>
           <p>Note, that the two connector classes <b>HeatPort_a</b> and
           <b>HeatPort_b</b> are identical with the only exception of the different
           <b>icon layout</b>.</p></html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-50, 50}, {50, -50}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-120, 120}, {100, 60}}, lineColor = {191, 0, 0}, textString = "%name")})); 
        end HeatPort_a;

        partial model PartialElementaryConditionalHeatPortWithoutT  "Partial model to include a conditional HeatPort in order to dissipate losses, used for textual modeling, i.e., for elementary models" 
          parameter Boolean useHeatPort = false "=true, if heatPort is enabled" annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow = -lossPower) if useHeatPort "Optional port to which dissipated losses are transported in form of heat" annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
          Modelica.SIunits.Power lossPower "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
          annotation(Documentation(info = "<html>
           <p>
           This partial model provides a conditional heat port for dissipating losses.
           </p>
           <ul>
           <li>If <b>useHeatPort</b> is set to <b>false</b> (default), no heat port is available, and the thermal loss power is dissipated internally.
           <li>If <b>useHeatPort</b> is set to <b>true</b>, the heat port is available and must be connected from the outside.</li>
           </ul>
           <p>
           If this model is used, the loss power has to be provided by an equation in the model which inherits from the PartialElementaryConditionalHeatPortWithoutT model
           (<b>lossPower = ...</b>).
           </p>

           <p>
           Note, this partial model is used in cases, where heatPort.T (that is the device temperature) is not utilized in the model. If this is desired, inherit instead from partial model
           <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">PartialElementaryConditionalHeatPort</a>.
           </p>
           </html>")); 
        end PartialElementaryConditionalHeatPortWithoutT;
        annotation(Documentation(info = "<html>

         </html>")); 
      end Interfaces;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {13.758, 27.517}, lineColor = {128, 128, 128}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-54, -6}, {-61, -7}, {-75, -15}, {-79, -24}, {-80, -34}, {-78, -42}, {-73, -49}, {-64, -51}, {-57, -51}, {-47, -50}, {-41, -43}, {-38, -35}, {-40, -27}, {-40, -20}, {-42, -13}, {-47, -7}, {-54, -5}, {-54, -6}}), Polygon(origin = {13.758, 27.517}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid, points = {{-75, -15}, {-79, -25}, {-80, -34}, {-78, -42}, {-72, -49}, {-64, -51}, {-57, -51}, {-47, -50}, {-57, -47}, {-65, -45}, {-71, -40}, {-74, -33}, {-76, -23}, {-75, -15}, {-75, -15}}), Polygon(origin = {13.758, 27.517}, lineColor = {160, 160, 164}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{39, -6}, {32, -7}, {18, -15}, {14, -24}, {13, -34}, {15, -42}, {20, -49}, {29, -51}, {36, -51}, {46, -50}, {52, -43}, {55, -35}, {53, -27}, {53, -20}, {51, -13}, {46, -7}, {39, -5}, {39, -6}}), Polygon(origin = {13.758, 27.517}, fillColor = {160, 160, 164}, fillPattern = FillPattern.Solid, points = {{18, -15}, {14, -25}, {13, -34}, {15, -42}, {21, -49}, {29, -51}, {36, -51}, {46, -50}, {36, -47}, {28, -45}, {22, -40}, {19, -33}, {17, -23}, {18, -15}, {18, -15}}), Polygon(origin = {13.758, 27.517}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid, points = {{-9, -23}, {-9, -10}, {18, -17}, {-9, -23}}), Line(origin = {13.758, 27.517}, points = {{-41, -17}, {-9, -17}}, color = {191, 0, 0}, thickness = 0.5), Line(origin = {13.758, 27.517}, points = {{-17, -40}, {15, -40}}, color = {191, 0, 0}, thickness = 0.5), Polygon(origin = {13.758, 27.517}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid, points = {{-17, -46}, {-17, -34}, {-40, -40}, {-17, -46}})}), Documentation(info = "<HTML>
       <p>
       This package contains components to model <b>1-dimensional heat transfer</b>
       with lumped elements. This allows especially to model heat transfer in
       machines provided the parameters of the lumped elements, such as
       the heat capacity of a part, can be determined by measurements
       (due to the complex geometries and many materials used in machines,
       calculating the lumped element parameters from some basic analytic
       formulas is usually not possible).
       </p>
       <p>
       Example models how to use this library are given in subpackage <b>Examples</b>.<br>
       For a first simple example, see <b>Examples.TwoMasses</b> where two masses
       with different initial temperatures are getting in contact to each
       other and arriving after some time at a common temperature.<br>
       <b>Examples.ControlledTemperature</b> shows how to hold a temperature
       within desired limits by switching on and off an electric resistor.<br>
       A more realistic example is provided in <b>Examples.Motor</b> where the
       heating of an electrical motor is modelled, see the following screen shot
       of this example:
       </p>

       <p>
       <img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" ALT=\"driveWithHeatTransfer\">
       </p>

       <p>
       The <b>filled</b> and <b>non-filled red squares</b> at the left and
       right side of a component represent <b>thermal ports</b> (connector HeatPort).
       Drawing a line between such squares means that they are thermally connected.
       The variables of a HeatPort connector are the temperature <b>T</b> at the port
       and the heat flow rate <b>Q_flow</b> flowing into the component (if Q_flow is positive,
       the heat flows into the element, otherwise it flows out of the element):
       </p>
       <pre>   Modelica.SIunits.Temperature  T  \"absolute temperature at port in Kelvin\";
          Modelica.SIunits.HeatFlowRate Q_flow  \"flow rate at the port in Watt\";
       </pre>
       <p>
       Note, that all temperatures of this package, including initial conditions,
       are given in Kelvin. For convenience, in subpackages <b>HeatTransfer.Celsius</b>,
        <b>HeatTransfer.Fahrenheit</b> and <b>HeatTransfer.Rankine</b> components are provided such that source and
       sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
       respectively. Additionally, in package <b>SIunits.Conversions</b> conversion
       functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
       provided. These functions may be used in the following way:
       </p>
       <pre>  <b>import</b> SI=Modelica.SIunits;
         <b>import</b> Modelica.SIunits.Conversions.*;
            ...
         <b>parameter</b> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
       </pre>

       <p>
       There are several other components available, such as AxialConduction (discretized PDE in
       axial direction), which have been temporarily removed from this library. The reason is that
       these components reference material properties, such as thermal conductivity, and currently
       the Modelica design group is discussing a general scheme to describe material properties.
       </p>
       <p>
       For technical details in the design of this library, see the following reference:<br>
       <b>Michael Tiller (2001)</b>: <a href=\"http://www.amazon.de\">
       Introduction to Physical Modeling with Modelica</a>.
       Kluwer Academic Publishers Boston.
       </p>
       <p>
       <b>Acknowledgements:</b><br>
       Several helpful remarks from the following persons are acknowledged:
       John Batteh, Ford Motors, Dearborn, U.S.A;
       <a href=\"http://www.haumer.at/\">Anton Haumer</a>, Technical Consulting &amp; Electrical Engineering, Austria;
       Ludwig Marvan, VA TECH ELIN EBG Elektronik GmbH, Wien, Austria;
       Hans Olsson, Dassault Syst&egrave;mes AB, Sweden;
       Hubertus Tummescheit, Lund Institute of Technology, Lund, Sweden.
       </p>
       <dl>
         <dt><b>Main Authors:</b></dt>
         <dd>
         <p>
         <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
         Technical Consulting &amp; Electrical Engineering<br>
         A-3423 St.Andrae-Woerdern, Austria<br>
         email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
       </p>
         </dd>
       </dl>
       <p><b>Copyright &copy; 2001-2013, Modelica Association, Michael Tiller and DLR.</b></p>

       <p>
       <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
       </p>
       </html>", revisions = "<html>
       <ul>
       <li><i>July 15, 2002</i>
              by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
              and Nikolaus Sch&uuml;rmann:<br>
              Implemented.
       </li>
       <li><i>June 13, 2005</i>
              by <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
              Refined placing of connectors (cosmetic).<br>
              Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
              Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
       </li>
         <li> v1.1.1 2007/11/13 Anton Haumer<br>
              components moved to sub-packages</li>
         <li> v1.2.0 2009/08/26 Anton Haumer<br>
              added component ThermalCollector</li>

       </ul>
       </html>")); 
    end HeatTransfer;
    annotation(Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Line(origin = {-47.5, 11.6667}, points = {{-2.5, -91.66670000000001}, {17.5, -71.66670000000001}, {-22.5, -51.6667}, {17.5, -31.6667}, {-22.5, -11.667}, {17.5, 8.333299999999999}, {-2.5, 28.3333}, {-2.5, 48.3333}}, smooth = Smooth.Bezier), Polygon(origin = {-50.0, 68.333}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.0, 21.667}, {-10.0, -8.333}, {10.0, -8.333}}), Line(origin = {2.5, 11.6667}, points = {{-2.5, -91.66670000000001}, {17.5, -71.66670000000001}, {-22.5, -51.6667}, {17.5, -31.6667}, {-22.5, -11.667}, {17.5, 8.333299999999999}, {-2.5, 28.3333}, {-2.5, 48.3333}}, smooth = Smooth.Bezier), Polygon(origin = {0.0, 68.333}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.0, 21.667}, {-10.0, -8.333}, {10.0, -8.333}}), Line(origin = {52.5, 11.6667}, points = {{-2.5, -91.66670000000001}, {17.5, -71.66670000000001}, {-22.5, -51.6667}, {17.5, -31.6667}, {-22.5, -11.667}, {17.5, 8.333299999999999}, {-2.5, 28.3333}, {-2.5, 48.3333}}, smooth = Smooth.Bezier), Polygon(origin = {50.0, 68.333}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{0.0, 21.667}, {-10.0, -8.333}, {10.0, -8.333}})}), Documentation(info = "<html>
     <p>
     This package contains libraries to model heat transfer
     and fluid heat flow.
     </p>
     </html>")); 
  end Thermal;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  "Basic icon for mathematical function with y-axis on left side"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), Polygon(points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 80}, {-88, 80}}, color = {95, 95, 95}), Line(points = {{-80, -80}, {-88, -80}}, color = {95, 95, 95}), Line(points = {{-80, -90}, {-80, 84}}, color = {95, 95, 95}), Text(extent = {{-75, 104}, {-55, 84}}, lineColor = {95, 95, 95}, textString = "y"), Polygon(points = {{-80, 98}, {-86, 82}, {-74, 82}, {-80, 98}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
        <p>
        Icon for a mathematical function, consisting of an y-axis on the left side.
        It is expected, that an x-axis is added and a plot of the function.
        </p>
        </html>")); end AxisLeft;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), Polygon(points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(graphics = {Line(points = {{0, 80}, {-8, 80}}, color = {95, 95, 95}), Line(points = {{0, -80}, {-8, -80}}, color = {95, 95, 95}), Line(points = {{0, -90}, {0, 84}}, color = {95, 95, 95}), Text(extent = {{5, 104}, {25, 84}}, lineColor = {95, 95, 95}, textString = "y"), Polygon(points = {{0, 98}, {-6, 82}, {6, 82}, {0, 98}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
        <p>
        Icon for a mathematical function, consisting of an y-axis in the middle.
        It is expected, that an x-axis is added and a plot of the function.
        </p>
        </html>")); end AxisCenter;
    end Icons;

    package Matrices  "Library of functions operating on matrices" 
      extends Modelica.Icons.Package;

      function solve  "Solve real system of linear equations A*x=b with a b vector (Gaussian elimination with partial pivoting)" 
        extends Modelica.Icons.Function;
        input Real[:, size(A, 1)] A "Matrix A of A*x = b";
        input Real[size(A, 1)] b "Vector b of A*x = b";
        output Real[size(b, 1)] x "Vector x such that A*x = b";
      protected
        Integer info;
      algorithm
        (x, info) := LAPACK.dgesv_vec(A, b);
        assert(info == 0, "Solving a linear system of equations with function
        \"Matrices.solve\" is not possible, because the system has either
        no or infinitely many solutions (A is singular).");
        annotation(Documentation(info = "<HTML>
         <h4>Syntax</h4>
         <blockquote><pre>
         Matrices.<b>solve</b>(A,b);
         </pre></blockquote>
         <h4>Description</h4>
         <p>
         This function call returns the
         solution <b>x</b> of the linear system of equations
         </p>
         <blockquote>
         <p>
         <b>A</b>*<b>x</b> = <b>b</b>
         </p>
         </blockquote>
         <p>
         If a unique solution <b>x</b> does not exist (since <b>A</b> is singular),
         an assertion is triggered. If this is not desired, use instead
         <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
         and inquire the singularity of the solution with the return argument rank
         (a unique solution is computed if rank = size(A,1)).
         </p>

         <p>
         Note, the solution is computed with the LAPACK function \"dgesv\",
         i.e., by Gaussian elimination with partial pivoting.
         </p>
         <h4>Example</h4>
         <blockquote><pre>
           Real A[3,3] = [1,2,3;
                          3,4,5;
                          2,1,4];
           Real b[3] = {10,22,12};
           Real x[3];
         <b>algorithm</b>
           x := Matrices.solve(A,b);  // x = {3,2,1}
         </pre></blockquote>
         <h4>See also</h4>
         <a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
         <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
         <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>.
         </HTML>")); 
      end solve;

      package LAPACK  "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)" 
        extends Modelica.Icons.Package;

        function dgesv_vec  "Solve real system of linear equations A*x=b with a b vector" 
          extends Modelica.Icons.Function;
          input Real[:, size(A, 1)] A;
          input Real[size(A, 1)] b;
          output Real[size(A, 1)] x = b;
          output Integer info;
        protected
          Real[size(A, 1), size(A, 1)] Awork = A;
          Integer lda = max(1, size(A, 1));
          Integer ldb = max(1, size(b, 1));
          Integer[size(A, 1)] ipiv;
          external "FORTRAN 77" dgesv(size(A, 1), 1, Awork, lda, ipiv, x, ldb, info);
          annotation(Documentation(info = "
           Same as function LAPACK.dgesv, but right hand side is a vector and not a matrix.
           For details of the arguments, see documentation of dgesv.
           ")); 
        end dgesv_vec;
        annotation(Documentation(info = "<html>
         <p>
         This package contains external Modelica functions as interface to the
         LAPACK library
         (<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>)
         that provides FORTRAN subroutines to solve linear algebra
         tasks. Usually, these functions are not directly called, but only via
         the much more convenient interface of
         <a href=\"modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a>.
         The documentation of the LAPACK functions is a copy of the original
         FORTRAN code. The details of LAPACK are described in:
         </p>

         <dl>
         <dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
             Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
         <dd> <a href=\"http://www.netlib.org/lapack/lug/lapack_lug.html\">Lapack Users' Guide</a>.
              Third Edition, SIAM, 1999.</dd>
         </dl>

         <p>
         See also <a href=\"http://en.wikipedia.org/wiki/Lapack\">http://en.wikipedia.org/wiki/Lapack</a>.
         </p>

         <p>
         This package contains a direct interface to the LAPACK subroutines
         </p>

         </html>")); 
      end LAPACK;
      annotation(Documentation(info = "<HTML>
       <h4>Library content</h4>
       <p>
       This library provides functions operating on matrices. Below, the
       functions are ordered according to categories and a typical
       call of the respective function is shown.
       Most functions are solely an interface to the external
       <a href=\"modelica://Modelica.Math.Matrices.LAPACK\">LAPACK</a> library.
       </p>

       <p>
       Note: A' is a short hand notation of transpose(A):
       </p>

       <p><b>Basic Information</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.toString\">toString</a>(A)
            - returns the string representation of matrix A.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)
            - returns true if matrices M1 and M2 have the same size and the same elements.</li>
       </ul>

       <p><b>Linear Equations</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.solve\">solve</a>(A,b)
            - returns solution x of the linear equation A*x=b (where b is a vector,
              and A is a square matrix that must be regular).</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.solve2\">solve2</a>(A,B)
            - returns solution X of the linear equation A*X=B (where B is a matrix,
              and A is a square matrix that must be regular)</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">leastSquares</a>(A,b)
            - returns solution x of the linear equation A*x=b in a least squares sense
              (where b is a vector and A may be non-square and may be rank deficient)</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">leastSquares2</a>(A,B)
            - returns solution X of the linear equation A*X=B in a least squares sense
              (where B is a matrix and A may be non-square and may be rank deficient)</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.equalityLeastSquares\">equalityLeastSquares</a>(A,a,B,b)
            - returns solution x of a linear equality constrained least squares problem:
              min|A*x-a|^2 subject to B*x=b</<li>

       <li> (LU,p,info) = <a href=\"modelica://Modelica.Math.Matrices.LU\">LU</a>(A)
            - returns the LU decomposition with row pivoting of a rectangular matrix A.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)
            - returns solution x of the linear equation L*U*x[p]=b with a b
              vector and an LU decomposition from \"LU(..)\".</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)
            - returns solution X of the linear equation L*U*X[p,:]=B with a B
              matrix and an LU decomposition from \"LU(..)\".</li>
       </ul>

       <p><b>Matrix Factorizations</b></p>
       <ul>
       <li> (eval,evec) = <a href=\"modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)
            - returns eigen values \"eval\" and eigen vectors \"evec\" for a real,
              nonsymmetric matrix A in a Real representation.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eval)
            - returns real valued block diagonal matrix of the eigenvalues \"eval\" of matrix A.</li>

       <li> (sigma,U,VT) = <a href=\"modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)
            - returns singular values \"sigma\" and left and right singular vectors U and VT
              of a rectangular matrix A.</li>

       <li> (Q,R,p) = <a href=\"modelica://Modelica.Math.Matrices.QR\">QR</a>(A)
            - returns the QR decomposition with column pivoting of a rectangular matrix A
              such that Q*R = A[:,p].</li>

       <li> (H,U) = <a href=\"modelica://Modelica.Math.Matrices.hessenberg\">hessenberg</a>(A)
            - returns the upper Hessenberg form H and the orthogonal transformation matrix U
              of a square matrix A such that H = U'*A*U.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.realSchur\">realSchur</a>(A)
            - returns the real Schur form of a square matrix A.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.cholesky\">cholesky</a>(A)
            - returns the cholesky factor H of a real symmetric positive definite matrix A so that A = H'*H.</li>

       <li> (D,Aimproved) = <a href=\"modelica://Modelica.Math.Matrices.balance\">balance</a>(A)
            - returns an improved form Aimproved of a square matrix A that has a smaller condition as A,
              with Aimproved = inv(diagonal(D))*A*diagonal(D).</li>
       </ul>

       <p><b>Matrix Properties</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.trace\">trace</a>(A)
            - returns the trace of square matrix A, i.e., the sum of the diagonal elements.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.det\">det</a>(A)
            - returns the determinant of square matrix A (using LU decomposition; try to avoid det(..))</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.inv\">inv</a>(A)
            - returns the inverse of square matrix A (try to avoid, use instead \"solve2(..) with B=identity(..))</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.rank\">rank</a>(A)
            - returns the rank of square matrix A (computed with singular value decomposition)</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">conditionNumber</a>(A)
            - returns the condition number norm(A)*norm(inv(A)) of a square matrix A in the range 1..&infin;.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.rcond\">rcond</a>(A)
            - returns the reciprocal condition number 1/conditionNumber(A) of a square matrix A in the range 0..1.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.norm\">norm</a>(A)
            - returns the 1-, 2-, or infinity-norm of matrix A.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">frobeniusNorm</a>(A)
            - returns the Frobenius norm of matrix A.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.nullSpace\">nullSpace</a>(A)
            - returns the null space of matrix A.</li>
       </ul>

       <p><b>Matrix Exponentials</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.exp\">exp</a>(A)
            - returns the exponential e^A of a matrix A by adaptive Taylor series
              expansion with scaling and balancing</li>

       <li> (phi, gamma) = <a href=\"modelica://Modelica.Math.Matrices.integralExp\">integralExp</a>(A,B)
            - returns the exponential phi=e^A and the integral gamma=integral(exp(A*t)*dt)*B as needed
              for a discretized system with zero order hold.</li>

       <li> (phi, gamma, gamma1) = <a href=\"modelica://Modelica.Math.Matrices.integralExpT\">integralExpT</a>(A,B)
            - returns the exponential phi=e^A, the integral gamma=integral(exp(A*t)*dt)*B,
              and the time-weighted integral gamma1 = integral((T-t)*exp(A*t)*dt)*B as needed
              for a discretized system with first order hold.</li>
       </ul>

       <p><b>Matrix Equations</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">continuousLyapunov</a>(A,C)
            - returns solution X of the continuous-time Lyapunov equation X*A + A'*X = C</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">continuousSylvester</a>(A,B,C)
            - returns solution X of the continuous-time Sylvester equation A*X + X*B = C</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>(A,B,R,Q)
            - returns solution X of the continuous-time algebraic Riccati equation
              A'*X + X*A - X*B*inv(R)*B'*X + Q = 0</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">discreteLyapunov</a>(A,C)
            - returns solution X of the discrete-time Lyapunov equation A'*X*A + sgn*X = C</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">discreteSylvester</a>(A,B,C)
            - returns solution X of the discrete-time Sylvester equation A*X*B + sgn*X = C</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>(A,B,R,Q)
            - returns solution X of the discrete-time algebraic Riccati equation
              A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0</li>
       </ul>

       <p><b>Matrix Manipulation</b></p>
       <ul>
       <li> <a href=\"modelica://Modelica.Math.Matrices.sort\">sort</a>(M)
            - returns the sorted rows or columns of matrix M in ascending or descending order.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">flipLeftRight</a>(M)
            - returns matrix M so that the columns of M are flipped in left/right direction.</li>

       <li> <a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">flipUpDown</a>(M)
            - returns matrix M so that the rows of M are flipped in up/down direction.</li>
       </ul>

       <h4>See also</h4>
       <a href=\"modelica://Modelica.Math.Vectors\">Vectors</a>

       </html>")); 
    end Matrices;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.59999999999999, -67.5}, {-73.59999999999999, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.59999999999999, 67.5}, {80, 80}}, color = {0, 0, 0}), Text(extent = {{-88, 78}, {-16, 30}}, lineColor = {192, 192, 192}, textString = "asin")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-40, -72}, {-15, -88}}, textString = "-pi/2", lineColor = {0, 0, 255}), Text(extent = {{-38, 88}, {-13, 72}}, textString = " pi/2", lineColor = {0, 0, 255}), Text(extent = {{68, -9}, {88, -29}}, textString = "+1", lineColor = {0, 0, 255}), Text(extent = {{-90, 21}, {-70, 1}}, textString = "-1", lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{98, 0}, {82, 6}, {82, -6}, {98, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.59999999999999, -67.5}, {-73.59999999999999, -59.4}, {-66.3, -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 52.7}, {75.2, 62.2}, {77.59999999999999, 67.5}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{82, 24}, {102, 4}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {86, 80}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{80, 86}, {80, -10}}, color = {175, 175, 175}, smooth = Smooth.None)}), Documentation(info = "<html>
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
      external "builtin" y = exp(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, -80.3976}, {68, -80.3976}}, color = {192, 192, 192}), Polygon(points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.90000000000001}, {-6.03, -74}, {10.9, -68.40000000000001}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.09999999999999, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}, color = {0, 0, 0}), Text(extent = {{-86, 50}, {-14, 2}}, lineColor = {192, 192, 192}, textString = "exp")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, -80.3976}, {84, -80.3976}}, color = {95, 95, 95}), Polygon(points = {{98, -80.3976}, {82, -74.3976}, {82, -86.3976}, {98, -80.3976}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-31, -77.90000000000001}, {-6.03, -74}, {10.9, -68.40000000000001}, {23.7, -61}, {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {67.09999999999999, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-31, 72}, {-11, 88}}, textString = "20", lineColor = {0, 0, 255}), Text(extent = {{-92, -81}, {-72, -101}}, textString = "-3", lineColor = {0, 0, 255}), Text(extent = {{66, -81}, {86, -101}}, textString = "3", lineColor = {0, 0, 255}), Text(extent = {{2, -69}, {22, -89}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{78, -54}, {98, -74}}, lineColor = {95, 95, 95}, textString = "u"), Line(points = {{0, 80}, {88, 80}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{80, 84}, {80, -84}}, color = {175, 175, 175}, smooth = Smooth.None)}), Documentation(info = "<html>
       <p>
       This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
       </p>

       <p>
       <img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
       </p>
       </html>")); 
    end exp;

    function log  "Natural (base e) logarithm (u shall be > 0)" 
      extends Modelica.Math.Icons.AxisLeft;
      input Real u;
      output Real y;
      external "builtin" y = log(u);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -80}, {-79.2, -50.6}, {-78.40000000000001, -37}, {-77.59999999999999, -28}, {-76.8, -21.3}, {-75.2, -11.4}, {-72.8, -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, {-47, 38.1}, {-31.8, 48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.09999999999999}, {80, 80}}, color = {0, 0, 0}), Text(extent = {{-6, -24}, {66, -72}}, lineColor = {192, 192, 192}, textString = "log")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {84, 0}}, color = {95, 95, 95}), Polygon(points = {{100, 0}, {84, 6}, {84, -6}, {100, 0}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Line(points = {{-78, -80}, {-77.2, -50.6}, {-76.40000000000001, -37}, {-75.59999999999999, -28}, {-74.8, -21.3}, {-73.2, -11.4}, {-70.8, -1.31}, {-67.5, 8.08}, {-62.7, 17.9}, {-55.5, 28}, {-45, 38.1}, {-29.8, 48.1}, {-8.1, 58}, {24.1, 68}, {70.7, 78.09999999999999}, {82, 80}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-105, 72}, {-85, 88}}, textString = "3", lineColor = {0, 0, 255}), Text(extent = {{60, -3}, {80, -23}}, textString = "20", lineColor = {0, 0, 255}), Text(extent = {{-78, -7}, {-58, -27}}, textString = "1", lineColor = {0, 0, 255}), Text(extent = {{84, 26}, {104, 6}}, lineColor = {95, 95, 95}, textString = "u"), Text(extent = {{-100, 9}, {-80, -11}}, textString = "0", lineColor = {0, 0, 255}), Line(points = {{-80, 80}, {84, 80}}, color = {175, 175, 175}, smooth = Smooth.None), Line(points = {{82, 82}, {82, -6}}, color = {175, 175, 175}, smooth = Smooth.None)}), Documentation(info = "<html>
       <p>
       This function returns y = log(10) (the natural logarithm of u),
       with u &gt; 0:
       </p>

       <p>
       <img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
       </p>
       </html>")); 
    end log;

    function tempInterpol1  "Temporary function for linear interpolation (will be removed)" 
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;
      input Real u "input value (first column of table)";
      input Real[:, :] table "table to be interpolated";
      input Integer icol "column of table to be interpolated";
      output Real y "interpolated input value (icol column of table)";
    protected
      Integer i;
      Integer n "number of rows of table";
      Real u1;
      Real u2;
      Real y1;
      Real y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        y := table[1, icol];
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := table[i, icol];
        y2 := table[i + 1, icol];
        assert(u2 > u1, "Table index must be increasing");
        y := y1 + (y2 - y1) * (u - u1) / (u2 - u1);
      end if;
      annotation(Documentation(info = "<html>

       </html>"), derivative(zeroDerivative = table, zeroDerivative = icol) = tempInterpol1_der); 
    end tempInterpol1;

    function tempInterpol1_der  "Temporary function for linear interpolation (will be removed)" 
      input Real u "input value (first column of table)";
      input Real[:, :] table "table to be interpolated";
      input Integer icol "column of table to be interpolated";
      input Real du;
      output Real dy "interpolated input value (icol column of table)";
    protected
      Integer i;
      Integer n "number of rows of table";
      Real u1;
      Real u2;
      Real y1;
      Real y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        dy := 0;
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := table[i, icol];
        y2 := table[i + 1, icol];
        assert(u2 > u1, "Table index must be increasing");
        dy := (y2 - y1) / (u2 - u1);
      end if;
      annotation(Documentation(info = "<html>

       </html>")); 
    end tempInterpol1_der;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.40000000000001}, {-49.4, 74.59999999999999}, {-43.8, 79.09999999999999}, {-38.2, 79.8}, {-32.6, 76.59999999999999}, {-26.9, 69.7}, {-21.3, 59.4}, {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, -64.2}, {29.3, -73.09999999999999}, {35, -78.40000000000001}, {40.6, -80}, {46.2, -77.59999999999999}, {51.9, -71.5}, {57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, color = {0, 0, 0}, smooth = Smooth.Bezier)}), Documentation(info = "<HTML>
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
     </html>", revisions = "<html>
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

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real inf = ModelicaServices.Machine.inf "Biggest Real number such that inf and -inf are representable on the machine";
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real R(final unit = "J/(mol.K)") = 8.314472 "Molar gas constant";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1e-007 "Magnetic constant";
    final constant .Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_zero = -273.15 "Absolute zero temperature";
    annotation(Documentation(info = "<html>
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
     </html>", revisions = "<html>
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
     </html>"), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-9.2597, 25.6673}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{48.017, 11.336}, {48.017, 11.336}, {10.766, 11.336}, {-25.684, 10.95}, {-34.944, -15.111}, {-34.944, -15.111}, {-32.298, -15.244}, {-32.298, -15.244}, {-22.112, 0.168}, {11.292, 0.234}, {48.267, -0.097}, {48.267, -0.097}}, smooth = Smooth.Bezier), Polygon(origin = {-19.9923, -8.3993}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{3.239, 37.343}, {3.305, 37.343}, {-0.399, 2.683}, {-16.936, -20.071}, {-7.808, -28.604}, {6.811, -22.519}, {9.986000000000001, 37.145}, {9.986000000000001, 37.145}}, smooth = Smooth.Bezier), Polygon(origin = {23.753, -11.5422}, fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.873, 41.478}, {-10.873, 41.478}, {-14.048, -4.162}, {-9.352, -24.8}, {7.912, -24.469}, {16.247, 0.27}, {16.247, 0.27}, {13.336, 0.07099999999999999}, {13.336, 0.07099999999999999}, {7.515, -9.983000000000001}, {-3.134, -7.271}, {-2.671, 41.214}, {-2.671, 41.214}}, smooth = Smooth.Bezier)})); 
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, fillPattern = FillPattern.None, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
      <p>Standard package icon.</p>
      </html>")); end Package;

    partial package VariantsPackage  "Icon for package containing variants" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(origin = {10.0, 10.0}, fillColor = {76, 76, 76}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-80.0, -80.0}, {-20.0, -20.0}}), Ellipse(origin = {10.0, 10.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{0.0, -80.0}, {60.0, -20.0}}), Ellipse(origin = {10.0, 10.0}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{0.0, 0.0}, {60.0, 60.0}}), Ellipse(origin = {10.0, 10.0}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, 0.0}, {-20.0, 60.0}})}), Documentation(info = "<html>
       <p>This icon shall be used for a package/library that contains several variants of one components.</p>
       </html>")); 
    end VariantsPackage;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {20.0, 0.0}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-10.0, 70.0}, {10.0, 70.0}, {40.0, 20.0}, {80.0, 20.0}, {80.0, -20.0}, {40.0, -20.0}, {10.0, -70.0}, {-10.0, -70.0}}), Polygon(fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-100.0, 20.0}, {-60.0, 20.0}, {-30.0, 70.0}, {-10.0, 70.0}, {-10.0, -70.0}, {-30.0, -70.0}, {-60.0, -20.0}, {-100.0, -20.0}})}), Documentation(info = "<html>
       <p>This icon indicates packages containing interfaces.</p>
       </html>")); 
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {23.3333, 0.0}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-23.333, 30.0}, {46.667, 0.0}, {-23.333, -30.0}}), Rectangle(fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-70, -4.5}, {0, 4.5}})}), Documentation(info = "<html>
       <p>This icon indicates a package which contains sources.</p>
       </html>")); 
    end SourcesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})})); 
    end IconsPackage;

    partial package MaterialPropertiesPackage  "Icon for package containing property classes" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(lineColor = {102, 102, 102}, fillColor = {204, 204, 204}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Documentation(info = "<html>
       <p>This icon indicates a package that contains properties</p>
       </html>")); 
    end MaterialPropertiesPackage;

    partial class MaterialProperty  "Icon for property classes"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(lineColor = {102, 102, 102}, fillColor = {204, 204, 204}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-100.0, -100.0}, {100.0, 100.0}})}), Documentation(info = "<html>
      <p>This icon indicates a property class.</p>
      </html>")); end MaterialProperty;

    partial function Function  "Icon for functions"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 105}, {150, 145}}, textString = "%name"), Ellipse(lineColor = {108, 88, 49}, fillColor = {255, 215, 136}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(lineColor = {108, 88, 49}, extent = {{-90.0, -90.0}, {90.0, 90.0}}, textString = "f")}), Documentation(info = "<html>
      <p>This icon indicates Modelica functions.</p>
      </html>")); end Function;

    partial record Record  "Icon for records"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 60}, {150, 100}}, textString = "%name"), Rectangle(origin = {0.0, -25.0}, lineColor = {64, 64, 64}, fillColor = {255, 215, 136}, fillPattern = FillPattern.Solid, extent = {{-100.0, -75.0}, {100.0, 75.0}}, radius = 25.0), Line(points = {{-100.0, 0.0}, {100.0, 0.0}}, color = {64, 64, 64}), Line(origin = {0.0, -50.0}, points = {{-100.0, 0.0}, {100.0, 0.0}}, color = {64, 64, 64}), Line(origin = {0.0, -25.0}, points = {{0.0, 75.0}, {0.0, -75.0}}, color = {64, 64, 64})}), Documentation(info = "<html>
      <p>
      This icon is indicates a record.
      </p>
      </html>")); end Record;

    partial class ObsoleteModel  "Icon for classes that are obsolete and will be removed in later versions"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-102, 102}, {102, -102}}, lineColor = {255, 0, 0}, pattern = LinePattern.Dash, lineThickness = 0.5)}), Documentation(info = "<html>
      <p>
      This partial class is intended to provide a <u>default icon
      for an obsolete model</u> that will be removed from the
      corresponding library in a future release.
      </p>
      </html>")); end ObsoleteModel;
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

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for SIunits" 
      extends Modelica.Icons.IconsPackage;

      partial function Conversion  "Base icon for conversion functions"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {30, 0}}, color = {191, 0, 0}), Polygon(points = {{90, 0}, {30, 20}, {30, -20}, {90, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-115, 155}, {115, 105}}, textString = "%name", lineColor = {0, 0, 255})})); end Conversion;
    end Icons;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units" 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
        type AngularVelocity_rpm = Real(final quantity = "AngularVelocity", final unit = "1/min") "Angular velocity in revolutions per minute. Alias unit names that are outside of the SI system: rpm, r/min, rev/min";
        type Pressure_bar = Real(final quantity = "Pressure", final unit = "bar") "Absolute pressure in bar";
        annotation(Documentation(info = "<HTML>
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

      function to_degC  "Convert from Kelvin to degCelsius" 
        extends Modelica.SIunits.Icons.Conversion;
        input Temperature Kelvin "Kelvin value";
        output NonSIunits.Temperature_degC Celsius "Celsius value";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-20, 100}, {-100, 20}}, lineColor = {0, 0, 0}, textString = "K"), Text(extent = {{100, -20}, {20, -100}}, lineColor = {0, 0, 0}, textString = "degC")})); 
      end to_degC;

      function from_degC  "Convert from degCelsius to Kelvin" 
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-20, 100}, {-100, 20}}, lineColor = {0, 0, 0}, textString = "degC"), Text(extent = {{100, -20}, {20, -100}}, lineColor = {0, 0, 0}, textString = "K")})); 
      end from_degC;

      function to_rpm  "Convert from radian per second to revolutions per minute" 
        extends Modelica.SIunits.Icons.Conversion;
        input AngularVelocity rs "radian per second value";
        output NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
      algorithm
        rpm := 30 / Modelica.Constants.pi * rs;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{30, 100}, {-100, 50}}, lineColor = {0, 0, 0}, textString = "rad/s"), Text(extent = {{100, -52}, {-40, -98}}, lineColor = {0, 0, 0}, textString = "1/min")})); 
      end to_rpm;

      function from_rpm  "Convert from revolutions per minute to radian per second" 
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.AngularVelocity_rpm rpm "revolutions per minute value";
        output AngularVelocity rs "radian per second value";
      algorithm
        rs := Modelica.Constants.pi / 30 * rpm;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{14, 100}, {-102, 56}}, lineColor = {0, 0, 0}, textString = "1/min"), Text(extent = {{100, -56}, {-32, -102}}, lineColor = {0, 0, 0}, textString = "rad/s")})); 
      end from_rpm;

      function to_bar  "Convert from Pascal to bar" 
        extends Modelica.SIunits.Icons.Conversion;
        input Pressure Pa "Pascal value";
        output NonSIunits.Pressure_bar bar "bar value";
      algorithm
        bar := Pa / 100000.0;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-12, 100}, {-100, 56}}, lineColor = {0, 0, 0}, textString = "Pa"), Text(extent = {{98, -52}, {-4, -100}}, lineColor = {0, 0, 0}, textString = "bar")})); 
      end to_bar;
      annotation(Documentation(info = "<HTML>
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
    type Length = Real(final quantity = "Length", final unit = "m");
    type Height = Length(min = 0);
    type Area = Real(final quantity = "Area", final unit = "m2");
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Inertia = MomentOfInertia;
    type Force = Real(final quantity = "Force", final unit = "N");
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 100000.0);
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
    type Energy = Real(final quantity = "Energy", final unit = "J");
    type Power = Real(final quantity = "Power", final unit = "W");
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type VolumeFlowRate = Real(final quantity = "VolumeFlowRate", final unit = "m3/s");
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
    type Temperature = ThermodynamicTemperature;
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)");
    type RatioOfSpecificHeatCapacities = Real(final quantity = "RatioOfSpecificHeatCapacities", final unit = "1");
    type Entropy = Real(final quantity = "Entropy", final unit = "J/K");
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", final unit = "J/(kg.K)");
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", final unit = "J/kg");
    type SpecificEnthalpy = SpecificEnergy;
    type DerDensityByPressure = Real(final unit = "s2/m2");
    type DerDensityByTemperature = Real(final unit = "kg/(m3.K)");
    type AmountOfSubstance = Real(final quantity = "AmountOfSubstance", final unit = "mol", min = 0);
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0);
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1);
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", min = 0, max = 1);
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-66, 78}, {-66, -40}}, color = {64, 64, 64}, smooth = Smooth.None), Ellipse(extent = {{12, 36}, {68, -38}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-74, 78}, {-66, -40}}, lineColor = {64, 64, 64}, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-66, -4}, {-66, 6}, {-16, 56}, {-16, 46}, {-66, -4}}, lineColor = {64, 64, 64}, smooth = Smooth.None, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, 16}, {-40, 22}, {-2, -40}, {-10, -40}, {-46, 16}}, lineColor = {64, 64, 64}, smooth = Smooth.None, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid), Ellipse(extent = {{22, 26}, {58, -28}}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{68, 2}, {68, -46}, {64, -60}, {58, -68}, {48, -72}, {18, -72}, {18, -64}, {46, -64}, {54, -60}, {58, -54}, {60, -46}, {60, -26}, {64, -20}, {68, -6}, {68, 2}}, lineColor = {64, 64, 64}, smooth = Smooth.Bezier, fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
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
     </html>", revisions = "<html>
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
  annotation(preferredView = "info", version = "3.2.1", versionBuild = 3, versionDate = "2013-08-14", dateModified = "2013-08-23 19:30:00Z", revisionId = "$Id:: package.mo 6954 2013-08-23 17:46:49Z #$", uses(Complex(version = "3.2.1"), ModelicaServices(version = "3.2.1")), conversion(noneFromVersion = "3.2", noneFromVersion = "3.1", noneFromVersion = "3.0.1", noneFromVersion = "3.0", from(version = "2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-6.9888, 20.048}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-93.0112, 10.3188}, {-93.0112, 10.3188}, {-73.011, 24.6}, {-63.011, 31.221}, {-51.219, 36.777}, {-39.842, 38.629}, {-31.376, 36.248}, {-25.819, 29.369}, {-24.232, 22.49}, {-23.703, 17.463}, {-15.501, 25.135}, {-6.24, 32.015}, {3.02, 36.777}, {15.191, 39.423}, {27.097, 37.306}, {32.653, 29.633}, {35.035, 20.108}, {43.501, 28.046}, {54.085, 35.19}, {65.991, 39.952}, {77.89700000000001, 39.688}, {87.422, 33.338}, {91.126, 21.696}, {90.068, 9.525}, {86.099, -1.058}, {79.749, -10.054}, {71.283, -21.431}, {62.816, -33.337}, {60.964, -32.808}, {70.489, -16.14}, {77.36799999999999, -2.381}, {81.072, 10.054}, {79.749, 19.05}, {72.605, 24.342}, {61.758, 23.019}, {49.587, 14.817}, {39.003, 4.763}, {29.214, -6.085}, {21.012, -16.669}, {13.339, -26.458}, {5.401, -36.777}, {-1.213, -46.037}, {-6.24, -53.446}, {-8.092000000000001, -52.387}, {-0.6840000000000001, -40.746}, {5.401, -30.692}, {12.81, -17.198}, {19.424, -3.969}, {23.658, 7.938}, {22.335, 18.785}, {16.514, 23.283}, {8.047000000000001, 23.019}, {-1.478, 19.05}, {-11.267, 11.113}, {-19.734, 2.381}, {-29.259, -8.202}, {-38.519, -19.579}, {-48.044, -31.221}, {-56.511, -43.392}, {-64.449, -55.298}, {-72.386, -66.93899999999999}, {-77.678, -74.61199999999999}, {-79.53, -74.083}, {-71.857, -61.383}, {-62.861, -46.037}, {-52.278, -28.046}, {-44.869, -15.346}, {-38.784, -2.117}, {-35.344, 8.731}, {-36.403, 19.844}, {-42.488, 23.813}, {-52.013, 22.49}, {-60.744, 16.933}, {-68.947, 10.054}, {-76.884, 2.646}, {-93.0112, -12.1707}, {-93.0112, -12.1707}}, smooth = Smooth.Bezier), Ellipse(origin = {40.8208, -37.7602}, fillColor = {161, 0, 4}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-17.8562, -17.8563}, {17.8563, 17.8562}})}), Documentation(info = "<HTML>
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
