package Control

        package Functions
        
                function AccelRamp
                         input Real acc1;
                         input Real acc2;
                         input Real pv_acc;
                         input Real vel;
                         input Real t;
                         output Real y;
                protected
                         Real tAcc1;
                         Real tAcc2;
                algorithm
                         tAcc1 := vel*pv_acc/acc1;
                         tAcc2 := vel*(1-pv_acc)/acc2;
                         y := if t <= tAcc1 then t*acc1
                              else if t <= tAcc1+tAcc2 then (tAcc1*acc1)+(t-tAcc1)*acc2
                              else vel;
                end AccelRamp;

                function DecelRamp
                         input Real dec1;
                         input Real dec2;
                         input Real pv_dec;
                         input Real vel;
                         input Real t;
                         output Real y;
                protected
                         Real tDec1;
                         Real tDec2;
                algorithm
                         tDec1 := vel*(1-pv_dec)/dec1;
                         tDec2 := vel*pv_dec/dec2;
                         y := if t <= tDec2 then -t*dec2
                              else if t <= tDec1+tDec2 then -((tDec2*dec2)+(t-tDec2)*dec1)
                              else vel;
                end DecelRamp;

                function CalcDiscreteTrapezium // Doesn't work on OpenModelica!!!
                         input Real acc1;
                         input Real acc2;
                         input Real dec1;
                         input Real dec2;
                         input Real pv_acc;
                         input Real pv_dec;
                         input Real adv;
                         input Real vel;
                         input Real period;
                         output Real[3] data;
                protected
                         Real accCount;
                         Real decCount;
                         Real remaining;
                         Real tAcc1;
                         Real tAcc2;
                         Real tDec1;
                         Real tDec2;
                         Real accVal;
                         Real decVal;
                         Real nextVal;
                algorithm
                         accCount := 0;
                         decCount := 0;
                         remaining := adv;
                         tAcc1 := vel*pv_acc/acc1;
                         tAcc2 := vel*(1-pv_acc)/acc2;
                         tDec1 := vel*(1-pv_dec)/dec1;
                         tDec2 := vel*pv_dec/dec2;
                         accVal := 0;
                         decVal := if (decCount+1)*period <= tDec2 then (decCount+1)*period*dec2
                                   else if (decCount+1)*period <= tDec2+tDec1 then (vel*pv_dec)+((decCount+1)*period-tDec2)*dec1
                                   else vel;
                         nextVal := if accVal <= decVal then accVal else decVal;
                         while remaining >= nextVal*period loop
                               if accVal <= decVal then
                                  accCount := accCount+1;
                                  remaining := remaining-(accVal*period);
                                  accVal := if accCount*period <= tAcc1 then accCount*period*acc1
                                            else if accCount*period <= tAcc1+tAcc2 then (vel*pv_acc)+((accCount*period)-tAcc1)*acc2
                                            else vel;
                               else
                                   decCount := decCount+1;
                                   remaining := remaining-(decVal*period);
                                   decVal := if (decCount+1)*period <= tDec2 then (decCount+1)*period*dec2
                                             else if (decCount+1)*period <= tDec2+tDec1 then (vel*pv_dec)+((decCount+1)*period-tDec2)*dec1
                                             else vel;
                                   //decVal := decVal+1;
                               end if;
                               nextVal := if accVal <= decVal then accVal else decVal;
                         end while;
                         data[1] := accCount;
                         data[2] := decCount;
                         data[3] := remaining;
                end CalcDiscreteTrapezium;

                function CalcTrapezium
                         input Real acc1;
                         input Real acc2;
                         input Real dec1;
                         input Real dec2;
                         input Real pv_acc;
                         input Real pv_dec;
                         input Real adv;
                         input Real vel;
                         output Real data[6];
                protected
                         Real tAcc1;
                         Real tAcc2;
                         Real tSlew;
                         Real tDec1;
                         Real tDec2;
                         Real v;
                         Real v1;
                         Real v2;
                         Real aAcc1;
                         Real aAcc2;
                         Real aDec1;
                         Real aDec2;
                algorithm
                         v1 := vel*pv_acc;
                         v2 := vel*pv_dec;
                         tAcc1 := v1/acc1;
                         tAcc2 := (vel-v1)/acc2;
                         tDec1 := (vel-v2)/dec1;
                         tDec2 := v2/dec2;
                         aAcc1 := tAcc1*v1/2;
                         aAcc2 := tAcc2*(v1+vel)/2;
                         aDec1 := tDec1*(v2+vel)/2;
                         aDec2 := tDec2*v2/2;
                         if adv >= aAcc1+aAcc2+aDec1+aDec2 then
                              v := vel;
                              tSlew := (adv-(aAcc1+aAcc2+aDec1+aDec2))/vel;
                         elseif pv_acc <= pv_dec then
                              if adv <= aAcc1+(aDec2*(pv_acc^2)/(pv_dec^2)) then
                                   v := (adv*acc1*dec2*2/(acc1+dec2))^0.5;
                                   tAcc1 := v/acc1;
                                   tDec2 := v/dec2;
                                   tAcc2 := 0;
                                   tSlew := 0;
                                   tDec1 := 0;
                              elseif adv <= aAcc1+aDec2+(aAcc2*((v2^2-v1^2)/(vel^2-v1^2))) then
                                   v := ((adv-aAcc1+((v1^2)/(2*acc2)))*(2*acc2*dec2/(acc2+dec2)))^0.5;
                                   tAcc2 := (v-v1)/acc2;
                                   tDec2 := v/dec2;
                                   tSlew := 0;
                                   tDec1 := 0;
                              else
                                   v := ((adv-aAcc1-aDec2+((v1^2)/(2*acc2))+((v2^2)/(2*dec1)))*(2*acc2*dec1/(acc2+dec1)))^0.5;
                                   tAcc2 := (v-v1)/acc2;
                                   tDec1 := (v-v2)/dec1;
                                   tSlew := 0;
                              end if;
                         else
                              if adv <= aDec2+(aAcc1*(pv_dec^2)/(pv_acc^2)) then
                                   v := (adv*acc1*dec2*2/(acc1+dec2))^0.5;
                                   tAcc1 := v/acc1;
                                   tDec2 := v/dec2;
                                   tAcc2 := 0;
                                   tSlew := 0;
                                   tDec1 := 0;
                              elseif adv <= aAcc1+aDec2+(aDec1*((v1^2-v2^2)/(vel^2-v2^2))) then
                                   v := ((adv-aDec2+((v2^2)/(2*dec1)))*(2*dec1*acc1/(dec1+acc1)))^0.5;
                                   tAcc1 := v/acc1;
                                   tDec1 := (v-v2)/dec1;
                                   tAcc2 := 0;
                                   tSlew := 0;
                              else
                                   v := ((adv-aAcc1-aDec2+((v1^2)/(2*acc2))+((v2^2)/(2*dec1)))*(2*acc2*dec1/(acc2+dec1)))^0.5;
                                   tAcc2 := (v-v1)/acc2;
                                   tDec1 := (v-v2)/dec1;
                                   tSlew := 0;
                              end if;
                         end if;
                         data[1] := tAcc1;
                         data[2] := tAcc2;
                         data[3] := tSlew;
                         data[4] := tDec1;
                         data[5] := tDec2;
                         data[6] := v;
                end CalcTrapezium;

        end Functions;

        package Power
        
                model PWMGenerator
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Electrical.Analog.Interfaces.Pin p,n;
                      parameter Real gain=1;
                equation
                        p.v - n.v = u*gain;
                        p.i + n.i = 0;
                end PWMGenerator;
        
                model PWMSaturation
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Electrical.Analog.Interfaces.Pin p,n;
                      parameter Real gain=1;
                      parameter Real saturation=42;
                equation
                        p.v - n.v = if u*gain>saturation then saturation
                                    else if u*gain<(-saturation) then -saturation
                                    else u*gain;
                        p.i + n.i = 0;
                end PWMSaturation;
        
        end Power;

        package Servos
        
                model Servo //Obsolete
                      // PID parameters
                      parameter Real KP = 1800;
                      parameter Real KD = 6000;
                      // Motor parameters
                      parameter Real MotorJ = 0.0001;
                      parameter Real MotorTorqueK = 0.078;
                      parameter Real MotorResistance = 7.1;
                      parameter Real MotorInductance = 0.1;
                      // PWM parameters
                      parameter Real PWMGain = 1;
                      parameter Real PWMSaturationValue = 42;
                      // Components
                      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      Controllers.PID pid(Kp=KP,Kd=KD);
                      Power.PWMSaturation pwm(gain=PWMGain,saturation=PWMSaturationValue);
                      Modelica.Electrical.Analog.Basic.Ground ground;
                      DCMotor motor(load.J=MotorJ,emf1.k=MotorTorqueK,r1.R=MotorResistance,i1.L=MotorInductance);
                      Modelica.Mechanics.Rotational.Sensors.AngleSensor encoder;
                equation
                        connect(u,comparator.u1);
                        connect(comparator.y,pid.u);
                        connect(pid.y,pwm.u);
                        connect(pwm.p,motor.p);
                        connect(pwm.n,motor.n);
                        connect(motor.n,ground.p);
                        connect(motor.flange_b,encoder.flange_a);
                        connect(encoder.phi,comparator.u2);
                        connect(motor.flange_b,flange_b);
                end Servo;
        
                model ServoWithIdealGear //Obsolete
                      parameter Real KP = 1800, KD = 6000;
                      parameter Real MotorJ = 0.0001, MotorTorqueK = 0.078, MotorResistance = 7.1, MotorInductance = 0.1;
                      parameter Real GearRatio = 40;
                      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      Controllers.PID pid(Kp=KP,Kd=KD);
                      Power.PWMSaturation pwm;
                      Modelica.Electrical.Analog.Basic.Ground ground;
                      DCMotor motor(load.J=MotorJ,emf1.k=MotorTorqueK,r1.R=MotorResistance,i1.L=MotorInductance);
                      Modelica.Mechanics.Rotational.IdealGear gear(ratio=GearRatio);
                      Modelica.Mechanics.Rotational.Sensors.AngleSensor encoder;
                equation
                        connect(u,comparator.u1);
                        connect(comparator.y,pid.u);
                        connect(pid.y,pwm.u);
                        connect(pwm.p,motor.p);
                        connect(pwm.n,motor.n);
                        connect(motor.n,ground.p);
                        connect(motor.flange_b,gear.flange_a);
                        connect(gear.flange_b,encoder.flange_a);
                        connect(encoder.phi,comparator.u2);
                        connect(gear.flange_b,flange_b);
                end ServoWithIdealGear;
        
                model ServoWithGear //Obsolete
                      parameter Real KP = 1800, KD = 6000;
                      parameter Real MotorJ = 0.0001, MotorTorqueK = 0.078, MotorResistance = 7.1, MotorInductance = 0.1;
                      parameter Real GearRatio = 40;
                      parameter Real BacklashAmplitude = 0.01, BacklashDamping = 10;
                      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      Controllers.PID pid(Kp=KP,Kd=KD);
                      Power.PWMSaturation pwm;
                      Modelica.Electrical.Analog.Basic.Ground ground;
                      DCMotor motor(load.J=MotorJ,emf1.k=MotorTorqueK,r1.R=MotorResistance,i1.L=MotorInductance);
                      Modelica.Mechanics.Rotational.IdealGear gear(ratio=GearRatio);
                      Modelica.Mechanics.Rotational.ElastoBacklash backlash(b=BacklashAmplitude,d=BacklashDamping);
                      Modelica.Mechanics.Rotational.Sensors.AngleSensor encoder;
                equation
                        connect(u,comparator.u1);
                        connect(comparator.y,pid.u);
                        connect(pid.y,pwm.u);
                        connect(pwm.p,motor.p);
                        connect(pwm.n,motor.n);
                        connect(motor.n,ground.p);
                        connect(motor.flange_b,gear.flange_a);
                        connect(gear.flange_b,backlash.flange_a);
                        connect(backlash.flange_b,encoder.flange_a);
                        connect(encoder.phi,comparator.u2);
                        connect(backlash.flange_b,flange_b);
                end ServoWithGear;
        
                model DiscreteServoWithGear //Obsolete
                      parameter Real KP = 1800, KD = 6000;
                      parameter Real MotorJ = 0.0001, MotorTorqueK = 0.078, MotorResistance = 7.1, MotorInductance = 0.1;
                      parameter Real GearRatio = 40;
                      parameter Real BacklashAmplitude = 0.01, BacklashDamping = 10;
                      parameter Real SamplerPeriod = 0.0012;
                      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      Controllers.DiscretePID pid(Kp=KP,Kd=KD,samplePeriod = SamplerPeriod);
                      Power.PWMSaturation pwm;
                      Modelica.Electrical.Analog.Basic.Ground ground;
                      DCMotor motor(load.J=MotorJ,emf1.k=MotorTorqueK,r1.R=MotorResistance,i1.L=MotorInductance);
                      Modelica.Mechanics.Rotational.IdealGear gear(ratio=GearRatio);
                      Modelica.Mechanics.Rotational.ElastoBacklash backlash(b=BacklashAmplitude,d=BacklashDamping);
                      Modelica.Mechanics.Rotational.Sensors.AngleSensor encoder;
                equation
                        connect(u,comparator.u1);
                        connect(comparator.y,pid.u);
                        connect(pid.y,pwm.u);
                        connect(pwm.p,motor.p);
                        connect(pwm.n,motor.n);
                        connect(motor.n,ground.p);
                        connect(motor.flange_b,gear.flange_a);
                        connect(gear.flange_b,backlash.flange_a);
                        connect(backlash.flange_b,encoder.flange_a);
                        connect(encoder.phi,comparator.u2);
                        connect(backlash.flange_b,flange_b);
                end DiscreteServoWithGear;
        
                model ServoWithFilter //Obsolete
                      parameter Real KP = 1800, KD = 6000;
                      parameter Real MotorJ = 0.0001, MotorTorqueK = 0.078, MotorResistance = 7.1, MotorInductance = 0.1;
                      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      Controllers.PID pid(Kp=KP,Kd=KD);
                      Utils.LowPassFilter filter;
                      Power.PWMSaturation pwm;
                      Modelica.Electrical.Analog.Basic.Ground ground;
                      DCMotor motor(load.J=MotorJ,emf1.k=MotorTorqueK,r1.R=MotorResistance,i1.L=MotorInductance);
                      Modelica.Mechanics.Rotational.Sensors.AngleSensor encoder;
                equation
                        connect(u,comparator.u1);
                        connect(comparator.y,pid.u);
                        connect(pid.y,filter.u);
                        connect(filter.y,pwm.u);
                        connect(pwm.p,motor.p);
                        connect(pwm.n,motor.n);
                        connect(motor.n,ground.p);
                        connect(motor.flange_b,encoder.flange_a);
                        connect(encoder.phi,comparator.u2);
                        connect(motor.flange_b,flange_b);
                end ServoWithFilter;

        end Servos;

        package Controllers

                block PID
                      extends Modelica.Blocks.Interfaces.SISO;
                      parameter Real Kp=1,Kd=1;
                      Modelica.Blocks.Math.Gain proportional(k=Kp), derivative(k=Kd);
                      Modelica.Blocks.Continuous.Der derivator;
                      Modelica.Blocks.Math.Add sum;
                equation
                        connect(u,derivator.u);
                        connect(u,proportional.u);
                        connect(derivator.y,derivative.u);
                        connect(proportional.y,sum.u1);
                        connect(derivative.y,sum.u2);
                        connect(sum.y,y);
                end PID;

                block DiscretePID //Incomplete
                      extends Modelica.Blocks.Interfaces.DiscreteSISO;
                      parameter Real Kp=1,Kd=1;
                      Real verr;
                equation
                        verr = der(u);
                        when {sampleTrigger,initial()} then
                             y = (Kp*u + Kd*verr)/128;
                        end when;
                end DiscretePID;
                
                model MicroController
                      Modelica.Blocks.Interfaces.RealInput command,position;
                      Modelica.Blocks.Interfaces.RealOutput pwm;
                      Modelica.Blocks.Math.Add comparator(k2=-1);
                      DiscretePID pid;
                equation
                        connect(command,comparator.u1);
                        connect(position,comparator.u2);
                        connect(comparator.y,pid.u);
                        connect(pid.y,pwm);
                end MicroController;

        end Controllers;

        package Utils
        
                model LowPassFilter
                      parameter Real T = 1;
                      Modelica.Blocks.Interfaces.RealInput u;
                      Modelica.Blocks.Interfaces.RealOutput y;
                equation
                        T*der(y) + y = u;
                end LowPassFilter;
        
        end Utils;
        
        package Sources
        
                model BasicSpeedTrapezium //Obsolete
                      import SI = Modelica.SIUnits;
                      extends Modelica.Blocks.Interfaces.SO;
                      parameter Real acc=1,dec=1;
                      parameter SI.Length adv=1;
                      parameter SI.Velocity vel=1;
                      parameter SI.Time startTime=0;
                      SI.Time tAcc,tSlew,tDec;
                equation
                        tAcc = vel/acc;
                        tDec = vel/dec;
                        tSlew = if (tAcc+tDec)*vel/2 >= adv then 0 else (adv - (tAcc+tDec)*vel/2)/vel;
                        y = if time <= startTime then 0
                            else if time <= startTime+tAcc then (time-startTime)*acc
                            else if time <= startTime+tAcc+tSlew then vel
                            else if time <= startTime+tAcc+tSlew+tDec then vel - ((time-startTime)-(tAcc+tSlew))*dec
                            else 0;
                end BasicSpeedTrapezium;

                model SpeedTrapezium
                      extends Modelica.Blocks.Interfaces.SO;
                      parameter Real acc1;
                      parameter Real acc2;
                      parameter Real dec1;
                      parameter Real dec2;
                      parameter Real pv_acc;
                      parameter Real pv_dec;
                      parameter Real adv;
                      parameter Real vel;
                      Real tAcc1;
                      Real tAcc2;
                      Real tSlew;
                      Real tDec1;
                      Real tDec2;
                      Real v;
                      Real[6] dat;
                equation
                        dat = Functions.CalcTrapezium(acc1,acc2,dec1,dec2,pv_acc,pv_dec,adv,vel);
                        tAcc1 = dat[1];
                        tAcc2 = dat[2];
                        tSlew = dat[3];
                        tDec1 = dat[4];
                        tDec2 = dat[5];
                        v = dat[6];
                        y = if time <= 0 then 0
                            elseif time <= tAcc1 then time*acc1
                            elseif time <= tAcc1+tAcc2 then (tAcc1*acc1)+((time-tAcc1)*acc2)
                            elseif time <= tAcc1+tAcc2+tSlew then vel
                            elseif time <= tAcc1+tAcc2+tSlew+tDec1 then v-((time-(tAcc1+tAcc2+tSlew))*dec1)
                            elseif time <= tAcc1+tAcc2+tSlew+tDec1+tDec2 then v-(tDec1*dec1)-((time-(tAcc1+tAcc2+tSlew+tDec1))*dec2)
                            else 0;
                end SpeedTrapezium;
                
                model Discretizer
                      extends Modelica.Blocks.Interfaces.DiscreteSISO;
                equation
                        when {initial(),sampleTrigger} then
                             y = u;
                        end when;
                end Discretizer;

        end Sources;

end Control;

