model testJInit
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 2.0, Tolerance = 1e-06));
  Modelica.Mechanics.Rotational.Components.Clutch clutch1(mue_pos = [0,0.5], peak = 1.3, cgeo = 0.4, fn_max = 1000, locked(start = false, fixed = true)) annotation(Placement(visible = true, transformation(origin = {-8.5,11.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 5, stateSelect = StateSelect.default, w(start = 0, fixed = true)) annotation(Placement(visible = true, transformation(origin = {31,12}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1, stateSelect = StateSelect.default, w(start = 200, fixed = true)) annotation(Placement(visible = true, transformation(origin = {-50,11}, extent = {{-15,-15},{15,15}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(Placement(visible = true, transformation(origin = {-8.5,62.5}, extent = {{-15,-15},{15,15}}, rotation = 0)));
equation
  connect(constant1.y,clutch1.f_normalized) annotation(Line(points = {{-8.5,46},{-8.5,42},{-8.5,28},{-8.5,28}}));
  connect(clutch1.flange_b,inertia2.flange_a) annotation(Line(points = {{6.5,11.5},{16.5,11.5},{16.5,12},{16,12}}));
  connect(inertia1.flange_b,clutch1.flange_a) annotation(Line(points = {{-35,11},{-23.5,11},{-23.5,11.5},{-23.5,11.5}}));
end testJInit;

