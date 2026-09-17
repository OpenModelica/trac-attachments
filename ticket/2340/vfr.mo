package Buildings 
  extends Modelica.Icons.Package;

  package Fluid 
    extends Modelica.Icons.Package;

    package Sensors 
      extends Modelica.Icons.SensorsPackage;

      model VolumeFlowRate 
        extends Buildings.Fluid.Sensors.BaseClasses.PartialDynamicFlowSensor;
        extends Modelica.Icons.RotationalSensor;
        parameter Medium.Density d_start = Medium.density(Medium.setState_pTX(p_start, T_start, X_start));
        parameter Modelica.SIunits.Temperature T_start = Medium.T_default;
        parameter Modelica.SIunits.Pressure p_start = Medium.p_default;
        parameter Modelica.SIunits.MassFraction[Medium.nX] X_start = Medium.X_default;
        Modelica.Blocks.Interfaces.RealOutput V_flow(final quantity = "VolumeFlowRate", final unit = "m3/s");
      protected
        Medium.Density dMed(start = d_start);
        Medium.Density d_a_inflow(start = d_start);
        Medium.Density d_b_inflow(start = d_start);
        Medium.Density d(start = d_start);
      initial equation
        if dynamic then
          if initType == Modelica.Blocks.Types.Init.SteadyState then
            der(d) = 0;
          elseif initType == Modelica.Blocks.Types.Init.InitialState or initType == Modelica.Blocks.Types.Init.InitialOutput then
            d = d_start;
          end if;
        end if;
      equation
        if allowFlowReversal then
          d_a_inflow = Medium.density(state = Medium.setState_phX(p = port_b.p, h = port_b.h_outflow, X = port_b.Xi_outflow));
          d_b_inflow = Medium.density(state = Medium.setState_phX(p = port_a.p, h = port_a.h_outflow, X = port_a.Xi_outflow));
          dMed = Modelica.Fluid.Utilities.regStep(x = port_a.m_flow, y1 = d_a_inflow, y2 = d_b_inflow, x_small = m_flow_small);
        else
          dMed = Medium.density(state = Medium.setState_phX(p = port_b.p, h = port_b.h_outflow, X = port_b.Xi_outflow));
          d_a_inflow = dMed;
          d_b_inflow = dMed;
        end if;
        if dynamic then
          der(d) = (dMed - d) * k / tau;
        else
          d = dMed;
        end if;
        V_flow = port_a.m_flow / d;
      end VolumeFlowRate;

      package Examples 
        extends Modelica.Icons.ExamplesPackage;

        model VolumeFlowRate 
          extends Modelica.Icons.Example;
          package Medium = .Buildings.Media.PerfectGases.MoistAirUnsaturated;
          .Buildings.Fluid.Sources.Boundary_pT sin(redeclare package Medium = Medium, T = 293.15, nPorts = 1);
          .Buildings.Fluid.Sources.MassFlowSource_T masFloRat(redeclare package Medium = Medium, use_T_in = false, X = {0.02, 0.98}, use_m_flow_in = true, nPorts = 1);
          inner Modelica.Fluid.System system;
          Modelica.Blocks.Sources.Ramp ramp(height = -20, offset = 10, duration = 60);
          .Buildings.Fluid.Sensors.VolumeFlowRate senDyn(redeclare package Medium = Medium, m_flow_nominal = 10);
          .Buildings.Fluid.Sensors.VolumeFlowRate senSteSta(redeclare package Medium = Medium, m_flow_nominal = 10, tau = 0);
        equation
          connect(ramp.y, masFloRat.m_flow_in);
          connect(masFloRat.ports[1], senDyn.port_a);
          connect(senDyn.port_b, senSteSta.port_a);
          connect(senSteSta.port_b, sin.ports[1]);
        end VolumeFlowRate;
      end Examples;

      package BaseClasses 
        extends Modelica.Icons.BasesPackage;

        partial model PartialDynamicFlowSensor 
          extends PartialFlowSensor;
          parameter Modelica.SIunits.Time tau(min = 0) = 1;
          parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.InitialState;
        protected
          Real k(start = 1);
          final parameter Boolean dynamic = tau > 0.0000000001 or tau < -0.0000000001;
          Real mNor_flow;
        equation
          if dynamic then
            mNor_flow = port_a.m_flow / m_flow_nominal;
            k = Modelica.Fluid.Utilities.regStep(x = port_a.m_flow, y1 = mNor_flow, y2 = -mNor_flow, x_small = m_flow_small);
          else
            mNor_flow = 1;
            k = 1;
          end if;
        end PartialDynamicFlowSensor;

        partial model PartialFlowSensor 
          extends Modelica.Fluid.Interfaces.PartialTwoPort;
          parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min = 0);
          parameter Modelica.SIunits.MassFlowRate m_flow_small(min = 0) = 0.0001 * m_flow_nominal;
        equation
          port_b.m_flow = -port_a.m_flow;
          port_a.p = port_b.p;
          port_a.h_outflow = inStream(port_b.h_outflow);
          port_b.h_outflow = inStream(port_a.h_outflow);
          port_a.Xi_outflow = inStream(port_b.Xi_outflow);
          port_b.Xi_outflow = inStream(port_a.Xi_outflow);
          port_a.C_outflow = inStream(port_b.C_outflow);
          port_b.C_outflow = inStream(port_a.C_outflow);
        end PartialFlowSensor;
      end BaseClasses;
    end Sensors;

    package Sources 
      extends Modelica.Icons.SourcesPackage;

      model Boundary_pT 
        extends Modelica.Fluid.Sources.BaseClasses.PartialSource;
        parameter Boolean use_p_in = false;
        parameter Boolean use_T_in = false;
        parameter Boolean use_X_in = false;
        parameter Boolean use_C_in = false;
        parameter Medium.AbsolutePressure p = Medium.p_default;
        parameter Medium.Temperature T = Medium.T_default;
        parameter Medium.MassFraction[Medium.nX] X = Medium.X_default;
        parameter Medium.ExtraProperty[Medium.nC] C(quantity = Medium.extraPropertiesNames) = fill(0, Medium.nC);
        Modelica.Blocks.Interfaces.RealInput p_in if use_p_in;
        Modelica.Blocks.Interfaces.RealInput T_in if use_T_in;
        Modelica.Blocks.Interfaces.RealInput[Medium.nX] X_in if use_X_in;
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in if use_C_in;
      protected
        Modelica.Blocks.Interfaces.RealInput p_in_internal;
        Modelica.Blocks.Interfaces.RealInput T_in_internal;
        Modelica.Blocks.Interfaces.RealInput[Medium.nX] X_in_internal;
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in_internal;
      equation
        Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, Medium.singleState, true, X_in_internal, "Boundary_pT");
        connect(p_in, p_in_internal);
        connect(T_in, T_in_internal);
        connect(X_in, X_in_internal);
        connect(C_in, C_in_internal);
        if not use_p_in then
          p_in_internal = p;
        end if;
        if not use_T_in then
          T_in_internal = T;
        end if;
        if not use_X_in then
          X_in_internal = X;
        end if;
        if not use_C_in then
          C_in_internal = C;
        end if;
        medium.p = p_in_internal;
        medium.T = T_in_internal;
        medium.Xi = X_in_internal[1:Medium.nXi];
        ports.C_outflow = fill(C_in_internal, nPorts);
      end Boundary_pT;

      model MassFlowSource_T 
        extends Modelica.Fluid.Sources.BaseClasses.PartialSource;
        parameter Boolean use_m_flow_in = false;
        parameter Boolean use_T_in = false;
        parameter Boolean use_X_in = false;
        parameter Boolean use_C_in = false;
        parameter Modelica.SIunits.MassFlowRate m_flow = 0;
        parameter Medium.Temperature T = Medium.T_default;
        parameter Medium.MassFraction[Medium.nX] X = Medium.X_default;
        parameter Medium.ExtraProperty[Medium.nC] C(quantity = Medium.extraPropertiesNames) = fill(0, Medium.nC);
        Modelica.Blocks.Interfaces.RealInput m_flow_in if use_m_flow_in;
        Modelica.Blocks.Interfaces.RealInput T_in if use_T_in;
        Modelica.Blocks.Interfaces.RealInput[Medium.nX] X_in if use_X_in;
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in if use_C_in;
      protected
        Modelica.Blocks.Interfaces.RealInput m_flow_in_internal;
        Modelica.Blocks.Interfaces.RealInput T_in_internal;
        Modelica.Blocks.Interfaces.RealInput[Medium.nX] X_in_internal;
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in_internal;
      equation
        Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames, Medium.singleState, true, X_in_internal, "MassFlowSource_T");
        connect(m_flow_in, m_flow_in_internal);
        connect(T_in, T_in_internal);
        connect(X_in, X_in_internal);
        connect(C_in, C_in_internal);
        if not use_m_flow_in then
          m_flow_in_internal = m_flow;
        end if;
        if not use_T_in then
          T_in_internal = T;
        end if;
        if not use_X_in then
          X_in_internal = X;
        end if;
        if not use_C_in then
          C_in_internal = C;
        end if;
        sum(ports.m_flow) = -m_flow_in_internal;
        medium.T = T_in_internal;
        medium.Xi = X_in_internal[1:Medium.nXi];
        ports.C_outflow = fill(C_in_internal, nPorts);
      end MassFlowSource_T;
    end Sources;
  end Fluid;

  package Media 
    extends Modelica.Icons.MaterialPropertiesPackage;

    package PerfectGases 
      extends Modelica.Icons.MaterialPropertiesPackage;

      package MoistAir 
        extends Modelica.Media.Interfaces.PartialCondensingGases(mediumName = "Moist air perfect gas", substanceNames = {"water", "air"}, final reducedX = true, final singleState = false, reference_X = {0.01, 0.99}, fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O, Modelica.Media.IdealGases.Common.FluidData.N2});
        constant Integer Water = 1;
        constant Integer Air = 2;
        constant Real k_mair = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM / Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM;
        constant Modelica.SIunits.SpecificHeatCapacity steam_R = 461.5233290850878;
        constant Modelica.SIunits.SpecificHeatCapacity steam_cp = 1860;
        constant Modelica.SIunits.SpecificHeatCapacity steam_cv = steam_cp - steam_R;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_R = 287.0512249529787;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_cp = 1006;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_cv = dryair_cp - dryair_R;
        constant Modelica.SIunits.Temperature TMin = 200;
        constant Modelica.SIunits.Temperature TMax = 400;

        redeclare record extends ThermodynamicState end ThermodynamicState;

        redeclare replaceable model extends BaseProperties 
          MassFraction x_water;
          Real phi;
        protected
          constant .Modelica.SIunits.MolarMass[2] MMX = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM, Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM};
          MassFraction X_liquid;
          MassFraction X_steam;
          MassFraction X_air;
          MassFraction X_sat;
          MassFraction x_sat;
          AbsolutePressure p_steam_sat;
        equation
          assert(T >= TMin and T <= TMax, "
          Temperature T is not in the allowed range " + String(TMin) + " <= (T =" + String(T) + " K) <= " + String(TMax) + " K
          required from medium model \"" + mediumName + "\".");
          MM = 1 / (Xi[Water] / MMX[Water] + (1.0 - Xi[Water]) / MMX[Air]);
          p_steam_sat = min(saturationPressure(T), 0.999 * p);
          X_sat = min(p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - p_steam_sat) * (1 - Xi[Water]), 1.0);
          X_liquid = max(Xi[Water] - X_sat, 0.0);
          X_steam = Xi[Water] - X_liquid;
          X_air = 1 - Xi[Water];
          h = specificEnthalpy_pTX(p, T, Xi);
          R = dryair_R * (1 - X_steam / (1 - X_liquid)) + steam_R * X_steam / (1 - X_liquid);
          u = h - R * T;
          d = p / (R * T);
          state.p = p;
          state.T = T;
          state.X = X;
          x_sat = k_mair * p_steam_sat / max(100 * Modelica.Constants.eps, p - p_steam_sat);
          x_water = Xi[Water] / max(X_air, 100 * Modelica.Constants.eps);
          phi = p / p_steam_sat * Xi[Water] / (Xi[Water] + k_mair * X_air);
        end BaseProperties;

        redeclare function setState_pTX 
          extends Modelica.Media.Air.MoistAir.setState_pTX;
        end setState_pTX;

        redeclare function setState_phX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T_phX(p, h, X), X = X) else ThermodynamicState(p = p, T = T_phX(p, h, X), X = cat(1, X, {1 - sum(X)}));
        end setState_phX;

        redeclare function setState_dTX 
          extends Modelica.Media.Air.MoistAir.setState_dTX;
        end setState_dTX;

        redeclare function gasConstant 
          extends Modelica.Media.Air.MoistAir.gasConstant;
        end gasConstant;

        function saturationPressureLiquid 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          output .Modelica.SIunits.AbsolutePressure psat;
        algorithm
          psat := 611.657 * Modelica.Math.exp(17.2799 - 4102.99 / (Tsat - 35.719));
        end saturationPressureLiquid;

        function saturationPressureLiquid_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          input Real dTsat(unit = "K/s");
          output Real psat_der(unit = "Pa/s");
        algorithm
          psat_der := 611.657 * Modelica.Math.exp(17.2799 - 4102.99 / (Tsat - 35.719)) * 4102.99 * dTsat / (Tsat - 35.719) / (Tsat - 35.719);
        end saturationPressureLiquid_der;

        function sublimationPressureIce = Modelica.Media.Air.MoistAir.sublimationPressureIce;

        redeclare function extends saturationPressure 
        algorithm
          psat := Buildings.Utilities.Math.Functions.spliceFunction(saturationPressureLiquid(Tsat), sublimationPressureIce(Tsat), Tsat - 273.16, 1.0);
        end saturationPressure;

        redeclare function pressure 
          extends Modelica.Media.Air.MoistAir.pressure;
        end pressure;

        redeclare function temperature 
          extends Modelica.Media.Air.MoistAir.temperature;
        end temperature;

        redeclare function density 
          extends Modelica.Media.Air.MoistAir.density;
        end density;

        redeclare function specificEntropy 
          extends Modelica.Media.Air.MoistAir.specificEntropy;
        end specificEntropy;

        redeclare function extends enthalpyOfVaporization 
        algorithm
          r0 := 2501014.5;
        end enthalpyOfVaporization;

        redeclare replaceable function extends enthalpyOfLiquid 
        algorithm
          h := (T - 273.15) * 4186;
        end enthalpyOfLiquid;

        replaceable function der_enthalpyOfLiquid 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := 4186 * der_T;
        end der_enthalpyOfLiquid;

        redeclare function enthalpyOfCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := (T - 273.15) * steam_cp + enthalpyOfVaporization(T);
        end enthalpyOfCondensingGas;

        replaceable function der_enthalpyOfCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := steam_cp * der_T;
        end der_enthalpyOfCondensingGas;

        redeclare function enthalpyOfNonCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := enthalpyOfDryAir(T);
        end enthalpyOfNonCondensingGas;

        replaceable function der_enthalpyOfNonCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := der_enthalpyOfDryAir(T, der_T);
        end der_enthalpyOfNonCondensingGas;

        redeclare replaceable function extends enthalpyOfGas 
        algorithm
          h := enthalpyOfCondensingGas(T) * X[Water] + enthalpyOfDryAir(T) * (1.0 - X[Water]);
        end enthalpyOfGas;

        replaceable function enthalpyOfDryAir 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := (T - 273.15) * dryair_cp;
        end enthalpyOfDryAir;

        replaceable function der_enthalpyOfDryAir 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := dryair_cp * der_T;
        end der_enthalpyOfDryAir;

        redeclare replaceable function extends specificHeatCapacityCp 
        algorithm
          cp := dryair_cp * (1 - state.X[Water]) + steam_cp * state.X[Water];
        end specificHeatCapacityCp;

        redeclare replaceable function extends specificHeatCapacityCv 
        algorithm
          cv := dryair_cv * (1 - state.X[Water]) + steam_cv * state.X[Water];
        end specificHeatCapacityCv;

        redeclare function extends dynamicViscosity 
        algorithm
          eta := 0.0000185;
        end dynamicViscosity;

        redeclare function extends thermalConductivity 
        algorithm
          lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate({-0.000000048737307422969, 0.0000767803133753502, 0.0241814385504202}, Modelica.SIunits.Conversions.to_degC(state.T));
        end thermalConductivity;

        function h_pTX 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          output .Modelica.SIunits.SpecificEnthalpy h;
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction x_sat;
          .Modelica.SIunits.MassFraction X_liquid;
          .Modelica.SIunits.MassFraction X_steam;
          .Modelica.SIunits.MassFraction X_air;
          .Modelica.SIunits.SpecificEnthalpy hDryAir;
        algorithm
          p_steam_sat := saturationPressure(T);
          x_sat := k_mair * p_steam_sat / (p - p_steam_sat);
          X_liquid := max(X[Water] - x_sat / (1 + x_sat), 0.0);
          X_steam := X[Water] - X_liquid;
          X_air := 1 - X[Water];
          hDryAir := (T - 273.15) * dryair_cp;
          h := hDryAir * X_air + ((T - 273.15) * steam_cp + 2501014.5) * X_steam + (T - 273.15) * 4186 * X_liquid;
        end h_pTX;

        redeclare function extends specificEnthalpy 
        algorithm
          h := h_pTX(state.p, state.T, state.X);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy 
          extends Modelica.Icons.Function;
        algorithm
          u := h_pTX(state.p, state.T, state.X) - gasConstant(state) * state.T;
        end specificInternalEnergy;

        redeclare function extends specificGibbsEnergy 
          extends Modelica.Icons.Function;
        algorithm
          g := h_pTX(state.p, state.T, state.X) - state.T * specificEntropy(state);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy 
          extends Modelica.Icons.Function;
        algorithm
          f := h_pTX(state.p, state.T, state.X) - gasConstant(state) * state.T - state.T * specificEntropy(state);
        end specificHelmholtzEnergy;

        function T_phX 
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X;
          output Temperature T;

        protected
          package Internal 
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data 
              extends Modelica.Media.IdealGases.Common.DataRecord;
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear 
            algorithm
              y := h_pTX(p, x, X);
            end f_nonlinear;

            redeclare function extends solve end solve;
          end Internal;

          constant Modelica.Media.IdealGases.Common.DataRecord steam = Modelica.Media.IdealGases.Common.SingleGasesData.H2O;
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction x_sat;
        algorithm
          T := 273.15 + (h - 2501014.5 * X[Water]) / ((1 - X[Water]) * dryair_cp + X[Water] * Buildings.Media.PerfectGases.Common.SingleGasData.H2O.cp);
          p_steam_sat := saturationPressure(T);
          x_sat := k_mair * p_steam_sat / (p - p_steam_sat);
          if X[Water] > x_sat / (1 + x_sat) then
            T := Internal.solve(h, TMin, TMax, p, X[1:nXi], steam);
          else
          end if;
        end T_phX;
      end MoistAir;

      package MoistAirUnsaturated 
        extends Modelica.Media.Interfaces.PartialCondensingGases(mediumName = "Moist air unsaturated perfect gas", substanceNames = {"water", "air"}, final reducedX = true, final singleState = false, reference_X = {0.01, 0.99}, fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O, Modelica.Media.IdealGases.Common.FluidData.N2});
        constant Integer Water = 1;
        constant Integer Air = 2;
        constant Real k_mair = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM / Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM;
        constant Modelica.SIunits.SpecificHeatCapacity steam_R = 461.5233290850878;
        constant Modelica.SIunits.SpecificHeatCapacity steam_cp = 1860;
        constant Modelica.SIunits.SpecificHeatCapacity steam_cv = steam_cp - steam_R;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_R = 287.0512249529787;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_cp = 1006;
        constant Modelica.SIunits.SpecificHeatCapacity dryair_cv = dryair_cp - dryair_R;
        constant Buildings.Media.PerfectGases.Common.DataRecord steam = Common.SingleGasData.H2O;

        redeclare record extends ThermodynamicState end ThermodynamicState;

        redeclare replaceable model extends BaseProperties 
          MassFraction x_water;
          Real phi;
        protected
          constant .Modelica.SIunits.MolarMass[2] MMX = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM, Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM};
          MassFraction X_steam;
          MassFraction X_air;
          MassFraction X_sat;
          MassFraction x_sat;
          AbsolutePressure p_steam_sat;
        equation
          assert(T >= 200.0 and T <= 423.15, "
          Temperature T is not in the allowed range
          200.0 K <= (T =" + String(T) + " K) <= 423.15 K
          required from medium model \"" + mediumName + "\".");
          MM = 1 / (Xi[Water] / MMX[Water] + (1.0 - Xi[Water]) / MMX[Air]);
          p_steam_sat = min(saturationPressure(T), 0.999 * p);
          X_sat = min(p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - p_steam_sat) * (1 - Xi[Water]), 1.0);
          X_steam = Xi[Water];
          X_air = 1 - Xi[Water];
          h = specificEnthalpy_pTX(p, T, Xi);
          R = dryair_R * (1 - X_steam) + steam_R * X_steam;
          u = h - R * T;
          d = p / (R * T);
          state.p = p;
          state.T = T;
          state.X = X;
          x_sat = k_mair * p_steam_sat / max(100 * Modelica.Constants.eps, p - p_steam_sat);
          x_water = Xi[Water] / max(X_air, 100 * Modelica.Constants.eps);
          phi = p / p_steam_sat * Xi[Water] / (Xi[Water] + k_mair * X_air);
        end BaseProperties;

        redeclare function setState_pTX 
          extends Buildings.Media.PerfectGases.MoistAir.setState_pTX;
        end setState_pTX;

        redeclare function setState_phX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T_phX(p, h, X), X = X) else ThermodynamicState(p = p, T = T_phX(p, h, X), X = cat(1, X, {1 - sum(X)}));
        end setState_phX;

        redeclare function setState_dTX 
          extends Buildings.Media.PerfectGases.MoistAir.setState_dTX;
        end setState_dTX;

        redeclare function gasConstant 
          extends Buildings.Media.PerfectGases.MoistAir.gasConstant;
        end gasConstant;

        function saturationPressureLiquid 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          output .Modelica.SIunits.AbsolutePressure psat;
        algorithm
          psat := 611.657 * Modelica.Math.exp(17.2799 - 4102.99 / (Tsat - 35.719));
        end saturationPressureLiquid;

        function saturationPressureLiquid_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          input Real dTsat(unit = "K/s");
          output Real psat_der(unit = "Pa/s");
        algorithm
          psat_der := 611.657 * Modelica.Math.exp(17.2799 - 4102.99 / (Tsat - 35.719)) * 4102.99 * dTsat / (Tsat - 35.719) / (Tsat - 35.719);
        end saturationPressureLiquid_der;

        function sublimationPressureIce = Buildings.Media.PerfectGases.MoistAir.sublimationPressureIce;

        redeclare function extends saturationPressure 
        algorithm
          psat := Buildings.Utilities.Math.Functions.spliceFunction(saturationPressureLiquid(Tsat), sublimationPressureIce(Tsat), Tsat - 273.16, 1.0);
        end saturationPressure;

        redeclare function pressure 
          extends Buildings.Media.PerfectGases.MoistAir.pressure;
        end pressure;

        redeclare function temperature 
          extends Buildings.Media.PerfectGases.MoistAir.temperature;
        end temperature;

        redeclare function density 
          extends Buildings.Media.PerfectGases.MoistAir.density;
        end density;

        redeclare function specificEntropy 
          extends Buildings.Media.PerfectGases.MoistAir.specificEntropy;
        end specificEntropy;

        redeclare function extends enthalpyOfVaporization 
        algorithm
          r0 := 2501014.5;
        end enthalpyOfVaporization;

        redeclare replaceable function extends enthalpyOfLiquid 
        algorithm
          h := (T - 273.15) * 4186;
        end enthalpyOfLiquid;

        replaceable function der_enthalpyOfLiquid 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := 4186 * der_T;
        end der_enthalpyOfLiquid;

        redeclare function enthalpyOfCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := (T - 273.15) * steam_cp + enthalpyOfVaporization(T);
        end enthalpyOfCondensingGas;

        replaceable function der_enthalpyOfCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := steam_cp * der_T;
        end der_enthalpyOfCondensingGas;

        redeclare function enthalpyOfNonCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := enthalpyOfDryAir(T);
        end enthalpyOfNonCondensingGas;

        replaceable function der_enthalpyOfNonCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := der_enthalpyOfDryAir(T, der_T);
        end der_enthalpyOfNonCondensingGas;

        redeclare replaceable function extends enthalpyOfGas 
        algorithm
          h := enthalpyOfCondensingGas(T) * X[Water] + enthalpyOfDryAir(T) * (1.0 - X[Water]);
        end enthalpyOfGas;

        replaceable function enthalpyOfDryAir 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        algorithm
          h := (T - 273.15) * dryair_cp;
        end enthalpyOfDryAir;

        replaceable function der_enthalpyOfDryAir 
          extends Modelica.Icons.Function;
          input Temperature T;
          input Real der_T;
          output Real der_h;
        algorithm
          der_h := dryair_cp * der_T;
        end der_enthalpyOfDryAir;

        redeclare replaceable function extends specificHeatCapacityCp 
        algorithm
          cp := dryair_cp * (1 - state.X[Water]) + steam_cp * state.X[Water];
        end specificHeatCapacityCp;

        replaceable function der_specificHeatCapacityCp 
          input ThermodynamicState state;
          input ThermodynamicState der_state;
          output Real der_cp(unit = "J/(kg.K.s)");
        algorithm
          der_cp := (steam_cp - dryair_cp) * der_state.X[Water];
        end der_specificHeatCapacityCp;

        redeclare replaceable function extends specificHeatCapacityCv 
        algorithm
          cv := dryair_cv * (1 - state.X[Water]) + steam_cv * state.X[Water];
        end specificHeatCapacityCv;

        replaceable function der_specificHeatCapacityCv 
          input ThermodynamicState state;
          input ThermodynamicState der_state;
          output Real der_cv(unit = "J/(kg.K.s)");
        algorithm
          der_cv := (steam_cv - dryair_cv) * der_state.X[Water];
        end der_specificHeatCapacityCv;

        redeclare function extends dynamicViscosity 
        algorithm
          eta := 0.0000185;
        end dynamicViscosity;

        redeclare function extends thermalConductivity 
        algorithm
          lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate({-0.000000048737307422969, 0.0000767803133753502, 0.0241814385504202}, Modelica.SIunits.Conversions.to_degC(state.T));
        end thermalConductivity;

        function h_pTX 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          output .Modelica.SIunits.SpecificEnthalpy h;
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction x_sat;
          .Modelica.SIunits.SpecificEnthalpy hDryAir;
        algorithm
          p_steam_sat := saturationPressure(T);
          x_sat := k_mair * p_steam_sat / (p - p_steam_sat);
          hDryAir := (T - 273.15) * dryair_cp;
          h := hDryAir * (1 - X[Water]) + ((T - 273.15) * steam.cp + 2501014.5) * X[Water];
        end h_pTX;

        redeclare function extends specificEnthalpy 
        algorithm
          h := h_pTX(state.p, state.T, state.X);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy 
          extends Modelica.Icons.Function;
        algorithm
          u := h_pTX(state.p, state.T, state.X) - gasConstant(state) * state.T;
        end specificInternalEnergy;

        redeclare function extends specificGibbsEnergy 
          extends Modelica.Icons.Function;
        algorithm
          g := h_pTX(state.p, state.T, state.X) - state.T * specificEntropy(state);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy 
          extends Modelica.Icons.Function;
        algorithm
          f := h_pTX(state.p, state.T, state.X) - gasConstant(state) * state.T - state.T * specificEntropy(state);
        end specificHelmholtzEnergy;

        function T_phX 
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X;
          output Temperature T;
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction x_sat;
        algorithm
          T := 273.15 + (h - 2501014.5 * X[Water]) / ((1 - X[Water]) * dryair_cp + X[Water] * steam_cp);
          p_steam_sat := saturationPressure(T);
          x_sat := k_mair * p_steam_sat / (p - p_steam_sat);
        end T_phX;
      end MoistAirUnsaturated;

      package Common 
        extends Modelica.Icons.MaterialPropertiesPackage;

        record DataRecord 
          extends Modelica.Icons.Record;
          String name;
          Modelica.SIunits.MolarMass MM;
          Modelica.SIunits.SpecificHeatCapacity R;
          Modelica.SIunits.SpecificHeatCapacity cp;
          Modelica.SIunits.SpecificHeatCapacity cv = cp - R;
        end DataRecord;

        package SingleGasData 
          extends Modelica.Icons.MaterialPropertiesPackage;
          constant PerfectGases.Common.DataRecord H2O(
             name = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.name, 
             R = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R, 
             MM = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM, 
             cp = 1860);
        end SingleGasData;
      end Common;
    end PerfectGases;
  end Media;

  package Utilities 
    extends Modelica.Icons.Package;

    package Math 
      extends Modelica.Icons.VariantsPackage;

      package Functions 
        extends Modelica.Icons.BasesPackage;

        function spliceFunction 
          input Real pos;
          input Real neg;
          input Real x;
          input Real deltax;
          output Real out;
        protected
          Real scaledX1;
          Real y;
          constant Real asin1 = Modelica.Math.asin(1);
        algorithm
          scaledX1 := x / deltax;
          if scaledX1 <= -0.999999999 then
            out := neg;
          elseif scaledX1 >= 0.999999999 then
            out := pos;
          else
            y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX1 * asin1)) + 1) / 2;
            out := pos * y + (1 - y) * neg;
          end if;
        end spliceFunction;

        package BaseClasses 
          extends Modelica.Icons.BasesPackage;

          function der_spliceFunction 
            input Real pos;
            input Real neg;
            input Real x;
            input Real deltax = 1;
            input Real dpos;
            input Real dneg;
            input Real dx;
            input Real ddeltax = 0;
            output Real out;
          protected
            Real scaledX;
            Real scaledX1;
            Real dscaledX1;
            Real y;
            constant Real asin1 = Modelica.Math.asin(1);
          algorithm
            scaledX1 := x / deltax;
            if scaledX1 <= -0.99999999999 then
              out := dneg;
            elseif scaledX1 >= 0.9999999999 then
              out := dpos;
            else
              scaledX := scaledX1 * asin1;
              dscaledX1 := (dx - scaledX1 * ddeltax) / deltax;
              y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1) / 2;
              out := dpos * y + (1 - y) * dneg;
              out := out + (pos - neg) * dscaledX1 * asin1 / 2 / (Modelica.Math.cosh(Modelica.Math.tan(scaledX)) * Modelica.Math.cos(scaledX)) ^ 2;
            end if;
          end der_spliceFunction;
        end BaseClasses;
      end Functions;
    end Math;
  end Utilities;
