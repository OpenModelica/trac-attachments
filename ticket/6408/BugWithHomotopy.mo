package BugWithHomotopy

  package Examples
    
    model NetworkModelWithHomotopy
      extends Modelica.Icons.Example;
      extends BugWithHomotopy.Examples.NetworkModelWithoutHomotopy(redeclare Elements.CompositeLoadWithDummyHomotopy composite_load);
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.01),
        __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
        __OpenModelica_simulationFlags(lv = "LOG_NLS,LOG_NLS_V,LOG_STATS", s = "ida"));
    end NetworkModelWithHomotopy;
    model NetworkModelWithoutHomotopy
      extends Modelica.Icons.Example;
      inner BugWithHomotopy.Elements.SystemBase SysData(SBase = 1e+6, fBase = 50) annotation(
        Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-30, -10}, {30, 10}}, rotation = 0)));
      
      parameter Real P_0 = 18.549341834292655e3;
      parameter Real Q_0 = 6.258853e3;
      parameter Real v_0 = 1.0003343 * 20e3;
      parameter Real angle_0 = 1;
      BugWithHomotopy.Elements.ElmVac source(VBase = 20e3, angle_0 = angle_0, v_0 = v_0, P_0 = -P_0, Q_0 = -Q_0) annotation(
        Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant synchronous_frequency(k = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      BugWithHomotopy.Elements.CompositeLoad composite_load(P_0=P_0, Q_0=Q_0, VBase = 20e3, angle_0=angle_0, omega_0 = 1, v_0=v_0) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Step voltage(height = -0.01, offset = v_0 / 20e3, startTime = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(source.p, composite_load.p) annotation(
        Line(points = {{-36, 0}, {0, 0}}, color = {0, 85, 0}));
      connect(composite_load.win, synchronous_frequency.y) annotation(
        Line(points = {{10, 0}, {20, 0}, {20, 30}, {-58, 30}}, color = {0, 0, 127}));
      connect(source.fPu, synchronous_frequency.y) annotation(
        Line(points = {{-46, 6}, {-52, 6}, {-52, 30}, {-58, 30}}, color = {0, 0, 127}));
      connect(voltage.y, source.vPu) annotation(
        Line(points = {{-58, -30}, {-52, -30}, {-52, -4}, {-46, -4}}, color = {0, 0, 127}));
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.01),
        __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
        __OpenModelica_simulationFlags(lv = "LOG_NLS,LOG_NLS_V,LOG_STATS", s = "ida"));
    end NetworkModelWithoutHomotopy;
    extends Modelica.Icons.ExamplesPackage;
  
  end Examples;
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import C = Modelica.Constants;
  import CM = Modelica.ComplexMath;

  package Elements
    
    model ElmVac
      extends Elements.BaseClasses.OnePort;
      SI.Angle phiu;
      Modelica.Blocks.Interfaces.RealInput fPu annotation(
        Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput vPu annotation(
        Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    initial equation
      phiu = angle_0;
    equation
      der(phiu) = 2 * fBase * C.pi * (fPu - 1);
      p.v = VBase * Complex(vPu * cos(phiu), vPu * sin(phiu));
      annotation(
        Icon(graphics = {Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Line(origin = {-5.53254, -0.428994}, points = {{-40, 0}, {-20, 20}, {20, -20}, {40, 0}, {40, 0}})}));
    end ElmVac;
    model CompositeLoad
      extends BugWithHomotopy.Elements.BaseClasses.OnePort(p(i(re(nominal = M_b / VBase), im(nominal = M_b / VBase))));
      parameter SI.PerUnit omega_0 = 1 "Initial frequency" annotation(
        Dialog(group = "Power flow data"));
      // General Parameters
      parameter Real Kpm = 0.8 annotation(
        Dialog(group = "General Parameters"));
      parameter Real Mlf = 0.8 annotation(
        Dialog(group = "General Parameters"));
      // Parmeters of the exp model
      parameter Real expP = 2 annotation(
        Dialog(group = "Exponential Load Model Parameters"));
      parameter Real expQ = 2 annotation(
        Dialog(group = "Exponential Load Model Parameters"));
      // Parameters of the induction machine
      parameter SI.PerUnit Rs = 0.028 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xs = 0.01 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xm = 4.236 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Rr = 0.00489 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xr = 0.1822 annotation(
        Dialog(group = "Machine Parameters"));
      parameter Real H = 1.67 annotation(
        Dialog(group = "Machine Parameters"));
      parameter Real expT = 2 annotation(
        Dialog(group = "Machine Parameters"));
      final parameter Real omega_base = 2 * C.pi * fBase;
      // Active and reactive powers
      final parameter Types.ActivePower Pm_0 = Kpm * P_0;
      final parameter Types.ApparentPower M_b = Pm_0 / Mlf;
      final parameter Types.ActivePower Pexp_0 = P_0 - Pm_0;
      final parameter Types.ReactivePower Qexp_0(fixed = false);
      final parameter Real x_ss = Xs + Xm;
      final parameter Real x_sr = Xm;
      final parameter Real x_rr = Xr + Xm;
      final parameter Real r_r = Rr;
      final parameter Real r_s = Rs;
      final parameter Real xhat = x_ss - x_sr / x_rr * x_sr;
      // Start parameters
      parameter Types.ComplexCurrent I_m0 = Complex(i_sd0, i_sq0) * M_b / VBase;
      parameter Types.ComplexCurrent I_e0 = I_0 - I_m0;
      final parameter SI.PerUnit u_sd0 = v_0 * cos(angle_0) / VBase;
      final parameter SI.PerUnit u_sq0 = v_0 * sin(angle_0) / VBase;
      final parameter SI.PerUnit psi_rd0(fixed = false);
      final parameter SI.PerUnit psi_rq0(fixed = false);
      final parameter SI.PerUnit psi_sq0(fixed = false);
      final parameter SI.PerUnit psi_sd0(fixed = false);
      final parameter SI.PerUnit i_sd0(start = I_0.re / (M_b / VBase), fixed = false);
      final parameter SI.PerUnit i_sq0(start = I_0.im / (M_b / VBase), fixed = false);
      final parameter SI.PerUnit w_0(start = omega_0, fixed = false);
      // Model variables
      // Angle w.r.t. the reference angle in the 50Hz rotating frame
      SI.PerUnit delta;
      // Synchronous frequency
      Modelica.Blocks.Interfaces.RealInput win annotation(
        Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Types.ComplexCurrent imach(re(start = I_m0.re), im(start = I_m0.im));
      Types.ComplexCurrent iexp(re(start = I_e0.re), im(start = I_e0.im));
      SI.PerUnit wr(start = w_0);
      SI.PerUnit psi_rd(start = psi_rd0);
      SI.PerUnit psi_rq(start = psi_rq0);
      SI.PerUnit psi_sd(start = psi_sd0);
      SI.PerUnit psi_sq(start = psi_sq0);
      SI.PerUnit i_sd(start = i_sd0);
      SI.PerUnit i_sq(start = i_sq0);
      SI.PerUnit u_sd(start = u_sd0);
      SI.PerUnit u_sq(start = u_sq0);
      SI.PerUnit T_m(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
      SI.PerUnit T_e(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
      SI.PerUnit T_0(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
    initial equation
// Start values for the machine model
      0 = r_r / x_rr * x_sr * i_sd0 - r_r / x_rr * psi_rd0 + (omega_0 - w_0) * psi_rq0;
      0 = r_r / x_rr * x_sr * i_sq0 - r_r / x_rr * psi_rq0 - (omega_0 - w_0) * psi_rd0;
      psi_sd0 = xhat * i_sd0 + x_sr / x_rr * psi_rd0;
      psi_sq0 = xhat * i_sq0 + x_sr / x_rr * psi_rq0;
      u_sd0 = r_s * i_sd0 - omega_0 / 1 * psi_sq0;
      u_sq0 = r_s * i_sq0 + omega_0 / 1 * psi_sd0;
      Pm_0 / M_b = u_sd0 * i_sd0 + u_sq0 * i_sq0;
// Initialization
      Qexp_0 = Q_0 - (u_sq * i_sd - u_sd * i_sq) * M_b;
      P = P_0;
      delta = 0;
      der(wr) = 0;
      der(psi_rd) = 0;
      der(psi_rq) = 0;
    equation
// Integration of frequency differences to determine delta for d-q transformation
      der(delta) = omega_base * (win - 1);
// d-q transformations
      [u_sd; u_sq] * VBase = [cos(delta), sin(delta); -sin(delta), cos(delta)] * [p.v.re; p.v.im];
      [i_sd; i_sq] * (M_b / VBase) = [cos(delta), sin(delta); -sin(delta), cos(delta)] * [imach.re; imach.im];
// Mechanical equations
      der(T_0) = 0;
      T_m = T_0 * wr ^ expT;
      T_e = (-i_sd * psi_sq) + i_sq * psi_sd;
      der(wr) = 1 / (2 * H) * (T_e - T_m);
// Electrical equations
      u_sd = r_s * i_sd - win / 1 * psi_sq;
      u_sq = r_s * i_sq + win / 1 * psi_sd;
      psi_sd = xhat * i_sd + x_sr / x_rr * psi_rd;
      psi_sq = xhat * i_sq + x_sr / x_rr * psi_rq;
      der(psi_rd) / omega_base = r_r / x_rr * x_sr * i_sd - r_r / x_rr * psi_rd + (win - wr) * psi_rq;
      der(psi_rq) / omega_base = r_r / x_rr * x_sr * i_sq - r_r / x_rr * psi_rq - (win - wr) * psi_rd;
// Exponential load model
      p.v * CM.conj(iexp) = Complex(Pexp_0 * (CM.'abs'(p.v) / v_0) ^ expP, Qexp_0 * (CM.'abs'(p.v) / v_0) ^ expQ);
      p.i = imach + iexp;
      annotation(
        Icon(graphics = {Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Text(origin = {-40.989, -17}, extent = {{-39.011, -3}, {118.989, -63}}, textString = "COMPOSITE")}, coordinateSystem(initialScale = 0.1)));
    end CompositeLoad;
    
    model CompositeLoadWithDummyHomotopy
      extends BugWithHomotopy.Elements.BaseClasses.OnePort(p(i(re(nominal = M_b / VBase), im(nominal = M_b / VBase))));
      parameter SI.PerUnit omega_0 = 1 "Initial frequency" annotation(
        Dialog(group = "Power flow data"));
      // General Parameters
      parameter Real Kpm = 0.8 annotation(
        Dialog(group = "General Parameters"));
      parameter Real Mlf = 0.8 annotation(
        Dialog(group = "General Parameters"));
      // Parmeters of the exp model
      parameter Real expP = 2 annotation(
        Dialog(group = "Exponential Load Model Parameters"));
      parameter Real expQ = 2 annotation(
        Dialog(group = "Exponential Load Model Parameters"));
      // Parameters of the induction machine
      parameter SI.PerUnit Rs = 0.028 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xs = 0.01 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xm = 4.236 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Rr = 0.00489 annotation(
        Dialog(group = "Machine Parameters"));
      parameter SI.PerUnit Xr = 0.1822 annotation(
        Dialog(group = "Machine Parameters"));
      parameter Real H = 1.67 annotation(
        Dialog(group = "Machine Parameters"));
      parameter Real expT = 2 annotation(
        Dialog(group = "Machine Parameters"));
      final parameter Real omega_base = 2 * C.pi * fBase;
      // Active and reactive powers
      final parameter Types.ActivePower Pm_0 = Kpm * P_0;
      final parameter Types.ApparentPower M_b = Pm_0 / Mlf;
      final parameter Types.ActivePower Pexp_0 = P_0 - Pm_0;
      final parameter Types.ReactivePower Qexp_0(fixed = false);
      final parameter Real x_ss = Xs + Xm;
      final parameter Real x_sr = Xm;
      final parameter Real x_rr = Xr + Xm;
      final parameter Real r_r = Rr;
      final parameter Real r_s = Rs;
      final parameter Real xhat = x_ss - x_sr / x_rr * x_sr;
      // Start parameters
      parameter Types.ComplexCurrent I_m0 = Complex(i_sd0, i_sq0) * M_b / VBase;
      parameter Types.ComplexCurrent I_e0 = I_0 - I_m0;
      final parameter SI.PerUnit u_sd0 = v_0 * cos(angle_0) / VBase;
      final parameter SI.PerUnit u_sq0 = v_0 * sin(angle_0) / VBase;
      final parameter SI.PerUnit psi_rd0(fixed = false);
      final parameter SI.PerUnit psi_rq0(fixed = false);
      final parameter SI.PerUnit psi_sq0(fixed = false);
      final parameter SI.PerUnit psi_sd0(fixed = false);
      final parameter SI.PerUnit i_sd0(start = I_0.re / (M_b / VBase), fixed = false);
      final parameter SI.PerUnit i_sq0(start = I_0.im / (M_b / VBase), fixed = false);
      final parameter SI.PerUnit w_0(start = omega_0, fixed = false);
      // Model variables
      // Angle w.r.t. the reference angle in the 50Hz rotating frame
      SI.PerUnit delta;
      // Synchronous frequency
      Modelica.Blocks.Interfaces.RealInput win annotation(
        Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Types.ComplexCurrent imach(re(start = I_m0.re), im(start = I_m0.im));
      Types.ComplexCurrent iexp(re(start = I_e0.re), im(start = I_e0.im));
      SI.PerUnit wr(start = w_0);
      SI.PerUnit psi_rd(start = psi_rd0);
      SI.PerUnit psi_rq(start = psi_rq0);
      SI.PerUnit psi_sd(start = psi_sd0);
      SI.PerUnit psi_sq(start = psi_sq0);
      SI.PerUnit i_sd(start = i_sd0);
      SI.PerUnit i_sq(start = i_sq0);
      SI.PerUnit u_sd(start = u_sd0);
      SI.PerUnit u_sq(start = u_sq0);
      SI.PerUnit T_m(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
      SI.PerUnit T_e(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
      SI.PerUnit T_0(start = (-i_sd0 * psi_sq0) + i_sq0 * psi_sd0);
    initial equation
// Start values for the machine model
      0 = r_r / x_rr * x_sr * i_sd0 - r_r / x_rr * psi_rd0 + (omega_0 - w_0) * psi_rq0;
      0 = r_r / x_rr * x_sr * i_sq0 - r_r / x_rr * psi_rq0 - (omega_0 - w_0) * psi_rd0;
      psi_sd0 = xhat * i_sd0 + x_sr / x_rr * psi_rd0;
      psi_sq0 = xhat * i_sq0 + x_sr / x_rr * psi_rq0;
      u_sd0 = r_s * i_sd0 - omega_0 / 1 * psi_sq0;
      u_sq0 = r_s * i_sq0 + omega_0 / 1 * psi_sd0;
      Pm_0 / M_b = u_sd0 * i_sd0 + u_sq0 * i_sq0;
// Initialization
      Qexp_0 = Q_0 - (u_sq * i_sd - u_sd * i_sq) * M_b;
      P = P_0;
      delta = 0;
      der(wr) = 0;
      der(psi_rd) = 0;
      der(psi_rq) = 0;
    equation
// Integration of frequency differences to determine delta for d-q transformation
      der(delta) = omega_base * (win - 1);
// d-q transformations
      [u_sd; u_sq] * VBase = [cos(delta), sin(delta); -sin(delta), cos(delta)] * [p.v.re; p.v.im];
      [i_sd; i_sq] * (M_b / VBase) = [cos(delta), sin(delta); -sin(delta), cos(delta)] * [imach.re; imach.im];
// Mechanical equations
      der(T_0) = 0;
      T_m = homotopy(T_0 * wr ^ expT, T_0 * wr ^ 0);
      T_e = (-i_sd * psi_sq) + i_sq * psi_sd;
      der(wr) = 1 / (2 * H) * (T_e - T_m);
// Electrical equations
      u_sd = r_s * i_sd - win / 1 * psi_sq;
      u_sq = r_s * i_sq + win / 1 * psi_sd;
      psi_sd = xhat * i_sd + x_sr / x_rr * psi_rd;
      psi_sq = xhat * i_sq + x_sr / x_rr * psi_rq;
      der(psi_rd) / omega_base = r_r / x_rr * x_sr * i_sd - r_r / x_rr * psi_rd + (win - wr) * psi_rq;
      der(psi_rq) / omega_base = r_r / x_rr * x_sr * i_sq - r_r / x_rr * psi_rq - (win - wr) * psi_rd;
// Exponential load model
      p.v * CM.conj(iexp) = Complex(Pexp_0 * (CM.'abs'(p.v) / v_0) ^ expP, Qexp_0 * (CM.'abs'(p.v) / v_0) ^ expQ);
      p.i = imach + iexp;
      annotation(
        Icon(graphics = {Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Text(origin = {-40.989, -17}, extent = {{-39.011, -3}, {118.989, -63}}, textString = "COMPOSITE")}, coordinateSystem(initialScale = 0.1)));
    end CompositeLoadWithDummyHomotopy;
    
    record SystemBase "System Base Definition"
      parameter SI.ApparentPower SBase(displayUnit = "MVA") = 100e6 "System base" annotation(
        Evaluate = true);
      parameter SI.Frequency fBase = 50 "System frequency" annotation(
        Evaluate = true);
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-120, -100}, {120, 100}}), graphics = {Rectangle(extent = {{-120, 100}, {120, -100}}, lineColor = {28, 108, 200}), Text(extent = {{-100, 40}, {100, 0}}, lineColor = {28, 108, 200}, horizontalAlignment = TextAlignment.Left, textString = "System Base: %S_b"), Text(extent = {{-100, -20}, {100, -60}}, lineColor = {28, 108, 200}, horizontalAlignment = TextAlignment.Left, textString = "Frequency: %fn"), Text(extent = {{-100, 100}, {100, 60}}, lineColor = {28, 108, 200}, horizontalAlignment = TextAlignment.Center, textString = "System Data")}),
        defaultComponentName = "SysData",
        defaultComponentPrefixes = "inner",
        missingInnerMessage = "
    No 'System Data' component is defined. A default component will be used, and generate a system base of 100 MVA, and a frequency of 50 Hz",
        Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}}, preserveAspectRatio = false)),
        defaultComponentPrefixes = "inner");
    end SystemBase;
    
    package BaseClasses
      
      partial model OnePort
        outer BugWithHomotopy.Elements.SystemBase SysData;
        parameter Types.ApparentPower SBase = SysData.SBase "System base power" annotation (Evaluate = true);
        parameter SI.Frequency fBase=SysData.fBase "System frequency" annotation ( Evaluate = true,Dialog(group="Power flow data"));  
        parameter Types.Voltage VBase "Base voltage of the element" annotation (Evaluate = true, Dialog(group="Power flow data"));
        
        parameter Types.ActivePower P_0 "Initial active power" annotation (Dialog(group="Power flow data"));
        parameter Types.ReactivePower Q_0 "Initial reactive power" annotation (Dialog(group="Power flow data"));
        parameter Types.Voltage v_0 "Initial voltage magnitude (pu)" annotation (Dialog(group="Power flow data"));
        parameter Types.Angle angle_0 "Initial voltage angle" annotation (Dialog(group="Power flow data"));
        
        parameter Types.ComplexVoltage U_0 = Complex(v_0*cos(angle_0), v_0*sin(angle_0));
        parameter Types.ComplexPower S_0 = Complex(P_0, Q_0);
        parameter Types.ComplexCurrent I_0 = CM.conj(S_0/U_0);
        BugWithHomotopy.Interfaces.terminal p(
        v(re(nominal = VBase, start=U_0.re), im(nominal = VBase, start=U_0.im)),
        i(re(nominal = SBase/VBase, start=I_0.re), im(nominal = SBase/VBase, start=I_0.im))) annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
        Types.ActivePower P = S.re;
        Types.ReactivePower Q = S.im;
        Types.ComplexPower S=p.v*CM.conj(p.i);
      end OnePort;
      
      extends Modelica.Icons.BasesPackage;
    
    end BaseClasses;
    extends Modelica.Icons.Package;
  
  end Elements;
  
  package Types
    
    operator record ComplexPerUnit = Complex(re(unit = "1"), im(unit = "1"));
    
    
    operator record ComplexVoltage = SI.ComplexVoltage(re(nominal = 1e4, displayUnit="kV"), im(nominal = 1e4, displayUnit="kV"));
    
    
    operator record ComplexCurrent = SI.ComplexCurrent(re(nominal = 1e4, displayUnit="kA"), im(nominal = 1e4, displayUnit="kA"));
    
    
    operator record ComplexPower = SI.ComplexPower(re(nominal = 1e8, displayUnit="MW"), im(nominal = 1e8, displayUnit="MVA"));
    
    
    type ReactivePower = SI.ReactivePower(nominal = 1e6, displayUnit = "MVA");
    
    
    type ActivePower = SI.ActivePower(nominal = 1e6, displayUnit = "MW");
    
    
    type ApparentPower = SI.ApparentPower(nominal = 1e6, displayUnit = "MVA");
    
    
    type Angle = SI.Angle;
    
    
    type Voltage = SI.Voltage(nominal = 20e3, displayUnit = "kV");
    
    extends Modelica.Icons.TypesPackage;
  
  end Types;
  
  package Interfaces
    
    connector terminal "Connector for electrical blocks treating voltage and current as complex variables"
      Types.ComplexVoltage v(re(nominal=20e3, start=20e3), im(nominal=20e3, start=0)) "Voltage phasor";
      flow Types.ComplexCurrent i(re(nominal=1e6/20e3),im(nominal=1e6/20e3)) "Current phasor";
      annotation(
        Icon(graphics = {Rectangle(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}),
        Diagram(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-100, 160}, {100, 120}}, textString = "%name"), Rectangle(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end terminal;
    
    extends Modelica.Icons.InterfacesPackage;
  
  end Interfaces;
end BugWithHomotopy;
