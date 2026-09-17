model flash_sum

parameter Real F = 1;
parameter Real z[3] = {0.45,0.35,0.20};
parameter Real P = 110000;
parameter Real pv[3] = {195750,97840,50320};
parameter Real L = 0.9;

Real k[3],V(max = 0.2,fixed = true),x[3],y[3],M(start = 30,fixed = true);

equation

F = L + V + der(M); // Overall Material balance 
z[:]*F = x[:]*L + y[:]*V + der(M*x[:]); // Component balance
y[:] = k[:].*x[:];
k[:] = pv[:]/P;

sum(y[:]) = 1; 
end flash_sum;