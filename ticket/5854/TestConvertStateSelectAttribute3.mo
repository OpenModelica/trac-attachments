package TestConvertStateSelectAttribute3
  model Test
    TestConvertStateSelectAttribute3.ModelUp modelUp(stateSelectOne = StateSelect.always, stateSelectTwo = StateSelect.prefer) annotation(
      Placement(visible = true, transformation(origin = {-18, -2}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
    inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}) annotation(
      Placement(transformation(extent = {{108, -34}, {88, -14}})));
    Modelica.Mechanics.MultiBody.Parts.Body body(r_CM = {0, 0, 0}, m = 1, I_11 = 0.1, I_22 = 0.1, I_33 = 0.1) annotation(
      Placement(transformation(extent = {{-66, -12}, {-86, 8}})));
  equation
    connect(world.frame_b, modelUp.frame_a) annotation(
      Line(points = {{88, -24}, {30, -24}, {30, -23.6}, {18, -23.6}}, color = {95, 95, 95}, thickness = 0.5));
    connect(modelUp.frame_b, body.frame_a) annotation(
      Line(points = {{-54, -2}, {-66, -2}}, color = {95, 95, 95}, thickness = 0.5));
    annotation(
      Icon(coordinateSystem(initialScale = 0.1)),
      experiment(StopTime = 60, Interval = 0.001, Tolerance = 1e-06),
      __Dymola_experimentFlags(Advanced(EvaluateAlsoTop = false, GenerateVariableDependencies = true, OutputModelicaCode = false), Evaluate = true, OutputCPUtime = true, OutputFlatModelica = false));
  end Test;

  model ModelUp
    import SI = Modelica.SIunits;
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(
      Placement(visible = true, transformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b annotation(
      Placement(visible = true, transformation(origin = {-100, 1.77636e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-100, 1.77636e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    parameter StateSelect stateSelectOne = StateSelect.prefer annotation(
      Evaluate = true,
      Dialog(tab = "Advanced"));
    parameter StateSelect stateSelectTwo = StateSelect.prefer annotation(
      Evaluate = true,
      Dialog(tab = "Advanced"));
    parameter Boolean externalSteering = true;
    // components
    TestConvertStateSelectAttribute3.ModelDown modelDown(stateSelectU = {stateSelectOne, stateSelectTwo}) annotation(
      Placement(transformation(extent = {{-20, -10}, {-40, 10}})));
  equation
    modelDown.u[2] = 0;
    connect(frame_b, modelDown.frame_b) annotation(
      Line(points = {{-100, 0}, {-40, 0}}, color = {95, 95, 95}, thickness = 0.5));
  connect(modelDown.frame_a, frame_a) annotation(
      Line(points = {{-20, 0}, {102, 0}, {102, -60}, {100, -60}}));
    annotation(
      Diagram(graphics = {Bitmap(extent = {{-10, 12}, {-10, 12}}), Bitmap(extent = {{18, 60}, {18, 60}})}, coordinateSystem(initialScale = 0.1)));
  end ModelUp;

  model ModelDown
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialElementaryJoint;
    parameter StateSelect stateSelectU[2] = fill(StateSelect.prefer, 2);
    parameter StateSelect stateSelectLambda[2] = fill(StateSelect.avoid, 2);
    Real u[2](stateSelect = stateSelectU, each fixed = false);
    Real lambda[2](stateSelect = stateSelectLambda, each fixed = false);
    annotation(
      Icon(coordinateSystem(initialScale = 0.1)),
      experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.01));
  end ModelDown;
  annotation(
    uses(Modelica(version = "3.2.3")));

end TestConvertStateSelectAttribute3;
