package InitializationInInitial
  
  
  model ModelWithInitialScalar
    inner Modelica.Mechanics.MultiBody.World world annotation(
      Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      angle = Modelica.SIunits.Conversions.to_deg(angle),
      n = {0,0,1},
      rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis)  annotation(
      Placement(visible = true, transformation(origin = {-8, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.Body body(m = 1, r_CM = {0, 0, 0})  annotation(
      Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real myParam[3] = {0,1,0};
  protected
  //  parameter Real axis[3](each fixed = false);
    parameter Modelica.SIunits.Angle angle(fixed = false);
  initial equation
    angle = myInitFunScalar(myParam);
  equation
    connect(fixedRotation.frame_b, body.frame_a) annotation(
      Line(points = {{2, 0}, {20, 0}, {20, 0}, {20, 0}}, color = {95, 95, 95}));
    connect(world.frame_b, fixedRotation.frame_a) annotation(
      Line(points = {{-40, 0}, {-18, 0}, {-18, 0}, {-18, 0}}));
  end ModelWithInitialScalar;
  
  model ModelWithInitialVect
    inner Modelica.Mechanics.MultiBody.World world annotation(
      Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation fixedRotation(
      angle = Modelica.SIunits.Conversions.to_deg(angle),
      n = axis,
      rotationType = Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis)  annotation(
      Placement(visible = true, transformation(origin = {-8, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Parts.Body body(m = 1, r_CM = {0, 0, 0})  annotation(
      Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    parameter Real myParam[3] = {0,1,0};
  protected
    parameter Real axis[3](each fixed = false);
    parameter Modelica.SIunits.Angle angle(fixed = false);
  initial equation
    (axis, angle) = myInitFunVect(myParam);
  equation
    connect(fixedRotation.frame_b, body.frame_a) annotation(
      Line(points = {{2, 0}, {20, 0}, {20, 0}, {20, 0}}, color = {95, 95, 95}));
    connect(world.frame_b, fixedRotation.frame_a) annotation(
      Line(points = {{-40, 0}, {-18, 0}, {-18, 0}, {-18, 0}}));
  end ModelWithInitialVect;
  
  function myInitFunScalar
    input Real rotatedVersor[3];
    output Modelica.SIunits.Angle rotationAngle;
  algorithm
  rotationAngle  := 0;
    annotation (Inline=true);
  end myInitFunScalar;
  
  function myInitFunVect
    input Real rotatedVersor[3];
    output Real rotationAxis[3];
    output Modelica.SIunits.Angle rotationAngle;
  algorithm
    rotationAxis := {0,0,1};
    rotationAngle := 0;
    annotation (
      Inline=true);
  end myInitFunVect;
  annotation(
    uses(Modelica(version = "3.2.3")));
end InitializationInInitial;
