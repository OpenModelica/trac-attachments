model Rectifier "B6 diode bridge"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Analog.Ideal;
  parameter Modelica.SIunits.Voltage VAC=400 "RMS line-to-line";
  parameter Modelica.SIunits.Frequency f=50 "line frequency";
  parameter Modelica.SIunits.Inductance LAC=60E-6 "line inductor";
  parameter Modelica.SIunits.Resistance Ron=1E-3 "diode forward resistance";
  parameter Modelica.SIunits.Conductance Goff=1E-3 "diode backward conductance";
  parameter Modelica.SIunits.Voltage Vknee=2 "diode threshold voltage";
  parameter Modelica.SIunits.Capacitance CDC=15E-3 "DC capacitance";
  parameter Modelica.SIunits.Current IDC=500 "load current";
  output Modelica.SIunits.Voltage uDC;
  output Modelica.SIunits.Current iAC[3];
  output Modelica.SIunits.Voltage uAC[3];
  output Modelica.SIunits.Power Losses;
Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(freqHz=f,
       V=VAC*sqrt(2/3));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage2(
    freqHz=f,
    phase=-2/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage3(
    freqHz=f,
    phase=-4/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3));
  Modelica.Electrical.Analog.Basic.Inductor Inductor1(L=LAC);
  Modelica.Electrical.Analog.Basic.Inductor Inductor2(L=LAC);
  Modelica.Electrical.Analog.Basic.Inductor Inductor3(L=LAC);
  Ideal.IdealDiode IdealDiode1(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee) ;
  Ideal.IdealDiode IdealDiode2(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee);
Ideal.IdealDiode IdealDiode3(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee);
  Ideal.IdealDiode IdealDiode4(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee);
  Ideal.IdealDiode IdealDiode5(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee);
  Ideal.IdealDiode IdealDiode6(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee);
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=2*CDC);
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor2(C=2*CDC);
  Modelica.Electrical.Analog.Basic.Ground Ground1;
  Modelica.Electrical.Analog.Sources.SignalCurrent SignalCurrent1;
  Modelica.Blocks.Sources.Constant Constant1(k=IDC);
initial equation 
  Capacitor1.v = VAC*sqrt(2)/2;
  Capacitor2.v = VAC*sqrt(2)/2;
equation 
  uDC = Capacitor1.v + Capacitor2.v;
  iAC = {Inductor1.i,Inductor2.i,Inductor3.i};
  uAC[1] = Inductor1.n.v - Inductor2.n.v;
  uAC[2] = Inductor2.n.v - Inductor3.n.v;
  uAC[3] = Inductor3.n.v - Inductor1.n.v;
  Losses = IdealDiode1.v*IdealDiode1.i + IdealDiode2.v*IdealDiode2.i +
    IdealDiode3.v*IdealDiode3.i + IdealDiode4.v*IdealDiode4.i +
    IdealDiode5.v*IdealDiode5.i + IdealDiode6.v*IdealDiode6.i;
  connect(SineVoltage1.n, SineVoltage2.n);
  connect(SineVoltage2.n, SineVoltage3.n);
  connect(SineVoltage1.p, Inductor1.p);
  connect(SineVoltage2.p, Inductor2.p);
  connect(SineVoltage3.p, Inductor3.p) ;
  connect(IdealDiode1.p, IdealDiode4.n);
  connect(IdealDiode2.p, IdealDiode5.n);
  connect(IdealDiode3.p, IdealDiode6.n);
  connect(IdealDiode1.n, IdealDiode2.n);
  connect(IdealDiode2.n, IdealDiode3.n);
  connect(IdealDiode4.p, IdealDiode5.p);
  connect(IdealDiode5.p, IdealDiode6.p);
  connect(Capacitor2.n, IdealDiode6.p) ;
  connect(IdealDiode3.n, Capacitor1.p);
  connect(Capacitor1.n, Capacitor2.p);
  connect(Capacitor2.p, Ground1.p) ;
  connect(Capacitor1.p, SignalCurrent1.p) ;
  connect(SignalCurrent1.n, Capacitor2.n) ;
  connect(Constant1.y, SignalCurrent1.i) ;
  connect(Inductor1.n, IdealDiode1.p);
  connect(Inductor2.n, IdealDiode2.p);
  connect(Inductor3.n, IdealDiode3.p);
end Rectifier;
