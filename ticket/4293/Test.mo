within ;
package Test
  package Types
  type Area = Modelica.SIunits.Area(nominal = 10);
  type SpecificHeatCapacity = Modelica.SIunits.SpecificHeatCapacity(nominal = 500);
  type Length = Modelica.SIunits.Length(nominal = 1);
  type ThermalConductivity = Modelica.SIunits.ThermalConductivity(nominal = 1e3);
  type HeatCapacity = Modelica.SIunits.HeatCapacity(nominal = 1e3);
  type Temperature = Modelica.SIunits.Temperature(nominal = 500);
  type Pressure = Modelica.SIunits.Pressure(nominal = 1e7);
  type Density = Modelica.SIunits.Density(nominal = 1e2);
  type Volume = Modelica.SIunits.Volume(nominal = 10);
  type SpecificVolume = Modelica.SIunits.SpecificVolume(nominal = 0.01);
  type MassFlowRate = Modelica.SIunits.MassFlowRate(nominal = 100);
  type HeatFlowRate = Modelica.SIunits.HeatFlowRate(nominal = 1e6);
  type SpecificEnthalpy = SpecificEnergy;
  type SpecificEnergy = Modelica.SIunits.SpecificEnergy(nominal = 1e6);
  type SpecificEntropy = Modelica.SIunits.SpecificEntropy(nominal = 1e3);
  type SpecificHeatCapacityWater = Modelica.SIunits.SpecificHeatCapacity(nominal = 1e3);
  type SpecificHeatCapacityAtConstantPressure =
      Modelica.SIunits.SpecificHeatCapacity (                                         nominal = 1e3);
  type SpecificHeatCapacityAtConstantVolume =
      Modelica.SIunits.SpecificHeatCapacity (                                       nominal = 1e3);
  type HeatFlux = Real(final quantity = "HeatFlux", final unit = "W/m2", nominal = 1e4);
  type Stress = Modelica.SIunits.NormalStress(nominal = 1e7);
  type ThermalConductance = Modelica.SIunits.ThermalConductance(nominal = 1e-2);
  type DynamicViscosity = Modelica.SIunits.DynamicViscosity(nominal = 1e-5);
  type Velocity = Modelica.SIunits.Velocity(nominal = 1e3);
  type CoefficientOfHeatTransfer = Modelica.SIunits.CoefficientOfHeatTransfer(nominal = 5000, min = 0);
  type DerSpecificVolumeByPressure = Real(final unit = "m2/s2", nominal = 1e-10);
  type DerSpecificVolumeByTemperature = Real(final unit = "m3/(kg.K)", nominal = 1e-5);
  type DerSpecificVolumeByTemperatureWater = Real(final unit = "m3/(kg.K)", nominal = 1e-5);
  type DerEnergyByPressure = Modelica.SIunits.DerEnergyByPressure(nominal = 1e-2);
  type DerPressureByTemperature = Modelica.SIunits.DerPressureByTemperature(nominal = 1e5);
  type Power = Modelica.SIunits.Power(nominal = 1e7);
  type ReynoldsNumber = Modelica.SIunits.ReynoldsNumber(nominal = 1e5);
  type NusseltNumber = Modelica.SIunits.NusseltNumber(nominal = 100);
  type PrandtlNumber = Modelica.SIunits.PrandtlNumber(nominal = 10);
  type PressureRatio = Real(final quantity = "PressureRatio", final unit = "1", nominal = 2);
  type Mass = Modelica.SIunits.Mass(nominal = 1e3);
  type Energy = Modelica.SIunits.Energy(nominal = 1e6);
  type MolarMass = Modelica.SIunits.MolarMass(nominal = 0.0440095);

  type Temp_C = Modelica.SIunits.Conversions.NonSIunits.Temperature_degC;
  end Types;

  model fluids_property_plot_10e_5
     import Test.Types.*;
    //Reference parameters for adimensionalization
    constant Pressure p_crit = 7.377e6;
    constant Temperature T_crit = 304.13;
    constant SpecificVolume v_crit = 94.07e-6 / MM;
    constant SpecificHeatCapacityWater R = Modelica.Constants.R / MM "Specific gas constant";
    constant MolarMass MM = 0.0440095;
    //Start parameters
    parameter Pressure p_start = 1e7;
    parameter Temperature T_start = 600;
    parameter SpecificVolume v_start = R * T_start / p_start;
    parameter Real r_mu_start = rc_mu / (1 + Q1_mu * ((p_start / p_crit * T_start / T_crit) ^ 0.5 - 1)) ^ 2;
    parameter Real c_mu_start = b_mu * (exp(Q2_mu * (T_start / T_crit) ^ 0.5 - 1) + Q3_mu * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
    //Constants of the correlations
    parameter Types.SpecificVolume b = 0.077796074 * R * T_crit / p_crit;
    parameter Real w = 0.228 "acentric factor 0.225";
    parameter Real m = 0.37464 + 1.54226 * w - 0.26992 * w ^ 2;
    parameter Real ac = 0.45723553 * R ^ 2 * T_crit ^ 2 / p_crit;
    parameter Real mu_crit = 7.7 * T_crit ^ (-1 / 6) * (MM * 1e3) ^ 0.5 * (p_crit / 1e5) ^ (2 / 3);
    parameter Real rc_mu = mu_crit * T_crit / (p_crit / 1e5) / (p_crit * v_crit / R / T_crit);
    parameter Real Q1_mu = 0.829599 + 0.350857 * w - 0.747680 * w ^ 2;
    parameter Real Q2_mu = 1.94546 - 3.19777 * w + 2.80193 * w ^ 2;
    parameter Real Q3_mu = 0.299757 - 2.20855 * w + 6.64959 * w ^ 2;
    parameter Real a_mu = 0.457233553 * rc_mu ^ 2 * (p_crit / 1e5) ^ 2 / T_crit;
    parameter Real b_mu = 0.077796074 * rc_mu * (p_crit / 1e5) / T_crit;
    parameter Real a_k = 0.45724 * rc_k ^ 2 * (p_crit / 1e5) ^ 2 / T_crit;
    parameter Real b_k = 0.07780 * rc_k * (p_crit / 1e5) / T_crit;
    parameter Real rc_k = k_crit * T_crit / (p_crit / 1e5) / (p_crit * v_crit / R / T_crit);
    parameter Real k_crit = T_crit ^ (-1 / 6) * (MM * 1e3) ^ (-0.5) * (p_crit / 1e5) ^ (2 / 3) / 21;
    parameter Real Q1_k = 0.929163;
    parameter Real Q2_k = 0.012330;
    parameter Real Q3_k = 0.433261;
    parameter Real Q4_k = -0.054170;
    parameter Pressure p = 120e5;
    Temperature T;
    parameter Real A = 273.14;
    parameter Real B = 400;

    //Coefficients of the correlations
    Real r_mu(start = r_mu_start, nominal = 1);
    Real c_mu(start = c_mu_start, nominal = 1e2);

    parameter Real r_k_start = rc_k / (1 - Q1_k * (1 - (p_start / p_crit) ^ 0.5)) ^ 2;
    parameter Real c_k_start = b_k * (1 + Q2_k * (T_start / T_crit - 1) ^ 0.0125 + Q3_k * (T_start / T_crit - 1) ^ 1.75 + Q4_k * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
    Real T1;

    DynamicViscosity mu(start = 10e-5) "Dynamic viscosity";

  equation
  //Coefficients
    T = (B - A) * time + A;
    T1=T-273.14;

    r_mu = rc_mu / (1 + Q1_mu * ((p / p_crit * T / T_crit) ^ 0.5 - 1)) ^ 2;
    c_mu = b_mu * (exp(Q2_mu * (T / T_crit) ^ 0.5 - 1) + Q3_mu * ((p / p_crit) ^ 0.5 - 1) ^ 2);
    T = r_mu * (p *1e-5) / (mu * 1e7 - c_mu) - a_mu / (mu * 1e7 * (mu * 1e7 + b_mu) + b_mu * (mu * 1e7 - b_mu));
    //T * (mu * 1e7 - c_mu) * (mu * 1e7 * (mu * 1e7 + b_mu) + b_mu * (mu * 1e7 - b_mu)) = r_mu * (p / 1e5) * (mu * 1e7 * (mu * 1e7 + b_mu) + b_mu * (mu * 1e7 - b_mu)) - a_mu * (mu * 1e7 - c_mu);
  end fluids_property_plot_10e_5;

  annotation (uses(Modelica(version="3.2.2")));
end Test;
