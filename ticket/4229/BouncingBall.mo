model BouncingBall
  parameter Real e=0.7 "coefficient of restitution";
  parameter Real g=9.81 "gravity acceleration";
  Real h(start=1) "height of ball";
  Real v "velocity of ball";
  Boolean flying(start=true) "true, if ball is flying";

equation
  der(h) = v;
  der(v) = if flying then -g else 0;
  flying = not (h <= 0 and v <= 0);

  when h <= 0.0 then
    reinit(v, -e*pre(v));
  end when;

end BouncingBall;
