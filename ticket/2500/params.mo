package params

  import T = Modelica.Mechanics.Translational;

  model drivetrain

    type DirectionOfTravel = enumeration(Forward, Backward);

    T.Sources.ConstantForce forward_engine(f_constant=1);
    T.Sources.ConstantForce reverse_engine(f_constant=-1);
    T.Components.Fixed ground;
    T.Components.Mass body(m=1, v.start=0, v.fixed=true, s.start=0, s.fixed=true);

    parameter DirectionOfTravel direction = DirectionOfTravel.Forward;

  equation
    if direction == DirectionOfTravel.Forward then
      connect(body.flange_a, forward_engine.flange);
      connect(reverse_engine.flange, ground.flange);
    elseif direction == DirectionOfTravel.Backward then
      connect(body.flange_a, reverse_engine.flange);
      connect(forward_engine.flange, ground.flange);
    end if;

  end drivetrain;

  model backward
    extends drivetrain(direction=drivetrain.DirectionOfTravel.Backward);
  end backward;

end params;
