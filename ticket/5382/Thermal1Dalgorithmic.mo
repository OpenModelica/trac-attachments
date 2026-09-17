model Thermal1Dalgorithmic

// Optimized C++ code back-translated to algorithmic modelica "for fun" as suggested by Hilding Elmqvist
// https://modelica.org/events/modelica2019/proceedings/html/papers/Modelica2019paper3B4.pdf

parameter Integer nx = 10000;

parameter Real h = 20; //Forward euler integration step

parameter Real area = 0.0005^2 * 3.14; // m^2
parameter Real nlength = 0.1; // m
parameter Real conductivity = 401; // W/m.K
parameter Real specificheatcapacity = 385; // J/Kg.K
parameter Real density = 8960; // Kg/m^3
parameter Real g = conductivity * area / nlength; //W/K
parameter Real c = specificheatcapacity * density * area * nlength; //J/K
parameter Real Thi = 400 + 273.15; //°C
parameter Real Tlo = 20 + 273.15; // °C

discrete Real T[nx](each start=Tlo);

algorithm
when sample(0,h) then
    T[1] := (1.0 - 3.0*g*h/c) * pre(T[1]) + g*h/c * pre(T[2]) + 2.0*g*h/c*Thi;
    for i in 2 : nx-1 loop
        T[i] := g*h/c * pre(T[i-1]) + (1.0 - 2.0*g*h/c) * pre(T[i]) + g*h/c * pre(T[i+1]);
    end for;
    T[nx] := (1.0 - 3.0*g*h/c) * pre(T[nx]) + g*h/c * pre(T[nx-1]) + 2.0*g*h/c*Tlo;
end when;

annotation(
    experiment(StartTime = 0, StopTime = 100000, Tolerance = 1e-6, Interval = 20));
end Thermal1Dalgorithmic;
