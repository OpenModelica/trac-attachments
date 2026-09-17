model MissingRad "car alternator and simple car electric system"
  constant Real PI=Modelica.Constants.pi;
  parameter Modelica.SIunits.Voltage uACpk=14*PI/(3*sqrt(3))
    "peak line-to-neutral voltage";
  parameter Modelica.SIunits.Power genSn=650 "nominal alternator power (W)";
  parameter Modelica.SIunits.Impedance Zn=3/2*uACpk^2/genSn
    "nominal alternator impedance (ohm)";
  parameter Modelica.SIunits.Frequency fn=400 "nominal machine frequency";
  parameter Modelica.SIunits.Frequency Wen=2*PI*fn "nominal radian frequency";
  parameter Modelica.SIunits.Inductance genInduct=Zn/Wen
    "generator inductance";
  parameter Modelica.SIunits.Resistance Ron=1E-3 "diode forward resistance";
  parameter Modelica.SIunits.Conductance Goff=1E-3
    "diode backward conductance";
  parameter Modelica.SIunits.Voltage Vknee=0.6 "diode threshold voltage";
  Modelica.SIunits.Voltage uLL[3];
  Modelica.Electrical.MultiPhase.Basic.Inductor supplyL(m=3, L=fill(genInduct,
        3)) annotation (Placement(visible=true, transformation(extent={{-4, 10}, {16, 30}}, rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Star starS(m=3) annotation (Placement(
        visible=true, transformation(
        origin={-24, -26},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    V=fill(14*PI/(3*sqrt(3)), 3),
    freqHz=fill(fn, 3),m=3, phase( displayUnit = "rad") = {0, 2. / 3. * PI, -2. / 3. * PI})
                      annotation (Placement(visible=true, transformation(
        origin={-24, 8},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(R = fill(10, 3))  annotation(
    Placement(visible = true, transformation(origin = {28, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-24, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(starS.pin_n, ground1.p) annotation(
    Line(points = {{-24, -36}, {-24, -36}, {-24, -42}, {-24, -42}}, color = {0, 0, 255}));
  connect(supplyL.plug_n, resistor1.plug_p) annotation(
    Line(points = {{16, 20}, {28, 20}, {28, 6}, {28, 6}}, color = {0, 0, 255}));
  connect(resistor1.plug_n, starS.plug_p) annotation(
    Line(points = {{28, -14}, {28, -14}, {28, -16}, {-24, -16}, {-24, -16}}, color = {0, 0, 255}));
  connect(starS.plug_p, sineVoltage.plug_n) annotation(
    Line(points = {{-24, -16}, {-24, -2}}, color = {0, 0, 255}));
  connect(sineVoltage.plug_p, supplyL.plug_p) annotation(
    Line(points = {{-24, 18}, {-24, 20}, {-4, 20}}, color = {0, 0, 255}));
  uLL[1] = supplyL.plug_n.pin[1].v - supplyL.plug_n.pin[2].v;
  uLL[2] = supplyL.plug_n.pin[2].v - supplyL.plug_n.pin[3].v;
  uLL[3] = supplyL.plug_n.pin[3].v - supplyL.plug_n.pin[1].v;
  annotation(
    experiment(StopTime = 0.01, __Dymola_NumberOfIntervals = 1000),
    Documentation(info = "<html><head></head><body><p>Car generation test 0</p><p><i>Note</i>: works with OM 1.11</p>
</body></html>", revisions = "<html><head></head><body><p><br></p>
</body></html>"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-140, -60}, {100, 100}})),
  Diagram(coordinateSystem(extent = {{-80, -60}, {80, 60}}, preserveAspectRatio = false)),
    uses(Modelica(version = "3.2.3")),
  version = "");
end MissingRad;
