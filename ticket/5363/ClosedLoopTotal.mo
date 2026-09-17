package ThermoPower  "Open library for thermal power plant simulation" 
  extends Modelica.Icons.Package;

  model System  "System wide properties and defaults" 
    parameter Boolean allowFlowReversal = true "= false to restrict to design flow direction (flangeA -> flangeB)" annotation(Evaluate = true);
    parameter Choices.Init.Options initOpt = Choices.Init.Options.fixedState;
    parameter .Modelica.SIunits.Pressure p_amb = 101325 "Ambient pressure";
    parameter .Modelica.SIunits.Temperature T_amb = 293.15 "Ambient Temperature (dry bulb)";
    parameter .Modelica.SIunits.Temperature T_wb = 288.15 "Ambient temperature (wet bulb)";
    parameter .Modelica.SIunits.Frequency fnom = 50 "Nominal grid frequency";
    annotation(defaultComponentPrefixes = "inner", missingInnerMessage = "The System object is missing, please drag it on the top layer of your model"); 
  end System;

  package Examples  "Application examples" 
    extends Modelica.Icons.ExamplesPackage;

    package HRB  "Heat recovery boiler models" 
      extends Modelica.Icons.ExamplesPackage;

      package Models  
        extends Modelica.Icons.Library;

        model Evaporator  "Fire tube boiler, fixed heat transfer coefficient, no radiative heat transfer" 
          replaceable package FlueGasMedium = ThermoPower.Media.FlueGas constrainedby Modelica.Media.Interfaces.PartialMedium;
          replaceable package FluidMedium = ThermoPower.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
          parameter Integer N = 2 "Number of node of the gas side";
          parameter .Modelica.SIunits.MassFlowRate gasNomFlowRate "Nominal flow rate through the gas side";
          parameter .Modelica.SIunits.MassFlowRate fluidNomFlowRate "Nominal flow rate through the fluid side";
          parameter .Modelica.SIunits.Pressure gasNomPressure "Nominal pressure in the gas side inlet";
          parameter .Modelica.SIunits.Pressure fluidNomPressure "Nominal pressure in the fluid side inlet";
          parameter .Modelica.SIunits.Area exchSurface "Exchange surface between gas - metal tube";
          parameter .Modelica.SIunits.Volume gasVol "Gas volume";
          parameter .Modelica.SIunits.Volume fluidVol "Fluid volume";
          parameter .Modelica.SIunits.Volume metalVol "Volume of the metal part in the tubes";
          parameter .Modelica.SIunits.Density rhom "Metal density";
          parameter .Modelica.SIunits.SpecificHeatCapacity cm "Specific heat capacity of the metal";
          parameter .Modelica.SIunits.Temperature Tstart "Average gas temperature start value";
          parameter .Modelica.SIunits.CoefficientOfHeatTransfer gamma "Constant heat transfer coefficient in the gas side";
          parameter Choices.Flow1D.FFtypes FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.NoFriction "Friction Factor Type, gas side";
          parameter Real Kfnom_G = 0 "Nominal hydraulic resistance coefficient, gas side";
          parameter .Modelica.SIunits.PressureDifference dpnom_G = 0 "Nominal pressure drop, gas side (friction term only!)";
          parameter .Modelica.SIunits.Density rhonom_G = 0 "Nominal inlet density, gas side";
          parameter Real Cfnom_G = 0 "Nominal Fanning friction factor, gsa side";
          parameter Boolean gasQuasiStatic = false "Quasi-static model of the flue gas (mass, energy and momentum static balances";
          Water.DrumEquilibrium water(cm = cm, redeclare package Medium = FluidMedium, Vd = fluidVol, Mm = metalVol * rhom, pstart = fluidNomPressure, Vlstart = fluidVol * 0.8);
          Thermal.HT_DHTVolumes adapter(N = N - 1);
          Water.FlangeA waterIn(redeclare package Medium = FluidMedium);
          Water.FlangeB waterOut(redeclare package Medium = FluidMedium);
          Gas.FlangeA gasIn(redeclare package Medium = FlueGasMedium);
          Gas.FlangeB gasOut(redeclare package Medium = FlueGasMedium);
          Gas.Flow1DFV gasFlow(Dhyd = 1, wnom = gasNomFlowRate, FFtype = ThermoPower.Choices.Flow1D.FFtypes.NoFriction, redeclare package Medium = FlueGasMedium, QuasiStatic = gasQuasiStatic, N = N, L = L, A = gasVol / L, omega = exchSurface / L, Tstartbar = Tstart, redeclare model HeatTransfer = Thermal.HeatTransferFV.ConstantHeatTransferCoefficient(gamma = gamma));
          Modelica.Blocks.Interfaces.RealOutput voidFraction;
          final parameter .Modelica.SIunits.Distance L = 1 "Tube length";
          Modelica.Blocks.Sources.RealExpression realExpression;
          Modelica.Blocks.Sources.RealExpression output1(y = water.Vv / water.Vd);
        equation
          connect(water.feed, waterIn);
          connect(water.steam, waterOut);
          connect(gasFlow.infl, gasIn);
          connect(gasFlow.outfl, gasOut);
          connect(output1.y, voidFraction);
          connect(adapter.DHT_port, gasFlow.wall);
          connect(adapter.HT_port, water.wall);
        end Evaporator;
      end Models;
    end HRB;

    package RankineCycle  "Steam power plant" 
      extends Modelica.Icons.ExamplesPackage;

      package Models  
        extends Modelica.Icons.Package;

        model HE  "Heat Exchanger fluid - gas" 
          replaceable package FlueGasMedium = ThermoPower.Media.FlueGas constrainedby Modelica.Media.Interfaces.PartialMedium;
          replaceable package FluidMedium = ThermoPower.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
          parameter Integer N_G = 2 "Number of node of the gas side";
          parameter Integer N_F = 2 "Number of node of the fluid side";
          parameter .Modelica.SIunits.MassFlowRate gasNomFlowRate "Nominal flow rate through the gas side";
          parameter .Modelica.SIunits.MassFlowRate fluidNomFlowRate "Nominal flow rate through the fluid side";
          parameter .Modelica.SIunits.Pressure gasNomPressure "Nominal pressure in the gas side inlet";
          parameter .Modelica.SIunits.Pressure fluidNomPressure "Nominal pressure in the fluid side inlet";
          parameter .Modelica.SIunits.Area exchSurface_G "Exchange surface between gas - metal tube";
          parameter .Modelica.SIunits.Area exchSurface_F "Exchange surface between metal tube - fluid";
          parameter .Modelica.SIunits.Area extSurfaceTub "Total external surface of the tubes";
          parameter .Modelica.SIunits.Volume gasVol "Gas volume";
          parameter .Modelica.SIunits.Volume fluidVol "Fluid volume";
          parameter .Modelica.SIunits.Volume metalVol "Volume of the metal part in the tubes";
          parameter Real rhomcm "Metal heat capacity per unit volume [J/m^3.K]";
          parameter .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity of the metal (density by specific heat capacity)";
          parameter .Modelica.SIunits.Temperature Tstart_G "Average gas temperature start value";
          parameter .Modelica.SIunits.Temperature Tstart_M "Average metal wall temperature start value";
          parameter Choices.FluidPhase.FluidPhases FluidPhaseStart = Choices.FluidPhase.FluidPhases.Liquid "Initialization fluid phase";
          parameter .Modelica.SIunits.CoefficientOfHeatTransfer gamma_G "Constant heat transfer coefficient in the gas side";
          parameter .Modelica.SIunits.CoefficientOfHeatTransfer gamma_F "Constant heat transfer coefficient in the fluid side";
          parameter Choices.Flow1D.FFtypes FFtype_G = ThermoPower.Choices.Flow1D.FFtypes.NoFriction "Friction Factor Type, gas side";
          parameter Real Kfnom_G = 0 "Nominal hydraulic resistance coefficient, gas side";
          parameter .Modelica.SIunits.PressureDifference dpnom_G = 0 "Nominal pressure drop, gas side (friction term only!)";
          parameter .Modelica.SIunits.Density rhonom_G = 0 "Nominal inlet density, gas side";
          parameter Real Cfnom_G = 0 "Nominal Fanning friction factor, gsa side";
          parameter Choices.Flow1D.FFtypes FFtype_F = ThermoPower.Choices.Flow1D.FFtypes.NoFriction "Friction Factor Type, fluid side";
          parameter Real Kfnom_F = 0 "Nominal hydraulic resistance coefficient, fluid side";
          parameter .Modelica.SIunits.PressureDifference dpnom_F = 0 "Nominal pressure drop, fluid side (friction term only!)";
          parameter .Modelica.SIunits.Density rhonom_F = 0 "Nominal inlet density, fluid side";
          parameter Real Cfnom_F = 0 "Nominal Fanning friction factor, fluid side";
          parameter Choices.Flow1D.HCtypes HCtype_F = ThermoPower.Choices.Flow1D.HCtypes.Downstream "Location of the hydraulic capacitance, fluid side";
          parameter Boolean counterCurrent = true "Counter-current flow";
          parameter Boolean gasQuasiStatic = false "Quasi-static model of the flue gas (mass, energy and momentum static balances";
          constant Real pi = Modelica.Constants.pi;
          Gas.FlangeA gasIn(redeclare package Medium = FlueGasMedium);
          Gas.FlangeB gasOut(redeclare package Medium = FlueGasMedium);
          Water.FlangeA waterIn(redeclare package Medium = FluidMedium);
          Water.FlangeB waterOut(redeclare package Medium = FluidMedium);
          Water.Flow1DFV fluidFlow(Nt = 1, N = N_F, wnom = fluidNomFlowRate, redeclare package Medium = FluidMedium, L = exchSurface_F ^ 2 / (fluidVol * pi * 4), A = (fluidVol * 4 / exchSurface_F) ^ 2 / 4 * pi, omega = fluidVol * 4 / exchSurface_F * pi, Dhyd = fluidVol * 4 / exchSurface_F, FFtype = FFtype_F, dpnom = dpnom_F, rhonom = rhonom_F, HydraulicCapacitance = HCtype_F, Kfnom = Kfnom_F, Cfnom = Cfnom_F, FluidPhaseStart = FluidPhaseStart, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient(gamma = gamma_F));
          Thermal.MetalTubeFV metalTube(rhomcm = rhomcm, lambda = lambda, L = exchSurface_F ^ 2 / (fluidVol * pi * 4), rint = fluidVol * 4 / exchSurface_F / 2, WallRes = false, rext = (metalVol + fluidVol) * 4 / extSurfaceTub / 2, Tstartbar = Tstart_M, Nw = N_F - 1);
          Gas.Flow1DFV gasFlow(Dhyd = 1, wnom = gasNomFlowRate, N = N_G, redeclare package Medium = FlueGasMedium, QuasiStatic = gasQuasiStatic, L = L, A = gasVol / L, omega = exchSurface_G / L, Tstartbar = Tstart_G, dpnom = dpnom_G, rhonom = rhonom_G, Kfnom = Kfnom_G, Cfnom = Cfnom_G, FFtype = FFtype_G, redeclare model HeatTransfer = ThermoPower.Thermal.HeatTransferFV.ConstantHeatTransferCoefficient(gamma = gamma_G));
          Thermal.CounterCurrentFV cC(Nw = N_F - 1);
          final parameter .Modelica.SIunits.Distance L = 1 "Tube length";
        equation
          connect(gasFlow.infl, gasIn);
          connect(gasFlow.outfl, gasOut);
          connect(fluidFlow.outfl, waterOut);
          connect(fluidFlow.infl, waterIn);
          connect(metalTube.ext, cC.side2);
          connect(metalTube.int, fluidFlow.wall);
          connect(gasFlow.wall, cC.side1);
        end HE;

        model PrescribedSpeedPump  "Prescribed speed pump" 
          replaceable package FluidMedium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
          parameter Modelica.SIunits.VolumeFlowRate[3] q_nom "Nominal volume flow rates";
          parameter Modelica.SIunits.Height[3] head_nom "Nominal heads";
          parameter Modelica.SIunits.Density rho0 "Nominal density";
          parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n0 "Nominal rpm";
          parameter Modelica.SIunits.Pressure nominalOutletPressure "Nominal live steam pressure";
          parameter Modelica.SIunits.Pressure nominalInletPressure "Nominal condensation pressure";
          parameter Modelica.SIunits.MassFlowRate nominalMassFlowRate "Nominal steam mass flow rate";
          parameter Modelica.SIunits.SpecificEnthalpy hstart = 1e5 "Fluid Specific Enthalpy Start Value";
          parameter Boolean SSInit = false "Steady-state initialization";
          function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.quadraticFlow(q_nom = {1, 2, 3}, head_nom = {1, 2, 3});
          Water.FlangeA inlet(redeclare package Medium = FluidMedium);
          Water.FlangeB outlet(redeclare package Medium = FluidMedium);
          Water.Pump feedWaterPump(redeclare function flowCharacteristic = flowCharacteristic, n0 = n0, redeclare package Medium = FluidMedium, initOpt = if SSInit then Choices.Init.Options.steadyState else Choices.Init.Options.noInit, wstart = nominalMassFlowRate, w0 = nominalMassFlowRate, dp0 = nominalOutletPressure - nominalInletPressure, rho0 = rho0, hstart = hstart, use_in_n = true);
          Modelica.Blocks.Interfaces.RealInput nPump;
        equation
          connect(nPump, feedWaterPump.in_n);
          connect(feedWaterPump.infl, inlet);
          connect(feedWaterPump.outfl, outlet);
        end PrescribedSpeedPump;

        model PrescribedPressureCondenser  "Ideal condenser with prescribed pressure" 
          replaceable package Medium = Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
          parameter Modelica.SIunits.Pressure p "Nominal inlet pressure";
          parameter Modelica.SIunits.Volume Vtot = 10 "Total volume of the fluid side";
          parameter Modelica.SIunits.Volume Vlstart = 0.15 * Vtot "Start value of the liquid water volume";
          parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
          outer System system "System object";
          Modelica.SIunits.Density rhol "Density of saturated liquid";
          Modelica.SIunits.Density rhov "Density of saturated steam";
          Medium.SaturationProperties sat "Saturation properties";
          Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
          Medium.SpecificEnthalpy hv "Specific enthalpy of saturated vapour";
          Modelica.SIunits.Mass M "Total mass, steam+liquid";
          Modelica.SIunits.Mass Ml "Liquid mass";
          Modelica.SIunits.Mass Mv "Steam mass";
          Modelica.SIunits.Volume Vl(start = Vlstart) "Liquid volume";
          Modelica.SIunits.Volume Vv "Steam volume";
          Modelica.SIunits.Energy E "Internal energy";
          Modelica.SIunits.Power Q "Thermal power";
          Water.FlangeA steamIn(redeclare package Medium = Medium);
          Water.FlangeB waterOut(redeclare package Medium = Medium);
        initial equation
          if initOpt == Choices.Init.Options.noInit then
          elseif initOpt == Choices.Init.Options.fixedState then
            Vl = Vlstart;
          elseif initOpt == Choices.Init.Options.steadyState then
            der(Vl) = 0;
          else
            assert(false, "Unsupported initialisation option");
          end if;
        equation
          steamIn.p = p;
          steamIn.h_outflow = hl;
          sat.psat = p;
          sat.Tsat = Medium.saturationTemperature(p);
          hl = Medium.bubbleEnthalpy(sat);
          hv = Medium.dewEnthalpy(sat);
          waterOut.p = p;
          waterOut.h_outflow = hl;
          rhol = Medium.bubbleDensity(sat);
          rhov = Medium.dewDensity(sat);
          Ml = Vl * rhol;
          Mv = Vv * rhov;
          Vtot = Vv + Vl;
          M = Ml + Mv;
          E = Ml * hl + Mv * inStream(steamIn.h_outflow) - p * Vtot;
          der(M) = steamIn.m_flow + waterOut.m_flow;
          der(E) = steamIn.m_flow * hv + waterOut.m_flow * hl - Q;
        end PrescribedPressureCondenser;

        model Plant  
          replaceable package FlueGas = .ThermoPower.Media.FlueGas constrainedby Modelica.Media.Interfaces.PartialMedium;
          replaceable package Water = .ThermoPower.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
          .ThermoPower.Examples.RankineCycle.Models.PrescribedPressureCondenser condenser(p = 5390, redeclare package Medium = Water, initOpt = .ThermoPower.Choices.Init.Options.fixedState);
          .ThermoPower.Examples.RankineCycle.Models.PrescribedSpeedPump prescribedSpeedPump(n0 = 1500, nominalMassFlowRate = 55, q_nom = {0, 0.055, 0.1}, redeclare package FluidMedium = Water, head_nom = {450, 300, 0}, rho0 = 1000, nominalOutletPressure = 3000000, nominalInletPressure = 50000);
          Modelica.Blocks.Continuous.FirstOrder temperatureActuator(k = 1, y_start = 750, T = 4, initType = Modelica.Blocks.Types.Init.SteadyState);
          Modelica.Blocks.Continuous.FirstOrder powerSensor(k = 1, T = 1, y_start = 56.8e6, initType = Modelica.Blocks.Types.Init.SteadyState);
          Modelica.Blocks.Interfaces.RealOutput generatedPower;
          Modelica.Blocks.Interfaces.RealInput gasFlowRate;
          Modelica.Blocks.Interfaces.RealInput gasTemperature;
          Modelica.Blocks.Continuous.FirstOrder gasFlowActuator(k = 1, T = 4, y_start = 500, initType = Modelica.Blocks.Types.Init.SteadyState);
          Modelica.Blocks.Continuous.FirstOrder nPumpActuator(k = 1, initType = Modelica.Blocks.Types.Init.SteadyState, T = 2, y_start = 1500);
          Modelica.Blocks.Interfaces.RealInput nPump;
          Modelica.Blocks.Interfaces.RealOutput voidFraction;
          Modelica.Blocks.Continuous.FirstOrder voidFractionSensor(k = 1, T = 1, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 0.2);
          .ThermoPower.Water.SteamTurbineStodola steamTurbine(wstart = 55, wnom = 55, Kt = 0.0104, redeclare package Medium = Water, PRstart = 30, pnom = 3000000);
          Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor1;
          .ThermoPower.Examples.RankineCycle.Models.HE economizer(redeclare package FluidMedium = Water, redeclare package FlueGasMedium = FlueGas, N_F = 6, exchSurface_G = 40095.9, exchSurface_F = 3439.389, extSurfaceTub = 3888.449, gasVol = 10, fluidVol = 28.977, metalVol = 8.061, rhomcm = 7900 * 578.05, lambda = 20, gasNomFlowRate = 500, fluidNomFlowRate = 55, gamma_G = 30, gamma_F = 3000, rhonom_G = 1, Kfnom_F = 150, FFtype_G = .ThermoPower.Choices.Flow1D.FFtypes.OpPoint, FFtype_F = .ThermoPower.Choices.Flow1D.FFtypes.Kfnom, N_G = 6, gasNomPressure = 101325, fluidNomPressure = 3000000, Tstart_G = 473.15, Tstart_M = 423.15, dpnom_G = 1000, dpnom_F = 20000);
          .ThermoPower.Examples.HRB.Models.Evaporator evaporator(redeclare package FluidMedium = Water, redeclare package FlueGasMedium = FlueGas, gasVol = 10, fluidVol = 12.400, metalVol = 4.801, gasNomFlowRate = 500, fluidNomFlowRate = 55, N = 4, rhom = 7900, cm = 578.05, gamma = 85, exchSurface = 24402, gasNomPressure = 101325, fluidNomPressure = 3000000, Tstart = 623.15, FFtype_G = .ThermoPower.Choices.Flow1D.FFtypes.OpPoint, dpnom_G = 1000, rhonom_G = 1);
          .ThermoPower.Examples.RankineCycle.Models.HE superheater(redeclare package FluidMedium = Water, redeclare package FlueGasMedium = FlueGas, N_F = 7, exchSurface_G = 2314.8, exchSurface_F = 450.218, extSurfaceTub = 504.652, gasVol = 10, fluidVol = 4.468, metalVol = 1.146, rhomcm = 7900 * 578.05, lambda = 20, gasNomFlowRate = 500, gamma_G = 90, gamma_F = 6000, fluidNomFlowRate = 55, rhonom_G = 1, Kfnom_F = 150, FluidPhaseStart = .ThermoPower.Choices.FluidPhase.FluidPhases.Steam, FFtype_G = .ThermoPower.Choices.Flow1D.FFtypes.OpPoint, FFtype_F = .ThermoPower.Choices.Flow1D.FFtypes.Kfnom, N_G = 7, gasNomPressure = 101325, fluidNomPressure = 3000000, Tstart_G = 723.15, Tstart_M = 573.15, dpnom_G = 1000, dpnom_F = 20000);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateGasInlet(redeclare package Medium = FlueGas);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateGasInletEvaporator(redeclare package Medium = FlueGas);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateGasInletEconomizer(redeclare package Medium = FlueGas);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateGasOutlet(redeclare package Medium = FlueGas);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_water stateWaterSuperheater_in(redeclare package Medium = Water);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_water stateWaterSuperheater_out(redeclare package Medium = Water);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_water stateWaterEvaporator_in(redeclare package Medium = Water);
          .ThermoPower.PowerPlants.HRSG.Components.StateReader_water stateWaterEconomizer_in(redeclare package Medium = Water);
          .ThermoPower.Gas.SourceMassFlow sourceW_gas(w0 = 500, redeclare package Medium = FlueGas, T = 750, use_in_w0 = true, use_in_T = true);
          .ThermoPower.Gas.SinkPressure sinkP_gas(T = 400, redeclare package Medium = FlueGas);
          inner .ThermoPower.System system(allowFlowReversal = false, initOpt = .ThermoPower.Choices.Init.Options.steadyState);
          Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed = 157, phi(start = 0, fixed = true));
        equation
          connect(prescribedSpeedPump.inlet, condenser.waterOut);
          connect(generatedPower, powerSensor.y);
          connect(gasFlowActuator.u, gasFlowRate);
          connect(temperatureActuator.u, gasTemperature);
          connect(nPumpActuator.u, nPump);
          connect(voidFraction, voidFractionSensor.y);
          connect(powerSensor1.flange_a, steamTurbine.shaft_b);
          connect(stateGasInlet.inlet, sourceW_gas.flange);
          connect(condenser.steamIn, steamTurbine.outlet);
          connect(prescribedSpeedPump.outlet, stateWaterEconomizer_in.inlet);
          connect(stateWaterEconomizer_in.outlet, economizer.waterIn);
          connect(economizer.waterOut, stateWaterEvaporator_in.inlet);
          connect(stateWaterEvaporator_in.outlet, evaporator.waterIn);
          connect(economizer.gasIn, stateGasInletEconomizer.outlet);
          connect(stateGasInletEconomizer.inlet, evaporator.gasOut);
          connect(sinkP_gas.flange, stateGasOutlet.outlet);
          connect(stateGasOutlet.inlet, economizer.gasOut);
          connect(evaporator.gasIn, stateGasInletEvaporator.outlet);
          connect(stateGasInletEvaporator.inlet, superheater.gasOut);
          connect(evaporator.waterOut, stateWaterSuperheater_in.inlet);
          connect(stateWaterSuperheater_in.outlet, superheater.waterIn);
          connect(superheater.waterOut, stateWaterSuperheater_out.inlet);
          connect(stateWaterSuperheater_out.outlet, steamTurbine.inlet);
          connect(superheater.gasIn, stateGasInlet.outlet);
          connect(powerSensor.u, powerSensor1.power);
          connect(voidFractionSensor.u, evaporator.voidFraction);
          connect(gasFlowActuator.y, sourceW_gas.in_w0);
          connect(temperatureActuator.y, sourceW_gas.in_T);
          connect(nPumpActuator.y, prescribedSpeedPump.nPump);
          connect(constantSpeed.flange, powerSensor1.flange_b);
        end Plant;

        model PID  "PID controller with anti-windup" 
          parameter Real Kp "Proportional gain (normalised units)";
          parameter .Modelica.SIunits.Time Ti "Integral time";
          parameter Boolean integralAction = true "Use integral action";
          parameter .Modelica.SIunits.Time Td = 0 "Derivative time";
          parameter Real Nd = 1 "Derivative action up to Nd / Td rad/s";
          parameter Real Ni = 1 "Ni*Ti is the time constant of anti-windup compensation";
          parameter Real b = 1 "Setpoint weight on proportional action";
          parameter Real c = 0 "Setpoint weight on derivative action";
          parameter Real PVmin "Minimum value of process variable for scaling";
          parameter Real PVmax "Maximum value of process variable for scaling";
          parameter Real CSmin "Minimum value of control signal for scaling";
          parameter Real CSmax "Maximum value of control signal for scaling";
          parameter Real PVstart = 0.5 "Start value of PV (scaled)";
          parameter Real CSstart = 0.5 "Start value of CS (scaled)";
          parameter Boolean holdWhenSimplified = false "Hold CSs at start value when homotopy=simplified";
          parameter Boolean steadyStateInit = false "Initialize in steady state";
          Real CSs_hom "Control signal scaled in per units, used when homotopy=simplified";
          Real P "Proportional action / Kp";
          Real I(start = CSstart / Kp) "Integral action / Kp";
          Real D "Derivative action / Kp";
          Real Dx(start = c * PVstart - PVstart) "State of approximated derivator";
          Real PVs "Process variable scaled in per unit";
          Real SPs "Setpoint variable scaled in per unit";
          Real CSs(start = CSstart) "Control signal scaled in per unit";
          Real CSbs(start = CSstart) "Control signal scaled in per unit before saturation";
          Real track "Tracking signal for anti-windup integral action";
          Modelica.Blocks.Interfaces.RealInput PV "Process variable signal";
          Modelica.Blocks.Interfaces.RealOutput CS "Control signal";
          Modelica.Blocks.Interfaces.RealInput SP "Set point signal";
        initial equation
          if steadyStateInit then
            if Ti > 0 then
              der(I) = 0;
            end if;
            if Td > 0 then
              D = 0;
            end if;
          end if;
        equation
          SPs = (SP - PVmin) / (PVmax - PVmin);
          PVs = (PV - PVmin) / (PVmax - PVmin);
          CS = CSmin + CSs * (CSmax - CSmin);
          P = b * SPs - PVs;
          if integralAction then
            assert(Ti > 0, "Integral time must be positive");
            Ti * der(I) = SPs - PVs + track;
          else
            I = 0;
          end if;
          if Td > 0 then
            Td / Nd * der(Dx) + Dx = c * SPs - PVs "State equation of approximated derivator";
            D = Nd * (c * SPs - PVs - Dx) "Output equation of approximated derivator";
          else
            Dx = 0;
            D = 0;
          end if;
          if holdWhenSimplified then
            CSs_hom = CSstart;
          else
            CSs_hom = CSbs;
          end if;
          CSbs = Kp * (P + I + D) "Control signal before saturation";
          CSs = homotopy(smooth(0, if CSbs > 1 then 1 else if CSbs < 0 then 0 else CSbs), CSs_hom) "Saturated control signal";
          track = (CSs - CSbs) / (Kp * Ni);
        end PID;
      end Models;

      package Simulators  "Simulation models for the Rankine cycle example" 
        extends Modelica.Icons.ExamplesPackage;

        model ClosedLoop  
          extends Modelica.Icons.Example;
          Modelica.Blocks.Sources.Ramp gasTemperature(height = 0, duration = 0, offset = 750);
          ThermoPower.Examples.RankineCycle.Models.Plant plant(economizer(gasFlow(wnm = 2)));
          Modelica.Blocks.Sources.Step voidFractionSetPoint(offset = 0.2, height = 0, startTime = 0);
          Models.PID voidFractionController(PVmin = 0.1, PVmax = 0.9, CSmax = 2500, PVstart = 0.1, CSstart = 0.5, steadyStateInit = true, CSmin = 500, Kp = -2, Ti = 300);
          Modelica.Blocks.Sources.Ramp powerSetPoint(duration = 450, startTime = 500, height = -56.8e6 * 0.35, offset = 56.8e6);
          Models.PID powerController(steadyStateInit = true, PVmin = 20e6, PVmax = 100e6, Ti = 240, CSmin = 100, CSmax = 1000, Kp = 2, CSstart = 0.7, holdWhenSimplified = true);
          inner System system;
        equation
          connect(voidFractionController.SP, voidFractionSetPoint.y);
          connect(voidFractionController.CS, plant.nPump);
          connect(voidFractionController.PV, plant.voidFraction);
          connect(powerSetPoint.y, powerController.SP);
          connect(powerController.PV, plant.generatedPower);
          connect(gasTemperature.y, plant.gasTemperature);
          connect(powerController.CS, plant.gasFlowRate);
          annotation(experiment(StopTime = 3000, Tolerance = 1e-006), experimentSetupOutput(equdistant = false)); 
        end ClosedLoop;
      end Simulators;
    end RankineCycle;
  end Examples;

  package PowerPlants  "Models of thermoelectrical power plants components" 
    extends Modelica.Icons.ExamplesPackage;

    package HRSG  "Models and tests of the HRSG and its main components" 
      extends Modelica.Icons.Package;

      package Components  "HRSG component models" 
        extends Modelica.Icons.Package;

        model BaseReader_water  "Base reader for the visualization of the state in the simulation (water)" 
          replaceable package Medium = Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialPureSubstance;
          parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
          outer ThermoPower.System system "System wide properties";
          Water.FlangeA inlet(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0));
          Water.FlangeB outlet(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0));
        equation
          inlet.m_flow + outlet.m_flow = 0 "Mass balance";
          inlet.p = outlet.p "No pressure drop";
          inlet.h_outflow = inStream(outlet.h_outflow);
          inStream(inlet.h_outflow) = outlet.h_outflow;
        end BaseReader_water;

        model StateReader_water  "State reader for the visualization of the state in the simulation (water)" 
          extends ThermoPower.PowerPlants.HRSG.Components.BaseReader_water;
          .Modelica.SIunits.Temperature T "Temperature";
          .Modelica.SIunits.Pressure p "Pressure";
          .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          .Modelica.SIunits.MassFlowRate w "Mass flow rate";
          Medium.ThermodynamicState fluidState "Thermodynamic state of the fluid";
        equation
          p = inlet.p;
          h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
          fluidState = Medium.setState_ph(p, h);
          T = Medium.temperature(fluidState);
          w = inlet.m_flow;
        end StateReader_water;

        model BaseReader_gas  "Base reader for the visualization of the state in the simulation (gas)" 
          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
          parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction";
          outer ThermoPower.System system "System wide properties";
          Gas.FlangeA inlet(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0));
          Gas.FlangeB outlet(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0));
        equation
          inlet.m_flow + outlet.m_flow = 0 "Mass balance";
          inlet.p = outlet.p "Momentum balance";
          inlet.h_outflow = inStream(outlet.h_outflow);
          inStream(inlet.h_outflow) = outlet.h_outflow;
          inlet.Xi_outflow = inStream(outlet.Xi_outflow);
          inStream(inlet.Xi_outflow) = outlet.Xi_outflow;
        end BaseReader_gas;

        model StateReader_gas  "State reader for the visualization of the state in the simulation (gas)" 
          extends BaseReader_gas;
          Medium.BaseProperties gas;
          .Modelica.SIunits.Temperature T "Temperature";
          .Modelica.SIunits.Pressure p "Pressure";
          .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          .Modelica.SIunits.MassFlowRate w "Mass flow rate";
        equation
          inlet.p = gas.p;
          gas.h = homotopy(if not allowFlowReversal then inStream(inlet.h_outflow) else actualStream(inlet.h_outflow), inStream(inlet.h_outflow));
          gas.Xi = homotopy(if not allowFlowReversal then inStream(inlet.Xi_outflow) else actualStream(inlet.Xi_outflow), inStream(inlet.Xi_outflow));
          T = gas.T;
          p = gas.p;
          h = gas.h;
          w = inlet.m_flow;
        end StateReader_gas;
      end Components;
    end HRSG;
  end PowerPlants;

  package Gas  "Models of components with ideal gases as working fluid" 
    connector Flange  "Flange connector for gas flows" 
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
      flow Medium.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
      Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
      stream Medium.SpecificEnthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
      stream Medium.MassFraction[Medium.nXi] Xi_outflow "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      stream Medium.ExtraProperty[Medium.nC] C_outflow "Properties c_i/m close to the connection point if m_flow < 0";
    end Flange;

    connector FlangeA  "A-type flange connector for gas flows" 
      extends Flange;
    end FlangeA;

    connector FlangeB  "B-type flange connector for gas flows" 
      extends Flange;
    end FlangeB;

    extends Modelica.Icons.Package;

    model SinkPressure  "Pressure sink for gas flows" 
      extends Icons.Gas.SourceP;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(p(start = p0), T(start = T), Xi(start = Xnom[1:Medium.nXi]));
      parameter Medium.AbsolutePressure p0 = 101325 "Nominal pressure";
      parameter Medium.Temperature T = 300 "Nominal temperature";
      parameter Medium.MassFraction[Medium.nX] Xnom = Medium.reference_X "Nominal gas composition";
      parameter Units.HydraulicResistance R = 0 "Hydraulic Resistance";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
      parameter Boolean use_in_p0 = false "Use connector input for the pressure";
      parameter Boolean use_in_T = false "Use connector input for the temperature";
      parameter Boolean use_in_X = false "Use connector input for the composition";
      outer ThermoPower.System system "System wide properties";
      FlangeA flange(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0));
      Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0;
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X if use_in_X;
    protected
      Modelica.Blocks.Interfaces.RealInput in_p0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X_internal;
    equation
      if R > 0 then
        flange.p = gas.p + flange.m_flow * R;
      else
        flange.p = gas.p;
      end if;
      gas.p = in_p0_internal;
      if not use_in_p0 then
        in_p0_internal = p0 "Pressure set by parameter";
      end if;
      gas.T = in_T_internal;
      if not use_in_T then
        in_T_internal = T "Temperature set by parameter";
      end if;
      gas.Xi = in_X_internal[1:Medium.nXi];
      if not use_in_X then
        in_X_internal = Xnom "Composition set by parameter";
      end if;
      flange.h_outflow = gas.h;
      flange.Xi_outflow = gas.Xi;
      connect(in_p0, in_p0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);
    end SinkPressure;

    model SourceMassFlow  "Flow rate source for gas flows" 
      extends Icons.Gas.SourceW;
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
      Medium.BaseProperties gas(p(start = p0), T(start = T), Xi(start = Xnom[1:Medium.nXi]));
      parameter Medium.AbsolutePressure p0 = 101325 "Nominal pressure";
      parameter Medium.Temperature T = 300 "Nominal temperature";
      parameter Medium.MassFraction[Medium.nX] Xnom = Medium.reference_X "Nominal gas composition";
      parameter Medium.MassFlowRate w0 = 0 "Nominal mass flowrate";
      parameter Units.HydraulicConductance G = 0 "HydraulicConductance";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
      parameter Boolean use_in_w0 = false "Use connector input for the nominal flow rate";
      parameter Boolean use_in_T = false "Use connector input for the temperature";
      parameter Boolean use_in_X = false "Use connector input for the composition";
      outer ThermoPower.System system "System wide properties";
      Medium.MassFlowRate w "Nominal mass flow rate";
      FlangeB flange(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0));
      Modelica.Blocks.Interfaces.RealInput in_w0 if use_in_w0;
      Modelica.Blocks.Interfaces.RealInput in_T if use_in_T;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X if use_in_X;
    protected
      Modelica.Blocks.Interfaces.RealInput in_w0_internal;
      Modelica.Blocks.Interfaces.RealInput in_T_internal;
      Modelica.Blocks.Interfaces.RealInput[Medium.nX] in_X_internal;
    equation
      if G > 0 then
        flange.m_flow = (-w) + (flange.p - p0) * G;
      else
        flange.m_flow = -w;
      end if;
      w = in_w0_internal;
      if not use_in_w0 then
        in_w0_internal = w0 "Flow rate set by parameter";
      end if;
      gas.T = in_T_internal;
      if not use_in_T then
        in_T_internal = T "Temperature set by parameter";
      end if;
      gas.Xi = in_X_internal[1:Medium.nXi];
      if not use_in_X then
        in_X_internal = Xnom "Composition set by parameter";
      end if;
      flange.p = gas.p;
      flange.h_outflow = gas.h;
      flange.Xi_outflow = gas.Xi;
      connect(in_w0, in_w0_internal);
      connect(in_T, in_T_internal);
      connect(in_X, in_X_internal);
    end SourceMassFlow;

    model Flow1DFV  "1-dimensional fluid flow model for gas (finite volumes)" 
      extends BaseClasses.Flow1DBase;
      Thermal.DHTVolumes wall(final N = Nw);
      replaceable model HeatTransfer = Thermal.HeatTransferFV.IdealHeatTransfer constrainedby ThermoPower.Thermal.BaseClasses.DistributedHeatTransferFV;
      HeatTransfer heatTransfer(redeclare package Medium = Medium, final Nf = N, final Nw = Nw, final Nt = Nt, final L = L, final A = A, final Dhyd = Dhyd, final omega = omega, final wnom = wnom / Nt, final w = w * ones(N), final fluidState = gas.state) "Instantiated heat transfer model";
      parameter .Modelica.SIunits.PerUnit wnm = 1e-2 "Maximum fraction of the nominal flow rate allowed as reverse flow";
      Medium.BaseProperties[N] gas "Gas nodal properties";
      .Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction";
      .Modelica.SIunits.Length omega_hyd "Wet perimeter (single tube)";
      Real Kf "Friction factor";
      Real Kfl "Linear friction factor";
      Real dwdt "Time derivative of mass flow rate";
      .Modelica.SIunits.PerUnit Cf "Fanning friction factor";
      Medium.MassFlowRate w(start = wnom / Nt) "Mass flowrate (single tube)";
      Medium.Temperature[N - 1] Ttilde(start = ones(N - 1) * Tstartin + (1:N - 1) / (N - 1) * (Tstartout - Tstartin), each stateSelect = StateSelect.prefer) "Temperature state variables";
      Medium.Temperature[N] T "Node temperatures";
      Medium.SpecificEnthalpy[N] h "Node specific enthalpies";
      Medium.Temperature Tin(start = Tstartin);
      Medium.MassFraction[if UniformComposition or Medium.fixedX then 1 else N - 1, nX] Xtilde(start = ones(size(Xtilde, 1), size(Xtilde, 2)) * diagonal(Xstart[1:nX]), each stateSelect = StateSelect.prefer) "Composition state variables";
      Medium.MassFlowRate[N - 1] wbar(each start = wnom / Nt);
      .Modelica.SIunits.Power[N - 1] Q_single = heatTransfer.Qvol / Nt "Heat flows entering the volumes from the lateral boundary (single tube)";
      .Modelica.SIunits.Velocity[N] u "Fluid velocity";
      Medium.AbsolutePressure p(start = pstart, stateSelect = StateSelect.prefer);
      .Modelica.SIunits.Time Tr "Residence time";
      .Modelica.SIunits.Mass M "Gas Mass (single tube)";
      .Modelica.SIunits.Mass Mtot "Gas Mass (total)";
      .Modelica.SIunits.Power Q "Total heat flow through the wall (all Nt tubes)";
    protected
      parameter .Modelica.SIunits.Length l = L / (N - 1) "Length of a single volume";
      Medium.Density[N - 1] rhobar "Fluid average density";
      .Modelica.SIunits.SpecificVolume[N - 1] vbar "Fluid average specific volume";
      Medium.DerDensityByPressure[N - 1] drbdp "Derivative of average density by pressure";
      Medium.DerDensityByTemperature[N - 1] drbdT1 "Derivative of average density by left temperature";
      Medium.DerDensityByTemperature[N - 1] drbdT2 "Derivative of average density by right temperature";
      Real[N - 1, nX] drbdX1(each unit = "kg/m3") "Derivative of average density by left composition";
      Real[N - 1, nX] drbdX2(each unit = "kg/m3") "Derivative of average density by right composition";
      Medium.SpecificHeatCapacity[N - 1] cvbar "Average cv";
      .Modelica.SIunits.MassFlowRate[N - 1] dMdt "Derivative of mass in a finite volume";
      Medium.SpecificHeatCapacity[N] cv;
      Medium.DerDensityByTemperature[N] dddT "Derivative of density by temperature";
      Medium.DerDensityByPressure[N] dddp "Derivative of density by pressure";
      Real[N, nX] dddX(each unit = "kg/m3") "Derivative of density by composition";
    initial equation
      if initOpt == Choices.Init.Options.noInit or QuasiStatic then
      elseif initOpt == Choices.Init.Options.fixedState then
        if not noInitialPressure then
          p = pstart;
        end if;
        Ttilde = Tstart[2:N];
        Xtilde = ones(size(Xtilde, 1), size(Xtilde, 2)) * diagonal(Xstart[1:nX]);
      elseif initOpt == Choices.Init.Options.steadyState then
        if not Medium.singleState and not noInitialPressure then
          der(p) = 0;
        end if;
        der(Ttilde) = zeros(N - 1);
        if not Medium.fixedX then
          der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
        end if;
      elseif initOpt == Choices.Init.Options.steadyStateNoP then
        der(Ttilde) = zeros(N - 1);
        if not Medium.fixedX then
          der(Xtilde) = zeros(size(Xtilde, 1), size(Xtilde, 2));
        end if;
      else
        assert(false, "Unsupported initialisation option");
      end if;
    equation
      assert(FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction or dpnom > 0, "dpnom=0 not supported, it is also used in the homotopy trasformation during the inizialization");
      omega_hyd = 4 * A / Dhyd;
      if FFtype == ThermoPower.Choices.Flow1D.FFtypes.Kfnom then
        Kf = Kfnom * Kfc;
        Cf = 2 * Kf * A ^ 3 / (omega_hyd * L);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.OpPoint then
        Kf = dpnom * rhonom / (wnom / Nt) ^ 2 * Kfc;
        Cf = 2 * Kf * A ^ 3 / (omega_hyd * L);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.Cfnom then
        Kf = Cfnom * omega_hyd * L / (2 * A ^ 3) * Kfc;
        Cf = Cfnom * Kfc;
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.Colebrook then
        Cf = f_colebrook(w, Dhyd / A, e, Medium.dynamicViscosity(gas[integer(N / 2)].state)) * Kfc;
        Kf = Cf * omega_hyd * L / (2 * A ^ 3);
      elseif FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction then
        Cf = 0;
        Kf = 0;
      else
        assert(false, "Unsupported FFtype");
        Cf = 0;
        Kf = 0;
      end if;
      assert(Kf >= 0, "Negative friction coefficient");
      Kfl = wnom / Nt * wnf * Kf "Linear friction factor";
      dwdt = if DynamicMomentum and not QuasiStatic then der(w) else 0;
      sum(dMdt) = (infl.m_flow + outfl.m_flow) / Nt "Mass balance";
      L / A * dwdt + outfl.p - infl.p + Dpfric = 0 "Momentum balance";
      Dpfric = if FFtype == ThermoPower.Choices.Flow1D.FFtypes.NoFriction then 0 else homotopy(smooth(1, Kf * squareReg(w, wnom / Nt * wnf)) * sum(vbar) / (N - 1), dpnom / (wnom / Nt) * w) "Pressure drop due to friction";
      for j in 1:N - 1 loop
        if not QuasiStatic then
          A * l * rhobar[j] * cvbar[j] * der(Ttilde[j]) + wbar[j] * (gas[j + 1].h - gas[j].h) = Q_single[j] "Energy balance";
          dMdt[j] = A * l * (drbdp[j] * der(p) + drbdT1[j] * der(gas[j].T) + drbdT2[j] * der(gas[j + 1].T) + vector(drbdX1[j, :]) * vector(der(gas[j].X)) + vector(drbdX2[j, :]) * vector(der(gas[j + 1].X))) "Mass balance";
          if avoidInletEnthalpyDerivative and j == 1 then
            rhobar[j] = gas[j + 1].d;
            drbdp[j] = dddp[j + 1];
            drbdT1[j] = 0;
            drbdT2[j] = dddT[j + 1];
            drbdX1[j, :] = zeros(size(Xtilde, 2));
            drbdX2[j, :] = dddX[j + 1, :];
          else
            rhobar[j] = (gas[j].d + gas[j + 1].d) / 2;
            drbdp[j] = (dddp[j] + dddp[j + 1]) / 2;
            drbdT1[j] = dddT[j] / 2;
            drbdT2[j] = dddT[j + 1] / 2;
            drbdX1[j, :] = dddX[j, :] / 2;
            drbdX2[j, :] = dddX[j + 1, :] / 2;
          end if;
          vbar[j] = 1 / rhobar[j];
          wbar[j] = homotopy(infl.m_flow / Nt - sum(dMdt[1:j - 1]) - dMdt[j] / 2, wnom / Nt);
          cvbar[j] = (cv[j] + cv[j + 1]) / 2;
        else
          wbar[j] * (gas[j + 1].h - gas[j].h) = Q_single[j] "Energy balance";
          dMdt[j] = 0 "Mass balance";
          rhobar[j] = 0;
          drbdp[j] = 0;
          drbdT1[j] = 0;
          drbdT2[j] = 0;
          drbdX1[j, :] = zeros(nX);
          drbdX2[j, :] = zeros(nX);
          vbar[j] = 0;
          wbar[j] = infl.m_flow / Nt;
          cvbar[j] = 0;
        end if;
      end for;
      Q = heatTransfer.Q "Total heat flow through the lateral boundary";
      if Medium.fixedX then
        Xtilde = fill(Medium.reference_X, 1);
      elseif QuasiStatic then
        Xtilde = fill(gas[1].X, size(Xtilde, 1)) "Gas composition equal to actual inlet";
      elseif UniformComposition then
        der(Xtilde[1, :]) = homotopy(1 / L * sum(u) / N * (gas[1].X - gas[N].X), 1 / L * unom * (gas[1].X - gas[N].X)) "Partial mass balance for the whole pipe";
      else
        for j in 1:N - 1 loop
          der(Xtilde[j, :]) = homotopy((u[j + 1] + u[j]) / (2 * l) * (gas[j].X - gas[j + 1].X), 1 / L * unom * (gas[j].X - gas[j + 1].X)) "Partial mass balance for single volume";
        end for;
      end if;
      for j in 1:N loop
        u[j] = w / (gas[j].d * A) "Gas velocity";
        gas[j].p = p;
        gas[j].T = T[j];
        gas[j].h = h[j];
      end for;
      for j in 1:N loop
        if not QuasiStatic then
          cv[j] = Medium.heatCapacity_cv(gas[j].state);
          dddT[j] = Medium.density_derT_p(gas[j].state);
          dddp[j] = Medium.density_derp_T(gas[j].state);
          if nX > 0 then
            dddX[j, :] = Medium.density_derX(gas[j].state);
          end if;
        else
          cv[j] = 0;
          dddT[j] = 0;
          dddp[j] = 0;
          dddX[j, :] = zeros(nX);
        end if;
      end for;
      if HydraulicCapacitance == ThermoPower.Choices.Flow1D.HCtypes.Upstream then
        p = infl.p;
        w = -outfl.m_flow / Nt;
      else
        p = outfl.p;
        w = infl.m_flow / Nt;
      end if;
      infl.h_outflow = gas[1].h;
      outfl.h_outflow = gas[N].h;
      infl.Xi_outflow = gas[1].Xi;
      outfl.Xi_outflow = gas[N].Xi;
      gas[1].h = inStream(infl.h_outflow);
      gas[2:N].T = Ttilde;
      gas[1].Xi = inStream(infl.Xi_outflow);
      for j in 2:N loop
        gas[j].Xi = Xtilde[if UniformComposition then 1 else j - 1, 1:nXi];
      end for;
      connect(wall, heatTransfer.wall);
      Tin = gas[1].T;
      M = sum(rhobar) * A * l "Fluid mass (single tube)";
      Mtot = M * Nt "Fluid mass (total)";
      Tr = noEvent(M / max(infl.m_flow / Nt, Modelica.Constants.eps)) "Residence time";
      assert(infl.m_flow > (-wnom * wnm), "Reverse flow not allowed, maybe you connected the component with wrong orientation");
    end Flow1DFV;

    function f_colebrook  "Fanning friction factor for water/steam flows" 
      input .Modelica.SIunits.MassFlowRate w;
      input Real D_A;
      input Real e;
      input .Modelica.SIunits.DynamicViscosity mu;
      output .Modelica.SIunits.PerUnit f;
    protected
      Real Re;
    algorithm
      Re := w * D_A / mu;
      Re := if Re > 2100 then Re else 2100;
      f := 0.332 / log(e / 3.7 + 5.47 / Re ^ 0.9) ^ 2;
    end f_colebrook;

    package BaseClasses  
      extends Modelica.Icons.BasesPackage;

      partial model Flow1DBase  "Basic interface for 1-dimensional water/steam fluid flow models" 
        extends Icons.Gas.Tube;
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
        parameter Integer N(min = 2) = 2 "Number of nodes for thermal variables";
        parameter Integer Nw = N - 1 "Number of volumes on the wall interface";
        parameter Integer Nt = 1 "Number of tubes in parallel";
        parameter .Modelica.SIunits.Distance L "Tube length";
        parameter .Modelica.SIunits.Position H = 0 "Elevation of outlet over inlet";
        parameter .Modelica.SIunits.Area A "Cross-sectional area (single tube)";
        parameter .Modelica.SIunits.Length omega "Perimeter of heat transfer surface (single tube)";
        parameter .Modelica.SIunits.Length Dhyd "Hydraulic Diameter (single tube)";
        parameter Medium.MassFlowRate wnom "Nominal mass flowrate (total)";
        parameter ThermoPower.Choices.Flow1D.FFtypes FFtype = ThermoPower.Choices.Flow1D.FFtypes.NoFriction "Friction Factor Type" annotation(Evaluate = true);
        parameter .Modelica.SIunits.PressureDifference dpnom = 0 "Nominal pressure drop";
        parameter Real Kfnom = 0 "Nominal hydraulic resistance coefficient";
        parameter Medium.Density rhonom = 0 "Nominal inlet density";
        parameter .Modelica.SIunits.PerUnit Cfnom = 0 "Nominal Fanning friction factor";
        parameter .Modelica.SIunits.PerUnit e = 0 "Relative roughness (ratio roughness/diameter)";
        parameter Real Kfc = 1 "Friction factor correction coefficient";
        parameter Boolean DynamicMomentum = false "Inertial phenomena accounted for" annotation(Evaluate = true);
        parameter Boolean UniformComposition = true "Uniform gas composition is assumed" annotation(Evaluate = true);
        parameter Boolean QuasiStatic = false "Quasi-static model (mass, energy and momentum static balances" annotation(Evaluate = true);
        parameter .ThermoPower.Choices.Flow1D.HCtypes HydraulicCapacitance = .ThermoPower.Choices.Flow1D.HCtypes.Downstream "1: Upstream, 2: Downstream";
        parameter Boolean avoidInletEnthalpyDerivative = true "Avoid inlet enthalpy derivative";
        parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
        outer ThermoPower.System system "System wide properties";
        parameter Medium.AbsolutePressure pstart = 1e5 "Pressure start value";
        parameter Medium.Temperature Tstartbar = 300 "Avarage temperature start value";
        parameter Medium.Temperature Tstartin = Tstartbar "Inlet temperature start value";
        parameter Medium.Temperature Tstartout = Tstartbar "Outlet temperature start value";
        parameter Medium.Temperature[N] Tstart = linspace(Tstartin, Tstartout, N) "Start value of temperature vector (initialized by default)";
        final parameter .Modelica.SIunits.Velocity unom = 10 "Nominal velocity for simplified equation";
        parameter Real wnf = 0.01 "Fraction of nominal flow rate at which linear friction equals turbulent friction";
        parameter Medium.MassFraction[nX] Xstart = Medium.reference_X "Start gas composition";
        parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
        parameter Boolean noInitialPressure = false "Remove initial equation on pressure";
        function squareReg = ThermoPower.Functions.squareReg;
      protected
        parameter Integer nXi = Medium.nXi "number of independent mass fractions";
        parameter Integer nX = Medium.nX "total number of mass fractions";
      public
        FlangeA infl(redeclare package Medium = Medium, m_flow(start = wnom, min = if allowFlowReversal then -Modelica.Constants.inf else 0));
        FlangeB outfl(redeclare package Medium = Medium, m_flow(start = -wnom, max = if allowFlowReversal then +Modelica.Constants.inf else 0));
      initial equation
        assert(wnom > 0, "Please set a positive value for wnom");
        assert(FFtype == .ThermoPower.Choices.Flow1D.FFtypes.NoFriction or dpnom > 0, "dpnom=0 not valid, it is also used in the homotopy trasformation during the inizialization");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Kfnom and not Kfnom > 0), "Kfnom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.OpPoint and not rhonom > 0), "rhonom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Cfnom and not Cfnom > 0), "Cfnom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Colebrook and not Dhyd > 0), "Dhyd = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Colebrook and not e > 0), "e = 0 not valid, please set a positive value");
      end Flow1DBase;
    end BaseClasses;
  end Gas;

  package Water  "Models of components with water/steam as working fluid" 
    connector Flange  "Flange connector for water/steam flows" 
      replaceable package Medium = StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
      flow Medium.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
      Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
      stream Medium.SpecificEnthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
      stream Medium.MassFraction[Medium.nXi] Xi_outflow "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      stream Medium.ExtraProperty[Medium.nC] C_outflow "Properties c_i/m close to the connection point if m_flow < 0";
    end Flange;

    connector FlangeA  "A-type flange connector for water/steam flows" 
      extends ThermoPower.Water.Flange;
    end FlangeA;

    connector FlangeB  "B-type flange connector for water/steam flows" 
      extends ThermoPower.Water.Flange;
    end FlangeB;

    extends Modelica.Icons.Package;
    package StandardWater = Modelica.Media.Water.StandardWater;

    model Flow1DFV  "1-dimensional fluid flow model for water/steam (finite volumes)" 
      extends BaseClasses.Flow1DBase;
      parameter .Modelica.SIunits.PerUnit wnm = 1e-3 "Maximum fraction of the nominal flow rate allowed as reverse flow";
      parameter Boolean fixedMassFlowSimplified = false "Fix flow rate = wnom for simplified homotopy model";
      Medium.ThermodynamicState[N] fluidState "Thermodynamic state of the fluid at the nodes";
      .Modelica.SIunits.Length omega_hyd "Wet perimeter (single tube)";
      .Modelica.SIunits.Pressure Dpfric "Pressure drop due to friction (total)";
      .Modelica.SIunits.Pressure Dpfric1 "Pressure drop due to friction (from inlet to capacitance)";
      .Modelica.SIunits.Pressure Dpfric2 "Pressure drop due to friction (from capacitance to outlet)";
      .Modelica.SIunits.Pressure Dpstat "Pressure drop due to static head";
      Medium.MassFlowRate win "Flow rate at the inlet (single tube)";
      Medium.MassFlowRate wout "Flow rate at the outlet (single tube)";
      Real Kf "Hydraulic friction coefficient";
      Real dwdt "Dynamic momentum term";
      .Modelica.SIunits.PerUnit Cf "Fanning friction factor";
      Medium.AbsolutePressure p(start = pstart, stateSelect = StateSelect.prefer) "Fluid pressure for property calculations";
      Medium.MassFlowRate w(start = wnom / Nt) "Mass flow rate (single tube)";
      Medium.MassFlowRate[N - 1] wbar(each start = wnom / Nt) "Average flow rate through volumes (single tube)";
      .Modelica.SIunits.Power[N - 1] Q_single = heatTransfer.Qvol / Nt "Heat flows entering the volumes from the lateral boundary (single tube)";
      .Modelica.SIunits.Velocity[N] u "Fluid velocity";
      Medium.Temperature[N] T "Fluid temperature";
      Medium.SpecificEnthalpy[N] h(start = hstart) "Fluid specific enthalpy at the nodes";
      Medium.SpecificEnthalpy[N - 1] htilde(start = hstart[2:N], each stateSelect = StateSelect.prefer) "Enthalpy state variables";
      Medium.Density[N] rho "Fluid nodal density";
      .Modelica.SIunits.Mass M "Fluid mass (single tube)";
      .Modelica.SIunits.Mass Mtot "Fluid mass (total)";
      .Modelica.SIunits.MassFlowRate[N - 1] dMdt "Time derivative of mass in each cell between two nodes";
      replaceable model HeatTransfer = Thermal.HeatTransferFV.IdealHeatTransfer constrainedby ThermoPower.Thermal.BaseClasses.DistributedHeatTransferFV;
      HeatTransfer heatTransfer(redeclare package Medium = Medium, final Nf = N, final Nw = Nw, final Nt = Nt, final L = L, final A = A, final Dhyd = Dhyd, final omega = omega, final wnom = wnom / Nt, final w = w * ones(N), final fluidState = fluidState) "Instantiated heat transfer model";
      ThermoPower.Thermal.DHTVolumes wall(final N = Nw);
    protected
      Medium.Density[N - 1] rhobar "Fluid average density";
      .Modelica.SIunits.SpecificVolume[N - 1] vbar "Fluid average specific volume";
      .Modelica.SIunits.DerDensityByEnthalpy[N] drdh "Derivative of density by enthalpy";
      .Modelica.SIunits.DerDensityByEnthalpy[N - 1] drbdh "Derivative of average density by enthalpy";
      .Modelica.SIunits.DerDensityByPressure[N] drdp "Derivative of density by pressure";
      .Modelica.SIunits.DerDensityByPressure[N - 1] drbdp "Derivative of average density by pressure";
    initial equation
      if initOpt == Choices.Init.Options.noInit then
      elseif initOpt == Choices.Init.Options.fixedState then
        if not noInitialPressure then
          p = pstart;
        end if;
        htilde = hstart[2:N];
      elseif initOpt == Choices.Init.Options.steadyState then
        der(htilde) = zeros(N - 1);
        if not Medium.singleState and not noInitialPressure then
          der(p) = 0;
        end if;
      elseif initOpt == Choices.Init.Options.steadyStateNoP then
        der(htilde) = zeros(N - 1);
        assert(false, "initOpt = steadyStateNoP deprecated, use steadyState and noInitialPressure", AssertionLevel.warning);
      elseif initOpt == Choices.Init.Options.steadyStateNoT and not Medium.singleState then
        der(p) = 0;
      else
        assert(false, "Unsupported initialisation option");
      end if;
    equation
      omega_hyd = 4 * A / Dhyd;
      if FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Kfnom then
        Kf = Kfnom * Kfc;
      elseif FFtype == .ThermoPower.Choices.Flow1D.FFtypes.OpPoint then
        Kf = dpnom * rhonom / (wnom / Nt) ^ 2 * Kfc;
      elseif FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Cfnom then
        Cf = Cfnom * Kfc;
      elseif FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Colebrook then
        Cf = f_colebrook(w, Dhyd / A, e, Medium.dynamicViscosity(fluidState[integer(N / 2)])) * Kfc;
      else
        Cf = 0;
      end if;
      Kf = Cf * omega_hyd * L / (2 * A ^ 3) "Relationship between friction coefficient and Fanning friction factor";
      assert(Kf >= 0, "Negative friction coefficient");
      if DynamicMomentum then
        dwdt = der(w);
      else
        dwdt = 0;
      end if;
      sum(dMdt) = (infl.m_flow + outfl.m_flow) / Nt "Mass balance";
      L / A * dwdt + outfl.p - infl.p + Dpstat + Dpfric = 0 "Momentum balance";
      Dpfric = Dpfric1 + Dpfric2 "Total pressure drop due to friction";
      if FFtype == .ThermoPower.Choices.Flow1D.FFtypes.NoFriction then
        Dpfric1 = 0;
        Dpfric2 = 0;
      elseif HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Middle then
        Dpfric1 = homotopy(Kf * squareReg(win, wnom / Nt * wnf) * sum(vbar[1:integer((N - 1) / 2)]) / (N - 1), dpnom / 2 / (wnom / Nt) * win) "Pressure drop from inlet to capacitance";
        Dpfric2 = homotopy(Kf * squareReg(wout, wnom / Nt * wnf) * sum(vbar[1 + integer((N - 1) / 2):N - 1]) / (N - 1), dpnom / 2 / (wnom / Nt) * wout) "Pressure drop from capacitance to outlet";
      elseif HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Upstream then
        Dpfric1 = 0 "Pressure drop from inlet to capacitance";
        Dpfric2 = homotopy(Kf * squareReg(wout, wnom / Nt * wnf) * sum(vbar) / (N - 1), dpnom / (wnom / Nt) * wout) "Pressure drop from capacitance to outlet";
      else
        Dpfric1 = homotopy(Kf * squareReg(win, wnom / Nt * wnf) * sum(vbar) / (N - 1), dpnom / (wnom / Nt) * win) "Pressure drop from inlet to capacitance";
        Dpfric2 = 0 "Pressure drop from capacitance to outlet";
      end if;
      Dpstat = if abs(dzdx) < 1e-6 then 0 else g * l * dzdx * sum(rhobar) "Pressure drop due to static head";
      for j in 1:N - 1 loop
        if Medium.singleState then
          A * l * rhobar[j] * der(htilde[j]) + wbar[j] * (h[j + 1] - h[j]) = Q_single[j] "Energy balance (pressure effects neglected)";
        else
          A * l * rhobar[j] * der(htilde[j]) + wbar[j] * (h[j + 1] - h[j]) - A * l * der(p) = Q_single[j] "Energy balance";
        end if;
        dMdt[j] = A * l * (drbdh[j] * der(htilde[j]) + drbdp[j] * der(p)) "Mass derivative for each volume";
        rhobar[j] = (rho[j] + rho[j + 1]) / 2;
        drbdp[j] = (drdp[j] + drdp[j + 1]) / 2;
        drbdh[j] = (drdh[j] + drdh[j + 1]) / 2;
        vbar[j] = 1 / rhobar[j];
        if fixedMassFlowSimplified then
          wbar[j] = homotopy(infl.m_flow / Nt - sum(dMdt[1:j - 1]) - dMdt[j] / 2, wnom / Nt);
        else
          wbar[j] = infl.m_flow / Nt - sum(dMdt[1:j - 1]) - dMdt[j] / 2;
        end if;
      end for;
      for j in 1:N loop
        fluidState[j] = Medium.setState_ph(p, h[j]);
        T[j] = Medium.temperature(fluidState[j]);
        rho[j] = Medium.density(fluidState[j]);
        drdp[j] = if Medium.singleState then 0 else Medium.density_derp_h(fluidState[j]);
        drdh[j] = Medium.density_derh_p(fluidState[j]);
        u[j] = w / (rho[j] * A);
      end for;
      win = infl.m_flow / Nt;
      wout = -outfl.m_flow / Nt;
      assert(HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Upstream or HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Middle or HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Downstream, "Unsupported HydraulicCapacitance option");
      if HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Middle then
        p = infl.p - Dpfric1 - Dpstat / 2;
        w = win;
      elseif HydraulicCapacitance == .ThermoPower.Choices.Flow1D.HCtypes.Upstream then
        p = infl.p;
        w = -outfl.m_flow / Nt;
      else
        p = outfl.p;
        w = win;
      end if;
      infl.h_outflow = htilde[1];
      outfl.h_outflow = htilde[N - 1];
      h[1] = inStream(infl.h_outflow);
      h[2:N] = htilde;
      connect(wall, heatTransfer.wall);
      Q = heatTransfer.Q "Total heat flow through lateral boundary";
      M = sum(rhobar) * A * l "Fluid mass (single tube)";
      Mtot = M * Nt "Fluid mass (total)";
      Tr = noEvent(M / max(win, Modelica.Constants.eps)) "Residence time";
      assert(w > (-wnom * wnm), "Reverse flow not allowed, maybe you connected the component with wrong orientation");
    end Flow1DFV;

    model DrumEquilibrium  
      extends Icons.Water.Drum;
      replaceable package Medium = StandardWater constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium;
      parameter .Modelica.SIunits.Volume Vd "Drum internal volume";
      parameter .Modelica.SIunits.Mass Mm "Drum metal mass";
      parameter Medium.SpecificHeatCapacity cm "Specific heat capacity of the metal";
      parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
      outer ThermoPower.System system "System wide properties";
      parameter .Modelica.SIunits.Pressure pstart "Pressure start value";
      parameter .Modelica.SIunits.Volume Vlstart "Start value of drum water volume";
      parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
      parameter Boolean noInitialPressure = false "Remove initial equation on pressure";
      Medium.SaturationProperties sat "Saturation conditions";
      FlangeA feed(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0));
      FlangeB steam(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a wall "Metal wall thermal port";
      .Modelica.SIunits.Mass Ml "Liquid water mass";
      .Modelica.SIunits.Mass Mv "Steam mass";
      .Modelica.SIunits.Mass M "Total liquid+steam mass";
      .Modelica.SIunits.Energy E "Total energy";
      .Modelica.SIunits.Volume Vv(start = Vd - Vlstart) "Steam volume";
      .Modelica.SIunits.Volume Vl(start = Vlstart, stateSelect = StateSelect.prefer) "Liquid water total volume";
      Medium.AbsolutePressure p(start = pstart, stateSelect = StateSelect.prefer) "Drum pressure";
      Medium.MassFlowRate qf "Feedwater mass flowrate";
      Medium.MassFlowRate qs "Steam mass flowrate";
      .Modelica.SIunits.HeatFlowRate Q "Heat flow to the risers";
      Medium.SpecificEnthalpy hf "Feedwater specific enthalpy";
      Medium.SpecificEnthalpy hl "Specific enthalpy of saturated liquid";
      Medium.SpecificEnthalpy hv "Specific enthalpy of saturated steam";
      Medium.Temperature Ts "Saturation temperature";
      Units.LiquidDensity rhol "Density of saturated liquid";
      Units.GasDensity rhov "Density of saturated steam";
    initial equation
      if initOpt == Choices.Init.Options.noInit then
      elseif initOpt == Choices.Init.Options.fixedState then
        if not noInitialPressure then
          p = pstart;
        end if;
        Vl = Vlstart;
      elseif initOpt == Choices.Init.Options.steadyState then
        if not noInitialPressure then
          der(p) = 0;
        end if;
        der(Vl) = 0;
      else
        assert(false, "Unsupported initialisation option");
      end if;
    equation
      Ml = Vl * rhol "Mass of liquid";
      Mv = Vv * rhov "Mass of vapour";
      M = Ml + Mv "Total mass";
      E = Ml * hl + Mv * hv - p * Vd + Mm * cm * Ts "Total energy";
      Ts = sat.Tsat "Saturation temperature";
      der(M) = qf - qs "Mass balance";
      der(E) = Q + qf * hf - qs * hv "Energy balance";
      Vl + Vv = Vd "Total volume";
      p = feed.p;
      p = steam.p;
      if not allowFlowReversal then
        hf = inStream(feed.h_outflow);
      else
        hf = homotopy(actualStream(feed.h_outflow), inStream(feed.h_outflow));
      end if;
      feed.m_flow = qf;
      -steam.m_flow = qs;
      feed.h_outflow = hl;
      steam.h_outflow = hv;
      Q = wall.Q_flow;
      wall.T = Ts;
      sat.psat = p;
      sat.Tsat = Medium.saturationTemperature(p);
      rhol = Medium.bubbleDensity(sat);
      rhov = Medium.dewDensity(sat);
      hl = Medium.bubbleEnthalpy(sat);
      hv = Medium.dewEnthalpy(sat);
    end DrumEquilibrium;

    model Pump  "Centrifugal pump with ideally controlled speed" 
      extends BaseClasses.PumpBase;
      parameter .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n_const = n0 "Constant rotational speed";
      Modelica.Blocks.Interfaces.RealInput in_n if use_in_n "RPM";
      parameter Boolean use_in_n = false "Use connector input for the rotational speed";
    protected
      Modelica.Blocks.Interfaces.RealInput in_n_int "Internal connector for rotational speed";
    equation
      connect(in_n, in_n_int);
      if not use_in_n then
        in_n_int = n_const "Rotational speed provided by parameter";
      end if;
      n = in_n_int "Rotational speed";
    end Pump;

    function f_colebrook  "Fanning friction factor for water/steam flows" 
      input .Modelica.SIunits.MassFlowRate w;
      input Real D_A;
      input Real e;
      input .Modelica.SIunits.DynamicViscosity mu;
      output .Modelica.SIunits.PerUnit f;
    protected
      .Modelica.SIunits.PerUnit Re;
    algorithm
      Re := abs(w) * D_A / mu;
      Re := if Re > 2100 then Re else 2100;
      f := 0.332 / log(e / 3.7 + 5.47 / Re ^ 0.9) ^ 2;
    end f_colebrook;

    model SteamTurbineStodola  "Steam turbine: Stodola's ellipse law and constant isentropic efficiency" 
      extends BaseClasses.SteamTurbineBase;
      parameter .Modelica.SIunits.PerUnit eta_iso_nom = 0.92 "Nominal isentropic efficiency";
      parameter .Modelica.SIunits.Area Kt "Kt coefficient of Stodola's law";
      Medium.Density rho "Inlet density";
    equation
      rho = Medium.density(steamState_in);
      w = homotopy(Kt * theta * sqrt(pin * rho) * Functions.sqrtReg(1 - (1 / PR) ^ 2), theta * wnom / pnom * pin) "Stodola's law";
      eta_iso = eta_iso_nom "Constant efficiency";
    end SteamTurbineStodola;

    package BaseClasses  "Contains partial models" 
      extends Modelica.Icons.BasesPackage;

      partial model Flow1DBase  "Basic interface for 1-dimensional water/steam fluid flow models" 
        replaceable package Medium = StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        extends Icons.Water.Tube;
        constant Real pi = Modelica.Constants.pi;
        parameter Integer N(min = 2) = 2 "Number of nodes for thermal variables";
        parameter Integer Nw = N - 1 "Number of volumes on the wall interface";
        parameter Integer Nt = 1 "Number of tubes in parallel";
        parameter .Modelica.SIunits.Distance L "Tube length" annotation(Evaluate = true);
        parameter .Modelica.SIunits.Position H = 0 "Elevation of outlet over inlet";
        parameter .Modelica.SIunits.Area A "Cross-sectional area (single tube)";
        parameter .Modelica.SIunits.Length omega "Perimeter of heat transfer surface (single tube)";
        parameter .Modelica.SIunits.Length Dhyd = omega / pi "Hydraulic Diameter (single tube)";
        parameter Medium.MassFlowRate wnom "Nominal mass flowrate (total)";
        parameter ThermoPower.Choices.Flow1D.FFtypes FFtype = ThermoPower.Choices.Flow1D.FFtypes.NoFriction "Friction Factor Type" annotation(Evaluate = true);
        parameter .Modelica.SIunits.PressureDifference dpnom = 0 "Nominal pressure drop (friction term only!)";
        parameter Real Kfnom = 0 "Nominal hydraulic resistance coefficient (DP = Kfnom*w^2/rho)";
        parameter Medium.Density rhonom = 0 "Nominal inlet density";
        parameter .Modelica.SIunits.PerUnit Cfnom = 0 "Nominal Fanning friction factor";
        parameter .Modelica.SIunits.PerUnit e = 0 "Relative roughness (ratio roughness/diameter)";
        parameter .Modelica.SIunits.PerUnit Kfc = 1 "Friction factor correction coefficient";
        parameter Boolean DynamicMomentum = false "Inertial phenomena accounted for" annotation(Evaluate = true);
        parameter ThermoPower.Choices.Flow1D.HCtypes HydraulicCapacitance = ThermoPower.Choices.Flow1D.HCtypes.Downstream "Location of the hydraulic capacitance";
        parameter Boolean avoidInletEnthalpyDerivative = true "Avoid inlet enthalpy derivative";
        parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
        outer ThermoPower.System system "System wide properties";
        parameter Choices.FluidPhase.FluidPhases FluidPhaseStart = Choices.FluidPhase.FluidPhases.Liquid "Fluid phase (only for initialization!)";
        parameter Medium.AbsolutePressure pstart = 1e5 "Pressure start value";
        parameter Medium.SpecificEnthalpy hstartin = if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Inlet enthalpy start value";
        parameter Medium.SpecificEnthalpy hstartout = if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Liquid then 1e5 else if FluidPhaseStart == Choices.FluidPhase.FluidPhases.Steam then 3e6 else 1e6 "Outlet enthalpy start value";
        parameter Medium.SpecificEnthalpy[N] hstart = linspace(hstartin, hstartout, N) "Start value of enthalpy vector (initialized by default)";
        parameter .Modelica.SIunits.PerUnit wnf = 0.02 "Fraction of nominal flow rate at which linear friction equals turbulent friction";
        parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
        parameter Boolean noInitialPressure = false "Remove initial equation on pressure";
        constant .Modelica.SIunits.Acceleration g = Modelica.Constants.g_n;
        function squareReg = ThermoPower.Functions.squareReg;
        FlangeA infl(h_outflow(start = hstartin), redeclare package Medium = Medium, m_flow(start = wnom, min = if allowFlowReversal then -Modelica.Constants.inf else 0));
        FlangeB outfl(h_outflow(start = hstartout), redeclare package Medium = Medium, m_flow(start = -wnom, max = if allowFlowReversal then +Modelica.Constants.inf else 0));
        .Modelica.SIunits.Power Q "Total heat flow through the lateral boundary (all Nt tubes)";
        .Modelica.SIunits.Time Tr "Residence time";
        final parameter .Modelica.SIunits.PerUnit dzdx = H / L "Slope" annotation(Evaluate = true);
        final parameter .Modelica.SIunits.Length l = L / (N - 1) "Length of a single volume";
        final parameter .Modelica.SIunits.Volume V = Nt * A * L "Total volume (all Nt tubes)";
      initial equation
        assert(wnom > 0, "Please set a positive value for wnom");
        assert(FFtype == .ThermoPower.Choices.Flow1D.FFtypes.NoFriction or dpnom > 0, "dpnom=0 not valid, it is also used in the homotopy trasformation during the inizialization");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Kfnom and not Kfnom > 0), "Kfnom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.OpPoint and not rhonom > 0), "rhonom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Cfnom and not Cfnom > 0), "Cfnom = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Colebrook and not Dhyd > 0), "Dhyd = 0 not valid, please set a positive value");
        assert(not (FFtype == .ThermoPower.Choices.Flow1D.FFtypes.Colebrook and not e > 0), "e = 0 not valid, please set a positive value");
        annotation(Evaluate = true); 
      end Flow1DBase;

      partial model PumpBase  "Base model for centrifugal pumps" 
        extends Icons.Water.Pump;
        replaceable package Medium = StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        Medium.ThermodynamicState inletFluidState "Thermodynamic state of the fluid at the inlet";
        replaceable function flowCharacteristic = ThermoPower.Functions.PumpCharacteristics.baseFlow "Head vs. q_flow characteristic at nominal speed and density" annotation(choicesAllMatching = true);
        parameter Boolean usePowerCharacteristic = false "Use powerCharacteristic (vs. efficiencyCharacteristic)";
        replaceable function powerCharacteristic = Functions.PumpCharacteristics.constantPower constrainedby ThermoPower.Functions.PumpCharacteristics.basePower;
        replaceable function efficiencyCharacteristic = Functions.PumpCharacteristics.constantEfficiency(eta_nom = 0.8) constrainedby ThermoPower.Functions.PumpCharacteristics.baseEfficiency;
        parameter Integer Np0(min = 1) = 1 "Nominal number of pumps in parallel";
        parameter Boolean use_in_Np = false "Use connector input for the pressure";
        parameter Units.LiquidDensity rho0 = 1000 "Nominal Liquid Density";
        parameter .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n0 "Nominal rotational speed";
        parameter .Modelica.SIunits.Volume V = 0 "Pump Internal Volume" annotation(Evaluate = true);
        parameter Boolean CheckValve = false "Reverse flow stopped";
        parameter Boolean allowFlowReversal = system.allowFlowReversal "= true to allow flow reversal, false restricts to design direction" annotation(Evaluate = true);
        outer ThermoPower.System system "System wide properties";
        parameter Medium.MassFlowRate wstart = w0 "Mass Flow Rate Start Value";
        parameter Medium.SpecificEnthalpy hstart = 1e5 "Specific Enthalpy Start Value";
        parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
        parameter Boolean noInitialPressure = false "Remove initial equation on pressure";
        constant .Modelica.SIunits.Acceleration g = Modelica.Constants.g_n;
        parameter Medium.MassFlowRate w0 "Nominal mass flow rate";
        parameter .Modelica.SIunits.Pressure dp0 "Nominal pressure increase";
        final parameter .Modelica.SIunits.VolumeFlowRate q_single0 = w0 / (Np0 * rho0) "Nominal volume flow rate (single pump)" annotation(Evaluate = true);
        final parameter .Modelica.SIunits.Height head0 = dp0 / (rho0 * g) "Nominal pump head" annotation(Evaluate = true);
        final parameter Real d_head_dq_0 = (flowCharacteristic(q_single0 * 1.05) - flowCharacteristic(q_single0 * 0.95)) / (q_single0 * 0.1) "Approximate derivative of flow characteristic w.r.t. volume flow" annotation(Evaluate = true);
        final parameter Real d_head_dn_0 = 2 / n0 * head0 - q_single0 / n0 * d_head_dq_0 "Approximate derivative of the flow characteristic w.r.t. rotational speed" annotation(Evaluate = true);
        Medium.MassFlowRate w_single(start = wstart / Np0) "Mass flow rate (single pump)";
        Medium.MassFlowRate w = Np * w_single "Mass flow rate (total)";
        .Modelica.SIunits.VolumeFlowRate q_single(start = wstart / (Np0 * rho0)) "Volume flow rate (single pump)";
        .Modelica.SIunits.VolumeFlowRate q = Np * q_single "Volume flow rate (total)";
        .Modelica.SIunits.PressureDifference dp "Outlet pressure minus inlet pressure";
        .Modelica.SIunits.Height head "Pump head";
        Medium.SpecificEnthalpy h(start = hstart) "Fluid specific enthalpy";
        Medium.SpecificEnthalpy hin "Enthalpy of entering fluid";
        Medium.SpecificEnthalpy hout "Enthalpy of outgoing fluid";
        Units.LiquidDensity rho "Liquid density";
        Medium.Temperature Tin "Liquid inlet temperature";
        .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n "Shaft r.p.m.";
        Integer Np(min = 1) "Number of pumps in parallel";
        .Modelica.SIunits.Power W_single "Power Consumption (single pump)";
        .Modelica.SIunits.Power W = Np * W_single "Power Consumption (total)";
        .Modelica.SIunits.Power Qloss = 0 "Heat loss (single pump)";
        constant .Modelica.SIunits.Power W_eps = 1e-8 "Small coefficient to avoid numerical singularities";
        constant .Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n_eps = 1e-6;
        .Modelica.SIunits.PerUnit eta "Pump efficiency";
        .Modelica.SIunits.PerUnit s(start = 1) "Auxiliary non-dimensional variable";
        FlangeA infl(redeclare package Medium = Medium, m_flow(min = if allowFlowReversal then -Modelica.Constants.inf else 0));
        FlangeB outfl(redeclare package Medium = Medium, m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0));
        Modelica.Blocks.Interfaces.IntegerInput in_Np if use_in_Np "Number of  parallel pumps";
      protected
        Modelica.Blocks.Interfaces.IntegerInput int_Np "Internal connector with number of parallel pumps";
      initial equation
        if initOpt == Choices.Init.Options.noInit then
        elseif initOpt == Choices.Init.Options.fixedState then
          if V > 0 then
            h = hstart;
          end if;
        elseif initOpt == Choices.Init.Options.steadyState then
          if V > 0 then
            der(h) = 0;
          end if;
        else
          assert(false, "Unsupported initialisation option");
        end if;
      equation
        q_single = w_single / homotopy(rho, rho0);
        head = dp / (homotopy(rho, rho0) * g);
        if noEvent(s > 0 or not CheckValve) then
          q_single = s * q_single0;
          head = homotopy((n / n0) ^ 2 * flowCharacteristic(q_single * n0 / (n + n_eps)), head0 + d_head_dq_0 * (q_single - q_single0) + d_head_dn_0 * (n - n0));
        else
          head = homotopy((n / n0) ^ 2 * flowCharacteristic(0) - s * head0, head0 + d_head_dq_0 * (q_single - q_single0) + d_head_dn_0 * (n - n0));
          q_single = 0;
        end if;
        if usePowerCharacteristic then
          W_single = (n / n0) ^ 3 * (rho / rho0) * powerCharacteristic(q_single * n0 / (n + n_eps)) "Power consumption (single pump)";
          eta = dp * q_single / (W_single + W_eps) "Hydraulic efficiency";
        else
          eta = efficiencyCharacteristic(q_single * n0 / (n + n_eps));
          W_single = dp * q_single / eta;
        end if;
        inletFluidState = Medium.setState_ph(infl.p, hin);
        rho = Medium.density(inletFluidState);
        Tin = Medium.temperature(inletFluidState);
        dp = outfl.p - infl.p;
        w = infl.m_flow "Pump total flow rate";
        hin = homotopy(if not allowFlowReversal then inStream(infl.h_outflow) else if w >= 0 then inStream(infl.h_outflow) else inStream(outfl.h_outflow), inStream(infl.h_outflow));
        infl.h_outflow = hout;
        outfl.h_outflow = hout;
        h = hout;
        infl.m_flow + outfl.m_flow = 0 "Mass balance";
        if V > 0 then
          rho * V * der(h) = outfl.m_flow / Np * hout + infl.m_flow / Np * hin + W_single - Qloss "Energy balance";
        else
          0 = outfl.m_flow / Np * hout + infl.m_flow / Np * hin + W_single - Qloss "Energy balance";
        end if;
        connect(in_Np, int_Np);
        if not use_in_Np then
          int_Np = Np0;
        end if;
        Np = int_Np;
      end PumpBase;

      partial model SteamTurbineBase  "Steam turbine" 
        replaceable package Medium = ThermoPower.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Boolean explicitIsentropicEnthalpy = true "Outlet enthalpy computed by isentropicEnthalpy function";
        parameter Medium.MassFlowRate wstart = wnom "Mass flow rate start value";
        parameter .Modelica.SIunits.PerUnit PRstart "Pressure ratio start value";
        parameter Medium.MassFlowRate wnom "Inlet nominal flowrate";
        parameter Medium.AbsolutePressure pnom "Nominal inlet pressure";
        parameter Real eta_mech = 0.98 "Mechanical efficiency";
        parameter Boolean usePartialArcInput = false "Use the input connector for the partial arc opening";
        outer ThermoPower.System system "System wide properties";
        Medium.ThermodynamicState steamState_in;
        Medium.ThermodynamicState steamState_iso;
        .Modelica.SIunits.Angle phi "shaft rotation angle";
        .Modelica.SIunits.Torque tau "net torque acting on the turbine";
        .Modelica.SIunits.AngularVelocity omega "shaft angular velocity";
        Medium.MassFlowRate w(start = wstart) "Mass flow rate";
        Medium.SpecificEnthalpy hin "Inlet enthalpy";
        Medium.SpecificEnthalpy hout "Outlet enthalpy";
        Medium.SpecificEnthalpy hiso "Isentropic outlet enthalpy";
        Medium.SpecificEntropy sin "Inlet entropy";
        Medium.AbsolutePressure pin(start = pnom) "Outlet pressure";
        Medium.AbsolutePressure pout(start = pnom / PRstart) "Outlet pressure";
        .Modelica.SIunits.PerUnit PR "pressure ratio";
        .Modelica.SIunits.Power Pm "Mechanical power input";
        .Modelica.SIunits.PerUnit eta_iso "Isentropic efficiency";
        .Modelica.SIunits.PerUnit theta "Partial arc opening in p.u.";
        Modelica.Blocks.Interfaces.RealInput partialArc if usePartialArcInput "Partial arc opening in p.u.";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a;
        Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b;
        FlangeA inlet(redeclare package Medium = Medium, m_flow(min = 0));
        FlangeB outlet(redeclare package Medium = Medium, m_flow(max = 0));
      protected
        Modelica.Blocks.Interfaces.RealInput partialArc_int "Internal connector for partial arc input";
      equation
        PR = pin / pout "Pressure ratio";
        theta = partialArc_int;
        if not usePartialArcInput then
          partialArc_int = 1 "Default value if not connector input is disabled";
        end if;
        if explicitIsentropicEnthalpy then
          hiso = Medium.isentropicEnthalpy(pout, steamState_in) "Isentropic enthalpy";
          sin = 0;
          steamState_iso = Medium.setState_ph(1e5, 1e5);
        else
          sin = Medium.specificEntropy(steamState_in);
          steamState_iso = Medium.setState_ps(pout, sin);
          hiso = Medium.specificEnthalpy(steamState_iso);
        end if;
        hin - hout = eta_iso * (hin - hiso) "Computation of outlet enthalpy";
        Pm = eta_mech * w * (hin - hout) "Mechanical power from the steam";
        Pm = -tau * omega "Mechanical power balance";
        inlet.m_flow + outlet.m_flow = 0 "Mass balance";
        assert(w >= (-wnom / 100), "The turbine model does not support flow reversal");
        shaft_a.phi = phi;
        shaft_b.phi = phi;
        shaft_a.tau + shaft_b.tau = tau;
        der(phi) = omega;
        steamState_in = Medium.setState_ph(pin, inStream(inlet.h_outflow));
        hin = inStream(inlet.h_outflow);
        hout = outlet.h_outflow;
        pin = inlet.p;
        pout = outlet.p;
        w = inlet.m_flow;
        inlet.h_outflow = outlet.h_outflow;
      end SteamTurbineBase;
    end BaseClasses;
  end Water;

  package Thermal  "Thermal models of heat transfer" 
    extends Modelica.Icons.Package;
    connector HT = Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a "Thermal port for lumped parameter heat transfer";

    connector DHTVolumes  "Distributed Heat Terminal" 
      parameter Integer N "Number of volumes";
      .Modelica.SIunits.Temperature[N] T "Temperature at the volumes";
      flow .Modelica.SIunits.Power[N] Q "Heat flow at the volumes";
    end DHTVolumes;

    model HT_DHTVolumes  "HT to DHT adaptor" 
      parameter Integer N = 1 "Number of volumes on the connectors";
      HT HT_port;
      DHTVolumes DHT_port(N = N);
    equation
      for i in 1:N loop
        DHT_port.T[i] = HT_port.T "Uniform temperature distribution on DHT side";
      end for;
      sum(DHT_port.Q) + HT_port.Q_flow = 0 "Energy balance";
    end HT_DHTVolumes;

    model MetalTubeFV  "Cylindrical metal tube model with Nw finite volumes" 
      extends Icons.MetalWall;
      parameter Integer Nw = 1 "Number of volumes on the wall ports";
      parameter Integer Nt = 1 "Number of tubes in parallel";
      parameter .Modelica.SIunits.Length L "Tube length";
      parameter .Modelica.SIunits.Length rint "Internal radius (single tube)";
      parameter .Modelica.SIunits.Length rext "External radius (single tube)";
      parameter Real rhomcm "Metal heat capacity per unit volume [J/m^3.K]";
      parameter .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
      parameter Boolean WallRes = true "Wall thermal resistance accounted for";
      parameter .Modelica.SIunits.Temperature Tstartbar = 300 "Avarage temperature";
      parameter .Modelica.SIunits.Temperature Tstart1 = Tstartbar "Temperature start value - first volume";
      parameter .Modelica.SIunits.Temperature TstartN = Tstartbar "Temperature start value - last volume";
      parameter .Modelica.SIunits.Temperature[Nw] Tvolstart = Functions.linspaceExt(Tstart1, TstartN, Nw);
      parameter Choices.Init.Options initOpt = system.initOpt "Initialisation option";
      constant Real pi = Modelica.Constants.pi;
      final parameter .Modelica.SIunits.Area Am = (rext ^ 2 - rint ^ 2) * pi "Area of the metal tube cross-section";
      final parameter .Modelica.SIunits.HeatCapacity Cm = Nt * L * Am * rhomcm "Total heat capacity";
      outer ThermoPower.System system "System wide properties";
      .Modelica.SIunits.Temperature[Nw] Tvol(start = Tvolstart) "Volume temperatures";
      ThermoPower.Thermal.DHTVolumes int(final N = Nw, T(start = Tvolstart)) "Internal surface";
      ThermoPower.Thermal.DHTVolumes ext(final N = Nw, T(start = Tvolstart)) "External surface";
    initial equation
      if initOpt == Choices.Init.Options.noInit then
      elseif initOpt == Choices.Init.Options.fixedState then
        Tvol = Tvolstart;
      elseif initOpt == Choices.Init.Options.steadyState then
        der(Tvol) = zeros(Nw);
      elseif initOpt == Choices.Init.Options.steadyStateNoT then
      else
        assert(false, "Unsupported initialisation option");
      end if;
    equation
      assert(rext > rint, "External radius must be greater than internal radius");
      L / Nw * Nt * rhomcm * Am * der(Tvol) = int.Q + ext.Q "Energy balance";
      if WallRes then
        int.Q = lambda * (2 * pi * L / Nw) * (int.T - Tvol) / log((rint + rext) / (2 * rint)) * Nt "Heat conduction through the internal half-thickness";
        ext.Q = lambda * (2 * pi * L / Nw) * (ext.T - Tvol) / log(2 * rext / (rint + rext)) * Nt "Heat conduction through the external half-thickness";
      else
        ext.T = Tvol;
        int.T = Tvol;
      end if;
    end MetalTubeFV;

    model HeatExchangerTopologyFV  "Connects two DHTVolumes ports according to a selected heat exchanger topology" 
      extends Icons.HeatFlow;
      parameter Integer Nw "Number of volumes";
      replaceable model HeatExchangerTopology = HeatExchangerTopologies.CoCurrentFlow constrainedby ThermoPower.Thermal.BaseClasses.HeatExchangerTopologyData;
      HeatExchangerTopology HET(final Nw = Nw);
      Thermal.DHTVolumes side1(final N = Nw);
      Thermal.DHTVolumes side2(final N = Nw);
    equation
      for j in 1:Nw loop
        side2.T[HET.correspondingVolumes[j]] = side1.T[j];
        side2.Q[HET.correspondingVolumes[j]] + side1.Q[j] = 0;
      end for;
    end HeatExchangerTopologyFV;

    model CounterCurrentFV  "Connects two DHTVolume ports according to a counter-current flow configuration" 
      extends ThermoPower.Thermal.HeatExchangerTopologyFV(redeclare model HeatExchangerTopology = HeatExchangerTopologies.CounterCurrentFlow);
    end CounterCurrentFV;

    package HeatTransferFV  "Heat transfer models for FV components" 
      model IdealHeatTransfer  "Delta T across the boundary layer is zero (infinite h.t.c.)" 
        extends BaseClasses.DistributedHeatTransferFV(final useAverageTemperature = false);
      equation
        assert(Nw == Nf - 1, "Number of volumes Nw on wall side should be equal to number of volumes fluid side Nf - 1");
        for j in 1:Nw loop
          wall.T[j] = T[j + 1] "Ideal infinite heat transfer";
        end for;
      end IdealHeatTransfer;

      model ConstantHeatTransferCoefficient  "Constant heat transfer coefficient" 
        extends BaseClasses.DistributedHeatTransferFV;
        parameter .Modelica.SIunits.CoefficientOfHeatTransfer gamma "Constant heat transfer coefficient";
        parameter Boolean adaptiveAverageTemperature = true "Adapt the average temperature at low flow rates";
        parameter Modelica.SIunits.PerUnit sigma = 0.1 "Fraction of nominal flow rate below which the heat transfer is computed on outlet volume temperatures";
        .Modelica.SIunits.PerUnit w_wnom "Ratio between actual and nominal flow rate";
        Medium.Temperature[Nw] Tvol "Fluid temperature in the volumes";
      equation
        assert(Nw == Nf - 1, "The number of volumes Nw on wall side should be equal to number of volumes fluid side Nf - 1");
        w_wnom = abs(w[1]) / wnom;
        for j in 1:Nw loop
          Tvol[j] = if not useAverageTemperature then T[j + 1] else if not adaptiveAverageTemperature then (T[j] + T[j + 1]) / 2 else (T[j] + T[j + 1]) / 2 + (T[j + 1] - T[j]) / 2 * exp(-w_wnom / sigma);
          Qw[j] = (Tw[j] - Tvol[j]) * omega * l * gamma * Nt;
        end for;
      end ConstantHeatTransferCoefficient;
    end HeatTransferFV;

    package HeatExchangerTopologies  
      model CoCurrentFlow  "Co-current flow" 
        extends BaseClasses.HeatExchangerTopologyData(final correspondingVolumes = 1:Nw);
      end CoCurrentFlow;

      model CounterCurrentFlow  "Counter-current flow" 
        extends BaseClasses.HeatExchangerTopologyData(final correspondingVolumes = Nw:(-1):1);
      end CounterCurrentFlow;
    end HeatExchangerTopologies;

    package BaseClasses  
      partial model DistributedHeatTransferFV  "Base class for distributed heat transfer models - finite volumes" 
        extends ThermoPower.Icons.HeatFlow;
        input Medium.ThermodynamicState[Nf] fluidState;
        input Medium.MassFlowRate[Nf] w;
        parameter Boolean useAverageTemperature = true "= true to use average temperature for heat transfer";
        ThermoPower.Thermal.DHTVolumes wall(final N = Nw);
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model";
        parameter Integer Nf(min = 2) = 2 "Number of nodes on the fluid side";
        parameter Integer Nw = Nf - 1 "Number of volumes on the wall side";
        parameter Integer Nt(min = 1) "Number of tubes in parallel";
        parameter .Modelica.SIunits.Distance L "Tube length";
        parameter .Modelica.SIunits.Area A "Cross-sectional area (single tube)";
        parameter .Modelica.SIunits.Length omega "Wet perimeter of heat transfer surface (single tube)";
        parameter .Modelica.SIunits.Length Dhyd "Hydraulic Diameter (single tube)";
        parameter .Modelica.SIunits.MassFlowRate wnom "Nominal mass flow rate (single tube)";
        final parameter .Modelica.SIunits.Length l = L / Nw "Length of a single volume";
        Medium.Temperature[Nf] T "Temperatures at the fluid side nodes";
        Medium.Temperature[Nw] Tw "Temperatures of the wall volumes";
        .Modelica.SIunits.Power[Nw] Qw "Heat flows entering from the wall volumes";
        .Modelica.SIunits.Power[Nf - 1] Qvol = Qw "Heat flows going to the fluid volumes";
        .Modelica.SIunits.Power Q "Total heat flow through lateral boundary";
      equation
        for j in 1:Nf loop
          T[j] = Medium.temperature(fluidState[j]);
        end for;
        Tw = wall.T;
        Qw = wall.Q;
        Q = sum(wall.Q);
      end DistributedHeatTransferFV;

      partial model HeatExchangerTopologyData  "Base class for heat exchanger topology data" 
        parameter Integer Nw "Number of volumes on both sides";
        parameter Integer[Nw] correspondingVolumes "Indeces of corresponding volumes";
      end HeatExchangerTopologyData;
    end BaseClasses;
  end Thermal;

  package Icons  "Icons for ThermoPower library" 
    extends Modelica.Icons.IconsPackage;

    package Water  "Icons for component using water/steam as working fluid" 
      extends Modelica.Icons.Package;

      partial model Tube  end Tube;

      model Drum  end Drum;

      partial model Pump  end Pump;
    end Water;

    partial model HeatFlow  end HeatFlow;

    partial model MetalWall  end MetalWall;

    package Gas  "Icons for component using water/steam as working fluid" 
      extends Modelica.Icons.Package;

      partial model SourceP  end SourceP;

      partial model SourceW  end SourceW;

      partial model Tube  end Tube;
    end Gas;
  end Icons;

  package Choices  "Choice enumerations for ThermoPower models" 
    extends Modelica.Icons.TypesPackage;

    package Flow1D  
      type FFtypes = enumeration(Kfnom "Kfnom friction factor", OpPoint "Friction factor defined by operating point", Cfnom "Cfnom friction factor", Colebrook "Colebrook's equation", NoFriction "No friction") "Type, constants and menu choices to select the friction factor";
      type HCtypes = enumeration(Middle "Middle of the pipe", Upstream "At the inlet", Downstream "At the outlet") "Type, constants and menu choices to select the location of the hydraulic capacitance";
    end Flow1D;

    package Init  "Options for initialisation" 
      type Options = enumeration(noInit "No initial equations", fixedState "Fixed initial state variables", steadyState "Steady-state initialization", steadyStateNoP "Steady-state initialization except pressures (deprecated)", steadyStateNoT "Steady-state initialization except temperatures (deprecated)", steadyStateNoPT "Steady-state initialization except pressures and temperatures (deprecated)") "Type, constants and menu choices to select the initialisation options";
    end Init;

    package FluidPhase  
      type FluidPhases = enumeration(Liquid "Liquid", Steam "Steam", TwoPhases "Two Phases") "Type, constants and menu choices to select the fluid phase";
    end FluidPhase;
  end Choices;

  package Functions  "Miscellaneous functions" 
    extends Modelica.Icons.Package;

    function sqrtReg  "Symmetric square root approximation with finite derivative in zero" 
      extends Modelica.Icons.Function;
      input Real x;
      input Real delta = 0.01 "Range of significant deviation from sqrt(x)";
      output Real y;
    algorithm
      y := x / sqrt(sqrt(x * x + delta * delta));
      annotation(derivative(zeroDerivative = delta) = ThermoPower.Functions.sqrtReg_der); 
    end sqrtReg;

    function sqrtReg_der  "Derivative of sqrtReg" 
      extends Modelica.Icons.Function;
      input Real x;
      input Real delta = 0.01 "Range of significant deviation from sqrt(x)";
      input Real dx "Derivative of x";
      output Real dy;
    algorithm
      dy := dx * 0.5 * (x * x + 2 * delta * delta) / (x * x + delta * delta) ^ 1.25;
    end sqrtReg_der;

    function squareReg  "Anti-symmetric square approximation with non-zero derivative in the origin" 
      extends Modelica.Icons.Function;
      input Real x;
      input Real delta = 0.01 "Range of significant deviation from x^2*sgn(x)";
      output Real y;
    algorithm
      y := x * sqrt(x * x + delta * delta);
    end squareReg;

    function linspaceExt  "Extended linspace function handling also the N=1 case" 
      input Real x1;
      input Real x2;
      input Integer N;
      output Real[N] vec;
    algorithm
      vec := if N == 1 then {x1} else linspace(x1, x2, N);
    end linspaceExt;

    package PumpCharacteristics  "Functions for pump characteristics" 
      partial function baseFlow  "Base class for pump flow characteristics" 
        extends Modelica.Icons.Function;
        input .Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        output .Modelica.SIunits.Height head "Pump head";
      end baseFlow;

      partial function basePower  "Base class for pump power consumption characteristics" 
        extends Modelica.Icons.Function;
        input .Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        output .Modelica.SIunits.Power consumption "Power consumption at nominal density";
      end basePower;

      partial function baseEfficiency  "Base class for efficiency characteristics" 
        extends Modelica.Icons.Function;
        input .Modelica.SIunits.VolumeFlowRate q_flow "Volumetric flow rate";
        output .Modelica.SIunits.PerUnit eta "Efficiency";
      end baseEfficiency;

      function quadraticFlow  "Quadratic flow characteristic" 
        extends baseFlow;
        input .Modelica.SIunits.VolumeFlowRate[3] q_nom "Volume flow rate for three operating points (single pump)";
        input .Modelica.SIunits.Height[3] head_nom "Pump head for three operating points";
      protected
        parameter Real[3] q_nom2 = {q_nom[1] ^ 2, q_nom[2] ^ 2, q_nom[3] ^ 2} "Squared nominal flow rates";
        parameter Real[3] c = Modelica.Math.Matrices.solve([ones(3), q_nom, q_nom2], head_nom) "Coefficients of quadratic head curve";
      algorithm
        head := c[1] + q_flow * c[2] + q_flow ^ 2 * c[3];
      end quadraticFlow;

      function constantPower  "Constant power consumption characteristic" 
        extends basePower;
        input .Modelica.SIunits.Power power = 0 "Constant power consumption";
      algorithm
        consumption := power;
      end constantPower;

      function constantEfficiency  "Constant efficiency characteristic" 
        extends baseEfficiency;
        input .Modelica.SIunits.PerUnit eta_nom "Nominal efficiency";
      algorithm
        eta := eta_nom;
      end constantEfficiency;
    end PumpCharacteristics;
  end Functions;

  package Media  "Medium models for the ThermoPower library" 
    extends Modelica.Icons.Package;

    package FlueGas  "flue gas" 
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(mediumName = "FlueGas", data = {Modelica.Media.IdealGases.Common.SingleGasesData.O2, Modelica.Media.IdealGases.Common.SingleGasesData.Ar, Modelica.Media.IdealGases.Common.SingleGasesData.H2O, Modelica.Media.IdealGases.Common.SingleGasesData.CO2, Modelica.Media.IdealGases.Common.SingleGasesData.N2}, fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.O2, Modelica.Media.IdealGases.Common.FluidData.Ar, Modelica.Media.IdealGases.Common.FluidData.H2O, Modelica.Media.IdealGases.Common.FluidData.CO2, Modelica.Media.IdealGases.Common.FluidData.N2}, substanceNames = {"Oxygen", "Argon", "Water", "Carbondioxide", "Nitrogen"}, reference_X = {0.23, 0.02, 0.01, 0.04, 0.7}, referenceChoice = Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C);
    end FlueGas;
  end Media;

  package Units  "Types with custom units" 
    extends Modelica.Icons.Package;
    type HydraulicConductance = Real(final quantity = "HydraulicConductance", final unit = "(kg/s)/Pa");
    type HydraulicResistance = Real(final quantity = "HydraulicResistance", final unit = "Pa/(kg/s)");
    type LiquidDensity = .Modelica.SIunits.Density(start = 1000, nominal = 1000) "start value for liquids";
    type GasDensity = .Modelica.SIunits.Density(start = 5, nominal = 5) "start value for gases/vapours";
  end Units;
  annotation(version = "3.1"); 
end ThermoPower;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(Protection(access = Access.hide), version = "3.2.2", versionBuild = 0, versionDate = "2016-01-15", dateModified = "2016-01-15 08:44:41Z"); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Continuous  "Library of continuous control blocks with internal states" 
      extends Modelica.Icons.Package;

      block FirstOrder  "First order transfer function block (= 1 pole)" 
        parameter Real k(unit = "1") = 1 "Gain";
        parameter .Modelica.SIunits.Time T(start = 1) "Time Constant";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate = true);
        parameter Real y_start = 0 "Initial or guess value of output (= state)";
        extends .Modelica.Blocks.Interfaces.SISO(y(start = y_start));
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(y) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState or initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = (k * u - y) / T;
      end FirstOrder;
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";
      connector IntegerInput = input Integer "'input Integer' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal";
        RealOutput y "Connector of Real output signal";
      end SISO;

      partial block SignalSource  "Base class for continuous signal source" 
        extends SO;
        parameter Real offset = 0 "Offset of output signal y";
        parameter .Modelica.SIunits.Time startTime = 0 "Output y = offset for time < startTime";
      end SignalSource;
    end Interfaces;

    package Sources  "Library of signal source blocks generating Real, Integer and Boolean signals" 
      extends Modelica.Icons.SourcesPackage;

      block RealExpression  "Set output signal to a time varying Real expression" 
        Modelica.Blocks.Interfaces.RealOutput y = 0.0 "Value of Real output";
      end RealExpression;

      block Step  "Generate step signal of type Real" 
        parameter Real height = 1 "Height of step";
        extends .Modelica.Blocks.Interfaces.SignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
      end Step;

      block Ramp  "Generate ramp signal" 
        parameter Real height = 1 "Height of ramps";
        parameter Modelica.SIunits.Time duration(min = 0.0, start = 2) "Duration of ramp (= 0.0 gives a Step)";
        parameter Real offset = 0 "Offset of output signal";
        parameter Modelica.SIunits.Time startTime = 0 "Output = offset for time < startTime";
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = offset + (if time < startTime then 0 else if time < startTime + duration then (time - startTime) * height / duration else height);
      end Ramp;
    end Sources;

    package Types  "Library of constants and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true);
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;
    end Icons;
  end Blocks;

  package Mechanics  "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)" 
    extends Modelica.Icons.Package;

    package Rotational  "Library to model 1-dimensional, rotational mechanical systems" 
      extends Modelica.Icons.Package;

      package Sensors  "Sensors to measure variables in 1D rotational mechanical components" 
        extends Modelica.Icons.SensorsPackage;

        model PowerSensor  "Ideal sensor to measure the power between two flanges (= flange_a.tau*der(flange_a.phi))" 
          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput power(unit = "W") "Power in flange flange_a as output signal";
        equation
          flange_a.phi = flange_b.phi;
          power = flange_a.tau * der(flange_a.phi);
        end PowerSensor;
      end Sensors;

      package Sources  "Sources to drive 1D rotational mechanical components" 
        extends Modelica.Icons.SourcesPackage;

        model ConstantSpeed  "Constant speed, not dependent on torque" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
          Modelica.SIunits.AngularVelocity w "Angular velocity of flange with respect to support (= der(phi))";
          parameter Modelica.SIunits.AngularVelocity w_fixed "Fixed speed";
        equation
          w = der(phi);
          w = w_fixed;
        end ConstantSpeed;
      end Sources;

      package Interfaces  "Connectors and partial models for 1D rotational mechanical components" 
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a  "One-dimensional rotational flange of a shaft (filled circle icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
        end Flange_a;

        connector Flange_b  "One-dimensional rotational flange of a shaft  (non-filled circle icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
        end Flange_b;

        connector Support  "Support/housing of a 1-dim. rotational shaft" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of the support/housing";
          flow .Modelica.SIunits.Torque tau "Reaction torque in the support/housing";
        end Support;

        partial model PartialElementaryOneFlangeAndSupport2  "Partial model for a component with one rotational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models" 
          parameter Boolean useSupport = false "= true, if support flange enabled, otherwise implicitly grounded" annotation(Evaluate = true, HideResult = true);
          Flange_b flange "Flange of shaft";
          Support support(phi = phi_support, tau = -flange.tau) if useSupport "Support/housing of component";
        protected
          Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
        equation
          if not useSupport then
            phi_support = 0;
          end if;
        end PartialElementaryOneFlangeAndSupport2;

        partial model PartialTorque  "Partial model of a torque acting at the flange (accelerates the flange)" 
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
          Modelica.SIunits.Angle phi "Angle of flange with respect to support (= flange.phi - support.phi)";
        equation
          phi = flange.phi - phi_support;
        end PartialTorque;

        partial model PartialRelativeSensor  "Partial model to measure a single relative variable between two flanges" 
          extends Modelica.Icons.RotationalSensor;
          Flange_a flange_a "Left flange of shaft";
          Flange_b flange_b "Right flange of shaft";
        equation
          0 = flange_a.tau + flange_b.tau;
        end PartialRelativeSensor;
      end Interfaces;
    end Rotational;
  end Mechanics;

  package Media  "Library of media property models" 
    extends Modelica.Icons.Package;

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
        constant AbsolutePressure reference_p = 101325 "Reference pressure of Medium: default 1 atmosphere";
        constant MassFraction[nX] reference_X = fill(1 / nX, nX) "Default mass fractions of medium";
        constant AbsolutePressure p_default = 101325 "Default value for pressure of medium (for initialization)";
        constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20) "Default value for temperature of medium (for initialization)";
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

        replaceable partial function specificGibbsEnergy  "Return specific Gibbs energy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnergy g "Specific Gibbs energy";
        end specificGibbsEnergy;

        replaceable partial function specificHelmholtzEnergy  "Return specific Helmholtz energy" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output SpecificEnergy f "Specific Helmholtz energy";
        end specificHelmholtzEnergy;

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

        function heatCapacity_cv = specificHeatCapacityCv "Alias for deprecated name";

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

        replaceable partial function density_derX  "Return density derivative w.r.t. mass fraction" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state record";
          output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
        end density_derX;

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
      end PartialMedium;

      partial package PartialPureSubstance  "Base class for pure substances of one chemical substance" 
        extends PartialMedium(final reducedX = true, final fixedX = true);

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

      partial package PartialMixtureMedium  "Base class for pure substances of several chemical substances" 
        extends PartialMedium(redeclare replaceable record FluidConstants = Modelica.Media.Interfaces.Types.IdealGas.FluidConstants);

        redeclare replaceable record extends ThermodynamicState  "Thermodynamic state variables" 
          AbsolutePressure p "Absolute pressure of medium";
          Temperature T "Temperature of medium";
          MassFraction[nX] X(start = reference_X) "Mass fractions (= (component mass)/total mass  m_i/m)";
        end ThermodynamicState;

        constant FluidConstants[nS] fluidConstants "Constant data for the fluid";

        replaceable function gasConstant  "Return the gas constant of the mixture (also for liquids)" 
          extends Modelica.Icons.Function;
          input ThermodynamicState state "Thermodynamic state";
          output .Modelica.SIunits.SpecificHeatCapacity R "Mixture gas constant";
        end gasConstant;

        function massToMoleFractions  "Return mole fractions from mass fractions X" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.MassFraction[:] X "Mass fractions of mixture";
          input .Modelica.SIunits.MolarMass[:] MMX "Molar masses of components";
          output .Modelica.SIunits.MoleFraction[size(X, 1)] moleFractions "Mole fractions of gas mixture";
        protected
          Real[size(X, 1)] invMMX "Inverses of molar weights";
          .Modelica.SIunits.MolarMass Mmix "Molar mass of mixture";
        algorithm
          for i in 1:size(X, 1) loop
            invMMX[i] := 1 / MMX[i];
          end for;
          Mmix := 1 / (X * invMMX);
          for i in 1:size(X, 1) loop
            moleFractions[i] := Mmix * X[i] / MMX[i];
          end for;
          annotation(smoothOrder = 5); 
        end massToMoleFractions;
      end PartialMixtureMedium;

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

        replaceable partial function saturationTemperature_derp  "Return derivative of saturation temperature w.r.t. pressure" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          output DerTemperatureByPressure dTp "Derivative of saturation temperature w.r.t. pressure";
        end saturationTemperature_derp;

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
        type ReferenceEnthalpy = enumeration(ZeroAt0K "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded", ZeroAt25C "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded", UserDefined "The user-defined reference enthalpy is used at 293.15 K (25 degC)") "Enumeration defining the reference enthalpy of a medium" annotation(Evaluate = true);
      end Choices;

      package Types  "Types to be used in fluid models" 
        extends Modelica.Icons.Package;
        type AbsolutePressure = .Modelica.SIunits.AbsolutePressure(min = 0, max = 1.e8, nominal = 1.e5, start = 1.e5) "Type for absolute pressure with medium specific attributes";
        type Density = .Modelica.SIunits.Density(min = 0, max = 1.e5, nominal = 1, start = 1) "Type for density with medium specific attributes";
        type DynamicViscosity = .Modelica.SIunits.DynamicViscosity(min = 0, max = 1.e8, nominal = 1.e-3, start = 1.e-3) "Type for dynamic viscosity with medium specific attributes";
        type MassFraction = Real(quantity = "MassFraction", final unit = "kg/kg", min = 0, max = 1, nominal = 0.1) "Type for mass fraction with medium specific attributes";
        type MoleFraction = Real(quantity = "MoleFraction", final unit = "mol/mol", min = 0, max = 1, nominal = 0.1) "Type for mole fraction with medium specific attributes";
        type MolarMass = .Modelica.SIunits.MolarMass(min = 0.001, max = 0.25, nominal = 0.032) "Type for molar mass with medium specific attributes";
        type MolarVolume = .Modelica.SIunits.MolarVolume(min = 1e-6, max = 1.0e6, nominal = 1.0) "Type for molar volume with medium specific attributes";
        type IsentropicExponent = .Modelica.SIunits.RatioOfSpecificHeatCapacities(min = 1, max = 500000, nominal = 1.2, start = 1.2) "Type for isentropic exponent with medium specific attributes";
        type SpecificEnergy = .Modelica.SIunits.SpecificEnergy(min = -1.0e8, max = 1.e8, nominal = 1.e6) "Type for specific energy with medium specific attributes";
        type SpecificInternalEnergy = SpecificEnergy "Type for specific internal energy with medium specific attributes";
        type SpecificEnthalpy = .Modelica.SIunits.SpecificEnthalpy(min = -1.0e10, max = 1.e10, nominal = 1.e6) "Type for specific enthalpy with medium specific attributes";
        type SpecificEntropy = .Modelica.SIunits.SpecificEntropy(min = -1.e7, max = 1.e7, nominal = 1.e3) "Type for specific entropy with medium specific attributes";
        type SpecificHeatCapacity = .Modelica.SIunits.SpecificHeatCapacity(min = 0, max = 1.e7, nominal = 1.e3, start = 1.e3) "Type for specific heat capacity with medium specific attributes";
        type SurfaceTension = .Modelica.SIunits.SurfaceTension "Type for surface tension with medium specific attributes";
        type Temperature = .Modelica.SIunits.Temperature(min = 1, max = 1.e4, nominal = 300, start = 288.15) "Type for temperature with medium specific attributes";
        type ThermalConductivity = .Modelica.SIunits.ThermalConductivity(min = 0, max = 500, nominal = 1, start = 1) "Type for thermal conductivity with medium specific attributes";
        type VelocityOfSound = .Modelica.SIunits.Velocity(min = 0, max = 1.e5, nominal = 1000, start = 1000) "Type for velocity of sound with medium specific attributes";
        type ExtraProperty = Real(min = 0.0, start = 1.0) "Type for unspecified, mass-specific property transported by flow";
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

        package IdealGas  "The ideal gas version of a record used in several degrees of detail" 
          extends Icons.Package;

          record FluidConstants  "Extended fluid constants" 
            extends Modelica.Media.Interfaces.Types.Basic.FluidConstants;
            Temperature criticalTemperature "Critical temperature";
            AbsolutePressure criticalPressure "Critical pressure";
            MolarVolume criticalMolarVolume "Critical molar Volume";
            Real acentricFactor "Pitzer acentric factor";
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
            Boolean hasVapourPressureCurve = false "True if vapour pressure data, e.g., Antoine coefficients are known";
            Boolean hasAcentricFactor = false "True if Pitzer accentric factor is known";
            SpecificEnthalpy HCRIT0 = 0.0 "Critical specific enthalpy of the fundamental equation";
            SpecificEntropy SCRIT0 = 0.0 "Critical specific entropy of the fundamental equation";
            SpecificEnthalpy deltah = 0.0 "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
            SpecificEntropy deltas = 0.0 "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
          end FluidConstants;
        end IdealGas;

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
            Boolean hasVapourPressureCurve = false "True if vapour pressure data, e.g., Antoine coefficients are known";
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
      type DerPressureByDensity = Real(final quantity = "DerPressureByDensity", final unit = "Pa.m3/kg");
      type DerPressureByTemperature = Real(final quantity = "DerPressureByTemperature", final unit = "Pa/K");
      constant Real MINPOS = 1.0e-9 "Minimal value for physical variables which are always > 0.0";

      record IF97BaseTwoPhase  "Intermediate property data record for IF 97" 
        extends Modelica.Icons.Record;
        Integer phase(start = 0) "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
        Integer region(min = 1, max = 5) "IF 97 region";
        .Modelica.SIunits.Pressure p "Pressure";
        .Modelica.SIunits.Temperature T "Temperature";
        .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        .Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
        .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        .Modelica.SIunits.Density rho "Density";
        .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
        Real vt "Derivative of specific volume w.r.t. temperature";
        Real vp "Derivative of specific volume w.r.t. pressure";
        Real x "Dryness fraction";
        Real dpT "dp/dT derivative of saturation curve";
      end IF97BaseTwoPhase;

      record IF97PhaseBoundaryProperties  "Thermodynamic base properties on the phase boundary for IF97 steam tables" 
        extends Modelica.Icons.Record;
        Boolean region3boundary "True if boundary between 2-phase and region 3";
        .Modelica.SIunits.SpecificHeatCapacity R "Specific heat capacity";
        .Modelica.SIunits.Temperature T "Temperature";
        .Modelica.SIunits.Density d "Density";
        .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        .Modelica.SIunits.SpecificHeatCapacity cp "Heat capacity at constant pressure";
        .Modelica.SIunits.SpecificHeatCapacity cv "Heat capacity at constant volume";
        DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
        DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
        Real vt(unit = "m3/(kg.K)") "Derivative of specific volume w.r.t. temperature";
        Real vp(unit = "m3/(kg.Pa)") "Derivative of specific volume w.r.t. pressure";
      end IF97PhaseBoundaryProperties;

      record GibbsDerivs  "Derivatives of dimensionless Gibbs-function w.r.t. dimensionless pressure and temperature" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Pressure p "Pressure";
        .Modelica.SIunits.Temperature T "Temperature";
        .Modelica.SIunits.SpecificHeatCapacity R "Specific heat capacity";
        Real pi(unit = "1") "Dimensionless pressure";
        Real tau(unit = "1") "Dimensionless temperature";
        Real g(unit = "1") "Dimensionless Gibbs-function";
        Real gpi(unit = "1") "Derivative of g w.r.t. pi";
        Real gpipi(unit = "1") "2nd derivative of g w.r.t. pi";
        Real gtau(unit = "1") "Derivative of g w.r.t. tau";
        Real gtautau(unit = "1") "2nd derivative of g w.r.t. tau";
        Real gtaupi(unit = "1") "Mixed derivative of g w.r.t. pi and tau";
      end GibbsDerivs;

      record HelmholtzDerivs  "Derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressure, density and temperature" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Density d "Density";
        .Modelica.SIunits.Temperature T "Temperature";
        .Modelica.SIunits.SpecificHeatCapacity R "Specific heat capacity";
        Real delta(unit = "1") "Dimensionless density";
        Real tau(unit = "1") "Dimensionless temperature";
        Real f(unit = "1") "Dimensionless Helmholtz-function";
        Real fdelta(unit = "1") "Derivative of f w.r.t. delta";
        Real fdeltadelta(unit = "1") "2nd derivative of f w.r.t. delta";
        Real ftau(unit = "1") "Derivative of f w.r.t. tau";
        Real ftautau(unit = "1") "2nd derivative of f w.r.t. tau";
        Real fdeltatau(unit = "1") "Mixed derivative of f w.r.t. delta and tau";
      end HelmholtzDerivs;

      record PhaseBoundaryProperties  "Thermodynamic base properties on the phase boundary" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Density d "Density";
        .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        .Modelica.SIunits.SpecificEnergy u "Inner energy";
        .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        .Modelica.SIunits.SpecificHeatCapacity cp "Heat capacity at constant pressure";
        .Modelica.SIunits.SpecificHeatCapacity cv "Heat capacity at constant volume";
        DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      end PhaseBoundaryProperties;

      record NewtonDerivatives_ph  "Derivatives for fast inverse calculations of Helmholtz functions: p & h" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Pressure p "Pressure";
        .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
        DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
        Real hd "Derivative of specific enthalpy w.r.t. density";
        Real ht "Derivative of specific enthalpy w.r.t. temperature";
      end NewtonDerivatives_ph;

      record NewtonDerivatives_ps  "Derivatives for fast inverse calculation of Helmholtz functions: p & s" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Pressure p "Pressure";
        .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
        DerPressureByTemperature pt "Derivative of pressure w.r.t. temperature";
        Real sd "Derivative of specific entropy w.r.t. density";
        Real st "Derivative of specific entropy w.r.t. temperature";
      end NewtonDerivatives_ps;

      record NewtonDerivatives_pT  "Derivatives for fast inverse calculations of Helmholtz functions:p & T" 
        extends Modelica.Icons.Record;
        .Modelica.SIunits.Pressure p "Pressure";
        DerPressureByDensity pd "Derivative of pressure w.r.t. density";
      end NewtonDerivatives_pT;

      function gibbsToBoundaryProps  "Calculate phase boundary property record from dimensionless Gibbs function" 
        extends Modelica.Icons.Function;
        input GibbsDerivs g "Dimensionless derivatives of Gibbs function";
        output PhaseBoundaryProperties sat "Phase boundary properties";
      protected
        Real vt "Derivative of specific volume w.r.t. temperature";
        Real vp "Derivative of specific volume w.r.t. pressure";
      algorithm
        sat.d := g.p / (g.R * g.T * g.pi * g.gpi);
        sat.h := g.R * g.T * g.tau * g.gtau;
        sat.u := g.T * g.R * (g.tau * g.gtau - g.pi * g.gpi);
        sat.s := g.R * (g.tau * g.gtau - g.g);
        sat.cp := -g.R * g.tau * g.tau * g.gtautau;
        sat.cv := g.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
        vt := g.R / g.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
        vp := g.R * g.T / (g.p * g.p) * g.pi * g.pi * g.gpipi;
        sat.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
        sat.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
      end gibbsToBoundaryProps;

      function helmholtzToBoundaryProps  "Calculate phase boundary property record from dimensionless Helmholtz function" 
        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
        output PhaseBoundaryProperties sat "Phase boundary property record";
      protected
        .Modelica.SIunits.Pressure p "Pressure";
      algorithm
        p := f.R * f.d * f.T * f.delta * f.fdelta;
        sat.d := f.d;
        sat.h := f.R * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
        sat.s := f.R * (f.tau * f.ftau - f.f);
        sat.u := f.R * f.T * f.tau * f.ftau;
        sat.cp := f.R * ((-f.tau * f.tau * f.ftautau) + (f.delta * f.fdelta - f.delta * f.tau * f.fdeltatau) ^ 2 / (2 * f.delta * f.fdelta + f.delta * f.delta * f.fdeltadelta));
        sat.cv := f.R * (-f.tau * f.tau * f.ftautau);
        sat.pt := f.R * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
        sat.pd := f.R * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      end helmholtzToBoundaryProps;

      function cv2Phase  "Compute isochoric specific heat capacity inside the two-phase region" 
        extends Modelica.Icons.Function;
        input PhaseBoundaryProperties liq "Properties on the boiling curve";
        input PhaseBoundaryProperties vap "Properties on the condensation curve";
        input .Modelica.SIunits.MassFraction x "Vapour mass fraction";
        input .Modelica.SIunits.Temperature T "Temperature";
        input .Modelica.SIunits.Pressure p "Properties";
        output .Modelica.SIunits.SpecificHeatCapacity cv "Isochoric specific heat capacity";
      protected
        Real dpT "Derivative of pressure w.r.t. temperature";
        Real dxv "Derivative of vapour mass fraction w.r.t. specific volume";
        Real dvTl "Derivative of liquid specific volume w.r.t. temperature";
        Real dvTv "Derivative of vapour specific volume w.r.t. temperature";
        Real duTl "Derivative of liquid specific inner energy w.r.t. temperature";
        Real duTv "Derivative of vapour specific inner energy w.r.t. temperature";
        Real dxt "Derivative of vapour mass fraction w.r.t. temperature";
      algorithm
        dxv := if liq.d <> vap.d then liq.d * vap.d / (liq.d - vap.d) else 0.0;
        dpT := (vap.s - liq.s) * dxv;
        dvTl := (liq.pt - dpT) / liq.pd / liq.d / liq.d;
        dvTv := (vap.pt - dpT) / vap.pd / vap.d / vap.d;
        dxt := -dxv * (dvTl + x * (dvTv - dvTl));
        duTl := liq.cv + (T * liq.pt - p) * dvTl;
        duTv := vap.cv + (T * vap.pt - p) * dvTv;
        cv := duTl + x * (duTv - duTl) + dxt * (vap.u - liq.u);
      end cv2Phase;

      function Helmholtz_ph  "Function to calculate analytic derivatives for computing d and t given p and h" 
        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
        output NewtonDerivatives_ph nderivs "Derivatives for Newton iteration to calculate d and t from p and h";
      protected
        .Modelica.SIunits.SpecificHeatCapacity cv "Isochoric heat capacity";
      algorithm
        cv := -f.R * (f.tau * f.tau * f.ftautau);
        nderivs.p := f.d * f.R * f.T * f.delta * f.fdelta;
        nderivs.h := f.R * f.T * (f.tau * f.ftau + f.delta * f.fdelta);
        nderivs.pd := f.R * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
        nderivs.pt := f.R * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
        nderivs.ht := cv + nderivs.pt / f.d;
        nderivs.hd := (nderivs.pd - f.T * nderivs.pt / f.d) / f.d;
      end Helmholtz_ph;

      function Helmholtz_pT  "Function to calculate analytic derivatives for computing d and t given p and t" 
        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
        output NewtonDerivatives_pT nderivs "Derivatives for Newton iteration to compute d and t from p and t";
      algorithm
        nderivs.p := f.d * f.R * f.T * f.delta * f.fdelta;
        nderivs.pd := f.R * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
      end Helmholtz_pT;

      function Helmholtz_ps  "Function to calculate analytic derivatives for computing d and t given p and s" 
        extends Modelica.Icons.Function;
        input HelmholtzDerivs f "Dimensionless derivatives of Helmholtz function";
        output NewtonDerivatives_ps nderivs "Derivatives for Newton iteration to compute d and t from p and s";
      protected
        .Modelica.SIunits.SpecificHeatCapacity cv "Isochoric heat capacity";
      algorithm
        cv := -f.R * (f.tau * f.tau * f.ftautau);
        nderivs.p := f.d * f.R * f.T * f.delta * f.fdelta;
        nderivs.s := f.R * (f.tau * f.ftau - f.f);
        nderivs.pd := f.R * f.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
        nderivs.pt := f.R * f.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
        nderivs.st := cv / f.T;
        nderivs.sd := -nderivs.pt / (f.d * f.d);
      end Helmholtz_ps;

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

      package OneNonLinearEquation  "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way" 
        extends Modelica.Icons.Package;

        replaceable record f_nonlinear_Data  "Data specific for function f_nonlinear" 
          extends Modelica.Icons.Record;
        end f_nonlinear_Data;

        replaceable partial function f_nonlinear  "Nonlinear algebraic equation in one unknown: y = f_nonlinear(x,p,X)" 
          extends Modelica.Icons.Function;
          input Real x "Independent variable of function";
          input Real p = 0.0 "Disregarded variables (here always used for pressure)";
          input Real[:] X = fill(0, 0) "Disregarded variables (her always used for composition)";
          input f_nonlinear_Data f_nonlinear_data "Additional data for the function";
          output Real y "= f_nonlinear(x)";
        end f_nonlinear;

        replaceable function solve  "Solve f_nonlinear(x_zero)=y_zero; f_nonlinear(x_min) - y_zero and f_nonlinear(x_max)-y_zero must have different sign" 
          extends Modelica.Icons.Function;
          input Real y_zero "Determine x_zero, such that f_nonlinear(x_zero) = y_zero";
          input Real x_min "Minimum value of x";
          input Real x_max "Maximum value of x";
          input Real pressure = 0.0 "Disregarded variables (here always used for pressure)";
          input Real[:] X = fill(0, 0) "Disregarded variables (here always used for composition)";
          input f_nonlinear_Data f_nonlinear_data "Additional data for function f_nonlinear";
          input Real x_tol = 100 * Modelica.Constants.eps "Relative tolerance of the result";
          output Real x_zero "f_nonlinear(x_zero) = y_zero";
        protected
          constant Real eps = Modelica.Constants.eps "Machine epsilon";
          constant Real x_eps = 1e-10 "Slight modification of x_min, x_max, since x_min, x_max are usually exactly at the borders T_min/h_min and then small numeric noise may make the interval invalid";
          Real x_min2 = x_min - x_eps;
          Real x_max2 = x_max + x_eps;
          Real a = x_min2 "Current best minimum interval value";
          Real b = x_max2 "Current best maximum interval value";
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

    package IdealGases  "Data and models of ideal gases (single, fixed and dynamic mixtures) from NASA source" 
      extends Modelica.Icons.VariantsPackage;

      package Common  "Common packages and data for the ideal gas models" 
        extends Modelica.Icons.Package;

        record DataRecord  "Coefficient data record for properties of ideal gases based on NASA source" 
          extends Modelica.Icons.Record;
          String name "Name of ideal gas";
          .Modelica.SIunits.MolarMass MM "Molar mass";
          .Modelica.SIunits.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
          .Modelica.SIunits.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
          .Modelica.SIunits.Temperature Tlimit "Temperature limit between low and high data sets";
          Real[7] alow "Low temperature coefficients a";
          Real[2] blow "Low temperature constants b";
          Real[7] ahigh "High temperature coefficients a";
          Real[2] bhigh "High temperature constants b";
          .Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
        end DataRecord;

        package Functions  "Basic Functions for ideal gases: cp, h, s, thermal conductivity, viscosity" 
          extends Modelica.Icons.FunctionsPackage;
          constant Boolean excludeEnthalpyOfFormation = true "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          constant Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice = Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K "Choice of reference enthalpy";
          constant Modelica.Media.Interfaces.Types.SpecificEnthalpy h_offset = 0.0 "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

          function cp_T  "Compute specific heat capacity at constant pressure from temperature and gas data" 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input .Modelica.SIunits.Temperature T "Temperature";
            output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
          algorithm
            cp := smooth(0, if T < data.Tlimit then data.R * (1 / (T * T) * (data.alow[1] + T * (data.alow[2] + T * (1. * data.alow[3] + T * (data.alow[4] + T * (data.alow[5] + T * (data.alow[6] + data.alow[7] * T))))))) else data.R * (1 / (T * T) * (data.ahigh[1] + T * (data.ahigh[2] + T * (1. * data.ahigh[3] + T * (data.ahigh[4] + T * (data.ahigh[5] + T * (data.ahigh[6] + data.ahigh[7] * T))))))));
            annotation(Inline = true, smoothOrder = 2); 
          end cp_T;

          function h_T  "Compute specific enthalpy from temperature and gas data; reference is decided by the
              refChoice input, or by the referenceChoice package constant by default" 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input .Modelica.SIunits.Temperature T "Temperature";
            input Boolean exclEnthForm = excludeEnthalpyOfFormation "If true, enthalpy of formation Hf is not included in specific enthalpy h";
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice = referenceChoice "Choice of reference enthalpy";
            input .Modelica.SIunits.SpecificEnthalpy h_off = h_offset "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
            output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at temperature T";
          algorithm
            h := smooth(0, (if T < data.Tlimit then data.R * (((-data.alow[1]) + T * (data.blow[1] + data.alow[2] * Math.log(T) + T * (1. * data.alow[3] + T * (0.5 * data.alow[4] + T * (1 / 3 * data.alow[5] + T * (0.25 * data.alow[6] + 0.2 * data.alow[7] * T)))))) / T) else data.R * (((-data.ahigh[1]) + T * (data.bhigh[1] + data.ahigh[2] * Math.log(T) + T * (1. * data.ahigh[3] + T * (0.5 * data.ahigh[4] + T * (1 / 3 * data.ahigh[5] + T * (0.25 * data.ahigh[6] + 0.2 * data.ahigh[7] * T)))))) / T)) + (if exclEnthForm then -data.Hf else 0.0) + (if refChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K then data.H0 else 0.0) + (if refChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined then h_off else 0.0));
            annotation(Inline = false, smoothOrder = 2); 
          end h_T;

          function s0_T  "Compute specific entropy from temperature and gas data" 
            extends Modelica.Icons.Function;
            input IdealGases.Common.DataRecord data "Ideal gas data";
            input .Modelica.SIunits.Temperature T "Temperature";
            output .Modelica.SIunits.SpecificEntropy s "Specific entropy at temperature T";
          algorithm
            s := if T < data.Tlimit then data.R * (data.blow[2] - 0.5 * data.alow[1] / (T * T) - data.alow[2] / T + data.alow[3] * Math.log(T) + T * (data.alow[4] + T * (0.5 * data.alow[5] + T * (1 / 3 * data.alow[6] + 0.25 * data.alow[7] * T)))) else data.R * (data.bhigh[2] - 0.5 * data.ahigh[1] / (T * T) - data.ahigh[2] / T + data.ahigh[3] * Math.log(T) + T * (data.ahigh[4] + T * (0.5 * data.ahigh[5] + T * (1 / 3 * data.ahigh[6] + 0.25 * data.ahigh[7] * T))));
            annotation(Inline = true, smoothOrder = 2); 
          end s0_T;

          function dynamicViscosityLowPressure  "Dynamic viscosity of low pressure gases" 
            extends Modelica.Icons.Function;
            input .Modelica.SIunits.Temp_K T "Gas temperature";
            input .Modelica.SIunits.Temp_K Tc "Critical temperature of gas";
            input .Modelica.SIunits.MolarMass M "Molar mass of gas";
            input .Modelica.SIunits.MolarVolume Vc "Critical molar volume of gas";
            input Real w "Acentric factor of gas";
            input Modelica.Media.Interfaces.Types.DipoleMoment mu "Dipole moment of gas molecule";
            input Real k = 0.0 "Special correction for highly polar substances";
            output .Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity of gas";
          protected
            parameter Real Const1_SI = 40.785 * 10 ^ (-9.5) "Constant in formula for eta converted to SI units";
            parameter Real Const2_SI = 131.3 / 1000.0 "Constant in formula for mur converted to SI units";
            Real mur = Const2_SI * mu / sqrt(Vc * Tc) "Dimensionless dipole moment of gas molecule";
            Real Fc = 1 - 0.2756 * w + 0.059035 * mur ^ 4 + k "Factor to account for molecular shape and polarities of gas";
            Real Tstar "Dimensionless temperature defined by equation below";
            Real Ov "Viscosity collision integral for the gas";
          algorithm
            Tstar := 1.2593 * T / Tc;
            Ov := 1.16145 * Tstar ^ (-0.14874) + 0.52487 * Modelica.Math.exp(-0.7732 * Tstar) + 2.16178 * Modelica.Math.exp(-2.43787 * Tstar);
            eta := Const1_SI * Fc * sqrt(M * T) / (Vc ^ (2 / 3) * Ov);
            annotation(smoothOrder = 2); 
          end dynamicViscosityLowPressure;

          function thermalConductivityEstimate  "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)" 
            extends Modelica.Icons.Function;
            input Modelica.Media.Interfaces.Types.SpecificHeatCapacity Cp "Constant pressure heat capacity";
            input Modelica.Media.Interfaces.Types.DynamicViscosity eta "Dynamic viscosity";
            input Integer method(min = 1, max = 2) = 1 "1: Eucken Method, 2: Modified Eucken Method";
            input IdealGases.Common.DataRecord data "Ideal gas data";
            output Modelica.Media.Interfaces.Types.ThermalConductivity lambda "Thermal conductivity [W/(m.k)]";
          algorithm
            lambda := if method == 1 then eta * (Cp - data.R + 9 / 4 * data.R) else eta * (Cp - data.R) * (1.32 + 1.77 / (Cp / Modelica.Constants.R - 1.0));
            annotation(smoothOrder = 2); 
          end thermalConductivityEstimate;
        end Functions;

        partial package MixtureGasNasa  "Medium model of a mixture of ideal gases based on NASA source" 
          extends Modelica.Media.Interfaces.PartialMixtureMedium(ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.pTX, substanceNames = data[:].name, reducedX = false, singleState = false, reference_X = fill(1 / nX, nX), SpecificEnthalpy(start = if referenceChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K then 3e5 else if referenceChoice == .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.UserDefined then h_offset else 0, nominal = 1.0e5), Density(start = 10, nominal = 10), AbsolutePressure(start = 10e5, nominal = 10e5), Temperature(min = 200, max = 6000, start = 500, nominal = 500));

          redeclare record extends ThermodynamicState  "Thermodynamic state variables" end ThermodynamicState;

          constant Modelica.Media.IdealGases.Common.DataRecord[:] data "Data records of ideal gas substances";
          constant Boolean excludeEnthalpyOfFormation = true "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          constant .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy referenceChoice = .Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt0K "Choice of reference enthalpy";
          constant SpecificEnthalpy h_offset = 0.0 "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          constant MolarMass[nX] MMX = data[:].MM "Molar masses of components";
          constant Integer methodForThermalConductivity(min = 1, max = 2) = 1;

          redeclare replaceable model extends BaseProperties(T(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), p(stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), Xi(each stateSelect = if preferredMediumStates then StateSelect.prefer else StateSelect.default), final standardOrderComponents = true)  "Base properties (p, d, T, h, u, R, MM, X, and Xi of NASA mixture gas" 
          equation
            assert(T >= 200 and T <= 6000, "
          Temperature T (=" + String(T) + " K = 200 K) is not in the allowed range
          200 K <= T <= 6000 K
          required from medium model \"" + mediumName + "\".");
            MM = molarMass(state);
            h = h_TX(T, X);
            R = data.R * X;
            u = h - R * T;
            d = p / (R * T);
            state.T = T;
            state.p = p;
            state.X = if fixedX then reference_X else X;
          end BaseProperties;

          redeclare function setState_pTX  "Return thermodynamic state as function of p, T and composition X" 
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input Temperature T "Temperature";
            input MassFraction[:] X = reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T, X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T, X = X) else ThermodynamicState(p = p, T = T, X = cat(1, X, {1 - sum(X)}));
            annotation(Inline = true, smoothOrder = 2); 
          end setState_pTX;

          redeclare function setState_phX  "Return thermodynamic state as function of p, h and composition X" 
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEnthalpy h "Specific enthalpy";
            input MassFraction[:] X = reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T_hX(h, reference_X), X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T_hX(h, X), X = X) else ThermodynamicState(p = p, T = T_hX(h, X), X = cat(1, X, {1 - sum(X)}));
            annotation(Inline = true, smoothOrder = 2); 
          end setState_phX;

          redeclare function setState_psX  "Return thermodynamic state as function of p, s and composition X" 
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEntropy s "Specific entropy";
            input MassFraction[:] X = reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X, 1) == 0 then ThermodynamicState(p = p, T = T_psX(p, s, reference_X), X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = p, T = T_psX(p, s, X), X = X) else ThermodynamicState(p = p, T = T_psX(p, s, X), X = cat(1, X, {1 - sum(X)}));
            annotation(Inline = true, smoothOrder = 2); 
          end setState_psX;

          redeclare function setState_dTX  "Return thermodynamic state as function of d, T and composition X" 
            extends Modelica.Icons.Function;
            input Density d "Density";
            input Temperature T "Temperature";
            input MassFraction[:] X = reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := if size(X, 1) == 0 then ThermodynamicState(p = d * (data.R * reference_X) * T, T = T, X = reference_X) else if size(X, 1) == nX then ThermodynamicState(p = d * (data.R * X) * T, T = T, X = X) else ThermodynamicState(p = d * (data.R * cat(1, X, {1 - sum(X)})) * T, T = T, X = cat(1, X, {1 - sum(X)}));
            annotation(Inline = true, smoothOrder = 2); 
          end setState_dTX;

          redeclare function extends setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
          algorithm
            state := ThermodynamicState(p = Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), T = Media.Common.smoothStep(x, state_a.T, state_b.T, x_small), X = Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
            annotation(Inline = true, smoothOrder = 2); 
          end setSmoothState;

          redeclare function extends pressure  "Return pressure of ideal gas" 
          algorithm
            p := state.p;
            annotation(Inline = true, smoothOrder = 2); 
          end pressure;

          redeclare function extends temperature  "Return temperature of ideal gas" 
          algorithm
            T := state.T;
            annotation(Inline = true, smoothOrder = 2); 
          end temperature;

          redeclare function extends density  "Return density of ideal gas" 
          algorithm
            d := state.p / (state.X * data.R * state.T);
            annotation(Inline = true, smoothOrder = 3); 
          end density;

          redeclare function extends specificEnthalpy  "Return specific enthalpy" 
            extends Modelica.Icons.Function;
          algorithm
            h := h_TX(state.T, state.X);
            annotation(Inline = true, smoothOrder = 2); 
          end specificEnthalpy;

          redeclare function extends specificInternalEnergy  "Return specific internal energy" 
            extends Modelica.Icons.Function;
          algorithm
            u := h_TX(state.T, state.X) - gasConstant(state) * state.T;
            annotation(Inline = true, smoothOrder = 2); 
          end specificInternalEnergy;

          redeclare function extends specificEntropy  "Return specific entropy" 
          protected
            Real[nX] Y(each unit = "mol/mol") = massToMoleFractions(state.X, data.MM) "Molar fractions";
          algorithm
            s := s_TX(state.T, state.X) - sum(state.X[i] * Modelica.Constants.R / MMX[i] * (if state.X[i] < Modelica.Constants.eps then Y[i] else Modelica.Math.log(Y[i] * state.p / reference_p)) for i in 1:nX);
            annotation(Inline = true, smoothOrder = 2); 
          end specificEntropy;

          redeclare function extends specificGibbsEnergy  "Return specific Gibbs energy" 
            extends Modelica.Icons.Function;
          algorithm
            g := h_TX(state.T, state.X) - state.T * specificEntropy(state);
            annotation(Inline = true, smoothOrder = 2); 
          end specificGibbsEnergy;

          redeclare function extends specificHelmholtzEnergy  "Return specific Helmholtz energy" 
            extends Modelica.Icons.Function;
          algorithm
            f := h_TX(state.T, state.X) - gasConstant(state) * state.T - state.T * specificEntropy(state);
            annotation(Inline = true, smoothOrder = 2); 
          end specificHelmholtzEnergy;

          function h_TX  "Return specific enthalpy" 
            extends Modelica.Icons.Function;
            input .Modelica.SIunits.Temperature T "Temperature";
            input MassFraction[nX] X = reference_X "Independent Mass fractions of gas mixture";
            input Boolean exclEnthForm = excludeEnthalpyOfFormation "If true, enthalpy of formation Hf is not included in specific enthalpy h";
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice = referenceChoice "Choice of reference enthalpy";
            input .Modelica.SIunits.SpecificEnthalpy h_off = h_offset "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
            output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at temperature T";
          algorithm
            h := (if fixedX then reference_X else X) * {Modelica.Media.IdealGases.Common.Functions.h_T(data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
            annotation(Inline = false, smoothOrder = 2); 
          end h_TX;

          redeclare function extends gasConstant  "Return gasConstant" 
          algorithm
            R := data.R * state.X;
            annotation(Inline = true, smoothOrder = 3); 
          end gasConstant;

          redeclare function extends specificHeatCapacityCp  "Return specific heat capacity at constant pressure" 
          algorithm
            cp := {Modelica.Media.IdealGases.Common.Functions.cp_T(data[i], state.T) for i in 1:nX} * state.X;
            annotation(Inline = true, smoothOrder = 1); 
          end specificHeatCapacityCp;

          redeclare function extends specificHeatCapacityCv  "Return specific heat capacity at constant volume from temperature and gas data" 
          algorithm
            cv := {Modelica.Media.IdealGases.Common.Functions.cp_T(data[i], state.T) for i in 1:nX} * state.X - data.R * state.X;
            annotation(Inline = true, smoothOrder = 1); 
          end specificHeatCapacityCv;

          function s_TX  "Return temperature dependent part of the entropy, expects full entropy vector" 
            extends Modelica.Icons.Function;
            input Temperature T "Temperature";
            input MassFraction[nX] X "Mass fraction";
            output SpecificEntropy s "Specific entropy";
          algorithm
            s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(data[i], T) * X[i] for i in 1:size(X, 1));
            annotation(Inline = true, smoothOrder = 2); 
          end s_TX;

          redeclare function extends isentropicExponent  "Return isentropic exponent" 
          algorithm
            gamma := specificHeatCapacityCp(state) / specificHeatCapacityCv(state);
            annotation(Inline = true, smoothOrder = 2); 
          end isentropicExponent;

          redeclare function extends velocityOfSound  "Return velocity of sound" 
            extends Modelica.Icons.Function;
            input ThermodynamicState state "Properties at upstream location";
          algorithm
            a := sqrt(max(0, gasConstant(state) * state.T * specificHeatCapacityCp(state) / specificHeatCapacityCv(state)));
            annotation(Inline = true, smoothOrder = 2); 
          end velocityOfSound;

          function isentropicEnthalpyApproximation  "Approximate method of calculating h_is from upstream properties and downstream pressure" 
            extends Modelica.Icons.Function;
            input AbsolutePressure p2 "Downstream pressure";
            input ThermodynamicState state "Thermodynamic state at upstream location";
            output SpecificEnthalpy h_is "Isentropic enthalpy";
          protected
            SpecificEnthalpy h "Specific enthalpy at upstream location";
            SpecificEnthalpy[nX] h_component "Specific enthalpy at upstream location";
            IsentropicExponent gamma = isentropicExponent(state) "Isentropic exponent";
            MassFraction[nX] X "Complete X-vector";
          algorithm
            X := if reducedX then cat(1, state.X, {1 - sum(state.X)}) else state.X;
            h_component := {Modelica.Media.IdealGases.Common.Functions.h_T(data[i], state.T, excludeEnthalpyOfFormation, referenceChoice, h_offset) for i in 1:nX};
            h := h_component * X;
            h_is := h + gamma / (gamma - 1.0) * (state.T * gasConstant(state)) * ((p2 / state.p) ^ ((gamma - 1) / gamma) - 1.0);
            annotation(smoothOrder = 2); 
          end isentropicEnthalpyApproximation;

          redeclare function extends isentropicEnthalpy  "Return isentropic enthalpy" 
            input Boolean exact = false "Flag whether exact or approximate version should be used";
          algorithm
            h_is := if exact then specificEnthalpy_psX(p_downstream, specificEntropy(refState), refState.X) else isentropicEnthalpyApproximation(p_downstream, refState);
            annotation(Inline = true, smoothOrder = 2); 
          end isentropicEnthalpy;

          function gasMixtureViscosity  "Return viscosities of gas mixtures at low pressures (Wilke method)" 
            extends Modelica.Icons.Function;
            input MoleFraction[:] yi "Mole fractions";
            input MolarMass[size(yi, 1)] M "Mole masses";
            input DynamicViscosity[size(yi, 1)] eta "Pure component viscosities";
            output DynamicViscosity etam "Viscosity of the mixture";
          protected
            Real[size(yi, 1), size(yi, 1)] fi;
          algorithm
            for i in 1:size(eta, 1) loop
              assert(fluidConstants[i].hasDipoleMoment, "Dipole moment for " + fluidConstants[i].chemicalFormula + " not known. Can not compute viscosity.");
              assert(fluidConstants[i].hasCriticalData, "Critical data for " + fluidConstants[i].chemicalFormula + " not known. Can not compute viscosity.");
              for j in 1:size(eta, 1) loop
                if i == 1 then
                  fi[i, j] := (1 + (eta[i] / eta[j]) ^ (1 / 2) * (M[j] / M[i]) ^ (1 / 4)) ^ 2 / (8 * (1 + M[i] / M[j])) ^ (1 / 2);
                elseif j < i then
                  fi[i, j] := eta[i] / eta[j] * M[j] / M[i] * fi[j, i];
                else
                  fi[i, j] := (1 + (eta[i] / eta[j]) ^ (1 / 2) * (M[j] / M[i]) ^ (1 / 4)) ^ 2 / (8 * (1 + M[i] / M[j])) ^ (1 / 2);
                end if;
              end for;
            end for;
            etam := sum(yi[i] * eta[i] / sum(yi[j] * fi[i, j] for j in 1:size(eta, 1)) for i in 1:size(eta, 1));
            annotation(smoothOrder = 2); 
          end gasMixtureViscosity;

          redeclare replaceable function extends dynamicViscosity  "Return mixture dynamic viscosity" 
          protected
            DynamicViscosity[nX] etaX "Component dynamic viscosities";
          algorithm
            for i in 1:nX loop
              etaX[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(state.T, fluidConstants[i].criticalTemperature, fluidConstants[i].molarMass, fluidConstants[i].criticalMolarVolume, fluidConstants[i].acentricFactor, fluidConstants[i].dipoleMoment);
            end for;
            eta := gasMixtureViscosity(massToMoleFractions(state.X, fluidConstants[:].molarMass), fluidConstants[:].molarMass, etaX);
            annotation(smoothOrder = 2); 
          end dynamicViscosity;

          function lowPressureThermalConductivity  "Return thermal conductivities of low-pressure gas mixtures (Mason and Saxena Modification)" 
            extends Modelica.Icons.Function;
            input MoleFraction[:] y "Mole fraction of the components in the gas mixture";
            input Temperature T "Temperature";
            input Temperature[size(y, 1)] Tc "Critical temperatures";
            input AbsolutePressure[size(y, 1)] Pc "Critical pressures";
            input MolarMass[size(y, 1)] M "Molecular weights";
            input ThermalConductivity[size(y, 1)] lambda "Thermal conductivities of the pure gases";
            output ThermalConductivity lambdam "Thermal conductivity of the gas mixture";
          protected
            MolarMass[size(y, 1)] gamma;
            Real[size(y, 1)] Tr "Reduced temperature";
            Real[size(y, 1), size(y, 1)] A "Mason and Saxena Modification";
            constant Real epsilon = 1.0 "Numerical constant near unity";
          algorithm
            for i in 1:size(y, 1) loop
              gamma[i] := 210 * (Tc[i] * M[i] ^ 3 / Pc[i] ^ 4) ^ (1 / 6);
              Tr[i] := T / Tc[i];
            end for;
            for i in 1:size(y, 1) loop
              for j in 1:size(y, 1) loop
                A[i, j] := epsilon * (1 + (gamma[j] * (.Modelica.Math.exp(0.0464 * Tr[i]) - .Modelica.Math.exp(-0.2412 * Tr[i])) / (gamma[i] * (.Modelica.Math.exp(0.0464 * Tr[j]) - .Modelica.Math.exp(-0.2412 * Tr[j])))) ^ (1 / 2) * (M[i] / M[j]) ^ (1 / 4)) ^ 2 / (8 * (1 + M[i] / M[j])) ^ (1 / 2);
              end for;
            end for;
            lambdam := sum(y[i] * lambda[i] / sum(y[j] * A[i, j] for j in 1:size(y, 1)) for i in 1:size(y, 1));
            annotation(smoothOrder = 2); 
          end lowPressureThermalConductivity;

          redeclare replaceable function extends thermalConductivity  "Return thermal conductivity for low pressure gas mixtures" 
            input Integer method = methodForThermalConductivity "Method to compute single component thermal conductivity";
          protected
            ThermalConductivity[nX] lambdaX "Component thermal conductivities";
            DynamicViscosity[nX] eta "Component thermal dynamic viscosities";
            SpecificHeatCapacity[nX] cp "Component heat capacity";
          algorithm
            for i in 1:nX loop
              assert(fluidConstants[i].hasCriticalData, "Critical data for " + fluidConstants[i].chemicalFormula + " not known. Can not compute thermal conductivity.");
              eta[i] := Modelica.Media.IdealGases.Common.Functions.dynamicViscosityLowPressure(state.T, fluidConstants[i].criticalTemperature, fluidConstants[i].molarMass, fluidConstants[i].criticalMolarVolume, fluidConstants[i].acentricFactor, fluidConstants[i].dipoleMoment);
              cp[i] := Modelica.Media.IdealGases.Common.Functions.cp_T(data[i], state.T);
              lambdaX[i] := Modelica.Media.IdealGases.Common.Functions.thermalConductivityEstimate(Cp = cp[i], eta = eta[i], method = method, data = data[i]);
            end for;
            lambda := lowPressureThermalConductivity(massToMoleFractions(state.X, fluidConstants[:].molarMass), state.T, fluidConstants[:].criticalTemperature, fluidConstants[:].criticalPressure, fluidConstants[:].molarMass, lambdaX);
            annotation(smoothOrder = 2); 
          end thermalConductivity;

          redeclare function extends isobaricExpansionCoefficient  "Return isobaric expansion coefficient beta" 
          algorithm
            beta := 1 / state.T;
            annotation(Inline = true, smoothOrder = 2); 
          end isobaricExpansionCoefficient;

          redeclare function extends isothermalCompressibility  "Return isothermal compressibility factor" 
          algorithm
            kappa := 1.0 / state.p;
            annotation(Inline = true, smoothOrder = 2); 
          end isothermalCompressibility;

          redeclare function extends density_derp_T  "Return density derivative by pressure at constant temperature" 
          algorithm
            ddpT := 1 / (state.T * gasConstant(state));
            annotation(Inline = true, smoothOrder = 2); 
          end density_derp_T;

          redeclare function extends density_derT_p  "Return density derivative by temperature at constant pressure" 
          algorithm
            ddTp := -state.p / (state.T * state.T * gasConstant(state));
            annotation(Inline = true, smoothOrder = 2); 
          end density_derT_p;

          redeclare function density_derX  "Return density derivative by mass fraction" 
            extends Modelica.Icons.Function;
            input ThermodynamicState state "Thermodynamic state record";
            output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
          algorithm
            dddX := {-state.p / (state.T * gasConstant(state)) * molarMass(state) / data[i].MM for i in 1:nX};
            annotation(Inline = true, smoothOrder = 2); 
          end density_derX;

          redeclare function extends molarMass  "Return molar mass of mixture" 
          algorithm
            MM := 1 / sum(state.X[j] / data[j].MM for j in 1:size(state.X, 1));
            annotation(Inline = true, smoothOrder = 2); 
          end molarMass;

          function T_hX  "Return temperature from specific enthalpy and mass fraction" 
            extends Modelica.Icons.Function;
            input SpecificEnthalpy h "Specific enthalpy";
            input MassFraction[nX] X "Mass fractions of composition";
            input Boolean exclEnthForm = excludeEnthalpyOfFormation "If true, enthalpy of formation Hf is not included in specific enthalpy h";
            input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy refChoice = referenceChoice "Choice of reference enthalpy";
            input .Modelica.SIunits.SpecificEnthalpy h_off = h_offset "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
            output Temperature T "Temperature";
          protected
            MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});

            package Internal  "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)" 
              extends Modelica.Media.Common.OneNonLinearEquation;

              redeclare record extends f_nonlinear_Data  "Data to be passed to non-linear function" 
                extends Modelica.Media.IdealGases.Common.DataRecord;
              end f_nonlinear_Data;

              redeclare function extends f_nonlinear  
              algorithm
                y := h_TX(x, X);
              end f_nonlinear;

              redeclare function extends solve  end solve;
            end Internal;
          algorithm
            T := Internal.solve(h, 200, 6000, 1.0e5, Xfull, data[1]);
            annotation(inverse(h = h_TX(T, X, exclEnthForm, refChoice, h_off))); 
          end T_hX;

          function T_psX  "Return temperature from pressure, specific entropy and mass fraction" 
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEntropy s "Specific entropy";
            input MassFraction[nX] X "Mass fractions of composition";
            output Temperature T "Temperature";
          protected
            MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});

            package Internal  "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)" 
              extends Modelica.Media.Common.OneNonLinearEquation;

              redeclare record extends f_nonlinear_Data  "Data to be passed to non-linear function" 
                extends Modelica.Media.IdealGases.Common.DataRecord;
              end f_nonlinear_Data;

              redeclare function extends f_nonlinear  "Note that this function always sees the complete mass fraction vector" 
              protected
                MassFraction[nX] Xfull = if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)});
                Real[nX] Y(each unit = "mol/mol") = massToMoleFractions(if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)}), data.MM) "Molar fractions";
              algorithm
                y := s_TX(x, Xfull) - sum(Xfull[i] * Modelica.Constants.R / MMX[i] * (if Xfull[i] < Modelica.Constants.eps then Y[i] else Modelica.Math.log(Y[i] * p / reference_p)) for i in 1:nX);
              end f_nonlinear;

              redeclare function extends solve  end solve;
            end Internal;
          algorithm
            T := Internal.solve(s, 200, 6000, p, Xfull, data[1]);
          end T_psX;
        end MixtureGasNasa;

        package FluidData  "Critical data, dipole moments and related data" 
          extends Modelica.Icons.Package;
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants N2(chemicalFormula = "N2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7727-37-9", meltingPoint = 63.15, normalBoilingPoint = 77.35, criticalTemperature = 126.20, criticalPressure = 33.98e5, criticalMolarVolume = 90.10e-6, acentricFactor = 0.037, dipoleMoment = 0.0, molarMass = SingleGasesData.N2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants O2(chemicalFormula = "O2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7782-44-7", meltingPoint = 54.36, normalBoilingPoint = 90.17, criticalTemperature = 154.58, criticalPressure = 50.43e5, criticalMolarVolume = 73.37e-6, acentricFactor = 0.022, dipoleMoment = 0.0, molarMass = SingleGasesData.O2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO2(chemicalFormula = "CO2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "124-38-9", meltingPoint = 216.58, normalBoilingPoint = -1.0, criticalTemperature = 304.12, criticalPressure = 73.74e5, criticalMolarVolume = 94.07e-6, acentricFactor = 0.225, dipoleMoment = 0.0, molarMass = SingleGasesData.CO2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2O(chemicalFormula = "H2O", iupacName = "oxidane", structureFormula = "H2O", casRegistryNumber = "7732-18-5", meltingPoint = 273.15, normalBoilingPoint = 373.124, criticalTemperature = 647.096, criticalPressure = 220.64e5, criticalMolarVolume = 55.95e-6, acentricFactor = 0.344, dipoleMoment = 1.8, molarMass = SingleGasesData.H2O.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
          constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants Ar(chemicalFormula = "Ar", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7440-37-1", meltingPoint = 83.80, normalBoilingPoint = 87.27, criticalTemperature = 150.86, criticalPressure = 48.98e5, criticalMolarVolume = 74.57e-6, acentricFactor = -0.002, dipoleMoment = 0.0, molarMass = SingleGasesData.Ar.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        end FluidData;

        package SingleGasesData  "Ideal gas data based on the NASA Glenn coefficients" 
          extends Modelica.Icons.Package;
          constant IdealGases.Common.DataRecord Ar(name = "Ar", MM = 0.039948, Hf = 0, H0 = 155137.3785921698, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 4.37967491}, ahigh = {20.10538475, -0.05992661069999999, 2.500069401, -3.99214116e-008, 1.20527214e-011, -1.819015576e-015, 1.078576636e-019}, bhigh = {-744.993961, 4.37918011}, R = 208.1323720837088);
          constant IdealGases.Common.DataRecord CH4(name = "CH4", MM = 0.01604246, Hf = -4650159.63885838, H0 = 624355.7409524474, Tlimit = 1000, alow = {-176685.0998, 2786.18102, -12.0257785, 0.0391761929, -3.61905443e-005, 2.026853043e-008, -4.976705489999999e-012}, blow = {-23313.1436, 89.0432275}, ahigh = {3730042.76, -13835.01485, 20.49107091, -0.001961974759, 4.72731304e-007, -3.72881469e-011, 1.623737207e-015}, bhigh = {75320.6691, -121.9124889}, R = 518.2791167938085);
          constant IdealGases.Common.DataRecord CH3OH(name = "CH3OH", MM = 0.03204186, Hf = -6271171.523750494, H0 = 356885.5553329301, Tlimit = 1000, alow = {-241664.2886, 4032.14719, -20.46415436, 0.0690369807, -7.59893269e-005, 4.59820836e-008, -1.158706744e-011}, blow = {-44332.61169999999, 140.014219}, ahigh = {3411570.76, -13455.00201, 22.61407623, -0.002141029179, 3.73005054e-007, -3.49884639e-011, 1.366073444e-015}, bhigh = {56360.8156, -127.7814279}, R = 259.4878075117987);
          constant IdealGases.Common.DataRecord CO(name = "CO", MM = 0.0280101, Hf = -3946262.098314536, H0 = 309570.6191695138, Tlimit = 1000, alow = {14890.45326, -292.2285939, 5.72452717, -0.008176235030000001, 1.456903469e-005, -1.087746302e-008, 3.027941827e-012}, blow = {-13031.31878, -7.85924135}, ahigh = {461919.725, -1944.704863, 5.91671418, -0.0005664282830000001, 1.39881454e-007, -1.787680361e-011, 9.62093557e-016}, bhigh = {-2466.261084, -13.87413108}, R = 296.8383547363272);
          constant IdealGases.Common.DataRecord CO2(name = "CO2", MM = 0.0440095, Hf = -8941478.544405185, H0 = 212805.6215135368, Tlimit = 1000, alow = {49436.5054, -626.411601, 5.30172524, 0.002503813816, -2.127308728e-007, -7.68998878e-010, 2.849677801e-013}, blow = {-45281.9846, -7.04827944}, ahigh = {117696.2419, -1788.791477, 8.29152319, -9.22315678e-005, 4.86367688e-009, -1.891053312e-012, 6.330036589999999e-016}, bhigh = {-39083.5059, -26.52669281}, R = 188.9244822140674);
          constant IdealGases.Common.DataRecord C2H2_vinylidene(name = "C2H2_vinylidene", MM = 0.02603728, Hf = 15930556.80163212, H0 = 417638.4015534649, Tlimit = 1000, alow = {-14660.42239, 278.9475593, 1.276229776, 0.01395015463, -1.475702649e-005, 9.476298110000001e-009, -2.567602217e-012}, blow = {47361.1018, 16.58225704}, ahigh = {1940838.725, -6892.718150000001, 13.39582494, -0.0009368968669999999, 1.470804368e-007, -1.220040365e-011, 4.12239166e-016}, bhigh = {91071.1293, -63.3750293}, R = 319.3295152181795);
          constant IdealGases.Common.DataRecord C2H4(name = "C2H4", MM = 0.02805316, Hf = 1871446.924339362, H0 = 374955.5843263291, Tlimit = 1000, alow = {-116360.5836, 2554.85151, -16.09746428, 0.0662577932, -7.885081859999999e-005, 5.12522482e-008, -1.370340031e-011}, blow = {-6176.19107, 109.3338343}, ahigh = {3408763.67, -13748.47903, 23.65898074, -0.002423804419, 4.43139566e-007, -4.35268339e-011, 1.775410633e-015}, bhigh = {88204.2938, -137.1278108}, R = 296.3827247982046);
          constant IdealGases.Common.DataRecord C2H6(name = "C2H6", MM = 0.03006904, Hf = -2788633.890539904, H0 = 395476.3437741943, Tlimit = 1000, alow = {-186204.4161, 3406.19186, -19.51705092, 0.0756583559, -8.20417322e-005, 5.0611358e-008, -1.319281992e-011}, blow = {-27029.3289, 129.8140496}, ahigh = {5025782.13, -20330.22397, 33.2255293, -0.00383670341, 7.23840586e-007, -7.3191825e-011, 3.065468699e-015}, bhigh = {111596.395, -203.9410584}, R = 276.5127187299628);
          constant IdealGases.Common.DataRecord C2H5OH(name = "C2H5OH", MM = 0.04606844, Hf = -5100020.751733725, H0 = 315659.1801241805, Tlimit = 1000, alow = {-234279.1392, 4479.18055, -27.44817302, 0.1088679162, -0.0001305309334, 8.437346399999999e-008, -2.234559017e-011}, blow = {-50222.29, 176.4829211}, ahigh = {4694817.65, -19297.98213, 34.4758404, -0.00323616598, 5.78494772e-007, -5.56460027e-011, 2.2262264e-015}, bhigh = {86016.22709999999, -203.4801732}, R = 180.4808671619877);
          constant IdealGases.Common.DataRecord C3H6_propylene(name = "C3H6_propylene", MM = 0.04207974, Hf = 475288.1077687267, H0 = 322020.9535515191, Tlimit = 1000, alow = {-191246.2174, 3542.07424, -21.14878626, 0.0890148479, -0.0001001429154, 6.267959389999999e-008, -1.637870781e-011}, blow = {-15299.61824, 140.7641382}, ahigh = {5017620.34, -20860.84035, 36.4415634, -0.00388119117, 7.27867719e-007, -7.321204500000001e-011, 3.052176369e-015}, bhigh = {126124.5355, -219.5715757}, R = 197.588483198803);
          constant IdealGases.Common.DataRecord C3H8(name = "C3H8", MM = 0.04409562, Hf = -2373931.923397381, H0 = 334301.1845620949, Tlimit = 1000, alow = {-243314.4337, 4656.27081, -29.39466091, 0.1188952745, -0.0001376308269, 8.814823909999999e-008, -2.342987994e-011}, blow = {-35403.3527, 184.1749277}, ahigh = {6420731.680000001, -26597.91134, 45.3435684, -0.00502066392, 9.471216939999999e-007, -9.57540523e-011, 4.00967288e-015}, bhigh = {145558.2459, -281.8374734}, R = 188.5555073270316);
          constant IdealGases.Common.DataRecord C4H8_1_butene(name = "C4H8_1_butene", MM = 0.05610631999999999, Hf = -9624.584182316718, H0 = 305134.9651875226, Tlimit = 1000, alow = {-272149.2014, 5100.079250000001, -31.8378625, 0.1317754442, -0.0001527359339, 9.714761109999999e-008, -2.56020447e-011}, blow = {-25230.96386, 200.6932108}, ahigh = {6257948.609999999, -26603.76305, 47.6492005, -0.00438326711, 7.12883844e-007, -5.991020839999999e-011, 2.051753504e-015}, bhigh = {156925.2657, -291.3869761}, R = 148.1913623991023);
          constant IdealGases.Common.DataRecord C4H10_n_butane(name = "C4H10_n_butane", MM = 0.0581222, Hf = -2164233.28779709, H0 = 330832.0228759407, Tlimit = 1000, alow = {-317587.254, 6176.331819999999, -38.9156212, 0.1584654284, -0.0001860050159, 1.199676349e-007, -3.20167055e-011}, blow = {-45403.63390000001, 237.9488665}, ahigh = {7682322.45, -32560.5151, 57.3673275, -0.00619791681, 1.180186048e-006, -1.221893698e-010, 5.250635250000001e-015}, bhigh = {177452.656, -358.791876}, R = 143.0515706563069);
          constant IdealGases.Common.DataRecord C5H10_1_pentene(name = "C5H10_1_pentene", MM = 0.07013290000000001, Hf = -303423.9279995551, H0 = 309127.3852927798, Tlimit = 1000, alow = {-534054.813, 9298.917380000001, -56.6779245, 0.2123100266, -0.000257129829, 1.666834304e-007, -4.43408047e-011}, blow = {-47906.8218, 339.60364}, ahigh = {3744014.97, -21044.85321, 47.3612699, -0.00042442012, -3.89897505e-008, 1.367074243e-011, -9.31319423e-016}, bhigh = {115409.1373, -278.6177449000001}, R = 118.5530899192818);
          constant IdealGases.Common.DataRecord C5H12_n_pentane(name = "C5H12_n_pentane", MM = 0.07214878, Hf = -2034130.029641527, H0 = 335196.2430965569, Tlimit = 1000, alow = {-276889.4625, 5834.28347, -36.1754148, 0.1533339707, -0.0001528395882, 8.191092e-008, -1.792327902e-011}, blow = {-46653.7525, 226.5544053}, ahigh = {-2530779.286, -8972.59326, 45.3622326, -0.002626989916, 3.135136419e-006, -5.31872894e-010, 2.886896868e-014}, bhigh = {14846.16529, -251.6550384}, R = 115.2406457877736);
          constant IdealGases.Common.DataRecord C6H6(name = "C6H6", MM = 0.07811184, Hf = 1061042.730525872, H0 = 181735.4577743912, Tlimit = 1000, alow = {-167734.0902, 4404.50004, -37.1737791, 0.1640509559, -0.0002020812374, 1.307915264e-007, -3.4442841e-011}, blow = {-10354.55401, 216.9853345}, ahigh = {4538575.72, -22605.02547, 46.940073, -0.004206676830000001, 7.90799433e-007, -7.9683021e-011, 3.32821208e-015}, bhigh = {139146.4686, -286.8751333}, R = 106.4431717393932);
          constant IdealGases.Common.DataRecord C6H12_1_hexene(name = "C6H12_1_hexene", MM = 0.08415948000000001, Hf = -498458.4030224521, H0 = 311788.9986962847, Tlimit = 1000, alow = {-666883.165, 11768.64939, -72.70998330000001, 0.2709398396, -0.00033332464, 2.182347097e-007, -5.85946882e-011}, blow = {-62157.8054, 428.682564}, ahigh = {733290.696, -14488.48641, 46.7121549, 0.00317297847, -5.24264652e-007, 4.28035582e-011, -1.472353254e-015}, bhigh = {66977.4041, -262.3643854}, R = 98.79424159940152);
          constant IdealGases.Common.DataRecord C6H14_n_hexane(name = "C6H14_n_hexane", MM = 0.08617535999999999, Hf = -1936980.593988816, H0 = 333065.0431863586, Tlimit = 1000, alow = {-581592.67, 10790.97724, -66.3394703, 0.2523715155, -0.0002904344705, 1.802201514e-007, -4.617223680000001e-011}, blow = {-72715.4457, 393.828354}, ahigh = {-3106625.684, -7346.087920000001, 46.94131760000001, 0.001693963977, 2.068996667e-006, -4.21214168e-010, 2.452345845e-014}, bhigh = {523.750312, -254.9967718}, R = 96.48317105956971);
          constant IdealGases.Common.DataRecord C7H14_1_heptene(name = "C7H14_1_heptene", MM = 0.09818605999999999, Hf = -639194.6066478277, H0 = 313588.3036756949, Tlimit = 1000, alow = {-744940.284, 13321.79893, -82.81694379999999, 0.3108065994, -0.000378677992, 2.446841042e-007, -6.488763869999999e-011}, blow = {-72178.8501, 485.667149}, ahigh = {-1927608.174, -9125.024420000002, 47.4817797, 0.00606766053, -8.684859080000001e-007, 5.81399526e-011, -1.473979569e-015}, bhigh = {26009.14656, -256.2880707}, R = 84.68077851377274);
          constant IdealGases.Common.DataRecord C7H16_n_heptane(name = "C7H16_n_heptane", MM = 0.10020194, Hf = -1874015.612871368, H0 = 331540.487140269, Tlimit = 1000, alow = {-612743.289, 11840.85437, -74.87188599999999, 0.2918466052, -0.000341679549, 2.159285269e-007, -5.65585273e-011}, blow = {-80134.0894, 440.721332}, ahigh = {9135632.469999999, -39233.1969, 78.8978085, -0.00465425193, 2.071774142e-006, -3.4425393e-010, 1.976834775e-014}, bhigh = {205070.8295, -485.110402}, R = 82.97715593131233);
          constant IdealGases.Common.DataRecord C8H10_ethylbenz(name = "C8H10_ethylbenz", MM = 0.106165, Hf = 281825.4603682946, H0 = 209862.0072528611, Tlimit = 1000, alow = {-469494, 9307.16836, -65.2176947, 0.2612080237, -0.000318175348, 2.051355473e-007, -5.40181735e-011}, blow = {-40738.7021, 378.090436}, ahigh = {5551564.100000001, -28313.80598, 60.6124072, 0.001042112857, -1.327426719e-006, 2.166031743e-010, -1.142545514e-014}, bhigh = {164224.1062, -369.176982}, R = 78.31650732350586);
          constant IdealGases.Common.DataRecord C8H18_n_octane(name = "C8H18_n_octane", MM = 0.11422852, Hf = -1827477.060895125, H0 = 330740.51909278, Tlimit = 1000, alow = {-698664.715, 13385.01096, -84.1516592, 0.327193666, -0.000377720959, 2.339836988e-007, -6.01089265e-011}, blow = {-90262.2325, 493.922214}, ahigh = {6365406.949999999, -31053.64657, 69.6916234, 0.01048059637, -4.12962195e-006, 5.543226319999999e-010, -2.651436499e-014}, bhigh = {150096.8785, -416.989565}, R = 72.78805678301707);
          constant IdealGases.Common.DataRecord CL2(name = "CL2", MM = 0.07090600000000001, Hf = 0, H0 = 129482.8364313316, Tlimit = 1000, alow = {34628.1517, -554.7126520000001, 6.20758937, -0.002989632078, 3.17302729e-006, -1.793629562e-009, 4.260043590000001e-013}, blow = {1534.069331, -9.438331107}, ahigh = {6092569.42, -19496.27662, 28.54535795, -0.01449968764, 4.46389077e-006, -6.35852586e-010, 3.32736029e-014}, bhigh = {121211.7724, -169.0778824}, R = 117.2604857134798);
          constant IdealGases.Common.DataRecord F2(name = "F2", MM = 0.0379968064, Hf = 0, H0 = 232259.1511269747, Tlimit = 1000, alow = {10181.76308, 22.74241183, 1.97135304, 0.008151604010000001, -1.14896009e-005, 7.95865253e-009, -2.167079526e-012}, blow = {-958.6943, 11.30600296}, ahigh = {-2941167.79, 9456.5977, -7.73861615, 0.00764471299, -2.241007605e-006, 2.915845236e-010, -1.425033974e-014}, bhigh = {-60710.0561, 84.23835080000001}, R = 218.8202848542556);
          constant IdealGases.Common.DataRecord H2(name = "H2", MM = 0.00201588, Hf = 0, H0 = 4200697.462150524, Tlimit = 1000, alow = {40783.2321, -800.918604, 8.21470201, -0.01269714457, 1.753605076e-005, -1.20286027e-008, 3.36809349e-012}, blow = {2682.484665, -30.43788844}, ahigh = {560812.801, -837.150474, 2.975364532, 0.001252249124, -3.74071619e-007, 5.936625200000001e-011, -3.6069941e-015}, bhigh = {5339.82441, -2.202774769}, R = 4124.487568704486);
          constant IdealGases.Common.DataRecord H2O(name = "H2O", MM = 0.01801528, Hf = -13423382.81725291, H0 = 549760.6476280135, Tlimit = 1000, alow = {-39479.6083, 575.573102, 0.931782653, 0.00722271286, -7.34255737e-006, 4.95504349e-009, -1.336933246e-012}, blow = {-33039.7431, 17.24205775}, ahigh = {1034972.096, -2412.698562, 4.64611078, 0.002291998307, -6.836830479999999e-007, 9.426468930000001e-011, -4.82238053e-015}, bhigh = {-13842.86509, -7.97814851}, R = 461.5233290850878);
          constant IdealGases.Common.DataRecord He(name = "He", MM = 0.004002602, Hf = 0, H0 = 1548349.798456104, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 0.9287239740000001}, ahigh = {0, 0, 2.5, 0, 0, 0, 0}, bhigh = {-745.375, 0.9287239740000001}, R = 2077.26673798694);
          constant IdealGases.Common.DataRecord NH3(name = "NH3", MM = 0.01703052, Hf = -2697510.117130892, H0 = 589713.1150428759, Tlimit = 1000, alow = {-76812.26149999999, 1270.951578, -3.89322913, 0.02145988418, -2.183766703e-005, 1.317385706e-008, -3.33232206e-012}, blow = {-12648.86413, 43.66014588}, ahigh = {2452389.535, -8040.89424, 12.71346201, -0.000398018658, 3.55250275e-008, 2.53092357e-012, -3.32270053e-016}, bhigh = {43861.91959999999, -64.62330602}, R = 488.2101075011215);
          constant IdealGases.Common.DataRecord NO(name = "NO", MM = 0.0300061, Hf = 3041758.509103149, H0 = 305908.1320131574, Tlimit = 1000, alow = {-11439.16503, 153.6467592, 3.43146873, -0.002668592368, 8.48139912e-006, -7.685111050000001e-009, 2.386797655e-012}, blow = {9098.214410000001, 6.72872549}, ahigh = {223901.8716, -1289.651623, 5.43393603, -0.00036560349, 9.880966450000001e-008, -1.416076856e-011, 9.380184619999999e-016}, bhigh = {17503.17656, -8.50166909}, R = 277.0927244793559);
          constant IdealGases.Common.DataRecord NO2(name = "NO2", MM = 0.0460055, Hf = 743237.6346306421, H0 = 221890.3174620426, Tlimit = 1000, alow = {-56420.3878, 963.308572, -2.434510974, 0.01927760886, -1.874559328e-005, 9.145497730000001e-009, -1.777647635e-012}, blow = {-1547.925037, 40.6785121}, ahigh = {721300.157, -3832.6152, 11.13963285, -0.002238062246, 6.54772343e-007, -7.6113359e-011, 3.32836105e-015}, bhigh = {25024.97403, -43.0513004}, R = 180.7277825477389);
          constant IdealGases.Common.DataRecord N2(name = "N2", MM = 0.0280134, Hf = 0, H0 = 309498.4543111511, Tlimit = 1000, alow = {22103.71497, -381.846182, 6.08273836, -0.00853091441, 1.384646189e-005, -9.62579362e-009, 2.519705809e-012}, blow = {710.846086, -10.76003744}, ahigh = {587712.406, -2239.249073, 6.06694922, -0.00061396855, 1.491806679e-007, -1.923105485e-011, 1.061954386e-015}, bhigh = {12832.10415, -15.86640027}, R = 296.8033869505308);
          constant IdealGases.Common.DataRecord N2O(name = "N2O", MM = 0.0440128, Hf = 1854006.107314236, H0 = 217685.1961247637, Tlimit = 1000, alow = {42882.2597, -644.011844, 6.03435143, 0.0002265394436, 3.47278285e-006, -3.62774864e-009, 1.137969552e-012}, blow = {11794.05506, -10.0312857}, ahigh = {343844.804, -2404.557558, 9.125636220000001, -0.000540166793, 1.315124031e-007, -1.4142151e-011, 6.38106687e-016}, bhigh = {21986.32638, -31.47805016}, R = 188.9103169986913);
          constant IdealGases.Common.DataRecord Ne(name = "Ne", MM = 0.0201797, Hf = 0, H0 = 307111.9986917546, Tlimit = 1000, alow = {0, 0, 2.5, 0, 0, 0, 0}, blow = {-745.375, 3.35532272}, ahigh = {0, 0, 2.5, 0, 0, 0, 0}, bhigh = {-745.375, 3.35532272}, R = 412.0215860493466);
          constant IdealGases.Common.DataRecord O2(name = "O2", MM = 0.0319988, Hf = 0, H0 = 271263.4223783392, Tlimit = 1000, alow = {-34255.6342, 484.700097, 1.119010961, 0.00429388924, -6.83630052e-007, -2.0233727e-009, 1.039040018e-012}, blow = {-3391.45487, 18.4969947}, ahigh = {-1037939.022, 2344.830282, 1.819732036, 0.001267847582, -2.188067988e-007, 2.053719572e-011, -8.193467050000001e-016}, bhigh = {-16890.10929, 17.38716506}, R = 259.8369938872708);
          constant IdealGases.Common.DataRecord SO2(name = "SO2", MM = 0.0640638, Hf = -4633037.690552231, H0 = 164650.3485587805, Tlimit = 1000, alow = {-53108.4214, 909.031167, -2.356891244, 0.02204449885, -2.510781471e-005, 1.446300484e-008, -3.36907094e-012}, blow = {-41137.52080000001, 40.45512519}, ahigh = {-112764.0116, -825.226138, 7.61617863, -0.000199932761, 5.65563143e-008, -5.45431661e-012, 2.918294102e-016}, bhigh = {-33513.0869, -16.55776085}, R = 129.7842463294403);
          constant IdealGases.Common.DataRecord SO3(name = "SO3", MM = 0.0800632, Hf = -4944843.573576874, H0 = 145990.9046852986, Tlimit = 1000, alow = {-39528.5529, 620.857257, -1.437731716, 0.02764126467, -3.144958662e-005, 1.792798e-008, -4.12638666e-012}, blow = {-51841.0617, 33.91331216}, ahigh = {-216692.3781, -1301.022399, 10.96287985, -0.000383710002, 8.466889039999999e-008, -9.70539929e-012, 4.49839754e-016}, bhigh = {-43982.83990000001, -36.55217314}, R = 103.8488594010732);
        end SingleGasesData;
      end Common;
    end IdealGases;

    package Water  "Medium models for water" 
      extends Modelica.Icons.VariantsPackage;
      constant Modelica.Media.Interfaces.Types.TwoPhase.FluidConstants[1] waterConstants(each chemicalFormula = "H2O", each structureFormula = "H2O", each casRegistryNumber = "7732-18-5", each iupacName = "oxidane", each molarMass = 0.018015268, each criticalTemperature = 647.096, each criticalPressure = 22064.0e3, each criticalMolarVolume = 1 / 322.0 * 0.018015268, each normalBoilingPoint = 373.124, each meltingPoint = 273.15, each triplePointTemperature = 273.16, each triplePointPressure = 611.657, each acentricFactor = 0.344, each dipoleMoment = 1.8, each hasCriticalData = true);
      package StandardWater = WaterIF97_ph "Water using the IF97 standard, explicit in p and h. Recommended for most applications";

      package WaterIF97_ph  "Water using the IF97 standard, explicit in p and h" 
        extends WaterIF97_base(ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, final ph_explicit = true, final dT_explicit = false, final pT_explicit = false, smoothModel = false, onePhase = false);
      end WaterIF97_ph;

      partial package WaterIF97_base  "Water: Steam properties as defined by IAPWS/IF97 standard" 
        extends Interfaces.PartialTwoPhaseMedium(mediumName = "WaterIF97", substanceNames = {"water"}, singleState = false, SpecificEnthalpy(start = 1.0e5, nominal = 5.0e5), Density(start = 150, nominal = 500), AbsolutePressure(start = 50e5, nominal = 10e5, min = 611.657, max = 100e6), Temperature(start = 500, nominal = 500, min = 273.15, max = 2273.15), smoothModel = false, onePhase = false, fluidConstants = waterConstants);

        redeclare record extends ThermodynamicState  "Thermodynamic state" 
          SpecificEnthalpy h "Specific enthalpy";
          Density d "Density";
          Temperature T "Temperature";
          AbsolutePressure p "Pressure";
        end ThermodynamicState;

        constant Integer Region = 0 "Region of IF97, if known, zero otherwise";
        constant Boolean ph_explicit "True if explicit in pressure and specific enthalpy";
        constant Boolean dT_explicit "True if explicit in density and temperature";
        constant Boolean pT_explicit "True if explicit in pressure and temperature";

        redeclare replaceable model extends BaseProperties(h(stateSelect = if ph_explicit and preferredMediumStates then StateSelect.prefer else StateSelect.default), d(stateSelect = if dT_explicit and preferredMediumStates then StateSelect.prefer else StateSelect.default), T(stateSelect = if (pT_explicit or dT_explicit) and preferredMediumStates then StateSelect.prefer else StateSelect.default), p(stateSelect = if (pT_explicit or ph_explicit) and preferredMediumStates then StateSelect.prefer else StateSelect.default))  "Base properties of water" 
          Integer phase(min = 0, max = 2, start = 1, fixed = false) "2 for two-phase, 1 for one-phase, 0 if not known";
        equation
          MM = fluidConstants[1].molarMass;
          if Region > 0 then
            phase = if Region == 4 then 2 else 1;
          elseif smoothModel then
            if onePhase then
              phase = 1;
              if ph_explicit then
                assert(h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat) or p > fluidConstants[1].criticalPressure, "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!" + "(p = " + String(p) + ", h = " + String(h) + ")");
              else
                if dT_explicit then
                  assert(not (d < bubbleDensity(sat) and d > dewDensity(sat) and T < fluidConstants[1].criticalTemperature), "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!" + "(d = " + String(d) + ", T = " + String(T) + ")");
                end if;
              end if;
            else
              phase = 0;
            end if;
          else
            if ph_explicit then
              phase = if h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat) or p > fluidConstants[1].criticalPressure then 1 else 2;
            elseif dT_explicit then
              phase = if not (d < bubbleDensity(sat) and d > dewDensity(sat) and T < fluidConstants[1].criticalTemperature) then 1 else 2;
            else
              phase = 1;
            end if;
          end if;
          if dT_explicit then
            p = pressure_dT(d, T, phase, Region);
            h = specificEnthalpy_dT(d, T, phase, Region);
            sat.Tsat = T;
            sat.psat = saturationPressure(T);
          elseif ph_explicit then
            d = density_ph(p, h, phase, Region);
            T = temperature_ph(p, h, phase, Region);
            sat.Tsat = saturationTemperature(p);
            sat.psat = p;
          else
            h = specificEnthalpy_pT(p, T, Region);
            d = density_pT(p, T, Region);
            sat.psat = p;
            sat.Tsat = saturationTemperature(p);
          end if;
          u = h - p / d;
          R = Modelica.Constants.R / fluidConstants[1].molarMass;
          h = state.h;
          p = state.p;
          T = state.T;
          d = state.d;
          phase = state.phase;
        end BaseProperties;

        redeclare function density_ph  "Computes density as a function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output Density d "Density";
        algorithm
          d := IF97_Utilities.rho_ph(p, h, phase, region);
          annotation(Inline = true); 
        end density_ph;

        redeclare function temperature_ph  "Computes temperature as a function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output Temperature T "Temperature";
        algorithm
          T := IF97_Utilities.T_ph(p, h, phase, region);
          annotation(Inline = true); 
        end temperature_ph;

        redeclare function temperature_ps  "Compute temperature from pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output Temperature T "Temperature";
        algorithm
          T := IF97_Utilities.T_ps(p, s, phase, region);
          annotation(Inline = true); 
        end temperature_ps;

        redeclare function density_ps  "Computes density as a function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output Density d "Density";
        algorithm
          d := IF97_Utilities.rho_ps(p, s, phase, region);
          annotation(Inline = true); 
        end density_ps;

        redeclare function pressure_dT  "Computes pressure as a function of density and temperature" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output AbsolutePressure p "Pressure";
        algorithm
          p := IF97_Utilities.p_dT(d, T, phase, region);
          annotation(Inline = true); 
        end pressure_dT;

        redeclare function specificEnthalpy_dT  "Computes specific enthalpy as a function of density and temperature" 
          extends Modelica.Icons.Function;
          input Density d "Density";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := IF97_Utilities.h_dT(d, T, phase, region);
          annotation(Inline = true); 
        end specificEnthalpy_dT;

        redeclare function specificEnthalpy_pT  "Computes specific enthalpy as a function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := IF97_Utilities.h_pT(p, T, region);
          annotation(Inline = true); 
        end specificEnthalpy_pT;

        redeclare function specificEnthalpy_ps  "Computes specific enthalpy as a function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := IF97_Utilities.h_ps(p, s, phase, region);
          annotation(Inline = true); 
        end specificEnthalpy_ps;

        redeclare function density_pT  "Computes density as a function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
          output Density d "Density";
        algorithm
          d := IF97_Utilities.rho_pT(p, T, region);
          annotation(Inline = true); 
        end density_pT;

        redeclare function extends setDewState  "Set the thermodynamic state on the dew line" 
        algorithm
          state := ThermodynamicState(phase = phase, p = sat.psat, T = sat.Tsat, h = dewEnthalpy(sat), d = dewDensity(sat));
          annotation(Inline = true); 
        end setDewState;

        redeclare function extends setBubbleState  "Set the thermodynamic state on the bubble line" 
        algorithm
          state := ThermodynamicState(phase = phase, p = sat.psat, T = sat.Tsat, h = bubbleEnthalpy(sat), d = bubbleDensity(sat));
          annotation(Inline = true); 
        end setBubbleState;

        redeclare function extends dynamicViscosity  "Dynamic viscosity of water" 
        algorithm
          eta := IF97_Utilities.dynamicViscosity(state.d, state.T, state.p, state.phase);
          annotation(Inline = true); 
        end dynamicViscosity;

        redeclare function extends thermalConductivity  "Thermal conductivity of water" 
        algorithm
          lambda := IF97_Utilities.thermalConductivity(state.d, state.T, state.p, state.phase);
          annotation(Inline = true); 
        end thermalConductivity;

        redeclare function extends surfaceTension  "Surface tension in two phase region of water" 
        algorithm
          sigma := IF97_Utilities.surfaceTension(sat.Tsat);
          annotation(Inline = true); 
        end surfaceTension;

        redeclare function extends pressure  "Return pressure of ideal gas" 
        algorithm
          p := state.p;
          annotation(Inline = true); 
        end pressure;

        redeclare function extends temperature  "Return temperature of ideal gas" 
        algorithm
          T := state.T;
          annotation(Inline = true); 
        end temperature;

        redeclare function extends density  "Return density of ideal gas" 
        algorithm
          d := state.d;
          annotation(Inline = true); 
        end density;

        redeclare function extends specificEnthalpy  "Return specific enthalpy" 
          extends Modelica.Icons.Function;
        algorithm
          h := state.h;
          annotation(Inline = true); 
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy  "Return specific internal energy" 
          extends Modelica.Icons.Function;
        algorithm
          u := state.h - state.p / state.d;
          annotation(Inline = true); 
        end specificInternalEnergy;

        redeclare function extends specificGibbsEnergy  "Return specific Gibbs energy" 
          extends Modelica.Icons.Function;
        algorithm
          g := state.h - state.T * specificEntropy(state);
          annotation(Inline = true); 
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy  "Return specific Helmholtz energy" 
          extends Modelica.Icons.Function;
        algorithm
          f := state.h - state.p / state.d - state.T * specificEntropy(state);
          annotation(Inline = true); 
        end specificHelmholtzEnergy;

        redeclare function extends specificEntropy  "Specific entropy of water" 
        algorithm
          s := if dT_explicit then IF97_Utilities.s_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.s_pT(state.p, state.T, Region) else IF97_Utilities.s_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end specificEntropy;

        redeclare function extends specificHeatCapacityCp  "Specific heat capacity at constant pressure of water" 
        algorithm
          cp := if dT_explicit then IF97_Utilities.cp_dT(state.d, state.T, Region) else if pT_explicit then IF97_Utilities.cp_pT(state.p, state.T, Region) else IF97_Utilities.cp_ph(state.p, state.h, Region);
          annotation(Inline = true); 
        end specificHeatCapacityCp;

        redeclare function extends specificHeatCapacityCv  "Specific heat capacity at constant volume of water" 
        algorithm
          cv := if dT_explicit then IF97_Utilities.cv_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.cv_pT(state.p, state.T, Region) else IF97_Utilities.cv_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end specificHeatCapacityCv;

        redeclare function extends isentropicExponent  "Return isentropic exponent" 
        algorithm
          gamma := if dT_explicit then IF97_Utilities.isentropicExponent_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.isentropicExponent_pT(state.p, state.T, Region) else IF97_Utilities.isentropicExponent_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end isentropicExponent;

        redeclare function extends isothermalCompressibility  "Isothermal compressibility of water" 
        algorithm
          kappa := if dT_explicit then IF97_Utilities.kappa_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.kappa_pT(state.p, state.T, Region) else IF97_Utilities.kappa_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end isothermalCompressibility;

        redeclare function extends isobaricExpansionCoefficient  "Isobaric expansion coefficient of water" 
        algorithm
          beta := if dT_explicit then IF97_Utilities.beta_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.beta_pT(state.p, state.T, Region) else IF97_Utilities.beta_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end isobaricExpansionCoefficient;

        redeclare function extends velocityOfSound  "Return velocity of sound as a function of the thermodynamic state record" 
        algorithm
          a := if dT_explicit then IF97_Utilities.velocityOfSound_dT(state.d, state.T, state.phase, Region) else if pT_explicit then IF97_Utilities.velocityOfSound_pT(state.p, state.T, Region) else IF97_Utilities.velocityOfSound_ph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end velocityOfSound;

        redeclare function extends isentropicEnthalpy  "Compute h(s,p)" 
        algorithm
          h_is := IF97_Utilities.isentropicEnthalpy(p_downstream, specificEntropy(refState), 0);
          annotation(Inline = true); 
        end isentropicEnthalpy;

        redeclare function extends density_derh_p  "Density derivative by specific enthalpy" 
        algorithm
          ddhp := IF97_Utilities.ddhp(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end density_derh_p;

        redeclare function extends density_derp_h  "Density derivative by pressure" 
        algorithm
          ddph := IF97_Utilities.ddph(state.p, state.h, state.phase, Region);
          annotation(Inline = true); 
        end density_derp_h;

        redeclare function extends bubbleEnthalpy  "Boiling curve specific enthalpy of water" 
        algorithm
          hl := IF97_Utilities.BaseIF97.Regions.hl_p(sat.psat);
          annotation(Inline = true); 
        end bubbleEnthalpy;

        redeclare function extends dewEnthalpy  "Dew curve specific enthalpy of water" 
        algorithm
          hv := IF97_Utilities.BaseIF97.Regions.hv_p(sat.psat);
          annotation(Inline = true); 
        end dewEnthalpy;

        redeclare function extends bubbleEntropy  "Boiling curve specific entropy of water" 
        algorithm
          sl := IF97_Utilities.BaseIF97.Regions.sl_p(sat.psat);
          annotation(Inline = true); 
        end bubbleEntropy;

        redeclare function extends dewEntropy  "Dew curve specific entropy of water" 
        algorithm
          sv := IF97_Utilities.BaseIF97.Regions.sv_p(sat.psat);
          annotation(Inline = true); 
        end dewEntropy;

        redeclare function extends bubbleDensity  "Boiling curve specific density of water" 
        algorithm
          dl := if ph_explicit or pT_explicit then IF97_Utilities.BaseIF97.Regions.rhol_p(sat.psat) else IF97_Utilities.BaseIF97.Regions.rhol_T(sat.Tsat);
          annotation(Inline = true); 
        end bubbleDensity;

        redeclare function extends dewDensity  "Dew curve specific density of water" 
        algorithm
          dv := if ph_explicit or pT_explicit then IF97_Utilities.BaseIF97.Regions.rhov_p(sat.psat) else IF97_Utilities.BaseIF97.Regions.rhov_T(sat.Tsat);
          annotation(Inline = true); 
        end dewDensity;

        redeclare function extends saturationTemperature  "Saturation temperature of water" 
        algorithm
          T := IF97_Utilities.BaseIF97.Basic.tsat(p);
          annotation(Inline = true); 
        end saturationTemperature;

        redeclare function extends saturationTemperature_derp  "Derivative of saturation temperature w.r.t. pressure" 
        algorithm
          dTp := IF97_Utilities.BaseIF97.Basic.dtsatofp(p);
          annotation(Inline = true); 
        end saturationTemperature_derp;

        redeclare function extends saturationPressure  "Saturation pressure of water" 
        algorithm
          p := IF97_Utilities.BaseIF97.Basic.psat(T);
          annotation(Inline = true); 
        end saturationPressure;

        redeclare function extends dBubbleDensity_dPressure  "Bubble point density derivative" 
        algorithm
          ddldp := IF97_Utilities.BaseIF97.Regions.drhol_dp(sat.psat);
          annotation(Inline = true); 
        end dBubbleDensity_dPressure;

        redeclare function extends dDewDensity_dPressure  "Dew point density derivative" 
        algorithm
          ddvdp := IF97_Utilities.BaseIF97.Regions.drhov_dp(sat.psat);
          annotation(Inline = true); 
        end dDewDensity_dPressure;

        redeclare function extends dBubbleEnthalpy_dPressure  "Bubble point specific enthalpy derivative" 
        algorithm
          dhldp := IF97_Utilities.BaseIF97.Regions.dhl_dp(sat.psat);
          annotation(Inline = true); 
        end dBubbleEnthalpy_dPressure;

        redeclare function extends dDewEnthalpy_dPressure  "Dew point specific enthalpy derivative" 
        algorithm
          dhvdp := IF97_Utilities.BaseIF97.Regions.dhv_dp(sat.psat);
          annotation(Inline = true); 
        end dDewEnthalpy_dPressure;

        redeclare function extends setState_dTX  "Return thermodynamic state of water as function of d, T, and optional region" 
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
        algorithm
          state := ThermodynamicState(d = d, T = T, phase = if region == 0 then 0 else if region == 4 then 2 else 1, h = specificEnthalpy_dT(d, T, region = region), p = pressure_dT(d, T, region = region));
          annotation(Inline = true); 
        end setState_dTX;

        redeclare function extends setState_phX  "Return thermodynamic state of water as function of p, h, and optional region" 
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
        algorithm
          state := ThermodynamicState(d = density_ph(p, h, region = region), T = temperature_ph(p, h, region = region), phase = if region == 0 then 0 else if region == 4 then 2 else 1, h = h, p = p);
          annotation(Inline = true); 
        end setState_phX;

        redeclare function extends setState_psX  "Return thermodynamic state of water as function of p, s, and optional region" 
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
        algorithm
          state := ThermodynamicState(d = density_ps(p, s, region = region), T = temperature_ps(p, s, region = region), phase = if region == 0 then 0 else if region == 4 then 2 else 1, h = specificEnthalpy_ps(p, s, region = region), p = p);
          annotation(Inline = true); 
        end setState_psX;

        redeclare function extends setState_pTX  "Return thermodynamic state of water as function of p, T, and optional region" 
          input Integer region = Region "If 0, region is unknown, otherwise known and this input";
        algorithm
          state := ThermodynamicState(d = density_pT(p, T, region = region), T = T, phase = 1, h = specificEnthalpy_pT(p, T, region = region), p = p);
          annotation(Inline = true); 
        end setState_pTX;

        redeclare function extends setSmoothState  "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b" 
        algorithm
          state := ThermodynamicState(p = .Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), h = .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small), d = density_ph(.Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small)), T = temperature_ph(.Modelica.Media.Common.smoothStep(x, state_a.p, state_b.p, x_small), .Modelica.Media.Common.smoothStep(x, state_a.h, state_b.h, x_small)), phase = 0);
          annotation(Inline = true); 
        end setSmoothState;
      end WaterIF97_base;

      package IF97_Utilities  "Low level and utility computation for high accuracy water properties according to the IAPWS/IF97 standard" 
        extends Modelica.Icons.UtilitiesPackage;

        package BaseIF97  "Modelica Physical Property Model: the new industrial formulation IAPWS-IF97" 
          extends Modelica.Icons.Package;

          record IterationData  "Constants for iterations internal to some functions" 
            extends Modelica.Icons.Record;
            constant Integer IMAX = 50 "Maximum number of iterations for inverse functions";
            constant Real DELP = 1.0e-6 "Maximum iteration error in pressure, Pa";
            constant Real DELS = 1.0e-8 "Maximum iteration error in specific entropy, J/{kg.K}";
            constant Real DELH = 1.0e-8 "Maximum iteration error in specific enthalpy, J/kg";
            constant Real DELD = 1.0e-8 "Maximum iteration error in density, kg/m^3";
          end IterationData;

          record data  "Constant IF97 data and region limits" 
            extends Modelica.Icons.Record;
            constant .Modelica.SIunits.SpecificHeatCapacity RH2O = 461.526 "Specific gas constant of water vapour";
            constant .Modelica.SIunits.MolarMass MH2O = 0.01801528 "Molar weight of water";
            constant .Modelica.SIunits.Temperature TSTAR1 = 1386.0 "Normalization temperature for region 1 IF97";
            constant .Modelica.SIunits.Pressure PSTAR1 = 16.53e6 "Normalization pressure for region 1 IF97";
            constant .Modelica.SIunits.Temperature TSTAR2 = 540.0 "Normalization temperature for region 2 IF97";
            constant .Modelica.SIunits.Pressure PSTAR2 = 1.0e6 "Normalization pressure for region 2 IF97";
            constant .Modelica.SIunits.Temperature TSTAR5 = 1000.0 "Normalization temperature for region 5 IF97";
            constant .Modelica.SIunits.Pressure PSTAR5 = 1.0e6 "Normalization pressure for region 5 IF97";
            constant .Modelica.SIunits.SpecificEnthalpy HSTAR1 = 2.5e6 "Normalization specific enthalpy for region 1 IF97";
            constant Real IPSTAR = 1.0e-6 "Normalization pressure for inverse function in region 2 IF97";
            constant Real IHSTAR = 5.0e-7 "Normalization specific enthalpy for inverse function in region 2 IF97";
            constant .Modelica.SIunits.Temperature TLIMIT1 = 623.15 "Temperature limit between regions 1 and 3";
            constant .Modelica.SIunits.Temperature TLIMIT2 = 1073.15 "Temperature limit between regions 2 and 5";
            constant .Modelica.SIunits.Temperature TLIMIT5 = 2273.15 "Upper temperature limit of 5";
            constant .Modelica.SIunits.Pressure PLIMIT1 = 100.0e6 "Upper pressure limit for regions 1, 2 and 3";
            constant .Modelica.SIunits.Pressure PLIMIT4A = 16.5292e6 "Pressure limit between regions 1 and 2, important for for two-phase (region 4)";
            constant .Modelica.SIunits.Pressure PLIMIT5 = 10.0e6 "Upper limit of valid pressure in region 5";
            constant .Modelica.SIunits.Pressure PCRIT = 22064000.0 "The critical pressure";
            constant .Modelica.SIunits.Temperature TCRIT = 647.096 "The critical temperature";
            constant .Modelica.SIunits.Density DCRIT = 322.0 "The critical density";
            constant .Modelica.SIunits.SpecificEntropy SCRIT = 4412.02148223476 "The calculated specific entropy at the critical point";
            constant .Modelica.SIunits.SpecificEnthalpy HCRIT = 2087546.84511715 "The calculated specific enthalpy at the critical point";
            constant Real[5] n = array(0.34805185628969e3, -0.11671859879975e1, 0.10192970039326e-2, 0.57254459862746e3, 0.13918839778870e2) "Polynomial coefficients for boundary between regions 2 and 3";
          end data;

          record triple  "Triple point data" 
            extends Modelica.Icons.Record;
            constant .Modelica.SIunits.Temperature Ttriple = 273.16 "The triple point temperature";
            constant .Modelica.SIunits.Pressure ptriple = 611.657 "The triple point temperature";
            constant .Modelica.SIunits.Density dltriple = 999.792520031617642 "The triple point liquid density";
            constant .Modelica.SIunits.Density dvtriple = 0.485457572477861372e-2 "The triple point vapour density";
          end triple;

          package Regions  "Functions to find the current region for given pairs of input variables" 
            extends Modelica.Icons.Package;

            function boundary23ofT  "Boundary function for region boundary between regions 2 and 3 (input temperature)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature t "Temperature (K)";
              output .Modelica.SIunits.Pressure p "Pressure";
            protected
              constant Real[5] n = data.n;
            algorithm
              p := 1.0e6 * (n[1] + t * (n[2] + t * n[3]));
            end boundary23ofT;

            function boundary23ofp  "Boundary function for region boundary between regions 2 and 3 (input pressure)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Temperature t "Temperature (K)";
            protected
              constant Real[5] n = data.n;
              Real pi "Dimensionless pressure";
            algorithm
              pi := p / 1.0e6;
              assert(p > triple.ptriple, "IF97 medium function boundary23ofp called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              t := n[4] + ((pi - n[5]) / n[3]) ^ 0.5;
            end boundary23ofp;

            function hlowerofp5  "Explicit lower specific enthalpy limit of region 5 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p / data.PSTAR5;
              assert(p > triple.ptriple, "IF97 medium function hlowerofp5 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              h := 461526. * (9.01505286876203 + pi * ((-0.00979043490246092) + ((-0.0000203245575263501) + 3.36540214679088e-7 * pi) * pi));
            end hlowerofp5;

            function hupperofp5  "Explicit upper specific enthalpy limit of region 5 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p / data.PSTAR5;
              assert(p > triple.ptriple, "IF97 medium function hupperofp5 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              h := 461526. * (15.9838891400332 + pi * ((-0.000489898813722568) + ((-5.01510211858761e-8) + 7.5006972718273e-8 * pi) * pi));
            end hupperofp5;

            function slowerofp5  "Explicit lower specific entropy limit of region 5 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p / data.PSTAR5;
              assert(p > triple.ptriple, "IF97 medium function slowerofp5 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              s := 461.526 * (18.4296209980112 + pi * ((-0.00730911805860036) + ((-0.0000168348072093888) + 2.09066899426354e-7 * pi) * pi) - Modelica.Math.log(pi));
            end slowerofp5;

            function supperofp5  "Explicit upper specific entropy limit of region 5 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
            algorithm
              pi := p / data.PSTAR5;
              assert(p > triple.ptriple, "IF97 medium function supperofp5 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              s := 461.526 * (22.7281531474243 + pi * ((-0.000656650220627603) + ((-1.96109739782049e-8) + 2.19979537113031e-8 * pi) * pi) - Modelica.Math.log(pi));
            end supperofp5;

            function hlowerofp1  "Explicit lower specific enthalpy limit of region 1 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p / data.PSTAR1;
              assert(p > triple.ptriple, "IF97 medium function hlowerofp1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              o[1] := pi1 * pi1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              h := 639675.036 * (0.173379420894777 + pi1 * ((-0.022914084306349) + pi1 * ((-0.00017146768241932) + pi1 * ((-4.18695814670391e-6) + pi1 * ((-2.41630417490008e-7) + pi1 * (1.73545618580828e-11 + o[1] * pi1 * (8.43755552264362e-14 + o[2] * o[3] * pi1 * (5.35429206228374e-35 + o[1] * ((-8.12140581014818e-38) + o[1] * o[2] * ((-1.43870236842915e-44) + pi1 * (1.73894459122923e-45 + ((-7.06381628462585e-47) + 9.64504638626269e-49 * pi1) * pi1)))))))))));
            end hlowerofp1;

            function hupperofp1  "Explicit upper specific enthalpy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p / data.PSTAR1;
              assert(p > triple.ptriple, "IF97 medium function hupperofp1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              o[1] := pi1 * pi1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              h := 639675.036 * (2.42896927729349 + pi1 * ((-0.00141131225285294) + pi1 * (0.00143759406818289 + pi1 * (0.000125338925082983 + pi1 * (0.0000123617764767172 + pi1 * (3.17834967400818e-6 + o[1] * pi1 * (1.46754947271665e-8 + o[2] * o[3] * pi1 * (1.86779322717506e-17 + o[1] * ((-4.18568363667416e-19) + o[1] * o[2] * ((-9.19148577641497e-22) + pi1 * (4.27026404402408e-22 + ((-6.66749357417962e-23) + 3.49930466305574e-24 * pi1) * pi1)))))))))));
            end hupperofp1;

            function supperofp1  "Explicit upper specific entropy limit of region 1 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real pi1 "Dimensionless pressure";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi1 := 7.1 - p / data.PSTAR1;
              assert(p > triple.ptriple, "IF97 medium function supperofp1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              o[1] := pi1 * pi1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              s := 461.526 * (7.28316418503422 + pi1 * (0.070602197808399 + pi1 * (0.0039229343647356 + pi1 * (0.000313009170788845 + pi1 * (0.0000303619398631619 + pi1 * (7.46739440045781e-6 + o[1] * pi1 * (3.40562176858676e-8 + o[2] * o[3] * pi1 * (4.21886233340801e-17 + o[1] * ((-9.44504571473549e-19) + o[1] * o[2] * ((-2.06859611434475e-21) + pi1 * (9.60758422254987e-22 + ((-1.49967810652241e-22) + 7.86863124555783e-24 * pi1) * pi1)))))))))));
            end supperofp1;

            function hlowerofp2  "Explicit lower specific enthalpy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
              Real q1 "Auxiliary variable";
              Real q2 "Auxiliary variable";
              Real[18] o "Vector of auxiliary variables";
            algorithm
              pi := p / data.PSTAR2;
              assert(p > triple.ptriple, "IF97 medium function hlowerofp2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              q1 := 572.54459862746 + 31.3220101646784 * ((-13.91883977887) + pi) ^ 0.5;
              q2 := (-0.5) + 540. / q1;
              o[1] := q1 * q1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              o[4] := pi * pi;
              o[5] := o[4] * o[4];
              o[6] := q2 * q2;
              o[7] := o[6] * o[6];
              o[8] := o[6] * o[7];
              o[9] := o[5] * o[5];
              o[10] := o[7] * o[7];
              o[11] := o[9] * o[9];
              o[12] := o[10] * o[10];
              o[13] := o[12] * o[12];
              o[14] := o[7] * q2;
              o[15] := o[6] * q2;
              o[16] := o[10] * o[6];
              o[17] := o[13] * o[6];
              o[18] := o[13] * o[6] * q2;
              h := (4.63697573303507e9 + 3.74686560065793 * o[2] + 3.57966647812489e-6 * o[1] * o[2] + 2.81881548488163e-13 * o[3] - 7.64652332452145e7 * q1 - 0.00450789338787835 * o[2] * q1 - 1.55131504410292e-9 * o[1] * o[2] * q1 + o[1] * (2.51383707870341e6 - 4.78198198764471e6 * o[10] * o[11] * o[12] * o[13] * o[4] + 49.9651389369988 * o[11] * o[12] * o[13] * o[4] * o[5] * o[7] + o[15] * o[4] * (1.03746636552761e-13 - 0.00349547959376899 * o[16] - 2.55074501962569e-7 * o[8]) * o[9] + ((-242662.235426958 * o[10] * o[12]) - 3.46022402653609 * o[16]) * o[4] * o[5] * pi + o[4] * (0.109336249381227 - 2248.08924686956 * o[14] - 354742.725841972 * o[17] - 24.1331193696374 * o[6]) * pi - 3.09081828396912e-19 * o[11] * o[12] * o[5] * o[7] * pi - 1.24107527851371e-8 * o[11] * o[13] * o[4] * o[5] * o[6] * o[7] * pi + 3.99891272904219 * o[5] * o[8] * pi + 0.0641817365250892 * o[10] * o[7] * o[9] * pi + pi * ((-4444.87643334512) - 75253.6156722047 * o[14] - 43051.9020511789 * o[6] - 22926.6247146068 * q2) + o[4] * ((-8.23252840892034) - 3927.0508365636 * o[15] - 239.325789467604 * o[18] - 76407.3727417716 * o[8] - 94.4508644545118 * q2) + 0.360567666582363 * o[5] * ((-0.0161221195808321) + q2) * (0.0338039844460968 + q2) + o[11] * ((-0.000584580992538624 * o[10] * o[12] * o[7]) + 1.33248030241755e6 * o[12] * o[13] * q2) + o[9] * ((-7.38502736990986e7 * o[18]) + 0.0000224425477627799 * o[6] * o[7] * q2) + o[4] * o[5] * ((-2.08438767026518e8 * o[17]) - 0.0000124971648677697 * o[6] - 8442.30378348203 * o[10] * o[6] * o[7] * q2) + o[11] * o[9] * (4.73594929247646e-22 * o[10] * o[12] * q2 - 13.6411358215175 * o[10] * o[12] * o[13] * q2 + 5.52427169406836e-10 * o[13] * o[6] * o[7] * q2) + o[11] * o[5] * (2.67174673301715e-6 * o[17] + 4.44545133805865e-18 * o[12] * o[6] * q2 - 50.2465185106411 * o[10] * o[13] * o[6] * o[7] * q2))) / o[1];
            end hlowerofp2;

            function hupperofp2  "Explicit upper specific enthalpy limit of region 2 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real pi "Dimensionless pressure";
              Real[2] o "Vector of auxiliary variables";
            algorithm
              pi := p / data.PSTAR2;
              assert(p > triple.ptriple, "IF97 medium function hupperofp2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              o[1] := pi * pi;
              o[2] := o[1] * o[1] * o[1];
              h := 4.16066337647071e6 + pi * ((-4518.48617188327) + pi * ((-8.53409968320258) + pi * (0.109090430596056 + pi * ((-0.000172486052272327) + pi * (4.2261295097284e-15 + pi * ((-1.27295130636232e-10) + pi * ((-3.79407294691742e-25) + pi * (7.56960433802525e-23 + pi * (7.16825117265975e-32 + pi * (3.37267475986401e-21 + ((-7.5656940729795e-74) + o[1] * ((-8.00969737237617e-134) + (1.6746290980312e-65 + pi * ((-3.71600586812966e-69) + pi * (8.06630589170884e-129 + ((-1.76117969553159e-103) + 1.88543121025106e-84 * pi) * pi))) * o[1])) * o[2]))))))))));
            end hupperofp2;

            function slowerofp2  "Explicit lower specific entropy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
              Real q1 "Auxiliary variable";
              Real q2 "Auxiliary variable";
              Real[40] o "Vector of auxiliary variables";
            algorithm
              pi := p / data.PSTAR2;
              assert(p > triple.ptriple, "IF97 medium function slowerofp2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              q1 := 572.54459862746 + 31.3220101646784 * ((-13.91883977887) + pi) ^ 0.5;
              q2 := (-0.5) + 540.0 / q1;
              o[1] := pi * pi;
              o[2] := o[1] * pi;
              o[3] := o[1] * o[1];
              o[4] := o[1] * o[3] * pi;
              o[5] := q1 * q1;
              o[6] := o[5] * q1;
              o[7] := 1 / o[5];
              o[8] := 1 / q1;
              o[9] := o[5] * o[5];
              o[10] := o[9] * q1;
              o[11] := q2 * q2;
              o[12] := o[11] * q2;
              o[13] := o[1] * o[3];
              o[14] := o[11] * o[11];
              o[15] := o[3] * o[3];
              o[16] := o[1] * o[15];
              o[17] := o[11] * o[14];
              o[18] := o[11] * o[14] * q2;
              o[19] := o[3] * pi;
              o[20] := o[14] * o[14];
              o[21] := o[11] * o[20];
              o[22] := o[15] * pi;
              o[23] := o[14] * o[20] * q2;
              o[24] := o[20] * o[20];
              o[25] := o[15] * o[15];
              o[26] := o[25] * o[3];
              o[27] := o[14] * o[24];
              o[28] := o[25] * o[3] * pi;
              o[29] := o[20] * o[24] * q2;
              o[30] := o[15] * o[25];
              o[31] := o[24] * o[24];
              o[32] := o[11] * o[31] * q2;
              o[33] := o[14] * o[31];
              o[34] := o[1] * o[25] * o[3] * pi;
              o[35] := o[11] * o[14] * o[31] * q2;
              o[36] := o[1] * o[25] * o[3];
              o[37] := o[1] * o[25];
              o[38] := o[20] * o[24] * o[31] * q2;
              o[39] := o[14] * q2;
              o[40] := o[11] * o[31];
              s := 461.526 * (9.692768600217 + 1.22151969114703e-16 * o[10] + 0.00018948987516315 * o[1] * o[11] + 1.6714766451061e-11 * o[12] * o[13] + 0.0039392777243355 * o[1] * o[14] - 1.0406965210174e-19 * o[14] * o[16] + 0.043797295650573 * o[1] * o[18] - 2.2922076337661e-6 * o[18] * o[19] - 2.0481737692309e-8 * o[2] + 0.00003227767723857 * o[12] * o[2] + 0.0015033924542148 * o[17] * o[2] - 1.1256211360459e-11 * o[15] * o[20] + 1.0018179379511e-9 * o[11] * o[14] * o[16] * o[20] + 1.0234747095929e-13 * o[16] * o[21] - 1.9809712802088e-8 * o[22] * o[23] + 0.0021171472321355 * o[13] * o[24] - 8.9185845355421e-25 * o[26] * o[27] - 1.2790717852285e-8 * o[11] * o[3] - 4.8225372718507e-7 * o[12] * o[3] - 7.3087610595061e-29 * o[11] * o[20] * o[24] * o[30] - 0.10693031879409 * o[11] * o[24] * o[25] * o[31] + 4.2002467698208e-6 * o[24] * o[26] * o[31] - 5.5414715350778e-17 * o[20] * o[30] * o[31] + 9.436970724121e-7 * o[11] * o[20] * o[24] * o[30] * o[31] + 23.895741934104 * o[13] * o[32] + 0.040668253562649 * o[2] * o[32] - 3.0629316876232e-13 * o[26] * o[32] + 0.000026674547914087 * o[1] * o[33] + 8.2311340897998 * o[15] * o[33] + 1.2768608934681e-15 * o[34] * o[35] + 0.33662250574171 * o[37] * o[38] + 5.905956432427e-18 * o[4] + 0.038946842435739 * o[29] * o[4] - 4.88368302964335e-6 * o[5] - 3.34901734177133e6 / o[6] + 2.58538448402683e-9 * o[6] + 82839.5726841115 * o[7] - 5446.7940672972 * o[8] - 8.40318337484194e-13 * o[9] + 0.0017731742473213 * pi + 0.045996013696365 * o[11] * pi + 0.057581259083432 * o[12] * pi + 0.05032527872793 * o[17] * pi + o[8] * pi * (9.63082563787332 - 0.008917431146179 * q1) + 0.00811842799898148 * q1 + 0.000033032641670203 * o[1] * q2 - 4.3870667284435e-7 * o[2] * q2 + 8.0882908646985e-11 * o[14] * o[20] * o[24] * o[25] * q2 + 5.9056029685639e-26 * o[14] * o[24] * o[28] * q2 + 7.8847309559367e-10 * o[3] * q2 - 3.7826947613457e-6 * o[14] * o[24] * o[31] * o[36] * q2 + 1.2621808899101e-6 * o[11] * o[20] * o[4] * q2 + 540. * o[8] * (10.08665568018 - 0.000033032641670203 * o[1] - 6.2245802776607e-15 * o[10] - 0.015757110897342 * o[1] * o[12] - 5.0144299353183e-11 * o[11] * o[13] + 4.1627860840696e-19 * o[12] * o[16] - 0.306581069554011 * o[1] * o[17] + 9.0049690883672e-11 * o[15] * o[18] + 0.0000160454534363627 * o[17] * o[19] + 4.3870667284435e-7 * o[2] - 0.00009683303171571 * o[11] * o[2] + 2.57526266427144e-7 * o[14] * o[20] * o[22] - 1.40254511313154e-8 * o[16] * o[23] - 2.34560435076256e-9 * o[14] * o[20] * o[24] * o[25] - 1.24017662339842e-24 * o[27] * o[28] - 7.8847309559367e-10 * o[3] + 1.44676118155521e-6 * o[11] * o[3] + 1.90027787547159e-27 * o[29] * o[30] - 0.000960283724907132 * o[1] * o[32] - 296.320827232793 * o[15] * o[32] - 4.97975748452559e-14 * o[11] * o[14] * o[31] * o[34] + 2.21658861403112e-15 * o[30] * o[35] + 0.000200482822351322 * o[14] * o[24] * o[31] * o[36] - 19.1874828272775 * o[20] * o[24] * o[31] * o[37] - 0.0000547344301999018 * o[30] * o[38] - 0.0090203547252888 * o[2] * o[39] - 0.0000138839897890111 * o[21] * o[4] - 0.973671060893475 * o[20] * o[24] * o[4] - 836.35096769364 * o[13] * o[40] - 1.42338887469272 * o[2] * o[40] + 1.07202609066812e-11 * o[26] * o[40] + 0.0000150341259240398 * o[5] - 1.8087714924605e-8 * o[6] + 18605.6518987296 * o[7] - 306.813232163376 * o[8] + 1.43632471334824e-11 * o[9] + 1.13103675106207e-18 * o[5] * o[9] - 0.017834862292358 * pi - 0.172743777250296 * o[11] * pi - 0.30195167236758 * o[39] * pi + o[8] * pi * ((-49.6756947920742) + 0.045996013696365 * q1) - 0.0003789797503263 * o[1] * q2 - 0.033874355714168 * o[11] * o[13] * o[14] * o[20] * q2 - 1.0234747095929e-12 * o[16] * o[20] * q2 + 1.78371690710842e-23 * o[11] * o[24] * o[26] * q2 + 2.558143570457e-8 * o[3] * q2 + 5.3465159397045 * o[24] * o[25] * o[31] * q2 - 0.000201611844951398 * o[11] * o[14] * o[20] * o[26] * o[31] * q2) - Modelica.Math.log(pi));
            end slowerofp2;

            function supperofp2  "Explicit upper specific entropy limit of region 2 as function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real pi "Dimensionless pressure";
              Real[2] o "Vector of auxiliary variables";
            algorithm
              pi := p / data.PSTAR2;
              assert(p > triple.ptriple, "IF97 medium function supperofp2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              o[1] := pi * pi;
              o[2] := o[1] * o[1] * o[1];
              s := 8505.73409708683 - 461.526 * Modelica.Math.log(pi) + pi * ((-3.36563543302584) + pi * ((-0.00790283552165338) + pi * (0.0000915558349202221 + pi * ((-1.59634706513e-7) + pi * (3.93449217595397e-18 + pi * ((-1.18367426347994e-13) + pi * (2.72575244843195e-15 + pi * (7.04803892603536e-26 + pi * (6.67637687381772e-35 + pi * (3.1377970315132e-24 + ((-7.04844558482265e-77) + o[1] * ((-7.46289531275314e-137) + (1.55998511254305e-68 + pi * ((-3.46166288915497e-72) + pi * (7.51557618628583e-132 + ((-1.64086406733212e-106) + 1.75648443097063e-87 * pi) * pi))) * o[1])) * o[2] * o[2]))))))))));
            end supperofp2;

            function d1n  "Density in region 1 as function of p and T" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.Density d "Density";
            protected
              Real pi "Dimensionless pressure";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
              Real gpi "Dimensionless Gibbs-derivative w.r.t. pi";
              Real[11] o "Auxiliary variables";
            algorithm
              pi := p / data.PSTAR1;
              tau := data.TSTAR1 / T;
              pi1 := 7.1 - pi;
              tau1 := tau - 1.222;
              o[1] := tau1 * tau1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              o[4] := o[1] * o[2];
              o[5] := o[1] * tau1;
              o[6] := o[2] * tau1;
              o[7] := pi1 * pi1;
              o[8] := o[7] * o[7];
              o[9] := o[8] * o[8];
              o[10] := o[3] * o[3];
              o[11] := o[10] * o[10];
              gpi := pi1 * (pi1 * ((0.000095038934535162 + o[2] * (8.4812393955936e-6 + 2.55615384360309e-9 * o[4])) / o[2] + pi1 * ((8.9701127632e-6 + (2.60684891582404e-6 + 5.7366919751696e-13 * o[2] * o[3]) * o[5]) / o[6] + pi1 * (2.02584984300585e-6 / o[3] + o[7] * pi1 * (o[8] * o[9] * pi1 * (o[7] * (o[7] * o[8] * ((-7.63737668221055e-22 / (o[1] * o[11] * o[2])) + pi1 * (pi1 * ((-5.65070932023524e-23 / (o[11] * o[3])) + 2.99318679335866e-24 * pi1 / (o[11] * o[3] * tau1)) + 3.5842867920213e-22 / (o[1] * o[11] * o[2] * tau1))) - 3.33001080055983e-19 / (o[1] * o[10] * o[2] * o[3] * tau1)) + 1.44400475720615e-17 / (o[10] * o[2] * o[3] * tau1)) + (1.01874413933128e-8 + 1.39398969845072e-9 * o[6]) / (o[1] * o[3] * tau1))))) + (0.00094368642146534 + o[5] * (0.00060003561586052 + ((-0.000095322787813974) + o[1] * (8.8283690661692e-6 + 1.45389992595188e-15 * o[1] * o[2] * o[3])) * tau1)) / o[5]) + ((-0.00028319080123804) + o[1] * (0.00060706301565874 + o[4] * (0.018990068218419 + tau1 * (0.032529748770505 + (0.021841717175414 + 0.00005283835796993 * o[1]) * tau1)))) / (o[3] * tau1);
              d := p / (data.RH2O * T * pi * gpi);
            end d1n;

            function d2n  "Density in region 2 as function of p and T" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.Density d "Density";
            protected
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
              Real gpi "Dimensionless Gibbs-derivative w.r.t. pi";
              Real[12] o "Auxiliary variables";
            algorithm
              pi := p / data.PSTAR2;
              tau := data.TSTAR2 / T;
              tau2 := tau - 0.5;
              o[1] := tau2 * tau2;
              o[2] := o[1] * tau2;
              o[3] := o[1] * o[1];
              o[4] := o[3] * o[3];
              o[5] := o[4] * o[4];
              o[6] := o[3] * o[4] * o[5] * tau2;
              o[7] := o[3] * o[4] * tau2;
              o[8] := o[1] * o[3] * o[4];
              o[9] := pi * pi;
              o[10] := o[9] * o[9];
              o[11] := o[3] * o[5] * tau2;
              o[12] := o[5] * o[5];
              gpi := (1. + pi * ((-0.0017731742473213) + tau2 * ((-0.017834862292358) + tau2 * ((-0.045996013696365) + ((-0.057581259083432) - 0.05032527872793 * o[2]) * tau2)) + pi * (tau2 * ((-0.000066065283340406) + ((-0.0003789797503263) + o[1] * ((-0.007878555448671) + o[2] * ((-0.087594591301146) - 0.000053349095828174 * o[6]))) * tau2) + pi * (6.1445213076927e-8 + (1.31612001853305e-6 + o[1] * ((-0.00009683303171571) + o[2] * ((-0.0045101773626444) - 0.122004760687947 * o[6]))) * tau2 + pi * (tau2 * ((-3.15389238237468e-9) + (5.116287140914e-8 + 1.92901490874028e-6 * tau2) * tau2) + pi * (0.0000114610381688305 * o[1] * o[3] * tau2 + pi * (o[2] * ((-1.00288598706366e-10) + o[7] * ((-0.012702883392813) - 143.374451604624 * o[1] * o[5] * tau2)) + pi * ((-4.1341695026989e-17) + o[1] * o[4] * ((-8.8352662293707e-6) - 0.272627897050173 * o[8]) * tau2 + pi * (o[4] * (9.0049690883672e-11 - 65.8490727183984 * o[3] * o[4] * o[5]) + pi * (1.78287415218792e-7 * o[7] + pi * (o[3] * (1.0406965210174e-18 + o[1] * ((-1.0234747095929e-12) - 1.0018179379511e-8 * o[3]) * o[3]) + o[10] * o[9] * (((-1.29412653835176e-9) + 1.71088510070544 * o[11]) * o[6] + o[9] * ((-6.05920510335078 * o[12] * o[4] * o[5] * tau2) + o[9] * (o[3] * o[5] * (1.78371690710842e-23 + o[1] * o[3] * o[4] * (6.1258633752464e-12 - 0.000084004935396416 * o[7]) * tau2) + pi * ((-1.24017662339842e-24 * o[11]) + pi * (0.0000832192847496054 * o[12] * o[3] * o[5] * tau2 + pi * (o[1] * o[4] * o[5] * (1.75410265428146e-27 + (1.32995316841867e-15 - 0.0000226487297378904 * o[1] * o[5]) * o[8]) * pi - 2.93678005497663e-14 * o[1] * o[12] * o[3] * tau2))))))))))))))))) / pi;
              d := p / (data.RH2O * T * pi * gpi);
            end d2n;

            function hl_p_R4b  "Explicit approximation of liquid specific enthalpy on the boundary between regions 4 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real x "Auxiliary variable";
            algorithm
              x := Modelica.Math.acos(p / data.PCRIT);
              h := (1 + x * ((-0.4945586958175176) + x * (1.346800016564904 + x * ((-3.889388153209752) + x * (6.679385472887931 + x * ((-6.75820241066552) + x * (3.558919744656498 + ((-0.7179818554978939) - 0.0001152032945617821 * x) * x))))))) * data.HCRIT;
            end hl_p_R4b;

            function hv_p_R4b  "Explicit approximation of vapour specific enthalpy on the boundary between regions 4 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real x "Auxiliary variable";
            algorithm
              x := Modelica.Math.acos(p / data.PCRIT);
              h := (1 + x * (0.4880153718655694 + x * (0.2079670746250689 + x * ((-6.084122698421623) + x * (25.08887602293532 + x * ((-48.38215180269516) + x * (45.66489164833212 + ((-16.98555442961553) + 0.0006616936460057691 * x) * x))))))) * data.HCRIT;
            end hv_p_R4b;

            function sl_p_R4b  "Explicit approximation of liquid specific entropy on the boundary between regions 4 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real x "Auxiliary variable";
            algorithm
              x := Modelica.Math.acos(p / data.PCRIT);
              s := (1 + x * ((-0.36160692245648063) + x * (0.9962778630486647 + x * ((-2.8595548144171103) + x * (4.906301159555333 + x * ((-4.974092309614206) + x * (2.6249651699204457 + ((-0.5319954375299023) - 0.00008064497431880644 * x) * x))))))) * data.SCRIT;
            end sl_p_R4b;

            function sv_p_R4b  "Explicit approximation of vapour specific entropy on the boundary between regions 4 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s;
            protected
              Real x "Auxiliary variable";
            algorithm
              x := Modelica.Math.acos(p / data.PCRIT);
              s := (1 + x * (0.35682641826674344 + x * (0.1642457027815487 + x * ((-4.425350377422446) + x * (18.324477859983133 + x * ((-35.338631625948665) + x * (33.36181025816282 + ((-12.408711490585757) + 0.0004810049834109226 * x) * x))))))) * data.SCRIT;
            end sv_p_R4b;

            function rhol_p_R4b  "Explicit approximation of liquid density on the boundary between regions 4 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Density dl "Liquid density";
            protected
              Real x "Auxiliary variable";
            algorithm
              if p < data.PCRIT then
                x := Modelica.Math.acos(p / data.PCRIT);
                dl := (1 + x * (1.903224079094824 + x * ((-2.5314861802401123) + x * ((-8.191449323843552) + x * (94.34196116778385 + x * ((-369.3676833623383) + x * (796.6627910598293 + x * ((-994.5385383600702) + x * (673.2581177021598 + ((-191.43077336405156) + 0.00052536560808895 * x) * x))))))))) * data.DCRIT;
              else
                dl := data.DCRIT;
              end if;
            end rhol_p_R4b;

            function rhov_p_R4b  "Explicit approximation of vapour density on the boundary between regions 4 and 2" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Density dv "Vapour density";
            protected
              Real x "Auxiliary variable";
            algorithm
              if p < data.PCRIT then
                x := Modelica.Math.acos(p / data.PCRIT);
                dv := (1 + x * ((-1.8463850803362596) + x * ((-1.1447872718878493) + x * (59.18702203076563 + x * ((-403.5391431811611) + x * (1437.2007245332388 + x * ((-3015.853540307519) + x * (3740.5790348670057 + x * ((-2537.375817253895) + (725.8761975803782 - 0.0011151111658332337 * x) * x))))))))) * data.DCRIT;
              else
                dv := data.DCRIT;
              end if;
            end rhov_p_R4b;

            function boilingcurve_p  "Properties on the boiling curve" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output Common.IF97PhaseBoundaryProperties bpro "Property record";
            protected
              Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives";
              Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives";
              .Modelica.SIunits.Pressure plim = min(p, data.PCRIT - 1e-7) "Pressure limited to critical pressure - epsilon";
            algorithm
              bpro.R := data.RH2O;
              bpro.T := Basic.tsat(plim);
              bpro.dpT := Basic.dptofT(bpro.T);
              bpro.region3boundary := bpro.T > data.TLIMIT1;
              if not bpro.region3boundary then
                g := Basic.g1(p, bpro.T);
                bpro.d := p / (bpro.R * bpro.T * g.pi * g.gpi);
                bpro.h := if p > plim then data.HCRIT else bpro.R * bpro.T * g.tau * g.gtau;
                bpro.s := g.R * (g.tau * g.gtau - g.g);
                bpro.cp := -bpro.R * g.tau * g.tau * g.gtautau;
                bpro.vt := bpro.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
                bpro.vp := bpro.R * bpro.T / (p * p) * g.pi * g.pi * g.gpipi;
                bpro.pt := -p / bpro.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
                bpro.pd := -bpro.R * bpro.T * g.gpi * g.gpi / g.gpipi;
              else
                bpro.d := rhol_p_R4b(plim);
                f := Basic.f3(bpro.d, bpro.T);
                bpro.h := hl_p_R4b(plim);
                bpro.s := f.R * (f.tau * f.ftau - f.f);
                bpro.cv := bpro.R * (-f.tau * f.tau * f.ftautau);
                bpro.pt := bpro.R * bpro.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
                bpro.pd := bpro.R * bpro.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
              end if;
            end boilingcurve_p;

            function dewcurve_p  "Properties on the dew curve" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output Common.IF97PhaseBoundaryProperties bpro "Property record";
            protected
              Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives";
              Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives";
              .Modelica.SIunits.Pressure plim = min(p, data.PCRIT - 1e-7) "Pressure limited to critical pressure - epsilon";
            algorithm
              bpro.R := data.RH2O;
              bpro.T := Basic.tsat(plim);
              bpro.dpT := Basic.dptofT(bpro.T);
              bpro.region3boundary := bpro.T > data.TLIMIT1;
              if not bpro.region3boundary then
                g := Basic.g2(p, bpro.T);
                bpro.d := p / (bpro.R * bpro.T * g.pi * g.gpi);
                bpro.h := if p > plim then data.HCRIT else bpro.R * bpro.T * g.tau * g.gtau;
                bpro.s := g.R * (g.tau * g.gtau - g.g);
                bpro.cp := -bpro.R * g.tau * g.tau * g.gtautau;
                bpro.vt := bpro.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
                bpro.vp := bpro.R * bpro.T / (p * p) * g.pi * g.pi * g.gpipi;
                bpro.pt := -p / bpro.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
                bpro.pd := -bpro.R * bpro.T * g.gpi * g.gpi / g.gpipi;
              else
                bpro.d := rhov_p_R4b(plim);
                f := Basic.f3(bpro.d, bpro.T);
                bpro.h := hv_p_R4b(plim);
                bpro.s := f.R * (f.tau * f.ftau - f.f);
                bpro.cv := bpro.R * (-f.tau * f.tau * f.ftautau);
                bpro.pt := bpro.R * bpro.d * f.delta * (f.fdelta - f.tau * f.fdeltatau);
                bpro.pd := bpro.R * bpro.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
              end if;
            end dewcurve_p;

            function hvl_p  
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := bpro.h;
              annotation(derivative(noDerivative = bpro) = hvl_p_der, Inline = false, LateInline = true); 
            end hvl_p;

            function hl_p  "Liquid specific enthalpy on the boundary between regions 4 and 3 or 1" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := hvl_p(p, boilingcurve_p(p));
              annotation(Inline = true); 
            end hl_p;

            function hv_p  "Vapour specific enthalpy on the boundary between regions 4 and 3 or 2" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              h := hvl_p(p, dewcurve_p(p));
              annotation(Inline = true); 
            end hv_p;

            function hvl_p_der  "Derivative function for the specific enthalpy along the phase boundary" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              input Real p_der "Derivative of pressure";
              output Real h_der "Time derivative of specific enthalpy along the phase boundary";
            algorithm
              if bpro.region3boundary then
                h_der := ((bpro.d * bpro.pd - bpro.T * bpro.pt) * p_der + (bpro.T * bpro.pt * bpro.pt + bpro.d * bpro.d * bpro.pd * bpro.cv) / bpro.dpT * p_der) / (bpro.pd * bpro.d * bpro.d);
              else
                h_der := (1 / bpro.d - bpro.T * bpro.vt) * p_der + bpro.cp / bpro.dpT * p_der;
              end if;
              annotation(Inline = true); 
            end hvl_p_der;

            function rhovl_p  
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output .Modelica.SIunits.Density rho "Density";
            algorithm
              rho := bpro.d;
              annotation(derivative(noDerivative = bpro) = rhovl_p_der, Inline = false, LateInline = true); 
            end rhovl_p;

            function rhol_p  "Density of saturated water" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              output .Modelica.SIunits.Density rho "Density of steam at the condensation point";
            algorithm
              rho := rhovl_p(p, boilingcurve_p(p));
              annotation(Inline = true); 
            end rhol_p;

            function rhov_p  "Density of saturated vapour" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              output .Modelica.SIunits.Density rho "Density of steam at the condensation point";
            algorithm
              rho := rhovl_p(p, dewcurve_p(p));
              annotation(Inline = true); 
            end rhov_p;

            function rhovl_p_der  
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              input Real p_der "Derivative of pressure";
              output Real d_der "Time derivative of density along the phase boundary";
            algorithm
              d_der := if bpro.region3boundary then (p_der - bpro.pt * p_der / bpro.dpT) / bpro.pd else -bpro.d * bpro.d * (bpro.vp + bpro.vt / bpro.dpT) * p_der;
              annotation(Inline = true); 
            end rhovl_p_der;

            function sl_p  "Liquid specific entropy on the boundary between regions 4 and 3 or 1" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              .Modelica.SIunits.Temperature Tsat "Saturation temperature";
              .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              if p < data.PLIMIT4A then
                Tsat := Basic.tsat(p);
                (h, s) := Isentropic.handsofpT1(p, Tsat);
              elseif p < data.PCRIT then
                s := sl_p_R4b(p);
              else
                s := data.SCRIT;
              end if;
            end sl_p;

            function sv_p  "Vapour specific entropy on the boundary between regions 4 and 3 or 2" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              .Modelica.SIunits.Temperature Tsat "Saturation temperature";
              .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            algorithm
              if p < data.PLIMIT4A then
                Tsat := Basic.tsat(p);
                (h, s) := Isentropic.handsofpT2(p, Tsat);
              elseif p < data.PCRIT then
                s := sv_p_R4b(p);
              else
                s := data.SCRIT;
              end if;
            end sv_p;

            function rhol_T  "Density of saturated water" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature";
              output .Modelica.SIunits.Density d "Density of water at the boiling point";
            protected
              .Modelica.SIunits.Pressure p "Saturation pressure";
            algorithm
              p := Basic.psat(T);
              if T < data.TLIMIT1 then
                d := d1n(p, T);
              elseif T < data.TCRIT then
                d := rhol_p_R4b(p);
              else
                d := data.DCRIT;
              end if;
            end rhol_T;

            function rhov_T  "Density of saturated vapour" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature";
              output .Modelica.SIunits.Density d "Density of steam at the condensation point";
            protected
              .Modelica.SIunits.Pressure p "Saturation pressure";
            algorithm
              p := Basic.psat(T);
              if T < data.TLIMIT1 then
                d := d2n(p, T);
              elseif T < data.TCRIT then
                d := rhov_p_R4b(p);
              else
                d := data.DCRIT;
              end if;
            end rhov_T;

            function region_ph  "Return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific enthalpy" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if not known";
              input Integer mode = 0 "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "Region (valid values: 1,2,3,4,5) in IF97";
            protected
              Boolean hsubcrit;
              .Modelica.SIunits.Temperature Ttest;
              .Modelica.SIunits.SpecificEnthalpy hl "Bubble enthalpy";
              .Modelica.SIunits.SpecificEnthalpy hv "Dew enthalpy";
            algorithm
              if mode <> 0 then
                region := mode;
              else
                hl := hl_p(p);
                hv := hv_p(p);
                if phase == 2 then
                  region := 4;
                else
                  if p < triple.ptriple or p > data.PLIMIT1 or h < hlowerofp1(p) or p < 10.0e6 and h > hupperofp5(p) or p >= 10.0e6 and h > hupperofp2(p) then
                    region := -1;
                  else
                    hsubcrit := h < data.HCRIT;
                    if p < data.PLIMIT4A then
                      if hsubcrit then
                        if phase == 1 then
                          region := 1;
                        else
                          if h < Isentropic.hofpT1(p, Basic.tsat(p)) then
                            region := 1;
                          else
                            region := 4;
                          end if;
                        end if;
                      else
                        if h > hlowerofp5(p) then
                          if p < data.PLIMIT5 and h < hupperofp5(p) then
                            region := 5;
                          else
                            region := -2;
                          end if;
                        else
                          if phase == 1 then
                            region := 2;
                          else
                            if h > Isentropic.hofpT2(p, Basic.tsat(p)) then
                              region := 2;
                            else
                              region := 4;
                            end if;
                          end if;
                        end if;
                      end if;
                    else
                      if hsubcrit then
                        if h < hupperofp1(p) then
                          region := 1;
                        else
                          if h < hl or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                      else
                        if h > hlowerofp2(p) then
                          region := 2;
                        else
                          if h > hv or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end region_ph;

            function region_ps  "Return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific entropy" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
              input Integer mode = 0 "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "Region (valid values: 1,2,3,4,5) in IF97";
            protected
              Boolean ssubcrit;
              .Modelica.SIunits.Temperature Ttest;
              .Modelica.SIunits.SpecificEntropy sl "Bubble entropy";
              .Modelica.SIunits.SpecificEntropy sv "Dew entropy";
            algorithm
              if mode <> 0 then
                region := mode;
              else
                sl := sl_p(p);
                sv := sv_p(p);
                if phase == 2 or phase == 0 and s > sl and s < sv and p < data.PCRIT then
                  region := 4;
                else
                  region := 0;
                  if p < triple.ptriple then
                    region := -2;
                  else
                  end if;
                  if p > data.PLIMIT1 then
                    region := -3;
                  else
                  end if;
                  if p < 10.0e6 and s > supperofp5(p) then
                    region := -5;
                  else
                  end if;
                  if p >= 10.0e6 and s > supperofp2(p) then
                    region := -6;
                  else
                  end if;
                  if region < 0 then
                    assert(false, "Region computation from p and s failed: function called outside the legal region");
                  else
                    ssubcrit := s < data.SCRIT;
                    if p < data.PLIMIT4A then
                      if ssubcrit then
                        region := 1;
                      else
                        if s > slowerofp5(p) then
                          if p < data.PLIMIT5 and s < supperofp5(p) then
                            region := 5;
                          else
                            region := -1;
                          end if;
                        else
                          region := 2;
                        end if;
                      end if;
                    else
                      if ssubcrit then
                        if s < supperofp1(p) then
                          region := 1;
                        else
                          if s < sl or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                      else
                        if s > slowerofp2(p) then
                          region := 2;
                        else
                          if s > sv or p > data.PCRIT then
                            region := 3;
                          else
                            region := 4;
                          end if;
                        end if;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end region_ps;

            function region_pT  "Return the current region (valid values: 1,2,3,5) in IF97, given pressure and temperature" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input Integer mode = 0 "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "Region (valid values: 1,2,3,5) in IF97, region 4 is impossible!";
            algorithm
              if mode <> 0 then
                region := mode;
              else
                if p < data.PLIMIT4A then
                  if T > data.TLIMIT2 then
                    region := 5;
                  elseif T > Basic.tsat(p) then
                    region := 2;
                  else
                    region := 1;
                  end if;
                else
                  if T < data.TLIMIT1 then
                    region := 1;
                  elseif T < boundary23ofp(p) then
                    region := 3;
                  else
                    region := 2;
                  end if;
                end if;
              end if;
            end region_pT;

            function region_dT  "Return the current region (valid values: 1,2,3,4,5) in IF97, given density and temperature" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density d "Density";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if not known";
              input Integer mode = 0 "Mode: 0 means check, otherwise assume region=mode";
              output Integer region "(valid values: 1,2,3,4,5) in IF97";
            protected
              Boolean Tovercrit "Flag if overcritical temperature";
              .Modelica.SIunits.Pressure p23 "Pressure needed to know if region 2 or 3";
            algorithm
              Tovercrit := T > data.TCRIT;
              if mode <> 0 then
                region := mode;
              else
                p23 := boundary23ofT(T);
                if T > data.TLIMIT2 then
                  if d < 20.5655874106483 then
                    region := 5;
                  else
                    assert(false, "Out of valid region for IF97, pressure above region 5!");
                  end if;
                elseif Tovercrit then
                  if d > d2n(p23, T) and T > data.TLIMIT1 then
                    region := 3;
                  elseif T < data.TLIMIT1 then
                    region := 1;
                  else
                    region := 2;
                  end if;
                elseif d > rhol_T(T) then
                  if T < data.TLIMIT1 then
                    region := 1;
                  else
                    region := 3;
                  end if;
                elseif d < rhov_T(T) then
                  if d > d2n(p23, T) and T > data.TLIMIT1 then
                    region := 3;
                  else
                    region := 2;
                  end if;
                else
                  region := 4;
                end if;
              end if;
            end region_dT;

            function hvl_dp  "Derivative function for the specific enthalpy along the phase boundary" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output Real dh_dp "Derivative of specific enthalpy along the phase boundary";
            algorithm
              if bpro.region3boundary then
                dh_dp := (bpro.d * bpro.pd - bpro.T * bpro.pt + (bpro.T * bpro.pt * bpro.pt + bpro.d * bpro.d * bpro.pd * bpro.cv) / bpro.dpT) / (bpro.pd * bpro.d * bpro.d);
              else
                dh_dp := 1 / bpro.d - bpro.T * bpro.vt + bpro.cp / bpro.dpT;
              end if;
            end hvl_dp;

            function dhl_dp  "Derivative of liquid specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.DerEnthalpyByPressure dh_dp "Specific enthalpy derivative w.r.t. pressure";
            algorithm
              dh_dp := hvl_dp(p, boilingcurve_p(p));
              annotation(Inline = true); 
            end dhl_dp;

            function dhv_dp  "Derivative of vapour specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t. pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.DerEnthalpyByPressure dh_dp "Specific enthalpy derivative w.r.t. pressure";
            algorithm
              dh_dp := hvl_dp(p, dewcurve_p(p));
              annotation(Inline = true); 
            end dhv_dp;

            function drhovl_dp  
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              input Common.IF97PhaseBoundaryProperties bpro "Property record";
              output Real dd_dp(unit = "kg/(m3.Pa)") "Derivative of density along the phase boundary";
            algorithm
              dd_dp := if bpro.region3boundary then (1.0 - bpro.pt / bpro.dpT) / bpro.pd else -bpro.d * bpro.d * (bpro.vp + bpro.vt / bpro.dpT);
              annotation(Inline = true); 
            end drhovl_dp;

            function drhol_dp  "Derivative of density of saturated water w.r.t. pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              output .Modelica.SIunits.DerDensityByPressure dd_dp "Derivative of density of water at the boiling point";
            algorithm
              dd_dp := drhovl_dp(p, boilingcurve_p(p));
              annotation(Inline = true); 
            end drhol_dp;

            function drhov_dp  "Derivative of density of saturated steam w.r.t. pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Saturation pressure";
              output .Modelica.SIunits.DerDensityByPressure dd_dp "Derivative of density of water at the boiling point";
            algorithm
              dd_dp := drhovl_dp(p, dewcurve_p(p));
              annotation(Inline = true); 
            end drhov_dp;
          end Regions;

          package Basic  "Base functions as described in IAWPS/IF97" 
            extends Modelica.Icons.Package;

            function g1  "Gibbs function for region 1: g(p,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real pi1 "Dimensionless pressure";
              Real tau1 "Dimensionless temperature";
              Real[45] o "Vector of auxiliary variables";
              Real pl "Auxiliary variable";
            algorithm
              pl := min(p, data.PCRIT - 1);
              assert(p > triple.ptriple, "IF97 medium function g1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              assert(p <= 100.0e6, "IF97 medium function g1: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
              assert(T >= 273.15, "IF97 medium function g1: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              g.pi := p / data.PSTAR1;
              g.tau := data.TSTAR1 / T;
              pi1 := 7.1000000000000 - g.pi;
              tau1 := (-1.22200000000000) + g.tau;
              o[1] := tau1 * tau1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              o[4] := o[3] * tau1;
              o[5] := 1 / o[4];
              o[6] := o[1] * o[2];
              o[7] := o[1] * tau1;
              o[8] := 1 / o[7];
              o[9] := o[1] * o[2] * o[3];
              o[10] := 1 / o[2];
              o[11] := o[2] * tau1;
              o[12] := 1 / o[11];
              o[13] := o[2] * o[3];
              o[14] := 1 / o[3];
              o[15] := pi1 * pi1;
              o[16] := o[15] * pi1;
              o[17] := o[15] * o[15];
              o[18] := o[17] * o[17];
              o[19] := o[17] * o[18] * pi1;
              o[20] := o[15] * o[17];
              o[21] := o[3] * o[3];
              o[22] := o[21] * o[21];
              o[23] := o[22] * o[3] * tau1;
              o[24] := 1 / o[23];
              o[25] := o[22] * o[3];
              o[26] := 1 / o[25];
              o[27] := o[1] * o[2] * o[22] * tau1;
              o[28] := 1 / o[27];
              o[29] := o[1] * o[2] * o[22];
              o[30] := 1 / o[29];
              o[31] := o[1] * o[2] * o[21] * o[3] * tau1;
              o[32] := 1 / o[31];
              o[33] := o[2] * o[21] * o[3] * tau1;
              o[34] := 1 / o[33];
              o[35] := o[1] * o[3] * tau1;
              o[36] := 1 / o[35];
              o[37] := o[1] * o[3];
              o[38] := 1 / o[37];
              o[39] := 1 / o[6];
              o[40] := o[1] * o[22] * o[3];
              o[41] := 1 / o[40];
              o[42] := 1 / o[22];
              o[43] := o[1] * o[2] * o[21] * o[3];
              o[44] := 1 / o[43];
              o[45] := 1 / o[13];
              g.g := pi1 * (pi1 * (pi1 * (o[10] * ((-0.000031679644845054) + o[2] * ((-2.82707979853120e-6) - 8.5205128120103e-10 * o[6])) + pi1 * (o[12] * ((-2.24252819080000e-6) + ((-6.5171222895601e-7) - 1.43417299379240e-13 * o[13]) * o[7]) + pi1 * ((-4.0516996860117e-7 * o[14]) + o[16] * (((-1.27343017416410e-9) - 1.74248712306340e-10 * o[11]) * o[36] + o[19] * ((-6.8762131295531e-19 * o[34]) + o[15] * (1.44783078285210e-20 * o[32] + o[20] * (2.63357816627950e-23 * o[30] + pi1 * ((-1.19476226400710e-23 * o[28]) + pi1 * (1.82280945814040e-24 * o[26] - 9.3537087292458e-26 * o[24] * pi1))))))))) + o[8] * ((-0.00047184321073267) + o[7] * ((-0.000300017807930260) + (0.000047661393906987 + o[1] * ((-4.4141845330846e-6) - 7.2694996297594e-16 * o[9])) * tau1))) + o[5] * (0.000283190801238040 + o[1] * ((-0.00060706301565874) + o[6] * ((-0.0189900682184190) + tau1 * ((-0.032529748770505) + ((-0.0218417171754140) - 0.000052838357969930 * o[1]) * tau1))))) + (0.146329712131670 + tau1 * ((-0.84548187169114) + tau1 * ((-3.7563603672040) + tau1 * (3.3855169168385 + tau1 * ((-0.95791963387872) + tau1 * (0.157720385132280 + ((-0.0166164171995010) + 0.00081214629983568 * tau1) * tau1)))))) / o[1];
              g.gpi := pi1 * (pi1 * (o[10] * (0.000095038934535162 + o[2] * (8.4812393955936e-6 + 2.55615384360309e-9 * o[6])) + pi1 * (o[12] * (8.9701127632000e-6 + (2.60684891582404e-6 + 5.7366919751696e-13 * o[13]) * o[7]) + pi1 * (2.02584984300585e-6 * o[14] + o[16] * ((1.01874413933128e-8 + 1.39398969845072e-9 * o[11]) * o[36] + o[19] * (1.44400475720615e-17 * o[34] + o[15] * ((-3.3300108005598e-19 * o[32]) + o[20] * ((-7.6373766822106e-22 * o[30]) + pi1 * (3.5842867920213e-22 * o[28] + pi1 * ((-5.6507093202352e-23 * o[26]) + 2.99318679335866e-24 * o[24] * pi1))))))))) + o[8] * (0.00094368642146534 + o[7] * (0.00060003561586052 + ((-0.000095322787813974) + o[1] * (8.8283690661692e-6 + 1.45389992595188e-15 * o[9])) * tau1))) + o[5] * ((-0.000283190801238040) + o[1] * (0.00060706301565874 + o[6] * (0.0189900682184190 + tau1 * (0.032529748770505 + (0.0218417171754140 + 0.000052838357969930 * o[1]) * tau1))));
              g.gpipi := pi1 * (o[10] * ((-0.000190077869070324) + o[2] * ((-0.0000169624787911872) - 5.1123076872062e-9 * o[6])) + pi1 * (o[12] * ((-0.0000269103382896000) + ((-7.8205467474721e-6) - 1.72100759255088e-12 * o[13]) * o[7]) + pi1 * ((-8.1033993720234e-6 * o[14]) + o[16] * (((-7.1312089753190e-8) - 9.7579278891550e-9 * o[11]) * o[36] + o[19] * ((-2.88800951441230e-16 * o[34]) + o[15] * (7.3260237612316e-18 * o[32] + o[20] * (2.13846547101895e-20 * o[30] + pi1 * ((-1.03944316968618e-20 * o[28]) + pi1 * (1.69521279607057e-21 * o[26] - 9.2788790594118e-23 * o[24] * pi1))))))))) + o[8] * ((-0.00094368642146534) + o[7] * ((-0.00060003561586052) + (0.000095322787813974 + o[1] * ((-8.8283690661692e-6) - 1.45389992595188e-15 * o[9])) * tau1));
              g.gtau := pi1 * (o[38] * ((-0.00254871721114236) + o[1] * (0.0042494411096112 + (0.0189900682184190 + ((-0.0218417171754140) - 0.000158515073909790 * o[1]) * o[1]) * o[6])) + pi1 * (o[10] * (0.00141552963219801 + o[2] * (0.000047661393906987 + o[1] * ((-0.0000132425535992538) - 1.23581493705910e-14 * o[9]))) + pi1 * (o[12] * (0.000126718579380216 - 5.1123076872062e-9 * o[37]) + pi1 * (o[39] * (0.0000112126409540000 + (1.30342445791202e-6 - 1.43417299379240e-12 * o[13]) * o[7]) + pi1 * (3.2413597488094e-6 * o[5] + o[16] * ((1.40077319158051e-8 + 1.04549227383804e-9 * o[11]) * o[45] + o[19] * (1.99410180757040e-17 * o[44] + o[15] * ((-4.4882754268415e-19 * o[42]) + o[20] * ((-1.00075970318621e-21 * o[28]) + pi1 * (4.6595728296277e-22 * o[26] + pi1 * ((-7.2912378325616e-23 * o[24]) + 3.8350205789908e-24 * o[41] * pi1))))))))))) + o[8] * ((-0.292659424263340) + tau1 * (0.84548187169114 + o[1] * (3.3855169168385 + tau1 * ((-1.91583926775744) + tau1 * (0.47316115539684 + ((-0.066465668798004) + 0.0040607314991784 * tau1) * tau1)))));
              g.gtautau := pi1 * (o[36] * (0.0254871721114236 + o[1] * ((-0.033995528876889) + ((-0.037980136436838) - 0.00031703014781958 * o[2]) * o[6])) + pi1 * (o[12] * ((-0.0056621185287920) + o[6] * ((-0.0000264851071985076) - 1.97730389929456e-13 * o[9])) + pi1 * (((-0.00063359289690108) - 2.55615384360309e-8 * o[37]) * o[39] + pi1 * (pi1 * ((-0.0000291722377392842 * o[38]) + o[16] * (o[19] * ((-5.9823054227112e-16 * o[32]) + o[15] * (o[20] * (3.9029628424262e-20 * o[26] + pi1 * ((-1.86382913185108e-20 * o[24]) + pi1 * (2.98940751135026e-21 * o[41] - 1.61070864317613e-22 * pi1 / (o[1] * o[22] * o[3] * tau1)))) + 1.43624813658928e-17 / (o[22] * tau1))) + ((-1.68092782989661e-7) - 7.3184459168663e-9 * o[11]) / (o[2] * o[3] * tau1))) + ((-0.000067275845724000) + ((-3.9102733737361e-6) - 1.29075569441316e-11 * o[13]) * o[7]) / (o[1] * o[2] * tau1))))) + o[10] * (0.87797827279002 + tau1 * ((-1.69096374338228) + o[7] * ((-1.91583926775744) + tau1 * (0.94632231079368 + ((-0.199397006394012) + 0.0162429259967136 * tau1) * tau1))));
              g.gtaupi := o[38] * (0.00254871721114236 + o[1] * ((-0.0042494411096112) + ((-0.0189900682184190) + (0.0218417171754140 + 0.000158515073909790 * o[1]) * o[1]) * o[6])) + pi1 * (o[10] * ((-0.00283105926439602) + o[2] * ((-0.000095322787813974) + o[1] * (0.0000264851071985076 + 2.47162987411820e-14 * o[9]))) + pi1 * (o[12] * ((-0.00038015573814065) + 1.53369230616185e-8 * o[37]) + pi1 * (o[39] * ((-0.000044850563816000) + ((-5.2136978316481e-6) + 5.7366919751696e-12 * o[13]) * o[7]) + pi1 * ((-0.0000162067987440468 * o[5]) + o[16] * (((-1.12061855326441e-7) - 8.3639381907043e-9 * o[11]) * o[45] + o[19] * ((-4.1876137958978e-16 * o[44]) + o[15] * (1.03230334817355e-17 * o[42] + o[20] * (2.90220313924001e-20 * o[28] + pi1 * ((-1.39787184888831e-20 * o[26]) + pi1 * (2.26028372809410e-21 * o[24] - 1.22720658527705e-22 * o[41] * pi1))))))))));
            end g1;

            function g2  "Gibbs function for region 2: g(p,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real tau2 "Dimensionless temperature";
              Real[55] o "Vector of auxiliary variables";
            algorithm
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              assert(p > 0.0, "IF97 medium function g2 called with too low pressure\n" + "p = " + String(p) + " Pa <=  0.0 Pa");
              assert(p <= 100.0e6, "IF97 medium function g2: the input pressure (= " + String(p) + " Pa) is higher than 100 Mpa");
              assert(T >= 273.15, "IF97 medium function g2: the temperature (= " + String(T) + " K) is lower than 273.15 K!");
              assert(T <= 1073.15, "IF97 medium function g2: the input temperature (= " + String(T) + " K) is higher than the limit of 1073.15 K");
              g.pi := p / data.PSTAR2;
              g.tau := data.TSTAR2 / T;
              tau2 := (-0.5) + g.tau;
              o[1] := tau2 * tau2;
              o[2] := o[1] * tau2;
              o[3] := -0.050325278727930 * o[2];
              o[4] := (-0.057581259083432) + o[3];
              o[5] := o[4] * tau2;
              o[6] := (-0.045996013696365) + o[5];
              o[7] := o[6] * tau2;
              o[8] := (-0.0178348622923580) + o[7];
              o[9] := o[8] * tau2;
              o[10] := o[1] * o[1];
              o[11] := o[10] * o[10];
              o[12] := o[11] * o[11];
              o[13] := o[10] * o[11] * o[12] * tau2;
              o[14] := o[1] * o[10] * tau2;
              o[15] := o[10] * o[11] * tau2;
              o[16] := o[1] * o[12] * tau2;
              o[17] := o[1] * o[11] * tau2;
              o[18] := o[1] * o[10] * o[11];
              o[19] := o[10] * o[11] * o[12];
              o[20] := o[1] * o[10];
              o[21] := g.pi * g.pi;
              o[22] := o[21] * o[21];
              o[23] := o[21] * o[22];
              o[24] := o[10] * o[12] * tau2;
              o[25] := o[12] * o[12];
              o[26] := o[11] * o[12] * o[25] * tau2;
              o[27] := o[10] * o[12];
              o[28] := o[1] * o[10] * o[11] * tau2;
              o[29] := o[10] * o[12] * o[25] * tau2;
              o[30] := o[1] * o[10] * o[25] * tau2;
              o[31] := o[1] * o[11] * o[12];
              o[32] := o[1] * o[12];
              o[33] := g.tau * g.tau;
              o[34] := o[33] * o[33];
              o[35] := -0.000053349095828174 * o[13];
              o[36] := (-0.087594591301146) + o[35];
              o[37] := o[2] * o[36];
              o[38] := (-0.0078785554486710) + o[37];
              o[39] := o[1] * o[38];
              o[40] := (-0.00037897975032630) + o[39];
              o[41] := o[40] * tau2;
              o[42] := (-0.000066065283340406) + o[41];
              o[43] := o[42] * tau2;
              o[44] := 5.7870447262208e-6 * tau2;
              o[45] := -0.301951672367580 * o[2];
              o[46] := (-0.172743777250296) + o[45];
              o[47] := o[46] * tau2;
              o[48] := (-0.091992027392730) + o[47];
              o[49] := o[48] * tau2;
              o[50] := o[1] * o[11];
              o[51] := o[10] * o[11];
              o[52] := o[11] * o[12] * o[25];
              o[53] := o[10] * o[12] * o[25];
              o[54] := o[1] * o[10] * o[25];
              o[55] := o[11] * o[12] * tau2;
              g.g := g.pi * ((-0.00177317424732130) + o[9] + g.pi * (tau2 * ((-0.000033032641670203) + ((-0.000189489875163150) + o[1] * ((-0.0039392777243355) + ((-0.043797295650573) - 0.0000266745479140870 * o[13]) * o[2])) * tau2) + g.pi * (2.04817376923090e-8 + (4.3870667284435e-7 + o[1] * ((-0.000032277677238570) + ((-0.00150339245421480) - 0.040668253562649 * o[13]) * o[2])) * tau2 + g.pi * (g.pi * (2.29220763376610e-6 * o[14] + g.pi * (((-1.67147664510610e-11) + o[15] * ((-0.00211714723213550) - 23.8957419341040 * o[16])) * o[2] + g.pi * ((-5.9059564324270e-18) + o[17] * ((-1.26218088991010e-6) - 0.038946842435739 * o[18]) + g.pi * (o[11] * (1.12562113604590e-11 - 8.2311340897998 * o[19]) + g.pi * (1.98097128020880e-8 * o[15] + g.pi * (o[10] * (1.04069652101740e-19 + ((-1.02347470959290e-13) - 1.00181793795110e-9 * o[10]) * o[20]) + o[23] * (o[13] * ((-8.0882908646985e-11) + 0.106930318794090 * o[24]) + o[21] * ((-0.33662250574171 * o[26]) + o[21] * (o[27] * (8.9185845355421e-25 + (3.06293168762320e-13 - 4.2002467698208e-6 * o[15]) * o[28]) + g.pi * ((-5.9056029685639e-26 * o[24]) + g.pi * (3.7826947613457e-6 * o[29] + g.pi * ((-1.27686089346810e-15 * o[30]) + o[31] * (7.3087610595061e-29 + o[18] * (5.5414715350778e-17 - 9.4369707241210e-7 * o[32])) * g.pi)))))))))))) + tau2 * ((-7.8847309559367e-10) + (1.27907178522850e-8 + 4.8225372718507e-7 * tau2) * tau2))))) + ((-0.0056087911830200) + g.tau * (0.071452738814550 + g.tau * ((-0.40710498239280) + g.tau * (1.42408197144400 + g.tau * ((-4.3839511194500) + g.tau * ((-9.6927686002170) + g.tau * (10.0866556801800 + ((-0.284086326077200) + 0.0212684635330700 * g.tau) * g.tau) + Modelica.Math.log(g.pi))))))) / (o[34] * g.tau);
              g.gpi := (1.00000000000000 + g.pi * ((-0.00177317424732130) + o[9] + g.pi * (o[43] + g.pi * (6.1445213076927e-8 + (1.31612001853305e-6 + o[1] * ((-0.000096833031715710) + ((-0.0045101773626444) - 0.122004760687947 * o[13]) * o[2])) * tau2 + g.pi * (g.pi * (0.0000114610381688305 * o[14] + g.pi * (((-1.00288598706366e-10) + o[15] * ((-0.0127028833928130) - 143.374451604624 * o[16])) * o[2] + g.pi * ((-4.1341695026989e-17) + o[17] * ((-8.8352662293707e-6) - 0.272627897050173 * o[18]) + g.pi * (o[11] * (9.0049690883672e-11 - 65.849072718398 * o[19]) + g.pi * (1.78287415218792e-7 * o[15] + g.pi * (o[10] * (1.04069652101740e-18 + ((-1.02347470959290e-12) - 1.00181793795110e-8 * o[10]) * o[20]) + o[23] * (o[13] * ((-1.29412653835176e-9) + 1.71088510070544 * o[24]) + o[21] * ((-6.0592051033508 * o[26]) + o[21] * (o[27] * (1.78371690710842e-23 + (6.1258633752464e-12 - 0.000084004935396416 * o[15]) * o[28]) + g.pi * ((-1.24017662339842e-24 * o[24]) + g.pi * (0.000083219284749605 * o[29] + g.pi * ((-2.93678005497663e-14 * o[30]) + o[31] * (1.75410265428146e-27 + o[18] * (1.32995316841867e-15 - 0.0000226487297378904 * o[32])) * g.pi)))))))))))) + tau2 * ((-3.15389238237468e-9) + (5.1162871409140e-8 + 1.92901490874028e-6 * tau2) * tau2)))))) / g.pi;
              g.gpipi := ((-1.00000000000000) + o[21] * (o[43] + g.pi * (1.22890426153854e-7 + (2.63224003706610e-6 + o[1] * ((-0.000193666063431420) + ((-0.0090203547252888) - 0.244009521375894 * o[13]) * o[2])) * tau2 + g.pi * (g.pi * (0.000045844152675322 * o[14] + g.pi * (((-5.0144299353183e-10) + o[15] * ((-0.063514416964065) - 716.87225802312 * o[16])) * o[2] + g.pi * ((-2.48050170161934e-16) + o[17] * ((-0.000053011597376224) - 1.63576738230104 * o[18]) + g.pi * (o[11] * (6.3034783618570e-10 - 460.94350902879 * o[19]) + g.pi * (1.42629932175034e-6 * o[15] + g.pi * (o[10] * (9.3662686891566e-18 + ((-9.2112723863361e-12) - 9.0163614415599e-8 * o[10]) * o[20]) + o[23] * (o[13] * ((-1.94118980752764e-8) + 25.6632765105816 * o[24]) + o[21] * ((-103.006486756963 * o[26]) + o[21] * (o[27] * (3.3890621235060e-22 + (1.16391404129682e-10 - 0.00159609377253190 * o[15]) * o[28]) + g.pi * ((-2.48035324679684e-23 * o[24]) + g.pi * (0.00174760497974171 * o[29] + g.pi * ((-6.4609161209486e-13 * o[30]) + o[31] * (4.0344361048474e-26 + o[18] * (3.05889228736295e-14 - 0.00052092078397148 * o[32])) * g.pi)))))))))))) + tau2 * ((-9.4616771471240e-9) + (1.53488614227420e-7 + o[44]) * tau2))))) / o[21];
              g.gtau := (0.0280439559151000 + g.tau * ((-0.285810955258200) + g.tau * (1.22131494717840 + g.tau * ((-2.84816394288800) + g.tau * (4.3839511194500 + o[33] * (10.0866556801800 + ((-0.56817265215440) + 0.063805390599210 * g.tau) * g.tau)))))) / (o[33] * o[34]) + g.pi * ((-0.0178348622923580) + o[49] + g.pi * ((-0.000033032641670203) + ((-0.00037897975032630) + o[1] * ((-0.0157571108973420) + ((-0.306581069554011) - 0.00096028372490713 * o[13]) * o[2])) * tau2 + g.pi * (4.3870667284435e-7 + o[1] * ((-0.000096833031715710) + ((-0.0090203547252888) - 1.42338887469272 * o[13]) * o[2]) + g.pi * ((-7.8847309559367e-10) + g.pi * (0.0000160454534363627 * o[20] + g.pi * (o[1] * ((-5.0144299353183e-11) + o[15] * ((-0.033874355714168) - 836.35096769364 * o[16])) + g.pi * (((-0.0000138839897890111) - 0.97367106089347 * o[18]) * o[50] + g.pi * (o[14] * (9.0049690883672e-11 - 296.320827232793 * o[19]) + g.pi * (2.57526266427144e-7 * o[51] + g.pi * (o[2] * (4.1627860840696e-19 + ((-1.02347470959290e-12) - 1.40254511313154e-8 * o[10]) * o[20]) + o[23] * (o[19] * ((-2.34560435076256e-9) + 5.3465159397045 * o[24]) + o[21] * ((-19.1874828272775 * o[52]) + o[21] * (o[16] * (1.78371690710842e-23 + (1.07202609066812e-11 - 0.000201611844951398 * o[15]) * o[28]) + g.pi * ((-1.24017662339842e-24 * o[27]) + g.pi * (0.000200482822351322 * o[53] + g.pi * ((-4.9797574845256e-14 * o[54]) + (1.90027787547159e-27 + o[18] * (2.21658861403112e-15 - 0.000054734430199902 * o[32])) * o[55] * g.pi)))))))))))) + (2.55814357045700e-8 + 1.44676118155521e-6 * tau2) * tau2))));
              g.gtautau := ((-0.168263735490600) + g.tau * (1.42905477629100 + g.tau * ((-4.8852597887136) + g.tau * (8.5444918286640 + g.tau * ((-8.7679022389000) + o[33] * ((-0.56817265215440) + 0.127610781198420 * g.tau) * g.tau))))) / (o[33] * o[34] * g.tau) + g.pi * ((-0.091992027392730) + ((-0.34548755450059) - 1.50975836183790 * o[2]) * tau2 + g.pi * ((-0.00037897975032630) + o[1] * ((-0.047271332692026) + ((-1.83948641732407) - 0.033609930371750 * o[13]) * o[2]) + g.pi * (((-0.000193666063431420) + ((-0.045101773626444) - 48.395221739552 * o[13]) * o[2]) * tau2 + g.pi * (2.55814357045700e-8 + 2.89352236311042e-6 * tau2 + g.pi * (0.000096272720618176 * o[10] * tau2 + g.pi * (((-1.00288598706366e-10) + o[15] * ((-0.50811533571252) - 28435.9329015838 * o[16])) * tau2 + g.pi * (o[11] * ((-0.000138839897890111) - 23.3681054614434 * o[18]) * tau2 + g.pi * ((6.3034783618570e-10 - 10371.2289531477 * o[19]) * o[20] + g.pi * (3.09031519712573e-6 * o[17] + g.pi * (o[1] * (1.24883582522088e-18 + ((-9.2112723863361e-12) - 1.82330864707100e-7 * o[10]) * o[20]) + o[23] * (o[1] * o[11] * o[12] * ((-6.5676921821352e-8) + 261.979281045521 * o[24]) * tau2 + o[21] * ((-1074.49903832754 * o[1] * o[10] * o[12] * o[25] * tau2) + o[21] * ((3.3890621235060e-22 + (3.6448887082716e-10 - 0.0094757567127157 * o[15]) * o[28]) * o[32] + g.pi * ((-2.48035324679684e-23 * o[16]) + g.pi * (0.0104251067622687 * o[1] * o[12] * o[25] * tau2 + g.pi * (o[11] * o[12] * (4.7506946886790e-26 + o[18] * (8.6446955947214e-14 - 0.00311986252139440 * o[32])) * g.pi - 1.89230784411972e-12 * o[10] * o[25] * tau2))))))))))))))));
              g.gtaupi := (-0.0178348622923580) + o[49] + g.pi * ((-0.000066065283340406) + ((-0.00075795950065260) + o[1] * ((-0.0315142217946840) + ((-0.61316213910802) - 0.00192056744981426 * o[13]) * o[2])) * tau2 + g.pi * (1.31612001853305e-6 + o[1] * ((-0.000290499095147130) + ((-0.0270610641758664) - 4.2701666240781 * o[13]) * o[2]) + g.pi * ((-3.15389238237468e-9) + g.pi * (0.000080227267181813 * o[20] + g.pi * (o[1] * ((-3.00865796119098e-10) + o[15] * ((-0.203246134285008) - 5018.1058061618 * o[16])) + g.pi * (((-0.000097187928523078) - 6.8156974262543 * o[18]) * o[50] + g.pi * (o[14] * (7.2039752706938e-10 - 2370.56661786234 * o[19]) + g.pi * (2.31773639784430e-6 * o[51] + g.pi * (o[2] * (4.1627860840696e-18 + ((-1.02347470959290e-11) - 1.40254511313154e-7 * o[10]) * o[20]) + o[23] * (o[19] * ((-3.7529669612201e-8) + 85.544255035272 * o[24]) + o[21] * ((-345.37469089099 * o[52]) + o[21] * (o[16] * (3.5674338142168e-22 + (2.14405218133624e-10 - 0.0040322368990280 * o[15]) * o[28]) + g.pi * ((-2.60437090913668e-23 * o[27]) + g.pi * (0.0044106220917291 * o[53] + g.pi * ((-1.14534422144089e-12 * o[54]) + (4.5606669011318e-26 + o[18] * (5.3198126736747e-14 - 0.00131362632479764 * o[32])) * o[55] * g.pi)))))))))))) + (1.02325742818280e-7 + o[44]) * tau2)));
            end g2;

            function f3  "Helmholtz function for region 3: f(d,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density d "Density";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output Modelica.Media.Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
            protected
              Real[40] o "Vector of auxiliary variables";
            algorithm
              f.T := T;
              f.d := d;
              f.R := data.RH2O;
              f.tau := data.TCRIT / T;
              f.delta := if d == data.DCRIT and T == data.TCRIT then 1 - Modelica.Constants.eps else abs(d / data.DCRIT);
              o[1] := f.tau * f.tau;
              o[2] := o[1] * o[1];
              o[3] := o[2] * f.tau;
              o[4] := o[1] * f.tau;
              o[5] := o[2] * o[2];
              o[6] := o[1] * o[5] * f.tau;
              o[7] := o[5] * f.tau;
              o[8] := -0.64207765181607 * o[1];
              o[9] := 0.88521043984318 + o[8];
              o[10] := o[7] * o[9];
              o[11] := (-1.15244078066810) + o[10];
              o[12] := o[11] * o[2];
              o[13] := (-1.26543154777140) + o[12];
              o[14] := o[1] * o[13];
              o[15] := o[1] * o[2] * o[5] * f.tau;
              o[16] := o[2] * o[5];
              o[17] := o[1] * o[5];
              o[18] := o[5] * o[5];
              o[19] := o[1] * o[18] * o[2];
              o[20] := o[1] * o[18] * o[2] * f.tau;
              o[21] := o[18] * o[5];
              o[22] := o[1] * o[18] * o[5];
              o[23] := 0.251168168486160 * o[2];
              o[24] := 0.078841073758308 + o[23];
              o[25] := o[15] * o[24];
              o[26] := (-6.1005234513930) + o[25];
              o[27] := o[26] * f.tau;
              o[28] := 9.7944563083754 + o[27];
              o[29] := o[2] * o[28];
              o[30] := (-1.70429417648412) + o[29];
              o[31] := o[1] * o[30];
              o[32] := f.delta * f.delta;
              o[33] := -10.9153200808732 * o[1];
              o[34] := 13.2781565976477 + o[33];
              o[35] := o[34] * o[7];
              o[36] := (-6.9146446840086) + o[35];
              o[37] := o[2] * o[36];
              o[38] := (-2.53086309554280) + o[37];
              o[39] := o[38] * f.tau;
              o[40] := o[18] * o[5] * f.tau;
              f.f := (-15.7328452902390) + f.tau * (20.9443969743070 + ((-7.6867707878716) + o[3] * (2.61859477879540 + o[4] * ((-2.80807811486200) + o[1] * (1.20533696965170 - 0.0084566812812502 * o[6])))) * f.tau) + f.delta * (o[14] + f.delta * (0.38493460186671 + o[1] * ((-0.85214708824206) + o[2] * (4.8972281541877 + ((-3.05026172569650) + o[15] * (0.039420536879154 + 0.125584084243080 * o[2])) * f.tau)) + f.delta * ((-0.279993296987100) + o[1] * (1.38997995694600 + o[1] * ((-2.01899150235700) + o[16] * ((-0.0082147637173963) - 0.47596035734923 * o[17]))) + f.delta * (0.043984074473500 + o[1] * ((-0.44476435428739) + o[1] * (0.90572070719733 + 0.70522450087967 * o[19])) + f.delta * (f.delta * ((-0.0221754008730960) + o[1] * (0.094260751665092 + 0.164362784479610 * o[21]) + f.delta * ((-0.0135033722413480 * o[1]) + f.delta * ((-0.0148343453524720 * o[22]) + f.delta * (o[1] * (0.00057922953628084 + 0.0032308904703711 * o[21]) + f.delta * (0.000080964802996215 - 0.000044923899061815 * f.delta * o[22] - 0.000165576797950370 * f.tau))))) + (0.107705126263320 + o[1] * ((-0.32913623258954) - 0.50871062041158 * o[20])) * f.tau))))) + 1.06580700285130 * Modelica.Math.log(f.delta);
              f.fdelta := (1.06580700285130 + f.delta * (o[14] + f.delta * (0.76986920373342 + o[31] + f.delta * ((-0.83997989096130) + o[1] * (4.1699398708380 + o[1] * ((-6.0569745070710) + o[16] * ((-0.0246442911521889) - 1.42788107204769 * o[17]))) + f.delta * (0.175936297894000 + o[1] * ((-1.77905741714956) + o[1] * (3.6228828287893 + 2.82089800351868 * o[19])) + f.delta * (f.delta * ((-0.133052405238576) + o[1] * (0.56556450999055 + 0.98617670687766 * o[21]) + f.delta * ((-0.094523605689436 * o[1]) + f.delta * ((-0.118674762819776 * o[22]) + f.delta * (o[1] * (0.0052130658265276 + 0.0290780142333399 * o[21]) + f.delta * (0.00080964802996215 - 0.00049416288967996 * f.delta * o[22] - 0.00165576797950370 * f.tau))))) + (0.53852563131660 + o[1] * ((-1.64568116294770) - 2.54355310205790 * o[20])) * f.tau)))))) / f.delta;
              f.fdeltadelta := ((-1.06580700285130) + o[32] * (0.76986920373342 + o[31] + f.delta * ((-1.67995978192260) + o[1] * (8.3398797416760 + o[1] * ((-12.1139490141420) + o[16] * ((-0.049288582304378) - 2.85576214409538 * o[17]))) + f.delta * (0.52780889368200 + o[1] * ((-5.3371722514487) + o[1] * (10.8686484863680 + 8.4626940105560 * o[19])) + f.delta * (f.delta * ((-0.66526202619288) + o[1] * (2.82782254995276 + 4.9308835343883 * o[21]) + f.delta * ((-0.56714163413662 * o[1]) + f.delta * ((-0.83072333973843 * o[22]) + f.delta * (o[1] * (0.041704526612220 + 0.232624113866719 * o[21]) + f.delta * (0.0072868322696594 - 0.0049416288967996 * f.delta * o[22] - 0.0149019118155333 * f.tau))))) + (2.15410252526640 + o[1] * ((-6.5827246517908) - 10.1742124082316 * o[20])) * f.tau))))) / o[32];
              f.ftau := 20.9443969743070 + ((-15.3735415757432) + o[3] * (18.3301634515678 + o[4] * ((-28.0807811486200) + o[1] * (14.4640436358204 - 0.194503669468755 * o[6])))) * f.tau + f.delta * (o[39] + f.delta * (f.tau * ((-1.70429417648412) + o[2] * (29.3833689251262 + ((-21.3518320798755) + o[15] * (0.86725181134139 + 3.2651861903201 * o[2])) * f.tau)) + f.delta * ((2.77995991389200 + o[1] * ((-8.0759660094280) + o[16] * ((-0.131436219478341) - 12.3749692910800 * o[17]))) * f.tau + f.delta * (((-0.88952870857478) + o[1] * (3.6228828287893 + 18.3358370228714 * o[19])) * f.tau + f.delta * (0.107705126263320 + o[1] * ((-0.98740869776862) - 13.2264761307011 * o[20]) + f.delta * ((0.188521503330184 + 4.2734323964699 * o[21]) * f.tau + f.delta * ((-0.0270067444826960 * f.tau) + f.delta * ((-0.38569297916427 * o[40]) + f.delta * (f.delta * ((-0.000165576797950370) - 0.00116802137560719 * f.delta * o[40]) + (0.00115845907256168 + 0.084003152229649 * o[21]) * f.tau)))))))));
              f.ftautau := (-15.3735415757432) + o[3] * (109.980980709407 + o[4] * ((-252.727030337580) + o[1] * (159.104479994024 - 4.2790807283126 * o[6]))) + f.delta * ((-2.53086309554280) + o[2] * ((-34.573223420043) + (185.894192367068 - 174.645121293971 * o[1]) * o[7]) + f.delta * ((-1.70429417648412) + o[2] * (146.916844625631 + ((-128.110992479253) + o[15] * (18.2122880381691 + 81.629654758002 * o[2])) * f.tau) + f.delta * (2.77995991389200 + o[1] * ((-24.2278980282840) + o[16] * ((-1.97154329217511) - 309.374232277000 * o[17])) + f.delta * ((-0.88952870857478) + o[1] * (10.8686484863680 + 458.39592557179 * o[19]) + f.delta * (f.delta * (0.188521503330184 + 106.835809911747 * o[21] + f.delta * ((-0.0270067444826960) + f.delta * ((-9.6423244791068 * o[21]) + f.delta * (0.00115845907256168 + 2.10007880574121 * o[21] - 0.0292005343901797 * o[21] * o[32])))) + ((-1.97481739553724) - 330.66190326753 * o[20]) * f.tau)))));
              f.fdeltatau := o[39] + f.delta * (f.tau * ((-3.4085883529682) + o[2] * (58.766737850252 + ((-42.703664159751) + o[15] * (1.73450362268278 + 6.5303723806402 * o[2])) * f.tau)) + f.delta * ((8.3398797416760 + o[1] * ((-24.2278980282840) + o[16] * ((-0.39430865843502) - 37.124907873240 * o[17]))) * f.tau + f.delta * (((-3.5581148342991) + o[1] * (14.4915313151573 + 73.343348091486 * o[19])) * f.tau + f.delta * (0.53852563131660 + o[1] * ((-4.9370434888431) - 66.132380653505 * o[20]) + f.delta * ((1.13112901998110 + 25.6405943788192 * o[21]) * f.tau + f.delta * ((-0.189047211378872 * f.tau) + f.delta * ((-3.08554383331418 * o[40]) + f.delta * (f.delta * ((-0.00165576797950370) - 0.0128482351316791 * f.delta * o[40]) + (0.0104261316530551 + 0.75602837006684 * o[21]) * f.tau))))))));
            end f3;

            function g5  "Base function for region 5: g(p,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
            protected
              Real[11] o "Vector of auxiliary variables";
            algorithm
              assert(p > 0.0, "IF97 medium function g5 called with too low pressure\n" + "p = " + String(p) + " Pa <=  0.0 Pa");
              assert(p <= data.PLIMIT5, "IF97 medium function g5: input pressure (= " + String(p) + " Pa) is higher than 10 Mpa in region 5");
              assert(T <= 2273.15, "IF97 medium function g5: input temperature (= " + String(T) + " K) is higher than limit of 2273.15K in region 5");
              g.p := p;
              g.T := T;
              g.R := data.RH2O;
              g.pi := p / data.PSTAR5;
              g.tau := data.TSTAR5 / T;
              o[1] := g.tau * g.tau;
              o[2] := -0.0045942820899910 * o[1];
              o[3] := 0.00217746787145710 + o[2];
              o[4] := o[3] * g.tau;
              o[5] := o[1] * g.tau;
              o[6] := o[1] * o[1];
              o[7] := o[6] * o[6];
              o[8] := o[7] * g.tau;
              o[9] := -7.9449656719138e-6 * o[8];
              o[10] := g.pi * g.pi;
              o[11] := -0.0137828462699730 * o[1];
              g.g := g.pi * ((-0.000125631835895920) + o[4] + g.pi * ((-3.9724828359569e-6 * o[8]) + 1.29192282897840e-7 * o[5] * g.pi)) + ((-0.0248051489334660) + g.tau * (0.36901534980333 + g.tau * ((-3.11613182139250) + g.tau * ((-13.1799836742010) + (6.8540841634434 - 0.32961626538917 * g.tau) * g.tau + Modelica.Math.log(g.pi))))) / o[5];
              g.gpi := (1.0 + g.pi * ((-0.000125631835895920) + o[4] + g.pi * (o[9] + 3.8757684869352e-7 * o[5] * g.pi))) / g.pi;
              g.gpipi := ((-1.00000000000000) + o[10] * (o[9] + 7.7515369738704e-7 * o[5] * g.pi)) / o[10];
              g.gtau := g.pi * (0.00217746787145710 + o[11] + g.pi * ((-0.000035752345523612 * o[7]) + 3.8757684869352e-7 * o[1] * g.pi)) + (0.074415446800398 + g.tau * ((-0.73803069960666) + (3.11613182139250 + o[1] * (6.8540841634434 - 0.65923253077834 * g.tau)) * g.tau)) / o[6];
              g.gtautau := ((-0.297661787201592) + g.tau * (2.21409209881998 + ((-6.2322636427850) - 0.65923253077834 * o[5]) * g.tau)) / (o[6] * g.tau) + g.pi * ((-0.0275656925399460 * g.tau) + g.pi * ((-0.000286018764188897 * o[1] * o[6] * g.tau) + 7.7515369738704e-7 * g.pi * g.tau));
              g.gtaupi := 0.00217746787145710 + o[11] + g.pi * ((-0.000071504691047224 * o[7]) + 1.16273054608056e-6 * o[1] * g.pi);
            end g5;

            function tph1  "Inverse function for region 1: T(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              Real eta1 "Dimensionless specific enthalpy";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              assert(p > triple.ptriple, "IF97 medium function tph1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              pi := p / data.PSTAR2;
              eta1 := h / data.HSTAR1 + 1.0;
              o[1] := eta1 * eta1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              T := (-238.724899245210) - 13.3917448726020 * pi + eta1 * (404.21188637945 + 43.211039183559 * pi + eta1 * (113.497468817180 - 54.010067170506 * pi + eta1 * (30.5358922039160 * pi + eta1 * ((-6.5964749423638 * pi) + o[1] * ((-5.8457616048039) + o[2] * (pi * (0.0093965400878363 + ((-0.0000258586412820730) + 6.6456186191635e-8 * pi) * pi) + o[2] * o[3] * ((-0.000152854824131400) + o[1] * o[3] * ((-1.08667076953770e-6) + pi * (1.15736475053400e-7 + pi * ((-4.0644363084799e-9) + pi * (8.0670734103027e-11 + pi * ((-9.3477771213947e-13) + (5.8265442020601e-15 - 1.50201859535030e-17 * pi) * pi))))))))))));
            end tph1;

            function tps1  "Inverse function for region 1: T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              constant .Modelica.SIunits.Pressure pstar = 1.0e6;
              constant .Modelica.SIunits.SpecificEntropy sstar = 1.0e3;
              Real pi "Dimensionless pressure";
              Real sigma1 "Dimensionless specific entropy";
              Real[6] o "Vector of auxiliary variables";
            algorithm
              pi := p / pstar;
              assert(p > triple.ptriple, "IF97 medium function tps1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              sigma1 := s / sstar + 2.0;
              o[1] := sigma1 * sigma1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              o[4] := o[3] * o[3];
              o[5] := o[4] * o[4];
              o[6] := o[1] * o[2] * o[4];
              T := 174.782680583070 + sigma1 * (34.806930892873 + sigma1 * (6.5292584978455 + (0.33039981775489 + o[3] * ((-1.92813829231960e-7) - 2.49091972445730e-23 * o[2] * o[4])) * sigma1)) + pi * ((-0.261076364893320) + pi * (0.00056608900654837 + pi * (o[1] * o[3] * (2.64004413606890e-13 + 7.8124600459723e-29 * o[6]) - 3.07321999036680e-31 * o[5] * pi) + sigma1 * ((-0.00032635483139717) + sigma1 * (0.000044778286690632 + o[1] * o[2] * ((-5.1322156908507e-10) - 4.2522657042207e-26 * o[6]) * sigma1))) + sigma1 * (0.225929659815860 + sigma1 * ((-0.064256463395226) + sigma1 * (0.0078876289270526 + o[3] * sigma1 * (3.5672110607366e-10 + 1.73324969948950e-24 * o[1] * o[4] * sigma1)))));
            end tps1;

            function tph2  "Reverse function for region 2: T(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              Real pi2b "Dimensionless pressure";
              Real pi2c "Dimensionless pressure";
              Real eta "Dimensionless specific enthalpy";
              Real etabc "Dimensionless specific enthalpy";
              Real eta2a "Dimensionless specific enthalpy";
              Real eta2b "Dimensionless specific enthalpy";
              Real eta2c "Dimensionless specific enthalpy";
              Real[8] o "Vector of auxiliary variables";
            algorithm
              pi := p * data.IPSTAR;
              eta := h * data.IHSTAR;
              etabc := h * 1.0e-3;
              if pi < 4.0 then
                eta2a := eta - 2.1;
                o[1] := eta2a * eta2a;
                o[2] := o[1] * o[1];
                o[3] := pi * pi;
                o[4] := o[3] * o[3];
                o[5] := o[3] * pi;
                T := 1089.89523182880 + (1.84457493557900 - 0.0061707422868339 * pi) * pi + eta2a * (849.51654495535 - 4.1792700549624 * pi + eta2a * ((-107.817480918260) + (6.2478196935812 - 0.310780466295830 * pi) * pi + eta2a * (33.153654801263 - 17.3445631081140 * pi + o[2] * ((-7.4232016790248) + pi * ((-200.581768620960) + 11.6708730771070 * pi) + o[1] * (271.960654737960 * pi + o[1] * ((-455.11318285818 * pi) + eta2a * (1.38657242832260 * o[4] + o[1] * o[2] * (3091.96886047550 * pi + o[1] * (11.7650487243560 + o[2] * ((-13551.3342407750 * o[5]) + o[2] * ((-62.459855192507 * o[3] * o[4] * pi) + o[2] * (o[4] * (235988.325565140 + 7399.9835474766 * pi) + o[1] * (19127.7292396600 * o[3] * o[4] + o[1] * (o[3] * (1.28127984040460e8 - 551966.97030060 * o[5]) + o[1] * ((-9.8554909623276e8 * o[3]) + o[1] * (2.82245469730020e9 * o[3] + o[1] * (o[3] * ((-3.5948971410703e9) + 3.7154085996233e6 * o[5]) + o[1] * pi * (252266.403578720 + pi * (1.72273499131970e9 + pi * (1.28487346646500e7 + ((-1.31052365450540e7) - 415351.64835634 * o[3]) * pi))))))))))))))))))));
              elseif pi < (0.12809002730136e-03 * etabc - 0.67955786399241) * etabc + 0.90584278514723e3 then
                eta2b := eta - 2.6;
                pi2b := pi - 2.0;
                o[1] := pi2b * pi2b;
                o[2] := o[1] * pi2b;
                o[3] := o[1] * o[1];
                o[4] := eta2b * eta2b;
                o[5] := o[4] * o[4];
                o[6] := o[4] * o[5];
                o[7] := o[5] * o[5];
                T := 1489.50410795160 + 0.93747147377932 * pi2b + eta2b * (743.07798314034 + o[2] * (0.000110328317899990 - 1.75652339694070e-18 * o[1] * o[3]) + eta2b * ((-97.708318797837) + pi2b * (3.3593118604916 + pi2b * ((-0.0218107553247610) + pi2b * (0.000189552483879020 + (2.86402374774560e-7 - 8.1456365207833e-14 * o[2]) * pi2b))) + o[5] * (3.3809355601454 * pi2b + o[4] * ((-0.108297844036770 * o[1]) + o[5] * (2.47424647056740 + (0.168445396719040 + o[1] * (0.00308915411605370 - 0.0000107798573575120 * pi2b)) * pi2b + o[6] * ((-0.63281320016026) + pi2b * (0.73875745236695 + ((-0.046333324635812) + o[1] * ((-0.000076462712454814) + 2.82172816350400e-7 * pi2b)) * pi2b) + o[6] * (1.13859521296580 + pi2b * ((-0.47128737436186) + o[1] * (0.00135555045549490 + (0.0000140523928183160 + 1.27049022719450e-6 * pi2b) * pi2b)) + o[5] * ((-0.47811863648625) + (0.150202731397070 + o[2] * ((-0.0000310838143314340) + o[1] * ((-1.10301392389090e-8) - 2.51805456829620e-11 * pi2b))) * pi2b + o[5] * o[7] * (0.0085208123431544 + pi2b * ((-0.00217641142197500) + pi2b * (0.000071280351959551 + o[1] * ((-1.03027382121030e-6) + (7.3803353468292e-8 + 8.6934156344163e-15 * o[3]) * pi2b))))))))))));
              else
                eta2c := eta - 1.8;
                pi2c := pi + 25.0;
                o[1] := pi2c * pi2c;
                o[2] := o[1] * o[1];
                o[3] := o[1] * o[2] * pi2c;
                o[4] := 1 / o[3];
                o[5] := o[1] * o[2];
                o[6] := eta2c * eta2c;
                o[7] := o[2] * o[2];
                o[8] := o[6] * o[6];
                T := eta2c * ((859777.22535580 + o[1] * (482.19755109255 + 1.12615974072300e-12 * o[5])) / o[1] + eta2c * (((-5.8340131851590e11) + (2.08255445631710e10 + 31081.0884227140 * o[2]) * pi2c) / o[5] + o[6] * (o[8] * (o[6] * (1.23245796908320e-7 * o[5] + o[6] * ((-1.16069211309840e-6 * o[5]) + o[8] * (0.0000278463670885540 * o[5] + ((-0.00059270038474176 * o[5]) + 0.00129185829918780 * o[5] * o[6]) * o[8]))) - 10.8429848800770 * pi2c) + o[4] * (7.3263350902181e12 + o[7] * (3.7966001272486 + ((-0.045364172676660) - 1.78049822406860e-11 * o[2]) * pi2c))))) + o[4] * ((-3.2368398555242e12) + pi2c * (3.5825089945447e11 + pi2c * ((-1.07830682174700e10) + o[1] * pi2c * (610747.83564516 + pi2c * ((-25745.7236041700) + (1208.23158659360 + 1.45591156586980e-13 * o[5]) * pi2c)))));
              end if;
            end tph2;

            function tps2a  "Reverse function for region 2a: T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              Real[12] o "Vector of auxiliary variables";
              constant Real IPSTAR = 1.0e-6 "Scaling variable";
              constant Real ISSTAR2A = 1 / 2000.0 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2a "Dimensionless specific entropy";
            algorithm
              pi := p * IPSTAR;
              sigma2a := s * ISSTAR2A - 2.0;
              o[1] := pi ^ 0.5;
              o[2] := sigma2a * sigma2a;
              o[3] := o[2] * o[2];
              o[4] := o[3] * o[3];
              o[5] := o[4] * o[4];
              o[6] := pi ^ 0.25;
              o[7] := o[2] * o[4] * o[5];
              o[8] := 1 / o[7];
              o[9] := o[3] * sigma2a;
              o[10] := o[2] * o[3] * sigma2a;
              o[11] := o[3] * o[4] * sigma2a;
              o[12] := o[2] * sigma2a;
              T := (((-392359.83861984) + (515265.73827270 + o[3] * (40482.443161048 + o[2] * o[3] * ((-321.93790923902) + o[2] * (96.961424218694 - 22.8678463717730 * sigma2a)))) * sigma2a) / (o[4] * o[5]) + o[6] * (((-449429.14124357) + o[3] * ((-5011.8336020166) + 0.35684463560015 * o[4] * sigma2a)) / (o[2] * o[5] * sigma2a) + o[6] * (o[8] * (44235.335848190 + o[9] * ((-13673.3888117080) + o[3] * (421632.60207864 + (22516.9258374750 + o[10] * (474.42144865646 - 149.311307976470 * sigma2a)) * sigma2a))) + o[6] * (((-197811.263204520) - 23554.3994707600 * sigma2a) / (o[2] * o[3] * o[4] * sigma2a) + o[6] * (((-19070.6163020760) + o[11] * (55375.669883164 + (3829.3691437363 - 603.91860580567 * o[2]) * o[3])) * o[8] + o[6] * ((1936.31026203310 + o[2] * (4266.0643698610 + o[2] * o[3] * o[4] * ((-5978.0638872718) - 704.01463926862 * o[9]))) / (o[2] * o[4] * o[5] * sigma2a) + o[1] * ((338.36784107553 + o[12] * (20.8627866351870 + (0.033834172656196 - 0.000043124428414893 * o[12]) * o[3])) * sigma2a + o[6] * (166.537913564120 + sigma2a * ((-139.862920558980) + o[3] * ((-0.78849547999872) + (0.072132411753872 + o[3] * ((-0.0059754839398283) + ((-0.0000121413589539040) + 2.32270967338710e-7 * o[2]) * o[3])) * sigma2a)) + o[6] * ((-10.5384635661940) + o[3] * (2.07189254965020 + ((-0.072193155260427) + 2.07498870811200e-7 * o[4]) * o[9]) + o[6] * (o[6] * (o[12] * (0.210375278936190 + 0.000256812397299990 * o[3] * o[4]) + ((-0.0127990029337810) - 8.2198102652018e-6 * o[11]) * o[6] * o[9]) + o[10] * ((-0.0183406579113790) + 2.90362723486960e-7 * o[2] * o[4] * sigma2a))))))))))) / (o[1] * pi);
            end tps2a;

            function tps2b  "Reverse function for region 2b: T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              Real[8] o "Vector of auxiliary variables";
              constant Real IPSTAR = 1.0e-6 "Scaling variable";
              constant Real ISSTAR2B = 1 / 785.3 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2b "Dimensionless specific entropy";
            algorithm
              pi := p * IPSTAR;
              sigma2b := 10.0 - s * ISSTAR2B;
              o[1] := pi * pi;
              o[2] := o[1] * o[1];
              o[3] := sigma2b * sigma2b;
              o[4] := o[3] * o[3];
              o[5] := o[4] * o[4];
              o[6] := o[3] * o[5] * sigma2b;
              o[7] := o[3] * o[5];
              o[8] := o[3] * sigma2b;
              T := (316876.65083497 + 20.8641758818580 * o[6] + pi * ((-398593.99803599) - 21.8160585188770 * o[6] + pi * (223697.851942420 + ((-2784.17034458170) + 9.9207436071480 * o[7]) * sigma2b + pi * ((-75197.512299157) + (2970.86059511580 + o[7] * ((-3.4406878548526) + 0.38815564249115 * sigma2b)) * sigma2b + pi * (17511.2950857500 + sigma2b * ((-1423.71128544490) + (1.09438033641670 + 0.89971619308495 * o[4]) * o[4] * sigma2b) + pi * ((-3375.9740098958) + (471.62885818355 + o[4] * ((-1.91882419936790) + o[8] * (0.41078580492196 - 0.33465378172097 * sigma2b))) * sigma2b + pi * (1387.00347775050 + sigma2b * ((-406.63326195838) + sigma2b * (41.727347159610 + o[3] * (2.19325494345320 + sigma2b * ((-1.03200500090770) + (0.35882943516703 + 0.0052511453726066 * o[8]) * sigma2b)))) + pi * (12.8389164507050 + sigma2b * ((-2.86424372193810) + sigma2b * (0.56912683664855 + ((-0.099962954584931) + o[4] * ((-0.0032632037778459) + 0.000233209225767230 * sigma2b)) * sigma2b)) + pi * ((-0.153348098574500) + (0.0290722882399020 + 0.00037534702741167 * o[4]) * sigma2b + pi * (0.00172966917024110 + ((-0.00038556050844504) - 0.000035017712292608 * o[3]) * sigma2b + pi * ((-0.0000145663936314920) + 5.6420857267269e-6 * sigma2b + pi * (4.1286150074605e-8 + ((-2.06846711188240e-8) + 1.64093936747250e-9 * sigma2b) * sigma2b)))))))))))) / (o[1] * o[2]);
            end tps2b;

            function tps2c  "Reverse function for region 2c: T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              constant Real IPSTAR = 1.0e-6 "Scaling variable";
              constant Real ISSTAR2C = 1 / 2925.1 "Scaling variable";
              Real pi "Dimensionless pressure";
              Real sigma2c "Dimensionless specific entropy";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              pi := p * IPSTAR;
              sigma2c := 2.0 - s * ISSTAR2C;
              o[1] := pi * pi;
              o[2] := sigma2c * sigma2c;
              o[3] := o[2] * o[2];
              T := (909.68501005365 + 2404.56670884200 * sigma2c + pi * ((-591.62326387130) + pi * (541.45404128074 + sigma2c * ((-270.983084111920) + (979.76525097926 - 469.66772959435 * sigma2c) * sigma2c) + pi * (14.3992746047230 + ((-19.1042042304290) + o[2] * (5.3299167111971 - 21.2529753759340 * sigma2c)) * sigma2c + pi * ((-0.311473344137600) + (0.60334840894623 - 0.042764839702509 * sigma2c) * sigma2c + pi * (0.0058185597255259 + ((-0.0145970082847530) + 0.0056631175631027 * o[3]) * sigma2c + pi * ((-0.000076155864584577) + sigma2c * (0.000224403429193320 - 0.0000125610950134130 * o[2] * sigma2c) + pi * (6.3323132660934e-7 + ((-2.05419896753750e-6) + 3.6405370390082e-8 * sigma2c) * sigma2c + pi * ((-2.97598977892150e-9) + 1.01366185297630e-8 * sigma2c + pi * (5.9925719692351e-12 + sigma2c * ((-2.06778701051640e-11) + o[2] * ((-2.08742781818860e-11) + (1.01621668250890e-10 - 1.64298282813470e-10 * sigma2c) * sigma2c)))))))))))) / o[1];
            end tps2c;

            function tps2  "Reverse function for region 2: T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
            protected
              Real pi "Dimensionless pressure";
              constant .Modelica.SIunits.SpecificEntropy SLIMIT = 5.85e3 "Subregion boundary specific entropy between regions 2a and 2b";
            algorithm
              if p < 4.0e6 then
                T := tps2a(p, s);
              elseif s > SLIMIT then
                T := tps2b(p, s);
              else
                T := tps2c(p, s);
              end if;
            end tps2;

            function tsat  "Region 4 saturation temperature as a function of pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Temperature t_sat "Temperature";
            protected
              Real pi "Dimensionless pressure";
              Real[20] o "Vector of auxiliary variables";
            algorithm
              assert(p > triple.ptriple, "IF97 medium function tsat called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              pi := min(p, data.PCRIT) * data.IPSTAR;
              o[1] := pi ^ 0.25;
              o[2] := -3.2325550322333e6 * o[1];
              o[3] := pi ^ 0.5;
              o[4] := -724213.16703206 * o[3];
              o[5] := 405113.40542057 + o[2] + o[4];
              o[6] := -17.0738469400920 * o[1];
              o[7] := 14.9151086135300 + o[3] + o[6];
              o[8] := -4.0 * o[5] * o[7];
              o[9] := 12020.8247024700 * o[1];
              o[10] := 1167.05214527670 * o[3];
              o[11] := (-4823.2657361591) + o[10] + o[9];
              o[12] := o[11] * o[11];
              o[13] := o[12] + o[8];
              o[14] := o[13] ^ 0.5;
              o[15] := -o[14];
              o[16] := -12020.8247024700 * o[1];
              o[17] := -1167.05214527670 * o[3];
              o[18] := 4823.2657361591 + o[15] + o[16] + o[17];
              o[19] := 1 / o[18];
              o[20] := 2.0 * o[19] * o[5];
              t_sat := 0.5 * (650.17534844798 + o[20] - ((-4.0 * ((-0.238555575678490) + 1300.35069689596 * o[19] * o[5])) + (650.17534844798 + o[20]) ^ 2.0) ^ 0.5);
              annotation(derivative = tsat_der); 
            end tsat;

            function dtsatofp  "Derivative of saturation temperature w.r.t. pressure" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output Real dtsat(unit = "K/Pa") "Derivative of T w.r.t. p";
            protected
              Real pi "Dimensionless pressure";
              Real[49] o "Vector of auxiliary variables";
            algorithm
              pi := max(Modelica.Constants.small, p * data.IPSTAR);
              o[1] := pi ^ 0.75;
              o[2] := 1 / o[1];
              o[3] := -4.268461735023 * o[2];
              o[4] := sqrt(pi);
              o[5] := 1 / o[4];
              o[6] := 0.5 * o[5];
              o[7] := o[3] + o[6];
              o[8] := pi ^ 0.25;
              o[9] := -3.2325550322333e6 * o[8];
              o[10] := -724213.16703206 * o[4];
              o[11] := 405113.40542057 + o[10] + o[9];
              o[12] := -4 * o[11] * o[7];
              o[13] := -808138.758058325 * o[2];
              o[14] := -362106.58351603 * o[5];
              o[15] := o[13] + o[14];
              o[16] := -17.073846940092 * o[8];
              o[17] := 14.91510861353 + o[16] + o[4];
              o[18] := -4 * o[15] * o[17];
              o[19] := 3005.2061756175 * o[2];
              o[20] := 583.52607263835 * o[5];
              o[21] := o[19] + o[20];
              o[22] := 12020.82470247 * o[8];
              o[23] := 1167.0521452767 * o[4];
              o[24] := (-4823.2657361591) + o[22] + o[23];
              o[25] := 2.0 * o[21] * o[24];
              o[26] := o[12] + o[18] + o[25];
              o[27] := -4.0 * o[11] * o[17];
              o[28] := o[24] * o[24];
              o[29] := o[27] + o[28];
              o[30] := sqrt(o[29]);
              o[31] := 1 / o[30];
              o[32] := -o[30];
              o[33] := -12020.82470247 * o[8];
              o[34] := -1167.0521452767 * o[4];
              o[35] := 4823.2657361591 + o[32] + o[33] + o[34];
              o[36] := o[30];
              o[37] := (-4823.2657361591) + o[22] + o[23] + o[36];
              o[38] := o[37] * o[37];
              o[39] := 1 / o[38];
              o[40] := -1.72207339365771 * o[30];
              o[41] := 21592.2055343628 * o[8];
              o[42] := o[30] * o[8];
              o[43] := -8192.87114842946 * o[4];
              o[44] := -0.510632954559659 * o[30] * o[4];
              o[45] := -3100.02526152368 * o[1];
              o[46] := pi;
              o[47] := 1295.95640782102 * o[46];
              o[48] := 2862.09212505088 + o[40] + o[41] + o[42] + o[43] + o[44] + o[45] + o[47];
              o[49] := 1 / (o[35] * o[35]);
              dtsat := data.IPSTAR * 0.5 * (2.0 * o[15] / o[35] - 2. * o[11] * ((-3005.2061756175 * o[2]) - 0.5 * o[26] * o[31] - 583.52607263835 * o[5]) * o[49] - 20953.46356643991 * (o[39] * (1295.95640782102 + 5398.05138359071 * o[2] + 0.25 * o[2] * o[30] - 0.861036696828853 * o[26] * o[31] - 0.255316477279829 * o[26] * o[31] * o[4] - 4096.43557421473 * o[5] - 0.255316477279829 * o[30] * o[5] - 2325.01894614276 / o[8] + 0.5 * o[26] * o[31] * o[8]) - 2.0 * (o[19] + o[20] + 0.5 * o[26] * o[31]) * o[48] * o[37] ^ (-3)) / sqrt(o[39] * o[48]));
            end dtsatofp;

            function tsat_der  "Derivative function for tsat" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input Real der_p(unit = "Pa/s") "Pressure derivative";
              output Real der_tsat(unit = "K/s") "Temperature derivative";
            protected
              Real dtp;
            algorithm
              dtp := dtsatofp(p);
              der_tsat := dtp * der_p;
            end tsat_der;

            function psat  "Region 4 saturation pressure as a function of temperature" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.Pressure p_sat "Pressure";
            protected
              Real[8] o "Vector of auxiliary variables";
              Real Tlim = min(T, data.TCRIT);
            algorithm
              assert(T >= 273.16, "IF97 medium function psat: input temperature (= " + String(triple.ptriple) + " K).\n" + "lower than the triple point temperature 273.16 K");
              o[1] := (-650.17534844798) + Tlim;
              o[2] := 1 / o[1];
              o[3] := -0.238555575678490 * o[2];
              o[4] := o[3] + Tlim;
              o[5] := -4823.2657361591 * o[4];
              o[6] := o[4] * o[4];
              o[7] := 14.9151086135300 * o[6];
              o[8] := 405113.40542057 + o[5] + o[7];
              p_sat := 16.0e6 * o[8] * o[8] * o[8] * o[8] * 1 / (3.2325550322333e6 - 12020.8247024700 * o[4] + 17.0738469400920 * o[6] + ((-4.0 * ((-724213.16703206) + 1167.05214527670 * o[4] + o[6]) * o[8]) + ((-3.2325550322333e6) + 12020.8247024700 * o[4] - 17.0738469400920 * o[6]) ^ 2.0) ^ 0.5) ^ 4.0;
              annotation(derivative = psat_der); 
            end psat;

            function dptofT  "Derivative of pressure w.r.t. temperature along the saturation pressure curve" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output Real dpt(unit = "Pa/K") "Temperature derivative of pressure";
            protected
              Real[31] o "Vector of auxiliary variables";
              Real Tlim "Temperature limited to TCRIT";
            algorithm
              Tlim := min(T, data.TCRIT);
              o[1] := (-650.17534844798) + Tlim;
              o[2] := 1 / o[1];
              o[3] := -0.238555575678490 * o[2];
              o[4] := o[3] + Tlim;
              o[5] := -4823.2657361591 * o[4];
              o[6] := o[4] * o[4];
              o[7] := 14.9151086135300 * o[6];
              o[8] := 405113.40542057 + o[5] + o[7];
              o[9] := o[8] * o[8];
              o[10] := o[9] * o[9];
              o[11] := o[1] * o[1];
              o[12] := 1 / o[11];
              o[13] := 0.238555575678490 * o[12];
              o[14] := 1.00000000000000 + o[13];
              o[15] := 12020.8247024700 * o[4];
              o[16] := -17.0738469400920 * o[6];
              o[17] := (-3.2325550322333e6) + o[15] + o[16];
              o[18] := -4823.2657361591 * o[14];
              o[19] := 29.8302172270600 * o[14] * o[4];
              o[20] := o[18] + o[19];
              o[21] := 1167.05214527670 * o[4];
              o[22] := (-724213.16703206) + o[21] + o[6];
              o[23] := o[17] * o[17];
              o[24] := -4.0000000000000 * o[22] * o[8];
              o[25] := o[23] + o[24];
              o[26] := sqrt(o[25]);
              o[27] := -12020.8247024700 * o[4];
              o[28] := 17.0738469400920 * o[6];
              o[29] := 3.2325550322333e6 + o[26] + o[27] + o[28];
              o[30] := o[29] * o[29];
              o[31] := o[30] * o[30];
              dpt := 1e6 * ((-64.0 * o[10] * ((-12020.8247024700 * o[14]) + 34.147693880184 * o[14] * o[4] + 0.5 * ((-4.0 * o[20] * o[22]) + 2.00000000000000 * o[17] * (12020.8247024700 * o[14] - 34.147693880184 * o[14] * o[4]) - 4.0 * (1167.05214527670 * o[14] + 2.0 * o[14] * o[4]) * o[8]) / o[26])) / (o[29] * o[31]) + 64. * o[20] * o[8] * o[9] / o[31]);
            end dptofT;

            function psat_der  "Derivative function for psat" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input Real der_T(unit = "K/s") "Temperature derivative";
              output Real der_psat(unit = "Pa/s") "Pressure";
            protected
              Real dpt;
            algorithm
              dpt := dptofT(T);
              der_psat := dpt * der_T;
            end psat_der;

            function h3ab_p  "Region 3 a b boundary for pressure/enthalpy" 
              extends Modelica.Icons.Function;
              output .Modelica.SIunits.SpecificEnthalpy h "Enthalpy";
              input .Modelica.SIunits.Pressure p "Pressure";
            protected
              constant Real[:] n = {0.201464004206875e4, 0.374696550136983e1, -0.219921901054187e-1, 0.875131686009950e-4};
              constant .Modelica.SIunits.SpecificEnthalpy hstar = 1000 "Normalization enthalpy";
              constant .Modelica.SIunits.Pressure pstar = 1e6 "Normalization pressure";
              Real pi = p / pstar "Normalized specific pressure";
            algorithm
              h := (n[1] + n[2] * pi + n[3] * pi ^ 2 + n[4] * pi ^ 3) * hstar;
            end h3ab_p;

            function T3a_ph  "Region 3 a: inverse function T(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.Temp_K T "Temperature";
            protected
              constant Real[:] n = {-0.133645667811215e-6, 0.455912656802978e-5, -0.146294640700979e-4, 0.639341312970080e-2, 0.372783927268847e3, -0.718654377460447e4, 0.573494752103400e6, -0.267569329111439e7, -0.334066283302614e-4, -0.245479214069597e-1, 0.478087847764996e2, 0.764664131818904e-5, 0.128350627676972e-2, 0.171219081377331e-1, -0.851007304583213e1, -0.136513461629781e-1, -0.384460997596657e-5, 0.337423807911655e-2, -0.551624873066791, 0.729202277107470, -0.992522757376041e-2, -0.119308831407288, 0.793929190615421, 0.454270731799386, 0.209998591259910, -0.642109823904738e-2, -0.235155868604540e-1, 0.252233108341612e-2, -0.764885133368119e-2, 0.136176427574291e-1, -0.133027883575669e-1};
              constant Real[:] I = {-12, -12, -12, -12, -12, -12, -12, -12, -10, -10, -10, -8, -8, -8, -8, -5, -3, -2, -2, -2, -1, -1, 0, 0, 1, 3, 3, 4, 4, 10, 12};
              constant Real[:] J = {0, 1, 2, 6, 14, 16, 20, 22, 1, 5, 12, 0, 2, 4, 10, 2, 0, 1, 3, 4, 0, 2, 0, 1, 1, 0, 1, 0, 3, 4, 5};
              constant .Modelica.SIunits.SpecificEnthalpy hstar = 2300e3 "Normalization enthalpy";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.Temp_K Tstar = 760 "Normalization temperature";
              Real pi = p / pstar "Normalized specific pressure";
              Real eta = h / hstar "Normalized specific enthalpy";
            algorithm
              T := sum(n[i] * (pi + 0.240) ^ I[i] * (eta - 0.615) ^ J[i] for i in 1:31) * Tstar;
            end T3a_ph;

            function T3b_ph  "Region 3 b: inverse function T(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.Temp_K T "Temperature";
            protected
              constant Real[:] n = {0.323254573644920e-4, -0.127575556587181e-3, -0.475851877356068e-3, 0.156183014181602e-2, 0.105724860113781, -0.858514221132534e2, 0.724140095480911e3, 0.296475810273257e-2, -0.592721983365988e-2, -0.126305422818666e-1, -0.115716196364853, 0.849000969739595e2, -0.108602260086615e-1, 0.154304475328851e-1, 0.750455441524466e-1, 0.252520973612982e-1, -0.602507901232996e-1, -0.307622221350501e1, -0.574011959864879e-1, 0.503471360939849e1, -0.925081888584834, 0.391733882917546e1, -0.773146007130190e2, 0.949308762098587e4, -0.141043719679409e7, 0.849166230819026e7, 0.861095729446704, 0.323346442811720, 0.873281936020439, -0.436653048526683, 0.286596714529479, -0.131778331276228, 0.676682064330275e-2};
              constant Real[:] I = {-12, -12, -10, -10, -10, -10, -10, -8, -8, -8, -8, -8, -6, -6, -6, -4, -4, -3, -2, -2, -1, -1, -1, -1, -1, -1, 0, 0, 1, 3, 5, 6, 8};
              constant Real[:] J = {0, 1, 0, 1, 5, 10, 12, 0, 1, 2, 4, 10, 0, 1, 2, 0, 1, 5, 0, 4, 2, 4, 6, 10, 14, 16, 0, 2, 1, 1, 1, 1, 1};
              constant .Modelica.SIunits.Temp_K Tstar = 860 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEnthalpy hstar = 2800e3 "Normalization enthalpy";
              Real pi = p / pstar "Normalized specific pressure";
              Real eta = h / hstar "Normalized specific enthalpy";
            algorithm
              T := sum(n[i] * (pi + 0.298) ^ I[i] * (eta - 0.720) ^ J[i] for i in 1:33) * Tstar;
            end T3b_ph;

            function v3a_ph  "Region 3 a: inverse function v(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n = {0.529944062966028e-2, -0.170099690234461, 0.111323814312927e2, -0.217898123145125e4, -0.506061827980875e-3, 0.556495239685324, -0.943672726094016e1, -0.297856807561527, 0.939353943717186e2, 0.192944939465981e-1, 0.421740664704763, -0.368914126282330e7, -0.737566847600639e-2, -0.354753242424366, -0.199768169338727e1, 0.115456297059049e1, 0.568366875815960e4, 0.808169540124668e-2, 0.172416341519307, 0.104270175292927e1, -0.297691372792847, 0.560394465163593, 0.275234661176914, -0.148347894866012, -0.651142513478515e-1, -0.292468715386302e1, 0.664876096952665e-1, 0.352335014263844e1, -0.146340792313332e-1, -0.224503486668184e1, 0.110533464706142e1, -0.408757344495612e-1};
              constant Real[:] I = {-12, -12, -12, -12, -10, -10, -10, -8, -8, -6, -6, -6, -4, -4, -3, -2, -2, -1, -1, -1, -1, 0, 0, 1, 1, 1, 2, 2, 3, 4, 5, 8};
              constant Real[:] J = {6, 8, 12, 18, 4, 7, 10, 5, 12, 3, 4, 22, 2, 3, 7, 3, 16, 0, 1, 2, 3, 0, 1, 0, 1, 2, 0, 2, 0, 2, 2, 2};
              constant .Modelica.SIunits.Volume vstar = 0.0028 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEnthalpy hstar = 2100e3 "Normalization enthalpy";
              Real pi = p / pstar "Normalized specific pressure";
              Real eta = h / hstar "Normalized specific enthalpy";
            algorithm
              v := sum(n[i] * (pi + 0.128) ^ I[i] * (eta - 0.727) ^ J[i] for i in 1:32) * vstar;
            end v3a_ph;

            function v3b_ph  "Region 3 b: inverse function v(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n = {-0.225196934336318e-8, 0.140674363313486e-7, 0.233784085280560e-5, -0.331833715229001e-4, 0.107956778514318e-2, -0.271382067378863, 0.107202262490333e1, -0.853821329075382, -0.215214194340526e-4, 0.769656088222730e-3, -0.431136580433864e-2, 0.453342167309331, -0.507749535873652, -0.100475154528389e3, -0.219201924648793, -0.321087965668917e1, 0.607567815637771e3, 0.557686450685932e-3, 0.187499040029550, 0.905368030448107e-2, 0.285417173048685, 0.329924030996098e-1, 0.239897419685483, 0.482754995951394e1, -0.118035753702231e2, 0.169490044091791, -0.179967222507787e-1, 0.371810116332674e-1, -0.536288335065096e-1, 0.160697101092520e1};
              constant Real[:] I = {-12, -12, -8, -8, -8, -8, -8, -8, -6, -6, -6, -6, -6, -6, -4, -4, -4, -3, -3, -2, -2, -1, -1, -1, -1, 0, 1, 1, 2, 2};
              constant Real[:] J = {0, 1, 0, 1, 3, 6, 7, 8, 0, 1, 2, 5, 6, 10, 3, 6, 10, 0, 2, 1, 2, 0, 1, 4, 5, 0, 0, 1, 2, 6};
              constant .Modelica.SIunits.Volume vstar = 0.0088 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEnthalpy hstar = 2800e3 "Normalization enthalpy";
              Real pi = p / pstar "Normalized specific pressure";
              Real eta = h / hstar "Normalized specific enthalpy";
            algorithm
              v := sum(n[i] * (pi + 0.0661) ^ I[i] * (eta - 0.720) ^ J[i] for i in 1:30) * vstar;
            end v3b_ph;

            function T3a_ps  "Region 3 a: inverse function T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temp_K T "Temperature";
            protected
              constant Real[:] n = {0.150042008263875e10, -0.159397258480424e12, 0.502181140217975e-3, -0.672057767855466e2, 0.145058545404456e4, -0.823889534888890e4, -0.154852214233853, 0.112305046746695e2, -0.297000213482822e2, 0.438565132635495e11, 0.137837838635464e-2, -0.297478527157462e1, 0.971777947349413e13, -0.571527767052398e-4, 0.288307949778420e5, -0.744428289262703e14, 0.128017324848921e2, -0.368275545889071e3, 0.664768904779177e16, 0.449359251958880e-1, -0.422897836099655e1, -0.240614376434179, -0.474341365254924e1, 0.724093999126110, 0.923874349695897, 0.399043655281015e1, 0.384066651868009e-1, -0.359344365571848e-2, -0.735196448821653, 0.188367048396131, 0.141064266818704e-3, -0.257418501496337e-2, 0.123220024851555e-2};
              constant Real[:] I = {-12, -12, -10, -10, -10, -10, -8, -8, -8, -8, -6, -6, -6, -5, -5, -5, -4, -4, -4, -2, -2, -1, -1, 0, 0, 0, 1, 2, 2, 3, 8, 8, 10};
              constant Real[:] J = {28, 32, 4, 10, 12, 14, 5, 7, 8, 28, 2, 6, 32, 0, 14, 32, 6, 10, 36, 1, 4, 1, 6, 0, 1, 4, 0, 0, 3, 2, 0, 1, 2};
              constant .Modelica.SIunits.Temp_K Tstar = 760 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEntropy sstar = 4.4e3 "Normalization entropy";
              Real pi = p / pstar "Normalized specific pressure";
              Real sigma = s / sstar "Normalized specific entropy";
            algorithm
              T := sum(n[i] * (pi + 0.240) ^ I[i] * (sigma - 0.703) ^ J[i] for i in 1:33) * Tstar;
            end T3a_ps;

            function T3b_ps  "Region 3 b: inverse function T(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.Temp_K T "Temperature";
            protected
              constant Real[:] n = {0.527111701601660, -0.401317830052742e2, 0.153020073134484e3, -0.224799398218827e4, -0.193993484669048, -0.140467557893768e1, 0.426799878114024e2, 0.752810643416743, 0.226657238616417e2, -0.622873556909932e3, -0.660823667935396, 0.841267087271658, -0.253717501764397e2, 0.485708963532948e3, 0.880531517490555e3, 0.265015592794626e7, -0.359287150025783, -0.656991567673753e3, 0.241768149185367e1, 0.856873461222588, 0.655143675313458, -0.213535213206406, 0.562974957606348e-2, -0.316955725450471e15, -0.699997000152457e-3, 0.119845803210767e-1, 0.193848122022095e-4, -0.215095749182309e-4};
              constant Real[:] I = {-12, -12, -12, -12, -8, -8, -8, -6, -6, -6, -5, -5, -5, -5, -5, -4, -3, -3, -2, 0, 2, 3, 4, 5, 6, 8, 12, 14};
              constant Real[:] J = {1, 3, 4, 7, 0, 1, 3, 0, 2, 4, 0, 1, 2, 4, 6, 12, 1, 6, 2, 0, 1, 1, 0, 24, 0, 3, 1, 2};
              constant .Modelica.SIunits.Temp_K Tstar = 860 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEntropy sstar = 5.3e3 "Normalization entropy";
              Real pi = p / pstar "Normalized specific pressure";
              Real sigma = s / sstar "Normalized specific entropy";
            algorithm
              T := sum(n[i] * (pi + 0.760) ^ I[i] * (sigma - 0.818) ^ J[i] for i in 1:28) * Tstar;
            end T3b_ps;

            function v3a_ps  "Region 3 a: inverse function v(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n = {0.795544074093975e2, -0.238261242984590e4, 0.176813100617787e5, -0.110524727080379e-2, -0.153213833655326e2, 0.297544599376982e3, -0.350315206871242e8, 0.277513761062119, -0.523964271036888, -0.148011182995403e6, 0.160014899374266e7, 0.170802322663427e13, 0.246866996006494e-3, 0.165326084797980e1, -0.118008384666987, 0.253798642355900e1, 0.965127704669424, -0.282172420532826e2, 0.203224612353823, 0.110648186063513e1, 0.526127948451280, 0.277000018736321, 0.108153340501132e1, -0.744127885357893e-1, 0.164094443541384e-1, -0.680468275301065e-1, 0.257988576101640e-1, -0.145749861944416e-3};
              constant Real[:] I = {-12, -12, -12, -10, -10, -10, -10, -8, -8, -8, -8, -6, -5, -4, -3, -3, -2, -2, -1, -1, 0, 0, 0, 1, 2, 4, 5, 6};
              constant Real[:] J = {10, 12, 14, 4, 8, 10, 20, 5, 6, 14, 16, 28, 1, 5, 2, 4, 3, 8, 1, 2, 0, 1, 3, 0, 0, 2, 2, 0};
              constant .Modelica.SIunits.Volume vstar = 0.0028 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEntropy sstar = 4.4e3 "Normalization entropy";
              Real pi = p / pstar "Normalized specific pressure";
              Real sigma = s / sstar "Normalized specific entropy";
            algorithm
              v := sum(n[i] * (pi + 0.187) ^ I[i] * (sigma - 0.755) ^ J[i] for i in 1:28) * vstar;
            end v3a_ps;

            function v3b_ps  "Region 3 b: inverse function v(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              output .Modelica.SIunits.SpecificVolume v "Specific volume";
            protected
              constant Real[:] n = {0.591599780322238e-4, -0.185465997137856e-2, 0.104190510480013e-1, 0.598647302038590e-2, -0.771391189901699, 0.172549765557036e1, -0.467076079846526e-3, 0.134533823384439e-1, -0.808094336805495e-1, 0.508139374365767, 0.128584643361683e-2, -0.163899353915435e1, 0.586938199318063e1, -0.292466667918613e1, -0.614076301499537e-2, 0.576199014049172e1, -0.121613320606788e2, 0.167637540957944e1, -0.744135838773463e1, 0.378168091437659e-1, 0.401432203027688e1, 0.160279837479185e2, 0.317848779347728e1, -0.358362310304853e1, -0.115995260446827e7, 0.199256573577909, -0.122270624794624, -0.191449143716586e2, -0.150448002905284e-1, 0.146407900162154e2, -0.327477787188230e1};
              constant Real[:] I = {-12, -12, -12, -12, -12, -12, -10, -10, -10, -10, -8, -5, -5, -5, -4, -4, -4, -4, -3, -2, -2, -2, -2, -2, -2, 0, 0, 0, 1, 1, 2};
              constant Real[:] J = {0, 1, 2, 3, 5, 6, 0, 1, 2, 4, 0, 1, 2, 3, 0, 1, 2, 3, 1, 0, 1, 2, 3, 4, 12, 0, 1, 2, 0, 2, 2};
              constant .Modelica.SIunits.Volume vstar = 0.0088 "Normalization temperature";
              constant .Modelica.SIunits.Pressure pstar = 100e6 "Normalization pressure";
              constant .Modelica.SIunits.SpecificEntropy sstar = 5.3e3 "Normalization entropy";
              Real pi = p / pstar "Normalized specific pressure";
              Real sigma = s / sstar "Normalized specific entropy";
            algorithm
              v := sum(n[i] * (pi + 0.298) ^ I[i] * (sigma - 0.816) ^ J[i] for i in 1:31) * vstar;
            end v3b_ps;
          end Basic;

          package Transport  "Transport properties for water according to IAPWS/IF97" 
            extends Modelica.Icons.Package;

            function visc_dTp  "Dynamic viscosity eta(d,T,p), industrial formulation" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density d "Density";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input .Modelica.SIunits.Pressure p "Pressure (only needed for region of validity)";
              input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
              output .Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";
            protected
              constant Real n0 = 1.0 "Viscosity coefficient";
              constant Real n1 = 0.978197 "Viscosity coefficient";
              constant Real n2 = 0.579829 "Viscosity coefficient";
              constant Real n3 = -0.202354 "Viscosity coefficient";
              constant Real[42] nn = array(0.5132047, 0.3205656, 0.0, 0.0, -0.7782567, 0.1885447, 0.2151778, 0.7317883, 1.241044, 1.476783, 0.0, 0.0, -0.2818107, -1.070786, -1.263184, 0.0, 0.0, 0.0, 0.1778064, 0.460504, 0.2340379, -0.4924179, 0.0, 0.0, -0.0417661, 0.0, 0.0, 0.1600435, 0.0, 0.0, 0.0, -0.01578386, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.003629481, 0.0, 0.0) "Viscosity coefficients";
              constant .Modelica.SIunits.Density rhostar = 317.763 "Scaling density";
              constant .Modelica.SIunits.DynamicViscosity etastar = 55.071e-6 "Scaling viscosity";
              constant .Modelica.SIunits.Temperature tstar = 647.226 "Scaling temperature";
              Integer i "Auxiliary variable";
              Integer j "Auxiliary variable";
              Real delta "Dimensionless density";
              Real deltam1 "Dimensionless density";
              Real tau "Dimensionless temperature";
              Real taum1 "Dimensionless temperature";
              Real Psi0 "Auxiliary variable";
              Real Psi1 "Auxiliary variable";
              Real tfun "Auxiliary variable";
              Real rhofun "Auxiliary variable";
              Real Tc = T - 273.15 "Celsius temperature for region check";
            algorithm
              delta := d / rhostar;
              assert(d > triple.dvtriple, "IF97 medium function visc_dTp for viscosity called with too low density\n" + "d = " + String(d) + " <= " + String(triple.dvtriple) + " (triple point density)");
              assert(p <= 500e6 and Tc >= 0.0 and Tc <= 150 or p <= 350e6 and Tc > 150.0 and Tc <= 600 or p <= 300e6 and Tc > 600.0 and Tc <= 900, "IF97 medium function visc_dTp: viscosity computed outside the range\n" + "of validity of the IF97 formulation: p = " + String(p) + " Pa, Tc = " + String(Tc) + " K");
              deltam1 := delta - 1.0;
              tau := tstar / T;
              taum1 := tau - 1.0;
              Psi0 := 1 / (n0 + (n1 + (n2 + n3 * tau) * tau) * tau) / tau ^ 0.5;
              Psi1 := 0.0;
              tfun := 1.0;
              for i in 1:6 loop
                if i <> 1 then
                  tfun := tfun * taum1;
                else
                end if;
                rhofun := 1.;
                for j in 0:6 loop
                  if j <> 0 then
                    rhofun := rhofun * deltam1;
                  else
                  end if;
                  Psi1 := Psi1 + nn[i + j * 6] * tfun * rhofun;
                end for;
              end for;
              eta := etastar * Psi0 * Modelica.Math.exp(delta * Psi1);
            end visc_dTp;

            function cond_dTp  "Thermal conductivity lam(d,T,p) (industrial use version) only in one-phase region" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density d "Density";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input .Modelica.SIunits.Pressure p "Pressure";
              input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
              input Boolean industrialMethod = true "If true, the industrial method is used, otherwise the scientific one";
              output .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
            protected
              Integer region(min = 1, max = 5) "IF97 region, valid values:1,2,3, and 5";
              constant Real n0 = 1.0 "Conductivity coefficient";
              constant Real n1 = 6.978267 "Conductivity coefficient";
              constant Real n2 = 2.599096 "Conductivity coefficient";
              constant Real n3 = -0.998254 "Conductivity coefficient";
              constant Real[30] nn = array(1.3293046, 1.7018363, 5.2246158, 8.7127675, -1.8525999, -0.40452437, -2.2156845, -10.124111, -9.5000611, 0.9340469, 0.2440949, 1.6511057, 4.9874687, 4.3786606, 0.0, 0.018660751, -0.76736002, -0.27297694, -0.91783782, 0.0, -0.12961068, 0.37283344, -0.43083393, 0.0, 0.0, 0.044809953, -0.1120316, 0.13333849, 0.0, 0.0) "Conductivity coefficient";
              constant .Modelica.SIunits.ThermalConductivity lamstar = 0.4945 "Scaling conductivity";
              constant .Modelica.SIunits.Density rhostar = 317.763 "Scaling density";
              constant .Modelica.SIunits.Temperature tstar = 647.226 "Scaling temperature";
              constant .Modelica.SIunits.Pressure pstar = 22.115e6 "Scaling pressure";
              constant .Modelica.SIunits.DynamicViscosity etastar = 55.071e-6 "Scaling viscosity";
              Integer i "Auxiliary variable";
              Integer j "Auxiliary variable";
              Real delta "Dimensionless density";
              Real tau "Dimensionless temperature";
              Real deltam1 "Dimensionless density";
              Real taum1 "Dimensionless temperature";
              Real Lam0 "Part of thermal conductivity";
              Real Lam1 "Part of thermal conductivity";
              Real Lam2 "Part of thermal conductivity";
              Real tfun "Auxiliary variable";
              Real rhofun "Auxiliary variable";
              Real dpitau "Auxiliary variable";
              Real ddelpi "Auxiliary variable";
              Real d2 "Auxiliary variable";
              Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              Modelica.Media.Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Real Tc = T - 273.15 "Celsius temperature for region check";
              Real Chi "Symmetrized compressibility";
              constant .Modelica.SIunits.Density rhostar2 = 317.7 "Reference density";
              constant .Modelica.SIunits.Temperature Tstar2 = 647.25 "Reference temperature";
              constant .Modelica.SIunits.ThermalConductivity lambdastar = 1 "Reference thermal conductivity";
              Real TREL = T / Tstar2 "Relative temperature";
              Real rhoREL = d / rhostar2 "Relative density";
              Real lambdaREL "Relative thermal conductivity";
              Real deltaTREL "Relative temperature increment";
              constant Real[:] C = {0.642857, -4.11717, -6.17937, 0.00308976, 0.0822994, 10.0932};
              constant Real[:] dpar = {0.0701309, 0.0118520, 0.00169937, -1.0200};
              constant Real[:] b = {-0.397070, 0.400302, 1.060000};
              constant Real[:] B = {-0.171587, 2.392190};
              constant Real[:] a = {0.0102811, 0.0299621, 0.0156146, -0.00422464};
              Real Q;
              Real S;
              Real lambdaREL2 "Function, part of the interpolating equation of the thermal conductivity";
              Real lambdaREL1 "Function, part of the interpolating equation of the thermal conductivity";
              Real lambdaREL0 "Function, part of the interpolating equation of the thermal conductivity";
            algorithm
              assert(d > triple.dvtriple, "IF97 medium function cond_dTp called with too low density\n" + "d = " + String(d) + " <= " + String(triple.dvtriple) + " (triple point density)");
              assert(p <= 100e6 and Tc >= 0.0 and Tc <= 500 or p <= 70e6 and Tc > 500.0 and Tc <= 650 or p <= 40e6 and Tc > 650.0 and Tc <= 800, "IF97 medium function cond_dTp: thermal conductivity computed outside the range\n" + "of validity of the IF97 formulation: p = " + String(p) + " Pa, Tc = " + String(Tc) + " K");
              if industrialMethod == true then
                deltaTREL := abs(TREL - 1) + C[4];
                Q := 2 + C[5] / deltaTREL ^ (3 / 5);
                if TREL >= 1 then
                  S := 1 / deltaTREL;
                else
                  S := C[6] / deltaTREL ^ (3 / 5);
                end if;
                lambdaREL2 := (dpar[1] / TREL ^ 10 + dpar[2]) * rhoREL ^ (9 / 5) * Modelica.Math.exp(C[1] * (1 - rhoREL ^ (14 / 5))) + dpar[3] * S * rhoREL ^ Q * Modelica.Math.exp(Q / (1 + Q) * (1 - rhoREL ^ (1 + Q))) + dpar[4] * Modelica.Math.exp(C[2] * TREL ^ (3 / 2) + C[3] / rhoREL ^ 5);
                lambdaREL1 := b[1] + b[2] * rhoREL + b[3] * Modelica.Math.exp(B[1] * (rhoREL + B[2]) ^ 2);
                lambdaREL0 := TREL ^ (1 / 2) * sum(a[i] * TREL ^ (i - 1) for i in 1:4);
                lambdaREL := lambdaREL0 + lambdaREL1 + lambdaREL2;
                lambda := lambdaREL * lambdastar;
              else
                if p < data.PLIMIT4A then
                  if d > data.DCRIT then
                    region := 1;
                  else
                    region := 2;
                  end if;
                else
                  assert(false, "The scientific method works only for temperature up to 623.15 K");
                end if;
                tau := tstar / T;
                delta := d / rhostar;
                deltam1 := delta - 1.0;
                taum1 := tau - 1.0;
                Lam0 := 1 / (n0 + (n1 + (n2 + n3 * tau) * tau) * tau) / tau ^ 0.5;
                Lam1 := 0.0;
                tfun := 1.0;
                for i in 1:5 loop
                  if i <> 1 then
                    tfun := tfun * taum1;
                  else
                  end if;
                  rhofun := 1.0;
                  for j in 0:5 loop
                    if j <> 0 then
                      rhofun := rhofun * deltam1;
                    else
                    end if;
                    Lam1 := Lam1 + nn[i + j * 5] * tfun * rhofun;
                  end for;
                end for;
                if region == 1 then
                  g := Basic.g1(p, T);
                  dpitau := -tstar / pstar * (data.PSTAR1 * (g.gpi - data.TSTAR1 / T * g.gtaupi) / g.gpipi / T);
                  ddelpi := -pstar / rhostar * data.RH2O / data.PSTAR1 / data.PSTAR1 * T * d * d * g.gpipi;
                  Chi := delta * ddelpi;
                elseif region == 2 then
                  g := Basic.g2(p, T);
                  dpitau := -tstar / pstar * (data.PSTAR2 * (g.gpi - data.TSTAR2 / T * g.gtaupi) / g.gpipi / T);
                  ddelpi := -pstar / rhostar * data.RH2O / data.PSTAR2 / data.PSTAR2 * T * d * d * g.gpipi;
                  Chi := delta * ddelpi;
                else
                  assert(false, "Thermal conductivity can only be called in the one-phase regions below 623.15 K\n" + "(p = " + String(p) + " Pa, T = " + String(T) + " K, region = " + String(region) + ")");
                end if;
                taum1 := 1 / tau - 1;
                d2 := deltam1 * deltam1;
                Lam2 := 0.0013848 * etastar / visc_dTp(d, T, p) / (tau * tau * delta * delta) * dpitau * dpitau * max(Chi, Modelica.Constants.small) ^ 0.4678 * delta ^ 0.5 * Modelica.Math.exp((-18.66 * taum1 * taum1) - d2 * d2);
                lambda := lamstar * (Lam0 * Modelica.Math.exp(delta * Lam1) + Lam2);
              end if;
            end cond_dTp;

            function surfaceTension  "Surface tension in region 4 between steam and water" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.SurfaceTension sigma "Surface tension in SI units";
            protected
              Real Theta "Dimensionless temperature";
            algorithm
              Theta := min(1.0, T / data.TCRIT);
              sigma := 235.8e-3 * (1 - Theta) ^ 1.256 * (1 - 0.625 * (1 - Theta));
            end surfaceTension;
          end Transport;

          package Isentropic  "Functions for calculating the isentropic enthalpy from pressure p and specific entropy s" 
            extends Modelica.Icons.Package;

            function hofpT1  "Intermediate function for isentropic specific enthalpy in region 1" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real[13] o "Vector of auxiliary variables";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
            algorithm
              tau := data.TSTAR1 / T;
              pi1 := 7.1 - p / data.PSTAR1;
              assert(p > triple.ptriple, "IF97 medium function hofpT1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              tau1 := (-1.222) + tau;
              o[1] := tau1 * tau1;
              o[2] := o[1] * tau1;
              o[3] := o[1] * o[1];
              o[4] := o[3] * o[3];
              o[5] := o[1] * o[4];
              o[6] := o[1] * o[3];
              o[7] := o[3] * tau1;
              o[8] := o[3] * o[4];
              o[9] := pi1 * pi1;
              o[10] := o[9] * o[9];
              o[11] := o[10] * o[10];
              o[12] := o[4] * o[4];
              o[13] := o[12] * o[12];
              h := data.RH2O * T * tau * (pi1 * (((-0.00254871721114236) + o[1] * (0.00424944110961118 + (0.018990068218419 + ((-0.021841717175414) - 0.00015851507390979 * o[1]) * o[1]) * o[6])) / o[5] + pi1 * ((0.00141552963219801 + o[3] * (0.000047661393906987 + o[1] * ((-0.0000132425535992538) - 1.2358149370591e-14 * o[1] * o[3] * o[4]))) / o[3] + pi1 * ((0.000126718579380216 - 5.11230768720618e-9 * o[5]) / o[7] + pi1 * ((0.000011212640954 + o[2] * (1.30342445791202e-6 - 1.4341729937924e-12 * o[8])) / o[6] + pi1 * (o[9] * pi1 * ((1.40077319158051e-8 + 1.04549227383804e-9 * o[7]) / o[8] + o[10] * o[11] * pi1 * (1.9941018075704e-17 / (o[1] * o[12] * o[3] * o[4]) + o[9] * ((-4.48827542684151e-19 / o[13]) + o[10] * o[9] * (pi1 * (4.65957282962769e-22 / (o[13] * o[4]) + pi1 * (3.83502057899078e-24 * pi1 / (o[1] * o[13] * o[4]) - 7.2912378325616e-23 / (o[13] * o[4] * tau1))) - 1.00075970318621e-21 / (o[1] * o[13] * o[3] * tau1))))) + 3.24135974880936e-6 / (o[4] * tau1)))))) + ((-0.29265942426334) + tau1 * (0.84548187169114 + o[1] * (3.3855169168385 + tau1 * ((-1.91583926775744) + tau1 * (0.47316115539684 + ((-0.066465668798004) + 0.0040607314991784 * tau1) * tau1))))) / o[2]);
            end hofpT1;

            function handsofpT1  "Special function for specific enthalpy and specific entropy in region 1" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real[28] o "Vector of auxiliary variables";
              Real pi1 "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau1 "Dimensionless temperature";
              Real g "Dimensionless Gibbs energy";
              Real gtau "Derivative of dimensionless Gibbs energy w.r.t. tau";
            algorithm
              assert(p > triple.ptriple, "IF97 medium function handsofpT1 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              tau := data.TSTAR1 / T;
              pi1 := 7.1 - p / data.PSTAR1;
              tau1 := (-1.222) + tau;
              o[1] := tau1 * tau1;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              o[4] := o[3] * tau1;
              o[5] := 1 / o[4];
              o[6] := o[1] * o[2];
              o[7] := o[1] * tau1;
              o[8] := 1 / o[7];
              o[9] := o[1] * o[2] * o[3];
              o[10] := 1 / o[2];
              o[11] := o[2] * tau1;
              o[12] := 1 / o[11];
              o[13] := o[2] * o[3];
              o[14] := pi1 * pi1;
              o[15] := o[14] * pi1;
              o[16] := o[14] * o[14];
              o[17] := o[16] * o[16];
              o[18] := o[16] * o[17] * pi1;
              o[19] := o[14] * o[16];
              o[20] := o[3] * o[3];
              o[21] := o[20] * o[20];
              o[22] := o[21] * o[3] * tau1;
              o[23] := 1 / o[22];
              o[24] := o[21] * o[3];
              o[25] := 1 / o[24];
              o[26] := o[1] * o[2] * o[21] * tau1;
              o[27] := 1 / o[26];
              o[28] := o[1] * o[3];
              g := pi1 * (pi1 * (pi1 * (o[10] * ((-0.000031679644845054) + o[2] * ((-2.8270797985312e-6) - 8.5205128120103e-10 * o[6])) + pi1 * (o[12] * ((-2.2425281908e-6) + ((-6.5171222895601e-7) - 1.4341729937924e-13 * o[13]) * o[7]) + pi1 * ((-4.0516996860117e-7 / o[3]) + o[15] * (o[18] * (o[14] * (o[19] * (2.6335781662795e-23 / (o[1] * o[2] * o[21]) + pi1 * ((-1.1947622640071e-23 * o[27]) + pi1 * (1.8228094581404e-24 * o[25] - 9.3537087292458e-26 * o[23] * pi1))) + 1.4478307828521e-20 / (o[1] * o[2] * o[20] * o[3] * tau1)) - 6.8762131295531e-19 / (o[2] * o[20] * o[3] * tau1)) + ((-1.2734301741641e-9) - 1.7424871230634e-10 * o[11]) / (o[1] * o[3] * tau1))))) + o[8] * ((-0.00047184321073267) + o[7] * ((-0.00030001780793026) + (0.000047661393906987 + o[1] * ((-4.4141845330846e-6) - 7.2694996297594e-16 * o[9])) * tau1))) + o[5] * (0.00028319080123804 + o[1] * ((-0.00060706301565874) + o[6] * ((-0.018990068218419) + tau1 * ((-0.032529748770505) + ((-0.021841717175414) - 0.00005283835796993 * o[1]) * tau1))))) + (0.14632971213167 + tau1 * ((-0.84548187169114) + tau1 * ((-3.756360367204) + tau1 * (3.3855169168385 + tau1 * ((-0.95791963387872) + tau1 * (0.15772038513228 + ((-0.016616417199501) + 0.00081214629983568 * tau1) * tau1)))))) / o[1];
              gtau := pi1 * (((-0.00254871721114236) + o[1] * (0.00424944110961118 + (0.018990068218419 + ((-0.021841717175414) - 0.00015851507390979 * o[1]) * o[1]) * o[6])) / o[28] + pi1 * (o[10] * (0.00141552963219801 + o[2] * (0.000047661393906987 + o[1] * ((-0.0000132425535992538) - 1.2358149370591e-14 * o[9]))) + pi1 * (o[12] * (0.000126718579380216 - 5.11230768720618e-9 * o[28]) + pi1 * ((0.000011212640954 + (1.30342445791202e-6 - 1.4341729937924e-12 * o[13]) * o[7]) / o[6] + pi1 * (3.24135974880936e-6 * o[5] + o[15] * ((1.40077319158051e-8 + 1.04549227383804e-9 * o[11]) / o[13] + o[18] * (1.9941018075704e-17 / (o[1] * o[2] * o[20] * o[3]) + o[14] * ((-4.48827542684151e-19 / o[21]) + o[19] * ((-1.00075970318621e-21 * o[27]) + pi1 * (4.65957282962769e-22 * o[25] + pi1 * ((-7.2912378325616e-23 * o[23]) + 3.83502057899078e-24 * pi1 / (o[1] * o[21] * o[3])))))))))))) + o[8] * ((-0.29265942426334) + tau1 * (0.84548187169114 + o[1] * (3.3855169168385 + tau1 * ((-1.91583926775744) + tau1 * (0.47316115539684 + ((-0.066465668798004) + 0.0040607314991784 * tau1) * tau1)))));
              h := data.RH2O * T * tau * gtau;
              s := data.RH2O * (tau * gtau - g);
            end handsofpT1;

            function hofpT2  "Intermediate function for isentropic specific enthalpy in region 2" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
            protected
              Real[16] o "Vector of auxiliary variables";
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
            algorithm
              assert(p > triple.ptriple, "IF97 medium function hofpT2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              pi := p / data.PSTAR2;
              tau := data.TSTAR2 / T;
              tau2 := (-0.5) + tau;
              o[1] := tau * tau;
              o[2] := o[1] * o[1];
              o[3] := tau2 * tau2;
              o[4] := o[3] * tau2;
              o[5] := o[3] * o[3];
              o[6] := o[5] * o[5];
              o[7] := o[6] * o[6];
              o[8] := o[5] * o[6] * o[7] * tau2;
              o[9] := o[3] * o[5];
              o[10] := o[5] * o[6] * tau2;
              o[11] := o[3] * o[7] * tau2;
              o[12] := o[3] * o[5] * o[6];
              o[13] := o[5] * o[6] * o[7];
              o[14] := pi * pi;
              o[15] := o[14] * o[14];
              o[16] := o[7] * o[7];
              h := data.RH2O * T * tau * ((0.0280439559151 + tau * ((-0.2858109552582) + tau * (1.2213149471784 + tau * ((-2.848163942888) + tau * (4.38395111945 + o[1] * (10.08665568018 + ((-0.5681726521544) + 0.06380539059921 * tau) * tau)))))) / (o[1] * o[2]) + pi * ((-0.017834862292358) + tau2 * ((-0.09199202739273) + ((-0.172743777250296) - 0.30195167236758 * o[4]) * tau2) + pi * ((-0.000033032641670203) + ((-0.0003789797503263) + o[3] * ((-0.015757110897342) + o[4] * ((-0.306581069554011) - 0.000960283724907132 * o[8]))) * tau2 + pi * (4.3870667284435e-7 + o[3] * ((-0.00009683303171571) + o[4] * ((-0.0090203547252888) - 1.42338887469272 * o[8])) + pi * ((-7.8847309559367e-10) + (2.558143570457e-8 + 1.44676118155521e-6 * tau2) * tau2 + pi * (0.0000160454534363627 * o[9] + pi * (((-5.0144299353183e-11) + o[10] * ((-0.033874355714168) - 836.35096769364 * o[11])) * o[3] + pi * (((-0.0000138839897890111) - 0.973671060893475 * o[12]) * o[3] * o[6] + pi * ((9.0049690883672e-11 - 296.320827232793 * o[13]) * o[3] * o[5] * tau2 + pi * (2.57526266427144e-7 * o[5] * o[6] + pi * (o[4] * (4.1627860840696e-19 + ((-1.0234747095929e-12) - 1.40254511313154e-8 * o[5]) * o[9]) + o[14] * o[15] * (o[13] * ((-2.34560435076256e-9) + 5.3465159397045 * o[5] * o[7] * tau2) + o[14] * ((-19.1874828272775 * o[16] * o[6] * o[7]) + o[14] * (o[11] * (1.78371690710842e-23 + (1.07202609066812e-11 - 0.000201611844951398 * o[10]) * o[3] * o[5] * o[6] * tau2) + pi * ((-1.24017662339842e-24 * o[5] * o[7]) + pi * (0.000200482822351322 * o[16] * o[5] * o[7] + pi * ((-4.97975748452559e-14 * o[16] * o[3] * o[5]) + o[6] * o[7] * (1.90027787547159e-27 + o[12] * (2.21658861403112e-15 - 0.0000547344301999018 * o[3] * o[7])) * pi * tau2)))))))))))))))));
            end hofpT2;

            function handsofpT2  "Function for isentropic specific enthalpy and specific entropy in region 2" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
            protected
              Real[22] o "Vector of auxiliary variables";
              Real pi "Dimensionless pressure";
              Real tau "Dimensionless temperature";
              Real tau2 "Dimensionless temperature";
              Real g "Dimensionless Gibbs energy";
              Real gtau "Derivative of dimensionless Gibbs energy w.r.t. tau";
            algorithm
              assert(p > triple.ptriple, "IF97 medium function handsofpT2 called with too low pressure\n" + "p = " + String(p) + " Pa <= " + String(triple.ptriple) + " Pa (triple point pressure)");
              tau := data.TSTAR2 / T;
              pi := p / data.PSTAR2;
              tau2 := tau - 0.5;
              o[1] := tau2 * tau2;
              o[2] := o[1] * tau2;
              o[3] := o[1] * o[1];
              o[4] := o[3] * o[3];
              o[5] := o[4] * o[4];
              o[6] := o[3] * o[4] * o[5] * tau2;
              o[7] := o[1] * o[3] * tau2;
              o[8] := o[3] * o[4] * tau2;
              o[9] := o[1] * o[5] * tau2;
              o[10] := o[1] * o[3] * o[4];
              o[11] := o[3] * o[4] * o[5];
              o[12] := o[1] * o[3];
              o[13] := pi * pi;
              o[14] := o[13] * o[13];
              o[15] := o[13] * o[14];
              o[16] := o[3] * o[5] * tau2;
              o[17] := o[5] * o[5];
              o[18] := o[3] * o[5];
              o[19] := o[1] * o[3] * o[4] * tau2;
              o[20] := o[1] * o[5];
              o[21] := tau * tau;
              o[22] := o[21] * o[21];
              g := pi * ((-0.0017731742473213) + tau2 * ((-0.017834862292358) + tau2 * ((-0.045996013696365) + ((-0.057581259083432) - 0.05032527872793 * o[2]) * tau2)) + pi * (tau2 * ((-0.000033032641670203) + ((-0.00018948987516315) + o[1] * ((-0.0039392777243355) + o[2] * ((-0.043797295650573) - 0.000026674547914087 * o[6]))) * tau2) + pi * (2.0481737692309e-8 + (4.3870667284435e-7 + o[1] * ((-0.00003227767723857) + o[2] * ((-0.0015033924542148) - 0.040668253562649 * o[6]))) * tau2 + pi * (tau2 * ((-7.8847309559367e-10) + (1.2790717852285e-8 + 4.8225372718507e-7 * tau2) * tau2) + pi * (2.2922076337661e-6 * o[7] + pi * (o[2] * ((-1.6714766451061e-11) + o[8] * ((-0.0021171472321355) - 23.895741934104 * o[9])) + pi * ((-5.905956432427e-18) + o[1] * ((-1.2621808899101e-6) - 0.038946842435739 * o[10]) * o[4] * tau2 + pi * ((1.1256211360459e-11 - 8.2311340897998 * o[11]) * o[4] + pi * (1.9809712802088e-8 * o[8] + pi * ((1.0406965210174e-19 + o[12] * ((-1.0234747095929e-13) - 1.0018179379511e-9 * o[3])) * o[3] + o[15] * (((-8.0882908646985e-11) + 0.10693031879409 * o[16]) * o[6] + o[13] * ((-0.33662250574171 * o[17] * o[4] * o[5] * tau2) + o[13] * (o[18] * (8.9185845355421e-25 + o[19] * (3.0629316876232e-13 - 4.2002467698208e-6 * o[8])) + pi * ((-5.9056029685639e-26 * o[16]) + pi * (3.7826947613457e-6 * o[17] * o[3] * o[5] * tau2 + pi * (o[1] * (7.3087610595061e-29 + o[10] * (5.5414715350778e-17 - 9.436970724121e-7 * o[20])) * o[4] * o[5] * pi - 1.2768608934681e-15 * o[1] * o[17] * o[3] * tau2)))))))))))))))) + ((-0.00560879118302) + tau * (0.07145273881455 + tau * ((-0.4071049823928) + tau * (1.424081971444 + tau * ((-4.38395111945) + tau * ((-9.692768600217) + tau * (10.08665568018 + ((-0.2840863260772) + 0.02126846353307 * tau) * tau) + Modelica.Math.log(pi))))))) / (o[22] * tau);
              gtau := (0.0280439559151 + tau * ((-0.2858109552582) + tau * (1.2213149471784 + tau * ((-2.848163942888) + tau * (4.38395111945 + o[21] * (10.08665568018 + ((-0.5681726521544) + 0.06380539059921 * tau) * tau)))))) / (o[21] * o[22]) + pi * ((-0.017834862292358) + tau2 * ((-0.09199202739273) + ((-0.172743777250296) - 0.30195167236758 * o[2]) * tau2) + pi * ((-0.000033032641670203) + ((-0.0003789797503263) + o[1] * ((-0.015757110897342) + o[2] * ((-0.306581069554011) - 0.000960283724907132 * o[6]))) * tau2 + pi * (4.3870667284435e-7 + o[1] * ((-0.00009683303171571) + o[2] * ((-0.0090203547252888) - 1.42338887469272 * o[6])) + pi * ((-7.8847309559367e-10) + (2.558143570457e-8 + 1.44676118155521e-6 * tau2) * tau2 + pi * (0.0000160454534363627 * o[12] + pi * (o[1] * ((-5.0144299353183e-11) + o[8] * ((-0.033874355714168) - 836.35096769364 * o[9])) + pi * (o[1] * ((-0.0000138839897890111) - 0.973671060893475 * o[10]) * o[4] + pi * ((9.0049690883672e-11 - 296.320827232793 * o[11]) * o[7] + pi * (2.57526266427144e-7 * o[3] * o[4] + pi * (o[2] * (4.1627860840696e-19 + o[12] * ((-1.0234747095929e-12) - 1.40254511313154e-8 * o[3])) + o[15] * (o[11] * ((-2.34560435076256e-9) + 5.3465159397045 * o[16]) + o[13] * ((-19.1874828272775 * o[17] * o[4] * o[5]) + o[13] * ((1.78371690710842e-23 + o[19] * (1.07202609066812e-11 - 0.000201611844951398 * o[8])) * o[9] + pi * ((-1.24017662339842e-24 * o[18]) + pi * (0.000200482822351322 * o[17] * o[3] * o[5] + pi * ((-4.97975748452559e-14 * o[1] * o[17] * o[3]) + (1.90027787547159e-27 + o[10] * (2.21658861403112e-15 - 0.0000547344301999018 * o[20])) * o[4] * o[5] * pi * tau2))))))))))))))));
              h := data.RH2O * T * tau * gtau;
              s := data.RH2O * (tau * gtau - g);
            end handsofpT2;
          end Isentropic;

          package Inverses  "Efficient inverses for selected pairs of variables" 
            extends Modelica.Icons.Package;

            function fixdT  "Region limits for inverse iteration in region 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density din "Density";
              input .Modelica.SIunits.Temperature Tin "Temperature";
              output .Modelica.SIunits.Density dout "Density";
              output .Modelica.SIunits.Temperature Tout "Temperature";
            protected
              .Modelica.SIunits.Temperature Tmin "Approximation of minimum temperature";
              .Modelica.SIunits.Temperature Tmax "Approximation of maximum temperature";
            algorithm
              if din > 765.0 then
                dout := 765.0;
              elseif din < 110.0 then
                dout := 110.0;
              else
                dout := din;
              end if;
              if dout < 390.0 then
                Tmax := 554.3557377 + dout * 0.809344262;
              else
                Tmax := 1116.85 - dout * 0.632948717;
              end if;
              if dout < data.DCRIT then
                Tmin := data.TCRIT * (1.0 - (dout - data.DCRIT) * (dout - data.DCRIT) / 1.0e6);
              else
                Tmin := data.TCRIT * (1.0 - (dout - data.DCRIT) * (dout - data.DCRIT) / 1.44e6);
              end if;
              if Tin < Tmin then
                Tout := Tmin;
              elseif Tin > Tmax then
                Tout := Tmax;
              else
                Tout := Tin;
              end if;
            end fixdT;

            function dofp13  "Density at the boundary between regions 1 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Density d "Density";
            protected
              Real p2 "Auxiliary variable";
              Real[3] o "Vector of auxiliary variables";
            algorithm
              p2 := 7.1 - 6.04960677555959e-8 * p;
              o[1] := p2 * p2;
              o[2] := o[1] * o[1];
              o[3] := o[2] * o[2];
              d := 57.4756752485113 / (0.0737412153522555 + p2 * (0.00145092247736023 + p2 * (0.000102697173772229 + p2 * (0.0000114683182476084 + p2 * (1.99080616601101e-6 + o[1] * p2 * (1.13217858826367e-8 + o[2] * o[3] * p2 * (1.35549330686006e-17 + o[1] * ((-3.11228834832975e-19) + o[1] * o[2] * ((-7.02987180039442e-22) + p2 * (3.29199117056433e-22 + ((-5.17859076694812e-23) + 2.73712834080283e-24 * p2) * p2))))))))));
            end dofp13;

            function dofp23  "Density at the boundary between regions 2 and 3" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              output .Modelica.SIunits.Density d "Density";
            protected
              .Modelica.SIunits.Temperature T;
              Real[13] o "Vector of auxiliary variables";
              Real taug "Auxiliary variable";
              Real pi "Dimensionless pressure";
              Real gpi23 "Derivative of g w.r.t. pi on the boundary between regions 2 and 3";
            algorithm
              pi := p / data.PSTAR2;
              T := 572.54459862746 + 31.3220101646784 * ((-13.91883977887) + pi) ^ 0.5;
              o[1] := ((-13.91883977887) + pi) ^ 0.5;
              taug := (-0.5) + 540.0 / (572.54459862746 + 31.3220101646784 * o[1]);
              o[2] := taug * taug;
              o[3] := o[2] * taug;
              o[4] := o[2] * o[2];
              o[5] := o[4] * o[4];
              o[6] := o[5] * o[5];
              o[7] := o[4] * o[5] * o[6] * taug;
              o[8] := o[4] * o[5] * taug;
              o[9] := o[2] * o[4] * o[5];
              o[10] := pi * pi;
              o[11] := o[10] * o[10];
              o[12] := o[4] * o[6] * taug;
              o[13] := o[6] * o[6];
              gpi23 := (1.0 + pi * ((-0.0017731742473213) + taug * ((-0.017834862292358) + taug * ((-0.045996013696365) + ((-0.057581259083432) - 0.05032527872793 * o[3]) * taug)) + pi * (taug * ((-0.000066065283340406) + ((-0.0003789797503263) + o[2] * ((-0.007878555448671) + o[3] * ((-0.087594591301146) - 0.000053349095828174 * o[7]))) * taug) + pi * (6.1445213076927e-8 + (1.31612001853305e-6 + o[2] * ((-0.00009683303171571) + o[3] * ((-0.0045101773626444) - 0.122004760687947 * o[7]))) * taug + pi * (taug * ((-3.15389238237468e-9) + (5.116287140914e-8 + 1.92901490874028e-6 * taug) * taug) + pi * (0.0000114610381688305 * o[2] * o[4] * taug + pi * (o[3] * ((-1.00288598706366e-10) + o[8] * ((-0.012702883392813) - 143.374451604624 * o[2] * o[6] * taug)) + pi * ((-4.1341695026989e-17) + o[2] * o[5] * ((-8.8352662293707e-6) - 0.272627897050173 * o[9]) * taug + pi * (o[5] * (9.0049690883672e-11 - 65.8490727183984 * o[4] * o[5] * o[6]) + pi * (1.78287415218792e-7 * o[8] + pi * (o[4] * (1.0406965210174e-18 + o[2] * ((-1.0234747095929e-12) - 1.0018179379511e-8 * o[4]) * o[4]) + o[10] * o[11] * (((-1.29412653835176e-9) + 1.71088510070544 * o[12]) * o[7] + o[10] * ((-6.05920510335078 * o[13] * o[5] * o[6] * taug) + o[10] * (o[4] * o[6] * (1.78371690710842e-23 + o[2] * o[4] * o[5] * (6.1258633752464e-12 - 0.000084004935396416 * o[8]) * taug) + pi * ((-1.24017662339842e-24 * o[12]) + pi * (0.0000832192847496054 * o[13] * o[4] * o[6] * taug + pi * (o[2] * o[5] * o[6] * (1.75410265428146e-27 + (1.32995316841867e-15 - 0.0000226487297378904 * o[2] * o[6]) * o[9]) * pi - 2.93678005497663e-14 * o[13] * o[2] * o[4] * taug))))))))))))))))) / pi;
              d := p / (data.RH2O * T * pi * gpi23);
            end dofp23;

            function dofpt3  "Inverse iteration in region 3: (d) = f(p,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input .Modelica.SIunits.Pressure delp "Iteration converged if (p-pre(p) < delp)";
              output .Modelica.SIunits.Density d "Density";
              output Integer error = 0 "Error flag: iteration failed if different from 0";
            protected
              .Modelica.SIunits.Density dguess "Guess density";
              Integer i = 0 "Loop counter";
              Real dp "Pressure difference";
              .Modelica.SIunits.Density deld "Density step";
              Modelica.Media.Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_pT nDerivs "Derivatives needed in Newton iteration";
              Boolean found = false "Flag for iteration success";
              Boolean supercritical "Flag, true for supercritical states";
              Boolean liquid "Flag, true for liquid states";
              .Modelica.SIunits.Density dmin "Lower density limit";
              .Modelica.SIunits.Density dmax "Upper density limit";
              .Modelica.SIunits.Temperature Tmax "Maximum temperature";
              Real damping "Damping factor";
            algorithm
              found := false;
              assert(p >= data.PLIMIT4A, "BaseIF97.dofpt3: function called outside of region 3! p too low\n" + "p = " + String(p) + " Pa < " + String(data.PLIMIT4A) + " Pa");
              assert(T >= data.TLIMIT1, "BaseIF97.dofpt3: function called outside of region 3! T too low\n" + "T = " + String(T) + " K < " + String(data.TLIMIT1) + " K");
              assert(p >= Regions.boundary23ofT(T), "BaseIF97.dofpt3: function called outside of region 3! T too high\n" + "p = " + String(p) + " Pa, T = " + String(T) + " K");
              supercritical := p > data.PCRIT;
              damping := if supercritical then 1.0 else 1.0;
              Tmax := Regions.boundary23ofp(p);
              if supercritical then
                dmax := dofp13(p);
                dmin := dofp23(p);
                dguess := dmax - (T - data.TLIMIT1) / (data.TLIMIT1 - Tmax) * (dmax - dmin);
              else
                liquid := T < Basic.tsat(p);
                if liquid then
                  dmax := dofp13(p);
                  dmin := Regions.rhol_p_R4b(p);
                  dguess := 1.1 * Regions.rhol_T(T) "Guess: 10 percent more than on the phase boundary for same T";
                else
                  dmax := Regions.rhov_p_R4b(p);
                  dmin := dofp23(p);
                  dguess := 0.9 * Regions.rhov_T(T) "Guess: 10% less than on the phase boundary for same T";
                end if;
              end if;
              while i < IterationData.IMAX and not found loop
                d := dguess;
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_pT(f);
                dp := nDerivs.p - p;
                if abs(dp / p) <= delp then
                  found := true;
                else
                end if;
                deld := dp / nDerivs.pd * damping;
                d := d - deld;
                if d > dmin and d < dmax then
                  dguess := d;
                else
                  if d > dmax then
                    dguess := dmax - sqrt(Modelica.Constants.eps);
                  else
                    dguess := dmin + sqrt(Modelica.Constants.eps);
                  end if;
                end if;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function dofpt3: iteration failed");
            end dofpt3;

            function dtofph3  "Inverse iteration in region 3: (d,T) = f(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              input .Modelica.SIunits.Pressure delp "Iteration accuracy";
              input .Modelica.SIunits.SpecificEnthalpy delh "Iteration accuracy";
              output .Modelica.SIunits.Density d "Density";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
              output Integer error "Error flag: iteration failed if different from 0";
            protected
              .Modelica.SIunits.Temperature Tguess "Initial temperature";
              .Modelica.SIunits.Density dguess "Initial density";
              Integer i "Iteration counter";
              Real dh "Newton-error in h-direction";
              Real dp "Newton-error in p-direction";
              Real det "Determinant of directional derivatives";
              Real deld "Newton-step in d-direction";
              Real delt "Newton-step in T-direction";
              Modelica.Media.Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_ph nDerivs "Derivatives needed in Newton iteration";
              Boolean found = false "Flag for iteration success";
              Integer subregion "1 for subregion 3a, 2 for subregion 3b";
            algorithm
              if p < data.PCRIT then
                subregion := if h < Regions.hl_p(p) + 10.0 then 1 else if h > Regions.hv_p(p) - 10.0 then 2 else 0;
                assert(subregion <> 0, "Inverse iteration of dt from ph called in 2 phase region: this can not work");
              else
                subregion := if h < Basic.h3ab_p(p) then 1 else 2;
              end if;
              T := if subregion == 1 then Basic.T3a_ph(p, h) else Basic.T3b_ph(p, h);
              d := if subregion == 1 then 1 / Basic.v3a_ph(p, h) else 1 / Basic.v3b_ph(p, h);
              i := 0;
              error := 0;
              while i < IterationData.IMAX and not found loop
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_ph(f);
                dh := nDerivs.h - h;
                dp := nDerivs.p - p;
                if abs(dh / h) <= delh and abs(dp / p) <= delp then
                  found := true;
                else
                end if;
                det := nDerivs.ht * nDerivs.pd - nDerivs.pt * nDerivs.hd;
                delt := (nDerivs.pd * dh - nDerivs.hd * dp) / det;
                deld := (nDerivs.ht * dp - nDerivs.pt * dh) / det;
                T := T - delt;
                d := d - deld;
                dguess := d;
                Tguess := T;
                i := i + 1;
                (d, T) := fixdT(dguess, Tguess);
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function dtofph3: iteration failed");
            end dtofph3;

            function dtofps3  "Inverse iteration in region 3: (d,T) = f(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              input .Modelica.SIunits.Pressure delp "Iteration accuracy";
              input .Modelica.SIunits.SpecificEntropy dels "Iteration accuracy";
              output .Modelica.SIunits.Density d "Density";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
              output Integer error "Error flag: iteration failed if different from 0";
            protected
              .Modelica.SIunits.Temperature Tguess "Initial temperature";
              .Modelica.SIunits.Density dguess "Initial density";
              Integer i "Iteration counter";
              Real ds "Newton-error in s-direction";
              Real dp "Newton-error in p-direction";
              Real det "Determinant of directional derivatives";
              Real deld "Newton-step in d-direction";
              Real delt "Newton-step in T-direction";
              Modelica.Media.Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
              Modelica.Media.Common.NewtonDerivatives_ps nDerivs "Derivatives needed in Newton iteration";
              Boolean found "Flag for iteration success";
              Integer subregion "1 for subregion 3a, 2 for subregion 3b";
            algorithm
              i := 0;
              error := 0;
              found := false;
              if p < data.PCRIT then
                subregion := if s < Regions.sl_p(p) + 10.0 then 1 else if s > Regions.sv_p(p) - 10.0 then 2 else 0;
                assert(subregion <> 0, "Inverse iteration of dt from ps called in 2 phase region: this is illegal!");
              else
                subregion := if s < data.SCRIT then 1 else 2;
              end if;
              T := if subregion == 1 then Basic.T3a_ps(p, s) else Basic.T3b_ps(p, s);
              d := if subregion == 1 then 1 / Basic.v3a_ps(p, s) else 1 / Basic.v3b_ps(p, s);
              while i < IterationData.IMAX and not found loop
                f := Basic.f3(d, T);
                nDerivs := Modelica.Media.Common.Helmholtz_ps(f);
                ds := nDerivs.s - s;
                dp := nDerivs.p - p;
                if abs(ds / s) <= dels and abs(dp / p) <= delp then
                  found := true;
                else
                end if;
                det := nDerivs.st * nDerivs.pd - nDerivs.pt * nDerivs.sd;
                delt := (nDerivs.pd * ds - nDerivs.sd * dp) / det;
                deld := (nDerivs.st * dp - nDerivs.pt * ds) / det;
                T := T - delt;
                d := d - deld;
                dguess := d;
                Tguess := T;
                i := i + 1;
                (d, T) := fixdT(dguess, Tguess);
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function dtofps3: iteration failed");
            end dtofps3;

            function pofdt125  "Inverse iteration in region 1,2 and 5: p = g(d,T)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Density d "Density";
              input .Modelica.SIunits.Temperature T "Temperature (K)";
              input .Modelica.SIunits.Pressure reldd "Relative iteration accuracy of density";
              input Integer region "Region in IAPWS/IF97 in which inverse should be calculated";
              output .Modelica.SIunits.Pressure p "Pressure";
              output Integer error "Error flag: iteration failed if different from 0";
            protected
              Integer i "Counter for while-loop";
              Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              Boolean found "Flag if iteration has been successful";
              Real dd "Difference between density for guessed p and the current density";
              Real delp "Step in p in Newton-iteration";
              Real relerr "Relative error in d";
              .Modelica.SIunits.Pressure pguess1 = 1.0e6 "Initial pressure guess in region 1";
              .Modelica.SIunits.Pressure pguess2 "Initial pressure guess in region 2";
              constant .Modelica.SIunits.Pressure pguess5 = 0.5e6 "Initial pressure guess in region 5";
            algorithm
              i := 0;
              error := 0;
              pguess2 := 42800 * d;
              found := false;
              if region == 1 then
                p := pguess1;
              elseif region == 2 then
                p := pguess2;
              else
                p := pguess5;
              end if;
              while i < IterationData.IMAX and not found loop
                if region == 1 then
                  g := Basic.g1(p, T);
                elseif region == 2 then
                  g := Basic.g2(p, T);
                else
                  g := Basic.g5(p, T);
                end if;
                dd := p / (data.RH2O * T * g.pi * g.gpi) - d;
                relerr := dd / d;
                if abs(relerr) < reldd then
                  found := true;
                else
                end if;
                delp := dd * (-p * p / (d * d * data.RH2O * T * g.pi * g.pi * g.gpipi));
                p := p - delp;
                i := i + 1;
                if not found then
                  if p < triple.ptriple then
                    p := 2.0 * triple.ptriple;
                  else
                  end if;
                  if p > data.PLIMIT1 then
                    p := 0.95 * data.PLIMIT1;
                  else
                  end if;
                else
                end if;
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function pofdt125: iteration failed");
            end pofdt125;

            function tofph5  "Inverse iteration in region 5: (p,T) = f(p,h)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
              input .Modelica.SIunits.SpecificEnthalpy reldh "Iteration accuracy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
              output Integer error "Error flag: iteration failed if different from 0";
            protected
              Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              .Modelica.SIunits.SpecificEnthalpy proh "H for current guess in T";
              constant .Modelica.SIunits.Temperature Tguess = 1500 "Initial temperature";
              Integer i "Iteration counter";
              Real relerr "Relative error in h";
              Real dh "Newton-error in h-direction";
              Real dT "Newton-step in T-direction";
              Boolean found "Flag for iteration success";
            algorithm
              i := 0;
              error := 0;
              T := Tguess;
              found := false;
              while i < IterationData.IMAX and not found loop
                g := Basic.g5(p, T);
                proh := data.RH2O * T * g.tau * g.gtau;
                dh := proh - h;
                relerr := dh / h;
                if abs(relerr) < reldh then
                  found := true;
                else
                end if;
                dT := dh / (-data.RH2O * g.tau * g.tau * g.gtautau);
                T := T - dT;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function tofph5: iteration failed");
            end tofph5;

            function tofps5  "Inverse iteration in region 5: (p,T) = f(p,s)" 
              extends Modelica.Icons.Function;
              input .Modelica.SIunits.Pressure p "Pressure";
              input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
              input .Modelica.SIunits.SpecificEnthalpy relds "Iteration accuracy";
              output .Modelica.SIunits.Temperature T "Temperature (K)";
              output Integer error "Error flag: iteration failed if different from 0";
            protected
              Modelica.Media.Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
              .Modelica.SIunits.SpecificEntropy pros "S for current guess in T";
              parameter .Modelica.SIunits.Temperature Tguess = 1500 "Initial temperature";
              Integer i "Iteration counter";
              Real relerr "Relative error in s";
              Real ds "Newton-error in s-direction";
              Real dT "Newton-step in T-direction";
              Boolean found "Flag for iteration success";
            algorithm
              i := 0;
              error := 0;
              T := Tguess;
              found := false;
              while i < IterationData.IMAX and not found loop
                g := Basic.g5(p, T);
                pros := data.RH2O * (g.tau * g.gtau - g.g);
                ds := pros - s;
                relerr := ds / s;
                if abs(relerr) < relds then
                  found := true;
                else
                end if;
                dT := ds * T / (-data.RH2O * g.tau * g.tau * g.gtautau);
                T := T - dT;
                i := i + 1;
              end while;
              if not found then
                error := 1;
              else
              end if;
              assert(error <> 1, "Error in inverse function tofps5: iteration failed");
            end tofps5;
          end Inverses;
        end BaseIF97;

        function waterBaseProp_ph  "Intermediate property record for water" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region = 0 "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
          .Modelica.SIunits.SpecificEnthalpy h_liq "Liquid specific enthalpy";
          .Modelica.SIunits.Density d_liq "Liquid density";
          .Modelica.SIunits.SpecificEnthalpy h_vap "Vapour specific enthalpy";
          .Modelica.SIunits.Density d_vap "Vapour density";
          Common.PhaseBoundaryProperties liq "Phase boundary property record";
          Common.PhaseBoundaryProperties vap "Phase boundary property record";
          Common.GibbsDerivs gl "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.GibbsDerivs gv "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          .Modelica.SIunits.Temperature t1 "Temperature at phase boundary, using inverse from region 1";
          .Modelica.SIunits.Temperature t2 "Temperature at phase boundary, using inverse from region 2";
        algorithm
          aux.region := if region == 0 then if phase == 2 then 4 else BaseIF97.Regions.region_ph(p = p, h = h, phase = phase) else region;
          aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
          aux.p := max(p, 611.657);
          aux.h := max(h, 1e3);
          aux.R := BaseIF97.data.RH2O;
          aux.vt := 0.0 "initialized in case it is not needed";
          aux.vp := 0.0 "initialized in case it is not needed";
          if aux.region == 1 then
            aux.T := BaseIF97.Basic.tph1(aux.p, aux.h);
            g := BaseIF97.Basic.g1(p, aux.T);
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 0.0;
            aux.dpT := -aux.vt / aux.vp;
          elseif aux.region == 2 then
            aux.T := BaseIF97.Basic.tph2(aux.p, aux.h);
            g := BaseIF97.Basic.g2(p, aux.T);
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 1.0;
            aux.dpT := -aux.vt / aux.vp;
          elseif aux.region == 3 then
            (aux.rho, aux.T, error) := BaseIF97.Inverses.dtofph3(p = aux.p, h = aux.h, delp = 1.0e-7, delh = 1.0e-6);
            f := BaseIF97.Basic.f3(aux.rho, aux.T);
            aux.h := aux.R * aux.T * (f.tau * f.ftau + f.delta * f.fdelta);
            aux.s := aux.R * (f.tau * f.ftau - f.f);
            aux.pd := aux.R * aux.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
            aux.pt := aux.R * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
            aux.cv := abs(aux.R * (-f.tau * f.tau * f.ftautau)) "Can be close to neg. infinity near critical point";
            aux.cp := (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * aux.rho * aux.pd);
            aux.x := 0.0;
            aux.dpT := aux.pt;
          elseif aux.region == 4 then
            h_liq := hl_p(p);
            h_vap := hv_p(p);
            aux.x := if h_vap <> h_liq then (h - h_liq) / (h_vap - h_liq) else 1.0;
            if p < BaseIF97.data.PLIMIT4A then
              t1 := BaseIF97.Basic.tph1(aux.p, h_liq);
              t2 := BaseIF97.Basic.tph2(aux.p, h_vap);
              gl := BaseIF97.Basic.g1(aux.p, t1);
              gv := BaseIF97.Basic.g2(aux.p, t2);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
              aux.T := t1 + aux.x * (t2 - t1);
            else
              aux.T := BaseIF97.Basic.tsat(aux.p);
              d_liq := rhol_T(aux.T);
              d_vap := rhov_T(aux.T);
              fl := BaseIF97.Basic.f3(d_liq, aux.T);
              fv := BaseIF97.Basic.f3(d_vap, aux.T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
            end if;
            aux.dpT := if liq.d <> vap.d then (vap.s - liq.s) * liq.d * vap.d / (liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.s := liq.s + aux.x * (vap.s - liq.s);
            aux.rho := liq.d * vap.d / (vap.d + aux.x * (liq.d - vap.d));
            aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, p);
            aux.cp := liq.cp + aux.x * (vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x * (vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x * (vap.pd - liq.pd);
          elseif aux.region == 5 then
            (aux.T, error) := BaseIF97.Inverses.tofph5(p = aux.p, h = aux.h, reldh = 1.0e-7);
            assert(error == 0, "Error in inverse iteration of steam tables");
            g := BaseIF97.Basic.g5(aux.p, aux.T);
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.dpT := -aux.vt / aux.vp;
          else
            assert(false, "Error in region computation of IF97 steam tables" + "(p = " + String(p) + ", h = " + String(h) + ")");
          end if;
        end waterBaseProp_ph;

        function waterBaseProp_ps  "Intermediate property record for water" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region = 0 "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
          .Modelica.SIunits.SpecificEntropy s_liq "Liquid specific entropy";
          .Modelica.SIunits.Density d_liq "Liquid density";
          .Modelica.SIunits.SpecificEntropy s_vap "Vapour specific entropy";
          .Modelica.SIunits.Density d_vap "Vapour density";
          Common.PhaseBoundaryProperties liq "Phase boundary property record";
          Common.PhaseBoundaryProperties vap "Phase boundary property record";
          Common.GibbsDerivs gl "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.GibbsDerivs gv "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          .Modelica.SIunits.Temperature t1 "Temperature at phase boundary, using inverse from region 1";
          .Modelica.SIunits.Temperature t2 "Temperature at phase boundary, using inverse from region 2";
        algorithm
          aux.region := if region == 0 then if phase == 2 then 4 else BaseIF97.Regions.region_ps(p = p, s = s, phase = phase) else region;
          aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
          aux.p := p;
          aux.s := s;
          aux.R := BaseIF97.data.RH2O;
          aux.vt := 0.0 "initialized in case it is not needed";
          aux.vp := 0.0 "initialized in case it is not needed";
          if aux.region == 1 then
            aux.T := BaseIF97.Basic.tps1(p, s);
            g := BaseIF97.Basic.g1(p, aux.T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 0.0;
            aux.dpT := -aux.vt / aux.vp;
          elseif aux.region == 2 then
            aux.T := BaseIF97.Basic.tps2(p, s);
            g := BaseIF97.Basic.g2(p, aux.T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 1.0;
            aux.dpT := -aux.vt / aux.vp;
          elseif aux.region == 3 then
            (aux.rho, aux.T, error) := BaseIF97.Inverses.dtofps3(p = p, s = s, delp = 1.0e-7, dels = 1.0e-6);
            f := BaseIF97.Basic.f3(aux.rho, aux.T);
            aux.h := aux.R * aux.T * (f.tau * f.ftau + f.delta * f.fdelta);
            aux.s := aux.R * (f.tau * f.ftau - f.f);
            aux.pd := aux.R * aux.T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
            aux.pt := aux.R * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
            aux.cv := aux.R * (-f.tau * f.tau * f.ftautau);
            aux.cp := (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * aux.rho * aux.pd);
            aux.x := 0.0;
            aux.dpT := aux.pt;
          elseif aux.region == 4 then
            s_liq := BaseIF97.Regions.sl_p(p);
            s_vap := BaseIF97.Regions.sv_p(p);
            aux.x := if s_vap <> s_liq then (s - s_liq) / (s_vap - s_liq) else 1.0;
            if p < BaseIF97.data.PLIMIT4A then
              t1 := BaseIF97.Basic.tps1(p, s_liq);
              t2 := BaseIF97.Basic.tps2(p, s_vap);
              gl := BaseIF97.Basic.g1(p, t1);
              gv := BaseIF97.Basic.g2(p, t2);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
              aux.T := t1 + aux.x * (t2 - t1);
            else
              aux.T := BaseIF97.Basic.tsat(p);
              d_liq := rhol_T(aux.T);
              d_vap := rhov_T(aux.T);
              fl := BaseIF97.Basic.f3(d_liq, aux.T);
              fv := BaseIF97.Basic.f3(d_vap, aux.T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
            end if;
            aux.dpT := if liq.d <> vap.d then (vap.s - liq.s) * liq.d * vap.d / (liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.h := liq.h + aux.x * (vap.h - liq.h);
            aux.rho := liq.d * vap.d / (vap.d + aux.x * (liq.d - vap.d));
            aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, p);
            aux.cp := liq.cp + aux.x * (vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x * (vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x * (vap.pd - liq.pd);
          elseif aux.region == 5 then
            (aux.T, error) := BaseIF97.Inverses.tofps5(p = p, s = s, relds = 1.0e-7);
            assert(error == 0, "Error in inverse iteration of steam tables");
            g := BaseIF97.Basic.g5(p, aux.T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.rho := p / (aux.R * aux.T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * aux.T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.dpT := -aux.vt / aux.vp;
            aux.x := 1.0;
          else
            assert(false, "Error in region computation of IF97 steam tables" + "(p = " + String(p) + ", s = " + String(s) + ")");
          end if;
        end waterBaseProp_ps;

        function rho_props_ps  "Density as function of pressure and specific entropy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := properties.rho;
          annotation(Inline = false, LateInline = true); 
        end rho_props_ps;

        function rho_ps  "Density as function of pressure and specific entropy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := rho_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
          annotation(Inline = true); 
        end rho_ps;

        function T_props_ps  "Temperature as function of pressure and specific entropy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output .Modelica.SIunits.Temperature T "Temperature";
        algorithm
          T := properties.T;
          annotation(Inline = false, LateInline = true); 
        end T_props_ps;

        function T_ps  "Temperature as function of pressure and specific entropy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Temperature T "Temperature";
        algorithm
          T := T_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
          annotation(Inline = true); 
        end T_ps;

        function h_props_ps  "Specific enthalpy as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation(Inline = false, LateInline = true); 
        end h_props_ps;

        function h_ps  "Specific enthalpy as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_ps(p, s, waterBaseProp_ps(p, s, phase, region));
          annotation(Inline = true); 
        end h_ps;

        function rho_props_ph  "Density as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := properties.rho;
          annotation(derivative(noDerivative = properties) = rho_ph_der, Inline = false, LateInline = true); 
        end rho_props_ph;

        function rho_ph  "Density as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := rho_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end rho_ph;

        function rho_ph_der  "Derivative function of rho_ph" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real rho_der "Derivative of density";
        algorithm
          if properties.region == 4 then
            rho_der := properties.rho * (properties.rho * properties.cv / properties.dpT + 1.0) / (properties.dpT * properties.T) * p_der + (-properties.rho * properties.rho / (properties.dpT * properties.T)) * h_der;
          elseif properties.region == 3 then
            rho_der := properties.rho * (properties.cv * properties.rho + properties.pt) / (properties.rho * properties.rho * properties.pd * properties.cv + properties.T * properties.pt * properties.pt) * p_der + (-properties.rho * properties.rho * properties.pt / (properties.rho * properties.rho * properties.pd * properties.cv + properties.T * properties.pt * properties.pt)) * h_der;
          else
            rho_der := (-properties.rho * properties.rho * (properties.vp * properties.cp - properties.vt / properties.rho + properties.T * properties.vt * properties.vt) / properties.cp) * p_der + (-properties.rho * properties.rho * properties.vt / properties.cp) * h_der;
          end if;
        end rho_ph_der;

        function T_props_ph  "Temperature as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output .Modelica.SIunits.Temperature T "Temperature";
        algorithm
          T := properties.T;
          annotation(derivative(noDerivative = properties) = T_ph_der, Inline = false, LateInline = true); 
        end T_props_ph;

        function T_ph  "Temperature as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Temperature T "Temperature";
        algorithm
          T := T_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end T_ph;

        function T_ph_der  "Derivative function of T_ph" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real T_der "Derivative of temperature";
        algorithm
          if properties.region == 4 then
            T_der := 1 / properties.dpT * p_der;
          elseif properties.region == 3 then
            T_der := ((-properties.rho * properties.pd) + properties.T * properties.pt) / (properties.rho * properties.rho * properties.pd * properties.cv + properties.T * properties.pt * properties.pt) * p_der + properties.rho * properties.rho * properties.pd / (properties.rho * properties.rho * properties.pd * properties.cv + properties.T * properties.pt * properties.pt) * h_der;
          else
            T_der := ((-1 / properties.rho) + properties.T * properties.vt) / properties.cp * p_der + 1 / properties.cp * h_der;
          end if;
        end T_ph_der;

        function s_props_ph  "Specific entropy as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := properties.s;
          annotation(derivative(noDerivative = properties) = s_ph_der, Inline = false, LateInline = true); 
        end s_props_ph;

        function s_ph  "Specific entropy as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end s_ph;

        function s_ph_der  "Specific entropy as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase properties "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real h_der "Derivative of specific enthalpy";
          output Real s_der "Derivative of entropy";
        algorithm
          s_der := (-1 / (properties.rho * properties.T) * p_der) + 1 / properties.T * h_der;
          annotation(Inline = true); 
        end s_ph_der;

        function cv_props_ph  "Specific heat capacity at constant volume as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation(Inline = false, LateInline = true); 
        end cv_props_ph;

        function cv_ph  "Specific heat capacity at constant volume as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end cv_ph;

        function cp_props_ph  "Specific heat capacity at constant pressure as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := aux.cp;
          annotation(Inline = false, LateInline = true); 
        end cp_props_ph;

        function cp_ph  "Specific heat capacity at constant pressure as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end cp_ph;

        function beta_props_ph  "Isobaric expansion coefficient as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 or aux.region == 4 then aux.pt / (aux.rho * aux.pd) else aux.vt * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end beta_props_ph;

        function beta_ph  "Isobaric expansion coefficient as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end beta_ph;

        function kappa_props_ph  "Isothermal compressibility factor as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 or aux.region == 4 then 1 / (aux.rho * aux.pd) else -aux.vp * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end kappa_props_ph;

        function kappa_ph  "Isothermal compressibility factor as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end kappa_ph;

        function velocityOfSound_props_ph  "Speed of sound as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd * aux.rho * aux.rho * aux.cv + aux.pt * aux.pt * aux.T) / (aux.rho * aux.rho * aux.cv))) else if aux.region == 4 then sqrt(max(0, 1 / (aux.rho * (aux.rho * aux.cv / aux.dpT + 1.0) / (aux.dpT * aux.T) - 1 / aux.rho * aux.rho * aux.rho / (aux.dpT * aux.T)))) else sqrt(max(0, -aux.cp / (aux.rho * aux.rho * (aux.vp * aux.cp + aux.vt * aux.vt * aux.T))));
          annotation(Inline = false, LateInline = true); 
        end velocityOfSound_props_ph;

        function velocityOfSound_ph  
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end velocityOfSound_ph;

        function isentropicExponent_props_ph  "Isentropic exponent as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1 / (aux.rho * p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt * aux.T) / aux.cv) else if aux.region == 4 then 1 / (aux.rho * p) * aux.dpT * aux.dpT * aux.T / aux.cv else -1 / (aux.rho * aux.p) * aux.cp / (aux.vp * aux.cp + aux.vt * aux.vt * aux.T);
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_props_ph;

        function isentropicExponent_ph  "Isentropic exponent as function of pressure and specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_ph(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_ph;

        function ddph_props  "Density derivative by pressure" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.DerDensityByPressure ddph "Density derivative by pressure";
        algorithm
          ddph := if aux.region == 3 then aux.rho * (aux.cv * aux.rho + aux.pt) / (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) else if aux.region == 4 then aux.rho * (aux.rho * aux.cv / aux.dpT + 1.0) / (aux.dpT * aux.T) else -aux.rho * aux.rho * (aux.vp * aux.cp - aux.vt / aux.rho + aux.T * aux.vt * aux.vt) / aux.cp;
          annotation(Inline = false, LateInline = true); 
        end ddph_props;

        function ddph  "Density derivative by pressure" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.DerDensityByPressure ddph "Density derivative by pressure";
        algorithm
          ddph := ddph_props(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end ddph;

        function ddhp_props  "Density derivative by specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.DerDensityByEnthalpy ddhp "Density derivative by specific enthalpy";
        algorithm
          ddhp := if aux.region == 3 then -aux.rho * aux.rho * aux.pt / (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) else if aux.region == 4 then -aux.rho * aux.rho / (aux.dpT * aux.T) else -aux.rho * aux.rho * aux.vt / aux.cp;
          annotation(Inline = false, LateInline = true); 
        end ddhp_props;

        function ddhp  "Density derivative by specific enthalpy" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.DerDensityByEnthalpy ddhp "Density derivative by specific enthalpy";
        algorithm
          ddhp := ddhp_props(p, h, waterBaseProp_ph(p, h, phase, region));
          annotation(Inline = true); 
        end ddhp;

        function waterBaseProp_pT  "Intermediate property record for water (p and T preferred states)" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
        algorithm
          aux.phase := 1;
          aux.region := if region == 0 then BaseIF97.Regions.region_pT(p = p, T = T) else region;
          aux.R := BaseIF97.data.RH2O;
          aux.p := p;
          aux.T := T;
          aux.vt := 0.0 "initialized in case it is not needed";
          aux.vp := 0.0 "initialized in case it is not needed";
          if aux.region == 1 then
            g := BaseIF97.Basic.g1(p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 0.0;
            aux.dpT := -aux.vt / aux.vp;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
          elseif aux.region == 2 then
            g := BaseIF97.Basic.g2(p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 1.0;
            aux.dpT := -aux.vt / aux.vp;
          elseif aux.region == 3 then
            (aux.rho, error) := BaseIF97.Inverses.dofpt3(p = p, T = T, delp = 1.0e-7);
            f := BaseIF97.Basic.f3(aux.rho, T);
            aux.h := aux.R * T * (f.tau * f.ftau + f.delta * f.fdelta);
            aux.s := aux.R * (f.tau * f.ftau - f.f);
            aux.pd := aux.R * T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
            aux.pt := aux.R * aux.rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
            aux.cv := aux.R * (-f.tau * f.tau * f.ftautau);
            aux.x := 0.0;
            aux.dpT := aux.pt;
          elseif aux.region == 5 then
            g := BaseIF97.Basic.g5(p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (p * p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 1.0;
            aux.dpT := -aux.vt / aux.vp;
          else
            assert(false, "Error in region computation of IF97 steam tables" + "(p = " + String(p) + ", T = " + String(T) + ")");
          end if;
        end waterBaseProp_pT;

        function rho_props_pT  "Density as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := aux.rho;
          annotation(derivative(noDerivative = aux) = rho_pT_der, Inline = false, LateInline = true); 
        end rho_props_pT;

        function rho_pT  "Density as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Density rho "Density";
        algorithm
          rho := rho_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end rho_pT;

        function h_props_pT  "Specific enthalpy as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation(derivative(noDerivative = aux) = h_pT_der, Inline = false, LateInline = true); 
        end h_props_pT;

        function h_pT  "Specific enthalpy as function or pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end h_pT;

        function h_pT_der  "Derivative function of h_pT" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          output Real h_der "Derivative of specific enthalpy";
        algorithm
          if aux.region == 3 then
            h_der := ((-aux.rho * aux.pd) + T * aux.pt) / (aux.rho * aux.rho * aux.pd) * p_der + (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * aux.rho * aux.pd) * T_der;
          else
            h_der := (1 / aux.rho - aux.T * aux.vt) * p_der + aux.cp * T_der;
          end if;
        end h_pT_der;

        function rho_pT_der  "Derivative function of rho_pT" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Derivative of pressure";
          input Real T_der "Derivative of temperature";
          output Real rho_der "Derivative of density";
        algorithm
          if aux.region == 3 then
            rho_der := 1 / aux.pd * p_der - aux.pt / aux.pd * T_der;
          else
            rho_der := (-aux.rho * aux.rho * aux.vp) * p_der + (-aux.rho * aux.rho * aux.vt) * T_der;
          end if;
        end rho_pT_der;

        function s_props_pT  "Specific entropy as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := aux.s;
          annotation(Inline = false, LateInline = true); 
        end s_props_pT;

        function s_pT  "Temperature as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end s_pT;

        function cv_props_pT  "Specific heat capacity at constant volume as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation(Inline = false, LateInline = true); 
        end cv_props_pT;

        function cv_pT  "Specific heat capacity at constant volume as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end cv_pT;

        function cp_props_pT  "Specific heat capacity at constant pressure as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := if aux.region == 3 then (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * aux.rho * aux.pd) else aux.cp;
          annotation(Inline = false, LateInline = true); 
        end cp_props_pT;

        function cp_pT  "Specific heat capacity at constant pressure as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end cp_pT;

        function beta_props_pT  "Isobaric expansion coefficient as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 then aux.pt / (aux.rho * aux.pd) else aux.vt * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end beta_props_pT;

        function beta_pT  "Isobaric expansion coefficient as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end beta_pT;

        function kappa_props_pT  "Isothermal compressibility factor as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 then 1 / (aux.rho * aux.pd) else -aux.vp * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end kappa_props_pT;

        function kappa_pT  "Isothermal compressibility factor as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end kappa_pT;

        function velocityOfSound_props_pT  "Speed of sound as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd * aux.rho * aux.rho * aux.cv + aux.pt * aux.pt * aux.T) / (aux.rho * aux.rho * aux.cv))) else sqrt(max(0, -aux.cp / (aux.rho * aux.rho * (aux.vp * aux.cp + aux.vt * aux.vt * aux.T))));
          annotation(Inline = false, LateInline = true); 
        end velocityOfSound_props_pT;

        function velocityOfSound_pT  "Speed of sound as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = true); 
        end velocityOfSound_pT;

        function isentropicExponent_props_pT  "Isentropic exponent as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1 / (aux.rho * p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt * aux.T) / aux.cv) else -1 / (aux.rho * aux.p) * aux.cp / (aux.vp * aux.cp + aux.vt * aux.vt * aux.T);
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_props_pT;

        function isentropicExponent_pT  "Isentropic exponent as function of pressure and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_pT(p, T, waterBaseProp_pT(p, T, region));
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_pT;

        function waterBaseProp_dT  "Intermediate property record for water (d and T preferred states)" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density rho "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "Phase: 2 for two-phase, 1 for one phase, 0 if unknown";
          input Integer region = 0 "If 0, do region computation, otherwise assume the region is this input";
          output Common.IF97BaseTwoPhase aux "Auxiliary record";
        protected
          .Modelica.SIunits.SpecificEnthalpy h_liq "Liquid specific enthalpy";
          .Modelica.SIunits.Density d_liq "Liquid density";
          .Modelica.SIunits.SpecificEnthalpy h_vap "Vapour specific enthalpy";
          .Modelica.SIunits.Density d_vap "Vapour density";
          Common.GibbsDerivs g "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Common.HelmholtzDerivs f "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.PhaseBoundaryProperties liq "Phase boundary property record";
          Modelica.Media.Common.PhaseBoundaryProperties vap "Phase boundary property record";
          Modelica.Media.Common.GibbsDerivs gl "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.GibbsDerivs gv "Dimensionless Gibbs function and derivatives w.r.t. pi and tau";
          Modelica.Media.Common.HelmholtzDerivs fl "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Modelica.Media.Common.HelmholtzDerivs fv "Dimensionless Helmholtz function and derivatives w.r.t. delta and tau";
          Integer error "Error flag for inverse iterations";
        algorithm
          aux.region := if region == 0 then if phase == 2 then 4 else BaseIF97.Regions.region_dT(d = rho, T = T, phase = phase) else region;
          aux.phase := if aux.region == 4 then 2 else 1;
          aux.R := BaseIF97.data.RH2O;
          aux.rho := rho;
          aux.T := T;
          aux.vt := 0.0 "initialized in case it is not needed";
          aux.vp := 0.0 "initialized in case it is not needed";
          if aux.region == 1 then
            (aux.p, error) := BaseIF97.Inverses.pofdt125(d = rho, T = T, reldd = 1.0e-8, region = 1);
            g := BaseIF97.Basic.g1(aux.p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := aux.p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / aux.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (aux.p * aux.p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 0.0;
          elseif aux.region == 2 then
            (aux.p, error) := BaseIF97.Inverses.pofdt125(d = rho, T = T, reldd = 1.0e-8, region = 2);
            g := BaseIF97.Basic.g2(aux.p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := aux.p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / aux.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (aux.p * aux.p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
            aux.x := 1.0;
          elseif aux.region == 3 then
            f := BaseIF97.Basic.f3(rho, T);
            aux.p := aux.R * rho * T * f.delta * f.fdelta;
            aux.h := aux.R * T * (f.tau * f.ftau + f.delta * f.fdelta);
            aux.s := aux.R * (f.tau * f.ftau - f.f);
            aux.pd := aux.R * T * f.delta * (2.0 * f.fdelta + f.delta * f.fdeltadelta);
            aux.pt := aux.R * rho * f.delta * (f.fdelta - f.tau * f.fdeltatau);
            aux.cv := aux.R * (-f.tau * f.tau * f.ftautau);
            aux.cp := (aux.rho * aux.rho * aux.pd * aux.cv + aux.T * aux.pt * aux.pt) / (aux.rho * aux.rho * aux.pd);
            aux.x := 0.0;
          elseif aux.region == 4 then
            aux.p := BaseIF97.Basic.psat(T);
            d_liq := rhol_T(T);
            d_vap := rhov_T(T);
            h_liq := hl_p(aux.p);
            h_vap := hv_p(aux.p);
            aux.x := if d_vap <> d_liq then (1 / rho - 1 / d_liq) / (1 / d_vap - 1 / d_liq) else 1.0;
            aux.h := h_liq + aux.x * (h_vap - h_liq);
            if T < BaseIF97.data.TLIMIT1 then
              gl := BaseIF97.Basic.g1(aux.p, T);
              gv := BaseIF97.Basic.g2(aux.p, T);
              liq := Common.gibbsToBoundaryProps(gl);
              vap := Common.gibbsToBoundaryProps(gv);
            else
              fl := BaseIF97.Basic.f3(d_liq, T);
              fv := BaseIF97.Basic.f3(d_vap, T);
              liq := Common.helmholtzToBoundaryProps(fl);
              vap := Common.helmholtzToBoundaryProps(fv);
            end if;
            aux.dpT := if liq.d <> vap.d then (vap.s - liq.s) * liq.d * vap.d / (liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
            aux.s := liq.s + aux.x * (vap.s - liq.s);
            aux.cv := Common.cv2Phase(liq, vap, aux.x, aux.T, aux.p);
            aux.cp := liq.cp + aux.x * (vap.cp - liq.cp);
            aux.pt := liq.pt + aux.x * (vap.pt - liq.pt);
            aux.pd := liq.pd + aux.x * (vap.pd - liq.pd);
          elseif aux.region == 5 then
            (aux.p, error) := BaseIF97.Inverses.pofdt125(d = rho, T = T, reldd = 1.0e-8, region = 5);
            g := BaseIF97.Basic.g2(aux.p, T);
            aux.h := aux.R * aux.T * g.tau * g.gtau;
            aux.s := aux.R * (g.tau * g.gtau - g.g);
            aux.rho := aux.p / (aux.R * T * g.pi * g.gpi);
            aux.vt := aux.R / aux.p * (g.pi * g.gpi - g.tau * g.pi * g.gtaupi);
            aux.vp := aux.R * T / (aux.p * aux.p) * g.pi * g.pi * g.gpipi;
            aux.pt := -g.p / g.T * (g.gpi - g.tau * g.gtaupi) / (g.gpipi * g.pi);
            aux.pd := -g.R * g.T * g.gpi * g.gpi / g.gpipi;
            aux.cp := -aux.R * g.tau * g.tau * g.gtautau;
            aux.cv := aux.R * ((-g.tau * g.tau * g.gtautau) + (g.gpi - g.tau * g.gtaupi) * (g.gpi - g.tau * g.gtaupi) / g.gpipi);
          else
            assert(false, "Error in region computation of IF97 steam tables" + "(rho = " + String(rho) + ", T = " + String(T) + ")");
          end if;
        end waterBaseProp_dT;

        function h_props_dT  "Specific enthalpy as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := aux.h;
          annotation(derivative(noDerivative = aux) = h_dT_der, Inline = false, LateInline = true); 
        end h_props_dT;

        function h_dT  "Specific enthalpy as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := h_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end h_dT;

        function h_dT_der  "Derivative function of h_dT" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real d_der "Derivative of density";
          input Real T_der "Derivative of temperature";
          output Real h_der "Derivative of specific enthalpy";
        algorithm
          if aux.region == 3 then
            h_der := ((-d * aux.pd) + T * aux.pt) / (d * d) * d_der + (aux.cv * d + aux.pt) / d * T_der;
          elseif aux.region == 4 then
            h_der := T * aux.dpT / (d * d) * d_der + (aux.cv * d + aux.dpT) / d * T_der;
          else
            h_der := (-((-1 / d) + T * aux.vt) / (d * d * aux.vp)) * d_der + (aux.vp * aux.cp - aux.vt / d + T * aux.vt * aux.vt) / aux.vp * T_der;
          end if;
        end h_dT_der;

        function p_props_dT  "Pressure as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.Pressure p "Pressure";
        algorithm
          p := aux.p;
          annotation(derivative(noDerivative = aux) = p_dT_der, Inline = false, LateInline = true); 
        end p_props_dT;

        function p_dT  "Pressure as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Pressure p "Pressure";
        algorithm
          p := p_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end p_dT;

        function p_dT_der  "Derivative function of p_dT" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real d_der "Derivative of density";
          input Real T_der "Derivative of temperature";
          output Real p_der "Derivative of pressure";
        algorithm
          if aux.region == 3 then
            p_der := aux.pd * d_der + aux.pt * T_der;
          elseif aux.region == 4 then
            p_der := aux.dpT * T_der;
          else
            p_der := (-1 / (d * d * aux.vp)) * d_der + (-aux.vt / aux.vp) * T_der;
          end if;
        end p_dT_der;

        function s_props_dT  "Specific entropy as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := aux.s;
          annotation(Inline = false, LateInline = true); 
        end s_props_dT;

        function s_dT  "Temperature as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        algorithm
          s := s_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end s_dT;

        function cv_props_dT  "Specific heat capacity at constant volume as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := aux.cv;
          annotation(Inline = false, LateInline = true); 
        end cv_props_dT;

        function cv_dT  "Specific heat capacity at constant volume as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity";
        algorithm
          cv := cv_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end cv_dT;

        function cp_props_dT  "Specific heat capacity at constant pressure as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := aux.cp;
          annotation(Inline = false, LateInline = true); 
        end cp_props_dT;

        function cp_dT  "Specific heat capacity at constant pressure as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity";
        algorithm
          cp := cp_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end cp_dT;

        function beta_props_dT  "Isobaric expansion coefficient as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := if aux.region == 3 or aux.region == 4 then aux.pt / (aux.rho * aux.pd) else aux.vt * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end beta_props_dT;

        function beta_dT  "Isobaric expansion coefficient as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.RelativePressureCoefficient beta "Isobaric expansion coefficient";
        algorithm
          beta := beta_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end beta_dT;

        function kappa_props_dT  "Isothermal compressibility factor as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := if aux.region == 3 or aux.region == 4 then 1 / (aux.rho * aux.pd) else -aux.vp * aux.rho;
          annotation(Inline = false, LateInline = true); 
        end kappa_props_dT;

        function kappa_dT  "Isothermal compressibility factor as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.IsothermalCompressibility kappa "Isothermal compressibility factor";
        algorithm
          kappa := kappa_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end kappa_dT;

        function velocityOfSound_props_dT  "Speed of sound as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := if aux.region == 3 then sqrt(max(0, (aux.pd * aux.rho * aux.rho * aux.cv + aux.pt * aux.pt * aux.T) / (aux.rho * aux.rho * aux.cv))) else if aux.region == 4 then sqrt(max(0, 1 / (aux.rho * (aux.rho * aux.cv / aux.dpT + 1.0) / (aux.dpT * aux.T) - 1 / aux.rho * aux.rho * aux.rho / (aux.dpT * aux.T)))) else sqrt(max(0, -aux.cp / (aux.rho * aux.rho * (aux.vp * aux.cp + aux.vt * aux.vt * aux.T))));
          annotation(Inline = false, LateInline = true); 
        end velocityOfSound_props_dT;

        function velocityOfSound_dT  "Speed of sound as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.Velocity v_sound "Speed of sound";
        algorithm
          v_sound := velocityOfSound_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = true); 
        end velocityOfSound_dT;

        function isentropicExponent_props_dT  "Isentropic exponent as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := if aux.region == 3 then 1 / (aux.rho * aux.p) * ((aux.pd * aux.cv * aux.rho * aux.rho + aux.pt * aux.pt * aux.T) / aux.cv) else if aux.region == 4 then 1 / (aux.rho * aux.p) * aux.dpT * aux.dpT * aux.T / aux.cv else -1 / (aux.rho * aux.p) * aux.cp / (aux.vp * aux.cp + aux.vt * aux.vt * aux.T);
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_props_dT;

        function isentropicExponent_dT  "Isentropic exponent as function of density and temperature" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Density d "Density";
          input .Modelica.SIunits.Temperature T "Temperature";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output Real gamma "Isentropic exponent";
        algorithm
          gamma := isentropicExponent_props_dT(d, T, waterBaseProp_dT(d, T, phase, region));
          annotation(Inline = false, LateInline = true); 
        end isentropicExponent_dT;

        function hl_p = BaseIF97.Regions.hl_p "Compute the saturated liquid specific h(p)";
        function hv_p = BaseIF97.Regions.hv_p "Compute the saturated vapour specific h(p)";
        function rhol_T = BaseIF97.Regions.rhol_T "Compute the saturated liquid d(T)";
        function rhov_T = BaseIF97.Regions.rhov_T "Compute the saturated vapour d(T)";
        function dynamicViscosity = BaseIF97.Transport.visc_dTp "Compute eta(d,T) in the one-phase region";
        function thermalConductivity = BaseIF97.Transport.cond_dTp "Compute lambda(d,T,p) in the one-phase region";
        function surfaceTension = BaseIF97.Transport.surfaceTension "Compute sigma(T) at saturation T";

        function isentropicEnthalpy  "Isentropic specific enthalpy from p,s (preferably use dynamicIsentropicEnthalpy in dynamic simulation!)" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Integer phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          input Integer region = 0 "If 0, region is unknown, otherwise known and this input";
          output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        algorithm
          h := isentropicEnthalpy_props(p, s, waterBaseProp_ps(p, s, phase, region));
          annotation(Inline = true); 
        end isentropicEnthalpy;

        function isentropicEnthalpy_props  
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          output .Modelica.SIunits.SpecificEnthalpy h "Isentropic enthalpy";
        algorithm
          h := aux.h;
          annotation(derivative(noDerivative = aux) = isentropicEnthalpy_der, Inline = false, LateInline = true); 
        end isentropicEnthalpy_props;

        function isentropicEnthalpy_der  "Derivative of isentropic specific enthalpy from p,s" 
          extends Modelica.Icons.Function;
          input .Modelica.SIunits.Pressure p "Pressure";
          input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
          input Common.IF97BaseTwoPhase aux "Auxiliary record";
          input Real p_der "Pressure derivative";
          input Real s_der "Entropy derivative";
          output Real h_der "Specific enthalpy derivative";
        algorithm
          h_der := 1 / aux.rho * p_der + aux.T * s_der;
          annotation(Inline = true); 
        end isentropicEnthalpy_der;
      end IF97_Utilities;
    end Water;
  end Media;

  package Thermal  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow" 
    extends Modelica.Icons.Package;

    package HeatTransfer  "Library of 1-dimensional heat transfer with lumped elements" 
      extends Modelica.Icons.Package;

      package Interfaces  "Connectors and partial models" 
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  "Thermal port for 1-dim. heat transfer" 
          Modelica.SIunits.Temperature T "Port temperature";
          flow Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
        end HeatPort;

        connector HeatPort_a  "Thermal port for 1-dim. heat transfer (filled rectangular icon)" 
          extends HeatPort;
        end HeatPort_a;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

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
          Integer n = size(A, 1);
          Integer nrhs = 1;
          Real[size(A, 1), size(A, 1)] Awork = A;
          Integer lda = max(1, size(A, 1));
          Integer ldb = max(1, size(b, 1));
          Integer[size(A, 1)] ipiv;
          external "FORTRAN 77" dgesv(n, nrhs, Awork, lda, ipiv, x, ldb, info) annotation(Library = "lapack");
        end dgesv_vec;
      end LAPACK;
    end Matrices;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  "Basic icon for mathematical function with y-axis on left side" end AxisLeft;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function acos  "Inverse cosine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = acos(u);
    end acos;

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
      extends Modelica.Icons.FunctionsPackage;

      function error  "Print error message and cancel all actions" 
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string) annotation(Library = "ModelicaExternalC");
      end error;
    end Streams;
  end Utilities;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = ModelicaServices.Machine.inf "Biggest Real number such that inf and -inf are representable on the machine";
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant .Modelica.SIunits.Acceleration g_n = 9.80665 "Standard acceleration of gravity on earth";
    final constant Real R(final unit = "J/(mol.K)") = 8.3144598 "Molar gas constant (previous value: 8.314472)";
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

    partial package BasesPackage  "Icon for packages containing base classes" 
      extends Modelica.Icons.Package;
    end BasesPackage;

    partial package VariantsPackage  "Icon for package containing variants" 
      extends Modelica.Icons.Package;
    end VariantsPackage;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package SensorsPackage  "Icon for packages containing sensors" 
      extends Modelica.Icons.Package;
    end SensorsPackage;

    partial package UtilitiesPackage  "Icon for utility packages" 
      extends Modelica.Icons.Package;
    end UtilitiesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package FunctionsPackage  "Icon for packages containing functions" 
      extends Modelica.Icons.Package;
    end FunctionsPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package MaterialPropertiesPackage  "Icon for package containing property classes" 
      extends Modelica.Icons.Package;
    end MaterialPropertiesPackage;

    partial class RotationalSensor  "Icon representing a round measurement device" end RotationalSensor;

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
        type AngularVelocity_rpm = Real(final quantity = "AngularVelocity", final unit = "rev/min") "Angular velocity in revolutions per minute. Alias unit names that are outside of the SI system: rpm, r/min, rev/min";
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
    type Length = Real(final quantity = "Length", final unit = "m");
    type Position = Length;
    type Distance = Length(min = 0);
    type Height = Length(min = 0);
    type Area = Real(final quantity = "Area", final unit = "m2");
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type SpecificVolume = Real(final quantity = "SpecificVolume", final unit = "m3/kg", min = 0.0);
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5);
    type PressureDifference = Pressure;
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
    type SurfaceTension = Real(final quantity = "SurfaceTension", final unit = "N/m");
    type Energy = Real(final quantity = "Energy", final unit = "J");
    type Power = Real(final quantity = "Power", final unit = "W");
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type VolumeFlowRate = Real(final quantity = "VolumeFlowRate", final unit = "m3/s");
    type MomentumFlux = Real(final quantity = "MomentumFlux", final unit = "N");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
    type Temp_K = ThermodynamicTemperature;
    type Temperature = ThermodynamicTemperature;
    type RelativePressureCoefficient = Real(final quantity = "RelativePressureCoefficient", final unit = "1/K");
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type CoefficientOfHeatTransfer = Real(final quantity = "CoefficientOfHeatTransfer", final unit = "W/(m2.K)");
    type HeatCapacity = Real(final quantity = "HeatCapacity", final unit = "J/K");
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
    type PerUnit = Real(unit = "1");
  end SIunits;
  annotation(version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z"); 
end Modelica;

model ClosedLoop_total
  extends ThermoPower.Examples.RankineCycle.Simulators.ClosedLoop;
 annotation(experiment(StopTime = 3000, Tolerance = 1e-006), experimentSetupOutput(equdistant = false));
end ClosedLoop_total;
