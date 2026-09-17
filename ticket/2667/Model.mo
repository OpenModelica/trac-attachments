model Model
    Real ramp(start=0, fixed=true);
    Real out;
    Real static_stock(start=1000, fixed=true);
equation
    der(ramp) = 1;
    out = if ramp > 0 then ramp else 0;
    der(static_stock) = 0;
end Model;

