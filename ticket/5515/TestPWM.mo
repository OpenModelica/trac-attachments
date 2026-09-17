model TestPWM
  Real x;
  Real u = sin(time);
  Real y;
  discrete Real Tstart(start=0, fixed=true);
  parameter Real T=0.4;
equation
  x = (time-Tstart)/T;
  y = if u < x then 1 else 0;
  when x > 1 then
    Tstart = time;
  end when;
annotation(experiment(StopTime=50));
end TestPWM;
