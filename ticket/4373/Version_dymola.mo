within ;
package Version_dymola

  package Experiment

    model Experiment_1
      // Experiment: a simulation package in Modelica , to simulate the  simple model.
      Version_dymola.Vehicles.vehicle vehicle;
      constant Real pi = Modelica.Constants.pi;
      Real swdamp = (110 * pi) / 180 "amplitude of the swd manouvre";
      output Real acc_vx;
      output Real vx_kph;
    equation
      vehicle.Aped = if time < 5 then 0 else if time <15 then 90 else 0;
      vehicle.Bped = if time < 15 then 0 else if time < 20 then 50 else 0;
      vehicle.trans.r_gear = if time<5 then 0 elseif time< 20 then 0 else 0;
      vehicle.chassis.theta = 0;
      acc_vx = der(vehicle.vx);
      vx_kph = vehicle.vx*18/5;
      vehicle.chassis.swa = 0.0;
      annotation (experiment(StartTime=0, StopTime=50,fixedstepsize=0.0005,
          Algorithm="Dassl"),Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Experiment_1;

  end Experiment;

  package Vehicles

    model vehicle
      // FH16 simple model
      // Modelica file where all the forces from all the model components are connected
      // This file can be translated as a fmu to Simulink to conduct simulations.
      Version_dymola.Driveline.transmission_modular trans(m=chassis.m, st_agear
          =st_agear);
      Version_dymola.body_and_wheel.chassis chassis;
      Version_dymola.body_and_wheel.wheel wheel1(m=chassis.m_f);
      Version_dymola.body_and_wheel.wheel wheel2(m=chassis.m_r);
      Version_dymola.body_and_wheel.brakes brake;

      input Real Aped;
      input Real Bped;
      input Real swa;
      input Real theta;
      input Real r_gear;

      parameter Integer st_agear= 6;
      output Real vx;
      output Real Fxr;
      output Real x;
      output Real y;
      output Real ax;
      output Real Fyf;
      output Real delta;
      output Real decl;
      output Integer agear;
      output Real ay;
      output Real yaw_velocity;
      output Real Tbw;
    equation
      //Forces
      wheel1.Fxv = chassis.Fxf;
      wheel2.Fxv = chassis.Fxr;
      wheel1.Fyv = chassis.Fyf;
      wheel2.Fyv = chassis.Fyr;
      wheel1.Fz = chassis.Fzf;
      wheel2.Fz = chassis.Fzr;

      //Velocity
      wheel1.Vx = chassis.vx;
      wheel2.Vx = chassis.vx;
      wheel1.Vy = chassis.vy + chassis.yaw_velocity*chassis.a;
      wheel2.Vy = chassis.vy - chassis.yaw_velocity*chassis.b;

      wheel1.delta = chassis.delta;
      wheel2.delta = 0;

      wheel1.Brake_torque = brake.Tbw;
      wheel2.Brake_torque = brake.Tbw;

      chassis.womega = (wheel1.omega + wheel2.omega)/2;

      // powertrain
      r_gear = trans.r_gear;
      wheel1.Drive_torque = trans.M_wheel_1;
      wheel2.Drive_torque = trans.M_wheel_2;//if r_gear == 1 then trans.rev_torque else trans.M_wheel_2;
      chassis.vx = trans.Vx;
      wheel1.omega = trans.w_wheel_1;
      wheel2.omega = trans.w_wheel_2;

      trans.Je = chassis.Je;
      trans.Fx = chassis.Fx;

      //
      Bped = brake.brakeped;
      Tbw = brake.Tbw;
      trans.Aped = Aped;
      swa= chassis.swa;
      theta = chassis.theta;
      Fxr = wheel2.Fxv;
      Fyf = wheel1.Fyv;
      delta = chassis.delta;
      decl = chassis.decl;
      x = chassis.x;
      y = chassis.y;
      vx = chassis.vx;
      ax = chassis.ax;
      agear = trans.agear;
      ay = chassis.ay;
      yaw_velocity = chassis.yaw_velocity;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end vehicle;

  end Vehicles;

  package body_and_wheel

    model wheel
      // FH16 simple model
      // Wheel or tire component : Modelica file this file contains the tire model...
      // wheel dynamics equation
      constant Real g=Modelica.Constants.g_n;
      import SI = Modelica.SIunits;
      constant Real pi = Modelica.Constants.pi;
      parameter Real rw = 0.5 "Radius of wheel";
      parameter Real c=20;
      parameter Real mu=0.9;
      parameter Real vx0= 1;
      parameter Real I_tyre = 11;
      parameter Real m;
      parameter Real f_r=0.0164 "Rolling resistance coefficient";
      SI.Velocity Vx(start = vx0) "Chassis long velocity";
      SI.Velocity Vy(start = 0.0) "Chassis lat velocity";
      SI.Velocity vx "wheel lon velocity";
      SI.Velocity vy "wheel lat velcoity";
      SI.AngularVelocity omega(start = vx0/rw) "wheel angular velocity";
      SI.Force Fxy "Tire Force combined";
      SI.Angle delta;
      SI.Force Fz;
      SI.Force Fxw;
      SI.Force Fyw;
      SI.Force Fxv;
      SI.Force Fyv;
      SI.Force Fr(start=0.0);
      SI.Torque Drive_torque;
      SI.Torque Brake_torque;
      Real sxy "combined slip";
      Real fsxy "tire coefficient";
      Real sx "longitudinal slip";
      Real sy "Lateral slip";
    equation
      vx = Vx * cos(delta) + Vy * sin(delta);
      vy = (-Vx * sin(delta)) + Vy * cos(delta);
      sx = -(vx - omega * rw) / max(abs(omega * rw), 0.01);
      sy = -vy / max(abs(omega * rw),0.01);
      sxy = sqrt((sx^2)+(sy^2));
      fsxy = 2 / pi * atan(c * (2 / pi) * sxy);
      Fxy =  mu * Fz * fsxy;
      Fxw = (rw*omega - vx)*Fxy/max((sqrt((rw*omega - vx)^2 + vy^2)),0.01);
      Fyw = -vy*Fxy/max((sqrt((rw*omega - vx)^2 + vy^2)),0.01);
      (I_tyre) * der(omega) = Drive_torque - tanh(10 * omega) * tanh(0.5 * abs(vx)) * Brake_torque - Fxw * rw - Fr;
      Fr = f_r*m*g*min(1, vx);
      Fxv = cos(delta)*Fxw - sin(delta)*Fyw;
      Fyv = sin(delta)*Fxw +cos(delta)*Fyw;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end wheel;

    model brakes
      // FH16 simple model
      // Modelica file for brakes subsystem
      Real brakeped;
      Real Tbw;
      Real Tbwact;
      parameter Real b_delay = 0.95;
      parameter Real Tbmax=25000;
    equation
      Tbwact = brakeped*Tbmax*0.01;
      der(Tbw) = b_delay*(Tbwact - Tbw);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end brakes;

    model chassis
      // FH16 simple model
      // Modelica file for the chassis or vehicle body as called in the report....
      // Contains all force and moment balance equations about the centre of gravity
      constant Real g=Modelica.Constants.g_n;
      parameter Real m=9840;
      //mass of the vehicle[kg]
      parameter Real a=1.68;
      //distance from CG to front axel [m]
      parameter Real b=1.715;
      //distance from CG to rear axel [m]
      parameter Real Izz=41340; //20490-used 1st,33795-2nd,(ay 3.2(1st),2.9(2nd),2.7(current) (2.4 with updated wheelbase))
      // Mass moment of inertia [kgm^2]
      parameter Real i_s=16;
      // steering ratio
      parameter Real Iw=1;
      // Wheel Inertia[kgm^2]
      parameter Real rw=0.5;
      //Wheel radius [m]
      parameter Real Tb=25000;
      //Braking torque[Nm]
      parameter Real m_f=m*(b/(a + b));
      parameter Real m_r=m*(a/(a + b));
      parameter Real Fzf=m*g*(b/(a + b));
      // Front vertical load
      parameter Real Fzr=m*g*(a/(a + b));
      //Rear vertical load
      parameter Real vx0=1;
      //initial longitudinal velocity [m/s]
      parameter Real Fxmax=3000000;
      parameter Real Pmax=29000;
      parameter Real rho=1.225 "air density";
      parameter Real Cd=0.7;
      parameter Real ac=10;
      parameter Real cx = 20;
      parameter Real mu= 0.9;
      parameter Real ratio=3.0;
      parameter Real Je=4  "Engine inertia";
      Real vy(start=0.0) "Vehicle Lateral Velocity [m/sec]";
      Real yaw_angle(start=0);
      Real yaw_velocity(start=0);
      Real ay;
      Real Fx;
      Real Fxf;
      Real Fyr;
      Real Fxr;
      Real Fd(start=0.0);
      Real Fg; //force due to gradient
      Real delta;
      Real womega;
      Real swa "Steering angle [rad]";
      Real theta;//road gradient
      output Real vx(start=vx0) "Vehicle longitudinal velocity";
      output Real x(start=0);
      output Real y(start=0);
      output Real ax;
      output Real Fyf;
      output Real decl(start=0);

    equation
      // Longitudinal Dynamics ---------------
      Fx = Fxf + Fxr + Fd +Fg*tanh(10 * abs(womega)) * tanh(0.5 * abs(vx));
      (m)*ax = (Fx);
      Fd = -sign(vx)*0.5*rho*Cd*ac*vx^2;
      Fg = -m*g*sin(theta);
      // Lateral Dynamics -------------------
      Izz*der(yaw_velocity) = (a*Fyf - b*Fyr);
      m*(ay) = (Fyf + Fyr);
      der(yaw_angle) = yaw_velocity;
      ay = der(vy) + vx*yaw_velocity;
      ax = der(vx) - vy*yaw_velocity;
      der(x) = vx*cos(yaw_angle) - vy*sin(yaw_angle);
      der(y) = vy*cos(yaw_angle) + vx*sin(yaw_angle);
      decl = if ax > 0 then 0 else ax;
      delta = swa/i_s;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end chassis;

  end body_and_wheel;

  package Driveline

    model engine_modular
      // FH16 simple model
      // Modelica file for engine model
      import SI = Modelica.SIunits;
      constant Real pi = Modelica.Constants.pi;
      parameter  SI.Mass m;
      //Engine coefficients
      parameter SI.AngularVelocity w_eng_max = 2000*pi/30
        "maximum engine rotation";
      parameter SI.AngularVelocity w_eng_idl = 600*pi/30 " engine idle speed";
      parameter SI.Acceleration axh = 0.8 "Upper acceleration limit";
      parameter SI.Acceleration axl = 0.6 "Lower acceleration limit";
      parameter Real E_factor = 1;
      parameter SI.Torque Tsplit = 700;
      parameter Real k = 0.5 "Boost pressure coefficient";

      Real perc_throttle;
      Real Aped "Accelerator pedal position [%]";
      SI.Velocity Vx "velocity of the vehicle m/s";
      SI.Torque T_req_raw(start = 0) "engine torque";
      SI.Torque Te;
      SI.Torque max_torque;
      SI.Torque T_alim;
      SI.Torque Tbase;
      SI.Torque Tdynreq;
      SI.Torque T_new_req;
      SI.Torque T_req_alim;
      SI.Torque Ttop;
      SI.Torque T_e;
      SI.Force Fx "Force to compute ax";
      SI.AngularVelocity w_engine(start = w_eng_idl) "engine speed in rad/s";
      SI.AngularVelocity rpm_engine "engine speed in rpm";
      Modelica.Blocks.Tables.CombiTable1Ds tab_torque(table = [0,0;
                                                                 62.8318,1660;
                                                                 73.3038,1880;
                                                                 83.775,2240;
                                                                 94.247,2900;
                                                                 104.719,3550;
                                                                 115.191,3550;
                                                                 125.663,3550;
                                                                 136.135,3550;
                                                                 146.607,3550;
                                                                 157.079,3470;
                                                                 167.551,3310;
                                                                 178.023,3120;
                                                                 188.495,2880;
                                                                 198.967,2660;
                                                                 209.439,1680;
                                                                 219.911,0],smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments);
    equation
      rpm_engine = w_engine * 30 / pi;
      tab_torque.u = w_engine;
      tab_torque.y[1] = max_torque;

      T_alim = if der((Vx)) > axh then E_factor*T_req_raw else if der((Vx)) < axl then T_req_raw else T_req_raw*( (((der((Vx))-axl)*(E_factor-1))/(axh-axl)) + 1);
      perc_throttle = max(min(Aped/100, 1), 0.0);
      T_req_raw = (perc_throttle)*(max_torque);

      der(T_new_req)  = 1*(T_req_raw -T_new_req);
      T_req_alim = min(T_new_req,T_alim);
      Tbase = min(T_req_alim,Tsplit);
      Tdynreq = T_req_alim - Tbase;
      der(Ttop) = k*(Tdynreq - Ttop);
      T_e = Tbase + Ttop;
      Te = noEvent(if Vx < 0 then max(0, T_e) else T_e);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end engine_modular;

    model transmission_modular
      extends Version_dymola.Driveline.engine_modular;
      import SI = Modelica.SIunits;
      constant Real pi = Modelica.Constants.pi;
       // transmission parameters
      parameter Real i_tm[12] = {11.73, 9.20, 7.09, 5.57, 4.35, 3.41, 2.70, 2.12, 1.63,1.28, 1.00, 0.79};
      parameter Real i_final = 3.61 "gear ratio final gear";
      parameter Real eff_tr = 0.90 "transmission efficiency";

      parameter Real upshift[12] = {2.31,3,3.81,4.05,4.25,5.25,8.25,11.25,13.45,15.78,21.1,1000000};
      parameter Real downshift[12] = {-1000000,2.2,2.28,3.5,3.9,4.1,4.77,5.1,6.5,8.5, 14.5,20};
      parameter SI.Torque max_drive_torque = 12e5;
      parameter Real dds=5 "damping factor for drive shaft flexibility ";
      parameter Integer st_agear;
      parameter Real td = 2;
      Integer agear(start = st_agear) " the automatic gear";
      Real i_T(start = 12.31) "total transmission ratio";
      Real r_gear;
      Real Je;
      SI.Torque Tc;
      SI.Torque Tt;
      SI.Torque Tp;
      SI.Torque Tf;
      SI.Torque Td;
      SI.Torque Tw;
      SI.AngularVelocity w_c(start = 2);
      SI.AngularVelocity w_t(start = 2);
      SI.AngularVelocity w_p(start = 2);
      SI.AngularVelocity w_f(start = 2);
      SI.AngularVelocity w_w(start = 2);
      SI.Torque M_wheel_1;
      SI.Torque M_wheel_2;
      SI.AngularVelocity w_wheel_1;
      SI.AngularVelocity w_wheel_2;
      SI.AngularVelocity w_mean_wheels;
      SI.Torque rev_torque;
      output Real r_c;
    equation

      i_T = i_final * i_tm[agear];
          when Vx > upshift[pre(agear)] then
            agear = pre(agear)+1;
          elsewhen Vx < downshift[pre(agear)] then
            agear = pre(agear)-1;
          end when;
      Je*der(w_engine) = Te- Tc; // Torque balance according to Newtons law
      w_engine = w_c;//min(w_eng_max,max(w_c,w_eng_idl));

      Tc = Tt;

      w_c = w_t;
      Tp = Tt*i_tm[agear];

      w_t/i_tm[agear] = w_p;

      Tp = Tf;

      w_p = w_f;
      eff_tr*Tf*i_final = Td;

      Td = Tw;

      w_f/i_final = w_w;

      w_w = w_mean_wheels;
      w_mean_wheels = (w_wheel_1+w_wheel_2)/2;
      rev_torque = -1250;//-1*r_c*max(Tt,0)*i_tm[6]*i_final;
      r_c = if r_gear > 0 then 1 else 0;
      M_wheel_2 = max(Tw,0);
      M_wheel_1 = 0;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end transmission_modular;

  end Driveline;
  annotation (uses(Modelica(version="3.2.2")));
end Version_dymola;
