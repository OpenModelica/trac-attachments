within ;
package DO1
  model DOminEnergy "Minimize mechanical energy in a simple path"
    parameter Real m=1000 "1000 kg of vehicle mass";
    parameter Real p=1 "needed for final constraints";
    parameter Real fGrip=0.02;
    parameter Real S=2 "superficie frontale in m^2";
    parameter Real Cx=0.4;
    constant Real rho=1.226 "densità aria kg/m^3";
    constant Real g=9.81;
    Real a(
      min=-1,
      max=1,
      nominal=0) annotation (isConstraint=true);
    Real v(start=0);
    Real pos(start=0);
    Real pow=f*v "Mechanical power";
    Real fResis "Motion resistance";
    Real Energy "Energy to minimize";
    input Real f(min=-1e9, max=1e9);
    Real constEn(nominal=1) = Energy "minimize Energy(tf)"
      annotation (isMayer=true);
    Real constSpeed(
      min=0,
      max=0) = p*v " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
    Real constSpace(
      min=1000,
      max=1000) = p*pos " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
  equation
    der(Energy) = pow;
    der(pos) = v;
    der(v) = a;
    fResis = fGrip*m*g + 0.5*Cx*rho*S*v^2;
    f - fResis = m*a;
    annotation (Documentation(info="<html>
<p>train movement optimization.</p>
</html>"), experiment(
        StartTime=0,
        StopTime=100,
        Tolerance=1e-08,
        Interval=0.333333));
  end DOminEnergy;

  model EVbasic
    "Simulates an Electric Vehcile based on BASMADrive electric drive model"
    import Modelica;
    parameter Real m=1000 "1000 kg of vehicle mass";
    parameter Real fGrip=0.02;
    parameter Real S=2 "superficie frontale in m^2";
    parameter Real Cx=0.4;
    constant Real rho=1.226 "densit�  aria kg/m^3";
    constant Real g=9.81;
    Real energy;
    parameter Modelica.SIunits.Mass vMass=1000 "Vehicle mass";
    Modelica.Mechanics.Translational.Sources.Force force2 annotation (Placement(
          visible=true, transformation(
          origin={96,10},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=11.5,
      rising=11.5,
      falling=11.5,
      period=10000,
      width=77) annotation (Placement(visible=true, transformation(
          origin={-108,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=-(fGrip*m*g + 0.5*
          rho*Cx*S*mass.v^2)) annotation (Placement(visible=true,
          transformation(
          origin={38,46},
          extent={{-20,-12},{20,12}},
          rotation=0)));
    Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(visible=true,
          transformation(
          origin={-82,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Math.Gain gain1(k=1e4) annotation (Placement(visible=true,
          transformation(
          origin={-54,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Mechanics.Translational.Sources.Force force1 annotation (Placement(
          visible=true, transformation(
          origin={-22,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation (
        Placement(visible=true, transformation(
          origin={6,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Mechanics.Translational.Components.Mass mass(m=vMass) annotation (
        Placement(visible=true, transformation(extent={{24,0},{44,20}},
            rotation=0)));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
        Placement(visible=true, transformation(
          origin={50,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP2 annotation (
        Placement(visible=true, transformation(
          origin={70,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  equation
    connect(mP2.flange_a, mass.flange_b)
      annotation (Line(points={{60,10},{44,10}}, color={0,127,0}));
    connect(mP2.flange_b, force2.flange)
      annotation (Line(points={{80,10},{86,10}}, color={0,127,0}));
    connect(feedback1.u2, velSens.v) annotation (Line(points={{-82,2},{-82,-44},
            {50,-44},{50,-31}}, color={0,0,127}));
    connect(velSens.flange, mass.flange_b)
      annotation (Line(points={{50,-10},{50,10},{44,10}}, color={0,127,0}));
    connect(mass.flange_a, mP1.flange_b)
      annotation (Line(points={{24,10},{16,10}}, color={0,127,0}));
    connect(force1.flange, mP1.flange_a)
      annotation (Line(points={{-12,10},{-4,10}}, color={0,127,0}));
    connect(gain1.y, force1.f)
      annotation (Line(points={{-43,10},{-34,10}}, color={0,0,127}));
    connect(feedback1.y, gain1.u)
      annotation (Line(points={{-73,10},{-66,10}}, color={0,0,127}));
    connect(trapezoid1.y, feedback1.u1)
      annotation (Line(points={{-97,10},{-90,10}}, color={0,0,127}));
    connect(realExpression1.y, force2.f) annotation (Line(points={{60,46},{114,
            46},{114,11},{110,11},{110,11.5},{108,11.5},{108,10}}, color={0,0,
            127}));
    der(energy) = mP2.power;
    annotation (
      experimentSetupOutput(derivatives=false),
      Commands,
      experiment(
        StartTime=0,
        StopTime=100,
        Tolerance=0.0001,
        Interval=0.05),
      Diagram(graphics, coordinateSystem(
          extent={{-120,-60},{120,60}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})),
      Icon(graphics, coordinateSystem(
          extent={{-120,-60},{120,60}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})));
  end EVbasic;

  model DOwCoasting "Minimize mechanical energy in a simple path"
    // Prova con selezione automatica del coasting.
    // non supera il check sintattico.
    // consultare Ruge.
    parameter Real m=1000 "1000 kg of vehicle mass";
    parameter Real p=1 "needed for final constraints";
    parameter Real fGrip=0.02;
    parameter Real S=2 "superficie frontale in m^2";
    parameter Real Cx=0.4;
    parameter Real iLoss=500 "iron losses, W, when  no coasting";
    constant Real rho=1.226 "densità aria kg/m^3";
    constant Real g=9.81;
    Real a(
      min=-1,
      max=1) annotation (isConstraint=true);
    Real v(start=0);
    Real pos(start=0);
    Real mechPow, elePow;
    Real fResis "Motion resistance";
    Real Energy "Energy to minimize";
    input Integer coasting(
      min=0,
      max=1);
    input Real f(min=-1e9, max=1e9);
    Real constEn= Energy "minimize Energy(tf)"
      annotation (isMayer=true);
    Real constSpeed(
      min=0,
      max=0) = p*v " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
    Real constSpace(
      min=1000,
      max=1000) = p*pos " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
  equation
    mechPow = f*v;
    elePow = coasting*(mechPow + iLoss);
    der(Energy) = elePow;
    der(pos) = v;
    der(v) = a;
    fResis = fGrip*m*g + 0.5*Cx*rho*S*v^2;
    f - fResis = m*a;
    annotation (Documentation(info="<html>
<p>train movement optimization.</p>
</html>"), experiment(
        StartTime=0,
        StopTime=100,
        Tolerance=1e-08,
        Interval=0.333333));
  end DOwCoasting;

  annotation (
    Icon(graphics, coordinateSystem(
        extent={{-100,-80},{100,80}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={2,2})),
    Diagram(graphics, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={2,2})),
    uses(Modelica(version="3.2.1")),
    version="1",
    conversion(from(version="", script="ConvertFromDOtrainPkg_.mos")));
end DO1;
