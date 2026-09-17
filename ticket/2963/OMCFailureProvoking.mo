within ;
model OMCFailureProvoking
  Real x(start=1, fixed = true) "Position";
  Real x_d(final start=0, fixed=true) "Velocity";

initial equation
  assert(x >= -1 and x <= +1, "x should be [-1;+1]. This failure is asserted only at initial equation!");
  //the assert should only check the start value of x; set x.start to 1.1 and the assert will prompt, but it should not during the simulation!

equation
  der(x) = x_d "Velocity";
  der(x_d) = -5 "set acceleration";
  //x should accelerate negative and break through -1, but that should be no problem!

  annotation(experiment(
    StopTime=1,
    Interval=5e-4,
    Tolerance=1e-006), uses(Modelica(version="3.2.1")));

end OMCFailureProvoking;
