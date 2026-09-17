package OpenFDM 
  package World 
    model WorldBase 
      function g_r 
        input .Modelica.SIunits.Position[3] r_r;
        output .Modelica.SIunits.Acceleration[3] g_r;
         annotation(Inline = true);
      algorithm
        g_r := {0, 0, 9.8};
      end g_r;

      function agl 
        input .Modelica.SIunits.Position[3] r_r;
        output .Modelica.SIunits.Position agl;
         annotation(Inline = true);
      algorithm
        agl := -r_r[3];
      end agl;

      function rho 
        input .Modelica.SIunits.Position[3] r_r;
        output .Modelica.SIunits.Density rho;
         annotation(Inline = true);
      algorithm
        rho := 1.225;
      end rho;

      function wind_r 
        input .Modelica.SIunits.Position[3] r_r;
        output .Modelica.SIunits.Velocity[3] wind_r;
         annotation(Inline = true);
      algorithm
        wind_r := {0, 0, 0};
      end wind_r;
    end WorldBase;

    model Earth 
      extends WorldBase;
    end Earth;
  end World;

  package Propulsion 
    model Thruster 
      extends Parts.ForceMoment;
      parameter Real maxThrust = 10;
      Modelica.Blocks.Nonlinear.Limiter sat(uMax = 1, uMin = 0);
      input Real throttle;
    equation
      sat.u = throttle;
      F_b = sat.y * {maxThrust, 0, 0};
      M_b = {0, 0, 0};
    end Thruster;
  end Propulsion;

  package Parts 
    function T1 
      input .Modelica.SIunits.Angle a;
      output Real[3, 3] T;
       annotation(Inline = true);
    algorithm
      T := {{1, 0, 0}, {0, cos(a), sin(a)}, {0, -sin(a), cos(a)}};
    end T1;

    function T2 
      input .Modelica.SIunits.Angle a;
      output Real[3, 3] T;
       annotation(Inline = true);
    algorithm
      T := {{cos(a), 0, -sin(a)}, {0, 1, 0}, {sin(a), 0, cos(a)}};
    end T2;

    function T3 
      input .Modelica.SIunits.Angle a;
      output Real[3, 3] T;
       annotation(Inline = true);
    algorithm
      T := {{cos(a), sin(a), 0}, {-sin(a), cos(a), 0}, {0, 0, 1}};
    end T3;

    model ForceMoment 
      .Modelica.SIunits.Force[3] F_b;
      .Modelica.SIunits.Torque[3] M_b;
      Interfaces.RigidConnector fA;
    equation
      fA.F_b + F_b = zeros(3);
      fA.M_b + M_b = zeros(3);
    end ForceMoment;

    partial model Translational 
      outer World.WorldBase world;
      Interfaces.RigidConnector fA;
      .Modelica.SIunits.Mass m "mass";
    protected
      .Modelica.SIunits.Momentum[3] L_b "linear momentum";
    equation
      L_b = m * (fA.v_b + cross(fA.w_ib, fA.C_br * fA.r_r));
      fA.F_b + fA.C_br * world.g_r(fA.r_r) = der(L_b) + cross(fA.w_ib, L_b);
    end Translational;

    model RigidBody 
      extends Translational;
      .Modelica.SIunits.MomentOfInertia[3, 3] I_b "inertial about the cm in the body frame";
    protected
      .Modelica.SIunits.AngularMomentum[3] H_b "angular momentum";
    equation
      H_b = I_b * fA.w_ib;
      fA.M_b = der(H_b) + cross(fA.w_ib, H_b);
    end RigidBody;

    partial model RigidLink 
      input .Modelica.SIunits.Position[3] r_a "position vector from fA to fB, resolved in fA";
      input .Modelica.SIunits.Angle[3] angles "rotation angles from fA into fB";
      Interfaces.RigidConnector fA;
      Interfaces.RigidConnector fB;
      Real[3, 3] C_ba "rotation matrix from fA into fB";
    equation
      fA.r_r + transpose(fA.C_br) * r_a = fB.r_r;
      C_ba * fA.v_b = fB.v_b;
      C_ba * fA.a_b = fB.a_b;
      zeros(3) = C_ba * fA.F_b + fB.F_b;
      C_ba * fA.C_br = fB.C_br;
      C_ba * fA.w_ib = fB.w_ib;
      C_ba * fA.z_b = fB.z_b;
      zeros(3) = C_ba * fA.M_b + cross(C_ba * r_a, fB.F_b) + fB.M_b;
    end RigidLink;

    model RigidLink_B321 
      extends RigidLink;
    equation
      C_ba = T1(angles[1]) * T2(angles[2]) * T3(angles[3]);
    end RigidLink_B321;

    model RigidReferencePoint 
      outer World.WorldBase world "the world";
      parameter Boolean wrapEuler = true;
      Interfaces.RigidConnector fA "the rigid body connector";
      .Modelica.SIunits.AngularVelocity[3] w_ir = {0, 0, 0} "ref frame ang rate wrt inertial expressed in the reference frame";
      .Modelica.SIunits.Position[3] r_r(each stateSelect = StateSelect.always) "cartesian position resolved in the refernce frame";
      .Modelica.SIunits.Velocity[3] v_r(each stateSelect = StateSelect.always) "velocity resolved in the reference frame";
      .Modelica.SIunits.Angle[3] euler(each stateSelect = StateSelect.always) "euler angles, body roll, horizon pitch, heading";
      .Modelica.SIunits.AngularVelocity[3] w_ib(each stateSelect = StateSelect.always) "angular velocity of body wrt inertial frame resolved in the body frame";
      .Modelica.SIunits.Velocity[3] v_b(each stateSelect = StateSelect.never) "velocity resolved in the body frame";
      .Modelica.SIunits.Acceleration[3] a_b(each stateSelect = StateSelect.never) "acceleration resolved in the body frame";
      .Modelica.SIunits.AngularAcceleration[3] z_b(each stateSelect = StateSelect.never) "angular acceleration resolved in the body frame";
      Real[3, 3] C_br(each stateSelect = StateSelect.never) "direction cosine matrix  from reference to body frame";
      .Modelica.SIunits.Position agl(stateSelect = StateSelect.never) "altitude above ground level";
      .Modelica.SIunits.Angle gamma "flight path angle";
      .Modelica.SIunits.Velocity vt "true velocity";
      .Modelica.SIunits.Velocity[3] vR_r "relative air velocity in reference frame";
      .Modelica.SIunits.Angle phi = euler[1] "euler angle 1: body roll";
      .Modelica.SIunits.Angle theta = euler[2] "euler angle 2: horizon pitch";
      .Modelica.SIunits.Angle psi = euler[3] "euler angle 3: heading";
      Real phi_deg = .Modelica.SIunits.Conversions.to_deg(phi);
      Real theta_deg = .Modelica.SIunits.Conversions.to_deg(theta);
      Real psi_deg = .Modelica.SIunits.Conversions.to_deg(psi);
      constant Real epsilon = 0.00000000000001;
    equation
      fA.r_r = r_r;
      fA.v_b = v_b;
      fA.a_b = a_b;
      fA.F_b = zeros(3);
      fA.C_br = C_br;
      fA.w_ib = w_ib;
      fA.z_b = z_b;
      fA.M_b = zeros(3);
      v_r = der(r_r);
      v_b = C_br * v_r;
      a_b = der(v_b);
      w_ib = w_ir + {{1, tan(theta) * sin(phi), tan(theta) * cos(phi)}, {0, cos(phi), -sin(phi)}, {0, sin(phi) / (cos(theta) + epsilon), cos(phi) / (cos(theta) + epsilon)}} * der(euler);
      C_br = T1(phi) * T2(theta) * T3(psi);
      z_b = der(w_ib);
      if wrapEuler then
        for i in 1:size(euler, 1) loop
          when euler[i] > .Modelica.Constants.pi then
            reinit(euler[i], pre(euler[i]) - 2 * .Modelica.Constants.pi);
          end when;
          when euler[i] < -.Modelica.Constants.pi then
            reinit(euler[i], pre(euler[i]) + 2 * .Modelica.Constants.pi);
          end when;
        end for;
      end if;
      vR_r = v_r - world.wind_r(r_r);
      vt = sqrt(vR_r * vR_r);
      gamma = asin(v_r[3] / sqrt(v_r * v_r + epsilon));
      agl = world.agl(r_r);
      assert(agl > 0, "hit ground");
    end RigidReferencePoint;
  end Parts;

  package Interfaces 
    expandable connector RigidConnector 
      .Modelica.SIunits.Position[3] r_r;
      .Modelica.SIunits.Velocity[3] v_b;
      .Modelica.SIunits.Acceleration[3] a_b;
      flow .Modelica.SIunits.Force[3] F_b;
      Real[3, 3] C_br;
      .Modelica.SIunits.AngularVelocity[3] w_ib;
      .Modelica.SIunits.AngularAcceleration[3] z_b;
      flow .Modelica.SIunits.Torque[3] M_b;
    end RigidConnector;
  end Interfaces;

  package Control 
    model AutoPilotConst 
      Real throttle(start = 0.3, fixed = false);
      Real elevator_deg(start = 0, fixed = false);
      Real rudder_deg(start = 0, fixed = false);
      Real aileron_deg(start = 0, fixed = false);
      Real flap_deg(start = 0, fixed = true);
    equation
      der(throttle) = 0;
      der(elevator_deg) = 0;
      der(rudder_deg) = 0;
      der(aileron_deg) = 0;
      der(flap_deg) = 0;
    end AutoPilotConst;
  end Control;

  package Aircraft 
    package Aerosonde 
      package Datcom 
        constant OpenFDM.Aerodynamics.Datcom.Tables tables(CL_Basic = {{-16, -1.533}, {-8, -0.602}, {-6, -0.369}, {-4, -0.142}, {-2, 0.083}, {0, 0.315}, {2, 0.552}, {4, 0.795}, {8, 1.288}, {9, 1.401}, {10, 1.503}, {12, 1.685}, {14, 1.832}, {16, 1.933}, {18, 1.892}, {19, 1.589}, {20, 1.226}, {21, 0.891}, {22, 0.646}, {24, 0.18}}, dCL_Flap = {{0, 0}, {5, 0.086}, {10, 0.172}, {15, 0.254}, {20, 0.332}, {25, 0.407}, {30, 0.468}, {35, 0.515}, {40, 0.547}}, dCL_Elevator = {{-28, -0.142}, {-20, -0.125}, {-10, -0.09}, {-5, -0.045}, {0, 0}, {5, 0.045}, {10, 0.09}, {20, 0.125}, {28, 0.142}}, dCL_PitchRate = {{-16, 0.1727}}, dCL_AlphaDot = {{-16, 0.02933}, {-8, 0.03257}, {-6, 0.03381}, {-4, 0.03499}, {-2, 0.03694}, {0, 0.03907}, {2, 0.04098}, {4, 0.04275}, {8, 0.04536}, {9, 0.03893}, {10, 0.02967}, {12, 0.02287}, {14, 0.01428}, {16, -0.009362}, {18, -0.04021}, {19, -0.0978}, {20, -0.1347}, {21, -0.1004}, {22, -0.08004}, {24, -0.07793}}, CD_Basic = {{-16, 0.813}, {-8, 0.235}, {-6, 0.151}, {-4, 0.092}, {-2, 0.058}, {0, 0.05}, {2, 0.067}, {4, 0.111}, {8, 0.276}, {9, 0.332}, {10, 0.393}, {12, 0.529}, {14, 0.683}, {16, 0.852}, {18, 1.021}, {19, 1.082}, {20, 1.152}, {21, 1.236}, {22, 1.334}, {24, 1.562}}, dCD_Flap = {{-999, 0, 5, 10, 15, 20, 25, 30, 35, 40}, {-16, -0.0000118, -0.00543, -0.00986, -0.0131, -0.0155, -0.0169, -0.0176, -0.0177, -0.0177}, {-8, -0.00000417, -0.00159, -0.00219, -0.00185, -0.000688, 0.00117, 0.00326, 0.00517, 0.00668}, {-6, -0.00000225, -0.00063, -0.000272, 0.000975, 0.00301, 0.0057, 0.00847, 0.0109, 0.0128}, {-4, -0.000000329, 0.000329, 0.00165, 0.0038, 0.0067, 0.0102, 0.0137, 0.0166, 0.0189}, {-2, 0.00000159, 0.00129, 0.00356, 0.00662, 0.0104, 0.0147, 0.0189, 0.0223, 0.0249}, {0, 0.00000351, 0.00225, 0.00548, 0.00945, 0.0141, 0.0193, 0.0241, 0.0281, 0.031}, {2, 0.00000543, 0.00321, 0.0074, 0.0123, 0.0178, 0.0238, 0.0293, 0.0338, 0.0371}, {4, 0.00000735, 0.00417, 0.00932, 0.0151, 0.0215, 0.0283, 0.0345, 0.0395, 0.0432}, {8, 0.0000112, 0.00609, 0.0131, 0.0207, 0.0289, 0.0374, 0.0449, 0.051, 0.0554}, {9, 0.0000122, 0.00657, 0.0141, 0.0222, 0.0307, 0.0396, 0.0475, 0.0538, 0.0584}, {10, 0.0000131, 0.00705, 0.0151, 0.0236, 0.0326, 0.0419, 0.0501, 0.0567, 0.0614}, {12, 0.000015, 0.008, 0.017, 0.0264, 0.0363, 0.0464, 0.0553, 0.0624, 0.0675}, {14, 0.0000169, 0.00896, 0.0189, 0.0292, 0.04, 0.0509, 0.0605, 0.0681, 0.0736}, {16, 0.0000189, 0.00992, 0.0208, 0.032, 0.0437, 0.0555, 0.0657, 0.0738, 0.0797}, {18, 0.0000208, 0.0109, 0.0227, 0.0349, 0.0474, 0.06, 0.0709, 0.0796, 0.0858}, {19, 0.0000218, 0.0114, 0.0237, 0.0363, 0.0492, 0.0623, 0.0735, 0.0824, 0.0888}, {20, 0.0000227, 0.0118, 0.0247, 0.0377, 0.0511, 0.0645, 0.0762, 0.0853, 0.0919}, {21, 0.0000237, 0.0123, 0.0256, 0.0391, 0.0529, 0.0668, 0.0788, 0.0882, 0.0949}, {22, 0.0000247, 0.0128, 0.0266, 0.0405, 0.0547, 0.069, 0.0814, 0.091, 0.098}, {24, 0.0000266, 0.0138, 0.0285, 0.0433, 0.0584, 0.0736, 0.0866, 0.0967, 0.104}}, dCD_Elevator = {{-999, -28, -20, -10, -5, 0, 5, 10, 20, 28}, {-16, 0.0134, 0.0113, 0.00725, 0.00307, -0.00000504, -0.00197, -0.00283, -0.00273, -0.00246}, {-8, 0.00817, 0.00666, 0.00393, 0.00141, -0.00000172, -0.000306, 0.000496, 0.00189, 0.00277}, {-6, 0.00692, 0.00556, 0.00314, 0.00101, -0.00000092, 0.0000922, 0.00129, 0.00299, 0.00402}, {-4, 0.00568, 0.00446, 0.00235, 0.00062, -0.000000132, 0.000486, 0.00208, 0.00409, 0.00526}, {-2, 0.00446, 0.00339, 0.00157, 0.000233, 0.000000643, 0.000874, 0.00285, 0.00517, 0.00647}, {0, 0.00328, 0.00234, 0.000819, -0.000144, 0.0000014, 0.00125, 0.00361, 0.00621, 0.00766}, {2, 0.00212, 0.00131, 0.0000813, -0.000513, 0.00000213, 0.00162, 0.00435, 0.00724, 0.00882}, {4, 0.000985, 0.000312, -0.000639, -0.000873, 0.00000285, 0.00198, 0.00507, 0.00824, 0.00995}, {8, -0.00122, -0.00164, -0.00204, -0.00157, 0.00000425, 0.00268, 0.00647, 0.0102, 0.0122}, {9, -0.00176, -0.00211, -0.00238, -0.00175, 0.0000046, 0.00285, 0.00681, 0.0107, 0.0127}, {10, -0.00239, -0.00267, -0.00279, -0.00195, 0.000005, 0.00305, 0.00721, 0.0112, 0.0133}, {12, -0.00376, -0.00389, -0.00366, -0.00238, 0.00000587, 0.00349, 0.00809, 0.0124, 0.0147}, {14, -0.00518, -0.00514, -0.00456, -0.00283, 0.00000678, 0.00394, 0.00899, 0.0137, 0.0161}, {16, -0.00679, -0.00656, -0.00558, -0.00335, 0.0000078, 0.00445, 0.01, 0.0151, 0.0177}, {18, -0.00885, -0.00839, -0.0069, -0.004, 0.00000912, 0.00511, 0.0113, 0.0169, 0.0198}, {19, -0.01, -0.00945, -0.00766, -0.00438, 0.00000988, 0.00549, 0.0121, 0.018, 0.021}, {20, -0.0119, -0.0111, -0.00886, -0.00498, 0.0000111, 0.00609, 0.0133, 0.0197, 0.0229}, {21, -0.0136, -0.0126, -0.00992, -0.00552, 0.0000121, 0.00662, 0.0144, 0.0211, 0.0245}, {22, -0.015, -0.0138, -0.0108, -0.00596, 0.000013, 0.00707, 0.0152, 0.0224, 0.026}, {24, -0.0178, -0.0163, -0.0126, -0.00685, 0.0000148, 0.00796, 0.017, 0.0249, 0.0287}}, dCY_Beta = {{-16, -0.008703}}, dCY_RollRate = {{-16, -0.00002141}, {-8, -0.001097}, {-6, -0.001353}, {-4, -0.001599}, {-2, -0.001841}, {0, -0.002093}, {2, -0.002353}, {4, -0.002622}, {8, -0.003208}, {9, -0.003365}, {10, -0.003514}, {12, -0.003777}, {14, -0.00402}, {16, -0.004538}, {18, -0.002749}, {19, -0.002559}, {20, -0.002014}, {21, -0.001387}, {22, -0.0008488}, {24, 0.0003659}}, dCl_Aileron = {{-56, -0.057601}, {-40, -0.05196}, {-20, -0.030247}, {-10, -0.015124}, {0, 0}, {10, 0.015124}, {20, 0.030247}, {40, 0.05196}, {56, 0.057601}}, dCl_Beta = {{-16, -0.002301}, {-8, -0.001955}, {-6, -0.001871}, {-4, -0.001787}, {-2, -0.001703}, {0, -0.001616}, {2, -0.001527}, {4, -0.001437}, {8, -0.001255}, {9, -0.001213}, {10, -0.001173}, {12, -0.001097}, {14, -0.00103}, {16, -0.000971}, {18, -0.0009398}, {19, -0.0009883}, {20, -0.001047}, {21, -0.001095}, {22, -0.001121}, {24, -0.001181}}, dCl_RollRate = {{-16, -0.006514}, {-8, -0.00617}, {-6, -0.006025}, {-4, -0.005877}, {-2, -0.005953}, {0, -0.006171}, {2, -0.00636}, {4, -0.006499}, {8, -0.00609}, {9, -0.005561}, {10, -0.004919}, {12, -0.003873}, {14, -0.002589}, {16, 0.0004904}, {18, 0.01534}, {19, 0.02274}, {20, 0.02216}, {21, 0.01776}, {22, 0.01508}, {24, 0.01509}}, dCl_YawRate = {{-16, -0.002374}, {-8, -0.0005274}, {-6, -0.00008532}, {-4, 0.000339}, {-2, 0.0007572}, {0, 0.001195}, {2, 0.001648}, {4, 0.002113}, {8, 0.003062}, {9, 0.00327}, {10, 0.003445}, {12, 0.003736}, {14, 0.003933}, {16, 0.004013}, {18, 0.003717}, {19, 0.002808}, {20, 0.001802}, {21, 0.0009363}, {22, 0.0002949}, {24, -0.001001}}, Cm_Basic = {{-16, 0.2}, {16, -0.2}}, dCm_Flap = {{0, 0.0001}, {5, 0.0267}, {10, 0.0534}, {15, 0.0786}, {20, 0.1029}, {25, 0.126}, {30, 0.1449}, {35, 0.1593}, {40, 0.1694}}, dCm_Elevator = {{-28, 0.7933}, {-20, 0.7003}, {-10, 0.5024}, {-5, 0.2512}, {0, -0.0005}, {5, -0.2512}, {10, -0.5024}, {20, -0.7003}, {28, -0.7933}}, dCm_PitchRate = {{-16, -0.7118}}, dCm_AlphaDot = {{-16, -0.1644}, {-8, -0.1826}, {-6, -0.1896}, {-4, -0.1962}, {-2, -0.2071}, {0, -0.2191}, {2, -0.2298}, {4, -0.2397}, {8, -0.2544}, {9, -0.2183}, {10, -0.1663}, {12, -0.1282}, {14, -0.08008}, {16, 0.05249}, {18, 0.2255}, {19, 0.5484}, {20, 0.7554}, {21, 0.5632}, {22, 0.4488}, {24, 0.4369}}, dCn_Aileron = {{-999, -56, -40, -20, -10, 0, 10, 20, 40, 56}, {-16, -0.005268, -0.004751, -0.002765, -0.001382, 0, 0.001382, 0.002765, 0.004751, 0.005268}, {-8, -0.001798, -0.001622, -0.0009436, -0.0004718, 0, 0.0004718, 0.0009436, 0.001622, 0.001798}, {-6, -0.0009541, -0.0008604, -0.0005007, -0.0002503, 0, 0.0002503, 0.0005007, 0.0008604, 0.0009541}, {-4, -0.0001375, -0.000124, -0.00007213, -0.00003607, 0, 0.00003607, 0.00007213, 0.000124, 0.0001375}, {-2, 0.0006716, 0.0006057, 0.0003525, 0.0001762, 0, -0.0001762, -0.0003525, -0.0006057, -0.0006716}, {0, 0.001517, 0.001368, 0.000796, 0.000398, 0, -0.000398, -0.000796, -0.001368, -0.001517}, {2, 0.002392, 0.002157, 0.001255, 0.0006277, 0, -0.0006277, -0.001255, -0.002157, -0.002392}, {4, 0.003291, 0.002967, 0.001727, 0.0008634, 0, -0.0008634, -0.001727, -0.002967, -0.003291}, {8, 0.005124, 0.00462, 0.002689, 0.001344, 0, -0.001344, -0.002689, -0.00462, -0.005124}, {9, 0.005532, 0.004989, 0.002903, 0.001452, 0, -0.001452, -0.002903, -0.004989, -0.005532}, {10, 0.005882, 0.005305, 0.003087, 0.001543, 0, -0.001543, -0.003087, -0.005305, -0.005882}, {12, 0.00648, 0.005844, 0.003401, 0.0017, 0, -0.0017, -0.003401, -0.005844, -0.00648}, {14, 0.006915, 0.006236, 0.003629, 0.001814, 0, -0.001814, -0.003629, -0.006236, -0.006915}, {16, 0.007144, 0.006442, 0.003749, 0.001874, 0, -0.001874, -0.003749, -0.006442, -0.007144}, {18, 0.006717, 0.006057, 0.003525, 0.001763, 0, -0.001763, -0.003525, -0.006057, -0.006717}, {19, 0.005176, 0.004668, 0.002716, 0.001358, 0, -0.001358, -0.002716, -0.004668, -0.005176}, {20, 0.003466, 0.003126, 0.001819, 0.0009095, 0, -0.0009095, -0.001819, -0.003126, -0.003466}, {21, 0.001999, 0.001803, 0.001049, 0.0005246, 0, -0.0005246, -0.001049, -0.001803, -0.001999}, {22, 0.0009235, 0.0008328, 0.0004846, 0.0002423, 0, -0.0002423, -0.0004846, -0.0008328, -0.0009235}, {24, -0.001253, -0.001129, -0.0006573, -0.0003286, 0, 0.0003286, 0.0006573, 0.001129, 0.001253}}, dCn_Beta = {{-16, 0.0008503}}, dCn_RollRate = {{-16, 0.001618}, {-8, 0.0006283}, {-6, 0.0003792}, {-4, 0.000132}, {-2, -0.0001151}, {0, -0.0003664}, {2, -0.0006206}, {4, -0.0008793}, {8, -0.001473}, {9, -0.001661}, {10, -0.001856}, {12, -0.002213}, {14, -0.002573}, {16, -0.003125}, {18, -0.004242}, {19, -0.004199}, {20, -0.003005}, {21, -0.001853}, {22, -0.001099}, {24, -0.0001072}}, dCn_YawRate = {{-16, -0.001442}, {-8, -0.001415}, {-6, -0.001429}, {-4, -0.00145}, {-2, -0.001478}, {0, -0.001513}, {2, -0.001555}, {4, -0.001607}, {8, -0.001737}, {9, -0.001771}, {10, -0.001801}, {12, -0.001855}, {14, -0.001893}, {16, -0.001909}, {18, -0.001856}, {19, -0.001717}, {20, -0.001602}, {21, -0.001536}, {22, -0.001504}, {24, -0.001488}});
      end Datcom;

      model Aircraft 
        inner .OpenFDM.World.Earth world;
        .OpenFDM.Parts.RigidReferencePoint p(v_r(start = {40, 0, 0}, fixed = {true, true, true}), r_r(start = {0, 0, -1000}, fixed = {true, true, true}), euler(start = {0, 0, 0}, fixed = {false, false, false}), w_ib(start = {0, 0, 0}, fixed = {true, true, true}), z_b(start = {0, 0, 0}, fixed = {true, true, true}), a_b(start = {0, 0, 0}, fixed = {true, true, true}));
        OpenFDM.Control.AutoPilotConst pilot;
        .OpenFDM.Aerodynamics.Datcom.ForceMoment aero(tables = .OpenFDM.Aircraft.Aerosonde.Datcom.tables, rudder_deg = pilot.rudder_deg, flap_deg = pilot.flap_deg, elevator_deg = pilot.elevator_deg, aileron_deg = pilot.aileron_deg, s = 1.04322, b = 3.377, cBar = 0.4602);
        OpenFDM.Propulsion.Thruster thruster(maxThrust = 100, throttle = pilot.throttle);
        .OpenFDM.Parts.RigidBody structure(m = 22.18, I_b = {{101.686, 0, 0}, {0, 43.071, 0}, {0, 0, 85.463}});
        .OpenFDM.Parts.RigidLink_B321 t_aero_rp(r_a = {0, 0, 0}, angles = {0, 0, 0});
        .OpenFDM.Parts.RigidLink_B321 t_motor(r_a = {-0.5639, 0, 0}, angles = {0, 0, 0});
      equation
        assert(p.w_ib[1] < 1, "rolling too fast");
        assert(p.w_ib[2] < 1, "pitching too fast");
        assert(p.w_ib[3] < 1, "yawing too fast");
        assert(p.z_b[1] < 100, "Zx too large");
        assert(p.z_b[2] < 100, "Zy too large");
        assert(p.z_b[3] < 100, "Zz too large");
        assert(p.v_b[1] < 100, "Vx too fast");
        assert(p.v_b[2] < 100, "Vy too fast");
        assert(p.v_b[3] < 100, "Vz too fast");
        assert(p.a_b[1] < 100, "Ax too large");
        assert(p.a_b[2] < 100, "Ay too large");
        assert(p.a_b[3] < 100, "Az too large");
        connect(p.fA, structure.fA);
        connect(p.fA, t_motor.fA);
        connect(t_motor.fB, thruster.fA);
        connect(p.fA, t_aero_rp.fA);
        connect(t_aero_rp.fB, aero.fA);
      end Aircraft;
    end Aerosonde;
  end Aircraft;

  package Aerodynamics 
    package Datcom 
      record Controls 
        Real flap_deg "flap";
        Real aileron_deg "aileron";
        Real elevator_deg "elevator";
        Real rudder_deg "rudder";
      end Controls;

      record Tables 
        Real[:, :] CL_Basic "basic lift coefficient";
        Real[:, :] dCL_Flap "change in lift coefficient due to flaps";
        Real[:, :] dCL_Elevator "change in lift coefficient due to elevator";
        Real[:, :] dCL_PitchRate "change in lift coefficient due to pitch rate";
        Real[:, :] dCL_AlphaDot "change in lift coefficient due to aoa rate";
        Real[:, :] CD_Basic "basic drag coefficient";
        Real[:, :] dCD_Flap "change in drag coefficient due to flaps";
        Real[:, :] dCD_Elevator "change in drag coefficient due to elevator";
        Real[:, :] dCY_Beta "change in side force coefficient due to side slip angle";
        Real[:, :] dCY_RollRate "change in side force coefficient due to roll rate";
        Real[:, :] dCl_Aileron "change in roll moment coefficient due to aileron";
        Real[:, :] dCl_Beta "change in roll moment coefficient due to side slip angle";
        Real[:, :] dCl_RollRate "change in roll moment coefficient due to roll rate";
        Real[:, :] dCl_YawRate "change in roll moment coefficient due to yaw rate";
        Real[:, :] Cm_Basic;
        Real[:, :] dCm_Flap "change in pitch moment coefficient due to flaps";
        Real[:, :] dCm_Elevator "change in pitch moment coefficient due to elevator";
        Real[:, :] dCm_PitchRate "change in pitch moment coefficient due to pitch rate";
        Real[:, :] dCm_AlphaDot "change in pitch moment coefficient due to aoa rate";
        Real[:, :] dCn_Aileron "change in yaw moment coefficient due to aileron";
        Real[:, :] dCn_Beta "change in yaw moment coefficient due to side slip angle";
        Real[:, :] dCn_RollRate "change in yaw moment coefficient due to roll rate";
        Real[:, :] dCn_YawRate "change in yaw moment coefficient due to yaw rate";
      end Tables;

      record CoefficientsAndDerivatives 
        Real CL_Basic "basic lift coefficient";
        Real dCL_Flap "change in lift coefficient due to flaps";
        Real dCL_Elevator "change in lift coefficient due to elevator";
        Real dCL_PitchRate "change in lift coefficient due to pitch rate";
        Real dCL_AlphaDot "change in lift coefficient due to aoa rate";
        Real CD_Basic "basic drag coefficient";
        Real dCD_Flap "change in drag coefficient due to flaps";
        Real dCD_Elevator "change in drag coefficient due to elevator";
        Real dCY_Beta "change in side force coefficient due to side slip angle";
        Real dCY_RollRate "change in side force coefficient due to roll rate";
        Real dCl_Aileron "change in roll moment coefficient due to aileron";
        Real dCl_Beta "change in roll moment coefficient due to side slip angle";
        Real dCl_RollRate "change in roll moment coefficient due to roll rate";
        Real dCl_YawRate "change in roll moment coefficient due to yaw rate";
        Real Cm_Basic "basic pitch moment coefficient";
        Real dCm_Flap "change in pitch moment coefficient due to flaps";
        Real dCm_Elevator "change in pitch moment coefficient due to elevator";
        Real dCm_PitchRate "change in pitch moment coefficient due to pitch rate";
        Real dCm_AlphaDot "change in pitch moment coefficient due to aoa rate";
        Real dCn_Aileron "change in yaw moment coefficient due to aileron";
        Real dCn_Beta "change in yaw moment coefficient due to side slip angle";
        Real dCn_RollRate "change in yaw moment coefficient due to roll rate";
        Real dCn_YawRate "change in yaw moment coefficient due to yaw rate";
      end CoefficientsAndDerivatives;

      block CombiTable1DSISO 
        output Real y;
        input Real u;
        constant Real[:, :] table;
        Modelica.Blocks.Nonlinear.Limiter sat(uMax = table[size(table, 1), 1], uMin = table[1, 1]);
        Modelica.Blocks.Tables.CombiTable1Ds combi(columns = {2}, smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, table = table);
      equation
        y = combi.y[1];
        connect(u, sat.u);
        connect(sat.y, combi.u);
      end CombiTable1DSISO;

      block CombiTable2DMISO 
        output Real y;
        input Real u1;
        input Real u2;
        constant Real[:, :] table;
        constant Integer nRows = size(table, 1);
        constant Integer nCols = size(table, 2);
        Modelica.Blocks.Nonlinear.Limiter sat1(uMax = table[nRows, 1], uMin = table[2, 1]);
        Modelica.Blocks.Nonlinear.Limiter sat2(uMax = table[1, nCols], uMin = table[1, 2]);
        Modelica.Blocks.Tables.CombiTable2D combi(smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, table = if nCols > nRows then table else transpose(table));
      equation
        y = combi.y;
        connect(u1, sat1.u);
        connect(u2, sat2.u);
        if nCols > nRows then
          connect(sat1.y, combi.u1);
          connect(sat2.y, combi.u2);
        else
          connect(sat1.y, combi.u2);
          connect(sat2.y, combi.u1);
        end if;
      end CombiTable2DMISO;

      partial model ForceMomentBase 
        extends ForceMomentStabilityFrame;
        extends CoefficientsAndDerivatives;
        extends Controls;
        constant Real rad2deg = 180.0 / 3.14159;
      equation
        CL = CL_Basic + dCL_Flap * flap_deg + dCL_Elevator * elevator_deg + (dCL_PitchRate * rad2deg * q * cBar) / (2 * vt) + (dCL_AlphaDot * rad2deg * alphaDot * cBar) / (2 * vt) + 0;
        CD = CD_Basic + dCD_Flap * flap_deg + dCD_Elevator * elevator_deg + 0;
        CY = (-dCY_Beta) * beta_deg + (dCY_RollRate * rad2deg * p * b) / (2 * vt) + 0;
        Cl = dCl_Aileron * aileron_deg + ((-dCl_Beta) * beta_deg) / 10000 + (dCl_RollRate * rad2deg * p * b) / (2 * vt) + (dCl_YawRate * rad2deg * r * b) / (2 * vt) + 0;
        Cm = Cm_Basic + dCm_Flap * flap_deg + dCm_Elevator * elevator_deg + (dCm_PitchRate * rad2deg * q * cBar) / (2 * vt) + (dCm_AlphaDot * rad2deg * alphaDot * cBar) / (2 * vt) + 0;
        Cn = dCn_Aileron * aileron_deg + ((-dCn_Beta) * beta_deg) / 10000 + (dCn_RollRate * rad2deg * p * b) / (2 * vt) + (dCn_YawRate * rad2deg * r * b) / (2 * vt) + 0;
      end ForceMomentBase;

      model ForceMoment 
        extends ForceMomentBase;
        constant Tables tables;
        CombiTable1DSISO CL_Basic_table(table = tables.CL_Basic, u = alpha_deg, y = CL_Basic);
        CombiTable1DSISO dCL_Flap_table(table = tables.dCL_Flap, u = flap_deg, y = dCL_Flap);
        CombiTable1DSISO dCL_Elevator_table(table = tables.dCL_Elevator, u = elevator_deg, y = dCL_Elevator);
        CombiTable1DSISO dCL_PitchRate_table(table = tables.dCL_PitchRate, u = alpha_deg, y = dCL_PitchRate);
        CombiTable1DSISO dCL_AlphaDot_table(table = tables.dCL_AlphaDot, u = alpha_deg, y = dCL_AlphaDot);
        CombiTable1DSISO CD_Basic_table(table = tables.CD_Basic, u = alpha_deg, y = CD_Basic);
        CombiTable2DMISO dCD_Flap_table(table = tables.dCD_Flap, u1 = alpha_deg, u2 = flap_deg, y = dCD_Flap);
        CombiTable2DMISO dCD_Elevator_table(table = tables.dCD_Elevator, u1 = alpha_deg, u2 = elevator_deg, y = dCD_Elevator);
        CombiTable1DSISO dCY_Beta_table(table = tables.dCY_Beta, u = alpha_deg, y = dCY_Beta);
        CombiTable1DSISO dCY_RollRate_table(table = tables.dCY_RollRate, u = alpha_deg, y = dCY_RollRate);
        CombiTable1DSISO dCl_Aileron_table(table = tables.dCl_Aileron, u = aileron_deg, y = dCl_Aileron);
        CombiTable1DSISO dCl_Beta_table(table = tables.dCl_Beta, u = alpha_deg, y = dCl_Beta);
        CombiTable1DSISO dCl_RollRate_table(table = tables.dCl_RollRate, u = alpha_deg, y = dCl_RollRate);
        CombiTable1DSISO dCl_YawRate_table(table = tables.dCl_YawRate, u = alpha_deg, y = dCl_YawRate);
        CombiTable1DSISO Cm_Basic_table(table = tables.Cm_Basic, u = alpha_deg, y = Cm_Basic);
        CombiTable1DSISO dCm_Flap_table(table = tables.dCm_Flap, u = alpha_deg, y = dCm_Flap);
        CombiTable1DSISO dCm_Elevator_table(table = tables.dCm_Elevator, u = alpha_deg, y = dCm_Elevator);
        CombiTable1DSISO dCm_PitchRate_table(table = tables.dCm_PitchRate, u = alpha_deg, y = dCm_PitchRate);
        CombiTable1DSISO dCm_AlphaDot_table(table = tables.dCm_AlphaDot, u = alpha_deg, y = dCm_AlphaDot);
        CombiTable2DMISO dCn_Aileron_table(table = tables.dCn_Aileron, u1 = alpha_deg, u2 = aileron_deg, y = dCn_Aileron);
        CombiTable1DSISO dCn_Beta_table(table = tables.dCn_Beta, u = alpha_deg, y = dCn_Beta);
        CombiTable1DSISO dCn_RollRate_table(table = tables.dCn_RollRate, u = alpha_deg, y = dCn_RollRate);
        CombiTable1DSISO dCn_YawRate_table(table = tables.dCn_YawRate, u = alpha_deg, y = dCn_YawRate);
      end ForceMoment;
    end Datcom;

    partial model ForceMoment 
      extends Parts.ForceMoment;
      outer World.WorldBase world;
      parameter .Modelica.SIunits.Velocity vtTol = 0.01 "when to ignore aerodynamics";
      .Modelica.SIunits.Velocity[3] vR_b "relative air velocity resolved in body frame";
      .Modelica.SIunits.Acceleration[3] aR_b "relative air acceleration resolved in body frame";
      .Modelica.SIunits.Velocity vt "true air velocity";
      .Modelica.SIunits.Acceleration vtDot "true air velocity derivative";
      .Modelica.SIunits.Pressure qBar "dynamics pressure";
      .Modelica.SIunits.Angle alpha "angle of attack";
      .Modelica.SIunits.AngularVelocity alphaDot "derivative of angle of attack";
      .Modelica.SIunits.Angle beta "side slip angle";
      .Modelica.SIunits.AngularVelocity betaDot "derivative of side slip angle";
      parameter .Modelica.SIunits.Area s "reference area";
      parameter .Modelica.SIunits.Length cBar "average chord";
      parameter .Modelica.SIunits.Length b "span";
      .Modelica.SIunits.AngularVelocity p "body roll rate";
      .Modelica.SIunits.AngularVelocity q "body pitch rate";
      .Modelica.SIunits.AngularVelocity r "body yaw rate";
      .Modelica.SIunits.Angle alpha_deg "angle of attack, deg";
      .Modelica.SIunits.Angle beta_deg "side slip, deg";
      Real[3, 3] C_bs "stability to body frame";
      Real[3, 3] C_bw "wind to body frame";
      Real[3] wind "wind";
    equation
      wind = world.wind_r(fA.r_r);
      vR_b = fA.v_b - fA.C_br * wind;
      vt = sqrt(vR_b * vR_b);
      qBar = 0.5 * world.rho(fA.r_r) * vt ^ 2;
      aR_b = der(vR_b);
      alpha = atan2(vR_b[3], vR_b[1]);
      alphaDot = der(alpha);
      vtDot = der(vt);
      beta = asin(vR_b[2] / vt);
      betaDot = der(beta);
      alpha_deg = .Modelica.SIunits.Conversions.to_deg(alpha);
      beta_deg = .Modelica.SIunits.Conversions.to_deg(beta);
      {p, q, r} = fA.w_ib;
      C_bs = Parts.T2(alpha);
      C_bw = Parts.T2(alpha) * Parts.T3(beta);
    end ForceMoment;

    model ForceMomentStabilityFrame 
      extends Aerodynamics.ForceMoment;
      Real CL;
      Real CD;
      Real CY;
      Real Cl;
      Real Cm;
      Real Cn;
    equation
      F_b = C_bs * {-CD, -CY, -CL} * qBar * s;
      M_b = C_bs * {Cl * b, Cm * cBar, Cn * b} * qBar * s;
    end ForceMomentStabilityFrame;
  end Aerodynamics;
