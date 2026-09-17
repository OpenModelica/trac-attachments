model foo
  Real s(start = -0.05, fixed = true), v(start = 0, fixed = true), a, Tw, Pw, Aw;
  parameter Real m = 0.1;
  parameter Real Av = 1;
equation
  if s > 0 then
    Tw = 0;
    Pw + Aw = 0;
    Pw = s * Av;
  else
    Pw = 0;
    Aw + Tw = 0;
    Aw = s * Av;
  end if;

  // mechanical equation
  v = der(s);
  a = der(v);
  m*a = 1;
annotation(
    experiment(StartTime = 0, StopTime = 0.15, Tolerance = 1e-06, Interval = 0.00015),
    __OpenModelica_simulationFlags(jacobian = "coloredNumerical", noEquidistantTimeGrid = "()", s = "dassl", lv = "LOG_STATS"));end foo;
