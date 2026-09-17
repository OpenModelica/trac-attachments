package TestPartial
  partial model PartObject
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end PartObject;

  model ObjectSuper1
    extends PartObject;
    Real a;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    a = u;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ObjectSuper1;

  model ObjectSuper2
    extends TestPartial.ObjectSuper1;
    Real b;
    Modelica.Blocks.Interfaces.RealInput realinput1 annotation(Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    b = realinput1 + u;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end ObjectSuper2;

  model Test1
    replaceable TestPartial.ObjectSuper1 objectsuper11 annotation(Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sine1 annotation(Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sine1.y, objectsuper11.u) annotation(Line(points = {{-49, 20}, {-11.2676, 20}, {-11.2676, 20.3443}, {-11.2676, 20.3443}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.00116252));
  end Test1;

  model Test2
    extends TestPartial.Test1;
    //while this code works fine, the icon that it shows is for the base class (TestPartial.ObjectSuper2, not the replacement class)
    redeclare TestPartial.ObjectSuper2 objectsuper11 annotation (Placement(transformation(extent={{-10,-26},{10,-4}})));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.00116252));
  end Test2;

  model Test3
    extends TestPartial.Test1(redeclare TestPartial.ObjectSuper2 objectsuper11);
    Modelica.Blocks.Sources.Sine sine2(amplitude = 1, freqHz = 1.5) annotation(Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sine2.y, objectsuper11.realinput1) annotation (Line(points={{-49,-20},{-30,-20},{-30,12},{-10,12}},color={0,0,127},smooth=Smooth.None));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.00116252));
  end Test3;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TestPartial;