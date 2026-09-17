model timeUnitDay "testing the support for 'day' as a time unit and 'day-1' as rate unit"
  Real t(unit = "s", displayUnit = "d") "time displayed in days";
  Real rate_pmin(unit="s-1", displayUnit="min-1") = 1 "displays as ";
  Real rate_pks(unit="s-1", displayUnit="ks-1") = 1 "displays as 1000";
  Real rate_pday(unit="s-1", displayUnit="d-1") = 1 "displays as 1, but should be 86400";
initial equation
  t=0;
equation
  der(t) = 1;
  annotation(
    experiment(StartTime = 0, StopTime = 172800, Tolerance = 1e-06, Interval = 346.988));
end timeUnitDay;