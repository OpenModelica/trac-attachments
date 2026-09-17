package TestNewton
  model Test1
    Real p0;
    Real T0;
    Real rho0;
    Real p0rel;
    Real p1;
    Real p1rel;
    Real rho1T0;
    Real rho1T2;
    Real p2;
    Real p2rel(stateSelect = StateSelect.prefer, start = 0, fixed = true);
    Real T2(stateSelect = StateSelect.prefer, start = Tatm, fixed = true);
    Real rho2;
    Real rho01;
    Real rho12;
    Real dp1 = p0 - p1;
    Real dp2 = p1 - p2;
    Real w(nominal = 1e-5);
    Real M(stateSelect = StateSelect.avoid);
    Real E(stateSelect = StateSelect.avoid);
    Real V;
    constant Real R = 289;
    constant Real cp = 1000;
    constant Real cv = cp - R;
    parameter Real patm = 101325;
    parameter Real Tatm = 300;
    parameter Real V0 = 1e-4;
    parameter Real wn = 1e-4;
    parameter Real ws = 1e-2 * wn;
    parameter Real dps = 1;
    parameter Real k1 = 2e-2;
    parameter Real k2 = k1;

    function rho_pT
      input Real p;
      input Real T;
      output Real rho;
    algorithm
      rho := p / (R * T);
      annotation(
        Inline = false,
        smoothOrder = 2);
    end rho_pT;
  equation
    p0 = patm;
    T0 = 300;
    rho0 = rho_pT(p0, T0);
    rho1T0 = rho_pT(p1, T0);
    rho1T2 = rho_pT(p1, T2);
    rho2 = rho_pT(p2, T2);
    M = rho2 * V;
    E = cv * T2 * M;
    der(M) = w;
    der(E) = w * noEvent(if w > 0 then cp * T0 else cp * T2);
    p0rel - p1rel = k1 * w / rho01;
    p1rel - p2rel = k2 * w / rho12;
    rho01 = Modelica.Fluid.Utilities.regStep(p0 - p1, rho0, rho1T2, dps);
    rho12 = Modelica.Fluid.Utilities.regStep(p1 - p2, rho1T0, rho2, dps);
    p0rel = p0 - patm;
    p1rel = p1 - patm;
    p2rel = p2 - patm;
    V = V0 * (1 + 0.5 * cos(time));
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-05, Interval = 0.002),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", noEquidistantTimeGrid = "()", outputFormat = "mat"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst -d=stateselection --showStructuralAnnotations -d=stateselection --showStructuralAnnotations ");
  end Test1;

  model Test2
    extends TestNewton.Test1;
    annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-05, Interval = 0.002),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", noEquidistantTimeGrid = "()", nls = "kinsol", outputFormat = "mat"));
  

  end Test2;
end TestNewton;
