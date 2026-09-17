package ModelicaServices
  package Machine
    final constant Real eps = 1.e-15;
    final constant Real small = 1.e-60;
    final constant Real inf = 1.e+60;
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax();
  end Machine;
end ModelicaServices;

package Modelica
  package Blocks
    package Continuous
      block Derivative
        parameter Real k(unit = "1") = 1;
        parameter .Modelica.SIunits.Time T(min = Modelica.Constants.small) = 0.01;
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit;
        parameter Real x_start = 0;
        parameter Real y_start = 0;
        extends .Modelica.Blocks.Interfaces.SISO;
        output Real x(start = x_start);
      protected
        parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(x) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState then
          x = x_start;
        elseif initType == .Modelica.Blocks.Types.Init.InitialOutput then
          if zeroGain then
            x = u;
          else
            y = y_start;
          end if;
        end if;
      equation
        der(x) = if zeroGain then 0 else (u - x) / T;
        y = if zeroGain then 0 else k / T * (u - x);
      end Derivative;

      block FirstOrder
        parameter Real k(unit = "1") = 1;
        parameter .Modelica.SIunits.Time T(start = 1);
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit;
        parameter Real y_start = 0;
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

      block PI
        parameter Real k(unit = "1") = 1;
        parameter .Modelica.SIunits.Time T(start = 1, min = Modelica.Constants.small);
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit;
        parameter Real x_start = 0;
        parameter Real y_start = 0;
        extends .Modelica.Blocks.Interfaces.SISO;
        output Real x(start = x_start);
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(x) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState then
          x = x_start;
        elseif initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(x) = u / T;
        y = k * (x + u);
      end PI;
    end Continuous;

    package Interfaces
      connector RealInput = input Real;
      connector RealOutput = output Real;

      partial block SO
        RealOutput y;
      end SO;

      partial block MO
        parameter Integer nout(min = 1) = 1;
        RealOutput[nout] y;
      end MO;

      partial block SISO
        RealInput u;
        RealOutput y;
      end SISO;

      partial block SI2SO
        RealInput u1;
        RealInput u2;
        RealOutput y;
      end SI2SO;

      partial block MIMO
        parameter Integer nin = 1;
        parameter Integer nout = 1;
        RealInput[nin] u;
        RealOutput[nout] y;
      end MIMO;

      partial block MIMOs
        parameter Integer n = 1;
        RealInput[n] u;
        RealOutput[n] y;
      end MIMOs;

      partial block SignalSource
        extends SO;
        parameter Real offset = 0;
        parameter .Modelica.SIunits.Time startTime = 0;
      end SignalSource;
    end Interfaces;

    package Math
      block Gain
        parameter Real k(start = 1, unit = "1");
        .Modelica.Blocks.Interfaces.RealInput u;
        .Modelica.Blocks.Interfaces.RealOutput y;
      equation
        y = k * u;
      end Gain;

      block Feedback
        .Modelica.Blocks.Interfaces.RealInput u1;
        .Modelica.Blocks.Interfaces.RealInput u2;
        .Modelica.Blocks.Interfaces.RealOutput y;
      equation
        y = u1 - u2;
      end Feedback;

      block Add
        extends .Modelica.Blocks.Interfaces.SI2SO;
        parameter Real k1 = +1;
        parameter Real k2 = +1;
      equation
        y = k1 * u1 + k2 * u2;
      end Add;
    end Math;

    package Nonlinear
      block SlewRateLimiter
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Modelica.SIunits.DampingCoefficient Rising(min = .Modelica.Constants.small) = 1;
        parameter Modelica.SIunits.DampingCoefficient Falling(min = -.Modelica.Constants.small) = -Rising;
        parameter Modelica.SIunits.Time Td(min = .Modelica.Constants.small) = 0.001;
        parameter Boolean strict = false;
      initial equation
        y = u;
      equation
        if strict then
          der(y) = smooth(1, noEvent(min(max((u - y) / Td, Falling), Rising)));
        else
          der(y) = smooth(1, min(max((u - y) / Td, Falling), Rising));
        end if;
      end SlewRateLimiter;
    end Nonlinear;

    package Routing
      block DeMultiplex2
        parameter Integer n1 = 1;
        parameter Integer n2 = 1;
        Modelica.Blocks.Interfaces.RealInput[n1 + n2] u;
        Modelica.Blocks.Interfaces.RealOutput[n1] y1;
        Modelica.Blocks.Interfaces.RealOutput[n2] y2;
      equation
        [u] = [y1; y2];
      end DeMultiplex2;
    end Routing;

    package Sources
      block Constant
        parameter Real k(start = 1);
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = k;
      end Constant;

      block Step
        parameter Real height = 1;
        extends .Modelica.Blocks.Interfaces.SignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
      end Step;
    end Sources;

    package Types
      type Init = enumeration(NoInit, SteadyState, InitialState, InitialOutput);
    end Types;
  end Blocks;

  package Electrical
    package Analog
      package Basic
        model Ground
          Interfaces.Pin p;
        equation
          p.v = 0;
        end Ground;

        model Resistor
          parameter Modelica.SIunits.Resistance R(start = 1);
          parameter Modelica.SIunits.Temperature T_ref = 300.15;
          parameter Modelica.SIunits.LinearTemperatureCoefficient alpha = 0;
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
          Modelica.SIunits.Resistance R_actual;
        equation
          assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
          R_actual = R * (1 + alpha * (T_heatPort - T_ref));
          v = R_actual * i;
          LossPower = v * i;
        end Resistor;

        model Inductor
          extends Interfaces.OnePort(i(start = 0));
          parameter .Modelica.SIunits.Inductance L(start = 1);
        equation
          L * der(i) = v;
        end Inductor;
      end Basic;

      package Interfaces
        connector Pin
          Modelica.SIunits.Voltage v;
          flow Modelica.SIunits.Current i;
        end Pin;

        connector PositivePin
          Modelica.SIunits.Voltage v;
          flow Modelica.SIunits.Current i;
        end PositivePin;

        connector NegativePin
          Modelica.SIunits.Voltage v;
          flow Modelica.SIunits.Current i;
        end NegativePin;

        partial model OnePort
          .Modelica.SIunits.Voltage v;
          .Modelica.SIunits.Current i;
          PositivePin p;
          NegativePin n;
        equation
          v = p.v - n.v;
          0 = p.i + n.i;
          i = p.i;
        end OnePort;

        partial model ConditionalHeatPort
          parameter Boolean useHeatPort = false;
          parameter Modelica.SIunits.Temperature T = 293.15;
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T(start = T) = T_heatPort, Q_flow = -LossPower) if useHeatPort;
          Modelica.SIunits.Power LossPower;
          Modelica.SIunits.Temperature T_heatPort;
        equation
          if not useHeatPort then
            T_heatPort = T;
          end if;
        end ConditionalHeatPort;
      end Interfaces;

      package Sensors
        model VoltageSensor
          Interfaces.PositivePin p;
          Interfaces.NegativePin n;
          Modelica.Blocks.Interfaces.RealOutput v(unit = "V");
        equation
          p.i = 0;
          n.i = 0;
          v = p.v - n.v;
        end VoltageSensor;

        model CurrentSensor
          Interfaces.PositivePin p;
          Interfaces.NegativePin n;
          Modelica.Blocks.Interfaces.RealOutput i(unit = "A");
        equation
          p.v = n.v;
          p.i = i;
          n.i = -i;
        end CurrentSensor;
      end Sensors;

      package Sources

        model SignalCurrent
          Interfaces.PositivePin p;
          Interfaces.NegativePin n;
          .Modelica.SIunits.Voltage v;
          Modelica.Blocks.Interfaces.RealInput i(unit = "A");
        equation
          v = p.v - n.v;
          0 = p.i + n.i;
          i = p.i;
        end SignalCurrent;
      end Sources;
    end Analog;

    package Machines
      package BasicMachines
        package SynchronousInductionMachines
          model SM_PermanentMagnet
            extends Machines.Interfaces.PartialBasicInductionMachine(Lssigma(start = 0.1 / (2 * pi * fsNominal)), final idq_ss = airGapR.i_ss, final idq_sr = airGapR.i_sr, final idq_rs = airGapR.i_rs, final idq_rr = airGapR.i_rr, redeclare final Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMPM thermalAmbient(final useDamperCage = useDamperCage, final Tr = TrOperational, final Tpm = TpmOperational), redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM thermalPort(final useDamperCage = useDamperCage), redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM internalThermalPort(final useDamperCage = useDamperCage), redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMPM powerBalance(final lossPowerRotorWinding = damperCageLossPower, final lossPowerRotorCore = 0, final lossPowerPermanentMagnet = permanentMagnet.lossPower), statorCore(final w = statorCoreParameters.wRef));
            Modelica.Blocks.Interfaces.RealOutput[2] ir(start = zeros(2), each final quantity = "ElectricCurrent", each final unit = "A") if useDamperCage;
            Modelica.Blocks.Interfaces.RealOutput[2] idq_dr(each stateSelect = StateSelect.prefer, each final quantity = "ElectricCurrent", each final unit = "A") if useDamperCage;
            Machines.BasicMachines.Components.AirGapR airGapR(final p = p, final Lmd = Lmd, final Lmq = Lmq, final m = m);
            final parameter Modelica.SIunits.Temperature TpmOperational = 293.15;
            parameter Modelica.SIunits.Temperature TrOperational(start = 293.15);
            parameter Modelica.SIunits.Voltage VsOpenCircuit(start = 112.3);
            parameter Modelica.SIunits.Inductance Lmd(start = 0.3 / (2 * pi * fsNominal));
            parameter Modelica.SIunits.Inductance Lmq(start = 0.3 / (2 * pi * fsNominal));
            parameter Boolean useDamperCage(start = true);
            parameter Modelica.SIunits.Inductance Lrsigmad(start = 0.05 / (2 * pi * fsNominal));
            parameter Modelica.SIunits.Inductance Lrsigmaq = Lrsigmad;
            parameter Modelica.SIunits.Resistance Rrd(start = 0.04);
            parameter Modelica.SIunits.Resistance Rrq = Rrd;
            parameter Modelica.SIunits.Temperature TrRef(start = 293.15);
            parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start = 0);
            parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(IRef(start = 100), wRef(start = 2 * pi * fsNominal / p));
            Components.PermanentMagnetWithLosses permanentMagnet(final Ie = Ie, final useHeatPort = true, final m = m, final permanentMagnetLossParameters = permanentMagnetLossParameters, final is = is);
            Machines.BasicMachines.Components.DamperCage damperCage(final Lrsigmad = Lrsigmad, final Lrsigmaq = Lrsigmaq, final Rrd = Rrd, final Rrq = Rrq, final T_ref = TrRef, final alpha = Machines.Thermal.convertAlpha(alpha20r, TrRef), final T = TrRef, final useHeatPort = true) if useDamperCage;
          protected
            final parameter Modelica.SIunits.Current Ie = sqrt(2) * VsOpenCircuit / (Lmd * 2 * pi * fsNominal);
            Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final quantity = "Power", final unit = "W");
          equation
            connect(ir, damperCage.i);
            connect(idq_dr, damperCage.i);
            connect(damperCageLossPower, damperCage.lossPower);
            if not useDamperCage then
              damperCageLossPower = 0;
            end if;
            connect(airGapR.spacePhasor_r, damperCage.spacePhasor_r);
            connect(airGapR.spacePhasor_r, permanentMagnet.spacePhasor_r);
            connect(airGapR.support, internalSupport);
            connect(lssigma.spacePhasor_b, airGapR.spacePhasor_s);
            connect(airGapR.flange, inertiaRotor.flange_a);
            connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet);
            connect(permanentMagnet.flange, inertiaRotor.flange_b);
            connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding);
            connect(internalSupport, permanentMagnet.support);
          end SM_PermanentMagnet;
        end SynchronousInductionMachines;

        package Components
          partial model PartialAirGap
            parameter Integer m = 3;
            parameter Integer p(min = 1);
            output Modelica.SIunits.Torque tauElectrical;
            Modelica.SIunits.Angle gamma;
            Modelica.SIunits.Current[2] i_ss;
            Modelica.SIunits.Current[2] i_sr;
            Modelica.SIunits.Current[2] i_rs;
            Modelica.SIunits.Current[2] i_rr;
            Modelica.SIunits.MagneticFlux[2] psi_ms;
            Modelica.SIunits.MagneticFlux[2] psi_mr;
            Real[2, 2] RotationMatrix;
            Modelica.Mechanics.Rotational.Interfaces.Flange_a flange;
            Modelica.Mechanics.Rotational.Interfaces.Flange_a support;
            Machines.Interfaces.SpacePhasor spacePhasor_s;
            Machines.Interfaces.SpacePhasor spacePhasor_r;
          equation
            gamma = p * (flange.phi - support.phi);
            RotationMatrix = {{+cos(gamma), -sin(gamma)}, {+sin(gamma), +cos(gamma)}};
            i_ss = spacePhasor_s.i_;
            i_ss = RotationMatrix * i_sr;
            i_rr = spacePhasor_r.i_;
            i_rs = RotationMatrix * i_rr;
            spacePhasor_s.v_ = der(psi_ms);
            spacePhasor_r.v_ = der(psi_mr);
            tauElectrical = m / 2 * p * (spacePhasor_s.i_[2] * psi_ms[1] - spacePhasor_s.i_[1] * psi_ms[2]);
            flange.tau = -tauElectrical;
            support.tau = tauElectrical;
          end PartialAirGap;

          model AirGapR
            parameter Modelica.SIunits.Inductance Lmd;
            parameter Modelica.SIunits.Inductance Lmq;
            extends PartialAirGap;
            Modelica.SIunits.Current[2] i_mr;
          protected
            parameter Modelica.SIunits.Inductance[2, 2] L = {{Lmd, 0}, {0, Lmq}};
          equation
            i_mr = i_sr + i_rr;
            psi_mr = L * i_mr;
            psi_ms = RotationMatrix * psi_mr;
          end AirGapR;

          model Inductor
            parameter Modelica.SIunits.Inductance[2] L;
            Modelica.SIunits.Voltage[2] v_;
            Modelica.SIunits.Current[2] i_;
            Machines.Interfaces.SpacePhasor spacePhasor_a;
            Machines.Interfaces.SpacePhasor spacePhasor_b;
          equation
            spacePhasor_a.i_ + spacePhasor_b.i_ = zeros(2);
            v_ = spacePhasor_a.v_ - spacePhasor_b.v_;
            i_ = spacePhasor_a.i_;
            v_[1] = L[1] * der(i_[1]);
            v_[2] = L[2] * der(i_[2]);
          end Inductor;

          model DamperCage
            parameter Modelica.SIunits.Inductance Lrsigmad;
            parameter Modelica.SIunits.Inductance Lrsigmaq;
            parameter Modelica.SIunits.Resistance Rrd;
            parameter Modelica.SIunits.Resistance Rrq;
            parameter Modelica.SIunits.Temperature T_ref = 293.15;
            parameter Modelica.SIunits.LinearTemperatureCoefficient alpha = 0;
            extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
            Modelica.SIunits.Resistance Rrd_actual;
            Modelica.SIunits.Resistance Rrq_actual;
            Modelica.Blocks.Interfaces.RealOutput[2] i(each final quantity = "ElectricCurrent", each final unit = "A") = -spacePhasor_r.i_;
            Modelica.Blocks.Interfaces.RealOutput lossPower(final quantity = "Power", final unit = "W") = LossPower;
            Machines.Interfaces.SpacePhasor spacePhasor_r;
          equation
            assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
            Rrd_actual = Rrd * (1 + alpha * (T_heatPort - T_ref));
            Rrq_actual = Rrq * (1 + alpha * (T_heatPort - T_ref));
            spacePhasor_r.v_[1] = Rrd_actual * spacePhasor_r.i_[1] + Lrsigmad * der(spacePhasor_r.i_[1]);
            spacePhasor_r.v_[2] = Rrq_actual * spacePhasor_r.i_[2] + Lrsigmaq * der(spacePhasor_r.i_[2]);
            2 / 3 * LossPower = Rrd_actual * spacePhasor_r.i_[1] * spacePhasor_r.i_[1] + Rrq_actual * spacePhasor_r.i_[2] * spacePhasor_r.i_[2];
          end DamperCage;

          model PermanentMagnet
            parameter Modelica.SIunits.Current Ie;
            Machines.Interfaces.SpacePhasor spacePhasor_r;
          equation
            spacePhasor_r.i_ = {-Ie, 0};
          end PermanentMagnet;

          model PermanentMagnetWithLosses
            extends Machines.BasicMachines.Components.PermanentMagnet;
            extends Machines.Losses.InductionMachines.PermanentMagnetLosses;
          end PermanentMagnetWithLosses;
        end Components;
      end BasicMachines;

      package Sensors
        model VoltageQuasiRMSSensor
          constant Integer m(final min = 1) = 3;
          Modelica.Blocks.Interfaces.RealOutput V(final quantity = "ElectricPotential", final unit = "V");
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m = m);
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m = m);
          Modelica.Blocks.Math.Gain Gain1(final k = 1 / sqrt(2));
          Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1;
          Machines.SpacePhasors.Blocks.ToPolar ToPolar1;
        equation
          connect(plug_p, VoltageSensor1.plug_p);
          connect(VoltageSensor1.plug_n, plug_n);
          connect(VoltageSensor1.v, ToSpacePhasor1.u);
          connect(ToSpacePhasor1.y, ToPolar1.u);
          connect(ToPolar1.y[1], Gain1.u);
          connect(Gain1.y, V);
        end VoltageQuasiRMSSensor;

        model CurrentQuasiRMSSensor
          constant Integer m(final min = 1) = 3;
          Modelica.Blocks.Interfaces.RealOutput I(final quantity = "ElectricCurrent", final unit = "A");
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m = m);
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Electrical.MultiPhase.Sensors.CurrentSensor CurrentSensor1(final m = m);
          Modelica.Blocks.Math.Gain Gain1(final k = 1 / sqrt(2));
          Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasor1;
          Machines.SpacePhasors.Blocks.ToPolar ToPolar1;
        equation
          connect(plug_p, CurrentSensor1.plug_p);
          connect(CurrentSensor1.plug_n, plug_n);
          connect(CurrentSensor1.i, ToSpacePhasor1.u);
          connect(ToSpacePhasor1.y, ToPolar1.u);
          connect(ToPolar1.y[1], Gain1.u);
          connect(Gain1.y, I);
        end CurrentQuasiRMSSensor;

        model RotorDisplacementAngle
          constant Integer m = 3;
          parameter Integer p(min = 1);
          parameter Boolean useSupport = false;
          Modelica.Blocks.Interfaces.RealOutput rotorDisplacementAngle(final quantity = "Angle", final unit = "rad");
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m = m);
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Electrical.MultiPhase.Sensors.VoltageSensor VoltageSensor1(final m = m);
          Machines.SpacePhasors.Blocks.ToSpacePhasor ToSpacePhasorVS;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange;
          Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relativeAngleSensor;
          Modelica.Blocks.Sources.Constant constant_(final k = Modelica.Constants.pi / 2);
          Modelica.Blocks.Math.Add add(final k2 = 1, final k1 = p);
          Machines.SpacePhasors.Blocks.Rotator rotatorVS2R;
          Machines.SpacePhasors.Blocks.ToPolar ToPolarVSR;
          Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2(final n1 = 1, final n2 = 1);
          Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport;
          Modelica.Mechanics.Rotational.Components.Fixed fixed if not useSupport;
        equation
          connect(plug_p, VoltageSensor1.plug_p);
          connect(plug_n, VoltageSensor1.plug_n);
          connect(relativeAngleSensor.flange_b, flange);
          connect(relativeAngleSensor.flange_a, support);
          connect(relativeAngleSensor.flange_a, fixed.flange);
          connect(relativeAngleSensor.phi_rel, add.u1);
          connect(constant_.y, add.u2);
          connect(VoltageSensor1.v, ToSpacePhasorVS.u);
          connect(ToSpacePhasorVS.y, rotatorVS2R.u);
          connect(rotatorVS2R.y, ToPolarVSR.u);
          connect(add.y, rotatorVS2R.angle);
          connect(ToPolarVSR.y, deMultiplex2.u);
          connect(deMultiplex2.y2[1], rotorDisplacementAngle);
        end RotorDisplacementAngle;
      end Sensors;

      package SpacePhasors
        package Components
          model SpacePhasor
            constant Integer m = 3;
            constant Real pi = Modelica.Constants.pi;
            parameter Real turnsRatio = 1;
            Modelica.SIunits.Voltage[m] v;
            Modelica.SIunits.Current[m] i;
          protected
            parameter Real[2, m] TransformationMatrix = 2 / m * {array(cos(+(k - 1) / m * 2 * pi) for k in 1:m), array(+sin(+(k - 1) / m * 2 * pi) for k in 1:m)};
            parameter Real[m, 2] InverseTransformation = array({cos(-(k - 1) / m * 2 * pi), -sin(-(k - 1) / m * 2 * pi)} for k in 1:m);
          public
            Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m = m);
            Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m = m);
            Modelica.Electrical.Analog.Interfaces.PositivePin zero;
            Modelica.Electrical.Analog.Interfaces.NegativePin ground;
            Machines.Interfaces.SpacePhasor spacePhasor;
          equation
            v / turnsRatio = plug_p.pin.v - plug_n.pin.v;
            i * turnsRatio = +plug_p.pin.i;
            i * turnsRatio = -plug_n.pin.i;
            m * zero.v = sum(v);
            spacePhasor.v_ = TransformationMatrix * v;
            -m * zero.i = sum(i);
            -spacePhasor.i_ = TransformationMatrix * i;
            ground.v = 0;
          end SpacePhasor;
        end Components;

        package Blocks
          block ToSpacePhasor
            extends Modelica.Blocks.Interfaces.MIMO(final nin = m, final nout = 2);
            constant Integer m = 3;
            constant Real pi = Modelica.Constants.pi;
          protected
            parameter Real[2, m] TransformationMatrix = 2 / m * {array(cos(+(k - 1) / m * 2 * pi) for k in 1:m), array(+sin(+(k - 1) / m * 2 * pi) for k in 1:m)};
            parameter Real[m, 2] InverseTransformation = array({cos(-(k - 1) / m * 2 * pi), -sin(-(k - 1) / m * 2 * pi)} for k in 1:m);
          public
            Modelica.Blocks.Interfaces.RealOutput zero;
          equation
            m * zero = sum(u);
            y = TransformationMatrix * u;
          end ToSpacePhasor;

          block FromSpacePhasor
            extends Modelica.Blocks.Interfaces.MIMO(final nin = 2, final nout = m);
            constant Integer m = 3;
            constant Real pi = Modelica.Constants.pi;
          protected
            parameter Real[2, m] TransformationMatrix = 2 / m * {array(cos(+(k - 1) / m * 2 * pi) for k in 1:m), array(+sin(+(k - 1) / m * 2 * pi) for k in 1:m)};
            parameter Real[m, 2] InverseTransformation = array({cos(-(k - 1) / m * 2 * pi), -sin(-(k - 1) / m * 2 * pi)} for k in 1:m);
          public
            Modelica.Blocks.Interfaces.RealInput zero;
          equation
            y = fill(zero, m) + InverseTransformation * u;
          end FromSpacePhasor;

          block Rotator
            extends Modelica.Blocks.Interfaces.MIMOs(final n = 2);
          protected
            Real[2, 2] RotationMatrix = {{+cos(-angle), -sin(-angle)}, {+sin(-angle), +cos(-angle)}};
          public
            Modelica.Blocks.Interfaces.RealInput angle;
          equation
            y = RotationMatrix * u;
          end Rotator;

          block ToPolar
            extends Modelica.Blocks.Interfaces.MIMOs(final n = 2);
            constant Real small = Modelica.Constants.small;
          equation
            y[1] = sqrt(u[1] ^ 2 + u[2] ^ 2);
            y[2] = if noEvent(y[1] <= small) then 0 else Modelica.Math.atan2(u[2], u[1]);
          end ToPolar;
        end Blocks;

        package Functions
          function activePower
            input Modelica.SIunits.Voltage[m] v;
            input Modelica.SIunits.Current[m] i;
            output Modelica.SIunits.Power p;
          protected
            constant Integer m = 3;
            constant Modelica.SIunits.Angle pi = Modelica.Constants.pi;
            Modelica.SIunits.Voltage[2] v_;
            Modelica.SIunits.Current[2] i_;
          algorithm
            v_ := zeros(2);
            i_ := zeros(2);
            for k in 1:m loop
              v_ := v_ + 2 / m * {+cos((k - 1) / m * 2 * pi), +sin(+(k - 1) / m * 2 * pi)} * v[k];
              i_ := i_ + 2 / m * {+cos((k - 1) / m * 2 * pi), +sin(+(k - 1) / m * 2 * pi)} * i[k];
            end for;
            p := m / 2 * ((+v_[1] * i_[1]) + v_[2] * i_[2]);
          end activePower;
        end Functions;
      end SpacePhasors;

      package Losses
        record FrictionParameters
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.AngularVelocity wRef(displayUnit = "1/min", min = Modelica.Constants.small);
          parameter Real power_w(min = Modelica.Constants.small) = 2;
          final parameter Modelica.SIunits.Torque tauRef = if PRef <= 0 then 0 else PRef / wRef;
          final parameter Real linear = 0.001;
          final parameter Modelica.SIunits.AngularVelocity wLinear = linear * wRef;
          final parameter Modelica.SIunits.Torque tauLinear = if PRef <= 0 then 0 else tauRef * (wLinear / wRef) ^ power_w;
        end FrictionParameters;

        record StrayLoadParameters
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.Current IRef(min = Modelica.Constants.small);
          parameter Modelica.SIunits.AngularVelocity wRef(displayUnit = "1/min", min = Modelica.Constants.small);
          parameter Real power_w(min = Modelica.Constants.small) = 1;
          final parameter Modelica.SIunits.Torque tauRef = if PRef <= 0 then 0 else PRef / wRef;
        end StrayLoadParameters;

        record CoreParameters
          parameter Integer m;
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.Voltage VRef(min = Modelica.Constants.small);
          parameter Modelica.SIunits.AngularVelocity wRef(min = Modelica.Constants.small);
          final parameter Real ratioHysteresis(min = 0, max = 1, start = 0.775) = 0;
          final parameter Modelica.SIunits.Conductance GcRef = if PRef <= 0 then 0 else PRef / VRef ^ 2 / m;
          final parameter Modelica.SIunits.AngularVelocity wMin = 1e-6 * wRef;
        end CoreParameters;

        record PermanentMagnetLossParameters
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Real c(min = 0, max = 1) = 0;
          parameter Modelica.SIunits.Current IRef(min = Modelica.Constants.small);
          parameter Real power_I(min = Modelica.Constants.small) = 2;
          parameter Modelica.SIunits.AngularVelocity wRef(displayUnit = "1/min", min = Modelica.Constants.small);
          parameter Real power_w(min = Modelica.Constants.small) = 1;
          final parameter Modelica.SIunits.Torque tauRef = if PRef <= 0 then 0 else PRef / wRef;
        end PermanentMagnetLossParameters;

        model Friction
          extends Machines.Interfaces.FlangeSupport;
          parameter FrictionParameters frictionParameters;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(useHeatPort = false);
        equation
          if frictionParameters.PRef <= 0 then
            tau = 0;
          else
            tau = -smooth(1, if w >= (+frictionParameters.wLinear) then +frictionParameters.tauRef * (+w / frictionParameters.wRef) ^ frictionParameters.power_w else if w <= (-frictionParameters.wLinear) then -frictionParameters.tauRef * (-w / frictionParameters.wRef) ^ frictionParameters.power_w else frictionParameters.tauLinear * (w / frictionParameters.wLinear));
          end if;
          lossPower = -tau * w;
        end Friction;

        package InductionMachines
          model StrayLoad
            extends Modelica.Electrical.MultiPhase.Interfaces.OnePort;
            extends Machines.Interfaces.FlangeSupport;
            parameter Machines.Losses.StrayLoadParameters strayLoadParameters;
            extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(useHeatPort = false);
            Modelica.SIunits.Current iRMS = .Modelica.Electrical.MultiPhase.Functions.quasiRMS(i);
          equation
            v = zeros(m);
            if strayLoadParameters.PRef <= 0 then
              tau = 0;
            else
              tau = -strayLoadParameters.tauRef * (iRMS / strayLoadParameters.IRef) ^ 2 * smooth(1, if w >= 0 then +(+w / strayLoadParameters.wRef) ^ strayLoadParameters.power_w else -(-w / strayLoadParameters.wRef) ^ strayLoadParameters.power_w);
            end if;
            lossPower = -tau * w;
          end StrayLoad;

          model PermanentMagnetLosses
            extends Machines.Interfaces.FlangeSupport;
            parameter Integer m(min = 1) = 3;
            parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters;
            extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(useHeatPort = false);
            input Modelica.SIunits.Current[m] is;
            Modelica.SIunits.Current iRMS = .Modelica.Electrical.MultiPhase.Functions.quasiRMS(is);
          equation
            if permanentMagnetLossParameters.PRef <= 0 then
              tau = 0;
            else
              tau = -permanentMagnetLossParameters.tauRef * (permanentMagnetLossParameters.c + (1 - permanentMagnetLossParameters.c) * (iRMS / permanentMagnetLossParameters.IRef) ^ permanentMagnetLossParameters.power_I) * smooth(1, if w >= 0 then +(+w / permanentMagnetLossParameters.wRef) ^ permanentMagnetLossParameters.power_w else -(-w / permanentMagnetLossParameters.wRef) ^ permanentMagnetLossParameters.power_w);
            end if;
            lossPower = -tau * w;
          end PermanentMagnetLosses;

          model Core
            parameter Machines.Losses.CoreParameters coreParameters(final m = m);
            final parameter Integer m = 3;
            parameter Real turnsRatio(final min = Modelica.Constants.small);
            extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(useHeatPort = false);
            Machines.Interfaces.SpacePhasor spacePhasor;
            input Modelica.SIunits.AngularVelocity w;
            Modelica.SIunits.Conductance Gc;
          protected
            Modelica.SIunits.AngularVelocity wLimit = noEvent(max(noEvent(abs(w)), coreParameters.wMin));
          equation
            if coreParameters.PRef <= 0 then
              Gc = 0;
              spacePhasor.i_ = zeros(2);
            else
              Gc = coreParameters.GcRef;
              spacePhasor.i_ = Gc * spacePhasor.v_;
            end if;
            lossPower = 3 / 2 * ((+spacePhasor.v_[1] * spacePhasor.i_[1]) + spacePhasor.v_[2] * spacePhasor.i_[2]);
          end Core;
        end InductionMachines;
      end Losses;

      package Thermal
        type LinearTemperatureCoefficient20 = Modelica.SIunits.LinearTemperatureCoefficient;

        function convertAlpha
          input Modelica.SIunits.LinearTemperatureCoefficient alpha1;
          input Modelica.SIunits.Temperature T2;
          input Modelica.SIunits.Temperature T1 = 293.15;
          output Modelica.SIunits.LinearTemperatureCoefficient alpha2;
        algorithm
          alpha2 := alpha1 / (1 + alpha1 * (T2 - T1));
        end convertAlpha;

        package SynchronousInductionMachines
          model ThermalAmbientSMPM
            parameter Boolean useDamperCage(start = true);
            extends Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM thermalPort(final useDamperCage = useDamperCage));
            parameter .Modelica.SIunits.Temperature Tpm(start = TDefault);
            parameter .Modelica.SIunits.Temperature Tr(start = TDefault);
            output .Modelica.SIunits.HeatFlowRate Q_flowRotorWinding = temperatureRotorWinding.port.Q_flow;
            output .Modelica.SIunits.HeatFlowRate Q_flowPermanentMagnet = temperaturePermanentMagnet.port.Q_flow;
            output .Modelica.SIunits.HeatFlowRate Q_flowTotal = Q_flowStatorWinding + Q_flowRotorWinding + Q_flowPermanentMagnet + Q_flowStatorCore + Q_flowRotorCore + Q_flowStrayLoad + Q_flowFriction;
            .Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperatureRotorWinding;
            .Modelica.Blocks.Interfaces.RealInput TRotorWinding if useTemperatureInputs and useDamperCage;
            .Modelica.Blocks.Sources.Constant constTr(final k = if useDamperCage then Tr else TDefault) if not useTemperatureInputs or not useDamperCage;
            .Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperaturePermanentMagnet;
            .Modelica.Blocks.Sources.Constant constTpm(final k = Tpm) if not useTemperatureInputs;
            .Modelica.Blocks.Interfaces.RealInput TPermanentMagnet if useTemperatureInputs;
          equation
            connect(constTr.y, temperatureRotorWinding.T);
            connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding);
            connect(TRotorWinding, temperatureRotorWinding.T);
            connect(temperaturePermanentMagnet.port, thermalPort.heatPortPermanentMagnet);
            connect(constTpm.y, temperaturePermanentMagnet.T);
            connect(TPermanentMagnet, temperaturePermanentMagnet.T);
          end ThermalAmbientSMPM;
        end SynchronousInductionMachines;
      end Thermal;

      package Interfaces
        connector SpacePhasor
          Modelica.SIunits.Voltage[2] v_;
          flow Modelica.SIunits.Current[2] i_;
        end SpacePhasor;

        partial model PartialBasicMachine
          constant Modelica.SIunits.Angle pi = Modelica.Constants.pi;
          parameter Modelica.SIunits.Inertia Jr;
          parameter Boolean useSupport = false;
          parameter Modelica.SIunits.Inertia Js(start = Jr);
          parameter Boolean useThermalPort = false;
          parameter Machines.Losses.FrictionParameters frictionParameters;
          output Modelica.SIunits.Angle phiMechanical(start = 0) = flange.phi - internalSupport.phi;
          output Modelica.SIunits.AngularVelocity wMechanical(displayUnit = "1/min", start = 0) = der(phiMechanical);
          output Modelica.SIunits.Torque tauElectrical = inertiaRotor.flange_a.tau;
          output Modelica.SIunits.Torque tauShaft = -flange.tau;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange;
          Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J = Jr);
          Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport;
          Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J = Js);
          Modelica.Mechanics.Rotational.Components.Fixed fixed if not useSupport;
          Machines.Losses.Friction friction(final frictionParameters = frictionParameters);
        protected
          Modelica.Mechanics.Rotational.Interfaces.Support internalSupport;
        equation
          connect(inertiaRotor.flange_b, flange);
          connect(inertiaStator.flange_b, support);
          connect(internalSupport, fixed.flange);
          connect(internalSupport, inertiaStator.flange_a);
          connect(inertiaRotor.flange_b, friction.flange);
          connect(friction.support, internalSupport);
        end PartialBasicMachine;

        partial model PartialBasicInductionMachine
          final parameter Integer m = 3;
          parameter Integer p(min = 1, start = 2);
          parameter Modelica.SIunits.Frequency fsNominal(start = 50);
          parameter Modelica.SIunits.Temperature TsOperational(start = 293.15);
          parameter Modelica.SIunits.Resistance Rs(start = 0.03);
          parameter Modelica.SIunits.Temperature TsRef(start = 293.15);
          parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start = 0);
          parameter Modelica.SIunits.Inductance Lszero = Lssigma;
          parameter Modelica.SIunits.Inductance Lssigma(start = 3 * (1 - sqrt(1 - 0.0667)) / (2 * pi * fsNominal));
          extends PartialBasicMachine(Jr(start = 0.29), frictionParameters(wRef = 2 * pi * fsNominal / p), friction(final useHeatPort = true));
          parameter Machines.Losses.CoreParameters statorCoreParameters(final m = 3, VRef(start = 100), wRef = 2 * pi * fsNominal);
          parameter Machines.Losses.StrayLoadParameters strayLoadParameters(IRef(start = 100), wRef = 2 * pi * fsNominal / p);
          replaceable output Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines powerBalance(final powerStator = Machines.SpacePhasors.Functions.activePower(vs, is), final powerMechanical = wMechanical * tauShaft, final powerInertiaStator = inertiaStator.J * inertiaStator.a * inertiaStator.w, final powerInertiaRotor = inertiaRotor.J * inertiaRotor.a * inertiaRotor.w, final lossPowerStatorWinding = sum(rs.resistor.LossPower), final lossPowerStatorCore = statorCore.lossPower, final lossPowerStrayLoad = strayLoad.lossPower, final lossPowerFriction = friction.lossPower);
          output Modelica.SIunits.Voltage[m] vs = plug_sp.pin.v - plug_sn.pin.v;
          output Modelica.SIunits.Current[m] is = plug_sp.pin.i;
          output Modelica.SIunits.Current i_0_s(stateSelect = StateSelect.prefer) = spacePhasorS.zero.i;
          input Modelica.SIunits.Current[2] idq_ss;
          input Modelica.SIunits.Current[2] idq_sr(each stateSelect = StateSelect.prefer);
          input Modelica.SIunits.Current[2] idq_rs;
          input Modelica.SIunits.Current[2] idq_rr(each stateSelect = StateSelect.prefer);
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m = m);
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m = m);
          Modelica.Electrical.MultiPhase.Basic.Resistor rs(final m = m, final R = fill(Rs, m), final T_ref = fill(TsRef, m), final alpha = fill(Machines.Thermal.convertAlpha(alpha20s, TsRef), m), final useHeatPort = true, final T = fill(TsRef, m));
          Machines.BasicMachines.Components.Inductor lssigma(final L = fill(Lssigma, 2));
          Modelica.Electrical.Analog.Basic.Inductor lszero(final L = Lszero);
          Machines.Losses.InductionMachines.Core statorCore(final coreParameters = statorCoreParameters, final useHeatPort = true, final turnsRatio = 1);
          Machines.SpacePhasors.Components.SpacePhasor spacePhasorS(final turnsRatio = 1);
          Machines.Losses.InductionMachines.StrayLoad strayLoad(final strayLoadParameters = strayLoadParameters, final useHeatPort = true, final m = m);
          replaceable Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines thermalPort(final m = m) if useThermalPort;
          replaceable Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines thermalAmbient(final useTemperatureInputs = false, final Ts = TsOperational, final m = m) if not useThermalPort;
        protected
          replaceable Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines internalThermalPort(final m = m);
        equation
          connect(spacePhasorS.plug_n, plug_sn);
          connect(thermalPort, internalThermalPort);
          connect(thermalAmbient.thermalPort, internalThermalPort);
          connect(strayLoad.plug_n, rs.plug_p);
          connect(strayLoad.plug_p, plug_sp);
          connect(strayLoad.support, internalSupport);
          connect(spacePhasorS.plug_p, rs.plug_n);
          connect(spacePhasorS.zero, lszero.p);
          connect(lszero.n, spacePhasorS.ground);
          connect(spacePhasorS.spacePhasor, lssigma.spacePhasor_a);
          connect(statorCore.spacePhasor, lssigma.spacePhasor_a);
          connect(statorCore.heatPort, internalThermalPort.heatPortStatorCore);
          connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad);
          connect(rs.heatPort, internalThermalPort.heatPortStatorWinding);
          connect(friction.heatPort, internalThermalPort.heatPortFriction);
          connect(strayLoad.flange, inertiaRotor.flange_b);
        end PartialBasicInductionMachine;

        package InductionMachines
          connector PartialThermalPortInductionMachines
            parameter Integer m = 3;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[m] heatPortStatorWinding;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStatorCore;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRotorCore;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction;
          end PartialThermalPortInductionMachines;

          model PartialThermalAmbientInductionMachines
            parameter Integer m = 3;
            parameter Boolean useTemperatureInputs = false;
            constant Modelica.SIunits.Temperature TDefault = 293.15;
            parameter Modelica.SIunits.Temperature Ts(start = TDefault);
            output Modelica.SIunits.HeatFlowRate Q_flowStatorWinding = temperatureStatorWinding.port.Q_flow;
            output Modelica.SIunits.HeatFlowRate Q_flowStatorCore = temperatureStatorCore.port.Q_flow;
            output Modelica.SIunits.HeatFlowRate Q_flowRotorCore = temperatureRotorCore.port.Q_flow;
            output Modelica.SIunits.HeatFlowRate Q_flowStrayLoad = temperatureStrayLoad.port.Q_flow;
            output Modelica.SIunits.HeatFlowRate Q_flowFriction = temperatureFriction.port.Q_flow;
            replaceable Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines thermalPort(final m = m);
            Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperatureStatorWinding;
            Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureStatorCore(final T = TDefault);
            Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureRotorCore(final T = TDefault);
            Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureStrayLoad(final T = TDefault);
            Modelica.Thermal.HeatTransfer.Sources.FixedTemperature temperatureFriction(final T = TDefault);
            Modelica.Blocks.Interfaces.RealInput TStatorWinding if useTemperatureInputs;
            Modelica.Blocks.Sources.Constant constTs(final k = Ts) if not useTemperatureInputs;
            Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorStator(final m = m);
          equation
            connect(constTs.y, temperatureStatorWinding.T);
            connect(TStatorWinding, temperatureStatorWinding.T);
            connect(temperatureStrayLoad.port, thermalPort.heatPortStrayLoad);
            connect(temperatureFriction.port, thermalPort.heatPortFriction);
            connect(thermalCollectorStator.port_b, temperatureStatorWinding.port);
            connect(thermalCollectorStator.port_a, thermalPort.heatPortStatorWinding);
            connect(temperatureStatorCore.port, thermalPort.heatPortStatorCore);
            connect(temperatureRotorCore.port, thermalPort.heatPortRotorCore);
          end PartialThermalAmbientInductionMachines;

          record PartialPowerBalanceInductionMachines
            Modelica.SIunits.Power powerStator = 0;
            Modelica.SIunits.Power powerMechanical = 0;
            Modelica.SIunits.Power powerInertiaStator = 0;
            Modelica.SIunits.Power powerInertiaRotor = 0;
            Modelica.SIunits.Power lossPowerTotal = 0;
            Modelica.SIunits.Power lossPowerStatorWinding = 0;
            Modelica.SIunits.Power lossPowerStatorCore = 0;
            Modelica.SIunits.Power lossPowerRotorCore = 0;
            Modelica.SIunits.Power lossPowerStrayLoad = 0;
            Modelica.SIunits.Power lossPowerFriction = 0;
          end PartialPowerBalanceInductionMachines;

          connector ThermalPortSMPM
            extends Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
            parameter Boolean useDamperCage(start = true);
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRotorWinding if useDamperCage;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortPermanentMagnet;
          end ThermalPortSMPM;

          record PowerBalanceSMPM
            extends Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(final lossPowerTotal = lossPowerStatorWinding + lossPowerStatorCore + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + lossPowerRotorWinding + lossPowerPermanentMagnet);
            Modelica.SIunits.Power lossPowerRotorWinding;
            Modelica.SIunits.Power lossPowerPermanentMagnet;
          end PowerBalanceSMPM;
        end InductionMachines;

        partial model FlangeSupport
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a support;
          Modelica.SIunits.Angle phi;
          Modelica.SIunits.Torque tau;
          Modelica.SIunits.AngularVelocity w;
        equation
          phi = flange.phi - support.phi;
          w = der(phi);
          tau = -flange.tau;
          tau = support.tau;
        end FlangeSupport;
      end Interfaces;

      package Utilities
        package ParameterRecords
          record InductionMachineData
            final parameter Integer m = 3;
            parameter Modelica.SIunits.Inertia Jr = 0.29;
            parameter Modelica.SIunits.Inertia Js = Jr;
            parameter Integer p(min = 1) = 2;
            parameter Modelica.SIunits.Frequency fsNominal = 50;
            parameter Modelica.SIunits.Resistance Rs = 0.03;
            parameter Modelica.SIunits.Temperature TsRef = 293.15;
            parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s = 0;
            parameter Modelica.SIunits.Inductance Lszero = Lssigma;
            parameter Modelica.SIunits.Inductance Lssigma = 3 * (1 - sqrt(1 - 0.0667)) / (2 * .Modelica.Constants.pi * fsNominal);
            parameter Machines.Losses.FrictionParameters frictionParameters(PRef = 0, wRef = 2 * .Modelica.Constants.pi * fsNominal / p);
            parameter Machines.Losses.CoreParameters statorCoreParameters(final m = m, PRef = 0, VRef = 100, wRef = 2 * .Modelica.Constants.pi * fsNominal);
            parameter Machines.Losses.StrayLoadParameters strayLoadParameters(PRef = 0, IRef = 100, wRef = 2 * .Modelica.Constants.pi * fsNominal / p);
          end InductionMachineData;

          record SM_PermanentMagnetData
            extends SM_ReluctanceRotorData(Lmd = 0.3 / (2 * .Modelica.Constants.pi * fsNominal), Lmq = 0.3 / (2 * .Modelica.Constants.pi * fsNominal));
            parameter Modelica.SIunits.Voltage VsOpenCircuit = 112.3;
            parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(PRef = 0, IRef = 100, wRef = 2 * .Modelica.Constants.pi * fsNominal / p);
          end SM_PermanentMagnetData;

          record SM_ReluctanceRotorData
            extends InductionMachineData(Lssigma = 0.1 / (2 * .Modelica.Constants.pi * fsNominal));
            parameter Modelica.SIunits.Inductance Lmd = 2.9 / (2 * .Modelica.Constants.pi * fsNominal);
            parameter Modelica.SIunits.Inductance Lmq = 0.9 / (2 * .Modelica.Constants.pi * fsNominal);
            parameter Boolean useDamperCage = true;
            parameter Modelica.SIunits.Inductance Lrsigmad = 0.05 / (2 * .Modelica.Constants.pi * fsNominal);
            parameter Modelica.SIunits.Inductance Lrsigmaq = Lrsigmad;
            parameter Modelica.SIunits.Resistance Rrd = 0.04;
            parameter Modelica.SIunits.Resistance Rrq = Rrd;
            parameter Modelica.SIunits.Temperature TrRef = 293.15;
            parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r = 0;
          end SM_ReluctanceRotorData;
        end ParameterRecords;

        model CurrentController
          constant Integer m = 3;
          parameter Integer p;
          extends Modelica.Blocks.Interfaces.MO(final nout = m);
          Modelica.Blocks.Interfaces.RealInput id_rms;
          Modelica.Blocks.Interfaces.RealInput iq_rms;
          Modelica.Blocks.Interfaces.RealInput phi;
          Modelica.Blocks.Math.Gain toPeak_d(k = sqrt(2));
          Modelica.Blocks.Math.Gain toPeak_q(k = sqrt(2));
          Modelica.Blocks.Math.Gain toGamma(k = -p);
          Machines.SpacePhasors.Blocks.Rotator rotator;
          Modelica.Blocks.Sources.Constant i0(k = 0);
          Machines.SpacePhasors.Blocks.FromSpacePhasor fromSpacePhasor;
        equation
          connect(iq_rms, toPeak_q.u);
          connect(phi, toGamma.u);
          connect(rotator.angle, toGamma.y);
          connect(rotator.y, fromSpacePhasor.u);
          connect(toPeak_d.u, id_rms);
          connect(toPeak_d.y, rotator.u[1]);
          connect(toPeak_q.y, rotator.u[2]);
          connect(i0.y, fromSpacePhasor.zero);
          connect(fromSpacePhasor.y, y);
        end CurrentController;

        model TerminalBox
          parameter Integer m = 3;
          parameter String terminalConnection(start = "Y");
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m = m);
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m = m);
          Modelica.Electrical.MultiPhase.Basic.Star star(final m = m) if terminalConnection <> "D";
          Modelica.Electrical.MultiPhase.Basic.Delta delta(final m = m) if terminalConnection == "D";
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply(final m = m);
          Modelica.Electrical.Analog.Interfaces.NegativePin starpoint if terminalConnection <> "D";
        equation
          connect(plug_sn, star.plug_p);
          connect(plug_sn, delta.plug_n);
          connect(delta.plug_p, plug_sp);
          connect(plug_sp, plugSupply);
          connect(star.pin_n, starpoint);
        end TerminalBox;
      end Utilities;
    end Machines;

    package MultiPhase
      package Basic
        model Star
          parameter Integer m(final min = 1) = 3;
          Interfaces.PositivePlug plug_p(final m = m);
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n;
        equation
          for j in 1:m loop
            plug_p.pin[j].v = pin_n.v;
          end for;
          sum(plug_p.pin.i) + pin_n.i = 0;
        end Star;

        model Delta
          parameter Integer m(final min = 2) = 3;
          Interfaces.PositivePlug plug_p(final m = m);
          Interfaces.NegativePlug plug_n(final m = m);
        equation
          for j in 1:m loop
            if j < m then
              plug_n.pin[j].v = plug_p.pin[j + 1].v;
              plug_n.pin[j].i + plug_p.pin[j + 1].i = 0;
            else
              plug_n.pin[j].v = plug_p.pin[1].v;
              plug_n.pin[j].i + plug_p.pin[1].i = 0;
            end if;
          end for;
        end Delta;

        model Resistor
          extends Interfaces.TwoPlug;
          parameter Modelica.SIunits.Resistance[m] R(start = fill(1, m));
          parameter Modelica.SIunits.Temperature[m] T_ref = fill(300.15, m);
          parameter Modelica.SIunits.LinearTemperatureCoefficient[m] alpha = zeros(m);
          extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh = m, T = T_ref);
          Modelica.Electrical.Analog.Basic.Resistor[m] resistor(final R = R, final T_ref = T_ref, final alpha = alpha, each final useHeatPort = useHeatPort, final T = T);
        equation
          connect(resistor.p, plug_p.pin);
          connect(resistor.n, plug_n.pin);
          connect(resistor.heatPort, heatPort);
        end Resistor;
      end Basic;

      package Functions
        function quasiRMS
          input Real[:] x;
          output Real y;
        algorithm
          y := sqrt(sum(x .^ 2 / size(x, 1)));
        end quasiRMS;
      end Functions;

      package Sensors
        model VoltageSensor
          parameter Integer m(final min = 1) = 3;
          Interfaces.PositivePlug plug_p(final m = m);
          Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Blocks.Interfaces.RealOutput[m] v;
          Modelica.Electrical.Analog.Sensors.VoltageSensor[m] voltageSensor;
        equation
          connect(voltageSensor.n, plug_n.pin);
          connect(voltageSensor.p, plug_p.pin);
          connect(voltageSensor.v, v);
        end VoltageSensor;

        model CurrentSensor
          parameter Integer m(final min = 1) = 3;
          Interfaces.PositivePlug plug_p(final m = m);
          Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Blocks.Interfaces.RealOutput[m] i;
          Modelica.Electrical.Analog.Sensors.CurrentSensor[m] currentSensor;
        equation
          connect(plug_p.pin, currentSensor.p);
          connect(currentSensor.n, plug_n.pin);
          connect(currentSensor.i, i);
        end CurrentSensor;
      end Sensors;

      package Sources
        model SignalCurrent
          parameter Integer m(min = 1) = 3;
          Modelica.SIunits.Voltage[m] v = plug_p.pin.v - plug_n.pin.v;
          Interfaces.PositivePlug plug_p(final m = m);
          Interfaces.NegativePlug plug_n(final m = m);
          Modelica.Blocks.Interfaces.RealInput[m] i(each unit = "A");
          Modelica.Electrical.Analog.Sources.SignalCurrent[m] signalCurrent;
        equation
          connect(signalCurrent.p, plug_p.pin);
          connect(signalCurrent.n, plug_n.pin);
          connect(i, signalCurrent.i);
        end SignalCurrent;
      end Sources;

      package Interfaces
        connector Plug
          parameter Integer m(final min = 1) = 3;
          Modelica.Electrical.Analog.Interfaces.Pin[m] pin;
        end Plug;

        connector PositivePlug
          extends Plug;
        end PositivePlug;

        connector NegativePlug
          extends Plug;
        end NegativePlug;

        partial model ConditionalHeatPort
          parameter Integer mh(min = 1) = 3;
          parameter Boolean useHeatPort = false;
          parameter Modelica.SIunits.Temperature[mh] T = fill(293.15, mh);
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[mh] heatPort if useHeatPort;
        end ConditionalHeatPort;

        partial model TwoPlug
          parameter Integer m(min = 1) = 3;
          Modelica.SIunits.Voltage[m] v;
          Modelica.SIunits.Current[m] i;
          PositivePlug plug_p(final m = m);
          NegativePlug plug_n(final m = m);
        equation
          v = plug_p.pin.v - plug_n.pin.v;
          i = plug_p.pin.i;
        end TwoPlug;

        partial model OnePort
          extends TwoPlug;
        equation
          plug_p.pin.i + plug_n.pin.i = zeros(m);
        end OnePort;
      end Interfaces;
    end MultiPhase;
  end Electrical;

  package Mechanics
    package Rotational
      package Components
        model Fixed
          parameter .Modelica.SIunits.Angle phi0 = 0;
          Interfaces.Flange_b flange;
        equation
          flange.phi = phi0;
        end Fixed;

        model Inertia
          Rotational.Interfaces.Flange_a flange_a;
          Rotational.Interfaces.Flange_b flange_b;
          parameter .Modelica.SIunits.Inertia J(min = 0, start = 1);
          parameter StateSelect stateSelect = StateSelect.default;
          .Modelica.SIunits.Angle phi(stateSelect = stateSelect);
          .Modelica.SIunits.AngularVelocity w(stateSelect = stateSelect);
          .Modelica.SIunits.AngularAcceleration a;
        equation
          phi = flange_a.phi;
          phi = flange_b.phi;
          w = der(phi);
          a = der(w);
          J * a = flange_a.tau + flange_b.tau;
        end Inertia;

        model ElastoBacklash
          parameter .Modelica.SIunits.RotationalSpringConstant c(final min = Modelica.Constants.small, start = 1.0e5);
          parameter .Modelica.SIunits.RotationalDampingConstant d(final min = 0, start = 0);
          parameter .Modelica.SIunits.Angle b(final min = 0) = 0;
          parameter .Modelica.SIunits.Angle phi_rel0 = 0;
          extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
        protected
          final parameter .Modelica.SIunits.Angle bMax = b / 2;
          final parameter .Modelica.SIunits.Angle bMin = -bMax;
          .Modelica.SIunits.Torque tau_c;
          .Modelica.SIunits.Torque tau_d;
          .Modelica.SIunits.Angle phi_diff = phi_rel - phi_rel0;
          constant .Modelica.SIunits.Angle bEps = 1e-10;
        equation
          if initial() then
            tau_c = if phi_diff > 1.5 * bMax then c * (phi_diff - bMax) else if phi_diff < 1.5 * bMin then c * (phi_diff - bMin) else c / 3 * phi_diff;
            tau_d = d * w_rel;
            tau = tau_c + tau_d;
            lossPower = tau_d * w_rel;
          else
            tau_c = if abs(b) <= bEps then c * phi_diff else if phi_diff > bMax then c * (phi_diff - bMax) else if phi_diff < bMin then c * (phi_diff - bMin) else 0;
            tau_d = d * w_rel;
            tau = if abs(b) <= bEps then tau_c + tau_d else if phi_diff > bMax then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(tau_c, tau_d))) else if phi_diff < bMin then smooth(0, noEvent(if tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c, tau_d))) else 0;
            lossPower = if abs(b) <= bEps then tau_d * w_rel else if phi_diff > bMax then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else min(tau_c, tau_d) * w_rel)) else if phi_diff < bMin then smooth(0, noEvent(if tau_c + tau_d >= 0 then 0 else max(tau_c, tau_d) * w_rel)) else 0;
          end if;
        end ElastoBacklash;

        model LossyGear
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
          parameter Real ratio(start = 1);
          parameter Real[:, 5] lossTable = [0, 1, 1, 0, 0];
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
          Modelica.SIunits.Angle phi_a;
          Modelica.SIunits.Angle phi_b;
          Real sa(final unit = "1");
          .Modelica.SIunits.AngularVelocity w_a;
          .Modelica.SIunits.AngularAcceleration a_a;
          Real[1, size(lossTable, 2) - 1] interpolation_result;
          Real eta_mf1;
          Real eta_mf2;
          Real tau_bf_a;
          Real tau_eta;
          Real tau_bf1;
          Real tau_bf2;
          Real quadrant1;
          Real quadrant2;
          Real quadrant3;
          Real quadrant4;
          Real quadrant1_p;
          Real quadrant2_p;
          Real quadrant3_m;
          Real quadrant4_m;
          .Modelica.SIunits.Torque tauLoss;
          .Modelica.SIunits.Torque tauLossMax;
          .Modelica.SIunits.Torque tauLossMin;
          .Modelica.SIunits.Torque tauLossMax_p;
          .Modelica.SIunits.Torque tauLossMin_m;
          Boolean tau_aPos(start = true);
          Boolean tau_etaPos(start = true);
          Boolean startForward(start = false);
          Boolean startBackward(start = false);
          Boolean locked(start = false);
          Boolean ideal;
          constant Integer Unknown = 3;
          constant Integer Free = 2;
          constant Integer Forward = 1;
          constant Integer Stuck = 0;
          constant Integer Backward = -1;
          Integer mode(final min = Backward, final max = Unknown, start = Free, fixed = true);
          .Modelica.SIunits.Torque tau_eta_p;
          .Modelica.SIunits.Torque tau_eta_m;
        protected
          constant .Modelica.SIunits.AngularAcceleration unitAngularAcceleration = 1;
          constant .Modelica.SIunits.Torque unitTorque = 1;
          parameter Real[1, size(lossTable, 2) - 1] interpolation_result_0 = Modelica.Math.tempInterpol2(0, lossTable, {2, 3, 4, 5});
          parameter Real eta_mf1_0 = interpolation_result_0[1, 1];
          parameter Real eta_mf2_0 = interpolation_result_0[1, 2];
          parameter Real tau_bf1_0 = abs(interpolation_result_0[1, 3]);
          parameter Real tau_bf2_0 = abs(interpolation_result_0[1, 4]);
          parameter Real tau_bf_a_0 = if Modelica.Math.isEqual(eta_mf1_0, 1.0, Modelica.Constants.eps) and Modelica.Math.isEqual(eta_mf2_0, 1.0, Modelica.Constants.eps) then tau_bf1_0 / 2 else (tau_bf1_0 - tau_bf2_0) / (eta_mf1_0 - 1.0 / eta_mf2_0);
        equation
          assert(abs(ratio) > 0, "Error in initialization of LossyGear: ratio may not be zero");
          ideal = Modelica.Math.Matrices.isEqual(lossTable, [0, 1, 1, 0, 0], Modelica.Constants.eps);
          interpolation_result = if ideal then [1, 1, 0, 0] else Modelica.Math.tempInterpol2(noEvent(abs(w_a)), lossTable, {2, 3, 4, 5});
          eta_mf1 = interpolation_result[1, 1];
          eta_mf2 = interpolation_result[1, 2];
          tau_bf1 = noEvent(abs(interpolation_result[1, 3]));
          tau_bf2 = noEvent(abs(interpolation_result[1, 4]));
          if Modelica.Math.isEqual(eta_mf1, 1.0, Modelica.Constants.eps) and Modelica.Math.isEqual(eta_mf2, 1.0, Modelica.Constants.eps) then
            tau_bf_a = tau_bf1 / 2;
          else
            tau_bf_a = (tau_bf1 - tau_bf2) / (eta_mf1 - 1.0 / eta_mf2);
          end if;
          phi_a = flange_a.phi - phi_support;
          phi_b = flange_b.phi - phi_support;
          phi_a = ratio * phi_b;
          0 = flange_b.tau + ratio * (flange_a.tau - tauLoss);
          w_a = der(phi_a);
          a_a = der(w_a);
          tau_eta_p = flange_a.tau - tau_bf_a_0;
          tau_eta_m = flange_a.tau + tau_bf_a_0;
          quadrant1_p = (1 - eta_mf1_0) * flange_a.tau + tau_bf1_0;
          quadrant2_p = (1 - 1 / eta_mf2_0) * flange_a.tau + tau_bf2_0;
          tauLossMax_p = if noEvent(tau_eta_p > 0) then quadrant1_p else quadrant2_p;
          quadrant4_m = (1 - 1 / eta_mf2_0) * flange_a.tau - tau_bf2_0;
          quadrant3_m = (1 - eta_mf1_0) * flange_a.tau - tau_bf1_0;
          tauLossMin_m = if noEvent(tau_eta_m > 0) then quadrant4_m else quadrant3_m;
          quadrant1 = (1 - eta_mf1) * flange_a.tau + tau_bf1;
          quadrant2 = (1 - 1 / eta_mf2) * flange_a.tau + tau_bf2;
          quadrant4 = (1 - 1 / eta_mf2) * flange_a.tau - tau_bf2;
          quadrant3 = (1 - eta_mf1) * flange_a.tau - tau_bf1;
          tau_eta = if ideal then flange_a.tau else if locked then flange_a.tau else if startForward or pre(mode) == Forward then flange_a.tau - tau_bf_a else flange_a.tau + tau_bf_a;
          tau_etaPos = tau_eta >= 0;
          tau_aPos = tau_etaPos;
          tauLossMax = if tau_etaPos then quadrant1 else quadrant2;
          tauLossMin = if tau_etaPos then quadrant4 else quadrant3;
          startForward = pre(mode) == Stuck and sa > tauLossMax_p / unitTorque or initial() and w_a > 0;
          startBackward = pre(mode) == Stuck and sa < tauLossMin_m / unitTorque or initial() and w_a < 0;
          locked = not (ideal or pre(mode) == Forward or startForward or pre(mode) == Backward or startBackward);
          tauLoss = if ideal then 0 else if locked then sa * unitTorque else if startForward or pre(mode) == Forward then tauLossMax else tauLossMin;
          a_a = unitAngularAcceleration * (if locked then 0 else sa - tauLoss / unitTorque);
          mode = if ideal then Free else if (pre(mode) == Forward or startForward) and w_a > 0 then Forward else if (pre(mode) == Backward or startBackward) and w_a < 0 then Backward else Stuck;
          lossPower = tauLoss * w_a;
        end LossyGear;

        model Gearbox
          extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;
          parameter Real ratio(start = 1);
          parameter Real[:, 5] lossTable = [0, 1, 1, 0, 0];
          parameter .Modelica.SIunits.RotationalSpringConstant c(final min = Modelica.Constants.small, start = 1.0e5);
          parameter .Modelica.SIunits.RotationalDampingConstant d(final min = 0, start = 0);
          parameter .Modelica.SIunits.Angle b(final min = 0) = 0;
          parameter StateSelect stateSelect = StateSelect.prefer;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(final T = 293.15);
          Modelica.SIunits.Angle phi_rel(start = 0, stateSelect = stateSelect, nominal = 1e-4) = flange_b.phi - lossyGear.flange_b.phi;
          Modelica.SIunits.AngularVelocity w_rel(start = 0, stateSelect = stateSelect) = der(phi_rel);
          Modelica.SIunits.AngularAcceleration a_rel(start = 0) = der(w_rel);
          Rotational.Components.LossyGear lossyGear(final ratio = ratio, final lossTable = lossTable, final useSupport = true, final useHeatPort = true);
          Rotational.Components.ElastoBacklash elastoBacklash(final b = b, final c = c, final phi_rel0 = 0, final d = d, final useHeatPort = true);
        equation
          connect(flange_a, lossyGear.flange_a);
          connect(lossyGear.flange_b, elastoBacklash.flange_a);
          connect(elastoBacklash.flange_b, flange_b);
          connect(elastoBacklash.heatPort, internalHeatPort);
          connect(lossyGear.heatPort, internalHeatPort);
          connect(lossyGear.support, internalSupport);
        end Gearbox;

        model IdealGearR2T
          extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
          parameter Real ratio(final unit = "rad/m", start = 1);
        equation
          flangeR.phi - internalSupportR.phi = ratio * (flangeT.s - internalSupportT.s);
          0 = ratio * flangeR.tau + flangeT.f;
        end IdealGearR2T;
      end Components;

      package Sensors

        model AngleSensor
          extends Rotational.Interfaces.PartialAbsoluteSensor;
          Modelica.Blocks.Interfaces.RealOutput phi(unit = "rad", displayUnit = "deg");
        equation
          phi = flange.phi;
        end AngleSensor;

        model SpeedSensor
          extends Rotational.Interfaces.PartialAbsoluteSensor;
          Modelica.Blocks.Interfaces.RealOutput w(unit = "rad/s");
        equation
          w = der(flange.phi);
        end SpeedSensor;

        model RelAngleSensor
          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput phi_rel(unit = "rad", displayUnit = "deg");
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          0 = flange_a.tau;
        end RelAngleSensor;

        model TorqueSensor
          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput tau(unit = "N.m");
        equation
          flange_a.phi = flange_b.phi;
          flange_a.tau = tau;
        end TorqueSensor;
      end Sensors;

      package Interfaces
        connector Flange_a
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Flange_a;

        connector Flange_b
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Flange_b;

        connector Support
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Support;

        model InternalSupport
          input Modelica.SIunits.Torque tau;
          Modelica.SIunits.Angle phi;
          Flange_a flange;
        equation
          flange.tau = tau;
          flange.phi = phi;
        end InternalSupport;

        partial model PartialTwoFlangesAndSupport
          parameter Boolean useSupport = false;
          Flange_a flange_a;
          Flange_b flange_b;
          Support support if useSupport;
        protected
          Support internalSupport;
          Components.Fixed fixed if not useSupport;
        equation
          connect(support, internalSupport);
          connect(internalSupport, fixed.flange);
        end PartialTwoFlangesAndSupport;

        partial model PartialCompliantWithRelativeStates
          Modelica.SIunits.Angle phi_rel(start = 0, stateSelect = stateSelect, nominal = if phi_nominal >= Modelica.Constants.eps then phi_nominal else 1);
          Modelica.SIunits.AngularVelocity w_rel(start = 0, stateSelect = stateSelect);
          Modelica.SIunits.AngularAcceleration a_rel(start = 0);
          Modelica.SIunits.Torque tau;
          Flange_a flange_a;
          Flange_b flange_b;
          parameter .Modelica.SIunits.Angle phi_nominal(displayUnit = "rad", min = 0.0) = 1e-4;
          parameter StateSelect stateSelect = StateSelect.prefer;
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          w_rel = der(phi_rel);
          a_rel = der(w_rel);
          flange_b.tau = tau;
          flange_a.tau = -tau;
        end PartialCompliantWithRelativeStates;

        partial model PartialElementaryTwoFlangesAndSupport2
          parameter Boolean useSupport = false;
          Flange_a flange_a;
          Flange_b flange_b;
          Support support(phi = phi_support, tau = (-flange_a.tau) - flange_b.tau) if useSupport;
        protected
          Modelica.SIunits.Angle phi_support;
        equation
          if not useSupport then
            phi_support = 0;
          end if;
        end PartialElementaryTwoFlangesAndSupport2;

        partial model PartialElementaryRotationalToTranslational
          parameter Boolean useSupportR = false;
          parameter Boolean useSupportT = false;
          Rotational.Interfaces.Flange_a flangeR;
          Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT;
          Rotational.Interfaces.Support supportR if useSupportR;
          Translational.Interfaces.Support supportT if useSupportT;
        protected
          Rotational.Interfaces.InternalSupport internalSupportR(tau = -flangeR.tau);
          Translational.Interfaces.InternalSupport internalSupportT(f = -flangeT.f);
          Rotational.Components.Fixed fixedR if not useSupportR;
          Translational.Components.Fixed fixedT if not useSupportT;
        equation
          connect(internalSupportR.flange, supportR);
          connect(internalSupportR.flange, fixedR.flange);
          connect(fixedT.flange, internalSupportT.flange);
          connect(internalSupportT.flange, supportT);
        end PartialElementaryRotationalToTranslational;

        partial model PartialAbsoluteSensor
          Flange_a flange;
        equation
          0 = flange.tau;
        end PartialAbsoluteSensor;

        partial model PartialRelativeSensor
          Flange_a flange_a;
          Flange_b flange_b;
        equation
          0 = flange_a.tau + flange_b.tau;
        end PartialRelativeSensor;
      end Interfaces;

    end Rotational;

    package Translational
      package Components
        model Fixed
          parameter .Modelica.SIunits.Position s0 = 0;
          Interfaces.Flange_b flange;
        equation
          flange.s = s0;
        end Fixed;

        model Mass
          parameter .Modelica.SIunits.Mass m(min = 0, start = 1);
          parameter StateSelect stateSelect = StateSelect.default;
          extends Translational.Interfaces.PartialRigid(L = 0, s(start = 0, stateSelect = stateSelect));
          .Modelica.SIunits.Velocity v(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.Acceleration a(start = 0);
        equation
          v = der(s);
          a = der(v);
          m * a = flange_a.f + flange_b.f;
        end Mass;

        model SpringDamper
          extends Translational.Interfaces.PartialCompliantWithRelativeStates;
          parameter .Modelica.SIunits.TranslationalSpringConstant c(final min = 0, start = 1);
          parameter .Modelica.SIunits.TranslationalDampingConstant d(final min = 0, start = 1);
          parameter .Modelica.SIunits.Position s_rel0 = 0;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
        protected
          Modelica.SIunits.Force f_c;
          Modelica.SIunits.Force f_d;
        equation
          f_c = c * (s_rel - s_rel0);
          f_d = d * v_rel;
          f = f_c + f_d;
          lossPower = f_d * v_rel;
        end SpringDamper;

        model IdealGearR2T
          extends Modelica.Mechanics.Rotational.Components.IdealGearR2T;
        end IdealGearR2T;
      end Components;

      package Sources
        model ConstantForce
          extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
          parameter Modelica.SIunits.Force f_constant;
        equation
          f = -f_constant;
        end ConstantForce;
      end Sources;

      package Interfaces
        connector Flange_a
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Flange_a;

        connector Flange_b
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Flange_b;

        connector Support
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Support;

        model InternalSupport
          input .Modelica.SIunits.Force f;
          .Modelica.SIunits.Position s;
          Flange_a flange;
        equation
          flange.f = f;
          flange.s = s;
        end InternalSupport;

        partial model PartialRigid
          .Modelica.SIunits.Position s;
          parameter .Modelica.SIunits.Length L(start = 0);
          Flange_a flange_a;
          Flange_b flange_b;
        equation
          flange_a.s = s - L / 2;
          flange_b.s = s + L / 2;
        end PartialRigid;

        partial model PartialCompliantWithRelativeStates
          parameter StateSelect stateSelect = StateSelect.prefer;
          parameter .Modelica.SIunits.Distance s_nominal = 1e-4;
          .Modelica.SIunits.Position s_rel(start = 0, stateSelect = stateSelect, nominal = s_nominal);
          .Modelica.SIunits.Velocity v_rel(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.Force f;
          Translational.Interfaces.Flange_a flange_a;
          Translational.Interfaces.Flange_b flange_b;
        equation
          s_rel = flange_b.s - flange_a.s;
          v_rel = der(s_rel);
          flange_b.f = f;
          flange_a.f = -f;
        end PartialCompliantWithRelativeStates;

        partial model PartialElementaryOneFlangeAndSupport2
          parameter Boolean useSupport = false;
          Modelica.SIunits.Length s;
          Flange_b flange;
          Support support(s = s_support, f = -flange.f) if useSupport;
        protected
          Modelica.SIunits.Length s_support;
        equation
          s = flange.s - s_support;
          if not useSupport then
            s_support = 0;
          end if;
        end PartialElementaryOneFlangeAndSupport2;

        partial model PartialForce
          extends PartialElementaryOneFlangeAndSupport2;
          Modelica.SIunits.Force f;
        equation
          f = flange.f;
        end PartialForce;
      end Interfaces;
    end Translational;
  end Mechanics;

  package Thermal
    package HeatTransfer
      package Components
        model ThermalCollector
          parameter Integer m(min = 1) = 3;
          Interfaces.HeatPort_a[m] port_a;
          Interfaces.HeatPort_b port_b;
        equation
          port_b.Q_flow + sum(port_a.Q_flow) = 0;
          port_a.T = fill(port_b.T, m);
        end ThermalCollector;
      end Components;

      package Sources
        model FixedTemperature
          parameter Modelica.SIunits.Temperature T;
          Interfaces.HeatPort_b port;
        equation
          port.T = T;
        end FixedTemperature;

        model PrescribedTemperature
          Interfaces.HeatPort_b port;
          Modelica.Blocks.Interfaces.RealInput T(unit = "K");
        equation
          port.T = T;
        end PrescribedTemperature;
      end Sources;

      package Interfaces
        partial connector HeatPort
          Modelica.SIunits.Temperature T;
          flow Modelica.SIunits.HeatFlowRate Q_flow;
        end HeatPort;

        connector HeatPort_a
          extends HeatPort;
        end HeatPort_a;

        connector HeatPort_b
          extends HeatPort;
        end HeatPort_b;

        partial model PartialElementaryConditionalHeatPortWithoutT
          parameter Boolean useHeatPort = false;
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow = -lossPower) if useHeatPort;
          Modelica.SIunits.Power lossPower;
        end PartialElementaryConditionalHeatPortWithoutT;

        partial model PartialConditionalHeatPort
          parameter Boolean useHeatPort = false;
          parameter Modelica.SIunits.Temperature T = 293.15;
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort;
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T = T) if not useHeatPort;
        protected
          HeatPort_a internalHeatPort;
        equation
          connect(heatPort, internalHeatPort);
          connect(fixedTemperature.port, internalHeatPort);
        end PartialConditionalHeatPort;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math
    package Matrices
      function isEqual
        input Real[:, :] M1;
        input Real[:, :] M2;
        input Real eps(min = 0) = 0;
        output Boolean result;
      protected
        Integer nrow = size(M1, 1);
        Integer ncol = size(M1, 2);
        Integer i = 1;
        Integer j;
      algorithm
        result := false;
        if size(M2, 1) == nrow and size(M2, 2) == ncol then
          result := true;
          while i <= nrow loop
            j := 1;
            while j <= ncol loop
              if abs(M1[i, j] - M2[i, j]) > eps then
                result := false;
                i := nrow;
                j := ncol;
              else
              end if;
              j := j + 1;
            end while;
            i := i + 1;
          end while;
        else
        end if;
      end isEqual;
    end Matrices;

    function isEqual
      input Real s1;
      input Real s2;
      input Real eps(min = 0) = 0;
      output Boolean result;
    algorithm
      result := abs(s1 - s2) <= eps;
    end isEqual;

    function asin
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function atan2
      input Real u1;
      input Real u2;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = atan2(u1, u2);
    end atan2;

    function exp
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;

    function tempInterpol2
      input Real u;
      input Real[:, :] table;
      input Integer[:] icol;
      output Real[1, size(icol, 1)] y;
    protected
      Integer i;
      Integer n;
      Real u1;
      Real u2;
      Real[1, size(icol, 1)] y1;
      Real[1, size(icol, 1)] y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        y := transpose([table[1, icol]]);
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := transpose([table[i, icol]]);
        y2 := transpose([table[i + 1, icol]]);
        assert(u2 > u1, "Table index must be increasing");
        y := y1 + (y2 - y1) * (u - u1) / (u2 - u1);
      end if;
    end tempInterpol2;

    function tempInterpol2_der
      input Real u;
      input Real[:, :] table;
      input Integer[:] icol;
      input Real du;
      output Real[1, size(icol, 1)] dy;
    protected
      Integer i;
      Integer n;
      Real u1;
      Real u2;
      Real[1, size(icol, 1)] y1;
      Real[1, size(icol, 1)] y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        dy := zeros(1, size(icol, 1));
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := transpose([table[i, icol]]);
        y2 := transpose([table[i + 1, icol]]);
        assert(u2 > u1, "Table index must be increasing");
        dy := (y2 - y1) / (u2 - u1);
      end if;
    end tempInterpol2_der;
  end Math;

  package Utilities
    package Streams
      function print
        input String string = "";
        input String fileName = "";
        external "C" ModelicaInternal_print(string, fileName);
      end print;

      function error
        input String string;
        external "C" ModelicaError(string);
      end error;
    end Streams;
  end Utilities;

  package Constants
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps;
    final constant Real small = ModelicaServices.Machine.small;
    final constant .Modelica.SIunits.Velocity c = 299792458;
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7;
  end Constants;

  package SIunits
    package Conversions
      package NonSIunits
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC");
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Length = Real(final quantity = "Length", final unit = "m");
    type Position = Length;
    type Distance = Length(min = 0);
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
    type DampingCoefficient = Real(final quantity = "DampingCoefficient", final unit = "s-1");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Inertia = MomentOfInertia;
    type Force = Real(final quantity = "Force", final unit = "N");
    type TranslationalSpringConstant = Real(final quantity = "TranslationalSpringConstant", final unit = "N/m");
    type TranslationalDampingConstant = Real(final quantity = "TranslationalDampingConstant", final unit = "N.s/m");
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type RotationalSpringConstant = Real(final quantity = "RotationalSpringConstant", final unit = "N.m/rad");
    type RotationalDampingConstant = Real(final quantity = "RotationalDampingConstant", final unit = "N.m.s/rad");
    type Power = Real(final quantity = "Power", final unit = "W");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC");
    type Temperature = ThermodynamicTemperature;
    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit = "1/K");
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
    type ElectricCurrent = Real(final quantity = "ElectricCurrent", final unit = "A");
    type Current = ElectricCurrent;
    type ElectricPotential = Real(final quantity = "ElectricPotential", final unit = "V");
    type Voltage = ElectricPotential;
    type MagneticFlux = Real(final quantity = "MagneticFlux", final unit = "Wb");
    type Inductance = Real(final quantity = "Inductance", final unit = "H");
    type Resistance = Real(final quantity = "Resistance", final unit = "Ohm");
    type Conductance = Real(final quantity = "Conductance", final unit = "S");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
