package DEMOsimple
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  constant Real pi = Modelica.Constants.pi;

  package Icons
    extends Modelica.Icons.IconsPackage;

  partial model HeatFlow

    annotation (Icon(graphics={Rectangle(
            extent={{-80,20},{80,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward)}));
  end HeatFlow;

  partial model Tube

    annotation (Icon(graphics={Rectangle(
            extent={{-80,40},{80,-40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,0,255})}),                        Diagram(graphics));
  end Tube;

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
            textString="P")}));
  end SourceP;
  end Icons;

  package Media
    extends Modelica.Icons.MaterialPropertiesPackage;

    record HeliumProperties
      extends Modelica.Icons.Record;

      Types.Temperature Tnom = 300 + 273.15 "Nominal temperature";
      SI.Density rhonom = 6.61 "Nominal density";
      Real drho_dT = -8.4e-3 "Derivative of density w.r.t. temperature";
      SI.SpecificHeatCapacityAtConstantPressure cp = 5190 "Constant cp";
      SI.SpecificHeatCapacityAtConstantVolume cv = cp - Rstar "Constant cv";
      constant SI.MolarMass MM = Modelica.Media.IdealGases.Common.SingleGasesData.He.MM;
      constant SI.SpecificHeatCapacity Rstar = Modelica.Constants.R/MM;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HeliumProperties;
  end Media;

  package Types
    extends Modelica.Icons.TypesPackage;

    type MassFlowRate = SI.MassFlowRate;

    type Pressure = SI.Pressure(nominal = 100e5);

    type SpecificEnthalpy = SI.SpecificEnthalpy;

    type Temperature = SI.Temperature(start = 600);
  end Types;

  package Interfaces
    extends Modelica.Icons.InterfacesPackage;

    connector Flange "Flange connector for water/steam flows"
      flow Types.MassFlowRate m_flow
        "Mass flow rate from the connection point into the component";
      Types.Pressure p "Thermodynamic pressure in the connection point";
      stream Types.SpecificEnthalpy h_outflow
        "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
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
      extends Flange;
      annotation (Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}));
    end FlangeA;

    connector FlangeB "B-type flange connector for water/steam flows"
      extends Flange;
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

    connector DHT "Distributed Heat Terminal"
      parameter Integer N(min=1) = 1 "Number of volumes";
      SI.Temperature T[N] "Temperatures";
      flow SI.Power Q[N] "Heat flows";
      annotation (Icon(coordinateSystem(
              preserveAspectRatio = false,
     extent={{-80,-20},{80,20}}),
              graphics={Rectangle(
                extent={{-80,20},{80,-20}},
                lineColor={255,127,0},
                fillColor={255,127,0},
                fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(extent={{-80,-20},{80,20}})));
    end DHT;
  end Interfaces;

  package Models
    extends Modelica.Icons.Package;

    model HeliumSourcePressure "Helium pressure source"
      extends Icons.SourceP;
      parameter Boolean pressurizer = false "Use as pressurizer"
        annotation(choices(checkBox=true));
      parameter Types.Pressure p "Fixed pressure";
      parameter Types.Temperature T = prop.Tnom "Fixed temperature"
       annotation(Dialog(enable = not pressurizer));
      final constant Media.HeliumProperties prop;
      final parameter Types.SpecificEnthalpy h_out = prop.cp*(T - prop.Tnom);

      Interfaces.FlangeA flange(m_flow(min = if pressurizer then 0 else -Modelica.Constants.inf))
        annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
    equation
      flange.p = p;
      flange.h_outflow = h_out;

      annotation (
        Diagram(graphics),
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
    end HeliumSourcePressure;

    model HeliumPipe
      extends Icons.Tube;
      parameter Integer N(min=2) = 2 "Number of volumes";
      parameter SI.Length L "Length";
      final parameter SI.Length l = L/N "Lenght of single volume";
      parameter SI.Area A "Cross section";
      parameter SI.Length omega = sqrt(4*pi*A) "Wet perimeter";
      parameter SI.CoefficientOfHeatTransfer lambda
        "Nominal heat transfer coefficient";
      parameter Types.Pressure dpnom "Nominal pressure drop";
      parameter Types.MassFlowRate wnom "Nominal mass flow rate";
      parameter SI.HeatCapacity Cm "Heat capacity of metal";
      final constant Media.HeliumProperties prop;

      Interfaces.FlangeA inlet annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}}), iconTransformation(extent={{-120,-20},{-80,20}})));
      Interfaces.FlangeB outlet annotation (Placement(transformation(extent={{90,-10},
                {110,10}}), iconTransformation(extent={{80,-20},{120,20}})));
      Interfaces.DHT thermalPort(final N = N) annotation (Placement(transformation(extent={{-10,30},
                {10,50}}),
            iconTransformation(extent={{-40,40},{40,60}})));

      SI.MassFlowRate w "Mass flow rate";
      SI.Pressure dp "Pressure drop";
      SI.Temperature T[N+1](each start = prop.Tnom)
        "Temperatures at the volume boundaries";
      SI.Temperature Tm[N] "Temperature of the metal volumes";
                          //(each start = prop.Tnom, each fixed = true)
      SI.Density rho[N] "Density of each volume" annotation (HideResult=true);
      SI.Temperature Ttilde[N](each start = prop.Tnom)
        "Temperature state variables" annotation (HideResult=true);
                                                       //, each fixed = true
      Types.SpecificEnthalpy h[N+1]
        "Specific enthalpy at the volume boundaries" annotation (HideResult=true);
      Types.SpecificEnthalpy hin "Inlet specific enthalpy" annotation (HideResult=true);
      Types.SpecificEnthalpy hout "Outlet specific enthalpy" annotation (HideResult=true);
      SI.Power Q[N] "Heat flows entering the metal volumes" annotation (HideResult=true);
      SI.Power Qmf[N] "Heat flows from metal to fluid volumes" annotation (HideResult=true);
      SI.Power Qg = 0 "Heat flow generated by neutron flux" annotation (HideResult=true);

    initial algorithm
      if Cm > 0 then
        for i in 1:N loop
          Tm[i] := prop.Tnom;
        end for;
      end if;

    equation
      for i in 1:N loop
        w*(h[i+1]-h[i]) = Qmf[i] "Fluid energy balance";
        if Cm <= 0 then
          0 = Q[i] - Qmf[i] + Qg/N;
        else
          Cm/N * der(Tm[i]) = Q[i] - Qmf[i] + Qg/N "Wall energy balance";
        end if;
        rho[i] = prop.rhonom + prop.drho_dT*(Ttilde[i] - prop.Tnom);
        Qmf[i] = (Tm[i] - 0.5*(T[i]+T[i+1]))*omega*l*lambda;
      end for;
      for i in 1:N+1 loop
        h[i] = prop.cp*(T[i] - prop.Tnom);
      end for;
      dp = dpnom/wnom*w;
      Ttilde = T[2:N+1];
      hin =  h[1];
      hout = h[N+1];
      // Boundary conditions
      inlet.m_flow = w;
      outlet.m_flow = -w;
      inlet.p - outlet.p = dp;
      inStream(inlet.h_outflow) = hin;
      inlet.h_outflow = 0; //Dummy, not used
      outlet.h_outflow = hout;
      Q = thermalPort.Q;
      Tm = thermalPort.T;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
                points={{-34,0},{26,0},{6,10},{6,-10},{26,0},{26,0}}, color={255,0,0})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end HeliumPipe;

    model ThermalConduction
      extends Icons.HeatFlow;
      parameter Integer N = 1 "Number of volumes";
      parameter SI.ThermalConductance G "Total thermal conductance";
      parameter Boolean counterCurrent = true
        "Counter-current exchange geometry";
      Interfaces.DHT side1(final N=N) annotation (Placement(transformation(extent={{-40,
                20},{40,40}}, rotation=0), iconTransformation(extent={{-40,20},
                {40,40}})));
      Interfaces.DHT side2(final N=N) annotation (Placement(transformation(extent={{-42,-18},
                {38,-40}},      rotation=0), iconTransformation(extent={{-40,-20},
                {40,-40}})));
    equation
      if counterCurrent then
        side1.Q = G/N*(side1.T - side2.T[end:-1:1]) "Convective heat transfer";
        side1.Q + side2.Q[end:-1:1] = zeros(N) "Energy balance";
      else
        side1.Q = G/N*(side1.T - side2.T) "Convective heat transfer";
        side1.Q + side2.Q = zeros(N) "Energy balance";
      end if;
      annotation (                   Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two lumped parameter objects, with a constant heat transfer coefficient.
</HTML>",   revisions="<html>
<li><i>28 Dic 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
    end ThermalConduction;

    model HeliumCP
      parameter Integer Nch = 10 "Number of channels per CP";
      parameter Integer Nv = 4 "Numer of volumes for each pipe";
      parameter Types.Pressure dpnom "Nominal total pressure loss";
      parameter Types.MassFlowRate wnom[Nch]
        "Nominal flow rates for each channel";
      parameter SI.CoefficientOfHeatTransfer lambda "Heat transfer coefficient";
      parameter SI.Length L[Nch] "Channel length";
      parameter SI.ThermalConductance G[2*Nch-1] "Conductances of channels";
      parameter SI.Area A[Nch] "Cross-section of channels";
      parameter SI.HeatCapacity Cm[Nch] "Wall heat capacity of channels";

      Interfaces.FlangeA inletA annotation (Placement(transformation(extent={{-110,50},
                {-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
      Interfaces.FlangeB outletB annotation (Placement(transformation(extent={{-110,
                -70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
      Interfaces.FlangeB outletA annotation (Placement(transformation(extent={{90,50},
                {110,70}}), iconTransformation(extent={{90,50},{110,70}})));
      Interfaces.FlangeA inletB annotation (Placement(transformation(extent={{90,-70},
                {110,-50}}), iconTransformation(extent={{90,-70},{110,-50}})));

      Models.HeliumPipe chA[Nch](
        each N = Nv,
        each dpnom = dpnom,
        wnom = wnom,
        each lambda = lambda,
        L = L,
        A = A,
        Cm = Cm);
      Models.HeliumPipe chB[Nch](
        each N = Nv,
        each dpnom = dpnom,
        wnom = wnom,
        each lambda = lambda,
        L = L,
        A = A,
        Cm = Cm);
      Models.ThermalConduction TC[2*Nch - 1](
        each N = Nv,
        G = G);

    equation
      for i in 1:Nch loop
        connect(inletA, chA[i].inlet);
        connect(chA[i].outlet, outletA);

        connect(inletB, chB[i].inlet);
        connect(chB[i].outlet, outletB);

        connect(chA[i].thermalPort, TC[2*i-1].side1);
        connect(chB[i].thermalPort, TC[2*i-1].side2);
      end for;
      for i in 1:Nch-1 loop
        connect(chB[i].thermalPort,   TC[2*i].side1);
        connect(chA[i+1].thermalPort, TC[2*i].side2);
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}), Text(
              extent={{-60,60},{60,-60}},
              lineColor={151,147,156},
              textString="He")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end HeliumCP;
  end Models;

  package Test
    extends Modelica.Icons.ExamplesPackage;

    package Helium
      extends Modelica.Icons.Package;

      model TestCP

        Real step = (if time < 0 then 0 else 1);
        Models.HeliumSourcePressure sink1(p=8000000)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=-90,
              origin={0,-40})));
        Models.HeliumSourcePressure sink2(p=8100000)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={0,40})));
        Models.HeliumCP heliumCP(
          Nch=2,
          wnom={1,0.5},
          lambda=1000,
          L={1,1},
          G={1,1,1},
          A={0.01,0.01},
          Cm={1,1},
        dpnom=100000,
        each chA(Qg=step*{5e3,8e3}),
        each chB(Qg=step*{8e3,5e3}))   annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(sink2.flange, heliumCP.inletA) annotation (Line(points={{0,30},{0,30},
                {0,20},{-20,20},{-20,6},{-10,6}}, color={0,0,255}));
        connect(sink2.flange, heliumCP.inletB) annotation (Line(points={{0,30},{0,20},
                {20,20},{20,-6},{10,-6}}, color={0,0,255}));
        connect(sink1.flange, heliumCP.outletB) annotation (Line(points={{0,-30},{0,-20},
                {-20,-20},{-20,-6},{-10,-6}}, color={0,0,255}));
        connect(sink1.flange, heliumCP.outletA) annotation (Line(points={{1.77636e-015,
                -30},{1.77636e-015,-20},{20,-20},{20,6},{10,6}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end TestCP;
    end Helium;
  end Test;
  annotation (uses(Modelica(version="3.2.2")));
end DEMOsimple;
