package HelmholtzMedia  "Data and models of real pure fluids (liquid, two-phase and gas)" 
  extends Modelica.Icons.MaterialPropertiesPackage;

  package Examples  "Test" 
    package MediaTestModels  "Test models to test all media" 
      extends Modelica.Icons.ExamplesPackage;

      model HeliumTestModel  "Test HelmholtzMedia.HelmholtzFluids.Helium" 
        extends Modelica.Icons.Example;
        extends Modelica.Media.Examples.Tests.Components.PartialTestModel(redeclare package Medium = HelmholtzMedia.HelmholtzFluids.Helium, ambient(use_p_ambient = true, use_T_ambient = false));
        annotation(experiment(StopTime = 1.01)); 
      end HeliumTestModel;
    end MediaTestModels;
  end Examples;

  package Interfaces  
    partial package PartialHelmholtzMedium  
      extends HelmholtzMedia.Interfaces.Choices;
      extends Modelica.Media.Interfaces.PartialTwoPhaseMedium(onePhase = false, singleState = false, smoothModel = true, DipoleMoment(min = 0, max = 5), AbsolutePressure(min = Modelica.Constants.small, max = 1e12), SpecificEntropy(min = -Modelica.Constants.inf, max = Modelica.Constants.inf), ThermoStates = Choices.IndependentVariables.ph);

      package EoS  
        record HelmholtzDerivs  "dimensionless Helmholtz energy and its derivatives" 
          extends Modelica.Icons.Record;
          MolarMass MM = fluidConstants[1].molarMass;
          SpecificHeatCapacity R = Modelica.Constants.R / MM "specific gas constant";
          Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Density d(min = 0);
          Real delta(unit = "1") = d / d_crit "reduced density";
          Temperature T;
          Real tau(unit = "1") = T_crit / T "inverse reduced temperature";
          Real i(unit = "1") "f_i";
          Real it(unit = "1") "(df_i/dtau)@delta=const";
          Real itt(unit = "1") "(d2f_i/dtau2)@delta=const";
          Real ittt(unit = "1") "(d3f_i/dtau3)@delta=const";
          Real r(unit = "1") "f_r";
          Real rd(unit = "1") "(df_r/ddelta)@tau=const";
          Real rdd(unit = "1") "(d2f_r/ddelta2)@tau=const";
          Real rt(unit = "1") "(df_r/dtau)@delta=const";
          Real rtt(unit = "1") "(d2f_r/dtau2)@delta=const";
          Real rtd(unit = "1") "(d2f_r/dtau ddelta)";
          Real rttt(unit = "1") "(d3f_r/dtau3)@delta=const";
          Real rttd(unit = "1") "(d3f_r/dtau2 ddelta)";
          Real rtdd(unit = "1") "(d3f_r/dtau ddelta2)";
          Real rddd(unit = "1") "(d3f_r/ddelta3)@tau=const";
        end HelmholtzDerivs;

        record HelmholtzCoefficients  "Coefficients for Helmholtz energy equations of state" 
          constant Real[:, 2] idealLog = fill(0.0, 0, 2);
          constant Real[:, 2] idealPower = fill(0.0, 0, 2);
          constant Real[:, 2] idealEinstein = fill(0.0, 0, 2);
          constant Real[:, 2] idealCosh = fill(0.0, 0, 2);
          constant Real[:, 2] idealSinh = fill(0.0, 0, 2);
          constant Real[:, 4] residualPoly = fill(0.0, 0, 4);
          constant Real[:, 4] residualBwr = fill(0.0, 0, 4);
          constant Real[:, 9] residualGauss = fill(0.0, 0, 9);
          constant Real[:, 12] residualNonAnalytical = fill(0.0, 0, 12);
          Boolean useLineSearch = false;
        end HelmholtzCoefficients;

        function setHelmholtzDerivsFirst  
          input Density d;
          input Temperature T;
          input FixedPhase phase = 1;
          output HelmholtzDerivs f;
        protected
          constant MolarMass MM = fluidConstants[1].molarMass;
          constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant Real delta(unit = "1") = d / d_crit "reduced density";
          constant Real tau(unit = "1") = T_crit / T "inverse reduced temperature";
        algorithm
          f.d := d;
          f.T := T;
          f.delta := delta;
          f.tau := tau;
          if phase == 1 then
            f.i := f_i(tau = tau, delta = delta);
            f.it := f_it(tau = tau, delta = delta);
            f.r := f_r(tau = tau, delta = delta);
            f.rt := f_rt(tau = tau, delta = delta);
            f.rd := f_rd(tau = tau, delta = delta);
          else
            assert(false, "This function will return valid values for single phase input only!");
          end if;
        end setHelmholtzDerivsFirst;

        function setHelmholtzDerivsSecond  
          input Density d;
          input Temperature T;
          input FixedPhase phase = 1;
          output HelmholtzDerivs f;
        protected
          constant MolarMass MM = fluidConstants[1].molarMass;
          constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant Real delta(unit = "1") = d / d_crit "reduced density";
          constant Real tau(unit = "1") = T_crit / T "inverse reduced temperature";
        algorithm
          f.d := d;
          f.T := T;
          f.delta := delta;
          f.tau := tau;
          if phase == 1 then
            f.i := f_i(tau = tau, delta = delta);
            f.it := f_it(tau = tau, delta = delta);
            f.itt := f_itt(tau = tau, delta = delta);
            f.r := f_r(tau = tau, delta = delta);
            f.rt := f_rt(tau = tau, delta = delta);
            f.rtt := f_rtt(tau = tau, delta = delta);
            f.rtd := f_rtd(tau = tau, delta = delta);
            f.rd := f_rd(tau = tau, delta = delta);
            f.rdd := f_rdd(tau = tau, delta = delta);
          else
            assert(false, "This function will return valid values for single phase input only!");
          end if;
        end setHelmholtzDerivsSecond;

        function f_i  "ideal part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_ideal "ideal part of dimensionless Helmholtz energy";
        protected
          final constant Integer nLog = size(helmholtzCoefficients.idealLog, 1);
          final constant Integer nPower = size(helmholtzCoefficients.idealPower, 1);
          final constant Integer nEinstein = size(helmholtzCoefficients.idealEinstein, 1);
          final constant Integer nCosh = size(helmholtzCoefficients.idealCosh, 1);
          final constant Integer nSinh = size(helmholtzCoefficients.idealSinh, 1);
          final constant Real[nLog, 2] l = helmholtzCoefficients.idealLog;
          final constant Real[nPower, 2] p = helmholtzCoefficients.idealPower;
          final constant Real[nEinstein, 2] e = helmholtzCoefficients.idealEinstein;
          final constant Real[nCosh, 2] c = helmholtzCoefficients.idealCosh;
          final constant Real[nSinh, 2] s = helmholtzCoefficients.idealSinh;
        algorithm
          if delta > 0 and tau > 0 then
            f_ideal := log(delta) + sum(l[i, 1] * log(tau ^ l[i, 2]) for i in 1:nLog) + sum(p[i, 1] * tau ^ p[i, 2] for i in 1:nPower) + sum(e[i, 1] * log(1 - exp(e[i, 2] * tau)) for i in 1:nEinstein) - sum(c[i, 1] * log(abs(cosh(c[i, 2] * tau))) for i in 1:nCosh) + sum(s[i, 1] * log(abs(sinh(s[i, 2] * tau))) for i in 1:nSinh);
          else
            f_ideal := -Modelica.Constants.inf;
          end if;
        end f_i;

        function f_it  "ideal part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_ideal_tau "ideal part of dimensionless Helmholtz energy";
        protected
          final constant Integer nLog = size(helmholtzCoefficients.idealLog, 1);
          final constant Integer nPower = size(helmholtzCoefficients.idealPower, 1);
          final constant Integer nEinstein = size(helmholtzCoefficients.idealEinstein, 1);
          final constant Integer nCosh = size(helmholtzCoefficients.idealCosh, 1);
          final constant Integer nSinh = size(helmholtzCoefficients.idealSinh, 1);
          final constant Real[nLog, 2] l = helmholtzCoefficients.idealLog;
          final constant Real[nPower, 2] p = helmholtzCoefficients.idealPower;
          final constant Real[nEinstein, 2] e = helmholtzCoefficients.idealEinstein;
          final constant Real[nCosh, 2] c = helmholtzCoefficients.idealCosh;
          final constant Real[nSinh, 2] s = helmholtzCoefficients.idealSinh;
        algorithm
          f_ideal_tau := sum(l[i, 1] * l[i, 2] / tau for i in 1:nLog) + sum(p[i, 1] * tau ^ (p[i, 2] - 1) * p[i, 2] for i in 1:nPower) + sum(e[i, 1] * (-e[i, 2]) * ((1 - exp(e[i, 2] * tau)) ^ (-1) - 1) for i in 1:nEinstein) - sum(c[i, 1] * c[i, 2] * tanh(c[i, 2] * tau) for i in 1:nCosh) + sum(s[i, 1] * s[i, 2] / tanh(s[i, 2] * tau) for i in 1:nSinh);
        end f_it;

        function f_itt  "ideal part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_ideal_tau_tau "ideal part of dimensionless Helmholtz energy";
        protected
          final constant Integer nLog = size(helmholtzCoefficients.idealLog, 1);
          final constant Integer nPower = size(helmholtzCoefficients.idealPower, 1);
          final constant Integer nEinstein = size(helmholtzCoefficients.idealEinstein, 1);
          final constant Integer nCosh = size(helmholtzCoefficients.idealCosh, 1);
          final constant Integer nSinh = size(helmholtzCoefficients.idealSinh, 1);
          final constant Real[nLog, 2] l = helmholtzCoefficients.idealLog;
          final constant Real[nPower, 2] p = helmholtzCoefficients.idealPower;
          final constant Real[nEinstein, 2] e = helmholtzCoefficients.idealEinstein;
          final constant Real[nCosh, 2] c = helmholtzCoefficients.idealCosh;
          final constant Real[nSinh, 2] s = helmholtzCoefficients.idealSinh;
        algorithm
          f_ideal_tau_tau := sum(-l[i, 1] * l[i, 2] / tau ^ 2 for i in 1:nLog) + sum(p[i, 1] * tau ^ (p[i, 2] - 2) * p[i, 2] * (p[i, 2] - 1) for i in 1:nPower) - sum(e[i, 1] * (-e[i, 2]) ^ 2 * exp(e[i, 2] * tau) * (1 - exp(e[i, 2] * tau)) ^ (-2) for i in 1:nEinstein) - sum(c[i, 1] * c[i, 2] ^ 2 / cosh(c[i, 2] * tau) ^ 2 for i in 1:nCosh) - sum(s[i, 1] * s[i, 2] ^ 2 / sinh(s[i, 2] * tau) ^ 2 for i in 1:nSinh);
        end f_itt;

        function f_r  "residual part of dimensionless Helmholtz energy" 
          input Real delta(min = 0);
          input Real tau(min = 0);
          output Real f_residual "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual := sum(p[i, 1] * tau ^ p[i, 2] * delta ^ p[i, 3] for i in 1:nPoly) + sum(b[i, 1] * tau ^ b[i, 2] * delta ^ b[i, 3] * exp(-delta ^ b[i, 4]) for i in 1:nBwr) + sum(g[i, 1] * tau ^ g[i, 2] * delta ^ g[i, 3] * exp(g[i, 6] * (delta - g[i, 9]) ^ g[i, 4] + g[i, 7] * (tau - g[i, 8]) ^ g[i, 5]) for i in 1:nGauss);
        end f_r;

        function f_rt  "residual part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_residual_tau "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual_tau := sum(p[i, 1] * p[i, 2] * tau ^ (p[i, 2] - 1) * delta ^ p[i, 3] for i in 1:nPoly) + sum(b[i, 1] * b[i, 2] * tau ^ (b[i, 2] - 1) * delta ^ b[i, 3] * exp(-delta ^ b[i, 4]) for i in 1:nBwr) + sum(g[i, 1] * tau ^ g[i, 2] * delta ^ g[i, 3] * exp(g[i, 6] * (delta - g[i, 9]) ^ 2 + g[i, 7] * (tau - g[i, 8]) ^ 2) * (g[i, 2] / tau + 2 * g[i, 7] * (tau - g[i, 8])) for i in 1:nGauss);
        end f_rt;

        function f_rtt  "residual part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_residual_tau_tau "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual_tau_tau := sum(p[i, 1] * p[i, 2] * (p[i, 2] - 1) * delta ^ p[i, 3] * tau ^ (p[i, 2] - 2) for i in 1:nPoly) + sum(b[i, 1] * b[i, 2] * (b[i, 2] - 1) * delta ^ b[i, 3] * tau ^ (b[i, 2] - 2) * exp(-delta ^ b[i, 4]) for i in 1:nBwr) + sum(g[i, 1] * delta ^ g[i, 3] * tau ^ g[i, 2] * exp(g[i, 6] * (delta - g[i, 9]) ^ 2 + g[i, 7] * (tau - g[i, 8]) ^ 2) * ((g[i, 2] / tau + 2 * g[i, 7] * (tau - g[i, 8])) ^ 2 - g[i, 2] / tau ^ 2 + 2 * g[i, 7]) for i in 1:nGauss);
        end f_rtt;

        function f_rtd  "residual part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_residual_delta_tau "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual_delta_tau := sum(p[i, 1] * p[i, 3] * p[i, 2] * delta ^ (p[i, 3] - 1) * tau ^ (p[i, 2] - 1) for i in 1:nPoly) + sum(b[i, 1] * b[i, 2] * delta ^ (b[i, 3] - 1) * tau ^ (b[i, 2] - 1) * (b[i, 3] - b[i, 4] * delta ^ b[i, 4]) * exp(-delta ^ b[i, 4]) for i in 1:nBwr) + sum(g[i, 1] * delta ^ g[i, 3] * tau ^ g[i, 2] * exp(g[i, 6] * (delta - g[i, 9]) ^ 2 + g[i, 7] * (tau - g[i, 8]) ^ 2) * (g[i, 3] / delta + 2 * g[i, 6] * (delta - g[i, 9])) * (g[i, 2] / tau + 2 * g[i, 7] * (tau - g[i, 8])) for i in 1:nGauss);
        end f_rtd;

        function f_rd  "residual part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_residual_delta "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual_delta := sum(p[i, 1] * p[i, 3] * delta ^ (p[i, 3] - 1) * tau ^ p[i, 2] for i in 1:nPoly) + sum(b[i, 1] * exp(-delta ^ b[i, 4]) * (delta ^ (b[i, 3] - 1) * tau ^ b[i, 2] * (b[i, 3] - b[i, 4] * delta ^ b[i, 4])) for i in 1:nBwr) + sum(g[i, 1] * delta ^ g[i, 3] * tau ^ g[i, 2] * exp(g[i, 6] * (delta - g[i, 9]) ^ 2 + g[i, 7] * (tau - g[i, 8]) ^ 2) * (g[i, 3] / delta + 2 * g[i, 6] * (delta - g[i, 9])) for i in 1:nGauss);
        end f_rd;

        function f_rdd  "residual part of dimensionless Helmholtz energy" 
          input Real delta;
          input Real tau;
          output Real f_residual_delta_delta "residual part of dimensionless Helmholtz energy";
        protected
          final constant Integer nPoly = size(helmholtzCoefficients.residualPoly, 1);
          final constant Integer nBwr = size(helmholtzCoefficients.residualBwr, 1);
          final constant Integer nGauss = size(helmholtzCoefficients.residualGauss, 1);
          final constant Real[nPoly, 4] p = helmholtzCoefficients.residualPoly;
          final constant Real[nBwr, 4] b = helmholtzCoefficients.residualBwr;
          final constant Real[nGauss, 9] g = helmholtzCoefficients.residualGauss;
        algorithm
          f_residual_delta_delta := sum(p[i, 1] * p[i, 3] * (p[i, 3] - 1) * delta ^ (p[i, 3] - 2) * tau ^ p[i, 2] for i in 1:nPoly) + sum(b[i, 1] * exp(-delta ^ b[i, 4]) * (delta ^ (b[i, 3] - 2) * tau ^ b[i, 2] * ((b[i, 3] - b[i, 4] * delta ^ b[i, 4]) * (b[i, 3] - 1 - b[i, 4] * delta ^ b[i, 4]) - b[i, 4] ^ 2 * delta ^ b[i, 4])) for i in 1:nBwr) + sum(g[i, 1] * tau ^ g[i, 2] * exp(g[i, 6] * (delta - g[i, 9]) ^ 2 + g[i, 7] * (tau - g[i, 8]) ^ 2) * (2 * g[i, 6] * delta ^ g[i, 3] + 4 * g[i, 6] ^ 2 * delta ^ g[i, 3] * (delta - g[i, 9]) ^ 2 + 4 * g[i, 3] * g[i, 6] * delta ^ (g[i, 3] - 1) * (delta - g[i, 9]) + g[i, 3] * (g[i, 3] - 1) * delta ^ (g[i, 3] - 2)) for i in 1:nGauss);
        end f_rdd;

        function p  "returns pressure p from EoS" 
          input HelmholtzDerivs f;
          output AbsolutePressure p;
        algorithm
          p := f.d * f.T * f.R * (1 + f.delta * f.rd);
        end p;

        function s  "returns specifc entropy s from EoS" 
          input HelmholtzDerivs f;
          output SpecificEntropy s;
        algorithm
          s := f.R * (f.tau * (f.it + f.rt) - f.i - f.r);
        end s;

        function u  "returns specifc internal energy u from EoS" 
          input HelmholtzDerivs f;
          output SpecificEnergy u;
        algorithm
          u := f.T * f.R * (f.tau * (f.it + f.rt));
        end u;

        function h  "returns specifc enthalpy h from EoS" 
          input HelmholtzDerivs f;
          output SpecificEnthalpy h;
        algorithm
          h := f.T * f.R * (f.tau * (f.it + f.rt) + 1 + f.delta * f.rd);
        end h;

        function g  "returns specifc Gibbs energy g from EoS" 
          input HelmholtzDerivs f;
          output SpecificEnergy g;
        algorithm
          g := f.T * f.R * (f.i + f.r + 1 + f.delta * f.rd);
        end g;

        function cp0  "returns ideal gas heat capacity from EoS" 
          input HelmholtzDerivs f;
          output SpecificHeatCapacity cp0;
        algorithm
          cp0 := f.R * (1 - f.tau * f.tau * f.itt);
        end cp0;

        function dpdT  "returns pressure derivative (dp/dd)@T=const" 
          input EoS.HelmholtzDerivs f;
          output DerPressureByDensity dpdT;
        algorithm
          dpdT := f.T * f.R * (1 + 2 * f.delta * f.rd + f.delta * f.delta * f.rdd);
        end dpdT;

        function dpTd  "returns pressure derivative (dp/dT)@d=const" 
          input EoS.HelmholtzDerivs f;
          output DerPressureByTemperature dpTd;
        algorithm
          dpTd := f.d * f.R * (1 + f.delta * f.rd - f.delta * f.tau * f.rtd);
        end dpTd;

        function dsdT  "returns entropy derivative (ds/dd)@T=const" 
          input EoS.HelmholtzDerivs f;
          output DerEntropyByDensity dsdT;
        algorithm
          dsdT := -f.R / f.d * (1 + f.delta * f.rd - f.tau * f.delta * f.rtd);
        end dsdT;

        function dsTd  "returns entropy derivative (ds/dT)@d=const" 
          input EoS.HelmholtzDerivs f;
          output DerEntropyByTemperature dsTd;
        algorithm
          dsTd := f.R / f.T * (-f.tau * f.tau * (f.itt + f.rtt));
        end dsTd;

        function dudT  "returns internal energy derivative (du/dd)@T=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnergyByDensity dudT;
        algorithm
          dudT := f.R * f.T / f.d * (f.tau * f.delta * f.rtd);
        end dudT;

        function duTd  "returns internal energy derivative (du/dT)@d=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnergyByTemperature duTd;
        algorithm
          duTd := f.R * (-f.tau * f.tau * (f.itt + f.rtt));
        end duTd;

        function dhdT  "returns enthalpy derivative (dh/dd)@T=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnthalpyByDensity dhdT;
        algorithm
          dhdT := f.T * f.R / f.d * (0 + f.tau * f.delta * f.rtd + f.delta * f.rd + f.delta * f.delta * f.rdd);
        end dhdT;

        function dhTd  "returns enthalpy derivative (dh/dT)@d=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnthalpyByTemperature dhTd;
        algorithm
          dhTd := f.R * (1 - f.tau * f.tau * (f.itt + f.rtt) + f.delta * f.rd - f.tau * f.delta * f.rtd);
        end dhTd;

        function dgdT  "returns Gibbs energy derivative (dg/dd)@T=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnergyByDensity dgdT;
        algorithm
          dgdT := f.T * f.R / f.d * (1 + 2 * f.delta * f.rd + f.delta * f.delta * f.rdd);
        end dgdT;

        function dgTd  "returns Gibbs energy derivative (dg/dT)@d=const" 
          input EoS.HelmholtzDerivs f;
          output DerEnergyByTemperature dgTd;
        algorithm
          dgTd := f.R * ((-f.tau * (f.it + f.rt)) + f.i + f.r + 1 + f.delta * f.rd - f.delta * f.tau * f.rtd);
        end dgTd;
      end EoS;

      package Ancillary  
        record AncillaryCoefficients  "Coefficients for anciallry equations (psat, dliq, dvap)" 
          constant PressureSaturationModel pressureSaturationModel = PressureSaturationModel.PS5;
          constant Real[:, 2] pressureSaturation = fill(0.0, 0, 2) "vapor pressure coefficients";
          constant DensityLiquidModel densityLiquidModel = DensityLiquidModel.DL1;
          constant Real[:, 2] densityLiquid = fill(0.0, 0, 2) "saturated liquid density coefficients";
          constant DensityVaporModel densityVaporModel = DensityVaporModel.DV3;
          constant Real[:, 2] densityVapor = fill(0.0, 0, 2) "saturated vapor density coefficients";
          constant PressureMeltingModel pressureMeltingModel = PressureMeltingModel.ML1;
          constant Temperature T_reducing = 273.15;
          constant AbsolutePressure p_reducing = 101325;
          constant Real[:, 2] pressureMelting1 = fill(0.0, 0, 2) "melting pressure coefficients";
          constant Real[:, 2] pressureMelting2 = fill(0.0, 0, 2) "melting pressure coefficients";
          constant Real[:, 2] pressureMelting3 = fill(0.0, 0, 2) "melting pressure coefficients";
        end AncillaryCoefficients;

        function bubbleDensity_T  "ancillary function: calculate density of saturated liquid for a given T" 
          input Modelica.SIunits.Temperature T;
          output Modelica.SIunits.Density dliq;
        protected
          DensityLiquidModel densityLiquidModel = ancillaryCoefficients.densityLiquidModel;
          Density d_crit = fluidConstants[1].molarMass / fluidConstants[1].criticalMolarVolume;
          Real delta "reduced density";
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Real T_theta;
          Real tau = T_crit / T "inverse reduced temperature";
          Integer nDliq = size(ancillaryCoefficients.densityLiquid, 1);
          Real[nDliq] n = ancillaryCoefficients.densityLiquid[:, 1];
          Real[nDliq] theta = ancillaryCoefficients.densityLiquid[:, 2];
        algorithm
          if densityLiquidModel == DensityLiquidModel.DL1 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := 1 + delta;
          elseif densityLiquidModel == DensityLiquidModel.DL2 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := 1 + delta;
          elseif densityLiquidModel == DensityLiquidModel.DL3 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := exp(delta);
          elseif densityLiquidModel == DensityLiquidModel.DL4 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := exp(delta);
          elseif densityLiquidModel == DensityLiquidModel.DL5 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := exp(tau * delta);
          elseif densityLiquidModel == DensityLiquidModel.DL6 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDliq);
            delta := exp(tau * delta);
          else
            assert(false, "bubbleDensity_d: this should not happen, check DensityLiquidModel");
          end if;
          dliq := d_crit * delta;
        end bubbleDensity_T;

        function dewDensity_T  "ancillary function: calculate density of saturated vapor for a given T" 
          input Modelica.SIunits.Temperature T;
          output Modelica.SIunits.Density dvap;
        protected
          DensityVaporModel densityVaporModel = ancillaryCoefficients.densityVaporModel;
          Density d_crit = fluidConstants[1].molarMass / fluidConstants[1].criticalMolarVolume;
          Real delta "reduced density";
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Real T_theta;
          Real tau = T_crit / T "inverse reduced temperature";
          Integer nDvap = size(ancillaryCoefficients.densityVapor, 1);
          Real[nDvap] n = ancillaryCoefficients.densityVapor[:, 1];
          Real[nDvap] theta = ancillaryCoefficients.densityVapor[:, 2];
        algorithm
          if densityVaporModel == DensityVaporModel.DV1 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := 1 + delta;
          elseif densityVaporModel == DensityVaporModel.DV2 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := 1 + delta;
          elseif densityVaporModel == DensityVaporModel.DV3 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := exp(delta);
          elseif densityVaporModel == DensityVaporModel.DV4 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := exp(delta);
          elseif densityVaporModel == DensityVaporModel.DV5 then
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := exp(tau * delta);
          elseif densityVaporModel == DensityVaporModel.DV6 then
            T_theta := max((1 - T / T_crit) ^ (1 / 3), Modelica.Constants.small);
            delta := sum(n[i] * T_theta ^ theta[i] for i in 1:nDvap);
            delta := exp(tau * delta);
          else
            assert(false, "dewDensity_d: this should not happen, check DensityVaporModel");
          end if;
          dvap := d_crit * delta;
        end dewDensity_T;

        function saturationPressure_T  "ancillary function: calculate saturation pressure for a given Temperature" 
          input Modelica.SIunits.Temperature T;
          output Modelica.SIunits.AbsolutePressure p;
        protected
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant Real tau = T_crit / T "inverse reduced temperature";
          constant Real T_theta = max(1 - T / T_crit, Modelica.Constants.small);
          constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
          Integer nPressureSaturation = size(ancillaryCoefficients.pressureSaturation, 1);
          Real[nPressureSaturation] n = ancillaryCoefficients.pressureSaturation[:, 1];
          Real[nPressureSaturation] theta = ancillaryCoefficients.pressureSaturation[:, 2];
          constant Real eps = 1e-9;
        algorithm
          assert(T <= T_crit + eps, "saturationPressure error: Temperature is higher than critical temperature");
          p := p_crit * exp(tau * sum(n[i] * T_theta ^ theta[i] for i in 1:nPressureSaturation));
          annotation(inverse(T = saturationTemperature_p(p = p))); 
        end saturationPressure_T;

        function saturationTemperature_p  "ancillary iterative function: calculate saturation temperature for a given pressure by iterating the ancillary function" 
          input Modelica.SIunits.AbsolutePressure p;
          output Modelica.SIunits.Temperature T;
        protected
          constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          Real tau "inverse reduced temperature";
          Real T_theta;
          constant AbsolutePressure p_trip = fluidConstants[1].triplePointPressure;
          constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
          Integer nPressureSaturation = size(ancillaryCoefficients.pressureSaturation, 1);
          Real[nPressureSaturation] n = ancillaryCoefficients.pressureSaturation[:, 1];
          Real[nPressureSaturation] theta = ancillaryCoefficients.pressureSaturation[:, 2];
          Real RES_p;
          Real dpdT;
          constant Real gamma(min = 0, max = 1) = 1 "convergence speed, default=1";
          constant Real tolerance = 1e-6 "relative tolerance for RES_p";
          Integer iter = 0;
          constant Integer iter_max = 200;
        algorithm
          if p < p_crit and p > p_trip then
            T := 1 / (1 / T_crit - (1 / T_trip - 1 / T_crit) / log(p_crit / p_trip) * log(p / p_crit));
            T := min(T, T_crit - Modelica.Constants.eps);
            tau := T_crit / T;
            T_theta := max(1 - T / T_crit, Modelica.Constants.small);
            RES_p := p_crit * exp(tau * sum(n[i] * T_theta ^ theta[i] for i in 1:nPressureSaturation)) - p;
            while abs(RES_p / p) > tolerance and iter < iter_max loop
              iter := iter + 1;
              dpdT := -p_crit * exp(tau * sum(n[i] * T_theta ^ theta[i] for i in 1:nPressureSaturation)) * (1 / T * sum(n[i] * theta[i] * T_theta ^ (theta[i] - 1) for i in 1:nPressureSaturation) + tau / T * sum(n[i] * T_theta ^ theta[i] for i in 1:nPressureSaturation));
              T := T - gamma / dpdT * RES_p;
              T := max(T, T_trip * 0.99);
              T := min(T, T_crit);
              tau := T_crit / T;
              T_theta := max(1 - T / T_crit, Modelica.Constants.small);
              RES_p := p_crit * exp(tau * sum(n[i] * T_theta ^ theta[i] for i in 1:nPressureSaturation)) - p;
            end while;
            assert(iter < iter_max, "Ancillary.saturationTemperature_p did not converge, input was p=" + String(p));
          elseif p <= p_trip then
            T := T_trip;
          elseif p >= p_crit then
            T := T_crit;
          else
            assert(false, "Ancillary.saturationTemperature_p: this should not happen, check p");
          end if;
          annotation(inverse(p = saturationPressure_T(T = T))); 
        end saturationTemperature_p;

        function saturationTemperature_d  "ancillary iterative function: calculate saturation temperature for a given density by iterating the ancillary function" 
          input Modelica.SIunits.Density d;
          output Modelica.SIunits.Temperature T;
        protected
          constant MolarMass MM = fluidConstants[1].molarMass;
          constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant Density dv_trip = Ancillary.dewDensity_T(T_trip);
          constant Density dl_trip = Ancillary.bubbleDensity_T(T_trip);
          Temperature T1 = 0.98 * T_trip;
          Temperature T2 = T_crit;
          Temperature T3;
          Temperature T4;
          Density R1 "residual of T1";
          Density R2 "residual of T2";
          Density R3 "residual of T3";
          Density R4 = Modelica.Constants.inf "residual of T4";
          constant Real tolerance = 1e-6 "relative tolerance for RES_d";
          Integer iter = 0;
          constant Integer iter_max = 200;
        algorithm
          if d < d_crit and d > dv_trip then
            R1 := Ancillary.dewDensity_T(T1) - d;
            R2 := d_crit - d;
            if R1 * R2 < 0 then
              while abs(R4 / d) > tolerance and iter < iter_max and abs(T1 - T2) > tolerance loop
                iter := iter + 1;
                T3 := (T1 + T2) / 2;
                R3 := Ancillary.dewDensity_T(T3) - d;
                T4 := T3 + (T3 - T1) * sign(R1 - R2) * R3 / sqrt(R3 * R3 - R1 * R2);
                R4 := Ancillary.dewDensity_T(T4) - d;
                if R4 * R3 <= 0 then
                  T1 := T3;
                  R1 := R3;
                  T2 := T4;
                  R2 := R4;
                else
                  if R4 * R1 < 0 then
                    T2 := T4;
                    R2 := R4;
                  elseif R4 * R2 < 0 then
                    T1 := T4;
                    R1 := R4;
                  else
                    assert(false, "Ancillary.saturationTemperature_d (vapour side): this should not happen");
                  end if;
                end if;
              end while;
              assert(iter < iter_max, "saturationTemperature_d_vap did not converge, input was d_vap=" + String(d));
              T := T4;
            else
              if abs(R1 / d) < tolerance then
                T := T1;
              elseif abs(R2 / d) < tolerance then
                T := T2;
              else
                assert(false, "Ancillary.saturationTemperature_d (vapour side): T1=" + String(T1) + " and T2=" + String(T2) + " did not bracket the root");
              end if;
            end if;
          elseif d > d_crit and d < dl_trip then
            R1 := Ancillary.bubbleDensity_T(T1) - d;
            R2 := d_crit - d;
            if R1 * R2 < 0 then
              while abs(R4 / d) > tolerance and iter < iter_max and abs(T1 - T2) > tolerance loop
                iter := iter + 1;
                T3 := (T1 + T2) / 2;
                R3 := Ancillary.bubbleDensity_T(T3) - d;
                T4 := T3 + (T3 - T1) * sign(R1 - R2) * R3 / sqrt(R3 * R3 - R1 * R2);
                R4 := Ancillary.bubbleDensity_T(T4) - d;
                if R4 * R3 <= 0 then
                  T1 := T3;
                  R1 := R3;
                  T2 := T4;
                  R2 := R4;
                else
                  if R4 * R1 < 0 then
                    T2 := T4;
                    R2 := R4;
                  elseif R4 * R2 < 0 then
                    T1 := T4;
                    R1 := R4;
                  else
                    assert(false, "Ancillary.saturationTemperature_d (liquid side): this should not happen");
                  end if;
                end if;
              end while;
              assert(iter < iter_max, "saturationTemperature_d_liq did not converge, remaining residuum is R4=" + String(R4) + ", input was d_liq=" + String(d));
              T := T4;
            else
              if abs(R1 / d) < tolerance then
                T := T1;
              elseif abs(R2 / d) < tolerance then
                T := T2;
              else
                assert(false, "Ancillary.saturationTemperature_d (liquid side): T1=" + String(T1) + " and T2=" + String(T2) + " did not bracket the root");
              end if;
            end if;
          elseif d >= dl_trip or d <= dv_trip then
            T := T_trip;
          else
            T := T_crit;
          end if;
        end saturationTemperature_d;

        function saturationTemperature_h_liq  "ancillary iterative function: calculate saturation temperature for a given enthalpy by iterating the ancillary function" 
          input Modelica.SIunits.SpecificEnthalpy h;
          output Modelica.SIunits.Temperature T;
        protected
          constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant SpecificEnthalpy h_crit = fluidConstants[1].HCRIT0;
          constant Density dl_trip = Ancillary.bubbleDensity_T(T_trip);
          constant EoS.HelmholtzDerivs fl_trip = EoS.setHelmholtzDerivsFirst(d = dl_trip, T = T_trip);
          constant SpecificEnthalpy hl_trip = EoS.h(fl_trip);
          Temperature T1 = 0.98 * T_trip;
          Temperature T2 = T_crit;
          Temperature T3;
          Temperature T4;
          Density d1;
          Density d2;
          Density d3;
          Density d4;
          EoS.HelmholtzDerivs f1;
          EoS.HelmholtzDerivs f2;
          EoS.HelmholtzDerivs f3;
          EoS.HelmholtzDerivs f4;
          SpecificEnthalpy R1 "residual of T1";
          SpecificEnthalpy R2 "residual of T2";
          SpecificEnthalpy R3 "residual of T3";
          SpecificEnthalpy R4 = Modelica.Constants.inf "residual of T4";
          constant Real tolerance = 1e-6 "relative tolerance for RES";
          Integer iter = 0;
          constant Integer iter_max = 200;
        algorithm
          if h < 0.98 * h_crit and h > hl_trip then
            R1 := hl_trip - h;
            R2 := h_crit - h;
            if R1 * R2 < 0 then
              while abs(R4 / h) > tolerance and iter < iter_max and abs(T1 - T2) > tolerance loop
                iter := iter + 1;
                T3 := (T1 + T2) / 2;
                d3 := Ancillary.bubbleDensity_T(T3);
                f3 := EoS.setHelmholtzDerivsFirst(d = d3, T = T3);
                R3 := EoS.h(f3) - h;
                T4 := T3 + (T3 - T1) * sign(R1 - R2) * R3 / sqrt(R3 * R3 - R1 * R2);
                d4 := Ancillary.bubbleDensity_T(T4);
                f4 := EoS.setHelmholtzDerivsFirst(d = d4, T = T4);
                R4 := EoS.h(f4) - h;
                if R4 * R3 <= 0 then
                  T1 := T3;
                  R1 := R3;
                  T2 := T4;
                  R2 := R4;
                else
                  if R4 * R1 < 0 then
                    T2 := T4;
                    R2 := R4;
                  elseif R4 * R2 < 0 then
                    T1 := T4;
                    R1 := R4;
                  else
                    assert(false, "Ancillary.saturationTemperature_h (liquid side): this should not happen");
                  end if;
                end if;
              end while;
              assert(iter < iter_max, "saturationTemperature_h_liq did not converge, input was h_liq=" + String(h));
              T := T4;
            else
              if abs(R1 / h) < tolerance then
                T := T1;
              elseif abs(R2 / h) < tolerance then
                T := T2;
              else
                assert(false, "Ancillary.saturationTemperature_h (liquid side): T1=" + String(T1) + " and T2=" + String(T2) + " did not bracket the root");
              end if;
            end if;
          elseif h >= 0.98 * h_crit then
            T := T_crit;
          elseif h <= hl_trip then
            T := T_trip;
          else
            assert(false, "Ancillary.saturationTemperature_h (liquid side): this should also not happen");
          end if;
        end saturationTemperature_h_liq;

        function saturationTemperature_s_liq  "ancillary iterative function: calculate saturation temperature for a given entropy by iterating the ancillary function" 
          input Modelica.SIunits.SpecificEntropy s;
          output Modelica.SIunits.Temperature T;
        protected
          constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant SpecificEntropy s_crit = fluidConstants[1].SCRIT0;
          constant Density dl_trip = Ancillary.bubbleDensity_T(T_trip);
          constant EoS.HelmholtzDerivs fl_trip = EoS.setHelmholtzDerivsFirst(d = dl_trip, T = T_trip);
          constant SpecificEntropy sl_trip = EoS.s(fl_trip);
          Temperature T1 = 0.98 * T_trip;
          Temperature T2 = T_crit;
          Temperature T3;
          Temperature T4;
          Density d1;
          Density d2;
          Density d3;
          Density d4;
          EoS.HelmholtzDerivs f1;
          EoS.HelmholtzDerivs f2;
          EoS.HelmholtzDerivs f3;
          EoS.HelmholtzDerivs f4;
          SpecificEntropy R1 "residual of T1";
          SpecificEntropy R2 "residual of T2";
          SpecificEntropy R3 "residual of T3";
          SpecificEntropy R4 = Modelica.Constants.inf "residual of T4";
          constant Real tolerance = 1e-6 "relative tolerance for RES";
          Integer iter = 0;
          constant Integer iter_max = 200;
        algorithm
          if s < 0.98 * s_crit and s > sl_trip then
            R1 := sl_trip - s;
            R2 := s_crit - s;
            if R1 * R2 < 0 then
              while abs(R4 / s) > tolerance and iter < iter_max and abs(T1 - T2) > tolerance loop
                iter := iter + 1;
                T3 := (T1 + T2) / 2;
                d3 := Ancillary.bubbleDensity_T(T3);
                f3 := EoS.setHelmholtzDerivsFirst(d = d3, T = T3);
                R3 := EoS.s(f3) - s;
                T4 := T3 + (T3 - T1) * sign(R1 - R2) * R3 / sqrt(R3 * R3 - R1 * R2);
                d4 := Ancillary.bubbleDensity_T(T4);
                f4 := EoS.setHelmholtzDerivsFirst(d = d4, T = T4);
                R4 := EoS.s(f4) - s;
                if R4 * R3 <= 0 then
                  T1 := T3;
                  R1 := R3;
                  T2 := T4;
                  R2 := R4;
                else
                  if R4 * R1 < 0 then
                    T2 := T4;
                    R2 := R4;
                  elseif R4 * R2 < 0 then
                    T1 := T4;
                    R1 := R4;
                  else
                    assert(false, "Ancillary.saturationTemperature_s (liquid side): this should not happen");
                  end if;
                end if;
              end while;
              assert(iter < iter_max, "saturationTemperature_s_liq did not converge, input was s_liq=" + String(s));
              T := T4;
            else
              if abs(R1 / s) < tolerance then
                T := T1;
              elseif abs(R2 / s) < tolerance then
                T := T2;
              else
                assert(false, "Ancillary.saturationTemperature_s (liquid side): T1=" + String(T1) + " and T2=" + String(T2) + " did not bracket the root");
              end if;
            end if;
          elseif s >= 0.98 * s_crit then
            T := T_crit;
          elseif s <= sl_trip then
            T := T_trip;
          else
            assert(false, "Ancillary.saturationTemperature_s (liquid side): this should also not happen");
          end if;
        end saturationTemperature_s_liq;

        function density_pT_Soave  "solve Redlich-Kwong-Soave for density" 
          input Temperature T;
          input AbsolutePressure p;
          input AbsolutePressure psat = Ancillary.saturationPressure_T(T = T);
          output Density d;
        protected
          constant MolarMass MM = fluidConstants[1].molarMass;
          constant SpecificHeatCapacity R = Modelica.Constants.R / MM "specific gas constant";
          constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
          constant Real omega = fluidConstants[1].acentricFactor;
          constant Real m = 0.480 + 1.574 * omega - 0.176 * omega ^ 2;
          Real a = 0.42747 * R ^ 2 * T_crit ^ 2 / p_crit * (1 + m * (1 - sqrt(T / T_crit))) ^ 2;
          Real b = 0.08664 * R * T_crit / p_crit;
          Real A = a * p / (R ^ 2 * T ^ 2);
          Real B = b * p / (R * T);
          Real r = A - B - B ^ 2 - 1 / 3;
          Real q = (-2 / 27) + 1 / 3 * (A - B - B ^ 2) - A * B;
          Real D = (r / 3) ^ 3 + (q / 2) ^ 2 "discriminant";
          Real u;
          Real u3;
          Real Y1;
          Real Y2;
          Real Y3;
          Real Theta;
          Real phi;
        algorithm
          if D >= 0 then
            u3 := (-q / 2) + sqrt(D);
            u := sign(u3) * abs(u3) ^ (1 / 3);
            Y1 := u - r / (3 * u);
            d := p / (R * T * (Y1 + 1 / 3));
          elseif abs(D) < 1e-8 and abs(r) < 1e-3 then
            d := d_crit;
          else
            Theta := sqrt(-r ^ 3 / 27);
            phi := acos(-q / (2 * Theta));
            Y1 := 2 * Theta ^ (1 / 3) * cos(phi / 3);
            Y2 := 2 * Theta ^ (1 / 3) * cos(phi / 3 + 2 * .Modelica.Constants.pi / 3);
            Y3 := 2 * Theta ^ (1 / 3) * cos(phi / 3 + 4 * .Modelica.Constants.pi / 3);
            if T <= T_crit then
              if p > psat then
                Y1 := min({Y1, Y2, Y3});
                d := p / (R * T * (Y1 + 1 / 3));
              elseif p < psat then
                Y1 := max({Y1, Y2, Y3});
                d := p / (R * T * (Y1 + 1 / 3));
              else
                assert(p <> psat, "Ancillary.density_pT_Soave error: pressure equals saturation pressure");
              end if;
            else
              d := max({p / (R * T * (Y1 + 1 / 3)), p / (R * T * (Y2 + 1 / 3)), p / (R * T * (Y3 + 1 / 3))});
            end if;
          end if;
        end density_pT_Soave;

        function temperature_pd_Waals  
          input AbsolutePressure p;
          input Density d;
          output Temperature T;
        protected
          constant MolarMass MM = fluidConstants[1].molarMass;
          constant SpecificHeatCapacity R = Modelica.Constants.R / MM "specific gas constant";
          constant Temperature T_crit = fluidConstants[1].criticalTemperature;
          constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
          Real a = 27 / 64 * (R * R * T_crit * T_crit) / p_crit "correction for attraction";
          Real b = R * T_crit / (8 * p_crit) "correction for volume";
        algorithm
          T := (p + a * d ^ 2) * (1 / d - b) / R;
        end temperature_pd_Waals;
      end Ancillary;

      package Transport  
        record ThermalConductivityCoefficients  
          constant ThermalConductivityModel thermalConductivityModel;
          constant ThermalConductivityCriticalEnhancementModel thermalConductivityCriticalEnhancementModel;
          constant Temperature reducingTemperature_0 = 1 "reducing temperature";
          constant Real reducingThermalConductivity_0 = 1 "usually unity";
          constant Real[:, 2] lambda_0_num_coeffs = fill(0.0, 0, 2) "coeffs for dilute contribution numerator";
          constant Real[:, 2] lambda_0_den_coeffs = fill(0.0, 0, 2) "coeffs for dilute contribution denominator";
          constant Temperature reducingTemperature_background(min = 1) = 1 "reducing temperature";
          constant MolarVolume reducingMolarVolume_background "reducing molar volume";
          constant Real reducingThermalConductivity_background = 1 "usually unity";
          constant Real[:, 4] lambda_b_coeffs = fill(0.0, 0, 4) "coeffs for background contribution";
          constant Real nu = 0.63 "universal exponent";
          constant Real gamma = 1.239 "universal exponent";
          constant Real R0 = 1.03 "universal amplitude";
          constant Real z = 0.063 "universal exponent, used for viscosity";
          constant Real c = 1 "constant in viscosity, often set to 1";
          constant Real xi_0 "amplitude";
          constant Real Gamma_0 "amplitude";
          constant Real qd_inverse "modified effective cutoff parameter";
          constant Temperature T_ref(min = 1, max = 3e3) "reference temperature";
        end ThermalConductivityCoefficients;

        record DynamicViscosityCoefficients  
          constant DynamicViscosityModel dynamicViscosityModel;
          constant CollisionIntegralModel collisionIntegralModel;
          constant Temperature epsilon_kappa(min = 0) "Lennard-Jones energy parameter";
          constant Real sigma "Lennard-Jones size parameter";
          constant Real[:, 2] a = fill(0.0, 0, 2) "coefficients for collision integral";
          constant Real[:, 2] CET = fill(0.0, 0, 2);
          constant Temperature reducingTemperature_0(min = 1) = 1 "reducing temperature";
          constant Real reducingViscosity_0 = 1 "reducing viscosity";
          constant Temperature reducingTemperature_1(min = 1) = 1 "reducing temperature";
          constant Real reducingViscosity_1 = 1 "reducing viscosity";
          constant Real[:, 2] b = fill(0.0, 0, 2) "coefficients for second viscosity virial coefficent B";
          constant Real[:, 1] c = fill(0.0, 0, 1) "coefficients for residual viscosity contribution in VS2 model";
          constant Temperature reducingTemperature_residual(min = 1) = 1 "reducing temperature";
          constant MolarVolume reducingMolarVolume_residual = 1 "reducing molar volume";
          constant Real reducingViscosity_residual = 1 "reducing viscosity";
          constant Real[:, 2] g = fill(0.0, 0, 2) "close-packed density delta_0";
          constant Real[:, 5] e = fill(0.0, 0, 5) "simple poly";
          constant Real[:, 5] nu_po = fill(0.0, 0, 5) "  numerator of rational poly";
          constant Real[:, 5] de_po = fill(0.0, 0, 5) "denominator of rational poly";
        end DynamicViscosityCoefficients;

        record SurfaceTensionCoefficients  
          Real[:, 2] coeffs = fill(0.0, 0, 2) "sigma0 and n";
        end SurfaceTensionCoefficients;

        function dynamicViscosity  "Returns dynamic Viscosity" 
          input ThermodynamicState state;
          output DynamicViscosity eta;
        protected
          DynamicViscosityModel dynamicViscosityModel = dynamicViscosityCoefficients.dynamicViscosityModel;
          constant Real micro = 1e-6;
        algorithm
          if dynamicViscosityModel == DynamicViscosityModel.VS0 then
            eta := dynamicViscosity_residual(state);
          else
            eta := dynamicViscosity_dilute(state) + dynamicViscosity_initial(state) + dynamicViscosity_residual(state);
          end if;
          eta := micro * eta;
        end dynamicViscosity;

        function dynamicViscosity_dilute  "Returns dynamic Viscosity dilute contribution" 
          input ThermodynamicState state;
          output DynamicViscosity eta_0;
        protected
          DynamicViscosityModel dynamicViscosityModel = dynamicViscosityCoefficients.dynamicViscosityModel;
          CollisionIntegralModel collisionIntegralModel = dynamicViscosityCoefficients.collisionIntegralModel;
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Temperature T_red_0 = dynamicViscosityCoefficients.reducingTemperature_0;
          Temperature T_red_residual = dynamicViscosityCoefficients.reducingTemperature_residual;
          Real T_star "reduced temperature";
          Real tau "reduced temperature";
          MolarMass MM = fluidConstants[1].molarMass;
          Real dm = state.d / (1000 * MM) "molar density in mol/l";
          Real[size(dynamicViscosityCoefficients.a, 1), 2] a = dynamicViscosityCoefficients.a;
          Real[size(dynamicViscosityCoefficients.CET, 1), 2] CET = dynamicViscosityCoefficients.CET;
          Real Omega = 0 "reduced effective cross section / Omega collision integral";
          Real sigma = dynamicViscosityCoefficients.sigma;
          Real eta_red_0 = dynamicViscosityCoefficients.reducingViscosity_0;
        algorithm
          if collisionIntegralModel == CollisionIntegralModel.CI0 or dynamicViscosityModel == DynamicViscosityModel.VS0 then
            T_star := state.T / dynamicViscosityCoefficients.epsilon_kappa;
            Omega := 1.16145 / T_star ^ 0.14874 + 0.52487 * exp(-0.77320 * T_star) + 2.16178 * exp(-2.43787 * T_star);
          elseif collisionIntegralModel == CollisionIntegralModel.CI1 then
            T_star := Modelica.Math.log(state.T / dynamicViscosityCoefficients.epsilon_kappa);
            Omega := exp(sum(a[i, 1] * T_star ^ a[i, 2] for i in 1:size(a, 1)));
          elseif collisionIntegralModel == CollisionIntegralModel.CI2 then
            T_star := (dynamicViscosityCoefficients.epsilon_kappa / state.T) ^ (1 / 3);
            Omega := 1 / sum(a[i, 1] * T_star ^ (4 - i) for i in 1:size(a, 1));
          else
            assert(false, "unknown CollisionIntegralModel");
          end if;
          if dynamicViscosityModel == DynamicViscosityModel.VS0 then
            eta_0 := 26.692E-3 * sqrt(dm * state.T) / (sigma ^ 2 * Omega);
          elseif dynamicViscosityModel == DynamicViscosityModel.VS1 or dynamicViscosityModel == DynamicViscosityModel.VS1_alternative then
            tau := state.T / T_red_0;
            eta_0 := CET[1, 1] * sqrt(tau) / (sigma ^ 2 * Omega);
            eta_0 := eta_0 + sum(CET[i, 1] * tau ^ CET[i, 2] for i in 2:size(CET, 1));
          elseif dynamicViscosityModel == DynamicViscosityModel.VS2 then
            eta_0 := CET[1, 1] * state.T ^ CET[1, 2] / (sigma ^ 2 * Omega);
          elseif dynamicViscosityModel == DynamicViscosityModel.VS4 then
            assert(false, "dynamicViscosityModel VS4 not yet implemented");
          else
            assert(false, "unknown dynamicViscosityModel");
          end if;
          eta_0 := eta_0 * eta_red_0;
        end dynamicViscosity_dilute;

        function dynamicViscosity_initial  "Returns dynamic Viscosity initial contribution" 
          input ThermodynamicState state;
          output DynamicViscosity eta_1;
        protected
          DynamicViscosityModel dynamicViscosityModel = dynamicViscosityCoefficients.dynamicViscosityModel;
          CollisionIntegralModel collisionIntegralModel = dynamicViscosityCoefficients.collisionIntegralModel;
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Temperature T_red_0 = dynamicViscosityCoefficients.reducingTemperature_0;
          Temperature T_red_residual = dynamicViscosityCoefficients.reducingTemperature_residual;
          Real T_star "reduced temperature";
          Real tau "reduced temperature";
          MolarMass MM = fluidConstants[1].molarMass;
          Real dm = state.d / (1000 * MM) "molar density in mol/l";
          Real[size(dynamicViscosityCoefficients.b, 1), 2] b = dynamicViscosityCoefficients.b;
          Real B_star = 0 "reduced second viscosity virial coefficient";
          Real B = 0 "second viscosity virial coefficient, l/mol";
          Real sigma = dynamicViscosityCoefficients.sigma;
          Real eta_red_1 = dynamicViscosityCoefficients.reducingViscosity_1;
        algorithm
          if dynamicViscosityModel == DynamicViscosityModel.VS0 then
            eta_1 := 0;
          elseif dynamicViscosityModel == DynamicViscosityModel.VS1 or dynamicViscosityModel == DynamicViscosityModel.VS1_alternative or dynamicViscosityModel == DynamicViscosityModel.VS4 then
            T_star := state.T / dynamicViscosityCoefficients.epsilon_kappa;
            B_star := sum(b[i, 1] * T_star ^ b[i, 2] for i in 1:size(b, 1));
            B := B_star * 0.6022137 * sigma ^ 3;
            eta_1 := dynamicViscosity_dilute(state) * B * dm;
          elseif dynamicViscosityModel == DynamicViscosityModel.VS2 then
            eta_1 := dm * (b[1, 1] + b[2, 1] * (b[3, 1] - log(state.T / b[4, 1])) ^ 2);
          else
            assert(false, "unknown dynamicViscosityModel");
          end if;
          eta_1 := eta_1 * eta_red_1;
        end dynamicViscosity_initial;

        function dynamicViscosity_residual  "Returns dynamic Viscosity residual contribution" 
          input ThermodynamicState state;
          output DynamicViscosity eta_r;
        protected
          DynamicViscosityModel dynamicViscosityModel = dynamicViscosityCoefficients.dynamicViscosityModel;
          CollisionIntegralModel collisionIntegralModel = dynamicViscosityCoefficients.collisionIntegralModel;
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Temperature T_red_0 = dynamicViscosityCoefficients.reducingTemperature_0;
          Temperature T_red_residual = dynamicViscosityCoefficients.reducingTemperature_residual;
          Real T_star "reduced temperature";
          Real tau "reduced temperature";
          MolarMass MM = fluidConstants[1].molarMass;
          Real dm = state.d / (1000 * MM) "molar density in mol/l";
          Real d_gcm = state.d / 1000 "density in g/cm3";
          Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          Density d_red_residual = MM / dynamicViscosityCoefficients.reducingMolarVolume_residual;
          Real delta = 0 "reduced density";
          Real delta_exp = 0 "reduced density in exponential term";
          Real delta_0 = 0 "close packed density";
          Real[size(dynamicViscosityCoefficients.c, 1), 1] c = dynamicViscosityCoefficients.c;
          Real[size(dynamicViscosityCoefficients.g, 1), 2] g = dynamicViscosityCoefficients.g;
          Real[size(dynamicViscosityCoefficients.e, 1), 5] e = dynamicViscosityCoefficients.e;
          Real[size(dynamicViscosityCoefficients.nu_po, 1), 5] nu_po = dynamicViscosityCoefficients.nu_po;
          Real[size(dynamicViscosityCoefficients.de_po, 1), 5] de_po = dynamicViscosityCoefficients.de_po;
          Real visci = 0 "RefProp      visci temporary variable";
          Real xnum = 0 "RefProp   numerator temporary variable";
          Real xden = 0 "RefProp denominator temporary variable";
          Real G = 0 "RefProp temporary variable";
          Real H = 0 "RefProp temporary variable";
          Real F = 0 "RefProp temporary variable";
          Real x = 0 "RefProp temporary variable";
          Real B = 0 "RefProp temporary variable";
          Real C = 0 "RefProp temporary variable";
          Real D = 0 "RefProp temporary variable";
          Real eta_e = 0 "RefProp temporary variable";
          Real eta_0 = 0 "RefProp temporary variable";
          Real eta_0a = 0 "RefProp temporary variable";
          Real eta_0b = 0 "RefProp temporary variable";
          Real eta_red_residual = dynamicViscosityCoefficients.reducingViscosity_residual;
        algorithm
          if dynamicViscosityModel == DynamicViscosityModel.VS0 then
            if mediumName == "helium" then
              x := if state.T <= 300.0E0 then log(state.T) else 5.703782474656201;
              B := (-47.5295259E0 / x) + 87.6799309E0 - 42.0741589E0 * x + 8.33128289E0 * x ^ 2 - 0.589252385E0 * x ^ 3;
              C := 547.309267E0 / x - 904.870586E0 + 431.404928E0 * x - 81.4504854E0 * x ^ 2 + 5.37008433E0 * x ^ 3;
              D := (-1684.39324E0 / x) + 3331.08630E0 - 1632.19172E0 * x + 308.804413E0 * x ^ 2 - 20.2936367E0 * x ^ 3;
              eta_e := exp(min(100, B * d_gcm + C * d_gcm ^ 2 + D * d_gcm ^ 3));
              eta_0a := exp((-0.135311743E0 / x) + 1.00347841E0 + 1.20654649E0 * x - 0.149564551E0 * x ^ 2 + 0.0125208416E0 * x ^ 3);
              if state.T < 100.0E0 then
                eta_r := eta_0a * eta_e;
              else
                eta_0b := 196.0E0 * state.T ^ 0.71938E0 * exp(12.451E0 / state.T - 295.67E0 / state.T ^ 2 - 4.1249E0);
                if state.T <= 110.0E0 then
                  eta_0 := eta_0a + (eta_0b - eta_0a) * (state.T - 100.0E0) / 10.0E0;
                else
                  eta_0 := eta_0b;
                end if;
                eta_r := eta_0a * eta_e + eta_0 - eta_0a;
              end if;
              eta_r := eta_r / 10.0E0;
            elseif mediumName == "water" then
              assert(false, "water viscosity not yet implemented");
            else
            end if;
          elseif dynamicViscosityModel == DynamicViscosityModel.VS1 or dynamicViscosityModel == DynamicViscosityModel.VS1_alternative then
            tau := state.T / T_red_residual;
            delta := state.d / d_red_residual;
            if abs(d_red_residual - 1) > 0.001 then
              delta_exp := state.d / d_crit;
            else
              delta_exp := delta;
            end if;
            if dynamicViscosityModel == DynamicViscosityModel.VS1 then
              delta_0 := sum(g[i, 1] * tau ^ g[i, 2] for i in 1:size(g, 1));
            elseif dynamicViscosityModel == DynamicViscosityModel.VS1_alternative then
              delta_0 := g[1, 1] / (1 + sum(g[i, 1] * tau ^ g[i, 2] for i in 2:size(g, 1)));
            else
            end if;
            for i in 1:size(e, 1) loop
              visci := e[i, 1] * tau ^ e[i, 2] * delta ^ e[i, 3] * delta_0 ^ e[i, 4];
              if e[i, 5] > 0 then
                visci := visci * exp(-delta_exp ^ e[i, 5]);
              else
              end if;
              eta_r := eta_r + visci;
            end for;
            for i in 1:size(nu_po, 1) loop
              xnum := xnum + nu_po[i, 1] * tau ^ nu_po[i, 2] * delta ^ nu_po[i, 3] * delta_0 ^ nu_po[i, 4];
              if nu_po[i, 5] > 0 then
                xnum := xnum * exp(-delta_exp ^ nu_po[i, 5]);
              else
              end if;
            end for;
            for i in 1:size(de_po, 1) loop
              xden := xden + de_po[i, 1] * tau ^ de_po[i, 2] * delta ^ de_po[i, 3] * delta_0 ^ de_po[i, 4];
              if de_po[i, 5] > 0 then
                xden := xden * exp(-delta_exp ^ de_po[i, 5]);
              else
              end if;
            end for;
            eta_r := eta_r + xnum / xden;
          elseif dynamicViscosityModel == DynamicViscosityModel.VS2 then
            G := c[1, 1] + c[2, 1] / state.T;
            H := sqrt(dm) * (dm - c[8, 1]) / c[8, 1];
            F := G + (c[3, 1] + c[4, 1] * state.T ^ (-3 / 2)) * dm ^ 0.1 + (c[5, 1] + c[6, 1] / state.T + c[7, 1] / state.T ^ 2) * H;
            eta_r := exp(F) - exp(G);
          elseif dynamicViscosityModel == DynamicViscosityModel.VS4 then
            assert(false, "VS4 not yet implemented!!");
          else
            assert(false, "unknown dynamicViscosityModel");
          end if;
          eta_r := eta_r * eta_red_residual;
        end dynamicViscosity_residual;

        function thermalConductivity  "Return thermal conductivity" 
          input ThermodynamicState state;
          output ThermalConductivity lambda;
        protected
          ThermalConductivityModel thermalConductivityModel = thermalConductivityCoefficients.thermalConductivityModel;
        algorithm
          assert(state.phase <> 2, "thermalConductivity warning: property not defined in two-phase region", AssertionLevel.warning);
          if thermalConductivityModel == ThermalConductivityModel.TC0 then
            lambda := thermalConductivity_background(state);
          else
            lambda := thermalConductivity_dilute(state) + thermalConductivity_background(state) + thermalConductivity_critical(state);
          end if;
        end thermalConductivity;

        function thermalConductivity_dilute  "Return thermal conductivity dilute (i.e. density-independent) contribution" 
          input ThermodynamicState state;
          output ThermalConductivity lambda_0;
        protected
          Temperature T_red_0 = thermalConductivityCoefficients.reducingTemperature_0;
          Real tau "reduced temperature";
          Integer nDilute_num = size(thermalConductivityCoefficients.lambda_0_num_coeffs, 1);
          Real[nDilute_num, 2] A_num = thermalConductivityCoefficients.lambda_0_num_coeffs;
          Integer nDilute_den = size(thermalConductivityCoefficients.lambda_0_den_coeffs, 1);
          Real[nDilute_den, 2] A_den = thermalConductivityCoefficients.lambda_0_den_coeffs;
          Real denom = 1;
          Real lambda_red_0 = thermalConductivityCoefficients.reducingThermalConductivity_0;
          constant Real eps = Modelica.Constants.eps;
          constant Real kilo = 1e3;
          EoS.HelmholtzDerivs f;
          Real cp0;
          Real eta_0;
        algorithm
          tau := state.T / T_red_0;
          if A_num[nDilute_num, 2] > (-90) then
            lambda_0 := sum(A_num[i, 1] * tau ^ A_num[i, 2] for i in 1:nDilute_num);
          else
            lambda_0 := sum(A_num[i, 1] * tau ^ A_num[i, 2] for i in 1:nDilute_num - 1);
            f := EoS.setHelmholtzDerivsSecond(d = state.d, T = state.T);
            cp0 := EoS.cp0(f);
            eta_0 := dynamicViscosity_dilute(state);
            if abs(A_num[nDilute_num, 2] + 99) < eps then
              Modelica.Utilities.Streams.print("thermalConductivity_dilute: flag 99");
              assert(false, "not yet implemented");
            elseif abs(A_num[nDilute_num, 2] + 98) < eps then
              Modelica.Utilities.Streams.print("thermalConductivity_dilute: flag 98");
              assert(false, "not yet implemented");
            elseif abs(A_num[nDilute_num, 2] + 97) < eps then
              Modelica.Utilities.Streams.print("thermalConductivity_dilute: flag 97");
              assert(false, "not yet implemented");
            elseif abs(A_num[nDilute_num, 2] + 96) < eps then
              cp0 := cp0 / f.R - 2.5;
              lambda_0 := (lambda_0 * cp0 + 15.0 / 4.0) * f.R * eta_0 / kilo;
            else
            end if;
          end if;
          if nDilute_den > 1 then
            denom := sum(A_den[i, 1] * tau ^ A_den[i, 2] for i in 1:nDilute_den);
          else
            denom := 1;
          end if;
          lambda_0 := lambda_0 / denom * lambda_red_0;
        end thermalConductivity_dilute;

        function thermalConductivity_background  "Return thermal conductivity background/residual  contribution" 
          input ThermodynamicState state;
          output ThermalConductivity lambda_b;
        protected
          ThermalConductivityModel thermalConductivityModel = thermalConductivityCoefficients.thermalConductivityModel;
          MolarMass MM = fluidConstants[1].molarMass;
          Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          Density d_red_background = fluidConstants[1].molarMass / thermalConductivityCoefficients.reducingMolarVolume_background;
          Real delta "reduced density";
          Temperature T_red_background = thermalConductivityCoefficients.reducingTemperature_background;
          Real tau "reduced temperature";
          Integer nBackground = size(thermalConductivityCoefficients.lambda_b_coeffs, 1);
          Real[nBackground, 4] B = thermalConductivityCoefficients.lambda_b_coeffs;
          Real lambda_red_background = thermalConductivityCoefficients.reducingThermalConductivity_background;
        algorithm
          if thermalConductivityModel == ThermalConductivityModel.TC0 then
            if mediumName == "helium" then
            else
            end if;
          elseif thermalConductivityModel == ThermalConductivityModel.TC1 then
            tau := state.T / T_red_background;
            delta := state.d / d_red_background;
            lambda_b := sum(B[i, 1] * tau ^ B[i, 2] * delta ^ B[i, 3] for i in 1:nBackground);
            lambda_b := lambda_b * lambda_red_background;
          elseif thermalConductivityModel == ThermalConductivityModel.TC2 then
            assert(false, "ThermalconductivityModel TC2 not yet implemented");
          else
            assert(false, "unknown ThermalconductivityModel");
          end if;
        end thermalConductivity_background;

        function thermalConductivity_critical  "Return thermal conductivity critical enhancement" 
          input ThermodynamicState state;
          output ThermalConductivity lambda_c;
        protected
          MolarMass MM = fluidConstants[1].molarMass;
          Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Real tau "reduced temperature";
          AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
          Real nu = thermalConductivityCoefficients.nu;
          Real gamma = thermalConductivityCoefficients.gamma;
          Real R0 = thermalConductivityCoefficients.R0;
          Real z = thermalConductivityCoefficients.z;
          Real c = thermalConductivityCoefficients.c;
          Real xi_0 = thermalConductivityCoefficients.xi_0;
          Real Gamma_0 = thermalConductivityCoefficients.Gamma_0;
          Real q_D = 1 / thermalConductivityCoefficients.qd_inverse;
          Temperature T_ref = thermalConductivityCoefficients.T_ref;
          constant Real pi = Modelica.Constants.pi;
          constant Real k_b = Modelica.Constants.k;
          EoS.HelmholtzDerivs f;
          EoS.HelmholtzDerivs f_ref;
          Real ddpT;
          Real ddpT_ref;
          Real chi;
          Real chi_ref;
          Real Delta_chi;
          Real xi;
          Real Omega_0;
          Real Omega;
          SpecificHeatCapacity Cp;
          SpecificHeatCapacity Cv;
          DynamicViscosity eta_b;
        algorithm
          if state.T > T_ref or state.d < d_crit / 100 then
            lambda_c := 0;
          else
            f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
            f_ref := EoS.setHelmholtzDerivsSecond(T = T_ref, d = state.d, phase = 1);
            ddpT := 1.0 / EoS.dpdT(f);
            ddpT_ref := 1.0 / EoS.dpdT(f_ref);
            chi := p_crit / d_crit ^ 2 * state.d * ddpT;
            chi_ref := p_crit / d_crit ^ 2 * state.d * ddpT_ref * T_ref / state.T;
            Delta_chi := chi - chi_ref;
            if Delta_chi < 0 then
              lambda_c := 0;
            else
              xi := xi_0 * (Delta_chi / Gamma_0) ^ (nu / gamma);
              Cp := specificHeatCapacityCp(state = state);
              Cv := specificHeatCapacityCv(state = state);
              Omega := 2 / pi * ((Cp - Cv) / Cp * atan(q_D * xi) + Cv / Cp * q_D * xi);
              Omega_0 := 2 / pi * (1 - exp(-1 / (1 / (q_D * xi) + (q_D * xi * d_crit / state.d) ^ 2 / 3)));
              eta_b := dynamicViscosity(state = state);
              lambda_c := state.d * Cp * R0 * k_b * state.T / (6 * pi * eta_b * xi) * (Omega - Omega_0);
              lambda_c := max(0, lambda_c);
            end if;
          end if;
        end thermalConductivity_critical;

        function surfaceTension  "Return surface tension sigma in the two phase region" 
          input SaturationProperties sat;
          output SurfaceTension sigma;
        protected
          Temperature T_crit = fluidConstants[1].criticalTemperature;
          Real[size(surfaceTensionCoefficients.coeffs, 1)] a = surfaceTensionCoefficients.coeffs[:, 1];
          Real[size(surfaceTensionCoefficients.coeffs, 1)] n = surfaceTensionCoefficients.coeffs[:, 2];
          Real X "reduced temperature difference";
        algorithm
          X := (T_crit - sat.Tsat) / T_crit;
          sigma := sum(a[i] * X ^ n[i] for i in 1:size(a, 1));
        end surfaceTension;
      end Transport;

      constant HelmholtzMedia.Interfaces.Types.FluidLimits fluidLimits;
      constant EoS.HelmholtzCoefficients helmholtzCoefficients;
      constant Transport.ThermalConductivityCoefficients thermalConductivityCoefficients;
      constant Transport.DynamicViscosityCoefficients dynamicViscosityCoefficients;
      constant Transport.SurfaceTensionCoefficients surfaceTensionCoefficients;
      constant Ancillary.AncillaryCoefficients ancillaryCoefficients;
      constant InputChoice inputChoice = InputChoice.ph "Default choice of input variables for property computations";

      redeclare record extends ThermodynamicState(phase(start = 0))  
        Temperature T "Temperature of medium";
        AbsolutePressure p "Absolute pressure of medium";
        Density d "Density of medium";
        SpecificEnergy u "Specific inner energy of medium";
        SpecificEnthalpy h "Specific enthalpy of medium";
        SpecificEntropy s "Specific entropy of medium";
      end ThermodynamicState;

      redeclare record extends SaturationProperties  
        ThermodynamicState liq;
        ThermodynamicState vap;
      end SaturationProperties;

      redeclare model extends BaseProperties(p(stateSelect = if preferredMediumStates and (componentInputChoice == InputChoice.ph or componentInputChoice == InputChoice.pT or componentInputChoice == InputChoice.ps) then StateSelect.prefer else StateSelect.default), T(stateSelect = if preferredMediumStates and (componentInputChoice == InputChoice.pT or componentInputChoice == InputChoice.dT) then StateSelect.prefer else StateSelect.default), h(stateSelect = if preferredMediumStates and componentInputChoice == InputChoice.ph then StateSelect.prefer else StateSelect.default), d(stateSelect = if preferredMediumStates and componentInputChoice == InputChoice.dT then StateSelect.prefer else StateSelect.default))  "Base properties (p, d, T, h, u, s) of a medium" 
        SpecificEntropy s;
        parameter InputChoice componentInputChoice = inputChoice "Choice of input variables for property computations";
      equation
        MM = fluidConstants[1].molarMass;
        R = Modelica.Constants.R / MM;
        if componentInputChoice == InputChoice.ph then
          d = density_ph(p = p, h = h);
          T = temperature_ph(p = p, h = h);
          s = specificEntropy_ph(p = p, h = h);
        elseif componentInputChoice == InputChoice.ps then
          d = density_ps(p = p, s = s);
          T = temperature_ps(p = p, s = s);
          h = specificEnthalpy_ps(p = p, s = s);
        elseif componentInputChoice == InputChoice.pT then
          d = density_pT(p = p, T = T);
          h = specificEnthalpy_pT(p = p, T = T);
          s = specificEntropy_pT(p = p, T = T);
        elseif componentInputChoice == InputChoice.dT then
          p = pressure_dT(d = d, T = T);
          h = specificEnthalpy_dT(d = d, T = T);
          s = specificEntropy_dT(d = d, T = T);
        else
          assert(false, "Invalid choice for basePropertiesInput");
        end if;
        u = h - p / d;
        sat = setSat_p(p = p);
        state.d = d;
        state.T = T;
        state.p = p;
        state.h = h;
        state.s = s;
        state.u = u;
        state.phase = if p < fluidConstants[1].criticalPressure and p > fluidConstants[1].triplePointPressure and h > sat.liq.h and h < sat.vap.h then 2 else 1;
      end BaseProperties;

      type DerEnergyByDensity = Real(final unit = "(J/kg)/(kg/m3)");
      type DerEnergyByTemperature = Real(final unit = "(J/kg)/K");
      type DerEnthalpyByDensity = Real(final unit = "(J/kg)/(kg/m3)");
      type DerEnthalpyByTemperature = Real(final unit = "(J/kg)/K");
      type DerEntropyByDensity = Real(final unit = "(J/(kg.K))/(kg/m3)");
      type DerEntropyByPressure = Real(final unit = "(J/(kg.K))/Pa");
      type DerEntropyByTemperature = Real(final unit = "(J/(kg.K))/K");
      type DerPressureByDensity = Real(final unit = "Pa/(kg/m3)", start = 1);
      type DerPressureByTemperature = Real(final unit = "Pa/K");
      type DerVolumeByPressure = Real(final unit = "(m3/kg)/Pa");
      type DerVolumeByTemperature = Real(final unit = "(m3/kg)/K");
      type DerFractionByPressure = Real(final unit = "1/Pa");
      type DerFractionByTemperature = Real(final unit = "1/K");

      redeclare function setSat_T  "iterative calculation of saturation properties from EoS with Newton-Raphson algorithm" 
        input Temperature T;
        output SaturationProperties sat;
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        constant Real tau(unit = "1") = T_crit / T "inverse reduced temperature";
        EoS.HelmholtzDerivs fl(T = T);
        EoS.HelmholtzDerivs fv(T = T);
        Real delta_liq(unit = "1", min = 0);
        Real delta_vap(unit = "1", min = 0);
        Real J_liq;
        Real J_liq_delta;
        Real J_vap;
        Real J_vap_delta;
        Real K_liq;
        Real K_liq_delta;
        Real K_vap;
        Real K_vap_delta;
        Real[2] RES "residual function vector";
        Real RSS "residual sum of squares";
        Real[2, 2] Jacobian "Jacobian matrix";
        Real[2] NS "Newton step vector";
        constant Real lambda(min = 0.1, max = 1) = 1 "convergence speed, default=1";
        constant Real tolerance = 1e-18 "tolerance for RSS";
        Integer iter = 0;
        constant Integer iter_max = 200;
      algorithm
        sat.Tsat := T;
        if T >= T_trip and T < T_crit then
          delta_liq := 1.02 * Ancillary.bubbleDensity_T(T = T) / d_crit;
          delta_vap := 0.98 * Ancillary.dewDensity_T(T = T) / d_crit;
          fl.r := EoS.f_r(tau = tau, delta = delta_liq);
          fv.r := EoS.f_r(tau = tau, delta = delta_vap);
          fl.rd := EoS.f_rd(tau = tau, delta = delta_liq);
          fv.rd := EoS.f_rd(tau = tau, delta = delta_vap);
          J_liq := delta_liq * (1 + delta_liq * fl.rd);
          J_vap := delta_vap * (1 + delta_vap * fv.rd);
          K_liq := delta_liq * fl.rd + fl.r + log(delta_liq);
          K_vap := delta_vap * fv.rd + fv.r + log(delta_vap);
          RES := {J_vap - J_liq, K_vap - K_liq};
          RSS := RES * RES / 2;
          while RSS > tolerance and iter < iter_max loop
            iter := iter + 1;
            fl.rdd := EoS.f_rdd(tau = tau, delta = delta_liq);
            fv.rdd := EoS.f_rdd(tau = tau, delta = delta_vap);
            J_liq_delta := 1 + 2 * delta_liq * fl.rd + delta_liq * delta_liq * fl.rdd;
            J_vap_delta := 1 + 2 * delta_vap * fv.rd + delta_vap * delta_vap * fv.rdd;
            K_liq_delta := 2 * fl.rd + delta_liq * fl.rdd + 1 / delta_liq;
            K_vap_delta := 2 * fv.rd + delta_vap * fv.rdd + 1 / delta_vap;
            Jacobian := [-J_liq_delta, J_vap_delta; -K_liq_delta, K_vap_delta];
            NS := -Modelica.Math.Matrices.solve(Jacobian, RES);
            delta_liq := delta_liq + lambda * NS[1];
            delta_vap := delta_vap + lambda * NS[2];
            delta_liq := max(delta_liq, 1);
            delta_liq := min(delta_liq, Modelica.Constants.inf);
            delta_vap := max(delta_vap, Modelica.Constants.small);
            delta_vap := min(delta_vap, 1);
            fl.r := EoS.f_r(tau = tau, delta = delta_liq);
            fv.r := EoS.f_r(tau = tau, delta = delta_vap);
            fl.rd := EoS.f_rd(tau = tau, delta = delta_liq);
            fv.rd := EoS.f_rd(tau = tau, delta = delta_vap);
            J_liq := delta_liq * (1 + delta_liq * fl.rd);
            J_vap := delta_vap * (1 + delta_vap * fv.rd);
            K_liq := delta_liq * fl.rd + fl.r + log(delta_liq);
            K_vap := delta_vap * fv.rd + fv.r + log(delta_vap);
            RES := {J_vap - J_liq, K_vap - K_liq};
            RSS := RES * RES / 2;
          end while;
          assert(iter < iter_max, "setSat_T did not converge, input was T=" + String(T) + "; the remaining residuals are RES_J=" + String(RES[1]) + " and RES_K=" + String(RES[2]));
          sat.liq := setState_dTX(d = delta_liq * d_crit, T = T, phase = 1);
          sat.vap := setState_dTX(d = delta_vap * d_crit, T = T, phase = 1);
          sat.psat := (sat.liq.p + sat.vap.p) / 2;
        elseif T >= T_crit then
          sat.liq := setState_dTX(d = d_crit, T = T, phase = 1);
          sat.vap := setState_dTX(d = d_crit, T = T, phase = 1);
          sat.psat := (sat.liq.p + sat.vap.p) / 2;
        else
          sat.Tsat := max(T, Modelica.Constants.small);
          delta_liq := T_trip / sat.Tsat * Ancillary.bubbleDensity_T(T = T_trip) / d_crit;
          delta_vap := sat.Tsat / T_trip * Ancillary.dewDensity_T(T = T_trip) / d_crit;
          sat.liq := setState_dTX(d = delta_liq * d_crit, T = T, phase = 1);
          sat.vap := setState_dTX(d = delta_vap * d_crit, T = T, phase = 1);
          sat.psat := (sat.liq.p + sat.vap.p) / 2;
        end if;
      end setSat_T;

      redeclare function setSat_p  "iterative calculation of saturation properties from EoS for a given pressure" 
        input AbsolutePressure p;
        output SaturationProperties sat;
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        constant AbsolutePressure p_trip = fluidConstants[1].triplePointPressure;
        constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
        constant Density dv_trip = Ancillary.dewDensity_T(T_trip);
        constant Density dl_trip = Ancillary.bubbleDensity_T(T_trip);
        EoS.HelmholtzDerivs fl;
        EoS.HelmholtzDerivs fv;
        Real[3] RES "residual function vector";
        Real RSS "residual sum of squares";
        Real[3, 3] Jacobian "Jacobian matrix";
        Real[3] NS "Newton step vector";
        constant Real lambda(min = 0.1, max = 1) = 1 "convergence speed, default=1";
        constant Real tolerance = 1e-9 "tolerance for RSS";
        Integer iter = 0;
        constant Integer iter_max = 200;
      algorithm
        sat.psat := p;
        if p > p_trip and p < p_crit then
          sat.Tsat := Ancillary.saturationTemperature_p(p = p);
          sat.liq.d := 1.02 * Ancillary.bubbleDensity_T(T = sat.Tsat);
          sat.vap.d := 0.98 * Ancillary.dewDensity_T(T = sat.Tsat);
          fl := EoS.setHelmholtzDerivsSecond(d = sat.liq.d, T = sat.Tsat, phase = 1);
          fv := EoS.setHelmholtzDerivsSecond(d = sat.vap.d, T = sat.Tsat, phase = 1);
          RES := {EoS.p(fl) - p, EoS.p(fv) - p, EoS.g(fl) - EoS.g(fv)};
          RSS := RES * RES / 2;
          while RSS > tolerance and iter < iter_max loop
            iter := iter + 1;
            Jacobian := [+EoS.dpdT(fl), +0, +EoS.dpTd(fl); +0, +EoS.dpdT(fv), +EoS.dpTd(fv); +EoS.dgdT(fl), -EoS.dgdT(fv), EoS.dgTd(fl) - EoS.dgTd(fv)];
            NS := -Modelica.Math.Matrices.solve(Jacobian, RES);
            sat.liq.d := sat.liq.d + lambda * NS[1];
            sat.vap.d := sat.vap.d + lambda * NS[2];
            sat.Tsat := sat.Tsat + lambda * NS[3];
            sat.liq.d := max(sat.liq.d, 0.98 * d_crit);
            sat.liq.d := min(sat.liq.d, 1.02 * dl_trip);
            sat.vap.d := max(sat.vap.d, 0.98 * dv_trip);
            sat.vap.d := min(sat.vap.d, 1.02 * d_crit);
            sat.Tsat := max(sat.Tsat, 0.98 * T_trip);
            sat.Tsat := min(sat.Tsat, 1.02 * T_crit);
            fl := EoS.setHelmholtzDerivsSecond(d = sat.liq.d, T = sat.Tsat, phase = 1);
            fv := EoS.setHelmholtzDerivsSecond(d = sat.vap.d, T = sat.Tsat, phase = 1);
            RES := {EoS.p(fl) - p, EoS.p(fv) - p, EoS.g(fl) - EoS.g(fv)};
            RSS := RES * RES / 2;
          end while;
          assert(iter < iter_max, "setSat_p did not converge, input was p=" + String(p) + "; the remaining residuals are RES_pl=" + String(RES[1]) + " and RES_pv=" + String(RES[2]) + " and RES_g=" + String(RES[3]));
          sat.liq.d := max(sat.liq.d, d_crit);
          sat.liq.d := min(sat.liq.d, dl_trip);
          sat.vap.d := max(sat.vap.d, dv_trip);
          sat.vap.d := min(sat.vap.d, d_crit);
          sat.Tsat := max(sat.Tsat, T_trip);
          sat.Tsat := min(sat.Tsat, T_crit);
          sat.liq := setState_dTX(d = sat.liq.d, T = sat.Tsat, phase = 1);
          sat.vap := setState_dTX(d = sat.vap.d, T = sat.Tsat, phase = 1);
        elseif p >= p_crit then
          sat.psat := p;
          sat.liq := setState_pd(p = p, d = d_crit, phase = 1);
          sat.vap := sat.liq;
          sat.Tsat := sat.liq.T;
        elseif p <= p_trip then
          sat.psat := p;
          sat.liq := setState_dT(d = dl_trip, T = T_trip, phase = 1);
          sat.vap := setState_dT(d = dv_trip, T = T_trip, phase = 1);
          sat.Tsat := T_trip;
        else
          assert(false, "setSat_p: this should not happen, check p");
        end if;
      end setSat_p;

      redeclare function extends setBubbleState  "returns bubble ThermodynamicState from given saturation properties" 
      algorithm
        state := sat.liq;
      end setBubbleState;

      redeclare function extends setDewState  "returns dew ThermodynamicState from given saturation properties" 
      algorithm
        state := sat.vap;
      end setDewState;

      redeclare function extends setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
      algorithm
        state := ThermodynamicState(p = .Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), h = .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small), d = density_ph(p = .Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), h = .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small)), T = temperature_ph(p = .Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), h = .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small)), s = specificEntropy_ph(p = .Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), h = .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small)), u = state.h - state.p / state.d, phase = 0);
        annotation(Inline = true); 
      end setSmoothState;

      redeclare function extends setState_dTX  "Return thermodynamic state as function of (d, T)" 
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
      algorithm
        state.phase := phase;
        if state.phase == 0 then
          if T >= T_trip and T < T_crit then
            if d > 1.05 * Ancillary.bubbleDensity_T(T = T) or d < 0.98 * Ancillary.dewDensity_T(T = T) then
              state.phase := 1;
            else
              sat := setSat_T(T = T);
              if d < sat.liq.d and d > sat.vap.d then
                state.phase := 2;
              else
                state.phase := 1;
              end if;
            end if;
          else
            state.phase := 1;
          end if;
        elseif state.phase == 2 then
          assert(T <= T_crit, "setState_dTX_error: Temperature is higher than critical temperature");
          sat := setSat_T(T = T);
          assert(d >= sat.vap.d, "setState_dTX_error: density is lower than saturated vapor density: this is single phase vapor");
          assert(d <= sat.liq.d, "setState_dTX_error: density is higher than saturated liquid density: this is single phase liquid");
        else
        end if;
        state.d := d;
        state.T := T;
        if state.phase == 2 then
          x := (1.0 / d - 1.0 / sat.liq.d) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
          state.p := sat.psat;
          state.h := sat.liq.h + x * (sat.vap.h - sat.liq.h);
          state.u := sat.liq.u + x * (sat.vap.u - sat.liq.u);
          state.s := sat.liq.s + x * (sat.vap.s - sat.liq.s);
        else
          f := EoS.setHelmholtzDerivsFirst(d = d, T = T);
          state.p := EoS.p(f = f);
          state.s := EoS.s(f = f);
          state.h := EoS.h(f = f);
          state.u := EoS.u(f = f);
        end if;
      end setState_dTX;

      redeclare function extends setState_pTX  "Return thermodynamic state as function of (p, T)" 
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        EoS.HelmholtzDerivs f(T = T);
        SaturationProperties sat;
        Density d_min;
        Density d_max;
        Density d_iter;
        AbsolutePressure RES_p;
        AbsolutePressure RES_min;
        AbsolutePressure RES_max;
        DerPressureByDensity dpdT "(dp/dd)@T=const";
        Real gamma(min = 0.1, max = 1) = 1 "convergence speed, default=1";
        constant Real tolerance = 1e-9 "relativ tolerance for RES_p";
        Integer iter = 0;
        constant Integer iter_max = 200;
      algorithm
        assert(phase <> 2, "setState_pTX_error: pressure and temperature are not independent variables in two-phase state");
        state.phase := 1;
        if T < T_crit then
          sat.psat := Ancillary.saturationPressure_T(T = T);
          if p > 1.02 * sat.psat then
            sat.liq.d := Ancillary.bubbleDensity_T(T = T);
          elseif p < 0.98 * sat.psat then
            sat.vap.d := Ancillary.dewDensity_T(T = T);
          else
            sat := setSat_T(T = T);
          end if;
          if p > sat.psat then
            d_min := 0.98 * sat.liq.d;
            d_max := 1.10 * fluidLimits.DMAX;
            d_iter := 1.10 * sat.liq.d;
          elseif p < sat.psat then
            d_min := fluidLimits.DMIN;
            d_max := 1.02 * sat.vap.d;
            d_iter := Ancillary.density_pT_Soave(T = T, p = p, psat = sat.psat);
          else
            assert(p <> sat.psat, "setState_pTX_error: pressure equals saturation pressure");
          end if;
        else
          d_min := fluidLimits.DMIN;
          d_max := 1.1 * fluidLimits.DMAX;
          d_iter := Ancillary.density_pT_Soave(T = T, p = p, psat = sat.psat);
        end if;
        d_iter := max(d_iter, d_min);
        d_iter := min(d_iter, d_max);
        f.d := d_min;
        f.delta := f.d / d_crit;
        f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
        RES_min := EoS.p(f) - p;
        f.d := d_max;
        f.delta := f.d / d_crit;
        f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
        RES_max := EoS.p(f) - p;
        f.d := d_iter;
        f.delta := f.d / d_crit;
        f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
        RES_p := EoS.p(f) - p;
        assert(RES_min * RES_max < 0, "setState_pTX: d_min and d_max did not bracket the root", AssertionLevel.warning);
        if RES_p * RES_min < 0 then
          d_max := d_iter;
          RES_max := RES_p;
        elseif RES_p * RES_max < 0 then
          d_min := d_iter;
          RES_min := RES_p;
        else
        end if;
        while abs(RES_p / p) > tolerance and iter < iter_max loop
          iter := iter + 1;
          f.rdd := EoS.f_rdd(delta = f.delta, tau = f.tau);
          dpdT := EoS.dpdT(f);
          d_iter := d_iter - gamma / dpdT * RES_p;
          if d_iter < d_min or d_iter > d_max then
            d_iter := (d_min + d_max) / 2;
          else
          end if;
          f.d := d_iter;
          f.delta := f.d / d_crit;
          f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
          RES_p := EoS.p(f) - p;
          if RES_p * RES_min < 0 then
            d_max := d_iter;
            RES_max := RES_p;
          elseif RES_p * RES_max < 0 then
            d_min := d_iter;
            RES_min := RES_p;
          else
          end if;
        end while;
        assert(iter < iter_max, "setState_pTX did not converge, input was p=" + String(p) + " and T=" + String(T));
        state.p := p;
        state.T := T;
        state.d := d_iter;
        f := EoS.setHelmholtzDerivsFirst(d = state.d, T = state.T);
        state.s := EoS.s(f = f);
        state.h := EoS.h(f = f);
        state.u := EoS.u(f = f);
      end setState_pTX;

      redeclare function extends setState_phX  "Return thermodynamic state as function of (p, h)" 
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        Real delta "reduced density";
        Real tau "inverse reduced temperature";
        constant AbsolutePressure p_trip = fluidConstants[1].triplePointPressure;
        constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
        constant SpecificEnthalpy h_crit = fluidConstants[1].HCRIT0;
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        Density d_min;
        Density d_max;
        Density d_iter;
        Density d_iter_old;
        Temperature T_min;
        Temperature T_max;
        Temperature T_iter;
        Temperature T_iter_old;
        Real[2] RES "residual function vector";
        Real RSS "residual sum of squares";
        Real RSS_old "residual sum of squares";
        Real[2, 2] Jacobian "Jacobian matrix";
        Real[2] NS "Newton step vector";
        Real[2] grad "gradient vector";
        Real slope;
        constant Real tolerance = 1e-9 "tolerance for RSS";
        Integer iter = 0;
        Integer iter_max = 200;
        Real lambda(min = 1e-3, max = 1) = 1 "convergence speed, default=1";
        Boolean useLineSearch = helmholtzCoefficients.useLineSearch;
        Integer iterLineSearch = 0;
        Real RSS_ls;
        Real lambda_ls;
        constant Real lambda_min = 0.01 "minimum for convergence speed";
        Real lambda_temp = 1 "temporary variable for convergence speed";
        constant Real alpha(min = 0, max = 1) = 1e-4;
        Real rhs1;
        Real rhs2;
        Real a;
        Real b;
        Real Discriminant;
      algorithm
        state.phase := phase;
        if state.phase == 2 then
          assert(p <= p_crit, "setState_phX_error: pressure is higher than critical pressure");
          sat := setSat_p(p = p);
          assert(h >= sat.liq.h, "setState_phX_error: enthalpy is lower than saturated liquid enthalpy: this is single phase liquid");
          assert(h <= sat.vap.h, "setState_phX_error: enthalpy is higher than saturated vapor enthalpy: this is single phase vapor");
        else
          if p < p_crit then
            if p > 0.98 * p_crit or p < 300 * p_trip then
              sat := setSat_p(p = p);
            else
              sat.Tsat := Ancillary.saturationTemperature_p(p = p);
              sat.liq.d := Ancillary.bubbleDensity_T(T = sat.Tsat);
              f := EoS.setHelmholtzDerivsFirst(d = sat.liq.d, T = sat.Tsat, phase = 1);
              sat.liq.h := EoS.h(f);
              sat.vap.d := Ancillary.dewDensity_T(T = sat.Tsat);
              f := EoS.setHelmholtzDerivsFirst(d = sat.vap.d, T = sat.Tsat, phase = 1);
              sat.vap.h := EoS.h(f);
              if h > sat.liq.h - abs(0.02 * sat.liq.h) and h < sat.vap.h + abs(0.02 * sat.vap.h) then
                sat := setSat_p(p = p);
              else
              end if;
            end if;
            if h < sat.liq.h then
              state.phase := 1;
              d_min := sat.liq.d * 0.98;
              d_iter := sat.liq.d * 1.02;
              d_max := fluidLimits.DMAX * 1.10;
              T_min := fluidLimits.TMIN * 0.99;
              T_iter := sat.Tsat * 0.98;
              T_max := sat.Tsat * 1.02;
            elseif h > sat.vap.h then
              state.phase := 1;
              d_min := fluidLimits.DMIN;
              d_iter := sat.vap.d / 10;
              d_max := sat.vap.d * 1.02;
              T_min := sat.Tsat * 0.98;
              T_iter := sat.Tsat * 1.02;
              T_max := fluidLimits.TMAX * 1.10;
            else
              state.phase := 2;
            end if;
          else
            state.phase := 1;
            if h <= h_crit then
              d_min := d_crit * 0.99;
              d_iter := fluidLimits.DMAX * 0.85;
              d_max := fluidLimits.DMAX * 1.1;
              T_min := fluidLimits.TMIN;
              T_max := 1.25 * Ancillary.saturationTemperature_h_liq(h = h);
              T_iter := (1 * T_min + 5 * T_max / 1.25) / 6;
            else
              d_min := fluidLimits.DMIN;
              d_iter := d_crit / 10;
              d_max := fluidLimits.DMAX * 1.1;
              T_min := fluidLimits.TMIN;
              T_iter := T_crit * 1.3;
              T_max := fluidLimits.TMAX * 1.1;
            end if;
          end if;
        end if;
        if state.phase == 2 then
          state.p := p;
          state.h := h;
          state.T := sat.Tsat;
          x := (h - sat.liq.h) / (sat.vap.h - sat.liq.h);
          state.d := 1 / (1 / sat.liq.d + x * (1 / sat.vap.d - 1 / sat.liq.d));
          state.u := sat.liq.u + x * (sat.vap.u - sat.liq.u);
          state.s := sat.liq.s + x * (sat.vap.s - sat.liq.s);
        else
          f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
          RES := {EoS.p(f) - p, EoS.h(f) - h};
          RSS := RES * RES / 2;
          while RSS > tolerance and iter < iter_max loop
            iter := iter + 1;
            Jacobian := [EoS.dpdT(f), EoS.dpTd(f); EoS.dhdT(f), EoS.dhTd(f)];
            NS := -Modelica.Math.Matrices.solve(Jacobian, RES) "-J^(-1)*F";
            grad := RES * Jacobian "F*J";
            slope := grad * NS;
            assert(slope < 0, "roundoff problem, input was p=" + String(p) + " and h=" + String(h));
            d_iter_old := d_iter;
            T_iter_old := T_iter;
            RSS_old := RSS;
            d_iter := d_iter_old + NS[1];
            T_iter := T_iter_old + NS[2];
            d_iter := max(d_iter, d_min);
            d_iter := min(d_iter, d_max);
            T_iter := max(T_iter, T_min);
            T_iter := min(T_iter, T_max);
            f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
            RES := {EoS.p(f) - p, EoS.h(f) - h};
            RSS := RES * RES / 2;
            while useLineSearch and lambda >= lambda_min and not RSS <= RSS_old + alpha * lambda * slope loop
              iterLineSearch := iterLineSearch + 1;
              iter_max := iter_max + 1;
              if iterLineSearch < 2 then
                lambda_temp := -slope / (2 * (RSS - RSS_old - slope));
              else
                rhs1 := RSS - RSS_old - lambda * slope;
                rhs2 := RSS_ls - RSS_old - lambda_ls * slope;
                a := (rhs1 / lambda ^ 2 - rhs2 / lambda_ls ^ 2) / (lambda - lambda_ls);
                b := ((-lambda_ls * rhs1 / lambda ^ 2) + lambda * rhs2 / lambda_ls ^ 2) / (lambda - lambda_ls);
                if a == 0 then
                  lambda_temp := -slope / (2 * b);
                else
                  Discriminant := b * b - 3 * a * slope;
                  if Discriminant < 0 then
                    lambda_temp := 0.5 * lambda;
                  elseif b <= 0 then
                    lambda_temp := ((-b) + sqrt(Discriminant)) / (3 * a);
                  else
                    lambda_temp := -slope / (b + sqrt(Discriminant));
                  end if;
                  lambda_temp := if lambda_temp > 0.5 * lambda then 0.5 * lambda else lambda_temp;
                end if;
              end if;
              lambda_ls := lambda;
              RSS_ls := RSS;
              lambda := max({lambda_temp, 0.1 * lambda});
              d_iter := d_iter_old + lambda * NS[1];
              T_iter := T_iter_old + lambda * NS[2];
              d_iter := max(d_iter, d_min);
              d_iter := min(d_iter, d_max);
              T_iter := max(T_iter, T_min);
              T_iter := min(T_iter, T_max);
              f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
              RES := {EoS.p(f) - p, EoS.h(f) - h};
              RSS := RES * RES / 2;
            end while;
            iterLineSearch := 0;
            lambda_temp := 1;
            lambda := 1;
          end while;
          assert(iter < iter_max, "setState_phX did not converge, input was p=" + String(p) + " and h=" + String(h));
          state.p := p;
          state.h := h;
          state.d := d_iter;
          state.T := T_iter;
          state.u := EoS.u(f);
          state.s := EoS.s(f);
        end if;
      end setState_phX;

      redeclare function extends setState_psX  "Return thermodynamic state as function of (p, s)" 
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        Real delta "reduced density";
        Real tau "inverse reduced temperature";
        constant AbsolutePressure p_trip = fluidConstants[1].triplePointPressure;
        constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
        constant SpecificEntropy s_crit = fluidConstants[1].SCRIT0;
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        Density d_min;
        Density d_max;
        Density d_iter;
        Density d_iter_old;
        Temperature T_min;
        Temperature T_max;
        Temperature T_iter;
        Temperature T_iter_old;
        Real[2] RES "residual function vector";
        Real RSS "residual sum of squares (divided by 2)";
        Real RSS_old "residual sum of squares (divided by 2)";
        Real[2, 2] Jacobian "Jacobian matrix";
        Real[2] NS "Newton step vector";
        Real[2] grad "gradient vector";
        Real slope;
        EoS.HelmholtzDerivs f_med;
        Real[2] RES_med "residual function vector";
        Real[2] xy;
        Real[2] xy_old;
        Real[2] xy_med;
        Real[2, 2] Jacobian_med "Jacobian matrix";
        constant Real tolerance = 1e-7 "tolerance for RSS";
        Integer iter = 0;
        Integer iter_max = 200;
        Real lambda(min = 1e-3, max = 1) = 1 "convergence speed, default=1";
        Boolean useLineSearch = helmholtzCoefficients.useLineSearch;
        Integer iterLineSearch = 0;
        Real RSS_ls;
        Real lambda_ls;
        constant Real lambda_min = 0.01 "minimum for convergence speed";
        Real lambda_temp = 1 "temporary variable for convergence speed";
        constant Real alpha(min = 0, max = 1) = 1e-4;
        Real rhs1;
        Real rhs2;
        Real a;
        Real b;
        Real Discriminant;
        ThermodynamicState state_ref;
      algorithm
        state.phase := phase;
        if state.phase == 2 then
          assert(p <= p_crit, "setState_psX_error: pressure is higher than critical pressure");
          sat := setSat_p(p = p);
          assert(s >= sat.liq.s, "setState_psX_error: entropy is lower than saturated liquid entropy: this is single phase liquid");
          assert(s <= sat.vap.s, "setState_psX_error: entropy is higher than saturated vapor entropy: this is single phase vapor");
        else
          if p <= p_crit then
            if p > 0.98 * p_crit or p < 300 * p_trip then
              sat := setSat_p(p = p);
            else
              sat.Tsat := Ancillary.saturationTemperature_p(p = p);
              sat.liq.d := Ancillary.bubbleDensity_T(T = sat.Tsat);
              f := EoS.setHelmholtzDerivsFirst(d = sat.liq.d, T = sat.Tsat, phase = 1);
              sat.liq.s := EoS.s(f);
              sat.vap.d := Ancillary.dewDensity_T(T = sat.Tsat);
              f := EoS.setHelmholtzDerivsFirst(d = sat.vap.d, T = sat.Tsat, phase = 1);
              sat.vap.s := EoS.s(f);
              if s > sat.liq.s - abs(0.05 * sat.liq.s) and s < sat.vap.s + abs(0.05 * sat.vap.s) then
                sat := setSat_p(p = p);
              else
              end if;
            end if;
            if s < sat.liq.s then
              state.phase := 1;
              d_min := sat.liq.d * 0.98;
              d_max := fluidLimits.DMAX * 1.10;
              d_iter := sat.liq.d * 1.10;
              T_min := fluidLimits.TMIN * 0.99;
              T_max := sat.Tsat * 1.02;
              T_iter := sat.Tsat * 0.95;
            elseif s > sat.vap.s then
              state.phase := 1;
              d_min := fluidLimits.DMIN;
              d_max := sat.vap.d * 1.02;
              d_iter := sat.vap.d / 10;
              T_min := sat.Tsat * 0.98;
              T_max := fluidLimits.TMAX * 1.10;
              T_iter := sat.Tsat * 1.02;
            else
              state.phase := 2;
            end if;
          else
            state.phase := 1;
            if s <= s_crit then
              state_ref := setState_pT(p = p, T = T_crit);
              if s < state_ref.s then
                T_min := max(fluidLimits.TMIN * 0.99, Ancillary.saturationTemperature_s_liq(s = s) * 0.95);
                T_max := T_crit;
                T_iter := 0.95 * T_crit;
              elseif s > state_ref.s then
                T_min := T_crit;
                T_max := fluidLimits.TMAX * 1.1;
                T_iter := 1.05 * T_crit;
              else
                T_min := 0.95 * T_crit;
                T_max := 1.05 * T_crit;
                T_iter := T_crit;
              end if;
              d_min := d_crit * 0.99;
              d_max := fluidLimits.DMAX * 1.1;
              d_iter := fluidLimits.DMAX * 0.9;
            else
              state_ref := setState_pd(p = p, d = d_crit);
              if s > state_ref.s then
                d_min := fluidLimits.DMIN * 0.99;
                d_max := d_crit;
                d_iter := 0.95 * d_crit;
              elseif s < state_ref.s then
                d_min := d_crit;
                d_max := fluidLimits.DMAX * 1.1;
                d_iter := 1.05 * d_crit;
              else
                d_min := 0.95 * d_crit;
                d_max := 1.05 * d_crit;
                d_iter := d_crit;
              end if;
              T_min := T_crit * 0.98;
              T_max := fluidLimits.TMAX * 1.1;
              T_iter := T_crit * 1.3;
            end if;
          end if;
        end if;
        if state.phase == 2 then
          state.p := p;
          state.s := s;
          state.T := sat.Tsat;
          x := (s - sat.liq.s) / (sat.vap.s - sat.liq.s);
          state.d := 1 / (1 / sat.liq.d + x * (1 / sat.vap.d - 1 / sat.liq.d));
          state.u := sat.liq.u + x * (sat.vap.u - sat.liq.u);
          state.h := sat.liq.h + x * (sat.vap.h - sat.liq.h);
        else
          f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
          RES := {EoS.p(f) - p, EoS.s(f) - s};
          RSS := RES * RES / 2;
          while RSS > tolerance and iter < iter_max loop
            iter := iter + 1;
            Jacobian := [EoS.dpdT(f), EoS.dpTd(f); EoS.dsdT(f), EoS.dsTd(f)];
            NS := -Modelica.Math.Matrices.solve(Jacobian, RES) "-J^(-1)*F";
            grad := RES * Jacobian "F*J";
            slope := grad * NS;
            assert(slope < 0, "roundoff problem, input was p=" + String(p) + " and s=" + String(s), AssertionLevel.warning);
            d_iter_old := d_iter;
            T_iter_old := T_iter;
            RSS_old := RSS;
            d_iter := d_iter_old + NS[1];
            T_iter := T_iter_old + NS[2];
            d_iter := max(d_iter, d_min);
            d_iter := min(d_iter, d_max);
            T_iter := max(T_iter, T_min);
            T_iter := min(T_iter, T_max);
            f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
            RES := {EoS.p(f) - p, EoS.s(f) - s};
            RSS := RES * RES / 2;
            while useLineSearch and lambda >= lambda_min and not RSS <= RSS_old + alpha * lambda * slope loop
              iterLineSearch := iterLineSearch + 1;
              iter_max := iter_max + 1;
              if iterLineSearch < 2 then
                lambda_temp := -slope / (2 * (RSS - RSS_old - slope));
              else
                rhs1 := RSS - RSS_old - lambda * slope;
                rhs2 := RSS_ls - RSS_old - lambda_ls * slope;
                a := (rhs1 / lambda ^ 2 - rhs2 / lambda_ls ^ 2) / (lambda - lambda_ls);
                b := ((-lambda_ls * rhs1 / lambda ^ 2) + lambda * rhs2 / lambda_ls ^ 2) / (lambda - lambda_ls);
                if a == 0 then
                  lambda_temp := -slope / (2 * b);
                else
                  Discriminant := b * b - 3 * a * slope;
                  if Discriminant < 0 then
                    lambda_temp := 0.5 * lambda;
                  elseif b <= 0 then
                    lambda_temp := ((-b) + sqrt(Discriminant)) / (3 * a);
                  else
                    lambda_temp := -slope / (b + sqrt(Discriminant));
                  end if;
                  lambda_temp := if lambda_temp > 0.5 * lambda then 0.5 * lambda else lambda_temp;
                end if;
              end if;
              lambda_ls := lambda;
              RSS_ls := RSS;
              lambda := max({lambda_temp, 0.1 * lambda});
              d_iter := d_iter_old + lambda * NS[1];
              T_iter := T_iter_old + lambda * NS[2];
              d_iter := max(d_iter, d_min);
              d_iter := min(d_iter, d_max);
              T_iter := max(T_iter, T_min);
              T_iter := min(T_iter, T_max);
              f := EoS.setHelmholtzDerivsSecond(d = d_iter, T = T_iter, phase = 1);
              RES := {EoS.p(f) - p, EoS.s(f) - s};
              RSS := RES * RES / 2;
            end while;
            iterLineSearch := 0;
            lambda_temp := 1;
            lambda := 1;
          end while;
          assert(iter < iter_max, "setState_psX did not converge, input was p=" + String(p) + " and s=" + String(s) + ", remaining residual is RES_p=" + String(RES[1]) + " and RES_s=" + String(RES[2]));
          state.p := p;
          state.s := s;
          state.d := d_iter;
          state.T := T_iter;
          state.u := EoS.u(f);
          state.h := EoS.h(f);
        end if;
      end setState_psX;

      function setState_pd  "Return thermodynamic state as function of (p, d)" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Density d "Density";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output ThermodynamicState state "thermodynamic state record";
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant SpecificHeatCapacity R = Modelica.Constants.R / MM "specific gas constant";
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant Temperature T_trip = fluidConstants[1].triplePointTemperature;
        constant Temperature T_crit = fluidConstants[1].criticalTemperature;
        constant AbsolutePressure p_trip = fluidConstants[1].triplePointPressure;
        constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
        EoS.HelmholtzDerivs f(d = d);
        SaturationProperties sat;
        MassFraction x "vapour quality";
        Temperature T_min = 0.98 * fluidLimits.TMIN;
        Temperature T_max = 2 * max(fluidLimits.TMAX, p / (R * d));
        Temperature T_iter = T_crit;
        AbsolutePressure RES_min;
        AbsolutePressure RES_max;
        AbsolutePressure RES_p;
        DerPressureByTemperature dpTd "(dp/dT)@d=const";
        Real gamma(min = 0.1, max = 1) = 1 "convergence speed, default=1";
        constant Real tolerance = 1e-9 "relative tolerance for RES_p";
        Integer iter = 0;
        constant Integer iter_max = 200;
      algorithm
        state.phase := phase;
        if state.phase == 2 then
          assert(p <= p_crit, "setState_pdX_error: pressure is higher than critical pressure");
          sat := setSat_p(p = p);
          assert(d <= sat.liq.d, "setState_pdX_error: density is higher than saturated liquid density: this is single phase liquid");
          assert(d >= sat.vap.d, "setState_pdX_error: density is lower than saturated vapor density: this is single phase vapor");
        else
          if p < p_crit and p >= p_trip then
            if p > 0.98 * p_crit or p < 300 * p_trip then
              sat := setSat_p(p = p);
            else
              sat.Tsat := Ancillary.saturationTemperature_p(p = p);
              sat.liq.d := Ancillary.bubbleDensity_T(T = sat.Tsat);
              sat.vap.d := Ancillary.dewDensity_T(T = sat.Tsat);
              if d < sat.liq.d + abs(0.05 * sat.liq.d) and d > sat.vap.d - abs(0.05 * sat.vap.d) then
                sat := setSat_p(p = p);
              else
              end if;
            end if;
            if d > sat.liq.d then
              state.phase := 1;
              T_min := 0.98 * Ancillary.saturationTemperature_d(d = d);
              T_max := 1.02 * sat.Tsat;
              T_iter := 1.1 * T_min;
            elseif d < sat.vap.d then
              state.phase := 1;
              T_min := 0.99 * sat.Tsat;
              T_iter := Ancillary.temperature_pd_Waals(p = p, d = d);
            else
              state.phase := 2;
            end if;
          elseif p < p_trip then
            state.phase := 1;
            T_iter := p / (d * R);
          elseif p >= p_crit then
            state.phase := 1;
            if d > d_crit then
              T_min := 0.98 * Ancillary.saturationTemperature_d(d = d);
              T_iter := 1.05 * T_min;
            else
              T_min := 0.98 * T_crit;
              T_iter := Ancillary.temperature_pd_Waals(p = p, d = d);
              T_max := 25 * fluidLimits.TMAX;
            end if;
          else
            assert(false, "setState_pd: this should not happen, check p");
          end if;
        end if;
        T_iter := max({T_iter, T_min, fluidLimits.TMIN});
        T_iter := min({T_iter, T_max, fluidLimits.TMAX});
        if state.phase == 2 then
          state.p := p;
          state.d := d;
          x := (1.0 / d - 1.0 / sat.liq.d) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
          state.T := sat.Tsat;
          state.h := sat.liq.h + x * (sat.vap.h - sat.liq.h);
          state.u := sat.liq.u + x * (sat.vap.u - sat.liq.u);
          state.s := sat.liq.s + x * (sat.vap.s - sat.liq.s);
        else
          f.T := T_min;
          f.tau := T_crit / f.T;
          f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
          RES_min := EoS.p(f) - p;
          f.T := T_max;
          f.tau := T_crit / f.T;
          f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
          RES_max := EoS.p(f) - p;
          f.T := T_iter;
          f.tau := T_crit / f.T;
          f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
          RES_p := EoS.p(f) - p;
          assert(RES_min * RES_max < 0, "setState_pd: T_min=" + String(T_min) + " and T_max=" + String(T_max) + " did not bracket the root, input was p=" + String(p) + " and d=" + String(d), AssertionLevel.warning);
          if RES_p * RES_min < 0 then
            T_max := T_iter;
            RES_max := RES_p;
          elseif RES_p * RES_max < 0 then
            T_min := T_iter;
            RES_min := RES_p;
          else
          end if;
          while abs(RES_p / p) > tolerance and iter < iter_max loop
            iter := iter + 1;
            f.rtd := EoS.f_rtd(delta = f.delta, tau = f.tau);
            dpTd := EoS.dpTd(f);
            T_iter := T_iter - gamma / dpTd * RES_p;
            if T_iter < 0.95 * T_min or T_iter > 1.05 * T_max then
              T_iter := (T_min + T_max) / 2;
            else
            end if;
            f.T := T_iter;
            f.tau := T_crit / f.T;
            f.rd := EoS.f_rd(delta = f.delta, tau = f.tau);
            RES_p := EoS.p(f) - p;
            if RES_p * RES_min < 0 then
              T_max := T_iter;
              RES_max := RES_p;
            elseif RES_p * RES_max < 0 then
              T_min := T_iter;
              RES_min := RES_p;
            else
            end if;
          end while;
          assert(iter < iter_max, "setState_pdX did not converge (RES_p=" + String(RES_p) + "), input was p=" + String(p) + " and d=" + String(d));
          state.p := p;
          state.d := d;
          state.T := T_iter;
          f := EoS.setHelmholtzDerivsFirst(d = state.d, T = state.T);
          state.h := EoS.h(f);
          state.u := EoS.u(f);
          state.s := EoS.s(f);
        end if;
      end setState_pd;

      redeclare function extends temperature  "returns temperature from given ThermodynamicState" 
      algorithm
        T := state.T;
        annotation(Inline = true); 
      end temperature;

      redeclare function extends density  "returns density from given ThermodynamicState" 
      algorithm
        d := state.d;
        annotation(Inline = true); 
      end density;

      redeclare function extends pressure  "returns pressure from given ThermodynamicState" 
      algorithm
        p := state.p;
        annotation(Inline = true); 
      end pressure;

      redeclare function extends specificInternalEnergy  "returns specificEnergy from given ThermodynamicState" 
      algorithm
        u := state.u;
        annotation(Inline = true); 
      end specificInternalEnergy;

      redeclare function extends specificEntropy  "returns specificEntropy from given ThermodynamicState" 
      algorithm
        s := state.s;
        annotation(Inline = true); 
      end specificEntropy;

      redeclare function extends specificEnthalpy  "returns specificEnthalpy from given ThermodynamicState" 
      algorithm
        h := state.h;
        annotation(Inline = true); 
      end specificEnthalpy;

      function vapourQuality_sat  "returns the vapour quality" 
        input ThermodynamicState state;
        input SaturationProperties sat;
        output MassFraction x;
      protected
        Temperature T_trip = fluidConstants[1].triplePointTemperature;
        Temperature T_crit = fluidConstants[1].criticalTemperature;
      algorithm
        assert(state.T >= T_trip, "vapourQuality warning: Temperature is lower than triple-point temperature", AssertionLevel.warning);
        assert(state.T <= T_crit, "vapourQuality warning: Temperature is higher than critical temperature", AssertionLevel.warning);
        if state.d <= sat.vap.d then
          x := 1;
        elseif state.d >= sat.liq.d then
          x := 0;
        else
          x := (1.0 / state.d - 1.0 / sat.liq.d) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
        end if;
      end vapourQuality_sat;

      redeclare function extends specificHeatCapacityCp  "returns the isobaric specific heat capcacity" 
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          cp := EoS.dhTd(f) - EoS.dhdT(f) * EoS.dpTd(f) / EoS.dpdT(f);
        elseif state.phase == 2 then
          assert(false, "specificHeatCapacityCp warning: in the two-phase region cp is infinite", AssertionLevel.warning);
          cp := Modelica.Constants.inf;
        else
        end if;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv  "returns the isochoric specific heat capcacity" 
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        DerPressureByTemperature dpT;
        EoS.HelmholtzDerivs fl;
        EoS.HelmholtzDerivs fv;
        DerEnergyByTemperature duT_liq;
        DerEnergyByTemperature duT_vap;
        DerDensityByTemperature ddT_liq;
        DerDensityByTemperature ddT_vap;
        DerVolumeByTemperature dvT_liq;
        DerVolumeByTemperature dvT_vap;
        DerFractionByTemperature dxTv;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          cv := EoS.duTd(f);
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          x := vapourQuality_sat(state = state, sat = sat);
          dpT := saturationPressure_derT_sat(sat = sat);
          fl := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.liq.d, phase = 1);
          fv := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.vap.d, phase = 1);
          duT_liq := EoS.duTd(fl) - EoS.dudT(fl) * EoS.dpTd(fl) / EoS.dpdT(fl) + EoS.dudT(fl) / EoS.dpdT(fl) * dpT;
          duT_vap := EoS.duTd(fv) - EoS.dudT(fv) * EoS.dpTd(fv) / EoS.dpdT(fv) + EoS.dudT(fv) / EoS.dpdT(fv) * dpT;
          ddT_liq := (-EoS.dpTd(fl) / EoS.dpdT(fl)) + 1.0 / EoS.dpdT(fl) * dpT;
          ddT_vap := (-EoS.dpTd(fv) / EoS.dpdT(fv)) + 1.0 / EoS.dpdT(fv) * dpT;
          dvT_liq := -1 / sat.liq.d ^ 2 * ddT_liq;
          dvT_vap := -1 / sat.vap.d ^ 2 * ddT_vap;
          dxTv := (x * dvT_vap + (1 - x) * dvT_liq) / (1 / sat.liq.d - 1 / sat.vap.d);
          cv := duT_liq + dxTv * (sat.vap.u - sat.liq.u) + x * (duT_vap - duT_liq);
        else
        end if;
      end specificHeatCapacityCv;

      redeclare function extends velocityOfSound  "returns the speed or velocity of sound" 
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        DerTemperatureByPressure dTp;
        EoS.HelmholtzDerivs fl;
        EoS.HelmholtzDerivs fv;
        DerEntropyByPressure dsp_liq;
        DerEntropyByPressure dsp_vap;
        DerDensityByPressure ddp_liq;
        DerDensityByPressure ddp_vap;
        DerVolumeByPressure dvp_liq;
        DerVolumeByPressure dvp_vap;
        DerVolumeByPressure dvps;
        DerFractionByPressure dxps;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          a := sqrt(EoS.dpdT(f) - EoS.dpTd(f) * EoS.dsdT(f) / EoS.dsTd(f));
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          x := vapourQuality_sat(state = state, sat = sat);
          dTp := saturationTemperature_derp_sat(sat = sat);
          fl := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.liq.d, phase = 1);
          fv := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.vap.d, phase = 1);
          dsp_liq := EoS.dsdT(fl) / EoS.dpdT(fl) + (EoS.dsTd(fl) - EoS.dsdT(fl) * EoS.dpTd(fl) / EoS.dpdT(fl)) * dTp;
          dsp_vap := EoS.dsdT(fv) / EoS.dpdT(fv) + (EoS.dsTd(fv) - EoS.dsdT(fv) * EoS.dpTd(fv) / EoS.dpdT(fv)) * dTp;
          ddp_liq := 1.0 / EoS.dpdT(fl) - EoS.dpTd(fl) / EoS.dpdT(fl) * dTp;
          ddp_vap := 1.0 / EoS.dpdT(fv) - EoS.dpTd(fv) / EoS.dpdT(fv) * dTp;
          dvp_liq := -1.0 / sat.liq.d ^ 2 * ddp_liq;
          dvp_vap := -1.0 / sat.vap.d ^ 2 * ddp_vap;
          dxps := (x * dsp_vap + (1 - x) * dsp_liq) / (sat.liq.s - sat.vap.s);
          dvps := dvp_liq + dxps * (1.0 / sat.vap.d - 1.0 / sat.liq.d) + x * (dvp_vap - dvp_liq);
          a := sqrt(-1.0 / (state.d * state.d * dvps));
        else
        end if;
      end velocityOfSound;

      redeclare function extends isobaricExpansionCoefficient  "returns 1/v*(dv/dT)@p=const" 
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          beta := 1.0 / state.d * EoS.dpTd(f) / EoS.dpdT(f);
        elseif state.phase == 2 then
          assert(false, "isobaricExpansionCoefficient warning: in the two-phase region beta is zero", AssertionLevel.warning);
          beta := Modelica.Constants.small;
        else
        end if;
      end isobaricExpansionCoefficient;

      redeclare function extends isothermalCompressibility  "returns -1/v*(dv/dp)@T=const" 
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          kappa := 1.0 / state.d / EoS.dpdT(f);
        elseif state.phase == 2 then
          assert(false, "isothermalCompressibility warning: in the two-phase region kappa is infinite", AssertionLevel.warning);
          kappa := Modelica.Constants.inf;
        else
        end if;
      end isothermalCompressibility;

      redeclare function extends isentropicExponent  "returns -v/p*(dp/dv)@s=const" 
      algorithm
        gamma := state.d / state.p * velocityOfSound(state) ^ 2;
        annotation(Inline = true); 
      end isentropicExponent;

      redeclare function extends isentropicEnthalpy  "returns isentropic enthalpy" 
      algorithm
        h_is := specificEnthalpy(setState_ps(p = p_downstream, s = specificEntropy(refState)));
        annotation(Inline = true); 
      end isentropicEnthalpy;

      function jouleThomsonCoefficient  "returns Joule-Thomson-Coefficient (dT/dp)@h=const" 
        input ThermodynamicState state;
        output DerTemperatureByPressure mu;
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          mu := 1.0 / (EoS.dpTd(f) - EoS.dpdT(f) * EoS.dhTd(f) / EoS.dhdT(f));
        elseif state.phase == 2 then
          mu := saturationTemperature_derp_sat(sat = setSat_T(T = state.T));
        else
        end if;
      end jouleThomsonCoefficient;

      function isothermalThrottlingCoefficient  "returns isothermal throttling coefficient (dh/dp)@T=const" 
        input ThermodynamicState state;
        output DerEnthalpyByPressure delta_T;
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          delta_T := EoS.dhdT(f) / EoS.dpdT(f);
        elseif state.phase == 2 then
          assert(false, "isothermalThrottlingCoefficient warning: in the two-phase region delta_T is infinite", AssertionLevel.warning);
          delta_T := Modelica.Constants.inf;
        else
        end if;
      end isothermalThrottlingCoefficient;

      redeclare replaceable function extends dynamicViscosity  "Returns dynamic Viscosity" 
      algorithm
        assert(state.phase <> 2, "dynamicViscosity warning: property not defined in two-phase region", AssertionLevel.warning);
        eta := Transport.dynamicViscosity(state);
      end dynamicViscosity;

      redeclare replaceable function extends thermalConductivity  "Return thermal conductivity" 
      algorithm
        assert(state.phase <> 2, "thermalConductivity warning: property not defined in two-phase region", AssertionLevel.warning);
        lambda := Transport.thermalConductivity(state);
      end thermalConductivity;

      redeclare replaceable function extends surfaceTension  "Return surface tension sigma in the two phase region" 
      protected
        Temperature T_trip = fluidConstants[1].triplePointTemperature;
        Temperature T_crit = fluidConstants[1].criticalTemperature;
      algorithm
        assert(sat.Tsat >= T_trip, "surfaceTension error: Temperature is lower than triple-point temperature");
        assert(sat.Tsat <= T_crit, "surfaceTension error: Temperature is higher than critical temperature");
        sigma := Transport.surfaceTension(sat = sat);
      end surfaceTension;

      redeclare function extends bubbleEnthalpy  "returns specificEnthalpy from given SaturationProperties" 
      algorithm
        hl := sat.liq.h;
        annotation(Inline = true); 
      end bubbleEnthalpy;

      redeclare function extends dewEnthalpy  "returns specificEnthalpy from given SaturationProperties" 
      algorithm
        hv := sat.vap.h;
        annotation(Inline = true); 
      end dewEnthalpy;

      redeclare function extends dewEntropy  "returns specificEntropy from given SaturationProperties" 
      algorithm
        sv := sat.vap.s;
        annotation(Inline = true); 
      end dewEntropy;

      redeclare function extends bubbleEntropy  "returns specificEntropy from given SaturationProperties" 
      algorithm
        sl := sat.liq.s;
        annotation(Inline = true); 
      end bubbleEntropy;

      redeclare function extends dewDensity  "returns density from given SaturationProperties" 
      algorithm
        dv := sat.vap.d;
        annotation(Inline = true); 
      end dewDensity;

      redeclare function extends bubbleDensity  "returns density from given SaturationProperties" 
      algorithm
        dl := sat.liq.d;
        annotation(Inline = true); 
      end bubbleDensity;

      redeclare function extends saturationTemperature  
      algorithm
        T := saturationTemperature_sat(setSat_p(p = p));
        annotation(Inline = true); 
      end saturationTemperature;

      redeclare function extends saturationTemperature_derp  "returns (dT/dp)@sat" 
      protected
        constant MolarMass MM = fluidConstants[1].molarMass;
        constant Density d_crit = MM / fluidConstants[1].criticalMolarVolume;
        constant AbsolutePressure p_crit = fluidConstants[1].criticalPressure;
      algorithm
        dTp := if p < p_crit then saturationTemperature_derp_sat(sat = setSat_p(p = p)) else 1.0 / pressure_derT_d(state = setState_pd(p = p, d = d_crit));
        annotation(Inline = true); 
      end saturationTemperature_derp;

      redeclare function saturationTemperature_derp_sat  "returns (dT/dp)@sat" 
        input SaturationProperties sat;
        output DerTemperatureByPressure dTp;
      algorithm
        dTp := (1.0 / sat.vap.d - 1.0 / sat.liq.d) / (sat.vap.s - sat.liq.s);
        annotation(Inline = true); 
      end saturationTemperature_derp_sat;

      redeclare function extends saturationPressure  
      algorithm
        p := saturationPressure_sat(setSat_T(T = T));
        annotation(Inline = true); 
      end saturationPressure;

      function saturationPressure_derT_sat  "returns (dp/dT)@sat" 
        input SaturationProperties sat;
        output DerPressureByTemperature dpT;
      algorithm
        dpT := (sat.vap.s - sat.liq.s) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
        annotation(Inline = true); 
      end saturationPressure_derT_sat;

      redeclare function extends dBubbleDensity_dPressure  "Return bubble point density derivative" 
      protected
        EoS.HelmholtzDerivs f = EoS.setHelmholtzDerivsSecond(d = sat.liq.d, T = sat.liq.T);
        DerDensityByPressure ddpT = 1.0 / EoS.dpdT(f);
        DerDensityByTemperature ddTp = -EoS.dpTd(f) / EoS.dpdT(f);
        DerTemperatureByPressure dTp = saturationTemperature_derp(p = sat.psat);
      algorithm
        ddldp := ddpT + ddTp * dTp;
        annotation(Inline = true); 
      end dBubbleDensity_dPressure;

      redeclare function extends dDewDensity_dPressure  "Return dew point density derivative" 
      protected
        EoS.HelmholtzDerivs f = EoS.setHelmholtzDerivsSecond(d = sat.vap.d, T = sat.vap.T);
        DerDensityByPressure ddpT = 1.0 / EoS.dpdT(f);
        DerDensityByTemperature ddTp = -EoS.dpTd(f) / EoS.dpdT(f);
        DerTemperatureByPressure dTp = saturationTemperature_derp(p = sat.psat);
      algorithm
        ddvdp := ddpT + ddTp * dTp;
        annotation(Inline = true); 
      end dDewDensity_dPressure;

      redeclare function extends dBubbleEnthalpy_dPressure  "Return bubble point enthalpy derivative" 
      protected
        EoS.HelmholtzDerivs f = EoS.setHelmholtzDerivsSecond(d = sat.liq.d, T = sat.liq.T);
        DerEnthalpyByPressure dhpT = EoS.dhdT(f) / EoS.dpdT(f);
        DerEnthalpyByTemperature dhTp = EoS.dhTd(f) - EoS.dhdT(f) * EoS.dpTd(f) / EoS.dpdT(f);
        DerTemperatureByPressure dTp = saturationTemperature_derp(p = sat.psat);
      algorithm
        dhldp := dhpT + dhTp * dTp;
        annotation(Inline = true); 
      end dBubbleEnthalpy_dPressure;

      redeclare function extends dDewEnthalpy_dPressure  "Return dew point enthalpy derivative" 
      protected
        EoS.HelmholtzDerivs f = EoS.setHelmholtzDerivsSecond(d = sat.vap.d, T = sat.vap.T);
        DerEnthalpyByPressure dhpT = EoS.dhdT(f) / EoS.dpdT(f);
        DerEnthalpyByTemperature dhTp = EoS.dhTd(f) - EoS.dhdT(f) * EoS.dpTd(f) / EoS.dpdT(f);
        DerTemperatureByPressure dTp = saturationTemperature_derp(p = sat.psat);
      algorithm
        dhvdp := dhpT + dhTp * dTp;
        annotation(Inline = true); 
      end dDewEnthalpy_dPressure;

      redeclare function density_ph  "returns density for given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "density";
      algorithm
        d := density_ph_state(p = p, h = h, state = setState_ph(p = p, h = h, phase = phase));
        annotation(Inline = true, inverse(h = specificEnthalpy_pd(p = p, d = d, phase = phase))); 
      end density_ph;

      function density_ph_state  "returns density for given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Enthalpy";
        input ThermodynamicState state;
        output Density d "density";
      algorithm
        d := density(state);
        annotation(Inline = false, LateInline = true, derivative(noDerivative = state) = density_ph_der); 
      end density_ph_state;

      function density_ph_der  "time derivative of density_ph" 
        input AbsolutePressure p;
        input SpecificEnthalpy h;
        input ThermodynamicState state;
        input Real p_der "time derivative of pressure";
        input Real h_der "time derivative of specific enthalpy";
        output Real d_der "time derivative of density";
      algorithm
        d_der := p_der * density_derp_h(state = state) + h_der * density_derh_p(state = state);
        annotation(Inline = true); 
      end density_ph_der;

      redeclare function extends density_derp_h  "returns density derivative (dd/dp)@h=const" 
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        DerTemperatureByPressure dTp;
        EoS.HelmholtzDerivs fl;
        EoS.HelmholtzDerivs fv;
        DerEnthalpyByPressure dhp_liq;
        DerEnthalpyByPressure dhp_vap;
        DerDensityByPressure ddp_liq;
        DerDensityByPressure ddp_vap;
        DerVolumeByPressure dvp_liq;
        DerVolumeByPressure dvp_vap;
        DerVolumeByPressure dvph;
        DerFractionByPressure dxph;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          ddph := 1.0 / (EoS.dpdT(f) - EoS.dpTd(f) * EoS.dhdT(f) / EoS.dhTd(f));
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          x := vapourQuality_sat(state = state, sat = sat);
          dTp := saturationTemperature_derp_sat(sat = sat);
          fl := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.liq.d, phase = 1);
          fv := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.vap.d, phase = 1);
          dhp_liq := EoS.dhdT(fl) / EoS.dpdT(fl) + (EoS.dhTd(fl) - EoS.dhdT(fl) * EoS.dpTd(fl) / EoS.dpdT(fl)) * dTp;
          dhp_vap := EoS.dhdT(fv) / EoS.dpdT(fv) + (EoS.dhTd(fv) - EoS.dhdT(fv) * EoS.dpTd(fv) / EoS.dpdT(fv)) * dTp;
          ddp_liq := 1.0 / EoS.dpdT(fl) - EoS.dpTd(fl) / EoS.dpdT(fl) * dTp;
          ddp_vap := 1.0 / EoS.dpdT(fv) - EoS.dpTd(fv) / EoS.dpdT(fv) * dTp;
          dvp_liq := -1.0 / sat.liq.d ^ 2 * ddp_liq;
          dvp_vap := -1.0 / sat.vap.d ^ 2 * ddp_vap;
          dxph := (x * dhp_vap + (1 - x) * dhp_liq) / (sat.liq.h - sat.vap.h);
          dvph := dvp_liq + dxph * (1.0 / sat.vap.d - 1.0 / sat.liq.d) + x * (dvp_vap - dvp_liq);
          ddph := -state.d * state.d * dvph;
        else
        end if;
      end density_derp_h;

      redeclare function extends density_derh_p  "returns density derivative (dd/dh)@p=const" 
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          ddhp := 1.0 / (EoS.dhdT(f) - EoS.dhTd(f) * EoS.dpdT(f) / EoS.dpTd(f));
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          ddhp := -state.d ^ 2 * (1 / sat.liq.d - 1 / sat.vap.d) / (sat.liq.h - sat.vap.h);
        else
        end if;
      end density_derh_p;

      redeclare function temperature_ph  "returns temperature for given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature_ph_state(p = p, h = h, state = setState_ph(p = p, h = h, phase = phase));
        annotation(Inline = true, inverse(h = specificEnthalpy_pT(p = p, T = T, phase = phase))); 
      end temperature_ph;

      function temperature_ph_state  "returns temperature for given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Enthalpy";
        input ThermodynamicState state;
        output Temperature T "Temperature";
      algorithm
        T := temperature(state);
        annotation(Inline = false, LateInline = true, inverse(h = specificEnthalpy_pT_state(p = p, T = T, state = state)), derivative(noDerivative = state) = temperature_ph_der); 
      end temperature_ph_state;

      function temperature_ph_der  "time derivative of temperature_ph" 
        input AbsolutePressure p;
        input SpecificEnthalpy h;
        input ThermodynamicState state;
        input Real p_der "time derivative of pressure";
        input Real h_der "time derivative of specific enthalpy";
        output Real T_der "time derivative of temperature";
      algorithm
        T_der := p_der * jouleThomsonCoefficient(state = state) + h_der / specificHeatCapacityCp(state = state);
        annotation(Inline = true); 
      end temperature_ph_der;

      function specificEntropy_ph  "returns specific entropy for a given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific Enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEntropy s "Specific Entropy";
      algorithm
        s := specificEntropy_ph_state(p = p, h = h, state = setState_ph(p = p, h = h, phase = phase));
        annotation(Inline = true, inverse(h = specificEnthalpy_ps(p = p, s = s, phase = phase))); 
      end specificEntropy_ph;

      function specificEntropy_ph_state  "returns specific entropy for a given p and h" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific Enthalpy";
        input ThermodynamicState state;
        output SpecificEntropy s "Specific Entropy";
      algorithm
        s := specificEntropy(state);
        annotation(Inline = false, LateInline = true, derivative(noDerivative = state) = specificEntropy_ph_der); 
      end specificEntropy_ph_state;

      function specificEntropy_ph_der  
        input AbsolutePressure p;
        input SpecificEnthalpy h;
        input ThermodynamicState state;
        input Real p_der "time derivative of pressure";
        input Real h_der "time derivative of specific enthalpy";
        output Real s_der "time derivative of specific entropy";
      algorithm
        s_der := p_der * (-1.0 / (state.d * state.T)) + h_der * (1.0 / state.T);
        annotation(Inline = true); 
      end specificEntropy_ph_der;

      redeclare function density_pT  "Return density from p and T" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";
      algorithm
        d := density_pT_state(p = p, T = T, state = setState_pT(p = p, T = T, phase = phase));
        annotation(Inline = true, inverse(p = pressure_dT(d = d, T = T, phase = phase), T = temperature_pd(p = p, d = d, phase = phase))); 
      end density_pT;

      function density_pT_state  
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        output Density d "Density";
      algorithm
        d := density(state);
        annotation(Inline = false, LateInline = true, inverse(p = pressure_dT_state(d = d, T = T, state = state)), derivative(noDerivative = state) = density_pT_der); 
      end density_pT_state;

      function density_pT_der  "time derivative of density_pT" 
        input AbsolutePressure p;
        input Temperature T;
        input ThermodynamicState state;
        input Real p_der "time derivative of pressure";
        input Real T_der "time derivative of temperature";
        output Real d_der "time derivative of density";
      algorithm
        d_der := p_der * density_derp_T(state = state) + T_der * density_derT_p(state = state);
        annotation(Inline = true); 
      end density_pT_der;

      redeclare function extends density_derp_T  "returns density derivative (dd/dp)@T=const" 
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          ddpT := 1.0 / EoS.dpdT(f);
        elseif state.phase == 2 then
          ddpT := Modelica.Constants.inf;
        else
        end if;
      end density_derp_T;

      redeclare function extends density_derT_p  "returns density derivative (dd/dT)@p=const" 
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = 1);
          ddTp := -EoS.dpTd(f) / EoS.dpdT(f);
        elseif state.phase == 2 then
          ddTp := Modelica.Constants.inf;
        else
        end if;
      end density_derT_p;

      redeclare function specificEnthalpy_pT  "returns specific enthalpy for given p and T" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy_pT_state(p = p, T = T, state = setState_pT(p = p, T = T, phase = phase));
        annotation(Inline = true, inverse(T = temperature_ph(p = p, h = h, phase = phase))); 
      end specificEnthalpy_pT;

      function specificEnthalpy_pT_state  "returns specific enthalpy for given p and T" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy(state);
        annotation(Inline = false, LateInline = true, inverse(T = temperature_ph_state(p = p, h = h, state = state)), derivative(noDerivative = state) = specificEnthalpy_pT_der); 
      end specificEnthalpy_pT_state;

      function specificEnthalpy_pT_der  "time derivative of specificEnthalpy_pT" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p;
        input Temperature T;
        input ThermodynamicState state;
        input Real p_der "time derivative of pressure";
        input Real T_der "time derivative of temperature";
        output Real h_der "time derivative of specific Enthalpy";
      algorithm
        h_der := p_der * isothermalThrottlingCoefficient(state = state) + T_der * specificHeatCapacityCp(state = state);
        annotation(Inline = true); 
      end specificEnthalpy_pT_der;

      redeclare function pressure_dT  
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output AbsolutePressure p "pressure";
      algorithm
        p := pressure_dT_state(d = d, T = T, state = setState_dT(d = d, T = T, phase = phase));
        annotation(Inline = true, inverse(d = density_pT(p = p, T = T, phase = phase), T = temperature_pd(p = p, d = d, phase = phase))); 
      end pressure_dT;

      function pressure_dT_state  
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        output AbsolutePressure p "pressure";
      algorithm
        p := pressure(state);
        annotation(Inline = false, LateInline = true, inverse(d = density_pT_state(p = p, T = T, state = state)), derivative(noDerivative = state) = pressure_dT_der); 
      end pressure_dT_state;

      function pressure_dT_der  "time derivative of pressure_dT" 
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        input Real der_d "Density derivative";
        input Real der_T "Temperature derivative";
        output Real der_p "Time derivative of pressure";
      algorithm
        der_p := der_d * pressure_derd_T(state = state) + der_T * pressure_derT_d(state = state);
      end pressure_dT_der;

      function pressure_derd_T  "returns pressure derivative (dp/dd)@T=const" 
        input ThermodynamicState state;
        output DerPressureByDensity dpdT;
      protected
        EoS.HelmholtzDerivs f;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          dpdT := EoS.dpdT(f);
        elseif state.phase == 2 then
          dpdT := Modelica.Constants.small;
        else
        end if;
      end pressure_derd_T;

      function pressure_derT_d  "returns pressure derivative (dp/dT)@d=const" 
        input ThermodynamicState state;
        output DerPressureByTemperature dpTd;
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          dpTd := EoS.dpTd(f);
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          dpTd := (sat.vap.s - sat.liq.s) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
        else
        end if;
      end pressure_derT_d;

      redeclare function specificEnthalpy_dT  
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific Enthalpy";
      algorithm
        h := specificEnthalpy_dT_state(d = d, T = T, state = setState_dT(d = d, T = T, phase = phase));
        annotation(Inline = true); 
      end specificEnthalpy_dT;

      function specificEnthalpy_dT_state  
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        output SpecificEnthalpy h "SpecificEnthalpy";
      algorithm
        h := specificEnthalpy(state);
        annotation(Inline = false, LateInline = true, derivative(noDerivative = state) = specificEnthalpy_dT_der); 
      end specificEnthalpy_dT_state;

      function specificEnthalpy_dT_der  
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input ThermodynamicState state;
        input Real der_d "Density derivative";
        input Real der_T "Temperature derivative";
        output Real der_h "Time derivative of enthalpy";
      algorithm
        der_h := der_d * specificEnthalpy_derd_T(state = state) + der_T * specificEnthalpy_derT_d(state = state);
      end specificEnthalpy_dT_der;

      function specificEnthalpy_derd_T  "returns enthalpy derivative (dh/dd)@T=const" 
        input ThermodynamicState state;
        output DerEnthalpyByDensity dhdT;
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          dhdT := EoS.dhdT(f);
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          dhdT := -1 / state.d ^ 2 * (sat.liq.h - sat.vap.h) / (1 / sat.liq.d - 1 / sat.vap.d);
        else
        end if;
      end specificEnthalpy_derd_T;

      function specificEnthalpy_derT_d  "returns enthalpy derivative (dh/dT)@d=const" 
        input ThermodynamicState state;
        output DerEnthalpyByTemperature dhTd;
      protected
        EoS.HelmholtzDerivs f;
        SaturationProperties sat;
        MassFraction x "vapour quality";
        DerPressureByTemperature dpT;
        EoS.HelmholtzDerivs fl;
        EoS.HelmholtzDerivs fv;
        DerEnthalpyByTemperature dhT_liq;
        DerEnthalpyByTemperature dhT_vap;
        DerDensityByTemperature ddT_liq;
        DerDensityByTemperature ddT_vap;
        DerVolumeByTemperature dvT_liq;
        DerVolumeByTemperature dvT_vap;
        DerFractionByTemperature dxTv;
      algorithm
        if state.phase == 1 then
          f := EoS.setHelmholtzDerivsSecond(T = state.T, d = state.d, phase = state.phase);
          dhTd := EoS.dhTd(f);
        elseif state.phase == 2 then
          sat := setSat_T(T = state.T);
          x := (1 / state.d - 1 / sat.liq.d) / (1 / sat.vap.d - 1 / sat.liq.d);
          dpT := (sat.vap.s - sat.liq.s) / (1.0 / sat.vap.d - 1.0 / sat.liq.d);
          fl := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.liq.d, phase = 1);
          fv := EoS.setHelmholtzDerivsSecond(T = state.T, d = sat.vap.d, phase = 1);
          dhT_liq := EoS.dhTd(fl) - EoS.dhdT(fl) * EoS.dpTd(fl) / EoS.dpdT(fl) + EoS.dhdT(fl) / EoS.dpdT(fl) * dpT;
          dhT_vap := EoS.dhTd(fv) - EoS.dhdT(fv) * EoS.dpTd(fv) / EoS.dpdT(fv) + EoS.dhdT(fv) / EoS.dpdT(fv) * dpT;
          ddT_liq := (-EoS.dpTd(fl) / EoS.dpdT(fl)) + 1.0 / EoS.dpdT(fl) * dpT;
          ddT_vap := (-EoS.dpTd(fv) / EoS.dpdT(fv)) + 1.0 / EoS.dpdT(fv) * dpT;
          dvT_liq := -1 / sat.liq.d ^ 2 * ddT_liq;
          dvT_vap := -1 / sat.vap.d ^ 2 * ddT_vap;
          dxTv := (x * dvT_vap + (1 - x) * dvT_liq) / (1 / sat.liq.d - 1 / sat.vap.d);
          dhTd := dhT_liq + dxTv * (sat.vap.h - sat.liq.h) + x * (dhT_vap - dhT_liq);
        else
        end if;
      end specificEnthalpy_derT_d;

      function specificEntropy_pT  "iteratively finds the specific entropy for a given p and T" 
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEntropy s "Specific Entropy";
      algorithm
        s := specificEntropy(setState_pTX(p = p, T = T, phase = phase));
        annotation(inverse(T = temperature_ps(p = p, s = s, phase = phase), p = pressure_Ts(T = T, s = s, phase = phase))); 
      end specificEntropy_pT;

      function specificEntropy_dT  "return specific enthalpy for given d and T" 
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEntropy s "specific entropy";
      algorithm
        s := specificEntropy(setState_dTX(d = d, T = T, phase = phase));
        annotation(inverse(d = density_Ts(T = T, s = s, phase = phase))); 
      end specificEntropy_dT;

      redeclare function temperature_ps  "returns temperature for given p and d" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Entropy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_ps(p = p, s = s, phase = phase));
        annotation(inverse(p = pressure_Ts(T = T, s = s, phase = phase), s = specificEntropy_pT(p = p, T = T, phase = phase))); 
      end temperature_ps;

      redeclare function specificEnthalpy_ps  "returns specific enthalpy for a given p and s" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Entropy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(p = p, s = s, phase = phase));
        annotation(inverse(s = specificEntropy_ph(p = p, h = h, phase = phase))); 
      end specificEnthalpy_ps;
    end PartialHelmholtzMedium;

    package Choices  
      extends Modelica.Media.Interfaces.Choices;
      type ThermalConductivityModel = enumeration(TC0 "TC0 model (hardcoded)", TC1 "TC1 model", TC2 "TC2 model");
      type ThermalConductivityCriticalEnhancementModel = enumeration(TK0 "TK0 model (hardcoded/none)", TK2 "TK2 model", TK3 "TK3 model", TK4 "TK4 model", TK6 "TK6 model");
      type DynamicViscosityModel = enumeration(VS0 "VS0 model (hardcoded)", VS1 "VS1 model", VS1_alternative "VS1 with alternative first term", VS2 "VS2 model", VS4 "VS4 model");
      type CollisionIntegralModel = enumeration(CI0 "CI0 model", CI1 "CI1 model", CI2 "CI2 model");
      type PressureSaturationModel = enumeration(PS1, PS2, PS3, PS4, PS5 "most common", PS6);
      type DensityLiquidModel = enumeration(DL1 "most common", DL2, DL3, DL4, DL5, DL6);
      type DensityVaporModel = enumeration(DV1, DV2, DV3 "most common", DV4, DV5, DV6);
      type PressureMeltingModel = enumeration(ML1 "most common", ML2);
      type InputChoice = enumeration(dT "(d,T) as inputs", ph "(p,h) as inputs", ps "(p,s) as inputs", pT "(p,T) as inputs");
    end Choices;

    package Types  
      extends Modelica.Media.Interfaces.Types;
    end Types;
  end Interfaces;

  package HelmholtzFluids  
    package Helium  "Helium" 
      extends Interfaces.PartialHelmholtzMedium(mediumName = "helium", fluidConstants = {fluidConstantsHelium}, helmholtzCoefficients = helmholtzCoefficientsHelium, thermalConductivityCoefficients = thermalConductivityCoefficientsHelium, dynamicViscosityCoefficients = dynamicViscosityCoefficientsHelium, surfaceTensionCoefficients = surfaceTensionCoefficientsHelium, ancillaryCoefficients = ancillaryCoefficientsHelium, fluidLimits = fluidLimitsHelium, Density(min = fluidLimitsHelium.DMIN, max = fluidLimitsHelium.DMAX, start = fluidConstantsHelium.molarMass / fluidConstantsHelium.criticalMolarVolume), Temperature(min = fluidLimitsHelium.TMIN, max = fluidLimitsHelium.TMAX, start = 298.15), AbsolutePressure(min = 0, max = 1000e6, start = 101325), SpecificEnthalpy(min = fluidLimitsHelium.HMIN, max = fluidLimitsHelium.HMAX, start = 0), SpecificEntropy(min = fluidLimitsHelium.SMIN, max = fluidLimitsHelium.SMAX, start = 0));
      final constant FluidConstants fluidConstantsHelium(casRegistryNumber = "7440-59-7", iupacName = "helium-4", structureFormula = "He", chemicalFormula = "He", molarMass = 0.004002602, triplePointTemperature = 2.1768, normalBoilingPoint = 4.2226, hasCriticalData = true, criticalTemperature = 5.1953, criticalPressure = 227610, criticalMolarVolume = 1.0 / 17.3837e3, HCRIT0 = 11229.8913760996, SCRIT0 = 2054.84033693702, hasAcentricFactor = true, acentricFactor = -0.385, hasIdealGasHeatCapacity = false, hasDipoleMoment = true, dipoleMoment = 0.0, hasFundamentalEquation = true, hasLiquidHeatCapacity = true, hasSolidHeatCapacity = false, hasAccurateViscosityData = true, hasAccurateConductivityData = true, hasVapourPressureCurve = true, triplePointPressure = 5033.5, meltingPoint = 2.1768) "Fluid Constants";
      final constant FluidLimits fluidLimitsHelium(TMIN = fluidConstantsHelium.triplePointTemperature, TMAX = 2000, DMIN = Modelica.Constants.small, DMAX = 565.247, PMIN = Modelica.Constants.small, PMAX = 1000e6, HMIN = -6.6877e3, HMAX = +12000e3, SMIN = -1.8782e3, SMAX = 120e3) "Helmholtz EoS Limits";
      final constant EoS.HelmholtzCoefficients helmholtzCoefficientsHelium(useLineSearch = true, idealLog = [1.5, 1], idealPower = [0.159269591430361000, 0; 0.476532113807410000, 1], idealEinstein = fill(0.0, 0, 2), idealCosh = fill(0.0, 0, 2), idealSinh = fill(0.0, 0, 2), residualPoly = [0.014799269, 1.0, 4, 0; 3.06281562, 0.426, 1, 0; -4.25338698, 0.631, 1, 0; 0.05192797, 0.596, 2, 0; -0.165087335, 1.705, 2, 0; 0.087236897, 0.568, 3, 0], residualBwr = [2.10653786, 0.9524, 1, 1; -0.62835030, 1.471, 1, 2; -0.28200301, 1.48, 3, 2; 1.04234019, 1.393, 2, 1; -0.07620555, 3.863, 2, 2; -1.35006365, 0.803, 1, 1], residualGauss = [0.11997252, 3.273, 1, 2, 2, -8.674, -8.005, 1.1475, 0.912; 0.10724500, 0.66, 1, 2, 2, -4.006, -1.15, 1.7036, 0.79; -0.35374839, 2.629, 1, 2, 2, -8.1099, -2.143, 1.6795, 0.90567; 0.75348862, 1.4379, 2, 2, 2, -0.1449, -0.147, 0.9512, 5.1136; 0.00701871, 3.317, 2, 2, 2, -0.1784, -0.154, 4.475, 3.6022; 0.226283167, 2.3676, 2, 2, 2, -2.432, -0.701, 2.7284, 0.6488; -0.22464733, 0.7545, 3, 2, 2, -0.0414, -0.21, 1.7167, 4.2753; 0.12413584, 1.353, 2, 2, 2, -0.421, -0.134, 1.5237, 2.744; 0.00901399, 1.982, 2, 2, 2, -5.8575, -19.256, 0.7649, 0.8736]) "Coefficients of the Helmholtz EoS";
      final constant Transport.ThermalConductivityCoefficients thermalConductivityCoefficientsHelium(thermalConductivityModel = ThermalConductivityModel.TC0, thermalConductivityCriticalEnhancementModel = ThermalConductivityCriticalEnhancementModel.TK0, reducingTemperature_0 = 10, reducingThermalConductivity_0 = 1, lambda_0_num_coeffs = fill(0.0, 0, 2), reducingTemperature_background = 1, reducingMolarVolume_background = 1, reducingThermalConductivity_background = 1, lambda_b_coeffs = fill(0.0, 0, 4), xi_0 = 0.194E-9, Gamma_0 = 0.0496, qd_inverse = 0.875350E-9, T_ref = 637.68) "Coefficients for the thermal conductivity";
      final constant Transport.DynamicViscosityCoefficients dynamicViscosityCoefficientsHelium(dynamicViscosityModel = DynamicViscosityModel.VS0, collisionIntegralModel = CollisionIntegralModel.CI0, sigma = 1, epsilon_kappa = 1, CET = fill(0.0, 0, 2), a = fill(0.0, 0, 2), b = fill(0.0, 0, 2), reducingTemperature_residual = 1, reducingMolarVolume_residual = 1, reducingViscosity_residual = 1, g = fill(0.0, 0, 2), e = fill(0.0, 0, 5), nu_po = fill(0.0, 0, 5), de_po = fill(0.0, 0, 5)) "Coefficients for the dynamic viscosity";
      final constant Transport.SurfaceTensionCoefficients surfaceTensionCoefficientsHelium(coeffs = [0.0004656, 1.04; 0.001889, 2.468; -0.002006, 2.661]) "Coefficients for the surface tension";
      final constant Ancillary.AncillaryCoefficients ancillaryCoefficientsHelium(pressureMeltingModel = PressureMeltingModel.ML1, T_reducing = 10, p_reducing = 1000e3, pressureMelting1 = [-1.7455837, 0.000000; 1.6979793, 1.555414], pressureMelting2 = fill(0.0, 0, 2), pressureMelting3 = fill(0.0, 0, 2), pressureSaturationModel = PressureSaturationModel.PS5, pressureSaturation = [-3.8357, 1.0; 1.7062, 1.5; -0.71231, 1.25; 1.0862, 2.8], densityLiquidModel = DensityLiquidModel.DL1, densityLiquid = [1.0929, 0.286; 1.6584, 1.2; -3.6477, 2.0; 2.7440, 2.8; -2.3859, 6.5], densityVaporModel = DensityVaporModel.DV3, densityVapor = [-1.5789, 0.333; -10.749, 1.5; 17.711, 2.1; -15.413, 2.7; -14.352, 9.0]) "Coefficients for the ancillary equations (PS5, DL1, DV3, ML1)";
    end Helium;
  end HelmholtzFluids;
