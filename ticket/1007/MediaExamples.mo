package MediaExamples 
  "Example to test the Modelica.Media conmponent. Simulations must be stopped after 1 second." 
  
  package BaseExamples 
    import SI = Modelica.SIunits;
    
    model SimpleAir "This is a very simple test involving the SimpleAir Media." 
      
      package Medium = Modelica.Media.Air.SimpleAir;
      Medium.BaseProperties medium;
    equation 
      medium.T = 300 + time * 50;
      medium.p = 1e5 + time * 1e5;
    end SimpleAir;
    
    model MoistAir 
      "This is a medium level-of-difficulty test involving the MoistAir Media." 
      
      package Medium = Modelica.Media.Air.MoistAir;
      Medium.BaseProperties medium;
    equation 
      medium.T = 300 + time * 50;
      medium.p = 1e5 + time * 1e5;
      medium.X[1] = 0.2;
    end MoistAir;
    
    model DryAirNasa 
      "This is a medium-to-high level-of-difficulty test involving the DryAirNasa Media." 
      
      package Medium = Modelica.Media.Air.DryAirNasa;
      Medium.BaseProperties medium;
    equation 
      medium.T = 300 + time * 50;
      medium.p = 1e5 + time * 1e5;
    end DryAirNasa;
    
    model WaterIF97_ph 
      "This is a high level-of-difficulty test involving the IF97 Media." 
      
      package Medium = Modelica.Media.Water.WaterIF97_pT;
      Medium.BaseProperties medium;
    equation 
      medium.T = 300 + time * 50;
      medium.h = 2e5 + time * 2e5;
    end WaterIF97_ph;
    
    model WaterIF97_pT 
      "This is a high level-of-difficulty test involving the IF97 Media." 
      
      package Medium = Modelica.Media.Water.WaterIF97_pT;
      Medium.BaseProperties medium;
    equation 
      medium.T = 300 + time * 50;
      medium.p = 1e5 + time * 1e5;
    end WaterIF97_pT;
    
    partial model Generic_ph "This is an use example of a generic medium." 
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
      Medium.AbsolutePressure pmin;
      Medium.AbsolutePressure pmax;
      Medium.SpecificEnthalpy hmin;
      Medium.SpecificEnthalpy hmax;
      Medium.MassFraction Xmin[Medium.nXi];
      Medium.MassFraction Xmax[Medium.nXi];
      Medium.BaseProperties medium;
    equation 
      medium.h = hmin + time * (hmax-hmin);
      medium.p = pmin + time * (pmax-pmin);
      
      for i in 1:Medium.nXi loop
      medium.X[i] = Xmin[i] +  time* (Xmax[i]- Xmin[i]);
      end for;
      
    end Generic_ph;
    
    partial model Generic_pT "This is an use example of a generic medium." 
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
      Medium.AbsolutePressure pmin;
      Medium.AbsolutePressure pmax;
      Medium.Temperature Tmin;
      Medium.Temperature Tmax;
      Medium.MassFraction Xmin[Medium.nXi];
      Medium.MassFraction Xmax[Medium.nXi];
      Medium.BaseProperties medium;
    equation 
      medium.T = Tmin + time * (Tmax-Tmin);
      medium.p = pmin + time * (pmax-pmin);
      
      for i in 1:Medium.nXi loop
      medium.X[i] = Xmin[i] +  time* (Xmax[i]- Xmin[i]);
      end for;
      
    end Generic_pT;
  end BaseExamples;
  annotation (uses(Modelica(version="2.2.1")));
  package FunctionsExamples 
    model SimpleAir_functions "SimpleAir plus functions test" 
      extends BaseExamples.SimpleAir;
      import SI = Modelica.SIunits;
      
      Medium.ThermodynamicState state_pTX;
      Medium.ThermodynamicState state_phX;
      Medium.ThermodynamicState state_psX;
      Medium.ThermodynamicState state_dTX;
      Medium.DynamicViscosity eta "Dynamic viscosity";
      Medium.ThermalConductivity lambda "Thermal conductivity";
      Medium.PrandtlNumber Pr "Prandtl number";
      Medium.AbsolutePressure p "Pressure";
      Medium.Temperature T "Temperature";
      Medium.Density d "Density";
      Medium.SpecificEnthalpy h "Specific enthalpy";
      Medium.SpecificEnergy u "Specific internal energy";
      Medium.SpecificEntropy s "Specific entropy";
      Medium.SpecificEnergy g "Specific Gibbs energy";
      Medium.SpecificEnergy f "Specific Helmholtz energy";
      Medium.SpecificHeatCapacity cp 
        "Specific heat capacity at constant pressure";
      Medium.SpecificHeatCapacity cv 
        "Specific heat capacity at constant volume";
      Medium.IsentropicExponent gamma "Isentropic exponent";
    //  Medium.SpecificEnthalpy h_is "Isentropic enthalpy";
      Medium.VelocityOfSound a "Velocity of sound";
    //  Medium.IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
    //  SI.IsothermalCompressibility kappa "Isothermal compressibility";
    //  Medium.DerDensityByPressure ddph "Density derivative wrt pressure";
    //  Medium.DerDensityByEnthalpy ddhp "Density derivative wrt specific enthalpy";
    //  Medium.DerDensityByPressure ddpT "Density derivative wrt pressure";
    //  Medium.DerDensityByTemperature ddTp "Density derivative wrt temperature";
    //  Medium.Density[Medium.nX] dddX "Derivative of density wrt mass fraction";
    //  Medium.MolarMass MM "Mixture molar mass";
      Medium.SpecificEnthalpy h_pTX "Specific enthalpy";
      Medium.Temperature T_phX "Temperature";
      Medium.Density d_phX "Density";
      Medium.Temperature T_psX "Temperature";
      Medium.Density d_psX "Density";
      Medium.SpecificEnthalpy h_psX "Specific enthalpy";
      Medium.ThermodynamicState state_pT 
        "Return thermodynamic state from p and T";
      Medium.ThermodynamicState state_ph 
        "Return thermodynamic state from p and h";
      Medium.ThermodynamicState state_ps 
        "Return thermodynamic state from p and s";
      Medium.ThermodynamicState state_dT 
        "Return thermodynamic state from d and T";
      Medium.Density density_ph "Return density from p and h";
      Medium.Temperature temperature_ph "Return temperature from p and h";
      Medium.AbsolutePressure pressure_dT "Return pressure from d and T";
      Medium.SpecificEnthalpy specificEnthalpy_dT 
        "Return specific enthalphy from d and T";
      Medium.SpecificEnthalpy specificEnthalpy_ps 
        "Return specific enthalphy from p and s";
      Medium.Temperature temperature_ps 
        "Return specific temperature from p ans s";
      Medium.Density density_ps "Return density from p and s";
      Medium.SpecificEnthalpy specificEnthalpy_pT 
        "Return specifc enthalphy from p and T";
      Medium.Density density_pT "Return density from p and T";
      
    equation 
      state_pTX = Medium.setState_pTX(medium.p,medium.T,medium.X);
      state_phX = Medium.setState_phX(medium.p,medium.h,medium.X);
      state_psX = Medium.setState_psX(medium.p,s,medium.X);
      state_dTX = Medium.setState_dTX(medium.d,medium.T,medium.X);
      eta       = Medium.dynamicViscosity(medium);
      lambda    = Medium.thermalConductivity(medium);
      Pr        = Medium.prandtlNumber(medium);
      p         = Medium.pressure(medium);
      T         = Medium.temperature(medium);
      d         = Medium.density(medium);
      h         = Medium.specificEnthalpy(medium);
      u         = Medium.specificInternalEnergy(medium);
      s         = Medium.specificEntropy(medium);
      g         = Medium.specificGibbsEnergy(medium);
      f         = Medium.specificHelmholtzEnergy(medium);
      cp        = Medium.specificHeatCapacityCp(medium);
      cv        = Medium.specificHeatCapacityCv(medium);
      gamma     = Medium.isentropicExponent(medium);
    //  h_is    = Medium.isentropicEnthalpy(medium.p+5e4,medium); //Not implemented
      a         = Medium.velocityOfSound(medium);
    //  beta    = Medium.isobaricExpansionCoefficient(medium); //Not implemented
    //  kappa     = Medium.isothermalCompressibility(medium); //Not implemented
    //  ddph      = Medium.density_derp_h(medium); //Not implemented
    //  ddhp      = Medium.density_derh_p(medium); //Not implemented
    //  ddpT      = Medium.density_derp_T(medium); //Not implemented
    //  ddTp      = Medium.density_derT_p(medium); //Not implemented
    //  dddX      = Medium.density_derX(medium); //Not implemented
    //  MM        = Medium.molarMass(medium); //Not implemented
      h_pTX     = Medium.specificEnthalpy_pTX(medium.p,medium.T,medium.X);
      T_phX     = Medium.temperature_phX(medium.p,medium.h,medium.X);
      d_phX     = Medium.density_phX(medium.p,medium.h,medium.X);
      T_psX   = Medium.temperature_psX(medium.p,s,medium.X);
      d_psX   = Medium.density_psX(medium.p,s,medium.X);
      h_psX   = Medium.specificEnthalpy_psX(medium.p,s,medium.X);
      state_pT = Medium.setState_pT(medium.p,medium.T);
      state_ph = Medium.setState_pT(medium.p,medium.h);
      state_ps = Medium.setState_pT(medium.p,s);
      state_dT = Medium.setState_pT(medium.d,medium.T);
      density_ph = Medium.density_ph(medium.p,medium.h);
      temperature_ph = Medium.temperature_ph(medium.p,medium.h);
      pressure_dT = Medium.pressure_dT(medium.d,medium.T);
      specificEnthalpy_dT = Medium.specificEnthalpy_dT(medium.d,medium.T);
      temperature_ps = Medium.temperature_ps(medium.p, s);
      density_ps = Medium.density_ps(medium.p,s);
      specificEnthalpy_ps = Medium.specificEnthalpy_ps(medium.p,s);
      specificEnthalpy_pT = Medium.specificEnthalpy_pT(medium.p,medium.T);
      density_pT = Medium.density_pT(medium.p, medium.T);
    end SimpleAir_functions;
    
    model MoistAir_functions "MoistAir plus functions test" 
      extends BaseExamples.MoistAir;
      import SI = Modelica.SIunits;
      
      Medium.MassFraction X_sat "steam mass fraction of sat. boundary";
      Medium.ThermodynamicState state_pTX;
      Medium.ThermodynamicState state_phX;
      Medium.ThermodynamicState state_dTX;
      Medium.AbsolutePressure psat "saturation pressure";
      Medium.AbsolutePressure psat_sub "sublimation pressure";
      Medium.AbsolutePressure psat_2 
        "saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)";
      Medium.SpecificEnthalpy r0 "vaporization enthalpy";
      Medium.SpecificHeatCapacity cp_fl;
      Medium.SpecificEnthalpy h_l;
      Medium.SpecificEnthalpy h_g;
      Medium.SpecificEnthalpy h_cg;
      Medium.SpecificEntropy s "Specific entropy";
      Medium.SpecificHeatCapacity cp 
        "Specific heat capacity at constant pressure";
      Medium.SpecificHeatCapacity cv 
        "Specific heat capacity at constant volume";
      Medium.DynamicViscosity eta "Dynamic viscosity";
      Medium.ThermalConductivity lambda "Thermal conductivity";
      Medium.SpecificEnthalpy h_pTX "Specific enthalpy at p, T, X";
      Medium.SpecificEnthalpy h "Specific enthalpy";
      Medium.SpecificEnergy u "Specific internal energy";
      Medium.SpecificEnergy g "Specific Gibbs energy";
      Medium.SpecificEnergy f "Specific Helmholtz energy";
      Medium.Temperature T_phX "Temperature";
      Medium.PrandtlNumber Pr "Prandtl number";
      //Medium.IsentropicExponent gamma "Isentropic exponent";
      //SpecificEnthalpy h_is "Isentropic enthalpy";
      //Medium.VelocityOfSound a "Velocity of sound";
      //Medium.IsobaricExpansionCoefficient beta "Isobaric expansion coefficient";
      //SI.IsothermalCompressibility kappa "Isothermal compressibility";
      //Medium.DerDensityByPressure ddph "Density derivative wrt pressure";
      //Medium.DerDensityByEnthalpy ddhp "Density derivative wrt specific enthalpy";
      //Medium.DerDensityByPressure ddpT "Density derivative wrt pressure";
      //Medium.DerDensityByTemperature ddTp "Density derivative wrt temperature";
      //Medium.Density[Medium.nX] dddX "Derivative of density wrt mass fraction";
      //Medium.MolarMass MM "Mixture molar mass";
      //Medium.SpecificEnthalpy h_pTX "Specific enthalpy";
      //Medium.Temperature T_phX "Temperature";
      Medium.Density d_phX "Density";
      
    equation 
      X_sat=Medium.Xsaturation(medium.state);
      state_pTX=Medium.setState_pTX(medium.p,medium.T,medium.X);
      state_phX=Medium.setState_phX(medium.p,medium.h,medium.X);
      state_dTX=Medium.setState_dTX(medium.d,medium.T,medium.X);
      psat=Medium.saturationPressureLiquid(medium.T);
      psat_sub=Medium.sublimationPressureIce(medium.T);
      psat_2=Medium.saturationPressure(medium.T);
      r0=Medium.enthalpyOfVaporization(medium.T);
      cp_fl=Medium.HeatCapacityOfWater(medium.T);
      h_l=Medium.enthalpyOfLiquid(medium.T);
      h_g=Medium.enthalpyOfGas(medium.T,medium.X);
      h_cg=Medium.enthalpyOfCondensingGas(medium.T);
      s=Medium.specificEntropy(medium);
      cp=Medium.specificHeatCapacityCp(medium);
      cv=Medium.specificHeatCapacityCv(medium);
      eta=Medium.dynamicViscosity(medium);
      lambda=Medium.thermalConductivity(medium);
      h_pTX=Medium.h_pTX(medium.p,medium.T,medium.X);
      h=Medium.specificEnthalpy(medium);
      u=Medium.specificInternalEnergy(medium);
      g=Medium.specificGibbsEnergy(medium);
      f=Medium.specificHelmholtzEnergy(medium);
      T_phX=Medium.T_phX(medium.p,medium.h,medium.X);
      Pr=Medium.prandtlNumber(medium);
      //gamma=Medium.isentropicExponent(medium); //Not implemented
      //h_is=Medium.isentropicEnthalpy(medium.p,medium); //Not implemented
      //a=Medium.velocityOfSound(medium); //Not implemented
      //beta=Medium.isobaricExpansionCoefficient(medium); //Not implemented
      //kappa=Medium.isothermalCompressibility(medium); //Not implemented
      //ddph=Medium.density_derp_h(medium); //Not implemented
      //ddhp=Medium.density_derh_p(medium); //Not implemented  
      //ddpT=Medium.density_derp_T(medium); //Not implemented
      //ddTp=Medium.density_derT_p(medium); //Not implemented
      //dddX=Medium.density_derX(medium); //Not implemented
      //MM=Medium.molarMass(medium); //Not implemented
      //h_pTX=Medium.specificEnthalpy_pTX(medium.p,medium.T,medium.X);
      //T_phX=Medium.temperature_phX(medium.p,medium.h,medium.X);
      d_phX=Medium.density_phX(medium.p,medium.h,medium.X);
    end MoistAir_functions;
  end FunctionsExamples;

  package ExtendedExamples 
    model ComponentWithSimpleAir_ph 
      extends BaseExamples.Generic_ph(redeclare package Medium = 
    Modelica.Media.Air.SimpleAir,pmax=2e5,pmin=1e5,hmax=4e3,hmin=6e3);
    end ComponentWithSimpleAir_ph;
    
    // model ComponentWithMoistAir_ph 
    //   extends BaseExamples.Generic_ph(redeclare package Medium = 
    // Modelica.Media.Air.MoistAir,pmax=2e5,pmin=1e5,hmax=6e5,hmin=4e5);
    //   
    // equation 
    //   medium.X[Medium.Water] = 0.2;
    //   //medium.Xmax[1] = 0.9;
    // end ComponentWithMoistAir_ph;
    
    model ComponentWithDryAirNasa_ph 
      extends BaseExamples.Generic_ph(redeclare package Medium = 
    Modelica.Media.Air.DryAirNasa,pmax=2e5,pmin=1e5,hmax=4.6e5,hmin=3e5);
    end ComponentWithDryAirNasa_ph;
    
    model ComponentWithWaterIF97_ph_ph 
      extends BaseExamples.Generic_ph(redeclare package Medium = 
    Modelica.Media.Water.WaterIF97_ph,pmax=2e5,pmin=1e5,hmax=1e6,hmin=1e5);
    end ComponentWithWaterIF97_ph_ph;
    
    model ComponentWithWaterIF97_pT_ph 
      extends BaseExamples.Generic_ph(redeclare package Medium = 
    Modelica.Media.Water.WaterIF97_pT,pmax=2e5,pmin=1e5,hmax=5e5,hmin=3e5);
    end ComponentWithWaterIF97_pT_ph;
    
    model ComponentWithSimpleAir_pT 
      extends BaseExamples.Generic_pT(redeclare package Medium = 
    Modelica.Media.Air.SimpleAir,pmax=2e5,pmin=1e5,Tmax=370,Tmin=280);
    end ComponentWithSimpleAir_pT;
    
    // model ComponentWithMoistAir_pT 
    //   extends BaseExamples.Generic_pT(redeclare package Medium = 
    // Modelica.Media.Air.MoistAir,pmax=2e5,pmin=1e5,Tmax=4e3,Tmin=3e3);
    //   
    // equation 
    //   medium.X[Medium.Water] = 0.2;
    //   //medium.Xmax[1] = 0.9;
    // end ComponentWithMoistAir_pT;
    
    model ComponentWithDryAirNasa_pT 
      extends BaseExamples.Generic_pT(redeclare package Medium = 
    Modelica.Media.Air.DryAirNasa,pmax=2e5,pmin=1e5,Tmax=4e2,Tmin=3e2);
    end ComponentWithDryAirNasa_pT;
    
    model ComponentWithWaterIF97_ph_pT 
      extends BaseExamples.Generic_pT(redeclare package Medium = 
    Modelica.Media.Water.WaterIF97_pT,pmax=2e5,pmin=1e5,Tmax=4e2,Tmin=3e2);
    end ComponentWithWaterIF97_ph_pT;
    
    model ComponentWithWaterIF97_pT_pT 
      extends BaseExamples.Generic_pT(redeclare package Medium = 
    Modelica.Media.Water.WaterIF97_pT,pmax=2e5,pmin=1e5,Tmax=4e2,Tmin=3e2);
    end ComponentWithWaterIF97_pT_pT;
    
  end ExtendedExamples;
end MediaExamples;
