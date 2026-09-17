within EnSysLib.Technologies.EnergyStorages.ElectricalStorage.Lithium_Sulfur_Battery.PhysicalModels;

model Kumaresan_2008
  /**********     PACKAGES    **********/
  import SI = Modelica.SIunits;
  /**********     PARAMETERS    **********/
  parameter Integer n = n_p + n_s, n_p = 5, n_s = 3;
  parameter Real F = 96485.33;
  parameter Real R = 8.3145 "gas constant";
  parameter Real T = 25 + 273.15 "temperature";
  
  parameter Real s[8, 6] = [-1, 0, 0, 0, 0, 0; 0, -1 / 2, 0, 0, 0, 0; 0, 1 / 2, -3 / 2, 0, 0, 0; 0, 0, 2, -1, 0, 0; 0, 0, 0, 3 / 2, -1 / 2, 0; 0, 0, 0, 0, 1, -1 / 2; 0, 0, 0, 0, 0, 1; 0, 0, 0, 0, 0, 0] "Stoichiometric coefficient of species i in electrochemical reaction j";
  //s[i,j]
  parameter Real p[8, 6] = [0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0; 0, 1/2, 0, 0, 0, 0; 0, 0, 2, 0, 0, 0; 0, 0, 0, 3 / 2, 0, 0; 0, 0, 0, 0, 1, 0; 0, 0, 0, 0, 0, 1; 0, 0, 0, 0, 0, 0] "Anodic reaction order of species i in electrochemical reaction j";
  //p[i,j]
  parameter Real q[8, 6] = [-1, 0, 0, 0, 0, 0; 0, -1 / 2, 0, 0, 0, 0; 0, 0, -3 / 2, 0, 0, 0; 0, 0, 0, -1, 0, 0; 0, 0, 0, 0, -1 / 2, 0; 0, 0, 0, 0, 0, -1 / 2; 0, 0, 0, 0, 0, 0; 0, 0, 0, 0, 0, 0] "Cathodic reaction order of species i in electrochemical reaction j";
  //q[i,j]
  parameter Real gamma[8, 5] = [0, 2, 2, 2, 2; 1, 0, 0, 0, 0; 0, 1, 0, 0, 0; 0, 0, 0, 0, 0; 0, 0, 1, 0, 0; 0, 0, 0, 1, 0; 0, 0, 0, 0, 1; 0, 0, 0, 0, 0] "Number of ionic species i produced by dissociation of precipitate k";
  //gamma[i,k]
  parameter Real y_0_ref[6] = {0.394, 1.972, 0.019, 0.019, 1.97e-4, 1.97e-7} "Exchange current density of electrochemical reaction j at reference concentrations";
  //y_0_ref[j]
  parameter Real alpha_a[6] = {0.5 for j in 1:6} "Anodic transfer coefficient of reaction j";
  //alpha_a[i]
  parameter Real alpha_c[6] = {0.5 for j in 1:6} "Cathodic transfer coefficient of reaction j";
  //alpha_c[i]
  parameter Real n_e[6] = {1 for j in 1:6} "number of electrons transfered in electrochemical reaction j";
  //n[j]
  parameter Real U_theta[6] = {0, 2.39, 2.37, 2.24, 2.04, 2.01} "Standard OCP of electrochemical reaction j";
  //U_theta[j]
  parameter Real z[8] = {1, 0, -2, -2, -2, -2, -2, -1} "Charge number of species i";
  //z[i]
  parameter Real D_0[8] = {1e-10, 1e-9, 6e-10, 6e-10, 1e-10, 1e-10, 1e-10, 4e-10} "diffusion coefficient of species i in the bulk medium";
  //D_0[i]
  parameter Real C_ref[8] = {1001.04, 19.0, 0.178, 0.324, 0.02, 5.229e-7, 8.267e-10, 1000} "Reference concentration of species i";
  //C_ref[i]
  parameter Real d[2] = {9e-6, 41e-6};
  parameter Real x_b1[n_s + 1] = linspace(0, d[1], n_s + 1);
  parameter Real x_b2[n_p + 1] = linspace(d[1], sum(d), n_p + 1);
  parameter Real x_b[n + 1] = cat(1, x_b1[1:end - 1], x_b2);
  //x_b[l]
  parameter Real x_m[n] = (x_b[1:end - 1] + x_b[2:end]) / 2;
  //x_m[l]
  parameter Real epsilon_init[2] = {0.37, 0.778};
  //
  parameter Real a_0 = 132762 "Initial value of a, m2/m3";
  parameter Real beta[2] = {1.5, 1.5} "Bruggeman coefficient";
  parameter Real sigma = 1 "Effective conductivity of solid phase of the cathode";
  parameter Real k_rate[5] = {10, 1e-11, 9.98e-12, 9.98e-9, 6.9e-5} "Rate constant of precipitate k";
  // 1 / s
  // m^6 mol^2 / s
  //k[k]
  parameter Real K_sp[5] = {19, 38.09, 11.26, 5.1e-3, 3e-5} "Solubility product of precipitate k";
  //mol m^3
  //mol^3/m^9
  //K_sp[k]
  parameter Real V_molar[5] = {1.239e-4, 1.361e-4, 7.415e-5, 4.317e-5, 2.768e-5} "Molar volume of the precipitate k";
  //V_molar[k]
  parameter Real zeta = 1.5 "Morphology parameter";
  
  parameter Real epsilon_volume_init[5, 2] = [1e-12, 0.16;
                                        1e-6, 1e-6;
                                        1e-6, 1e-6;
                                        1e-6, 1e-6;
                                        1e-7, 1e-7] "Volume fraction of precipitate k in the separator and cathode";
  //epsilon_volume[k,l]
  /**********     INDIZES    **********/
  // i in 1:8 "species"  Li+, S8(l), S8^2-, S6^2-, S4^2-, S2^2-, S^2-, A^-
  // j in 1:6 "reactions"
  // k in 1:5 precipitates
  // I solid phase
  // II liquid phase
  // l in 1:n_s element (separator)
  // l in n_s+1:n element (positive electrode)
  // b element border
  // m element midpoint
  /**********     VARIABLES    **********/
  Real C[8, n];
  //C[i,l]
  Real epsilon[n] "Porosity of separator and cathode";
  //epsilon[l]
  Real epsilon_volume[5, n];
  Real N[8, n + 1];
  //N[i,l]
  Real r[8, n] "Production rate of species i due to electrochemical reactions";
  //r[i,l];
  Real Rp[8, n] "production rate";
  //R[i,l]
  Real y_a[1, 1] (each fixed=false, each start=y_0_ref[1]);  //y[j,l]
  Real y_c[5, n_p];  //y[j,l]
  
  Real D_eff[8, n];
  //D_eff[i,l]
  Real phi_I[n_p] (each fixed=false, each start=2.39), 
       phi_II[n] (each fixed=false, each start=0);
  //phi_I[l]
  //phi_II[l]
  Real a[n_p];
  //a[l] n_s+1:n
  Real U_ref[6] "OCP of electrochemical reaction j at reference concentrations"; // Kann-Parameter
  //U_ref[j]
  Real i_I[n_p + 1] "solid-phase current density",
       i_II[n + 1] "liquid-phase current density";
  //i_I[l]
  //i_II[l]
  Real Rp_[5, n] "Rate of precipitation of solid species k";
  //Rp_[k,l]
  Real eta_a[1, 1] "Overpotential anode for electrochemical reaction j";
  //eta[j,l]
  Real eta_c[5, n_p] "Overpotential cathode for electrochemical reaction j";
  //eta[j,l]
  
  Modelica.Blocks.Interfaces.RealInput i_app (quantity="CurrentDensity")
    "Applied current density" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

