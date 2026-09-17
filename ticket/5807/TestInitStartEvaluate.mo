model TestInitStartEvaluate
  final parameter Real p(start = p_start, fixed = false);
  parameter Real p_start = -2;
initial equation
 (p - 1)*p*(p+2) = 0;
annotation(__OpenModelica_commandLineOptions="-d=evaluateAllParameters",
           __OpenModelica_simulationFlags(lv="LOG_NLS_V"));
end TestInitStartEvaluate;
