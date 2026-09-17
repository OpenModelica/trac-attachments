package SimpleOpt
  model First
    parameter Real k = 1 "Gain";
    parameter Modelica.SIunits.Time T = 1 "Time constant";
    Modelica.Blocks.Sources.Ramp ramp1 annotation(Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.FirstOrder firstorderRef(k = 1, T = 1) annotation(Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.FirstOrder firstorderUnknown(k = k, T = T) annotation(Placement(visible = true, transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1 annotation(Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator1 annotation(Placement(visible = true, transformation(origin = {80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(product1.y, integrator1.u) annotation(Line(points = {{61, 20}, {68, 20}, {68, 20}, {68, 20}}, color = {0, 0, 127}));
    connect(feedback1.y, product1.u2) annotation(Line(points = {{19, 20}, {30, 20}, {30, 14}, {36, 14}, {36, 14}}, color = {0, 0, 127}));
    connect(feedback1.y, product1.u1) annotation(Line(points = {{19, 20}, {30, 20}, {30, 26}, {36, 26}, {36, 26}}, color = {0, 0, 127}));
    connect(firstorderUnknown.y, feedback1.u2) annotation(Line(points = {{-19, -20}, {10, -20}, {10, 12}, {10, 12}}, color = {0, 0, 127}));
    connect(firstorderRef.y, feedback1.u1) annotation(Line(points = {{-19, 20}, {0, 20}, {0, 22}, {0, 22}}, color = {0, 0, 127}));
    connect(ramp1.y, firstorderUnknown.u) annotation(Line(points = {{-67, 0}, {-50, 0}, {-50, -20}, {-44, -20}, {-44, -20}}, color = {0, 0, 127}));
    connect(ramp1.y, firstorderRef.u) annotation(Line(points = {{-67, 0}, {-50, 0}, {-50, 20}, {-44, 20}, {-44, 20}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.01));
  end First;
end SimpleOpt;