end OpenFDM;

package Modelica 
  extends Modelica.Icons.Library;

  package Blocks 
    extends Modelica.Icons.Library2;

    package Interfaces 
      extends Modelica.Icons.Library;
      connector RealInput = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid)}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid), Text(extent = {{-10, 85}, {-10, 60}}, lineColor = {0, 0, 127}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one input signal of type Real.
        </p>
        </html>"));
      connector RealOutput = output Real "'output Real' as connector" annotation(defaultComponentName = "y", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{30, 110}, {30, 60}}, lineColor = {0, 0, 127}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one output signal of type Real.
        </p>
        </html>"));

      partial block BlockIcon 
         annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Documentation(info = "<html>
          <p>
          Block that has only the basic icon for an input/output
          block (no declarations, no equations). Most blocks
          of package Modelica.Blocks inherit directly or indirectly
          from this block.
          </p>
          </html>"));
      end BlockIcon;

      partial block SISO 
        extends BlockIcon;
        RealInput u "Connector of Real input signal" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
         annotation(Documentation(info = "<html>
          <p>
          Block has one continuous Real input and one continuous Real output signal.
          </p>
          </html>"));
      end SISO;

      partial block SI2SO 
        extends BlockIcon;
        RealInput u1 "Connector of Real input signal 1" annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}}, rotation = 0)));
        RealInput u2 "Connector of Real input signal 2" annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}}, rotation = 0)));
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
         annotation(Documentation(info = "<html>
          <p>
          Block has two continuous Real input signals u1 and u2 and one
          continuous Real output signal y.
          </p>
          </html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})));
      end SI2SO;

      partial block SIMO 
        extends BlockIcon;
        parameter Integer nout = 1 "Number of outputs";
        RealInput u "Connector of Real input signal" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
        RealOutput[nout] y "Connector of Real output signals" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
         annotation(Documentation(info = "<HTML>
          <p> Block has one continuous Real input signal and a
              vector of continuous Real output signals.</p>

          </HTML>
          "));
      end SIMO;
       annotation(Documentation(info = "<HTML>
        <p>
        This package contains interface definitions for
        <b>continuous</b> input/output blocks with Real,
        Integer and Boolean signals. Furthermore, it contains
        partial models for continuous and discrete blocks.
        </p>

        </HTML>
        ", revisions = "<html>
        <ul>
        <li><i>Oct. 21, 2002</i>
               by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
               and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
               Added several new interfaces. <a href=\"../Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
        <li><i>Oct. 24, 1999</i>
               by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
               RealInputSignal renamed to RealInput. RealOutputSignal renamed to
               output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
               SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
               SignalGenerator renamed to SignalSource. Introduced the following
               new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
               DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
               BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
        <li><i>June 30, 1999</i>
               by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
               Realized a first version, based on an existing Dymola library
               of Dieter Moormann and Hilding Elmqvist.</li>
        </ul>
        </html>
        "));
    end Interfaces;

    package Nonlinear 
      extends Modelica.Icons.Library;

      block Limiter 
        parameter Real uMax(start = 1) "Upper limits of input signals";
        parameter Real uMin = -uMax "Lower limits of input signals";
        parameter Boolean limitsAtInit = true "= false, if limits are ignored during initializiation (i.e., y=u)";
        extends .Modelica.Blocks.Interfaces.SISO;
         annotation(Documentation(info = "
          <HTML>
          <p>
          The Limiter block passes its input signal as output signal
          as long as the input is within the specified upper and lower
          limits. If this is not the case, the corresponding limits are passed
          as output.
          </p>
          </HTML>
          "), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), Polygon(points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-80, -70}, {-50, -70}, {50, 70}, {80, 70}}, color = {0, 0, 0}), Text(extent = {{-150, -150}, {150, -110}}, lineColor = {0, 0, 0}, textString = "uMax=%uMax"), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Line(points = {{0, -60}, {0, 50}}, color = {192, 192, 192}), Polygon(points = {{0, 60}, {-5, 50}, {5, 50}, {0, 60}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-60, 0}, {50, 0}}, color = {192, 192, 192}), Polygon(points = {{60, 0}, {50, -5}, {50, 5}, {60, 0}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Line(points = {{-50, -40}, {-30, -40}, {30, 40}, {50, 40}}, color = {0, 0, 0}), Text(extent = {{46, -6}, {68, -18}}, lineColor = {128, 128, 128}, textString = "u"), Text(extent = {{-30, 70}, {-5, 50}}, lineColor = {128, 128, 128}, textString = "y"), Text(extent = {{-58, -54}, {-28, -42}}, lineColor = {128, 128, 128}, textString = "uMin"), Text(extent = {{26, 40}, {66, 56}}, lineColor = {128, 128, 128}, textString = "uMax")}));
      equation
        assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) + ") < uMin (=" + String(uMin) + ")");
        if initial() and not limitsAtInit then
          y = u;
          assert(u >= uMin - 0.01 * abs(uMin) and u <= uMax + 0.01 * abs(uMax), "Limiter: During initialization the limits have been ignored.\n" + "However, the result is that the input u is not within the required limits:\n" + "  u = " + String(u) + ", uMin = " + String(uMin) + ", uMax = " + String(uMax));
        else
          y = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u);
        end if;
      end Limiter;
       annotation(Documentation(info = "
        <HTML>
        <p>
        This package contains <b>discontinuous</b> and
        <b>non-differentiable, algebraic</b> input/output blocks.
        </p>
        </HTML>
        ", revisions = "<html>
        <ul>
        <li><i>October 21, 2002</i>
               by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
               New block VariableLimiter added.
        <li><i>August 22, 1999</i>
               by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
               Realized, based on an existing Dymola library
               of Dieter Moormann and Hilding Elmqvist.
        </li>
        </ul>
        </html>
        "));
    end Nonlinear;

    package Tables 
      extends Modelica.Icons.Library;

      model CombiTable1Ds 
        parameter Boolean tableOnFile = false "true, if table is defined on file or in function usertab" annotation(Dialog(group = "table data definition"));
        parameter Real[:, :] table = fill(0.0, 0, 2) "table matrix (grid = first column; e.g., table=[0,2])" annotation(Dialog(group = "table data definition", enable = not tableOnFile));
        parameter String tableName = "NoName" "table name on file or in function usertab (see docu)" annotation(Dialog(group = "table data definition", enable = tableOnFile));
        parameter String fileName = "NoName" "file where matrix is stored" annotation(Dialog(group = "table data definition", enable = tableOnFile, __Dymola_loadSelector(filter = "Text files (*.txt);;Matlab files (*.mat)", caption = "Open file in which table is present")));
        parameter Integer[:] columns = 2:size(table, 2) "columns of table to be interpolated" annotation(Dialog(group = "table data interpretation"));
        parameter Modelica.Blocks.Types.Smoothness smoothness = .Modelica.Blocks.Types.Smoothness.LinearSegments "smoothness of table interpolation" annotation(Dialog(group = "table data interpretation"));
        extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
      protected
        Integer tableID;

        function tableInit 
          input String tableName;
          input String fileName;
          input Real[:, :] table;
          input Modelica.Blocks.Types.Smoothness smoothness;
          output Integer tableID;
          external "C" tableID = ModelicaTables_CombiTable1D_init(tableName, fileName, table, size(table, 1), size(table, 2), smoothness);
        end tableInit;

        function tableIpo 
          input Integer tableID;
          input Integer icol;
          input Real u;
          output Real value;
          external "C" value = ModelicaTables_CombiTable1D_interpolate(tableID, icol, u);
        end tableIpo;
         annotation(Documentation(info = "<html>
          <p>
          <b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
          Via parameter <b>columns</b> it can be defined how many columns of the
          table are interpolated. If, e.g., icol={2,4}, it is assumed that one input
          and 2 output signals are present and that the first output interpolates
          via column 2 and the second output interpolates via column 4 of the
          table matrix.
          </p>
          <p>
          The grid points and function values are stored in a matrix \"table[i,j]\",
          where the first column \"table[:,1]\" contains the grid points and the
          other columns contain the data to be interpolated. Example:
          </p>
          <pre>
             table = [0,  0;
                      1,  1;
                      2,  4;
                      4, 16]
             If, e.g., the input u = 1.0, the output y =  1.0,
                 e.g., the input u = 1.5, the output y =  2.5,
                 e.g., the input u = 2.0, the output y =  4.0,
                 e.g., the input u =-1.0, the output y = -1.0 (i.e. extrapolation).
          </pre>
          <ul>
          <li> The interpolation is <b>efficient</b>, because a search for a new interpolation
               starts at the interval used in the last call.</li>
          <li> If the table has only <b>one row</b>, the table value is returned,
               independent of the value of the input signal.</li>
          <li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
               u &gt; table[size(table,1),1] or u &lt; table[1,1], the corresponding
               value is also determined by linear
               interpolation through the last or first two points of the table.</li>
          <li> The grid values (first column) have to be <b>strict</b>
               monotonically increasing.</li>
          </ul>
          <p>
          The table matrix can be defined in the following ways:
          </p>
          <ol>
          <li> Explicitly supplied as <b>parameter matrix</b> \"table\",
               and the other parameters have the following values:
          <pre>
             tableName is \"NoName\" or has only blanks,
             fileName  is \"NoName\" or has only blanks.
          </pre></li>
          <li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
                \"tableName\". Both ASCII and binary file format is possible.
                (the ASCII format is described below).
                It is most convenient to generate the binary file from Matlab
                (Matlab 4 storage format), e.g., by command
          <pre>
             save tables.mat tab1 tab2 tab3 -V4
          </pre>
                when the three tables tab1, tab2, tab3 should be
                used from the model.</li>
          <li>  Statically stored in function \"usertab\" in file \"usertab.c\".
                The matrix is identified by \"tableName\". Parameter
                fileName = \"NoName\" or has only blanks.</li>
          </ol>
          <p>
          Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
          and do not access files, whereas method (2) does. Therefore (1) and (3)
          are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
          When the constant \"NO_FILE\" is defined, all parts of the
          source code of method (2) are removed by the C-preprocessor, such that
          no dynamic memory allocation and no access to files takes place.
          </p>
          <p>
          If tables are read from an ASCII-file, the file need to have the
          following structure (\"-----\" is not part of the file content):
          </p>
          <pre>
          -----------------------------------------------------
          #1
          double tab1(5,2)   # comment line
            0   0
            1   1
            2   4
            3   9
            4  16
          double tab2(5,2)   # another comment line
            0   0
            2   2
            4   8
            6  18
            8  32
          -----------------------------------------------------
          </pre>
          <p>
          Note, that the first two characters in the file need to be
          \"#1\". Afterwards, the corresponding matrix has to be declared
          with type, name and actual dimensions. Finally, in successive
          rows of the file, the elements of the matrix have to be given.
          Several matrices may be defined one after another.
          </p>
          </HTML>
          "), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-60, 40}, {-60, -40}, {60, -40}, {60, 40}, {30, 40}, {30, -40}, {-30, -40}, {-30, 40}, {-60, 40}, {-60, 20}, {60, 20}, {60, 0}, {-60, 0}, {-60, -20}, {60, -20}, {60, -40}, {-60, -40}, {-60, 40}, {60, 40}, {60, -40}}, color = {0, 0, 0}), Line(points = {{0, 40}, {0, -40}}, color = {0, 0, 0}), Rectangle(extent = {{-60, 40}, {-30, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, 20}, {-30, 0}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, 0}, {-30, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, -20}, {-30, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {-58, 0}}, color = {0, 0, 255}), Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}), Text(extent = {{-100, 100}, {100, 64}}, textString = "1 dimensional linear table interpolation", lineColor = {0, 0, 255}), Line(points = {{-54, 40}, {-54, -40}, {54, -40}, {54, 40}, {28, 40}, {28, -40}, {-28, -40}, {-28, 40}, {-54, 40}, {-54, 20}, {54, 20}, {54, 0}, {-54, 0}, {-54, -20}, {54, -20}, {54, -40}, {-54, -40}, {-54, 40}, {54, 40}, {54, -40}}, color = {0, 0, 0}), Line(points = {{0, 40}, {0, -40}}, color = {0, 0, 0}), Rectangle(extent = {{-54, 40}, {-28, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, 20}, {-28, 0}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, 0}, {-28, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, -20}, {-28, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-52, 56}, {-34, 44}}, textString = "u", lineColor = {0, 0, 255}), Text(extent = {{-22, 54}, {2, 42}}, textString = "y[1]", lineColor = {0, 0, 255}), Text(extent = {{4, 54}, {28, 42}}, textString = "y[2]", lineColor = {0, 0, 255}), Text(extent = {{0, -40}, {32, -54}}, textString = "columns", lineColor = {0, 0, 255})}));
      equation
        if tableOnFile then
          assert(tableName <> "NoName", "tableOnFile = true and no table name given");
        end if;
        if not tableOnFile then
          assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        for i in 1:nout loop
          y[i] = if not tableOnFile and size(table, 1) == 1 then table[1, columns[i]] else tableIpo(tableID, columns[i], u);
        end for;
        when initial() then
          tableID = tableInit(if tableOnFile then tableName else "NoName", if tableOnFile then fileName else "NoName", table, smoothness);
        end when;
      end CombiTable1Ds;

      model CombiTable2D 
        extends Modelica.Blocks.Interfaces.SI2SO;
        parameter Boolean tableOnFile = false "true, if table is defined on file or in function usertab" annotation(Dialog(group = "table data definition"));
        parameter Real[:, :] table = fill(0.0, 0, 2) "table matrix (grid u1 = first column, grid u2 = first row; e.g. table=[0,0;0,1])" annotation(Dialog(group = "table data definition", enable = not tableOnFile));
        parameter String tableName = "NoName" "table name on file or in function usertab (see docu)" annotation(Dialog(group = "table data definition", enable = tableOnFile));
        parameter String fileName = "NoName" "file where matrix is stored" annotation(Dialog(group = "table data definition", enable = tableOnFile, __Dymola_loadSelector(filter = "Text files (*.txt);;Matlab files (*.mat)", caption = "Open file in which table is present")));
        parameter Modelica.Blocks.Types.Smoothness smoothness = .Modelica.Blocks.Types.Smoothness.LinearSegments "smoothness of table interpolation" annotation(Dialog(group = "table data interpretation"));
      protected
        Integer tableID;

        function tableInit 
          input String tableName;
          input String fileName;
          input Real[:, :] table;
          input Modelica.Blocks.Types.Smoothness smoothness;
          output Integer tableID;
          external "C" tableID = ModelicaTables_CombiTable2D_init(tableName, fileName, table, size(table, 1), size(table, 2), smoothness);
        end tableInit;

        function tableIpo 
          input Integer tableID;
          input Real u1;
          input Real u2;
          output Real value;
          external "C" value = ModelicaTables_CombiTable2D_interpolate(tableID, u1, u2);
        end tableIpo;
         annotation(Documentation(info = "<html>
          <p>
          <b>Linear interpolation</b> in <b>two</b> dimensions of a <b>table</b>.
          The grid points and function values are stored in a matrix \"table[i,j]\",
          where:
          </p>
          <ul>
          <li> the first column \"table[2:,1]\" contains the u[1] grid points,</li>
          <li> the first row \"table[1,2:]\" contains the u[2] grid points,</li>
          <li> the other rows and columns contain the data to be interpolated.</li>
          </ul>
          <p>
          Example:
          </p>
          <pre>
                     |       |       |       |
                     |  1.0  |  2.0  |  3.0  |  // u2
                 ----*-------*-------*-------*
                 1.0 |  1.0  |  3.0  |  5.0  |
                 ----*-------*-------*-------*
                 2.0 |  2.0  |  4.0  |  6.0  |
                 ----*-------*-------*-------*
               // u1
             is defined as
                table = [0.0,   1.0,   2.0,   3.0;
                         1.0,   1.0,   3.0,   5.0;
                         2.0,   2.0,   4.0,   6.0]
             If, e.g. the input u is [1.0;1.0], the output y is 1.0,
                 e.g. the input u is [2.0;1.5], the output y is 3.0.
          </pre>
          <ul>
          <li> The interpolation is <b>efficient</b>, because a search for a new interpolation
               starts at the interval used in the last call.</li>
          <li> If the table has only <b>one element</b>, the table value is returned,
               independent of the value of the input signal.</li>
          <li> If the input signal <b>u1</b> or <b>u2</b> is <b>outside</b> of the defined <b>interval</b>,
               the corresponding value is also determined by linear
               interpolation through the last or first two points of the table.</li>
          <li> The grid values (first column and first row) have to be <b>strict</b>
               monotonically increasing.</li>
          </ul>
          <p>
          The table matrix can be defined in the following ways:
          </p>
          <ol>
          <li> Explicitly supplied as <b>parameter matrix</b> \"table\",
               and the other parameters have the following values:
          <pre>
             tableName is \"NoName\" or has only blanks,
             fileName  is \"NoName\" or has only blanks.
          </pre></li>
          <li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
                \"tableName\". Both ASCII and binary file format is possible.
                (the ASCII format is described below).
                It is most convenient to generate the binary file from Matlab
                (Matlab 4 storage format), e.g., by command
          <pre>
             save tables.mat tab1 tab2 tab3 -V4
          </pre>
                when the three tables tab1, tab2, tab3 should be
                used from the model.</li>
          <li>  Statically stored in function \"usertab\" in file \"usertab.c\".
                The matrix is identified by \"tableName\". Parameter
                fileName = \"NoName\" or has only blanks.</li>
          </ol>
          <p>
          Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
          and do not access files, whereas method (2) does. Therefore (1) and (3)
          are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
          When the constant \"NO_FILE\" is defined, all parts of the
          source code of method (2) are removed by the C-preprocessor, such that
          no dynamic memory allocation and no access to files takes place.
          </p>
          <p>
          If tables are read from an ASCII-file, the file need to have the
          following structure (\"-----\" is not part of the file content):
          </p>
          <pre>
          -----------------------------------------------------
          #1
          double table2D_1(3,4)   # comment line
          0.0  1.0  2.0  3.0  # u[2] grid points
          1.0  1.0  3.0  5.0
          2.0  2.0  4.0  6.0

          double table2D_2(4,4)   # comment line
          0.0  1.0  2.0  3.0  # u[2] grid points
          1.0  1.0  3.0  5.0
          2.0  2.0  4.0  6.0
          3.0  3.0  5.0  7.0
          -----------------------------------------------------
          </pre>
          <p>
          Note, that the first two characters in the file need to be
          \"#1\". Afterwards, the corresponding matrix has to be declared
          with type, name and actual dimensions. Finally, in successive
          rows of the file, the elements of the matrix have to be given.
          Several matrices may be defined one after another.
          The matrix elements are interpreted in exactly the same way
          as if the matrix is given as a parameter. For example, the first
          column \"table2D_1[2:,1]\" contains the u[1] grid points,
          and the first row \"table2D_1[1,2:]\" contains the u[2] grid points.
          </p>

          </html>
          "), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-60, 40}, {-60, -40}, {60, -40}, {60, 40}, {30, 40}, {30, -40}, {-30, -40}, {-30, 40}, {-60, 40}, {-60, 20}, {60, 20}, {60, 0}, {-60, 0}, {-60, -20}, {60, -20}, {60, -40}, {-60, -40}, {-60, 40}, {60, 40}, {60, -40}}, color = {0, 0, 0}), Line(points = {{0, 40}, {0, -40}}, color = {0, 0, 0}), Rectangle(extent = {{-60, 20}, {-30, 0}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, 0}, {-30, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-60, -20}, {-30, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-30, 40}, {0, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{0, 40}, {30, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{30, 40}, {60, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-60, 40}, {-30, 20}}, color = {0, 0, 0}), Line(points = {{-30, 40}, {-60, 20}}, color = {0, 0, 0})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}), Text(extent = {{-100, 100}, {100, 64}}, textString = "2 dimensional linear table interpolation", lineColor = {0, 0, 255}), Line(points = {{-54, 40}, {-54, -40}, {54, -40}, {54, 40}, {28, 40}, {28, -40}, {-28, -40}, {-28, 40}, {-54, 40}, {-54, 20}, {54, 20}, {54, 0}, {-54, 0}, {-54, -20}, {54, -20}, {54, -40}, {-54, -40}, {-54, 40}, {54, 40}, {54, -40}}, color = {0, 0, 0}), Line(points = {{0, 40}, {0, -40}}, color = {0, 0, 0}), Rectangle(extent = {{-54, 20}, {-28, 0}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, 0}, {-28, -20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-54, -20}, {-28, -40}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-28, 40}, {0, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{0, 40}, {28, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{28, 40}, {54, 20}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Line(points = {{-54, 40}, {-28, 20}}, color = {0, 0, 0}), Line(points = {{-28, 40}, {-54, 20}}, color = {0, 0, 0}), Text(extent = {{-54, -40}, {-30, -56}}, textString = "u1", lineColor = {0, 0, 255}), Text(extent = {{28, 58}, {52, 44}}, textString = "u2", lineColor = {0, 0, 255}), Text(extent = {{-2, 12}, {32, -22}}, textString = "y", lineColor = {0, 0, 255})}));
      equation
        if tableOnFile then
          assert(tableName <> "NoName", "tableOnFile = true and no table name given");
        end if;
        if not tableOnFile then
          assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        y = tableIpo(tableID, u1, u2);
        when initial() then
          tableID = tableInit(if tableOnFile then tableName else "NoName", if tableOnFile then fileName else "NoName", table, smoothness);
        end when;
      end CombiTable2D;
       annotation(Documentation(info = "<html>
        <p>
        This package contains blocks for one- and two-dimensional
        interpolation in tables.
        </p>
        </html>"));
    end Tables;

    package Types 
      extends Modelica.Icons.Library;
      type Smoothness = enumeration(LinearSegments "Table points are linearly interpolated", ContinuousDerivative "Table points are interpolated such that the first derivative is continuous") "Enumeration defining the smoothness of table interpolation" annotation(Documentation(info = "<html>

        </html>"));
       annotation(Documentation(info = "<HTML>
        <p>
        In this package <b>types</b> and <b>constants</b> are defined that are used
        in library Modelica.Blocks. The types have additional annotation choices
        definitions that define the menus to be built up in the graphical
        user interface when the type is used as parameter in a declaration.
        </p>
        </HTML>"));
    end Types;
     annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-32, -6}, {16, -35}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-32, -56}, {16, -85}}, lineColor = {0, 0, 0}), Line(points = {{16, -20}, {49, -20}, {49, -71}, {16, -71}}, color = {0, 0, 0}), Line(points = {{-32, -72}, {-64, -72}, {-64, -21}, {-32, -21}}, color = {0, 0, 0}), Polygon(points = {{16, -71}, {29, -67}, {29, -74}, {16, -71}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-32, -21}, {-46, -17}, {-46, -25}, {-32, -21}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
      <p>
      This library contains input/output blocks to build up block diagrams.
      </p>

      <dl>
      <dt><b>Main Author:</b>
      <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
          Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
          Oberpfaffenhofen<br>
          Postfach 1116<br>
          D-82230 Wessling<br>
          email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
      </dl>
      <p>
      Copyright &copy; 1998-2009, Modelica Association and DLR.
      </p>
      <p>
      <i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
      under the terms of the <b>Modelica license</b>, see the license conditions
      and the accompanying <b>disclaimer</b>
      <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
      </p>
      </HTML>
      ", revisions = "<html>
      <ul>
      <li><i>June 23, 2004</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Introduced new block connectors and adapated all blocks to the new connectors.
             Included subpackages Continuous, Discrete, Logical, Nonlinear from
             package ModelicaAdditions.Blocks.
             Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
             and in the new package Modelica.Blocks.Tables.
             Added new blocks to Blocks.Sources and Blocks.Logical.
             </li>
      <li><i>October 21, 2002</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
             New subpackage Examples, additional components.
             </li>
      <li><i>June 20, 2000</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
             Michael Tiller:<br>
             Introduced a replaceable signal type into
             Blocks.Interfaces.RealInput/RealOutput:
      <pre>
         replaceable type SignalType = Real
      </pre>
             in order that the type of the signal of an input/output block
             can be changed to a physical type, for example:
      <pre>
         Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
      </pre>
            </li>
      <li><i>Sept. 18, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Renamed to Blocks. New subpackages Math, Nonlinear.
             Additional components in subpackages Interfaces, Continuous
             and Sources. </li>
      <li><i>June 30, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Realized a first version, based on an existing Dymola library
             of Dieter Moormann and Hilding Elmqvist.</li>
      </ul>
      </html>"));
  end Blocks;

  package Math 
    extends Modelica.Icons.Library2;

    function asin 
      extends baseIcon2;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "C" y = asin(u);
    end asin;

    function exp 
      extends baseIcon2;
      input Real u;
      output Real y;
      external "C" y = exp(u);
    end exp;

    partial function baseIcon2 
       annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), Polygon(points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, 80}, {-8, 80}}, color = {95, 95, 95}), Line(points = {{0, -80}, {-8, -80}}, color = {95, 95, 95}), Line(points = {{0, -90}, {0, 84}}, color = {95, 95, 95}), Text(extent = {{5, 104}, {25, 84}}, lineColor = {95, 95, 95}, textString = "y"), Polygon(points = {{0, 98}, {-6, 82}, {6, 82}, {0, 98}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid)}), Documentation(revisions = "<html>
        <p>
        Icon for a mathematical function, consisting of an y-axis in the middle.
        It is expected, that an x-axis is added and a plot of the function.
        </p>
        </html>"));
    end baseIcon2;
     annotation(Invisible = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-59, -9}, {42, -56}}, lineColor = {0, 0, 0}, textString = "f(x)")}), Documentation(info = "<HTML>
      <p>
      This package contains <b>basic mathematical functions</b> (such as sin(..)),
      as well as functions operating on <b>vectors</b> and <b>matrices</b>.
      </p>

      <dl>
      <dt><b>Main Author:</b>
      <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
          Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
          Institut f&uuml;r Robotik und Mechatronik<br>
          Postfach 1116<br>
          D-82230 Wessling<br>
          Germany<br>
          email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
      </dl>

      <p>
      Copyright &copy; 1998-2009, Modelica Association and DLR.
      </p>
      <p>
      <i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
      under the terms of the <b>Modelica license</b>, see the license conditions
      and the accompanying <b>disclaimer</b>
      <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
      </p><br>
      </HTML>
      ", revisions = "<html>
      <ul>
      <li><i>October 21, 2002</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
             Function tempInterpol2 added.</li>
      <li><i>Oct. 24, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Icons for icon and diagram level introduced.</li>
      <li><i>June 30, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Realized.</li>
      </ul>

      </html>"));
  end Math;

  package Constants 
    extends Modelica.Icons.Library2;
    final constant Real pi = 2 * Modelica.Math.asin(1.0);
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 0.0000001 "Magnetic constant";
     annotation(Documentation(info = "<html>
      <p>
      This package provides often needed constants from mathematics, machine
      dependent constants and constants from nature. The latter constants
      (name, value, description) are from the following source:
      </p>

      <dl>
      <dt>Peter J. Mohr and Barry N. Taylor (1999):</dt>
      <dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 1998</b>.
          Journal of Physical and Chemical Reference Data, Vol. 28, No. 6, 1999 and
          Reviews of Modern Physics, Vol. 72, No. 2, 2000. See also <a href=
      \"http://physics.nist.gov/cuu/Constants/\">http://physics.nist.gov/cuu/Constants/</a></dd>
      </dl>

      <p>CODATA is the Committee on Data for Science and Technology.</p>

      <dl>
      <dt><b>Main Author:</b></dt>
      <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
          Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
          Oberpfaffenhofen<br>
          Postfach 11 16<br>
          D-82230 We&szlig;ling<br>
          email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
      </dl>


      <p>
      Copyright &copy; 1998-2009, Modelica Association and DLR.
      </p>
      <p>
      <i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
      under the terms of the <b>Modelica license</b>, see the license conditions
      and the accompanying <b>disclaimer</b>
      <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
      </p><br>
      </html>
      ", revisions = "<html>
      <ul>
      <li><i>Nov 8, 2004</i>
             by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
             Constants updated according to 2002 CODATA values.</li>
      <li><i>Dec 9, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Constants updated according to 1998 CODATA values. Using names, values
             and description text from this source. Included magnetic and
             electric constant.</li>
      <li><i>Sep 18, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Constants eps, inf, small introduced.</li>
      <li><i>Nov 15, 1997</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Realized.</li>
      </ul>
      </html>"), Invisible = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-34, -38}, {12, -38}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-20, -38}, {-24, -48}, {-28, -56}, {-34, -64}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-2, -38}, {2, -46}, {8, -56}, {14, -64}}, color = {0, 0, 0}, thickness = 0.5)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{200, 162}, {380, 312}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{200, 312}, {220, 332}, {400, 332}, {380, 312}, {200, 312}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{400, 332}, {400, 182}, {380, 162}, {380, 312}, {400, 332}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{210, 302}, {370, 272}}, lineColor = {160, 160, 164}, textString = "Library"), Line(points = {{266, 224}, {312, 224}}, color = {0, 0, 0}, thickness = 1), Line(points = {{280, 224}, {276, 214}, {272, 206}, {266, 198}}, color = {0, 0, 0}, thickness = 1), Line(points = {{298, 224}, {302, 216}, {308, 206}, {314, 198}}, color = {0, 0, 0}, thickness = 1), Text(extent = {{152, 412}, {458, 334}}, lineColor = {255, 0, 0}, textString = "Modelica.Constants")}));
  end Constants;

  package Icons 
    partial package Library 
       annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{-100, -100}, {80, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{-100, 50}, {-80, 70}, {100, 70}, {80, 50}, {-100, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{100, 70}, {100, -80}, {80, -100}, {80, 50}, {100, 70}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-85, 35}, {65, -85}}, lineColor = {0, 0, 255}, textString = "Library"), Text(extent = {{-120, 122}, {120, 73}}, lineColor = {255, 0, 0}, textString = "%name")}), Documentation(info = "<html>
        <p>
        This icon is designed for a <b>library</b>.
        </p>
        </html>"));
    end Library;

    partial package Library2 
       annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(extent = {{-100, -100}, {80, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{-100, 50}, {-80, 70}, {100, 70}, {80, 50}, {-100, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{100, 70}, {100, -80}, {80, -100}, {80, 50}, {100, 70}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-120, 125}, {120, 70}}, lineColor = {255, 0, 0}, textString = "%name"), Text(extent = {{-90, 40}, {70, 10}}, lineColor = {160, 160, 164}, textString = "Library")}), Documentation(info = "<html>
        <p>
        This icon is designed for a <b>package</b> where a package
        specific graphic is additionally included in the icon.
        </p>
        </html>"));
    end Library2;
     annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {80, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{-100, 50}, {-80, 70}, {100, 70}, {80, 50}, {-100, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{100, 70}, {100, -80}, {80, -100}, {80, 50}, {100, 70}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-120, 135}, {120, 70}}, lineColor = {255, 0, 0}, textString = "%name"), Text(extent = {{-90, 40}, {70, 10}}, lineColor = {160, 160, 164}, textString = "Library"), Rectangle(extent = {{-100, -100}, {80, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{-100, 50}, {-80, 70}, {100, 70}, {80, 50}, {-100, 50}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{100, 70}, {100, -80}, {80, -100}, {80, 50}, {100, 70}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{-90, 40}, {70, 10}}, lineColor = {160, 160, 164}, textString = "Library"), Polygon(points = {{-64, -20}, {-50, -4}, {50, -4}, {36, -20}, {-64, -20}, {-64, -20}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-64, -20}, {36, -84}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-60, -24}, {32, -38}}, lineColor = {128, 128, 128}, textString = "Library"), Polygon(points = {{50, -4}, {50, -70}, {36, -84}, {36, -20}, {50, -4}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
      <p>
      This package contains definitions for the graphical layout of
      components which may be used in different libraries.
      The icons can be utilized by inheriting them in the desired class
      using \"extends\" or by directly copying the \"icon\" layer.
      </p>

      <dl>
      <dt><b>Main Author:</b>
      <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
          Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
          Oberpfaffenhofen<br>
          Postfach 1116<br>
          D-82230 Wessling<br>
          email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
      </dl>

      <p>
      Copyright &copy; 1998-2009, Modelica Association and DLR.
      </p>
      <p>
      <i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
      under the terms of the <b>Modelica license</b>, see the license conditions
      and the accompanying <b>disclaimer</b>
      <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
      </p><br>
      </HTML>
      ", revisions = "<html>
      <ul>
      <li><i>October 21, 2002</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
             Added new icons <b>Function</b>, <b>Enumerations</b> and <b>Record</b>.</li>
      <li><i>June 6, 2000</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Replaced <b>model</b> keyword by <b>package</b> if the main
             usage is for inheriting from a package.<br>
             New icons <b>GearIcon</b> and <b>MotorIcon</b>.</li>
      <li><i>Sept. 18, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Renaming package Icon to Icons.
             Model Advanced removed (icon not accepted on the Modelica meeting).
             New model Library2, which is the Library icon with enough place
             to add library specific elements in the icon. Icon also used in diagram
             level for models Info, TranslationalSensor, RotationalSensor.</li>
      <li><i>July 15, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Model Caution renamed to Advanced, model Sensor renamed to
             TranslationalSensor, new model RotationalSensor.</li>
      <li><i>June 30, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Realized a first version.</li>
      </ul>
      <br>
      </html>"));
  end Icons;

  package SIunits 
    extends Modelica.Icons.Library2;

    package Conversions 
      extends Modelica.Icons.Library2;

      package NonSIunits 
        extends Modelica.Icons.Library2;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(__Dymola_absoluteValue = true);
        type Angle_deg = Real(final quantity = "Angle", final unit = "deg") "Angle in degree";
         annotation(Documentation(info = "<HTML>
          <p>
          This package provides predefined types, such as <b>Angle_deg</b> (angle in
          degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
          minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
          which are in common use but are not part of the international standard on
          units according to ISO 31-1992 \"General principles concerning quantities,
          units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
          the use of their multiples and of certain other units\".</p>
          <p>If possible, the types in this package should not be used. Use instead
          types of package Modelica.SIunits. For more information on units, see also
          the book of Francois Cardarelli <b>Scientific Unit Conversion - A
          Practical Guide to Metrication</b> (Springer 1997).</p>
          <p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
          Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
          definitions have been placed erroneously in Modelica.SIunits although they
          are not SIunits. For backward compatibility, these type definitions are
          still kept in Modelica.SIunits.</p>
          </HTML>
          "), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-66, -13}, {52, -67}}, lineColor = {0, 0, 0}, textString = "[km/h]")}));
      end NonSIunits;

      function to_deg 
        extends ConversionIcon;
        input Angle radian "radian value";
        output NonSIunits.Angle_deg degree "degree value";
         annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-20, 100}, {-100, 20}}, lineColor = {0, 0, 0}, textString = "rad"), Text(extent = {{100, -20}, {20, -100}}, lineColor = {0, 0, 0}, textString = "deg")}));
      algorithm
        degree := 180.0 / Modelica.Constants.pi * radian;
      end to_deg;

      partial function ConversionIcon 
         annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-90, 0}, {30, 0}}, color = {191, 0, 0}), Polygon(points = {{90, 0}, {30, 20}, {30, -20}, {90, 0}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid), Text(extent = {{-115, 155}, {115, 105}}, textString = "%name", lineColor = {0, 0, 255})}));
      end ConversionIcon;
       annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-33, -7}, {-92, -67}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "°C"), Text(extent = {{82, -7}, {22, -67}}, lineColor = {0, 0, 0}, textString = "K"), Line(points = {{-26, -36}, {6, -36}}, color = {0, 0, 0}), Polygon(points = {{6, -28}, {6, -45}, {26, -37}, {6, -28}}, pattern = LinePattern.None, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255})}), Documentation(info = "<HTML>
        <p>This package provides conversion functions from the non SI Units
        defined in package Modelica.SIunits.Conversions.NonSIunits to the
        corresponding SI Units defined in package Modelica.SIunits and vice
        versa. It is recommended to use these functions in the following
        way (note, that all functions have one Real input and one Real output
        argument):</p>
        <pre>
          <b>import</b> SI = Modelica.SIunits;
          <b>import</b> Modelica.SIunits.Conversions.*;
             ...
          <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
          <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
          <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                              // to radian per seconds
        </pre>

        </HTML>
        "));
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Length = Real(final quantity = "Length", final unit = "m");
    type Position = Length;
    type Area = Real(final quantity = "Area", final unit = "m2");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.000001, max = 30000.0);
    type Momentum = Real(final quantity = "Momentum", final unit = "kg.m/s");
    type AngularMomentum = Real(final quantity = "AngularMomentum", final unit = "kg.m2/s");
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Force = Real(final quantity = "Force", final unit = "N");
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", min = -1000000000.0, max = 1000000000.0, nominal = 100000.0, start = 100000.0, displayUnit = "bar");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
     annotation(Invisible = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-63, -13}, {45, -67}}, lineColor = {0, 0, 0}, textString = "[kg.m2]")}), Documentation(info = "<html>
      <p>This package provides predefined types, such as <i>Mass</i>,
      <i>Angle</i>, <i>Time</i>, based on the international standard
      on units, e.g.,
      </p>

      <pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                           <b>final</b> unit     = \"rad\",
                           displayUnit    = \"deg\");
      </pre>

      <p>
      as well as conversion functions from non SI-units to SI-units
      and vice versa in subpackage
      <a href=\"Modelica://Modelica.SIunits.Conversions\">Conversions</a>.
      </p>

      <p>
      For an introduction how units are used in the Modelica standard library
      with package SIunits, have a look at:
      <a href=\"Modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
      </p>

      <p>
      Copyright &copy; 1998-2009, Modelica Association and DLR.
      </p>
      <p>
      <i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
      under the terms of the <b>Modelica license</b>, see the license conditions
      and the accompanying <b>disclaimer</b>
      <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
      </p>

      </html>", revisions = "<html>
      <ul>
      <li><i>Dec. 14, 2005</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Add User's Guide and removed \"min\" values for Resistance and Conductance.</li>
      <li><i>October 21, 2002</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
             Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
      <li><i>June 6, 2000</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Introduced the following new types<br>
             type Temperature = ThermodynamicTemperature;<br>
             types DerDensityByEnthalpy, DerDensityByPressure,
             DerDensityByTemperature, DerEnthalpyByPressure,
             DerEnergyByDensity, DerEnergyByPressure<br>
             Attribute \"final\" removed from min and max values
             in order that these values can still be changed to narrow
             the allowed range of values.<br>
             Quantity=\"Stress\" removed from type \"Stress\", in order
             that a type \"Stress\" can be connected to a type \"Pressure\".</li>
      <li><i>Oct. 27, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             New types due to electrical library: Transconductance, InversePotential,
             Damping.</li>
      <li><i>Sept. 18, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Renamed from SIunit to SIunits. Subpackages expanded, i.e., the
             SIunits package, does no longer contain subpackages.</li>
      <li><i>Aug 12, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Type \"Pressure\" renamed to \"AbsolutePressure\" and introduced a new
             type \"Pressure\" which does not contain a minimum of zero in order
             to allow convenient handling of relative pressure. Redefined
             BulkModulus as an alias to AbsolutePressure instead of Stress, since
             needed in hydraulics.</li>
      <li><i>June 29, 1999</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
             Bug-fix: Double definition of \"Compressibility\" removed
             and appropriate \"extends Heat\" clause introduced in
             package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
      <li><i>April 8, 1998</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and Astrid Jaschinski:<br>
             Complete ISO 31 chapters realized.</li>
      <li><i>Nov. 15, 1997</i>
             by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
             and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br>
             Some chapters realized.</li>
      </ul>
      </html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{169, 86}, {349, 236}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{169, 236}, {189, 256}, {369, 256}, {349, 236}, {169, 236}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Polygon(points = {{369, 256}, {369, 106}, {349, 86}, {349, 236}, {369, 256}}, fillColor = {235, 235, 235}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 255}), Text(extent = {{179, 226}, {339, 196}}, lineColor = {160, 160, 164}, textString = "Library"), Text(extent = {{206, 173}, {314, 119}}, lineColor = {0, 0, 0}, textString = "[kg.m2]"), Text(extent = {{163, 320}, {406, 264}}, lineColor = {255, 0, 0}, textString = "Modelica.SIunits")}));
  end SIunits;
   annotation(preferredView = "info", version = "3.1", versionBuild = 9, versionDate = "2009-08-14", uses(ModelicaServices(version = "1.0")), dateModified = "2012-03-06 21:00:00Z", revisionId = "$Id:: package.mo 4972 2012-03-06 19:49:17Z #$", conversion(noneFromVersion = "3.0.1", noneFromVersion = "3.0", from(version = "2.1", script = "Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2", script = "Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.1", script = "Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.2", script = "Scripts/ConvertModelica_from_2.2.2_to_3.0.mos")), __Dymola_classOrder = {"UsersGuide", "Blocks", "StateGraph", "Electrical", "Magnetic", "Mechanics", "Fluid", "Media", "Thermal", "Math", "Utilities", "Constants", "Icons", "SIunits"}, Settings(NewStateSelection = true), Documentation(info = "<HTML>
    <p>
    Package <b>Modelica</b> is a <b>standardized</b> and <b>free</b> package
    that is developed together with the Modelica language from the
    Modelica Association, see
    <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
    It is also called <b>Modelica Standard Library</b>.
    It provides model components in many domains that are based on
    standardized interface definitions. Some typical examples are shown
    in the next figure:
    </p>

    <p>
    <img src=\"../Images/UsersGuide/ModelicaLibraries.png\">
    </p>

    <p>
    For an introduction, have especially a look at:
    </p>
    <ul>
    <li> <a href=\"Modelica://Modelica.UsersGuide.Overview\">Overview</a>
      provides an overview of the Modelica Standard Library
      inside the <a href=\"Modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
    <li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
     summarizes the changes of new versions of this package.</li>
    <li> <a href=\"Modelica://Modelica.UsersGuide.Contact\">Contact</a>
      lists the contributors of the Modelica Standard Library.</li>
    <li> The <b>Examples</b> packages in the various libraries, demonstrate
      how to use the components of the corresponding sublibrary.</li>
    </ul>

    <p>
    This version of the Modelica Standard Library consists of
    </p>
    <ul>
    <li> <b>922</b> models and blocks, and</li>
    <li> <b>615</b> functions
    </ul>
    <p>
    that are directly usable (= number of public, non-partial classes).
    </p>


    <p>
    <b>Licensed by the Modelica Association under the Modelica License 2</b><br>
    Copyright &copy; 1998-2009, ABB, arsenal research, T.&nbsp;B&ouml;drich, DLR, Dynasim, Fraunhofer, Modelon,
    TU Hamburg-Harburg, Politecnico di Milano.
    </p>

    <p>
    <i>This Modelica package is <u>free</u> software and
    the use is completely at <u>your own risk</u>;
    it can be redistributed and/or modified under the terms of the
    Modelica license 2, see the license conditions (including the
    disclaimer of warranty)
    <a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a></u>
    or at
    <a href=\"http://www.Modelica.org/licenses/ModelicaLicense2\">
    http://www.Modelica.org/licenses/ModelicaLicense2</a>.
    </p>

    </HTML>
    "));
end Modelica;

model AerosondeModel 
  extends OpenFDM.Aircraft.Aerosonde.Aircraft;
end AerosondeModel;
