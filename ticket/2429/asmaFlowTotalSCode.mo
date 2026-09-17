model asmaFlow  
  parameter Modelica.SIunits.AngularVelocity DeltaOmEl = 25;
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox;
  Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(p = 2, fsNominal = 50, Rs = 0.435, Lssigma = 0.004, Lrsigma = 0.002, Rr = 0.4, Jr = 2, Lm = 0.06931);
  Modelica.Electrical.Analog.Basic.Ground ground;
  Modelica.Electrical.MultiPhase.Basic.Star star;
  Modelica.Mechanics.Rotational.Sources.Torque torque;
  Modelica.Blocks.Sources.Constant const(k = -15);
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor;
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sinevoltage1(V = 230 * sqrt(2) / sqrt(3) * ones(3), freqHz = 50 * ones(3));
equation
  connect(sinevoltage1.plug_n, terminalBox.plugSupply);
  connect(sinevoltage1.plug_p, star.plug_p);
  connect(terminalBox.plug_sn, aimc.plug_sn);
  connect(terminalBox.plug_sp, aimc.plug_sp);
  connect(ground.p, star.pin_n);
  connect(torque.flange, aimc.flange);
  connect(const.y, torque.tau);
  connect(speedSensor.flange, torque.flange);
end asmaFlow;

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

      partial block SignalSource  
        extends SO;
        parameter Real offset = 0;
        parameter .Modelica.SIunits.Time startTime = 0;
      end SignalSource;
    end Interfaces;

    package Sources  
      extends Modelica.Icons.SourcesPackage;

      block Constant  
        parameter Real k(start = 1);
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = k;
      end Constant;

      block Sine  
        parameter Real amplitude = 1;
        parameter .Modelica.SIunits.Frequency freqHz(start = 1);
        parameter .Modelica.SIunits.Angle phase = 0;
        parameter Real offset = 0;
        parameter .Modelica.SIunits.Time startTime = 0;
        extends .Modelica.Blocks.Interfaces.SO;
      protected
        constant Real pi = Modelica.Constants.pi;
      equation
        y = offset + (if time < startTime then 0 else amplitude * Modelica.Math.sin(2 * pi * freqHz * (time - startTime) + phase));
      end Sine;
    end Sources;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial block Block  end Block;
    end Icons;
  end Blocks;

  package Electrical  
    extends Modelica.Icons.Package;

    package Analog  
      extends Modelica.Icons.Package;

      package Basic  
        extends Modelica.Icons.Package;

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
        extends Modelica.Icons.InterfacesPackage;

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

        partial model VoltageSource  
          extends OnePort;
          parameter .Modelica.SIunits.Voltage offset = 0;
          parameter .Modelica.SIunits.Time startTime = 0;
          replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(final offset = offset, final startTime = startTime);
        equation
          v = signalSource.y;
        end VoltageSource;
      end Interfaces;

      package Sources  
        extends Modelica.Icons.SourcesPackage;

        model SineVoltage  
          parameter .Modelica.SIunits.Voltage V(start = 1);
          parameter .Modelica.SIunits.Angle phase = 0;
          parameter .Modelica.SIunits.Frequency freqHz(start = 1);
          extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Sine signalSource(amplitude = V, freqHz = freqHz, phase = phase));
        end SineVoltage;
      end Sources;
    end Analog;

    package Machines  
      extends Modelica.Icons.Package;

      package BasicMachines  
        extends Modelica.Icons.Package;

        package AsynchronousInductionMachines  
          extends Modelica.Icons.VariantsPackage;

          model AIM_SquirrelCage  
            extends Machines.Interfaces.PartialBasicInductionMachine(final idq_ss = airGapS.i_ss, final idq_sr = airGapS.i_sr, final idq_rs = airGapS.i_rs, final idq_rr = airGapS.i_rr, redeclare final Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC thermalAmbient(final Tr = TrOperational), redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMC thermalPort, redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMC internalThermalPort, redeclare final Machines.Interfaces.InductionMachines.PowerBalanceAIMC powerBalance(final lossPowerRotorWinding = squirrelCageR.LossPower, final lossPowerRotorCore = 0), statorCore(final w = statorCoreParameters.wRef));
            output Modelica.SIunits.Current[2] ir = -squirrelCageR.spacePhasor_r.i_;
            Machines.BasicMachines.Components.AirGapS airGapS(final p = p, final Lm = Lm, final m = m);
            parameter Modelica.SIunits.Inductance Lm(start = 3 * sqrt(1 - 0.0667) / (2 * pi * fsNominal));
            parameter Modelica.SIunits.Inductance Lrsigma(start = 3 * (1 - sqrt(1 - 0.0667)) / (2 * pi * fsNominal));
            parameter Modelica.SIunits.Resistance Rr(start = 0.04);
            parameter Modelica.SIunits.Temperature TrRef(start = 293.15);
            parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start = 0);
            parameter Modelica.SIunits.Temperature TrOperational(start = 293.15);
            Machines.BasicMachines.Components.SquirrelCage squirrelCageR(final Lrsigma = Lrsigma, final Rr = Rr, final useHeatPort = true, final T_ref = TrRef, final T = TrRef, final alpha = Machines.Thermal.convertAlpha(alpha20r, TrRef));
          equation
            connect(airGapS.spacePhasor_r, squirrelCageR.spacePhasor_r);
            connect(airGapS.flange, inertiaRotor.flange_a);
            connect(lssigma.spacePhasor_b, airGapS.spacePhasor_s);
            connect(squirrelCageR.heatPort, internalThermalPort.heatPortRotorWinding);
            connect(airGapS.support, internalSupport);
          end AIM_SquirrelCage;
        end AsynchronousInductionMachines;

        package Components  
          extends Modelica.Icons.Package;

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

          model AirGapS  
            parameter Modelica.SIunits.Inductance Lm;
            extends PartialAirGap;
            Modelica.SIunits.Current[2] i_ms;
          protected
            parameter Modelica.SIunits.Inductance[2, 2] L = {{Lm, 0}, {0, Lm}};
          equation
            i_ms = i_ss + i_rs;
            psi_ms = L * i_ms;
            psi_mr = transpose(RotationMatrix) * psi_ms;
          end AirGapS;

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

          model SquirrelCage  
            parameter Modelica.SIunits.Inductance Lrsigma;
            parameter Modelica.SIunits.Resistance Rr;
            parameter Modelica.SIunits.Temperature T_ref = 293.15;
            parameter Modelica.SIunits.LinearTemperatureCoefficient alpha = 0;
            extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
            Modelica.SIunits.Resistance Rr_actual;
            Machines.Interfaces.SpacePhasor spacePhasor_r;
          equation
            assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
            Rr_actual = Rr * (1 + alpha * (T_heatPort - T_ref));
            spacePhasor_r.v_ = Rr_actual * spacePhasor_r.i_ + Lrsigma * der(spacePhasor_r.i_);
            2 / 3 * LossPower = Rr_actual * (spacePhasor_r.i_[1] * spacePhasor_r.i_[1] + spacePhasor_r.i_[2] * spacePhasor_r.i_[2]);
          end SquirrelCage;
        end Components;
      end BasicMachines;

      package SpacePhasors  
        extends Modelica.Icons.Package;

        package Components  
          extends Modelica.Icons.Package;

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

        package Functions  
          extends Modelica.Icons.Package;

          function activePower  
            extends Modelica.Icons.Function;
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
            p := m / 2 * (+v_[1] * i_[1] + v_[2] * i_[2]);
          end activePower;
        end Functions;
      end SpacePhasors;

      package Losses  
        extends Modelica.Icons.Package;

        record FrictionParameters  
          extends Modelica.Icons.Record;
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.AngularVelocity wRef(displayUnit = "1/min", min = Modelica.Constants.small);
          parameter Real power_w(min = Modelica.Constants.small) = 2;
          final parameter Modelica.SIunits.Torque tauRef = if PRef <= 0 then 0 else PRef / wRef;
          final parameter Real linear = 0.001;
          final parameter Modelica.SIunits.AngularVelocity wLinear = linear * wRef;
          final parameter Modelica.SIunits.Torque tauLinear = if PRef <= 0 then 0 else tauRef * (wLinear / wRef) ^ power_w;
        end FrictionParameters;

        record StrayLoadParameters  
          extends Modelica.Icons.Record;
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.Current IRef(min = Modelica.Constants.small);
          parameter Modelica.SIunits.AngularVelocity wRef(displayUnit = "1/min", min = Modelica.Constants.small);
          parameter Real power_w(min = Modelica.Constants.small) = 1;
          final parameter Modelica.SIunits.Torque tauRef = if PRef <= 0 then 0 else PRef / wRef;
        end StrayLoadParameters;

        record CoreParameters  
          extends Modelica.Icons.Record;
          parameter Integer m;
          parameter Modelica.SIunits.Power PRef(min = 0) = 0;
          parameter Modelica.SIunits.Voltage VRef(min = Modelica.Constants.small);
          parameter Modelica.SIunits.AngularVelocity wRef(min = Modelica.Constants.small);
          final parameter Real ratioHysteresis(min = 0, max = 1, start = 0.775) = 0;
          final parameter Modelica.SIunits.Conductance GcRef = if PRef <= 0 then 0 else PRef / VRef ^ 2 / m;
          final parameter Modelica.SIunits.AngularVelocity wMin = 0.000001 * wRef;
        end CoreParameters;

        model Friction  
          extends Machines.Interfaces.FlangeSupport;
          parameter FrictionParameters frictionParameters;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(useHeatPort = false);
        equation
          if frictionParameters.PRef <= 0 then
            tau = 0;
          else
            tau = -smooth(1, if w >= +frictionParameters.wLinear then +frictionParameters.tauRef * (+w / frictionParameters.wRef) ^ frictionParameters.power_w else if w <= -frictionParameters.wLinear then -frictionParameters.tauRef * (-w / frictionParameters.wRef) ^ frictionParameters.power_w else frictionParameters.tauLinear * w / frictionParameters.wLinear);
          end if;
          lossPower = -tau * w;
        end Friction;

        package InductionMachines  
          extends Modelica.Icons.VariantsPackage;

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
            lossPower = 3 / 2 * (+spacePhasor.v_[1] * spacePhasor.i_[1] + spacePhasor.v_[2] * spacePhasor.i_[2]);
          end Core;
        end InductionMachines;
      end Losses;

      package Thermal  
        extends Modelica.Icons.Package;
        type LinearTemperatureCoefficient20 = Modelica.SIunits.LinearTemperatureCoefficient;

        function convertAlpha  
          extends Modelica.Icons.Function;
          input Modelica.SIunits.LinearTemperatureCoefficient alpha1;
          input Modelica.SIunits.Temperature T2;
          input Modelica.SIunits.Temperature T1 = 293.15;
          output Modelica.SIunits.LinearTemperatureCoefficient alpha2;
        algorithm
          alpha2 := alpha1 / (1 + alpha1 * (T2 - T1));
        end convertAlpha;

        package AsynchronousInductionMachines  
          extends Modelica.Icons.VariantsPackage;

          model ThermalAmbientAIMC  
            extends Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(redeclare final Machines.Interfaces.InductionMachines.ThermalPortAIMC thermalPort);
            parameter Modelica.SIunits.Temperature Tr(start = TDefault);
            output Modelica.SIunits.HeatFlowRate Q_flowRotorWinding = temperatureRotorWinding.port.Q_flow;
            output Modelica.SIunits.HeatFlowRate Q_flowTotal = Q_flowStatorWinding + Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore + Q_flowStrayLoad + Q_flowFriction;
            Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperatureRotorWinding;
            Modelica.Blocks.Interfaces.RealInput TRotorWinding if useTemperatureInputs;
            Modelica.Blocks.Sources.Constant constTr(final k = Tr) if not useTemperatureInputs;
          equation
            connect(constTr.y, temperatureRotorWinding.T);
            connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding);
            connect(TRotorWinding, temperatureRotorWinding.T);
          end ThermalAmbientAIMC;
        end AsynchronousInductionMachines;
      end Thermal;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector SpacePhasor  
          Modelica.SIunits.Voltage[2] v_;
          flow Modelica.SIunits.Current[2] i_;
        end SpacePhasor;

        partial model PartialBasicMachine  
          extends Machines.Icons.TransientMachine;
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
          extends Modelica.Icons.VariantsPackage;

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
            extends Modelica.Icons.Record;
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

          connector ThermalPortAIMC  
            extends Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRotorWinding;
          end ThermalPortAIMC;

          record PowerBalanceAIMC  
            extends Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(final lossPowerTotal = lossPowerStatorWinding + lossPowerStatorCore + lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + lossPowerRotorWinding);
            Modelica.SIunits.Power lossPowerRotorWinding;
          end PowerBalanceAIMC;
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

      package Icons  
        extends Modelica.Icons.IconsPackage;

        partial model TransientMachine  end TransientMachine;
      end Icons;

      package Utilities  
        extends Modelica.Icons.UtilitiesPackage;

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
      extends Modelica.Icons.Package;

      package Basic  
        extends Modelica.Icons.Package;

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
        extends Modelica.Icons.Package;

        function quasiRMS  
          extends Modelica.Icons.Function;
          input Real[:] x;
          output Real y;
        algorithm
          y := sqrt(sum(x .^ 2 / size(x, 1)));
        end quasiRMS;

        function symmetricOrientation  
          extends Modelica.Icons.Function;
          input Integer m;
          output Modelica.SIunits.Angle[m] orientation;
        algorithm
          if mod(m, 2) == 0 then
            if m == 2 then
              orientation[1] := 0;
              orientation[2] := +.Modelica.Constants.pi / 2;
            else
              orientation[1:integer(m / 2)] := symmetricOrientation(integer(m / 2));
              orientation[integer(m / 2) + 1:m] := symmetricOrientation(integer(m / 2)) - fill(.Modelica.Constants.pi / m, integer(m / 2));
            end if;
          else
            orientation := array((k - 1) * 2 * .Modelica.Constants.pi / m for k in 1:m);
          end if;
        end symmetricOrientation;
      end Functions;

      package Sources  
        extends Modelica.Icons.SourcesPackage;

        model SineVoltage  
          extends Interfaces.TwoPlug;
          parameter Modelica.SIunits.Voltage[m] V(start = fill(1, m));
          parameter Modelica.SIunits.Angle[m] phase = -Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
          parameter Modelica.SIunits.Frequency[m] freqHz(start = fill(1, m));
          parameter Modelica.SIunits.Voltage[m] offset = zeros(m);
          parameter Modelica.SIunits.Time[m] startTime = zeros(m);
          Modelica.Electrical.Analog.Sources.SineVoltage[m] sineVoltage(final V = V, final phase = phase, final freqHz = freqHz, final offset = offset, final startTime = startTime);
        equation
          connect(sineVoltage.p, plug_p.pin);
          connect(sineVoltage.n, plug_n.pin);
        end SineVoltage;
      end Sources;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

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
    extends Modelica.Icons.Package;

    package Rotational  
      extends Modelica.Icons.Package;

      package Components  
        extends Modelica.Icons.Package;

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
      end Components;

      package Sensors  
        extends Modelica.Icons.SensorsPackage;

        model SpeedSensor  
          extends Rotational.Interfaces.PartialAbsoluteSensor;
          Modelica.Blocks.Interfaces.RealOutput w(unit = "rad/s");
        equation
          w = der(flange.phi);
        end SpeedSensor;
      end Sensors;

      package Sources  
        extends Modelica.Icons.SourcesPackage;

        model Torque  
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
          Modelica.Blocks.Interfaces.RealInput tau(unit = "N.m");
        equation
          flange.tau = -tau;
        end Torque;
      end Sources;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

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

        partial model PartialElementaryOneFlangeAndSupport2  
          parameter Boolean useSupport = false;
          Flange_b flange;
          Support support(phi = phi_support, tau = -flange.tau) if useSupport;
        protected
          Modelica.SIunits.Angle phi_support;
        equation
          if not useSupport then
            phi_support = 0;
          end if;
        end PartialElementaryOneFlangeAndSupport2;

        partial model PartialAbsoluteSensor  
          extends Modelica.Icons.RotationalSensor;
          Flange_a flange;
        equation
          0 = flange.tau;
        end PartialAbsoluteSensor;
      end Interfaces;
    end Rotational;
  end Mechanics;

  package Thermal  
    extends Modelica.Icons.Package;

    package HeatTransfer  
      extends Modelica.Icons.Package;

      package Components  
        extends Modelica.Icons.Package;

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
        extends Modelica.Icons.SourcesPackage;

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
        extends Modelica.Icons.InterfacesPackage;

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
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  
    extends Modelica.Icons.Package;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  end AxisLeft;

      partial function AxisCenter  end AxisCenter;
    end Icons;

    function sin  
      extends Modelica.Math.Icons.AxisLeft;
      input Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = sin(u);
    end sin;

    function asin  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function exp  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Constants  
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps;
    final constant Real small = ModelicaServices.Machine.small;
    final constant .Modelica.SIunits.Velocity c = 299792458;
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 0.0000001;
  end Constants;

  package Icons  
    extends Icons.Package;

    partial package Package  end Package;

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

    partial package IconsPackage  
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial class RotationalSensor  end RotationalSensor;

    partial function Function  end Function;

    partial record Record  end Record;
  end Icons;

  package SIunits  
    extends Modelica.Icons.Package;

    package Conversions  
      extends Modelica.Icons.Package;

      package NonSIunits  
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC");
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Inertia = MomentOfInertia;
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
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