end Modelica;

package Noise
  package Examples
    package Actuator
      model Actuator
        Parts.MotorWithCurrentControl Motor;
        Parts.Controller controller;
        Modelica.Blocks.Sources.Step Speed(startTime = 0.5, height = 50);
        Modelica.Mechanics.Rotational.Components.Gearbox gearbox(lossTable = [0, 0.85, 0.8, 0.1, 0.1], c = 1e6, d = 1e4, ratio = 10, b = 0.0017453292519943);
        Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio = 300);
        Modelica.Mechanics.Translational.Components.Mass mass(m = 100);
        Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(f_constant = 10000);
        Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising = 50);
        Modelica.Mechanics.Translational.Components.Mass rodMass(m = 3);
        Modelica.Mechanics.Translational.Components.SpringDamper elastoGap(c = 1e8, d = 1e5);
      equation
        connect(controller.y1, Motor.iq_rms1);
        connect(Motor.phi, controller.positionMeasured);
        connect(Motor.flange, gearbox.flange_a);
        connect(gearbox.flange_b, idealGearR2T.flangeR);
        connect(constantForce.flange, mass.flange_b);
        connect(Speed.y, slewRateLimiter.u);
        connect(slewRateLimiter.y, controller.positionReference);
        connect(rodMass.flange_a, idealGearR2T.flangeT);
        connect(rodMass.flange_b, elastoGap.flange_a);
        connect(elastoGap.flange_b, mass.flange_a);
      end Actuator;

      model ActuatorLinearSystemsNoise
        extends Actuator(controller(redeclare Noise.Examples.Actuator.Parts.LinearSystemsNoise noiseModel));
      end ActuatorLinearSystemsNoise;

      package Parts
        model MotorWithCurrentControl
          constant Integer m = 3;
          parameter Modelica.SIunits.Voltage VNominal = 100;
          parameter Modelica.SIunits.Frequency fNominal = 50;
          parameter Modelica.SIunits.Frequency f = 50;
          parameter Modelica.SIunits.Time tRamp = 1;
          parameter Modelica.SIunits.Torque TLoad = 181.4;
          parameter Modelica.SIunits.Time tStep = 1.2;
          parameter Modelica.SIunits.Inertia JLoad = 0.29;
          Modelica.SIunits.Angle phi_motor;
          Modelica.SIunits.AngularVelocity w;
          Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(p = smpmData.p, fsNominal = smpmData.fsNominal, TsOperational = 293.15, Rs = smpmData.Rs, TsRef = smpmData.TsRef, alpha20s = smpmData.alpha20s, Lszero = smpmData.Lszero, Lssigma = smpmData.Lssigma, Jr = smpmData.Jr, Js = smpmData.Js, frictionParameters = smpmData.frictionParameters, phiMechanical(fixed = true), wMechanical(fixed = true), statorCoreParameters = smpmData.statorCoreParameters, strayLoadParameters = smpmData.strayLoadParameters, TrOperational = 293.15, VsOpenCircuit = smpmData.VsOpenCircuit, Lmd = smpmData.Lmd, Lmq = smpmData.Lmq, useDamperCage = smpmData.useDamperCage, Lrsigmad = smpmData.Lrsigmad, Lrsigmaq = smpmData.Lrsigmaq, Rrd = smpmData.Rrd, Rrq = smpmData.Rrq, TrRef = smpmData.TrRef, alpha20r = smpmData.alpha20r, permanentMagnetLossParameters = smpmData.permanentMagnetLossParameters);
          Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(final m = m);
          Modelica.Electrical.MultiPhase.Basic.Star star(final m = m);
          Modelica.Electrical.Analog.Basic.Ground ground;
          Modelica.Electrical.Machines.Utilities.CurrentController currentController(p = smpm.p);
          Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor;
          Modelica.Electrical.MultiPhase.Basic.Star starM(final m = m);
          Modelica.Electrical.Analog.Basic.Ground groundM;
          Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection = "Y");
          Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p = smpm.p);
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor;
          Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor;
          Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor;
          Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J = 0.29);
          parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(useDamperCage = false);
          Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor;
          Modelica.Blocks.Sources.Constant id(k = 0);
          Modelica.Blocks.Interfaces.RealInput iq_rms1;
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange;
          Modelica.Blocks.Interfaces.RealOutput phi;
        equation
          w = speedSensor.w;
          phi_motor = angleSensor.phi;
          connect(star.pin_n, ground.p);
          connect(rotorDisplacementAngle.plug_n, smpm.plug_sn);
          connect(rotorDisplacementAngle.plug_p, smpm.plug_sp);
          connect(terminalBox.plug_sn, smpm.plug_sn);
          connect(terminalBox.plug_sp, smpm.plug_sp);
          connect(smpm.flange, rotorDisplacementAngle.flange);
          connect(signalCurrent.plug_p, star.plug_p);
          connect(angleSensor.flange, rotorDisplacementAngle.flange);
          connect(angleSensor.phi, currentController.phi);
          connect(groundM.p, terminalBox.starpoint);
          connect(smpm.flange, torqueSensor.flange_a);
          connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply);
          connect(starM.plug_p, voltageQuasiRMSSensor.plug_n);
          connect(starM.pin_n, groundM.p);
          connect(currentController.y, signalCurrent.i);
          connect(speedSensor.flange, smpm.flange);
          connect(torqueSensor.flange_b, inertiaLoad.flange_a);
          connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p);
          connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p);
          connect(id.y, currentController.id_rms);
          connect(currentController.iq_rms, iq_rms1);
          connect(inertiaLoad.flange_b, flange);
          connect(angleSensor.phi, phi);
        end MotorWithCurrentControl;

        model Controller
          Modelica.Blocks.Continuous.PI speed_PI(k = 10, T = 5e-2);
          Modelica.Blocks.Math.Feedback speedFeedback;
          Modelica.Blocks.Continuous.Derivative positionToSpeed(T = 0.005);
          Modelica.Blocks.Interfaces.RealInput positionMeasured;
          Modelica.Blocks.Interfaces.RealInput positionReference;
          Modelica.Blocks.Interfaces.RealOutput y1;
          Modelica.Blocks.Continuous.PI position_PI(T = 5e-1, k = 3);
          Modelica.Blocks.Math.Feedback positionFeedback;
          Modelica.Blocks.Math.Add addNoise;
          replaceable .Noise.Examples.Actuator.Parts.NoNoise noiseModel constrainedby Noise.Examples.Actuator.Parts.NoiseModel;
          Modelica.Blocks.Continuous.FirstOrder busdelay(T = 1e-3);
        equation
          connect(positionToSpeed.y, speedFeedback.u2);
          connect(speedFeedback.y, speed_PI.u);
          connect(positionFeedback.u2, positionToSpeed.u);
          connect(positionReference, positionFeedback.u1);
          connect(positionFeedback.y, position_PI.u);
          connect(position_PI.y, speedFeedback.u1);
          connect(positionMeasured, addNoise.u2);
          connect(addNoise.y, positionToSpeed.u);
          connect(noiseModel.y, addNoise.u1);
          connect(speed_PI.y, busdelay.u);
          connect(y1, busdelay.y);
        end Controller;

        model NoNoise
          extends NoiseModel;
          Modelica.Blocks.Sources.Constant noise(k = 0);
        equation
          connect(noise.y, y);
        end NoNoise;

        model LinearSystemsNoise
          extends NoiseModel;
          .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Noise noise(y_max = 0.01, blockType = .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete, y_min = -0.01);
          inner .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.SampleClock sampleClock(blockType = .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockType.Discrete, sampleTime = 1 / 2000);
          .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.FilterFIR filter1(blockType = .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Discrete, L = 10);
        equation
          connect(noise.y, filter1.u);
          connect(filter1.y, y);
        end LinearSystemsNoise;

        partial model NoiseModel
          extends Modelica.Blocks.Interfaces.SO;
        end NoiseModel;
      end Parts;
    end Actuator;

    package Parts
      package Modelica_LinearSystems2

        package Controller

          block SampleClock
            parameter Types.BlockType blockType = Types.BlockType.Continuous;
            parameter .Noise.Examples.Parts.Modelica_LinearSystems2.Types.Method methodType = .Noise.Examples.Parts.Modelica_LinearSystems2.Types.Method.Trapezoidal;
            parameter Modelica.SIunits.Time sampleTime = 1;
            parameter Types.Init initType = Types.Init.SteadyState;
            output Boolean sampleTrigger;
          equation
            if blockType == Types.BlockType.Continuous then
              sampleTrigger = false;
            else
              sampleTrigger = sample(sampleTime, sampleTime);
            end if;
          end SampleClock;

          block Noise
            parameter Real y_min;
            parameter Real y_max;
            parameter Integer[3] firstSeed(each min = 0, each max = 255) = {23, 87, 187};
            parameter Types.BlockTypeWithGlobalDefault blockType = Types.BlockTypeWithGlobalDefault.UseSampleClockOption;
            final parameter Boolean continuous = blockType == Types.BlockTypeWithGlobalDefault.Continuous or blockType == Types.BlockTypeWithGlobalDefault.UseSampleClockOption and sampleClock.blockType == Types.BlockType.Continuous;
            parameter Integer sampleFactor(min = 1) = 1;
            Modelica.Blocks.Interfaces.RealOutput y;
          protected
            outer SampleClock sampleClock;
            Internal.DiscreteNoise discretePart(y_min = y_min, y_max = y_max, firstSeed = firstSeed, sampleFactor = sampleFactor) if not continuous;
          equation
            if continuous then
              y = 0.0;
            end if;
            connect(y, discretePart.y);
          end Noise;

          package Types
            type BlockType = enumeration(Continuous, Discrete);
            type BlockTypeWithGlobalDefault = enumeration(Continuous, Discrete, UseSampleClockOption);
            type Init = enumeration(NoInit, SteadyState, InitialState, InitialOutput);
            type FIRspec = enumeration(MeanValue, Window, Coefficients);
            type Window = enumeration(Rectangle, Bartlett, Hann, Hamming, Blackman, Kaiser);
          end Types;

          package Internal
            block DiscreteNoise
              parameter Real y_min;
              parameter Real y_max;
              parameter Integer[3] firstSeed(each min = 0, each max = 255) = {23, 87, 187};
              parameter Integer sampleFactor(min = 1) = 1;
              final parameter Modelica.SIunits.Time Ts = sampleClock.sampleTime * sampleFactor;
              Modelica.Blocks.Interfaces.RealOutput y;
            protected
              outer SampleClock sampleClock;
              Integer ticks;
              Integer[3] seedState;
              Boolean sampleTrigger;
              discrete Real noise;
              discrete Real y_sampled;
            initial equation
              pre(ticks) = 0;
              pre(seedState) = firstSeed;
            equation
              if sampleClock.blockType == Types.BlockType.Continuous then
                sampleTrigger = sample(Ts, Ts);
                ticks = 0;
              else
                when sampleClock.sampleTrigger then
                  ticks = if pre(ticks) < sampleFactor then pre(ticks) + 1 else 1;
                end when;
                sampleTrigger = sampleClock.sampleTrigger and ticks >= sampleFactor;
              end if;
              when {initial(), sampleTrigger} then
                (noise, seedState) = random(pre(seedState));
                y_sampled = y_min + (y_max - y_min) * noise;
              end when;
              y = y_sampled;
            end DiscreteNoise;

            function random
              input Integer[3] seedIn;
              output Real x;
              output Integer[3] seedOut;
            algorithm
              seedOut[1] := rem(171 * seedIn[1], 30269);
              seedOut[2] := rem(172 * seedIn[2], 30307);
              seedOut[3] := rem(170 * seedIn[3], 30323);
              for i in 1:3 loop
                if seedOut[i] == 0 then
                  seedOut[i] := 1;
                else
                end if;
              end for;
              x := rem(seedOut[1] / 30269.0 + seedOut[2] / 30307.0 + seedOut[3] / 30323.0, 1.0);
            end random;

            function bessel0
              input Real x;
              output Real y;
            protected
              Real ax;
              Real a;
            algorithm
              ax := abs(x);
              if ax < 3.75 then
                a := (x / 3.75) ^ 2;
                y := 1 + a * (3.5156229 + a * (3.0899424 + a * (1.2067492 + a * (0.2659732 + a * (0.0360768 + a * 0.0045813)))));
              else
                a := 3.75 / ax;
                y := exp(ax) / sqrt(ax) * (0.39894228 + a * (0.01328592 + a * (0.00225319 + a * ((-0.00157565) + a * (0.00916281 + a * ((-0.02057706) + a * (0.02635537 + a * ((-0.01647633) + a * 0.00392377))))))));
              end if;
            end bessel0;

            block DiscreteFIR
              extends Interfaces.PartialDiscreteSISO_equality;
              parameter Real[:] a = {1, 1};
            protected
              parameter Integer n = size(a, 1) - 1;
              discrete Real[n] x;
              discrete Real[n] sum;
              discrete Real y_sampled;
            initial equation
              x = pre(x);
            equation
              when {initial(), sampleTrigger} then
                u_sampled = u;
                x[1] = pre(u);
                sum[1] = a[2] * x[1];
                x[2:n] = pre(x[1:n - 1]);
                sum[2:n] = a[3:n + 1] * diagonal(x[2:n]) + sum[1:n - 1];
                y_sampled = a[1] * u + sum[n];
              end when;
              y = y_sampled;
            end DiscreteFIR;

            function FIR_coefficients
              input .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.FIRspec specType = Modelica_LinearSystems2.Controller.Types.FIRspec.MeanValue;
              input Integer L(min = 2) = 2;
              input .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType filterType = Modelica_LinearSystems2.Types.FilterType.LowPass;
              input Integer order(min = 1) = 2;
              input Modelica.SIunits.Frequency f_cut = 1;
              input Modelica.SIunits.Time Ts(min = 0);
              input Types.Window window = Modelica_LinearSystems2.Controller.Types.Window.Rectangle;
              input Real beta = 2.12;
              input Real[:] a_desired = {1, 1};
              output Real[if specType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.FIRspec.MeanValue then L else if specType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.FIRspec.Window then if mod(order, 2) > 0 and filterType == .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType.HighPass then order + 2 else order + 1 else size(a_desired, 1)] a;
            protected
              constant Real pi = Modelica.Constants.pi;
              Boolean isEven = mod(order, 2) == 0;
              Integer order2 = if not isEven and filterType == .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType.HighPass then order + 1 else order;
              Real Wc = 2 * pi * f_cut * Ts;
              Integer i;
              Real[order2 + 1] w;
              Real k;
            algorithm
              assert(f_cut <= 1 / (2 * Ts), "The cut-off frequency f_cut may not be greater than half the sample frequency (Nyquist frequency), i.e. f_cut <= " + String(1 / (2 * Ts)) + " but is " + String(f_cut));
              if specType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.FIRspec.MeanValue then
                a := fill(1 / L, L);
              elseif specType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.FIRspec.Window then
                w := Internal.FIR_window(order2 + 1, window, beta);
                for i in 1:order2 + 1 loop
                  k := i - 1 - order2 / 2;
                  if i - 1 == order2 / 2 then
                    a[i] := if filterType == .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType.LowPass then Wc * w[i] / pi else w[i] - Wc * w[i] / pi;
                  else
                    a[i] := if filterType == .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType.LowPass then sin(k * Wc) * w[i] / (k * pi) else w[i] * (sin(k * pi) - sin(k * Wc)) / (k * pi);
                  end if;
                end for;
              else
                a := a_desired;
              end if;
              if not isEven and filterType == .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType.HighPass then
                Modelica.Utilities.Streams.print("The requested order of the FIR filter in FIR_coefficients is odd and has been increased by one to get an even order filter\n");
              else
              end if;
            end FIR_coefficients;

            function FIR_window
              input Integer L;
              input .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window window;
              input Real beta = 2.12;
              output Real[L] a;
            protected
              Integer i = 0;
              constant Real pi = Modelica.Constants.pi;
              Real k;
            algorithm
              if window <> .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Rectangle then
                for i in 1:L loop
                  k := i - 1 - (L - 1) / 2;
                  if window == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Bartlett then
                    a[i] := 1 - 2 * abs(k) / (L - 1);
                  elseif window == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Hann then
                    a[i] := 0.5 + 0.5 * cos(2 * pi * k / (L - 1));
                  elseif window == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Hamming then
                    a[i] := 0.54 + 0.46 * cos(2 * pi * k / (L - 1));
                  elseif window == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Blackman then
                    a[i] := 0.42 + 0.5 * cos(2 * pi * k / (L - 1)) + 0.08 * cos(4 * pi * k / (L - 1));
                  elseif window == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.Window.Kaiser then
                    k := 2 * beta * sqrt((i - 1) * (L - i)) / (L - 1);
                    a[i] := Internal.bessel0(k) / Internal.bessel0(beta);
                  else
                    Modelica.Utilities.Streams.error("window = " + String(window) + " not known");
                  end if;
                end for;
              else
                a := ones(L);
              end if;
            end FIR_window;
          end Internal;

          block FilterFIR
            extends Interfaces.PartialSISO_equality;
            parameter Types.FIRspec specType = Modelica_LinearSystems2.Controller.Types.FIRspec.MeanValue;
            parameter Integer L(min = 2) = 2;
            parameter .Noise.Examples.Parts.Modelica_LinearSystems2.Types.FilterType filterType = Modelica_LinearSystems2.Types.FilterType.LowPass;
            parameter Integer order(min = 1) = 2;
            parameter Modelica.SIunits.Frequency f_cut = 1;
            parameter Types.Window window = Modelica_LinearSystems2.Controller.Types.Window.Rectangle;
            parameter Real beta = 2.12;
            parameter Real[:] a = {1, 1};
          protected
            parameter Real[:] a2 = Internal.FIR_coefficients(specType, L, filterType, order, f_cut, sampleClock.sampleTime * sampleFactor, window, beta, a) if not continuous;
            Internal.DiscreteFIR discretePart(sampleFactor = sampleFactor, a = a2) if not continuous;
          equation
            if continuous then
              y = u;
            end if;
            connect(u, discretePart.u);
            connect(y, discretePart.y);
          end FilterFIR;

          package Interfaces
            partial block PartialDiscreteSISO_equality
              parameter Integer sampleFactor(min = 1) = 1;
              final parameter Modelica.SIunits.Time Ts = sampleClock.sampleTime * sampleFactor;
              Modelica.Blocks.Interfaces.RealInput u;
              Modelica.Blocks.Interfaces.RealOutput y;
            protected
              outer SampleClock sampleClock;
              discrete Real u_sampled;
              Integer ticks;
              Boolean sampleTrigger;
            initial equation
              pre(ticks) = 0;
            equation
              if sampleClock.blockType == Types.BlockType.Continuous then
                sampleTrigger = sample(Ts, Ts);
                ticks = 0;
              else
                when sampleClock.sampleTrigger then
                  ticks = if pre(ticks) < sampleFactor then pre(ticks) + 1 else 1;
                end when;
                sampleTrigger = sampleClock.sampleTrigger and ticks >= sampleFactor;
              end if;
            end PartialDiscreteSISO_equality;

            partial block PartialSISO_equality
              parameter .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault blockType = Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.UseSampleClockOption;
              final parameter Boolean continuous = blockType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Continuous or blockType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.UseSampleClockOption and sampleClock.blockType == .Noise.Examples.Parts.Modelica_LinearSystems2.Controller.Types.BlockType.Continuous;
              parameter Integer sampleFactor(min = 1) = 1;
              Modelica.Blocks.Interfaces.RealInput u;
              Modelica.Blocks.Interfaces.RealOutput y;
            protected
              outer SampleClock sampleClock;
            end PartialSISO_equality;
          end Interfaces;
        end Controller;

        package Types
          type Method = enumeration(ExplicitEuler, ImplicitEuler, Trapezoidal, ImpulseExact, StepExact, RampExact);
          type FilterType = enumeration(LowPass, HighPass, BandPass, BandStop);
        end Types;
      end Modelica_LinearSystems2;
    end Parts;
  end Examples;
end Noise;

model ActuatorLinearSystemsNoise
  extends Noise.Examples.Actuator.ActuatorLinearSystemsNoise;
end ActuatorLinearSystemsNoise;
