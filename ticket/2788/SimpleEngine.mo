package Test
  model SimpleEngine
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 1) annotation(Placement(visible = true, transformation(origin = {-15.2074,12.4424}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.ConstantTorque constanttorque1(tau_constant = 1) annotation(Placement(visible = true, transformation(origin = {-61.9816,12.4424}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Damper damper1(d = 1.5) annotation(Placement(visible = true, transformation(origin = {28.8018,12.212}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation(Placement(visible = true, transformation(origin = {58.0645,0.691244}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    annotation(experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-006));
equation
  connect(damper1.flange_b,fixed1.flange) annotation(Line(points = {{40.8018,12.212},{57.8341,12.212},{57.8341,0.691244},{58.0645,0.691244}}));
  connect(inertia1.flange_b,damper1.flange_a) annotation(Line(points = {{-3.20737,12.4424},{16.129,12.4424},{16.129,12.212},{16.8018,12.212}}));
  connect(constanttorque1.flange,inertia1.flange_a) annotation(Line(points = {{-49.9816,12.4424},{-27.8802,12.4424},{-27.8802,12.4424},{-27.2074,12.4424}}));
  end SimpleEngine;
  model SimpleEngine_fail
    SimpleEngine the_model_under_test(constanttorque1(tau_constant=1));
    parameter Modelica.SIunits.AngularVelocity desired_velocity = 1;
    type Requirement = enumeration(success, unknown, violated);
    Requirement Req(start = Requirement.unknown, fixed = true);
  equation
    if Req == Requirement.success or the_model_under_test.inertia1.w > desired_velocity then
      Req = Requirement.success;
    else
      Req = Requirement.unknown;
    end if;
  end SimpleEngine_fail;
  model SimpleEngine_pass
    SimpleEngine the_model_under_test(constanttorque1(tau_constant=2));
    parameter Modelica.SIunits.AngularVelocity desired_velocity = 1;
    type Requirement = enumeration(success, unknown, violated);
    Requirement Req(start = Requirement.unknown , fixed = true);
  equation
    if Req == Requirement.success or the_model_under_test.inertia1.w > desired_velocity then
      Req = Requirement.success;
    else
      Req = Requirement.unknown;
    end if;
  end SimpleEngine_pass;
end Test;
