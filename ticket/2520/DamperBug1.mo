model DamperBug1
  annotation(Diagram(), experiment(StartTime = 0.0, StopTime = 25.0, Tolerance = 0.000001));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 100) annotation(Placement(visible = true, transformation(origin = {-72.0789,25.4637}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 0.6, w(start = 83.7758, fixed = true), phi(start = 0.0, fixed = true)) annotation(Placement(visible = true, transformation(origin = {-39.3355,25.2085}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.SpringDamper springdamper3(c = 7500, d = 1) annotation(Placement(visible = true, transformation(origin = {-0.575544,8.0576}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.SpringDamper springdamper1(c = 7500, d = 1) annotation(Placement(visible = true, transformation(origin = {-1.43885,40.2878}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel idealrollingwheel1(radius = 0.3) annotation(Placement(visible = true, transformation(origin = {30.5036,40.2878}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel idealrollingwheel2(radius = 0.3) annotation(Placement(visible = true, transformation(origin = {32.8058,7.48201}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass1(m = 1200, v(start = 0, fixed = true)) annotation(Placement(visible = true, transformation(origin = {76.5468,22.7338}, extent = {{-12,-12},{12,12}}, rotation = 0)));
equation
  connect(idealrollingwheel2.flangeT,mass1.flange_a) annotation(Line(points = {{44.8058,7.48201},{53.5252,7.48201},{53.5252,22.7338},{64.5468,22.7338},{64.5468,22.7338}}));
  connect(idealrollingwheel1.flangeT,mass1.flange_a) annotation(Line(points = {{42.5036,40.2878},{53.5252,40.2878},{53.5252,22.7338},{64.5468,22.7338},{64.5468,22.7338}}));
  connect(springdamper1.flange_b,idealrollingwheel1.flangeR) annotation(Line(points = {{10.5612,40.2878},{18.705,40.2878},{18.705,40.2878},{18.5036,40.2878}}));
  connect(springdamper3.flange_b,idealrollingwheel2.flangeR) annotation(Line(points = {{11.4245,8.0576},{20.7194,8.0576},{20.7194,7.48201},{20.8058,7.48201}}));
  connect(springdamper3.flange_a,inertia1.flange_b) annotation(Line(points = {{-12.5755,8.0576},{-20.7194,8.0576},{-20.7194,25.3237},{-27.3355,25.3237},{-27.3355,25.2085}}));
  connect(inertia1.flange_b,springdamper1.flange_a) annotation(Line(points = {{-27.3355,25.2085},{-20.7194,25.2085},{-20.7194,40.2878},{-13.4388,40.2878},{-13.4388,40.2878}}));
  connect(constanttorque1.flange,inertia1.flange_a) annotation(Line(points = {{-60.0789,25.4637},{-55.4461,25.4637},{-55.4461,25.2085},{-51.3355,25.2085}}));
end DamperBug1;

