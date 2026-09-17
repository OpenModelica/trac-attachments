package ExampleLib
  import Modelica.SIunits.*;

  model ExampleModel
    parameter Length Length1 = 1;
    parameter Length Length2 = 1;
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape(r = {Length1, 0, 0}, r_CM = {0.5, 0, 0}, m = 1) annotation(Placement(transformation(extent = {{-40, 20}, {-20, 40}})));
    Modelica.Mechanics.MultiBody.Parts.BodyShape bodyShape1(r_CM = {0.5, 0, 0}, m = 1, r = {Length2, 0, 0}) annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute(phi(fixed = true), w(fixed = true)) annotation(Placement(transformation(extent = {{0, 20}, {20, 40}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(phi(fixed = true), w(fixed = true)) annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a1 "Coordinate system fixed to the joint with one cut-force and cut-torque" annotation(Placement(transformation(extent = {{-118, 14}, {-86, 46}})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b1 "Coordinate system fixed to the component with one cut-force and cut-torque" annotation(Placement(transformation(extent = {{86, 14}, {118, 46}})));
  protected
    parameter Length TotalLength = Length1 + Length2;
  public
    Modelica.Mechanics.MultiBody.Parts.Body body(m = 1, r_CM = {0, TotalLength, 0}) annotation(Placement(transformation(extent = {{-56, -12}, {-36, 8}})));
  equation
    connect(revolute1.frame_b, bodyShape.frame_a) annotation(Line(points = {{-60, 30}, {-50, 30}, {-40, 30}}, color = {95, 95, 95}, thickness = 0.5));
    connect(bodyShape.frame_b, revolute.frame_a) annotation(Line(points = {{-20, 30}, {-10, 30}, {0, 30}}, color = {95, 95, 95}, thickness = 0.5));
    connect(revolute.frame_b, bodyShape1.frame_a) annotation(Line(points = {{20, 30}, {30, 30}, {40, 30}}, color = {95, 95, 95}, thickness = 0.5));
    connect(revolute1.frame_a, frame_a1) annotation(Line(points = {{-80, 30}, {-91, 30}, {-102, 30}}, color = {95, 95, 95}, thickness = 0.5));
    connect(bodyShape1.frame_b, frame_b1) annotation(Line(points = {{60, 30}, {81, 30}, {102, 30}}, color = {95, 95, 95}, thickness = 0.5));
    connect(body.frame_a, revolute1.frame_b) annotation(Line(points = {{-56, -2}, {-58, -2}, {-58, 30}, {-60, 30}}, color = {95, 95, 95}, thickness = 0.5));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false)));
  end ExampleModel;

  model ExampleTestCase
    inner Modelica.Mechanics.MultiBody.World world annotation(Placement(transformation(extent = {{-82, 18}, {-62, 38}})));
    ExampleModel exampleModel(Length1 = 2, Length2 = 2) annotation(Placement(transformation(extent = {{-44, 14}, {-24, 34}})));
  equation
    connect(world.frame_b, exampleModel.frame_a1) annotation(Line(points = {{-62, 28}, {-54, 28}, {-54, 27}, {-44.2, 27}}, color = {95, 95, 95}, thickness = 0.5));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false)), Diagram(coordinateSystem(preserveAspectRatio = false)));
  end ExampleTestCase;
  annotation(uses(Modelica(version = "3.2.1")));
end ExampleLib;