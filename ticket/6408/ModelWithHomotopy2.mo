model ModelWithHomotopy2

parameter Real startA = 1;
final parameter Real a(start=startA, fixed=false);

Real x;
Real y;
Real z;
initial equation
x^a = 2;
equation
x = 2;
y = homotopy(x, 3);
z+ 1e-3*sin(z) = 4*y;
annotation(
    __OpenModelica_simulationFlags(lv = "LOG_INIT_HOMOTOPY,LOG_NLS,LOG_NLS_V,LOG_STATS", s = "dassl"));
end ModelWithHomotopy2;
