model TestAnnotation "Thermal chip model written by explicit ODEs, constant power on half of the bottom surface"
  Real x(start = 1, fixed = true);
equation
  der(x) = -x;
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 2e-06),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "euler"));
end TestAnnotation;
