model invTrifNotWorking
  Modelica.Electrical.MultiPhase.Basic.Star star2 annotation(Placement(visible = true, transformation(origin = {56,-36}, extent = {{10,-10},{-10,10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor Rload(R = fill(30, 3)) annotation(Placement(visible = true, transformation(origin = {56,-10}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Capacitor Cf(C = fill(0.000634, 3)) annotation(Placement(visible = true, transformation(origin = {24,-10}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Basic.Star star1 annotation(Placement(visible = true, transformation(origin = {-50,-60}, extent = {{10,-10},{-10,10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(Placement(visible = true, transformation(origin = {-50,58}, extent = {{-10,-10},{10,10}}, rotation = 90)));
  Modelica.Electrical.MultiPhase.Ideal.IdealOpeningSwitch downSW annotation(Placement(visible = true, transformation(origin = {-50,-30}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Electrical.MultiPhase.Ideal.IdealOpeningSwitch upSW annotation(Placement(visible = true, transformation(origin = {-50,30}, extent = {{-10,-10},{10,10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant ampl[3](k = 0.7) annotation(Placement(visible = true, transformation(origin = {82,68}, extent = {{-10,10},{10,-10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant phase[3](k = -array(120 * (j - 1) for j in 1:3)) annotation(Placement(visible = true, transformation(origin = {82,30}, extent = {{-10,10},{10,-10}}, rotation = 180)));
  PwmPulser pwmPulser[3] annotation(Placement(visible = true, transformation(origin = {23,52}, extent = {{-13,13},{13,-13}}, rotation = 180)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 100) annotation(Placement(visible = true, transformation(origin = {-84,2}, extent = {{-10,10},{10,-10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {56,-44}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Inductor Lf(L = fill(0.001, 3)) annotation(Placement(visible = true, transformation(origin = {8,9}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Resistor Rf(R = fill(0.125, 3)) annotation(Placement(visible = true, transformation(origin = {-18,9}, extent = {{-10,-10},{10,10}}, rotation = 0)));
equation
  connect(Rf.plug_n,Lf.plug_p) annotation(Line(points = {{-8,9},{-2,9}}, color = {0,0,255}));
  connect(Rf.plug_p,downSW.plug_p) annotation(Line(points = {{-28,9},{-50,9},{-50,0}}, color = {0,0,255}));
  connect(Cf.plug_p,Lf.plug_n) annotation(Line(points = {{24,0.000000000000000555112},{18,9}}, color = {0,0,255}));
  connect(ground1.p,star2.pin_n) annotation(Line(points = {{56,-34},{56,-26}}, color = {0,0,255}));
  connect(V1.n,star1.pin_n) annotation(Line(points = {{-84,-8},{-84,-70},{-50,-70}}, color = {0,0,255}));
  connect(star.pin_n,V1.p) annotation(Line(points = {{-50,68},{-84,68},{-84,12}}, color = {0,0,255}));
  connect(pwmPulser.Bot,downSW.control) annotation(Line(points = {{8.7,44.46},{-20,44.46},{-20,20},{-34,20},{-34,-30},{-43,-30}}, color = {255,0,255}));
  connect(pwmPulser.Top,upSW.control) annotation(Line(points = {{8.7,60.58},{-26,60.58},{-26,30},{-43,30}}, color = {255,0,255}));
  connect(ampl.y,pwmPulser.Ampl) annotation(Line(points = {{71,68},{60,68},{60,60.32},{38.6,60.32}}, color = {0,0,127}));
  connect(phase.y,pwmPulser.Ph_deg) annotation(Line(points = {{71,30},{64,30},{64,44.98},{38.6,44.98}}, color = {0,0,127}));
  connect(upSW.plug_p,star.plug_p) annotation(Line(points = {{-50,40},{-50,48}}, color = {0,0,255}));
  connect(upSW.plug_n,downSW.plug_p) annotation(Line(points = {{-50,20},{-50,-20}}, color = {0,0,255}));
  connect(downSW.plug_n,star1.plug_p) annotation(Line(points = {{-50,-40},{-50,-50}}, color = {0,0,255}));
  connect(Cf.plug_n,Rload.plug_n) annotation(Line(points = {{24,-20},{56,-20}}, color = {0,0,255}));
  connect(Cf.plug_p,Rload.plug_p) annotation(Line(points = {{24,0},{56,0}}, color = {0,0,255}));
  connect(Rload.plug_n,star2.plug_p) annotation(Line(points = {{56,-20},{56,-26}}, color = {0,0,255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experimentSetupOutput, Documentation(info = "<html>
<p>Il risultato &egrave; identico a quello che si ha con interruttori pilotati e dioidi in antiparallelo entrambi iteali.</p>
<p>Questo perch&eacute; con un controllo senza blanking time i due inverter sono identici.</p>
<p>Il sisema pi&ugrave; fisico &egrave; superiore perch&eacute; consente di valutare anche gli effetti del blanking time.</p>
</html>"), experiment(StartTime = 0, StopTime = 0.1, Tolerance = 0.0001));
end invTrifNotWorking;

