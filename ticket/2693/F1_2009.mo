within Project1;
record F1_2009 "F1 2009"
  extends VDLMotorsports.Chassis.Suspensions.Linkages.Geometry.DWP(
    r0H_1(displayUnit="mm") = {0,0.7157,0},
    r0CL1_1(displayUnit="mm") = {-0.32,0.015,-0.1012},
    r0CL2_1(displayUnit="mm") = {0.163,0.018,-0.1122},
    r0L1L2U_1(displayUnit="mm") = {-0.0035,0.6467,-0.1082},
    r0CL3_1(displayUnit="mm") = {-0.25,0.1787,0.0838},
    r0CL4_1(displayUnit="mm") = {0.11,0.1507,0.0838},
    r0L3L4U_1(displayUnit="mm") = {-0.023,0.608,0.0838},
    r0L5X_1(displayUnit="mm") = {0.158,0.17,0.0838},
    r0L5U_1(displayUnit="mm") = {0.054,0.6349,0.0852},
    r0R1L1_1(displayUnit="mm") = {0.02,0.63,-0.13},
    r0R1L2_1(displayUnit="mm") = {0.02,0.12,0.125},
    r0R2L3_1(displayUnit="mm") = {0.07,0.12,0.125},
    wishboneAndUpright_1=false,
    pushrod_1=false,
    toeLink_1=true,
    wishboneAndUpright_2=true,
    pushrod_2=false,
    toeLink_2=false,
    ucaMass_1=
        VDLMotorsports.Chassis.Suspensions.Front.ComponentMasses.UpperControlArm());

    import SI = Modelica.SIunits;
parameter SI.Force fAntiRoll_1=0
    "Initial estimate of the force in the anti-roll bar arms" annotation (
    Evaluate=false, Dialog(tab="Initialization", group="Anti-roll bar"));
parameter SI.Position r0CS_1[3]={0.3,0.08,0.13}
    "Position of the left spring end connected to the chassis resolved in vehicle";
parameter SI.Position r0RS_1[3]={0.06,0.04,0.13}
    "Position of the left spring end connected to the rocker resolved in vehicle";
parameter SI.Position r0CD_1[3]=r0CS_1
    "Position of the left damper mount connected to the chassis resolved in vehicle";
parameter SI.Position r0RD_1[3]=r0RS_1
    "Position of the left damper mount connected to the rocker resolved in vehicle";
parameter SI.Position r0CS_2[3]=r0CS_1 .* {1,-1,1}
    "Position of the right spring end connected to the chassis resolved in vehicle";
parameter SI.Position r0RS_2[3]=r0RS_1 .* {1,-1,1}
    "Position of the right spring end connected to the rocker resolved in vehicle";
parameter SI.Position r0CD_2[3]=r0CD_1 .* {1,-1,1}
    "Position of the right damper mount connected to the chassis resolved in vehicle";
parameter SI.Position r0RD_2[3]=r0RD_1 .* {1,-1,1}
    "Position of the right damper mount connected to the rocker resolved in vehicle";
parameter SI.Position r0RP_1[3]=r0R2L3_1 + {-0.02,-0.05,0.01}
    "Position of left pivot point on rocker resolved in Vehicle Frame";
parameter SI.Position r0LP_1[3]=r0RP_1 + {-0.15,0,0}
    "Position of left lever pivot point resolved in Vehicle Frame";
parameter SI.Position r0ARB_1[3]=r0LP_1 + {0,0,-0.05}
    "Position of left end of anti-roll bar resolved in Vehicle Frame";

parameter SI.Position r0RP_2[3]=r0RP_1 .* {1,-1,1}
    "Position of right pivot point on rocker resolved in Vehicle Frame";
parameter SI.Position r0LP_2[3]=r0LP_1 .* {1,-1,1}
    "Position of right lever pivot point resolved in Vehicle Frame";
parameter SI.Position r0ARB_2[3]=r0ARB_1 .* {1,-1,1}
    "Position of right end of anti-roll bar resolved in Vehicle Frame";
parameter SI.Position iPR=-0.0075
    "Ratio from pinion to rack (effective pinion radius) [m/rad]";
parameter SI.Position r0QZ[3]={-0.85,0,0.35}
    "Position of upper steering column joint, resolved in vehicleFrame";
parameter SI.Position r0Q[3]={-0.85,0,0.35}
    "Position of steering wheel centre, resolved in vehicleFrame";

parameter Boolean antiroll=false "Anti-roll link solution selection"
annotation (choices(checkBox=true), Dialog(tab="Solution selection", group="Anti-
roll (if overridesolution=true)"));

end F1_2009;
