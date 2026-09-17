model ModelStartNotDefined

parameter Real startA(fixed=false);
final parameter Real a(start=startA, fixed=false);

Real x;
initial equation
startA = 1;
x^a = 2;
equation
x = 2;
annotation(
    __OpenModelica_simulationFlags(lv = "LOG_NLS,LOG_NLS_V,LOG_STATS", s = "dassl"));
end ModelStartNotDefined;
