package TLM

connector Connector_Q
  output Real p;
  output Real q;
  input Real c;
  input Real Zc;
end Connector_Q;

connector Connector_C
  input Real p;
  input Real q;
  output Real c;
  output Real Zc;
end Connector_C;

model FlowSource
  Connector_Q source;
  parameter Real flowVal;
equation
  source.q = flowVal;
  source.p = source.c + source.q*source.Zc;
end FlowSource;

model PressureSource
  Connector_C pressure;
  parameter Real P;
equation
  pressure.c = P;
  pressure.Zc = 0;
end PressureSource;

model HydraulicAlternativePRV
  Connector_Q left;
  Connector_Q right;

  parameter Real Pref = 20000000 "Reference Opening Pressure";
  parameter Real cq = 0.67 "Flow Coefficient";
  parameter Real spooldiameter = 0.01 "Spool Diameter";
  parameter Real frac = 1.0 "Fraction of Spool Circumference that is Opening";
  parameter Real W = spooldiameter*frac;
  parameter Real pilotarea = 0.001 "Working Area of Pilot Pressure";
  parameter Real k = 1e6 "Steady State Characteristics of Spring";
  parameter Real c = 1000 "Steady State Damping Coefficient";
  parameter Real m = 0.01 "Mass";
  parameter Real xhyst = 0.0 "Hysteresis of Spool Position";
  constant Real xmax = 0.001 "Maximum Spool Position";
  constant Real xmin = 0 "Minimum Spool Position";

  parameter Real T;
  parameter Real Fs = pilotarea*Pref;

  Real Ftot = left.p*pilotarea - Fs;
  Real Ks = cq*W*x;
  Real x(start = xmin, min = xmin, max = xmax);
  parameter Integer one = 1;

  Real xfrac = x*Pref/xmax;
  Real v = der(xtmp);
  Real a = der(v);
  Real v2 = c*v;
  Real x2 = k*x;
  Real xtmp;
equation
  left.p = left.c + left.Zc*left.q;
  right.p = right.c + right.Zc*right.q;

  left.q  = -right.q;
  right.q = sign(left.c-right.c) * Ks * (noEvent(sqrt(abs(left.c-right.c)+((left.Zc+right.Zc)*Ks)^2/4)) - Ks*(left.Zc+right.Zc)/2);

  xtmp = (Ftot - c*v - m*a)/k;
  x = if noEvent(xtmp < xmin) then xmin else if noEvent(xtmp > xmax) then xmax else xtmp;
end HydraulicAlternativePRV;

model Volume
  parameter Real V;
  parameter Real Be;
  final parameter Real Zc = Be*T/V;
  parameter Real T;

  Connector_C left;
  Connector_C right;
equation
  left.Zc = Zc;
  right.Zc = Zc;
  left.c = delay(right.c+2*Zc*right.q,T);
  right.c = delay(left.c+2*Zc*left.q,T);
end Volume;

model Orifice
  parameter Real K;

  Connector_Q left;
  Connector_Q right;
equation
  left.q = (right.p - left.p)*K;
  right.q = -left.q;
  left.p = left.c + left.Zc*left.q;
  right.p = right.c + right.Zc*right.q;
end Orifice; 

end TLM;

model PRVSystem
  import TLM.{Volume,Orifice,FlowSource,PressureSource,HydraulicAlternativePRV};
  constant Boolean b = false;
  parameter Real T = 1e-4;
  Volume volume1(final V=1e-3,final Be=1e9,final T=T);
  Orifice orifice1(final K=1) if b;
  Volume volume2(final V=1e-3,final Be=1e9,final T=T) if b;
  FlowSource flowSource(flowVal = 1e-5);
  PressureSource pressureSource(P = 1e5);
  HydraulicAlternativePRV hydr(Pref=1e7,cq=0.67,spooldiameter=0.0025,frac=1.0,pilotarea=5e-5,xmax=0.015,m=0.12,c=400,k=150000,T=T);
equation
  connect(flowSource.source,volume1.left);
  if b then
    connect(volume1.right,orifice1.left);
    connect(orifice1.right,volume2.left);
    connect(volume2.right,hydr.left);
  else
    connect(volume1.right,hydr.left);
  end if;
  connect(hydr.right,pressureSource.pressure);
end PRVSystem;
