package NewFEbug1
  import SI = Modelica.SIunits;
  
  connector ODF_AB "Base port for oleodynamic components"
    SI.Pressure p "pressure";
    flow SI.MassFlowRate w "mass flowrate";
    annotation(
      Icon(coordinateSystem(grid = {1, 1}, initialScale = 0.1), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {255, 128, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "<html><head></head><body>base port to exchange olodynamic fluid between components.<div><br></div><div>(c) Dynamica - all right reserved</div></body></html>"));
  end ODF_AB;

  connector ODF_P "port to exchange olodynamic fluid - side P"
    extends ODF_AB;
    annotation(
      Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}, lineColor = {255, 128, 0}, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid)}),
      Documentation(info = "<html><head></head><body><br><div><br></div><div><span style=\"font-size: 12px;\">(c) Dynamica - all right reserved</span></div></body></html>"));
  end ODF_P;

  connector ODF_T
    extends ODF_AB;
    annotation(
      Icon(graphics = {Ellipse(lineColor = {255, 128, 0}, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Ellipse(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
  end ODF_T;

  model ImposedPressure "Node with imposed Pressure, independently from the oil flow"
    final constant Real NotUsed = Modelica.Constants.inf;
    parameter SI.Pressure p0 = NotUsed "imposed pressure if not use_in_p0";
    parameter Boolean use_in_p0 = false "use connector input for the pressure" annotation(
      Dialog(group = "External inputs"),
      choices(checkBox = true));
    // variables
    SI.Pressure p "Actual pressure";
    // interface
    ODF_P fl_P annotation(
      Placement(visible = true, transformation(origin = {88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    // conditional interface
    Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation(
      Placement(transformation(origin = {-40, 92}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  protected
    Modelica.Blocks.Interfaces.RealInput in_p0_internal;
  equation
    fl_P.p = p;
    p = in_p0_internal;
// Conditional connectors
    if not use_in_p0 then
      in_p0_internal = p0 "Pressure set by parameter";
    end if;
    connect(in_p0, in_p0_internal);
    annotation(
      Diagram(graphics),
      Icon(graphics = {Ellipse(fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}, endAngle = 360), Text(lineColor = {255, 255, 255}, extent = {{-20, 34}, {28, -26}}, textString = "P", fontName = "DejaVu Sans Mono"), Text(lineColor = {0, 0, 255}, extent = {{-100, -78}, {100, -106}}, textString = "%name", fontName = "DejaVu Sans Mono"), Text(extent = {{-106, 90}, {-52, 50}}, textString = "p0")}));
  end ImposedPressure;
  
partial model FlexiblePipeRC
  constant Real pi = 3.1415;
  import g = Modelica.Constants.g_n; 
  parameter Boolean calculatesTimeConstants = false "=true, to activate the calculation of typical time constant (not used by the model)";
  parameter Boolean oilCompressibility = true "= true, if oil compressibility is used";
  parameter Boolean FlangePatBottom = false "= true, if flange P is at bottom of not-horizontal pipe";
  parameter Integer N(min=1) = 1 "number of pipe segments";
  parameter SI.Temperature Toil = 293.15 "Oil temperature";
  parameter SI.Length d "pipe diameter";
  parameter SI.Length L "pipe length";
  parameter SI.Length h(min = 0) "pipe vertical total elevation (always positive or null), relevant to bottom flange";
  parameter SI.Length tk "pipe thickness";
  parameter SI.BulkModulus E "Young's modulus of pipe";
  parameter SI.Pressure pP_start "Start value of pressure at flange P" annotation(
    Dialog(tab = "Initialization"));
  parameter SI.Pressure pT_start = pP_start + rhoOil_start*g*z_tot "Start value of pressure at flange T" annotation(
    Dialog(tab = "Initialization"));
  final parameter SI.Length z_tot = if FlangePatBottom then -h else h "pipe vertical elevation from P to T flange, with signum";
  final parameter SI.Density rhoOil_start = 980 "start oil density";
  final parameter SI.Area A = 0.25*pi*d^2 "pipe cross-section";
  final parameter SI.Length dl = L/N "length of each pipe segment";
  final parameter SI.BulkModulus Kpipe = E*tk/d "pipe bulk modulus";
  final parameter SI.BulkModulus Koil = 1e9 "oil bulk modulus";
  final parameter SI.KinematicViscosity kinVisc = 3.5 "oil kinematic viscosity";
  final parameter SI.Length z[N+1](each fixed=false) "elevation profile, one value for each pipe node";
  final parameter Real I(final unit="1/m") = dl/A "segment equivalent inertance";
  final parameter SI.Pressure p_start[N] = linspace(pP_start, pT_start, N) "start pressure profile";
  
  //variables, pipe left/bottom side is for index=0
  SI.Density rho[N](each start = rhoOil_start) "oil density profile, one value for each segment";  
  SI.Volume V[N](each start = A*dl) "pipe volume profile, one value for each segment";  
  SI.MassFlowRate w[N+1] "mass flowrate profile, one value for each node";
  SI.Pressure p[N](start = p_start, each fixed = true) "pressure profile, one value for each segment";
  SI.Mass M[N] "oil mass profile, one value for each segment";  
  SI.PerUnit Re[N+1] "Reynolds Number profile, one value for node";
  SI.Pressure Dpstat[N] "static pressure drop, one value for each segment";
  SI.Pressure Dpfric[N+1] "friction pressure drop, one value for each node";
  SI.Pressure dpTot = fl_P.p - fl_T.p "total delta pressure across pipe, for monitoring only";

  Real C[N](each final unit="m.s2") "segment equivalent capacity";
  Real R[N](each final unit="1/(m.s)") "segment equivalent resistance";
  SI.Time TauWave[N], TauRC[N], TauRL[N] "typical time constants";
  
  //interfaces
  ODF_P fl_P annotation(
    Placement(visible = true, transformation(origin = {-106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ODF_T fl_T annotation(
    Placement(visible = true, transformation(origin = {106, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

initial algorithm
  for i in 1:N+1 loop
    z[i] := if FlangePatBottom then (i-1)*h/N else h - (i-1)*h/N;
  end for;
  assert(h>=0, "elevation cannot be negative");
  
equation
  //Reynolds Number profile calculation
  for k in 1:N loop
    Re[k] = abs(w[k])*d/(rho[k]*A*kinVisc);
  end for;
  Re[N+1] = abs(w[N+1])*d/(rho[N]*A*kinVisc);
   
  //Static head profile calculation
  for i in 1:N loop
    Dpstat[i] = rho[i]*g*(z[i+1] - z[i]);
  end for;
  
  //Mass Balance @ SEGMENTS
  for i in 1:N loop
    M[i] = V[i]*rho[i];
    der(M[i]) = w[i] - w[i+1];
    V[i] = A*dl*(1 + (p[i] - p_start[i])/Kpipe);
    if oilCompressibility then
      rho[i] = rhoOil_start*(1 + (p[i] - 1e9)/Koil);
    else
      rho[i] = rhoOil_start;
    end if;
  end for;

  //Momentum balance @ NODES
  (p[1] - fl_P.p) + Dpstat[1]/2 + Dpfric[1] = 0; 
  for j in 2:N loop
    (p[j] - p[j-1]) + Dpstat[j-1]/2 + Dpstat[j]/2 + Dpfric[j] = 0; 
  end for;
  (fl_T.p - p[N]) + Dpstat[N]/2 + Dpfric[N+1] = 0; 
  
  //boundary conditions
  w[1] = fl_P.w;
  w[N+1] = -fl_T.w;

  //Typical time constants
  if calculatesTimeConstants then
    if N == 1 then
      R[1] = if abs(w[1]) > 1e-6 and  abs(w[2]) > 1e-6 then Dpfric[1]/w[1] + Dpfric[2]/w[2] else 0;
    else
      R[1] = if abs(w[1]) > 1e-6 and  abs(w[2]) > 1e-6 then Dpfric[1]/w[1] + (Dpfric[2]/w[2])/2 else 0; 
      R[N] = if abs(w[N]) > 1e-6 and  abs(w[N+1]) > 1e-6 then (Dpfric[N]/w[N])/2 + Dpfric[N+1]/w[N+1] else 0;
    end if;
    for i in 2:N-1 loop
      R[i] = if abs(w[i]) > 1e-6 and  abs(w[i+1]) > 1e-6 then (Dpfric[i]/w[i])/2 + (Dpfric[i+1]/w[i+1])/2 else 0;
    end for;
 
    for i in 1:N loop
      C[i] = rho[i]*A*dl/Kpipe;
      TauWave[i] = sqrt(I*C[i]);
      TauRC[i] = R[i]*C[i];
      TauRL[i] = if R[i] > 1e-6 then I/R[i] else 0;
    end for;
  else
    R = fill(0,N);  
    C = fill(0,N);  
    TauWave = fill(0,N);  
    TauRC = fill(0,N);
    TauRL = fill(0,N);  
  end if;

annotation(
 Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(origin = {-22, -46}, points = {{-60, 20}, {76, 20}}, color = {255, 128, 0}), Polygon(origin = {63.72, -26}, lineColor = {255, 128, 0}, fillColor = {255, 128, 0}, fillPattern = FillPattern.Solid, points = {{-9.72361, 10}, {10.2764, 0}, {-9.72361, -10}, {-9.72361, 10}, {-9.72361, 10}}), Text(origin = {-45, -14}, extent = {{-5, 20}, {95, 4}}, textString = "FLEXIBLE RC"), Rectangle(extent = {{-100, 20}, {100, -20}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
      
end FlexiblePipeRC;
  
model FlexiblePipeRCLaminar
  extends FlexiblePipeRC;

equation
  // laminar friction losses calculation
  Dpfric[1] = 32*kinVisc*(dl/2)*w[1]/(A*d^2);
  for j in 2:N loop
    Dpfric[j] = 32*kinVisc*dl*w[j]/(A*d^2);
  end for;
  Dpfric[N+1] = 32*kinVisc*(dl/2)*w[N+1]/(A*d^2);

  annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-3, 24}, extent = {{-41, 12}, {49, -8}}, textString = "Laminar")}));
      
end FlexiblePipeRCLaminar;
  
model TestFlexiblePipeRCFilling
  extends Modelica.Icons.Example;
  FlexiblePipeRCLaminar flexiblePipeLaminar1(E(displayUnit = "Pa") = 2.06e+08, L = 500, N = 10, d = 0.00277, h = 500, pP_start = 100000, tk = 0.0018) annotation(
    Placement(visible = true, transformation(origin = {-38, -2.66454e-15}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  ImposedPressure imposedPressure1Lam(use_in_p0 = true) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid Pset(amplitude = 600e5, falling = 5, nperiod = 1, offset = 1e5, period = 410, rising = 5, startTime = 2, width = 200) annotation(
    Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Pset.y, imposedPressure1Lam.in_p0) annotation(
      Line(points = {{-118, 30}, {-94, 30}, {-94, 10}, {-94, 10}}, color = {0, 0, 127}));
  connect(imposedPressure1Lam.fl_P, flexiblePipeLaminar1.fl_P) annotation(
      Line(points = {{-80, 0}, {-60, 0}, {-60, 0}, {-60, 0}}, color = {255, 128, 0}));
    annotation(
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 400, Tolerance = 1e-06, Interval = 0.2));
end TestFlexiblePipeRCFilling;
  
  
  
  
  annotation(
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end NewFEbug1;