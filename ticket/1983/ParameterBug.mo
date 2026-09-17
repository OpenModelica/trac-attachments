within ;
model ParameterBug
  parameter Integer mode = 1;
  parameter Integer n = if mode == 1 then 0 else 1;
  parameter Real c[n](each fixed = false);
  parameter Real a[n](each fixed = false);
  parameter Real r[2](each fixed = false);
  Real x(start = 1, fixed = true);
initial equation
    if (mode == 1) then
      c = fill(0.0, 0);
    else
      c = fill(0.0, n);
    end if;

    if (mode == 1) then
      a = c;
      r = fill(1.0, 2);
    else
      a = fill(0.0, 0);
      r = {1,2};
    end if;
equation
  der(x) = r[1]*x;
  annotation (uses(Modelica(version="3.2")));
end ParameterBug;
