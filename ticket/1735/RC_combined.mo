package RC_combined
  model RCEngine
    Modelica.Mechanics.Rotational.Sources.Torque torque290
      "ICengine is a torque source; speed is a result of torque...?"                                                      annotation(Placement(transformation(extent = {{28,64},{40,76}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_crank(J = 3e-006, w(fixed = true, start = 500))
      "internal inertia of the engine; initially at 'idle speed'"                                                                                                  annotation(Placement(transformation(extent = {{44,64},{56,76}})));
    Modelica.Mechanics.Rotational.Components.BearingFriction Friction_crank(tau_pos = [500,0.05;1600,0.05])
      "Frictional forces within the IC engine"                                                                                                     annotation(Placement(transformation(extent = {{60,64},{72,76}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{78,60},{98,80}})));
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-120,70},{-88,102}})));
    Modelica.Blocks.Math.Feedback feedback annotation(Placement(transformation(extent={{-62,76},
                                                                                       {-42,96}})));
    Modelica.Blocks.Sources.Constant Scaling(k = 1)
      "Operating range of engine is 500->1600 rad/s, i.e. 1100 rad/s"                                               annotation(Placement(transformation(extent={{-44,64},
                                                                                                                                                                {-34,74}})));
    Modelica.Blocks.Math.Division division annotation(Placement(transformation(extent={{-28,78},
                                                                                       {-18,88}})));
    Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{8,64},{20,76}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0)
      "the input to the torque source must be between zero and the MaxTorque output "
      annotation(Placement(transformation(extent={{-12,78},
                                                  {-2,88}})));
    Modelica.Blocks.Tables.CombiTable1D MaxTorque(table = [500,1.079945386;525,1.142931969;550,1.204256759;575,1.263718168;600,1.321124795;625,1.376295423;650,1.429059019;675,1.479254737;700,1.526731912;725,1.571350068;750,1.612978911;775,1.651498332;800,1.686798407;825,1.718779397;850,1.747351747;875,1.772436089;900,1.793963237;925,1.81187419;950,1.826120133;975,1.836662435;1000,1.843472651;1025,1.846532519;1050,1.845833961;1075,1.841379087;1100,1.833180189;1125,1.821259744;1150,1.805650415;1175,1.78639505;1200,1.763546678;1225,1.737168518;1250,1.70733397;1275,1.67412662;1300,1.637640238;1325,1.597978781;1350,1.555256387;1375,1.509597383;1400,1.461136277;1425,1.410017763;1450,1.356396721;1475,1.300438215;1500,1.242317492;1525,1.182219987;1550,1.120341316;1575,1.056887282;1600,0.992073874])
      "Table giving maximum torque available at various angular velocities within R290's operating range"
      annotation(Placement(visible = true, transformation(origin = {17,47}, extent = {{7,7},{-7,-7}}, rotation = 180)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(Placement(visible = true, transformation(origin = {73,47}, extent = {{7,7},{-7,-7}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput crank_speed
      annotation (Placement(transformation(extent={{80,-20},{100,0}})));
    Modelica.Blocks.Nonlinear.Limiter Idle_Redline(uMax=1600, uMin=500)
      "the reference speed must be in the operating range of the engine"                                  annotation(Placement(transformation(extent={{-80,80},
                                                                                                                                                      {-68,92}})));
  equation
    connect(speedSensor.flange,flange_b) annotation(Line(points = {{66,47},{84,47},{84,70},{88,70}}, color = {0,0,0}, smooth = Smooth.None));
    connect(speedSensor.w,MaxTorque.u[1]) annotation(Line(points={{80.7,47},{8.6,
                                                                             47}},                                                                        color = {0,0,127}, smooth = Smooth.None));
    connect(feedback.y,division.u1) annotation(Line(points={{-43,86},{-29,86}},   color = {0,0,127}, smooth = Smooth.None));
    connect(MaxTorque.y[1],product.u2) annotation(Line(points={{24.7,47},{6.8,47},
                                                               {6.8,66.4}},                                                                         color = {0,0,127}, smooth = Smooth.None));
    connect(division.y,limiter.u) annotation(Line(points={{-17.5,83},{-13,83}},   color = {0,0,127}, smooth = Smooth.None));
    connect(torque290.flange,J_crank.flange_a) annotation(Line(points = {{40,70},{44,70}}, color = {0,0,0}, smooth = Smooth.None));
    connect(J_crank.flange_b,Friction_crank.flange_a) annotation(Line(points = {{56,70},{60,70}}, color = {0,0,0}, smooth = Smooth.None));
    connect(Friction_crank.flange_b,flange_b) annotation(Line(points = {{72,70},{88,70}}, color = {0,0,0}, smooth = Smooth.None));
    connect(product.y,torque290.tau) annotation(Line(points = {{20.6,70},{26.8,70}}, color = {0,0,127}, smooth = Smooth.None));
    connect(feedback.u2,speedSensor.w) annotation(Line(points={{-52,78},{-52,60},
                                                               {80.7,60},{80.7,47}},                                                                        color = {0,0,127}, smooth = Smooth.None));
    connect(Scaling.y,division.u2) annotation(Line(points={{-33.5,69},{-33.5,74.5},
                                                           {-29,74.5},{-29,80}},                                                                          color = {0,0,127}, smooth = Smooth.None));
    connect(crank_speed, speedSensor.w) annotation (Line(
                                                         points={{90,-10},{70,-10},{70,20},{80.7,20},{80.7,47}},
                                                         color={0,0,127},
                                                         smooth=Smooth.None));
    connect(limiter.y, product.u1) annotation (Line(
                                                    points={{-1.5,83},{0,83},{0,73.6},{6.8,73.6}},
                                                    color={0,0,127},
                                                    smooth=Smooth.None));
    connect(u, Idle_Redline.u) annotation (Line(
                                                points={{-104,86},{-81.2,86}},
                                                color={0,0,127},
                                                smooth=Smooth.None));
    connect(Idle_Redline.y, feedback.u1) annotation (Line(
                                                          points={{-67.4,86},{-60,86}},
                                                          color={0,0,127},
                                                          smooth=Smooth.None));
    annotation(uses(Modelica(version = "3.2")), Diagram(graphics),
               Icon(graphics));
  end RCEngine;
  model RC_driveline
    RCEngine rCEngine
      annotation (Placement(transformation(extent={{-74,28},{-54,48}})));
    Modelica.Mechanics.Rotational.Components.Clutch Inertial_Clutch(
                                                                    peak=1.1,
                                                                    mue_pos=[400,0.4; 1800,0.4],
                                                                    cgeo=0.02,
                                                                    fn_max=250) annotation (Placement(transformation(extent={{-18,30},{2,50}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_ClutchBell(J=0.00025, w(
                                                                               start=500))
      annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_ClutchPlates(J=0.00025, w(
                                                                                 fixed=true, start=0))
      annotation (Placement(transformation(extent={{8,30},{28,50}})));
    Modelica.Blocks.Tables.CombiTable1D Clutch_Behavior(table=[0,0; 597,0; 764,1;
                                                               2000,1]) "Assuming a linear engagement of the clutch"
      annotation (Placement(transformation(extent={{-40,56},{-20,76}})));
    Modelica.Blocks.Sources.Ramp ramp(
                                      duration=5,
                                      offset=500,
                                      startTime=0,
                                      height=1500)
      annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
    Modelica.Mechanics.Rotational.Components.LossyGear GearBox(ratio=57/17,
         lossTable=[400,0.98,0.98,0.00002,0.00002; 1600,0.98,0.98,0.00002,0.00002])
       annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
//     Modelica.Mechanics.Rotational.Components.IdealGear GearBox(ratio=57/17)
//       annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_Pinion(J=0.0001, w(start=0))
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_Spur(J=0.0005, w(start=0))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Mechanics.Rotational.Components.LossyGear Diff_pinion_idler(
         lossTable=[400,0.98,0.98,0.00002,0.00002; 1600,0.98,0.98,0.00002,0.00002],
         ratio=30/19)
       annotation (Placement(transformation(extent={{-44,-50},{-24,-30}})));
//    Modelica.Mechanics.Rotational.Components.IdealGear Diff_pinion_idler(
//                                                                         ratio=30/19)
//      annotation (Placement(transformation(extent={{-44,-50},{-24,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_Pinion1(J=0.0001, w(start=
                                                                           0))
      annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_idler(w(start=0), J=0.0002)
      annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
                                                                              transformation(
                                                                                             extent={{-10,-10},{10,10}},
                                                                                             rotation=0,
                                                                                             origin={46,-76})));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
      annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{-28,-86},{-8,-66}})));
    Modelica.Blocks.Math.Gain gain(k=-0.000311) "Torque Load from air drag"
      annotation (Placement(transformation(extent={{0,-86},{20,-66}})));
    Modelica.Mechanics.Rotational.Components.LossyGear Diff_final_ratio(lossTable
        =[400,0.98,0.98,0.00002,0.00002; 1600,0.98,0.98,0.00002,0.00002], ratio=48/30)
      annotation (Placement(transformation(extent={{4,-50},{24,-30}})));
//    Modelica.Mechanics.Rotational.Components.IdealGear Diff_final_ratio(ratio=48/30)
//      annotation (Placement(transformation(extent={{4,-50},{24,-30}})));
    Modelica.Mechanics.Rotational.Components.Inertia J_diff(w(start=0), J=0.001)
      annotation (Placement(transformation(extent={{28,-50},{48,-30}})));
  equation
    connect(J_ClutchBell.flange_b, Inertial_Clutch.flange_a) annotation (Line(
                                                                              points={{-24,40},{-18,40}},
                                                                              color={0,0,0},
                                                                              smooth=Smooth.None));
    connect(Inertial_Clutch.flange_b, J_ClutchPlates.flange_a) annotation (Line(
                                                                                points={{2,40},{8,40}},
                                                                                color={0,0,0},
                                                                                smooth=Smooth.None));
    connect(Clutch_Behavior.y[1], Inertial_Clutch.f_normalized) annotation (Line(
                                                                                 points={{-19,66},{-8,66},{-8,51}},
                                                                                 color={0,0,127},
                                                                                 smooth=Smooth.None));
    connect(rCEngine.crank_speed, Clutch_Behavior.u[1]) annotation (Line(
                                                                         points={{-55,37},{-48,37},{-48,66},{-42,66}},
                                                                         color={0,0,127},
                                                                         smooth=Smooth.None));
    connect(rCEngine.flange_b, J_ClutchBell.flange_a) annotation (Line(
                                                                       points={{-55.2,45},{-52,45},{-52,40},{-44,40}},
                                                                       color={0,0,0},
                                                                       smooth=Smooth.None));
    connect(rCEngine.u, ramp.y) annotation (Line(
                                                 points={{-74.4,46.6},{-80,46.6},{-80,64},{-74,64},{-74,80},{-79,80}},
                                                 color={0,0,127},
                                                 smooth=Smooth.None));
    connect(J_Pinion.flange_b, GearBox.flange_a) annotation (Line(
                                                                  points={{-28,0},{-24,0}},
                                                                  color={0,0,0},
                                                                  smooth=Smooth.None));
    connect(GearBox.flange_b, J_Spur.flange_a) annotation (Line(
                                                                points={{-4,0},{0,0}},
                                                                color={0,0,0},
                                                                smooth=Smooth.None));
    connect(J_ClutchPlates.flange_b, J_Pinion.flange_a) annotation (Line(
                                                                         points={{28,40},{34,40},{34,20},{-56,20},{-56,0},{-48,0}},
                                                                         color={0,0,0},
                                                                         smooth=Smooth.None));
    connect(J_Pinion1.flange_b, Diff_pinion_idler.flange_a) annotation (Line(
                                                                             points={{-48,-40},{-44,-40}},
                                                                             color={0,0,0},
                                                                             smooth=Smooth.None));
    connect(Diff_pinion_idler.flange_b, J_idler.flange_a) annotation (Line(
                                                                           points={{-24,-40},{-20,-40}},
                                                                           color={0,0,0},
                                                                           smooth=Smooth.None));
    connect(J_Spur.flange_b, J_Pinion1.flange_a) annotation (Line(
                                                                  points={{20,0},{34,0},{34,-20},{-76,-20},{-76,-40},{-68,-40}},
                                                                  color={0,0,0},
                                                                  smooth=Smooth.None));
    connect(speedSensor.w, product.u1) annotation (Line(
                                                        points={{-39,-70},{-30,-70}},
                                                        color={0,0,127},
                                                        smooth=Smooth.None));
    connect(speedSensor.w, product.u2) annotation (Line(
                                                        points={{-39,-70},{-34,-70},{-34,-82},{-30,-82}},
                                                        color={0,0,127},
                                                        smooth=Smooth.None));
    connect(product.y, gain.u) annotation (Line(
                                                points={{-7,-76},{-2,-76}},
                                                color={0,0,127},
                                                smooth=Smooth.None));
    connect(gain.y, torque.tau) annotation (Line(
                                                 points={{21,-76},{34,-76}},
                                                 color={0,0,127},
                                                 smooth=Smooth.None));
    connect(Diff_final_ratio.flange_b, J_diff.flange_a)   annotation (Line(
                                                                           points={{24,-40},{28,-40}},
                                                                           color={0,0,0},
                                                                           smooth=Smooth.None));
    connect(J_idler.flange_b, Diff_final_ratio.flange_a) annotation (Line(
                                                                          points={{0,-40},{4,-40}},
                                                                          color={0,0,0},
                                                                          smooth=Smooth.None));
    connect(J_diff.flange_b, speedSensor.flange) annotation (Line(
                                                                  points={{48,-40},{60,-40},{60,-56},{-64,-56},{-64,-70},{-60,-70}},
                                                                  color={0,0,0},
                                                                  smooth=Smooth.None));
    connect(torque.flange, J_diff.flange_b) annotation (Line(
                                                             points={{56,-76},{68,-76},{68,-40},{48,-40}},
                                                             color={0,0,0},
                                                             smooth=Smooth.None));
    annotation (uses(Modelica(version="3.2")),
                Diagram(graphics));
  end RC_driveline;
end RC_combined;
