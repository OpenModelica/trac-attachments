model ModelWithoutHomotopy

parameter Real startA = 1;
final parameter Real a(start=startA, fixed=false);

Real x;
Real y;
initial equation
x^a = 2;
equation
x = 2;
y = x;
annotation(
    __OpenModelica_simulationFlags(lv = "LOG_NLS,LOG_NLS_V,LOG_STATS", s = "dassl"));
end ModelWithoutHomotopy;