/**********     ALGORITHM     ********/
//initial algorithm
//  for i in 1:8 loop
//    for j in 1:6 loop
//      if s[i, j] > 0 then
//        p[i, j] := s[i, j];
//        q[i, j] := 0;
//      else
//        p[i, j] := 0;
//        q[i, j] := s[i, j];
//      end if;
//    end for;
//  end for;
  
/**********     EQUATIONS     ********/
initial equation
  for l in 1:n loop
    for i in 1:6 loop
      C[i, l] = C_ref[i];
    end for;
    C[8, l] = 990;
  end for;
  
  for l in 1:n_s loop
    epsilon[l] = epsilon_init[1]; 
    for k in 1:5 loop
      epsilon_volume[k, l] = epsilon_volume_init[k, 1];
    end for;
  end for;
  
  for l in n_s+1:n loop
    epsilon[l] = epsilon_init[2]; 
    for k in 1:5 loop
      epsilon_volume[k, l] = epsilon_volume_init[k, 2];
    end for;
  end for;
  
equation
// [12]
  for l in 1:n loop
    for i in 1:6 loop
      der(C[i, l]) = 1 / epsilon[l] * ((-C[i, l] * der(epsilon[l])) - (N[i, l + 1] - N[i, l]) / (x_b[l + 1] - x_b[l]) + r[i, l] - Rp[i, l]);
    end for;
    C[7, l] = -(sum(z[i] * C[i, l] for i in 1:6) + z[8] * C[8, l]) / z[7];
    der(C[8, l]) = 1 / epsilon[l] * ((-C[8, l] * der(epsilon[l])) - (N[8, l + 1] - N[8, l]) / (x_b[l + 1] - x_b[l]) + r[8, l] - Rp[8, l]);
  end for;
  
