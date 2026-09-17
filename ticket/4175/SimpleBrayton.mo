package SimpleBrayton
  package Substances
    model CO2
      import SimpleBrayton.Types.*;
      //Reference parameters for adimensionalization
      constant Pressure p_crit = 7.377e6;
      constant Temperature T_crit = 304.13;
      constant SpecificVolume v_crit = 94.07e-6 / MM;
      constant SpecificHeatCapacityWater R = Modelica.Constants.R / MM;
      constant Real MM = 0.0440095;
      constant Temperature T0 = 350 "Reference temperature for uinf, sinf = 0";
      parameter Boolean Calculate_trans = true "Used to decide if it is necessary to calculate the transport properties";
      constant SpecificVolume v0 = 0.009 "Reference specific volume for s";
      parameter SpecificEnthalpy u0 = R * (((-alow[1]) + T0 * (blow[1] + alow[2] * log(T0) + T0 * (1. * alow[3] + T0 * (0.5 * alow[4] + T0 * (1 / 3 * alow[5] + T0 * (0.25 * alow[6] + 0.2 * alow[7] * T0)))))) / T0);
      parameter SpecificEntropy s0 = R * ((-0.5 * alow[1] / (T0 * T0)) - alow[2] / T0 + alow[3] * log(T0) + T0 * (alow[4] + T0 * (0.5 * alow[5] + T0 * (1 / 3 * alow[6] + 0.25 * alow[7] * T0))));
      //Start parameters
      parameter Pressure p_start = 1e7;
      parameter Temperature T_start = 600;
      parameter SpecificVolume v_start = R * T_start / p_start;
      //parameter Types.SpecificVolume v_start = (R * T_start - p_start * b + sqrt(13 * p_start ^ 2 * b ^ 2 - 10 * p_start * b * R * T_start - 4 * a_start * p_start)) / 2 / p_start;
      parameter Density d_start = 1 / v_start;
      parameter SpecificEnergy uinf_start = (-u0) + R * (((-alow[1]) + T_start * (blow[1] + alow[2] * log(T_start) + T_start * (1. * alow[3] + T_start * (0.5 * alow[4] + T_start * (1 / 3 * alow[5] + T_start * (0.25 * alow[6] + 0.2 * alow[7] * T_start)))))) / T_start);
      parameter SpecificEnergy u_start = uinf_start + ku_start / (b * 2 ^ 0.5) * log((v_start - b * (1 + 2 ^ 0.5)) / (v_start - b * (1 - 2 ^ 0.5)));
      parameter SpecificEnthalpy h_start = u_start + p_start * v_start;
      parameter SpecificHeatCapacityAtConstantVolume cvinf_start = R * (1 / (T_start * T_start) * (alow[1] + T_start * (alow[2] + T_start * (1. * alow[3] + T_start * (alow[4] + T_start * (alow[5] + T_start * (alow[6] + alow[7] * T_start)))))));
      parameter SpecificHeatCapacityAtConstantVolume cv_start = cvinf_start + kcv_start / (b * 2 ^ 1.5) * log((v_start + b * (1 - 2 ^ 0.5)) / (v_start + b * (1 + 2 ^ 0.5)));
      parameter SpecificHeatCapacityAtConstantPressure cp_start = cv_start - T_start * dp_dT_start ^ 2 * dv_dp_start;
      parameter SpecificEntropy sinf_start = s0 + R * ((-0.5 * alow[1] / (T0 * T0)) - alow[2] / T0 + alow[3] * log(T0) + T0 * (alow[4] + T0 * (0.5 * alow[5] + T0 * (1 / 3 * alow[6] + 0.25 * alow[7] * T0))));
      parameter SpecificEntropy s_start = sinf_start + R * log((v_start - b) / v0) - ks_start / (b * 2 ^ 1.5) * log((v_start + b * (1 - 2 ^ 0.5)) / (v_start + b * (1 + 2 ^ 0.5)));
      parameter Velocity c_start = v_start * sqrt(-cp_start / cv_start / dv_dp_start);
      parameter SpecificHeatCapacityAtConstantPressure du_dT_start = cp_start + p_start * dp_dT_start * dv_dp_start;
      parameter DerEnergyByPressure du_dp_start = -(T_start * dp_dT_start * dv_dp_start + p_start * dv_dp_start);
      parameter DerPressureByTemperature dp_dT_start = R / (v_start - b) + m * ac / (T_start * T_crit) ^ 0.5 * (1 + m * (1 + (T_start / T_crit) ^ 0.5)) / (v_start * (v_start + b) + b * (v_start - b));
      parameter DerSpecificVolumeByPressure dv_dp_start = 1 / ((-R * T_start / (v_start - b) ^ 2) + 2 * a_start * (v_start + b) / (v_start * (v_start + b) + b * (v_start - b)) ^ 2);
      parameter DerSpecificVolumeByTemperature dv_dT_start = -dv_dp_start * dp_dT_start;
      parameter Real a_start = ac * (1 + m * (1 - (T_start / T_crit) ^ 0.5)) ^ 2;
      parameter Real ku_start = ac * (1 + m * (1 - (T_start / T_crit) ^ 0.5)) * (1 + m);
      parameter Real kcv_start = ac * m * (1 + m) / 2 / (T_start * T_crit) ^ 0.5;
      parameter Real ks_start = -ac * m / (T_start * T_crit) ^ 0.5 * (1 + m * (1 - (T_start / T_crit) ^ 0.5));
      parameter Real r_mu_start = rc_mu / (1 + Q1_mu * ((p_start / p_crit * T_start / T_crit) ^ 0.5 - 1)) ^ 2;
      parameter Real c_mu_start = b_mu * (exp(Q2_mu * (T_start / T_crit) ^ 0.5 - 1) + Q3_mu * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
      parameter Real r_k_start = rc_k / (1 - Q1_k * (1 - (p_start / p_crit) ^ 0.5)) ^ 2;
      parameter Real c_k_start = b_k * (1 + Q2_k * (T_start / T_crit - 1) ^ 0.0125 + Q3_k * (T_start / T_crit - 1) ^ 1.75 + Q4_k * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
      //Constants of the correlations
      parameter Types.SpecificVolume b = 0.077796074 * R * T_crit / p_crit;
      parameter Real w = 0.228 "acentric factor 0.225";
      parameter Real m = 0.37464 + 1.54226 * w - 0.26992 * w ^ 2;
      parameter Real[7] alow = {49436.5054, -626.411601, 4.30172524, 0.002503813816, -2.127308728e-007, -7.68998878e-010, 2.849677801e-013} "5.30172524";
      parameter Real[2] blow = {-45281.9846, -7.04827944};
      parameter Real ac = 0.45723553 * R ^ 2 * T_crit ^ 2 / p_crit;
      parameter Real mu_crit = 7.7 * T_crit ^ (-1 / 6) * (MM * 1e3) ^ 0.5 * (p_crit / 1e5) ^ (2 / 3);
      //parameter Real mu_crit = 2.73864e2;
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
      //Variables
      Pressure p(start = p_start);
      input Temperature T(start = T_start);
      input SpecificVolume v(start = v_start);
      Density d(start = d_start);
      SpecificEnergy uinf(start = uinf_start);
      SpecificEnergy u(start = u_start);
      SpecificEnthalpy h(start = h_start);
      SpecificHeatCapacityAtConstantVolume cvinf(start = cvinf_start);
      SpecificHeatCapacityAtConstantVolume cv(start = cv_start);
      SpecificHeatCapacityAtConstantPressure cp(start = cp_start);
      SpecificEntropy sinf(start = sinf_start);
      SpecificEntropy s(start = s_start);
      Velocity c(start = c_start) "Celerity of the fluid";
      DynamicViscosity mu(start = 8e-5) "Dynamic viscosity";
      ThermalConductance k(start = 0.06) "Thermal Conductivity";
      DerPressureByTemperature dp_dT(start = dp_dT_start) "Temperature derivative of Pressure at constant specific volume";
      DerSpecificVolumeByPressure dv_dp(start = dv_dp_start) "Pressure derivative of specific volume at constant Temperature";
      DerSpecificVolumeByTemperature dv_dT(start = dv_dT_start) "Temperature derivative of specific volume at constant pressure";
      SpecificHeatCapacityAtConstantPressure du_dT(start = du_dT_start) "Temperature derivative of Internal Energy at constant Pressure";
      DerEnergyByPressure du_dp(start = du_dp_start) "Pressure derivative of Internal Energy at constant Temperature";
      //Coefficients of the correlations
      Real a(start = a_start, nominal = 1e1);
      Real ku(start = ku_start, nominal = 1.5e2) "ku = a - T * a'";
      Real kcv(start = kcv_start, nominal = 2e-1) "kcv = - T * a''";
      Real ks(start = ks_start, nominal = 1e-1) "ks = a'";
      Real r_mu(start = r_mu_start, nominal = 1e3);
      Real c_mu(start = c_mu_start, nominal = 1e2);
      Real r_k(start = r_k_start, nominal = 1e-1);
      Real c_k(start = c_k_start, nominal = 1e-2);
    equation
//Coefficients
      a = ac * (1 + m * (1 - (T / T_crit) ^ 0.5)) ^ 2;
      ku = ac * (1 + m * (1 - (T / T_crit) ^ 0.5)) * (1 + m);
      kcv = -ac * m * (1 + m) / 2 / (T * T_crit) ^ 0.5;
      ks = -ac * m / (T * T_crit) ^ 0.5 * (1 + m * (1 - (T / T_crit) ^ 0.5));
      if Calculate_trans == true then
        r_mu = rc_mu / (1 + Q1_mu * ((p / p_crit * T / T_crit) ^ 0.5 - 1)) ^ 2;
        c_mu = b_mu * (exp(Q2_mu * (T / T_crit) ^ 0.5 - 1) + Q3_mu * ((p / p_crit) ^ 0.5 - 1) ^ 2);
        r_k = rc_k / (1 - Q1_k * (1 - (p / p_crit) ^ 0.5)) ^ 2;
        c_k = b_k * (1 + Q2_k * (T / T_crit - 1) ^ 0.0125 + Q3_k * (T / T_crit - 1) ^ 1.75 + Q4_k * ((p / p_crit) ^ 0.5 - 1) ^ 2);
      else
        r_mu = 0;
        c_mu = 0;
        r_k = 0;
        c_k = 0;
      end if;
//Thermodynamic quantities
      p = R * T / (v - b) - a / (v * (v + b) + b * (v - b));
      d = 1 / v;
      uinf = (-u0) + R * (((-alow[1]) + T * (blow[1] + alow[2] * log(T) + T * (1. * alow[3] + T * (0.5 * alow[4] + T * (1 / 3 * alow[5] + T * (0.25 * alow[6] + 0.2 * alow[7] * T)))))) / T);
      sinf = (-s0) + R * ((-0.5 * alow[1] / (T * T)) - alow[2] / T + alow[3] * log(T) + T * (alow[4] + T * (0.5 * alow[5] + T * (1 / 3 * alow[6] + 0.25 * alow[7] * T))));
      u = uinf + ku / (b * 2 ^ 1.5) * log((v + b * (1 - 2 ^ 0.5)) / (v + b * (1 + 2 ^ 0.5)));
      h = u + p * v;
      s = sinf + R * log((v - b) / v0) + ks / (b * 2 ^ 1.5) * log((v + b * (1 + 2 ^ 0.5)) / (v + b * (1 - 2 ^ 0.5)));
//h = u + p * v + 28000 * log(p / p_crit) * (T_crit / T) ^ 4 "Added corrective term to improve accuracy near the critical point";
//s = sinf + R * log((v - b) / v0) + ks / (b * 2 ^ 1.5) * log((v + b * (1 + 2 ^ 0.5)) / (v + b * (1 - 2 ^ 0.5))) + 98 * log(p / p_crit) * (T_crit / T) ^ 4 "Added corrective term to improve accuracy near the critical point";
      cvinf = R * (1 / (T * T) * (alow[1] + T * (alow[2] + T * (1. * alow[3] + T * (alow[4] + T * (alow[5] + T * (alow[6] + alow[7] * T)))))));
      cv = cvinf + kcv / (b * 2 ^ 1.5) * log((v + b * (1 - 2 ^ 0.5)) / (v + b * (1 + 2 ^ 0.5)));
      dp_dT = R / (v - b) + m * ac / (T * T_crit) ^ 0.5 * (1 + m * (1 + (T / T_crit) ^ 0.5)) / (v * (v + b) + b * (v - b));
      dv_dp = 1 / ((-R * T / (v - b) ^ 2) + 2 * a * (v + b) / (v * (v + b) + b * (v - b)) ^ 2);
      dv_dT = -dv_dp * dp_dT;
      cp = cv - T * dp_dT ^ 2 * dv_dp;
      c = v * sqrt(-cp / cv / dv_dp);
      du_dT = cp + p * dp_dT * dv_dp;
      du_dp = -(T * dp_dT * dv_dp + p * dv_dp);
      if Calculate_trans == true then
        T = r_mu * (p / 1e5) / (mu * 1e7 - c_mu) - a_mu / (mu * 1e7 * (mu * 1e7 + b_mu) + b_mu * (mu * 1e7 - b_mu));
        T = r_k * (p / 1e5) / (k - c_k) - a_k / (k * (k + b_k) + b_k * (k - b_k));
      else
        mu = 0;
        k = 0;
      end if;
      annotation(Documentation(info = "<HTML>
  <p>Model of the CO2 fluid using:
  <p>the Peng-Robinson equation of state in its implicit form,
  <p>a temperature correlation for the cv at low pressure taken from the ideal gas library of Modelica.Media,
  <p>viscosity and thermal conductivity are obtained using equations with a form similar to the Peng-Robinson equation of state.
  </HTML>"));
    end CO2;

    model WaterLiquid
      //Start parameters
      parameter Boolean Calculate_trans = true "Used to decide if it is necessary to calculate the transport properties";
      parameter Types.Pressure p_start = 101325;
      parameter Types.Temperature T_start = 300;
      //parameter Types.Pressure p_sat_start = ;
      parameter Types.Density d_start = (((+1.48186e-005) * T_start + (-0.0177278)) * T_start + 6.36275) * T_start + 283.08;
      parameter Types.DerSpecificVolumeByTemperatureWater dv_dT_start = -(((+1.48186e-005 * 3) * T_start + (-0.0177278) * 2) * T_start + 6.36275) / d_start ^ 2;
      parameter Types.SpecificEnthalpy u_start = (((+0.00393447) * T_start + (-3.7185)) * T_start + 5350.25) * T_start + (-1.26407e+006);
      parameter Real du_dT_start = ((+0.00393447) * 3 * T_start + (-3.7185) * 2) * T_start + 5350.25;
      parameter Types.SpecificEnthalpy h_start = u_start + p_start / d_start;
      //Variables
      input Types.Pressure p(start = p_start);
      input Types.Temperature T(start = T_start);
      //Types.Pressure p_sat(start = p_sat_start);
      Types.Density d(start = d_start) "Density of the fluid";
      Types.DerSpecificVolumeByTemperatureWater dv_dT(start = dv_dT_start) "Temperature derivative of specific volume at constant pressure";
      parameter Real dv_dp = 0 "Pressure derivative of specific volume at constant Temperature";
      Types.SpecificEnthalpy u(start = u_start) "Specific Internal Energy of the fluid";
      Real du_dT(start = du_dT_start) "Temperature derivative of the Specific Internal Energy";
      parameter Real du_dp = 0 "Pressure derivative of the Specific Internal Energy";
      Types.SpecificHeatCapacityWater cp(start = du_dT_start) "Specific heat capacity of the fluid";
      Types.SpecificEnthalpy h(start = h_start) "Specific Enthalpy of the fluid";
      parameter Types.DynamicViscosity mu = 0.001 "Dynamic viscosity";
      parameter Types.ThermalConductance k = 0.62 "Thermal Conductivity";
    equation
//p_sat = ((((+0.000342217) * T + (-0.295484)) * T + 85.5469) * T + (-8298.06)) * T + (-104.079);
      d = (((+1.48186e-005) * T + (-0.0177278)) * T + 6.36275) * T + 283.08;
      dv_dT = -(((+1.48186e-005 * 3) * T + (-0.0177278) * 2) * T + 6.36275) / d ^ 2;
      u = (((+0.00393447) * T + (-3.7185)) * T + 5350.25) * T + (-1.26407e+006);
      du_dT = ((+0.00393447 * 3) * T + (-3.7185) * 2) * T + 5350.25;
      cp = du_dT;
      h = u + p / d;
//assert(p >= p_sat, "This model is valid only if p>=p saturation.\nSaturation pressure is: " + String(p_sat) + "[Pa], while the pressure is: " + String(p) + "[Pa].");
      annotation(Documentation(info = "<HTML>
<p>Liquid Water modeled using polynomial correlations obtained by interpolation of data from IF-97 standard to determine the saturated liquid state as a function of temperature.
<p>From that reference point the water is modeled as an incompressible liquid with the density of the saturated liquid, so it obeys the following equations of state:
<ul>
<li>d(T,p) = d_sat(T)</li>
</ul>
For an incompressible fluid Internal energy os only a function of temperature, so:
<ul>
<li>u(T,p) = u_sat(T)</li>
</ul>
And cp = cv and it defined as the temperature derivative of internal energy.
And to conclude, enthalpy is calculated following the definition:
<ul>
<li>h = u + p / d</li>
</ul>
</HTML>"));
    end WaterLiquid;

    model CO2_old
      extends Modelica.Icons.ObsoleteModel;
      //Reference parameters for adimensionalization
      constant Types.Pressure p_crit = 7.377e6;
      constant Types.Pressure T_crit = 304.13;
      constant Types.Pressure v_crit = 94.07e-6 / MM;
      constant Types.SpecificHeatCapacity R = Modelica.Constants.R / MM;
      constant Real MM = 0.0440095;
      constant Types.Temperature T0 = 350 "Reference temperature for uinf, sinf = 0";
      parameter Boolean Calculate_trans = true "Used to decide if it is necessary to calculate the transport properties";
      parameter Types.SpecificVolume v0 = 0.009 "Reference specific volume for s";
      parameter Types.SpecificEnthalpy u0 = R * (((-alow[1]) + T0 * (blow[1] + alow[2] * log(T0) + T0 * (1. * alow[3] + T0 * (0.5 * alow[4] + T0 * (1 / 3 * alow[5] + T0 * (0.25 * alow[6] + 0.2 * alow[7] * T0)))))) / T0);
      parameter Types.SpecificHeatCapacity s0 = R * ((-0.5 * alow[1] / (T0 * T0)) - alow[2] / T0 + alow[3] * log(T0) + T0 * (alow[4] + T0 * (0.5 * alow[5] + T0 * (1 / 3 * alow[6] + 0.25 * alow[7] * T0))));
      //Start parameters
      parameter Types.Pressure p_start = 1e7;
      parameter Types.Temperature T_start = 600;
      parameter Types.SpecificVolume v_start = R * T_start / p_start;
      //parameter Types.SpecificVolume v_start = (R * T_start - p_start * b + sqrt(13 * p_start ^ 2 * b ^ 2 - 10 * p_start * b * R * T_start - 4 * a_start * p_start)) / 2 / p_start;
      parameter Types.Density d_start = 1 / v_start;
      parameter Types.SpecificEnthalpy uinf_start = (-u0) + R * (((-alow[1]) + T_start * (blow[1] + alow[2] * log(T_start) + T_start * (1. * alow[3] + T_start * (0.5 * alow[4] + T_start * (1 / 3 * alow[5] + T_start * (0.25 * alow[6] + 0.2 * alow[7] * T_start)))))) / T_start);
      parameter Types.SpecificEnthalpy u_start = uinf_start + ku_start / (b * 2 ^ 0.5) * log((v_start - b * (1 + 2 ^ 0.5)) / (v_start - b * (1 - 2 ^ 0.5)));
      parameter Types.SpecificEnthalpy h_start = u_start + p_start * v_start;
      parameter Types.SpecificHeatCapacity cvinf_start = R * (1 / (T_start * T_start) * (alow[1] + T_start * (alow[2] + T_start * (1. * alow[3] + T_start * (alow[4] + T_start * (alow[5] + T_start * (alow[6] + alow[7] * T_start)))))));
      parameter Types.SpecificHeatCapacity cv_start = cvinf_start + kcv_start / (b * 2 ^ 1.5) * log((v_start + b * (1 - 2 ^ 0.5)) / (v_start + b * (1 + 2 ^ 0.5)));
      parameter Types.SpecificHeatCapacity cp_start = cv_start - T_start * dp_dT_start ^ 2 / dp_dv_start;
      parameter Types.SpecificHeatCapacity sinf_start = s0 + R * ((-0.5 * alow[1] / (T0 * T0)) - alow[2] / T0 + alow[3] * log(T0) + T0 * (alow[4] + T0 * (0.5 * alow[5] + T0 * (1 / 3 * alow[6] + 0.25 * alow[7] * T0))));
      parameter Types.SpecificHeatCapacity s_start = sinf_start + R * log((v_start - b) / v0) - ks_start / (b * 2 ^ 1.5) * log((v_start + b * (1 - 2 ^ 0.5)) / (v_start + b * (1 + 2 ^ 0.5)));
      parameter Types.Velocity c_start = v_start * sqrt(-cp_start / cv_start * dp_dv_start);
      parameter Real du_dT_start = cp_start + p_start * dp_dT_start / dp_dv_start;
      parameter Real du_dp_start = -(T_start * dp_dT_start / dp_dv_start + p_start / dp_dv_start);
      parameter Real dp_dT_start = R / (v_start - b) + m * ac / (T_start * T_crit) ^ 0.5 * (1 + m * (1 + (T_start / T_crit) ^ 0.5)) / (v_start * (v_start + b) + b * (v_start - b));
      parameter Real dp_dv_start = (-R * T_start / (v_start - b) ^ 2) + 2 * a_start * (v_start + b) / (v_start * (v_start + b) + b * (v_start - b)) ^ 2;
      parameter Real a_start = ac * (1 + m * (1 - (T_start / T_crit) ^ 0.5)) ^ 2;
      parameter Real ku_start = ac * (1 + m * (1 - (T_start / T_crit) ^ 0.5)) * (1 + m);
      parameter Real kcv_start = ac * m * (1 + m) / 2 / (T_start * T_crit) ^ 0.5;
      parameter Real ks_start = -ac * m / (T_start * T_crit) ^ 0.5 * (1 + m * (1 - (T_start / T_crit) ^ 0.5));
      parameter Real r_mu_start = rc_mu / (1 + Q1_mu * ((p_start / p_crit * T_start / T_crit) ^ 0.5 - 1)) ^ 2;
      parameter Real c_mu_start = b_mu * (exp(Q2_mu * (T_start / T_crit) ^ 0.5 - 1) + Q3_mu * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
      parameter Real r_k_start = rc_k / (1 - Q1_k * (1 - (p_start / p_crit) ^ 0.5)) ^ 2;
      parameter Real c_k_start = b_k * (1 + Q2_k * (T_start / T_crit - 1) ^ 0.0125 + Q3_k * (T_start / T_crit - 1) ^ 1.75 + Q4_k * ((p_start / p_crit) ^ 0.5 - 1) ^ 2);
      //Constants of the correlations
      parameter Types.SpecificVolume b = 0.077796074 * R * T_crit / p_crit;
      parameter Real w = 0.228 "acentric factor 0.225";
      parameter Real m = 0.37464 + 1.54226 * w - 0.26992 * w ^ 2;
      parameter Real[7] alow = {49436.5054, -626.411601, 4.30172524, 0.002503813816, -2.127308728e-007, -7.68998878e-010, 2.849677801e-013} "5.30172524";
      parameter Real[2] blow = {-45281.9846, -7.04827944};
      parameter Real ac = 0.45723553 * R ^ 2 * T_crit ^ 2 / p_crit;
      parameter Real mu_crit = 7.7 * T_crit ^ (-1 / 6) * (MM * 1e3) ^ 0.5 * (p_crit / 1e5) ^ (2 / 3);
      //parameter Real mu_crit = 2.73864e2;
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
      //Variables
      Types.Pressure p(start = p_start);
      input Types.Temperature T(start = T_start);
      input Types.SpecificVolume v(start = v_start);
      Types.Density d(start = d_start);
      Types.SpecificEnthalpy uinf(start = uinf_start);
      Types.SpecificEnthalpy u(start = u_start);
      Types.SpecificEnthalpy h(start = h_start);
      Types.SpecificHeatCapacity cvinf(start = cvinf_start);
      Types.SpecificHeatCapacity cv(start = cv_start);
      Types.SpecificHeatCapacity cp(start = cp_start);
      Types.SpecificHeatCapacity sinf(start = sinf_start);
      Types.SpecificHeatCapacity s(start = s_start);
      Types.Velocity c(start = c_start) "Celerity of the fluid";
      Types.DynamicViscosity mu(start = 8e-5) "Dynamic viscosity";
      Types.ThermalConductance k(start = 0.06) "Thermal Conductivity";
      Real dp_dT(start = dp_dT_start) "Temperature derivative of Pressure at constant Volume";
      Real dp_dv(start = dp_dv_start) "Volume derivative of Pressure at constant Temperature";
      Real du_dT(start = du_dT_start) "Temperature derivative of Internal Energy at constant Pressure";
      Real du_dp(start = du_dp_start) "Pressure derivative of Internal Energy at constant Temperature";
      //Coefficients of the correlations
      Real a(start = a_start);
      Real ku(start = ku_start) "ku = a - T * a'";
      Real kcv(start = kcv_start) "kcv = - T * a''";
      Real ks(start = ks_start) "ks = a'";
      Real r_mu(start = r_mu_start);
      Real c_mu(start = c_mu_start);
      Real r_k(start = r_k_start);
      Real c_k(start = c_k_start);
    equation
//Coefficients
      a = ac * (1 + m * (1 - (T / T_crit) ^ 0.5)) ^ 2;
      ku = ac * (1 + m * (1 - (T / T_crit) ^ 0.5)) * (1 + m);
      kcv = -ac * m * (1 + m) / 2 / (T * T_crit) ^ 0.5;
      ks = -ac * m / (T * T_crit) ^ 0.5 * (1 + m * (1 - (T / T_crit) ^ 0.5));
      if Calculate_trans == true then
        r_mu = rc_mu / (1 + Q1_mu * ((p / p_crit * T / T_crit) ^ 0.5 - 1)) ^ 2;
        c_mu = b_mu * (exp(Q2_mu * (T / T_crit) ^ 0.5 - 1) + Q3_mu * ((p / p_crit) ^ 0.5 - 1) ^ 2);
        r_k = rc_k / (1 - Q1_k * (1 - (p / p_crit) ^ 0.5)) ^ 2;
        c_k = b_k * (1 + Q2_k * (T / T_crit - 1) ^ 0.0125 + Q3_k * (T / T_crit - 1) ^ 1.75 + Q4_k * ((p / p_crit) ^ 0.5 - 1) ^ 2);
      else
        r_mu = 0;
        c_mu = 0;
        r_k = 0;
        c_k = 0;
      end if;
//Thermodynamic quantities
      p = R * T / (v - b) - a / (v * (v + b) + b * (v - b));
      d = 1 / v;
      uinf = (-u0) + R * (((-alow[1]) + T * (blow[1] + alow[2] * log(T) + T * (1. * alow[3] + T * (0.5 * alow[4] + T * (1 / 3 * alow[5] + T * (0.25 * alow[6] + 0.2 * alow[7] * T)))))) / T);
      u = uinf + ku / (b * 2 ^ 1.5) * log((v + b * (1 - 2 ^ 0.5)) / (v + b * (1 + 2 ^ 0.5)));
      h = u + p * v;
      cvinf = R * (1 / (T * T) * (alow[1] + T * (alow[2] + T * (1. * alow[3] + T * (alow[4] + T * (alow[5] + T * (alow[6] + alow[7] * T)))))));
      cv = cvinf + kcv / (b * 2 ^ 1.5) * log((v + b * (1 - 2 ^ 0.5)) / (v + b * (1 + 2 ^ 0.5)));
      dp_dT = R / (v - b) + m * ac / (T * T_crit) ^ 0.5 * (1 + m * (1 + (T / T_crit) ^ 0.5)) / (v * (v + b) + b * (v - b));
      dp_dv = (-R * T / (v - b) ^ 2) + 2 * a * (v + b) / (v * (v + b) + b * (v - b)) ^ 2;
      cp = cv - T * dp_dT ^ 2 / dp_dv;
      sinf = s0 + R * ((-0.5 * alow[1] / (T * T)) - alow[2] / T + alow[3] * log(T) + T * (alow[4] + T * (0.5 * alow[5] + T * (1 / 3 * alow[6] + 0.25 * alow[7] * T))));
      s = sinf + R * log((v - b) / v0) - ks / (b * 2 ^ 1.5) * log((v + b * (1 - 2 ^ 0.5)) / (v + b * (1 + 2 ^ 0.5)));
      c = v * sqrt(-cp / cv * dp_dv);
      du_dT = cp + p * dp_dT / dp_dv;
      du_dp = -(T * dp_dT / dp_dv + p / dp_dv);
      if Calculate_trans == true then
        T = r_mu * (p / 1e5) / (mu * 1e7 - c_mu) - a_mu / (mu * 1e7 * (mu * 1e7 + b_mu) + b_mu * (mu * 1e7 - b_mu));
        T = r_k * (p / 1e5) / (k - c_k) - a_k / (k * (k + b_k) + b_k * (k - b_k));
      else
        mu = 0;
        k = 0;
      end if;
    end CO2_old;
  end Substances;

  package Connectors
    connector FlangeA "A-type flange connector for gas flows"
      Types.Pressure p(start = 1e5) "Pressure";
      flow Types.MassFlowRate w "Mass flowrate";
      stream Types.SpecificEnthalpy h "Specific Enthalpy of the fluid";
      annotation(Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
<p> Must always be connected to a single type-B connector <tt>FlangeB</tt>.
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
    end FlangeA;

    connector FlangeB "B-type flange connector for gas flows"
      Types.Pressure p(start = 1e5) "Pressure";
      flow Types.MassFlowRate w "Mass flowrate";
      stream Types.SpecificEnthalpy h "Specific Enthalpy of the fluid";
      annotation(Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-42, 44}, {44, -40}}, lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
<p> Must always be connected to a single type-A connector <tt>FlangeA</tt>.
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
    end FlangeB;

    connector HeatPort "Thermal port for 1-dim. heat transfer (filled rectangular icon)"
      Types.Temperature T "Port temperature";
      flow Types.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
      annotation(defaultComponentName = "port", Documentation(info = "<HTML>
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
<b>icon layout</b>.</p></HTML>
"), Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}), Diagram(graphics = {Rectangle(extent = {{-50, 50}, {50, -50}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-120, 120}, {100, 60}}, lineColor = {191, 0, 0}, textString = "%name")}));
    end HeatPort;

    connector MultiHeatPort
      parameter Integer n(min = 1) = 3;
      Types.Temperature T[n] "Port temperature";
      flow Types.HeatFlowRate Q_flow[n] "Heat flow rate (positive if flowing from outside into the component)";
      annotation(defaultComponentName = "MultiPort", Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {255, 238, 44}, fillColor = {255, 238, 44}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end MultiHeatPort;

    connector PowerConnection "Electrical power connector"
      flow SimpleBrayton.Types.Power W "Active power";
      Modelica.SIunits.Frequency f "Frequency";
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}})}));
    end PowerConnection;
  end Connectors;

  package Components
    package Gas
      model Finite_volume
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.Tube;
        import SimpleBrayton.Types.*;
        //Parameters
        parameter Pressure p_start = 101325 "Pressure start value of outgoing gas";
        parameter Temperature T_start = 300 "Temperature start value of outgoing gas";
        parameter Temperature Tm_start = 300 "Metal wall start temperature";
        parameter Volume V = 1 "Volume of the finite element";
        parameter ThermalConductance G = 1 "Thermal Conductance between wall and fluid";
        //Other models
        SimpleBrayton.Connectors.HeatPort wall(T(start = Tm_start)) annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-72, -1.33227e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Substances.CO2 gas_in;
        SimpleBrayton.Substances.CO2 gas_out(p_start = p_start, T_start = T_start);
        Temperature Tmean(start = T_start);
      equation
        V * der(gas_out.d) = inlet.w + outlet.w "Mass Balance";
        V * der(gas_out.ud) = inlet.w * gas_in.h + outlet.w * gas_out.h + wall.Q_flow "Energy Balance";
        inlet.p = outlet.p "Momentum Balance";
        Tmean = (gas_out.T + gas_in.T) / 2;
//Boundary Conditions
        inlet.p = gas_in.p;
        outlet.p = gas_out.p;
        inlet.h = gas_in.h;
        outlet.h = gas_out.h;
        wall.Q_flow = G * (wall.T - Tmean);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Finite_volume;

      model Pipe_Nvolumes
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.Tube;
        import SimpleBrayton.Types.*;
        //Parameters
        parameter Integer N(min = 1) = 3 "Number of finite volumes in the pipe";
        parameter Boolean Direction = true "Used to set parallel or countercurrent heat exchanger";
        parameter Pressure p_start = 101325 "Pressure start value of outgoing gas";
        parameter Temperature T_start = 300 "Temperature start value of outgoing gas";
        parameter Temperature Tm_start = 300 "Metal wall start temperature";
        parameter Volume V = 1 "Volume of the finite element";
        parameter ThermalConductance G = 1 "Thermal Conductance between wall and fluid";
        //Other models
        SimpleBrayton.Connectors.MultiHeatPort wall(N = N) annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-72, -1.33227e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Components.Finite_volume node[N](each p_start = p_start, each T_start = T_start, each Tm_start = Tm_start, each V = V / N, each G = G / N) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(node[N].outlet, outlet) annotation(Line(points = {{10, 10}, {100, 10}, {100, 12}, {100, 12}}, color = {159, 159, 223}));
        connect(inlet, node[1].inlet) annotation(Line(points = {{-100, 0}, {-10, 0}, {-10, 10}, {-10, 10}}, color = {159, 159, 223}));
        if not N == 1 then
          for i in 1:N - 1 loop
            connect(node[i].outlet, node[i + 1].inlet);
          end for;
        end if;
        if Direction == true then
          for i in 1:N loop
            connect(node[i].wall, wall.hp[i]);
          end for;
        else
          for i in 1:N loop
            connect(node[i].wall, wall.hp[N + 1 - i]);
          end for;
        end if;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Pipe_Nvolumes;

      model Source_MassFlow
        extends SimpleBrayton.Icons.Gas.SourceW;
        import SimpleBrayton.Types.*;
        replaceable model Medium = SimpleBrayton.Substances.CO2 "Fluid model";
        parameter Pressure p_start = 7e6;
        parameter Temperature T0 = 500 "Nominal temperature and starting value for fluid";
        parameter MassFlowRate w0 = 0 "Nominal mass flowrate";
        parameter Boolean use_in_w = false "Use connector input for the nominal flow rate" annotation(Dialog(group = "External inputs"), choices(checkBox = true));
        parameter Boolean use_in_T = false "Use connector input for the temperature" annotation(Dialog(group = "External inputs"), choices(checkBox = true));
        Modelica.Blocks.Interfaces.RealInput in_w if use_in_w annotation(Placement(transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation(Placement(transformation(origin = {0, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Medium fluid(T_start = T0, p_start = p_start, Calculate_trans = false);
      protected
        Modelica.Blocks.Interfaces.RealInput in_w_internal;
        Modelica.Blocks.Interfaces.RealInput in_T_internal;
      equation
        outlet.w = -in_w_internal;
        if use_in_w == false then
          in_w_internal = w0 "Flow rate set by parameter";
        end if;
        fluid.T = in_T_internal;
        if use_in_T == false then
          in_T_internal = T0 "Flow rate set by parameter";
        end if;
        fluid.p = outlet.p;
        fluid.h = outlet.h;
// Connect protected connectors to public conditional connectors
        connect(in_w, in_w_internal);
        connect(in_T, in_T_internal);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Source_MassFlow;

      model Sink_Pressure
        extends SimpleBrayton.Icons.Gas.SourceP;
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        parameter SimpleBrayton.Types.Pressure p0 = 8e6 "Pressure of the reservoir";
      equation
        inlet.p = p0;
        inlet.h = inStream(inlet.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Sink_Pressure;

      model FlowSplit
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.FlowSplit;
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet1 annotation(Placement(visible = true, transformation(origin = {60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet2 annotation(Placement(visible = true, transformation(origin = {60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        inlet.w + outlet1.w + outlet2.w = 0 "Mass Balance";
        outlet1.p = inlet.p;
        outlet2.p = inlet.p;
        outlet1.h = inlet.h;
        outlet2.h = inlet.h;
        inlet.h = inStream(inlet.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end FlowSplit;

      model FlowJoin
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.FlowJoin;
        constant Types.MassFlowRate wzero = 1e-100 "Small flowrate to avoid singularity in computing the outlet enthalpy";
        SimpleBrayton.Connectors.FlangeA inlet1 annotation(Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeA inlet2 annotation(Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        inlet1.w + inlet2.w + outlet.w = 0 "Mass Balance";
        inlet1.p = outlet.p;
        inlet2.p = outlet.p;
        outlet.w * outlet.h + inlet1.w * inlet1.h + inlet2.w * inlet2.h = 0 "Energy Balance";
        inlet1.h = inStream(inlet1.h);
        inlet2.h = inStream(inlet2.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end FlowJoin;

      model SensT
        extends SimpleBrayton.Icons.Gas.SensThrough;
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealOutput T annotation(Placement(visible = true, transformation(origin = {66, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        replaceable SimpleBrayton.Substances.CO2 gas;
      equation
        inlet.w + outlet.w = 0 "Mass Balance";
        inlet.p = outlet.p "Momentum Balance";
        inlet.h = outlet.h "Energy Balance";
        gas.p = outlet.p;
        gas.h = outlet.h;
        T = gas.T;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {3, 63}, fillPattern = FillPattern.Solid, extent = {{37, -43}, {-43, 37}}, textString = "T")}));
      end SensT;

      partial model CompressorBase
        extends SimpleBrayton.Icons.Gas.Compressor;
        import SimpleBrayton.Types.*;
        parameter Temperature Tin_start = 500;
        parameter Temperature Tout_start = 500;
        parameter Pressure pin_start = 1e7;
        parameter Pressure pout_start = 2.5e7;
        constant Real fr = 50 "Rated frequency of rotation of the compressor";
        parameter Real eta_mec = 0.95 "Mechanic efficiency of the compressor";
        Real eta_is "Isoentropic efficiency of the compressor";
        PressureRatio beta(start = beta_start) "Compression ratio of the compressor";
        Real alpha(start = 1) "Reduced rotation speed of the compressor";
        Real phic(start = 1) "Reduced mass flow of the compresssor";
        PressureRatio beta_surge(start = 3) "Reduced mass flow at the onset of surge conditions at given beta and alfa";
        PressureRatio beta_choke(start = 2) "Reduced mass flow at the onset of choke conditions at given beta and alfa";
        Velocity cr "Rated Fluid velocity";
        Density dr "Rated fluid density";
        Power W "Electric work consumed by the compressor";
        constant Pressure pr = 7.71e6 "Rated pressure";
        constant Temperature Tr = 344.05 "Rated Temperature";
        constant MassFlowRate wr = 50.2 "Rated flow rate";
        parameter PressureRatio beta_start = pout_start / pin_start;
        SimpleBrayton.Substances.CO2 gas_in(T_start = Tin_start, p_start = pin_start, Calculate_trans = false);
        SimpleBrayton.Substances.CO2 gas_out(T_start = Tout_start, p_start = pin_start * beta_start, Calculate_trans = false);
        SimpleBrayton.Substances.CO2 gas_out_is(T_start = Tout_start, p_start = pin_start * beta_start, Calculate_trans = false);
        SimpleBrayton.Substances.CO2 gas_rated(p = pr, T = Tr, Calculate_trans = false);
        SimpleBrayton.Connectors.FlangeA inlet(w(start = wr)) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.PowerConnection shaft_r annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.PowerConnection shaft_l annotation(Placement(visible = true, transformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        inlet.w + outlet.w = 0 "Mass balance";
        inlet.w * gas_in.h + outlet.w * gas_out.h + W / eta_mec = 0 "Energy Balance";
        beta = outlet.p / inlet.p;
        gas_out_is.p = gas_out.p;
        gas_out_is.s = gas_in.s;
        gas_out.h - gas_in.h = (gas_out_is.h - gas_in.h) / eta_is;
        cr = gas_rated.c;
        dr = gas_rated.d;
        phic = inlet.w / wr * dr / gas_in.d * cr / gas_in.c;
        alpha = shaft_r.f / fr * cr / gas_in.c;
//assert(beta > beta_surge, "Compressor is in surge conditions");
//assert(beta < beta_choke, "Compressor is in choke conditions");
//Boundary Conditions
        inlet.p = gas_in.p;
        inlet.h = gas_in.h;
        inlet.h = inStream(inlet.h);
        outlet.p = gas_out.p;
        outlet.h = gas_out.h;
        shaft_r.f = shaft_l.f;
        W = shaft_l.W + shaft_r.W;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end CompressorBase;

      model TurbineStodola
        extends SimpleBrayton.Icons.Gas.Turbine;
        import SimpleBrayton.Types.*;
        parameter Temperature Tin_start = 926.175;
        parameter Temperature Tout_start = 804.55;
        parameter Pressure pin_start = 19.38e6;
        parameter Pressure pout_start = 7.85e6;
        parameter Real beta_nom = pin_start / pout_start;
        parameter Real eta_is = 0.95 "Isoentropic efficiency of the compressor";
        parameter Real eta_mec = 0.95 "Mechanic efficiency of the compressor";
        parameter Real K = 121 * sqrt(926.175) / 19.38e6 / sqrt(1 - (1 / beta_nom) ^ 2) "Stodola's constant";
        PressureRatio beta(start = beta_nom) "Expansion ratio of the turbine";
        Real omega_r(nominal = 1e1) "Reduced rotation speed of the turbine";
        Real w_r(nominal = 1e-4) "Reduced mass flow of the turbine";
        Power W "Electric work produced by the turbine";
        SimpleBrayton.Substances.CO2 gas_in(T_start = Tin_start, p_start = pin_start, Calculate_trans = false);
        SimpleBrayton.Substances.CO2 gas_out(T_start = Tout_start, p_start = pout_start, Calculate_trans = false);
        SimpleBrayton.Substances.CO2 gas_out_is(T_start = Tout_start * eta_is, p_start = pout_start, Calculate_trans = false);
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.PowerConnection shaft_r annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.PowerConnection shaft_l annotation(Placement(visible = true, transformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        inlet.w + outlet.w = 0 "Mass balance";
        inlet.w * gas_in.h + outlet.w * gas_out.h - W / eta_mec = 0 "Energy Balance";
        beta = inlet.p / outlet.p;
        omega_r = 2 * Modelica.Constants.pi * shaft_r.f / sqrt(gas_in.T);
        w_r = inlet.w * sqrt(gas_in.T) / gas_in.p;
        w_r = K * sqrt(1 - (1 / beta) ^ 2);
        gas_out_is.p = gas_out.p;
        gas_out_is.s = gas_in.s;
        gas_in.h - gas_out.h = (gas_in.h - gas_out_is.h) * eta_is;
//Boundary Conditions
        inlet.p = gas_in.p;
        inlet.h = gas_in.h;
        inlet.h = inStream(inlet.h);
        outlet.p = gas_out.p;
        outlet.h = gas_out.h;
        shaft_r.f = shaft_l.f;
        W = (-shaft_l.W) - shaft_r.W;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end TurbineStodola;

      model MainCompressor
        import SimpleBrayton.Types.*;
        extends SimpleBrayton.Components.Gas.CompressorBase(pr = 7.63e6, Tr = 304.84, wr = 70.2, Tin_start = 304.84, Tout_start = 341.896, pin_start = 7.63e6, pout_start = 19.95e6);
        //constant Real[9] a = {720.728076914302, -3986.04015380345, 9422.179870308, -11050.9671320317, 6426.7395599241, -1483.3745708877, -102.105389096937, 74.2880747014444, -18.9059661610773} "Coefficients for the evaluation of beta";
        parameter Real[9] a = {720.905, -3986.04015380345, 9422.179870308, -11050.9671320317, 6426.7395599241, -1483.3745708877, -102.105389096937, 74.2880747014444, -18.9059661610773} "Coefficients for the evaluation of beta";
        constant Real[10] b = {-5.77734913130572, -3.37860121187737, 21.9618689787914, -2.96821742813167, -26.57750566104, 12.452558055192, 1.76401739337081, 7.78804862952719, -0.504358660919303, -3.84884662297963} "Coefficients for the evaluation of eta";
        constant Real[3] c = {2.49050747739479, 1.70534224553784, -0.415526765631501} "Coefficients for the evaluation of surge line";
        constant Real[3] d = {-170.561540420571, 175.399534423353, 470.002106445143} "Coefficients for the evaluation of choke line";
      equation
        beta = a[1] + a[2] * phic + a[3] * phic ^ 2 + a[4] * phic ^ 3 + a[5] * phic ^ 4 + a[6] * phic ^ 5 + a[7] / alpha + a[8] / alpha ^ 2 + a[9] / alpha ^ 3;
        eta_is = b[1] + b[2] / phic + b[3] / alpha + b[4] / phic ^ 2 + b[5] / alpha ^ 2 + b[6] / (phic * alpha) + b[7] / phic ^ 3 + b[8] / alpha ^ 3 + b[9] / (phic * alpha ^ 2) + b[10] / (phic ^ 2 * alpha);
        beta_surge = c[1] + c[2] * phic ^ 2 + c[3] / phic ^ 1.5;
        beta_choke = d[1] + d[2] * log(phic) + d[3] * exp(-phic);
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-9, 27}, fillPattern = FillPattern.Solid, extent = {{-15, 5}, {31, -53}}, textString = "M")}));
      end MainCompressor;

      model ReCompressor
        import SimpleBrayton.Types.*;
        extends SimpleBrayton.Components.Gas.CompressorBase(pr = 7.64e6, Tr = 351.886, wr = 50.2, Tin_start = 351.886, Tout_start = 429.3, pin_start = 7.64e6, pout_start = 19.94e6);
        //constant Real[10] a = {-34.70067392, -134.2006404, 232.7570231, 177.9735814, -214.8473184, -28.8697102, -45.56461559, 53.47492136, 55.69294656, -59.0911049} "Coefficients of evaluation of beta";
        parameter Real[10] a = {-34.65, -134.2006404, 232.7570231, 177.9735814, -214.8473184, -28.8697102, -45.56461559, 53.47492136, 55.69294656, -59.0911049} "Coefficients of evaluation of beta";
        //constant Real[10] b = {0.995390724, -2.780998141, -4.395201492, 5.363774413, -14.04444752, 1.637855727, -2.674997295, -11.02106154, 8.842725263, 2.891681599} "Coefficients of evaluation of eta";
        constant Real[10] b = {1.083390724, -2.780998141, -4.395201492, 5.363774413, -14.04444752, 1.637855727, -2.674997295, -11.02106154, 8.842725263, 2.891681599} "Coefficients of evaluation of eta";
        constant Real[3] c = {-25.393308057238, -26.1765222168528, 20.187546048544} "Coefficients for the evaluation of surge line";
        constant Real[3] d = {13.6811822187673, 12.7017670390261, -4.43344082330522} "Coefficients for the evaluation of choke line";
      equation
        beta = a[1] + a[2] * phic + a[3] / alpha + a[4] * phic ^ 2 + a[5] / alpha ^ 2 + a[6] * phic / alpha + a[7] * phic ^ 3 + a[8] / alpha ^ 3 + a[9] * phic / alpha ^ 2 + a[10] * phic ^ 2 / alpha;
        eta_is = b[1] + b[2] * phic + b[3] * log(alpha) + b[4] * phic ^ 2 + b[5] * log(alpha) ^ 2 + b[6] * phic * log(alpha) + b[7] * phic ^ 3 + b[8] * log(alpha) ^ 3 + b[9] * phic * log(alpha) ^ 2 + b[10] * phic ^ 2 * log(alpha);
        beta_surge = c[1] + c[2] * phic ^ 2 + c[3] * exp(phic);
        beta_choke = d[1] + d[2] * phic * log(phic) + d[3] * exp(phic);
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-9, 27}, fillPattern = FillPattern.Solid, extent = {{-15, 5}, {31, -53}}, textString = "R")}));
      end ReCompressor;

      model Plenum
        extends SimpleBrayton.Icons.Gas.SourceP;
        parameter SimpleBrayton.Types.Pressure p = 7.64e6;
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        inlet.p = p;
        outlet.p = p;
        inlet.h = outlet.h;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Plenum;

      model Valve
        extends SimpleBrayton.Icons.Gas.Valve;
        Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput w(min = 0) annotation(Placement(visible = true, transformation(origin = {-4, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
        inlet.w + outlet.w = 0 "Mass Balance";
        inlet.h = outlet.h "Energy Balance";
        w = inlet.w;
        inlet.h = inStream(inlet.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
      end Valve;

      model Pipe
        extends SimpleBrayton.Icons.Gas.Tube;
        import SimpleBrayton.Types.*;
        replaceable model HeatTransferModel = SimpleBrayton.Components.Thermal.Gnielinski "Heat transfer model";
        replaceable model Medium = SimpleBrayton.Substances.CO2 "Fluid model";
        //Parameters
        parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
        parameter Boolean fix[n + 1] = cat(1, fill(false, 1), fill(initialized, n));
        parameter Integer n(min = 1) = 3 "Number of finite volumes in the heat exchanger";
        parameter Pressure pout_start = 8e6 "Pressure start value of outgoing fluid";
        //parameter Pressure p_start[n + 1] = cat(1, ones(1) * (pout_start + k * w_start), ones(n) * pout_start);
        parameter Temperature Tin_start = 500 "Temperature start value of fluid at the start of the heat exchanger";
        parameter Temperature Tout_start = 500 "Temperature start value of fluid at the end of the heat exchanger";
        parameter Temperature T_start[n + 1] = linspace(Tin_start, Tout_start, n + 1);
        //parameter Temperature Tmean_start[n] = linspace((T_start[1] + T_start[2]) / 2, (T_start[n] + T_start[n + 1]) / 2, n);
        //parameter Temperature Tm_start = 500 "Metal wall start temperature";
        parameter Modelica.SIunits.Length Di = 0.002 "Idraulic diameter of each pipe";
        parameter Modelica.SIunits.Length L = 2 "Length of each pipe";
        parameter Modelica.SIunits.Length wp = 0.008283185 "Wet perimeter of each pipe";
        parameter Real m = 70000 "Number of parallel pipes";
        parameter Modelica.SIunits.Area A = Modelica.Constants.pi * Di ^ 2 / 8 "Passage section of each pipe";
        parameter Modelica.SIunits.Area S = L * wp "Total surface of the walls of each pipe of the heat exchanger";
        parameter Modelica.SIunits.Area Si = S / n "Surface of the wall of each pipe of the finite volume";
        parameter Volume V = A * L * m "Total volume of the heat exchanger";
        parameter Volume Vi = V / n "Volume of one finite element";
        parameter Real k = 500 "Coefficient for the calculation of the pressure loss across the heat exchanger";
        parameter MassFlowRate w_start = 100;
        //Other models
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-72, -1.33227e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Medium fluid[n + 1](T(fixed = fix), T_start = T_start, each p_start = pout_start);
        HeatTransferModel HeatTransfer[n](each Lc = Di, each A = A, each S = Si, each m = m ", Tmean_start = Tmean_start");
        //Variables
        MassFlowRate w[n + 1](each min = 0, each start = w_start) "Mass flow at each interface, positive if from inlet to outlet";
        Mass Mi[n] "Mass of fluid in each finite volume";
        //Real dMi[n] "Variation of the mass of fluid in each finite volume";
        //Real dEi[n] "Variation of the energy contained in each finite volume";
        Temperature T[n + 1] "Temperature of each instance of fluid";
        Pressure p(start = pout_start, fixed = initialized) "Pressure of each instance of fluid";
        SimpleBrayton.Connectors.MultiHeatPort wall(n = n) annotation(Placement(visible = true, transformation(origin = {-1.77636e-15, 50.5}, extent = {{-42, -10.5}, {42, 10.5}}, rotation = 0), iconTransformation(origin = {-3.55271e-15, 51}, extent = {{-44, -11}, {44, 11}}, rotation = 0)));
      equation
        T[1] = fluid[1].T;
        fluid[1].p = p;
  for i in 1:n loop
          Mi[i] = Vi * fluid[i + 1].d;
          w[i] - w[i + 1] = -Vi * fluid[i + 1].d ^ 2 * (fluid[i + 1].dv_dT * der(fluid[i + 1].T) + fluid[i + 1].dv_dp * der(fluid[i + 1].p)) "Mass Balance";
//dMi[i] = -Vi * fluid[i + 1].d ^ 2 * (fluid[i + 1].dv_dT * der(fluid[i + 1].T) + fluid[i + 1].dv_dp * der(fluid[i + 1].p)) "Mass Balance";
//dMi[i] = w[i] - w[i + 1] "Mass Balance";
          fluid[i + 1].p = p "Momentum Balance";
          w[i] * fluid[i].h - w[i + 1] * fluid[i + 1].h + wall.Q_flow[i] = Mi[i] * (fluid[i + 1].du_dT * der(fluid[i + 1].T) + fluid[i + 1].du_dp * der(fluid[i + 1].p)) + (w[i] - w[i + 1]) * fluid[i + 1].u "Energy Balance";
//dEi[i] = Mi[i] * (fluid[i + 1].du_dT * der(fluid[i + 1].T) + fluid[i + 1].du_dp * der(fluid[i + 1].p)) + dMi[i] * fluid[i + 1].u "Energy Balance";
//dEi[i] = w[i] * fluid[i].h - w[i + 1] * fluid[i + 1].h + wall.Q_flow[i] "Energy Balance";
          HeatTransfer[i].Tmean = (fluid[i].T + fluid[i + 1].T) / 2;
//HeatTransfer[i].Tmean = fluid[i + 1].T;
          HeatTransfer[i].w = w[i + 1];
          HeatTransfer[i].mu = fluid[i + 1].mu;
          HeatTransfer[i].k = fluid[i + 1].k;
          HeatTransfer[i].cp = fluid[i + 1].cp;
          T[i + 1] = fluid[i + 1].T;
          HeatTransfer[i].Q_flow = wall.Q_flow[i];
          HeatTransfer[i].Twall = wall.T[i];
        end for;
        outlet.p = inlet.p - k * inlet.w "Momentum Balance";
//outlet.p = inlet.p "Momentum Balance";
        outlet.p = p;
//Boundary Conditions
        inlet.w = w[1];
        inlet.h = fluid[1].h;
        inlet.h = inStream(inlet.h);
        outlet.w = -w[n + 1];
        outlet.h = fluid[n + 1].h;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4, -65}, fillPattern = FillPattern.Solid, extent = {{-96, 15}, {104, -15}}, textString = "%name")}));
      end Pipe;

      model Heat_Exchanger_old
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.Tube;
        import SimpleBrayton.Types.*;
        //Parameters
        parameter Boolean Direction = true "Used to set parallel or countercurrent heat exchanger";
        parameter Integer n(min = 1) = 3 "Number of finite volumes in the heat exchanger";
        parameter Pressure p_start = 8e6 "Pressure start value of outgoing gas";
        parameter Temperature Tin_start = 500 "Temperature start value of gas at the start of the heat exchanger";
        parameter Temperature Tout_start = 500 "Temperature start value of gas at the end of the heat exchanger";
        parameter Temperature T_start[n + 1] = linspace(Tin_start, Tout_start, n + 1);
        //parameter Temperature Tm_start = 500 "Metal wall start temperature";
        parameter Modelica.SIunits.Length Di = 0.1 "Idraulic diameter of each pipe";
        parameter Modelica.SIunits.Length L = 2 "Length of each pipe";
        parameter Modelica.SIunits.Length wp = 0.1 "Wet perimeter of each pipe";
        parameter Integer m = 100000 "Number of parallel pipes";
        parameter Modelica.SIunits.Area A = Modelica.Constants.pi * Di ^ 2 / 8 "Passage section of each pipe";
        parameter Modelica.SIunits.Area S = L * wp "Total surface of the walls of each pipe of the heat exchanger";
        parameter Modelica.SIunits.Area Si = S / n "Surface of the wall of the finite volume";
        parameter Volume V = A * L * m "Total volume of the heat exchanger";
        parameter Volume Vi = V / n "Volume of one finite element";
        parameter Real k = 900 "Coefficient for the calculation of the pressure loss across the heat exchanger";
        parameter MassFlowRate w_start = 20;
        //Other models
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-72, -1.33227e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.MultiHeatPort wall(n = n) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        SimpleBrayton.Substances.CO2_old gas[n + 1](T_start = T_start, each p_start = p_start);
        replaceable SimpleBrayton.Components.Thermal.Gnielinski HeatTransfer[n](each Lc = Di, each A = A, each S = Si, each m = m, each Tmean_start = (Tin_start + Tout_start) / 2);
        //Variables
        MassFlowRate w[n + 1](each min = 0, each start = w_start) "Mass flow at each interface, positive if from inlet to outlet";
        Real Mi[n] "Mass of gas in each finite volume";
        MassFlowRate dMi[n] "Variation of the mass of gas in each finite volume";
        Real Ei[n] "Energy contained in each finite volume";
        Real dEi[n] "Variation of the energy contained in each finite volume";
        Temperature T[n + 1] "Temperature of each instance of gas";
      equation
        T[1] = gas[1].T;
  for i in 1:n loop
          Mi[i] = Vi * gas[i + 1].d;
          Ei[i] = Mi[i] * gas[i + 1].u;
          dMi[i] = Vi * (gas[i + 1].d ^ 2 / gas[i + 1].dp_dv * (gas[i + 1].dp_dT * der(gas[i + 1].T) - der(gas[i + 1].p))) "Mass Balance";
          dMi[i] = w[i] - w[i + 1] "Mass Balance";
          outlet.p = gas[i + 1].p "Momentum Balance";
          dEi[i] = Mi[i] * (gas[i + 1].du_dT * der(gas[i + 1].T) + gas[i + 1].du_dp * der(gas[i + 1].p)) + dMi[i] * gas[i + 1].u "Energy Balance";
          dEi[i] = w[i] * gas[i].h - w[i + 1] * gas[i + 1].h + HeatTransfer[i].Q_flow "Energy Balance";
//HeatTransfer[i].Tmean = (gas[i].T + gas[i + 1].T) / 2;
          HeatTransfer[i].Tmean = gas[i + 1].T;
          HeatTransfer[i].w = w[i + 1];
          HeatTransfer[i].mu = gas[i + 1].mu;
          HeatTransfer[i].k = gas[i + 1].k;
          HeatTransfer[i].cp = gas[i + 1].cp;
          T[i + 1] = gas[i + 1].T;
          if Direction == true then
            HeatTransfer[i].Q_flow = wall.Q_flow[i];
            HeatTransfer[i].Twall = wall.T[i];
          else
            HeatTransfer[n + 1 - i].Q_flow = wall.Q_flow[i];
            HeatTransfer[n + 1 - i].Twall = wall.T[i];
          end if;
        end for;
        outlet.p = inlet.p - k * inlet.w "Momentum Balance";
//Boundary Conditions
        inlet.w = w[1];
        inlet.p = gas[1].p;
        inlet.h = gas[1].h;
        inlet.h = inStream(inlet.h);
        outlet.w = -w[n + 1];
        outlet.h = gas[n + 1].h;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-4, -65}, fillPattern = FillPattern.Solid, extent = {{-96, 15}, {104, -15}}, textString = "%name")}));
      end Heat_Exchanger_old;

      model Heat_Exchanger
        import SimpleBrayton.Types.*;
        //replaceable model Medium1 = SimpleBrayton.Substances.CO2 "Fluid model on side 1";
        //replaceable model Medium2 = SimpleBrayton.Substances.CO2 "Fluid model on side 2";
        parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
        parameter Integer n(min = 1) = 3 "Number of finite volumes in the heat exchanger";
        parameter Pressure pout_start_cold = 8e6 "Pressure start value of outgoing fluid on side 1 of the heat exchanger";
        parameter Temperature Tin_start_cold = 500 "Temperature start value of fluid at the start of side 1 of the heat exchanger";
        parameter Temperature Tout_start_cold = 500 "Temperature start value of fluid at the end of side 1 of the heat exchanger";
        parameter Temperature T_start_cold[n + 1] = linspace(Tin_start_cold, Tout_start_cold, n + 1);
        parameter Pressure pout_start_hot = 8e6 "Pressure start value of outgoing fluid on side 2 of the heat exchanger";
        parameter Temperature Tin_start_hot = 500 "Temperature start value of fluid at the start of side 2 of the heat exchanger";
        parameter Temperature Tout_start_hot = 500 "Temperature start value of fluid at the end of side 2 of the heat exchanger";
        parameter Temperature T_start_hot[n + 1] = linspace(Tin_start_hot, Tout_start_hot, n + 1);
        parameter Temperature T_start_wall[n] = linspace((T_start_cold[2] + T_start_hot[n + 1]) / 2, (T_start_cold[n + 1] + T_start_hot[2]) / 2, n);
        parameter Real k_cold = 500 "Coefficient for the calculation of the pressure loss across the cold side of the heat exchanger";
        parameter MassFlowRate w_start_cold = 50;
        parameter Real k_hot = 500 "Coefficient for the calculation of the pressure loss across the hot side of the heat exchanger";
        parameter MassFlowRate w_start_hot = 50;
        parameter Modelica.SIunits.Length Di = 0.002 "Idraulic diameter of each pipe";
        parameter Modelica.SIunits.Length L = 2 "Length of each pipe";
        parameter Modelica.SIunits.Length wp = Di * (Modelica.Constants.pi / 2 + 1) "Wet perimeter of each pipe";
        parameter Integer m = 60000 "Number of parallel pipes in the Heat Exchanger";
        parameter Real M = 10000 "Total mass of metal wall";
        parameter SpecificHeatCapacityWater cp_metal = 502 "Specific Heat Capacity of the metal";
        Pipe pipe_hot(n = n, m = m / 2, Di = Di, L = L, wp = wp, pout_start = pout_start_hot, k = k_hot, w_start = w_start_hot, T_start = T_start_hot, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {1.33227e-15, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
        Pipe pipe_cold(n = n, m = m / 2, Di = Di, L = L, wp = wp, pout_start = pout_start_cold, k = k_cold, w_start = w_start_cold, T_start = T_start_cold, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {0, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Thermal.Metalpipes wall(n = n, M = M, cp = cp_metal, T_start = T_start_wall, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {1.33227e-15, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.FlangeB outlet_hot annotation(Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.FlangeA inlet_hot annotation(Placement(visible = true, transformation(origin = {100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.FlangeA inlet_cold annotation(Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{20, 20}, {-20, -20}}, rotation = 0)));
        Connectors.FlangeB outlet_cold annotation(Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        //Temperature T_hot[n + 1];
        //Temperature T_cold[n + 1];
      equation
//T_hot = pipe_hot.fluid.T;
//T_cold = pipe_cold.fluid.T;
        connect(pipe_cold.inlet, inlet_cold) annotation(Line(points = {{-20, -60}, {-100, -60}, {-100, -60}, {-100, -60}}, color = {159, 159, 223}));
        connect(wall.wall1, pipe_cold.wall) annotation(Line(points = {{0, -6}, {0, -6}, {0, -49.8}, {0, -49.8}}, color = {255, 238, 44}));
        connect(wall.wall2, pipe_hot.wall) annotation(Line(points = {{0, 6}, {0, 6}, {0, 49.8}, {0, 49.8}}, color = {255, 238, 44}));
        connect(pipe_cold.outlet, outlet_cold) annotation(Line(points = {{20, -60}, {100, -60}, {100, -60}, {100, -60}}, color = {159, 159, 223}));
        connect(pipe_hot.inlet, inlet_hot) annotation(Line(points = {{20, 60}, {96, 60}, {96, 60}, {100, 60}}, color = {159, 159, 223}));
        connect(pipe_hot.outlet, outlet_hot) annotation(Line(points = {{-20, 60}, {-96, 60}, {-96, 60}, {-100, 60}}, color = {159, 159, 223}));
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(lineColor = {85, 85, 255}, lineThickness = 3, extent = {{-100, 100}, {100, -100}}), Line(origin = {2, 48.99}, points = {{78, 1.01158}, {28, 1.01158}, {-2, 31.0116}, {-2, -28.9884}, {-32, 1.01158}, {-82, 1.01158}}, color = {255, 0, 0}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10), Line(origin = {-4, -51}, points = {{-76, 1}, {-26, 1}, {4, 31}, {4, -29}, {34, 1}, {84, 1}}, color = {0, 0, 255}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10), Text(fillPattern = FillPattern.Solid, extent = {{-80, 20}, {80, -20}}, textString = "%name")}));
      end Heat_Exchanger;

      model SolarCollector_old
        extends Modelica.Icons.ObsoleteModel;
        extends SimpleBrayton.Icons.Gas.Collector;
        parameter Real eta = 0.985 "Heat loss of the solar collector";
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput S annotation(Placement(visible = true, transformation(origin = {0, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1.33227e-15, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
        inlet.w + outlet.w = 0 "Mass Balance";
        inlet.p = outlet.p "Momentum Balance";
        inlet.w * inlet.h + outlet.w * outlet.h + S * eta = 0 "Energy Balance";
        inlet.h = inStream(inlet.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end SolarCollector_old;

      model SolarCollector
        import SimpleBrayton.Types.*;
        extends SimpleBrayton.Icons.Gas.Collector;
        parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
        parameter Integer n(min = 2) = 3 "Number of finite volumes in the solar collector";
        parameter Real eta = 0.985 "Heat loss of the solar collector";
        parameter Pressure pout_start = 19.38e6 "Pressure start value of outgoing fluid on side 1 of the solar collector";
        parameter Temperature Tin_start = 760.09 "Temperature start value of fluid at the start of the solar collector";
        parameter Temperature Tout_start = 926.175 "Temperature start value of fluid at the end of the solar collector";
        parameter Temperature T_start[n + 1] = linspace(Tin_start, Tout_start, n + 1);
        parameter Temperature T_start_wall[n] = linspace(T_start[2] + 20, T_start[n + 1] + 20, n);
        parameter Modelica.SIunits.Length Di = 0.0264 "Idraulic diameter of each pipe";
        parameter Modelica.SIunits.Length L = 18.7 "Length of each pipe";
        parameter Modelica.SIunits.Length wp = Modelica.Constants.pi * Di "Wet perimeter of each pipe";
        parameter Real m = 112 "Number of parallel pipes";
        parameter Real k = 4214.88 "Coefficient for the calculation of the pressure loss across the heat exchanger";
        parameter MassFlowRate w_start = 121;
        parameter Real M = 4303 "Total mass of metal wall";
        parameter SpecificHeatCapacityWater cp_metal = 502 "Specific Heat Capacity of the metal";
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Pipe pipe(n = n, pout_start = pout_start, Tin_start = Tin_start, Tout_start = Tout_start, Di = Di, L = L, wp = wp, m = m, k = k, w_start = w_start, initialized = initialized, T_start = T_start) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Thermal.Metalpipes wall(n = n, M = M, cp = cp_metal, T_start_a = T_start[2] + 20, T_start_b = T_start[n + 1] + 20, initialized = initialized, T_start = T_start_wall) annotation(Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput S annotation(Placement(visible = true, transformation(origin = {0, 82}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {1.33227e-15, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        Thermal.Wall_inputQ wall_inputQ(n = n) annotation(Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(wall_inputQ.S, S) annotation(Line(points = {{0, 54}, {0, 54}, {0, 82}, {0, 82}}, color = {0, 0, 127}));
        connect(wall.wall2, wall_inputQ.multiport) annotation(Line(points = {{0, 33}, {0, 33}, {0, 50}, {0, 50}}, color = {255, 238, 44}));
        connect(pipe.wall, wall.wall1) annotation(Line(points = {{0, 5.1}, {0, 5.1}, {0, 27}, {0, 27}}, color = {255, 238, 44}));
        connect(pipe.outlet, outlet) annotation(Line(points = {{10, 0}, {98, 0}, {98, 0}, {100, 0}}, color = {159, 159, 223}));
        connect(pipe.inlet, inlet) annotation(Line(points = {{-10, 0}, {-98, 0}, {-98, 0}, {-100, 0}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Documentation(info = "<HTML>
<p>Instead of explicitely calculating the thermal losses between the absorbing plate and the sorrounding air, the thermal losses are accountend by a constant efficiency factor on the incoming solar radiation.
<p>This choice is justified since collected heat is proportional to the total surface of the mirrors, while the losses are proportional to the surface of the absorbing plate. Given the high concentration factor of this configuration the losses are very small compared to the absorbed heat and their value doesn't change significantly with the temperature of the plate.
</HTML>"));
      end SolarCollector;

      model Sink_MassFlow
        extends SimpleBrayton.Icons.Gas.SourceW;
        import SimpleBrayton.Types.*;
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput in_w annotation(Placement(transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      equation
        inlet.w = in_w;
        inlet.h = inStream(inlet.h);
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Sink_MassFlow;

      package Parametrized_Components
        model Precooler
          extends SimpleBrayton.Components.Gas.Heat_Exchanger(pipe_cold(redeclare model Medium = SimpleBrayton.Substances.WaterLiquid, p(fixed = false)), L = 1.715, pout_start_cold = 110000, Tin_start_cold = 295, Tout_start_cold = 330, w_start_cold = 100, m = 63290, M = 2676.7, cp_metal = 530, k_cold = 142.450, k_hot = 142.450, w_start_hot = 70.2, Tin_start_hot = 342.99, Tout_start_hot = 304.84, pout_start_hot = 7.63e6);
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end Precooler;

        model LTRecuperator
          extends SimpleBrayton.Components.Gas.Heat_Exchanger(Di = 0.002, L = 2.00, m = 128990, M = 11738, cp_metal = 502, k_hot = 826.446, k_cold = 142.450, w_start_cold = 70.2, w_start_hot = 121, pout_start_cold = 19.94e6, Tin_start_cold = 342, Tout_start_cold = 429.3, pout_start_hot = 7.64e6, Tin_start_hot = 436.34, Tout_start_hot = 342.99);
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end LTRecuperator;

        model HTRecuperator
          extends SimpleBrayton.Components.Gas.Heat_Exchanger(Di = 0.002, L = 2.625, m = 173780, M = 20755, cp_metal = 502, k_hot = 909.091, k_cold = 413.223, w_start_cold = 121, w_start_hot = 121, pout_start_cold = 19.89e6, Tin_start_cold = 429.3, Tout_start_cold = 760.09, pout_start_hot = 7.74e6, Tin_start_hot = 804.55, Tout_start_hot = 436.34);
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end HTRecuperator;

        model HTRecuperator_sHT
          extends SimpleBrayton.Components.Gas.Heat_Exchanger(pipe_cold(redeclare model HeatTransferModel = SimpleBrayton.Components.Thermal.PowerLawMassFlow(each w0 = 120.765, each h0 = 3448.06, each gamma = 0.80)), pipe_hot(redeclare model HeatTransferModel = SimpleBrayton.Components.Thermal.PowerLawMassFlow(each w0 = 120.765, each h0 = 2927.35, each gamma = 0.79)), Di = 0.002, L = 2.625, m = 173780, M = 20755, cp_metal = 502, k_hot = 909.091, k_cold = 413.223, w_start_cold = 121, w_start_hot = 121, pout_start_cold = 19.89e6, Tin_start_cold = 429.3, Tout_start_cold = 760.09, pout_start_hot = 7.74e6, Tin_start_hot = 804.55, Tout_start_hot = 436.34);
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end HTRecuperator_sHT;

        model SolarCollector_sHT
          extends SimpleBrayton.Components.Gas.SolarCollector(pipe(redeclare model HeatTransferModel = SimpleBrayton.Components.Thermal.PowerLawMassFlow(each w0 = 120.765, each h0 = 7215.68)));
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
        end SolarCollector_sHT;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Parametrized_Components;
    end Gas;

    package Thermal
      partial model BasicHeatTransfer
        import SimpleBrayton.Types.*;
        Temperature Twall "Temperature of the wall for each finite volume";
        Temperature Tmean "Mean temperature of the gas in each finite volume";
        HeatFlowRate Q_flow "Heat flow entering through the wall of the finite volume";
        MassFlowRate w "Mass flow exiting the finite volume";
        DynamicViscosity mu "Dynamic viscosity of the fluid";
        ThermalConductance k "Themal conductance of the fluid";
        SpecificHeatCapacityAtConstantPressure cp " Specific heat capacity at constant pressure of the fluid";
        CoefficientOfHeatTransfer h(start = 2000) "Coefficient of convective heat exchange";
        parameter Temperature Tmean_start = 500;
        parameter Modelica.SIunits.Length Lc "Characteristic Lenght for the heat transfer";
        parameter Modelica.SIunits.Area A "Passage section of the mass flow in each pipe";
        parameter Modelica.SIunits.Area S "Surface of the wall of each pipe in the finite volume";
        parameter Real m "Number of parallel pipes";
        //Dimensionless Numbers
        Real Re(start = 1e5) "Reynolds Number";
        Real Pr(start = 1) "Prandtl Number";
        Real Nu(start = 120) "Nusselt Number";
      equation
        Re = w / m * Lc / mu / A;
        Pr = mu * cp / k;
        Nu = h * Lc / k;
        Q_flow = h * S * (Twall - Tmean) * m;
      end BasicHeatTransfer;

      model IdealHeatTransfer
        extends SimpleBrayton.Components.Thermal.BasicHeatTransfer;
      equation
        Twall = Tmean;
      end IdealHeatTransfer;

      model DittusBolter
        extends BasicHeatTransfer;
        parameter Boolean Heating = true;
      equation
        if Heating then
          Nu = 0.023 * Re ^ 0.8 * Pr ^ 0.4;
        else
          Nu = 0.023 * Re ^ 0.8 * Pr ^ 0.3;
        end if;
      end DittusBolter;

      model ConstantConductance
        extends BasicHeatTransfer;
        parameter Real hconst = 4000;
      equation
        h = hconst;
      end ConstantConductance;

      model Gnielinski
        extends BasicHeatTransfer;
        Real f(start = 0.02);
      equation
        f = (0.79 * log(Re) - 1.64) ^ (-2);
//f = (1.82 * (log(1e6) + (Re - 1e6) / 1e6 - (Re - 1e6) ^ 2 / 1e6 ^ 2 / 2) - 1.64) ^ 2;
        Nu = f / 8 * (Re - 1000) * Pr / (1 + 12.7 * (f / 8) ^ 0.5 * (Pr ^ (2 / 3) - 1));
      end Gnielinski;

      model Wall_FixedT
        parameter Integer n = 3;
        parameter Real Twall = 500;
        SimpleBrayton.Connectors.MultiHeatPort MultiPort(n = n) annotation(Placement(visible = true, transformation(origin = {2.22045e-15, -2.22045e-15}, extent = {{-40, -40}, {40, 40}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Types.HeatFlowRate Qtot;
      equation
        for i in 1:n loop
          MultiPort.T[i] = Twall;
        end for;
        Qtot = sum(MultiPort.Q_flow);
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-48, 10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Backward, extent = {{-12, -10}, {108, 10}})}));
      end Wall_FixedT;

      model Metalpipes
        import SimpleBrayton.Types.*;
        extends SimpleBrayton.Icons.MetalWall;
        parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
        parameter Integer n(min = 1) = 3 "Number of finite elements in the metal wall";
        parameter Real M = 10000 "Total mass of metal wall";
        parameter SpecificHeatCapacityWater cp = 502 "Specific Heat Capacity of the metal";
        parameter Real Ci = M * cp / n "Heat capacity of each finite element of the metal wall";
        parameter Temperature T_start_a = 500 "Starting Temperature for the first finite element of the metal wall";
        parameter Temperature T_start_b = 500 "Starting Temperature for the last finite element of the metal wall";
        parameter Temperature T_start[n] = linspace(T_start_a, T_start_b, n) "Starting Temperature for each finite element of the metal wall";
        Temperature T[n](start = T_start, each fixed = initialized) "Temperature of each finite element of the metal wall";
        SimpleBrayton.Connectors.MultiHeatPort wall2(n = n) annotation(Placement(visible = true, transformation(origin = {0, 30}, extent = {{-40, -10}, {40, 10}}, rotation = 0), iconTransformation(origin = {0, 30}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        SimpleBrayton.Connectors.MultiHeatPort wall1(n = n) annotation(Placement(visible = true, transformation(origin = {0, -30}, extent = {{-40, -10}, {40, 10}}, rotation = 0), iconTransformation(origin = {0, -30}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
      equation
        for i in 1:n loop
          Ci * der(T[i]) = wall1.Q_flow[i] + wall2.Q_flow[n + 1 - i] "Energy Balance";
//boundary Conditions
          T[i] = wall1.T[i];
          wall1.T[i] = wall2.T[n + 1 - i];
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Metalpipes;

      model SolarCollectorWall
        extends Modelica.Icons.ObsoleteModel;
        import SimpleBrayton.Types.*;
        parameter Integer n(min = 1) = 3 "Number of finite elements in the metal wall";
        parameter Integer m(min = 1) = 100 "Number of pipes";
        parameter ThermalConductance k = 1000 "Thermal conductivity of the metal";
        parameter Real L = 15 "Lenght of a single pipe";
        parameter Real ri = 0.02 "Internal radius of the pipe";
        parameter Real re = 0.03 "External radius of the pipe";
        Real G "Thermal conductance for a single finite element";
        Temperature T_ext[n] "Temperature of the external wall";
        SimpleBrayton.Connectors.MultiHeatPort wall_a(n = n) annotation(Placement(visible = true, transformation(origin = {0, 30}, extent = {{-40, -10}, {40, 10}}, rotation = 0), iconTransformation(origin = {0, 30}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput S annotation(Placement(visible = true, transformation(origin = {0, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {1.33227e-15, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      equation
        G = 2 * Modelica.Constants.pi * L * k / log(re / ri) * m / n;
        for i in 1:n loop
          wall_a.Q_flow[i] + S / n = 0 "Energy Balance";
          wall_a.Q_flow[i] = (wall_a.T[i] - T_ext[i]) * G;
        end for;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.VerticalCylinder, extent = {{-80, 20}, {80, -20}})}));
      end SolarCollectorWall;

      model Wall_inputQ
        parameter Integer n = 3;
        SimpleBrayton.Connectors.MultiHeatPort multiport(n = n) annotation(Placement(visible = true, transformation(origin = {2.22045e-15, -2.22045e-15}, extent = {{-40, -40}, {40, 40}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput S annotation(Placement(visible = true, transformation(origin = {0, 60}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {1.33227e-15, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      equation
        for i in 1:n loop
          multiport.Q_flow[i] = -S / n;
        end for;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-48, 10}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Backward, extent = {{-12, -10}, {108, 10}}), Text(origin = {1, 71}, fillPattern = FillPattern.Solid, extent = {{-21, 9}, {19, -11}}, textString = "Q_flow")}));
      end Wall_inputQ;

      model PowerLawMassFlow
        extends SimpleBrayton.Components.Thermal.BasicHeatTransfer;
        parameter SimpleBrayton.Types.CoefficientOfHeatTransfer h0 = 4000 "Reference coeffcient of heat transfer";
        parameter SimpleBrayton.Types.MassFlowRate w0 = 121 "reference mass flow";
        parameter Real gamma = 0.84 "Coefficient of the power law";
      equation
        h = h0 * (w / w0) ^ gamma;
      end PowerLawMassFlow;
    end Thermal;

    package Electrical
      model Grid
        parameter Real f = 50 "Frequency of the electrical grid";
        SimpleBrayton.Connectors.PowerConnection connection annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      equation
        connection.f = f;
        annotation(Diagram(graphics), Icon(graphics = {Line(points = {{18, -16}, {2, -38}}, color = {0, 0, 0}), Line(points = {{-72, 0}, {-40, 0}}, color = {0, 0, 0}), Ellipse(extent = {{100, -68}, {-40, 68}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-40, 0}, {-6, 0}, {24, 36}, {54, 50}}, color = {0, 0, 0}), Line(points = {{24, 36}, {36, -6}}, color = {0, 0, 0}), Line(points = {{-6, 0}, {16, -14}, {40, -52}}, color = {0, 0, 0}), Line(points = {{18, -14}, {34, -6}, {70, -22}}, color = {0, 0, 0}), Line(points = {{68, 18}, {36, -4}, {36, -4}}, color = {0, 0, 0}), Ellipse(extent = {{-8, 2}, {-2, -4}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{20, 38}, {26, 32}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{52, 54}, {58, 48}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{14, -12}, {20, -18}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{66, 22}, {72, 16}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{32, -2}, {38, -8}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{38, -50}, {44, -56}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{66, -18}, {72, -24}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{0, -34}, {6, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
      end Grid;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Electrical;

    package Water
      model WaterHeatExchanger
        extends SimpleBrayton.Icons.Water.Tube;
        import SimpleBrayton.Types.*;
        //Parameters
        parameter Boolean Direction = true "Used to set parallel or countercurrent heat exchanger";
        parameter Integer n(min = 1) = 3 "Number of finite volumes in the heat exchanger";
        parameter Pressure p_start = 101325 "Pressure start value of outgoing water";
        parameter Temperature Tin_start = 310 "Temperature start value of gas at the start of the heat exchanger";
        parameter Temperature Tout_start = 130 "Temperature start value of gas at the end of the heat exchanger";
        parameter Temperature T_start[n + 1] = linspace(Tin_start, Tout_start, n + 1);
        //parameter Temperature Tm_start = 310 "Metal wall start temperature";
        parameter Modelica.SIunits.Length Di = 0.1 "Idraulic diameter of each pipe";
        parameter Modelica.SIunits.Length L = 2 "Length of each pipe";
        parameter Modelica.SIunits.Length wp = 0.1 "Wet perimeter of each pipe";
        parameter Integer m = 100000 "Number of parallel pipes";
        parameter Modelica.SIunits.Area A = Modelica.Constants.pi * Di ^ 2 / 8 "Passage section of each pipe";
        parameter Modelica.SIunits.Area S = L * wp "Total surface of the walls of each pipe of the heat exchanger";
        parameter Modelica.SIunits.Area Si = S / n "Surface of the wall of the finite volume";
        parameter Volume V = A * L * m "Total volume of the heat exchanger";
        parameter Volume Vi = V / n "Volume of one finite element";
        parameter MassFlowRate w_start = 20;
        //Other models
        SimpleBrayton.Connectors.MultiHeatPort wall(n = n) annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
        replaceable SimpleBrayton.Substances.WaterLiquid water[n + 1](T_start = T_start, each p_start = p_start);
        replaceable SimpleBrayton.Components.Thermal.Gnielinski HeatTransfer[n](each Lc = Di, each A = A, each S = Si, each m = m, each Tmean_start = (Tin_start + Tout_start) / 2);
        //Variables
        MassFlowRate w[n + 1](each min = 0, each start = w_start) "Mass flow at each interface, positive if from inlet to outlet";
        Real Mi[n] "Mass of water in each finite volume";
        Real Ei[n] "Energy contained in each finite volume";
        Real dEi[n] "Variation of the energy contained in each finite volume";
        SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-72, -1.33227e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
        SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 1.75315e-16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Temperature T[n + 1] "Temperature of each instance of gas";
      equation
        T[1] = water[1].T;
  for i in 1:n loop
          Mi[i] = Vi * water[i + 1].d;
          Ei[i] = Mi[i] * water[i + 1].u;
          0 = w[i] - w[i + 1] "Mass Balance";
          water[i].p = water[i + 1].p "Momentum Balance";
          dEi[i] = Vi * water[i + 1].d * water[i + 1].cp * der(water[i + 1].T) "Energy Balance";
          dEi[i] = w[i] * water[i].h - w[i + 1] * water[i + 1].h + HeatTransfer[i].Q_flow "Energy Balance";
          HeatTransfer[i].Tmean = (water[i].T + water[i + 1].T) / 2;
//HeatTransfer[i].Tmean = water[i + 1].T;
          HeatTransfer[i].w = w[i + 1];
          HeatTransfer[i].mu = water[i + 1].mu;
          HeatTransfer[i].k = water[i + 1].k;
          HeatTransfer[i].cp = water[i + 1].cp;
          T[i + 1] = water[i + 1].T;
          if Direction == true then
            HeatTransfer[i].Q_flow = wall.Q_flow[i];
            HeatTransfer[i].Twall = wall.T[i];
          else
            HeatTransfer[n + 1 - i].Q_flow = wall.Q_flow[i];
            HeatTransfer[n + 1 - i].Twall = wall.T[i];
          end if;
        end for;
//Boundary Conditions
        inlet.w = w[1];
        inlet.p = water[1].p;
        inlet.h = water[1].h;
        inlet.h = inStream(inlet.h);
        outlet.w = -w[n + 1];
        outlet.p = water[n + 1].p;
        outlet.h = water[n + 1].h;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Text(origin = {-2, -58}, fillPattern = FillPattern.Solid, extent = {{-78, 18}, {82, -12}}, textString = "%name")}));
      end WaterHeatExchanger;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Water;
  end Components;

  package Types
    type Temperature = Modelica.SIunits.Temperature(nominal = 500);
    type Pressure = Modelica.SIunits.Pressure(nominal = 1e7);
    type Density = Modelica.SIunits.Density(nominal = 100);
    type Volume = Modelica.SIunits.Volume(nominal = 1);
    type SpecificVolume = Modelica.SIunits.SpecificVolume(nominal = 0.01);
    type MassFlowRate = Modelica.SIunits.MassFlowRate(nominal = 100);
    type HeatFlowRate = Modelica.SIunits.HeatFlowRate(nominal = 1e6);
    type SpecificEnthalpy = SpecificEnergy;
    type SpecificEnergy = Modelica.SIunits.SpecificEnergy(nominal = 1e6);
    type SpecificEntropy = Modelica.SIunits.SpecificEntropy(nominal = 1e2);
    type SpecificHeatCapacityWater = Modelica.SIunits.SpecificHeatCapacity(nominal = 4.1e3);
    type SpecificHeatCapacityAtConstantPressure = Modelica.SIunits.SpecificHeatCapacity(nominal = 2e4);
    type SpecificHeatCapacityAtConstantVolume = Modelica.SIunits.SpecificHeatCapacity(nominal = 9e2);
    type HeatFlux = Real(final quantity = "HeatFlux", final unit = "W/m2", nominal = 1e4);
    type Stress = Modelica.SIunits.NormalStress(nominal = 1e7);
    type ThermalConductance = Modelica.SIunits.ThermalConductance(nominal = 6e-2);
    type DynamicViscosity = Modelica.SIunits.DynamicViscosity(nominal = 1e-5);
    type Velocity = Modelica.SIunits.Velocity(nominal = 500);
    type CoefficientOfHeatTransfer = Modelica.SIunits.CoefficientOfHeatTransfer(nominal = 5000, min = 0);
    type DerSpecificVolumeByPressure = Real(final unit = "m2/s2", nominal = 1e-9);
    type DerSpecificVolumeByTemperature = Real(final unit = "m3/(kg.K)", nominal = 1e-4);
    type DerSpecificVolumeByTemperatureWater = Real(final unit = "m3/(kg.K)", nominal = 3e-7);
    type DerEnergyByPressure = Modelica.SIunits.DerEnergyByPressure(nominal = 4e-2);
    type DerPressureByTemperature = Modelica.SIunits.DerPressureByTemperature(nominal = 3e5);
    type Power = Modelica.SIunits.Power(nominal = 1e7);
    type ReynoldsNumber = Modelica.SIunits.ReynoldsNumber(nominal = 1e5);
    type NusseltNumber = Modelica.SIunits.NusseltNumber(nominal = 100);
    type PrandtlNumber = Modelica.SIunits.PrandtlNumber(nominal = 10);
    type PressureRatio = Real(final quantity = "PressureRatio", final unit = "1", nominal = 2);
    type Mass = Modelica.SIunits.Mass(nominal = 3);
    type Energy = Modelica.SIunits.Energy(nominal = 1e6);
  end Types;

  package Icons "Icons for ThermoPower library"
    extends Modelica.Icons.Library;

    package Water "Icons for component using water/steam as working fluid"
      extends Modelica.Icons.Library;

      partial model SourceP
        annotation(Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0}), Text(extent = {{-20, 34}, {28, -26}}, lineColor = {255, 255, 255}, textString = "P"), Text(extent = {{-100, -78}, {100, -106}}, textString = "%name")}));
      end SourceP;

      partial model SourceW
        annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}), Polygon(points = {{-12, -20}, {66, 0}, {-12, 20}, {34, 0}, {-12, -20}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-100, -52}, {100, -80}}, textString = "%name")}));
      end SourceW;

      partial model Tube
        annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder)}), Diagram(graphics));
      end Tube;

      partial model Mixer
        annotation(Icon(graphics = {Ellipse(extent = {{80, 80}, {-80, -80}}, lineColor = {0, 0, 0}), Text(extent = {{-100, -84}, {100, -110}}, textString = "%name")}), Diagram(graphics));
      end Mixer;

      partial model Tank
        annotation(Icon(graphics = {Rectangle(extent = {{-60, 60}, {60, -80}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, 60}, {54, 12}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, 12}, {54, -72}}, lineColor = {0, 0, 255})}));
      end Tank;

      partial model Valve
        annotation(Icon(graphics = {Line(points = {{0, 40}, {0, 0}}, color = {0, 0, 0}, thickness = 0.5), Polygon(points = {{-80, 40}, {-80, -40}, {0, 0}, {-80, 40}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Polygon(points = {{80, 40}, {0, 0}, {80, -40}, {80, 40}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Rectangle(extent = {{-20, 60}, {20, 40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}), Diagram(graphics));
      end Valve;

      model FlowJoin
        annotation(Diagram(graphics), Icon(graphics = {Polygon(points = {{-40, 60}, {0, 20}, {40, 20}, {40, -20}, {0, -20}, {-40, -60}, {-40, -20}, {-20, 0}, {-40, 20}, {-40, 60}}, lineColor = {0, 0, 0})}));
      end FlowJoin;

      model FlowSplit
        annotation(Diagram(graphics), Icon(graphics = {Polygon(points = {{40, 60}, {0, 20}, {-40, 20}, {-40, -20}, {0, -20}, {40, -60}, {40, -20}, {22, 0}, {40, 20}, {40, 60}}, lineColor = {0, 0, 0})}));
      end FlowSplit;

      model SensThrough
        annotation(Icon(graphics = {Rectangle(extent = {{-40, -20}, {40, -60}}, lineColor = {0, 0, 0}), Line(points = {{0, 20}, {0, -20}}, color = {0, 0, 0}), Ellipse(extent = {{-40, 100}, {40, 20}}, lineColor = {0, 0, 0}), Line(points = {{40, 60}, {60, 60}}), Text(extent = {{-100, -76}, {100, -100}}, textString = "%name")}));
      end SensThrough;

      model SensP
        annotation(Icon(graphics = {Line(points = {{0, 20}, {0, -20}}, color = {0, 0, 0}), Ellipse(extent = {{-40, 100}, {40, 20}}, lineColor = {0, 0, 0}), Line(points = {{40, 60}, {60, 60}}), Text(extent = {{-100, -52}, {100, -86}}, textString = "%name")}));
      end SensP;

      model Drum
        annotation(Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Polygon(points = {{-60, 0}, {-60, -6}, {-58, -16}, {-52, -30}, {-44, -42}, {-38, -46}, {-32, -50}, {-22, -56}, {-16, -58}, {-8, -60}, {-6, -60}, {0, -60}, {6, -60}, {12, -58}, {22, -56}, {30, -52}, {36, -48}, {42, -42}, {48, -36}, {52, -28}, {58, -18}, {60, -8}, {60, 0}, {-60, 0}}, lineColor = {128, 128, 128}), Polygon(points = {{-60, 0}, {-58, 16}, {-50, 34}, {-36, 48}, {-26, 54}, {-16, 58}, {-6, 60}, {0, 60}, {10, 60}, {20, 56}, {30, 52}, {36, 48}, {46, 40}, {52, 30}, {56, 22}, {58, 14}, {60, 6}, {60, 0}, {-60, 0}}, lineColor = {128, 128, 128}, fillColor = {159, 191, 223}, fillPattern = FillPattern.Solid)}));
      end Drum;

      partial model Pump
        annotation(Icon(graphics = {Polygon(points = {{-40, -24}, {-60, -60}, {60, -60}, {40, -24}, {-40, -24}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {0, 0, 191}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, 80}, {60, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere), Polygon(points = {{-30, 52}, {-30, -8}, {48, 20}, {-30, 52}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {255, 255, 255}), Text(extent = {{-100, -64}, {100, -90}}, textString = "%name")}));
      end Pump;

      partial model Accumulator
        annotation(Icon(graphics = {Rectangle(extent = {{-60, 80}, {60, -40}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, 100}, {60, 60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, -20}, {60, -60}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-52, 94}, {52, 64}}, lineColor = {0, 0, 191}, pattern = LinePattern.None, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-52, 22}, {52, -40}}, lineColor = {0, 0, 191}, fillColor = {0, 0, 191}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-52, 80}, {52, 20}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-52, -24}, {52, -54}}, lineColor = {0, 0, 191}, pattern = LinePattern.None, fillColor = {0, 0, 191}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-4, -58}, {4, -86}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-26, -86}, {26, -94}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Text(extent = {{-62, -100}, {64, -122}}, textString = "%name"), Polygon(points = {{-74, 86}, {-60, 72}, {-54, 78}, {-68, 92}, {-74, 86}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid)}), Diagram(graphics));
      end Accumulator;

      partial model PumpMech
        annotation(Icon(graphics = {Rectangle(extent = {{54, 28}, {80, 12}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164}), Polygon(points = {{-40, -24}, {-60, -60}, {60, -60}, {40, -24}, {-40, -24}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {0, 0, 191}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, 80}, {60, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere), Polygon(points = {{-30, 52}, {-30, -8}, {48, 20}, {-30, 52}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {255, 255, 255}), Text(extent = {{-100, -64}, {100, -90}}, textString = "%name")}));
      end PumpMech;

      partial model PressDrop
        annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder), Polygon(points = {{-80, 40}, {-42, 40}, {-20, 12}, {20, 12}, {40, 40}, {80, 40}, {80, -40}, {40, -40}, {20, -12}, {-20, -12}, {-40, -40}, {-80, -40}, {-80, 40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0, 0, 255})}), Diagram(graphics));
      end PressDrop;

      partial model SteamTurbineUnit
        annotation(Icon(graphics = {Line(points = {{14, 20}, {14, 42}, {38, 42}, {38, 20}}, color = {0, 0, 0}, thickness = 0.5), Rectangle(extent = {{-100, 8}, {100, -8}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164}), Polygon(points = {{-14, 48}, {-14, -48}, {14, -20}, {14, 20}, {-14, 48}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{38, 20}, {38, -20}, {66, -46}, {66, 48}, {38, 20}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-66, 20}, {-66, -20}, {-40, -44}, {-40, 48}, {-66, 20}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Line(points = {{-100, 70}, {-100, 70}, {-66, 70}, {-66, 20}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-40, 46}, {-40, 70}, {26, 70}, {26, 42}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-14, -46}, {-14, -70}, {66, -70}, {66, -46}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{66, -70}, {100, -70}}, color = {0, 0, 255}, thickness = 0.5)}), Diagram(graphics));
      end SteamTurbineUnit;

      partial model Header
        annotation(Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Ellipse(extent = {{70, 70}, {-70, -70}}, lineColor = {95, 95, 95}), Text(extent = {{-100, -84}, {100, -110}}, textString = "%name")}), Diagram(graphics));
      end Header;
    end Water;

    partial model HeatFlow
      annotation(Icon(graphics = {Rectangle(extent = {{-80, 20}, {80, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward)}));
    end HeatFlow;

    partial model MetalWall
      annotation(Icon(graphics = {Rectangle(extent = {{-80, 20}, {80, -20}}, lineColor = {0, 0, 0}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid)}));
    end MetalWall;

    package Gas "Icons for component using water/steam as working fluid"
      extends Modelica.Icons.Library;

      partial model SourceP
        annotation(Icon(graphics = {Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Text(extent = {{-20, 34}, {28, -26}}, lineColor = {255, 255, 255}, textString = "P"), Text(extent = {{-100, -78}, {100, -106}}, textString = "%name")}));
      end SourceP;

      partial model SourceW
        annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Polygon(points = {{-12, -20}, {66, 0}, {-12, 20}, {34, 0}, {-12, -20}}, lineColor = {128, 128, 128}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-100, -52}, {100, -80}}, textString = "%name")}));
      end SourceW;

      partial model Tube
        annotation(Icon(graphics = {Rectangle(extent = {{-80, 40}, {80, -40}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {159, 159, 223})}), Diagram(graphics));
      end Tube;

      partial model Mixer
        annotation(Icon(graphics = {Ellipse(extent = {{80, 80}, {-80, -80}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Text(extent = {{-100, -84}, {100, -110}}, textString = "%name")}), Diagram(graphics));
      end Mixer;

      partial model Valve
        annotation(Icon(graphics = {Line(points = {{0, 40}, {0, 0}}, color = {0, 0, 0}, thickness = 0.5), Polygon(points = {{-80, 40}, {-80, -40}, {0, 0}, {-80, 40}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Polygon(points = {{80, 40}, {0, 0}, {80, -40}, {80, 40}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-20, 60}, {20, 40}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}), Diagram(graphics));
      end Valve;

      model FlowJoin
        annotation(Diagram(graphics), Icon(graphics = {Polygon(points = {{-40, 60}, {0, 20}, {40, 20}, {40, -20}, {0, -20}, {-40, -60}, {-40, -20}, {-20, 0}, {-40, 20}, {-40, 60}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)}));
      end FlowJoin;

      model FlowSplit
        annotation(Diagram(graphics), Icon(graphics = {Polygon(points = {{40, 60}, {0, 20}, {-40, 20}, {-40, -20}, {0, -20}, {40, -60}, {40, -20}, {22, 0}, {40, 20}, {40, 60}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)}));
      end FlowSplit;

      model SensThrough
        annotation(Icon(graphics = {Rectangle(extent = {{-40, -20}, {40, -60}}, lineColor = {128, 128, 128}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Line(points = {{0, 20}, {0, -20}}, color = {0, 0, 0}), Ellipse(extent = {{-40, 100}, {40, 20}}, lineColor = {0, 0, 0}), Line(points = {{40, 60}, {60, 60}}), Text(extent = {{-100, -76}, {100, -100}}, textString = "%name")}));
      end SensThrough;

      model SensP
        annotation(Icon(graphics = {Line(points = {{0, 20}, {0, -20}}, color = {0, 0, 0}), Ellipse(extent = {{-40, 100}, {40, 20}}, lineColor = {0, 0, 0}), Line(points = {{40, 60}, {60, 60}}), Text(extent = {{-100, -52}, {100, -86}}, textString = "%name")}));
      end SensP;

      partial model Compressor
        annotation(Icon(graphics = {Polygon(points = {{24, 26}, {30, 26}, {30, 76}, {60, 76}, {60, 82}, {24, 82}, {24, 26}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Polygon(points = {{-30, 76}, {-30, 56}, {-24, 56}, {-24, 82}, {-60, 82}, {-60, 76}, {-30, 76}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, 8}, {60, -8}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164}), Polygon(points = {{-30, 60}, {-30, -60}, {30, -26}, {30, 26}, {-30, 60}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)}), Diagram(graphics));
      end Compressor;

      partial model Turbine
        annotation(Icon(graphics = {Polygon(points = {{-28, 76}, {-28, 28}, {-22, 28}, {-22, 82}, {-60, 82}, {-60, 76}, {-28, 76}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Polygon(points = {{26, 56}, {32, 56}, {32, 76}, {60, 76}, {60, 82}, {26, 82}, {26, 56}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, 8}, {60, -8}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164}), Polygon(points = {{-28, 28}, {-28, -26}, {32, -60}, {32, 60}, {-28, 28}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid)}), Diagram(graphics));
      end Turbine;

      partial model GasTurbineUnit
        annotation(Icon(graphics = {Line(points = {{-22, 26}, {-22, 48}, {22, 48}, {22, 28}}, color = {0, 0, 0}, thickness = 2.5), Rectangle(extent = {{-100, 8}, {100, -8}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160, 160, 164}), Polygon(points = {{-80, 60}, {-80, -60}, {-20, -26}, {-20, 26}, {-80, 60}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Polygon(points = {{20, 28}, {20, -26}, {80, -60}, {80, 60}, {20, 28}}, lineColor = {128, 128, 128}, lineThickness = 0.5, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-16, 64}, {16, 32}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.Sphere, fillColor = {255, 0, 0})}), Diagram(graphics));
      end GasTurbineUnit;

      partial model Collector
        annotation(Diagram(graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-80, 40}, {80, -40}})}));
      end Collector;
    end Gas;
  end Icons;

  package Tests
    package Heat_Exchanger
      model Static_Energy_Balance
        parameter Integer n = 5;
        SimpleBrayton.Components.Gas.Sink_Pressure ambient(p0 = 20e6) annotation(Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Pipe pipe(n = n, Tout_start = 750, pout_start = 20e6, m = 500, w_start = 20, L = 0.5) annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source(p_start = 20e6, T0 = 500, w0 = 20) annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Thermal.Wall_FixedT wall(n = n, Twall = 800) annotation(Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real Echeck;
      equation
        connect(wall.MultiPort, pipe.wall) annotation(Line(points = {{0, 52}, {0, 52}, {0, 15.1}, {0, 15.1}}, color = {255, 238, 44}));
        connect(pipe.inlet, source.outlet) annotation(Line(points = {{-10, 10}, {-40, 10}, {-40, 10}, {-40, 10}}, color = {159, 159, 223}));
        connect(pipe.outlet, ambient.inlet) annotation(Line(points = {{10, 10}, {40, 10}, {40, 10}, {40, 10}}, color = {159, 159, 223}));
        Echeck = pipe.inlet.w * pipe.inlet.h + pipe.outlet.w * pipe.outlet.h - wall.Qtot - sum(pipe.dEi);
      initial equation
        for i in 1:n loop
//pipe.fluid[i + 1].T = 500;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
      end Static_Energy_Balance;

      model Dynamic_Energy_Balance
        parameter Integer n = 6;
        SimpleBrayton.Components.Gas.Sink_Pressure ambient(p0 = 9e6) annotation(Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Heat_Exchanger_old pipe(n = n, redeclare SimpleBrayton.Components.Thermal.Gnielinski HeatTransfer) annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source(p_start = 9e6, w0 = 20, use_in_T = true, use_in_w = false) annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Thermal.Wall_FixedT wall(n = n, Twall = 610) annotation(Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real Echeck;
        Modelica.Blocks.Sources.Step StepT(height = 100, offset = 500, startTime = 1) annotation(Placement(visible = true, transformation(origin = {-66, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(source.in_T, StepT.y) annotation(Line(points = {{-50, 15}, {-50, 70}, {-55, 70}}, color = {0, 0, 127}));
        connect(wall.MultiPort, pipe.wall) annotation(Line(points = {{0, 52}, {0, 52}, {0, 16}, {0, 16}}, color = {255, 238, 44}));
        connect(pipe.inlet, source.outlet) annotation(Line(points = {{-10, 10}, {-40, 10}, {-40, 12}, {-40, 12}}, color = {159, 159, 223}));
        connect(pipe.outlet, ambient.inlet) annotation(Line(points = {{10, 10}, {40, 10}, {40, 10}, {40, 10}}, color = {159, 159, 223}));
        Echeck = pipe.inlet.w * pipe.inlet.h + pipe.outlet.w * pipe.outlet.h - wall.Qtot - sum(pipe.dUi);
      initial equation
        for i in 1:n loop
          pipe.gas[i + 1].T = 500;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002));
      end Dynamic_Energy_Balance;

      model Dynami_Mass_Balance
        parameter Integer n = 6;
        SimpleBrayton.Components.Gas.Sink_Pressure ambient(p0 = 9e6) annotation(Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Heat_Exchanger pipe(n = n, redeclare SimpleBrayton.Components.Thermal.ConstantConductance HeatTransfer) annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source(p0 = 9e6, w0 = 20, use_in_T = false, use_in_w = true, T0 = 500) annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Thermal.Wall_FixedT wall(n = n, Twall = 800) annotation(Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real Mcheck;
        Modelica.Blocks.Sources.Step Stepw(height = 10, offset = 20, startTime = 1) annotation(Placement(visible = true, transformation(origin = {-78, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(source.in_w, Stepw.y) annotation(Line(points = {{-56, 15}, {-56, 42.5}, {-67, 42.5}, {-67, 42}}, color = {0, 0, 127}));
        connect(wall.MultiPort, pipe.wall) annotation(Line(points = {{0, 52}, {0, 52}, {0, 16}, {0, 16}}, color = {255, 238, 44}));
        connect(pipe.inlet, source.outlet) annotation(Line(points = {{-10, 10}, {-40, 10}, {-40, 12}, {-40, 12}}, color = {159, 159, 223}));
        connect(pipe.outlet, ambient.inlet) annotation(Line(points = {{10, 10}, {40, 10}, {40, 10}, {40, 10}}, color = {159, 159, 223}));
        Mcheck = pipe.inlet.w + pipe.outlet.w - sum(pipe.dMi);
      initial equation
        for i in 1:n loop
          pipe.gas[i + 1].T = 500;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.002));
      end Dynami_Mass_Balance;

      model Real_parameters
        parameter Integer n = 8;
        SimpleBrayton.Components.Gas.Heat_Exchanger precooler_hot(redeclare SimpleBrayton.Components.Thermal.Gnielinski HeatTransfer, n = n, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, T_start = 342.99, Tm_start = 300) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 342.99, w0 = 70.2) annotation(Placement(visible = true, transformation(origin = {-32, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-72, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Thermal.Wall_FixedT wall_fixedt2(Twall = 305, n = n) annotation(Placement(visible = true, transformation(origin = {-6, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(wall_fixedt2.MultiPort, precooler_hot.wall) annotation(Line(points = {{-6, 36}, {-70, 36}, {-70, 32}, {-70, 32}}, color = {255, 238, 44}));
        connect(precooler_hot.outlet, sink_pressure1.inlet) annotation(Line(points = {{-82, 26}, {-82, 26}, {-82, -4}, {-82, -4}}, color = {159, 159, 223}));
        connect(source_massflow1.outlet, precooler_hot.inlet) annotation(Line(points = {{-42, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Real_parameters;

      model Pipe
        Components.Gas.Pipe pipe1(redeclare model Medium = SimpleBrayton.Substances.WaterLiquid, Tin_start = 293, Tout_start = 350, pout_start = 1.1e5, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, w_start = 85, n = 4) annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure1(p0 = 1.1e5) annotation(Placement(visible = true, transformation(origin = {36, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow1(redeclare model Medium = SimpleBrayton.Substances.WaterLiquid, w0 = 85, T0 = 293) annotation(Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Thermal.Wall_FixedT wall_FixedT1(n = 4, Twall = 400) annotation(Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pipe1.wall, wall_FixedT1.MultiPort) annotation(Line(points = {{0, 25.1}, {0, 25.1}, {0, 52}, {0, 52}}, color = {255, 238, 44}));
        connect(source_MassFlow1.outlet, pipe1.inlet) annotation(Line(points = {{-36, 20}, {-10, 20}}, color = {159, 159, 223}));
        connect(pipe1.outlet, sink_Pressure1.inlet) annotation(Line(points = {{10, 20}, {26, 20}, {26, 20}, {26, 20}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Pipe;

      model h_behaviour
        import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
        parameter Real lc = 0.002;
        parameter Real A = 0.002 ^ 2 * 3.14 / 8;
        parameter Real S = 0.008283185 * 2.3;
        parameter Real m = 173780 / 2;
        SimpleBrayton.Components.Thermal.Gnielinski HX(Lc = lc, A = A, S = S, m = m) annotation(Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Substances.CO2 fluid annotation(Placement(visible = true, transformation(origin = {-2, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real T;
        Real p;
        Real w;
        parameter Integer N = 50;
        SimpleBrayton.Components.Thermal.Gnielinski[N] HX_data(each Lc = lc, each A = A, each S = S, each m = m);
        SimpleBrayton.Substances.CO2[N] fluid_data;
        parameter Real w_data[:] = linspace(70, 121, N);
        Real h_data[:] = HX_data.h;
        Real coeff[2] = Poly.fitting(log(w_data), log(h_data), 1);
        Real h_a;
        Real h_a2;
      equation
        for i in 1:N loop
          HX_data[i].Tmean = fluid_data[i].T;
          HX_data[i].cp = fluid_data[i].cp;
          HX_data[i].k = fluid_data[i].k;
          HX_data[i].mu = fluid_data[i].mu;
          HX_data[i].Twall = 1000;
          HX_data[i].w = w_data[i];
          fluid_data[i].T = T;
          fluid_data[i].p = p;
        end for;
        T = 560;
//T = 500 + 408 * time;
        p = 2.11132e+07;
        w = 70 + 51 * time;
//w = 121;
//
        HX.Tmean = fluid.T;
        HX.cp = fluid.cp;
        HX.k = fluid.k;
        HX.mu = fluid.mu;
        HX.Twall = 1000;
        HX.w = w;
        fluid.T = T;
        fluid.p = p;
        h_a = exp(coeff[2]) * w ^ coeff[1];
        h_a2 = 7308.01 * (w / 121) ^ coeff[1];
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.00167224));
      end h_behaviour;

      model Ht_recuperator
        parameter Integer n = 3;
        Components.Gas.Source_MassFlow source_MassFlow1(p_start = 19.94e6, w0 = 121, T0 = 429.3) annotation(Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure1(p0 = 7.74e6) annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure2(p0 = 19.89e6) annotation(Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow2(p_start = 7.85e6, w0 = 121, T0 = 804.55) annotation(Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Real error;
        Real errorh;
        Real errorc;
        Components.Gas.Parametrized_Components.HTRecuperator hTRecuperator1(n = n) annotation(Placement(visible = true, transformation(origin = {0, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(source_MassFlow2.outlet, hTRecuperator1.inlet_hot) annotation(Line(points = {{40, 30}, {40, 30}, {40, 18}, {10, 18}, {10, 18}}, color = {159, 159, 223}));
        connect(hTRecuperator1.outlet_cold, sink_Pressure2.inlet) annotation(Line(points = {{10, 9}, {40, 9}, {40, -10}, {40, -10}}, color = {159, 159, 223}));
        connect(hTRecuperator1.inlet_cold, source_MassFlow1.outlet) annotation(Line(points = {{-10, 9}, {-40, 9}, {-40, -10}, {-40, -10}}, color = {159, 159, 223}));
        connect(hTRecuperator1.outlet_hot, sink_Pressure1.inlet) annotation(Line(points = {{-10, 19}, {-40, 19}, {-40, 30}, {-40, 30}}, color = {159, 159, 223}));
        error = errorh + errorc;
        errorh = hTRecuperator1.pipe_hot.T[n + 1] - hTRecuperator1.pipe_hot.T_start[n + 1];
        errorc = hTRecuperator1.pipe_cold.T_start[n + 1] - hTRecuperator1.pipe_cold.T[n + 1];
      initial equation
        for i in 1:n loop
//heat_Exchanger1.pipe_hot.fluid[i].T = 436.34;
//heat_Exchanger1.pipe_cold.fluid[i].T = 333.51;
          der(hTRecuperator1.pipe_hot.fluid[i + 1].T) = 0;
          der(hTRecuperator1.pipe_cold.fluid[i + 1].T) = 0;
          der(hTRecuperator1.wall.T[i]) = 0;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end Ht_recuperator;

      model Lt_recuperator
        import Modelica.Utilities.Streams.*;
        parameter Integer n = 3;
        Components.Gas.Source_MassFlow source_MassFlow1(p_start = 19.95e6, w0 = 70.2, T0 = 341.896) annotation(Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure1(p0 = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure2(p0 = 19.94e6) annotation(Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow2(p_start = 7.74e6, w0 = 121, T0 = 436.34) annotation(Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Real error;
        Real errorh;
        Real errorc;
        Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n) annotation(Placement(visible = true, transformation(origin = {0, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(ltrecuperator.inlet_hot, source_MassFlow2.outlet) annotation(Line(points = {{10, 19}, {40, 19}, {40, 28}, {40, 28}}, color = {159, 159, 223}));
        connect(ltrecuperator.outlet_cold, sink_Pressure2.inlet) annotation(Line(points = {{10, 9}, {40, 9}, {40, -10}, {40, -10}}, color = {159, 159, 223}));
        connect(ltrecuperator.inlet_cold, source_MassFlow1.outlet) annotation(Line(points = {{-10, 9}, {-40, 9}, {-40, -10}, {-40, -10}}, color = {159, 159, 223}));
        connect(ltrecuperator.outlet_hot, sink_Pressure1.inlet) annotation(Line(points = {{-10, 19}, {-40, 19}, {-40, 30}, {-40, 30}}, color = {159, 159, 223}));
        error = errorh - errorc;
        errorh = ltrecuperator.pipe_hot.T[n + 1] - ltrecuperator.pipe_hot.T_start[n + 1];
        errorc = ltrecuperator.pipe_cold.T_start[n + 1] - ltrecuperator.pipe_cold.T[n + 1];
        when pre(terminal()) == true then
          Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          for i in 2:n + 1 loop
            print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end for;
          for i in 2:n + 1 loop
            print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end for;
          print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        end when;
      initial equation
        for i in 1:n loop
          der(ltrecuperator.pipe_hot.fluid[i + 1].T) = 0;
          der(ltrecuperator.pipe_cold.fluid[i + 1].T) = 0;
          der(ltrecuperator.wall.T[i]) = 0;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end Lt_recuperator;

      model Precooler
        parameter Integer n = 8;
        Components.Gas.Source_MassFlow source_MassFlow1(w0 = 100, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure1(p0 = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Components.Gas.Sink_Pressure sink_Pressure2(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow2(p_start = 7.64e6, w0 = 70.2, T0 = 342.99) annotation(Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Real error;
        Real errorh;
        Real errorc;
        Components.Gas.Parametrized_Components.Precooler precooler1(n = n) annotation(Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(precooler1.inlet_hot, source_MassFlow2.outlet) annotation(Line(points = {{10, 17}, {40, 17}, {40, 30}, {40, 30}}, color = {159, 159, 223}));
        connect(precooler1.outlet_cold, sink_Pressure2.inlet) annotation(Line(points = {{10, 7}, {40, 7}, {40, -8}, {40, -8}}, color = {159, 159, 223}));
        connect(precooler1.inlet_cold, source_MassFlow1.outlet) annotation(Line(points = {{-10, 7}, {-40, 7}, {-40, -10}, {-40, -10}}, color = {159, 159, 223}));
        connect(precooler1.outlet_hot, sink_Pressure1.inlet) annotation(Line(points = {{-10, 17}, {-40, 17}, {-40, 30}, {-40, 30}}, color = {159, 159, 223}));
        error = errorh + errorc;
        errorh = precooler1.pipe_hot.T[n + 1] - precooler1.pipe_hot.T_start[n + 1];
        errorc = precooler1.pipe_cold.T_start[n + 1] - precooler1.pipe_cold.T[n + 1];
      initial equation
        for i in 1:n loop
//heat_Exchanger1.pipe_hot.fluid[i].T = 436.34;
//heat_Exchanger1.pipe_cold.fluid[i].T = 333.51;
//der(heat_Exchanger1.pipe_hot.fluid[i + 1].T) = 0;
//der(heat_Exchanger1.pipe_cold.fluid[i + 1].T) = 0;
//der(heat_Exchanger1.wall.T[i]) = 0;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.06));
      end Precooler;

      model SolarCollector
        parameter Real S = 2.56795e+07;
        parameter Integer n = 2;
        SimpleBrayton.Components.Gas.SolarCollector solarCollector1(n = n) annotation(Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real error;
        SimpleBrayton.Components.Gas.Source_MassFlow source_MassFlow1(p_start = 19.89e6, T0 = 760.09, w0 = 121) annotation(Placement(visible = true, transformation(origin = {-48, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.38e6) annotation(Placement(visible = true, transformation(origin = {46, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(solarCollector1.outlet, sink_Pressure1.inlet) annotation(Line(points = {{10, 4}, {23, 4}, {23, -10}, {36, -10}}, color = {159, 159, 223}));
        connect(source_MassFlow1.outlet, solarCollector1.inlet) annotation(Line(points = {{-38, 16}, {-10, 16}, {-10, 4}, {-10, 4}}, color = {159, 159, 223}));
        error = solarCollector1.pipe.T_start[n + 1] - solarCollector1.pipe.T[n + 1];
        solarCollector1.S = S;
      initial equation
        for i in 1:n loop
          der(solarCollector1.pipe.fluid[i + 1].T) = 0;
          der(solarCollector1.wall.T[i]) = 0;
        end for;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end SolarCollector;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Heat_Exchanger;

    package Turbomachines
      model Test_Turbine
        Real w_in;
        Real error;
        SimpleBrayton.Components.Gas.TurbineStodola turbinestodola1 annotation(Placement(visible = true, transformation(origin = {-6, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 7.85e6) annotation(Placement(visible = true, transformation(origin = {32, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 926.175, w0 = 121, use_in_w = false, p_start = 19.38e6) annotation(Placement(visible = true, transformation(origin = {-56, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {28, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        error = turbinestodola1.gas_out.T - turbinestodola1.gas_out.T_start;
        connect(turbinestodola1.shaft_r, grid1.connection) annotation(Line(points = {{2, 20}, {2, 20}, {2, 4}, {20, 4}, {20, 4}}, color = {0, 0, 255}));
        w_in = 90 + (121 - 90) * time;
//source_massflow1.in_w = w_in;
        connect(turbinestodola1.outlet, sink_pressure1.inlet) annotation(Line(points = {{2, 28}, {22, 28}, {22, 28}, {22, 28}}, color = {159, 159, 223}));
        connect(source_massflow1.outlet, turbinestodola1.inlet) annotation(Line(points = {{-46, 28}, {-14, 28}, {-14, 28}, {-14, 28}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Test_Turbine;

      model Test_MainCompressor
        //Real w_in;
        SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 304.84, w0 = 70.2, use_in_w = false) annotation(Placement(visible = true, transformation(origin = {-48, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.MainCompressor maincompressor1 annotation(Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real error;
        Real beta0;
        Real a;
      equation
        connect(maincompressor1.inlet, source_massflow1.outlet) annotation(Line(points = {{-18, 30}, {-29, 30}, {-29, 32}, {-38, 32}}, color = {159, 159, 223}));
        beta0 = sum(maincompressor1.a);
        a = maincompressor1.a[1] + maincompressor1.beta_start - beta0;
        error = maincompressor1.gas_out.T - maincompressor1.gas_out.T_start;
        connect(maincompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-2, 22}, {-2, 22}, {-2, -10}, {20, -10}, {20, -10}}, color = {0, 0, 255}));
        connect(maincompressor1.outlet, sink_pressure1.inlet) annotation(Line(points = {{-2, 30}, {20, 30}, {20, 30}, {20, 30}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Test_MainCompressor;

      model Test_ReCompressor
        //Real w_in;
        SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 351.886, w0 = 50.2, use_in_w = false) annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.94e6) annotation(Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.ReCompressor recompressor1 annotation(Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real error;
        Real beta0;
        Real a;
      equation
        beta0 = sum(recompressor1.a);
        a = recompressor1.a[1] + recompressor1.beta_start - beta0;
        error = recompressor1.gas_out.T - recompressor1.gas_out.T_start;
        connect(recompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-2, 22}, {-2, 22}, {-2, -10}, {24, -10}, {24, -10}}, color = {0, 0, 255}));
        connect(recompressor1.outlet, sink_pressure1.inlet) annotation(Line(points = {{-2, 30}, {20, 30}, {20, 30}, {20, 30}}, color = {159, 159, 223}));
        connect(recompressor1.inlet, source_massflow1.outlet) annotation(Line(points = {{-18, 30}, {-40, 30}, {-40, 30}, {-40, 30}}, color = {159, 159, 223}));
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Test_ReCompressor;

      model pipe_compressor
        //Real w_in;
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.MainCompressor maincompressor1(pin_start = 7.63e6, Tin_start = 304.84) annotation(Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Pipe pipe1(Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2, pout_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-52, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Thermal.Wall_FixedT wall_FixedT1(Twall = 304) annotation(Placement(visible = true, transformation(origin = {-52, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow1(w0 = 70.2, T0 = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-88, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(source_MassFlow1.outlet, pipe1.inlet) annotation(Line(points = {{-78, 30}, {-64, 30}, {-64, 30}, {-64, 30}}, color = {159, 159, 223}));
        connect(wall_FixedT1.MultiPort, pipe1.wall) annotation(Line(points = {{-52, 70}, {-52, 35}}, color = {255, 238, 44}));
        connect(pipe1.outlet, maincompressor1.inlet) annotation(Line(points = {{-42, 30}, {-18, 30}, {-18, 30}, {-18, 30}}, color = {159, 159, 223}));
        connect(maincompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-2, 22}, {-2, 22}, {-2, -10}, {20, -10}, {20, -10}}, color = {0, 0, 255}));
        connect(maincompressor1.outlet, sink_pressure1.inlet) annotation(Line(points = {{-2, 30}, {20, 30}, {20, 30}, {20, 30}}, color = {159, 159, 223}));
      initial equation
        for i in 2:4 loop
//der(pipe1.fluid[i].T) = 0;
        end for;
//der(pipe1.fluid[4].p) = 0;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end pipe_compressor;

      model closed_circuit
        //Real w_in;
        SimpleBrayton.Components.Gas.MainCompressor maincompressor1(pin_start = 7.63e6, Tin_start = 350, Tout_start = 400) annotation(Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.TurbineStodola turbineStodola1(Tin_start = 926.175, Tout_start = 804.55, p_start = 19e6) annotation(Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {68, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Pipe pipe1(Tin_start = 400, Tout_start = 920, w_start = 90, pout_start = 19e6) annotation(Placement(visible = true, transformation(origin = {-12, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Pipe pipe2(Tout_start = 350, w_start = 90, pout_start = 7.63e6, Tin_start = 800) annotation(Placement(visible = true, transformation(origin = {-10, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Components.Thermal.Wall_FixedT wall_FixedT1(Twall = 920) annotation(Placement(visible = true, transformation(origin = {-10, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Thermal.Wall_FixedT wall_FixedT2(Twall = 350) annotation(Placement(visible = true, transformation(origin = {-10, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        connect(pipe2.wall, wall_FixedT2.MultiPort) annotation(Line(points = {{-10, -25}, {-10, -25}, {-10, -64}, {-10, -64}}, color = {255, 238, 44}));
        connect(pipe1.wall, wall_FixedT1.MultiPort) annotation(Line(points = {{-12, 47}, {-10, 47}, {-10, 78}, {-10, 78}}, color = {255, 238, 44}));
        connect(pipe2.outlet, maincompressor1.inlet) annotation(Line(points = {{-20, -20}, {-72, -20}, {-72, 18}, {-58, 18}, {-58, 18}, {-58, 18}}, color = {159, 159, 223}));
        connect(turbineStodola1.outlet, pipe2.inlet) annotation(Line(points = {{38, 18}, {46, 18}, {46, -20}, {0, -20}, {0, -20}}, color = {159, 159, 223}));
        connect(turbineStodola1.inlet, pipe1.outlet) annotation(Line(points = {{22, 18}, {22, 18}, {22, 42}, {-2, 42}, {-2, 42}}, color = {159, 159, 223}));
        connect(maincompressor1.outlet, pipe1.inlet) annotation(Line(points = {{-42, 18}, {-40, 18}, {-40, 42}, {-22, 42}, {-22, 42}}, color = {159, 159, 223}));
        connect(turbineStodola1.shaft_r, grid1.connection) annotation(Line(points = {{38, 10}, {60, 10}, {60, 10}, {60, 10}}, color = {0, 0, 255}));
        connect(maincompressor1.shaft_r, turbineStodola1.shaft_l) annotation(Line(points = {{-42, 10}, {22, 10}, {22, 10}, {22, 10}}, color = {0, 0, 255}));
      initial equation
        for i in 2:4 loop
          der(pipe1.fluid[i].T) = 0;
          der(pipe2.fluid[i].T) = 0;
        end for;
//der(pipe1.fluid[4].p) = 0;
      end closed_circuit;

      model pipe_compressor_compare
        //Real w_in;
        SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.MainCompressor maincompressor1(pin_start = 7.63e6, Tin_start = 304.84) annotation(Placement(visible = true, transformation(origin = {-10, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Source_MassFlow source_MassFlow1(w0 = 70.2, T0 = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-88, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Heat_Exchanger_old heat_Exchanger_old1(Tout_start = 304.84, Tin_start = 342.99, p_start = 7.63e6, k = 500, w_start = 70.2, Di = 0.002, wp = 0.008283185, m = 70000) annotation(Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Thermal.Wall_FixedT wall_FixedT1(Twall = 304) annotation(Placement(visible = true, transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(wall_FixedT1.MultiPort, heat_Exchanger_old1.wall) annotation(Line(points = {{-50, 70}, {-50, 70}, {-50, 34}, {-50, 34}}, color = {255, 238, 44}));
        connect(heat_Exchanger_old1.inlet, source_MassFlow1.outlet) annotation(Line(points = {{-60, 30}, {-78, 30}}, color = {159, 159, 223}));
        connect(heat_Exchanger_old1.outlet, maincompressor1.inlet) annotation(Line(points = {{-40, 30}, {-18, 30}}, color = {159, 159, 223}));
        connect(maincompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-2, 22}, {-2, 22}, {-2, -10}, {20, -10}, {20, -10}}, color = {0, 0, 255}));
        connect(maincompressor1.outlet, sink_pressure1.inlet) annotation(Line(points = {{-2, 30}, {20, 30}, {20, 30}, {20, 30}}, color = {159, 159, 223}));
      initial equation
        for i in 2:4 loop
//der(pipe1.fluid[i].T) = 0;
        end for;
//der(pipe1.fluid[4].p) = 0;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end pipe_compressor_compare;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Turbomachines;

    package Substances
      model Test_Water_Model
        import Modelica.SIunits.*;
        package Medium = Modelica.Media.Water.WaterIF97_pT;
        Medium.ThermodynamicState state;
        SimpleBrayton.Substances.WaterLiquid Medium_a;
        parameter Pressure T_min = 280;
        parameter Pressure T_max = 350;
        parameter Pressure p = 101325;
        //Variables
        Temperature T;
        Density d;
        SpecificEnthalpy u;
        SpecificHeatCapacity cp;
        SpecificEnthalpy h;
        Types.DynamicViscosity mu "Dynamic viscosity";
        Types.ThermalConductance k "Thermal Conductivity";
        Density d_a;
        SpecificEnthalpy u_a;
        SpecificHeatCapacity cp_a;
        SpecificEnthalpy h_a;
      equation
        T = T_min + (T_max - T_min) * time;
        state = Medium.setState_pT(p, T);
        d = state.d;
        u = h - p / d;
        cp = der(u) / (T_max - T_min);
        h = state.h;
        mu = Medium.dynamicViscosity(state);
        k = Medium.thermalConductivity(state);
        Medium_a.T = T;
        Medium_a.p = p;
        d_a = Medium_a.d;
        u_a = Medium_a.u;
        cp_a = Medium_a.cp;
        h_a = Medium_a.h;
      end Test_Water_Model;

      model SolarRadiation
        SimpleBrayton.Substances.CO2 p4;
        SimpleBrayton.Substances.CO2 p5;
        Real S;
      equation
        p4.p = 19.89e6;
        p4.T = 760.09;
        p5.p = 19.38e6;
        p5.T = 926.175;
        S = (p5.h - p4.h) * 121 / 0.985;
      end SolarRadiation;

      model maincompressor
        SimpleBrayton.Substances.CO2 p1;
        SimpleBrayton.Substances.CO2 p2is;
        SimpleBrayton.Substances.CO2 p2;
        Real eta_is;
      equation
        p1.T = 304.84;
        p1.p = 7.63e6;
        p2is.s = p1.s;
        p2is.p = 19.95e6;
        p2.T = 333.51;
        p2.p = 19.95e6;
        eta_is = (p2is.h - p1.h) / (p2.h - p1.h);
      end maincompressor;

      model recompressor
        SimpleBrayton.Substances.CO2 p8;
        SimpleBrayton.Substances.CO2 p3is;
        SimpleBrayton.Substances.CO2 p3;
        Real eta_is;
      equation
        p8.T = 342.99;
        p8.p = 7.64e6;
        p3is.s = p8.s;
        p3is.p = 19.94e6;
        p3.T = 429.3;
        p3.p = 19.94e6;
        eta_is = (p3is.h - p8.h) / (p3.h - p8.h);
      end recompressor;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Substances;

    package Plant
      model Working_model
        Plants.Plant_init_eq plant annotation(Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        plant.solar_radiation = 25500000;
        plant.cooling_massflow = 90;
        plant.draw_out_massflow = 0;
        plant.bypass_massflow = 0;
        plant.reint_massflow = 0;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 3000, Tolerance = 1e-06, Interval = 6));
      end Working_model;

      package Progressive_testing_old
        extends Modelica.Icons.ObsoleteModel;

        model Precooler
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4;
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2, k = 142) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 342.99, w0 = 70.2) annotation(Placement(visible = true, transformation(origin = {-32, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-46, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(precooler_hot.outlet, sink_pressure1.inlet) annotation(Line(points = {{-82, 26}, {-82, 26}, {-82, -12}, {-56, -12}, {-56, -12}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          connect(source_massflow1.outlet, precooler_hot.inlet) annotation(Line(points = {{-42, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          source_water.in_w = 85;
//precooler_hot.gas[4].T = 315;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
          end when;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end Precooler;

        model Add_MainCompressor
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4;
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2, k = 142) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 342.99, w0 = 70.2) annotation(Placement(visible = true, transformation(origin = {-32, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {-46, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, pin_start = 7.63e6, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(maincompressor.outlet, sink_pressure1.inlet) annotation(Line(points = {{-66, -42}, {-66, -42}, {-66, -12}, {-56, -12}, {-56, -12}}, color = {159, 159, 223}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(maincompressor.shaft_r, grid.connection) annotation(Line(points = {{-66, -50}, {84, -50}, {84, -50}, {84, -50}}, color = {0, 0, 255}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          connect(source_massflow1.outlet, precooler_hot.inlet) annotation(Line(points = {{-42, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
//print("  precooler_hot.gas[" + String(n_pc) + "].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.T[2:5] = {325.595, 316.019, 310.089, 306.445};
          precooler_cold.T[2:5] = {300.425, 304.49, 308.851, 314.749};
//precooler_hot.gas[2].T = 318.322;
//precooler_hot.gas[3].T = 311.069;
//precooler_hot.gas[4].T = 307.29;
//precooler_hot.gas[5].T = 305.412;
//precooler_cold.water[2].T = 301.88;
//precooler_cold.water[3].T = 306.176;
//precooler_cold.water[4].T = 310.596;
//precooler_cold.water[5].T = 319.685;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.012));
        end Add_MainCompressor;

        model Add_ReCompressor
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4;
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 142) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 342.99, w0 = 121) annotation(Placement(visible = true, transformation(origin = {6, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {4, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, pin_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(maincompressor.outlet, sink_pressure1.inlet) annotation(Line(points = {{-66, -42}, {-66, -42}, {-66, -8}, {-6, -8}, {-6, -8}}, color = {159, 159, 223}));
          connect(recompressor.outlet, sink_pressure1.inlet) annotation(Line(points = {{-20, -42}, {-6, -42}, {-6, -8}, {-6, -8}}, color = {159, 159, 223}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, 26}}, color = {159, 159, 223}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(recompressor.inlet, source_massflow1.outlet) annotation(Line(points = {{-36, -42}, {-36, -42}, {-36, 22}, {-4, 22}, {-4, 22}}, color = {159, 159, 223}));
          connect(precooler_hot.inlet, source_massflow1.outlet) annotation(Line(points = {{-62, 26}, {-34, 26}, {-34, 22}, {-4, 22}, {-4, 22}}, color = {159, 159, 223}));
          connect(recompressor.shaft_r, grid.connection) annotation(Line(points = {{-20, -50}, {82, -50}, {82, -48}, {82, -48}}, color = {0, 0, 255}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  LTrecuperator_hot.gas[5].p = " + String(precooler_hot.gas[1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 318.273;
          precooler_hot.gas[3].T = 311.439;
          precooler_hot.gas[4].T = 307.82;
          precooler_hot.gas[5].T = 305.86;
          precooler_cold.water[2].T = 301.828;
          precooler_cold.water[3].T = 306.525;
          precooler_cold.water[4].T = 310.932;
          precooler_cold.water[5].T = 320.001;
          precooler_hot.gas[2].p = 7.7786e+006;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0120048));
        end Add_ReCompressor;

        model Add_LTrecuperator
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4;
          parameter Integer n_ltr = 4;
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2, k = 142) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, p_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old LTrecuperator_hot(n = n_ltr, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, p_start = 7.74e6, Tin_start = 436.34, Tout_start = 342.99, k = 826, w_start = 121) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old LTrecuperator_cold(n = n_ltr, HeatTransfer, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, Direction = false, p_start = 19.95e6, Tin_start = 333.51, Tout_start = 429.3, k = 142, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 436.34, w0 = 121) annotation(Placement(visible = true, transformation(origin = {36, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {46, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(recompressor.outlet, sink_pressure1.inlet) annotation(Line(points = {{-20, -42}, {36, -42}, {36, -6}, {36, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.outlet, sink_pressure1.inlet) annotation(Line(points = {{-4, -2}, {2, -2}, {2, -2}, {36, -2}, {36, -6}, {36, -6}}, color = {159, 159, 223}));
          connect(recompressor.inlet, LTrecuperator_hot.outlet) annotation(Line(points = {{-36, -42}, {-36, -42}, {-36, 22}, {-24, 22}, {-24, 22}}, color = {159, 159, 223}));
          connect(precooler_hot.inlet, LTrecuperator_hot.outlet) annotation(Line(points = {{-62, 26}, {-40, 26}, {-40, 22}, {-26, 22}, {-26, 22}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(LTrecuperator_hot.inlet, source_massflow1.outlet) annotation(Line(points = {{-4, 22}, {26, 22}, {26, 22}, {26, 22}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -42}, {-66, -42}}, color = {159, 159, 223}));
          connect(recompressor.shaft_r, grid.connection) annotation(Line(points = {{-20, -50}, {82, -50}, {82, -48}, {82, -48}}, color = {0, 0, 255}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  LTrecuperator_hot.gas[5].p = " + String(LTrecuperator_hot.gas[5].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 318.273;
          precooler_hot.gas[3].T = 311.439;
          precooler_hot.gas[4].T = 307.82;
          precooler_hot.gas[5].T = 305.86;
          precooler_cold.water[2].T = 301.828;
          precooler_cold.water[3].T = 306.525;
          precooler_cold.water[4].T = 310.932;
          precooler_cold.water[5].T = 320.001;
          precooler_hot.gas[2].p = 7.7786e+006;
          LTrecuperator_hot.gas[5].p = 7.84035e+006;
          LTrecuperator_hot.gas[2].T = 428.13;
          LTrecuperator_hot.gas[3].T = 410.674;
          LTrecuperator_hot.gas[4].T = 382.305;
          LTrecuperator_hot.gas[5].T = 351.348;
          LTrecuperator_cold.gas[2].T = 372.786;
          LTrecuperator_cold.gas[3].T = 403.51;
          LTrecuperator_cold.gas[4].T = 424.856;
          LTrecuperator_cold.gas[5].T = 434.925;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.1));
        end Add_LTrecuperator;

        model Add_HTrecuperator
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4 "Number of finite volumes in the Precooler";
          parameter Integer n_ltr = 4 "Number of finite volumes in the Low temperature recuperator";
          parameter Integer n_htr = 4 "Number of finite volumes in the High temperature recuperator";
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, p_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowSplit flowsplit annotation(Placement(visible = true, transformation(origin = {-40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_hot(n = n_ltr, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, p_start = 7.74e6, Tin_start = 436.34, Tout_start = 342.99) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_cold(n = n_ltr, HeatTransfer, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, Direction = false, p_start = 19.95e6, Tin_start = 333.51, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin annotation(Placement(visible = true, transformation(origin = {14, -6}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_cold(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, Direction = false, p_start = 19.94e6, Tin_start = 429.3, Tout_start = 760.09) annotation(Placement(visible = true, transformation(origin = {42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_hot(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, p_start = 7.85e6, Tin_start = 804.55, Tout_start = 436.34) annotation(Placement(visible = true, transformation(origin = {42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 804.55, w0 = 121) annotation(Placement(visible = true, transformation(origin = {82, 22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {76, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(HTrecuperator_hot.wall, HTrecuperator_cold.wall) annotation(Line(points = {{42, 17}, {42, 17}, {42, -2}, {42, -2}}, color = {255, 238, 44}));
          connect(HTrecuperator_cold.outlet, sink_pressure1.inlet) annotation(Line(points = {{52, -6}, {66, -6}, {66, -8}, {66, -8}}, color = {159, 159, 223}));
          connect(HTrecuperator_hot.inlet, source_massflow1.outlet) annotation(Line(points = {{52, 22}, {72, 22}, {72, 22}, {72, 22}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.inlet, HTrecuperator_hot.outlet) annotation(Line(points = {{-4, 22}, {32, 22}, {32, 22}, {32, 22}}, color = {159, 159, 223}));
          connect(flowjoin.outlet, HTrecuperator_cold.inlet) annotation(Line(points = {{20, -6}, {32, -6}, {32, -6}, {32, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(recompressor.outlet, flowjoin.inlet1) annotation(Line(points = {{-20, -42}, {8, -42}, {8, -10}, {8, -10}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.outlet, flowjoin.inlet2) annotation(Line(points = {{-4, -2}, {8, -2}, {8, -2}, {8, -2}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -42}, {-66, -42}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.outlet, flowsplit.inlet) annotation(Line(points = {{-24, 22}, {-34, 22}, {-34, 22}, {-34, 22}}, color = {159, 159, 223}));
          connect(flowsplit.outlet1, recompressor.inlet) annotation(Line(points = {{-46, 18}, {-46, 18}, {-46, -42}, {-36, -42}, {-36, -42}}, color = {159, 159, 223}));
          connect(flowsplit.outlet2, precooler_hot.inlet) annotation(Line(points = {{-46, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          connect(recompressor.shaft_r, grid.connection) annotation(Line(points = {{-20, -50}, {82, -50}, {82, -48}, {82, -48}}, color = {0, 0, 255}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_hot.gas[" + String(i) + "].T = " + String(HTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_cold.gas[" + String(i) + "].T = " + String(HTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 321.488;
          precooler_hot.gas[3].T = 313.423;
          precooler_hot.gas[4].T = 309.281;
          precooler_hot.gas[5].T = 306.631;
          precooler_cold.water[2].T = 302.329;
          precooler_cold.water[3].T = 307.813;
          precooler_cold.water[4].T = 312.97;
          precooler_cold.water[5].T = 323.867;
          precooler_hot.gas[2].p = 8.01824e+006;
          LTrecuperator_hot.gas[2].T = 429.019;
          LTrecuperator_hot.gas[3].T = 411.458;
          LTrecuperator_hot.gas[4].T = 382.758;
          LTrecuperator_hot.gas[5].T = 351.384;
          LTrecuperator_cold.gas[2].T = 373.106;
          LTrecuperator_cold.gas[3].T = 404.229;
          LTrecuperator_cold.gas[4].T = 425.745;
          LTrecuperator_cold.gas[5].T = 435.211;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.1));
        end Add_HTrecuperator;

        model Add_Turbine
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4 "Number of finite volumes in the Precooler";
          parameter Integer n_ltr = 4 "Number of finite volumes in the Low temperature recuperator";
          parameter Integer n_htr = 4 "Number of finite volumes in the High temperature recuperator";
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, p_start = 7.63e6, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowSplit flowsplit annotation(Placement(visible = true, transformation(origin = {-40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_hot(n = n_ltr, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, p_start = 7.74e6, Tin_start = 436.34, Tout_start = 342.99) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_cold(n = n_ltr, HeatTransfer, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, Direction = false, p_start = 19.95e6, Tin_start = 333.51, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin annotation(Placement(visible = true, transformation(origin = {14, -6}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_cold(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, Direction = false, p_start = 19.94e6, Tin_start = 429.3, Tout_start = 760.09) annotation(Placement(visible = true, transformation(origin = {42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_hot(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, p_start = 7.85e6, Tin_start = 804.55, Tout_start = 436.34) annotation(Placement(visible = true, transformation(origin = {42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.TurbineStodola turbine(Tin_start = 926.175, p_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {64, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {88, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 926.175, w0 = 121) annotation(Placement(visible = true, transformation(origin = {26, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(source_massflow1.outlet, turbine.inlet) annotation(Line(points = {{36, -30}, {56, -30}, {56, -42}, {56, -42}}, color = {159, 159, 223}));
          connect(HTrecuperator_cold.outlet, sink_pressure1.inlet) annotation(Line(points = {{52, -6}, {78, -6}}, color = {159, 159, 223}));
          connect(turbine.outlet, HTrecuperator_hot.inlet) annotation(Line(points = {{72, -42}, {72, -42}, {72, 22}, {52, 22}, {52, 22}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{72, -50}, {82, -50}, {82, -50}, {82, -50}}, color = {0, 0, 255}));
          connect(recompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-20, -50}, {56, -50}, {56, -50}, {56, -50}}, color = {0, 0, 255}));
          connect(HTrecuperator_hot.wall, HTrecuperator_cold.wall) annotation(Line(points = {{42, 17}, {42, 17}, {42, -2}, {42, -2}}, color = {255, 238, 44}));
          connect(LTrecuperator_hot.inlet, HTrecuperator_hot.outlet) annotation(Line(points = {{-4, 22}, {32, 22}, {32, 22}, {32, 22}}, color = {159, 159, 223}));
          connect(flowjoin.outlet, HTrecuperator_cold.inlet) annotation(Line(points = {{20, -6}, {32, -6}, {32, -6}, {32, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(recompressor.outlet, flowjoin.inlet1) annotation(Line(points = {{-20, -42}, {8, -42}, {8, -10}, {8, -10}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.outlet, flowjoin.inlet2) annotation(Line(points = {{-4, -2}, {8, -2}, {8, -2}, {8, -2}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -42}, {-66, -42}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.outlet, flowsplit.inlet) annotation(Line(points = {{-24, 22}, {-34, 22}, {-34, 22}, {-34, 22}}, color = {159, 159, 223}));
          connect(flowsplit.outlet1, recompressor.inlet) annotation(Line(points = {{-46, 18}, {-46, 18}, {-46, -42}, {-36, -42}, {-36, -42}}, color = {159, 159, 223}));
          connect(flowsplit.outlet2, precooler_hot.inlet) annotation(Line(points = {{-46, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_hot.gas[" + String(i) + "].T = " + String(HTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_cold.gas[" + String(i) + "].T = " + String(HTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 321.803;
          precooler_hot.gas[3].T = 313.621;
          precooler_hot.gas[4].T = 309.429;
          precooler_hot.gas[5].T = 306.7;
          precooler_cold.water[2].T = 302.377;
          precooler_cold.water[3].T = 307.941;
          precooler_cold.water[4].T = 313.173;
          precooler_cold.water[5].T = 324.297;
          precooler_hot.gas[2].p = 8.04398e+006;
          LTrecuperator_hot.gas[2].T = 437.603;
          LTrecuperator_hot.gas[3].T = 420.069;
          LTrecuperator_hot.gas[4].T = 388.527;
          LTrecuperator_hot.gas[5].T = 352.404;
          LTrecuperator_cold.gas[2].T = 377.404;
          LTrecuperator_cold.gas[3].T = 412.526;
          LTrecuperator_cold.gas[4].T = 434.602;
          LTrecuperator_cold.gas[5].T = 443.176;
          HTrecuperator_hot.gas[2].T = 650.855;
          HTrecuperator_hot.gas[3].T = 537.597;
          HTrecuperator_hot.gas[4].T = 471.966;
          HTrecuperator_hot.gas[5].T = 444.1;
          HTrecuperator_cold.gas[2].T = 463.45;
          HTrecuperator_cold.gas[3].T = 518.903;
          HTrecuperator_cold.gas[4].T = 621.563;
          HTrecuperator_cold.gas[5].T = 767.891;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.1));
        end Add_Turbine;

        model Add_Solarcollector
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4 "Number of finite volumes in the Precooler";
          parameter Integer n_ltr = 4 "Number of finite volumes in the Low temperature recuperator";
          parameter Integer n_htr = 4 "Number of finite volumes in the High temperature recuperator";
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, p_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowSplit flowsplit annotation(Placement(visible = true, transformation(origin = {-40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_hot(n = n_ltr, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, p_start = 7.74e6, Tin_start = 436.34, Tout_start = 342.99) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_cold(n = n_ltr, HeatTransfer, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, Direction = false, p_start = 19.95e6, Tin_start = 333.51, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin annotation(Placement(visible = true, transformation(origin = {14, -6}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_cold(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, Direction = false, p_start = 19.94e6, Tin_start = 429.3, Tout_start = 760.09) annotation(Placement(visible = true, transformation(origin = {42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_hot(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, p_start = 7.85e6, Tin_start = 804.55, Tout_start = 436.34) annotation(Placement(visible = true, transformation(origin = {42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.TurbineStodola turbine(Tin_start = 926.175, p_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {64, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.SolarCollector solarcollector annotation(Placement(visible = true, transformation(origin = {56, -24}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_pressure1(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {88, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Source_MassFlow source_massflow1(T0 = 760.09, w0 = 121, p_start = 19.89e6) annotation(Placement(visible = true, transformation(origin = {38, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(source_massflow1.outlet, solarcollector.inlet) annotation(Line(points = {{48, 48}, {56, 48}, {56, -12}, {56, -12}}, color = {159, 159, 223}));
          connect(HTrecuperator_cold.outlet, sink_pressure1.inlet) annotation(Line(points = {{52, -6}, {78, -6}, {78, -6}, {78, -6}}, color = {159, 159, 223}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{56, -34}, {56, -34}, {56, -42}, {56, -42}}, color = {159, 159, 223}));
          connect(turbine.outlet, HTrecuperator_hot.inlet) annotation(Line(points = {{72, -42}, {72, -42}, {72, 22}, {52, 22}, {52, 22}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{72, -50}, {82, -50}, {82, -50}, {82, -50}}, color = {0, 0, 255}));
          connect(recompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-20, -50}, {56, -50}, {56, -50}, {56, -50}}, color = {0, 0, 255}));
          connect(HTrecuperator_hot.wall, HTrecuperator_cold.wall) annotation(Line(points = {{42, 17}, {42, 17}, {42, -2}, {42, -2}}, color = {255, 238, 44}));
          connect(LTrecuperator_hot.inlet, HTrecuperator_hot.outlet) annotation(Line(points = {{-4, 22}, {32, 22}, {32, 22}, {32, 22}}, color = {159, 159, 223}));
          connect(flowjoin.outlet, HTrecuperator_cold.inlet) annotation(Line(points = {{20, -6}, {32, -6}, {32, -6}, {32, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(recompressor.outlet, flowjoin.inlet1) annotation(Line(points = {{-20, -42}, {8, -42}, {8, -10}, {8, -10}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.outlet, flowjoin.inlet2) annotation(Line(points = {{-4, -2}, {8, -2}, {8, -2}, {8, -2}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -42}, {-66, -42}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.outlet, flowsplit.inlet) annotation(Line(points = {{-24, 22}, {-34, 22}, {-34, 22}, {-34, 22}}, color = {159, 159, 223}));
          connect(flowsplit.outlet1, recompressor.inlet) annotation(Line(points = {{-46, 18}, {-46, 18}, {-46, -42}, {-36, -42}, {-36, -42}}, color = {159, 159, 223}));
          connect(flowsplit.outlet2, precooler_hot.inlet) annotation(Line(points = {{-46, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          solarcollector.S = 25500000;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
//print("  LTrecuperator_cold.gas[2].p = " + String(LTrecuperator_cold.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_hot.gas[" + String(i) + "].T = " + String(HTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_cold.gas[" + String(i) + "].T = " + String(HTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 321.824;
          precooler_hot.gas[3].T = 313.634;
          precooler_hot.gas[4].T = 309.438;
          precooler_hot.gas[5].T = 306.705;
          precooler_cold.water[2].T = 302.381;
          precooler_cold.water[3].T = 307.949;
          precooler_cold.water[4].T = 313.186;
          precooler_cold.water[5].T = 324.325;
          precooler_hot.gas[2].p = 8.04566e+006;
          LTrecuperator_hot.gas[2].T = 438.143;
          LTrecuperator_hot.gas[3].T = 420.615;
          LTrecuperator_hot.gas[4].T = 388.897;
          LTrecuperator_hot.gas[5].T = 352.47;
          LTrecuperator_cold.gas[2].T = 377.68;
          LTrecuperator_cold.gas[3].T = 413.055;
          LTrecuperator_cold.gas[4].T = 435.159;
          LTrecuperator_cold.gas[5].T = 443.68;
          HTrecuperator_hot.gas[2].T = 658.07;
          HTrecuperator_hot.gas[3].T = 542.099;
          HTrecuperator_hot.gas[4].T = 473.95;
          HTrecuperator_hot.gas[5].T = 444.592;
          HTrecuperator_cold.gas[2].T = 464.995;
          HTrecuperator_cold.gas[3].T = 522.768;
          HTrecuperator_cold.gas[4].T = 628.219;
          HTrecuperator_cold.gas[5].T = 776.855;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.1));
        end Add_Solarcollector;

        model Close_circuit
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4 "Number of finite volumes in the Precooler";
          parameter Integer n_ltr = 4 "Number of finite volumes in the Low temperature recuperator";
          parameter Integer n_htr = 4 "Number of finite volumes in the High temperature recuperator";
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old precooler_hot(Di = 0.002, L = 0.9, Tin_start = 342.99, Tout_start = 304.84, k = 142, m = 31645, n = n_pc, p_start = 7.64e6, w_start = 70.2, wp = 0.008283185) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, Tout_start = 333.51, p_start = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-74, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-28, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old LTrecuperator_hot(Di = 0.002, L = 2, Tin_start = 436.34, Tout_start = 342.99, k = 826, m = 64495, n = n_ltr, p_start = 7.74e6, wp = 0.008283185, w_start = 121) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old LTrecuperator_cold(Di = 0.002, Direction = false, L = 2, Tin_start = 333.51, Tout_start = 429.3, k = 142, m = 64495, n = n_ltr, p_start = 19.95e6, wp = 0.008283185, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin annotation(Placement(visible = true, transformation(origin = {14, -6}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old HTrecuperator_cold(Di = 0.002, Direction = false, L = 2.3, Tin_start = 429.3, Tout_start = 760.09, k = 413, m = 86890, n = n_htr, p_start = 19.94e6, wp = 0.008283185) annotation(Placement(visible = true, transformation(origin = {42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger_old HTrecuperator_hot(Di = 0.002, L = 2.3, Tin_start = 804.55, Tout_start = 436.34, k = 909, m = 86890, n = n_htr, p_start = 7.85e6, wp = 0.008283185) annotation(Placement(visible = true, transformation(origin = {42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.TurbineStodola turbine(Tin_start = 926.175, p_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {64, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.SolarCollector solarcollector annotation(Placement(visible = true, transformation(origin = {56, -24}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
          Components.Gas.FlowSplit flowSplit1 annotation(Placement(visible = true, transformation(origin = {-42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        equation
          connect(LTrecuperator_hot.outlet, flowSplit1.inlet) annotation(Line(points = {{-24, 22}, {-36, 22}, {-36, 22}, {-36, 22}}, color = {159, 159, 223}));
          connect(flowSplit1.outlet1, recompressor.inlet) annotation(Line(points = {{-48, 18}, {-48, 18}, {-48, -42}, {-36, -42}, {-36, -42}}, color = {159, 159, 223}));
          connect(precooler_hot.inlet, flowSplit1.outlet2) annotation(Line(points = {{-62, 26}, {-48, 26}, {-48, 26}, {-48, 26}}, color = {159, 159, 223}));
          connect(HTrecuperator_cold.outlet, solarcollector.inlet) annotation(Line(points = {{52, -6}, {56, -6}, {56, -14}, {56, -14}}, color = {159, 159, 223}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{56, -34}, {56, -34}, {56, -42}, {56, -42}}, color = {159, 159, 223}));
          connect(turbine.outlet, HTrecuperator_hot.inlet) annotation(Line(points = {{72, -42}, {72, -42}, {72, 22}, {52, 22}, {52, 22}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{72, -50}, {82, -50}, {82, -50}, {82, -50}}, color = {0, 0, 255}));
          connect(recompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-20, -50}, {56, -50}, {56, -50}, {56, -50}}, color = {0, 0, 255}));
          connect(HTrecuperator_hot.wall, HTrecuperator_cold.wall) annotation(Line(points = {{42, 17}, {42, 17}, {42, -2}, {42, -2}}, color = {255, 238, 44}));
          connect(LTrecuperator_hot.inlet, HTrecuperator_hot.outlet) annotation(Line(points = {{-4, 22}, {32, 22}, {32, 22}, {32, 22}}, color = {159, 159, 223}));
          connect(flowjoin.outlet, HTrecuperator_cold.inlet) annotation(Line(points = {{20, -6}, {32, -6}, {32, -6}, {32, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(recompressor.outlet, flowjoin.inlet1) annotation(Line(points = {{-20, -42}, {8, -42}, {8, -10}, {8, -10}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.outlet, flowjoin.inlet2) annotation(Line(points = {{-4, -2}, {8, -2}, {8, -2}, {8, -2}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -42}, {-66, -42}}, color = {159, 159, 223}));
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -50}, {-36, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 255}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -42}, {-82, -42}, {-82, 26}, {-82, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          solarcollector.S = 25500000;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
//print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
//print("  LTrecuperator_cold.gas[2].p = " + String(LTrecuperator_cold.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_hot.gas[" + String(i) + "].T = " + String(HTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_cold.gas[" + String(i) + "].T = " + String(HTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 323.385;
          precooler_hot.gas[3].T = 315.189;
          precooler_hot.gas[4].T = 310.816;
          precooler_hot.gas[5].T = 307.173;
          precooler_cold.water[2].T = 302.721;
          precooler_cold.water[3].T = 309.042;
          precooler_cold.water[4].T = 314.65;
          precooler_cold.water[5].T = 325.753;
          precooler_hot.gas[2].p = 8.33646e+006;
          LTrecuperator_hot.gas[2].T = 439.812;
          LTrecuperator_hot.gas[3].T = 423.81;
          LTrecuperator_hot.gas[4].T = 392.262;
          LTrecuperator_hot.gas[5].T = 352.271;
          LTrecuperator_cold.gas[2].T = 380.509;
          LTrecuperator_cold.gas[3].T = 416.678;
          LTrecuperator_cold.gas[4].T = 437.231;
          LTrecuperator_cold.gas[5].T = 444.525;
          LTrecuperator_cold.gas[2].p = 2.05634e+007;
          HTrecuperator_hot.gas[2].T = 692.172;
          HTrecuperator_hot.gas[3].T = 561.908;
          HTrecuperator_hot.gas[4].T = 481.467;
          HTrecuperator_hot.gas[5].T = 445.265;
          HTrecuperator_cold.gas[2].T = 470.422;
          HTrecuperator_cold.gas[3].T = 539.322;
          HTrecuperator_cold.gas[4].T = 659.095;
          HTrecuperator_cold.gas[5].T = 820.964;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.1));
        end Close_circuit;

        model Add_valve
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pc = 4 "Number of finite volumes in the Precooler";
          parameter Integer n_ltr = 4 "Number of finite volumes in the Low temperature recuperator";
          parameter Integer n_htr = 4 "Number of finite volumes in the High temperature recuperator";
          SimpleBrayton.Components.Gas.Source_MassFlow source_water(T0 = 293, use_in_w = true, redeclare SimpleBrayton.Substances.WaterLiquid gas) annotation(Placement(visible = true, transformation(origin = {-82, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
          SimpleBrayton.Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-34, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger precooler_hot(n = n_pc, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 7.64e6, Tin_start = 342.99, Tout_start = 304.84, w_start = 70.2) annotation(Placement(visible = true, transformation(origin = {-72, 26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Water.WaterHeatExchanger precooler_cold(n = n_pc, Direction = false, Di = 0.002, L = 0.9, wp = 0.008283185, m = 31645, p_start = 101325, Tin_start = 293, Tout_start = 318, w_start = 85) annotation(Placement(visible = true, transformation(origin = {-72, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.FlowSplit flowsplit1 annotation(Placement(visible = true, transformation(origin = {-40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_hot(n = n_ltr, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, p_start = 7.74e6, Tin_start = 436.34, Tout_start = 342.99) annotation(Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.Heat_Exchanger LTrecuperator_cold(n = n_ltr, HeatTransfer, Di = 0.002, L = 2, wp = 0.008283185, m = 64495, Direction = false, p_start = 19.95e6, Tin_start = 333.51, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin1 annotation(Placement(visible = true, transformation(origin = {14, -6}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_cold(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, Direction = false, p_start = 19.94e6, Tin_start = 429.3, Tout_start = 760.09) annotation(Placement(visible = true, transformation(origin = {42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.Heat_Exchanger HTrecuperator_hot(n = n_htr, Di = 0.002, L = 2.3, wp = 0.008283185, m = 86890, p_start = 7.85e6, Tin_start = 804.55, Tout_start = 436.34) annotation(Placement(visible = true, transformation(origin = {42, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          SimpleBrayton.Components.Gas.MainCompressor maincompressor(Tin_start = 304.84, p_start = 7.63e6, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-74, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.ReCompressor recompressor(Tin_start = 342.99, p_start = 7.64e6, Tout_start = 429.3) annotation(Placement(visible = true, transformation(origin = {-28, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowSplit flowsplit2 annotation(Placement(visible = true, transformation(origin = {52, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          SimpleBrayton.Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {82, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.TurbineStodola turbine(Tin_start = 926.175, p_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {56, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          SimpleBrayton.Components.Gas.SolarCollector solarcollector annotation(Placement(visible = true, transformation(origin = {48, -58}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
          SimpleBrayton.Components.Gas.Valve valve annotation(Placement(visible = true, transformation(origin = {70, -32}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
          SimpleBrayton.Components.Gas.FlowJoin flowjoin2 annotation(Placement(visible = true, transformation(origin = {90, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        equation
          connect(maincompressor.shaft_r, recompressor.shaft_l) annotation(Line(points = {{-66, -84}, {-36, -84}, {-36, -84}, {-36, -84}}, color = {0, 0, 255}));
          connect(flowjoin2.outlet, HTrecuperator_hot.inlet) annotation(Line(points = {{90, -20}, {90, -20}, {90, 22}, {52, 22}, {52, 22}}, color = {159, 159, 223}));
          connect(turbine.outlet, flowjoin2.inlet2) annotation(Line(points = {{64, -76}, {94, -76}, {94, -32}, {94, -32}}, color = {159, 159, 223}));
          connect(flowsplit2.outlet2, solarcollector.inlet) annotation(Line(points = {{48, -32}, {48, -32}, {48, -48}, {48, -48}}, color = {159, 159, 223}));
          connect(valve.outlet, flowjoin2.inlet1) annotation(Line(points = {{78, -32}, {84, -32}, {84, -32}, {84, -32}}, color = {159, 159, 223}));
          connect(flowsplit2.outlet1, valve.inlet) annotation(Line(points = {{56, -32}, {62, -32}}, color = {159, 159, 223}));
          connect(HTrecuperator_cold.outlet, flowsplit2.inlet) annotation(Line(points = {{52, -6}, {52, -6}, {52, -20}, {52, -20}}, color = {159, 159, 223}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{48, -68}, {48, -68}, {48, -78}, {48, -78}, {48, -76}, {48, -76}}, color = {159, 159, 223}));
          connect(recompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-20, -84}, {48, -84}}, color = {0, 0, 255}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{64, -84}, {74, -84}}, color = {0, 0, 255}));
          connect(flowsplit1.outlet1, recompressor.inlet) annotation(Line(points = {{-46, 18}, {-46, -76}, {-36, -76}}, color = {159, 159, 223}));
          connect(recompressor.outlet, flowjoin1.inlet1) annotation(Line(points = {{-20, -76}, {8, -76}, {8, -10}}, color = {159, 159, 223}));
          connect(maincompressor.inlet, precooler_hot.outlet) annotation(Line(points = {{-82, -76}, {-82, 26}}, color = {159, 159, 223}));
          connect(LTrecuperator_cold.inlet, maincompressor.outlet) annotation(Line(points = {{-24, -2}, {-66, -2}, {-66, -76}}, color = {159, 159, 223}));
          connect(HTrecuperator_hot.wall, HTrecuperator_cold.wall) annotation(Line(points = {{42, 17}, {42, 17}, {42, -2}, {42, -2}}, color = {255, 238, 44}));
          connect(LTrecuperator_hot.inlet, HTrecuperator_hot.outlet) annotation(Line(points = {{-4, 22}, {32, 22}, {32, 22}, {32, 22}}, color = {159, 159, 223}));
          connect(flowjoin1.outlet, HTrecuperator_cold.inlet) annotation(Line(points = {{20, -6}, {32, -6}, {32, -6}, {32, -6}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.wall, LTrecuperator_cold.wall) annotation(Line(points = {{-14, 17}, {-14, 17}, {-14, 2}, {-14, 2}}, color = {255, 238, 44}));
          connect(LTrecuperator_cold.outlet, flowjoin1.inlet2) annotation(Line(points = {{-4, -2}, {8, -2}, {8, -2}, {8, -2}}, color = {159, 159, 223}));
          connect(LTrecuperator_hot.outlet, flowsplit1.inlet) annotation(Line(points = {{-24, 22}, {-34, 22}, {-34, 22}, {-34, 22}}, color = {159, 159, 223}));
          connect(flowsplit1.outlet2, precooler_hot.inlet) annotation(Line(points = {{-46, 26}, {-62, 26}, {-62, 26}, {-62, 26}}, color = {159, 159, 223}));
          connect(precooler_cold.wall, precooler_hot.wall) annotation(Line(points = {{-72, 51}, {-72, 51}, {-72, 30}, {-72, 30}}, color = {255, 238, 44}));
          connect(precooler_cold.outlet, sink_water.inlet) annotation(Line(points = {{-62, 56}, {-44, 56}, {-44, 56}, {-44, 56}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler_cold.inlet) annotation(Line(points = {{-82, 74}, {-82, 74}, {-82, 56}, {-82, 56}}, color = {159, 159, 223}));
          source_water.in_w = 85;
          solarcollector.S = 25500000;
          valve.k = 1e-5;
          when terminal() then
            for i in 2:n_pc + 1 loop
              print("  precooler_hot.gas[" + String(i) + "].T = " + String(precooler_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pc + 1 loop
              print("  precooler_cold.water[" + String(i) + "].T = " + String(precooler_cold.water[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  precooler_hot.gas[2].p = " + String(precooler_hot.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_hot.gas[" + String(i) + "].T = " + String(LTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  LTrecuperator_cold.gas[" + String(i) + "].T = " + String(LTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("  LTrecuperator_cold.gas[2].p = " + String(LTrecuperator_cold.gas[2].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_hot.gas[" + String(i) + "].T = " + String(HTrecuperator_hot.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  HTrecuperator_cold.gas[" + String(i) + "].T = " + String(HTrecuperator_cold.gas[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print("end", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler_hot.gas[2].T = 323.385;
          precooler_hot.gas[3].T = 315.189;
          precooler_hot.gas[4].T = 310.816;
          precooler_hot.gas[5].T = 307.173;
          precooler_cold.water[2].T = 302.721;
          precooler_cold.water[3].T = 309.042;
          precooler_cold.water[4].T = 314.65;
          precooler_cold.water[5].T = 325.753;
          precooler_hot.gas[2].p = 8.33646e+006;
          LTrecuperator_hot.gas[2].T = 439.812;
          LTrecuperator_hot.gas[3].T = 423.81;
          LTrecuperator_hot.gas[4].T = 392.262;
          LTrecuperator_hot.gas[5].T = 352.271;
          LTrecuperator_cold.gas[2].T = 380.509;
          LTrecuperator_cold.gas[3].T = 416.678;
          LTrecuperator_cold.gas[4].T = 437.231;
          LTrecuperator_cold.gas[5].T = 444.525;
          LTrecuperator_cold.gas[2].p = 2.05634e+007;
          HTrecuperator_hot.gas[2].T = 692.172;
          HTrecuperator_hot.gas[3].T = 561.908;
          HTrecuperator_hot.gas[4].T = 481.467;
          HTrecuperator_hot.gas[5].T = 445.265;
          HTrecuperator_cold.gas[2].T = 470.422;
          HTrecuperator_cold.gas[3].T = 539.322;
          HTrecuperator_cold.gas[4].T = 659.095;
          HTrecuperator_cold.gas[5].T = 820.964;
          annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-06, Interval = 0.1));
        end Add_valve;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Progressive_testing_old;

      package Progressive_testing
        model Precooler
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-78, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 70.2, T0 = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-4, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          connect(source_MassFlow1.outlet, precooler.inlet_hot) annotation(Line(points = {{-14, 46}, {-36, 46}, {-36, 45}, {-52, 45}}, color = {159, 159, 223}));
          connect(sink_Pressure1.inlet, precooler.outlet_hot) annotation(Line(points = {{-88, 14}, {-88, 14}, {-88, 46}, {-72, 46}, {-72, 46}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_hot.T[2:7] = {320.759, 313.357, 309.677, 307.39, 305.894, 304.831};
          precooler.pipe_cold.T[2:7] = {299.255, 303.194, 305.65, 308.092, 311.423, 318.157};
          precooler.wall.T = {302.114, 304.993, 306.771, 309.207, 312.943, 321.231};
          annotation(experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end Precooler;

        model Add_Recompressor
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-4, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.94e6) annotation(Placement(visible = true, transformation(origin = {12, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-22, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure2(p0 = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-64, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(precooler.outlet_hot, sink_Pressure2.inlet) annotation(Line(points = {{-72, 45}, {-80, 45}, {-80, 8}, {-74, 8}, {-74, 8}}, color = {159, 159, 223}));
          connect(reCompressor.outlet, sink_Pressure1.inlet) annotation(Line(points = {{-14, -60}, {-14, -60}, {-14, 16}, {2, 16}, {2, 16}}, color = {159, 159, 223}));
          connect(source_MassFlow1.outlet, reCompressor.inlet) annotation(Line(points = {{-14, 46}, {-30, 46}, {-30, -60}}, color = {159, 159, 223}));
          connect(reCompressor.shaft_r, grid1.connection) annotation(Line(points = {{-14, -68}, {64, -68}, {64, -78}}, color = {0, 0, 255}));
          connect(source_MassFlow1.outlet, precooler.inlet_hot) annotation(Line(points = {{-14, 46}, {-36, 46}, {-36, 45}, {-52, 45}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_hot.T[2:7] = {320.968, 313.636, 309.991, 307.723, 306.151, 305.288};
          precooler.pipe_cold.T[2:7] = {300.676, 303.881, 306.128, 308.469, 311.727, 318.381};
          precooler.wall.T = {303.268, 305.346, 307.154, 309.538, 313.214, 321.419};
          annotation(experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end Add_Recompressor;

        model Add_MainCompressor
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 342.99, p_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-4, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-22, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure2(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {-48, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.94e6) annotation(Placement(visible = true, transformation(origin = {10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(source_MassFlow1.outlet, reCompressor1.inlet) annotation(Line(points = {{-14, 46}, {-30, 46}, {-30, -60}, {-30, -60}}, color = {159, 159, 223}));
          connect(reCompressor1.outlet, sink_Pressure1.inlet) annotation(Line(points = {{-14, -60}, {-14, -50}, {0, -50}}, color = {159, 159, 223}));
          connect(mainCompressor1.outlet, sink_Pressure2.inlet) annotation(Line(points = {{-64, -60}, {-64, -60}, {-64, -26}, {-58, -26}, {-58, -26}}, color = {159, 159, 223}));
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-30, -68}}, color = {0, 0, 255}));
          connect(reCompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-14, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(source_MassFlow1.outlet, precooler.inlet_hot) annotation(Line(points = {{-14, 46}, {-36, 46}, {-36, 45}, {-52, 45}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_hot.T[2:7] = {320.968, 313.636, 309.991, 307.723, 306.151, 305.288};
          precooler.pipe_cold.T[2:7] = {300.676, 303.881, 306.128, 308.469, 311.727, 318.381};
          precooler.wall.T = {303.268, 305.346, 307.154, 309.538, 313.214, 321.419};
          precooler.pipe_hot.fluid[n_pr + 1].p = 7.63e6;
          annotation(experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.04));
        end Add_MainCompressor;

        model Add_LTRecuperator
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor annotation(Placement(visible = true, transformation(origin = {-22, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr, Tin_start_cold = 342) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.94e6) annotation(Placement(visible = true, transformation(origin = {34, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 436.34, p_start = 7.74e6) annotation(Placement(visible = true, transformation(origin = {56, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          connect(ltrecuperator.outlet_hot, reCompressor.inlet) annotation(Line(points = {{-30, 45}, {-40, 45}, {-40, -60}, {-32, -60}, {-32, -60}}, color = {159, 159, 223}));
          connect(source_MassFlow1.outlet, ltrecuperator.inlet_hot) annotation(Line(points = {{46, 46}, {0, 46}, {0, 46}, {-10, 46}, {-10, 46}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, sink_Pressure1.inlet) annotation(Line(points = {{-10, 35}, {24, 35}, {24, 2}, {24, 2}}, color = {159, 159, 223}));
          connect(reCompressor.outlet, sink_Pressure1.inlet) annotation(Line(points = {{-14, -60}, {-14, 2}, {24, 2}}, color = {159, 159, 223}));
          connect(mainCompressor.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, -60}, {-64, 34}, {-30, 34}, {-30, 34}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-30, 45}, {-30, 46}, {-30, 46}}, color = {159, 159, 223}));
          connect(mainCompressor.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(mainCompressor.shaft_r, reCompressor.shaft_l) annotation(Line(points = {{-64, -68}, {-30, -68}}, color = {0, 0, 255}));
          connect(reCompressor.shaft_r, grid.connection) annotation(Line(points = {{-14, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_cold.fluid[" + String(i) + "].T = " + String(precooler.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_hot.fluid[" + String(i) + "].T = " + String(precooler.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.fluid.T", precooler.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.fluid.T", precooler.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.fluid[2].T = 299.474;
          precooler.pipe_cold.fluid[3].T = 303.287;
          precooler.pipe_cold.fluid[4].T = 305.731;
          precooler.pipe_cold.fluid[5].T = 308.276;
          precooler.pipe_cold.fluid[6].T = 311.951;
          precooler.pipe_cold.fluid[7].T = 320.449;
          precooler.pipe_hot.fluid[2].T = 322.342;
          precooler.pipe_hot.fluid[3].T = 313.747;
          precooler.pipe_hot.fluid[4].T = 309.718;
          precooler.pipe_hot.fluid[5].T = 307.29;
          precooler.pipe_hot.fluid[6].T = 305.681;
          precooler.pipe_hot.fluid[7].T = 304.76;
          precooler.wall.T = {302.197, 304.891, 306.759, 309.345, 313.496, 324.02};
          ltrecuperator.pipe_cold.fluid[2].T = 371.29;
          ltrecuperator.pipe_cold.fluid[3].T = 403.935;
          ltrecuperator.pipe_cold.fluid[4].T = 430.342;
          ltrecuperator.pipe_hot.fluid[2].T = 414.099;
          ltrecuperator.pipe_hot.fluid[3].T = 383.02;
          ltrecuperator.pipe_hot.fluid[4].T = 352.324;
          ltrecuperator.wall.T = {362.181, 393.139, 421.232};
          precooler.pipe_hot.fluid[7].p = 7.58413e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.59424e+006;
          annotation(experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
        end Add_LTRecuperator;

        model Add_HTRecuperator
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Integer n_htr = 3;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1 annotation(Placement(visible = true, transformation(origin = {-22, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1 annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.89e6) annotation(Placement(visible = true, transformation(origin = {76, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr) annotation(Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 804.55, p_start = 7.85e6) annotation(Placement(visible = true, transformation(origin = {78, 64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          connect(source_MassFlow1.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{68, 64}, {50, 64}, {50, 45}, {32, 45}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, sink_Pressure1.inlet) annotation(Line(points = {{32, 35}, {46, 35}, {46, -2}, {66, -2}, {66, -2}}, color = {159, 159, 223}));
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-14, -60}, {-4, -60}, {-4, 34}, {12, 34}, {12, 34}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{-10, 35}, {12, 35}, {12, 34}, {12, 34}}, color = {159, 159, 223}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{-10, 45}, {12, 45}, {12, 44}, {12, 44}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-30, 45}, {-40, 45}, {-40, -60}, {-32, -60}, {-32, -60}}, color = {159, 159, 223}));
          connect(mainCompressor1.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, -60}, {-64, 34}, {-30, 34}, {-30, 34}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-30, 45}, {-30, 46}, {-30, 46}}, color = {159, 159, 223}));
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-30, -68}}, color = {0, 0, 255}));
          connect(reCompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-14, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_cold.fluid[" + String(i) + "].T = " + String(precooler.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_hot.fluid[" + String(i) + "].T = " + String(precooler.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.fluid.T", precooler.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.fluid.T", precooler.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.fluid.T", ltrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.fluid.T", ltrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.fluid[2].T = 299.538;
          precooler.pipe_cold.fluid[3].T = 303.483;
          precooler.pipe_cold.fluid[4].T = 306.015;
          precooler.pipe_cold.fluid[5].T = 308.644;
          precooler.pipe_cold.fluid[6].T = 312.46;
          precooler.pipe_cold.fluid[7].T = 321.372;
          precooler.pipe_hot.fluid[2].T = 323.223;
          precooler.pipe_hot.fluid[3].T = 314.275;
          precooler.pipe_hot.fluid[4].T = 310.115;
          precooler.pipe_hot.fluid[5].T = 307.617;
          precooler.pipe_hot.fluid[6].T = 305.965;
          precooler.pipe_hot.fluid[7].T = 304.902;
          precooler.wall.T = {302.288, 305.142, 307.079, 309.75, 314.064, 325.117};
          ltrecuperator.pipe_cold.fluid[2].T = 379.951;
          ltrecuperator.pipe_cold.fluid[3].T = 421.934;
          ltrecuperator.pipe_cold.fluid[4].T = 450.835;
          ltrecuperator.pipe_hot.fluid[2].T = 433.336;
          ltrecuperator.pipe_hot.fluid[3].T = 395.546;
          ltrecuperator.pipe_hot.fluid[4].T = 354.814;
          ltrecuperator.wall.T = {368.033, 407.917, 440.747};
          htrecuperator.pipe_cold.fluid[2].T = 502.325;
          htrecuperator.pipe_cold.fluid[3].T = 608.911;
          htrecuperator.pipe_cold.fluid[4].T = 763.362;
          htrecuperator.pipe_hot.fluid[2].T = 641.816;
          htrecuperator.pipe_hot.fluid[3].T = 522.811;
          htrecuperator.pipe_hot.fluid[4].T = 456.301;
          htrecuperator.wall.T = {481.449, 567.853, 703.469};
          ltrecuperator.pipe_cold.fluid[4].p = 1.994e+007;
          precooler.pipe_hot.fluid[7].p = 7.63012e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.64031e+006;
          htrecuperator.pipe_hot.fluid[4].p = 7.74031e+006;
        end Add_HTRecuperator;

        model Add_turbine
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Integer n_htr = 3;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr) annotation(Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.TurbineStodola turbineStodola1(Tin_start = 926.175, pin_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {36, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 926.175, p_start = 19.38e6) annotation(Placement(visible = true, transformation(origin = {36, -36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.89e6) annotation(Placement(visible = true, transformation(origin = {46, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-36, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-28, -60}, {-8, -60}, {-8, 34}, {6, 34}, {6, 34}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-54, -68}, {-54, -68}, {-44, -68}}, color = {0, 0, 255}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-36, 45}, {-44, 45}, {-44, -60}}, color = {159, 159, 223}));
          connect(reCompressor1.shaft_r, turbineStodola1.shaft_l) annotation(Line(points = {{-28, -68}, {28, -68}}, color = {0, 0, 255}));
          connect(htrecuperator.outlet_cold, sink_Pressure1.inlet) annotation(Line(points = {{26, 35}, {36, 35}, {36, 14}, {36, 14}}, color = {159, 159, 223}));
          connect(source_MassFlow1.outlet, turbineStodola1.inlet) annotation(Line(points = {{26, -36}, {20, -36}, {20, -60}, {28, -60}, {28, -60}}, color = {159, 159, 223}));
          connect(turbineStodola1.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{44, -60}, {66, -60}, {66, 44}, {28, 44}, {28, 44}}, color = {159, 159, 223}));
          connect(turbineStodola1.shaft_r, grid1.connection) annotation(Line(points = {{44, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{-16, 45}, {6, 45}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{-16, 35}, {6, 35}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-36, 45}}, color = {159, 159, 223}));
          connect(mainCompressor1.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 35}, {-36, 35}}, color = {159, 159, 223}));
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_cold.fluid[" + String(i) + "].T = " + String(precooler.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_hot.fluid[" + String(i) + "].T = " + String(precooler.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.fluid.T", precooler.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.fluid.T", precooler.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.fluid.T", ltrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.fluid.T", ltrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.fluid[2].T = 299.538;
          precooler.pipe_cold.fluid[3].T = 303.484;
          precooler.pipe_cold.fluid[4].T = 306.016;
          precooler.pipe_cold.fluid[5].T = 308.646;
          precooler.pipe_cold.fluid[6].T = 312.462;
          precooler.pipe_cold.fluid[7].T = 321.376;
          precooler.pipe_hot.fluid[2].T = 323.227;
          precooler.pipe_hot.fluid[3].T = 314.277;
          precooler.pipe_hot.fluid[4].T = 310.117;
          precooler.pipe_hot.fluid[5].T = 307.618;
          precooler.pipe_hot.fluid[6].T = 305.967;
          precooler.pipe_hot.fluid[7].T = 304.902;
          precooler.wall.T = {302.289, 305.143, 307.081, 309.752, 314.066, 325.122};
          ltrecuperator.pipe_cold.fluid[2].T = 379.991;
          ltrecuperator.pipe_cold.fluid[3].T = 422.016;
          ltrecuperator.pipe_cold.fluid[4].T = 450.926;
          ltrecuperator.pipe_hot.fluid[2].T = 433.422;
          ltrecuperator.pipe_hot.fluid[3].T = 395.603;
          ltrecuperator.pipe_hot.fluid[4].T = 354.825;
          ltrecuperator.wall.T = {368.06, 407.984, 440.834};
          htrecuperator.pipe_cold.fluid[2].T = 502.544;
          htrecuperator.pipe_cold.fluid[3].T = 609.346;
          htrecuperator.pipe_cold.fluid[4].T = 763.988;
          htrecuperator.pipe_hot.fluid[2].T = 642.3;
          htrecuperator.pipe_hot.fluid[3].T = 523.081;
          htrecuperator.pipe_hot.fluid[4].T = 456.389;
          htrecuperator.wall.T = {481.606, 568.203, 704.02};
          ltrecuperator.pipe_cold.fluid[4].p = 1.994e+007;
          precooler.pipe_hot.fluid[7].p = 7.63034e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.64053e+006;
          htrecuperator.pipe_hot.fluid[4].p = 7.74053e+006;
        end Add_turbine;

        model Add_solarcollector
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Integer n_htr = 3;
          parameter Integer n_sc = 3;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr) annotation(Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.TurbineStodola turbine(Tin_start = 926.175, pin_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {36, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure1(p0 = 19.89e6) annotation(Placement(visible = true, transformation(origin = {46, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-36, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 121, T0 = 758.71, p_start = 19.89e6) annotation(Placement(visible = true, transformation(origin = {86, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Gas.SolarCollector solarcollector(n = n_sc) annotation(Placement(visible = true, transformation(origin = {28, -34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-74, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(ltrecuperator.inlet_cold, mainCompressor1.outlet) annotation(Line(points = {{-30, 35}, {-66, 35}, {-66, -60}, {-66, -60}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{-10, 35}, {10, 35}, {10, 34}, {10, 34}}, color = {159, 159, 223}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{-10, 45}, {12, 45}, {12, 44}, {12, 44}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-30, 45}, {-44, 45}, {-44, -60}, {-44, -60}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-30, 45}, {-30, 46}, {-30, 46}}, color = {159, 159, 223}));
          connect(precooler.outlet_hot, mainCompressor1.inlet) annotation(Line(points = {{-72, 45}, {-82, 45}, {-82, -60}, {-82, -60}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-66, -68}, {-44, -68}}, color = {0, 0, 255}));
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-28, -60}, {-28, -60}, {-28, 14}, {0, 14}, {0, 34}, {12, 34}, {12, 34}}, color = {159, 159, 223}));
          solarcollector.S = 25500000;
          connect(solarcollector.inlet, source_MassFlow1.outlet) annotation(Line(points = {{28, -24}, {28, -24}, {28, -8}, {76, -8}, {76, -8}}, color = {159, 159, 223}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{28, -44}, {28, -44}, {28, -60}, {28, -60}}, color = {159, 159, 223}));
          connect(reCompressor1.shaft_r, turbine.shaft_l) annotation(Line(points = {{-28, -68}, {28, -68}}, color = {0, 0, 255}));
          connect(htrecuperator.outlet_cold, sink_Pressure1.inlet) annotation(Line(points = {{26, 35}, {36, 35}, {36, 14}, {36, 14}}, color = {159, 159, 223}));
          connect(turbine.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{44, -60}, {66, -60}, {66, 44}, {28, 44}, {28, 44}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid1.connection) annotation(Line(points = {{44, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_cold.fluid[" + String(i) + "].T = " + String(precooler.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_hot.fluid[" + String(i) + "].T = " + String(precooler.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.fluid.T", precooler.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.fluid.T", precooler.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.fluid.T", ltrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.fluid.T", ltrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_sc + 1 loop
              print("  solarcollector.pipe.fluid[" + String(i) + "].T = " + String(solarcollector.pipe.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  solarcollector.pipe.fluid[" + String(n_sc + 1) + "].p = " + String(solarcollector.pipe.fluid[n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.fluid[2].T = 299.538;
          precooler.pipe_cold.fluid[3].T = 303.484;
          precooler.pipe_cold.fluid[4].T = 306.016;
          precooler.pipe_cold.fluid[5].T = 308.646;
          precooler.pipe_cold.fluid[6].T = 312.462;
          precooler.pipe_cold.fluid[7].T = 321.376;
          precooler.pipe_hot.fluid[2].T = 323.227;
          precooler.pipe_hot.fluid[3].T = 314.277;
          precooler.pipe_hot.fluid[4].T = 310.117;
          precooler.pipe_hot.fluid[5].T = 307.618;
          precooler.pipe_hot.fluid[6].T = 305.967;
          precooler.pipe_hot.fluid[7].T = 304.902;
          precooler.wall.T = {302.289, 305.143, 307.081, 309.752, 314.066, 325.122};
          ltrecuperator.pipe_cold.fluid[2].T = 379.991;
          ltrecuperator.pipe_cold.fluid[3].T = 422.017;
          ltrecuperator.pipe_cold.fluid[4].T = 450.926;
          ltrecuperator.pipe_hot.fluid[2].T = 433.423;
          ltrecuperator.pipe_hot.fluid[3].T = 395.604;
          ltrecuperator.pipe_hot.fluid[4].T = 354.825;
          ltrecuperator.wall.T = {368.061, 407.985, 440.835};
          htrecuperator.pipe_cold.fluid[2].T = 502.542;
          htrecuperator.pipe_cold.fluid[3].T = 609.34;
          htrecuperator.pipe_cold.fluid[4].T = 763.976;
          htrecuperator.pipe_hot.fluid[2].T = 642.293;
          htrecuperator.pipe_hot.fluid[3].T = 523.079;
          htrecuperator.pipe_hot.fluid[4].T = 456.389;
          htrecuperator.wall.T = {481.606, 568.199, 704.01};
          solarcollector.pipe.fluid[2].T = 814.644;
          solarcollector.pipe.fluid[3].T = 870.586;
          solarcollector.pipe.fluid[4].T = 926.158;
          solarcollector.wall.T = {806.953, 862.992, 918.65};
          ltrecuperator.pipe_cold.fluid[4].p = 1.994e+007;
          precooler.pipe_hot.fluid[7].p = 7.63034e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.64053e+006;
          htrecuperator.pipe_hot.fluid[4].p = 7.74053e+006;
          solarcollector.pipe.fluid[4].p = 1.93801e+007;
          annotation(experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 0.2));
        end Add_solarcollector;

        model Closed_circuit
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Integer n_htr = 3;
          parameter Integer n_sc = 3;
          parameter Real w_water = 100;
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr) annotation(Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr) annotation(Placement(visible = true, transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-36, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.SolarCollector solarcollector(n = n_sc, w_start = 121, pout_start = 19.38e6, Tin_start = 760.09, Tout_start = 926.175, k = 4200) annotation(Placement(visible = true, transformation(origin = {32, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Components.Gas.TurbineStodola turbine(Tin_start = 926.175, pin_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {40, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(htrecuperator.inlet_hot, turbine.outlet) annotation(Line(points = {{26, 45}, {70, 45}, {70, -60}, {48, -60}, {48, -60}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, solarcollector.inlet) annotation(Line(points = {{26, 35}, {32, 35}, {32, -24}, {32, -24}}, color = {159, 159, 223}));
          connect(reCompressor1.shaft_r, turbine.shaft_l) annotation(Line(points = {{-28, -68}, {32, -68}}, color = {0, 0, 255}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{32, -46}, {32, -60}}, color = {159, 159, 223}));
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-28, -60}, {-6, -60}, {-6, 36}, {6, 36}, {6, 36}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{54, -68}, {64, -68}}, color = {0, 0, 255}));
          solarcollector.S = 25500000;
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-54, -68}, {-54, -68}, {-44, -68}}, color = {0, 0, 255}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-36, 45}, {-44, 45}, {-44, -60}}, color = {159, 159, 223}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{-16, 45}, {6, 45}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{-16, 35}, {6, 35}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-36, 45}}, color = {159, 159, 223}));
          connect(mainCompressor1.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 35}, {-36, 35}}, color = {159, 159, 223}));
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_cold.fluid[" + String(i) + "].T = " + String(precooler.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_pr + 1 loop
              print("  precooler.pipe_hot.fluid[" + String(i) + "].T = " + String(precooler.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.fluid.T", precooler.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.fluid.T", precooler.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_ltr + 1 loop
              print("  ltrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(ltrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.fluid.T", ltrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.fluid.T", ltrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_cold.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_cold.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            for i in 2:n_htr + 1 loop
              print("  htrecuperator.pipe_hot.fluid[" + String(i) + "].T = " + String(htrecuperator.pipe_hot.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            for i in 2:n_sc + 1 loop
              print("  solarcollector.pipe.fluid[" + String(i) + "].T = " + String(solarcollector.pipe.fluid[i].T) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            end for;
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.fluid.T", htrecuperator.pipe_cold.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
//print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.fluid.T", htrecuperator.pipe_hot.fluid.T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  solarcollector.pipe.fluid[" + String(n_sc + 1) + "].p = " + String(solarcollector.pipe.fluid[n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_cold.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_cold.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.fluid[2].T = 299.585;
          precooler.pipe_cold.fluid[3].T = 303.757;
          precooler.pipe_cold.fluid[4].T = 306.403;
          precooler.pipe_cold.fluid[5].T = 309.099;
          precooler.pipe_cold.fluid[6].T = 312.973;
          precooler.pipe_cold.fluid[7].T = 321.877;
          precooler.pipe_hot.fluid[2].T = 323.704;
          precooler.pipe_hot.fluid[3].T = 314.762;
          precooler.pipe_hot.fluid[4].T = 310.594;
          precooler.pipe_hot.fluid[5].T = 308.073;
          precooler.pipe_hot.fluid[6].T = 306.409;
          precooler.pipe_hot.fluid[7].T = 305.064;
          precooler.wall.T = {302.356, 305.511, 307.516, 310.231, 314.602, 325.619};
          ltrecuperator.pipe_cold.fluid[2].T = 381.15;
          ltrecuperator.pipe_cold.fluid[3].T = 424.102;
          ltrecuperator.pipe_cold.fluid[4].T = 453.034;
          ltrecuperator.pipe_hot.fluid[2].T = 435.545;
          ltrecuperator.pipe_hot.fluid[3].T = 397.175;
          ltrecuperator.pipe_hot.fluid[4].T = 354.873;
          ltrecuperator.wall.T = {368.629, 409.744, 442.928};
          htrecuperator.pipe_cold.fluid[2].T = 507.428;
          htrecuperator.pipe_cold.fluid[3].T = 619.588;
          htrecuperator.pipe_cold.fluid[4].T = 779.872;
          htrecuperator.pipe_hot.fluid[2].T = 653.909;
          htrecuperator.pipe_hot.fluid[3].T = 529.167;
          htrecuperator.pipe_hot.fluid[4].T = 458.413;
          htrecuperator.wall.T = {485.171, 576.375, 717.712};
          solarcollector.pipe.fluid[2].T = 835.304;
          solarcollector.pipe.fluid[3].T = 890.703;
          solarcollector.pipe.fluid[4].T = 945.739;
          solarcollector.wall.T = {827.71, 883.201, 938.317};
          precooler.pipe_hot.fluid[7].p = 7.71011e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.72034e+006;
          htrecuperator.pipe_hot.fluid[4].p = 7.82101e+006;
          solarcollector.pipe.fluid[4].p = 1.96929e+007;
          htrecuperator.pipe_cold.fluid[4].p = 2.02045e+007;
          ltrecuperator.pipe_cold.fluid[4].p = 2.02548e+007;
          annotation(experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 5));
        end Closed_circuit;

        model Add_bypass_valve
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 4;
          parameter Integer n_ltr = 4;
          parameter Integer n_htr = 4;
          parameter Integer n_sc = 4;
          parameter Real w_water = 130;
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 295, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Heat_Exchanger precooler(pipe_cold(redeclare model Medium = SimpleBrayton.Substances.WaterLiquid), n = n_pr, pout_start_cold = 110000, Tin_start_cold = 295, Tout_start_cold = 330, L = 0.9, w_start_cold = w_water, m = 63290, M = 1460, cp_metal = 530, k_cold = 142, k_hot = 142, w_start_hot = 70.2, Tin_start_hot = 342.99, Tout_start_hot = 310, pout_start_hot = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {88, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Heat_Exchanger htrecuperator(n = n_htr, pout_start_cold = 19.89e6, Tin_start_cold = 429.3, Tout_start_cold = 760.09, pout_start_hot = 7.74e6, Tin_start_hot = 804.55, Tout_start_hot = 436.34, k_cold = 413, w_start_cold = 121, k_hot = 909, w_start_hot = 121, L = 2.3, m = 173780, M = 18185, cp_metal = 502) annotation(Placement(visible = true, transformation(origin = {32, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.SolarCollector solarcollector(n = n_sc, w_start = 121, pout_start = 19.38e6, Tin_start = 760.09, Tout_start = 926.175, k = 4200) annotation(Placement(visible = true, transformation(origin = {48, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Components.Gas.TurbineStodola turbine(Tin_start = 926.175, pin_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {56, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Valve bypass annotation(Placement(visible = true, transformation(origin = {66, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Heat_Exchanger ltrecuperator(n = n_ltr, w_start_cold = 70.2, w_start_hot = 121, pout_start_hot = 7.64e6, Tin_start_hot = 436.34, Tout_start_hot = 342.99, pout_start_cold = 19.94e6, Tin_start_cold = 333.51, Tout_start_cold = 429.3, k_cold = 142, k_hot = 826, m = 128990, M = 11738, cp_metal = 502) annotation(Placement(visible = true, transformation(origin = {-4, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-36, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-46, 55}, {-46, 78}}, color = {159, 159, 223}));
          connect(re_int.outlet, precooler.inlet_hot) annotation(Line(points = {{8, 74}, {-22, 74}, {-22, 46}, {-52, 46}, {-52, 46}}, color = {159, 159, 223}));
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-6, -60}, {14, -60}, {14, 36}, {22, 36}, {22, 36}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-14, 45}, {-22, 45}, {-22, -60}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-22, -68}}, color = {0, 0, 255}));
          connect(reCompressor1.shaft_r, turbine.shaft_l) annotation(Line(points = {{-6, -68}, {48, -68}}, color = {0, 0, 255}));
          connect(mainCompressor1.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 35}, {-14, 35}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, ltrecuperator.outlet_hot) annotation(Line(points = {{-52, 45}, {-14, 45}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{6, 35}, {22, 35}}, color = {159, 159, 223}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{6, 45}, {22, 45}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, bypass.inlet) annotation(Line(points = {{42, 35}, {48, 35}, {48, 2}, {56, 2}}, color = {159, 159, 223}));
          connect(bypass.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{76, 2}, {86, 2}, {86, 44}, {42, 44}, {42, 44}, {42, 44}, {42, 44}}, color = {159, 159, 223}));
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{64, -68}, {74, -68}}, color = {0, 0, 255}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{48, -46}, {48, -60}}, color = {159, 159, 223}));
          connect(htrecuperator.inlet_hot, turbine.outlet) annotation(Line(points = {{42, 45}, {86, 45}, {86, -60}, {64, -60}, {64, -60}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, solarcollector.inlet) annotation(Line(points = {{42, 35}, {48, 35}, {48, -24}, {48, -24}}, color = {159, 159, 223}));
          solarcollector.S = 25500000;
          bypass.w = 5;
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.T", ltrecuperator.pipe_cold.fluid[2:n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.T", ltrecuperator.pipe_hot.fluid[2:n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.T", htrecuperator.pipe_cold.fluid[2:n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.T", htrecuperator.pipe_hot.fluid[2:n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.pipe.T", solarcollector.pipe.fluid[2:n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  solarcollector.pipe.fluid[" + String(n_sc + 1) + "].p = " + String(solarcollector.pipe.fluid[n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_cold.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_cold.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_cold.T[2:5] = {301.8, 308.386, 315.447, 326.225};
          precooler.pipe_hot.T[2:5] = {349.741, 327.555, 317.374, 311.05};
          precooler.wall.T = {306.638, 313.074, 320.471, 333.893};
          ltrecuperator.wall.T = {393.737, 450.258, 502.77, 545.26};
          ltrecuperator.pipe_cold.T[2:5] = {386.515, 442.545, 496.078, 539.961};
          ltrecuperator.pipe_hot.T[2:5] = {549.565, 508.415, 457.269, 401.342};
          htrecuperator.wall.T = {574.823, 631.68, 691.659, 753.806};
          htrecuperator.pipe_cold.T[2:5] = {569.237, 625.649, 685.308, 747.228};
          htrecuperator.pipe_hot.T[2:5] = {760.879, 698.589, 638.393, 581.213};
          solarcollector.pipe.T[2:5] = {790.316, 833.576, 876.631, 919.469};
          solarcollector.wall.T = {811.227, 854.452, 897.448, 940.21};
          precooler.pipe_hot.fluid[5].p = 9.44078e+006;
          ltrecuperator.pipe_hot.fluid[5].p = 9.45181e+006;
          htrecuperator.pipe_hot.fluid[5].p = 9.55312e+006;
          solarcollector.pipe.fluid[5].p = 1.97002e+007;
          htrecuperator.pipe_cold.fluid[5].p = 2.01944e+007;
          ltrecuperator.pipe_cold.fluid[5].p = 2.0245e+007;
          annotation(experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 5));
        end Add_bypass_valve;

        model Add_controll_mass_flow
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 6;
          parameter Integer n_ltr = 3;
          parameter Integer n_htr = 3;
          parameter Integer n_sc = 3;
          parameter Real w_water = 102;
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.SolarCollector solarcollector(n = n_sc, w_start = 121, pout_start = 19.38e6, Tin_start = 760.09, Tout_start = 926.175, k = 4200) annotation(Placement(visible = true, transformation(origin = {48, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Components.Gas.TurbineStodola turbine(Tin_start = 926.175, pin_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {56, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Valve bypass annotation(Placement(visible = true, transformation(origin = {66, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.ReCompressor reCompressor1(Tout_start = 429.3, Tin_start = 342.99, pin_start = 7.64e6) annotation(Placement(visible = true, transformation(origin = {-14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow re_int(T0 = 401.342, p_start = 9.45181e+006, w0 = 0, use_in_w = true) annotation(Placement(visible = true, transformation(origin = {18, 74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_water(p0 = 110000) annotation(Placement(visible = true, transformation(origin = {-36, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_MassFlow draw_out annotation(Placement(visible = true, transformation(origin = {68, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr) annotation(Placement(visible = true, transformation(origin = {-12, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr) annotation(Placement(visible = true, transformation(origin = {26, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {90, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{64, -68}, {82, -68}}, color = {0, 0, 255}));
          connect(htrecuperator.outlet_cold, solarcollector.inlet) annotation(Line(points = {{36, 35}, {48, 35}, {48, -24}}, color = {159, 159, 223}));
          connect(htrecuperator.inlet_hot, turbine.outlet) annotation(Line(points = {{36, 45}, {86, 45}, {86, -60}, {64, -60}}, color = {159, 159, 223}));
          connect(bypass.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{76, 2}, {86, 2}, {86, 45}, {36, 45}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, bypass.inlet) annotation(Line(points = {{36, 35}, {48, 35}, {48, 2}, {56, 2}}, color = {159, 159, 223}));
          connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{-2, 45}, {16, 45}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{-2, 35}, {16, 35}}, color = {159, 159, 223}));
          connect(reCompressor1.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-6, -60}, {16, -60}, {16, 35}}, color = {159, 159, 223}));
          connect(htrecuperator.outlet_cold, draw_out.inlet) annotation(Line(points = {{36, 35}, {58, 35}, {58, 24}}, color = {159, 159, 223}));
          connect(mainCompressor1.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 35}, {-22, 35}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_hot, precooler.inlet_hot) annotation(Line(points = {{-22, 45}, {-52, 45}, {-52, 46}}, color = {159, 159, 223}));
          connect(ltrecuperator.outlet_hot, reCompressor1.inlet) annotation(Line(points = {{-22, 45}, {-30, 45}, {-30, -60}, {-22, -60}}, color = {159, 159, 223}));
          connect(precooler.inlet_hot, re_int.outlet) annotation(Line(points = {{-52, 45}, {-30, 45}, {-30, 64}, {8, 64}, {8, 74}, {8, 74}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-46, 55}, {-46, 78}}, color = {159, 159, 223}));
          connect(mainCompressor1.shaft_r, reCompressor1.shaft_l) annotation(Line(points = {{-64, -68}, {-22, -68}}, color = {0, 0, 255}));
          connect(reCompressor1.shaft_r, turbine.shaft_l) annotation(Line(points = {{-6, -68}, {48, -68}}, color = {0, 0, 255}));
          connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{48, -46}, {48, -60}}, color = {159, 159, 223}));
          solarcollector.S = 25500000;
          bypass.w = 0;
          re_int.in_w = 0;
//draw_out.in_w = if time < 100 then time * 4 / 10000 else 0;
          draw_out.in_w = 0;
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.T", ltrecuperator.pipe_cold.fluid[2:n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.T", ltrecuperator.pipe_hot.fluid[2:n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.T", htrecuperator.pipe_cold.fluid[2:n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.T", htrecuperator.pipe_hot.fluid[2:n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.pipe.T", solarcollector.pipe.fluid[2:n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_hot.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_hot.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_hot.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_hot.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  solarcollector.pipe.fluid[" + String(n_sc + 1) + "].p = " + String(solarcollector.pipe.fluid[n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  htrecuperator.pipe_cold.fluid[" + String(n_htr + 1) + "].p = " + String(htrecuperator.pipe_cold.fluid[n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  ltrecuperator.pipe_cold.fluid[" + String(n_ltr + 1) + "].p = " + String(ltrecuperator.pipe_cold.fluid[n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          ltrecuperator.pipe_cold.fluid[4].p = 2.01364e+007;
          htrecuperator.pipe_cold.fluid[4].p = 2.00865e+007;
          solarcollector.pipe.fluid[4].p = 1.95792e+007;
          htrecuperator.pipe_hot.fluid[4].p = 7.74052e+006;
          ltrecuperator.pipe_hot.fluid[4].p = 7.64071e+006;
          precooler.pipe_hot.fluid[7].p = 7.63052e+006;
          solarcollector.wall.T = {833.714, 889.656, 945.212};
          solarcollector.pipe.T[2:4] = {841.387, 897.237, 952.713};
          htrecuperator.pipe_hot.T[2:4] = {658.364, 531.878, 459.511};
          htrecuperator.pipe_cold.T[2:4] = {509.716, 623.706, 785.481};
          htrecuperator.wall.T = {486.882, 579.756, 722.704};
          ltrecuperator.pipe_hot.T[2:4] = {436.064, 397.118, 354.914};
          ltrecuperator.pipe_cold.T[2:4] = {380.995, 424.38, 453.987};
          ltrecuperator.wall.T = {368.629, 409.877, 443.641};
          precooler.pipe_hot.T[2:7] = {322.881, 314.022, 309.945, 307.508, 305.918, 304.81};
          precooler.pipe_cold.T[2:7] = {299.429, 303.411, 305.912, 308.493, 312.244, 321.127};
          precooler.wall.T = {302.12, 305.077, 306.959, 309.572, 313.813, 324.841};
          annotation(experiment(StartTime = 0, StopTime = 3000, Tolerance = 1e-06, Interval = 5));
        end Add_controll_mass_flow;

        model precooler_maincompressor
          import Modelica.Utilities.Streams.*;
          parameter Integer n_pr = 4;
          parameter Real w_water = 85;
          Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-30, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_water(w0 = w_water, T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
          Components.Gas.Heat_Exchanger precooler(pipe_cold(redeclare model Medium = SimpleBrayton.Substances.WaterLiquid), n = n_pr, pout_start_cold = 110000, Tin_start_cold = 295, Tout_start_cold = 330, L = 0.9, w_start_cold = w_water, m = 63290, M = 1460, cp_metal = 530, k_cold = 142, k_hot = 142, w_start_hot = 70.2, Tin_start_hot = 342.99, Tout_start_hot = 310, pout_start_hot = 7.63e6) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          Components.Gas.Source_MassFlow source_MassFlow1(w0 = 70.2, T0 = 342.99) annotation(Placement(visible = true, transformation(origin = {-4, 46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.MainCompressor mainCompressor1(pin_start = 7.63e6, Tin_start = 304.84, Tout_start = 333.51) annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gas.Sink_Pressure sink_Pressure2(p0 = 19.95e6) annotation(Placement(visible = true, transformation(origin = {-48, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(mainCompressor1.shaft_r, grid1.connection) annotation(Line(points = {{-64, -68}, {64, -68}, {64, -68}, {64, -68}}, color = {0, 0, 255}));
          connect(mainCompressor1.outlet, sink_Pressure2.inlet) annotation(Line(points = {{-64, -60}, {-64, -60}, {-64, -26}, {-58, -26}, {-58, -26}}, color = {159, 159, 223}));
          connect(mainCompressor1.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
          connect(source_MassFlow1.outlet, precooler.inlet_hot) annotation(Line(points = {{-14, 46}, {-36, 46}, {-36, 45}, {-52, 45}}, color = {159, 159, 223}));
          connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-40, 55}, {-40, 78}, {-40, 78}}, color = {159, 159, 223}));
          connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
          when pre(terminal()) == true then
            Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", precooler.pipe_cold.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", precooler.pipe_hot.fluid[2:n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
            print("  precooler.pipe_hot.fluid[" + String(n_pr + 1) + "].p = " + String(precooler.pipe_hot.fluid[n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
          end when;
        initial equation
          precooler.pipe_hot.T[2:5] = {325.595, 316.019, 310.089, 306.445};
          precooler.pipe_cold.T[2:5] = {300.425, 304.49, 308.851, 314.749};
          precooler.wall.T = {304.465, 307.519, 312.1, 319.141};
//precooler.pipe_hot.fluid[n_pr + 1].p = 7.63e6;
          annotation(experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end precooler_maincompressor;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      end Progressive_testing;

      model Simplified_model
        Plants.SimpleHeatExchangeHT_initialized plant annotation(Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        plant.solar_radiation = 25500000;
        plant.cooling_massflow = 90;
        plant.draw_out_massflow = 0;
        plant.bypass_massflow = 0;
        plant.reint_massflow = 0;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 3000, Tolerance = 1e-06, Interval = 6));
      end Simplified_model;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Plant;

    package Valve
      model Test_valve
        Components.Gas.Sink_Pressure sink_Pressure1(p0 = 7.85e6) annotation(Placement(visible = true, transformation(origin = {-60, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        Components.Gas.FlowJoin flowJoin1 annotation(Placement(visible = true, transformation(origin = {-26, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        SimpleBrayton.Components.Gas.Source_MassFlow source_MassFlow1(T0 = 760.09, p_start = 19.89e6, w0 = 121) annotation(Placement(visible = true, transformation(origin = {-62, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.SolarCollector solarCollector1 annotation(Placement(visible = true, transformation(origin = {8, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.FlowSplit flowSplit1 annotation(Placement(visible = true, transformation(origin = {-26, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Gas.Valve valve1 annotation(Placement(visible = true, transformation(origin = {-20, 24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Components.Gas.TurbineStodola turbineStodola1(Tin_start = 926.175, p_start = 19.38e6, Tout_start = 804.55) annotation(Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Components.Electrical.Grid grid1 annotation(Placement(visible = true, transformation(origin = {38, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(source_MassFlow1.outlet, flowSplit1.inlet) annotation(Line(points = {{-52, 56}, {-32, 56}}, color = {159, 159, 223}));
        connect(turbineStodola1.shaft_r, grid1.connection) annotation(Line(points = {{10, 22}, {10, 22}, {10, 8}, {30, 8}, {30, 8}}, color = {0, 0, 255}));
        connect(turbineStodola1.outlet, flowJoin1.inlet2) annotation(Line(points = {{18, 22}, {18, 22}, {18, -8}, {-20, -8}, {-20, -8}}, color = {159, 159, 223}));
        connect(solarCollector1.outlet, turbineStodola1.inlet) annotation(Line(points = {{18, 60}, {18, 60}, {18, 38}, {18, 38}}, color = {159, 159, 223}));
        connect(valve1.outlet, flowJoin1.inlet1) annotation(Line(points = {{-20, 14}, {-20, 14}, {-20, 0}, {-20, 0}}, color = {159, 159, 223}));
        connect(flowSplit1.outlet2, valve1.inlet) annotation(Line(points = {{-20, 52}, {-20, 52}, {-20, 34}, {-20, 34}}, color = {159, 159, 223}));
        connect(flowSplit1.outlet1, solarCollector1.inlet) annotation(Line(points = {{-20, 60}, {-2, 60}}, color = {159, 159, 223}));
        connect(flowJoin1.outlet, sink_Pressure1.inlet) annotation(Line(points = {{-32, -4}, {-50, -4}, {-50, -4}, {-50, -4}}, color = {159, 159, 223}));
        valve1.k = 0;
        solarCollector1.S = 25500000;
        annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
      end Test_valve;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
    end Valve;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Tests;

  package Utilities
    model WaterCorrelations
      import Modelica.SIunits.*;
      import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
      import Modelica.Utilities.Streams.*;
      package Medium = Modelica.Media.Water.WaterIF97_pT;
      Medium.SaturationProperties sat;
      //parametri
      parameter Pressure T_min = 290;
      parameter Pressure T_max = 350;
      parameter Integer N = 50;
      parameter Integer ord_p = 4;
      parameter Integer ord_d = 3;
      parameter Integer ord_u = 3;
      //Variables
      Temperature T;
      Pressure p;
      Pressure p_a;
      Density d;
      Density d_a;
      SpecificEnthalpy u;
      SpecificEnthalpy u_a;
      //protected
      parameter Real T_data[:] = linspace(T_min, T_max, N);
      parameter Real p_data[:] = array(Medium.saturationPressure(T_data[i]) for i in 1:N);
      parameter Real d_data[:] = array(Medium.bubbleDensity(Medium.setSat_T(T_data[i])) for i in 1:N);
      parameter Real u_data[:] = array(Medium.bubbleEnthalpy(Medium.setSat_T(T_data[i])) - Medium.saturationPressure(T_data[i]) / Medium.bubbleDensity(Medium.setSat_T(T_data[i])) for i in 1:N);
      parameter Real coeff_p[:] = Poly.fitting(T_data, p_data, ord_p);
      parameter Real coeff_d[:] = Poly.fitting(T_data, d_data, ord_d);
      parameter Real coeff_u[:] = Poly.fitting(T_data, u_data, ord_u);
    equation
      T = T_min + (T_max - T_min) * time;
      sat = Medium.setSat_T(T);
      p = sat.psat;
      d = Medium.bubbleDensity(sat);
      u = Medium.bubbleEnthalpy(sat) - p / d;
      p_a = Poly.evaluate(coeff_p, T);
      d_a = Poly.evaluate(coeff_d, T);
      u_a = Poly.evaluate(coeff_u, T);
//printing
      when terminal() then
        print(PolynomialFunction("p_sat", coeff_p, "T"));
        print(PolynomialFunction("d", coeff_d, "T"));
        print(PolynomialFunction("u", coeff_u, "T"));
      end when;
    end WaterCorrelations;

    function PolynomialFunction
      input String variable;
      input Real coeff[:];
      input String independent_var;
      output String res;
    protected
      Integer coeff_size;
    algorithm
      coeff_size := size(coeff, 1);
      res := variable + " = ";
      for i in 1:coeff_size - 1 loop
        res := res + "(";
      end for;
      for i in 1:coeff_size loop
        if i < coeff_size then
          res := res + "+(" + String(coeff[i]) + "))*" + independent_var;
        else
          res := res + "+(" + String(coeff[i]) + ");";
        end if;
      end for;
//    res:= res+"\n";
    end PolynomialFunction;

    function PrintInitialization
      input String name;
      input Real variable[:];
      input Boolean fluid = true;
      output String res;
    protected
      Integer size;
    algorithm
      size := size(variable, 1);
      res := "  " + name;
      if fluid == true then
        res := res + "[2:" + String(size + 1) + "] = {";
      else
        res := res + " = {";
      end if;
      for i in 1:size loop
        if i < size then
          res := res + "" + String(variable[i]) + ", ";
        else
          res := res + "" + String(variable[i]) + "};";
        end if;
      end for;
    end PrintInitialization;

    function ParameterArray
      input String name;
      input Real variable[:];
      input Boolean fluid = true;
      output String res;
    protected
      Integer size;
    algorithm
      size := size(variable, 1);
      res := "  parameter Real";
      if fluid == true then
        res := res + "[" + String(size + 1) + "] " + name + "= {" + String(variable[1]) + ", ";
      else
        res := res + "[" + String(size) + "] " + name + "= {";
      end if;
      for i in 1:size loop
        if i < size then
          res := res + "" + String(variable[i]) + ", ";
        else
          res := res + "" + String(variable[i]) + "};";
        end if;
      end for;
    end ParameterArray;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Utilities;

  package Plants
    model BasePlant
      parameter Integer n_pr = 6;
      parameter Integer n_ltr = 3;
      parameter Integer n_htr = 3;
      parameter Integer n_sc = 3;
      parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
      Components.Gas.Source_MassFlow source_water(T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid, use_in_w = true) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
      Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Components.Gas.MainCompressor mainCompressor annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {88, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.SolarCollector solarcollector(n = n_sc, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {48, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Components.Gas.TurbineStodola turbine annotation(Placement(visible = true, transformation(origin = {56, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Valve bypass annotation(Placement(visible = true, transformation(origin = {66, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.ReCompressor reCompressor annotation(Placement(visible = true, transformation(origin = {-14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Source_MassFlow re_int(T0 = 401.342, p_start = 9.45181e+006, use_in_w = true) annotation(Placement(visible = true, transformation(origin = {18, 74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-36, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Sink_MassFlow draw_out annotation(Placement(visible = true, transformation(origin = {68, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput solar_radiation annotation(Placement(visible = true, transformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput cooling_massflow annotation(Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput reint_massflow annotation(Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput bypass_massflow annotation(Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput draw_out_massflow annotation(Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput TIT annotation(Placement(visible = true, transformation(origin = {120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput W_el annotation(Placement(visible = true, transformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Tmin annotation(Placement(visible = true, transformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput pmin annotation(Placement(visible = true, transformation(origin = {120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {-10, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Parametrized_Components.HTRecuperator htrecuperator(n = n_htr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {28, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(re_int.outlet, precooler.inlet_hot) annotation(Line(points = {{8, 74}, {-26, 74}, {-26, 44}, {-52, 44}, {-52, 45}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, solarcollector.inlet) annotation(Line(points = {{38, 43}, {48, 43}, {48, -26}}, color = {159, 159, 223}));
      connect(htrecuperator.inlet_hot, turbine.outlet) annotation(Line(points = {{38, 53}, {86, 53}, {86, -60}, {64, -60}}, color = {159, 159, 223}));
      connect(bypass.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{76, 2}, {86, 2}, {86, 53}, {38, 53}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, bypass.inlet) annotation(Line(points = {{38, 43}, {48, 43}, {48, 2}, {56, 2}}, color = {159, 159, 223}));
      connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{0, 41}, {0, 45}, {18, 45}, {18, 53}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{0, 31}, {0, 35}, {18, 35}, {18, 43}}, color = {159, 159, 223}));
      connect(reCompressor.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-6, -60}, {14, -60}, {14, 43}, {18, 43}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, draw_out.inlet) annotation(Line(points = {{38, 43}, {58, 43}, {58, 24}}, color = {159, 159, 223}));
      connect(mainCompressor.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 31}, {-20, 31}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_hot, precooler.inlet_hot) annotation(Line(points = {{-20, 41}, {-52, 41}, {-52, 45}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_hot, reCompressor.inlet) annotation(Line(points = {{-20, 41}, {-30, 41}, {-30, -60}, {-22, -60}}, color = {159, 159, 223}));
      TIT = turbine.gas_in.T;
      W_el = grid.connection.W;
      Tmin = precooler.pipe_hot.fluid[n_pr + 1].T;
      pmin = precooler.pipe_hot.fluid[n_pr + 1].p;
      connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{64, -68}, {80, -68}}, color = {0, 0, 255}));
      connect(solar_radiation, solarcollector.S);
      connect(cooling_massflow, source_water.in_w);
      connect(draw_out_massflow, draw_out.in_w);
      connect(reint_massflow, re_int.in_w);
      connect(bypass_massflow, bypass.w);
      connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-46, 55}, {-46, 78}}, color = {159, 159, 223}));
      connect(mainCompressor.shaft_r, reCompressor.shaft_l) annotation(Line(points = {{-64, -68}, {-22, -68}}, color = {0, 0, 255}));
      connect(reCompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-6, -68}, {48, -68}}, color = {0, 0, 255}));
      connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{48, -46}, {48, -60}}, color = {159, 159, 223}));
      connect(mainCompressor.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 45}}, color = {159, 159, 223}));
      connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 55}}, color = {159, 159, 223}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 100}, {-100, 100}}), Rectangle(lineThickness = 3, extent = {{100, -100}, {-100, 100}}), Text(origin = {1, 4}, fillPattern = FillPattern.Solid, extent = {{-81, 56}, {79, -64}}, textString = "%name")}));
    end BasePlant;

    model SimpleHeatExchangeHT_initialized
      extends SimpleBrayton.Plants.SimpleHeatExchangeHT;
    initial equation
      ltrecuperator.pipe_cold.fluid[n_ltr + 1].p = 1.99594e+007;
      htrecuperator.pipe_cold.fluid[n_htr + 1].p = 1.99122e+007;
      solarcollector.pipe.fluid[n_sc + 1].p = 1.94321e+007;
      htrecuperator.pipe_hot.fluid[n_htr + 1].p = 8.53886e+006;
      ltrecuperator.pipe_hot.fluid[n_ltr + 1].p = 8.44502e+006;
      precooler.pipe_hot.fluid[n_pr + 1].p = 8.43544e+006;
      solarcollector.wall.T = {901.856, 949.848, 993.305, 1035.02};
      solarcollector.pipe.T[2:5] = {863.538, 922.113, 970.234, 1013.88};
      htrecuperator.pipe_hot.T[2:5] = {808.016, 660.034, 543.699, 476.698};
      htrecuperator.pipe_cold.T[2:5] = {467.331, 524.678, 632.389, 782.029};
      htrecuperator.wall.T = {469.375, 530.901, 643.303, 796.857};
      ltrecuperator.pipe_hot.T[2:5] = {450.839, 434.156, 407.823, 372.988};
      ltrecuperator.pipe_cold.T[2:5] = {365.49, 399.324, 428.119, 445.186};
      ltrecuperator.wall.T = {368.132, 404.153, 431.839, 447.331};
      precooler.pipe_hot.T[2:5] = {338.721, 322.107, 313.726, 309.371};
      precooler.pipe_cold.T[2:5] = {300.551, 306.189, 312.022, 320.924};
      precooler.wall.T = {306.168, 310.399, 316.406, 327.559};
      annotation(documentation(info = "Initialized with cooling_massflow = 90 kg/s and solar_radiation = 2.55e7 W. In this conditions the power produced is 1.30701e+07 W and the TIT is 1031.18 K"));
    end SimpleHeatExchangeHT_initialized;

    model Less_volumes_HX
      extends SimpleBrayton.Plants.SimpleHeatExchangeHT(n_pr = 3, n_ltr = 3, n_htr = 3, n_sc = 3);
    initial equation
      ltrecuperator.pipe_cold.fluid[n_ltr + 1].p = 2.34606e+007;
      htrecuperator.pipe_cold.fluid[n_htr + 1].p = 2.34043e+007;
      solarcollector.pipe.fluid[n_sc + 1].p = 2.28314e+007;
      htrecuperator.pipe_hot.fluid[n_htr + 1].p = 1.25083e+007;
      ltrecuperator.pipe_hot.fluid[n_ltr + 1].p = 1.23956e+007;
      precooler.pipe_hot.fluid[n_pr + 1].p = 1.23839e+007;
      solarcollector.wall.T = {759.022, 808.521, 857.861};
      solarcollector.pipe.T[2:4] = {740.872, 790.371, 839.711};
      htrecuperator.pipe_hot.T[2:4] = {702.431, 640.04, 581.006};
      htrecuperator.pipe_cold.T[2:4] = {571.415, 629.86, 691.789};
      htrecuperator.wall.T = {575.778, 634.491, 696.63};
      ltrecuperator.pipe_hot.T[2:4] = {542.989, 491.293, 426.794};
      ltrecuperator.pipe_cold.T[2:4] = {412.991, 479.45, 534.071};
      ltrecuperator.wall.T = {420.398, 486.04, 539.121};
      precooler.pipe_hot.T[2:4] = {366.634, 337.734, 320.996};
      precooler.pipe_cold.T[2:4] = {307.488, 322.703, 342.724};
      precooler.wall.T = {315.498, 331.112, 353.791};
      annotation(documentation(info = "Initialized with cooling_massflow = 120 kg/s and solar_radiation = 2.55e+07. In this conditions the power produced is 7.3359e+06 W and the TIT is 813.466 K"));
    end Less_volumes_HX;

    model Plant_initialized
      extends SimpleBrayton.Plants.BasePlant(initialized = true, precooler(T_start_cold = pr_Tcold, pout_start_hot = pr_phot, T_start_hot = pr_Thot, T_start_wall = pr_Twall), ltrecuperator(pout_start_cold = ltr_pcold, T_start_cold = ltr_Tcold, pout_start_hot = ltr_phot, T_start_hot = ltr_Thot, T_start_wall = ltr_Twall), htrecuperator(pout_start_cold = htr_pcold, T_start_cold = htr_Tcold, pout_start_hot = htr_phot, T_start_hot = htr_Thot, T_start_wall = htr_Twall), solarcollector(pout_start = sc_p, T_start = sc_Tpipe, T_start_wall = sc_Twall));
      parameter Real ltr_pcold = 2.01381e+007;
      parameter Real htr_pcold = 2.00882e+007;
      parameter Real sc_p = 1.95792e+007;
      parameter Real htr_phot = 7.74066e+006;
      parameter Real ltr_phot = 7.64085e+006;
      parameter Real pr_phot = 7.63067e+006;
      parameter Real[3] sc_Twall = {833.74, 889.682, 945.24};
      parameter Real[4] sc_Tpipe = {841.412, 841.412, 897.263, 952.741};
      parameter Real[4] htr_Thot = {658.382, 658.382, 531.89, 459.52};
      parameter Real[4] htr_Tcold = {509.727, 509.727, 623.723, 785.507};
      parameter Real[3] htr_Twall = {486.892, 579.77, 722.726};
      parameter Real[4] ltr_Thot = {436.073, 436.073, 397.125, 354.916};
      parameter Real[4] ltr_Tcold = {381, 381, 424.389, 453.996};
      parameter Real[3] ltr_Twall = {368.633, 409.884, 443.65};
      parameter Real[7] pr_Thot = {322.882, 322.882, 314.023, 309.946, 307.509, 305.919, 304.811};
      parameter Real[7] pr_Tcold = {299.429, 299.429, 303.411, 305.913, 308.494, 312.245, 321.128};
      parameter Real[6] pr_Twall = {302.12, 305.078, 306.96, 309.573, 313.814, 324.842};
      annotation(documentation(info = "Initialized with cooling_massflow = 102 kg/s and solar_radiation = 2.55e7 W. In this conditions the power produced is 1.28323e+07 W and the TIT is 952.741 K, Tmin = 304.811 K and pmin = 7.63067e+06"));
    end Plant_initialized;

    model plant_init_eq
      extends SimpleBrayton.Plants.Plant_sHT;
    initial equation
      ltrecuperator.pipe_cold.fluid[4].p = 2.01381e+007;
      htrecuperator.pipe_cold.fluid[4].p = 2.00882e+007;
      solarcollector.pipe.fluid[4].p = 1.95792e+007;
      htrecuperator.pipe_hot.fluid[4].p = 7.74066e+006;
      ltrecuperator.pipe_hot.fluid[4].p = 7.64085e+006;
      precooler.pipe_hot.fluid[7].p = 7.63067e+006;
      solarcollector.wall.T = {833.74, 889.682, 945.24};
      solarcollector.pipe.T[2:4] = {841.412, 897.263, 952.741};
      htrecuperator.pipe_hot.T[2:4] = {658.382, 531.89, 459.52};
      htrecuperator.pipe_cold.T[2:4] = {509.727, 623.723, 785.507};
      htrecuperator.wall.T = {486.892, 579.77, 722.726};
      ltrecuperator.pipe_hot.T[2:4] = {436.073, 397.125, 354.916};
      ltrecuperator.pipe_cold.T[2:4] = {381, 424.389, 453.996};
      ltrecuperator.wall.T = {368.633, 409.884, 443.65};
      precooler.pipe_hot.T[2:7] = {322.882, 314.023, 309.946, 307.509, 305.919, 304.811};
      precooler.pipe_cold.T[2:7] = {299.429, 303.411, 305.913, 308.494, 312.245, 321.128};
      precooler.wall.T = {302.12, 305.078, 306.96, 309.573, 313.814, 324.842};
      annotation(documentation(info = "Initialized with cooling_massflow = 102 kg/s and solar_radiation = 2.55e7 W. In this conditions the power produced is 1.28323e+07 W and the TIT is 952.741 K, Tmin = 304.811 K and pmin = 7.63067e+06"));
    end plant_init_eq;

    model Plant_sHT
      parameter Integer n_pr = 6;
      parameter Integer n_ltr = 3;
      parameter Integer n_htr = 3;
      parameter Integer n_sc = 3;
      parameter Boolean initialized = false "If true sets the state variables to have fixed start value";
      Components.Gas.Source_MassFlow source_water(T0 = 293, redeclare model Medium = SimpleBrayton.Substances.WaterLiquid, use_in_w = true) annotation(Placement(visible = true, transformation(origin = {-90, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 360)));
      Components.Gas.Parametrized_Components.Precooler precooler(n = n_pr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {-62, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Components.Gas.MainCompressor mainCompressor annotation(Placement(visible = true, transformation(origin = {-72, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Electrical.Grid grid annotation(Placement(visible = true, transformation(origin = {88, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Parametrized_Components.SolarCollector_sHT solarcollector(n = n_sc, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {48, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Components.Gas.TurbineStodola turbine annotation(Placement(visible = true, transformation(origin = {56, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Valve bypass annotation(Placement(visible = true, transformation(origin = {66, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.ReCompressor reCompressor annotation(Placement(visible = true, transformation(origin = {-14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Source_MassFlow re_int(T0 = 401.342, p_start = 9.45181e+006, use_in_w = true) annotation(Placement(visible = true, transformation(origin = {18, 74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Components.Gas.Sink_Pressure sink_water(p0 = 101325) annotation(Placement(visible = true, transformation(origin = {-36, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Sink_MassFlow draw_out annotation(Placement(visible = true, transformation(origin = {68, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput solar_radiation annotation(Placement(visible = true, transformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput cooling_massflow annotation(Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput reint_massflow annotation(Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput bypass_massflow annotation(Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput draw_out_massflow annotation(Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput TIT annotation(Placement(visible = true, transformation(origin = {120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput W_el annotation(Placement(visible = true, transformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Tmin annotation(Placement(visible = true, transformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput pmin annotation(Placement(visible = true, transformation(origin = {120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Components.Gas.Parametrized_Components.LTRecuperator ltrecuperator(n = n_ltr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Gas.Parametrized_Components.HTRecuperator_sHT htrecuperator(n = n_htr, initialized = initialized) annotation(Placement(visible = true, transformation(origin = {30, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(re_int.outlet, precooler.inlet_hot) annotation(Line(points = {{8, 74}, {-26, 74}, {-26, 44}, {-50, 44}, {-50, 44}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, solarcollector.inlet) annotation(Line(points = {{40, 35}, {48, 35}, {48, -24}}, color = {159, 159, 223}));
      connect(htrecuperator.inlet_hot, turbine.outlet) annotation(Line(points = {{40, 45}, {86, 45}, {86, -60}, {64, -60}}, color = {159, 159, 223}));
      connect(bypass.outlet, htrecuperator.inlet_hot) annotation(Line(points = {{76, 2}, {86, 2}, {86, 45}, {40, 45}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, bypass.inlet) annotation(Line(points = {{40, 35}, {48, 35}, {48, 2}, {56, 2}}, color = {159, 159, 223}));
      connect(ltrecuperator.inlet_hot, htrecuperator.outlet_hot) annotation(Line(points = {{0, 45}, {20, 45}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_cold, htrecuperator.inlet_cold) annotation(Line(points = {{0, 35}, {20, 35}}, color = {159, 159, 223}));
      connect(reCompressor.outlet, htrecuperator.inlet_cold) annotation(Line(points = {{-6, -60}, {14, -60}, {14, 35}, {20, 35}}, color = {159, 159, 223}));
      connect(htrecuperator.outlet_cold, draw_out.inlet) annotation(Line(points = {{40, 35}, {58, 35}, {58, 24}}, color = {159, 159, 223}));
      connect(mainCompressor.outlet, ltrecuperator.inlet_cold) annotation(Line(points = {{-64, -60}, {-64, 35}, {-20, 35}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_hot, precooler.inlet_hot) annotation(Line(points = {{-20, 45}, {-52, 45}, {-52, 46}}, color = {159, 159, 223}));
      connect(ltrecuperator.outlet_hot, reCompressor.inlet) annotation(Line(points = {{-20, 45}, {-30, 45}, {-30, -60}, {-22, -60}}, color = {159, 159, 223}));
      TIT = turbine.gas_in.T;
      W_el = grid.connection.W;
      Tmin = precooler.pipe_hot.fluid[n_pr + 1].T;
      pmin = precooler.pipe_hot.fluid[n_pr + 1].p;
      connect(turbine.shaft_r, grid.connection) annotation(Line(points = {{64, -68}, {80, -68}, {80, -68}, {80, -68}}, color = {0, 0, 255}));
      connect(solar_radiation, solarcollector.S);
      connect(cooling_massflow, source_water.in_w);
      connect(draw_out_massflow, draw_out.in_w);
      connect(reint_massflow, re_int.in_w);
      connect(bypass_massflow, bypass.w);
      connect(precooler.outlet_cold, sink_water.inlet) annotation(Line(points = {{-52, 55}, {-46, 55}, {-46, 78}}, color = {159, 159, 223}));
      connect(mainCompressor.shaft_r, reCompressor.shaft_l) annotation(Line(points = {{-64, -68}, {-22, -68}}, color = {0, 0, 255}));
      connect(reCompressor.shaft_r, turbine.shaft_l) annotation(Line(points = {{-6, -68}, {48, -68}}, color = {0, 0, 255}));
      connect(solarcollector.outlet, turbine.inlet) annotation(Line(points = {{48, -46}, {48, -60}}, color = {159, 159, 223}));
      connect(mainCompressor.inlet, precooler.outlet_hot) annotation(Line(points = {{-80, -60}, {-80, -60}, {-80, 44}, {-72, 44}, {-72, 44}}, color = {159, 159, 223}));
      connect(source_water.outlet, precooler.inlet_cold) annotation(Line(points = {{-80, 78}, {-80, 78}, {-80, 56}, {-72, 56}, {-72, 56}}, color = {159, 159, 223}));
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillPattern = FillPattern.Solid, extent = {{-100, 100}, {-100, 100}}), Rectangle(lineThickness = 3, extent = {{100, -100}, {-100, 100}}), Text(origin = {1, 4}, fillPattern = FillPattern.Solid, extent = {{-81, 56}, {79, -64}}, textString = "%name")}));
    end Plant_sHT;

    model Plant_sHT_init_eq
      extends SimpleBrayton.Plants.Plant_sHT;
    initial equation
      ltrecuperator.pipe_cold.fluid[4].p = 2.01474e+007;
      htrecuperator.pipe_cold.fluid[4].p = 2.00974e+007;
      solarcollector.pipe.fluid[4].p = 1.95877e+007;
      htrecuperator.pipe_hot.fluid[4].p = 7.75055e+006;
      ltrecuperator.pipe_hot.fluid[4].p = 7.65061e+006;
      precooler.pipe_hot.fluid[7].p = 7.64041e+006;
      solarcollector.wall.T = {831.764, 887.726, 943.328};
      solarcollector.pipe.T[2:4] = {839.51, 895.298, 950.715};
      htrecuperator.pipe_hot.T[2:4] = {659.246, 532.01, 460.113};
      htrecuperator.pipe_cold.T[2:4] = {509.692, 624.383, 783.673};
      htrecuperator.wall.T = {487.383, 580.165, 721.827};
      ltrecuperator.pipe_hot.T[2:4] = {436.691, 397.545, 354.936};
      ltrecuperator.pipe_cold.T[2:4] = {381.278, 424.985, 454.619};
      ltrecuperator.wall.T = {368.788, 410.371, 444.261};
      precooler.pipe_hot.T[2:7] = {322.954, 314.091, 310.01, 307.568, 305.975, 304.833};
      precooler.pipe_cold.T[2:7] = {299.437, 303.447, 305.964, 308.554, 312.315, 321.201};
      precooler.wall.T = {302.132, 305.125, 307.017, 309.637, 313.888, 324.916};
      annotation(documentation(info = "Initialized with cooling_massflow = 102 kg/s and solar_radiation = 2.55e7 W. In this conditions the power produced is 1.2803e+07 W and the TIT is 950.716 K, Tmin = 304.833 K and pmin = 7.64041e+06"));
    end Plant_sHT_init_eq;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Plants;

  package Simulations
    model Initialize_base_plant
      import Modelica.Utilities.Streams.*;
      Plants.BasePlant plant annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      plant.cooling_massflow = 102;
      plant.solar_radiation = 25500000;
      plant.bypass_massflow = 0;
      plant.reint_massflow = 0;
      plant.draw_out_massflow = 0;
      when pre(terminal()) == true then
        Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", plant.precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", plant.precooler.pipe_cold.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", plant.precooler.pipe_hot.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", plant.ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.T", plant.ltrecuperator.pipe_cold.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.T", plant.ltrecuperator.pipe_hot.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", plant.htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.T", plant.htrecuperator.pipe_cold.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.T", plant.htrecuperator.pipe_hot.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.pipe.T", plant.solarcollector.pipe.fluid[2:plant.n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", plant.solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  precooler.pipe_hot.fluid[" + String(plant.n_pr + 1) + "].p = " + String(plant.precooler.pipe_hot.fluid[plant.n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  ltrecuperator.pipe_hot.fluid[" + String(plant.n_ltr + 1) + "].p = " + String(plant.ltrecuperator.pipe_hot.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  htrecuperator.pipe_hot.fluid[" + String(plant.n_htr + 1) + "].p = " + String(plant.htrecuperator.pipe_hot.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  solarcollector.pipe.fluid[" + String(plant.n_sc + 1) + "].p = " + String(plant.solarcollector.pipe.fluid[plant.n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  htrecuperator.pipe_cold.fluid[" + String(plant.n_htr + 1) + "].p = " + String(plant.htrecuperator.pipe_cold.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  ltrecuperator.pipe_cold.fluid[" + String(plant.n_ltr + 1) + "].p = " + String(plant.ltrecuperator.pipe_cold.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Twall", plant.precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Tcold", plant.precooler.pipe_cold.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Thot", plant.precooler.pipe_hot.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Twall", plant.ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Tcold", plant.ltrecuperator.pipe_cold.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Thot", plant.ltrecuperator.pipe_hot.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Twall", plant.htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Tcold", plant.htrecuperator.pipe_cold.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Thot", plant.htrecuperator.pipe_hot.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("sc_Tpipe", plant.solarcollector.pipe.fluid[2:plant.n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("sc_Twall", plant.solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real pr_phot = " + String(plant.precooler.pipe_hot.fluid[plant.n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real ltr_phot = " + String(plant.ltrecuperator.pipe_hot.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real htr_phot = " + String(plant.htrecuperator.pipe_hot.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real sc_p = " + String(plant.solarcollector.pipe.fluid[plant.n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real htr_pcold = " + String(plant.htrecuperator.pipe_cold.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real ltr_pcold = " + String(plant.ltrecuperator.pipe_cold.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
      end when;
    initial equation
      plant.ltrecuperator.pipe_cold.fluid[4].p = 2.01381e+007;
      plant.htrecuperator.pipe_cold.fluid[4].p = 2.00882e+007;
      plant.solarcollector.pipe.fluid[4].p = 1.95792e+007;
      plant.htrecuperator.pipe_hot.fluid[4].p = 7.74064e+006;
      plant.ltrecuperator.pipe_hot.fluid[4].p = 7.64083e+006;
      plant.precooler.pipe_hot.fluid[7].p = 7.63065e+006;
      plant.solarcollector.wall.T = {833.744, 889.687, 945.244};
      plant.solarcollector.pipe.T[2:4] = {841.417, 897.268, 952.746};
      plant.htrecuperator.pipe_hot.T[2:4] = {658.386, 531.892, 459.521};
      plant.htrecuperator.pipe_cold.T[2:4] = {509.729, 623.726, 785.511};
      plant.htrecuperator.wall.T = {486.894, 579.773, 722.73};
      plant.ltrecuperator.pipe_hot.T[2:4] = {436.073, 397.125, 354.916};
      plant.ltrecuperator.pipe_cold.T[2:4] = {381.001, 424.389, 453.997};
      plant.ltrecuperator.wall.T = {368.633, 409.885, 443.651};
      plant.precooler.pipe_hot.T[2:7] = {322.882, 314.023, 309.946, 307.509, 305.918, 304.81};
      plant.precooler.pipe_cold.T[2:7] = {299.429, 303.411, 305.913, 308.493, 312.245, 321.128};
      plant.precooler.wall.T = {302.12, 305.078, 306.959, 309.573, 313.814, 324.842};
      annotation(experiment(StartTime = 0, StopTime = 6000, Tolerance = 1e-06, Interval = 10));
    end Initialize_base_plant;

    model reference
      SimpleBrayton.Plants.plant_init_eq plant;
      parameter Real Sn = 25500000;
      Real u1(min = 0);
      Real u2(min = 0);
      Real u3(min = 0);
      Real u4(min = 0);
      Real du1;
      Real du2;
    equation
      plant.solar_radiation = Sn;
      u1 = plant.cooling_massflow;
      u2 = plant.bypass_massflow;
      u3 = plant.draw_out_massflow;
      u4 = plant.reint_massflow;
      u1 = 102;
      u2 = 0;
      u3 = 0;
      u4 = 0;
      du1 = der(u1);
      du2 = der(u2);
      annotation(experiment(StartTime = 0, StopTime = 3000, Tolerance = 1e-06, Interval = 6));
    end reference;

    model initialize_plant_sHT
      import Modelica.Utilities.Streams.*;
      Plants.Plant_sHT plant annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      plant.cooling_massflow = 102;
      plant.solar_radiation = 25500000;
      plant.bypass_massflow = 0;
      plant.reint_massflow = 0;
      plant.draw_out_massflow = 0;
      when pre(terminal()) == true then
        Modelica.Utilities.Files.remove("C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.wall.T", plant.precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_cold.T", plant.precooler.pipe_cold.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("precooler.pipe_hot.T", plant.precooler.pipe_hot.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.wall.T", plant.ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_cold.T", plant.ltrecuperator.pipe_cold.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("ltrecuperator.pipe_hot.T", plant.ltrecuperator.pipe_hot.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.wall.T", plant.htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_cold.T", plant.htrecuperator.pipe_cold.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("htrecuperator.pipe_hot.T", plant.htrecuperator.pipe_hot.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.pipe.T", plant.solarcollector.pipe.fluid[2:plant.n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.PrintInitialization("solarcollector.wall.T", plant.solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  precooler.pipe_hot.fluid[" + String(plant.n_pr + 1) + "].p = " + String(plant.precooler.pipe_hot.fluid[plant.n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  ltrecuperator.pipe_hot.fluid[" + String(plant.n_ltr + 1) + "].p = " + String(plant.ltrecuperator.pipe_hot.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  htrecuperator.pipe_hot.fluid[" + String(plant.n_htr + 1) + "].p = " + String(plant.htrecuperator.pipe_hot.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  solarcollector.pipe.fluid[" + String(plant.n_sc + 1) + "].p = " + String(plant.solarcollector.pipe.fluid[plant.n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  htrecuperator.pipe_cold.fluid[" + String(plant.n_htr + 1) + "].p = " + String(plant.htrecuperator.pipe_cold.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  ltrecuperator.pipe_cold.fluid[" + String(plant.n_ltr + 1) + "].p = " + String(plant.ltrecuperator.pipe_cold.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Twall", plant.precooler.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Tcold", plant.precooler.pipe_cold.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("pr_Thot", plant.precooler.pipe_hot.fluid[2:plant.n_pr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Twall", plant.ltrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Tcold", plant.ltrecuperator.pipe_cold.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("ltr_Thot", plant.ltrecuperator.pipe_hot.fluid[2:plant.n_ltr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Twall", plant.htrecuperator.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Tcold", plant.htrecuperator.pipe_cold.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("htr_Thot", plant.htrecuperator.pipe_hot.fluid[2:plant.n_htr + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("sc_Tpipe", plant.solarcollector.pipe.fluid[2:plant.n_sc + 1].T), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print(SimpleBrayton.Utilities.ParameterArray("sc_Twall", plant.solarcollector.wall.T, false), "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real pr_phot = " + String(plant.precooler.pipe_hot.fluid[plant.n_pr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real ltr_phot = " + String(plant.ltrecuperator.pipe_hot.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real htr_phot = " + String(plant.htrecuperator.pipe_hot.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real sc_p = " + String(plant.solarcollector.pipe.fluid[plant.n_sc + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real htr_pcold = " + String(plant.htrecuperator.pipe_cold.fluid[plant.n_htr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
        print("  parameter Real ltr_pcold = " + String(plant.ltrecuperator.pipe_cold.fluid[plant.n_ltr + 1].p) + ";", "C:\\Users\\Topomouse\\Desktop\\BCinit.txt");
      end when;
    initial equation
      plant.ltrecuperator.pipe_cold.fluid[4].p = 2.01474e+007;
      plant.htrecuperator.pipe_cold.fluid[4].p = 2.00974e+007;
      plant.solarcollector.pipe.fluid[4].p = 1.95877e+007;
      plant.htrecuperator.pipe_hot.fluid[4].p = 7.75055e+006;
      plant.ltrecuperator.pipe_hot.fluid[4].p = 7.65061e+006;
      plant.precooler.pipe_hot.fluid[7].p = 7.64041e+006;
      plant.solarcollector.wall.T = {831.764, 887.726, 943.328};
      plant.solarcollector.pipe.T[2:4] = {839.51, 895.298, 950.715};
      plant.htrecuperator.pipe_hot.T[2:4] = {659.246, 532.01, 460.113};
      plant.htrecuperator.pipe_cold.T[2:4] = {509.692, 624.383, 783.673};
      plant.htrecuperator.wall.T = {487.383, 580.165, 721.827};
      plant.ltrecuperator.pipe_hot.T[2:4] = {436.691, 397.545, 354.936};
      plant.ltrecuperator.pipe_cold.T[2:4] = {381.278, 424.985, 454.619};
      plant.ltrecuperator.wall.T = {368.788, 410.371, 444.261};
      plant.precooler.pipe_hot.T[2:7] = {322.954, 314.091, 310.01, 307.568, 305.975, 304.833};
      plant.precooler.pipe_cold.T[2:7] = {299.437, 303.447, 305.964, 308.554, 312.315, 321.201};
      plant.precooler.wall.T = {302.132, 305.125, 307.017, 309.637, 313.888, 324.916};
      annotation(experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 1));
    end initialize_plant_sHT;

    model reference_sHT
      SimpleBrayton.Plants.Plant_sHT_init_eq plant;
      parameter Real Sn = 25500000;
      Real u1(min = 0);
      Real u2(min = 0);
      Real u3(min = 0);
      Real u4(min = 0);
      Real du1;
      Real du2;
      Real OI;
      Real OF;
    equation
      plant.solar_radiation = Sn;
      u1 = plant.cooling_massflow;
      u2 = plant.bypass_massflow;
      u3 = plant.draw_out_massflow;
      u4 = plant.reint_massflow;
      u1 = 102;
      u2 = 0;
      u3 = 0;
      u4 = 0;
      OI = ((plant.TIT - 950.716) / 10) ^ 2 + ((plant.Tmin - 304.833) / 10) ^ 2 + ((plant.pmin - 7.639e+06) / 1e6) ^ 2;
      OI = der(OF);
      du1 = der(u1);
      du2 = der(u2);
    initial equation
      OF = 0;
      annotation(experiment(StartTime = 0, StopTime = 3000, Tolerance = 1e-06, Interval = 6));
    end reference_sHT;
  end Simulations;

  package SimpleComponent
    model TurbineStodola
      extends SimpleBrayton.Icons.Gas.Turbine;
      import SimpleBrayton.Types.*;
      //parameters and variables
      parameter Temperature Tin_start = 880;
      parameter Temperature Tout_start = 700;
      parameter Pressure pin_start = 18e5;
      parameter Pressure pout_start = 8e5;
      parameter PressureRatio beta_start = pin_start / pout_start;
      parameter Real eta_is = 0.95 "Isoentropic efficiency of the compressor";
      parameter Real eta_mec = 0.92 "Mechanic efficiency of the compressor";
      parameter Real K = 121 * sqrt(Tin_start) / pin_start / sqrt(1 - (1 / beta_start) ^ 2) "Stodola's constant";
      PressureRatio beta(start = beta_start) "Expansion ratio of the turbine";
      Real omega_r(nominal = 1e1) "Reduced rotation speed of the turbine";
      Real w_r(nominal = 70) "Reduced mass flow of the turbine";
      Power W "Electric work produced by the turbine";
      //fluid's instances
      SimpleBrayton.Substances.CO2 gas_in(T_start = Tin_start, p_start = pin_start, Calculate_trans = false);
      SimpleBrayton.Substances.CO2 gas_out(T_start = Tout_start, p_start = pout_start, Calculate_trans = false);
      SimpleBrayton.Substances.CO2 gas_out_is(T_start = Tout_start * eta_is, p_start = pout_start, Calculate_trans = false);
      //port
      SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.PowerConnection shaft_r annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.PowerConnection shaft_l annotation(Placement(visible = true, transformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      inlet.w + outlet.w = 0 "Mass balance";
      inlet.w * gas_in.h + outlet.w * gas_out.h - W / eta_mec = 0 "Energy Balance";
      beta = inlet.p / outlet.p;
      omega_r = 2 * Modelica.Constants.pi * shaft_r.f / sqrt(gas_in.T);
      w_r = inlet.w * sqrt(gas_in.T) / gas_in.p;
      w_r = K * sqrt(1 - (1 / beta) ^ 2);
      gas_out_is.p = gas_out.p;
      gas_out_is.s = gas_in.s;
      gas_in.h - gas_out.h = (gas_in.h - gas_out_is.h) * eta_is;
//Boundary Conditions
      inlet.p = gas_in.p;
      inlet.h = gas_in.h;
      inlet.h = inStream(inlet.h);
      outlet.p = gas_out.p;
      outlet.h = gas_out.h;
      shaft_r.f = shaft_l.f;
      W = (-shaft_l.W) - shaft_r.W;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end TurbineStodola;

    model Compressor
      extends SimpleBrayton.Icons.Gas.Compressor;
      import SimpleBrayton.Types.*;
      parameter Temperature Tin_start = 333;
      parameter Temperature Tout_start = 360;
      parameter Pressure pin_start = 8e5;
      parameter Pressure pout_start = 18e5;
      constant Real fr = 50 "Rated frequency of rotation of the compressor";
      parameter Real eta_mec = 0.95 "Mechanic efficiency of the compressor";
      parameter Real eta_is = 0.92 "Isoentropic efficiency of the compressor";
      parameter PressureRatio beta_start = pout_start / pin_start;
      parameter PressureRatio beta(start = beta_start) "Compression ratio of the compressor";
      Power W "Electric work consumed by the compressor";
      constant MassFlowRate wr = 70.2 "Rated flow rate";
      SimpleBrayton.Substances.CO2 gas_in(T_start = Tin_start, p_start = pin_start, Calculate_trans = false);
      SimpleBrayton.Substances.CO2 gas_out(T_start = Tout_start, p_start = pin_start * beta_start, Calculate_trans = false);
      SimpleBrayton.Substances.CO2 gas_out_is(T_start = Tout_start, p_start = pin_start * beta_start, Calculate_trans = false);
      SimpleBrayton.Connectors.FlangeA inlet(w(start = wr)) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.PowerConnection shaft_r annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.PowerConnection shaft_l annotation(Placement(visible = true, transformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      inlet.w + outlet.w = 0 "Mass balance";
      inlet.w * gas_in.h + outlet.w * gas_out.h + W / eta_mec = 0 "Energy Balance";
      beta = outlet.p / inlet.p;
      gas_out_is.p = gas_out.p;
      gas_out_is.s = gas_in.s;
      gas_out.h - gas_in.h = (gas_out_is.h - gas_in.h) / eta_is;
//Boundary Conditions
      inlet.p = gas_in.p;
      inlet.h = gas_in.h;
      inlet.h = inStream(inlet.h);
      outlet.p = gas_out.p;
      outlet.h = gas_out.h;
      shaft_r.f = shaft_l.f;
      W = shaft_l.W + shaft_r.W;
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Compressor;

    model Source_MassFlow
      extends SimpleBrayton.Icons.Gas.SourceW;
      import SimpleBrayton.Types.*;
      replaceable model Medium = SimpleBrayton.Substances.CO2 "Fluid model";
      parameter Pressure p_start = 7e6;
      parameter Temperature T0 = 500 "Nominal temperature and starting value for fluid";
      parameter MassFlowRate w0 = 0 "Nominal mass flowrate";
      parameter Boolean use_in_w = false "Use connector input for the nominal flow rate" annotation(Dialog(group = "External inputs"), choices(checkBox = true));
      parameter Boolean use_in_T = false "Use connector input for the temperature" annotation(Dialog(group = "External inputs"), choices(checkBox = true));
      Modelica.Blocks.Interfaces.RealInput in_w if use_in_w annotation(Placement(transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation(Placement(transformation(origin = {0, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Medium fluid(T_start = T0, p_start = p_start, Calculate_trans = false);
    protected
      Modelica.Blocks.Interfaces.RealInput in_w_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
    equation
      outlet.w = -in_w_internal;
      if use_in_w == false then
        in_w_internal = w0 "Flow rate set by parameter";
      end if;
      fluid.T = in_T_internal;
      if use_in_T == false then
        in_T_internal = T0 "Flow rate set by parameter";
      end if;
      fluid.p = outlet.p;
      fluid.h = outlet.h;
// Connect protected connectors to public conditional connectors
      connect(in_w, in_w_internal);
      connect(in_T, in_T_internal);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Source_MassFlow;

    model Sink_Pressure
      extends SimpleBrayton.Icons.Gas.SourceP;
      SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.33227e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      parameter SimpleBrayton.Types.Pressure p0 = 8e6 "Pressure of the reservoir";
    equation
      inlet.p = p0;
      inlet.h = inStream(inlet.h);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end Sink_Pressure;

    model Grid
      parameter Real f = 50 "Frequency of the electrical grid";
      SimpleBrayton.Connectors.PowerConnection connection annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connection.f = f;
      annotation(Diagram(graphics), Icon(graphics = {Line(points = {{18, -16}, {2, -38}}, color = {0, 0, 0}), Line(points = {{-72, 0}, {-40, 0}}, color = {0, 0, 0}), Ellipse(extent = {{100, -68}, {-40, 68}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-40, 0}, {-6, 0}, {24, 36}, {54, 50}}, color = {0, 0, 0}), Line(points = {{24, 36}, {36, -6}}, color = {0, 0, 0}), Line(points = {{-6, 0}, {16, -14}, {40, -52}}, color = {0, 0, 0}), Line(points = {{18, -14}, {34, -6}, {70, -22}}, color = {0, 0, 0}), Line(points = {{68, 18}, {36, -4}, {36, -4}}, color = {0, 0, 0}), Ellipse(extent = {{-8, 2}, {-2, -4}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{20, 38}, {26, 32}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{52, 54}, {58, 48}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{14, -12}, {20, -18}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{66, 22}, {72, 16}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{32, -2}, {38, -8}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{38, -50}, {44, -56}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{66, -18}, {72, -24}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{0, -34}, {6, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}));
    end Grid;

    model FixedHeatFlow "Fixed heat flow boundary condition"
      parameter Modelica.SIunits.HeatFlowRate Q_flow "Fixed heat flow rate at port";
      parameter Modelica.SIunits.Temperature T_ref = 293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha = 0 "Temperature coefficient of heat flow rate";
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    equation
      port.Q_flow = -Q_flow * (1 + alpha * (port.T - T_ref));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-150, 100}, {150, 60}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-150, -55}, {150, -85}}, lineColor = {0, 0, 0}, textString = "Q_flow=%Q_flow"), Line(points = {{-100, -20}, {48, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-100, 20}, {46, 20}}, color = {191, 0, 0}, thickness = 0.5), Polygon(points = {{40, 0}, {40, 40}, {70, 20}, {40, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{40, -40}, {40, 0}, {70, -20}, {40, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{70, 40}, {90, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-100, 40}, {0, -36}}, lineColor = {0, 0, 0}, textString = "Q_flow=const."), Line(points = {{-48, -20}, {60, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-48, 20}, {60, 20}}, color = {191, 0, 0}, thickness = 0.5), Polygon(points = {{60, 0}, {60, 40}, {90, 20}, {60, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{60, -40}, {60, 0}, {90, -20}, {60, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"));
    end FixedHeatFlow;

    model PrescribedHeatFlow "Prescribed heat flow boundary condition"
      parameter Modelica.SIunits.Temperature T_ref = 293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha = 0 "Temperature coefficient of heat flow rate";
      Modelica.Blocks.Interfaces.RealInput Q_flow(unit = "W") annotation(Placement(transformation(origin = {-100, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    equation
      port.Q_flow = -Q_flow * (1 + alpha * (port.T - T_ref));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-60, -20}, {40, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-60, 20}, {40, 20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-80, 0}, {-60, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-80, 0}, {-60, 20}}, color = {191, 0, 0}, thickness = 0.5), Polygon(points = {{40, 0}, {40, 40}, {70, 20}, {40, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{40, -40}, {40, 0}, {70, -20}, {40, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{70, 40}, {90, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 100}, {150, 60}}, textString = "%name", lineColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The amount of heat
is given by the input signal Q_flow into the model. The heat flows into the
component to which the component PrescribedHeatFlow is connected,
if the input signal is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-60, -20}, {68, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-60, 20}, {68, 20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-80, 0}, {-60, -20}}, color = {191, 0, 0}, thickness = 0.5), Line(points = {{-80, 0}, {-60, 20}}, color = {191, 0, 0}, thickness = 0.5), Polygon(points = {{60, 0}, {60, 40}, {90, 20}, {60, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{60, -40}, {60, 0}, {90, -20}, {60, -40}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}));
    end PrescribedHeatFlow;

    model FixedTemperature "Fixed temperature boundary condition in Kelvin"
      parameter SimpleBrayton.Types.Temperature T "Fixed temperature at port";
      SimpleBrayton.Connectors.HeatPort port annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
    equation
      port.T = T;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-150, -110}, {150, -140}}, lineColor = {0, 0, 0}, textString = "T=%T"), Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {159, 159, 223}, fillPattern = FillPattern.Backward), Text(extent = {{0, 0}, {-100, -100}}, lineColor = {0, 0, 0}, textString = "K"), Line(points = {{-52, 0}, {56, 0}}, color = {191, 0, 0}, thickness = 0.5), Polygon(points = {{50, -20}, {50, 20}, {90, 0}, {50, -20}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
This model defines a fixed temperature T at its port in Kelvin,
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -101}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {159, 159, 223}, fillPattern = FillPattern.Backward), Line(points = {{-52, 0}, {56, 0}}, color = {191, 0, 0}, thickness = 0.5), Text(extent = {{0, 0}, {-100, -100}}, lineColor = {0, 0, 0}, textString = "K"), Polygon(points = {{52, -20}, {52, 20}, {90, 0}, {52, -20}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}));
    end FixedTemperature;

    model SimplePipeHT
      extends SimpleBrayton.Icons.Gas.Tube;
      import SimpleBrayton.Types.*;
      replaceable model Medium = SimpleBrayton.Substances.CO2 "Fluid model";
      //parameters
      parameter Volume V = 1 "Constant Volume";
      parameter Temperature Tin_start = 500;
      parameter Temperature Tout_start = 500;
      parameter Pressure pin_start = 10e5;
      parameter Pressure pout_start = 10e5;
      constant MassFlowRate wr = 70 "Rated flow rate";
      //variables
      HeatFlowRate Qe "imposed flow rate";
      Temperature Tmean;
      Mass M "Mass of gas in each finite volume";
      Energy E "Energy contained in each finite volume";
      MassFlowRate der_M "Variation of the mass of gas";
      Power der_E "Variation of the energy contained in each finite volume";
      //fluid's instances
      SimpleBrayton.Substances.CO2 gas_in(T_start = Tin_start, p_start = pin_start, Calculate_trans = false);
      SimpleBrayton.Substances.CO2 gas_out(T_start = Tout_start, p_start = pout_start, Calculate_trans = false);
      //istances
      SimpleBrayton.Connectors.HeatPort heatport annotation(Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 50}, extent = {{-40, -10}, {40, 10}}, rotation = 0)));
      SimpleBrayton.Connectors.FlangeA inlet(w(start = wr)) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -1.77636e-15}, extent = {{-48, -20}, {-8, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    initial equation
      gas_out.T = Tout_start;
//gas_out.p=pout_start;
    equation
      M = V * gas_out.d;
      E = M * gas_out.u;
      der_M = inlet.w + outlet.w "Mass Balance";
      der_M = -V * gas_out.d ^ 2 * (gas_out.dv_dT * der(gas_out.T) + gas_out.dv_dp * der(gas_out.p));
      der_E = inlet.w * gas_in.h + outlet.w * gas_out.h + Qe "Energy Balance";
      der_E = M * (gas_out.du_dT * der(gas_out.T) + gas_out.du_dp * der(gas_out.p)) + der_M * gas_out.u;
      inlet.p = outlet.p "Momentum Balance";
      Tmean = (gas_in.T + gas_out.T) / 2;
      heatport.Q_flow = Qe;
      heatport.T = Tmean;
//Boundary Conditions
      inlet.p = gas_in.p;
      outlet.p = gas_out.p;
      inlet.h = gas_in.h;
      outlet.h = gas_out.h;
      inlet.h = inStream(inlet.h);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
    end SimplePipeHT;

    model Source_Sink
  extends SimpleBrayton.Icons.Gas.SourceW;
      import SimpleBrayton.Types.*;
      replaceable model Medium = SimpleBrayton.Substances.CO2 "Fluid model";
      parameter Pressure pin_start = 8e5;
      parameter Temperature Tin_start = 700 "Nominal temperature and starting value for fluid";
      SimpleBrayton.Connectors.FlangeA inlet annotation(Placement(visible = true, transformation(origin = {-92, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-82, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      SimpleBrayton.Connectors.FlangeB outlet annotation(Placement(visible = true, transformation(origin = {92, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput w_ext annotation(Placement(transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    equation
      outlet.w = (-inlet.w) - w_ext;
      outlet.h = inStream(inlet.h);
      inlet.p = outlet.p;
      inlet.h = 0; //not used, no flow reversal
      annotation(Line(points = {{88, 0}, {88, 0}}, color = {159, 159, 223}));
      annotation(Line(points = {{-88, 0}, {-88, 0}}, color = {159, 159, 223}));
  end Source_Sink;

    model ThermalConductor "Lumped thermal element transporting heat without storing it"
      extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
      parameter Modelica.SIunits.ThermalConductance G "Constant thermal conductance of material";
    equation
      Q_flow = G * dT;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-90, 70}, {90, -70}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillColor = {192, 192, 192}, fillPattern = FillPattern.Backward), Line(points = {{-90, 70}, {-90, -70}}, thickness = 0.5), Line(points = {{90, 70}, {90, -70}}, thickness = 0.5), Text(extent = {{-150, 115}, {150, 75}}, textString = "%name", lineColor = {0, 0, 255}), Text(extent = {{-150, -75}, {150, -105}}, lineColor = {0, 0, 0}, textString = "G=%G")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 0}, {80, 0}}, color = {255, 0, 0}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}), Text(extent = {{-100, -20}, {100, -40}}, lineColor = {255, 0, 0}, textString = "Q_flow"), Text(extent = {{-100, 40}, {100, 20}}, lineColor = {0, 0, 0}, textString = "dT = port_a.T - port_b.T")}), Documentation(info = "<html>
<p>
This is a model for transport of heat without storing it; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">ThermalResistor</a>.
It may be used for complicated geometries where
the thermal conductance G (= inverse of thermal resistance)
is determined by measurements and is assumed to be constant
over the range of operations. If the component consists mainly of
one type of material and a regular geometry, it may be calculated,
e.g., with one of the following equations:
</p>
<ul>
<li><p>
    Conductance for a <b>box</b> geometry under the assumption
    that heat flows along the box length:</p>
    <pre>
    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box
    </pre>
    </li>
<li><p>
    Conductance for a <b>cylindrical</b> geometry under the assumption
    that heat flows from the inside to the outside radius
    of the cylinder:</p>
    <pre>
    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
    </li>
</ul>
<pre>
    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)
      wood         0.1 ... 0.2
</pre>
</html>"));
    end ThermalConductor;
  end SimpleComponent;

  package TestSimpleComponent
    model Compressor
      import SimpleBrayton;
      Source_MassFlow source_MassFlow(T0(displayUnit = "K") = 333, p_start = 800000, use_in_w = false, w0 = 70) annotation(Placement(transformation(extent = {{-72, 34}, {-52, 54}})));
      SimpleBrayton.SimpleComponent.Compressor compressor annotation(Placement(transformation(extent = {{-10, 22}, {10, 42}})));
      SimpleBrayton.SimpleComponent.Sink_Pressure sink_Pressure(p0 = 1.8e+06) annotation(Placement(transformation(extent = {{68, 30}, {88, 50}})));
      SimpleBrayton.SimpleComponent.Grid grid(f = 50) annotation(Placement(transformation(extent = {{58, -14}, {78, 6}})));
    equation
      connect(compressor.shaft_r, grid.connection) annotation(Line(points = {{8, 32}, {34, 32}, {34, -4}, {60, -4}}, color = {0, 0, 255}, thickness = 0.5));
      connect(compressor.outlet, sink_Pressure.inlet) annotation(Line(points = {{8, 40}, {68, 40}}, color = {159, 159, 223}));
      connect(source_MassFlow.outlet, compressor.inlet) annotation(Line(points = {{-52, 44}, {-30, 44}, {-30, 40}, {-8, 40}}, color = {159, 159, 223}));
    end Compressor;

    model Turbine
      TurbineStodola turbineStodola annotation(Placement(transformation(extent = {{-6, 6}, {14, 26}})));
      Source_MassFlow source_MassFlow(T0(displayUnit = "K") = 880, p_start = 1.8e+06, use_in_w = false, w0 = 70) annotation(Placement(transformation(extent = {{-78, 22}, {-58, 42}})));
      Sink_Pressure sink_Pressure(p0 = 800000) annotation(Placement(transformation(extent = {{58, 20}, {78, 40}})));
      Grid grid annotation(Placement(transformation(extent = {{50, -22}, {70, -2}})));
    equation
      connect(source_MassFlow.outlet, turbineStodola.inlet) annotation(Line(points = {{-58, 32}, {-32, 32}, {-32, 24}, {-4, 24}}, color = {159, 159, 223}));
      connect(turbineStodola.outlet, sink_Pressure.inlet) annotation(Line(points = {{12, 24}, {36, 24}, {36, 30}, {58, 30}}, color = {159, 159, 223}));
      connect(turbineStodola.shaft_r, grid.connection) annotation(Line(points = {{12, 16}, {32, 16}, {32, -12}, {52, -12}}, color = {0, 0, 255}, thickness = 0.5));
      annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Turbine;

    model PipeConvection
      SimpleBrayton.SimpleComponent.Source_MassFlow source_MassFlow(T0(displayUnit = "K") = 700, p_start = 1e+06, w0 = 70) annotation(Placement(visible = true, transformation(extent = {{-66, -24}, {-46, -4}}, rotation = 0)));
      SimpleBrayton.SimpleComponent.Sink_Pressure sink_Pressure(p0 = 1e+06) annotation(Placement(visible = true, transformation(extent = {{70, -24}, {90, -4}}, rotation = 0)));
      SimpleBrayton.SimpleComponent.FixedTemperature fixedTemperature1(T(displayUnit = "K") = 305) annotation(Placement(visible = true, transformation(origin = {6, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      SimpleComponent.SimplePipeHT simplePipeHT(V = 1, Tin_start = 973.15, Tout_start = 606.15, pin_start = 800000, pout_start = 800000) annotation(Placement(transformation(extent = {{-4, -24}, {16, -4}})));
      SimpleComponent.ThermalConductor thermalConductor(G = 120000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {6, 34})));
    equation
      connect(source_MassFlow.outlet, simplePipeHT.inlet) annotation(Line(points = {{-46, -14}, {-1.8, -14}}, color = {159, 159, 223}));
      connect(sink_Pressure.inlet, simplePipeHT.outlet) annotation(Line(points = {{70, -14}, {46, -14}, {46, -14.4}, {14.4, -14.4}}, color = {159, 159, 223}));
      connect(thermalConductor.port_b, fixedTemperature1.port) annotation(Line(points = {{6, 44}, {6, 44}, {6, 64}}, color = {191, 0, 0}));
      connect(thermalConductor.port_a, simplePipeHT.heatport) annotation(Line(points = {{6, 24}, {6, -9}}, color = {191, 0, 0}));
      annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1)));
    end PipeConvection;

model PipeHT
  SimpleBrayton.SimpleComponent.Source_MassFlow source_MassFlow1(T0(displayUnit = "K") = 360, p_start = 1.8e+06, use_in_w = false, w0 = 70) annotation(Placement(visible = true, transformation(origin = {-74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleBrayton.SimpleComponent.Sink_Pressure sink_Pressure1(p0 = 1.8e+06) annotation(Placement(visible = true, transformation(origin = {62, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SimpleBrayton.SimpleComponent.FixedHeatFlow fixedHeatFlow1(Q_flow = 35000000) annotation(Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  SimpleBrayton.SimpleComponent.SimplePipeHT simplePipeHT1( Tin_start (displayUnit = "K") = 360, Tout_start (displayUnit = "K") = 880,V = 1, pin_start = 1800000, pout_start = 1800000) annotation(Placement(visible = true, transformation(origin = {-10, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
import SimpleBrayton.Types.Mass;
Mass M_check;
initial equation
  M_check = simplePipeHT1.M;

equation
der(M_check) = simplePipeHT1.inlet.w + simplePipeHT1.outlet.w "check equation";

connect(fixedHeatFlow1.port, simplePipeHT1.heatport) annotation(Line(points = {{-10, 50}, {-10, 50}, {-10, 1}}, color = {191, 0, 0}));
connect(sink_Pressure1.inlet, simplePipeHT1.outlet) annotation(Line(points = {{52, -2}, {-2, -2}, {-2, -4.4}, {-1.6, -4.4}}, color = {159, 159, 223}));
  connect(source_MassFlow1.outlet, simplePipeHT1.inlet) annotation(Line(points = {{-64, -4}, {-17.8, -4}}, color = {159, 159, 223}));
end PipeHT;

    model Check_Der_Pipe
      SimpleComponent.CheckDerPipe checkDerPipe annotation(Placement(transformation(extent = {{-12, -8}, {8, 12}})));
      SimpleComponent.Source_MassFlow source_MassFlow(w0 = 70, p_start = 800000) annotation(Placement(transformation(extent = {{-84, -6}, {-64, 14}})));
      SimpleComponent.Sink_Pressure sink_Pressure(p0 = 800000) annotation(Placement(transformation(extent = {{48, -8}, {68, 12}})));
      SimpleBrayton.SimpleComponent.FixedHeatFlow fixedHeatFlow(Q_flow = 2222) annotation(Placement(visible = true, transformation(origin = {-2, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    equation
      connect(fixedHeatFlow.port, checkDerPipe.heatport) annotation(Line(points = {{-2, 52}, {-2, 7}}, color = {191, 0, 0}));
      connect(checkDerPipe.outlet, sink_Pressure.inlet) annotation(Line(points = {{6.4, 1.6}, {27.2, 1.6}, {27.2, 2}, {48, 2}}, color = {159, 159, 223}));
      connect(checkDerPipe.inlet, source_MassFlow.outlet) annotation(Line(points = {{-9.8, 2}, {-64, 2}, {-64, 4}}, color = {159, 159, 223}));
    end Check_Der_Pipe;

    model Test_Source_Sink
      SimpleComponent.Source_Sink source_Sink annotation(Placement(transformation(extent = {{-8, 2}, {12, 22}})));
      SimpleComponent.Source_MassFlow source_MassFlow(T0(displayUnit = "K") = 333, p_start = 800000, w0 = 70)  annotation(Placement(transformation(extent = {{-78, 2}, {-58, 22}})));
      SimpleComponent.Sink_Pressure sink_Pressure(p0 = 800000)  annotation(Placement(transformation(extent = {{46, 2}, {66, 22}})));
  Modelica.Blocks.Sources.Constant const(k = 5)  annotation(Placement(visible = true, transformation(origin = {-68, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(const.y, source_Sink.w_ext) annotation(Line(points = {{-56, 48}, {-4, 48}, {-4, 18}, {-4, 18}}, color = {0, 0, 127}));
      connect(source_Sink.inlet, source_MassFlow.outlet) annotation(Line(points = {{-6.2, 12.2}, {-32.1, 12.2}, {-32.1, 12}, {-58, 12}}, color = {159, 159, 223}));
      connect(source_Sink.outlet, sink_Pressure.inlet) annotation(Line(points = {{10.6, 12}, {28, 12}, {46, 12}}, color = {159, 159, 223}));
      annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Test_Source_Sink;
  end TestSimpleComponent;

  package Plant
    model CloseCycle
      SimpleComponent.Compressor compressor annotation(Placement(transformation(extent = {{-72, 2}, {-52, 22}})));
      SimpleComponent.SimplePipeHT simplePipeHT(Tin_start(displayUnit = "K") = 360, Tout_start (displayUnit = "K") = 880, V = 1, pin_start = 1.8e+06, pout_start = 1.8e+06)  annotation(Placement(transformation(extent = {{-14, 26}, {6, 46}})));
      SimpleComponent.SimplePipeHT simplePipeHT1(Tin_start(displayUnit = "K") = 700, Tout_start(displayUnit = "K") = 333, V = 1, pin_start = 800000, pout_start = 800000)  annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {0, -10})));
      SimpleComponent.TurbineStodola turbineStodola annotation(Placement(transformation(extent = {{44, 2}, {64, 22}})));
      SimpleComponent.FixedTemperature fixedTemperature(T(displayUnit = "K") = 305) annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 90, origin = {0, -70})));
      SimpleComponent.ThermalConductor thermalConductor(G = 120000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -40})));
      SimpleComponent.Grid grid(f = 50)  annotation(Placement(transformation(extent = {{64, -48}, {84, -28}})));
      Modelica.Blocks.Interfaces.RealInput w_ext annotation(Placement(visible = true, transformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Q_imposed annotation(Placement(visible = true, transformation(origin = {-120, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput P_mecc annotation(Placement(visible = true, transformation(origin = {120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput press_low annotation(Placement(visible = true, transformation(origin = {120, -12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  SimpleBrayton.SimpleComponent.Source_Sink source_Sink1(Tin_start(displayUnit = "K") = 700, pin_start = 800000)  annotation(Placement(visible = true, transformation(origin = {-48, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  SimpleBrayton.SimpleComponent.PrescribedHeatFlow prescribedHeatFlow1 annotation(Placement(visible = true, transformation(origin = {-4, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(prescribedHeatFlow1.port, simplePipeHT.heatport) annotation(Line(points = {{-4, 52}, {-4, 52}, {-4, 42}, {-4, 42}}, color = {191, 0, 0}));
      connect(source_Sink1.outlet, compressor.inlet) annotation(Line(points = {{-56, -10}, {-80, -10}, {-80, 22}, {-70, 22}, {-70, 20}, {-70, 20}}, color = {159, 159, 223}));
      connect(simplePipeHT1.outlet, source_Sink1.inlet) annotation(Line(points = {{-8, -10}, {-40, -10}, {-40, -10}, {-40, -10}}, color = {159, 159, 223}));
      connect(compressor.outlet, simplePipeHT.inlet) annotation(Line(points = {{-54, 20}, {-54, 20}, {-54, 34}, {-54, 36}, {-48, 36}, {-11.8, 36}}, color = {159, 159, 223}));
      connect(simplePipeHT.outlet, turbineStodola.inlet) annotation(Line(points = {{4.4, 35.6}, {46, 35.6}, {46, 20}}, color = {159, 159, 223}));
      connect(turbineStodola.outlet, simplePipeHT1.inlet) annotation(Line(points = {{62, 20}, {70, 20}, {80, 20}, {80, -10}, {7.8, -10}}, color = {159, 159, 223}));
      connect(thermalConductor.port_a, simplePipeHT1.heatport) annotation(Line(points = {{1.77636e-015, -30}, {0, -30}, {0, -15}, {-6.66134e-016, -15}}, color = {191, 0, 0}));
      connect(thermalConductor.port_b, fixedTemperature.port) annotation(Line(points = {{-1.77636e-015, -50}, {0, -50}, {0, -62}, {4.44089e-016, -62}}, color = {191, 0, 0}));
      connect(compressor.shaft_r, turbineStodola.shaft_l) annotation(Line(points = {{-54, 12}, {-4, 12}, {46, 12}}, color = {0, 0, 255}, thickness = 0.5));
      connect(turbineStodola.shaft_r, grid.connection) annotation(Line(points = {{62, 12}, {66, 12}, {66, -38}}, color = {0, 0, 255}, thickness = 0.5));
      w_ext = source_Sink1.w_ext;
      Q_imposed = prescribedHeatFlow1.port.Q_flow;
      P_mecc = turbineStodola.W;
      press_low = simplePipeHT1.inlet.p ;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false)));
    end CloseCycle;
  end Plant;

  model Simulation
    SimpleBrayton.Plant.CloseCycle closeCycle1 annotation(Placement(visible = true, transformation(origin = {-2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant w_ext(k = 5)  annotation(Placement(visible = true, transformation(origin = {-58, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Q_imposed(k = 35000000)  annotation(Placement(visible = true, transformation(origin = {-58, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(w_ext.y, closeCycle1.w_ext) annotation(Line(points = {{-46, 8}, {-24, 8}, {-24, 0}, {-14, 0}}, color = {0, 0, 127}));
    connect(Q_imposed.y, closeCycle1.Q_imposed) annotation(Line(points = {{-46, -28}, {-24, -28}, {-24, -10}, {-14, -10}, {-14, -10}}, color = {0, 0, 127}));
  
  end Simulation;
  annotation(uses(Modelica(version = "3.2.2")));
end SimpleBrayton;
