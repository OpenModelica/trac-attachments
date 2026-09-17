model BridgeTri
  Modelica.Electrical.Analog.Basic.Inductor inductor1(L = 6e-05) annotation(Placement(visible = true, transformation(origin = {-49.1972,26.981}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L = 6e-05) annotation(Placement(visible = true, transformation(origin = {-48.3354,3.81558}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor3(L = 6e-05) annotation(Placement(visible = true, transformation(origin = {-49.4229,-20.8012}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-92.0303,-51.5103}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage U1(V = 100, phase = 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-82.3116,27.0684}, extent = {{12,12},{-12,-12}}, rotation = 180)));
  Modelica.Electrical.Analog.Sources.SineVoltage U2(V = 100, phase = -2 / 3 * Modelica.Constants.pi + 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-82.6757,3.49762}, extent = {{12,12},{-12,-12}}, rotation = 180)));
  Modelica.Electrical.Analog.Sources.SineVoltage U3(V = 100, phase = 2 / 3 * Modelica.Constants.pi + 1, freqHz = 50) annotation(Placement(visible = true, transformation(origin = {-83.45,-21.8935}, extent = {{12,12},{-12,-12}}, rotation = 180)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode6 annotation(Placement(visible = true, transformation(origin = {-17.4054,57.2337}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode1 annotation(Placement(visible = true, transformation(origin = {13.0318,56.5978}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode4 annotation(Placement(visible = true, transformation(origin = {42.372,56.5978}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode5 annotation(Placement(visible = true, transformation(origin = {-17.0874,-45.4642}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode2 annotation(Placement(visible = true, transformation(origin = {13.7552,-45.4642}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealdiode3 annotation(Placement(visible = true, transformation(origin = {42.69,-46.0541}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 10) annotation(Placement(visible = true, transformation(origin = {70.0032,42.2893}, extent = {{-12,12},{12,-12}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Inductor inductor4(L = 0.05) annotation(Placement(visible = true, transformation(origin = {69.9523,-11.5851}, extent = {{-12,12},{12,-12}}, rotation = 270)));
equation
  connect(resistor1.p,idealdiode4.n) annotation(Line(points = {{70.0032,54.2893},{69.3164,54.2893},{69.3164,68.9984},{42.372,68.9984},{42.372,68.5978}}));
  connect(inductor4.n,idealdiode3.p) annotation(Line(points = {{69.9523,-23.5851},{69.6343,-23.5851},{69.6343,-57.2337},{42.69,-57.2337},{42.69,-58.0541}}));
  connect(inductor4.p,resistor1.n) annotation(Line(points = {{69.9523,0.414944},{69.9523,0.414944},{69.9523,30.2893},{70.0032,30.2893}}));
  connect(inductor3.n,idealdiode4.p) annotation(Line(points = {{-37.4229,-20.8012},{41.9714,-20.8012},{41.9714,43.5612},{42.372,43.5612},{42.372,44.5978}}));
  connect(inductor2.n,idealdiode1.p) annotation(Line(points = {{-36.3354,3.81558},{13.6725,3.81558},{13.6725,44.5151},{13.0318,44.5151},{13.0318,44.5978}}));
  connect(inductor1.n,idealdiode6.p) annotation(Line(points = {{-37.1972,26.981},{-17.4881,26.981},{-17.4881,45.151},{-17.4054,45.151},{-17.4054,45.2337}}));
  connect(idealdiode2.p,idealdiode3.p) annotation(Line(points = {{13.7552,-57.4642},{43.5612,-57.4642},{43.5612,-58.0541},{42.69,-58.0541}}));
  connect(idealdiode4.p,idealdiode3.n) annotation(Line(points = {{42.372,44.5978},{42.2893,44.5978},{42.2893,-34.0541},{42.69,-34.0541}}));
  connect(idealdiode5.p,idealdiode2.p) annotation(Line(points = {{-17.0874,-57.4642},{14.3084,-57.4642},{14.3084,-57.4642},{13.7552,-57.4642}}));
  connect(idealdiode1.n,idealdiode4.n) annotation(Line(points = {{13.0318,68.5978},{42.2893,68.5978},{42.2893,68.5978},{42.372,68.5978}}));
  connect(idealdiode6.n,idealdiode1.n) annotation(Line(points = {{-17.4054,69.2337},{13.0366,69.2337},{13.0366,68.5978},{13.0318,68.5978}}));
  connect(idealdiode1.p,idealdiode2.n) annotation(Line(points = {{13.0318,44.5978},{13.3545,44.5978},{13.3545,-33.4642},{13.7552,-33.4642}}));
  connect(idealdiode6.p,idealdiode5.n) annotation(Line(points = {{-17.4054,45.2337},{-17.4881,45.2337},{-17.4881,-33.3863},{-17.0874,-33.3863},{-17.0874,-33.4642}}));
  connect(U1.n,U2.n) annotation(Line(points = {{-94.3116,27.0684},{-94.7583,27.0684},{-94.7583,3.49762},{-94.6757,3.49762}}));
  connect(ground1.p,U3.n) annotation(Line(points = {{-92.0303,-39.5103},{-92.0303,-24.1653},{-95.45,-24.1653},{-95.45,-21.8935}}));
  connect(U3.p,inductor3.p) annotation(Line(points = {{-71.45,-21.8935},{-64.5516,-21.8935},{-64.5516,-20.8012},{-61.4229,-20.8012}}));
  connect(U2.p,inductor2.p) annotation(Line(points = {{-70.6757,3.49762},{-60.7361,3.49762},{-60.7361,3.81558},{-60.3354,3.81558}}));
  connect(U1.p,inductor1.p) annotation(Line(points = {{-70.3116,27.0684},{-61.5978,27.0684},{-61.5978,26.981},{-61.1972,26.981}}));
  connect(U2.n,U3.n) annotation(Line(points = {{-94.6757,3.49762},{-94.7583,3.49762},{-94.7583,-21.8935},{-95.45,-21.8935}}));
  annotation(uses(Modelica(version = "2.2.2")), experiment(StartTime = 0.0, StopTime = 0.1, Tolerance = 1e-06));
end BridgeTri;

