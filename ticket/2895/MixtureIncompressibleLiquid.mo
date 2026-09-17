package MixtureIncompressibleLiquid
  import SI = Modelica.SIunits;
  import Cv = Modelica.SIunits.Conversions;
  import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
  import Modelica.Constants;
  import Modelica.Math;

  package Examples
    package PipelineOil "Model for a pipeline to which different batches of incompressible fluids are supplied"
      extends MixtureIncompressibleLiquid.TableBasedMixture(mediumName = "Oil", data = {MixtureIncompressibleLiquid.SingleLiquidPolynomials.Test, MixtureIncompressibleLiquid.SingleLiquidPolynomials.Glycol});
    end PipelineOil;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Examples;

  package Common "Common data structures"
    extends Modelica.Icons.Package;

    record DataRecord "Table-based properties of liquids"
      extends Modelica.Icons.Record;
      String name "Name of liquid";
      Real[:, 2] tableDensity "Table for density(T)";
      Real[:, 2] tableHeatCapacity "Table for heat capacity(T)";
      Real[:, 2] tableViscosity "Table for viscosity(T)";
      Real[:, 2] tableConductivity "Table for thermal conductivity(T)";
      Real[:, 2] tableVaporPressure "Table for vapor pressure(T)";
    end DataRecord;

    record PolyRecord "Polynomial coefficients for data interpolation"
      String name "Name of liquid";
      SI.Temperature T0 = 298.15 "Reference Temperature";
      SI.SpecificEnthalpy h0 "Reference specific enthalpy at T0";
      SI.SpecificEntropy s0 "Reference specific entropy at T0";
      Real poly_rho[:] "Polynomial coefficients of table-based density";
      Real poly_Cp[:] "Polynomial coefficients of table-based heat capacity";
      Real poly_eta[:] "Polynomial coefficients of table-based viscosity";
      Real poly_pVap[:] "Polynomial coefficients of table-based vapor pressure";
      Real poly_lam[:] "Polynomial coefficients of table-based thermal conductivity";
    end PolyRecord;
  end Common;

  package SingleLiquidData "Database of table-based liquid properties"
    extends Modelica.Icons.Package;
    constant MixtureIncompressibleLiquid.Common.DataRecord Glycol(name = "Glycol", tableDensity = [0, 1054; 20, 1044; 40, 1030; 60, 1015; 80, 999; 100, 984], tableHeatCapacity = [0, 3560; 20, 3620; 40, 3690; 60, 3760; 80, 3820; 100, 3890], tableConductivity = [0, 0.395; 20, 0.394; 40, 0.393; 60, 0.392; 80, 0.391; 100, 0.39], tableViscosity = [0, 0.019; 20, 0.00626; 40, 0.00299; 60, 0.00162; 80, 0.0011; 100, 0.00081], tableVaporPressure = [0, 100]);
    constant MixtureIncompressibleLiquid.Common.DataRecord Test(name = "Test", tableDensity = [0, 1034; 20, 1024; 40, 1010; 60, 995; 80, 979; 100, 974], tableHeatCapacity = [0, 3660; 20, 3720; 40, 3790; 60, 3860; 80, 3920; 100, 3990], tableConductivity = [0, 0.495; 20, 0.494; 40, 0.493; 60, 0.492; 80, 0.491; 100, 0.49], tableViscosity = [0, 0.01; 20, 0.003; 40, 0.0015; 60, 0.0008; 80, 0.0005; 100, 0.0004], tableVaporPressure = [0, 100]);
  end SingleLiquidData;

  package SingleLiquidPolynomials "Polynomial coefficient for the interpolation of the thermophysical properties"
    extends Modelica.Icons.Package;
    constant Boolean TinK = false "True if the temperatures in the tables are in Kelvin";
    constant Integer npolDensity = 3 "Degree of polynomial used for fitting rho(T)";
    constant Integer npolHeatCapacity = 3 "Degree of polynomial used for fitting Cp(T)";
    constant Integer npolViscosity = 3 "Degree of polynomial used for fitting eta(T)";
    constant Integer npolVaporPressure = 3 "Degree of polynomial used for fitting pVap(T)";
    constant Integer npolConductivity = 3 "Degree of polynomial used for fitting lambda(T)";
    constant Real T_min = Cv.from_degC(0) "Minimum temperature at which the thermophysical properties can be interpolated";
    constant Real T_max = Cv.from_degC(100) "Maximum temperature at which the thermophysical properties can be interpolated";
    constant MixtureIncompressibleLiquid.Common.PolyRecord Glycol(name = "Glycol", T0 = 0.0, h0 = 0.0, s0 = 0.0, poly_rho = Poly.fitting(SingleLiquidData.Glycol.tableDensity[:, 1], SingleLiquidData.Glycol.tableDensity[:, 2], npolDensity), poly_Cp = Poly.fitting(SingleLiquidData.Glycol.tableHeatCapacity[:, 1], SingleLiquidData.Glycol.tableHeatCapacity[:, 2], npolHeatCapacity), poly_eta = Poly.fitting(if TinK then 1 ./ SingleLiquidData.Glycol.tableViscosity[:, 1] else 1 ./ Cv.from_degC(SingleLiquidData.Glycol.tableViscosity[:, 1]), Math.log(SingleLiquidData.Glycol.tableViscosity[:, 2]), npolViscosity), poly_pVap = Poly.fitting(SingleLiquidData.Glycol.tableVaporPressure[:, 1], SingleLiquidData.Glycol.tableVaporPressure[:, 2], npolVaporPressure), poly_lam = Poly.fitting(SingleLiquidData.Glycol.tableConductivity[:, 1], SingleLiquidData.Glycol.tableConductivity[:, 2], npolConductivity));
    constant MixtureIncompressibleLiquid.Common.PolyRecord Test(name = "Test", T0 = 0.0, h0 = 0.0, s0 = 0.0, poly_rho = Poly.fitting(SingleLiquidData.Test.tableDensity[:, 1], SingleLiquidData.Test.tableDensity[:, 2], npolDensity), poly_Cp = Poly.fitting(SingleLiquidData.Test.tableHeatCapacity[:, 1], SingleLiquidData.Test.tableHeatCapacity[:, 2], npolHeatCapacity), poly_eta = Poly.fitting(if TinK then 1 ./ SingleLiquidData.Test.tableViscosity[:, 1] else 1 ./ Cv.from_degC(SingleLiquidData.Test.tableViscosity[:, 1]), Math.log(SingleLiquidData.Test.tableViscosity[:, 2]), npolViscosity), poly_pVap = Poly.fitting(SingleLiquidData.Test.tableVaporPressure[:, 1], SingleLiquidData.Test.tableVaporPressure[:, 2], npolVaporPressure), poly_lam = Poly.fitting(SingleLiquidData.Test.tableConductivity[:, 1], SingleLiquidData.Test.tableConductivity[:, 2], npolConductivity));
  end SingleLiquidPolynomials;

  package TableBasedMixture "Mixture of incompressible media with table-based properties"
    extends Modelica.Media.Interfaces.PartialMixtureMedium(ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX, substanceNames = data[:].name, final reducedX = false, final fixedX = false, singleState = false, reference_X = fill(1.0 / nX, nX), AbsolutePressure(start = 101325.0, nominal = 101325.0), reference_p = 101325.0, Temperature(min = 273.15, max = 373.15, start = 300, nominal = 300));

    redeclare record extends ThermodynamicState "Thermodynamic state variables"
    end ThermodynamicState;

    // Constants to be set in actual Medium
    constant MixtureIncompressibleLiquid.Common.PolyRecord[:] data "Data records of table-based incompressible liquids";
    constant SI.MolarMass MM_const = 0.1 "Dummy molar mass (not needed)";

    redeclare model extends BaseProperties(final standardOrderComponents = true, p_bar = Cv.to_bar(p), T_degC(start = T_start - 273.15) = Cv.to_degC(T), T(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), p(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), Xi(each stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default)) "Base properties of T dependent medium"
        parameter SI.Temperature T_start = 300.0 "Initial temperature";

      protected
        Real[nX] dens "Intermediate array for computing the density of the mixture. The direct calculation does not work.";

      equation
        assert(T >= SingleLiquidPolynomials.T_min and T <= SingleLiquidPolynomials.T_max, "Temperature T (= " + String(T) + " K) is not in the allowed range (" + String(SingleLiquidPolynomials.T_min) + " K <= T <= " + String(SingleLiquidPolynomials.T_max) + " K) required from medium model \"" + mediumName + "\".");
        R = Modelica.Constants.R;
        h = h_TX(T, X);
        u = h - (if singleState then reference_p / d else state.p / d);
        dens = array(d_T(data[i], T) for i in 1:nX);
        d = X * dens;
        state.T = T;
        state.p = p;
        state.X = if fixedX then reference_X else X;
        MM = MM_const;
    end BaseProperties;

    redeclare function setState_pTX "Return thermodynamic state as function of p, T and composition X"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "Pressure";
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] = reference_X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T, X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T, X = X) else ThermodynamicState(p = p, T = T, X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_pTX;

    redeclare function extends setState_dTX "Return thermodynamic state as function of density, T and composition X"
        extends Modelica.Icons.Function;

      algorithm
        assert(false, "For incompressible media with d(T) only, state can not be set from density and temperature");
    end setState_dTX;

    function setState_pT "Returns state record as function of p and T"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "Pressure";
      input SI.Temperature T "Temperature";
      output ThermodynamicState state "Thermodynamic state";
    algorithm
      state.T := T;
      state.p := p;
      annotation(smoothOrder = 3);
    end setState_pT;

    redeclare function setState_phX "Returns state record, given pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input SI.AbsolutePressure p "Pressure";
      input SI.SpecificEnthalpy h "Specific enthalpy";
      input SI.MassFraction[nX] X "Mass fractions";
      output ThermodynamicState state;
    algorithm
      state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T_hX(h, reference_X), X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T_hX(h, X), X = X) else ThermodynamicState(p = p, T = T_hX(h, X), X = cat(1, X, {1 - sum(X)}));
      annotation(Inline = true, smoothOrder = 2);
    end setState_phX;

    redeclare function extends setSmoothState "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        extends Modelica.Icons.Function;

      algorithm
        state := ThermodynamicState(p = Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), T = Modelica.Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
      annotation(Inline = true, smoothOrder = 3);
    end setSmoothState;

    redeclare function extends specificHeatCapacityCv "Specific heat capacity at constant volume (or pressure) of medium"
      algorithm
        cv := state.X * array(cp_TX(data[i], state.T) for i in 1:nX);
      annotation(smoothOrder = 2);
    end specificHeatCapacityCv;

    redeclare function extends specificHeatCapacityCp "Specific heat capacity at constant volume (or pressure) of medium"
        extends Modelica.Icons.Function;

      algorithm
        cp := state.X * array(cp_T(data[i], state.T) for i in 1:nX);
      annotation(smoothOrder = 2);
    end specificHeatCapacityCp;

    function cp_T "Return the heat capacity of a single species by interpolating its table"
      input MixtureIncompressibleLiquid.Common.PolyRecord data "Data record";
      input SI.Temperature T "Temperature";
      output SI.SpecificHeatCapacity cp;
    algorithm
      cp := Poly.evaluate(data.poly_Cp, if SingleLiquidPolynomials.TinK then T else T - 273.15);
      annotation(smoothOrder = 2);
    end cp_T;

    redeclare function extends dynamicViscosity "Return dynamic viscosity as a function of the thermodynamic state record"
        extends Modelica.Icons.Function;

      protected
        Real dens[size(state.X, 1)];

      algorithm
        dens := array(d_T(data[i], state.T) for i in 1:nX);
        eta := state.X * array(visc_T(data[i], state.T) for i in 1:nX);
      annotation(smoothOrder = 2);
    end dynamicViscosity;

    function visc_T "Return the viscosity of a single species by interpolating its table"
      extends Modelica.Icons.Function;
      input MixtureIncompressibleLiquid.Common.PolyRecord data "Data record";
      input SI.Temperature T "Temperature";
      output SI.DynamicViscosity visc;
    algorithm
      visc := Math.exp(Poly.evaluate(data.poly_eta, 1 / T));
      annotation(smoothOrder = 2);
    end visc_T;

    redeclare function extends thermalConductivity "Return thermal conductivity as a function of the thermodynamic state record"
        extends Modelica.Icons.Function;

      protected
        Real dens[size(state.X, 1)];

      algorithm
        dens := array(d_T(data[i], state.T) for i in 1:nX);
        lambda := state.X * array(thcond_T(data[i], state.T) for i in 1:nX);
      annotation(smoothOrder = 2);
    end thermalConductivity;

    function thcond_T "Return the thermal conductivity of a single species by interpolating its table"
      extends Modelica.Icons.Function;
      input MixtureIncompressibleLiquid.Common.PolyRecord data "Data record";
      input SI.Temperature T "Temperature";
      output SI.ThermalConductivity thcond;
    algorithm
      thcond := Poly.evaluate(data.poly_lam, if SingleLiquidPolynomials.TinK then T else Cv.to_degC(T));
      annotation(smoothOrder = 2);
    end thcond_T;

    function h_TX "Compute specific enthalpy from temperature"
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input SI.MassFraction[nX] X "Mass fractions";
      output SI.SpecificEnthalpy h;
    algorithm
      h := X * array(h_T(data[i], T) for i in 1:nX);
      annotation(derivative = h_TX_der);
    end h_TX;

    function h_T "Return the entalpy of a single species from its temperature"
      extends Modelica.Icons.Function;
      input MixtureIncompressibleLiquid.Common.PolyRecord data "Data record";
      input SI.Temperature T "Temperature";
      output SI.SpecificEnthalpy h "Specific enthalpy at T";
    algorithm
      h := data.h0 + Poly.integralValue(data.poly_Cp, if SingleLiquidPolynomials.TinK then T else Cv.to_degC(T), data.T0);
    end h_T;

    function h_TX_der "Compute specific enthalpy from temperature"
      import Modelica.SIunits.Conversions.to_degC;
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input MassFraction X[nX] "Independent Mass fractions of gas mixture";
      input Real dT "Temperature derivative";
      input Real dX[nX] "Independent mass fraction derivative";
      output Real dh "Derivative of Specific enthalpy at T";
    algorithm
      dh := X * array(cp_T(data[i], T) for i in 1:nX) * dT + dX * array(h_T(data[i], T) for i in 1:nX);
      annotation(smoothOrder = 1);
    end h_TX_der;

    function density_TX "Return density as function of temperature"
      extends Modelica.Icons.Function;
      input SI.Temperature T "Temperature";
      input SI.MassFraction X[:] = reference_X "Independent Mass fractions of liquid mixture";
      output SI.Density d "Density";
    protected
      Real[nX] dens;
    algorithm
      dens := array(d_T(data[i], T) for i in 1:nX);
      d := X * array(d_T(data[i], T) for i in 1:nX);
      annotation(Inline = true, smoothOrder = 2);
    end density_TX;

    function d_T "Return the density of a single species from its temperature"
      extends Modelica.Icons.Function;
      input MixtureIncompressibleLiquid.Common.PolyRecord data "Data record";
      input SI.Temperature T "Temperature";
      output SI.Density d "Density";
    algorithm
      d := Poly.evaluate(data.poly_rho, if SingleLiquidPolynomials.TinK then T else T - 273.15);
    end d_T;

    redeclare function extends temperature "Return temperature as a function of the thermodynamic state record"
      algorithm
        T := state.T;
      annotation(Inline = true, smoothOrder = 2);
    end temperature;

    redeclare function extends pressure "Return pressure as a function of the thermodynamic state record"
      algorithm
        p := state.p;
      annotation(Inline = true, smoothOrder = 2);
    end pressure;

    redeclare function extends density "Return density as a function of the thermodynamic state record"
      algorithm
        d := density_TX(state.T, state.X);
      annotation(Inline = true, smoothOrder = 2);
    end density;

    redeclare function extends specificEnthalpy "Return specific enthalpy as a function of the thermodynamic state record"
      algorithm
        h := h_TX(state.T, state.X);
      annotation(Inline = true, smoothOrder = 2);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy "Return specific internal energy as a function of the thermodynamic state record"
      algorithm
        u := h_TX(state.T, state.X) - (if singleState then reference_p else state.p) / density(state);
      annotation(Inline = true, smoothOrder = 2);
    end specificInternalEnergy;

    function T_hX "Compute temperature from specific enthalpy"
      extends Modelica.Icons.Function;
      input SI.SpecificEnthalpy h "Specific enthalpy";
      input SI.MassFraction[:] X "Mass fractions of composition";
      output SI.Temperature T "Temperature";

      package Internal "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
        extends Modelica.Media.Common.OneNonLinearEquation;

        redeclare record extends f_nonlinear_Data "Superfluous record, fix later when better structure of inverse functions exists"
            constant Real[5] dummy = {1, 2, 3, 4, 5};
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear "P is smuggled in via vector"
          algorithm
            y := h_TX(x, X);
        end f_nonlinear;

        // Dummy definition (has to be added for one tool)

        redeclare function extends solve
        end solve;
      end Internal;
    algorithm
      T := Internal.solve(h, SingleLiquidPolynomials.T_min, SingleLiquidPolynomials.T_max, 101325, X, Internal.f_nonlinear_Data());
      annotation(Inline = false, LateInline = true, inverse(h = h_TX(T, X)));
    end T_hX;

    function massToVolumeFractions "Return volume fractions from mass fractions X"
      extends Modelica.Icons.Function;
      input SI.MassFraction X[:] "Mass fractions of mixture";
      input SI.Density DX[:] "Molar masses of components";
      output SI.VolumeFraction volumeFractions[size(X, 1)] "Volume fractions of gas mixture";
    protected
      Real invDX[size(X, 1)] "Inverses of densities";
      Real sumDX;
    algorithm
      sumDX := 0.0;
      for i in 1:size(X, 1) loop
        invDX[i] := 1 / DX[i];
        sumDX := sumDX + X[i] * invDX[i];
      end for;
      for i in 1:size(X, 1) loop
        volumeFractions[i] := X[i] * invDX[i] / sumDX;
      end for;
      annotation(smoothOrder = 5);
    end massToVolumeFractions;
  end TableBasedMixture;
  annotation(Documentation(info = "<html>
                               <p>
                              This package can be used for hydraulic systems operated with different incompressible liquids having table-based properties. At the moment the mixture properties are computed by weighting the property of each liquid with its mass fraction, which is in general not correct. More rigorous mixing properties have to be implemented in the future.
                               </p>
                               </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end MixtureIncompressibleLiquid;