end HelmholtzMedia;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(Protection(access = Access.hide), version = "3.2.1", versionBuild = 2, versionDate = "2013-08-14", dateModified = "2013-08-14 08:44:41Z"); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.1 (Build 3)" 
  extends Modelica.Icons.Package;

  package Media  "Library of media property models" 
    extends Modelica.Icons.Package;

    package Examples  "Demonstrate usage of property models (currently: simple tests)" 
      extends Modelica.Icons.ExamplesPackage;

      package Tests  "Library to test that all media models simulate and fulfill the expected structural properties" 
        extends Modelica.Icons.ExamplesPackage;

        package Components  "Functions, connectors and models needed for the media model tests" 
          extends Modelica.Icons.Library;

          connector FluidPort  "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            Medium.AbsolutePressure p "Pressure in the connection point";
            flow Medium.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
            Medium.SpecificEnthalpy h "Specific mixture enthalpy in the connection point";
            flow Medium.EnthalpyFlowRate H_flow "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
            Medium.MassFraction[Medium.nXi] Xi "Independent mixture mass fractions m_i/m in the connection point";
            flow Medium.MassFlowRate[Medium.nXi] mXi_flow "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
            Medium.ExtraProperty[Medium.nC] C "Properties c_i/m in the connection point";
            flow Medium.ExtraPropertyFlowRate[Medium.nC] mC_flow "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
          end FluidPort;

          connector FluidPort_a  "Fluid connector with filled icon" 
            extends FluidPort;
          end FluidPort_a;

          connector FluidPort_b  "Fluid connector with outlined icon" 
            extends FluidPort;
          end FluidPort_b;

          model PortVolume  "Fixed volume associated with a port by the finite volume method" 
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            parameter .Modelica.SIunits.Volume V = 1e-6 "Fixed size of junction volume";
            parameter Boolean use_p_start = true "Select p_start or d_start" annotation(Evaluate = true);
            parameter Medium.AbsolutePressure p_start = 101325 "Initial pressure";
            parameter Medium.Density d_start = 1 "Initial density";
            parameter Boolean use_T_start = true "Select T_start or h_start" annotation(Evaluate = true);
            parameter Medium.Temperature T_start = Modelica.SIunits.Conversions.from_degC(20) "Initial temperature";
            parameter Medium.SpecificEnthalpy h_start = 1.e4 "Initial specific enthalpy";
            parameter Medium.MassFraction[Medium.nX] X_start "Initial mass fractions m_i/m";
            FluidPort_a port(redeclare package Medium = Medium);
            Medium.BaseProperties medium(preferredMediumStates = true);
            .Modelica.SIunits.Energy U "Internal energy of port volume";
            .Modelica.SIunits.Mass m "Mass of junction volume";
            .Modelica.SIunits.Mass[Medium.nXi] mXi "Independent substance masses of junction volume";
          initial equation
            if not Medium.singleState then
              if use_p_start then
                medium.p = p_start;
              else
                medium.d = d_start;
              end if;
            end if;
            if use_T_start then
              medium.T = T_start;
            else
              medium.h = h_start;
            end if;
            medium.Xi = X_start[1:Medium.nXi];
          equation
            medium.p = port.p;
            medium.h = port.h;
            medium.Xi = port.Xi;
            m = V * medium.d;
            mXi = m * medium.Xi;
            U = m * medium.u;
            der(m) = port.m_flow;
            der(mXi) = port.mXi_flow;
            der(U) = port.H_flow;
          end PortVolume;

          model FixedMassFlowRate  "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction" 
            parameter Medium.MassFlowRate m_flow "Fixed mass flow rate from an infinite reservoir to the fluid port";
            parameter Boolean use_T_ambient = true "Select T_ambient or h_ambient" annotation(Evaluate = true);
            parameter Medium.Temperature T_ambient = Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature";
            parameter Medium.SpecificEnthalpy h_ambient = 1.e4 "Ambient specific enthalpy";
            parameter Medium.MassFraction[Medium.nX] X_ambient "Ambient mass fractions m_i/m of reservoir";
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            Medium.BaseProperties medium "Medium in the source";
            FluidPort_b port(redeclare package Medium = Medium);
          equation
            if use_T_ambient then
              medium.T = T_ambient;
            else
              medium.h = h_ambient;
            end if;
            medium.Xi = X_ambient[1:Medium.nXi];
            medium.p = port.p;
            port.m_flow = -m_flow;
            port.mXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);
            port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
          end FixedMassFlowRate;

          model FixedAmbient  "Ambient pressure, temperature and mass fraction source" 
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            parameter Boolean use_p_ambient = true "Select p_ambient or d_ambient" annotation(Evaluate = true);
            parameter Medium.AbsolutePressure p_ambient = 101325 "Ambient pressure";
            parameter Medium.Density d_ambient = 1 "Ambient density";
            parameter Boolean use_T_ambient = true "Select T_ambient or h_ambient" annotation(Evaluate = true);
            parameter Medium.Temperature T_ambient = Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature";
            parameter Medium.SpecificEnthalpy h_ambient = 1.e4 "Ambient specific enthalpy";
            parameter Medium.MassFraction[Medium.nX] X_ambient "Ambient mass fractions m_i/m";
            Medium.BaseProperties medium "Medium in the source";
            FluidPort_b port(redeclare package Medium = Medium);
          equation
            if use_p_ambient or Medium.singleState then
              medium.p = p_ambient;
            else
              medium.d = d_ambient;
            end if;
            if use_T_ambient then
              medium.T = T_ambient;
            else
              medium.h = h_ambient;
            end if;
            medium.Xi = X_ambient[1:Medium.nXi];
            port.p = medium.p;
            port.H_flow = semiLinear(port.m_flow, port.h, medium.h);
            port.mXi_flow = semiLinear(port.m_flow, port.Xi, medium.Xi);
          end FixedAmbient;

          model ShortPipe  "Simple pressure loss in pipe" 
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            parameter Medium.AbsolutePressure dp_nominal(min = 1.e-10) "Nominal pressure drop";
            parameter Medium.MassFlowRate m_flow_nominal(min = 1.e-10) "Nominal mass flow rate at nominal pressure drop";
            FluidPort_a port_a(redeclare package Medium = Medium);
            FluidPort_b port_b(redeclare package Medium = Medium);
            Medium.MassFlowRate m_flow "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
            Modelica.SIunits.Pressure dp "Pressure drop from port_a to port_b";
          equation
            port_a.H_flow = semiLinear(port_a.m_flow, port_a.h, port_b.h);
            port_a.mXi_flow = semiLinear(port_a.m_flow, port_a.Xi, port_b.Xi);
            port_a.H_flow + port_b.H_flow = 0;
            port_a.m_flow + port_b.m_flow = 0;
            port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nXi);
            m_flow = port_a.m_flow;
            dp = port_a.p - port_b.p;
            m_flow = m_flow_nominal / dp_nominal * dp;
          end ShortPipe;

          partial model PartialTestModel  "Basic test model to test a medium" 
            replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model" annotation(choicesAllMatching = true);
            parameter .Modelica.SIunits.AbsolutePressure p_start = Medium.p_default "Initial value of pressure";
            parameter .Modelica.SIunits.Temperature T_start = Medium.T_default "Initial value of temperature";
            parameter .Modelica.SIunits.SpecificEnthalpy h_start = Medium.h_default "Initial value of specific enthalpy";
            parameter Real[Medium.nX] X_start = Medium.X_default "Initial value of mass fractions";
            PortVolume volume(redeclare package Medium = Medium, p_start = p_start, T_start = T_start, h_start = h_start, X_start = X_start, V = 0.1);
            FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium, T_ambient = 1.2 * T_start, h_ambient = 1.2 * h_start, m_flow = 1, X_ambient = 0.5 * X_start);
            FixedAmbient ambient(redeclare package Medium = Medium, T_ambient = T_start, h_ambient = h_start, X_ambient = X_start, p_ambient = p_start);
            ShortPipe shortPipe(redeclare package Medium = Medium, m_flow_nominal = 1, dp_nominal = 0.1e5);
          equation
            connect(fixedMassFlowRate.port, volume.port);
            connect(volume.port, shortPipe.port_a);
            connect(shortPipe.port_b, ambient.port);
          end PartialTestModel;
        end Components;
      end Tests;
    end Examples;

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
        constant MassFraction[nX] reference_X = fill(1 / nX, nX) "Default mass fractions of medium";
        constant AbsolutePressure p_default = 101325 "Default value for pressure of medium (for initialization)";
        constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20) "Default value for temperature of medium (for initialization)";
        constant SpecificEnthalpy h_default = specificEnthalpy_pTX(p_default, T_default, X_default) "Default value for specific enthalpy of medium (for initialization)";
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
          parameter Boolean preferredMediumStates = false "= true if StateSelect.prefer shall be used for the independent property variables of the medium" annotation(Evaluate = true);
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
              assert(X[i] >= (-1.e-5) and X[i] <= 1 + 1.e-5, "Mass fraction X[" + String(i) + "] = " + String(X[i]) + "of substance " + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
            end for;
          end if;
          assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" + mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
        end BaseProperties;

        replaceable partial function setState_pTX  "Return thermodynamic state as function of p, T and composition X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        end setState_pTX;

        replaceable partial function setState_phX  "Return thermodynamic state as function of p, h and composition X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        end setState_phX;

        replaceable partial function setState_psX  "Return thermodynamic state as function of p, s and composition X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        end setState_psX;

        replaceable partial function setState_dTX  "Return thermodynamic state as function of d, T and composition X or Xi" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input MassFraction[:] X = reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state record";
        end setState_dTX;

        replaceable partial function setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
          extends Modelica.Icons.Function;
          input Real x "m_flow or dp";
          input ThermodynamicState state_a "Thermodynamic state if x > 0";
          input ThermodynamicState state_b "Thermodynamic state if x < 0";
          input Real x_small(min = 0) "Smooth transition in the region -x_small < x < x_small";
          output ThermodynamicState state "Smooth thermodynamic state for all x (continuous and differentiable)";
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
        end isobaricExpansionCoefficient;

        replaceable partial function isothermalCompressibility  "Return overall the isothermal compressibility factor" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility";
        end isothermalCompressibility;

        replaceable partial function density_derp_h  "Return density derivative w.r.t. pressure at const specific enthalpy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
        end density_derp_h;

        replaceable partial function density_derh_p  "Return density derivative w.r.t. specific enthalpy at constant pressure" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output DerDensityByEnthalpy ddhp "Density derivative w.r.t. specific enthalpy";
        end density_derh_p;

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

        replaceable function temperature_phX  "Return temperature from p, h, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output Temperature T "Temperature";
        algorithm
          T := temperature(setState_phX(p, h, X));
        end temperature_phX;

        replaceable function density_phX  "Return density from p, h, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output Density d "Density";
        algorithm
          d := density(setState_phX(p, h, X));
        end density_phX;

        replaceable function temperature_psX  "Return temperature from p,s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output Temperature T "Temperature";
        algorithm
          T := temperature(setState_psX(p, s, X));
          annotation(inverse(s = specificEntropy_pTX(p, T, X))); 
        end temperature_psX;

        replaceable function density_psX  "Return density from p, s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output Density d "Density";
        algorithm
          d := density(setState_psX(p, s, X));
        end density_psX;

        replaceable function specificEnthalpy_psX  "Return specific enthalpy from p, s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X = reference_X "Mass fractions";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy(setState_psX(p, s, X));
        end specificEnthalpy_psX;

        type MassFlowRate = .Modelica.SIunits.MassFlowRate(quantity = "MassFlowRate." + mediumName, min = -1.0e5, max = 1.e5) "Type for mass flow rate with medium specific attributes";
        package Choices = Modelica.Media.Interfaces.Choices annotation(obsolete = "Use Modelica.Media.Interfaces.Choices");
      end PartialMedium;

      partial package PartialPureSubstance  "Base class for pure substances of one chemical substance" 
        extends PartialMedium(final reducedX = true, final fixedX = true);

        replaceable function setState_pT  "Return thermodynamic state from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_pTX(p, T, fill(0, 0));
        end setState_pT;

        replaceable function setState_ph  "Return thermodynamic state from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_phX(p, h, fill(0, 0));
        end setState_ph;

        replaceable function setState_ps  "Return thermodynamic state from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_psX(p, s, fill(0, 0));
        end setState_ps;

        replaceable function setState_dT  "Return thermodynamic state from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_dTX(d, T, fill(0, 0));
        end setState_dT;

        replaceable function density_ph  "Return density from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          output Density d "Density";
        algorithm
          d := density_phX(p, h, fill(0, 0));
        end density_ph;

        replaceable function temperature_ph  "Return temperature from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          output Temperature T "Temperature";
        algorithm
          T := temperature_phX(p, h, fill(0, 0));
        end temperature_ph;

        replaceable function pressure_dT  "Return pressure from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          output AbsolutePressure p "Pressure";
        algorithm
          p := pressure(setState_dTX(d, T, fill(0, 0)));
        end pressure_dT;

        replaceable function specificEnthalpy_dT  "Return specific enthalpy from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy(setState_dTX(d, T, fill(0, 0)));
        end specificEnthalpy_dT;

        replaceable function specificEnthalpy_ps  "Return specific enthalpy from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy_psX(p, s, fill(0, 0));
        end specificEnthalpy_ps;

        replaceable function temperature_ps  "Return temperature from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          output Temperature T "Temperature";
        algorithm
          T := temperature_psX(p, s, fill(0, 0));
        end temperature_ps;

        replaceable function density_ps  "Return density from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          output Density d "Density";
        algorithm
          d := density_psX(p, s, fill(0, 0));
        end density_ps;

        replaceable function specificEnthalpy_pT  "Return specific enthalpy from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy_pTX(p, T, fill(0, 0));
        end specificEnthalpy_pT;

        replaceable function density_pT  "Return density from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          output Density d "Density";
        algorithm
          d := density(setState_pTX(p, T, fill(0, 0)));
        end density_pT;

        redeclare replaceable partial model extends BaseProperties(final standardOrderComponents = true)  end BaseProperties;
      end PartialPureSubstance;

      partial package PartialTwoPhaseMedium  "Base class for two phase medium of one substance" 
        extends PartialPureSubstance(redeclare record FluidConstants = Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants);
        constant Boolean smoothModel = false "True if the (derived) model should not generate state events";
        constant Boolean onePhase = false "True if the (derived) model should never be called with two-phase inputs";
        constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

        redeclare replaceable record extends ThermodynamicState  "Thermodynamic state of two phase medium" 
          FixedPhase phase(min = 0, max = 2) "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";
        end ThermodynamicState;

        redeclare replaceable partial model extends BaseProperties  "Base properties (p, d, T, h, u, R, MM, sat) of two phase medium" 
          SaturationProperties sat "Saturation properties at the medium pressure";
        end BaseProperties;

        replaceable partial function setDewState  "Return the thermodynamic state on the dew line" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation point";
          input FixedPhase phase(min = 1, max = 2) = 1 "Phase: default is one phase";
          output ThermodynamicState state "Complete thermodynamic state info";
        end setDewState;

        replaceable partial function setBubbleState  "Return the thermodynamic state on the bubble line" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation point";
          input FixedPhase phase(min = 1, max = 2) = 1 "Phase: default is one phase";
          output ThermodynamicState state "Complete thermodynamic state info";
        end setBubbleState;

        redeclare replaceable partial function extends setState_dTX  "Return thermodynamic state as function of d, T and composition X or Xi" 
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        end setState_dTX;

        redeclare replaceable partial function extends setState_phX  "Return thermodynamic state as function of p, h and composition X or Xi" 
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        end setState_phX;

        redeclare replaceable partial function extends setState_psX  "Return thermodynamic state as function of p, s and composition X or Xi" 
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        end setState_psX;

        redeclare replaceable partial function extends setState_pTX  "Return thermodynamic state as function of p, T and composition X or Xi" 
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        end setState_pTX;

        replaceable function setSat_T  "Return saturation property record from temperature" 
          extends Modelica.Icons.Function;
          input Temperature T "Temperature";
          output SaturationProperties sat "Saturation property record";
        algorithm
          sat.Tsat := T;
          sat.psat := saturationPressure(T);
        end setSat_T;

        replaceable function setSat_p  "Return saturation property record from pressure" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          output SaturationProperties sat "Saturation property record";
        algorithm
          sat.psat := p;
          sat.Tsat := saturationTemperature(p);
        end setSat_p;

        replaceable partial function bubbleEnthalpy  "Return bubble point specific enthalpy" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output .Modelica.SIunits.SpecificEnthalpy hl "Boiling curve specific enthalpy";
        end bubbleEnthalpy;

        replaceable partial function dewEnthalpy  "Return dew point specific enthalpy" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output .Modelica.SIunits.SpecificEnthalpy hv "Dew curve specific enthalpy";
        end dewEnthalpy;

        replaceable partial function bubbleEntropy  "Return bubble point specific entropy" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output .Modelica.SIunits.SpecificEntropy sl "Boiling curve specific entropy";
        end bubbleEntropy;

        replaceable partial function dewEntropy  "Return dew point specific entropy" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output .Modelica.SIunits.SpecificEntropy sv "Dew curve specific entropy";
        end dewEntropy;

        replaceable partial function bubbleDensity  "Return bubble point density" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output Density dl "Boiling curve density";
        end bubbleDensity;

        replaceable partial function dewDensity  "Return dew point density" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output Density dv "Dew curve density";
        end dewDensity;

        replaceable partial function saturationPressure  "Return saturation pressure" 
          extends Modelica.Icons.Function;
          input Temperature T "Temperature";
          output AbsolutePressure p "Saturation pressure";
        end saturationPressure;

        replaceable partial function saturationTemperature  "Return saturation temperature" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          output Temperature T "Saturation temperature";
        end saturationTemperature;

        replaceable function saturationPressure_sat  "Return saturation temperature" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output AbsolutePressure p "Saturation pressure";
        algorithm
          p := sat.psat;
        end saturationPressure_sat;

        replaceable function saturationTemperature_sat  "Return saturation temperature" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output Temperature T "Saturation temperature";
        algorithm
          T := sat.Tsat;
        end saturationTemperature_sat;

        replaceable partial function saturationTemperature_derp  "Return derivative of saturation temperature w.r.t. pressure" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          output DerTemperatureByPressure dTp "Derivative of saturation temperature w.r.t. pressure";
        end saturationTemperature_derp;

        replaceable function saturationTemperature_derp_sat  "Return derivative of saturation temperature w.r.t. pressure" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output DerTemperatureByPressure dTp "Derivative of saturation temperature w.r.t. pressure";
        algorithm
          dTp := saturationTemperature_derp(sat.psat);
        end saturationTemperature_derp_sat;

        replaceable partial function surfaceTension  "Return surface tension sigma in the two phase region" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output SurfaceTension sigma "Surface tension sigma in the two phase region";
        end surfaceTension;

        redeclare replaceable function extends molarMass  "Return the molar mass of the medium" 
        algorithm
          MM := fluidConstants[1].molarMass;
        end molarMass;

        replaceable partial function dBubbleDensity_dPressure  "Return bubble point density derivative" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output DerDensityByPressure ddldp "Boiling curve density derivative";
        end dBubbleDensity_dPressure;

        replaceable partial function dDewDensity_dPressure  "Return dew point density derivative" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output DerDensityByPressure ddvdp "Saturated steam density derivative";
        end dDewDensity_dPressure;

        replaceable partial function dBubbleEnthalpy_dPressure  "Return bubble point specific enthalpy derivative" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output DerEnthalpyByPressure dhldp "Boiling curve specific enthalpy derivative";
        end dBubbleEnthalpy_dPressure;

        replaceable partial function dDewEnthalpy_dPressure  "Return dew point specific enthalpy derivative" 
          extends Modelica.Icons.Function;
          input SaturationProperties sat "Saturation property record";
          output DerEnthalpyByPressure dhvdp "Saturated steam specific enthalpy derivative";
        end dDewEnthalpy_dPressure;

        redeclare replaceable function specificEnthalpy_pTX  "Return specific enthalpy from pressure, temperature and mass fraction" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output SpecificEnthalpy h "Specific enthalpy at p, T, X";
        algorithm
          h := specificEnthalpy(setState_pTX(p, T, X, phase));
        end specificEnthalpy_pTX;

        redeclare replaceable function temperature_phX  "Return temperature from p, h, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Temperature T "Temperature";
        algorithm
          T := temperature(setState_phX(p, h, X, phase));
        end temperature_phX;

        redeclare replaceable function density_phX  "Return density from p, h, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
        algorithm
          d := density(setState_phX(p, h, X, phase));
        end density_phX;

        redeclare replaceable function temperature_psX  "Return temperature from p, s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Temperature T "Temperature";
        algorithm
          T := temperature(setState_psX(p, s, X, phase));
        end temperature_psX;

        redeclare replaceable function density_psX  "Return density from p, s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
        algorithm
          d := density(setState_psX(p, s, X, phase));
        end density_psX;

        redeclare replaceable function specificEnthalpy_psX  "Return specific enthalpy from p, s, and X or Xi" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input MassFraction[:] X "Mass fractions";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy(setState_psX(p, s, X, phase));
        end specificEnthalpy_psX;

        redeclare replaceable function setState_pT  "Return thermodynamic state from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_pTX(p, T, fill(0, 0), phase);
        end setState_pT;

        redeclare replaceable function setState_ph  "Return thermodynamic state from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_phX(p, h, fill(0, 0), phase);
        end setState_ph;

        redeclare replaceable function setState_ps  "Return thermodynamic state from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_psX(p, s, fill(0, 0), phase);
        end setState_ps;

        redeclare replaceable function setState_dT  "Return thermodynamic state from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output ThermodynamicState state "Thermodynamic state record";
        algorithm
          state := setState_dTX(d, T, fill(0, 0), phase);
        end setState_dT;

        redeclare replaceable function density_ph  "Return density from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
        algorithm
          d := density_phX(p, h, fill(0, 0), phase);
        end density_ph;

        redeclare replaceable function temperature_ph  "Return temperature from p and h" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Temperature T "Temperature";
        algorithm
          T := temperature_phX(p, h, fill(0, 0), phase);
        end temperature_ph;

        redeclare replaceable function pressure_dT  "Return pressure from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output AbsolutePressure p "Pressure";
        algorithm
          p := pressure(setState_dTX(d, T, fill(0, 0), phase));
        end pressure_dT;

        redeclare replaceable function specificEnthalpy_dT  "Return specific enthalpy from d and T" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy(setState_dTX(d, T, fill(0, 0), phase));
        end specificEnthalpy_dT;

        redeclare replaceable function specificEnthalpy_ps  "Return specific enthalpy from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy_psX(p, s, fill(0, 0));
        end specificEnthalpy_ps;

        redeclare replaceable function temperature_ps  "Return temperature from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Temperature T "Temperature";
        algorithm
          T := temperature_psX(p, s, fill(0, 0), phase);
        end temperature_ps;

        redeclare replaceable function density_ps  "Return density from p and s" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
        algorithm
          d := density_psX(p, s, fill(0, 0), phase);
        end density_ps;

        redeclare replaceable function specificEnthalpy_pT  "Return specific enthalpy from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := specificEnthalpy_pTX(p, T, fill(0, 0), phase);
        end specificEnthalpy_pT;

        redeclare replaceable function density_pT  "Return density from p and T" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
        algorithm
          d := density(setState_pTX(p, T, fill(0, 0), phase));
        end density_pT;
      end PartialTwoPhaseMedium;

      package Choices  "Types, constants to define menu choices" 
        extends Modelica.Icons.Package;
        type IndependentVariables = enumeration(T "Temperature", pT "Pressure, Temperature", ph "Pressure, Specific Enthalpy", phX "Pressure, Specific Enthalpy, Mass Fraction", pTX "Pressure, Temperature, Mass Fractions", dTX "Density, Temperature, Mass Fractions") "Enumeration defining the independent variables of a medium";
      end Choices;

      package Types  "Types to be used in fluid models" 
        extends Modelica.Icons.Package;
        type AbsolutePressure = .Modelica.SIunits.AbsolutePressure(min = 0, max = 1.e8, nominal = 1.e5, start = 1.e5) "Type for absolute pressure with medium specific attributes";
        type Density = .Modelica.SIunits.Density(min = 0, max = 1.e5, nominal = 1, start = 1) "Type for density with medium specific attributes";
        type DynamicViscosity = .Modelica.SIunits.DynamicViscosity(min = 0, max = 1.e8, nominal = 1.e-3, start = 1.e-3) "Type for dynamic viscosity with medium specific attributes";
        type EnthalpyFlowRate = .Modelica.SIunits.EnthalpyFlowRate(nominal = 1000.0, min = -1.0e8, max = 1.e8) "Type for enthalpy flow rate with medium specific attributes";
        type MassFraction = Real(quantity = "MassFraction", final unit = "kg/kg", min = 0, max = 1, nominal = 0.1) "Type for mass fraction with medium specific attributes";
        type MolarMass = .Modelica.SIunits.MolarMass(min = 0.001, max = 0.25, nominal = 0.032) "Type for molar mass with medium specific attributes";
        type MolarVolume = .Modelica.SIunits.MolarVolume(min = 1e-6, max = 1.0e6, nominal = 1.0) "Type for molar volume with medium specific attributes";
        type IsentropicExponent = .Modelica.SIunits.RatioOfSpecificHeatCapacities(min = 1, max = 500000, nominal = 1.2, start = 1.2) "Type for isentropic exponent with medium specific attributes";
        type SpecificEnergy = .Modelica.SIunits.SpecificEnergy(min = -1.0e8, max = 1.e8, nominal = 1.e6) "Type for specific energy with medium specific attributes";
        type SpecificInternalEnergy = SpecificEnergy "Type for specific internal energy with medium specific attributes";
        type SpecificEnthalpy = .Modelica.SIunits.SpecificEnthalpy(min = -1.0e10, max = 1.e10, nominal = 1.e6) "Type for specific enthalpy with medium specific attributes";
        type SpecificEntropy = .Modelica.SIunits.SpecificEntropy(min = -1.e7, max = 1.e7, nominal = 1.e3) "Type for specific entropy with medium specific attributes";
        type SpecificHeatCapacity = .Modelica.SIunits.SpecificHeatCapacity(min = 0, max = 1.e7, nominal = 1.e3, start = 1.e3) "Type for specific heat capacity with medium specific attributes";
        type SurfaceTension = .Modelica.SIunits.SurfaceTension "Type for surface tension with medium specific attributes";
        type Temperature = .Modelica.SIunits.Temperature(min = 1, max = 1.e4, nominal = 300, start = 300) "Type for temperature with medium specific attributes";
        type ThermalConductivity = .Modelica.SIunits.ThermalConductivity(min = 0, max = 500, nominal = 1, start = 1) "Type for thermal conductivity with medium specific attributes";
        type VelocityOfSound = .Modelica.SIunits.Velocity(min = 0, max = 1.e5, nominal = 1000, start = 1000) "Type for velocity of sound with medium specific attributes";
        type ExtraProperty = Real(min = 0.0, start = 1.0) "Type for unspecified, mass-specific property transported by flow";
        type ExtraPropertyFlowRate = Real(unit = "kg/s") "Type for flow rate of unspecified, mass-specific property";
        type IsobaricExpansionCoefficient = Real(min = 0, max = 1.0e8, unit = "1/K") "Type for isobaric expansion coefficient with medium specific attributes";
        type DipoleMoment = Real(min = 0.0, max = 2.0, unit = "debye", quantity = "ElectricDipoleMoment") "Type for dipole moment with medium specific attributes";
        type DerDensityByPressure = .Modelica.SIunits.DerDensityByPressure "Type for partial derivative of density with respect to pressure with medium specific attributes";
        type DerDensityByEnthalpy = .Modelica.SIunits.DerDensityByEnthalpy "Type for partial derivative of density with respect to enthalpy with medium specific attributes";
        type DerEnthalpyByPressure = .Modelica.SIunits.DerEnthalpyByPressure "Type for partial derivative of enthalpy with respect to pressure with medium specific attributes";
        type DerDensityByTemperature = .Modelica.SIunits.DerDensityByTemperature "Type for partial derivative of density with respect to temperature with medium specific attributes";
        type DerTemperatureByPressure = Real(final unit = "K/Pa") "Type for partial derivative of temperature with respect to pressure with medium specific attributes";

        replaceable record SaturationProperties  "Saturation properties of two phase medium" 
          extends Modelica.Icons.Record;
          AbsolutePressure psat "Saturation pressure";
          Temperature Tsat "Saturation temperature";
        end SaturationProperties;

        record FluidLimits  "Validity limits for fluid model" 
          extends Modelica.Icons.Record;
          Temperature TMIN "Minimum temperature";
          Temperature TMAX "Maximum temperature";
          Density DMIN "Minimum density";
          Density DMAX "Maximum density";
          AbsolutePressure PMIN "Minimum pressure";
          AbsolutePressure PMAX "Maximum pressure";
          SpecificEnthalpy HMIN "Minimum enthalpy";
          SpecificEnthalpy HMAX "Maximum enthalpy";
          SpecificEntropy SMIN "Minimum entropy";
          SpecificEntropy SMAX "Maximum entropy";
        end FluidLimits;

        type FixedPhase = Integer(min = 0, max = 2) "Phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g., interactive use";

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

        package TwoPhase  "The two phase fluid version of a record used in several degrees of detail" 
          extends Icons.Package;

          record FluidConstants  "Extended fluid constants" 
            extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
            Temperature criticalTemperature "Critical temperature";
            AbsolutePressure criticalPressure "Critical pressure";
            MolarVolume criticalMolarVolume "Critical molar Volume";
            Real acentricFactor "Pitzer acentric factor";
            Temperature triplePointTemperature "Triple point temperature";
            AbsolutePressure triplePointPressure "Triple point pressure";
            Temperature meltingPoint "Melting point at 101325 Pa";
            Temperature normalBoilingPoint "Normal boiling point (at 101325 Pa)";
            DipoleMoment dipoleMoment "Dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
            Boolean hasIdealGasHeatCapacity = false "True if ideal gas heat capacity is available";
            Boolean hasCriticalData = false "True if critical data are known";
            Boolean hasDipoleMoment = false "True if a dipole moment known";
            Boolean hasFundamentalEquation = false "True if a fundamental equation";
            Boolean hasLiquidHeatCapacity = false "True if liquid heat capacity is available";
            Boolean hasSolidHeatCapacity = false "True if solid heat capacity is available";
            Boolean hasAccurateViscosityData = false "True if accurate data for a viscosity function is available";
            Boolean hasAccurateConductivityData = false "True if accurate data for thermal conductivity is available";
            Boolean hasVapourPressureCurve = false "True if vapour pressure data, e.g., Antoine coefficents are known";
            Boolean hasAcentricFactor = false "True if Pitzer accentric factor is known";
            SpecificEnthalpy HCRIT0 = 0.0 "Critical specific enthalpy of the fundamental equation";
            SpecificEntropy SCRIT0 = 0.0 "Critical specific entropy of the fundamental equation";
            SpecificEnthalpy deltah = 0.0 "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
            SpecificEntropy deltas = 0.0 "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
          end FluidConstants;
        end TwoPhase;
      end Types;
    end Interfaces;

    package Common  "Data structures and fundamental functions for fluid properties" 
      extends Modelica.Icons.Package;
      constant Real MINPOS = 1.0e-9 "Minimal value for physical variables which are always > 0.0";

      function smoothStep  "Approximation of a general step, such that the characteristic is continuous and differentiable" 
        extends Modelica.Icons.Function;
        input Real x "Abscissa value";
        input Real y1 "Ordinate value for x > 0";
        input Real y2 "Ordinate value for x < 0";
        input Real x_small(min = 0) = 1e-5 "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
        output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
      algorithm
        y := smooth(1, if x > x_small then y1 else if x < (-x_small) then y2 else if abs(x_small) > 0 then x / x_small * ((x / x_small) ^ 2 - 3) * (y2 - y1) / 4 + (y1 + y2) / 2 else (y1 + y2) / 2);
        annotation(Inline = true, smoothOrder = 1); 
      end smoothStep;
    end Common;
  end Media;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  "Basic icon for mathematical function with y-axis on left side" end AxisLeft;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
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
          external "FORTRAN 77" dgesv(size(A, 1), 1, Awork, lda, ipiv, x, ldb, info) annotation(Library = "lapack");
        end dgesv_vec;
      end LAPACK;
    end Matrices;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;

    function log  "Natural (base e) logarithm (u shall be > 0)" 
      extends Modelica.Math.Icons.AxisLeft;
      input Real u;
      output Real y;
      external "builtin" y = log(u);
    end log;
  end Math;

  package Utilities  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)" 
    extends Modelica.Icons.Package;

    package Streams  "Read from files and write to files" 
      extends Modelica.Icons.Package;

      function print  "Print string to terminal or file" 
        extends Modelica.Icons.Function;
        input String string = "" "String to be printed";
        input String fileName = "" "File where to print (empty string is the terminal)";
        external "C" ModelicaInternal_print(string, fileName) annotation(Library = "ModelicaExternalC");
      end print;
    end Streams;
  end Utilities;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = ModelicaServices.Machine.inf "Biggest Real number such that inf and -inf are representable on the machine";
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real k(final unit = "J/K") = 1.3806505e-23 "Boltzmann constant";
    final constant Real R(final unit = "J/(mol.K)") = 8.314472 "Molar gas constant";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7 "Magnetic constant";
    final constant .Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_zero = -273.15 "Absolute zero temperature";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package ExamplesPackage  "Icon for packages containing runnable examples" 
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example  "Icon for runnable examples" end Example;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package MaterialPropertiesPackage  "Icon for package containing property classes" 
      extends Modelica.Icons.Package;
    end MaterialPropertiesPackage;

    partial function Function  "Icon for functions" end Function;

    partial record Record  "Icon for records" end Record;

    partial package Library  "This icon will be removed in future Modelica versions, use Package instead" end Library;
  end Icons;

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for SIunits" 
      extends Modelica.Icons.IconsPackage;

      partial function Conversion  "Base icon for conversion functions" end Conversion;
    end Icons;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units" 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
        type Pressure_bar = Real(final quantity = "Pressure", final unit = "bar") "Absolute pressure in bar";
      end NonSIunits;

      function to_degC  "Convert from Kelvin to degCelsius" 
        extends Modelica.SIunits.Icons.Conversion;
        input Temperature Kelvin "Kelvin value";
        output NonSIunits.Temperature_degC Celsius "Celsius value";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
        annotation(Inline = true); 
      end to_degC;

      function from_degC  "Convert from degCelsius to Kelvin" 
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
        annotation(Inline = true); 
      end from_degC;

      function to_bar  "Convert from Pascal to bar" 
        extends Modelica.SIunits.Icons.Conversion;
        input Pressure Pa "Pascal value";
        output NonSIunits.Pressure_bar bar "bar value";
      algorithm
        bar := Pa / 1e5;
        annotation(Inline = true); 
      end to_bar;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Area = Real(final quantity = "Area", final unit = "m2");
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5);
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
    type SurfaceTension = Real(final quantity = "SurfaceTension", final unit = "N/m");
    type Energy = Real(final quantity = "Energy", final unit = "J");
    type Power = Real(final quantity = "Power", final unit = "W");
    type EnthalpyFlowRate = Real(final quantity = "EnthalpyFlowRate", final unit = "W");
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
    type Temperature = ThermodynamicTemperature;
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)");
    type RatioOfSpecificHeatCapacities = Real(final quantity = "RatioOfSpecificHeatCapacities", final unit = "1");
    type Entropy = Real(final quantity = "Entropy", final unit = "J/K");
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", final unit = "J/(kg.K)");
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", final unit = "J/kg");
    type SpecificEnthalpy = SpecificEnergy;
    type DerDensityByEnthalpy = Real(final unit = "kg.s2/m5");
    type DerDensityByPressure = Real(final unit = "s2/m2");
    type DerDensityByTemperature = Real(final unit = "kg/(m3.K)");
    type DerEnthalpyByPressure = Real(final unit = "J.m.s2/kg2");
    type AmountOfSubstance = Real(final quantity = "AmountOfSubstance", final unit = "mol", min = 0);
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0);
    type MolarVolume = Real(final quantity = "MolarVolume", final unit = "m3/mol", min = 0);
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1);
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", min = 0, max = 1);
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
  annotation(version = "3.2.1", versionBuild = 3, versionDate = "2013-08-14", dateModified = "2014-06-27 19:30:00Z"); 
end Modelica;

model HeliumTestModel_total  "Test HelmholtzMedia.HelmholtzFluids.Helium"
  extends HelmholtzMedia.Examples.MediaTestModels.HeliumTestModel;
 annotation(experiment(StopTime = 1.01));
end HeliumTestModel_total;
