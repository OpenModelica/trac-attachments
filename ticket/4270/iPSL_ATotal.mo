package iPSL  "iTesla Power System Library" 
  extends Modelica.Icons.Package;

  package Electrical  
    package Buses  
      model InfiniteBus2  
        iPSL.Connectors.PwPin p;
        parameter Real angle "Bus voltage angle (deg)";
        Modelica.Blocks.Interfaces.RealInput V "Bus voltage magnitude (pu)";
      equation
        p.vr = V * cos(angle * Modelica.Constants.pi / 180);
        p.vi = V * sin(angle * Modelica.Constants.pi / 180);
      end InfiniteBus2;
    end Buses;

    package Branches  
      model PwLine  "Model for a transmission Line based on the pi-equivalent circuit" 
        outer iPSL.Electrical.SystemBase SysData;
        iPSL.Connectors.PwPin p;
        iPSL.Connectors.PwPin n;
        parameter Real R "Resistance (pu)";
        parameter Real X "Reactance (pu)";
        parameter Real G "Shunt half conductance (pu)";
        parameter Real B "Shunt half susceptance (pu)";
        parameter Real S_b = SysData.S_b "System base power (MVA)";
        parameter Real t1 = Modelica.Constants.inf;
        parameter Real t2 = Modelica.Constants.inf;
        parameter Integer opening = 1;
        parameter Boolean displayPF = false "Enable/Disable";
        Real P12;
        Real P21;
        Real Q12;
        Real Q21;
        Complex vs(re = p.vr, im = p.vi);
        Complex is(re = p.ir, im = p.ii);
        Complex vr(re = n.vr, im = n.vi);
        Complex ir(re = n.ir, im = n.ii);
      protected
        parameter Complex Y(re = G, im = B);
        parameter Complex Z(re = R, im = X);
      equation
        P12 = .Modelica.ComplexMath.real(vs * .Modelica.ComplexMath.conj(is)) * S_b;
        P21 = -.Modelica.ComplexMath.real(vr * .Modelica.ComplexMath.conj(ir)) * S_b;
        Q12 = .Modelica.ComplexMath.imag(vs * .Modelica.ComplexMath.conj(is)) * S_b;
        Q21 = -.Modelica.ComplexMath.imag(vr * .Modelica.ComplexMath.conj(ir)) * S_b;
        if time >= t1 and time < t2 then
          if opening == 1 then
            is = 0 + .Modelica.ComplexMath.j * 0;
            ir = 0 + .Modelica.ComplexMath.j * 0;
          elseif opening == 2 then
            is = 0 + .Modelica.ComplexMath.j * 0;
            ir = (vr - ir * Z) * Y;
          else
            ir = 0 + .Modelica.ComplexMath.j * 0;
            is = (vs - is * Z) * Y;
          end if;
        else
          vs - vr = Z * (is - vs * Y);
          vr - vs = Z * (ir - vr * Y);
        end if;
      end PwLine;
    end Branches;

    package Machines  
      package Eurostag  
        model PwGeneratorM1S  "Synchronous machine model according to Park's classical theory (Full model description).
                           The model corresponds to Eurostag's full model for M1S machine 
                           (defined by internal parameters). Developed by RTE and adapted by AIA.
                           2014/03/10. Update and validate by AIA (Change pin_OMEGA to RealOutput). 2016 " 
          iPSL.Connectors.PwPin sortie;
          Modelica.Blocks.Interfaces.RealInput pin_EFD;
          Modelica.Blocks.Interfaces.RealOutput pin_OMEGA;
          Modelica.Blocks.Interfaces.RealInput pin_CM;
          Modelica.Blocks.Interfaces.RealInput omegaRef;
          Real cm(start = init_cm);
          Real efd(start = init_efd);
          Real ur;
          Real ui;
          Real lambdaf(start = init_lambdaf);
          Real lambdad(start = init_lambdad);
          Real lambdaad(start = init_lambdaad);
          Real lambdaaq(start = init_lambdaaq);
          Real lambdaq1(start = init_lambdaq1);
          Real lambdaq2(start = init_lambdaq2);
          Real id(start = init_id);
          Real iq(start = init_iq);
          Real theta(start = init_theta);
          Real omega(start = init_omega);
          Real E;
          Real Mds;
          Real Mqs;
          Real Md;
          Real Mq;
          Real Mi;
          Real LMD;
          Real LMQ;
          parameter Real init_lambdaf = 0;
          parameter Real init_lambdad = 0;
          parameter Real init_lambdaad = 0;
          parameter Real init_lambdaaq = 0;
          parameter Real init_lambdaq1 = 0;
          parameter Real init_lambdaq2 = 0;
          parameter Real init_id = 0;
          parameter Real init_iq = 0;
          parameter Real init_theta = 0;
          parameter Real init_omega = 1;
          parameter Real init_cm = 0;
          parameter Real init_efd = 0;
          parameter Real omega0 = 2 * 3.14159265 * 50 "Nominal network angular frequency";
          parameter Real SNREF = 100 "MVA system base";
          parameter Real SN = 1150 "Nominal apparent power (MVA)";
          parameter Real PN = 1000 "Nominal turbine (active) power (MW)";
          parameter Real PNALT = 1100;
          parameter Real rStatIn = 0.004 "Stator resistance p.u. in the machine SN base";
          parameter Real lStatIn = 0.219 "Stator leakage p.u. in the machine SN base";
          parameter Real mD0Pu = 2.351 "d axis mutual inductance p.u. in the machine SN base";
          parameter Real WLMDVPu = 0.7459 "d axis mutual inductance corresponding to magnetic condition taken for setting the voltage regulator";
          parameter Real mCanPu = 0.0 "CANAY's inductance p.u. in the machine SN base";
          parameter Real rDPu = 0.01723 "d axis damper winding resistance p.u. in the machine SN base";
          parameter Real lDPu = 0.12825 "d axis damper winding leakage p.u. in the machine SN base";
          parameter Real rRotIn = 0.00113 "Rotor resistance p.u. in the machine SN base";
          parameter Real lRotIn = 0.24253 "Rotor leakage p.u. in the machine SN base";
          parameter Real mQ0Pu = 2.351 "q axis mutual inductance p.u. in the machine SN base";
          parameter Real rQ1Pu = 0.0193 "q axis damper 1 winding resistance p.u. in the machine SN base";
          parameter Real lQ1Pu = 0.08921 "q axis damper 1 winding leakeage p.u. in the machine SN base";
          parameter Real rQ2Pu = 0.03923 "q axis damper 2 winding resistance p.u. in the machine SN base";
          parameter Real lQ2Pu = 1.78484 "q axis damper 2 winding leakeage p.u. in the machine SN base";
          parameter Real md = 0.1 "Coefficient md of the saturation curve";
          parameter Real mq = 0.1 "Coefficient mq of the saturation curve";
          parameter Real snd = 6 "Coefficient nd of the saturation curve";
          parameter Real snq = 6 "Coefficient nq of the saturation curve";
          parameter Real DIn = 0.0 "mechanical damping coefficient";
          parameter Real HIn = 6.3 "Constant of inertia";
          parameter Real U1N = 24 "nominal voltage machine side";
          parameter Real V1 = 24 "base voltage machine side";
          parameter Real U2N = 400 "nominal voltage machine side";
          parameter Real V2 = 380 "base voltage machine side";
          parameter Boolean transformerIncluded = false;
          parameter Real RTfoPu = if transformerIncluded then 0.000185 else 0 "Machine transoformer resistance p.u. in the SNTfo base";
          parameter Real XTfoPu = if transformerIncluded then 0.00769 else 0 "Machine transoformer resistance p.u. in the SNTfo base";
          parameter Integer IWLMDV = 3;
          parameter Boolean Saturated = true;
          parameter Real yscale = if RT > 0.0 or XT > 0.0 then SNREF / SN * rtfo * rtfo else SNREF / SN;
          parameter Real SNtfo = 1300 "Machine transformer rating";
          parameter Real r = rStatIn * yscale "Stator Resistance";
          parameter Real rf = rRotIn * yscale "Rotor Resistance";
          parameter Real lld = lStatIn * yscale "Stator leakage";
          parameter Real lf = lRotIn * yscale "Rotor leakage";
          parameter Real mrc = mCanPu * yscale "CANAY's inductance";
          parameter Real lD = lDPu * yscale "d axis damper winding leakage";
          parameter Real rD = rDPu * yscale "d axis damper winding resistance";
          parameter Real rQ1 = rQ1Pu * yscale "q axis damper 1 winding resistance";
          parameter Real rQ2 = rQ2Pu * yscale "q axis damper 2 winding resistance";
          parameter Real lQ1 = lQ1Pu * yscale "q axis damper 1 winding leakeage";
          parameter Real lQ2 = lQ2Pu * yscale "q axis damper 2 winding leakeage";
          parameter Real RT = RTfoPu * SNREF / SNtfo * rtfo * rtfo "Machine transformer resistance (p.u.), enter value*SNREF/SNtfo";
          parameter Real XT = XTfoPu * SNREF / SNtfo * rtfo * rtfo "Machine transformer reactance (p.u.), enter value*SNREF/SNtfo";
          parameter Real Md0 = mD0Pu * yscale "d axis mutual inductance";
          parameter Real Mq0 = mQ0Pu * yscale "q axis mutual inductance";
          parameter Real Mdv = WLMDVPu * yscale;
          parameter Real D = DIn * SN / SNREF "Mechanical damping coefficient";
          parameter Real H = HIn * SN / SNREF "Constant of inertia";
          parameter Real rtfo = if transformerIncluded then U2N / V2 / (U1N / V1) else 1 "Transformer ratio";
          parameter Real DET = lf * lD + mrc * lf + mrc * lD;
          parameter Real Mdif = Md0 - Mq0;
          parameter Real Sdet = lf / DET + lD / DET;
          parameter Real Slq = 1.0 / lQ1 + 1.0 / lQ2;
          parameter Real Lddet = lD / DET;
          parameter Real Lfdet = lf / DET;
          parameter Real Lq1inv = 1.0 / lQ1;
          parameter Real Lq2inv = 1.0 / lQ2;
          parameter Real Sr = r + RT;
          parameter Real Sx = lld + XT;
          parameter Real Coef11 = rtfo * omega0 * rf / Mdv;
          parameter Real Coef12 = rf * omega0 * (lD + mrc) / DET;
          parameter Real Coef13 = rf * omega0 * mrc / DET;
          parameter Real Coef14 = omega0 * rf * lD / DET;
          parameter Real Coef21 = omega0 * rD * mrc / DET;
          parameter Real Coef22 = omega0 * rD * (lf + mrc) / DET;
          parameter Real Coef23 = omega0 * rD * lf / DET;
          parameter Real Coef31 = omega0 * rQ1 / lQ1;
          parameter Real Coef32 = omega0 * rQ1 / lQ1;
          parameter Real Coef41 = omega0 * rQ2 / lQ2;
          parameter Real Coef42 = omega0 * rQ2 / lQ2;
          parameter Real Coef51 = PN / (SNREF * 2 * H);
          parameter Real Coef52 = D / (2 * H);
          parameter Real Coef53 = 1.0 / (2 * H);
          Modelica.Blocks.Interfaces.RealOutput pin_TETA;
          Modelica.Blocks.Interfaces.RealOutput pin_UR;
          Modelica.Blocks.Interfaces.RealOutput pin_UI;
          Modelica.Blocks.Interfaces.RealOutput pin_FieldCurrent;
          Modelica.Blocks.Interfaces.RealOutput pin_TerminalVoltage;
          Modelica.Blocks.Interfaces.RealOutput pin_ActivePowerPNALT;
          Modelica.Blocks.Interfaces.RealOutput pin_ActivePowerPN;
          Modelica.Blocks.Interfaces.RealOutput pin_ActivePowerSNREF;
          Modelica.Blocks.Interfaces.RealOutput pin_ReactivePowerPNALT;
          Modelica.Blocks.Interfaces.RealOutput pin_ReactivePowerPN;
          Modelica.Blocks.Interfaces.RealOutput pin_ReactivePowerSNREF;
          Modelica.Blocks.Interfaces.RealOutput pin_ActivePowerSN;
          Modelica.Blocks.Interfaces.RealOutput pin_ReactivePowerSN;
          Modelica.Blocks.Interfaces.RealOutput pin_Current;
          Modelica.Blocks.Interfaces.RealOutput pin_FRZPU;
          Modelica.Blocks.Interfaces.RealOutput pin_FRZHZ;
        equation
          der(lambdaf) = (-efd * Coef11) - lambdaf * Coef12 + lambdad * Coef13 + lambdaad * Coef14;
          der(lambdad) = lambdaf * Coef21 - lambdad * Coef22 + lambdaad * Coef23;
          der(lambdaq1) = (-lambdaq1 * Coef31) + lambdaaq * Coef32;
          der(lambdaq2) = (-lambdaq2 * Coef41) + lambdaaq * Coef42;
          der(omega) = cm * Coef51 + (omegaRef - omega) * Coef52 + lambdaad * iq * Coef53 - lambdaaq * id * Coef53;
          der(theta) = (omega - omegaRef) * omega0;
          E = sqrt(lambdaad * lambdaad + lambdaaq * lambdaaq);
          if Saturated then
            Mds = Md0 / (1 + md / rtfo ^ snd * E ^ snd);
            Mqs = Mq0 / (1 + mq / rtfo ^ snq * E ^ snq);
          else
            Mds = Md0;
            Mqs = Mq0;
          end if;
          Mi = Mds * lambdaad * lambdaad / (E * E) + Mqs * lambdaaq * lambdaaq / (E * E);
          Md = Mi + Mdif * lambdaaq * lambdaaq / (E * E);
          Mq = Mi - Mdif * lambdaad * lambdaad / (E * E);
          LMD = 1.0 / (1.0 / Md + Sdet);
          LMQ = 1.0 / (1.0 / Mq + Slq);
          0 = (-lambdaad) + LMD * (id + lambdaf * Lddet + lambdad * Lfdet);
          0 = (-lambdaaq) + LMQ * (iq + lambdaq1 * Lq1inv + lambdaq2 * Lq2inv);
          0 = sin(theta) * ur - cos(theta) * ui + id * Sr - iq * Sx - omega * lambdaaq;
          0 = cos(theta) * ur + sin(theta) * ui + iq * Sr + id * Sx + omega * lambdaad;
          sortie.ir = -(sin(theta) * id + cos(theta) * iq);
          sortie.ii = -((-cos(theta) * id) + sin(theta) * iq);
          pin_TETA = theta;
          pin_OMEGA = omega;
          pin_CM = cm;
          pin_EFD = efd;
          pin_UR = ur;
          pin_UI = ui;
          sortie.vr = ur;
          sortie.vi = ui;
          pin_TerminalVoltage = sqrt((sortie.vr - RT * sortie.ir + XT * sortie.ii) * (sortie.vr - RT * sortie.ir + XT * sortie.ii) + (sortie.vi - RT * sortie.ii - XT * sortie.ir) * (sortie.vi - RT * sortie.ii - XT * sortie.ir)) * 1 / rtfo;
          pin_ActivePowerPN = (sortie.vr * (-sortie.ir) + sortie.vi * (-sortie.ii)) * SNREF / PN;
          if PNALT == 0 then
            pin_ActivePowerPNALT = 0;
          else
            pin_ActivePowerPNALT = (sortie.vr * (-sortie.ir) + sortie.vi * (-sortie.ii)) * SNREF / PNALT;
          end if;
          pin_ActivePowerSNREF = sortie.vr * (-sortie.ir) + sortie.vi * (-sortie.ii);
          pin_ReactivePowerPN = (sortie.vi * (-sortie.ir) - sortie.vr * (-sortie.ii)) * SNREF / PN;
          if PNALT == 0 then
            pin_ReactivePowerPNALT = 0;
          else
            pin_ReactivePowerPNALT = (sortie.vi * (-sortie.ir) - sortie.vr * (-sortie.ii)) * SNREF / PNALT;
          end if;
          pin_ReactivePowerSNREF = sortie.vi * (-sortie.ir) - sortie.vr * (-sortie.ii);
          pin_ActivePowerSN = (sortie.vr * (-sortie.ir) + sortie.vi * (-sortie.ii)) * SNREF / SN;
          pin_ReactivePowerSN = (sortie.vi * (-sortie.ir) - sortie.vr * (-sortie.ii)) * SNREF / SN;
          if md == 0 and mq == 0 and snd == 0 and snq == 0 then
            pin_FieldCurrent = -Mdv / rtfo * ((Md0 + lD + mrc) * lambdaf - (Md0 + mrc) * lambdad - Md0 * lD * id) / ((Md0 + mrc) * (lf + lD) + lf * lD);
          else
            pin_FieldCurrent = -Mdv / rtfo * ((lD + mrc) * lambdaf - mrc * lambdad - lD * lambdaad) / (mrc * (lf + lD) + lf * lD);
          end if;
          pin_Current = sqrt(sortie.ir * sortie.ir + sortie.ii * sortie.ii);
          pin_FRZPU = omegaRef;
          pin_FRZHZ = omegaRef * omega0;
        end PwGeneratorM1S;
      end Eurostag;
    end Machines;

    package Controls  
      package Eurostag  
        model GOVER1  "Steam turbine governor. Developed by AIA. 2013" 
          parameter Real init_Integrator;
          parameter Real init_LeadLag;
          Modelica.Blocks.Sources.Constant imSetPoint(k = 0);
          Modelica.Blocks.Continuous.LimIntegrator imLimitedIntegrator(outMin = 0, k = 1, outMax = 1.1, y_start = init_Integrator);
          Modelica.Blocks.Sources.Constant imSetPoint1(k = 25);
          iPSL.NonElectrical.Continuous.LeadLag imLeadLag(K = 1, T2 = 10, T1 = 3, y_start = init_LeadLag, x_start = init_LeadLag);
          Modelica.Blocks.Interfaces.RealInput pin_OMEGA;
          Modelica.Blocks.Interfaces.RealOutput pin_CM;
          Modelica.Blocks.Math.Add3 add3_1(k1 = -25, k2 = 1, k3 = 1);
        equation
          connect(imSetPoint.y, imLimitedIntegrator.u);
          connect(imLimitedIntegrator.y, add3_1.u2);
          connect(add3_1.u1, pin_OMEGA);
          connect(add3_1.u3, imSetPoint1.y);
          connect(add3_1.y, imLeadLag.u);
          connect(imLeadLag.y, pin_CM);
        end GOVER1;
      end Eurostag;
    end Controls;

    package Events  
      model PwFault  "Transitory short-circuit on a node. Shunt impedance connected only during a specified interval of time.
                    Developed by AIA. 2014/12/16" 
        iPSL.Connectors.PwPin p;
        parameter Real R "Resistance (pu)";
        parameter Real X "Conductance (pu)";
        parameter Real t1 "Start time of the fault (s)";
        parameter Real t2 "End time of the fault (s)";
      protected
        parameter Real ground = if R == 0 and X == 0 then 0 else 1;
      equation
        if time < t1 then
          p.ii = 0;
          p.ir = 0;
        elseif time < t2 and ground == 0 then
          p.vr = 1E-10;
          p.vi = 0;
        elseif time < t2 then
          p.ii = (R * p.vi - X * p.vr) / (X * X + R * R);
          p.ir = (R * p.vr + X * p.vi) / (R * R + X * X);
        else
          p.ii = 0;
          p.ir = 0;
        end if;
      end PwFault;
    end Events;

    model SystemBase  "System Base Definition" 
      parameter Real S_b = 100 "System base in MVA";
      parameter Real fn = 50 "System Frequency in Hz";
      annotation(defaultAttributes = "inner", missingInnerMessage = "
    No 'System Data' component is defined. A default component will be used, and generate a system base of 100 MVA, and a frequency of 50 Hz"); 
    end SystemBase;
  end Electrical;

  package NonElectrical  
    package Continuous  
      block LeadLag  "Lead-Lag filter" 
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Real K "Gain";
        parameter Modelica.SIunits.Time T1 "Lead time constant";
        parameter Modelica.SIunits.Time T2 "Lag time constant";
        parameter Real y_start "Output start value";
        parameter Real x_start = y_start / K "Start value of state variable";
      protected
        parameter Modelica.SIunits.Time T2_dummy = if abs(T1 - T2) < Modelica.Constants.eps then 1000 else T2 "Lead time constant";
      public
        Modelica.Blocks.Sources.RealExpression par1(y = T1);
        Modelica.Blocks.Sources.RealExpression par2(y = T2);
        Modelica.Blocks.Continuous.TransferFunction TF(b = {K * T1, K}, a = {T2_dummy, 1}, y_start = y_start, initType = Modelica.Blocks.Types.Init.SteadyState, x_start = {x_start});
      equation
        if abs(par1.y - par2.y) < Modelica.Constants.eps then
          y = K * u;
        else
          y = TF.y;
        end if;
        connect(TF.u, u);
      end LeadLag;
    end Continuous;
  end NonElectrical;

  package Connectors  
    connector PwPin  "connector for electrical blocks treating voltage and current as complex variables" 
      Real vr;
      Real vi;
      flow Real ir;
      flow Real ii;
    end PwPin;
  end Connectors;
  annotation(version = "0.8.1"); 
end iPSL;

package sortEqns  
  model iPSL_A  
    .iPSL.Electrical.Machines.Eurostag.PwGeneratorM1S MS(V2 = 24, U2N = 24, init_theta = 0.21995, init_omega = 1.0, init_efd = 1.0251, init_lambdaad = -0.98054, init_cm = 0.10003, init_lambdaq1 = 0.19950, init_lambdaq2 = 0.19950, init_iq = 0.97585, init_id = 0.21796, init_lambdaaq = 0.19950, init_lambdad = -0.98054, init_lambdaf = -1.0863, WLMDVPu = 2.351, Saturated = false);
    .iPSL.Electrical.Controls.Eurostag.GOVER1 gover(init_Integrator = 0.10003, init_LeadLag = 0.10003);
    .iPSL.Electrical.Buses.InfiniteBus2 inf(V = 1, angle = 0, p(vr(start = 1)), p(vi(start = 0)));
    .iPSL.Electrical.Events.PwFault fault(R = 0.001, X = 0, t1 = 5, t2 = 5.5);
    .iPSL.Electrical.Branches.PwLine lineinf(R = 0.0001, X = 0, B = 0, G = 0);
    .iPSL.Electrical.Branches.PwLine line(R = 0.0001, X = 0, B = 0, G = 0);
    Modelica.Blocks.Interfaces.RealInput omegaRef(start = 1);
    Modelica.Blocks.Interfaces.RealInput efd(start = 1);
  equation
    connect(omegaRef, MS.omegaRef);
    connect(efd, MS.pin_EFD);
    connect(gover.pin_CM, MS.pin_CM);
    connect(gover.pin_OMEGA, MS.pin_OMEGA);
    connect(inf.p, lineinf.p);
    connect(lineinf.n, line.p);
    connect(line.n, MS.sortie);
    connect(fault.p, line.n);
    annotation(experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002)); 
  end iPSL_A;
