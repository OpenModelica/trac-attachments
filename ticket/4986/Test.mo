model Test
  parameter Real T4 = 1;
  parameter Real T5 = 1e-3;
  parameter Real Tq = 1000;
  parameter Real T6(fixed = false);
initial equation
  Tq = homotopy(T4*T6/(T4+T5),T6);
end Test;
