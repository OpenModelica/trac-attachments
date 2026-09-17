package Modelica "Modelica Standard Library (Version 3.1)"
extends Modelica.Icons.Library;

  package Media "Library of media property models"
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;

  package Interfaces "Interfaces for media models"
    extends Modelica.Icons.Library;
    import SI = Modelica.SIunits;

    partial package PartialMedium
    "Partial medium properties (base package of all media packages)"

      import SI = Modelica.SIunits;
      extends Modelica.Icons.Library;

      // Constants to be set in Medium
      constant
      Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables
      ThermoStates "Enumeration type for independent variables";
      constant String mediumName = "unusablePartialMedium" "Name of the medium";
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
      constant MassFraction reference_X[nX]= fill(1/nX, nX)
      "Default mass fractions of medium";
      constant AbsolutePressure p_default=101325
      "Default value for pressure of medium (for initialization)";
      constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20)
      "Default value for temperature of medium (for initialization)";
      constant SpecificEnthalpy h_default = specificEnthalpy_pTX(p_default, T_default, X_default)
      "Default value for specific enthalpy of medium (for initialization)";
      constant MassFraction X_default[nX]=reference_X
      "Default value for mass fractions of medium (for initialization)";

      final constant Integer nS=size(substanceNames, 1) "Number of substances";
      constant Integer nX = nS "Number of mass fractions";
      constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
      "Number of structurally independent mass fractions (see docu for details)";

      final constant Integer nC=size(extraPropertiesNames, 1)
      "Number of extra (outside of standard mass-balance) transported properties";

      replaceable record FluidConstants
      "critical, triple, molecular and other standard data of fluid"
        extends Modelica.Icons.Record;
        String iupacName
        "complete IUPAC name (or common name, if non-existent)";
        String casRegistryNumber
        "chemical abstracts sequencing number (if it exists)";
        String chemicalFormula
        "Chemical formula, (brutto, nomenclature according to Hill";
        String structureFormula "Chemical structure formula";
        MolarMass molarMass "molar mass";
      end FluidConstants;

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
        "thermodynamic state record for optional functions";
        parameter Boolean preferredMediumStates=false
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium";
        parameter Boolean standardOrderComponents = true
        "if true, and reducedX = true, the last element of X will be computed from the other ones";
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
                     String(i) + "] = " + String(X[i]) + "of substance "
                     + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
            end for;

        end if;

        assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
          mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
      end BaseProperties;

      replaceable partial function setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_pTX;

      replaceable partial function setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_phX;

      replaceable partial function setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_psX;

      replaceable partial function setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input Density d "density";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
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
      end setSmoothState;

      replaceable partial function dynamicViscosity "Return dynamic viscosity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DynamicViscosity eta "Dynamic viscosity";
      end dynamicViscosity;

      replaceable partial function thermalConductivity
      "Return thermal conductivity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output ThermalConductivity lambda "Thermal conductivity";
      end thermalConductivity;

      replaceable function prandtlNumber "Return the Prandtl number"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output PrandtlNumber Pr "Prandtl number";
      algorithm
        Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/thermalConductivity(
          state);
      end prandtlNumber;

      replaceable partial function pressure "Return pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output AbsolutePressure p "Pressure";
      end pressure;

      replaceable partial function temperature "Return temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Temperature T "Temperature";
      end temperature;

      replaceable partial function density "Return density"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Density d "Density";
      end density;

      replaceable partial function specificEnthalpy "Return specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnthalpy h "Specific enthalpy";
      end specificEnthalpy;

      replaceable partial function specificInternalEnergy
      "Return specific internal energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy u "Specific internal energy";
      end specificInternalEnergy;

      replaceable partial function specificEntropy "Return specific entropy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEntropy s "Specific entropy";
      end specificEntropy;

      replaceable partial function specificGibbsEnergy
      "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy g "Specific Gibbs energy";
      end specificGibbsEnergy;

      replaceable partial function specificHelmholtzEnergy
      "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy f "Specific Helmholtz energy";
      end specificHelmholtzEnergy;

      replaceable partial function specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
      end specificHeatCapacityCp;

      function heatCapacity_cp = specificHeatCapacityCp
      "alias for deprecated name";

      replaceable partial function specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
      end specificHeatCapacityCv;

      function heatCapacity_cv = specificHeatCapacityCv
      "alias for deprecated name";

      replaceable partial function isentropicExponent
      "Return isentropic exponent"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output IsentropicExponent gamma "Isentropic exponent";
      end isentropicExponent;

      replaceable partial function isentropicEnthalpy
      "Return isentropic enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p_downstream "downstream pressure";
        input ThermodynamicState refState "reference state for entropy";
        output SpecificEnthalpy h_is "Isentropic enthalpy";
      end isentropicEnthalpy;

      replaceable partial function velocityOfSound "Return velocity of sound"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output VelocityOfSound a "Velocity of sound";
      end velocityOfSound;

      replaceable partial function isobaricExpansionCoefficient
      "Return overall the isobaric expansion coefficient beta"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output IsobaricExpansionCoefficient beta
        "Isobaric expansion coefficient";
      end isobaricExpansionCoefficient;

      function beta = isobaricExpansionCoefficient
      "alias for isobaricExpansionCoefficient for user convenience";

      replaceable partial function isothermalCompressibility
      "Return overall the isothermal compressibility factor"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SI.IsothermalCompressibility kappa "Isothermal compressibility";
      end isothermalCompressibility;

      function kappa = isothermalCompressibility
      "alias of isothermalCompressibility for user convenience";

      // explicit derivative functions for finite element models
      replaceable partial function density_derp_h
      "Return density derivative wrt pressure at const specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByPressure ddph "Density derivative wrt pressure";
      end density_derp_h;

      replaceable partial function density_derh_p
      "Return density derivative wrt specific enthalpy at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByEnthalpy ddhp
        "Density derivative wrt specific enthalpy";
      end density_derh_p;

      replaceable partial function density_derp_T
      "Return density derivative wrt pressure at const temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByPressure ddpT "Density derivative wrt pressure";
      end density_derp_T;

      replaceable partial function density_derT_p
      "Return density derivative wrt temperature at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByTemperature ddTp
        "Density derivative wrt temperature";
      end density_derT_p;

      replaceable partial function density_derX
      "Return density derivative wrt mass fraction"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Density[nX] dddX "Derivative of density wrt mass fraction";
      end density_derX;

      replaceable partial function molarMass
      "Return the molar mass of the medium"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
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
        h := specificEnthalpy(setState_pTX(p,T,X));
      end specificEnthalpy_pTX;

      replaceable function density_pTX "Return density from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:] "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(p,T,X));
      end density_pTX;

      replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_phX(p,h,X));
      end temperature_phX;

      replaceable function density_phX "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_phX(p,h,X));
      end density_phX;

      replaceable function temperature_psX
      "Return temperature from p,s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_psX(p,s,X));
      end temperature_psX;

      replaceable function density_psX "Return density from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_psX(p,s,X));
      end density_psX;

      replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(p,s,X));
      end specificEnthalpy_psX;

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
      type EnthalpyFlowRate = SI.EnthalpyFlowRate (
          nominal=1000.0,
          min=-1.0e8,
          max=1.e8)
      "Type for enthalpy flow rate with medium specific attributes";
      type MassFlowRate = SI.MassFlowRate (
          quantity="MassFlowRate." + mediumName,
          min=-1.0e5,
          max=1.e5) "Type for mass flow rate with medium specific attributes";
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
          min=-1.0e8,
          max=1.e8,
          nominal=1.e6)
      "Type for specific enthalpy with medium specific attributes";
      type SpecificEntropy = SI.SpecificEntropy (
          min=-1.e6,
          max=1.e6,
          nominal=1.e3)
      "Type for specific entropy with medium specific attributes";
      type SpecificHeatCapacity = SI.SpecificHeatCapacity (
          min=0,
          max=1.e6,
          nominal=1.e3,
          start=1.e3)
      "Type for specific heat capacity with medium specific attributes";
      type SurfaceTension = SI.SurfaceTension
      "Type for surface tension with medium specific attributes";
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
      type CumulativeExtraProperty = Real (min=0.0, start=1.0)
      "Type for conserved integral of unspecified, mass specific property";
      type ExtraPropertyFlowRate = Real(unit="kg/s")
      "Type for flow rate of unspecified, mass-specific property";
      type IsobaricExpansionCoefficient = Real (
          min=1e-8,
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
      "Type for partial derivative of density with resect to pressure with medium specific attributes";
      type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
      "Type for partial derivative of density with resect to enthalpy with medium specific attributes";
      type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
      "Type for partial derivative of enthalpy with resect to pressure with medium specific attributes";
      type DerDensityByTemperature = SI.DerDensityByTemperature
      "Type for partial derivative of density with resect to temperature with medium specific attributes";

      package Choices "Types, constants to define menu choices"

        type IndependentVariables = enumeration(
          T "Temperature",
          pT "Pressure, Temperature",
          ph "Pressure, Specific Enthalpy",
          phX "Pressure, Specific Enthalpy, Mass Fraction",
          pTX "Pressure, Temperature, Mass Fractions",
          dTX "Density, Temperature, Mass Fractions")
        "Enumeration defining the independent variables of a medium";

        type Init = enumeration(
          NoInit "NoInit (no initialization)",
          InitialStates "InitialStates (initialize medium states)",
          SteadyState "SteadyState (initialize in steady state)",
          SteadyMass
            "SteadyMass (initialize density or pressure in steady state)")
        "Enumeration defining initialization for fluid flow";

        type ReferenceEnthalpy = enumeration(
          ZeroAt0K
            "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded", 

          ZeroAt25C
            "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded", 

          UserDefined
            "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference enthalpy of a medium";

        type ReferenceEntropy = enumeration(
          ZeroAt0K "The entropy is 0 at 0 K (default)",
          ZeroAt0C "The entropy is 0 at 0 degC",
          UserDefined
            "The user-defined reference entropy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference entropy of a medium";

        type pd = enumeration(
          default "Default (no boundary condition for p or d)",
          p_known "p_known (pressure p is known)",
          d_known "d_known (density d is known)")
        "Enumeration defining whether p or d are known for the boundary condition";

        type Th = enumeration(
          default "Default (no boundary condition for T or h)",
          T_known "T_known (temperature T is known)",
          h_known "h_known (specific enthalpy h is known)")
        "Enumeration defining whether T or h are known as boundary condition";

      end Choices;

    end PartialMedium;
  end Interfaces;

  package Common
    "data structures and fundamental functions for fluid properties"
    extends Modelica.Icons.Library;

    function smoothStep
    "Approximation of a general step, such that the characteristic is continuous and differentiable"
      extends Modelica.Icons.Function;
      input Real x "Abszissa value";
      input Real y1 "Ordinate value for x > 0";
      input Real y2 "Ordinate value for x < 0";
      input Real x_small(min=0) = 1e-5
      "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
      output Real y
      "Ordinate value to approximate y = if x > 0 then y1 else y2";
    algorithm
      y := smooth(1, if x >  x_small then y1 else 
                     if x < -x_small then y2 else 
                     if abs(x_small)>0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);

    end smoothStep;

   package OneNonLinearEquation
    "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way"
     extends Modelica.Icons.Library;

      replaceable record f_nonlinear_Data
      "Data specific for function f_nonlinear"
        extends Modelica.Icons.Record;
      end f_nonlinear_Data;

      replaceable partial function f_nonlinear
      "Nonlinear algebraic equation in one unknown: y = f_nonlinear(x,p,X)"
        extends Modelica.Icons.Function;
        input Real x "Independent variable of function";
        input Real p = 0.0
        "disregaded variables (here always used for pressure)";
        input Real[:] X = fill(0,0)
        "disregaded variables (her always used for composition)";
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
        input Real pressure = 0.0
        "disregaded variables (here always used for pressure)";
        input Real[:] X = fill(0,0)
        "disregaded variables (here always used for composition)";
         input f_nonlinear_Data f_nonlinear_data
        "Additional data for function f_nonlinear";
         input Real x_tol =  100*Modelica.Constants.eps
        "Relative tolerance of the result";
         output Real x_zero "f_nonlinear(x_zero) = y_zero";
    protected
         constant Real eps = Modelica.Constants.eps "machine epsilon";
         Real a = x_min "Current best minimum interval value";
         Real b = x_max "Current best maximum interval value";
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
         Boolean found = false;
      algorithm
         // Check that f(x_min) and f(x_max) have different sign
         fa :=f_nonlinear(x_min, pressure, X, f_nonlinear_data) - y_zero;
         fb :=f_nonlinear(x_max, pressure, X, f_nonlinear_data) - y_zero;
         fc := fb;
         if fa > 0.0 and fb > 0.0 or 
            fa < 0.0 and fb < 0.0 then
            error("The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n" +
                  "do not bracket the root of the single non-linear equation:\n" +
                  "  x_min  = " + String(x_min) + "\n" +
                  "  x_max  = " + String(x_max) + "\n" +
                  "  y_zero = " + String(y_zero) + "\n" +
                  "  fa = f(x_min) - y_zero = " + String(fa) + "\n" +
                  "  fb = f(x_max) - y_zero = " + String(fb) + "\n" +
                  "fa and fb must have opposite sign which is not the case");
         end if;

         // Initialize variables
         c :=a;
         fc :=fa;
         e :=b - a;
         d :=e;

         // Search loop
         while not found loop
            if abs(fc) < abs(fb) then
               a :=b;
               b :=c;
               c :=a;
               fa :=fb;
               fb :=fc;
               fc :=fa;
            end if;

            tol :=2*eps*abs(b) + x_tol;
            m :=(c - b)/2;

            if abs(m) <= tol or fb == 0.0 then
               // root found (interval is small enough)
               found :=true;
               x_zero :=b;
            else
               // Determine if a bisection is needed
               if abs(e) < tol or abs(fa) <= abs(fb) then
                  e :=m;
                  d :=e;
               else
                  s :=fb/fa;
                  if a == c then
                     // linear interpolation
                     p :=2*m*s;
                     q :=1 - s;
                  else
                     // inverse quadratic interpolation
                     q :=fa/fc;
                     r :=fb/fc;
                     p :=s*(2*m*q*(q - r) - (b - a)*(r - 1));
                     q :=(q - 1)*(r - 1)*(s - 1);
                  end if;

                  if p > 0 then
                     q :=-q;
                  else
                     p :=-p;
                  end if;

                  s :=e;
                  e :=d;
                  if 2*p < 3*m*q-abs(tol*q) and p < abs(0.5*s*q) then
                     // interpolation successful
                     d :=p/q;
                  else
                     // use bi-section
                     e :=m;
                     d :=e;
                  end if;
               end if;

               // Best guess value is defined as "a"
               a :=b;
               fa :=fb;
               b :=b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
               fb :=f_nonlinear(b, pressure, X, f_nonlinear_data) - y_zero;

               if fb > 0 and fc > 0 or 
                  fb < 0 and fc < 0 then
                  // initialize variables
                  c :=a;
                  fc :=fa;
                  e :=b - a;
                  d :=e;
               end if;
            end if;
         end while;
      end solve;

   end OneNonLinearEquation;
  end Common;

    package Incompressible
    "Medium model for T-dependent properties, defined by tables or polynomials"
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      import Modelica.Constants;
      import Modelica.Math;

      package Common "Common data structures"

        record BaseProps_Tpoly "Fluid state record"
          extends Modelica.Icons.Record;
          SI.Temperature T "temperature";
          SI.Pressure p "pressure";
          //    SI.Density d "density";
        end BaseProps_Tpoly;
      end Common;

      package TableBased "Incompressible medium properties based on tables"
        import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;

        extends Modelica.Media.Interfaces.PartialMedium(
           ThermoStates = if enthalpyOfT then Choices.IndependentVariables.T else Choices.IndependentVariables.pT,
           final reducedX=true,
           final fixedX = true,
           mediumName="tableMedium",
           redeclare record ThermodynamicState=Common.BaseProps_Tpoly,
           singleState=true);
        // Constants to be set in actual Medium
        constant Boolean enthalpyOfT=true
        "true if enthalpy is approximated as a function of T only, (p-dependence neglected)";
        constant Boolean densityOfT = size(tableDensity,1) > 1
        "true if density is a function of temperature";
        constant Temperature T_min "Minimum temperature valid for medium model";
        constant Temperature T_max "Maximum temperature valid for medium model";
        constant Temperature T0=273.15 "reference Temperature";
        constant SpecificEnthalpy h0=0 "reference enthalpy at T0, reference_p";
        constant SpecificEntropy s0=0 "reference entropy at T0, reference_p";
        constant MolarMass MM_const=0.1 "Molar mass";
        constant Integer npol=2 "degree of polynomial used for fitting";
        constant Integer neta=size(tableViscosity,1)
        "number of data points for viscosity";
        constant Real[:,:] tableDensity "Table for rho(T)";
        constant Real[:,:] tableHeatCapacity "Table for Cp(T)";
        constant Real[:,:] tableViscosity "Table for eta(T)";
        constant Real[:,:] tableVaporPressure "Table for pVap(T)";
        constant Real[:,:] tableConductivity "Table for lambda(T)";
        //    constant Real[:] TK=tableViscosity[:,1]+T0*ones(neta) "Temperature for Viscosity";
        constant Boolean TinK "true if T[K],Kelvin used for table temperatures";
        constant Boolean hasDensity = not (size(tableDensity,1)==0)
        "true if table tableDensity is present";
        constant Boolean hasHeatCapacity = not (size(tableHeatCapacity,1)==0)
        "true if table tableHeatCapacity is present";
        constant Boolean hasViscosity = not (size(tableViscosity,1)==0)
        "true if table tableViscosity is present";
        constant Boolean hasVaporPressure = not (size(tableVaporPressure,1)==0)
        "true if table tableVaporPressure is present";
        final constant Real invTK[neta] = if size(tableViscosity,1) > 0 then 
            invertTemp(tableViscosity[:,1],TinK) else fill(0,0);
        final constant Real poly_rho[:] = if hasDensity then 
                                             Poly.fitting(tableDensity[:,1],tableDensity[:,2],npol) else 
                                               zeros(npol+1);
        final constant Real poly_Cp[:] = if hasHeatCapacity then 
                                             Poly.fitting(tableHeatCapacity[:,1],tableHeatCapacity[:,2],npol) else 
                                               zeros(npol+1);
        final constant Real poly_eta[:] = if hasViscosity then 
                                             Poly.fitting(invTK, Math.log(tableViscosity[:,2]),npol) else 
                                               zeros(npol+1);
        final constant Real poly_pVap[:] = if hasVaporPressure then 
                                             Poly.fitting(tableVaporPressure[:,1],tableVaporPressure[:,2],npol) else 
                                                zeros(npol+1);
        final constant Real poly_lam[:] = if size(tableConductivity,1)>0 then 
                                             Poly.fitting(tableConductivity[:,1],tableConductivity[:,2],npol) else 
                                               zeros(npol+1);
        function invertTemp "function to invert temperatures"
          input Real[:] table "table temperature data";
          input Boolean Tink "flag for Celsius or Kelvin";
          output Real invTable[size(table,1)] "inverted temperatures";
        algorithm
          for i in 1:size(table,1) loop
            invTable[i] := if TinK then 1/table[i] else 1/Cv.from_degC(table[i]);
          end for;
        end invertTemp;

        redeclare model extends BaseProperties(
          final standardOrderComponents=true,
          p_bar=Cv.to_bar(p),
          T_degC(start = T_start-273.15)=Cv.to_degC(T),
          T(start = T_start,
            stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
        "Base properties of T dependent medium"
        //  redeclare parameter SpecificHeatCapacity R=Modelica.Constants.R,

          SI.SpecificHeatCapacity cp "specific heat capacity";
          parameter SI.Temperature T_start = 298.15 "initial temperature";
        equation
          assert(hasDensity,"Medium " + mediumName +
                            " can not be used without assigning tableDensity.");
          assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) +
                 " K) is not in the allowed range (" + String(T_min) +
                 " K <= T <= " + String(T_max) + " K) required from medium model \""
                 + mediumName + "\".");
          R = Modelica.Constants.R;
          cp = Poly.evaluate(poly_Cp,if TinK then T else T_degC);
          h = if enthalpyOfT then h_T(T) else  h_pT(p,T,densityOfT);
          if singleState then
            u = h_T(T) - reference_p/d;
          else
            u = h - p/d;
          end if;
          d = Poly.evaluate(poly_rho,if TinK then T else T_degC);
          state.T = T;
          state.p = p;
          MM = MM_const;
        end BaseProperties;

        redeclare function extends setState_pTX
        "Returns state record, given pressure and temperature"
        algorithm
          state := ThermodynamicState(p=p,T=T);
        end setState_pTX;

        redeclare function extends setState_dTX
        "Returns state record, given pressure and temperature"
        algorithm
          assert(false, "for incompressible media with d(T) only, state can not be set from density and temperature");
        end setState_dTX;

        function setState_pT "returns state record as function of p and T"
          input AbsolutePressure p "pressure";
          input Temperature T "temperature";
          output ThermodynamicState state "thermodynamic state";
        algorithm
          state.T := T;
          state.p := p;
        end setState_pT;

        redeclare function extends setState_phX
        "Returns state record, given pressure and specific enthalpy"
        algorithm
          state :=ThermodynamicState(p=p,T=T_ph(p,h));
        end setState_phX;

        function setState_ph "returns state record as function of p and h"
          input AbsolutePressure p "pressure";
          input SpecificEnthalpy h "specific enthalpy";
          output ThermodynamicState state "thermodynamic state";
        algorithm
          state :=ThermodynamicState(p=p,T=T_ph(p,h));
        end setState_ph;

        redeclare function extends setState_psX
        "Returns state record, given pressure and specific entropy"
        algorithm
          state :=ThermodynamicState(p=p,T=T_ps(p,s));
        end setState_psX;

        function setState_ps "returns state record as function of p and s"
          input AbsolutePressure p "pressure";
          input SpecificEntropy s "specific entropy";
          output ThermodynamicState state "thermodynamic state";
        algorithm
          state :=ThermodynamicState(p=p,T=T_ps(p,s));
        end setState_ps;

            redeclare function extends setSmoothState
        "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
            algorithm
              state :=ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                         T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
            end setSmoothState;

        redeclare function extends specificHeatCapacityCv
        "Specific heat capacity at constant volume (or pressure) of medium"

        algorithm
          assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                                 + mediumName + ".");
          cv := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
        end specificHeatCapacityCv;

        redeclare function extends specificHeatCapacityCp
        "Specific heat capacity at constant volume (or pressure) of medium"

        algorithm
          assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                                 + mediumName + ".");
          cp := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
        end specificHeatCapacityCp;

        redeclare function extends dynamicViscosity
        "Return dynamic viscosity as a function of the thermodynamic state record"

        algorithm
          assert(size(tableViscosity,1)>0,"DynamicViscosity, eta, is not defined for medium "
                                                 + mediumName + ".");
          eta := Math.exp(Poly.evaluate(poly_eta, 1/state.T));
        end dynamicViscosity;

        redeclare function extends thermalConductivity
        "Return thermal conductivity as a function of the thermodynamic state record"

        algorithm
          assert(size(tableConductivity,1)>0,"ThermalConductivity, lambda, is not defined for medium "
                                                 + mediumName + ".");
          lambda := Poly.evaluate(poly_lam,if TinK then state.T else Cv.to_degC(state.T));
        end thermalConductivity;

        function s_T "compute specific entropy"
          input Temperature T "temperature";
          output SpecificEntropy s "specific entropy";
        algorithm
          s := s0 + (if TinK then 
            Poly.integralValue(poly_Cp[1:npol],T, T0) else 
            Poly.integralValue(poly_Cp[1:npol],Cv.to_degC(T),Cv.to_degC(T0)))
            + Modelica.Math.log(T/T0)*
            Poly.evaluate(poly_Cp,if TinK then 0 else Modelica.Constants.T_zero);
        end s_T;

        redeclare function extends specificEntropy "Return specific entropy
 as a function of the thermodynamic state record"

      protected
          Integer npol=size(poly_Cp,1)-1;
        algorithm
          assert(hasHeatCapacity,"Specific Entropy, s(T), is not defined for medium "
                                                 + mediumName + ".");
          s := s_T(state.T);
        end specificEntropy;

        function h_T "Compute specific enthalpy from temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Temperature T "Temperature";
          output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
        algorithm
          h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then 
          T0 else Cv.to_degC(T0));
        end h_T;

        function h_T_der "Compute specific enthalpy from temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Temperature T "Temperature";
          input Real dT "temperature derivative";
          output Real dh "derivative of Specific enthalpy at T";
        algorithm
          dh :=Poly.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
        end h_T_der;

        function h_pT "Compute specific enthalpy from pressure and temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Boolean densityOfT = false
          "include or neglect density derivative dependence of enthalpy";
          output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
        algorithm
          h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then 
          T0 else Cv.to_degC(T0)) + (p - reference_p)/Poly.evaluate(poly_rho, if TinK then 
                  T else Cv.to_degC(T))
            *(if densityOfT then (1 + T/Poly.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))
          *Poly.derivativeValue(poly_rho,if TinK then T else Cv.to_degC(T))) else 1.0);
        end h_pT;

        function density_T "Return density as function of temperature"

          input Temperature T "temperature";
          output Density d "density";
        algorithm
          d := Poly.evaluate(poly_rho,if TinK then T else Cv.to_degC(T));
        end density_T;

        redeclare function extends temperature
        "Return temperature as a function of the thermodynamic state record"
        algorithm
         T := state.T;
        end temperature;

        redeclare function extends pressure
        "Return pressure as a function of the thermodynamic state record"
        algorithm
         p := state.p;
        end pressure;

        redeclare function extends density
        "Return density as a function of the thermodynamic state record"
        algorithm
          d := Poly.evaluate(poly_rho,if TinK then state.T else Cv.to_degC(state.T));
        end density;

        redeclare function extends specificEnthalpy
        "Return specific enthalpy as a function of the thermodynamic state record"
        algorithm
          h := if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy
        "Return specific internal energy as a function of the thermodynamic state record"
        algorithm
          u := if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T)
            - (if singleState then  reference_p/density(state) else state.p/density(state));
        end specificInternalEnergy;

        function T_ph "Compute temperature from pressure and specific enthalpy"
          input AbsolutePressure p "pressure";
          input SpecificEnthalpy h "specific enthalpy";
          output Temperature T "temperature";
      protected
          package Internal
          "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data
            "superfluous record, fix later when better structure of inverse functions exists"
                constant Real[5] dummy = {1,2,3,4,5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear
            "p is smuggled in via vector"
            algorithm
              y := if singleState then h_T(x) else h_pT(p,x);
            end f_nonlinear;

            // Dummy definition has to be added for current Dymola
            redeclare function extends solve
            end solve;
          end Internal;
        algorithm
         T := Internal.solve(h, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
        end T_ph;

        function T_ps "Compute temperature from pressure and specific enthalpy"
          input AbsolutePressure p "pressure";
          input SpecificEntropy s "specific entropy";
          output Temperature T "temperature";
      protected
          package Internal
          "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data
            "superfluous record, fix later when better structure of inverse functions exists"
                constant Real[5] dummy = {1,2,3,4,5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear
            "p is smuggled in via vector"
            algorithm
              y := s_T(x);
            end f_nonlinear;

            // Dummy definition has to be added for current Dymola
            redeclare function extends solve
            end solve;
          end Internal;
        algorithm
         T := Internal.solve(s, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
        end T_ps;

        package Polynomials_Temp
        "Temporary Functions operating on polynomials (including polynomial fitting); only to be used in Modelica.Media.Incompressible.TableBased"
          extends Modelica.Icons.Library;

          function evaluate "Evaluate polynomial at a given abszissa value"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of polynomial at u";
          algorithm
            y := p[1];
            for j in 2:size(p, 1) loop
              y := p[j] + u*y;
            end for;
          end evaluate;

          function derivative "Derivative of polynomial"
            extends Modelica.Icons.Function;
            input Real p1[:]
            "Polynomial coefficients (p1[1] is coefficient of highest power)";
            output Real p2[size(p1, 1) - 1] "Derivative of polynomial p1";
        protected
            Integer n=size(p1, 1);
          algorithm
            for j in 1:n-1 loop
              p2[j] := p1[j]*(n - j);
            end for;
          end derivative;

          function derivativeValue
          "Value of derivative of polynomial at abszissa value u"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of derivative of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            y := p[1]*(n - 1);
            for j in 2:size(p, 1)-1 loop
              y := p[j]*(n - j) + u*y;
            end for;
          end derivativeValue;

          function secondDerivativeValue
          "Value of 2nd derivative of polynomial at abszissa value u"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of 2nd derivative of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            y := p[1]*(n - 1)*(n - 2);
            for j in 2:size(p, 1)-2 loop
              y := p[j]*(n - j)*(n - j - 1) + u*y;
            end for;
          end secondDerivativeValue;

          function integral "Indefinite integral of polynomial p(u)"
            extends Modelica.Icons.Function;
            input Real p1[:]
            "Polynomial coefficients (p1[1] is coefficient of highest power)";
            output Real p2[size(p1, 1) + 1]
            "Polynomial coefficients of indefinite integral of polynomial p1 (polynomial p2 + C is the indefinite integral of p1, where C is an arbitrary constant)";
        protected
            Integer n=size(p1, 1) + 1 "degree of output polynomial";
          algorithm
            for j in 1:n-1 loop
              p2[j] := p1[j]/(n-j);
            end for;
          end integral;

          function integralValue
          "Integral of polynomial p(u) from u_low to u_high"
            extends Modelica.Icons.Function;
            input Real p[:] "Polynomial coefficients";
            input Real u_high "High integrand value";
            input Real u_low=0 "Low integrand value, default 0";
            output Real integral=0.0
            "Integral of polynomial p from u_low to u_high";
        protected
            Integer n=size(p, 1) "degree of integrated polynomial";
            Real y_low=0 "value at lower integrand";
          algorithm
            for j in 1:n loop
              integral := u_high*(p[j]/(n - j + 1) + integral);
              y_low := u_low*(p[j]/(n - j + 1) + y_low);
            end for;
            integral := integral - y_low;
          end integralValue;

          function fitting
          "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
            extends Modelica.Icons.Function;
            input Real u[:] "Abscissa data values";
            input Real y[size(u, 1)] "Ordinate data values";
            input Integer n(min=1)
            "Order of desired polynomial that fits the data points (u,y)";
            output Real p[n + 1]
            "Polynomial coefficients of polynomial that fits the date points";
        protected
            Real V[size(u, 1), n + 1] "Vandermonde matrix";
          algorithm
            // Construct Vandermonde matrix
            V[:, n + 1] := ones(size(u, 1));
            for j in n:-1:1 loop
              V[:, j] := {u[i] * V[i, j + 1] for i in 1:size(u,1)};
            end for;

            // Solve least squares problem
            p :=Modelica.Math.Matrices.leastSquares(V, y);
          end fitting;

          function evaluate_der "Evaluate polynomial at a given abszissa value"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            input Real du "Abszissa value";
            output Real dy "Value of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            dy := p[1]*(n - 1);
            for j in 2:size(p, 1)-1 loop
              dy := p[j]*(n - j) + u*dy;
            end for;
            dy := dy*du;
          end evaluate_der;

          function integralValue_der
          "Time derivative of integral of polynomial p(u) from u_low to u_high, assuming only u_high as time-dependent (Leibnitz rule)"
            extends Modelica.Icons.Function;
            input Real p[:] "Polynomial coefficients";
            input Real u_high "High integrand value";
            input Real u_low=0 "Low integrand value, default 0";
            input Real du_high "High integrand value";
            input Real du_low=0 "Low integrand value, default 0";
            output Real dintegral=0.0
            "Integral of polynomial p from u_low to u_high";
          algorithm
            dintegral := evaluate(p,u_high)*du_high;
          end integralValue_der;

          function derivativeValue_der
          "time derivative of derivative of polynomial"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            input Real du "delta of abszissa value";
            output Real dy
            "time-derivative of derivative of polynomial w.r.t. input variable at u";
        protected
            Integer n=size(p, 1);
          algorithm
            dy := secondDerivativeValue(p,u)*du;
          end derivativeValue_der;
        end Polynomials_Temp;

      end TableBased;

      package Examples "Examples for incompressible media"

      package Glycol47 "1,2-Propylene glycol, 47% mixture with water"
        extends TableBased(
          mediumName="Glycol-Water 47%",
          T_min = Cv.from_degC(-30), T_max = Cv.from_degC(100),
          TinK = false, T0=273.15,
          tableDensity=
            [-30, 1066; -20, 1062; -10, 1058; 0, 1054;
             20, 1044; 40, 1030; 60, 1015; 80, 999; 100, 984],
          tableHeatCapacity=
            [-30, 3450; -20, 3490; -10, 3520; 0, 3560;
             20, 3620; 40, 3690; 60, 3760; 80, 3820; 100, 3890],
          tableConductivity=
            [-30,0.397;  -20,0.396;  -10,0.395;  0,0.395;
             20,0.394;  40,0.393;  60,0.392;  80,0.391;  100,0.390],
          tableViscosity=
            [-30, 0.160; -20, 0.0743; -10, 0.0317; 0, 0.0190;
             20, 0.00626; 40, 0.00299; 60, 0.00162; 80, 0.00110; 100, 0.00081],
          tableVaporPressure=
            [0, 500; 20, 1.9e3; 40, 5.3e3; 60, 16e3; 80, 37e3; 100, 80e3]);
      end Glycol47;

      model TestGlycol "Test Glycol47 Medium model"
        extends Modelica.Icons.Example;
        package Medium = Glycol47 "Medium model (Glycol47)";
        Medium.BaseProperties medium;

        Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium.state);
        Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium.state);
        Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
        Medium.SpecificHeatCapacity cv=Medium.specificHeatCapacityCv(medium.state);
      protected
        constant Modelica.SIunits.Time timeUnit = 1;
        constant Modelica.SIunits.Temperature Ta = 1;
      equation
        medium.p = 1e5;
        medium.T = Medium.T_min + time/timeUnit*Ta;
      end TestGlycol;
      end Examples;
    end Incompressible;
  end Media;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Library2;

  package Matrices "Library of functions operating on matrices"
    extends Modelica.Icons.Library;

    function leastSquares
    "Solve overdetermined or underdetermined real system of linear equations A*x=b in a least squares sense (A may be rank deficient)"
      extends Modelica.Icons.Function;
      input Real A[:, :] "Matrix A";
      input Real b[size(A, 1)] "Vector b";
      output Real x[size(A, 2)]
      "Vector x such that min|A*x-b|^2 if size(A,1) >= size(A,2) or min|x|^2 and A*x=b, if size(A,1) < size(A,2)";


  protected
      Integer info;
      Integer rank;
      Real xx[max(size(A,1),size(A,2))];
    algorithm
      (xx,info,rank) := LAPACK.dgelsx_vec(A, b, 100*Modelica.Constants.eps);
      x := xx[1:size(A,2)];
      assert(info == 0, "Solving an overdetermined or underdetermined linear system of
equations with function \"Matrices.leastSquares\" failed.");
    end leastSquares;

    package LAPACK
    "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
      extends Modelica.Icons.Library;

      function dgelsx_vec
      "Computes the minimum-norm solution to a real linear least squares problem with rank deficient A"

        extends Modelica.Icons.Function;
        input Real A[:, :];
        input Real b[size(A,1)];
        input Real rcond=0.0 "Reciprocal condition number to estimate rank";
        output Real x[max(nrow,ncol)]= cat(1,b,zeros(max(nrow,ncol)-nrow))
        "solution is in first size(A,2) rows";
        output Integer info;
        output Integer rank "Effective rank of A";
    protected
        Integer nrow=size(A,1);
        Integer ncol=size(A,2);
        Integer nx=max(nrow,ncol);
        Integer lwork=max( min(nrow,ncol)+3*ncol, 2*min(nrow,ncol)+1);
        Real work[lwork];
        Real Awork[nrow,ncol]=A;
        Integer jpvt[ncol]=zeros(ncol);
        external "FORTRAN 77" dgelsx(nrow, ncol, 1, Awork, nrow, x, nx, jpvt,
                                    rcond, rank, work, lwork, info);


      end dgelsx_vec;
    end LAPACK;
  end Matrices;

  function exp "Exponential, base e"
    extends baseIcon2;
    input Real u;
    output Real y;


  external "C" y=  exp(u);
  end exp;

  function log "Natural (base e) logarithm (u shall be > 0)"
    extends baseIcon1;
    input Real u;
    output Real y;


  external "C" y=  log(u);
  end log;

  partial function baseIcon1
    "Basic icon for mathematical function with y-axis on left side"

  end baseIcon1;

  partial function baseIcon2
    "Basic icon for mathematical function with y-axis in middle"

  end baseIcon2;
  end Math;

  package Utilities
  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)"
    extends Modelica.Icons.Library;

    package Streams "Read from files and write to files"
      extends Modelica.Icons.Library;

      function error "Print error message and cancel all actions"
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string);
      end error;
    end Streams;
  end Utilities;

  package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Library2;

    final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

    final constant Real R(final unit="J/(mol.K)") = 8.314472
    "Molar gas constant";

    final constant NonSI.Temperature_degC T_zero=-273.15
    "Absolute zero temperature";
  end Constants;

  package Icons "Library of icons"

    partial package Library "Icon for library"

    end Library;

    partial package Library2
    "Icon for library where additional icon elements shall be added"

    end Library2;

    partial model Example "Icon for an example model"

    equation

    end Example;

    partial function Function "Icon for a function"

    end Function;

    partial record Record "Icon for a record"

    end Record;
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Library2;

    package Conversions
    "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Library2;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Library2;

        type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
              final unit="degC")
        "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)";

        type Pressure_bar = Real (final quantity="Pressure", final unit="bar")
        "Absolute pressure in bar";
      end NonSIunits;

      function to_degC "Convert from Kelvin to °Celsius"
        extends ConversionIcon;
        input Temperature Kelvin "Kelvin value";
        output NonSIunits.Temperature_degC Celsius "Celsius value";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
      end to_degC;

      function from_degC "Convert from °Celsius to Kelvin"
        extends ConversionIcon;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
      end from_degC;

      function to_bar "Convert from Pascal to bar"
        extends ConversionIcon;
        input Pressure Pa "Pascal value";
        output NonSIunits.Pressure_bar bar "bar value";
      algorithm
        bar := Pa/1e5;
      end to_bar;

      partial function ConversionIcon "Base icon for conversion functions"
      end ConversionIcon;
    end Conversions;

    type Time = Real (final quantity="Time", final unit="s");

    type Velocity = Real (final quantity="Velocity", final unit="m/s");

    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0);

    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");

    type AbsolutePressure = Pressure (min=0);

    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);

    type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m");

    type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit
        =   "W");

    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0,
        displayUnit="degC")
    "Absolute temperature (use type TemperatureDifference for relative temperatures)";

    type Temperature = ThermodynamicTemperature;

    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");

    type IsothermalCompressibility = Compressibility;

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit
        =      "W/(m.K)");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");

    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");

    type SpecificEntropy = Real (final quantity="SpecificEntropy", final unit=
            "J/(kg.K)");

    type SpecificEnergy = Real (final quantity="SpecificEnergy", final unit=
            "J/kg");

    type SpecificEnthalpy = SpecificEnergy;

    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");

    type DerDensityByPressure = Real (final unit="s2/m2");

    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");

    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");

    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0);

    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);

    type MassFraction = Real (final quantity="MassFraction", final unit="1");

    type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1");
  end SIunits;
end Modelica;
model Modelica_Media_Incompressible_Examples_TestGlycol
 extends Modelica.Media.Incompressible.Examples.TestGlycol;
  annotation(experiment(
    StopTime=1,
    NumberOfIntervals=500,
    Tolerance=0.0001,
    Algorithm="dassl"),uses(Modelica(version="3.1")));
end Modelica_Media_Incompressible_Examples_TestGlycol;