end sortEqns;

package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Continuous  "Library of continuous control blocks with internal states" 
      extends Modelica.Icons.Package;

      block LimIntegrator  "Integrator with limited value of the output" 
        parameter Real k(unit = "1") = 1 "Integrator gain";
        parameter Real outMax(start = 1) "Upper limit of output";
        parameter Real outMin = -outMax "Lower limit of output";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.InitialState "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate = true);
        parameter Boolean limitsAtInit = true "= false, if limits are ignored during initialization (i.e., der(y)=k*u)" annotation(Evaluate = true);
        parameter Real y_start = 0 "Initial or guess value of output (must be in the limits outMin .. outMax)";
        parameter Boolean strict = false "= true, if strict limits with noEvent(..)" annotation(Evaluate = true);
        extends .Modelica.Blocks.Interfaces.SISO(y(start = y_start));
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(y) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState or initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
        end if;
      equation
        if initial() and not limitsAtInit then
          der(y) = k * u;
          assert(y >= outMin - 0.001 * abs(outMax - outMin) and y <= outMax + 0.001 * abs(outMax - outMin), "LimIntegrator: During initialization the limits have been ignored.\n" + "However, the result is that the output y is not within the required limits:\n" + "  y = " + String(y) + ", outMin = " + String(outMin) + ", outMax = " + String(outMax));
        elseif strict then
          der(y) = noEvent(if y < outMin and k * u < 0 or y > outMax and k * u > 0 then 0 else k * u);
        else
          der(y) = if y < outMin and k * u < 0 or y > outMax and k * u > 0 then 0 else k * u;
        end if;
      end LimIntegrator;

      block TransferFunction  "Linear transfer function" 
        extends .Modelica.Blocks.Interfaces.SISO;
        parameter Real[:] b = {1} "Numerator coefficients of transfer function (e.g., 2*s+3 is specified as {2,3})";
        parameter Real[:] a = {1} "Denominator coefficients of transfer function (e.g., 5*s+6 is specified as {5,6})";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true);
        parameter Real[size(a, 1) - 1] x_start = zeros(nx) "Initial or guess values of states";
        parameter Real y_start = 0 "Initial value of output (derivatives of y are zero up to nx-1-th derivative)";
        output Real[size(a, 1) - 1] x(start = x_start) "State of transfer function from controller canonical form";
      protected
        parameter Integer na = size(a, 1) "Size of Denominator of transfer function.";
        parameter Integer nb = size(b, 1) "Size of Numerator of transfer function.";
        parameter Integer nx = size(a, 1) - 1;
        parameter Real[:] bb = vector([zeros(max(0, na - nb), 1); b]);
        parameter Real d = bb[1] / a[1];
        parameter Real a_end = if a[end] > 100 * Modelica.Constants.eps * sqrt(a * a) then a[end] else 1.0;
        Real[size(x, 1)] x_scaled "Scaled vector x";
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(x_scaled) = zeros(nx);
        elseif initType == .Modelica.Blocks.Types.Init.InitialState then
          x_scaled = x_start * a_end;
        elseif initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
          der(x_scaled[2:nx]) = zeros(nx - 1);
        end if;
      equation
        assert(size(b, 1) <= size(a, 1), "Transfer function is not proper");
        if nx == 0 then
          y = d * u;
        else
          der(x_scaled[1]) = ((-a[2:na] * x_scaled) + a_end * u) / a[1];
          der(x_scaled[2:nx]) = x_scaled[1:nx - 1];
          y = (bb[2:na] - d * a[2:na]) * x_scaled / a_end + d * u;
          x = x_scaled / a_end;
        end if;
      end TransferFunction;
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal";
        RealOutput y "Connector of Real output signal";
      end SISO;
    end Interfaces;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      extends Modelica.Icons.Package;

      block Add3  "Output the sum of the three inputs" 
        extends Modelica.Blocks.Icons.Block;
        parameter Real k1 = +1 "Gain of upper input";
        parameter Real k2 = +1 "Gain of middle input";
        parameter Real k3 = +1 "Gain of lower input";
        .Modelica.Blocks.Interfaces.RealInput u1 "Connector 1 of Real input signals";
        .Modelica.Blocks.Interfaces.RealInput u2 "Connector 2 of Real input signals";
        .Modelica.Blocks.Interfaces.RealInput u3 "Connector 3 of Real input signals";
        .Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals";
      equation
        y = k1 * u1 + k2 * u2 + k3 * u3;
      end Add3;
    end Math;

    package Sources  "Library of signal source blocks generating Real and Boolean signals" 
      extends Modelica.Icons.SourcesPackage;

      block RealExpression  "Set output signal to a time varying Real expression" 
        Modelica.Blocks.Interfaces.RealOutput y = 0.0 "Value of Real output";
      end RealExpression;

      block Constant  "Generate constant signal of type Real" 
        parameter Real k(start = 1) "Constant output value";
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = k;
      end Constant;
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

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package ComplexMath  "Library of complex mathematical functions (e.g., sin, cos) and of functions operating on complex vectors and matrices" 
    extends Modelica.Icons.Package;
    final constant Complex j = Complex(0, 1) "Imaginary unit";

    function conj  "Conjugate of complex number" 
      extends Modelica.Icons.Function;
      input Complex c1 "Complex number";
      output Complex c2 "= c1.re - j*c1.im";
    algorithm
      c2 := Complex(c1.re, -c1.im);
      annotation(Inline = true); 
    end conj;

    function real  "Real part of complex number" 
      extends Modelica.Icons.Function;
      input Complex c "Complex number";
      output Real r "= c.re";
    algorithm
      r := c.re;
      annotation(Inline = true); 
    end real;

    function imag  "Imaginary part of complex number" 
      extends Modelica.Icons.Function;
      input Complex c "Complex number";
      output Real r "= c.im";
    algorithm
      r := c.im;
      annotation(Inline = true); 
    end imag;
  end ComplexMath;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real inf = ModelicaServices.Machine.inf "Biggest Real number such that inf and -inf are representable on the machine";
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7 "Magnetic constant";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units" 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Time = Real(final quantity = "Time", final unit = "s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
  annotation(version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z"); 
end Modelica;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(Protection(access = Access.hide), version = "3.2.1", versionBuild = 2, versionDate = "2013-08-14", dateModified = "2013-08-14 08:44:41Z"); 
end ModelicaServices;

operator record Complex  "Complex number with overloaded operators" 
  replaceable Real re "Real part of complex number";
  replaceable Real im "Imaginary part of complex number";

  encapsulated operator 'constructor'  "Constructor" 
    function fromReal  "Construct Complex from Real" 
      input Real re "Real part of complex number";
      input Real im = 0 "Imaginary part of complex number";
      output .Complex result(re = re, im = im) "Complex number";
    algorithm
      annotation(Inline = true); 
    end fromReal;
  end 'constructor';

  encapsulated operator function '0'  "Zero-element of addition (= Complex(0))" 
    output .Complex result "Complex(0)";
  algorithm
    result := .Complex(0);
    annotation(Inline = true); 
  end '0';

  encapsulated operator '-'  "Unary and binary minus" 
    function negate  "Unary minus (multiply complex number by -1)" 
      input .Complex c1 "Complex number";
      output .Complex c2 "= -c1";
    algorithm
      c2 := .Complex(-c1.re, -c1.im);
      annotation(Inline = true); 
    end negate;

    function subtract  "Subtract two complex numbers" 
      input .Complex c1 "Complex number 1";
      input .Complex c2 "Complex number 2";
      output .Complex c3 "= c1 - c2";
    algorithm
      c3 := .Complex(c1.re - c2.re, c1.im - c2.im);
      annotation(Inline = true); 
    end subtract;
  end '-';

  encapsulated operator '*'  "Multiplication" 
    function multiply  "Multiply two complex numbers" 
      input .Complex c1 "Complex number 1";
      input .Complex c2 "Complex number 2";
      output .Complex c3 "= c1*c2";
    algorithm
      c3 := .Complex(c1.re * c2.re - c1.im * c2.im, c1.re * c2.im + c1.im * c2.re);
      annotation(Inline = true); 
    end multiply;

    function scalarProduct  "Scalar product c1*c2 of two complex vectors" 
      input .Complex[:] c1 "Vector of Complex numbers 1";
      input .Complex[size(c1, 1)] c2 "Vector of Complex numbers 2";
      output .Complex c3 "= c1*c2";
    algorithm
      c3 := .Complex(0);
      for i in 1:size(c1, 1) loop
        c3 := c3 + c1[i] * c2[i];
      end for;
      annotation(Inline = true); 
    end scalarProduct;
  end '*';

  encapsulated operator function '+'  "Add two complex numbers" 
    input .Complex c1 "Complex number 1";
    input .Complex c2 "Complex number 2";
    output .Complex c3 "= c1 + c2";
  algorithm
    c3 := .Complex(c1.re + c2.re, c1.im + c2.im);
    annotation(Inline = true); 
  end '+';

  encapsulated operator function '/'  "Divide two complex numbers" 
    input .Complex c1 "Complex number 1";
    input .Complex c2 "Complex number 2";
    output .Complex c3 "= c1/c2";
  algorithm
    c3 := .Complex(((+c1.re * c2.re) + c1.im * c2.im) / (c2.re * c2.re + c2.im * c2.im), ((-c1.re * c2.im) + c1.im * c2.re) / (c2.re * c2.re + c2.im * c2.im));
    annotation(Inline = true); 
  end '/';

  encapsulated operator function '^'  "Complex power of complex number" 
    input .Complex c1 "Complex number";
    input .Complex c2 "Complex exponent";
    output .Complex c3 "= c1^c2";
  protected
    Real lnz = 0.5 * log(c1.re * c1.re + c1.im * c1.im);
    Real phi = atan2(c1.im, c1.re);
    Real re = lnz * c2.re - phi * c2.im;
    Real im = lnz * c2.im + phi * c2.re;
  algorithm
    c3 := .Complex(exp(re) * cos(im), exp(re) * sin(im));
    annotation(Inline = true); 
  end '^';

  encapsulated operator function '=='  "Test whether two complex numbers are identical" 
    input .Complex c1 "Complex number 1";
    input .Complex c2 "Complex number 2";
    output Boolean result "c1 == c2";
  algorithm
    result := c1.re == c2.re and c1.im == c2.im;
    annotation(Inline = true); 
  end '==';

  encapsulated operator function 'String'  "Transform Complex number into a String representation" 
    input .Complex c "Complex number to be transformed in a String representation";
    input String name = "j" "Name of variable representing sqrt(-1) in the string";
    input Integer significantDigits = 6 "Number of significant digits that are shown";
    output String s = "";
  algorithm
    s := String(c.re, significantDigits = significantDigits);
    if c.im <> 0 then
      if c.im > 0 then
        s := s + " + ";
      else
        s := s + " - ";
      end if;
      s := s + String(abs(c.im), significantDigits = significantDigits) + "*" + name;
    else
    end if;
    annotation(Inline = true); 
  end 'String';
  annotation(Protection(access = Access.hide), version = "3.2.1", versionBuild = 2, versionDate = "2013-08-14", dateModified = "2013-08-14 08:44:41Z"); 
end Complex;

model iPSL_A_total
  extends sortEqns.iPSL_A;
 annotation(experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.0002));
end iPSL_A_total;