end Buildings;

package ModelicaServices 
  extends Modelica.Icons.Package;

  package Machine 
    extends Modelica.Icons.Package;
    final constant Real eps = 0.000000000000001;
    final constant Real small = 1e-60;
    final constant Real inf = 1e+60;
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax();
  end Machine;
end ModelicaServices;

package Modelica 
  extends Modelica.Icons.Package;

  package Blocks 
    extends Modelica.Icons.Package;

    package Interfaces 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real;
      connector RealOutput = output Real;

      partial block SO 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y;
      end SO;
    end Interfaces;

    package Sources 
      extends Modelica.Icons.SourcesPackage;

      block Ramp 
        parameter Real height = 1;
        parameter Modelica.SIunits.Time duration(min = 0.0, start = 2);
        parameter Real offset = 0;
        parameter Modelica.SIunits.Time startTime = 0;
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = offset + (if time < startTime then 0 else if time < startTime + duration then (time - startTime) * height / duration else height);
      end Ramp;
    end Sources;

    package Types 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit, SteadyState, InitialState, InitialOutput);
    end Types;

    package Icons 
      extends Modelica.Icons.IconsPackage;

      partial block Block end Block;
    end Icons;
  end Blocks;

  package Fluid 
    extends Modelica.Icons.Package;

    model System 
      parameter Modelica.SIunits.AbsolutePressure p_ambient = 101325;
      parameter Modelica.SIunits.Temperature T_ambient = 293.15;
      parameter Modelica.SIunits.Acceleration g = Modelica.Constants.g_n;
      parameter Boolean allowFlowReversal = true;
      parameter Modelica.Fluid.Types.Dynamics energyDynamics = Types.Dynamics.DynamicFreeInitial;
      parameter Modelica.Fluid.Types.Dynamics massDynamics = energyDynamics;
      final parameter Modelica.Fluid.Types.Dynamics substanceDynamics = massDynamics;
      final parameter Modelica.Fluid.Types.Dynamics traceDynamics = massDynamics;
      parameter Modelica.Fluid.Types.Dynamics momentumDynamics = Types.Dynamics.SteadyState;
      parameter Modelica.SIunits.MassFlowRate m_flow_start = 0;
      parameter Modelica.SIunits.AbsolutePressure p_start = p_ambient;
      parameter Modelica.SIunits.Temperature T_start = T_ambient;
      parameter Boolean use_eps_Re = false;
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal = if use_eps_Re then 1 else 100.0 * m_flow_small;
      parameter Real eps_m_flow(min = 0) = 0.0001;
      parameter Modelica.SIunits.AbsolutePressure dp_small(min = 0) = 1;
      parameter Modelica.SIunits.MassFlowRate m_flow_small(min = 0) = 0.01;
    end System;

    package Sources 
      extends Modelica.Icons.SourcesPackage;

      package BaseClasses 
        extends Modelica.Icons.BasesPackage;

        partial model PartialSource 
          parameter Integer nPorts = 0;
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          Medium.BaseProperties medium;
          Interfaces.FluidPorts_b[nPorts] ports(redeclare each package Medium = Medium, m_flow(each max = if flowDirection == Types.PortFlowDirection.Leaving then 0 else +.Modelica.Constants.inf, each min = if flowDirection == Types.PortFlowDirection.Entering then 0 else -.Modelica.Constants.inf));
        protected
          parameter Types.PortFlowDirection flowDirection = Types.PortFlowDirection.Bidirectional;
        equation
          for i in 1:nPorts loop
            assert(cardinality(ports[i]) <= 1, "
            each ports[i] of boundary shall at most be connected to one component.
            If two or more connections are present, ideal mixing takes
            place with these connections, which is usually not the intention
            of the modeller. Increase nPorts to add an additional port.
            ");
            ports[i].p = medium.p;
            ports[i].h_outflow = medium.h;
            ports[i].Xi_outflow = medium.Xi;
          end for;
        end PartialSource;
      end BaseClasses;
    end Sources;

    package Interfaces 
      extends Modelica.Icons.InterfacesPackage;

      connector FluidPort 
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
        flow Medium.MassFlowRate m_flow;
        Medium.AbsolutePressure p;
        stream Medium.SpecificEnthalpy h_outflow;
        stream Medium.MassFraction[Medium.nXi] Xi_outflow;
        stream Medium.ExtraProperty[Medium.nC] C_outflow;
      end FluidPort;

      connector FluidPort_a 
        extends FluidPort;
      end FluidPort_a;

      connector FluidPort_b 
        extends FluidPort;
      end FluidPort_b;

      connector FluidPorts_b 
        extends FluidPort;
      end FluidPorts_b;

      partial model PartialTwoPort 
        outer Modelica.Fluid.System system;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
        parameter Boolean allowFlowReversal = system.allowFlowReversal;
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -.Modelica.Constants.inf else 0));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +.Modelica.Constants.inf else 0));
      protected
        parameter Boolean port_a_exposesState = false;
        parameter Boolean port_b_exposesState = false;
        parameter Boolean showDesignFlowDirection = true;
      end PartialTwoPort;
    end Interfaces;

    package Types 
      extends Modelica.Icons.TypesPackage;
      type Dynamics = enumeration(DynamicFreeInitial, FixedInitial, SteadyStateInitial, SteadyState);
      type PortFlowDirection = enumeration(Entering, Leaving, Bidirectional);
    end Types;

    package Utilities 
      extends Modelica.Icons.UtilitiesPackage;

      function checkBoundary 
        extends Modelica.Icons.Function;
        input String mediumName;
        input String[:] substanceNames;
        input Boolean singleState;
        input Boolean define_p;
        input Real[:] X_boundary;
        input String modelName = "??? boundary ???";
      protected
        Integer nX = size(X_boundary, 1);
        String X_str;
      algorithm
        assert(not singleState or singleState and define_p, "
        Wrong value of parameter define_p (= false) in model \"" + modelName + "\":
        The selected medium \"" + mediumName + "\" has Medium.singleState=true.
        Therefore, an boundary density cannot be defined and
        define_p = true is required.
        ");
        for i in 1:nX loop
          assert(X_boundary[i] >= 0.0, "
          Wrong boundary mass fractions in medium \"" + mediumName + "\" in model \"" + modelName + "\":
          The boundary value X_boundary(" + String(i) + ") = " + String(X_boundary[i]) + "
          is negative. It must be positive.
          ");
        end for;
        if nX > 0 and abs(sum(X_boundary) - 1.0) > 0.0000000001 then
          X_str := "";
          for i in 1:nX loop
            X_str := X_str + "   X_boundary[" + String(i) + "] = " + String(X_boundary[i]) + " \"" + substanceNames[i] + "\"\n";
          end for;
          Modelica.Utilities.Streams.error("The boundary mass fractions in medium \"" + mediumName + "\" in model \"" + modelName + "\"\n" + "do not sum up to 1. Instead, sum(X_boundary) = " + String(sum(X_boundary)) + ":\n" + X_str);
        else
        end if;
      end checkBoundary;

      function regStep 
        extends Modelica.Icons.Function;
        input Real x;
        input Real y1;
        input Real y2;
        input Real x_small(min = 0) = 0.00001;
        output Real y;
      algorithm
        y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if x_small > 0 then x / x_small * ((x / x_small) ^ 2 - 3) * (y2 - y1) / 4 + (y1 + y2) / 2 else (y1 + y2) / 2);
      end regStep;
    end Utilities;
  end Fluid;

  package Media 
    extends Modelica.Icons.Package;

    package Interfaces 
      extends Modelica.Icons.InterfacesPackage;

      partial package PartialMedium 
        extends Modelica.Media.Interfaces.Types;
        extends Modelica.Icons.MaterialPropertiesPackage;
        constant Modelica.Media.Interfaces.Choices.IndependentVariables ThermoStates;
        constant String mediumName = "unusablePartialMedium";
        constant String[:] substanceNames = {mediumName};
        constant String[:] extraPropertiesNames = fill("", 0);
        constant Boolean singleState;
        constant Boolean reducedX = true;
        constant Boolean fixedX = false;
        constant AbsolutePressure reference_p = 101325;
        constant MassFraction[nX] reference_X = fill(1 / nX, nX);
        constant AbsolutePressure p_default = 101325;
        constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20);
        constant MassFraction[nX] X_default = reference_X;
        final constant Integer nS = size(substanceNames, 1);
        constant Integer nX = nS;
        constant Integer nXi = if fixedX then 0 else if reducedX then nS - 1 else nS;
        final constant Integer nC = size(extraPropertiesNames, 1);
        replaceable record FluidConstants = Modelica.Media.Interfaces.Types.Basic.FluidConstants;

        replaceable record ThermodynamicState 
          extends Modelica.Icons.Record;
        end ThermodynamicState;

        replaceable partial model BaseProperties 
          InputAbsolutePressure p;
          InputMassFraction[nXi] Xi(start = reference_X[1:nXi]);
          InputSpecificEnthalpy h;
          Density d;
          Temperature T;
          MassFraction[nX] X(start = reference_X);
          SpecificInternalEnergy u;
          SpecificHeatCapacity R;
          MolarMass MM;
          ThermodynamicState state;
          parameter Boolean preferredMediumStates = false;
          parameter Boolean standardOrderComponents = true;
          .Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_degC = Modelica.SIunits.Conversions.to_degC(T);
          .Modelica.SIunits.Conversions.NonSIunits.Pressure_bar p_bar = Modelica.SIunits.Conversions.to_bar(p);
          connector InputAbsolutePressure = input .Modelica.SIunits.AbsolutePressure;
          connector InputSpecificEnthalpy = input .Modelica.SIunits.SpecificEnthalpy;
          connector InputMassFraction = input .Modelica.SIunits.MassFraction;
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
              assert(X[i] >= -0.00001 and X[i] <= 1 + 0.00001, "Mass fraction X[" + String(i) + "] = " + String(X[i]) + "of substance " + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
            end for;
          end if;
          assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" + mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
        end BaseProperties;

        replaceable partial function setState_pTX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        end setState_pTX;

        replaceable partial function setState_phX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        end setState_phX;

        replaceable partial function setState_psX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEntropy s;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        end setState_psX;

        replaceable partial function setState_dTX 
          extends Modelica.Icons.Function;
          input Density d;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        end setState_dTX;

        replaceable partial function setSmoothState 
          extends Modelica.Icons.Function;
          input Real x;
          input ThermodynamicState state_a;
          input ThermodynamicState state_b;
          input Real x_small(min = 0);
          output ThermodynamicState state;
        end setSmoothState;

        replaceable partial function dynamicViscosity 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output DynamicViscosity eta;
        end dynamicViscosity;

        replaceable partial function thermalConductivity 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output ThermalConductivity lambda;
        end thermalConductivity;

        replaceable partial function pressure 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output AbsolutePressure p;
        end pressure;

        replaceable partial function temperature 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output Temperature T;
        end temperature;

        replaceable partial function density 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output Density d;
        end density;

        replaceable partial function specificEnthalpy 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificEnthalpy h;
        end specificEnthalpy;

        replaceable partial function specificInternalEnergy 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificEnergy u;
        end specificInternalEnergy;

        replaceable partial function specificEntropy 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificEntropy s;
        end specificEntropy;

        replaceable partial function specificGibbsEnergy 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificEnergy g;
        end specificGibbsEnergy;

        replaceable partial function specificHelmholtzEnergy 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificEnergy f;
        end specificHelmholtzEnergy;

        replaceable partial function specificHeatCapacityCp 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificHeatCapacity cp;
        end specificHeatCapacityCp;

        replaceable partial function specificHeatCapacityCv 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output SpecificHeatCapacity cv;
        end specificHeatCapacityCv;

        replaceable partial function isentropicExponent 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output IsentropicExponent gamma;
        end isentropicExponent;

        replaceable partial function isentropicEnthalpy 
          extends Modelica.Icons.Function;
          input AbsolutePressure p_downstream;
          input ThermodynamicState refState;
          output SpecificEnthalpy h_is;
        end isentropicEnthalpy;

        replaceable partial function velocityOfSound 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output VelocityOfSound a;
        end velocityOfSound;

        replaceable partial function isobaricExpansionCoefficient 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output IsobaricExpansionCoefficient beta;
        end isobaricExpansionCoefficient;

        replaceable partial function isothermalCompressibility 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output .Modelica.SIunits.IsothermalCompressibility kappa;
        end isothermalCompressibility;

        replaceable partial function density_derp_h 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output DerDensityByPressure ddph;
        end density_derp_h;

        replaceable partial function density_derh_p 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output DerDensityByEnthalpy ddhp;
        end density_derh_p;

        replaceable partial function density_derp_T 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output DerDensityByPressure ddpT;
        end density_derp_T;

        replaceable partial function density_derT_p 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output DerDensityByTemperature ddTp;
        end density_derT_p;

        replaceable partial function density_derX 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output Density[nX] dddX;
        end density_derX;

        replaceable partial function molarMass 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output MolarMass MM;
        end molarMass;

        replaceable function specificEnthalpy_pTX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output SpecificEnthalpy h;
        algorithm
          h := specificEnthalpy(setState_pTX(p, T, X));
        end specificEnthalpy_pTX;

        type MassFlowRate = .Modelica.SIunits.MassFlowRate(quantity = "MassFlowRate." + mediumName, min = -100000.0, max = 100000.0);
      end PartialMedium;

      partial package PartialMixtureMedium 
        extends PartialMedium(redeclare replaceable record FluidConstants = Modelica.Media.Interfaces.Types.IdealGas.FluidConstants);

        redeclare replaceable record extends ThermodynamicState 
          AbsolutePressure p;
          Temperature T;
          MassFraction[nX] X;
        end ThermodynamicState;

        constant FluidConstants[nS] fluidConstants;

        replaceable function gasConstant 
          extends Modelica.Icons.Function;
          input ThermodynamicState state;
          output .Modelica.SIunits.SpecificHeatCapacity R;
        end gasConstant;

        function massToMoleFractions 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.MassFraction[:] X;
          input .Modelica.SIunits.MolarMass[:] MMX;
          output .Modelica.SIunits.MoleFraction[size(X, 1)] moleFractions;
        protected
          Real[size(X, 1)] invMMX;
          .Modelica.SIunits.MolarMass Mmix;
        algorithm
          for i in 1:size(X, 1) loop
            invMMX[i] := 1 / MMX[i];
          end for;
          Mmix := 1 / (X * invMMX);
          for i in 1:size(X, 1) loop
            moleFractions[i] := Mmix * X[i] / MMX[i];
          end for;
        end massToMoleFractions;
      end PartialMixtureMedium;

      partial package PartialCondensingGases 
        extends PartialMixtureMedium(ThermoStates = Choices.IndependentVariables.pTX);

        replaceable partial function saturationPressure 
          extends Modelica.Icons.Function;
          input Temperature Tsat;
          output AbsolutePressure psat;
        end saturationPressure;

        replaceable partial function enthalpyOfVaporization 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy r0;
        end enthalpyOfVaporization;

        replaceable partial function enthalpyOfLiquid 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        end enthalpyOfLiquid;

        replaceable partial function enthalpyOfGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          input MassFraction[:] X;
          output SpecificEnthalpy h;
        end enthalpyOfGas;

        replaceable partial function enthalpyOfCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        end enthalpyOfCondensingGas;

        replaceable partial function enthalpyOfNonCondensingGas 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEnthalpy h;
        end enthalpyOfNonCondensingGas;
      end PartialCondensingGases;

      package Choices 
        extends Modelica.Icons.Package;
        type IndependentVariables = enumeration(T, pT, ph, phX, pTX, dTX);
        type ReferenceEnthalpy = enumeration(ZeroAt0K, ZeroAt25C, UserDefined);
      end Choices;

      package Types 
        extends Modelica.Icons.Package;
        type AbsolutePressure = .Modelica.SIunits.AbsolutePressure(min = 0, max = 100000000.0, nominal = 100000.0, start = 100000.0);
        type Density = .Modelica.SIunits.Density(min = 0, max = 100000.0, nominal = 1, start = 1);
        type DynamicViscosity = .Modelica.SIunits.DynamicViscosity(min = 0, max = 100000000.0, nominal = 0.001, start = 0.001);
        type MassFraction = Real(quantity = "MassFraction", final unit = "kg/kg", min = 0, max = 1, nominal = 0.1);
        type MoleFraction = Real(quantity = "MoleFraction", final unit = "mol/mol", min = 0, max = 1, nominal = 0.1);
        type MolarMass = .Modelica.SIunits.MolarMass(min = 0.001, max = 0.25, nominal = 0.032);
        type MolarVolume = .Modelica.SIunits.MolarVolume(min = 0.000001, max = 1000000.0, nominal = 1.0);
        type IsentropicExponent = .Modelica.SIunits.RatioOfSpecificHeatCapacities(min = 1, max = 500000, nominal = 1.2, start = 1.2);
        type SpecificEnergy = .Modelica.SIunits.SpecificEnergy(min = -100000000.0, max = 100000000.0, nominal = 1000000.0);
        type SpecificInternalEnergy = SpecificEnergy;
        type SpecificEnthalpy = .Modelica.SIunits.SpecificEnthalpy(min = -10000000000.0, max = 10000000000.0, nominal = 1000000.0);
        type SpecificEntropy = .Modelica.SIunits.SpecificEntropy(min = -10000000.0, max = 10000000.0, nominal = 1000.0);
        type SpecificHeatCapacity = .Modelica.SIunits.SpecificHeatCapacity(min = 0, max = 10000000.0, nominal = 1000.0, start = 1000.0);
        type Temperature = .Modelica.SIunits.Temperature(min = 1, max = 10000.0, nominal = 300, start = 300);
        type ThermalConductivity = .Modelica.SIunits.ThermalConductivity(min = 0, max = 500, nominal = 1, start = 1);
        type VelocityOfSound = .Modelica.SIunits.Velocity(min = 0, max = 100000.0, nominal = 1000, start = 1000);
        type ExtraProperty = Real(min = 0.0, start = 1.0);
        type IsobaricExpansionCoefficient = Real(min = 0, max = 100000000.0, unit = "1/K");
        type DipoleMoment = Real(min = 0.0, max = 2.0, unit = "debye", quantity = "ElectricDipoleMoment");
        type DerDensityByPressure = .Modelica.SIunits.DerDensityByPressure;
        type DerDensityByEnthalpy = .Modelica.SIunits.DerDensityByEnthalpy;
        type DerDensityByTemperature = .Modelica.SIunits.DerDensityByTemperature;

        package Basic 
          extends Icons.Package;

          record FluidConstants 
            extends Modelica.Icons.Record;
            String iupacName;
            String casRegistryNumber;
            String chemicalFormula;
            String structureFormula;
            MolarMass molarMass;
          end FluidConstants;
        end Basic;

        package IdealGas 
          extends Icons.Package;

          record FluidConstants 
            extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
            Temperature criticalTemperature;
            AbsolutePressure criticalPressure;
            MolarVolume criticalMolarVolume;
            Real acentricFactor;
            Temperature meltingPoint;
            Temperature normalBoilingPoint;
            DipoleMoment dipoleMoment;
            Boolean hasIdealGasHeatCapacity = false;
            Boolean hasCriticalData = false;
            Boolean hasDipoleMoment = false;
            Boolean hasFundamentalEquation = false;
            Boolean hasLiquidHeatCapacity = false;
            Boolean hasSolidHeatCapacity = false;
            Boolean hasAccurateViscosityData = false;
            Boolean hasAccurateConductivityData = false;
            Boolean hasVapourPressureCurve = false;
            Boolean hasAcentricFactor = false;
            SpecificEnthalpy HCRIT0 = 0.0;
            SpecificEntropy SCRIT0 = 0.0;
            SpecificEnthalpy deltah = 0.0;
            SpecificEntropy deltas = 0.0;
          end FluidConstants;
        end IdealGas;
      end Types;
    end Interfaces;

    package Common 
      extends Modelica.Icons.Package;
      constant Real MINPOS = 0.000000001;

      function smoothStep 
        extends Modelica.Icons.Function;
        input Real x;
        input Real y1;
        input Real y2;
        input Real x_small(min = 0) = 0.00001;
        output Real y;
      algorithm
        y := smooth(1, if x > x_small then y1 else if x < -x_small then y2 else if abs(x_small) > 0 then x / x_small * ((x / x_small) ^ 2 - 3) * (y2 - y1) / 4 + (y1 + y2) / 2 else (y1 + y2) / 2);
      end smoothStep;

      package OneNonLinearEquation 
        extends Modelica.Icons.Package;

        replaceable record f_nonlinear_Data 
          extends Modelica.Icons.Record;
        end f_nonlinear_Data;

        replaceable partial function f_nonlinear 
          extends Modelica.Icons.Function;
          input Real x;
          input Real p = 0.0;
          input Real[:] X = fill(0, 0);
          input f_nonlinear_Data f_nonlinear_data;
          output Real y;
        end f_nonlinear;

        replaceable function solve 
          extends Modelica.Icons.Function;
          input Real y_zero;
          input Real x_min;
          input Real x_max;
          input Real pressure = 0.0;
          input Real[:] X = fill(0, 0);
          input f_nonlinear_Data f_nonlinear_data;
          input Real x_tol = 100 * Modelica.Constants.eps;
          output Real x_zero;
        protected
          constant Real eps = Modelica.Constants.eps;
          constant Real x_eps = 0.0000000001;
          Real x_min2 = x_min - x_eps;
          Real x_max2 = x_max + x_eps;
          Real a = x_min2;
          Real b = x_max2;
          Real c;
          Real d;
          Real e;
          Real m;
          Real s;
          Real p;
          Real q;
          Real r;
          Real tol;
          Real fa;
          Real fb;
          Real fc;
          Boolean found = false;
        algorithm
          fa := f_nonlinear(x_min2, pressure, X, f_nonlinear_data) - y_zero;
          fb := f_nonlinear(x_max2, pressure, X, f_nonlinear_data) - y_zero;
          fc := fb;
          if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
            .Modelica.Utilities.Streams.error("The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n" + "do not bracket the root of the single non-linear equation:\n" + "  x_min  = " + String(x_min2) + "\n" + "  x_max  = " + String(x_max2) + "\n" + "  y_zero = " + String(y_zero) + "\n" + "  fa = f(x_min) - y_zero = " + String(fa) + "\n" + "  fb = f(x_max) - y_zero = " + String(fb) + "\n" + "fa and fb must have opposite sign which is not the case");
          else
          end if;
          c := a;
          fc := fa;
          e := b - a;
          d := e;
          while not found loop
            if abs(fc) < abs(fb) then
              a := b;
              b := c;
              c := a;
              fa := fb;
              fb := fc;
              fc := fa;
            else
            end if;
            tol := 2 * eps * abs(b) + x_tol;
            m := (c - b) / 2;
            if abs(m) <= tol or fb == 0.0 then
              found := true;
              x_zero := b;
            else
              if abs(e) < tol or abs(fa) <= abs(fb) then
                e := m;
                d := e;
              else
                s := fb / fa;
                if a == c then
                  p := 2 * m * s;
                  q := 1 - s;
                else
                  q := fa / fc;
                  r := fb / fc;
                  p := s * (2 * m * q * (q - r) - (b - a) * (r - 1));
                  q := (q - 1) * (r - 1) * (s - 1);
                end if;
                if p > 0 then
                  q := -q;
                else
                  p := -p;
                end if;
                s := e;
                e := d;
                if 2 * p < 3 * m * q - abs(tol * q) and p < abs(0.5 * s * q) then
                  d := p / q;
                else
                  e := m;
                  d := e;
                end if;
              end if;
              a := b;
              fa := fb;
              b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
              fb := f_nonlinear(b, pressure, X, f_nonlinear_data) - y_zero;
              if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
                c := a;
                fc := fa;
                e := b - a;
                d := e;
              else
              end if;
            end if;
          end while;
        end solve;
      end OneNonLinearEquation;
    end Common;

    package Air 
      extends Modelica.Icons.VariantsPackage;

      package MoistAir 
        extends .Modelica.Media.Interfaces.PartialCondensingGases(mediumName = "Moist air", substanceNames = {"water", "air"}, final reducedX = true, final singleState = false, reference_X = {0.01, 0.99}, fluidConstants = {IdealGases.Common.FluidData.H2O, IdealGases.Common.FluidData.N2}, Temperature(min = 190, max = 647));
        constant Integer Water = 1;
        constant Integer Air = 2;
        constant Real k_mair = steam.MM / dryair.MM;
        constant IdealGases.Common.DataRecord dryair = IdealGases.Common.SingleGasesData.Air;
        constant IdealGases.Common.DataRecord steam = IdealGases.Common.SingleGasesData.H2O;
        constant .Modelica.SIunits.MolarMass[2] MMX = {steam.MM, dryair.MM};

        redeclare record extends ThermodynamicState end ThermodynamicState;

        redeclare replaceable model extends BaseProperties 
          MassFraction x_water;
          Real phi;
        protected
          MassFraction X_liquid;
          MassFraction X_steam;
          MassFraction X_air;
          MassFraction X_sat;
          MassFraction x_sat;
          AbsolutePressure p_steam_sat;
        equation
          assert(T >= 190 and T <= 647, "
          Temperature T is not in the allowed range
          190.0 K <= (T =" + String(T) + " K) <= 647.0 K
          required from medium model \"" + mediumName + "\".");
          MM = 1 / (Xi[Water] / MMX[Water] + (1.0 - Xi[Water]) / MMX[Air]);
          p_steam_sat = min(saturationPressure(T), 0.999 * p);
          X_sat = min(p_steam_sat * k_mair / max(100 * .Modelica.Constants.eps, p - p_steam_sat) * (1 - Xi[Water]), 1.0);
          X_liquid = max(Xi[Water] - X_sat, 0.0);
          X_steam = Xi[Water] - X_liquid;
          X_air = 1 - Xi[Water];
          h = specificEnthalpy_pTX(p, T, Xi);
          R = dryair.R * X_air / (1 - X_liquid) + steam.R * X_steam / (1 - X_liquid);
          u = h - R * T;
          d = p / (R * T);
          state.p = p;
          state.T = T;
          state.X = X;
          x_sat = k_mair * p_steam_sat / max(100 * .Modelica.Constants.eps, p - p_steam_sat);
          x_water = Xi[Water] / max(X_air, 100 * .Modelica.Constants.eps);
          phi = p / p_steam_sat * Xi[Water] / (Xi[Water] + k_mair * X_air);
        end BaseProperties;

        redeclare function setState_pTX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T, X = X) else ThermodynamicState(p = p, T = T, X = cat(1, X, {1 - sum(X)}));
        end setState_pTX;

        redeclare function setState_phX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T_phX(p, h, X), X = X) else ThermodynamicState(p = p, T = T_phX(p, h, X), X = cat(1, X, {1 - sum(X)}));
        end setState_phX;

        redeclare function setState_dTX 
          extends Modelica.Icons.Function;
          input Density d;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = d * {steam.R, dryair.R} * X * T, T = T, X = X) else ThermodynamicState(p = d * {steam.R, dryair.R} * cat(1, X, {1 - sum(X)}) * T, T = T, X = cat(1, X, {1 - sum(X)}));
        end setState_dTX;

        redeclare function extends setSmoothState 
        algorithm
          state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small), X = Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
        end setSmoothState;

        redeclare function extends gasConstant 
        algorithm
          R := dryair.R * (1 - state.X[Water]) + steam.R * state.X[Water];
        end gasConstant;

        function saturationPressureLiquid 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          output .Modelica.SIunits.AbsolutePressure psat;
        protected
          .Modelica.SIunits.Temperature Tcritical = 647.096;
          .Modelica.SIunits.AbsolutePressure pcritical = 22064000.0;
          Real r1 = 1 - Tsat / Tcritical;
          Real[:] a = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 1.80122502};
          Real[:] n = {1.0, 1.5, 3.0, 3.5, 4.0, 7.5};
        algorithm
          psat := exp((a[1] * r1 ^ n[1] + a[2] * r1 ^ n[2] + a[3] * r1 ^ n[3] + a[4] * r1 ^ n[4] + a[5] * r1 ^ n[5] + a[6] * r1 ^ n[6]) * Tcritical / Tsat) * pcritical;
        end saturationPressureLiquid;

        function saturationPressureLiquid_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          input Real dTsat(unit = "K/s");
          output Real psat_der(unit = "Pa/s");
        protected
          .Modelica.SIunits.Temperature Tcritical = 647.096;
          .Modelica.SIunits.AbsolutePressure pcritical = 22064000.0;
          Real r1 = 1 - Tsat / Tcritical;
          Real r1_der = -1 / Tcritical * dTsat;
          Real[:] a = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 1.80122502};
          Real[:] n = {1.0, 1.5, 3.0, 3.5, 4.0, 7.5};
          Real r2 = a[1] * r1 ^ n[1] + a[2] * r1 ^ n[2] + a[3] * r1 ^ n[3] + a[4] * r1 ^ n[4] + a[5] * r1 ^ n[5] + a[6] * r1 ^ n[6];
        algorithm
          psat_der := exp(r2 * Tcritical / Tsat) * pcritical * ((a[1] * r1 ^ (n[1] - 1) * n[1] * r1_der + a[2] * r1 ^ (n[2] - 1) * n[2] * r1_der + a[3] * r1 ^ (n[3] - 1) * n[3] * r1_der + a[4] * r1 ^ (n[4] - 1) * n[4] * r1_der + a[5] * r1 ^ (n[5] - 1) * n[5] * r1_der + a[6] * r1 ^ (n[6] - 1) * n[6] * r1_der) * Tcritical / Tsat - r2 * Tcritical * dTsat / Tsat ^ 2);
        end saturationPressureLiquid_der;

        function sublimationPressureIce 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          output .Modelica.SIunits.AbsolutePressure psat;
        protected
          .Modelica.SIunits.Temperature Ttriple = 273.16;
          .Modelica.SIunits.AbsolutePressure ptriple = 611.657;
          Real r1 = Tsat / Ttriple;
          Real[:] a = {-13.928169, 34.7078238};
          Real[:] n = {-1.5, -1.25};
        algorithm
          psat := exp(a[1] - a[1] * r1 ^ n[1] + a[2] - a[2] * r1 ^ n[2]) * ptriple;
        end sublimationPressureIce;

        function sublimationPressureIce_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature Tsat;
          input Real dTsat(unit = "K/s");
          output Real psat_der(unit = "Pa/s");
        protected
          .Modelica.SIunits.Temperature Ttriple = 273.16;
          .Modelica.SIunits.AbsolutePressure ptriple = 611.657;
          Real r1 = Tsat / Ttriple;
          Real r1_der = dTsat / Ttriple;
          Real[:] a = {-13.928169, 34.7078238};
          Real[:] n = {-1.5, -1.25};
        algorithm
          psat_der := exp(a[1] - a[1] * r1 ^ n[1] + a[2] - a[2] * r1 ^ n[2]) * ptriple * (-a[1] * r1 ^ (n[1] - 1) * n[1] * r1_der - a[2] * r1 ^ (n[2] - 1) * n[2] * r1_der);
        end sublimationPressureIce_der;

        redeclare function extends saturationPressure 
        algorithm
          psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat), sublimationPressureIce(Tsat), Tsat - 273.16, 1.0);
        end saturationPressure;

        function saturationPressure_der 
          extends Modelica.Icons.Function;
          input Temperature Tsat;
          input Real dTsat(unit = "K/s");
          output Real psat_der(unit = "Pa/s");
        algorithm
          psat_der := Utilities.spliceFunction_der(saturationPressureLiquid(Tsat), sublimationPressureIce(Tsat), Tsat - 273.16, 1.0, saturationPressureLiquid_der(Tsat = Tsat, dTsat = dTsat), sublimationPressureIce_der(Tsat = Tsat, dTsat = dTsat), dTsat, 0);
        end saturationPressure_der;

        redeclare function extends enthalpyOfVaporization 
        protected
          Real Tcritical = 647.096;
          Real dcritical = 322;
          Real pcritical = 22064000.0;
          Real[:] n = {1, 1.5, 3, 3.5, 4, 7.5};
          Real[:] a = {-7.85951783, 1.84408259, -11.7866497, 22.6807411, -15.9618719, 1.80122502};
          Real[:] m = {1 / 3, 2 / 3, 5 / 3, 16 / 3, 43 / 3, 110 / 3};
          Real[:] b = {1.99274064, 1.09965342, -0.510839303, -1.75493479, -45.5170352, -674694.45};
          Real[:] o = {2 / 6, 4 / 6, 8 / 6, 18 / 6, 37 / 6, 71 / 6};
          Real[:] c = {-2.0315024, -2.6830294, -5.38626492, -17.2991605, -44.7586581, -63.9201063};
          Real tau = 1 - T / Tcritical;
          Real r1 = a[1] * Tcritical * tau ^ n[1] / T + a[2] * Tcritical * tau ^ n[2] / T + a[3] * Tcritical * tau ^ n[3] / T + a[4] * Tcritical * tau ^ n[4] / T + a[5] * Tcritical * tau ^ n[5] / T + a[6] * Tcritical * tau ^ n[6] / T;
          Real r2 = a[1] * n[1] * tau ^ n[1] + a[2] * n[2] * tau ^ n[2] + a[3] * n[3] * tau ^ n[3] + a[4] * n[4] * tau ^ n[4] + a[5] * n[5] * tau ^ n[5] + a[6] * n[6] * tau ^ n[6];
          Real dp = dcritical * (1 + b[1] * tau ^ m[1] + b[2] * tau ^ m[2] + b[3] * tau ^ m[3] + b[4] * tau ^ m[4] + b[5] * tau ^ m[5] + b[6] * tau ^ m[6]);
          Real dpp = dcritical * exp(c[1] * tau ^ o[1] + c[2] * tau ^ o[2] + c[3] * tau ^ o[3] + c[4] * tau ^ o[4] + c[5] * tau ^ o[5] + c[6] * tau ^ o[6]);
        algorithm
          r0 := -(dp - dpp) * exp(r1) * pcritical * (r2 + r1 * tau) / (dp * dpp * tau);
        end enthalpyOfVaporization;

        redeclare function extends enthalpyOfLiquid 
        algorithm
          h := (T - 273.15) * 1000.0 * (4.2166 - 0.5 * (T - 273.15) * (0.0033166 + 0.333333 * (T - 273.15) * (0.00010295 - 0.25 * (T - 273.15) * (0.0000013819 + 0.2 * (T - 273.15) * 0.0000000073221))));
        end enthalpyOfLiquid;

        redeclare function extends enthalpyOfGas 
        algorithm
          h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5) * X[Water] + Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684) * (1.0 - X[Water]);
        end enthalpyOfGas;

        redeclare function extends enthalpyOfCondensingGas 
        algorithm
          h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5);
        end enthalpyOfCondensingGas;

        redeclare function extends enthalpyOfNonCondensingGas 
        algorithm
          h := Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684);
        end enthalpyOfNonCondensingGas;

        function enthalpyOfWater 
          extends Modelica.Icons.Function;
          input SIunits.Temperature T;
          output SIunits.SpecificEnthalpy h;
        algorithm
          h := Utilities.spliceFunction(4200 * (T - 273.15), 2050 * (T - 273.15) - 333000, T - 273.16, 0.1);
        end enthalpyOfWater;

        function enthalpyOfWater_der 
          extends Modelica.Icons.Function;
          input SIunits.Temperature T;
          input Real dT(unit = "K/s");
          output Real dh(unit = "J/(kg.s)");
        algorithm
          dh := Utilities.spliceFunction_der(4200 * (T - 273.15), 2050 * (T - 273.15) - 333000, T - 273.16, 0.1, 4200 * dT, 2050 * dT, dT, 0);
        end enthalpyOfWater_der;

        redeclare function extends pressure 
        algorithm
          p := state.p;
        end pressure;

        redeclare function extends temperature 
        algorithm
          T := state.T;
        end temperature;

        function T_phX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          input MassFraction[:] X;
          output Temperature T;

        protected
          package Internal 
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data 
              extends Modelica.Media.IdealGases.Common.DataRecord;
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear 
            algorithm
              y := h_pTX(p, x, X);
            end f_nonlinear;

            redeclare function extends solve end solve;
          end Internal;
        algorithm
          T := Internal.solve(h, 190, 647, p, X[1:nXi], steam);
        end T_phX;

        redeclare function extends density 
        algorithm
          d := state.p / (gasConstant(state) * state.T);
        end density;

        redeclare function extends specificEnthalpy 
        algorithm
          h := h_pTX(state.p, state.T, state.X);
        end specificEnthalpy;

        function h_pTX 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          output .Modelica.SIunits.SpecificEnthalpy h;
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction X_sat;
          .Modelica.SIunits.MassFraction X_liquid;
          .Modelica.SIunits.MassFraction X_steam;
          .Modelica.SIunits.MassFraction X_air;
        algorithm
          p_steam_sat := saturationPressure(T);
          X_sat := min(p_steam_sat * k_mair / max(100 * .Modelica.Constants.eps, p - p_steam_sat) * (1 - X[Water]), 1.0);
          X_liquid := max(X[Water] - X_sat, 0.0);
          X_steam := X[Water] - X_liquid;
          X_air := 1 - X[Water];
          h := {Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5), Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684)} * {X_steam, X_air} + enthalpyOfWater(T) * X_liquid;
        end h_pTX;

        function h_pTX_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          input Real dp(unit = "Pa/s");
          input Real dT(unit = "K/s");
          input Real[:] dX(each unit = "1/s");
          output Real h_der(unit = "J/(kg.s)");
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction X_sat;
          .Modelica.SIunits.MassFraction X_liquid;
          .Modelica.SIunits.MassFraction X_steam;
          .Modelica.SIunits.MassFraction X_air;
          .Modelica.SIunits.MassFraction x_sat;
          Real dX_steam(unit = "1/s");
          Real dX_air(unit = "1/s");
          Real dX_liq(unit = "1/s");
          Real dps(unit = "Pa/s");
          Real dx_sat(unit = "1/s");
        algorithm
          p_steam_sat := saturationPressure(T);
          x_sat := p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - p_steam_sat);
          X_sat := min(x_sat * (1 - X[Water]), 1.0);
          X_liquid := Utilities.smoothMax(X[Water] - X_sat, 0.0, 0.00001);
          X_steam := X[Water] - X_liquid;
          X_air := 1 - X[Water];
          dX_air := -dX[Water];
          dps := saturationPressure_der(Tsat = T, dTsat = dT);
          dx_sat := k_mair * (dps * (p - p_steam_sat) - p_steam_sat * (dp - dps)) / (p - p_steam_sat) / (p - p_steam_sat);
          dX_liq := Utilities.smoothMax_der(X[Water] - X_sat, 0.0, 0.00001, (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 0, 0);
          dX_steam := dX[Water] - dX_liq;
          h_der := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5, dT = dT) + dX_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5) + X_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684, dT = dT) + dX_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684) + X_liquid * enthalpyOfWater_der(T = T, dT = dT) + dX_liq * enthalpyOfWater(T);
        end h_pTX_der;

        redeclare function extends isentropicExponent 
        algorithm
          gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
        end isentropicExponent;

        redeclare function extends specificInternalEnergy 
          extends Modelica.Icons.Function;
          output .Modelica.SIunits.SpecificInternalEnergy u;
        algorithm
          u := specificInternalEnergy_pTX(state.p, state.T, state.X);
        end specificInternalEnergy;

        function specificInternalEnergy_pTX 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          output .Modelica.SIunits.SpecificInternalEnergy u;
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction X_liquid;
          .Modelica.SIunits.MassFraction X_steam;
          .Modelica.SIunits.MassFraction X_air;
          .Modelica.SIunits.MassFraction X_sat;
          Real R_gas;
        algorithm
          p_steam_sat := saturationPressure(T);
          X_sat := min(p_steam_sat * k_mair / max(100 * .Modelica.Constants.eps, p - p_steam_sat) * (1 - X[Water]), 1.0);
          X_liquid := max(X[Water] - X_sat, 0.0);
          X_steam := X[Water] - X_liquid;
          X_air := 1 - X[Water];
          R_gas := dryair.R * X_air / (1 - X_liquid) + steam.R * X_steam / (1 - X_liquid);
          u := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5) + X_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684) + enthalpyOfWater(T) * X_liquid - R_gas * T;
        end specificInternalEnergy_pTX;

        function specificInternalEnergy_pTX_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          input Real dp(unit = "Pa/s");
          input Real dT(unit = "K/s");
          input Real[:] dX(each unit = "1/s");
          output Real u_der(unit = "J/(kg.s)");
        protected
          .Modelica.SIunits.AbsolutePressure p_steam_sat;
          .Modelica.SIunits.MassFraction X_liquid;
          .Modelica.SIunits.MassFraction X_steam;
          .Modelica.SIunits.MassFraction X_air;
          .Modelica.SIunits.MassFraction X_sat;
          .Modelica.SIunits.SpecificHeatCapacity R_gas;
          .Modelica.SIunits.MassFraction x_sat;
          Real dX_steam(unit = "1/s");
          Real dX_air(unit = "1/s");
          Real dX_liq(unit = "1/s");
          Real dps(unit = "Pa/s");
          Real dx_sat(unit = "1/s");
          Real dR_gas(unit = "J/(kg.K.s)");
        algorithm
          p_steam_sat := saturationPressure(T);
          x_sat := p_steam_sat * k_mair / max(100 * Modelica.Constants.eps, p - p_steam_sat);
          X_sat := min(x_sat * (1 - X[Water]), 1.0);
          X_liquid := Utilities.spliceFunction(X[Water] - X_sat, 0.0, X[Water] - X_sat, 0.000001);
          X_steam := X[Water] - X_liquid;
          X_air := 1 - X[Water];
          R_gas := steam.R * X_steam / (1 - X_liquid) + dryair.R * X_air / (1 - X_liquid);
          dX_air := -dX[Water];
          dps := saturationPressure_der(Tsat = T, dTsat = dT);
          dx_sat := k_mair * (dps * (p - p_steam_sat) - p_steam_sat * (dp - dps)) / (p - p_steam_sat) / (p - p_steam_sat);
          dX_liq := Utilities.spliceFunction_der(X[Water] - X_sat, 0.0, X[Water] - X_sat, 0.000001, (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 0.0, (1 + x_sat) * dX[Water] - (1 - X[Water]) * dx_sat, 0.0);
          dX_steam := dX[Water] - dX_liq;
          dR_gas := (steam.R * (dX_steam * (1 - X_liquid) + dX_liq * X_steam) + dryair.R * (dX_air * (1 - X_liquid) + dX_liq * X_air)) / (1 - X_liquid) / (1 - X_liquid);
          u_der := X_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5, dT = dT) + dX_steam * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = steam, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 46479.819 + 2501014.5) + X_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow_der(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684, dT = dT) + dX_air * Modelica.Media.IdealGases.Common.Functions.h_Tlow(data = dryair, T = T, refChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined, h_off = 25104.684) + X_liquid * enthalpyOfWater_der(T = T, dT = dT) + dX_liq * enthalpyOfWater(T) - dR_gas * T - R_gas * dT;
        end specificInternalEnergy_pTX_der;

        redeclare function extends specificEntropy 
        algorithm
          s := s_pTX(state.p, state.T, state.X);
        end specificEntropy;

        redeclare function extends specificGibbsEnergy 
          extends Modelica.Icons.Function;
        algorithm
          g := h_pTX(state.p, state.T, state.X) - state.T * specificEntropy(state);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy 
          extends Modelica.Icons.Function;
        algorithm
          f := h_pTX(state.p, state.T, state.X) - gasConstant(state) * state.T - state.T * specificEntropy(state);
        end specificHelmholtzEnergy;

        redeclare function extends specificHeatCapacityCp 
        protected
          Real dT(unit = "s/K") = 1.0;
        algorithm
          cp := h_pTX_der(state.p, state.T, state.X, 0.0, 1.0, zeros(size(state.X, 1))) * dT;
        end specificHeatCapacityCp;

        redeclare function extends specificHeatCapacityCv 
        algorithm
          cv := Modelica.Media.IdealGases.Common.Functions.cp_Tlow(dryair, state.T) * (1 - state.X[Water]) + Modelica.Media.IdealGases.Common.Functions.cp_Tlow(steam, state.T) * state.X[Water] - gasConstant(state);
        end specificHeatCapacityCv;

        redeclare function extends dynamicViscosity 
        algorithm
          eta := 0.000001 * .Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluateWithRange({0.000000000000009739110288630587, -0.000000000031353724870333906, 0.000000043004876595642225, -0.00003822801629175824, 0.05042787436718076, 17.23926013924253}, .Modelica.SIunits.Conversions.to_degC(123.15), .Modelica.SIunits.Conversions.to_degC(1273.15), .Modelica.SIunits.Conversions.to_degC(state.T));
        end dynamicViscosity;

        redeclare function extends thermalConductivity 
        algorithm
          lambda := 0.001 * .Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluateWithRange({0.000000000000006569147081771781, -0.00000000003402596192305051, 0.00000005327928484630316, -0.00004534083928921947, 0.07612967530903766, 24.16948108809705}, .Modelica.SIunits.Conversions.to_degC(123.15), .Modelica.SIunits.Conversions.to_degC(1273.15), .Modelica.SIunits.Conversions.to_degC(state.T));
        end thermalConductivity;

        package Utilities 
          extends Modelica.Icons.UtilitiesPackage;

          function spliceFunction 
            extends Modelica.Icons.Function;
            input Real pos;
            input Real neg;
            input Real x;
            input Real deltax = 1;
            output Real out;
          protected
            Real scaledX;
            Real scaledX1;
            Real y;
          algorithm
            scaledX1 := x / deltax;
            scaledX := scaledX1 * Modelica.Math.asin(1);
            if scaledX1 <= -0.999999999 then
              y := 0;
            elseif scaledX1 >= 0.999999999 then
              y := 1;
            else
              y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1) / 2;
            end if;
            out := pos * y + (1 - y) * neg;
          end spliceFunction;

          function spliceFunction_der 
            extends Modelica.Icons.Function;
            input Real pos;
            input Real neg;
            input Real x;
            input Real deltax = 1;
            input Real dpos;
            input Real dneg;
            input Real dx;
            input Real ddeltax = 0;
            output Real out;
          protected
            Real scaledX;
            Real scaledX1;
            Real dscaledX1;
            Real y;
          algorithm
            scaledX1 := x / deltax;
            scaledX := scaledX1 * Modelica.Math.asin(1);
            dscaledX1 := (dx - scaledX1 * ddeltax) / deltax;
            if scaledX1 <= -0.99999999999 then
              y := 0;
            elseif scaledX1 >= 0.9999999999 then
              y := 1;
            else
              y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1) / 2;
            end if;
            out := dpos * y + (1 - y) * dneg;
            if abs(scaledX1) < 1 then
              out := out + (pos - neg) * dscaledX1 * Modelica.Math.asin(1) / 2 / (Modelica.Math.cosh(Modelica.Math.tan(scaledX)) * Modelica.Math.cos(scaledX)) ^ 2;
            else
            end if;
          end spliceFunction_der;

          function smoothMax 
            extends Modelica.Icons.Function;
            input Real x1;
            input Real x2;
            input Real dx;
            output Real y;
          algorithm
            y := max(x1, x2) + .Modelica.Math.log(exp(4 / dx * (x1 - max(x1, x2))) + exp(4 / dx * (x2 - max(x1, x2)))) / 4 / dx;
          end smoothMax;

          function smoothMax_der 
            extends Modelica.Icons.Function;
            input Real x1;
            input Real x2;
            input Real dx;
            input Real dx1;
            input Real dx2;
            input Real ddx;
            output Real dy;
          algorithm
            dy := (if x1 > x2 then dx1 else dx2) + 0.25 * (((4 * (dx1 - (if x1 > x2 then dx1 else dx2)) / dx - 4 * (x1 - max(x1, x2)) * ddx / dx ^ 2) * .Modelica.Math.exp(4 * (x1 - max(x1, x2)) / dx) + (4 * (dx2 - (if x1 > x2 then dx1 else dx2)) / dx - 4 * (x2 - max(x1, x2)) * ddx / dx ^ 2) * .Modelica.Math.exp(4 * (x2 - max(x1, x2)) / dx)) * dx / (.Modelica.Math.exp(4 * (x1 - max(x1, x2)) / dx) + .Modelica.Math.exp(4 * (x2 - max(x1, x2)) / dx)) + .Modelica.Math.log(.Modelica.Math.exp(4 * (x1 - max(x1, x2)) / dx) + .Modelica.Math.exp(4 * (x2 - max(x1, x2)) / dx)) * ddx);
          end smoothMax_der;
        end Utilities;

        redeclare function extends velocityOfSound 
        algorithm
          a := sqrt(isentropicExponent(state) * gasConstant(state) * temperature(state));
        end velocityOfSound;

        redeclare function extends isobaricExpansionCoefficient 
        algorithm
          beta := 1 / temperature(state);
        end isobaricExpansionCoefficient;

        redeclare function extends isothermalCompressibility 
        algorithm
          kappa := 1 / pressure(state);
        end isothermalCompressibility;

        redeclare function extends density_derp_h 
        algorithm
          ddph := 1 / (gasConstant(state) * temperature(state));
        end density_derp_h;

        redeclare function extends density_derh_p 
        algorithm
          ddhp := -density(state) / (specificHeatCapacityCp(state) * temperature(state));
        end density_derh_p;

        redeclare function extends density_derp_T 
        algorithm
          ddpT := 1 / (gasConstant(state) * temperature(state));
        end density_derp_T;

        redeclare function extends density_derT_p 
        algorithm
          ddTp := -density(state) / temperature(state);
        end density_derT_p;

        redeclare function extends density_derX 
        algorithm
          dddX[Water] := pressure(state) * (steam.R - dryair.R) / ((steam.R - dryair.R) * state.X[Water] * temperature(state) + dryair.R * temperature(state)) ^ 2;
          dddX[Air] := pressure(state) * (dryair.R - steam.R) / ((dryair.R - steam.R) * state.X[Air] * temperature(state) + steam.R * temperature(state)) ^ 2;
        end density_derX;

        redeclare function extends molarMass 
        algorithm
          MM := Modelica.Media.Air.MoistAir.gasConstant(state) / Modelica.Constants.R;
        end molarMass;

        function T_psX 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEntropy s;
          input MassFraction[:] X;
          output Temperature T;

        protected
          package Internal 
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data 
              extends Modelica.Media.IdealGases.Common.DataRecord;
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear 
            algorithm
              y := s_pTX(p, x, X);
            end f_nonlinear;

            redeclare function extends solve end solve;
          end Internal;
        algorithm
          T := Internal.solve(s, 190, 647, p, X[1:nX], steam);
        end T_psX;

        redeclare function extends setState_psX 
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T_psX(p, s, X), X = X) else ThermodynamicState(p = p, T = T_psX(p, s, X), X = cat(1, X, {1 - sum(X)}));
        end setState_psX;

        function s_pTX 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          output .Modelica.SIunits.SpecificEntropy s;
        protected
          MoleFraction[2] Y = massToMoleFractions(X, {steam.MM, dryair.MM});
        algorithm
          s := Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T) * (1 - X[Water]) + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T) * X[Water] - Modelica.Constants.R * (Utilities.smoothMax(X[Water] / MMX[Water] * Modelica.Math.log(max(Y[Water], Modelica.Constants.eps) * p / reference_p), 0.0, 0.000000001) - Utilities.smoothMax((1 - X[Water]) / MMX[Air] * Modelica.Math.log(max(Y[Air], Modelica.Constants.eps) * p / reference_p), 0.0, 0.000000001));
        end s_pTX;

        function s_pTX_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input .Modelica.SIunits.MassFraction[:] X;
          input Real dp(unit = "Pa/s");
          input Real dT(unit = "K/s");
          input Real[nX] dX(unit = "1/s");
          output Real ds(unit = "J/(kg.K.s)");
        protected
          MoleFraction[2] Y = massToMoleFractions(X, {steam.MM, dryair.MM});
        algorithm
          ds := Modelica.Media.IdealGases.Common.Functions.s0_Tlow_der(dryair, T, dT) * (1 - X[Water]) + Modelica.Media.IdealGases.Common.Functions.s0_Tlow_der(steam, T, dT) * X[Water] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(dryair, T) * dX[Air] + Modelica.Media.IdealGases.Common.Functions.s0_Tlow(steam, T) * dX[Water] - Modelica.Constants.R * (1 / MMX[Water] * Utilities.smoothMax_der(X[Water] * Modelica.Math.log(max(Y[Water], Modelica.Constants.eps) * p / reference_p), 0.0, 0.000000001, (Modelica.Math.log(max(Y[Water], Modelica.Constants.eps) * p / reference_p) + X[Water] / Y[Water] * X[Air] * MMX[Water] / (X[Air] * MMX[Water] + X[Water] * MMX[Air]) ^ 2) * dX[Water] + X[Water] * reference_p / p * dp, 0, 0) - 1 / MMX[Air] * Utilities.smoothMax_der((1 - X[Water]) * Modelica.Math.log(max(Y[Air], Modelica.Constants.eps) * p / reference_p), 0.0, 0.000000001, (Modelica.Math.log(max(Y[Air], Modelica.Constants.eps) * p / reference_p) + X[Air] / Y[Air] * X[Water] * MMX[Air] / (X[Air] * MMX[Water] + X[Water] * MMX[Air]) ^ 2) * dX[Air] + X[Air] * reference_p / p * dp, 0, 0));
        end s_pTX_der;

        redeclare function extends isentropicEnthalpy 
          extends Modelica.Icons.Function;
        algorithm
          h_is := Modelica.Media.Air.MoistAir.h_pTX(p_downstream, Modelica.Media.Air.MoistAir.T_psX(p_downstream, Modelica.Media.Air.MoistAir.specificEntropy(refState), refState.X), refState.X);
        end isentropicEnthalpy;
      end MoistAir;
    end Air;

    package IdealGases 
      extends Modelica.Icons.VariantsPackage;

      package Common 
        extends Modelica.Icons.Package;

        record DataRecord 
          extends Modelica.Icons.Record;
          String name;
          .Modelica.SIunits.MolarMass MM;
          .Modelica.SIunits.SpecificEnthalpy Hf;
          .Modelica.SIunits.SpecificEnthalpy H0;
          .Modelica.SIunits.Temperature Tlimit;
          Real[7] alow;
          Real[2] blow;
          Real[7] ahigh;
          Real[2] bhigh;
          .Modelica.SIunits.SpecificHeatCapacity R;
        end DataRecord;

        package Functions 
          extends Modelica.Icons.Package;
          constant Boolean excludeEnthalpyOfFormation = true;
          constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice = Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K;
          constant Modelica.Media.Interfaces.Types.SpecificEnthalpy h_offset = 0.0;

          function cp_Tlow 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            output .Modelica.SIunits.SpecificHeatCapacity cp;
          algorithm
            cp := data.R * 1 / (T * T) * (data.alow[1] + T * (data.alow[2] + T * (1.0 * data.alow[3] + T * (data.alow[4] + T * (data.alow[5] + T * (data.alow[6] + data.alow[7] * T))))));
          end cp_Tlow;

          function cp_Tlow_der 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            input Real dT;
            output Real cp_der;
          algorithm
            cp_der := dT * data.R / (T * T * T) * (-2 * data.alow[1] + T * (-data.alow[2] + T * T * (data.alow[4] + T * (2.0 * data.alow[5] + T * (3.0 * data.alow[6] + 4.0 * data.alow[7] * T)))));
          end cp_Tlow_der;

          function h_Tlow 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            input Boolean exclEnthForm = excludeEnthalpyOfFormation;
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice = referenceChoice;
            input .Modelica.SIunits.SpecificEnthalpy h_off = h_offset;
            output .Modelica.SIunits.SpecificEnthalpy h;
          algorithm
            h := data.R * (-data.alow[1] + T * (data.blow[1] + data.alow[2] * Math.log(T) + T * (1.0 * data.alow[3] + T * (0.5 * data.alow[4] + T * (1 / 3 * data.alow[5] + T * (0.25 * data.alow[6] + 0.2 * data.alow[7] * T)))))) / T + (if exclEnthForm then -data.Hf else 0.0) + (if refChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K then data.H0 else 0.0) + (if refChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined then h_off else 0.0);
          end h_Tlow;

          function h_Tlow_der 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            input Boolean exclEnthForm = excludeEnthalpyOfFormation;
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice = referenceChoice;
            input .Modelica.SIunits.SpecificEnthalpy h_off = h_offset;
            input Real dT(unit = "K/s");
            output Real h_der(unit = "J/(kg.s)");
          algorithm
            h_der := dT * Modelica.Media.IdealGases.Common.Functions.cp_Tlow(data, T);
          end h_Tlow_der;

          function s0_Tlow 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            output .Modelica.SIunits.SpecificEntropy s;
          algorithm
            s := data.R * (data.blow[2] - 0.5 * data.alow[1] / (T * T) - data.alow[2] / T + data.alow[3] * Math.log(T) + T * (data.alow[4] + T * (0.5 * data.alow[5] + T * (1 / 3 * data.alow[6] + 0.25 * data.alow[7] * T))));
          end s0_Tlow;

          function s0_Tlow_der 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data;
            input .Modelica.SIunits.Temperature T;
            input Real T_der;
            output .Modelica.SIunits.SpecificEntropy s;
          algorithm
            s := data.R * (data.blow[2] - 0.5 * data.alow[1] / (T * T) - data.alow[2] / T + data.alow[3] * Math.log(T) + T * (data.alow[4] + T * (0.5 * data.alow[5] + T * (1 / 3 * data.alow[6] + 0.25 * data.alow[7] * T))));
          end s0_Tlow_der;
        end Functions;

        package FluidData 
          extends Modelica.Icons.Package;
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants N2(chemicalFormula = "N2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7727-37-9", meltingPoint = 63.15, normalBoilingPoint = 77.35, criticalTemperature = 126.2, criticalPressure = 3398000.0, criticalMolarVolume = 0.0000901, acentricFactor = 0.037, dipoleMoment = 0.0, molarMass = SingleGasesData.N2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2O(chemicalFormula = "H2O", iupacName = "oxidane", structureFormula = "H2O", casRegistryNumber = "7732-18-5", meltingPoint = 273.15, normalBoilingPoint = 373.124, criticalTemperature = 647.096, criticalPressure = 22064000.0, criticalMolarVolume = 0.00005595, acentricFactor = 0.344, dipoleMoment = 1.8, molarMass = SingleGasesData.H2O.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        end FluidData;

        package SingleGasesData 
          extends Modelica.Icons.Package;
          constant IdealGases.Common.DataRecord Air(name = "Air", MM = 0.0289651159, Hf = -4333.833858403446, H0 = 298609.6803431054, Tlimit = 1000, alow = {10099.5016, -196.827561, 5.00915511, -0.00576101373, 0.0000106685993, -0.00000000794029797, 0.00000000000218523191}, blow = {-176.796731, -3.921504225}, ahigh = {241521.443, -1257.8746, 5.14455867, -0.000213854179, 0.0000000706522784, -0.0000000000107148349, 0.000000000000000657780015}, bhigh = {6462.26319, -8.147411905}, R = 287.0512249529787);
          constant IdealGases.Common.DataRecord Ar(name = "Ar", MM = 0.039948, Hf = 0, H0 = 155137.3785921698, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 4.37967491}, ahigh = {20.10538475, -0.05992661069999999, 2.500069401, -0.0000000399214116, 0.0000000000120527214, -0.000000000000001819015576, 0.0000000000000000001078576636}, bhigh = {-744.993961, 4.37918011}, R = 208.1323720837088);
          constant IdealGases.Common.DataRecord CH4(name = "CH4", MM = 0.01604246, Hf = -4650159.63885838, H0 = 624355.7409524474, Tlimit = 1000, alow = {-176685.0998, 2786.18102, -12.0257785, 0.0391761929, -0.0000361905443, 0.00000002026853043, -0.000000000004976705489999999}, blow = {-23313.1436, 89.0432275}, ahigh = {3730042.76, -13835.01485, 20.49107091, -0.001961974759, 0.000000472731304, -0.0000000000372881469, 0.000000000000001623737207}, bhigh = {75320.6691, -121.9124889}, R = 518.2791167938085);
          constant IdealGases.Common.DataRecord CH3OH(name = "CH3OH", MM = 0.03204186, Hf = -6271171.523750494, H0 = 356885.5553329301, Tlimit = 1000, alow = {-241664.2886, 4032.14719, -20.46415436, 0.0690369807, -0.0000759893269, 0.0000000459820836, -0.00000000001158706744}, blow = {-44332.61169999999, 140.014219}, ahigh = {3411570.76, -13455.00201, 22.61407623, -0.002141029179, 0.000000373005054, -0.0000000000349884639, 0.000000000000001366073444}, bhigh = {56360.8156, -127.7814279}, R = 259.4878075117987);
          constant IdealGases.Common.DataRecord CO(name = "CO", MM = 0.0280101, Hf = -3946262.098314536, H0 = 309570.6191695138, Tlimit = 1000, alow = {14890.45326, -292.2285939, 5.72452717, -0.008176235030000001, 0.00001456903469, -0.00000001087746302, 0.000000000003027941827}, blow = {-13031.31878, -7.85924135}, ahigh = {461919.725, -1944.704863, 5.91671418, -0.0005664282830000001, 0.000000139881454, -0.00000000001787680361, 0.000000000000000962093557}, bhigh = {-2466.261084, -13.87413108}, R = 296.8383547363272);
          constant IdealGases.Common.DataRecord CO2(name = "CO2", MM = 0.0440095, Hf = -8941478.544405185, H0 = 212805.6215135368, Tlimit = 1000, alow = {49436.5054, -626.411601, 5.30172524, 0.002503813816, -0.0000002127308728, -0.000000000768998878, 0.0000000000002849677801}, blow = {-45281.9846, -7.04827944}, ahigh = {117696.2419, -1788.791477, 8.29152319, -0.0000922315678, 0.00000000486367688, -0.000000000001891053312, 0.0000000000000006330036589999999}, bhigh = {-39083.5059, -26.52669281}, R = 188.9244822140674);
          constant IdealGases.Common.DataRecord C2H2_vinylidene(name = "C2H2_vinylidene", MM = 0.02603728, Hf = 15930556.80163212, H0 = 417638.4015534649, Tlimit = 1000, alow = {-14660.42239, 278.9475593, 1.276229776, 0.01395015463, -0.00001475702649, 0.00000000947629811, -0.000000000002567602217}, blow = {47361.1018, 16.58225704}, ahigh = {1940838.725, -6892.718150000001, 13.39582494, -0.0009368968669999999, 0.0000001470804368, -0.00000000001220040365, 0.000000000000000412239166}, bhigh = {91071.1293, -63.3750293}, R = 319.3295152181795);
          constant IdealGases.Common.DataRecord C2H4(name = "C2H4", MM = 0.02805316, Hf = 1871446.924339362, H0 = 374955.5843263291, Tlimit = 1000, alow = {-116360.5836, 2554.85151, -16.09746428, 0.0662577932, -0.00007885081859999999, 0.0000000512522482, -0.00000000001370340031}, blow = {-6176.19107, 109.3338343}, ahigh = {3408763.67, -13748.47903, 23.65898074, -0.002423804419, 0.000000443139566, -0.0000000000435268339, 0.000000000000001775410633}, bhigh = {88204.2938, -137.1278108}, R = 296.3827247982046);
          constant IdealGases.Common.DataRecord C2H6(name = "C2H6", MM = 0.03006904, Hf = -2788633.890539904, H0 = 395476.3437741943, Tlimit = 1000, alow = {-186204.4161, 3406.19186, -19.51705092, 0.0756583559, -0.0000820417322, 0.000000050611358, -0.00000000001319281992}, blow = {-27029.3289, 129.8140496}, ahigh = {5025782.13, -20330.22397, 33.2255293, -0.00383670341, 0.000000723840586, -0.000000000073191825, 0.000000000000003065468699}, bhigh = {111596.395, -203.9410584}, R = 276.5127187299628);
          constant IdealGases.Common.DataRecord C2H5OH(name = "C2H5OH", MM = 0.04606844, Hf = -5100020.751733725, H0 = 315659.1801241805, Tlimit = 1000, alow = {-234279.1392, 4479.18055, -27.44817302, 0.1088679162, -0.0001305309334, 0.00000008437346399999999, -0.00000000002234559017}, blow = {-50222.29, 176.4829211}, ahigh = {4694817.65, -19297.98213, 34.4758404, -0.00323616598, 0.000000578494772, -0.0000000000556460027, 0.0000000000000022262264}, bhigh = {86016.22709999999, -203.4801732}, R = 180.4808671619877);
          constant IdealGases.Common.DataRecord C3H6_propylene(name = "C3H6_propylene", MM = 0.04207974, Hf = 475288.1077687267, H0 = 322020.9535515191, Tlimit = 1000, alow = {-191246.2174, 3542.07424, -21.14878626, 0.0890148479, -0.0001001429154, 0.00000006267959389999999, -0.00000000001637870781}, blow = {-15299.61824, 140.7641382}, ahigh = {5017620.34, -20860.84035, 36.4415634, -0.00388119117, 0.000000727867719, -0.00000000007321204500000001, 0.000000000000003052176369}, bhigh = {126124.5355, -219.5715757}, R = 197.588483198803);
          constant IdealGases.Common.DataRecord C3H8(name = "C3H8", MM = 0.04409562, Hf = -2373931.923397381, H0 = 334301.1845620949, Tlimit = 1000, alow = {-243314.4337, 4656.27081, -29.39466091, 0.1188952745, -0.0001376308269, 0.00000008814823909999999, -0.00000000002342987994}, blow = {-35403.3527, 184.1749277}, ahigh = {6420731.680000001, -26597.91134, 45.3435684, -0.00502066392, 0.0000009471216939999999, -0.0000000000957540523, 0.00000000000000400967288}, bhigh = {145558.2459, -281.8374734}, R = 188.5555073270316);
          constant IdealGases.Common.DataRecord C4H8_1_butene(name = "C4H8_1_butene", MM = 0.05610631999999999, Hf = -9624.584182316717, H0 = 305134.9651875226, Tlimit = 1000, alow = {-272149.2014, 5100.079250000001, -31.8378625, 0.1317754442, -0.0001527359339, 0.00000009714761109999999, -0.0000000000256020447}, blow = {-25230.96386, 200.6932108}, ahigh = {6257948.609999999, -26603.76305, 47.6492005, -0.00438326711, 0.000000712883844, -0.0000000000599102084, 0.000000000000002051753504}, bhigh = {156925.2657, -291.3869761}, R = 148.1913623991023);
          constant IdealGases.Common.DataRecord C4H10_n_butane(name = "C4H10_n_butane", MM = 0.0581222, Hf = -2164233.28779709, H0 = 330832.0228759407, Tlimit = 1000, alow = {-317587.254, 6176.331819999999, -38.9156212, 0.1584654284, -0.0001860050159, 0.0000001199676349, -0.0000000000320167055}, blow = {-45403.63390000001, 237.9488665}, ahigh = {7682322.45, -32560.5151, 57.3673275, -0.00619791681, 0.000001180186048, -0.0000000001221893698, 0.000000000000005250635250000001}, bhigh = {177452.656, -358.791876}, R = 143.0515706563069);
          constant IdealGases.Common.DataRecord C5H10_1_pentene(name = "C5H10_1_pentene", MM = 0.07013290000000001, Hf = -303423.9279995551, H0 = 309127.3852927798, Tlimit = 1000, alow = {-534054.813, 9298.91738, -56.6779245, 0.2123100266, -0.000257129829, 0.0000001666834304, -0.0000000000443408047}, blow = {-47906.8218, 339.60364}, ahigh = {3744014.97, -21044.85321, 47.3612699, -0.00042442012, -0.0000000389897505, 0.00000000001367074243, -0.000000000000000931319423}, bhigh = {115409.1373, -278.6177449000001}, R = 118.5530899192818);
          constant IdealGases.Common.DataRecord C5H12_n_pentane(name = "C5H12_n_pentane", MM = 0.07214878, Hf = -2034130.029641527, H0 = 335196.2430965569, Tlimit = 1000, alow = {-276889.4625, 5834.28347, -36.1754148, 0.1533339707, -0.0001528395882, 0.00000008191092, -0.00000000001792327902}, blow = {-46653.7525, 226.5544053}, ahigh = {-2530779.286, -8972.59326, 45.3622326, -0.002626989916, 0.000003135136419, -0.000000000531872894, 0.00000000000002886896868}, bhigh = {14846.16529, -251.6550384}, R = 115.2406457877736);
          constant IdealGases.Common.DataRecord C6H6(name = "C6H6", MM = 0.07811184, Hf = 1061042.730525872, H0 = 181735.4577743912, Tlimit = 1000, alow = {-167734.0902, 4404.50004, -37.1737791, 0.1640509559, -0.0002020812374, 0.0000001307915264, -0.000000000034442841}, blow = {-10354.55401, 216.9853345}, ahigh = {4538575.72, -22605.02547, 46.940073, -0.004206676830000001, 0.000000790799433, -0.000000000079683021, 0.00000000000000332821208}, bhigh = {139146.4686, -286.8751333}, R = 106.4431717393932);
          constant IdealGases.Common.DataRecord C6H12_1_hexene(name = "C6H12_1_hexene", MM = 0.08415948000000001, Hf = -498458.4030224521, H0 = 311788.9986962847, Tlimit = 1000, alow = {-666883.165, 11768.64939, -72.7099833, 0.2709398396, -0.00033332464, 0.0000002182347097, -0.0000000000585946882}, blow = {-62157.8054, 428.682564}, ahigh = {733290.696, -14488.48641, 46.7121549, 0.00317297847, -0.000000524264652, 0.0000000000428035582, -0.000000000000001472353254}, bhigh = {66977.4041, -262.3643854}, R = 98.79424159940152);
          constant IdealGases.Common.DataRecord C6H14_n_hexane(name = "C6H14_n_hexane", MM = 0.08617535999999999, Hf = -1936980.593988816, H0 = 333065.0431863586, Tlimit = 1000, alow = {-581592.67, 10790.97724, -66.3394703, 0.2523715155, -0.0002904344705, 0.0000001802201514, -0.00000000004617223680000001}, blow = {-72715.4457, 393.828354}, ahigh = {-3106625.684, -7346.087920000001, 46.94131760000001, 0.001693963977, 0.000002068996667, -0.000000000421214168, 0.00000000000002452345845}, bhigh = {523.750312, -254.9967718}, R = 96.48317105956971);
          constant IdealGases.Common.DataRecord C7H14_1_heptene(name = "C7H14_1_heptene", MM = 0.09818605999999999, Hf = -639194.6066478277, H0 = 313588.3036756949, Tlimit = 1000, alow = {-744940.284, 13321.79893, -82.81694379999999, 0.3108065994, -0.000378677992, 0.0000002446841042, -0.00000000006488763869999999}, blow = {-72178.8501, 485.667149}, ahigh = {-1927608.174, -9125.024420000002, 47.4817797, 0.00606766053, -0.000000868485908, 0.0000000000581399526, -0.000000000000001473979569}, bhigh = {26009.14656, -256.2880707}, R = 84.68077851377274);
          constant IdealGases.Common.DataRecord C7H16_n_heptane(name = "C7H16_n_heptane", MM = 0.10020194, Hf = -1874015.612871368, H0 = 331540.487140269, Tlimit = 1000, alow = {-612743.289, 11840.85437, -74.87188599999999, 0.2918466052, -0.000341679549, 0.0000002159285269, -0.0000000000565585273}, blow = {-80134.0894, 440.721332}, ahigh = {9135632.469999999, -39233.1969, 78.8978085, -0.00465425193, 0.000002071774142, -0.00000000034425393, 0.00000000000001976834775}, bhigh = {205070.8295, -485.110402}, R = 82.97715593131232);
          constant IdealGases.Common.DataRecord C8H10_ethylbenz(name = "C8H10_ethylbenz", MM = 0.106165, Hf = 281825.4603682946, H0 = 209862.0072528611, Tlimit = 1000, alow = {-469494, 9307.16836, -65.2176947, 0.2612080237, -0.000318175348, 0.0000002051355473, -0.0000000000540181735}, blow = {-40738.7021, 378.090436}, ahigh = {5551564.100000001, -28313.80598, 60.6124072, 0.001042112857, -0.000001327426719, 0.0000000002166031743, -0.00000000000001142545514}, bhigh = {164224.1062, -369.176982}, R = 78.31650732350586);
          constant IdealGases.Common.DataRecord C8H18_n_octane(name = "C8H18_n_octane", MM = 0.11422852, Hf = -1827477.060895125, H0 = 330740.51909278, Tlimit = 1000, alow = {-698664.715, 13385.01096, -84.1516592, 0.327193666, -0.000377720959, 0.0000002339836988, -0.0000000000601089265}, blow = {-90262.2325, 493.922214}, ahigh = {6365406.949999999, -31053.64657, 69.6916234, 0.01048059637, -0.00000412962195, 0.0000000005543226319999999, -0.00000000000002651436499}, bhigh = {150096.8785, -416.989565}, R = 72.78805678301707);
          constant IdealGases.Common.DataRecord CL2(name = "CL2", MM = 0.07090600000000001, Hf = 0, H0 = 129482.8364313316, Tlimit = 1000, alow = {34628.1517, -554.712652, 6.20758937, -0.002989632078, 0.00000317302729, -0.000000001793629562, 0.0000000000004260043590000001}, blow = {1534.069331, -9.438331107}, ahigh = {6092569.42, -19496.27662, 28.54535795, -0.01449968764, 0.00000446389077, -0.000000000635852586, 0.0000000000000332736029}, bhigh = {121211.7724, -169.0778824}, R = 117.2604857134798);
          constant IdealGases.Common.DataRecord F2(name = "F2", MM = 0.0379968064, Hf = 0, H0 = 232259.1511269747, Tlimit = 1000, alow = {10181.76308, 22.74241183, 1.97135304, 0.00815160401, -0.0000114896009, 0.00000000795865253, -0.000000000002167079526}, blow = {-958.6943, 11.30600296}, ahigh = {-2941167.79, 9456.5977, -7.73861615, 0.00764471299, -0.000002241007605, 0.0000000002915845236, -0.00000000000001425033974}, bhigh = {-60710.0561, 84.2383508}, R = 218.8202848542556);
          constant IdealGases.Common.DataRecord H2(name = "H2", MM = 0.00201588, Hf = 0, H0 = 4200697.462150524, Tlimit = 1000, alow = {40783.2321, -800.918604, 8.21470201, -0.01269714457, 0.00001753605076, -0.0000000120286027, 0.00000000000336809349}, blow = {2682.484665, -30.43788844}, ahigh = {560812.801, -837.150474, 2.975364532, 0.001252249124, -0.000000374071619, 0.000000000059366252, -0.0000000000000036069941}, bhigh = {5339.82441, -2.202774769}, R = 4124.487568704486);
          constant IdealGases.Common.DataRecord H2O(name = "H2O", MM = 0.01801528, Hf = -13423382.81725291, H0 = 549760.6476280135, Tlimit = 1000, alow = {-39479.6083, 575.573102, 0.931782653, 0.00722271286, -0.00000734255737, 0.00000000495504349, -0.000000000001336933246}, blow = {-33039.7431, 17.24205775}, ahigh = {1034972.096, -2412.698562, 4.64611078, 0.002291998307, -0.0000006836830479999999, 0.00000000009426468930000001, -0.00000000000000482238053}, bhigh = {-13842.86509, -7.97814851}, R = 461.5233290850878);
          constant IdealGases.Common.DataRecord He(name = "He", MM = 0.004002602, Hf = 0, H0 = 1548349.798456104, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 0.9287239740000001}, ahigh = {0, 0, 2.5, 0, 0, 0, 0}, bhigh = {-745.375, 0.9287239740000001}, R = 2077.26673798694);
          constant IdealGases.Common.DataRecord NH3(name = "NH3", MM = 0.01703052, Hf = -2697510.117130892, H0 = 589713.1150428759, Tlimit = 1000, alow = {-76812.2615, 1270.951578, -3.89322913, 0.02145988418, -0.00002183766703, 0.00000001317385706, -0.00000000000333232206}, blow = {-12648.86413, 43.66014588}, ahigh = {2452389.535, -8040.89424, 12.71346201, -0.000398018658, 0.0000000355250275, 0.00000000000253092357, -0.000000000000000332270053}, bhigh = {43861.91959999999, -64.62330602}, R = 488.2101075011215);
          constant IdealGases.Common.DataRecord NO(name = "NO", MM = 0.0300061, Hf = 3041758.509103149, H0 = 305908.1320131574, Tlimit = 1000, alow = {-11439.16503, 153.6467592, 3.43146873, -0.002668592368, 0.00000848139912, -0.00000000768511105, 0.000000000002386797655}, blow = {9098.21441, 6.72872549}, ahigh = {223901.8716, -1289.651623, 5.43393603, -0.00036560349, 0.00000009880966450000001, -0.00000000001416076856, 0.000000000000000938018462}, bhigh = {17503.17656, -8.50166909}, R = 277.0927244793559);
          constant IdealGases.Common.DataRecord NO2(name = "NO2", MM = 0.0460055, Hf = 743237.6346306421, H0 = 221890.3174620426, Tlimit = 1000, alow = {-56420.3878, 963.308572, -2.434510974, 0.01927760886, -0.00001874559328, 0.000000009145497730000001, -0.000000000001777647635}, blow = {-1547.925037, 40.6785121}, ahigh = {721300.157, -3832.6152, 11.13963285, -0.002238062246, 0.000000654772343, -0.000000000076113359, 0.00000000000000332836105}, bhigh = {25024.97403, -43.0513004}, R = 180.7277825477389);
          constant IdealGases.Common.DataRecord N2(name = "N2", MM = 0.0280134, Hf = 0, H0 = 309498.4543111511, Tlimit = 1000, alow = {22103.71497, -381.846182, 6.08273836, -0.00853091441, 0.00001384646189, -0.00000000962579362, 0.000000000002519705809}, blow = {710.846086, -10.76003744}, ahigh = {587712.406, -2239.249073, 6.06694922, -0.00061396855, 0.0000001491806679, -0.00000000001923105485, 0.000000000000001061954386}, bhigh = {12832.10415, -15.86640027}, R = 296.8033869505308);
          constant IdealGases.Common.DataRecord N2O(name = "N2O", MM = 0.0440128, Hf = 1854006.107314236, H0 = 217685.1961247637, Tlimit = 1000, alow = {42882.2597, -644.011844, 6.03435143, 0.0002265394436, 0.00000347278285, -0.00000000362774864, 0.000000000001137969552}, blow = {11794.05506, -10.0312857}, ahigh = {343844.804, -2404.557558, 9.12563622, -0.000540166793, 0.0000001315124031, -0.000000000014142151, 0.000000000000000638106687}, bhigh = {21986.32638, -31.47805016}, R = 188.9103169986913);
          constant IdealGases.Common.DataRecord Ne(name = "Ne", MM = 0.0201797, Hf = 0, H0 = 307111.9986917546, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 3.35532272}, ahigh = {0, 0, 2.5, 0, 0, 0, 0}, bhigh = {-745.375, 3.35532272}, R = 412.0215860493466);
          constant IdealGases.Common.DataRecord O2(name = "O2", MM = 0.0319988, Hf = 0, H0 = 271263.4223783392, Tlimit = 1000, alow = {-34255.6342, 484.700097, 1.119010961, 0.00429388924, -0.000000683630052, -0.0000000020233727, 0.000000000001039040018}, blow = {-3391.45487, 18.4969947}, ahigh = {-1037939.022, 2344.830282, 1.819732036, 0.001267847582, -0.0000002188067988, 0.00000000002053719572, -0.0000000000000008193467050000001}, bhigh = {-16890.10929, 17.38716506}, R = 259.8369938872708);
          constant IdealGases.Common.DataRecord SO2(name = "SO2", MM = 0.0640638, Hf = -4633037.690552231, H0 = 164650.3485587805, Tlimit = 1000, alow = {-53108.4214, 909.031167, -2.356891244, 0.02204449885, -0.00002510781471, 0.00000001446300484, -0.00000000000336907094}, blow = {-41137.52080000001, 40.45512519}, ahigh = {-112764.0116, -825.226138, 7.61617863, -0.000199932761, 0.0000000565563143, -0.00000000000545431661, 0.0000000000000002918294102}, bhigh = {-33513.0869, -16.55776085}, R = 129.7842463294403);
          constant IdealGases.Common.DataRecord SO3(name = "SO3", MM = 0.0800632, Hf = -4944843.573576874, H0 = 145990.9046852986, Tlimit = 1000, alow = {-39528.5529, 620.857257, -1.437731716, 0.02764126467, -0.00003144958662, 0.00000001792798, -0.00000000000412638666}, blow = {-51841.0617, 33.91331216}, ahigh = {-216692.3781, -1301.022399, 10.96287985, -0.000383710002, 0.0000000846688904, -0.00000000000970539929, 0.000000000000000449839754}, bhigh = {-43982.83990000001, -36.55217314}, R = 103.8488594010732);
        end SingleGasesData;
      end Common;
    end IdealGases;

    package Incompressible 
      extends Modelica.Icons.VariantsPackage;

      package Common 
        extends Modelica.Icons.Package;

        record BaseProps_Tpoly 
          extends Modelica.Icons.Record;
          .Modelica.SIunits.Temperature T;
          .Modelica.SIunits.Pressure p;
        end BaseProps_Tpoly;
      end Common;

      package TableBased 
        extends Modelica.Media.Interfaces.PartialMedium(ThermoStates = if enthalpyOfT then Modelica.Media.Interfaces.Choices.IndependentVariables.T else Modelica.Media.Interfaces.Choices.IndependentVariables.pT, final reducedX = true, final fixedX = true, mediumName = "tableMedium", redeclare record ThermodynamicState = Common.BaseProps_Tpoly, singleState = true, reference_p = 101300.0, Temperature(min = T_min, max = T_max));
        constant Boolean enthalpyOfT = true;
        constant Boolean densityOfT = size(tableDensity, 1) > 1;
        constant Temperature T_min;
        constant Temperature T_max;
        constant Temperature T0 = 273.15;
        constant SpecificEnthalpy h0 = 0;
        constant SpecificEntropy s0 = 0;
        constant MolarMass MM_const = 0.1;
        constant Integer npol = 2;
        constant Integer npolDensity = npol;
        constant Integer npolHeatCapacity = npol;
        constant Integer npolViscosity = npol;
        constant Integer npolVaporPressure = npol;
        constant Integer npolConductivity = npol;
        constant Integer neta = size(tableViscosity, 1);
        constant Real[:, 2] tableDensity;
        constant Real[:, 2] tableHeatCapacity;
        constant Real[:, 2] tableViscosity;
        constant Real[:, 2] tableVaporPressure;
        constant Real[:, 2] tableConductivity;
        constant Boolean TinK;
        constant Boolean hasDensity = not size(tableDensity, 1) == 0;
        constant Boolean hasHeatCapacity = not size(tableHeatCapacity, 1) == 0;
        constant Boolean hasViscosity = not size(tableViscosity, 1) == 0;
        constant Boolean hasVaporPressure = not size(tableVaporPressure, 1) == 0;
        final constant Real[neta] invTK = if size(tableViscosity, 1) > 0 then if TinK then 1 ./ tableViscosity[:, 1] else 1 ./ .Modelica.SIunits.Conversions.from_degC(tableViscosity[:, 1]) else fill(0, neta);
        final constant Real[:] poly_rho = if hasDensity then Polynomials_Temp.fitting(tableDensity[:, 1], tableDensity[:, 2], npolDensity) else zeros(npolDensity + 1);
        final constant Real[:] poly_Cp = if hasHeatCapacity then Polynomials_Temp.fitting(tableHeatCapacity[:, 1], tableHeatCapacity[:, 2], npolHeatCapacity) else zeros(npolHeatCapacity + 1);
        final constant Real[:] poly_eta = if hasViscosity then Polynomials_Temp.fitting(invTK, .Modelica.Math.log(tableViscosity[:, 2]), npolViscosity) else zeros(npolViscosity + 1);
        final constant Real[:] poly_lam = if size(tableConductivity, 1) > 0 then Polynomials_Temp.fitting(tableConductivity[:, 1], tableConductivity[:, 2], npolConductivity) else zeros(npolConductivity + 1);

        redeclare model extends BaseProperties 
          .Modelica.SIunits.SpecificHeatCapacity cp;
          parameter .Modelica.SIunits.Temperature T_start = 298.15;
        equation
          assert(hasDensity, "Medium " + mediumName + " can not be used without assigning tableDensity.");
          assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) + " K) is not in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max) + " K) required from medium model \"" + mediumName + "\".");
          R = Modelica.Constants.R;
          cp = Polynomials_Temp.evaluate(poly_Cp, if TinK then T else T_degC);
          h = if enthalpyOfT then h_T(T) else h_pT(p, T, densityOfT);
          u = h - (if singleState then reference_p / d else state.p / d);
          d = Polynomials_Temp.evaluate(poly_rho, if TinK then T else T_degC);
          state.T = T;
          state.p = p;
          MM = MM_const;
        end BaseProperties;

        redeclare function extends setState_pTX 
        algorithm
          state := ThermodynamicState(p = p, T = T);
        end setState_pTX;

        redeclare function extends setState_dTX 
        algorithm
          assert(false, "For incompressible media with d(T) only, state can not be set from density and temperature");
        end setState_dTX;

        redeclare function extends setState_phX 
        algorithm
          state := ThermodynamicState(p = p, T = T_ph(p, h));
        end setState_phX;

        redeclare function extends setState_psX 
        algorithm
          state := ThermodynamicState(p = p, T = T_ps(p, s));
        end setState_psX;

        redeclare function extends setSmoothState 
        algorithm
          state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
        end setSmoothState;

        redeclare function extends specificHeatCapacityCv 
        algorithm
          assert(hasHeatCapacity, "Specific Heat Capacity, Cv, is not defined for medium " + mediumName + ".");
          cv := Polynomials_Temp.evaluate(poly_Cp, if TinK then state.T else state.T - 273.15);
        end specificHeatCapacityCv;

        redeclare function extends specificHeatCapacityCp 
        algorithm
          assert(hasHeatCapacity, "Specific Heat Capacity, Cv, is not defined for medium " + mediumName + ".");
          cp := Polynomials_Temp.evaluate(poly_Cp, if TinK then state.T else state.T - 273.15);
        end specificHeatCapacityCp;

        redeclare function extends dynamicViscosity 
        algorithm
          assert(size(tableViscosity, 1) > 0, "DynamicViscosity, eta, is not defined for medium " + mediumName + ".");
          eta := .Modelica.Math.exp(Polynomials_Temp.evaluate(poly_eta, 1 / state.T));
        end dynamicViscosity;

        redeclare function extends thermalConductivity 
        algorithm
          assert(size(tableConductivity, 1) > 0, "ThermalConductivity, lambda, is not defined for medium " + mediumName + ".");
          lambda := Polynomials_Temp.evaluate(poly_lam, if TinK then state.T else .Modelica.SIunits.Conversions.to_degC(state.T));
        end thermalConductivity;

        function s_T 
          extends Modelica.Icons.Function;
          input Temperature T;
          output SpecificEntropy s;
        algorithm
          s := s0 + (if TinK then Polynomials_Temp.integralValue(poly_Cp[1:npol], T, T0) else Polynomials_Temp.integralValue(poly_Cp[1:npol], .Modelica.SIunits.Conversions.to_degC(T), .Modelica.SIunits.Conversions.to_degC(T0))) + Modelica.Math.log(T / T0) * Polynomials_Temp.evaluate(poly_Cp, if TinK then 0 else Modelica.Constants.T_zero);
        end s_T;

        redeclare function extends specificEntropy 
        protected
          Integer npol = size(poly_Cp, 1) - 1;
        algorithm
          assert(hasHeatCapacity, "Specific Entropy, s(T), is not defined for medium " + mediumName + ".");
          s := s_T(state.T);
        end specificEntropy;

        function h_T 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature T;
          output .Modelica.SIunits.SpecificEnthalpy h;
        algorithm
          h := h0 + Polynomials_Temp.integralValue(poly_Cp, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T), if TinK then T0 else .Modelica.SIunits.Conversions.to_degC(T0));
        end h_T;

        function h_T_der 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Temperature T;
          input Real dT;
          output Real dh;
        algorithm
          dh := Polynomials_Temp.evaluate(poly_Cp, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T)) * dT;
        end h_T_der;

        function h_pT 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p;
          input .Modelica.SIunits.Temperature T;
          input Boolean densityOfT = false;
          output .Modelica.SIunits.SpecificEnthalpy h;
        algorithm
          h := h0 + Polynomials_Temp.integralValue(poly_Cp, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T), if TinK then T0 else .Modelica.SIunits.Conversions.to_degC(T0)) + (p - reference_p) / Polynomials_Temp.evaluate(poly_rho, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T)) * (if densityOfT then 1 + T / Polynomials_Temp.evaluate(poly_rho, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T)) * Polynomials_Temp.derivativeValue(poly_rho, if TinK then T else .Modelica.SIunits.Conversions.to_degC(T)) else 1.0);
        end h_pT;

        redeclare function extends temperature 
        algorithm
          T := state.T;
        end temperature;

        redeclare function extends pressure 
        algorithm
          p := state.p;
        end pressure;

        redeclare function extends density 
        algorithm
          d := Polynomials_Temp.evaluate(poly_rho, if TinK then state.T else .Modelica.SIunits.Conversions.to_degC(state.T));
        end density;

        redeclare function extends specificEnthalpy 
        algorithm
          h := if enthalpyOfT then h_T(state.T) else h_pT(state.p, state.T);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy 
        algorithm
          u := (if enthalpyOfT then h_T(state.T) else h_pT(state.p, state.T)) - (if singleState then reference_p else state.p) / density(state);
        end specificInternalEnergy;

        function T_ph 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEnthalpy h;
          output Temperature T;

        protected
          package Internal 
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data 
              constant Real[5] dummy = {1, 2, 3, 4, 5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear 
            algorithm
              y := if singleState then h_T(x) else h_pT(p, x);
            end f_nonlinear;

            redeclare function extends solve end solve;
          end Internal;
        algorithm
          T := Internal.solve(h, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
        end T_ph;

        function T_ps 
          extends Modelica.Icons.Function;
          input AbsolutePressure p;
          input SpecificEntropy s;
          output Temperature T;

        protected
          package Internal 
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data 
              constant Real[5] dummy = {1, 2, 3, 4, 5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear 
            algorithm
              y := s_T(x);
            end f_nonlinear;

            redeclare function extends solve end solve;
          end Internal;
        algorithm
          T := Internal.solve(s, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
        end T_ps;

        package Polynomials_Temp 
          extends Modelica.Icons.Package;

          function evaluate 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u;
            output Real y;
          algorithm
            y := p[1];
            for j in 2:size(p, 1) loop
              y := p[j] + u * y;
            end for;
          end evaluate;

          function evaluateWithRange 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real uMin;
            input Real uMax;
            input Real u;
            output Real y;
          algorithm
            if u < uMin then
              y := evaluate(p, uMin) - evaluate_der(p, uMin, uMin - u);
            elseif u > uMax then
              y := evaluate(p, uMax) + evaluate_der(p, uMax, u - uMax);
            else
              y := evaluate(p, u);
            end if;
          end evaluateWithRange;

          function derivativeValue 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u;
            output Real y;
          protected
            Integer n = size(p, 1);
          algorithm
            y := p[1] * (n - 1);
            for j in 2:size(p, 1) - 1 loop
              y := p[j] * (n - j) + u * y;
            end for;
          end derivativeValue;

          function secondDerivativeValue 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u;
            output Real y;
          protected
            Integer n = size(p, 1);
          algorithm
            y := p[1] * (n - 1) * (n - 2);
            for j in 2:size(p, 1) - 2 loop
              y := p[j] * (n - j) * (n - j - 1) + u * y;
            end for;
          end secondDerivativeValue;

          function integralValue 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u_high;
            input Real u_low = 0;
            output Real integral = 0.0;
          protected
            Integer n = size(p, 1);
            Real y_low = 0;
          algorithm
            for j in 1:n loop
              integral := u_high * (p[j] / (n - j + 1) + integral);
              y_low := u_low * (p[j] / (n - j + 1) + y_low);
            end for;
            integral := integral - y_low;
          end integralValue;

          function fitting 
            extends Modelica.Icons.Function;
            input Real[:] u;
            input Real[size(u, 1)] y;
            input Integer n(min = 1);
            output Real[n + 1] p;
          protected
            Real[size(u, 1), n + 1] V;
          algorithm
            V[:, n + 1] := ones(size(u, 1));
            for j in n:-1:1 loop
              V[:, j] := array(u[i] * V[i, j + 1] for i in 1:size(u, 1));
            end for;
            p := Modelica.Math.Matrices.leastSquares(V, y);
          end fitting;

          function evaluate_der 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u;
            input Real du;
            output Real dy;
          protected
            Integer n = size(p, 1);
          algorithm
            dy := p[1] * (n - 1);
            for j in 2:size(p, 1) - 1 loop
              dy := p[j] * (n - j) + u * dy;
            end for;
            dy := dy * du;
          end evaluate_der;

          function evaluateWithRange_der 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real uMin;
            input Real uMax;
            input Real u;
            input Real du;
            output Real dy;
          algorithm
            if u < uMin then
              dy := evaluate_der(p, uMin, du);
            elseif u > uMax then
              dy := evaluate_der(p, uMax, du);
            else
              dy := evaluate_der(p, u, du);
            end if;
          end evaluateWithRange_der;

          function integralValue_der 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u_high;
            input Real u_low = 0;
            input Real du_high;
            input Real du_low = 0;
            output Real dintegral = 0.0;
          algorithm
            dintegral := evaluate(p, u_high) * du_high;
          end integralValue_der;

          function derivativeValue_der 
            extends Modelica.Icons.Function;
            input Real[:] p;
            input Real u;
            input Real du;
            output Real dy;
          protected
            Integer n = size(p, 1);
          algorithm
            dy := secondDerivativeValue(p, u) * du;
          end derivativeValue_der;
        end Polynomials_Temp;
      end TableBased;
    end Incompressible;
  end Media;

  package Math 
    extends Modelica.Icons.Package;

    package Icons 
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft end AxisLeft;

      partial function AxisCenter end AxisCenter;
    end Icons;

    package Matrices 
      extends Modelica.Icons.Package;

      function leastSquares 
        extends Modelica.Icons.Function;
        input Real[:, :] A;
        input Real[size(A, 1)] b;
        input Real rcond = 100 * Modelica.Constants.eps;
        output Real[size(A, 2)] x;
        output Integer rank;
      protected
        Integer info;
        Real[max(size(A, 1), size(A, 2))] xx;
      algorithm
        if min(size(A)) > 0 then
          (xx, info, rank) := LAPACK.dgelsx_vec(A, b, rcond);
          x := xx[1:size(A, 2)];
          assert(info == 0, "Solving an overdetermined or underdetermined linear system\n" + "of equations with function \"Matrices.leastSquares\" failed.");
        else
          x := fill(0.0, size(A, 2));
        end if;
      end leastSquares;

      package LAPACK 
        extends Modelica.Icons.Package;

        function dgelsx_vec 
          extends Modelica.Icons.Function;
          input Real[:, :] A;
          input Real[size(A, 1)] b;
          input Real rcond = 0.0;
          output Real[max(size(A, 1), size(A, 2))] x = cat(1, b, zeros(max(nrow, ncol) - nrow));
          output Integer info;
          output Integer rank;
        protected
          Integer nrow = size(A, 1);
          Integer ncol = size(A, 2);
          Integer nx = max(nrow, ncol);
          Integer lwork = max(min(nrow, ncol) + 3 * ncol, 2 * min(nrow, ncol) + 1);
          Real[max(min(size(A, 1), size(A, 2)) + 3 * size(A, 2), 2 * min(size(A, 1), size(A, 2)) + 1)] work;
          Real[size(A, 1), size(A, 2)] Awork = A;
          Integer[size(A, 2)] jpvt = zeros(ncol);
          external "FORTRAN 77" dgelsx(nrow, ncol, 1, Awork, nrow, x, nx, jpvt, rcond, rank, work, lwork, info);
        end dgelsx_vec;
      end LAPACK;
    end Matrices;

    function cos 
      extends Modelica.Math.Icons.AxisLeft;
      input .Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = cos(u);
    end cos;

    function tan 
      extends Modelica.Math.Icons.AxisCenter;
      input .Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = tan(u);
    end tan;

    function asin 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function cosh 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = cosh(u);
    end cosh;

    function tanh 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = tanh(u);
    end tanh;

    function exp 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;

    function log 
      extends Modelica.Math.Icons.AxisLeft;
      input Real u;
      output Real y;
      external "builtin" y = log(u);
    end log;
  end Math;

  package Utilities 
    extends Modelica.Icons.Package;

    package Streams 
      extends Modelica.Icons.Package;

      function error 
        extends Modelica.Icons.Function;
        input String string;
        external "C" ModelicaError(string);
      end error;
    end Streams;
  end Utilities;

  package Constants 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps;
    final constant Real inf = ModelicaServices.Machine.inf;
    final constant .Modelica.SIunits.Velocity c = 299792458;
    final constant .Modelica.SIunits.Acceleration g_n = 9.80665;
    final constant Real R(final unit = "J/(mol.K)") = 8.314472;
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 0.0000001;
    final constant .Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T_zero = -273.15;
  end Constants;

  package Icons 
    extends Icons.Package;

    partial package ExamplesPackage 
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example end Example;

    partial package Package end Package;

    partial package BasesPackage 
      extends Modelica.Icons.Package;
    end BasesPackage;

    partial package VariantsPackage 
      extends Modelica.Icons.Package;
    end VariantsPackage;

    partial package InterfacesPackage 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package SensorsPackage 
      extends Modelica.Icons.Package;
    end SensorsPackage;

    partial package UtilitiesPackage 
      extends Modelica.Icons.Package;
    end UtilitiesPackage;

    partial package TypesPackage 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package MaterialPropertiesPackage 
      extends Modelica.Icons.Package;
    end MaterialPropertiesPackage;

    partial class RotationalSensor end RotationalSensor;

    partial function Function end Function;

    partial record Record end Record;
  end Icons;

  package SIunits 
    extends Modelica.Icons.Package;

    package Icons 
      extends Modelica.Icons.IconsPackage;

      partial function Conversion end Conversion;
    end Icons;

    package Conversions 
      extends Modelica.Icons.Package;

      package NonSIunits 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC");
        type Pressure_bar = Real(final quantity = "Pressure", final unit = "bar");
      end NonSIunits;

      function to_degC 
        extends Modelica.SIunits.Icons.Conversion;
        input Temperature Kelvin;
        output NonSIunits.Temperature_degC Celsius;
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
      end to_degC;

      function from_degC 
        extends Modelica.SIunits.Icons.Conversion;
        input NonSIunits.Temperature_degC Celsius;
        output Temperature Kelvin;
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
      end from_degC;

      function to_bar 
        extends Modelica.SIunits.Icons.Conversion;
        input Pressure Pa;
        output NonSIunits.Pressure_bar bar;
      algorithm
        bar := Pa / 100000.0;
      end to_bar;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Area = Real(final quantity = "Area", final unit = "m2");
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Time = Real(final quantity = "Time", final unit = "s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 100000.0);
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
    type Energy = Real(final quantity = "Energy", final unit = "J");
    type Power = Real(final quantity = "Power", final unit = "W");
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC");
    type Temperature = ThermodynamicTemperature;
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)");
    type RatioOfSpecificHeatCapacities = Real(final quantity = "RatioOfSpecificHeatCapacities", final unit = "1");
    type Entropy = Real(final quantity = "Entropy", final unit = "J/K");
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", final unit = "J/(kg.K)");
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", final unit = "J/kg");
    type SpecificInternalEnergy = SpecificEnergy;
    type SpecificEnthalpy = SpecificEnergy;
    type DerDensityByEnthalpy = Real(final unit = "kg.s2/m5");
    type DerDensityByPressure = Real(final unit = "s2/m2");
    type DerDensityByTemperature = Real(final unit = "kg/(m3.K)");
    type AmountOfSubstance = Real(final quantity = "AmountOfSubstance", final unit = "mol", min = 0);
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0);
    type MolarVolume = Real(final quantity = "MolarVolume", final unit = "m3/mol", min = 0);
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1);
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", min = 0, max = 1);
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
end Modelica;
