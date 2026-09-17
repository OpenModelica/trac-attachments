package Parameters 
  record Synchron 
    parameter Integer n_d(min = 1) = 1;
    parameter Integer n_q(min = 0) = 1;
  end Synchron;

  record Synchron_pm
    extends Synchron(n_d = 1, n_q = 1);
  end Synchron_pm;
end Parameters;

package Coefficients
  record Synchron
    parameter Integer n_d;
    parameter Integer n_q;
    Real[n_d, n_d] L_rd;
  end Synchron;
end Coefficients;

function machineSyn
  input Parameters.Synchron p;
  output Coefficients.Synchron c(n_d = p.n_d, n_q = p.n_q);
protected
  final parameter Integer n_d = p.n_d;
  final parameter Integer n_q = p.n_q;
  Real[n_q] Tc_q;
  Real[n_q] To_q;
  Real[n_d + 1, n_d + 1] zx_d;
algorithm
  To_q := T_open(0.4, {0.2}, Tc_q);
  c.L_rd := zx_d[1:n_d, 1:n_d];
end machineSyn;

function polyTime
  input Real[:] a;
  output Real[size(a, 1)] T;
protected
  parameter Integer n = size(a, 1);
  Real[n, n] A;
  Real[n, 2] lam;
algorithm
  A[1, 1:n] := -cat(1, a[n - 1:(-1):1], {1}) / a[n];
  T := -ones(n) ./ lam[n:(-1):1, 1];
end polyTime;

function T_open
  input Real x(unit = "1");
  input Real[:] xtr(each unit = "1");
  input Real[size(xtr, 1)] Tc;
  output Real[size(xtr, 1)] To;
protected
  parameter Integer n = size(xtr, 1);
  Real[n] y;
  Real[n] ac;
  Real[n - 1, n] A;
algorithm
  y := x ./ xtr;
  To := polyTime(ac * x / xtr[n] - cat(1, A * y, {0}));
end T_open;

model SynchronBase
  final parameter Parameters.Synchron par "machine parameters";
  final parameter Integer n_d = par.n_d;
  final parameter Integer n_q = par.n_q;
  final parameter Coefficients.Synchron c = machineSyn(par);
  parameter Real[n_d, n_d] L_rd = c.L_rd;
end SynchronBase;
