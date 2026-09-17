model test
  Modelica.Electrical.Analog.Basic.Resistor Load(R = 10) annotation(Placement(visible = true, transformation(origin = {58, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Inductor Lf2(L = 0.001) annotation(Placement(visible = true, transformation(origin = {-28, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor dcCap(C = 0.005, v(start = 100, fixed = true)) annotation(Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor Lf1(L = 0.001) annotation(Placement(visible = true, transformation(origin = {-28, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor rUp(R = 1) annotation(Placement(visible = true, transformation(origin = {16, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Resistor rDn(R = 2) annotation(Placement(visible = true, transformation(origin = {16, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible = true, transformation(origin = {58, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V1(V = 50) annotation(Placement(visible = true, transformation(origin = {-54, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Inductor Lf(L = 0.001) annotation(Placement(visible = true, transformation(origin = {38, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-68, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage V2(V = 50) annotation(Placement(visible = true, transformation(origin = {-54, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
equation
  connect(dcCap.p, Lf1.n) annotation(Line(points = {{-6, 10}, {-6, 48}, {-18, 48}, {-18, 48}, {-18, 48}}, color = {0, 0, 255}));
  connect(ground.p, V2.p) annotation(Line(points = {{-68, -4}, {-54, -4}, {-54, -18}}, color = {0, 0, 255}));
  connect(V1.n, V2.p) annotation(Line(points = {{-54, 6}, {-54, -18}}, color = {0, 0, 255}));
  connect(Lf2.p, V2.n) annotation(Line(points = {{-38, -48}, {-54, -48}, {-54, -40}, {-54, -40}, {-54, -40}}, color = {0, 0, 255}));
  connect(Lf.p, rUp.n) annotation(Line(points = {{28, -4}, {16, -4}, {16, 30}, {16, 20}}, color = {0, 0, 255}));
  connect(Load.p, Lf.n) annotation(Line(points = {{58, -12}, {58, -4}, {48, -4}}, color = {0, 0, 255}));
  connect(Lf1.p, V1.p) annotation(Line(points = {{-38, 48}, {-54, 48}, {-54, 24}, {-54, 24}}, color = {0, 0, 255}));
  connect(ground1.p, Load.n) annotation(Line(points = {{58, -36}, {58, -36}, {58, -32}, {58, -32}, {58, -32}}, color = {0, 0, 255}));
  connect(rDn.n, Lf2.n) annotation(Line(points = {{16, -48}, {16, -48}, {-18, -48}, {-18, -48}}, color = {0, 0, 255}));
  connect(rUp.n, rDn.p) annotation(Line(points = {{16, 20}, {16, -28}, {16, -28}, {16, -28}}, color = {0, 0, 255}));
  connect(Lf1.n, rUp.p) annotation(Line(points = {{-18, 48}, {16, 48}, {16, 38}, {16, 38}, {16, 38}}, color = {0, 0, 255}));
  connect(dcCap.n, Lf2.n) annotation(Line(points = {{-6, -10}, {-6, -48}, {-18, -48}, {-18, -48}}, color = {0, 0, 255}));
end test;