within ;
package Test0
  model FullRecovery "Minimize mechanical energy in a simple path"
    parameter Real m=1000 "1000 kg of vehicle mass";
    parameter Real p=1 "needed for final constraints";
    parameter Real fGrip=0.02;
    parameter Real S=2 "superficie frontale in m^2";
    parameter Real Cx=0.4;
    constant Real rho=1.226 "densit�  aria kg/m^3";
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
  end FullRecovery;

  model DOcoasting1 "Minimize mechanical energy in a simple path"
    // Prova con selezione automatica del coasting.
    // Contiene un trucco per evitare variabili booleane o intere per simulare il coasting:
    // quando la forza motrice scende sotto soglia threas, s'intende che siamo in coasting
    // e la potenza al pantografo si annulla
    parameter Real m=1000 "1000 kg of vehicle mass";
    parameter Real p=1 "needed for final constraints";
    parameter Real fGrip=0.02;
    parameter Real S=2 "superficie frontale in m^2";
    parameter Real Cx=0.4;
    parameter Real iLoss=200 "iron losses, W, when  no coasting";
    constant Real rho=1.226 "densità aria kg/m^3";
    constant Real g=9.81;
    Real a(
      min=-1,
      max=1,
      nominal=0) annotation (isConstraint=true);
    Real v(start=0);
    Real pos(start=0);
    Real elePow, ironLoss;
    Real fResis "Motion resistance";
    Real Energy "Energy to minimize";
    input Real f(min=-1e9, max=1e9);
    Real constEn(nominal=1e8) = Energy "minimize Energy(tf)"
      annotation (isMayer=true);
    Real constSpeed(
      min=0,
      max=0) = p*v " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
    Real constSpace(
      min=1000,
      max=1000) = p*pos " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
  equation
    ironLoss = iLoss*(1 - exp(-f^2/1e4));
    //ironLoss=100;
    elePow = f*v + ironLoss;
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
        Interval=1));
  end DOcoasting1;

  model DOminEnPant "Minimize mechanical Pantograph energy in a simple path"
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
    Real mechPow=f*v "Mechanical power";
    Real fResis "Motion resistance";
    Real mechEnergy;
    Real energy "Energy to minimize";
    input Real f(min=-1e9, max=1e9);
    Real constEn(nominal=1) = energy "minimize energy(tf)"
      annotation (isMayer=true);
    Real constSpeed(
      min=0,
      max=0) = p*v " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
    Real constSpace(
      min=1000,
      max=1000) = p*pos " 0<= p*v(tf) <=0 " annotation (isFinalConstraint=true);
  equation
    der(mechEnergy) = mechPow;
    der(pos) = v;
    der(v) = a;
    energy = mechEnergy;
    fResis = fGrip*m*g + 0.5*Cx*rho*S*v^2;
    f - fResis = m*a;
    annotation (Documentation(info="<html>
<p>train movement optimization.</p>
</html>"), experiment(
        StartTime=0,
        StopTime=100,
        Tolerance=1e-08,
        Interval=0.333333));
  end DOminEnPant;


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
end Test0;
