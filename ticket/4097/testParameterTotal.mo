within ;
model testParameter
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cs1(r={0,-0.760,-0.115},
      animation=false)
    annotation (Placement(transformation(extent={{-54,44},{-18,80}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cs2(r={-0.180,0,-0.115},
      animation=false)
    annotation (Placement(transformation(extent={{-52,-50},{-32,-30}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b1(
    m=259.1,
    r={0,0,0},
    r_CM={-0.001,-0.135,0},
    I_11=4.892,
    I_22=6.270,
    I_33=4.607,
    I_21=-0.035,
    I_31=-0.016,
    I_32=0.020,
    shapeType="modelica://MH_City_RT_meca/data/stl/achsschenkel_rechts.stl",
    useQuaternions=true,
    enforceStates=false,
    lengthDirection={1,0,0},
    color={200,0,0},
    animation=false)
    annotation (Placement(transformation(extent={{132,10},{156,34}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b3(
    r={0,0,0},
    r_CM={0,0,0},
    m=19.7,
    I_11=0.938,
    I_22=0.013,
    I_33=0.937,
    I_21=0,
    I_31=0,
    I_32=0,
    shapeType="modelica://MH_City_RT_meca/data/stl/lenkkolben.stl",
    useQuaternions=true,
    lengthDirection={1,0,0},
    color={200,0,0},
    animation=false)
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR triple(
    n_a={0,0,1},
    rRod2_ib={-0.180,0.041,0},
    phi_offset=0,
    animation=false,
    phi_guess=0,
    rRod1_ia={0,-0.379,0}) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={78,6})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cs3(r={0,-0.340,0},
      animation=false)
    annotation (Placement(transformation(extent={{50,-54},{78,-26}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b2(
    r_CM={0,-0.189,0},
    m=3.1,
    I_11=0.049,
    I_22=0.001,
    I_33=0.050,
    I_21=0,
    I_31=0,
    I_32=0,
    shapeType="modelica://MH_City_RT_meca/data/stl/spurstange.stl",
    r={0,0,0},
    useQuaternions=true,
    enforceStates=false,
    lengthDirection={1,0,0},
    color={200,0,0},
    animation=false)
    annotation (Placement(transformation(extent={{134,-20},{156,2}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic trans(
    n={0,1,0},
    stateSelect=StateSelect.prefer,
    useAxisFlange=true,
    s(fixed=true, start=1.39836e-12))
    annotation (Placement(transformation(extent={{-22,-30},{-2,-50}})));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-94,-50},{-74,-30}})));
equation
  connect(cs1.frame_b, triple.frame_b) annotation (Line(
      points={{-18,62},{78,62},{78,26}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cs3.frame_b, triple.frame_a) annotation (Line(
      points={{78,-40},{78,-14}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cs2.frame_b, trans.frame_a) annotation (Line(
      points={{-32,-40},{-22,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(trans.frame_b, b3.frame_a) annotation (Line(
      points={{-2,-40},{10,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(b3.frame_b, cs3.frame_a) annotation (Line(
      points={{30,-40},{50,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(b1.frame_a, triple.frame_ib) annotation (Line(
      points={{132,22},{98,22}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(world.frame_b, cs2.frame_a) annotation (Line(
      points={{-74,-40},{-52,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cs1.frame_a, cs2.frame_a) annotation (Line(
      points={{-54,62},{-66,62},{-66,-40},{-52,-40}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(b2.frame_a, triple.frame_ia) annotation (Line(
      points={{134,-9},{116,-9},{116,-10},{98,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (uses(Modelica(version="3.2.1")), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end testParameter;