//13
  N[1, 1] = y_a[1, 1] / F;
  for i in 2:8 loop
    N[i,1] = 0; // Zusatz-Definitions-Gleichung
  end for;
  
  for i in 1:8 loop
    for l in 2:n loop
      N[i, l] = -(D_eff[i, l] + D_eff[i, l - 1]) / 2 * ((C[i, l] - C[i, l - 1]) / (x_m[l] - x_m[l - 1]) + z[i] * F / (R * T) * (C[i, l] + C[i, l - 1]) / 2 * (phi_II[l] - phi_II[l - 1]) / (x_m[l] - x_m[l - 1]));
    end for;
    
    N[i, n + 1] = 0;
    
    for l in 1:n_s loop
      D_eff[i, l] = D_0[i] * epsilon[l] ^ beta[1];
    end for;
    
    for l in n_s + 1:n loop
      D_eff[i, l] = D_0[i] * epsilon[l] ^ beta[2];
    end for;
  end for;
  
//14
  for i in 1:8 loop
    for l in 1:n_s loop
      r[i, l] = 0;
    end for;
    for l in n_s + 1:n loop
      r[i, l] = -a[l-n_s] * sum(s[i, j] * y_c[j-1, l-n_s] / (n_e[j] * F) for j in 2:6);
    end for;
  end for;
  
//16
  for l in 1:n_p loop
    a[l] = a_0 * (epsilon[n_s+l] / epsilon_init[2]) ^ zeta;
  end for;
  
//17
  0 = y_a[1, 1] - y_0_ref[1] * (product((C[i, 1] / C_ref[i]) ^ p[i, 1] for i in 1:8) * exp(alpha_a[1] * F / (R * T) * eta_a[1, 1])  - product((C[i, 1] / C_ref[i]) ^ q[i, 1] for i in 1:8) * exp(-alpha_c[1] * F / (R * T) * eta_a[1, 1]));
  
  for l in 1:n_p loop
//    y_c[0, l] = 0;
    for j in 2:6 loop
      0 = y_c[j-1, l] - y_0_ref[j] * (product((C[i, l+n_s] / C_ref[i]) ^ p[i, j] for i in 1:8) * exp(alpha_a[j] * F / (R * T) * eta_c[j-1, l])  - product((C[i, l+n_s] / C_ref[i]) ^ q[i, j] for i in 1:8) * exp(-alpha_c[j] * F / (R * T) * eta_c[j-1, l]));
    end for;
  end for;
  
//18
  eta_a[1, 1] = -phi_II[1] - U_ref[1];
  
  for l in 1:n_p loop
    for j in 2:6 loop
      eta_c[j-1, l] = phi_I[l] - phi_II[l+n_s] - U_ref[j];
    end for;
  end for;
  
//21
  for j in 1:6 loop
    U_ref[j] = U_theta[j] - R * T / (n_e[j] * F) * sum(s[i, j] * log(C_ref[i] / 1000) for i in 1:8);
  end for;
  
//22
  for l in 1:n + 1 loop
    i_II[l] = F * sum(z[i] * N[i, l] for i in 1:8);
  end for;
  
//23
  i_I[1] = 0;
  for l in 2:n_p loop
    i_I[l] = -sigma * (phi_I[l] - phi_I[l - 1]) / (x_m[l+n_s] - x_m[l - 1 + n_s]);
  end for;
  i_I[n_p + 1] = i_app;
  
//24 & 25
  for l in 1:n_s loop
    0 = (i_II[l + 1] - i_II[l]) / (x_b[l + 1] - x_b[l]);
  end for;
  
  for l in n_s + 1:n loop
    0 = (i_II[l + 1] - i_II[l]) / (x_b[l + 1] - x_b[l]) + a[l-n_s] * sum(y_c[j-1, l-n_s] for j in 2:6);
    0 = (i_I[l + 1 - n_s] - i_I[l - n_s]) / (x_b[l + 1] - x_b[l]) - a[l-n_s] * sum(y_c[j-1, l-n_s] for j in 2:6);
  end for;
  
//26
  for l in 1:n loop
    for i in 1:8 loop
      Rp[i, l] = sum(gamma[i, k] * Rp_[k, l] for k in 1:5);
    end for;
  end for;
  
//27
  for l in 1:n loop
    for k in 1:5 loop
      Rp_[k, l] = k_rate[k] * epsilon_volume[k, l] * (product(C[i, l] ^ gamma[i, k] for i in 1:8) - K_sp[k]);
    end for;
  end for;
  
//28 & 29
  for l in 1:n loop
    der(epsilon[l]) = -sum(V_molar[k] * Rp_[k, l] for k in 1:5);
    for k in 1:5 loop
      der(epsilon_volume[k, l]) = V_molar[k] * Rp_[k, l];
    end for;
  end for;
end Kumaresan_2008;
