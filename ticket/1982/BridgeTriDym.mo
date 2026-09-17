within ;
model BridgeTriDym "Three-phase diode bridge"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Analog.Ideal;
  parameter Modelica.SIunits.Voltage VAC=400 "RMS line-to-line";
  parameter Modelica.SIunits.Frequency f=50 "line frequency";
  parameter Modelica.SIunits.Inductance LAC=60E-6 "line inductor";
  parameter Modelica.SIunits.Resistance Ron=1E-3 "diode forward resistance";
  parameter Modelica.SIunits.Conductance Goff=1E-3 "diode backward conductance";
  parameter Modelica.SIunits.Voltage Vknee=2 "diode threshold voltage";
  parameter Modelica.SIunits.Capacitance CDC=15E-6 "DC capacitance";
  parameter Modelica.SIunits.Current IDC=500 "load current";

public
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(freqHz=f,
       V=VAC*sqrt(2/3))
                      annotation (Placement(transformation(extent={{-70,10},{
            -90,30}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage2(
    freqHz=f,
    phase=-2/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3))
                   annotation (Placement(transformation(extent={{-70,-10},{-90,
            10}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage3(
    freqHz=f,
    phase=-4/3*Modelica.Constants.pi,
    V=VAC*sqrt(2/3))
                   annotation (Placement(transformation(extent={{-70,-30},{-90,
            -10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Inductor1(L=LAC)
  annotation (Placement(transformation(extent={{-60,10},{-40,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Inductor2(L=LAC)
  annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Inductor3(L=LAC)
  annotation (Placement(transformation(extent={{-60,-30},{-40,-10}}, rotation=0)));
  Ideal.IdealDiode IdealDiode1(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={-20,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode2(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={0,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode3(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={20,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode4(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={-20,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode5(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Ideal.IdealDiode IdealDiode6(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee)
    annotation (Placement(transformation(
        origin={20,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Ground Ground1
  annotation (Placement(transformation(extent={{40,-80},{60,-60}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor Ldc(L=50e-3)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={58,-12})));
  Modelica.Electrical.Analog.Basic.Resistor Rdc(R=10)       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,24})));
equation

  connect(SineVoltage1.n, SineVoltage2.n)
    annotation (Line(points={{-90,20},{-90,0}}, color={0,0,255}));
  connect(SineVoltage2.n, SineVoltage3.n)
    annotation (Line(points={{-90,0},{-90,-20}}, color={0,0,255}));
  connect(SineVoltage1.p, Inductor1.p)
    annotation (Line(points={{-70,20},{-60,20}}, color={0,0,255}));
  connect(SineVoltage2.p, Inductor2.p)
    annotation (Line(points={{-70,0},{-67.5,0},{-67.5,1.22125e-015},{-65,
          1.22125e-015},{-65,0},{-60,0}},      color={0,0,255}));
  connect(SineVoltage3.p, Inductor3.p)
    annotation (Line(points={{-70,-20},{-60,-20}}, color={0,0,255}));
  connect(IdealDiode1.p, IdealDiode4.n)
    annotation (Line(points={{-20,30},{-20,-30}}, color={0,0,255}));
  connect(IdealDiode2.p, IdealDiode5.n)
    annotation (Line(points={{-6.12323e-016,30},{-6.12323e-016,16},{0,0},{0,-30},
          {6.12323e-016,-30}}, color={0,0,255}));
  connect(IdealDiode3.p, IdealDiode6.n)
    annotation (Line(points={{20,30},{20,-30}}, color={0,0,255}));
  connect(IdealDiode1.n, IdealDiode2.n)
    annotation (Line(points={{-20,50},{6.12323e-016,50}}, color={0,0,255}));
  connect(IdealDiode2.n, IdealDiode3.n)
    annotation (Line(points={{6.12323e-016,50},{20,50}}, color={0,0,255}));
  connect(IdealDiode4.p, IdealDiode5.p)
    annotation (Line(points={{-20,-50},{-6.12323e-016,-50}}, color={0,0,255}));
  connect(IdealDiode5.p, IdealDiode6.p)
    annotation (Line(points={{-6.12323e-016,-50},{20,-50}}, color={0,0,255}));
  connect(Inductor1.n, IdealDiode1.p)
    annotation (Line(points={{-40,20},{-20,20},{-20,30}}, color={0,0,255}));
  connect(Inductor3.n, IdealDiode3.p)
    annotation (Line(points={{-40,-20},{20,-20},{20,30}}, color={0,0,255}));
  connect(Ground1.p, IdealDiode6.p) annotation (Line(
      points={{50,-60},{50,-50},{20,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Ldc.n, IdealDiode6.p)       annotation (Line(
      points={{58,-22},{58,-50},{20,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Rdc.n, Ldc.p)            annotation (Line(
      points={{58,14},{58,-2}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Inductor2.n, IdealDiode5.n) annotation (Line(
      points={{-40,0},{6.12323e-016,0},{6.12323e-016,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(IdealDiode3.n, Rdc.p) annotation (Line(
      points={{20,50},{40,50},{40,52},{58,52},{58,34},{58,34}},
      color={0,0,255},
      smooth=Smooth.None));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}),
                    graphics),
  experiment(StopTime=0.1, NumberOfIntervals=1000),
  Documentation(info="<html>
<p>The rectifier example shows a B6 diode bridge fed by a three phase sinusoidal voltage, loaded by a DC current. 
DC capacitors start at ideal no-load voltage, thus making easier initial transient.</p>
<p>Simulate until T=0.1 s. Plot in separate windows:
<br>uDC ... DC-voltage
<br>iAC ... AC-currents 1..3
<br>uAC ... AC-voltages 1..3 (distorted)
<br>Try different load currents iDC = 0..approximately 500 A. You may watch losses (of the whole diode bridge) trying different diode parameters.</p>
</html>",
   revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 7, 2004   </i>
       by Anton Haumer<br> realized<br>
       </li>
</ul>
</html>"),
    uses(Modelica(version="3.2")),
    __Dymola_experimentSetupOutput);
end BridgeTriDym;
