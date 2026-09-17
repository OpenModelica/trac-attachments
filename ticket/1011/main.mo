








type Voltage = Real(unit = "V", nominal = 0, min = -100, max = 100);
type Current = Real(unit = "A", nominal = 0, min = -10, max = 10);

connector Pin
    Voltage v;
    flow Current i;
end Pin;

model TwoPin
    Pin p, n;	// composition
    Voltage v;
    flow Current i;
equation
    v = p.v - n.v;	// voltage drop accros
    p.i + n.i = 0;
    i = p.i;
end TwoPin;

model Resistor
    extends TwoPin;
    parameter Real R(unit = "Ohm");
equation
    v = R*i;	// v,i are inherited
end Resistor;

model Capacitor
    extends TwoPin;
    parameter Real C(unit = "F");
equation
    der(v)*C = i;
end Capacitor;

model Inductor
    extends TwoPin;
    parameter Real L(unit = "H");
equation
    v = L*der(i);
end Inductor;

model Ground
    Pin p;
equation
    p.v = 0;
end Ground;

model VSource
    extends TwoPin;
    parameter Real Amp;
    parameter Real f(unit = "Hz", final quantity = "Frequence");
protected
	constant Real pi = 3.1415;
	Real x(start = 0);
equation
    v = Amp*sin(2*pi*f*x*time);
algorithm
    if x >= 1 and x<=1 then	// == BUG
	x:=0; // x := -1*computeAdder(x=3, y=x);
    end if;
    if (x > 10) then
	x := 1;
    else
	x := x + 1;
    end if;
end VSource;

// all together
model Circuit
    VSource VC(Amp = 10, f = 100);
    Resistor R1(R = 20);
    Resistor R2(R = 40);
    Capacitor C1(C = 0.01);
    Inductor L1(L = 0.1);
    Ground gnd;
equation
    connect(VC.p, R1.p);
    connect(R1.n, R2.p);
    connect(R2.n, gnd.p);
    connect(VC.p, C1.p);
    connect(C1.n, L1.p);
    connect(L1.n, gnd.p);
    connect(VC.n, gnd.p);
end Circuit;

function computeAdder
    input Real x,y;
    output z;
algorithm
    z := x + y;
end computeAdder;
