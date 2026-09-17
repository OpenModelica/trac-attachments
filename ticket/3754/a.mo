package Modelica
  package Media
    package Interfaces
      partial package PartialMedium
        extends Modelica.Media.Interfaces.Types;
        constant Boolean reducedX = true;
        constant MassFraction[nX] reference_X = fill(1 / nX, nX);
        constant Temperature T_default = 20;
        constant MassFraction[nX] X_default = reference_X;
        final constant Integer nS = 2;
        constant Integer nX = 2;
        constant Integer nXi = if reducedX then nS - 1 else nS;

        replaceable record ThermodynamicState  end ThermodynamicState;

        replaceable partial function setState_pTX
          input AbsolutePressure p;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        end setState_pTX;
      end PartialMedium;

      partial package PartialMixtureMedium
        extends PartialMedium;

        redeclare replaceable record extends ThermodynamicState
          AbsolutePressure p;
          Temperature T;
          MassFraction[nX] X;
        end ThermodynamicState;
      end PartialMixtureMedium;

      partial package PartialCondensingGases
        extends PartialMixtureMedium;
      end PartialCondensingGases;

      package Types
        type AbsolutePressure = .Modelica.SIunits.AbsolutePressure(min = 0, max = 1.e8, nominal = 1.e5, start = 1.e5);
        type MassFraction = Real(quantity = "MassFraction", final unit = "kg/kg", min = 0, max = 1, nominal = 0.1);
        type Temperature = .Modelica.SIunits.Temperature(min = 1, max = 1.e4, nominal = 300, start = 300);
        type ExtraProperty = Real(min = 0.0, start = 1.0);
      end Types;
    end Interfaces;

    package Air
      package MoistAir
        extends .Modelica.Media.Interfaces.PartialCondensingGases(final reducedX = true, reference_X = {0.01, 0.99});

        redeclare function setState_pTX
          input AbsolutePressure p;
          input Temperature T;
          input MassFraction[:] X = reference_X;
          output ThermodynamicState state;
        algorithm
          state := if size(X, 1) == nX then ThermodynamicState(p = p, T = T, X = X) else ThermodynamicState(p = p, T = T, X = cat(1, X, {1 - sum(X)}));
        end setState_pTX;
      end MoistAir;
    end Air;
  end Media;

  package SIunits
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5);
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC");
    type Temperature = ThermodynamicTemperature;
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1);
  end SIunits;
end Modelica;

package Buildings
  package Fluid
    package MixingVolumes
      model MixingVolume
        extends Buildings.Fluid.MixingVolumes.BaseClasses.PartialMixingVolume;
      end MixingVolume;

      package BaseClasses
        partial model PartialMixingVolume
          extends Buildings.Fluid.Interfaces.LumpedVolumeDeclarations;
          parameter Boolean homotopyInitialization = true annotation(Evaluate = true);
          parameter Modelica.SIunits.Volume V;
          parameter Boolean prescribedHeatFlowRate = false annotation(Evaluate = true);
          Modelica.SIunits.Temperature T;
          Modelica.SIunits.Pressure p;
          Modelica.SIunits.MassFraction[Medium.nXi] Xi;
        protected
          parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(T = T_start, p = p_start, X = X_start[1:Medium.nXi]);
        end PartialMixingVolume;
      end BaseClasses;
    end MixingVolumes;

    package Interfaces
      record LumpedVolumeDeclarations
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
        parameter Medium.AbsolutePressure p_start = 100;
        parameter Medium.Temperature T_start = Medium.T_default;
        parameter Medium.MassFraction[Medium.nX] X_start = Medium.X_default;
      end LumpedVolumeDeclarations;
    end Interfaces;
  end Fluid;

  package Media
    package GasesPTDecoupled
      package MoistAirUnsaturated
        extends Modelica.Media.Interfaces.PartialCondensingGases(reference_X = {0.01, 0.99});

        redeclare function setState_pTX
          extends Buildings.Media.PerfectGases.MoistAir.setState_pTX;
        end setState_pTX;
      end MoistAirUnsaturated;
    end GasesPTDecoupled;

    package PerfectGases
      package MoistAir
        extends Modelica.Media.Interfaces.PartialCondensingGases(reference_X = {0.01, 0.99});

        redeclare function setState_pTX
          extends Modelica.Media.Air.MoistAir.setState_pTX;
        end setState_pTX;
      end MoistAir;
    end PerfectGases;
  end Media;

  package Examples
    package Tutorial
      package Boiler
        model System2
          replaceable package MediumA = Buildings.Media.GasesPTDecoupled.MoistAirUnsaturated;
          Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = MediumA);
        end System2;
      end Boiler;
    end Tutorial;
  end Examples;
end Buildings;

model System2_total
  extends Buildings.Examples.Tutorial.Boiler.System2;
end System2_total;
