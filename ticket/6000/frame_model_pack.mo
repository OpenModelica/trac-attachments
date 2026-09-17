package frame_model_pack
  model frame_model
    import Modelica.SIunits.Conversions.*;
    parameter Real test = 0.1;
    parameter Real demo = 0.25;
    parameter Modelica.SIunits.Angle noseAngle = from_deg(118.8) "Nose angle of glider";
    parameter Modelica.SIunits.Length NosePx = demo - test "Set back of leading edge hinge along keel";
    frame_model_pack.keel keel(NPx = NosePx) annotation(
      Placement(visible = true, transformation(origin = {-50, 14}, extent = {{-50, -10}, {50, 10}}, rotation = 0)));
    inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
      Placement(visible = true, transformation(origin = {-174, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Joints.Revolute LE_hinge_R(a(fixed = false, start = 0), phi(fixed = true, start = noseAngle / 2), w(fixed = true, start = 0)) annotation(
      Placement(visible = true, transformation(origin = {-92, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    frame_model_pack.keel keel1 annotation(
      Placement(visible = true, transformation(origin = {-24, 74}, extent = {{-50, -10}, {50, 10}}, rotation = 0)));
  control_frame control_frame annotation(
      Placement(visible = true, transformation(origin = {-36, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    connect(world.frame_b, keel.frame_a) annotation(
      Line(points = {{-164, 14}, {-70, 14}}, color = {95, 95, 95}));
    connect(LE_hinge_R.frame_a, keel.LE_hinge_R) annotation(
      Line(points = {{-92, 30}, {-92, 30}, {-92, 24}, {-92, 24}}));
    connect(LE_hinge_R.frame_b, keel1.frame_a) annotation(
      Line(points = {{-92, 50}, {-92, 50}, {-92, 74}, {-74, 74}, {-74, 74}}, color = {95, 95, 95}));
  connect(keel.TOU_anchor, control_frame.TOU_conn) annotation(
      Line(points = {{-42, 14}, {-36, 14}, {-36, -38}, {-36, -38}}));
    annotation(
      Icon(coordinateSystem(extent = {{-500, -100}, {500, 100}})),
      Diagram(coordinateSystem(extent = {{-500, -100}, {500, 100}})));
  end frame_model;

  model keel
    parameter Modelica.SIunits.Length NPx = 0.05795 "Set back of leading edge hinge along keel";
    parameter Modelica.SIunits.Length NPy = 0.0635 "Distance outboard of leading edge hinge from keel";
    parameter Modelica.SIunits.Length keelLength = 2.28 "Overall length of keel";
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder keel_tube(diameter = 0.052, innerDiameter = 0.05, r = {keelLength, 0, 0}) annotation(
      Placement(visible = true, transformation(origin = {55, 7}, extent = {{-65, -65}, {65, 65}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
      Placement(visible = true, transformation(origin = {-196, 6}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-500, 2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation NP_R(r = {NPx, NPy, 0}) annotation(
      Placement(visible = true, transformation(origin = {-88, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation NP_L(r = {NPx, -NPy, 0}) annotation(
      Placement(visible = true, transformation(origin = {-88, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b LE_hinge_L annotation(
      Placement(visible = true, transformation(origin = {-88, -98}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {-428, -98}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b LE_hinge_R annotation(
      Placement(visible = true, transformation(origin = {-88, 98}, extent = {{-16, -16}, {16, 16}}, rotation = 90), iconTransformation(origin = {-426, 94}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation TOU_Translation(animation = false, r = {1.68, 0, 0}) annotation(
      Placement(visible = true, transformation(origin = {32, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation TS_Translation(animation = false, r = {2.47, 0, 0}) annotation(
      Placement(visible = true, transformation(origin = {32, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b TOU_anchor annotation(
      Placement(visible = true, transformation(origin = {104, 84}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {76, 4}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b TS_anchor annotation(
      Placement(visible = true, transformation(origin = {114, -66}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {402, 2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b keel_end annotation(
      Placement(visible = true, transformation(origin = {196, 10}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {498, 2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  equation
    connect(frame_a, keel_tube.frame_a) annotation(
      Line(points = {{-196, 6}, {-10, 6}, {-10, 7}}));
    connect(keel_tube.frame_a, NP_L.frame_a) annotation(
      Line(points = {{-10, 7}, {-88, 7}, {-88, -26}}, color = {95, 95, 95}));
    connect(keel_tube.frame_a, NP_R.frame_a) annotation(
      Line(points = {{-10, 7}, {-88, 7}, {-88, 50}}, color = {95, 95, 95}));
    connect(NP_R.frame_b, LE_hinge_R) annotation(
      Line(points = {{-88, 70}, {-88, 70}, {-88, 98}, {-88, 98}}));
    connect(NP_L.frame_b, LE_hinge_L) annotation(
      Line(points = {{-88, -46}, {-88, -46}, {-88, -98}, {-88, -98}}, color = {95, 95, 95}));
    connect(keel_tube.frame_a, TOU_Translation.frame_a) annotation(
      Line(points = {{-10, 8}, {-30, 8}, {-30, 76}, {22, 76}, {22, 76}}, color = {95, 95, 95}));
    connect(keel_tube.frame_a, TS_Translation.frame_a) annotation(
      Line(points = {{-10, 8}, {-34, 8}, {-34, -58}, {22, -58}, {22, -58}}, color = {95, 95, 95}));
    connect(TS_Translation.frame_b, TS_anchor) annotation(
      Line(points = {{42, -58}, {92, -58}, {92, -66}, {114, -66}, {114, -66}}, color = {95, 95, 95}));
    connect(TOU_Translation.frame_b, TOU_anchor) annotation(
      Line(points = {{42, 76}, {62, 76}, {62, 84}, {104, 84}, {104, 84}}, color = {95, 95, 95}));
    connect(keel_tube.frame_b, keel_end) annotation(
      Line(points = {{120, 8}, {198, 8}, {198, 10}, {196, 10}}, color = {95, 95, 95}));
    annotation(
      Icon(coordinateSystem(extent = {{-500, -100}, {500, 100}}, initialScale = 0.1), graphics = {Rectangle(origin = {1, 1}, fillColor = {136, 138, 133}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-499, 45}, {499, -45}}), Polygon(origin = {-430, 0}, fillColor = {136, 138, 133}, fillPattern = FillPattern.Solid, points = {{4, 98}, {-60, 4}, {2, -98}, {58, 10}, {4, 98}})}),
      Diagram(coordinateSystem(extent = {{-500, -100}, {500, 100}})));
  end keel;

model control_frame

  import Modelica.SIunits.Conversions.*;
  
  parameter Modelica.SIunits.Length width_TOU = 0.082 "Width across Top of Upright pivot points";
  parameter Modelica.SIunits.Length width_bb = 1.345 "Width across base bar";
  parameter Modelica.SIunits.Length height = 1.44722 "Total in plane height of control frame";
  parameter Modelica.SIunits.Length uprightLength = sqrt(height ^ 2 + ((width_bb - width_TOU) / 2) ^ 2);
  parameter Modelica.SIunits.Angle frameAngle = atan(height / ((width_bb - width_TOU) / 2));
  
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a TOU_conn annotation(
    Placement(visible = true, transformation(origin = {-92, 34}, extent = {{-16, -16}, {16, 16}}, rotation = -90), iconTransformation(origin = {-2, 200}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation TOU_R(r = {0, width_TOU / 2, 0}, width = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-50, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation TOU_L(r = {0, width_TOU / 2, 0}, width = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-132, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute TOU_joint_R(n = {1, 0, 0}, phi(fixed = false, start = -frameAngle), w(fixed = false, start = 0)) annotation(
    Placement(visible = true, transformation(origin = {-30, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder upright_R(density = 2400, diameter = 0.0284, innerDiameter = 0.025, r = {0, uprightLength, 0}) annotation(
    Placement(visible = true, transformation(origin = {-30, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder upright_L(density = 2400, diameter = 0.0284, innerDiameter = 0.025, r = {0, uprightLength, 0}) annotation(
    Placement(visible = true, transformation(origin = {-168, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute TOU_joint_L(n = {1, 0, 0}, phi(fixed = true, start =  -(from_deg(180) - frameAngle)), w(fixed = true, start = 0)) annotation(
    Placement(visible = true, transformation(origin = {-166, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
Modelica.Mechanics.MultiBody.Joints.Revolute BOU_L(n = {1, 0, 0}, phi(fixed = false, start = from_deg(180) - frameAngle), w(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-168, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder(density = 2400, diameter = 0.0284, innerDiameter = 0.025, r = {0, width_bb, 0}) annotation(
    Placement(visible = true, transformation(origin = {-104, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.RevolutePlanarLoopConstraint BOU_R(n = {1, 0, 0})  annotation(
      Placement(visible = true, transformation(origin = {-30, -72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

equation
    connect(TOU_conn, TOU_R.frame_a) annotation(
      Line(points = {{-92, 34}, {-92, 34}, {-92, 12}, {-60, 12}, {-60, 14}}));
    connect(TOU_L.frame_b, TOU_R.frame_a) annotation(
      Line(points = {{-122, 14}, {-60, 14}, {-60, 14}, {-60, 14}}));
    connect(TOU_R.frame_b, TOU_joint_R.frame_a) annotation(
      Line(points = {{-40, 14}, {-30, 14}, {-30, 4}}, color = {95, 95, 95}));
    connect(TOU_joint_R.frame_b, upright_R.frame_a) annotation(
      Line(points = {{-30, -16}, {-30, -32}}, color = {95, 95, 95}));
    connect(TOU_joint_L.frame_a, TOU_L.frame_a) annotation(
      Line(points = {{-166, 4}, {-166, 4}, {-166, 14}, {-142, 14}, {-142, 14}}));
    connect(TOU_joint_L.frame_b, upright_L.frame_a) annotation(
      Line(points = {{-166, -16}, {-168, -16}, {-168, -30}, {-168, -30}}, color = {95, 95, 95}));
    connect(upright_L.frame_b, BOU_L.frame_a) annotation(
      Line(points = {{-168, -50}, {-168, -50}, {-168, -60}, {-168, -60}}));
    connect(BOU_L.frame_b, bodyCylinder.frame_a) annotation(
      Line(points = {{-168, -80}, {-168, -86}, {-114, -86}}, color = {95, 95, 95}));
    connect(upright_R.frame_b, BOU_R.frame_a) annotation(
      Line(points = {{-30, -52}, {-30, -52}, {-30, -62}, {-30, -62}}));
    connect(BOU_R.frame_b, bodyCylinder.frame_b) annotation(
      Line(points = {{-30, -82}, {-30, -82}, {-30, -86}, {-94, -86}, {-94, -86}}));
    annotation(
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics = {Rectangle(origin = {-73, 66}, rotation = -25, lineColor = {52, 101, 164}, fillColor = {114, 159, 207}, fillPattern = FillPattern.VerticalCylinder, extent = {{9, 142}, {-11, -206}}), Rectangle(origin = {69, 68}, rotation = 25, lineColor = {52, 101, 164}, fillColor = {114, 159, 207}, fillPattern = FillPattern.VerticalCylinder, extent = {{9, 142}, {-11, -206}}), Rectangle(origin = {-23, -116}, rotation = 90, lineColor = {52, 101, 164}, fillColor = {114, 159, 207}, fillPattern = FillPattern.VerticalCylinder, extent = {{9, 142}, {-5, -184}})}),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})));

end control_frame;
  annotation(
    Icon(coordinateSystem(extent = {{-500, -100}, {500, 100}})),
    Diagram(coordinateSystem(extent = {{-500, -100}, {500, 100}})),
    uses(Modelica(version = "3.2.3")));
end frame_model_pack;