package LSPVPP
  block AntiPark
    Modelica.Blocks.Interfaces.RealInput q annotation(
      Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput d annotation(
      Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput theta annotation(
      Placement(visible = true, transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput a annotation(
      Placement(visible = true, transformation(origin = {110, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput b annotation(
      Placement(visible = true, transformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput c annotation(
      Placement(visible = true, transformation(origin = {110, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    constant Real pi = Modelica.Constants.pi;
  equation
    a = q * cos(theta) + d * sin(theta);
    b = q * cos(theta - 2 * pi / 3) + d * sin(theta - 2 * pi / 3);
    c = q * cos(theta + 2 * pi / 3) + d * sin(theta + 2 * pi / 3);
    annotation(
      Diagram(coordinateSystem(initialScale = 0.1)),
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(origin = {-14, 11}, extent = {{-86, 89}, {114, -111}}), Text(origin = {6, -5}, extent = {{-52, 41}, {42, -33}}, textString = "AntiPark"), Text(origin = {-85, 41}, extent = {{-9, 9}, {9, -9}}, textString = "q"), Text(origin = {3, -87}, extent = {{-13, 9}, {9, -9}}, textString = "theta"), Text(origin = {-87, -39}, extent = {{-9, 9}, {9, -9}}, textString = "d"), Text(origin = {89, 1}, extent = {{-13, 9}, {9, -9}}, textString = "b"), Text(origin = {89, 31}, extent = {{-13, 9}, {9, -9}}, textString = "a"), Text(origin = {89, -29}, extent = {{-13, 9}, {9, -9}}, textString = "c")}, coordinateSystem(initialScale = 0.1)));
  end AntiPark;

  block Clarke
    Modelica.Blocks.Interfaces.RealInput a annotation(
      Placement(visible = true, transformation(origin = {-102, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput b annotation(
      Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput c annotation(
      Placement(visible = true, transformation(origin = {-102, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput alfa annotation(
      Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput beta annotation(
      Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    alfa = 2 / 3 * (a - 0.5 * b - 0.5 * c);
    beta = 2 / 3 * ((-sqrt(3) / 2 * b) + sqrt(3) / 2 * c);
    annotation(
      uses(Modelica(version = "3.2.3")),
      Diagram,
      Icon(graphics = {Rectangle(origin = {5, -3}, extent = {{-77, 75}, {77, -75}}), Text(origin = {11, 0}, extent = {{-69, 32}, {55, -20}}, textString = "Clarke")}, coordinateSystem(initialScale = 0.1)));
  end Clarke;

  model GRID
    Modelica.Electrical.MultiPhase.Sources.SineVoltage HV(V = fill(160000 * sqrt(2) / sqrt(3), 3), freqHz = fill(50, 3)) annotation(
      Placement(visible = true, transformation(origin = {6, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground3 annotation(
      Placement(visible = true, transformation(origin = {24, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star3 annotation(
      Placement(visible = true, transformation(origin = {24, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rg(R = fill(0.829, 3)) annotation(
      Placement(visible = true, transformation(origin = {-20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lg(L = fill(0.016, 3)) annotation(
      Placement(visible = true, transformation(origin = {-52, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug PG annotation(
      Placement(visible = true, transformation(origin = {-100, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(HV.plug_n, star3.plug_p) annotation(
      Line(points = {{16, 10}, {24, 10}, {24, -6}, {24, -6}}, color = {0, 0, 255}));
    connect(Rg.plug_n, HV.plug_p) annotation(
      Line(points = {{-10, 10}, {-4, 10}, {-4, 10}, {-4, 10}}, color = {0, 0, 255}));
    connect(Lg.plug_n, Rg.plug_p) annotation(
      Line(points = {{-42, 10}, {-30, 10}, {-30, 10}, {-30, 10}}, color = {0, 0, 255}));
    connect(PG, Lg.plug_p) annotation(
      Line(points = {{-100, 10}, {-62, 10}, {-62, 10}, {-62, 10}}, color = {0, 0, 255}));
    connect(star3.pin_n, ground3.p) annotation(
      Line(points = {{24, -26}, {24, -26}, {24, -32}, {24, -32}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-5, 15}, extent = {{-69, 21}, {87, -37}}, textString = "HV grid")}, coordinateSystem(initialScale = 0.1)));
  end GRID;

  block Inner_Current_Controller
    Modelica.Blocks.Interfaces.RealInput Id_ref annotation(
      Placement(visible = true, transformation(origin = {-104, 84}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-88, 58}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Iq annotation(
      Placement(visible = true, transformation(origin = {-104, -20}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-88, -16}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Iq_ref annotation(
      Placement(visible = true, transformation(origin = {-104, -86}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {-88, -52}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Vq_ref annotation(
      Placement(visible = true, transformation(origin = {108, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3(k2 = +1, k3 = -1) annotation(
      Placement(visible = true, transformation(origin = {55, 85}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31(k1 = +1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {68, -78}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(visible = true, transformation(origin = {-70, 84}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {-62, -86}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Vld annotation(
      Placement(visible = true, transformation(origin = {19, 115}, extent = {{-9, -9}, {9, 9}}, rotation = -90), iconTransformation(origin = {-9, 87}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Vlq annotation(
      Placement(visible = true, transformation(origin = {47, -107}, extent = {{-11, -11}, {11, 11}}, rotation = 90), iconTransformation(origin = {51, 87}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
    Modelica.Blocks.Sources.Constant wl(k = 0.0188495) annotation(
      Placement(visible = true, transformation(origin = {-69, 3}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-20, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1 annotation(
      Placement(visible = true, transformation(origin = {-20, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator kiq(k = 5.5555) annotation(
      Placement(visible = true, transformation(origin = {-24, -100}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator kid(k = 5.5555) annotation(
      Placement(visible = true, transformation(origin = {-36, 68}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Math.Gain kd(k = 0.06) annotation(
      Placement(visible = true, transformation(origin = {-37, 101}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Blocks.Math.Gain kq(k = 0.06) annotation(
      Placement(visible = true, transformation(origin = {-24, -60}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(visible = true, transformation(origin = {18, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {0, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Vd_ref annotation(
      Placement(visible = true, transformation(origin = {110, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Id annotation(
      Placement(visible = true, transformation(origin = {-106, 32}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-88, 24}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  equation
    connect(Id_ref, feedback.u1) annotation(
      Line(points = {{-104, 84}, {-78, 84}}, color = {0, 0, 127}));
    connect(Iq_ref, feedback1.u1) annotation(
      Line(points = {{-104, -86}, {-70, -86}}, color = {0, 0, 127}));
    connect(feedback1.u2, Iq) annotation(
      Line(points = {{-62, -78}, {-62, -20}, {-104, -20}}, color = {0, 0, 127}));
    connect(Vld, add3.u1) annotation(
      Line(points = {{19, 115}, {19, 91}, {47, 91}}, color = {0, 0, 127}));
    connect(wl.y, product.u2) annotation(
      Line(points = {{-60, 4}, {-52, 4}, {-52, 18}, {-32, 18}}, color = {0, 0, 127}));
    connect(wl.y, product1.u1) annotation(
      Line(points = {{-60, 4}, {-52, 4}, {-52, -8}, {-32, -8}, {-32, -8}}, color = {0, 0, 127}));
    connect(Iq, product1.u2) annotation(
      Line(points = {{-104, -20}, {-32, -20}}, color = {0, 0, 127}));
    connect(feedback.y, kd.u) annotation(
      Line(points = {{-60, 84}, {-54, 84}, {-54, 100}, {-46, 100}, {-46, 102}}, color = {0, 0, 127}));
    connect(kd.y, add1.u1) annotation(
      Line(points = {{-30, 102}, {-20, 102}, {-20, 90}, {-12, 90}, {-12, 90}}, color = {0, 0, 127}));
    connect(add1.u2, kid.y) annotation(
      Line(points = {{-12, 78}, {-18, 78}, {-18, 68}, {-28, 68}, {-28, 68}}, color = {0, 0, 127}));
    connect(kid.u, feedback.y) annotation(
      Line(points = {{-46, 68}, {-54, 68}, {-54, 84}, {-60, 84}, {-60, 84}}, color = {0, 0, 127}));
    connect(add1.y, add3.u2) annotation(
      Line(points = {{12, 84}, {46, 84}, {46, 86}, {46, 86}}, color = {0, 0, 127}));
    connect(add3.u3, product1.y) annotation(
      Line(points = {{46, 80}, {34, 80}, {34, -14}, {-8, -14}, {-8, -14}}, color = {0, 0, 127}));
    connect(kq.u, feedback1.y) annotation(
      Line(points = {{-34, -60}, {-44, -60}, {-44, -86}, {-52, -86}}, color = {0, 0, 127}));
    connect(kiq.u, feedback1.y) annotation(
      Line(points = {{-34, -100}, {-44, -100}, {-44, -86}, {-52, -86}}, color = {0, 0, 127}));
    connect(kq.y, add.u1) annotation(
      Line(points = {{-16, -60}, {-4, -60}, {-4, -72}, {6, -72}, {6, -72}}, color = {0, 0, 127}));
    connect(add.u2, kiq.y) annotation(
      Line(points = {{6, -84}, {-2, -84}, {-2, -100}, {-15, -100}}, color = {0, 0, 127}));
    connect(add.y, add31.u2) annotation(
      Line(points = {{30, -78}, {60, -78}, {60, -78}, {60, -78}}, color = {0, 0, 127}));
    connect(Vlq, add31.u3) annotation(
      Line(points = {{48, -106}, {48, -106}, {48, -82}, {60, -82}, {60, -82}}, color = {0, 0, 127}));
    connect(product.y, add31.u1) annotation(
      Line(points = {{-8, 24}, {46, 24}, {46, -74}, {60, -74}, {60, -74}}, color = {0, 0, 127}));
    connect(Id, product.u1) annotation(
      Line(points = {{-106, 32}, {-34, 32}, {-34, 30}, {-32, 30}, {-32, 30}}, color = {0, 0, 127}));
    connect(Id, feedback.u2) annotation(
      Line(points = {{-106, 32}, {-70, 32}, {-70, 76}, {-70, 76}}, color = {0, 0, 127}));
    connect(add3.y, Vd_ref) annotation(
      Line(points = {{62, 86}, {100, 86}, {100, 84}, {110, 84}}, color = {0, 0, 127}));
    connect(add31.y, Vq_ref) annotation(
      Line(points = {{74, -78}, {102, -78}, {102, -78}, {108, -78}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(origin = {-4, 1}, extent = {{-76, 77}, {76, -77}}), Text(origin = {6, 1}, extent = {{-36, 25}, {20, -23}}, textString = "Inner CC"), Text(origin = {-63, 58}, extent = {{-13, 6}, {13, -6}}, textString = "Id_ref"), Text(origin = {-65, 20}, extent = {{-13, 6}, {13, -6}}, textString = "Id"), Text(origin = {-67, -18}, extent = {{-13, 6}, {13, -6}}, textString = "Iq"), Text(origin = {-61, -54}, extent = {{-13, 6}, {13, -6}}, textString = "Iq_ref"), Text(origin = {-7, 72}, extent = {{-13, 6}, {13, -6}}, textString = "Vzd"), Text(origin = {59, -40}, extent = {{-13, 6}, {13, -6}}, textString = "Vlq"), Text(origin = {59, 42}, extent = {{-13, 6}, {13, -6}}, textString = "Vld"), Text(origin = {47, 70}, extent = {{-13, 6}, {13, -6}}, textString = "Vzq")}, coordinateSystem(initialScale = 0.1)),
      Diagram(graphics = {Text(origin = {26, 118}, extent = {{-6, 4}, {6, -4}}, textString = "Vzd"), Text(origin = {38, -108}, extent = {{-6, 4}, {6, -4}}, textString = "Vzq")}));
  end Inner_Current_Controller;

  model inner_control_pllm3
    Modelica.Blocks.Interfaces.RealInput va annotation(
      Placement(visible = true, transformation(origin = {-120, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {113, 93}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput vb annotation(
      Placement(visible = true, transformation(origin = {-120, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {113, 55}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput vc annotation(
      Placement(visible = true, transformation(origin = {-120, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {113, 15}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput ia annotation(
      Placement(visible = true, transformation(origin = {-120, 16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {113, -27}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput ib annotation(
      Placement(visible = true, transformation(origin = {-120, -12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {113, -63}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput ic annotation(
      Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {112, -98}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput theta annotation(
      Placement(visible = true, transformation(origin = {110, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput Vzq annotation(
      Placement(visible = true, transformation(origin = {110, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Park parkI annotation(
      Placement(visible = true, transformation(origin = {-64, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Park ParkV annotation(
      Placement(visible = true, transformation(origin = {-18, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput idref annotation(
      Placement(visible = true, transformation(origin = {-120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput iqref annotation(
      Placement(visible = true, transformation(origin = {-120, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Inner_Current_Controller inner_Current_Controller annotation(
      Placement(visible = true, transformation(origin = {12, -70}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput vd annotation(
      Placement(visible = true, transformation(origin = {110, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput vq annotation(
      Placement(visible = true, transformation(origin = {110, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    PLL2 pll2 annotation(
      Placement(visible = true, transformation(origin = {20, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(ia, parkI.a) annotation(
      Line(points = {{-120, 16}, {-88, 16}, {-88, -8}, {-75, -8}}, color = {0, 0, 127}));
    connect(ib, parkI.b) annotation(
      Line(points = {{-120, -12}, {-75, -12}}, color = {0, 0, 127}));
    connect(ic, parkI.c) annotation(
      Line(points = {{-120, -40}, {-84, -40}, {-84, -16}, {-75, -16}}, color = {0, 0, 127}));
    connect(va, ParkV.a) annotation(
      Line(points = {{-120, 106}, {-56, 106}, {-56, 36}, {-30, 36}, {-30, 36}}, color = {0, 0, 127}));
    connect(vb, ParkV.b) annotation(
      Line(points = {{-120, 76}, {-64, 76}, {-64, 32}, {-30, 32}, {-30, 32}}, color = {0, 0, 127}));
    connect(vc, ParkV.c) annotation(
      Line(points = {{-120, 48}, {-72, 48}, {-72, 28}, {-30, 28}, {-30, 28}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Vlq, ParkV.q) annotation(
      Line(points = {{36, -30}, {36, -30}, {36, 36}, {-6, 36}, {-6, 36}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Vld, ParkV.d) annotation(
      Line(points = {{8, -30}, {6, -30}, {6, 30}, {-6, 30}, {-6, 30}}, color = {0, 0, 127}));
    connect(iqref, inner_Current_Controller.Iq_ref) annotation(
      Line(points = {{-120, -70}, {-68, -70}, {-68, -94}, {-28, -94}, {-28, -94}}, color = {0, 0, 127}));
    connect(idref, inner_Current_Controller.Id_ref) annotation(
      Line(points = {{-120, -100}, {-52, -100}, {-52, -46}, {-28, -46}, {-28, -44}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Id, parkI.d) annotation(
      Line(points = {{-28, -58}, {-46, -58}, {-46, -16}, {-52, -16}, {-52, -14}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Iq, parkI.q) annotation(
      Line(points = {{-28, -78}, {-40, -78}, {-40, -10}, {-52, -10}, {-52, -8}, {-52, -8}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Vd_ref, vd) annotation(
      Line(points = {{50, -46}, {104, -46}, {104, -46}, {110, -46}}, color = {0, 0, 127}));
    connect(inner_Current_Controller.Vq_ref, vq) annotation(
      Line(points = {{50, -92}, {102, -92}, {102, -92}, {110, -92}}, color = {0, 0, 127}));
    connect(pll2.theta, theta) annotation(
      Line(points = {{32, 72}, {50, 72}, {50, 36}, {110, 36}, {110, 36}}, color = {0, 0, 127}));
    connect(pll2.Va_grid, va) annotation(
      Line(points = {{8, 82}, {-56, 82}, {-56, 106}, {-120, 106}, {-120, 106}}, color = {0, 0, 127}));
    connect(vb, pll2.Vb_grid) annotation(
      Line(points = {{-120, 76}, {8, 76}, {8, 76}, {8, 76}}, color = {0, 0, 127}));
    connect(pll2.Vc_grid, vc) annotation(
      Line(points = {{8, 70}, {-56, 70}, {-56, 48}, {-120, 48}, {-120, 48}}, color = {0, 0, 127}));
    connect(parkI.theta, ParkV.theta) annotation(
      Line(points = {{-64, -24}, {-64, -24}, {-64, -28}, {-18, -28}, {-18, 20}, {-18, 20}}, color = {0, 0, 127}));
    connect(pll2.theta, ParkV.theta) annotation(
      Line(points = {{32, 72}, {50, 72}, {50, 6}, {-18, 6}, {-18, 20}, {-18, 20}}, color = {0, 0, 127}));
    connect(pll2.Vzq, Vzq) annotation(
      Line(points = {{32, 82}, {108, 82}, {108, 82}, {110, 82}}, color = {0, 0, 127}));
  protected
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon);
  end inner_control_pllm3;

  model inverterMod
    Modelica.Blocks.Interfaces.RealInput vdref annotation(
      Placement(visible = true, transformation(origin = {-120, 14}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput vqref annotation(
      Placement(visible = true, transformation(origin = {-120, 54}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division division1 annotation(
      Placement(visible = true, transformation(origin = {-42, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division division2 annotation(
      Placement(visible = true, transformation(origin = {-40, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter(homotopyType = Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy, limitsAtInit = true, uMax = 1, uMin = -1) annotation(
      Placement(visible = true, transformation(origin = {4, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter limiter1(homotopyType = Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy, limitsAtInit = true, uMax = 1, uMin = 0) annotation(
      Placement(visible = true, transformation(origin = {6, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AntiPark antiPark annotation(
      Placement(visible = true, transformation(origin = {84, 28}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput theta annotation(
      Placement(visible = true, transformation(origin = {84, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput va annotation(
      Placement(visible = true, transformation(origin = {120, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput vb annotation(
      Placement(visible = true, transformation(origin = {120, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput vc annotation(
      Placement(visible = true, transformation(origin = {120, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {40, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product1 annotation(
      Placement(visible = true, transformation(origin = {40, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-120, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    connect(vqref, division1.u1) annotation(
      Line(points = {{-120, 54}, {-54, 54}}, color = {0, 0, 127}));
    connect(division2.u1, vdref) annotation(
      Line(points = {{-52, 14}, {-120, 14}}, color = {0, 0, 127}));
    connect(division1.y, limiter.u) annotation(
      Line(points = {{-30, 48}, {-8, 48}}, color = {0, 0, 127}));
    connect(division2.y, limiter1.u) annotation(
      Line(points = {{-28, 8}, {-6, 8}}, color = {0, 0, 127}));
    connect(theta, antiPark.theta) annotation(
      Line(points = {{84, -120}, {84, 11}}, color = {0, 0, 127}));
    connect(antiPark.b, vb) annotation(
      Line(points = {{100, 28}, {110, 28}, {110, 28}, {120, 28}}, color = {0, 0, 127}));
    connect(va, antiPark.a) annotation(
      Line(points = {{120, 44}, {108, 44}, {108, 32}, {100, 32}, {100, 32}}, color = {0, 0, 127}));
    connect(antiPark.c, vc) annotation(
      Line(points = {{100, 24}, {108, 24}, {108, 12}, {120, 12}}, color = {0, 0, 127}));
    connect(gain.y, division1.u2) annotation(
      Line(points = {{-69, -46}, {-64, -46}, {-64, 44}, {-54, 44}, {-54, 42}}, color = {0, 0, 127}));
    connect(division2.u2, gain.y) annotation(
      Line(points = {{-52, 2}, {-64, 2}, {-64, -46}, {-69, -46}}, color = {0, 0, 127}));
    connect(product.y, antiPark.q) annotation(
      Line(points = {{52, 42}, {58, 42}, {58, 34}, {68, 34}, {68, 34}}, color = {0, 0, 127}));
    connect(product1.y, antiPark.d) annotation(
      Line(points = {{51, 14}, {60, 14}, {60, 22}, {68, 22}}, color = {0, 0, 127}));
    connect(product.u1, limiter.y) annotation(
      Line(points = {{28, 48}, {14, 48}, {14, 48}, {16, 48}}, color = {0, 0, 127}));
    connect(product1.u2, limiter1.y) annotation(
      Line(points = {{28, 8}, {16, 8}, {16, 8}, {18, 8}}, color = {0, 0, 127}));
    connect(product.u2, product1.u1) annotation(
      Line(points = {{28, 36}, {22, 36}, {22, 20}, {28, 20}, {28, 20}}, color = {0, 0, 127}));
    connect(u, gain.u) annotation(
      Line(points = {{-120, -46}, {-92, -46}}, color = {0, 0, 127}));
    connect(u, product1.u1) annotation(
      Line(points = {{-120, -46}, {-96, -46}, {-96, -80}, {22, -80}, {22, 20}, {28, 20}, {28, 20}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")));
  end inverterMod;

  model Line1
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug p annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug n annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.846, 3)) annotation(
      Placement(visible = true, transformation(origin = {-32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.4e-3, 3)) annotation(
      Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor.plug_p, p) annotation(
      Line(points = {{-42, 0}, {-100, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 255}));
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-22, 0}, {8, 0}, {8, 0}, {8, 0}}));
    connect(inductor.plug_n, n) annotation(
      Line(points = {{28, 0}, {98, 0}, {98, 0}, {100, 0}}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}}), Line(origin = {1.18, 15.2}, points = {{90.8201, -15.2042}, {-91.1799, -15.2042}, {90.8201, -15.2042}}, color = {0, 0, 255})}, coordinateSystem(initialScale = 0.1)));
  end Line1;

  model Line2
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug p annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug n annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.1638, 3)) annotation(
      Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.42336e-3, 3)) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-12, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {0, 0, 255}));
    connect(inductor.plug_n, n) annotation(
      Line(points = {{30, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(resistor.plug_p, p) annotation(
      Line(points = {{-32, 0}, {-98, 0}, {-98, 0}, {-100, 0}}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}}), Line(origin = {1.18, 15.2}, points = {{90.8201, -15.2042}, {-91.1799, -15.2042}, {90.8201, -15.2042}}, color = {0, 0, 255})}, coordinateSystem(initialScale = 0.1)));
  end Line2;

  model Line3
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug p annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug n annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.1456, 3)) annotation(
      Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.000376, 3)) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-12, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {0, 0, 255}));
    connect(inductor.plug_n, n) annotation(
      Line(points = {{30, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(resistor.plug_p, p) annotation(
      Line(points = {{-32, 0}, {-98, 0}, {-98, 0}, {-100, 0}}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}}), Line(origin = {1.18, 15.2}, points = {{90.8201, -15.2042}, {-91.1799, -15.2042}, {90.8201, -15.2042}}, color = {0, 0, 255})}, coordinateSystem(initialScale = 0.1)));
  end Line3;

  model Line4
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug p annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug n annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.12272, 3)) annotation(
      Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.317e-3, 3)) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-12, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {0, 0, 255}));
    connect(inductor.plug_n, n) annotation(
      Line(points = {{30, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(resistor.plug_p, p) annotation(
      Line(points = {{-32, 0}, {-98, 0}, {-98, 0}, {-100, 0}}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}}), Line(origin = {1.18, 15.2}, points = {{90.8201, -15.2042}, {-91.1799, -15.2042}, {90.8201, -15.2042}}, color = {0, 0, 255})}, coordinateSystem(initialScale = 0.1)));
  end Line4;

  model Line5
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug p annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug n annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.0975, 3)) annotation(
      Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.252e-3, 3)) annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-12, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {0, 0, 255}));
    connect(inductor.plug_n, n) annotation(
      Line(points = {{30, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {0, 0, 255}));
    connect(resistor.plug_p, p) annotation(
      Line(points = {{-32, 0}, {-98, 0}, {-98, 0}, {-100, 0}}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-60, 20}, {60, -20}}), Line(origin = {1.18, 15.2}, points = {{90.8201, -15.2042}, {-91.1799, -15.2042}, {90.8201, -15.2042}}, color = {0, 0, 255})}, coordinateSystem(initialScale = 0.1)));
  end Line5;

  model modu
    constant Real pi = Modelica.Constants.pi;
    Real p;
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    p = 2 * pi;
    y = mod(u, p);
    annotation(
      uses(Modelica(version = "3.2.3")));
  end modu;

  model NGenPV_NO_IND
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {204, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {204, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SineVoltage MV(V = fill(35355.34, 3), freqHz = fill(50, 3)) annotation(
      Placement(visible = true, transformation(origin = {190, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lg(L = fill(0.00076, 3)) annotation(
      Placement(visible = true, transformation(origin = {142, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rg(R = fill(0.005, 3)) annotation(
      Placement(visible = true, transformation(origin = {166, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -2000000; 0.5, 0; 0.8, 2000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {26, 104}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -6000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {26, 132}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-13, 129}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-13, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {16, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 134}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug pcc annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    trafo_three_w_NO_IND T1 annotation(
      Placement(visible = true, transformation(origin = {-86, 125}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w_NO_IND T2 annotation(
      Placement(visible = true, transformation(origin = {-87, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w_NO_IND T3 annotation(
      Placement(visible = true, transformation(origin = {-85, 21}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w_NO_IND T4 annotation(
      Placement(visible = true, transformation(origin = {-86, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w_NO_IND T5 annotation(
      Placement(visible = true, transformation(origin = {-85, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(star.pin_n, ground.p) annotation(
      Line(points = {{204, -20}, {204, -26}}, color = {0, 0, 255}));
    connect(star.plug_p, MV.plug_n) annotation(
      Line(points = {{204, 0}, {200, 0}}, color = {0, 0, 255}));
    connect(Lg.plug_n, Rg.plug_p) annotation(
      Line(points = {{152, 0}, {156, 0}}, color = {0, 0, 255}));
    connect(Rg.plug_n, MV.plug_p) annotation(
      Line(points = {{176, 0}, {180, 0}}, color = {0, 0, 255}));
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 86}, {150, 86}, {150, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{-7, 132}, {15, 132}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{-7, 104}, {15, 104}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{5, 74}, {0, 74}, {0, 98}, {-7, 98}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{5, 74}, {0, 74}, {0, 126}, {-7, 126}}, color = {0, 0, 127}));
    connect(Lg.plug_p, Cpcc.plug_n) annotation(
      Line(points = {{132, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(Cpcc.plug_p, pcc) annotation(
      Line(points = {{74, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(Vpcc.plug_p, Lg.plug_p) annotation(
      Line(points = {{106, 6}, {106, 6}, {106, 0}, {132, 0}, {132, 0}}));
    connect(VSC1.plv, T1.in1) annotation(
      Line(points = {{-119, 136}, {-108, 136}, {-108, 129}, {-96, 129}, {-96, 128}}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-96, 122}, {-108, 122}, {-108, 115}, {-119, 115}, {-119, 114}}, color = {0, 0, 255}));
    connect(T2.in1, VSC3.plv) annotation(
      Line(points = {{-97, 75}, {-108, 75}, {-108, 84}, {-119, 84}, {-119, 84}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{-97, 69}, {-107, 69}, {-107, 62}, {-119, 62}, {-119, 62}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-95, 24}, {-108, 24}, {-108, 31}, {-119, 31}, {-119, 30}}, color = {0, 0, 255}));
    connect(T3.in2, VSC6.plv) annotation(
      Line(points = {{-95, 18}, {-107, 18}, {-107, 8}, {-119, 8}, {-119, 8}}, color = {0, 0, 255}));
    connect(T4.in1, VSC7.plv) annotation(
      Line(points = {{-96, -29}, {-107, -29}, {-107, -21}, {-119, -21}, {-119, -22}}, color = {0, 0, 255}));
    connect(T4.in2, VSC8.plv) annotation(
      Line(points = {{-96, -35}, {-107, -35}, {-107, -44}, {-119, -44}, {-119, -44}}, color = {0, 0, 255}));
    connect(T5.in1, VSC9.plv) annotation(
      Line(points = {{-95, -85}, {-105, -85}, {-105, -76}, {-119, -76}, {-119, -76}}, color = {0, 0, 255}));
    connect(T5.in2, VSC10.plv) annotation(
      Line(points = {{-95, -91}, {-105, -91}, {-105, -100}, {-119, -100}, {-119, -100}}, color = {0, 0, 255}));
    connect(T1.out3, pcc) annotation(
      Line(points = {{-76, 125}, {-40, 125}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T2.out3, pcc) annotation(
      Line(points = {{-77, 72}, {-42, 72}, {-42, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T3.out3, pcc) annotation(
      Line(points = {{-75, 21}, {-40, 21}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T4.out3, pcc) annotation(
      Line(points = {{-76, -32}, {-42, -32}, {-42, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T5.out3, pcc) annotation(
      Line(points = {{-75, -88}, {-42, -88}, {-42, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 1, extent = {{-200, -200}, {200, 200}}, grid = {1, 1}), graphics = {Text(origin = {-40, 81}, extent = {{-2, 43}, {2, -43}}, textString = "text"), Rectangle(origin = {-41, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}}), Rectangle(origin = {173, -108}, extent = {{3, 4}, {-3, -4}})}),
      Icon(coordinateSystem(initialScale = 1, extent = {{-200, -200}, {200, 200}}, grid = {1, 1})),
      version = "");
  end NGenPV_NO_IND;

  model NGenPV
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {204, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {204, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SineVoltage MV(V = fill(35355.34, 3), freqHz = fill(50, 3)) annotation(
      Placement(visible = true, transformation(origin = {190, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lg(L = fill(0.00076, 3)) annotation(
      Placement(visible = true, transformation(origin = {142, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rg(R = fill(0.005, 3)) annotation(
      Placement(visible = true, transformation(origin = {166, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -2000000; 0.5, 0; 0.8, 2000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {26, 104}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -6000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {26, 132}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-13, 129}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-13, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {16, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 134}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T1 annotation(
      Placement(visible = true, transformation(origin = {-82, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T2 annotation(
      Placement(visible = true, transformation(origin = {-82, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T3 annotation(
      Placement(visible = true, transformation(origin = {-82, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T4 annotation(
      Placement(visible = true, transformation(origin = {-82, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T5 annotation(
      Placement(visible = true, transformation(origin = {-82, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug pcc annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(star.pin_n, ground.p) annotation(
      Line(points = {{204, -20}, {204, -26}}, color = {0, 0, 255}));
    connect(star.plug_p, MV.plug_n) annotation(
      Line(points = {{204, 0}, {200, 0}}, color = {0, 0, 255}));
    connect(Lg.plug_n, Rg.plug_p) annotation(
      Line(points = {{152, 0}, {156, 0}}, color = {0, 0, 255}));
    connect(Rg.plug_n, MV.plug_p) annotation(
      Line(points = {{176, 0}, {180, 0}}, color = {0, 0, 255}));
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 86}, {150, 86}, {150, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{-7, 132}, {15, 132}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{-7, 104}, {15, 104}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{5, 74}, {0, 74}, {0, 98}, {-7, 98}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{5, 74}, {0, 74}, {0, 126}, {-7, 126}}, color = {0, 0, 127}));
    connect(Lg.plug_p, Cpcc.plug_n) annotation(
      Line(points = {{132, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(T1.in1, VSC1.plv) annotation(
      Line(points = {{-92, 127}, {-100, 127}, {-100, 136}, {-118, 136}}, color = {0, 0, 255}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-92, 121}, {-100, 121}, {-100, 114}, {-118, 114}}, color = {0, 0, 255}));
    connect(T2.in1, VSC3.plv) annotation(
      Line(points = {{-92, 74}, {-100, 74}, {-100, 84}, {-120, 84}, {-120, 84}, {-118, 84}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{-92, 70}, {-100, 70}, {-100, 62}, {-118, 62}, {-118, 62}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-92, 22}, {-100, 22}, {-100, 30}, {-118, 30}, {-118, 30}}, color = {0, 0, 255}));
    connect(T3.in2, VSC6.plv) annotation(
      Line(points = {{-92, 18}, {-100, 18}, {-100, 8}, {-118, 8}, {-118, 8}}, color = {0, 0, 255}));
    connect(T5.in1, VSC7.plv) annotation(
      Line(points = {{-92, -29}, {-100, -29}, {-100, -22}, {-118, -22}}, color = {0, 0, 255}));
    connect(T5.in2, VSC8.plv) annotation(
      Line(points = {{-92, -35}, {-100, -35}, {-100, -44}, {-118, -44}}, color = {0, 0, 255}));
    connect(T4.in2, VSC10.plv) annotation(
      Line(points = {{-92, -90}, {-100, -90}, {-100, -100}, {-118, -100}, {-118, -100}}, color = {0, 0, 255}));
    connect(T4.in1, VSC9.plv) annotation(
      Line(points = {{-92, -86}, {-100, -86}, {-100, -76}, {-118, -76}, {-118, -76}}, color = {0, 0, 255}));
    connect(Cpcc.plug_p, pcc) annotation(
      Line(points = {{74, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T4.out3, pcc) annotation(
      Line(points = {{-72, -88}, {-40, -88}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T2.out3, pcc) annotation(
      Line(points = {{-72, 72}, {-40, 72}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T3.out3, pcc) annotation(
      Line(points = {{-72, 20}, {-40, 20}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T5.out3, pcc) annotation(
      Line(points = {{-72, -32}, {-40, -32}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(Vpcc.plug_p, Lg.plug_p) annotation(
      Line(points = {{106, 6}, {106, 6}, {106, 0}, {132, 0}, {132, 0}}));
    connect(T1.out3, pcc) annotation(
      Line(points = {{-72, 124}, {-40, 124}, {-40, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 1, extent = {{-200, -200}, {200, 200}}, grid = {1, 1}), graphics = {Text(origin = {-40, 81}, extent = {{-2, 43}, {2, -43}}, textString = "text"), Rectangle(origin = {-41, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}})}),
      Icon(coordinateSystem(initialScale = 1, extent = {{-200, -200}, {200, 200}}, grid = {1, 1})),
      version = "");
  end NGenPV;

  model vsc
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-100, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vca annotation(
      Placement(visible = true, transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vcb annotation(
      Placement(visible = true, transformation(origin = {-60, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vcc annotation(
      Placement(visible = true, transformation(origin = {-46, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.PlugToPins_p pp annotation(
      Placement(visible = true, transformation(origin = {-16, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rc(R = fill(0.005555, 3)) annotation(
      Placement(visible = true, transformation(origin = {14, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lc(L = fill(0.00006, 3)) annotation(
      Placement(visible = true, transformation(origin = {46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor PPCC annotation(
      Placement(visible = true, transformation(origin = {64, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cs annotation(
      Placement(visible = true, transformation(origin = {84, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner_control_pllm3 inner_control_pllm annotation(
      Placement(visible = true, transformation(origin = {39, -45}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    inverterMod inverterModd annotation(
      Placement(visible = true, transformation(origin = {-60, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression va(y = inner_control_pllm.va) annotation(
      Placement(visible = true, transformation(origin = {204, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression vb(y = inner_control_pllm.vb) annotation(
      Placement(visible = true, transformation(origin = {204, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression vc(y = inner_control_pllm.vc) annotation(
      Placement(visible = true, transformation(origin = {204, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ia(y = inner_control_pllm.ia) annotation(
      Placement(visible = true, transformation(origin = {204, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ib(y = inner_control_pllm.ib) annotation(
      Placement(visible = true, transformation(origin = {204, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ic(y = inner_control_pllm.ic) annotation(
      Placement(visible = true, transformation(origin = {204, -118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta1(y = inner_control_pllm.theta) annotation(
      Placement(visible = true, transformation(origin = {156, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {156, -80}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
    Ref_Computation ref_Computation annotation(
      Placement(visible = true, transformation(origin = {-10, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor iameas annotation(
      Placement(visible = true, transformation(origin = {-56, 70}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor icmeas annotation(
      Placement(visible = true, transformation(origin = {-26, 34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vab annotation(
      Placement(visible = true, transformation(origin = {-36, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vbc annotation(
      Placement(visible = true, transformation(origin = {-36, 46}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    invmodel Average annotation(
      Placement(visible = true, transformation(origin = {-136, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ia(y = iameas.i) annotation(
      Placement(visible = true, transformation(origin = {-170, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ic(y = icmeas.i) annotation(
      Placement(visible = true, transformation(origin = {-170, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Vab(y = vab.v) annotation(
      Placement(visible = true, transformation(origin = {-170, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Vbc(y = vbc.v) annotation(
      Placement(visible = true, transformation(origin = {-170, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor C(C = 0.001020) annotation(
      Placement(visible = true, transformation(origin = {-158, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression vzq(y = inner_control_pllm.Vzq) annotation(
      Placement(visible = true, transformation(origin = {-58, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 722) annotation(
      Placement(visible = true, transformation(origin = {-186, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput qref annotation(
      Placement(visible = true, transformation(origin = {-82, -138}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput pref annotation(
      Placement(visible = true, transformation(origin = {-82, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Udc(y = 800) annotation(
      Placement(visible = true, transformation(origin = {-82, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug plv annotation(
      Placement(visible = true, transformation(origin = {160, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Vca.n, ground.p) annotation(
      Line(points = {{-84, 70}, {-100, 70}, {-100, 52}}, color = {0, 0, 255}));
    connect(Vcb.n, ground.p) annotation(
      Line(points = {{-70, 52}, {-100, 52}}, color = {0, 0, 255}));
    connect(Vcb.p, pp.pin_p[2]) annotation(
      Line(points = {{-50, 52}, {-18, 52}}, color = {0, 0, 255}));
    connect(pp.plug_p, Rc.plug_p) annotation(
      Line(points = {{-14, 52}, {4, 52}}, color = {0, 0, 255}));
    connect(Rc.plug_n, Lc.plug_p) annotation(
      Line(points = {{24, 52}, {36, 52}}, color = {0, 0, 255}));
    connect(ground.p, Vcc.n) annotation(
      Line(points = {{-100, 52}, {-100, 34}, {-56, 34}}, color = {0, 0, 255}));
    connect(PPCC.phi[1], inner_control_pllm.va) annotation(
      Line(points = {{64, 18}, {64, 18}, {64, -32}, {56, -32}, {56, -32}}, color = {0, 0, 127}));
    connect(PPCC.phi[2], inner_control_pllm.vb) annotation(
      Line(points = {{64, 18}, {64, 18}, {64, -36}, {56, -36}, {56, -36}}, color = {0, 0, 127}));
    connect(Cs.i[1], inner_control_pllm.ia) annotation(
      Line(points = {{84, 41}, {84, -48}, {56, -48}, {56, -50}}, color = {0, 0, 127}));
    connect(Cs.i[2], inner_control_pllm.ib) annotation(
      Line(points = {{84, 41}, {84, -54}, {56, -54}}, color = {0, 0, 127}));
    connect(inner_control_pllm.ic, Cs.i[3]) annotation(
      Line(points = {{56, -60}, {84, -60}, {84, 41}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vc, PPCC.phi[3]) annotation(
      Line(points = {{56, -42}, {64, -42}, {64, 18}, {64, 18}}, color = {0, 0, 127}));
    connect(PPCC.plug_p, Lc.plug_n) annotation(
      Line(points = {{64, 40}, {64, 40}, {64, 52}, {56, 52}, {56, 52}}, color = {0, 0, 255}));
    connect(Vcb.v, inverterModd.vb) annotation(
      Line(points = {{-60, 40}, {-60, -11}}, color = {0, 0, 127}));
    connect(inverterModd.va, Vca.v) annotation(
      Line(points = {{-65, -11}, {-65, 18}, {-74, 18}, {-74, 58}}, color = {0, 0, 127}));
    connect(inverterModd.vc, Vcc.v) annotation(
      Line(points = {{-55, -11}, {-55, 18}, {-46, 18}, {-46, 22}}, color = {0, 0, 127}));
    connect(inverterModd.theta, inner_control_pllm.theta) annotation(
      Line(points = {{-48, -22}, {-13, -22}, {-13, -40}, {22, -40}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vd, inverterModd.vdref) annotation(
      Line(points = {{22, -56}, {-54, -56}, {-54, -34}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vq, inverterModd.vqref) annotation(
      Line(points = {{22, -50}, {-66, -50}, {-66, -34}}, color = {0, 0, 127}));
    connect(theta1.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{156, -46}, {156, -63}}, color = {0, 0, 127}));
    connect(va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{194, -40}, {182, -40}, {182, -68}, {172, -68}, {172, -68}}, color = {0, 0, 127}));
    connect(vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{194, -54}, {184, -54}, {184, -72}, {172, -72}, {172, -72}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Vc_grid, vc.y) annotation(
      Line(points = {{172, -76}, {186, -76}, {186, -70}, {194, -70}, {194, -70}, {194, -70}}, color = {0, 0, 127}));
    connect(ia.y, pac_Qac_Calculation.Ia_grid) annotation(
      Line(points = {{194, -90}, {186, -90}, {186, -82}, {172, -82}, {172, -82}}, color = {0, 0, 127}));
    connect(ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{194, -104}, {184, -104}, {184, -86}, {172, -86}, {172, -88}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ic_grid, ic.y) annotation(
      Line(points = {{172, -92}, {182, -92}, {182, -118}, {194, -118}, {194, -118}}, color = {0, 0, 127}));
    connect(ref_Computation.idref, inner_control_pllm.idref) annotation(
      Line(points = {{1, -116}, {48, -116}, {48, -62}}, color = {0, 0, 127}));
    connect(ref_Computation.iqref, inner_control_pllm.iqref) annotation(
      Line(points = {{1, -124}, {30, -124}, {30, -62}}, color = {0, 0, 127}));
    connect(Vca.p, vab.p) annotation(
      Line(points = {{-64, 70}, {-36, 70}, {-36, 68}}, color = {0, 0, 255}));
    connect(vab.n, Vcb.p) annotation(
      Line(points = {{-36, 56}, {-36, 52}, {-50, 52}}, color = {0, 0, 255}));
    connect(Vcb.p, vbc.p) annotation(
      Line(points = {{-50, 52}, {-36, 52}}, color = {0, 0, 255}));
    connect(vbc.n, Vcc.p) annotation(
      Line(points = {{-36, 40}, {-36, 34}}, color = {0, 0, 255}));
    connect(Vca.p, iameas.p) annotation(
      Line(points = {{-64, 70}, {-62, 70}}, color = {0, 0, 255}));
    connect(iameas.n, pp.pin_p[1]) annotation(
      Line(points = {{-50, 70}, {-18, 70}, {-18, 52}, {-18, 52}, {-18, 52}}, color = {0, 0, 255}));
    connect(pp.pin_p[3], icmeas.n) annotation(
      Line(points = {{-18, 52}, {-18, 52}, {-18, 34}, {-20, 34}, {-20, 34}}, color = {0, 0, 255}));
    connect(icmeas.p, Vcc.p) annotation(
      Line(points = {{-32, 34}, {-36, 34}, {-36, 34}, {-36, 34}}, color = {0, 0, 255}));
    connect(Ic.y, Average.Ic) annotation(
      Line(points = {{-159, 32}, {-140, 32}, {-140, 41}}, color = {0, 0, 127}));
    connect(Vbc.y, Average.Vbc) annotation(
      Line(points = {{-159, 18}, {-136, 18}, {-136, 41}}, color = {0, 0, 127}));
    connect(Ia.y, Average.Ia) annotation(
      Line(points = {{-159, 4}, {-132, 4}, {-132, 41}}, color = {0, 0, 127}));
    connect(Vab.y, Average.Vab) annotation(
      Line(points = {{-159, -10}, {-128, -10}, {-128, 41}}, color = {0, 0, 127}));
    connect(C.p, Average.D) annotation(
      Line(points = {{-158, 62}, {-146, 62}, {-146, 60}, {-146, 60}}, color = {0, 0, 255}));
    connect(C.n, Average.C) annotation(
      Line(points = {{-158, 42}, {-146, 42}, {-146, 44}, {-146, 44}}, color = {0, 0, 255}));
    connect(vzq.y, ref_Computation.Vzq) annotation(
      Line(points = {{-46, -112}, {-22, -112}}, color = {0, 0, 127}));
    connect(Lc.plug_n, Cs.plug_p) annotation(
      Line(points = {{56, 52}, {74, 52}}, color = {0, 0, 255}));
    connect(constantVoltage.p, C.p) annotation(
      Line(points = {{-186, 62}, {-158, 62}, {-158, 62}, {-158, 62}}, color = {0, 0, 255}));
    connect(C.n, constantVoltage.n) annotation(
      Line(points = {{-158, 42}, {-186, 42}, {-186, 42}, {-186, 42}}, color = {0, 0, 255}));
    connect(qref, ref_Computation.Qref) annotation(
      Line(points = {{-82, -138}, {-57, -138}, {-57, -128}, {-22, -128}}, color = {0, 0, 127}));
    connect(ref_Computation.Pref, pref) annotation(
      Line(points = {{-22, -120}, {-82, -120}}, color = {0, 0, 127}));
    connect(Udc.y, inverterModd.u) annotation(
      Line(points = {{-70, -76}, {-60, -76}, {-60, -34}, {-60, -34}}, color = {0, 0, 127}));
    connect(Cs.plug_n, plv) annotation(
      Line(points = {{94, 52}, {160, 52}}, color = {0, 0, 255}));
  protected
    annotation(
      uses(iPSL(version = "1.1.0"), PVSystems(version = "0.6.3"), Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(origin = {162, 52}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-2, 2}, {2, -2}}, endAngle = 360)}));
  end vsc;

  class thetamod
    extends Modelica.Blocks.Interfaces.SISO;
  equation
    y = if time < 0.001 then 1 else u;
  end thetamod;

  model trafo_three_w_NO_IND
    Modelica.Electrical.Machines.BasicMachines.Components.IdealCore core(n12 = 185.46, n13 = 185.46) annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug in1 annotation(
      Placement(visible = true, transformation(origin = {-100, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, 29}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug in2 annotation(
      Placement(visible = true, transformation(origin = {-100, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug out3 annotation(
      Placement(visible = true, transformation(origin = {96, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {101, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {-20, -66}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Interfaces.NegativePin g1 annotation(
      Placement(visible = true, transformation(origin = {-44, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-44, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Delta Delta3 annotation(
      Placement(visible = true, transformation(origin = {36, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.0006315, 3)) annotation(
      Placement(visible = true, transformation(origin = {-70, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(R = fill(0.0006315, 3)) annotation(
      Placement(visible = true, transformation(origin = {-70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor2(R = fill(2.40625, 3)) annotation(
      Placement(visible = true, transformation(origin = {68, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  equation
    connect(core.plug_n3, star.plug_p) annotation(
      Line(points = {{-10, -8}, {-20, -8}, {-20, -56}, {-20, -56}}, color = {0, 0, 255}));
    connect(star.pin_n, g1) annotation(
      Line(points = {{-20, -76}, {-20, -76}, {-20, -96}, {-44, -96}, {-44, -96}}, color = {0, 0, 255}));
    connect(Delta3.plug_n, core.plug_n1) annotation(
      Line(points = {{26, -8}, {10, -8}}, color = {0, 0, 255}));
    connect(core.plug_n2, core.plug_n3) annotation(
      Line(points = {{-10, 6}, {-16, 6}, {-16, -8}, {-10, -8}, {-10, -8}}, color = {0, 0, 255}));
    connect(in1, resistor.plug_p) annotation(
      Line(points = {{-100, 46}, {-80, 46}}, color = {0, 0, 255}));
    connect(resistor1.plug_p, in2) annotation(
      Line(points = {{-80, 8}, {-100, 8}}, color = {0, 0, 255}));
    connect(resistor2.plug_p, out3) annotation(
      Line(points = {{78, 20}, {94, 20}, {94, 18}, {96, 18}}, color = {0, 0, 255}));
    connect(Delta3.plug_p, resistor2.plug_p) annotation(
      Line(points = {{46, -8}, {78, -8}, {78, 20}}, color = {0, 0, 255}));
    connect(core.plug_p2, resistor.plug_n) annotation(
      Line(points = {{-10, 12}, {-28, 12}, {-28, 46}, {-60, 46}, {-60, 46}}, color = {0, 0, 255}));
    connect(resistor1.plug_n, core.plug_p3) annotation(
      Line(points = {{-60, 8}, {-28, 8}, {-28, -2}, {-10, -2}, {-10, -2}}, color = {0, 0, 255}));
    connect(core.plug_p1, resistor2.plug_n) annotation(
      Line(points = {{10, 12}, {20, 12}, {20, 20}, {58, 20}, {58, 20}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Ellipse(origin = {-33, 28}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {31, 0}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {-33, -28}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Line(origin = {-88.3134, 28.0896}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {-88.3134, -27.7014}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {83.7612, -0.432763}, points = {{-8, 0}, {12, 0}, {-8, 0}}), Text(origin = {-24, 114}, extent = {{-82, 14}, {108, -24}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end trafo_three_w_NO_IND;

  model trafo_three_w
    Modelica.Electrical.Machines.BasicMachines.Components.IdealCore core(n12 = 185.46, n13 = 185.46) annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug in1 annotation(
      Placement(visible = true, transformation(origin = {-100, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, 29}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug in2 annotation(
      Placement(visible = true, transformation(origin = {-100, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug out3 annotation(
      Placement(visible = true, transformation(origin = {96, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {101, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {-20, -66}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Delta Delta3 annotation(
      Placement(visible = true, transformation(origin = {36, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.0006315, 3)) annotation(
      Placement(visible = true, transformation(origin = {-82, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor1(R = fill(0.0006315, 3)) annotation(
      Placement(visible = true, transformation(origin = {-82, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor2(R = fill(2.40625, 3)) annotation(
      Placement(visible = true, transformation(origin = {62, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(1.331e-5, 3)) annotation(
      Placement(visible = true, transformation(origin = {-56, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor1(L = fill(1.331e-5, 3)) annotation(
      Placement(visible = true, transformation(origin = {-56, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor2(L = fill(0.05073, 3)) annotation(
      Placement(visible = true, transformation(origin = {36, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
      Placement(visible = true, transformation(origin = {-54, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-54, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(core.plug_n3, star.plug_p) annotation(
      Line(points = {{-10, -8}, {-20, -8}, {-20, -56}, {-20, -56}}, color = {0, 0, 255}));
    connect(Delta3.plug_n, core.plug_n1) annotation(
      Line(points = {{26, -8}, {10, -8}}, color = {0, 0, 255}));
    connect(in1, resistor.plug_p) annotation(
      Line(points = {{-100, 46}, {-92, 46}}, color = {0, 0, 255}));
    connect(resistor1.plug_p, in2) annotation(
      Line(points = {{-92, 8}, {-100, 8}}, color = {0, 0, 255}));
    connect(resistor2.plug_p, out3) annotation(
      Line(points = {{72, 20}, {94, 20}, {94, 18}, {96, 18}}, color = {0, 0, 255}));
    connect(resistor.plug_n, inductor.plug_p) annotation(
      Line(points = {{-72, 46}, {-66, 46}}, color = {0, 0, 255}));
    connect(resistor1.plug_n, inductor1.plug_p) annotation(
      Line(points = {{-72, 8}, {-66, 8}}, color = {0, 0, 255}));
    connect(resistor2.plug_n, inductor2.plug_p) annotation(
      Line(points = {{52, 20}, {46, 20}}, color = {0, 0, 255}));
    connect(inductor2.plug_n, core.plug_p1) annotation(
      Line(points = {{26, 20}, {18, 20}, {18, 12}, {10, 12}, {10, 12}}, color = {0, 0, 255}));
    connect(core.plug_n2, star.plug_p) annotation(
      Line(points = {{-10, 6}, {-20, 6}, {-20, -56}, {-20, -56}}, color = {0, 0, 255}));
    connect(inductor.plug_n, core.plug_p2) annotation(
      Line(points = {{-46, 46}, {-20, 46}, {-20, 12}, {-10, 12}, {-10, 12}}, color = {0, 0, 255}));
    connect(core.plug_p3, inductor1.plug_n) annotation(
      Line(points = {{-10, -2}, {-30, -2}, {-30, 8}, {-46, 8}, {-46, 8}}, color = {0, 0, 255}));
    connect(Delta3.plug_p, resistor2.plug_p) annotation(
      Line(points = {{46, -8}, {72, -8}, {72, 20}, {72, 20}}, color = {0, 0, 255}));
  connect(star.pin_n, pin_n) annotation(
      Line(points = {{-20, -76}, {-20, -76}, {-20, -92}, {-54, -92}, {-54, -92}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Ellipse(origin = {-33, 28}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {31, 0}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {-33, -28}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Line(origin = {-88.3134, 28.0896}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {-88.3134, -27.7014}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {83.7612, -0.432763}, points = {{-8, 0}, {12, 0}, {-8, 0}}), Text(origin = {-24, 114}, extent = {{-82, 14}, {108, -24}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end trafo_three_w;

  class Vzqmod
    extends Modelica.Blocks.Interfaces.SISO;
  equation
    y = if time < 0.001 then 1 else u;
  end Vzqmod;

  block Pac_Qac_Calculation
    Modelica.Blocks.Interfaces.RealInput Va_grid annotation(
      Placement(visible = true, transformation(origin = {-81, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {-81, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Vb_grid annotation(
      Placement(visible = true, transformation(origin = {-53, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {-53, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Vc_grid annotation(
      Placement(visible = true, transformation(origin = {-25, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {-23, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Ia_grid annotation(
      Placement(visible = true, transformation(origin = {25, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {19, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Ib_grid annotation(
      Placement(visible = true, transformation(origin = {55, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {51, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput Ic_grid annotation(
      Placement(visible = true, transformation(origin = {79, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {79, 111}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
    Park park annotation(
      Placement(visible = true, transformation(origin = {-53, 29}, extent = {{-17, -17}, {17, 17}}, rotation = -90)));
    Park park1 annotation(
      Placement(visible = true, transformation(origin = {55, 29}, extent = {{-17, -17}, {17, 17}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput theta annotation(
      Placement(visible = true, transformation(origin = {-120, 28}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Product vq_iq annotation(
      Placement(visible = true, transformation(origin = {-89, -51}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Math.Product vd_id annotation(
      Placement(visible = true, transformation(origin = {-31, -51}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Math.Product vd_iq annotation(
      Placement(visible = true, transformation(origin = {89, -51}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput Qac annotation(
      Placement(visible = true, transformation(origin = {50, -132}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {52, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add vqiq_vdid annotation(
      Placement(visible = true, transformation(origin = {-51, -81}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Math.Add add1(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {49, -79}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Math.Product vq_id annotation(
      Placement(visible = true, transformation(origin = {31, -51}, extent = {{-7, -7}, {7, 7}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain1(k = 3 / 2) annotation(
      Placement(visible = true, transformation(origin = {50, -106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput Pac annotation(
      Placement(visible = true, transformation(origin = {-50, -132}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-50, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain(k = 3 / 2) annotation(
      Placement(visible = true, transformation(origin = {-50, -106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(gain1.y, Qac) annotation(
      Line(points = {{50, -117}, {50, -132}}, color = {0, 0, 127}));
    connect(gain.y, Pac) annotation(
      Line(points = {{-50, -117}, {-50, -132}}, color = {0, 0, 127}));
    connect(gain.y, Pac) annotation(
      Line(points = {{-50, -117}, {-50, -132}}, color = {0, 0, 127}));
    connect(park.d, vd_id.u2) annotation(
      Line(points = {{-58, 18}, {-58, 18}, {-58, -28}, {-36, -28}, {-36, -42}, {-36, -42}}, color = {0, 0, 127}));
    connect(park.d, vd_iq.u2) annotation(
      Line(points = {{-58, 18}, {-58, 18}, {-58, -18}, {84, -18}, {84, -42}, {84, -42}}, color = {0, 0, 127}));
    connect(park.q, vq_id.u2) annotation(
      Line(points = {{-48, 18}, {-48, 18}, {-48, 0}, {26, 0}, {26, -42}, {26, -42}}, color = {0, 0, 127}));
    connect(park1.d, vq_id.u1) annotation(
      Line(points = {{50, 18}, {50, 18}, {50, 0}, {34, 0}, {34, -42}, {36, -42}}, color = {0, 0, 127}));
    connect(park1.d, vd_id.u1) annotation(
      Line(points = {{50, 18}, {50, 18}, {50, -28}, {-26, -28}, {-26, -42}, {-26, -42}}, color = {0, 0, 127}));
    connect(park1.q, vd_iq.u1) annotation(
      Line(points = {{60, 18}, {60, 18}, {60, -10}, {94, -10}, {94, -42}, {94, -42}}, color = {0, 0, 127}));
    connect(park1.q, vq_iq.u1) annotation(
      Line(points = {{60, 18}, {60, 18}, {60, -10}, {-86, -10}, {-86, -42}, {-84, -42}}, color = {0, 0, 127}));
    connect(park.q, vq_iq.u2) annotation(
      Line(points = {{-48, 18}, {-48, 18}, {-48, 0}, {-94, 0}, {-94, -42}, {-94, -42}}, color = {0, 0, 127}));
    connect(vq_iq.y, vqiq_vdid.u2) annotation(
      Line(points = {{-88, -58}, {-88, -66}, {-54, -66}, {-54, -73}, {-55, -73}}, color = {0, 0, 127}));
    connect(vd_id.y, vqiq_vdid.u1) annotation(
      Line(points = {{-30, -58}, {-32, -58}, {-32, -66}, {-47, -66}, {-47, -73}}, color = {0, 0, 127}));
    connect(vq_id.y, add1.u2) annotation(
      Line(points = {{32, -58}, {32, -66}, {45, -66}, {45, -71}}, color = {0, 0, 127}));
    connect(vd_iq.y, add1.u1) annotation(
      Line(points = {{90, -58}, {90, -66}, {53, -66}, {53, -71}}, color = {0, 0, 127}));
    connect(vqiq_vdid.y, gain.u) annotation(
      Line(points = {{-51, -89}, {-51, -103}, {-50, -103}, {-50, -94}}, color = {0, 0, 127}));
    connect(add1.y, gain1.u) annotation(
      Line(points = {{49, -87}, {48, -87}, {48, -94}, {50, -94}}, color = {0, 0, 127}));
    connect(theta, park.theta) annotation(
      Line(points = {{-120, 28}, {-74, 28}, {-74, 28}, {-72, 28}}, color = {0, 0, 127}));
    connect(park.b, Vb_grid) annotation(
      Line(points = {{-54, 48}, {-52, 48}, {-52, 112}, {-52, 112}}, color = {0, 0, 127}));
    connect(park.a, Va_grid) annotation(
      Line(points = {{-46, 48}, {-46, 62}, {-84, 62}, {-84, 111}, {-81, 111}}, color = {0, 0, 127}));
    connect(park1.c, Ic_grid) annotation(
      Line(points = {{48, 48}, {48, 60}, {80, 60}, {80, 111}, {79, 111}}, color = {0, 0, 127}));
    connect(park1.b, Ib_grid) annotation(
      Line(points = {{54, 48}, {55, 48}, {55, 111}}, color = {0, 0, 127}));
    connect(park1.a, Ia_grid) annotation(
      Line(points = {{62, 48}, {62, 48}, {62, 62}, {24, 62}, {24, 112}, {26, 112}}, color = {0, 0, 127}));
    connect(park.c, Vc_grid) annotation(
      Line(points = {{-60, 48}, {-60, 48}, {-60, 60}, {-26, 60}, {-26, 112}, {-24, 112}}, color = {0, 0, 127}));
    connect(theta, park1.theta) annotation(
      Line(points = {{-120, 28}, {-78, 28}, {-78, 4}, {26, 4}, {26, 28}, {36, 28}, {36, 28}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {11, 25}, rotation = 90, extent = {{-85, 69}, {43, -33}}, textString = "P Q"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
  end Pac_Qac_Calculation;

  block P_a_I
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Real eps = 0.001;
  equation
    y = if noEvent(abs(u2) > 0) then 2 * u1 / (3 * u2) else 11.78;
    annotation(
      Icon(graphics = {Text(origin = {-3, 5}, extent = {{-49, 33}, {49, -33}}, textString = "2/3vq")}));
  end P_a_I;

  block Park
    Modelica.Blocks.Interfaces.RealInput a annotation(
      Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, 39}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput b annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput c annotation(
      Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -41}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput theta annotation(
      Placement(visible = true, transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {1, -115}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput q annotation(
      Placement(visible = true, transformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput d annotation(
      Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    constant Real pi = Modelica.Constants.pi;
  equation
    q = 2 / 3 * (a * cos(theta) + b * cos(theta - 2 * pi / 3) + c * cos(theta + 2 * pi / 3));
    d = 2 / 3 * (a * sin(theta) + b * sin(theta - 2 * pi / 3) + c * sin(theta + 2 * pi / 3));
    annotation(
      Diagram(coordinateSystem(initialScale = 0.1)),
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(origin = {-1, 9}, extent = {{-99, 91}, {101, -109}}), Text(origin = {-16.9714, -12.5}, rotation = -90, extent = {{-70.5, 58.9714}, {37.5, -37.0286}}, textString = "Park"), Text(origin = {-84, 40}, extent = {{-10, 8}, {10, -8}}, textString = "a"), Text(origin = {-84, 0}, extent = {{-10, 8}, {10, -8}}, textString = "b"), Text(origin = {-84, -38}, extent = {{-10, 8}, {10, -8}}, textString = "c"), Text(origin = {0, -88}, extent = {{-10, 8}, {10, -8}}, textString = "theta"), Text(origin = {86, -30}, extent = {{-10, 8}, {10, -8}}, textString = "d"), Text(origin = {88, 30}, extent = {{-10, 8}, {10, -8}}, textString = "q")}, coordinateSystem(initialScale = 0.1)));
  end Park;

  block PI_PLL
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(visible = true, transformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 1.34335) annotation(
      Placement(visible = true, transformation(origin = {-6, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 298.463) annotation(
      Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(integrator.y, add.u2) annotation(
      Line(points = {{32, -30}, {44, -30}, {44, -6}, {50, -6}}, color = {0, 0, 127}));
    connect(add.y, y) annotation(
      Line(points = {{73, 0}, {100, 0}}, color = {0, 0, 127}));
    connect(gain1.y, integrator.u) annotation(
      Line(points = {{-28, -30}, {8, -30}, {8, -30}, {8, -30}}, color = {0, 0, 127}));
    connect(gain1.u, u) annotation(
      Line(points = {{-52, -30}, {-64, -30}, {-64, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 127}));
    connect(gain.y, add.u1) annotation(
      Line(points = {{6, 36}, {44, 36}, {44, 6}, {50, 6}, {50, 6}}, color = {0, 0, 127}));
    connect(gain.u, u) annotation(
      Line(points = {{-18, 36}, {-64, 36}, {-64, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 5}, extent = {{-60, 39}, {60, -39}}, textString = "PI"), Text(origin = {13, 110}, extent = {{-93, 46}, {49, -24}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end PI_PLL;

  block PI_PLLmv
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(visible = true, transformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 0.01256) annotation(
      Placement(visible = true, transformation(origin = {-6, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 2.7915) annotation(
      Placement(visible = true, transformation(origin = {-40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(integrator.y, add.u2) annotation(
      Line(points = {{32, -30}, {44, -30}, {44, -6}, {50, -6}}, color = {0, 0, 127}));
    connect(add.y, y) annotation(
      Line(points = {{73, 0}, {100, 0}}, color = {0, 0, 127}));
    connect(gain1.y, integrator.u) annotation(
      Line(points = {{-28, -30}, {8, -30}, {8, -30}, {8, -30}}, color = {0, 0, 127}));
    connect(gain1.u, u) annotation(
      Line(points = {{-52, -30}, {-64, -30}, {-64, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 127}));
    connect(gain.y, add.u1) annotation(
      Line(points = {{6, 36}, {44, 36}, {44, 6}, {50, 6}, {50, 6}}, color = {0, 0, 127}));
    connect(gain.u, u) annotation(
      Line(points = {{-18, 36}, {-64, 36}, {-64, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Text(origin = {0, 5}, extent = {{-60, 39}, {60, -39}}, textString = "PI"), Text(origin = {13, 110}, extent = {{-93, 46}, {49, -24}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
  end PI_PLLmv;

  block PLL2
    Modelica.Blocks.Interfaces.RealInput Va_grid annotation(
      Placement(visible = true, transformation(origin = {-57, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, 59}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Vb_grid annotation(
      Placement(visible = true, transformation(origin = {1, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Vc_grid annotation(
      Placement(visible = true, transformation(origin = {61, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, -59}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput theta annotation(
      Placement(visible = true, transformation(origin = {78, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Park park annotation(
      Placement(visible = true, transformation(origin = {1, -33}, extent = {{-19, -19}, {19, 19}}, rotation = 90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {4, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Vzq annotation(
      Placement(visible = true, transformation(origin = {-86, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(visible = true, transformation(origin = {-84, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const0(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-128, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PI_PLL pi_pll_kf annotation(
      Placement(visible = true, transformation(origin = {-34, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    modu m annotation(
      Placement(visible = true, transformation(origin = {42, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Vb_grid, park.b) annotation(
      Line(points = {{1, -113}, {1, -54}}, color = {0, 0, 127}));
    connect(park.q, Vzq) annotation(
      Line(points = {{-4, -12}, {-4, -4}, {-86, -4}}, color = {0, 0, 127}));
    connect(const0.y, feedback.u1) annotation(
      Line(points = {{-116, 40}, {-90, 40}, {-90, 40}, {-92, 40}}, color = {0, 0, 127}));
    connect(feedback.u2, park.d) annotation(
      Line(points = {{-84, 32}, {-84, 32}, {-84, 2}, {6, 2}, {6, -12}, {6, -12}}, color = {0, 0, 127}));
    connect(feedback.y, pi_pll_kf.u) annotation(
      Line(points = {{-74, 40}, {-46, 40}, {-46, 40}, {-44, 40}}, color = {0, 0, 127}));
    connect(pi_pll_kf.y, integrator.u) annotation(
      Line(points = {{-24, 40}, {-8, 40}}, color = {0, 0, 127}));
    connect(Va_grid, park.a) annotation(
      Line(points = {{-57, -113}, {-58, -113}, {-58, -60}, {-6, -60}, {-6, -54}}, color = {0, 0, 127}));
    connect(park.c, Vc_grid) annotation(
      Line(points = {{8, -54}, {8, -60}, {61, -60}, {61, -113}}, color = {0, 0, 127}));
    connect(theta, park.theta) annotation(
      Line(points = {{78, 40}, {82, 40}, {82, -34}, {22, -34}, {22, -32}}, color = {0, 0, 127}));
    connect(m.y, theta) annotation(
      Line(points = {{52, 40}, {72, 40}, {72, 40}, {78, 40}}, color = {0, 0, 127}));
    connect(integrator.y, m.u) annotation(
      Line(points = {{16, 40}, {28, 40}, {28, 40}, {30, 40}}, color = {0, 0, 127}));
  protected
    annotation(
      uses(Modelica(version = "3.2.3")),
      Diagram,
      Icon(graphics = {Rectangle(origin = {-8, 1}, extent = {{-92, 99}, {108, -101}}), Text(origin = {29, -12}, extent = {{-65, 38}, {17, -12}}, textString = "PLL"), Text(origin = {-85, 59}, extent = {{-11, 5}, {11, -5}}, textString = "Va"), Text(origin = {81, -45}, extent = {{-11, 5}, {11, -5}}, textString = "theta"), Text(origin = {77, 51}, extent = {{-11, 5}, {11, -5}}, textString = "Vzq"), Text(origin = {-85, -59}, extent = {{-11, 5}, {11, -5}}, textString = "Vc"), Text(origin = {-85, 1}, extent = {{-11, 5}, {11, -5}}, textString = "Vb")}, coordinateSystem(initialScale = 0.1)));
  end PLL2;

  block PLLMV
    Modelica.Blocks.Interfaces.RealInput Va_grid annotation(
      Placement(visible = true, transformation(origin = {-57, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, 59}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Vb_grid annotation(
      Placement(visible = true, transformation(origin = {1, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Vc_grid annotation(
      Placement(visible = true, transformation(origin = {61, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90), iconTransformation(origin = {-113, -59}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput theta annotation(
      Placement(visible = true, transformation(origin = {78, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Park park annotation(
      Placement(visible = true, transformation(origin = {1, -33}, extent = {{-19, -19}, {19, 19}}, rotation = 90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {4, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Vzq annotation(
      Placement(visible = true, transformation(origin = {-86, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(visible = true, transformation(origin = {-84, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const0(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-128, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PI_PLLmv pI_PLLmv annotation(
      Placement(visible = true, transformation(origin = {-44, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Vb_grid, park.b) annotation(
      Line(points = {{1, -113}, {1, -54}}, color = {0, 0, 127}));
    connect(park.q, Vzq) annotation(
      Line(points = {{-4, -12}, {-4, -4}, {-86, -4}}, color = {0, 0, 127}));
    connect(const0.y, feedback.u1) annotation(
      Line(points = {{-116, 40}, {-90, 40}, {-90, 40}, {-92, 40}}, color = {0, 0, 127}));
    connect(feedback.u2, park.d) annotation(
      Line(points = {{-84, 32}, {-84, 32}, {-84, 2}, {6, 2}, {6, -12}, {6, -12}}, color = {0, 0, 127}));
    connect(Va_grid, park.a) annotation(
      Line(points = {{-57, -113}, {-58, -113}, {-58, -60}, {-6, -60}, {-6, -54}}, color = {0, 0, 127}));
    connect(park.c, Vc_grid) annotation(
      Line(points = {{8, -54}, {8, -60}, {61, -60}, {61, -113}}, color = {0, 0, 127}));
    connect(theta, park.theta) annotation(
      Line(points = {{78, 40}, {82, 40}, {82, -34}, {22, -34}, {22, -32}}, color = {0, 0, 127}));
    connect(feedback.y, pI_PLLmv.u) annotation(
      Line(points = {{-74, 40}, {-54, 40}, {-54, 40}, {-54, 40}}, color = {0, 0, 127}));
    connect(pI_PLLmv.y, integrator.u) annotation(
      Line(points = {{-34, 40}, {-8, 40}, {-8, 40}, {-8, 40}}, color = {0, 0, 127}));
    connect(integrator.y, theta) annotation(
      Line(points = {{16, 40}, {74, 40}, {74, 40}, {78, 40}}, color = {0, 0, 127}));
  protected
    annotation(
      uses(Modelica(version = "3.2.3")),
      Diagram,
      Icon(graphics = {Rectangle(origin = {-8, 1}, extent = {{-92, 99}, {108, -101}}), Text(origin = {29, -12}, extent = {{-65, 38}, {17, -12}}, textString = "PLL"), Text(origin = {-85, 59}, extent = {{-11, 5}, {11, -5}}, textString = "Va"), Text(origin = {81, -45}, extent = {{-11, 5}, {11, -5}}, textString = "theta"), Text(origin = {77, 51}, extent = {{-11, 5}, {11, -5}}, textString = "Vzq"), Text(origin = {-85, -59}, extent = {{-11, 5}, {11, -5}}, textString = "Vc"), Text(origin = {-85, 1}, extent = {{-11, 5}, {11, -5}}, textString = "Vb")}, coordinateSystem(initialScale = 0.1)));
  end PLLMV;

  model Power_Control
    Modelica.Blocks.Interfaces.RealInput PTSO annotation(
      Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput QTSO annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ppvpp annotation(
      Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 28}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Qpvpp annotation(
      Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -28}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {-80, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain kpp(k = 1.068) annotation(
      Placement(visible = true, transformation(origin = {-50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain kpq(k = 0.5) annotation(
      Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator(k = 10) annotation(
      Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator1(k = 0.574) annotation(
      Placement(visible = true, transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {-10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division division annotation(
      Placement(visible = true, transformation(origin = {52, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division division1 annotation(
      Placement(visible = true, transformation(origin = {52, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 1) annotation(
      Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter Pminmax(limitsAtInit = true, uMax = 8360000, uMin = -8360000) annotation(
      Placement(visible = true, transformation(origin = {22, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Nonlinear.Limiter Qminmax(limitsAtInit = true, uMax = 8360000, uMin = -8360000) annotation(
      Placement(visible = true, transformation(origin = {22, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Pref annotation(
      Placement(visible = true, transformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Qref annotation(
      Placement(visible = true, transformation(origin = {110, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(QTSO, feedback1.u1) annotation(
      Line(points = {{-120, -60}, {-88, -60}}, color = {0, 0, 127}));
    connect(Qpvpp, feedback1.u2) annotation(
      Line(points = {{-120, -20}, {-80, -20}, {-80, -52}}, color = {0, 0, 127}));
    connect(Ppvpp, feedback.u2) annotation(
      Line(points = {{-120, 20}, {-80, 20}, {-80, 52}}, color = {0, 0, 127}));
    connect(feedback.u1, PTSO) annotation(
      Line(points = {{-88, 60}, {-120, 60}}, color = {0, 0, 127}));
    connect(kpp.u, feedback.y) annotation(
      Line(points = {{-62, 80}, {-68, 80}, {-68, 60}, {-70, 60}, {-70, 60}}, color = {0, 0, 127}));
    connect(kpq.u, feedback1.y) annotation(
      Line(points = {{-62, -40}, {-68, -40}, {-68, -60}, {-70, -60}, {-70, -60}}, color = {0, 0, 127}));
    connect(integrator.u, feedback1.y) annotation(
      Line(points = {{-62, -80}, {-68, -80}, {-68, -60}, {-70, -60}, {-70, -60}}, color = {0, 0, 127}));
    connect(integrator1.u, feedback.y) annotation(
      Line(points = {{-62, 40}, {-68, 40}, {-68, 60}, {-70, 60}, {-70, 60}}, color = {0, 0, 127}));
    connect(kpq.y, add1.u1) annotation(
      Line(points = {{-38, -40}, {-32, -40}, {-32, -54}, {-22, -54}, {-22, -54}}, color = {0, 0, 127}));
    connect(add1.u2, integrator.y) annotation(
      Line(points = {{-22, -66}, {-32, -66}, {-32, -80}, {-38, -80}, {-38, -80}}, color = {0, 0, 127}));
    connect(add.u1, kpp.y) annotation(
      Line(points = {{-22, 66}, {-30, 66}, {-30, 80}, {-38, 80}, {-38, 80}}, color = {0, 0, 127}));
    connect(integrator1.y, add.u2) annotation(
      Line(points = {{-38, 40}, {-30, 40}, {-30, 54}, {-22, 54}, {-22, 54}}, color = {0, 0, 127}));
    connect(add.y, Pminmax.u) annotation(
      Line(points = {{2, 60}, {10, 60}}, color = {0, 0, 127}));
    connect(add1.y, Qminmax.u) annotation(
      Line(points = {{2, -60}, {8, -60}, {8, -60}, {10, -60}}, color = {0, 0, 127}));
    connect(Pminmax.y, division.u1) annotation(
      Line(points = {{34, 60}, {38, 60}, {38, 60}, {40, 60}}, color = {0, 0, 127}));
    connect(Qminmax.y, division1.u1) annotation(
      Line(points = {{34, -60}, {40, -60}}, color = {0, 0, 127}));
    connect(Ngen.y, division.u2) annotation(
      Line(points = {{18, 0}, {36, 0}, {36, 48}, {40, 48}, {40, 48}}, color = {0, 0, 127}));
    connect(Ngen.y, division1.u2) annotation(
      Line(points = {{18, 0}, {36, 0}, {36, -72}, {40, -72}, {40, -72}}, color = {0, 0, 127}));
    connect(division.y, Pref) annotation(
      Line(points = {{64, 54}, {110, 54}}, color = {0, 0, 127}));
    connect(division1.y, Qref) annotation(
      Line(points = {{64, -66}, {100, -66}, {100, -66}, {110, -66}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")));
  end Power_Control;

  block Ref_Computation
    Modelica.Blocks.Interfaces.RealInput Vzq annotation(
      Placement(visible = true, transformation(origin = {-120, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Pref annotation(
      Placement(visible = true, transformation(origin = {-122, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-122, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Qref annotation(
      Placement(visible = true, transformation(origin = {-120, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput idref annotation(
      Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput iqref annotation(
      Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    iqref = if noEvent(abs(Vzq) > 0) then 2 / 3 * Pref / Vzq else Pref;
    idref = if noEvent(abs(Vzq) > 0) then 2 / 3 * Qref / Vzq else Qref;
    annotation(
      uses(Modelica(version = "3.2.3")));
  end Ref_Computation;

  model invmodel
    Modelica.Electrical.Analog.Interfaces.Pin D annotation(
      Placement(visible = true, transformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin C annotation(
      Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalCurrent idc annotation(
      Placement(visible = true, transformation(origin = {-80, -36}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor Vdc annotation(
      Placement(visible = true, transformation(origin = {-60, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Product product1 annotation(
      Placement(visible = true, transformation(origin = {82, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Add Pac(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Division division annotation(
      Placement(visible = true, transformation(origin = {-44, -36}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Math.Abs abs1 annotation(
      Placement(visible = true, transformation(origin = {-32, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {-100, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(0.0054, 3)) annotation(
      Placement(visible = true, transformation(origin = {278, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground2 annotation(
      Placement(visible = true, transformation(origin = {350, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {328, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V = fill(400, 3), freqHz = fill(50, 3), phase = {0, -2.0944, 2.0944}) annotation(
      Placement(visible = true, transformation(origin = {302, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {2, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 0.001) annotation(
      Placement(visible = true, transformation(origin = {-38, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ia annotation(
      Placement(visible = true, transformation(origin = {120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {41, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput Ic annotation(
      Placement(visible = true, transformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {-43, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput Vab annotation(
      Placement(visible = true, transformation(origin = {120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {81, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput Vbc annotation(
      Placement(visible = true, transformation(origin = {120, -28}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {-1, -113}, extent = {{-13, -13}, {13, 13}}, rotation = 90)));
    Modelica.Blocks.Math.Product Pdc annotation(
      Placement(visible = true, transformation(origin = {4, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(idc.n, D) annotation(
      Line(points = {{-80, -26}, {-80, 80}, {-100, 80}}, color = {0, 0, 255}));
    connect(idc.p, C) annotation(
      Line(points = {{-80, -46}, {-80, -80}, {-100, -80}}, color = {0, 0, 255}));
    connect(D, Vdc.n) annotation(
      Line(points = {{-100, 80}, {-60, 80}, {-60, 32}, {-60, 32}}, color = {0, 0, 255}));
    connect(Vdc.p, C) annotation(
      Line(points = {{-60, 12}, {-60, 12}, {-60, -80}, {-100, -80}, {-100, -80}}, color = {0, 0, 255}));
    connect(Vdc.v, abs1.u) annotation(
      Line(points = {{-48, 22}, {-44, 22}}, color = {0, 0, 127}));
    connect(division.y, idc.i) annotation(
      Line(points = {{-55, -36}, {-68, -36}}, color = {0, 0, 127}));
    connect(ground1.p, C) annotation(
      Line(points = {{-100, -88}, {-100, -88}, {-100, -80}, {-100, -80}}, color = {0, 0, 255}));
    connect(star.pin_n, ground2.p) annotation(
      Line(points = {{338, 0}, {350, 0}, {350, -18}}, color = {0, 0, 255}));
    connect(sineVoltage.plug_p, inductor.plug_n) annotation(
      Line(points = {{292, 0}, {288, 0}}, color = {0, 0, 255}));
    connect(sineVoltage.plug_n, star.plug_p) annotation(
      Line(points = {{312, 0}, {318, 0}}, color = {0, 0, 255}));
    connect(product.y, Pac.u2) annotation(
      Line(points = {{73, 50}, {64, 50}, {64, 6}, {58, 6}}, color = {0, 0, 127}));
    connect(product1.y, Pac.u1) annotation(
      Line(points = {{71, -56}, {64, -56}, {64, -6}, {58, -6}}, color = {0, 0, 127}));
    connect(add1.u1, const.y) annotation(
      Line(points = {{-10, 52}, {-20, 52}, {-20, 56}, {-26, 56}}, color = {0, 0, 127}));
    connect(add1.u2, abs1.y) annotation(
      Line(points = {{-10, 40}, {-16, 40}, {-16, 22}, {-20, 22}, {-20, 22}}, color = {0, 0, 127}));
    connect(add1.y, division.u2) annotation(
      Line(points = {{14, 46}, {22, 46}, {22, -42}, {-32, -42}, {-32, -42}}, color = {0, 0, 127}));
    connect(Pac.y, division.u1) annotation(
      Line(points = {{36, 0}, {8, 0}, {8, -30}, {-32, -30}, {-32, -30}}, color = {0, 0, 127}));
    connect(Vab, product.u2) annotation(
      Line(points = {{120, 80}, {100, 80}, {100, 56}, {96, 56}, {96, 56}, {96, 56}}, color = {0, 0, 127}));
    connect(Ia, product.u1) annotation(
      Line(points = {{120, 20}, {100, 20}, {100, 42}, {96, 42}, {96, 44}}, color = {0, 0, 127}));
    connect(Vbc, product1.u2) annotation(
      Line(points = {{120, -28}, {98, -28}, {98, -50}, {94, -50}, {94, -50}}, color = {0, 0, 127}));
    connect(Ic, product1.u1) annotation(
      Line(points = {{120, -80}, {98, -80}, {98, -62}, {94, -62}, {94, -62}}, color = {0, 0, 127}));
    connect(idc.i, Pdc.u2) annotation(
      Line(points = {{-68, -36}, {-60, -36}, {-60, -94}, {-8, -94}, {-8, -94}}, color = {0, 0, 127}));
    connect(add1.y, Pdc.u1) annotation(
      Line(points = {{14, 46}, {22, 46}, {22, -68}, {-20, -68}, {-20, -82}, {-8, -82}, {-8, -82}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3")));
  end invmodel;

  model m10
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-68, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-68, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-30, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-70, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-30, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-70, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-70, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-30, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T1 annotation(
      Placement(visible = true, transformation(origin = {-22, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T2 annotation(
      Placement(visible = true, transformation(origin = {16, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T3 annotation(
      Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T4 annotation(
      Placement(visible = true, transformation(origin = {-24, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T5 annotation(
      Placement(visible = true, transformation(origin = {16, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line1 line1 annotation(
      Placement(visible = true, transformation(origin = {50, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line2 line2 annotation(
      Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line3 line3 annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line4 line4 annotation(
      Placement(visible = true, transformation(origin = {50, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line5 line5 annotation(
      Placement(visible = true, transformation(origin = {50, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug PCCM10 annotation(
      Placement(visible = true, transformation(origin = {118, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Pref annotation(
      Placement(visible = true, transformation(origin = {-114, 8}, extent = {{-8, -8}, {8, 8}}, rotation = 0), iconTransformation(origin = {-112, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Qref annotation(
      Placement(visible = true, transformation(origin = {-114, -10}, extent = {{-8, -8}, {8, 8}}, rotation = 0), iconTransformation(origin = {-112, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_CalculationM10 annotation(
      Placement(visible = true, transformation(origin = {176, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor cPCC annotation(
      Placement(visible = true, transformation(origin = {156, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor pPCC annotation(
      Placement(visible = true, transformation(origin = {176, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug P annotation(
      Placement(visible = true, transformation(origin = {226, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression ia(y = cPCC.i[1]) annotation(
      Placement(visible = true, transformation(origin = {222, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression ib(y = cPCC.i[2]) annotation(
      Placement(visible = true, transformation(origin = {222, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression ic(y = cPCC.i[3]) annotation(
      Placement(visible = true, transformation(origin = {222, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression va(y = pPCC.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {222, 124}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression vb(y = pPCC.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {222, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression vc(y = pPCC.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {222, 96}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {192, 140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {176, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression PM10(y = Pref * 10) annotation(
      Placement(visible = true, transformation(origin = {170, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression QM10(y = Qref * 10) annotation(
      Placement(visible = true, transformation(origin = {170, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-32, 97}, {-32, 97.5}, {-38, 97.5}, {-38, 90}, {-57, 90}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-34, 3}, {-40, 3}, {-40, 10}, {-59, 10}}, color = {0, 0, 255}));
    connect(T5.in1, VSC7.plv) annotation(
      Line(points = {{6, -43}, {6, -43.5}, {0, -43.5}, {0, -36}, {-19, -36}}, color = {0, 0, 255}));
    connect(T4.in2, VSC10.plv) annotation(
      Line(points = {{-34, -103}, {-40, -103}, {-40, -112}, {-59, -112}}, color = {0, 0, 255}));
    connect(T1.out3, line1.p) annotation(
      Line(points = {{-12, 100}, {40, 100}}, color = {0, 0, 255}));
    connect(T2.out3, line2.p) annotation(
      Line(points = {{26, 48}, {40, 48}}, color = {0, 0, 255}));
    connect(T3.out3, line3.p) annotation(
      Line(points = {{-14, 0}, {40, 0}}, color = {0, 0, 255}));
    connect(T5.out3, line4.p) annotation(
      Line(points = {{26, -46}, {40, -46}}, color = {0, 0, 255}));
    connect(T4.out3, line5.p) annotation(
      Line(points = {{-14, -100}, {40, -100}}, color = {0, 0, 255}));
    connect(T1.in1, VSC1.plv) annotation(
      Line(points = {{-32, 102}, {-38, 102}, {-38, 112}, {-56, 112}, {-56, 112}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{6, 46}, {0, 46}, {0, 38}, {-18, 38}, {-18, 38}}, color = {0, 0, 255}));
    connect(T2.in1, VSC3.plv) annotation(
      Line(points = {{6, 50}, {0, 50}, {0, 60}, {-18, 60}, {-18, 60}}, color = {0, 0, 255}));
    connect(T5.in2, VSC8.plv) annotation(
      Line(points = {{6, -48}, {0, -48}, {0, -58}, {-18, -58}, {-18, -58}}, color = {0, 0, 255}));
    connect(T4.in1, VSC9.plv) annotation(
      Line(points = {{-34, -98}, {-40, -98}, {-40, -88}, {-58, -88}, {-58, -88}}, color = {0, 0, 255}));
    connect(T3.in2, VSC6.plv) annotation(
      Line(points = {{-34, -2}, {-40, -2}, {-40, -12}, {-58, -12}, {-58, -12}}, color = {0, 0, 255}));
    connect(Pref, VSC1.pref) annotation(
      Line(points = {{-114, 8}, {-100, 8}, {-100, 118}, {-80, 118}, {-80, 118}}, color = {0, 0, 127}));
    connect(VSC1.qref, Qref) annotation(
      Line(points = {{-80, 106}, {-100, 106}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(Pref, VSC2.pref) annotation(
      Line(points = {{-114, 8}, {-100, 8}, {-100, 96}, {-80, 96}, {-80, 96}}, color = {0, 0, 127}));
    connect(VSC2.qref, Qref) annotation(
      Line(points = {{-80, 84}, {-100, 84}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(Pref, VSC5.pref) annotation(
      Line(points = {{-114, 8}, {-100, 8}, {-100, 16}, {-82, 16}, {-82, 16}}, color = {0, 0, 127}));
    connect(VSC5.qref, Qref) annotation(
      Line(points = {{-82, 4}, {-100, 4}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(Pref, VSC6.pref) annotation(
      Line(points = {{-114, 8}, {-100, 8}, {-100, -6}, {-82, -6}, {-82, -6}}, color = {0, 0, 127}));
    connect(VSC6.qref, Qref) annotation(
      Line(points = {{-82, -18}, {-100, -18}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(Pref, VSC9.pref) annotation(
      Line(points = {{-114, 8}, {-100, 8}, {-100, -82}, {-82, -82}, {-82, -82}}, color = {0, 0, 127}));
    connect(VSC9.qref, Qref) annotation(
      Line(points = {{-82, -94}, {-100, -94}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(VSC10.pref, Pref) annotation(
      Line(points = {{-82, -106}, {-100, -106}, {-100, 8}, {-114, 8}, {-114, 8}}, color = {0, 0, 127}));
    connect(VSC10.qref, Qref) annotation(
      Line(points = {{-82, -118}, {-100, -118}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(VSC3.pref, Pref) annotation(
      Line(points = {{-42, 66}, {-100, 66}, {-100, 8}, {-114, 8}, {-114, 8}}, color = {0, 0, 127}));
    connect(VSC3.qref, Qref) annotation(
      Line(points = {{-42, 54}, {-100, 54}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(VSC4.pref, Pref) annotation(
      Line(points = {{-42, 44}, {-100, 44}, {-100, 8}, {-114, 8}, {-114, 8}}, color = {0, 0, 127}));
    connect(VSC4.qref, Qref) annotation(
      Line(points = {{-42, 32}, {-100, 32}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(VSC7.pref, Pref) annotation(
      Line(points = {{-42, -30}, {-100, -30}, {-100, 8}, {-114, 8}, {-114, 8}}, color = {0, 0, 127}));
    connect(VSC7.qref, Qref) annotation(
      Line(points = {{-42, -42}, {-100, -42}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(VSC8.pref, Pref) annotation(
      Line(points = {{-42, -52}, {-100, -52}, {-100, 8}, {-114, 8}, {-114, 8}}, color = {0, 0, 127}));
    connect(VSC8.qref, Qref) annotation(
      Line(points = {{-42, -64}, {-100, -64}, {-100, -10}, {-114, -10}, {-114, -10}}, color = {0, 0, 127}));
    connect(line1.n, PCCM10) annotation(
      Line(points = {{60, 100}, {100, 100}, {100, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(line2.n, PCCM10) annotation(
      Line(points = {{60, 48}, {100, 48}, {100, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(line3.n, PCCM10) annotation(
      Line(points = {{60, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(line4.n, PCCM10) annotation(
      Line(points = {{60, -46}, {100, -46}, {100, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(line5.n, PCCM10) annotation(
      Line(points = {{60, -100}, {100, -100}, {100, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(cPCC.plug_p, PCCM10) annotation(
      Line(points = {{146, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(cPCC.plug_n, P) annotation(
      Line(points = {{166, 0}, {226, 0}}, color = {0, 0, 255}));
    connect(pPCC.plug_p, cPCC.plug_n) annotation(
      Line(points = {{176, 10}, {176, 0}, {166, 0}}, color = {0, 0, 255}));
    connect(va.y, pac_Qac_CalculationM10.Va_grid) annotation(
      Line(points = {{210, 124}, {192, 124}, {192, 96}, {188, 96}, {188, 96}}, color = {0, 0, 127}));
    connect(vb.y, pac_Qac_CalculationM10.Vb_grid) annotation(
      Line(points = {{210, 110}, {196, 110}, {196, 94}, {188, 94}, {188, 94}}, color = {0, 0, 127}));
    connect(vc.y, pac_Qac_CalculationM10.Vc_grid) annotation(
      Line(points = {{210, 96}, {200, 96}, {200, 90}, {188, 90}, {188, 90}}, color = {0, 0, 127}));
    connect(ia.y, pac_Qac_CalculationM10.Ia_grid) annotation(
      Line(points = {{210, 80}, {200, 80}, {200, 86}, {188, 86}, {188, 86}}, color = {0, 0, 127}));
    connect(ic.y, pac_Qac_CalculationM10.Ic_grid) annotation(
      Line(points = {{210, 52}, {192, 52}, {192, 80}, {188, 80}, {188, 80}}, color = {0, 0, 127}));
    connect(pac_Qac_CalculationM10.Ib_grid, ib.y) annotation(
      Line(points = {{188, 82}, {196, 82}, {196, 66}, {210, 66}, {210, 66}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_CalculationM10.theta) annotation(
      Line(points = {{180, 140}, {176, 140}, {176, 100}, {176, 100}}, color = {0, 0, 127}));
    connect(pllmv.Va_grid, pPCC.phi[1]) annotation(
      Line(points = {{170, 40}, {170, 40}, {170, 34}, {176, 34}, {176, 32}, {176, 32}}, color = {0, 0, 127}));
    connect(pllmv.Vb_grid, pPCC.phi[2]) annotation(
      Line(points = {{176, 40}, {176, 40}, {176, 32}, {176, 32}}, color = {0, 0, 127}));
    connect(pllmv.Vc_grid, pPCC.phi[3]) annotation(
      Line(points = {{182, 40}, {182, 40}, {182, 34}, {176, 34}, {176, 32}, {176, 32}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {101, 4}, fillPattern = FillPattern.Solid, extent = {{-1, 96}, {-2, -104}}), Ellipse(origin = {227, -1}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-3, 3}, {1, -1}}, endAngle = 360)}));
  end m10;

  model NGen1MW
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -1000000; 0.5, 0; 0.8, 5000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -9000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 133}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {30, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T1 annotation(
      Placement(visible = true, transformation(origin = {-84, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T2 annotation(
      Placement(visible = true, transformation(origin = {-84, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T3 annotation(
      Placement(visible = true, transformation(origin = {-84, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T4 annotation(
      Placement(visible = true, transformation(origin = {-84, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    trafo_three_w T5 annotation(
      Placement(visible = true, transformation(origin = {-84, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug PCC annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    GRID grid annotation(
      Placement(visible = true, transformation(origin = {169, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Line1 line1 annotation(
      Placement(visible = true, transformation(origin = {-56, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line2 line2 annotation(
      Placement(visible = true, transformation(origin = {-56, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line3 line3 annotation(
      Placement(visible = true, transformation(origin = {-56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line4 line4 annotation(
      Placement(visible = true, transformation(origin = {-56, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line5 line5 annotation(
      Placement(visible = true, transformation(origin = {-56, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {114, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {138, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Machines.BasicMachines.Transformers.Yy.Yy00 transformer(L1sigma = 5.986e-3, L2sigma = 0.2444, R1 = 0.0625, R2 = 2.65, T1Ref = 566.3, T2Ref = 566.3, alpha20_1 = 0, alpha20_2 = 0, n = 0.2706329) annotation(
      Placement(visible = true, transformation(origin = {126, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{5, 136}, {29, 136}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{5, 108}, {29, 108}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 102}, {5, 102}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 130}, {5, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(T1.in1, VSC1.plv) annotation(
      Line(points = {{-94, 127}, {-100, 127}, {-100, 136}, {-118, 136}}, color = {0, 0, 255}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-94, 121}, {-100, 121}, {-100, 114}, {-118, 114}}, color = {0, 0, 255}));
    connect(T2.in1, VSC3.plv) annotation(
      Line(points = {{-94, 75}, {-100, 75}, {-100, 84}, {-118, 84}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{-94, 69}, {-100, 69}, {-100, 62}, {-118, 62}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-94, 23}, {-100, 23}, {-100, 30}, {-118, 30}}, color = {0, 0, 255}));
    connect(T3.in2, VSC6.plv) annotation(
      Line(points = {{-94, 17}, {-100, 17}, {-100, 8}, {-118, 8}}, color = {0, 0, 255}));
    connect(T5.in1, VSC7.plv) annotation(
      Line(points = {{-94, -29}, {-100, -29}, {-100, -22}, {-118, -22}}, color = {0, 0, 255}));
    connect(T5.in2, VSC8.plv) annotation(
      Line(points = {{-94, -35}, {-100, -35}, {-100, -44}, {-118, -44}}, color = {0, 0, 255}));
    connect(T4.in2, VSC10.plv) annotation(
      Line(points = {{-94, -91}, {-100, -91}, {-100, -100}, {-118, -100}}, color = {0, 0, 255}));
    connect(T4.in1, VSC9.plv) annotation(
      Line(points = {{-94, -85}, {-100, -85}, {-100, -76}, {-118, -76}}, color = {0, 0, 255}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(T1.out3, line1.p) annotation(
      Line(points = {{-74, 124}, {-68, 124}, {-68, 124}, {-66, 124}}, color = {0, 0, 255}));
    connect(line1.n, PCC) annotation(
      Line(points = {{-46, 124}, {-34, 124}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T2.out3, line2.p) annotation(
      Line(points = {{-74, 72}, {-66, 72}, {-66, 72}, {-66, 72}}, color = {0, 0, 255}));
    connect(line2.n, PCC) annotation(
      Line(points = {{-46, 72}, {-32, 72}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T3.out3, line3.p) annotation(
      Line(points = {{-74, 20}, {-66, 20}, {-66, 20}, {-66, 20}}, color = {0, 0, 255}));
    connect(line3.n, PCC) annotation(
      Line(points = {{-46, 20}, {-32, 20}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T5.out3, line4.p) annotation(
      Line(points = {{-74, -32}, {-68, -32}, {-68, -32}, {-66, -32}}, color = {0, 0, 255}));
    connect(line4.n, PCC) annotation(
      Line(points = {{-46, -32}, {-32, -32}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(T4.out3, line5.p) annotation(
      Line(points = {{-74, -88}, {-66, -88}, {-66, -88}, {-66, -88}}, color = {0, 0, 255}));
    connect(line5.n, PCC) annotation(
      Line(points = {{-46, -88}, {-34, -88}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(Vpcc.plug_p, Cpcc.plug_n) annotation(
      Line(points = {{106, 6}, {106, 6}, {106, 0}, {94, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(Cpcc.plug_n, transformer.plug1) annotation(
      Line(points = {{94, 0}, {116, 0}, {116, 0}, {116, 0}}, color = {0, 0, 255}));
    connect(transformer.plug2, grid.PG) annotation(
      Line(points = {{136, 0}, {158, 0}, {158, 0}, {156, 0}}, color = {0, 0, 255}));
    connect(ground1.p, transformer.starpoint2) annotation(
      Line(points = {{138, -36}, {138, -16}, {132, -16}, {132, -10}}, color = {0, 0, 255}));
    connect(transformer.starpoint1, ground.p) annotation(
      Line(points = {{122, -10}, {120, -10}, {120, -16}, {114, -16}, {114, -36}}, color = {0, 0, 255}));
    connect(PCC, Cpcc.plug_p) annotation(
      Line(points = {{0, 0}, {74, 0}, {74, 0}, {74, 0}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {-33, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}})}));
  end NGen1MW;

  model mvhv
    Modelica.Electrical.Machines.BasicMachines.Components.IdealCore core(n12 = 3.695 * 2, n13 = 3.695 * 2) annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug out3 annotation(
      Placement(visible = true, transformation(origin = {96, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {101, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor2(R = fill(2.65, 3)) annotation(
      Placement(visible = true, transformation(origin = {56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.0625, 3)) annotation(
      Placement(visible = true, transformation(origin = {-58, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug annotation(
      Placement(visible = true, transformation(origin = {-100, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {-14, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Star star1 annotation(
      Placement(visible = true, transformation(origin = {16, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L = fill(5.968e-3, 3)) annotation(
      Placement(visible = true, transformation(origin = {-30, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor inductor1(L = fill(0.244, 3)) annotation(
      Placement(visible = true, transformation(origin = {30, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
      Placement(visible = true, transformation(origin = {-44, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-52, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n1 annotation(
      Placement(visible = true, transformation(origin = {44, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {52, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor2.plug_p, out3) annotation(
      Line(points = {{66, 20}, {94, 20}, {94, 18}, {96, 18}}, color = {0, 0, 255}));
    connect(core.plug_n2, core.plug_p3) annotation(
      Line(points = {{-10, 6}, {-10, 6}, {-10, -2}, {-10, -2}, {-10, -2}}, color = {0, 0, 255}));
    connect(positivePlug, resistor.plug_p) annotation(
      Line(points = {{-100, 44}, {-68, 44}, {-68, 44}, {-68, 44}}, color = {0, 0, 255}));
    connect(star.plug_p, core.plug_n3) annotation(
      Line(points = {{-14, -40}, {-14, -40}, {-14, -8}, {-10, -8}, {-10, -8}}, color = {0, 0, 255}));
    connect(star1.plug_p, core.plug_n1) annotation(
      Line(points = {{16, -40}, {16, -40}, {16, -8}, {10, -8}, {10, -8}}, color = {0, 0, 255}));
    connect(resistor2.plug_n, inductor1.plug_p) annotation(
      Line(points = {{46, 20}, {40, 20}, {40, 20}, {40, 20}}));
    connect(inductor.plug_n, core.plug_p2) annotation(
      Line(points = {{-20, 44}, {-16, 44}, {-16, 12}, {-10, 12}, {-10, 12}}, color = {0, 0, 255}));
    connect(inductor.plug_p, resistor.plug_n) annotation(
      Line(points = {{-40, 44}, {-48, 44}, {-48, 44}, {-48, 44}}, color = {0, 0, 255}));
    connect(core.plug_p1, inductor1.plug_n) annotation(
      Line(points = {{10, 12}, {14, 12}, {14, 20}, {20, 20}, {20, 20}}, color = {0, 0, 255}));
    connect(pin_n, star.pin_n) annotation(
      Line(points = {{-44, -76}, {-14, -76}, {-14, -60}, {-14, -60}}, color = {0, 0, 255}));
    connect(star1.pin_n, pin_n1) annotation(
      Line(points = {{16, -60}, {16, -60}, {16, -76}, {44, -76}, {44, -76}}, color = {0, 0, 255}));
  protected
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Ellipse(origin = {31, 0}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {-33, 2}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Line(origin = {-88.9403, 2.38815}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {83.7612, -0.432763}, points = {{-8, 0}, {12, 0}, {-8, 0}})}, coordinateSystem(initialScale = 0.1)));
  end mvhv;

  model mvhvY
    Modelica.Electrical.Machines.BasicMachines.Components.IdealCore core(n12 = 3.695 * 2, n13 = 3.695 * 2) annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug out3 annotation(
      Placement(visible = true, transformation(origin = {96, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -4.44089e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor2(R = fill(2.65, 3)) annotation(
      Placement(visible = true, transformation(origin = {68, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R = fill(0.0625, 3)) annotation(
      Placement(visible = true, transformation(origin = {-68, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug annotation(
      Placement(visible = true, transformation(origin = {-100, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {-20, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Basic.Star star1 annotation(
      Placement(visible = true, transformation(origin = {20, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
      Placement(visible = true, transformation(origin = {20, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Interfaces.NegativePin pin_n1 annotation(
      Placement(visible = true, transformation(origin = {-20, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(resistor2.plug_p, out3) annotation(
      Line(points = {{78, 20}, {94, 20}, {94, 18}, {96, 18}}, color = {0, 0, 255}));
    connect(core.plug_n2, core.plug_p3) annotation(
      Line(points = {{-10, 6}, {-10, 6}, {-10, -2}, {-10, -2}, {-10, -2}}, color = {0, 0, 255}));
    connect(positivePlug, resistor.plug_p) annotation(
      Line(points = {{-100, 44}, {-78, 44}}, color = {0, 0, 255}));
    connect(star.plug_p, core.plug_n3) annotation(
      Line(points = {{-20, -40}, {-20, -8}, {-10, -8}}, color = {0, 0, 255}));
    connect(core.plug_n1, star1.plug_p) annotation(
      Line(points = {{10, -8}, {20, -8}, {20, -40}, {20, -40}}, color = {0, 0, 255}));
    connect(star1.pin_n, pin_n) annotation(
      Line(points = {{20, -60}, {20, -60}, {20, -76}, {20, -76}}, color = {0, 0, 255}));
    connect(star.pin_n, pin_n1) annotation(
      Line(points = {{-20, -60}, {-20, -60}, {-20, -76}, {-20, -76}}, color = {0, 0, 255}));
    connect(resistor.plug_n, core.plug_p2) annotation(
      Line(points = {{-58, 44}, {-28, 44}, {-28, 12}, {-10, 12}, {-10, 12}}, color = {0, 0, 255}));
    connect(core.plug_p1, resistor2.plug_n) annotation(
      Line(points = {{10, 12}, {20, 12}, {20, 20}, {58, 20}, {58, 20}}, color = {0, 0, 255}));
  protected
    annotation(
      uses(Modelica(version = "3.2.3")),
      Icon(graphics = {Ellipse(origin = {31, 0}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Ellipse(origin = {-27, 2}, extent = {{-47, 46}, {45, -46}}, endAngle = 360), Line(origin = {-82.9851, -0.119313}, points = {{-8, 0}, {8, 0}, {-8, 0}}), Line(origin = {83.7612, -0.432763}, points = {{-8, 0}, {12, 0}, {-8, 0}})}, coordinateSystem(initialScale = 0.1)));
  end mvhvY;

  model NGen1MW_NO_IND
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -1000000; 0.5, 0; 0.8, 5000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -9000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 133}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {30, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug PCC annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    GRID grid annotation(
      Placement(visible = true, transformation(origin = {169, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Line1 line1 annotation(
      Placement(visible = true, transformation(origin = {-56, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line2 line2 annotation(
      Placement(visible = true, transformation(origin = {-56, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line3 line3 annotation(
      Placement(visible = true, transformation(origin = {-56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line4 line4 annotation(
      Placement(visible = true, transformation(origin = {-56, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line5 line5 annotation(
      Placement(visible = true, transformation(origin = {-56, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T1 annotation(
      Placement(visible = true, transformation(origin = {-90, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T2 annotation(
      Placement(visible = true, transformation(origin = {-92, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T3 annotation(
      Placement(visible = true, transformation(origin = {-92, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T4 annotation(
      Placement(visible = true, transformation(origin = {-92, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T5 annotation(
      Placement(visible = true, transformation(origin = {-92, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Machines.BasicMachines.Transformers.Yy.Yy00 transformer(L1sigma = 5.986e-3, L2sigma = 0.2444, R1 = 0.0625, R2 = 2.65, T1Ref = 566.3, T2Ref = 566.3, alpha20_1 = 0, alpha20_2 = 0, n = 0.2706329, useThermalPort = false) annotation(
      Placement(visible = true, transformation(origin = {132, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {116, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {146, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{5, 136}, {29, 136}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{5, 108}, {29, 108}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 102}, {5, 102}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 130}, {5, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(PCC, Cpcc.plug_p) annotation(
      Line(points = {{0, 0}, {74, 0}}, color = {0, 0, 255}));
    connect(line1.n, PCC) annotation(
      Line(points = {{-46, 124}, {-34, 124}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line2.n, PCC) annotation(
      Line(points = {{-46, 72}, {-32, 72}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line3.n, PCC) annotation(
      Line(points = {{-46, 20}, {-32, 20}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line4.n, PCC) annotation(
      Line(points = {{-46, -32}, {-32, -32}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line5.n, PCC) annotation(
      Line(points = {{-46, -88}, {-34, -88}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(VSC1.plv, T1.in1) annotation(
      Line(points = {{-118, 136}, {-114, 136}, {-114, 130}, {-100, 130}, {-100, 127}}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-100, 121}, {-114, 121}, {-114, 114}, {-118, 114}}, color = {0, 0, 255}));
    connect(T1.out3, line1.p) annotation(
      Line(points = {{-80, 124}, {-66, 124}}, color = {0, 0, 255}));
    connect(VSC3.plv, T2.in1) annotation(
      Line(points = {{-118, 84}, {-112, 84}, {-112, 75}, {-102, 75}}));
    connect(T2.out3, line2.p) annotation(
      Line(points = {{-82, 72}, {-66, 72}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{-102, 69}, {-112, 69}, {-112, 62}, {-118, 62}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-102, 22}, {-110, 22}, {-110, 30}, {-118, 30}, {-118, 30}}, color = {0, 0, 255}));
    connect(VSC6.plv, T3.in2) annotation(
      Line(points = {{-118, 8}, {-110, 8}, {-110, 18}, {-102, 18}, {-102, 18}}));
    connect(T3.out3, line3.p) annotation(
      Line(points = {{-82, 20}, {-66, 20}, {-66, 20}, {-66, 20}}, color = {0, 0, 255}));
    connect(T4.in1, VSC7.plv) annotation(
      Line(points = {{-102, -29}, {-112, -29}, {-112, -22}, {-118, -22}}, color = {0, 0, 255}));
    connect(VSC8.plv, T4.in2) annotation(
      Line(points = {{-118, -44}, {-110, -44}, {-110, -35}, {-102, -35}}));
    connect(T5.in1, VSC9.plv) annotation(
      Line(points = {{-102, -85}, {-110, -85}, {-110, -76}, {-118, -76}}, color = {0, 0, 255}));
    connect(VSC10.plv, T5.in2) annotation(
      Line(points = {{-118, -100}, {-110, -100}, {-110, -91}, {-102, -91}}));
    connect(T4.out3, line4.p) annotation(
      Line(points = {{-82, -32}, {-66, -32}}, color = {0, 0, 255}));
    connect(T5.out3, line5.p) annotation(
      Line(points = {{-82, -88}, {-66, -88}}, color = {0, 0, 255}));
    connect(Cpcc.plug_n, Vpcc.plug_p) annotation(
      Line(points = {{94, 0}, {106, 0}, {106, 6}, {106, 6}}, color = {0, 0, 255}));
    connect(transformer.plug1, Cpcc.plug_n) annotation(
      Line(points = {{122, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(transformer.starpoint2, ground1.p) annotation(
      Line(points = {{137, -10}, {137, -24}, {146, -24}}, color = {0, 0, 255}));
    connect(transformer.starpoint1, ground.p) annotation(
      Line(points = {{127, -10}, {127, -24}, {116, -24}}, color = {0, 0, 255}));
    connect(grid.PG, transformer.plug2) annotation(
      Line(points = {{156, 0}, {142, 0}, {142, 0}, {142, 0}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {-33, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}})}));
  end NGen1MW_NO_IND;

  model NGen1MW_NO_IND2
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -1000000; 0.5, 0; 0.8, 5000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -9000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 133}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {30, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug PCC annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    GRID grid annotation(
      Placement(visible = true, transformation(origin = {169, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Line1 line1 annotation(
      Placement(visible = true, transformation(origin = {-56, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line2 line2 annotation(
      Placement(visible = true, transformation(origin = {-56, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line3 line3 annotation(
      Placement(visible = true, transformation(origin = {-56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line4 line4 annotation(
      Placement(visible = true, transformation(origin = {-56, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line5 line5 annotation(
      Placement(visible = true, transformation(origin = {-56, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T1 annotation(
      Placement(visible = true, transformation(origin = {-94, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T2 annotation(
      Placement(visible = true, transformation(origin = {-94, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T3 annotation(
      Placement(visible = true, transformation(origin = {-92, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T4 annotation(
      Placement(visible = true, transformation(origin = {-92, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T5 annotation(
      Placement(visible = true, transformation(origin = {-92, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {116, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {142, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    mvhvY mvhv1 annotation(
      Placement(visible = true, transformation(origin = {128, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{5, 136}, {29, 136}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{5, 108}, {29, 108}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 102}, {5, 102}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 130}, {5, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(PCC, Cpcc.plug_p) annotation(
      Line(points = {{0, 0}, {74, 0}}, color = {0, 0, 255}));
    connect(line1.n, PCC) annotation(
      Line(points = {{-46, 124}, {-34, 124}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line2.n, PCC) annotation(
      Line(points = {{-46, 72}, {-32, 72}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line3.n, PCC) annotation(
      Line(points = {{-46, 20}, {-32, 20}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line4.n, PCC) annotation(
      Line(points = {{-46, -32}, {-32, -32}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line5.n, PCC) annotation(
      Line(points = {{-46, -88}, {-34, -88}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(VSC1.plv, T1.in1) annotation(
      Line(points = {{-118, 136}, {-114, 136}, {-114, 130}, {-104, 130}, {-104, 127}}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-104, 121}, {-114, 121}, {-114, 114}, {-118, 114}}, color = {0, 0, 255}));
    connect(T1.out3, line1.p) annotation(
      Line(points = {{-84, 124}, {-66, 124}, {-66, 124}, {-66, 124}}, color = {0, 0, 255}));
    connect(VSC3.plv, T2.in1) annotation(
      Line(points = {{-118, 84}, {-112, 84}, {-112, 75}, {-104, 75}}));
    connect(T2.out3, line2.p) annotation(
      Line(points = {{-84, 72}, {-68, 72}, {-68, 72}, {-66, 72}}, color = {0, 0, 255}));
    connect(T2.in2, VSC4.plv) annotation(
      Line(points = {{-104, 70}, {-112, 70}, {-112, 62}, {-118, 62}, {-118, 62}}, color = {0, 0, 255}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-102, 22}, {-110, 22}, {-110, 30}, {-118, 30}, {-118, 30}}, color = {0, 0, 255}));
    connect(VSC6.plv, T3.in2) annotation(
      Line(points = {{-118, 8}, {-110, 8}, {-110, 18}, {-102, 18}, {-102, 18}}));
    connect(T3.out3, line3.p) annotation(
      Line(points = {{-82, 20}, {-66, 20}, {-66, 20}, {-66, 20}}, color = {0, 0, 255}));
    connect(T4.in1, VSC7.plv) annotation(
      Line(points = {{-102, -29}, {-112, -29}, {-112, -22}, {-118, -22}}, color = {0, 0, 255}));
    connect(VSC8.plv, T4.in2) annotation(
      Line(points = {{-118, -44}, {-110, -44}, {-110, -35}, {-102, -35}}));
    connect(T5.in1, VSC9.plv) annotation(
      Line(points = {{-102, -85}, {-110, -85}, {-110, -76}, {-118, -76}}, color = {0, 0, 255}));
    connect(VSC10.plv, T5.in2) annotation(
      Line(points = {{-118, -100}, {-110, -100}, {-110, -91}, {-102, -91}}));
    connect(T4.out3, line4.p) annotation(
      Line(points = {{-82, -32}, {-66, -32}}, color = {0, 0, 255}));
    connect(T5.out3, line5.p) annotation(
      Line(points = {{-82, -88}, {-66, -88}}, color = {0, 0, 255}));
    connect(Cpcc.plug_n, Vpcc.plug_p) annotation(
      Line(points = {{94, 0}, {106, 0}, {106, 6}, {106, 6}}, color = {0, 0, 255}));
    connect(mvhv1.positivePlug, Cpcc.plug_n) annotation(
      Line(points = {{118, 0}, {94, 0}, {94, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(mvhv1.out3, grid.PG) annotation(
      Line(points = {{138, 0}, {156, 0}, {156, 0}, {156, 0}}, color = {0, 0, 255}));
    connect(mvhv1.pin_n1, ground.p) annotation(
      Line(points = {{122, -10}, {124, -10}, {124, -24}, {116, -24}, {116, -24}}, color = {0, 0, 255}));
    connect(mvhv1.pin_n, ground1.p) annotation(
      Line(points = {{134, -10}, {134, -24}, {142, -24}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {-33, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}})}));
  end NGen1MW_NO_IND2;

  model NGen1MW_IND3
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor Vpcc annotation(
      Placement(visible = true, transformation(origin = {106, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cpcc annotation(
      Placement(visible = true, transformation(origin = {84, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {136, 80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression Va(y = Vpcc.phi[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vb(y = Vpcc.phi[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Vc(y = Vpcc.phi[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ia(y = Cpcc.i[1]) annotation(
      Placement(visible = true, transformation(origin = {172, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ib(y = Cpcc.i[2]) annotation(
      Placement(visible = true, transformation(origin = {172, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Ic(y = Cpcc.i[3]) annotation(
      Placement(visible = true, transformation(origin = {172, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta(y = pllmv.theta) annotation(
      Placement(visible = true, transformation(origin = {154, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Power_Control power_Control annotation(
      Placement(visible = true, transformation(origin = {74, 80}, extent = {{-12, 12}, {12, -12}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression P(y = PTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 90}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Q(y = QTSO.y[1]) annotation(
      Placement(visible = true, transformation(origin = {106, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression Pref(y = PxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Qref(y = QxGen.y) annotation(
      Placement(visible = true, transformation(origin = {-194, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QRref(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, -1000000; 0.5, 0; 0.8, 5000000; 0.9, -5000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable PRef(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000000; 0.3, -9000000; 0.5, -1000000; 0.8, -7000000]) annotation(
      Placement(visible = true, transformation(origin = {40, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division PxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 133}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Math.Division QxGen annotation(
      Placement(visible = true, transformation(origin = {-1, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ngen(y = 10) annotation(
      Placement(visible = true, transformation(origin = {30, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.CombiTimeTable PTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, -3000 * 4; 0.3, -6000 * 4; 0.5, -1000 * 4; 0.8, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable QTSO(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0 * 4; 0.3, -5000 * 4; 0.5, 0 * 4; 0.8, 2000 * 4; 0.9, -7000 * 4]) annotation(
      Placement(visible = true, transformation(origin = {74, 108}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    vsc VSC1 annotation(
      Placement(visible = true, transformation(origin = {-130, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC2 annotation(
      Placement(visible = true, transformation(origin = {-130, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC3 annotation(
      Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC4 annotation(
      Placement(visible = true, transformation(origin = {-130, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC5 annotation(
      Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC6 annotation(
      Placement(visible = true, transformation(origin = {-130, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC7 annotation(
      Placement(visible = true, transformation(origin = {-130, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC9 annotation(
      Placement(visible = true, transformation(origin = {-130, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC10 annotation(
      Placement(visible = true, transformation(origin = {-130, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    vsc VSC8 annotation(
      Placement(visible = true, transformation(origin = {-130, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Interfaces.Plug PCC annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PLLMV pllmv annotation(
      Placement(visible = true, transformation(origin = {106, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    GRID grid annotation(
      Placement(visible = true, transformation(origin = {169, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Line1 line1 annotation(
      Placement(visible = true, transformation(origin = {-56, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line2 line2 annotation(
      Placement(visible = true, transformation(origin = {-56, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line3 line3 annotation(
      Placement(visible = true, transformation(origin = {-56, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line4 line4 annotation(
      Placement(visible = true, transformation(origin = {-56, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Line5 line5 annotation(
      Placement(visible = true, transformation(origin = {-56, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    mvhv mvhv2 annotation(
      Placement(visible = true, transformation(origin = {128, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {112, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {146, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T1 annotation(
      Placement(visible = true, transformation(origin = {-94, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T2 annotation(
      Placement(visible = true, transformation(origin = {-94, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T3 annotation(
      Placement(visible = true, transformation(origin = {-96, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T4 annotation(
      Placement(visible = true, transformation(origin = {-96, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    LSPVPP.trafo_three_w_NO_IND T5 annotation(
      Placement(visible = true, transformation(origin = {-96, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{161, 118}, {150, 118}, {150, 88}, {147, 88}}, color = {0, 0, 127}));
    connect(Vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{161, 104}, {152, 104}, {152, 85}, {147, 85}}, color = {0, 0, 127}));
    connect(Vc.y, pac_Qac_Calculation.Vc_grid) annotation(
      Line(points = {{161, 90}, {154, 90}, {154, 82}, {147, 82}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ia_grid, Ia.y) annotation(
      Line(points = {{147, 78}, {154, 78}, {154, 70}, {161, 70}}, color = {0, 0, 127}));
    connect(Ic.y, pac_Qac_Calculation.Ic_grid) annotation(
      Line(points = {{161, 42}, {150, 42}, {150, 72}, {147, 72}}, color = {0, 0, 127}));
    connect(Ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{161, 56}, {152, 56}, {152, 75}, {147, 75}}, color = {0, 0, 127}));
    connect(theta.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{143, 136}, {136, 136}, {136, 92}}, color = {0, 0, 127}));
    connect(power_Control.Ppvpp, pac_Qac_Calculation.Pac) annotation(
      Line(points = {{88, 84}, {124, 84}, {124, 86}, {124, 86}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Qac, power_Control.Qpvpp) annotation(
      Line(points = {{124, 74}, {124, 74}, {124, 76}, {88, 76}, {88, 76}}, color = {0, 0, 127}));
    connect(P.y, power_Control.PTSO) annotation(
      Line(points = {{94, 90}, {90, 90}, {90, 90}, {88, 90}}, color = {0, 0, 127}));
    connect(Q.y, power_Control.QTSO) annotation(
      Line(points = {{94, 70}, {90, 70}, {90, 70}, {88, 70}}, color = {0, 0, 127}));
    connect(PxGen.u1, PRef.y[1]) annotation(
      Line(points = {{5, 136}, {29, 136}}, color = {0, 0, 127}));
    connect(QxGen.u1, QRref.y[1]) annotation(
      Line(points = {{5, 108}, {29, 108}}, color = {0, 0, 127}));
    connect(Ngen.y, QxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 102}, {5, 102}}, color = {0, 0, 127}));
    connect(Ngen.y, PxGen.u2) annotation(
      Line(points = {{19, 74}, {14, 74}, {14, 130}, {5, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC1.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 130}, {-142, 130}, {-142, 130}}, color = {0, 0, 127}));
    connect(Pref.y, VSC2.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 108}, {-142, 108}, {-142, 108}}, color = {0, 0, 127}));
    connect(Pref.y, VSC3.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 78}, {-142, 78}, {-142, 78}}, color = {0, 0, 127}));
    connect(Pref.y, VSC4.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 56}, {-142, 56}, {-142, 56}}, color = {0, 0, 127}));
    connect(Pref.y, VSC5.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 24}, {-144, 24}, {-144, 24}, {-142, 24}}, color = {0, 0, 127}));
    connect(Pref.y, VSC6.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, 2}, {-142, 2}, {-142, 2}}, color = {0, 0, 127}));
    connect(Pref.y, VSC7.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -28}, {-142, -28}, {-142, -28}}, color = {0, 0, 127}));
    connect(Pref.y, VSC8.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -50}, {-142, -50}, {-142, -50}}, color = {0, 0, 127}));
    connect(Pref.y, VSC9.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -82}, {-142, -82}, {-142, -82}}, color = {0, 0, 127}));
    connect(Pref.y, VSC10.pref) annotation(
      Line(points = {{-182, 26}, {-160, 26}, {-160, -106}, {-142, -106}, {-142, -106}}, color = {0, 0, 127}));
    connect(Qref.y, VSC1.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 142}, {-142, 142}, {-142, 142}}, color = {0, 0, 127}));
    connect(Qref.y, VSC2.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 120}, {-142, 120}, {-142, 120}}, color = {0, 0, 127}));
    connect(Qref.y, VSC3.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 90}, {-142, 90}, {-142, 90}}, color = {0, 0, 127}));
    connect(Qref.y, VSC4.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 68}, {-142, 68}, {-142, 68}}, color = {0, 0, 127}));
    connect(Qref.y, VSC5.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 36}, {-142, 36}, {-142, 36}}, color = {0, 0, 127}));
    connect(Qref.y, VSC6.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, 14}, {-144, 14}, {-144, 14}, {-142, 14}}, color = {0, 0, 127}));
    connect(Qref.y, VSC7.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -16}, {-142, -16}, {-142, -16}}, color = {0, 0, 127}));
    connect(Qref.y, VSC8.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -38}, {-142, -38}, {-142, -38}}, color = {0, 0, 127}));
    connect(Qref.y, VSC9.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -70}, {-142, -70}, {-142, -70}}, color = {0, 0, 127}));
    connect(Qref.y, VSC10.qref) annotation(
      Line(points = {{-182, 12}, {-160, 12}, {-160, -94}, {-142, -94}, {-142, -94}}, color = {0, 0, 127}));
    connect(pllmv.Va_grid, Vpcc.phi[1]) annotation(
      Line(points = {{100, 32}, {100, 32}, {100, 28}, {106, 28}, {106, 28}}, color = {0, 0, 127}));
    connect(Vpcc.phi[2], pllmv.Vb_grid) annotation(
      Line(points = {{106, 28}, {106, 28}, {106, 32}, {106, 32}}, color = {0, 0, 127}));
    connect(Vpcc.phi[3], pllmv.Vc_grid) annotation(
      Line(points = {{106, 28}, {112, 28}, {112, 32}, {112, 32}, {112, 32}}, color = {0, 0, 127}));
    connect(PCC, Cpcc.plug_p) annotation(
      Line(points = {{0, 0}, {74, 0}}, color = {0, 0, 255}));
    connect(line1.n, PCC) annotation(
      Line(points = {{-46, 124}, {-34, 124}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line2.n, PCC) annotation(
      Line(points = {{-46, 72}, {-32, 72}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line3.n, PCC) annotation(
      Line(points = {{-46, 20}, {-32, 20}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line4.n, PCC) annotation(
      Line(points = {{-46, -32}, {-32, -32}, {-32, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(line5.n, PCC) annotation(
      Line(points = {{-46, -88}, {-34, -88}, {-34, 0}, {0, 0}, {0, 0}}, color = {0, 0, 255}));
    connect(Vpcc.plug_p, Cpcc.plug_n) annotation(
      Line(points = {{106, 6}, {106, 6}, {106, 0}, {94, 0}, {94, 0}}, color = {0, 0, 255}));
    connect(Cpcc.plug_n, mvhv2.positivePlug) annotation(
      Line(points = {{94, 0}, {118, 0}, {118, 0}, {118, 0}}, color = {0, 0, 255}));
    connect(mvhv2.out3, grid.PG) annotation(
      Line(points = {{138, 0}, {158, 0}, {158, 0}, {156, 0}, {156, 0}}, color = {0, 0, 255}));
    connect(mvhv2.pin_n, ground.p) annotation(
      Line(points = {{122, -10}, {112, -10}, {112, -20}, {112, -20}}, color = {0, 0, 255}));
    connect(mvhv2.pin_n1, ground1.p) annotation(
      Line(points = {{134, -10}, {146, -10}, {146, -20}, {146, -20}}, color = {0, 0, 255}));
    connect(VSC1.plv, T1.in1) annotation(
      Line(points = {{-118, 136}, {-112, 136}, {-112, 130}, {-104, 130}, {-104, 127}}));
    connect(T1.in2, VSC2.plv) annotation(
      Line(points = {{-104, 121}, {-112, 121}, {-112, 114}, {-118, 114}}, color = {0, 0, 255}));
    connect(T1.out3, line1.p) annotation(
      Line(points = {{-84, 124}, {-66, 124}, {-66, 124}, {-66, 124}}, color = {0, 0, 255}));
    connect(line2.p, T2.out3) annotation(
      Line(points = {{-66, 72}, {-84, 72}, {-84, 72}, {-84, 72}}, color = {0, 0, 255}));
    connect(T2.in1, VSC3.plv) annotation(
      Line(points = {{-104, 74}, {-112, 74}, {-112, 84}, {-118, 84}, {-118, 84}}, color = {0, 0, 255}));
    connect(VSC4.plv, T2.in2) annotation(
      Line(points = {{-118, 62}, {-112, 62}, {-112, 70}, {-104, 70}, {-104, 70}}));
    connect(T3.in1, VSC5.plv) annotation(
      Line(points = {{-106, 22}, {-112, 22}, {-112, 30}, {-118, 30}, {-118, 30}}, color = {0, 0, 255}));
    connect(T3.in2, VSC6.plv) annotation(
      Line(points = {{-106, 18}, {-112, 18}, {-112, 8}, {-118, 8}, {-118, 8}}, color = {0, 0, 255}));
    connect(T3.out3, line3.p) annotation(
      Line(points = {{-86, 20}, {-66, 20}, {-66, 20}, {-66, 20}}, color = {0, 0, 255}));
    connect(line4.p, T4.out3) annotation(
      Line(points = {{-66, -32}, {-86, -32}, {-86, -32}, {-86, -32}}, color = {0, 0, 255}));
    connect(line5.p, T5.out3) annotation(
      Line(points = {{-66, -88}, {-86, -88}, {-86, -88}, {-86, -88}, {-86, -88}}, color = {0, 0, 255}));
    connect(T5.in2, VSC10.plv) annotation(
      Line(points = {{-106, -90}, {-114, -90}, {-114, -100}, {-118, -100}, {-118, -100}}, color = {0, 0, 255}));
    connect(VSC9.plv, T5.in1) annotation(
      Line(points = {{-118, -76}, {-114, -76}, {-114, -84}, {-106, -84}, {-106, -86}}));
    connect(VSC7.plv, T4.in1) annotation(
      Line(points = {{-118, -22}, {-112, -22}, {-112, -30}, {-106, -30}, {-106, -30}}));
    connect(T4.in2, VSC8.plv) annotation(
      Line(points = {{-106, -34}, {-112, -34}, {-112, -44}, {-118, -44}, {-118, -44}}, color = {0, 0, 255}));
    annotation(
      uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0"), iPSL(version = "1.1.0"), OpenIPSL(version = "2.0.0-dev")),
      Diagram(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {-33, 18}, fillPattern = FillPattern.Solid, extent = {{-1, 106}, {1, -106}})}));
  end NGen1MW_IND3;

  model VSC_1
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-100, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vca annotation(
      Placement(visible = true, transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vcb annotation(
      Placement(visible = true, transformation(origin = {-60, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.Analog.Sources.SignalVoltage Vcc annotation(
      Placement(visible = true, transformation(origin = {-46, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.PlugToPins_p pp annotation(
      Placement(visible = true, transformation(origin = {-16, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rc(R = fill(0.005555, 3)) annotation(
      Placement(visible = true, transformation(origin = {14, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lc(L = fill(1.331e-5, 3)) annotation(
      Placement(visible = true, transformation(origin = {46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sensors.PotentialSensor PPCC annotation(
      Placement(visible = true, transformation(origin = {64, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.MultiPhase.Sensors.CurrentSensor Cs annotation(
      Placement(visible = true, transformation(origin = {84, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner_control_pllm3 inner_control_pllm annotation(
      Placement(visible = true, transformation(origin = {39, -45}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    inverterMod inverterModd annotation(
      Placement(visible = true, transformation(origin = {-60, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.RealExpression va(y = inner_control_pllm.va) annotation(
      Placement(visible = true, transformation(origin = {204, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression vb(y = inner_control_pllm.vb) annotation(
      Placement(visible = true, transformation(origin = {204, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression vc(y = inner_control_pllm.vc) annotation(
      Placement(visible = true, transformation(origin = {204, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ia(y = inner_control_pllm.ia) annotation(
      Placement(visible = true, transformation(origin = {204, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ib(y = inner_control_pllm.ib) annotation(
      Placement(visible = true, transformation(origin = {204, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression ic(y = inner_control_pllm.ic) annotation(
      Placement(visible = true, transformation(origin = {204, -118}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression theta1(y = inner_control_pllm.theta) annotation(
      Placement(visible = true, transformation(origin = {156, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Pac_Qac_Calculation pac_Qac_Calculation annotation(
      Placement(visible = true, transformation(origin = {156, -80}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
    Ref_Computation ref_Computation annotation(
      Placement(visible = true, transformation(origin = {-10, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor iameas annotation(
      Placement(visible = true, transformation(origin = {-56, 70}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.CurrentSensor icmeas annotation(
      Placement(visible = true, transformation(origin = {-26, 34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vab annotation(
      Placement(visible = true, transformation(origin = {-36, 62}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vbc annotation(
      Placement(visible = true, transformation(origin = {-36, 46}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
    invmodel Average annotation(
      Placement(visible = true, transformation(origin = {-136, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ia(y = iameas.i) annotation(
      Placement(visible = true, transformation(origin = {-170, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ic(y = icmeas.i) annotation(
      Placement(visible = true, transformation(origin = {-170, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Vab(y = vab.v) annotation(
      Placement(visible = true, transformation(origin = {-170, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Vbc(y = vbc.v) annotation(
      Placement(visible = true, transformation(origin = {-170, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Capacitor C(C = 0.001020) annotation(
      Placement(visible = true, transformation(origin = {-158, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.RealExpression vzq(y = inner_control_pllm.Vzq) annotation(
      Placement(visible = true, transformation(origin = {-46, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Udc(y = constantVoltage.v) annotation(
      Placement(visible = true, transformation(origin = {-82, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable P(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, 500000; 0.5, -100000; 0.8, -400000; 0.9, -400000]) annotation(
      Placement(visible = true, transformation(origin = {-92, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable Q(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments, table = [0, 0; 0.3, 300000; 0.5, -300000; 0.8, -600000; 0.9, -400000]) annotation(
      Placement(visible = true, transformation(origin = {-92, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Sources.SineVoltage LV(V = fill(405 * sqrt(2) / sqrt(3), 3), freqHz = fill(50, 3)) annotation(
      Placement(visible = true, transformation(origin = {180, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Star star annotation(
      Placement(visible = true, transformation(origin = {198, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
      Placement(visible = true, transformation(origin = {198, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Inductor Lg(L = fill(0.00076e-2, 3)) annotation(
      Placement(visible = true, transformation(origin = {126, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.MultiPhase.Basic.Resistor Rg(R = fill(0.005, 3)) annotation(
      Placement(visible = true, transformation(origin = {152, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 722) annotation(
      Placement(visible = true, transformation(origin = {-180, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  equation
    connect(Vca.n, ground.p) annotation(
      Line(points = {{-84, 70}, {-100, 70}, {-100, 52}}, color = {0, 0, 255}));
    connect(Vcb.n, ground.p) annotation(
      Line(points = {{-70, 52}, {-100, 52}}, color = {0, 0, 255}));
    connect(Vcb.p, pp.pin_p[2]) annotation(
      Line(points = {{-50, 52}, {-18, 52}}, color = {0, 0, 255}));
    connect(pp.plug_p, Rc.plug_p) annotation(
      Line(points = {{-14, 52}, {4, 52}}, color = {0, 0, 255}));
    connect(Rc.plug_n, Lc.plug_p) annotation(
      Line(points = {{24, 52}, {36, 52}}, color = {0, 0, 255}));
    connect(ground.p, Vcc.n) annotation(
      Line(points = {{-100, 52}, {-100, 34}, {-56, 34}}, color = {0, 0, 255}));
    connect(PPCC.phi[1], inner_control_pllm.va) annotation(
      Line(points = {{64, 18}, {64, 18}, {64, -32}, {56, -32}, {56, -32}}, color = {0, 0, 127}));
    connect(PPCC.phi[2], inner_control_pllm.vb) annotation(
      Line(points = {{64, 18}, {64, 18}, {64, -36}, {56, -36}, {56, -36}}, color = {0, 0, 127}));
    connect(Cs.i[1], inner_control_pllm.ia) annotation(
      Line(points = {{84, 41}, {84, -48}, {56, -48}, {56, -50}}, color = {0, 0, 127}));
    connect(Cs.i[2], inner_control_pllm.ib) annotation(
      Line(points = {{84, 41}, {84, -54}, {56, -54}}, color = {0, 0, 127}));
    connect(inner_control_pllm.ic, Cs.i[3]) annotation(
      Line(points = {{56, -60}, {84, -60}, {84, 41}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vc, PPCC.phi[3]) annotation(
      Line(points = {{56, -42}, {64, -42}, {64, 18}, {64, 18}}, color = {0, 0, 127}));
    connect(PPCC.plug_p, Lc.plug_n) annotation(
      Line(points = {{64, 40}, {64, 40}, {64, 52}, {56, 52}, {56, 52}}, color = {0, 0, 255}));
    connect(Vcb.v, inverterModd.vb) annotation(
      Line(points = {{-60, 40}, {-60, -11}}, color = {0, 0, 127}));
    connect(inverterModd.va, Vca.v) annotation(
      Line(points = {{-65, -11}, {-65, 18}, {-74, 18}, {-74, 58}}, color = {0, 0, 127}));
    connect(inverterModd.vc, Vcc.v) annotation(
      Line(points = {{-55, -11}, {-55, 18}, {-46, 18}, {-46, 22}}, color = {0, 0, 127}));
    connect(inverterModd.theta, inner_control_pllm.theta) annotation(
      Line(points = {{-48, -22}, {-13, -22}, {-13, -40}, {22, -40}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vd, inverterModd.vdref) annotation(
      Line(points = {{22, -56}, {-54, -56}, {-54, -34}}, color = {0, 0, 127}));
    connect(inner_control_pllm.vq, inverterModd.vqref) annotation(
      Line(points = {{22, -50}, {-66, -50}, {-66, -34}}, color = {0, 0, 127}));
    connect(theta1.y, pac_Qac_Calculation.theta) annotation(
      Line(points = {{156, -46}, {156, -63}}, color = {0, 0, 127}));
    connect(va.y, pac_Qac_Calculation.Va_grid) annotation(
      Line(points = {{194, -40}, {182, -40}, {182, -68}, {172, -68}, {172, -68}}, color = {0, 0, 127}));
    connect(vb.y, pac_Qac_Calculation.Vb_grid) annotation(
      Line(points = {{194, -54}, {184, -54}, {184, -72}, {172, -72}, {172, -72}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Vc_grid, vc.y) annotation(
      Line(points = {{172, -76}, {186, -76}, {186, -70}, {194, -70}, {194, -70}, {194, -70}}, color = {0, 0, 127}));
    connect(ia.y, pac_Qac_Calculation.Ia_grid) annotation(
      Line(points = {{194, -90}, {186, -90}, {186, -82}, {172, -82}, {172, -82}}, color = {0, 0, 127}));
    connect(ib.y, pac_Qac_Calculation.Ib_grid) annotation(
      Line(points = {{194, -104}, {184, -104}, {184, -86}, {172, -86}, {172, -88}}, color = {0, 0, 127}));
    connect(pac_Qac_Calculation.Ic_grid, ic.y) annotation(
      Line(points = {{172, -92}, {182, -92}, {182, -118}, {194, -118}, {194, -118}}, color = {0, 0, 127}));
    connect(ref_Computation.idref, inner_control_pllm.idref) annotation(
      Line(points = {{1, -116}, {48, -116}, {48, -62}}, color = {0, 0, 127}));
    connect(ref_Computation.iqref, inner_control_pllm.iqref) annotation(
      Line(points = {{1, -124}, {30, -124}, {30, -62}}, color = {0, 0, 127}));
    connect(Vca.p, vab.p) annotation(
      Line(points = {{-64, 70}, {-36, 70}, {-36, 68}}, color = {0, 0, 255}));
    connect(vab.n, Vcb.p) annotation(
      Line(points = {{-36, 56}, {-36, 52}, {-50, 52}}, color = {0, 0, 255}));
    connect(Vcb.p, vbc.p) annotation(
      Line(points = {{-50, 52}, {-36, 52}}, color = {0, 0, 255}));
    connect(vbc.n, Vcc.p) annotation(
      Line(points = {{-36, 40}, {-36, 34}}, color = {0, 0, 255}));
    connect(Vca.p, iameas.p) annotation(
      Line(points = {{-64, 70}, {-62, 70}}, color = {0, 0, 255}));
    connect(iameas.n, pp.pin_p[1]) annotation(
      Line(points = {{-50, 70}, {-18, 70}, {-18, 52}, {-18, 52}, {-18, 52}}, color = {0, 0, 255}));
    connect(pp.pin_p[3], icmeas.n) annotation(
      Line(points = {{-18, 52}, {-18, 52}, {-18, 34}, {-20, 34}, {-20, 34}}, color = {0, 0, 255}));
    connect(icmeas.p, Vcc.p) annotation(
      Line(points = {{-32, 34}, {-36, 34}, {-36, 34}, {-36, 34}}, color = {0, 0, 255}));
    connect(Ic.y, Average.Ic) annotation(
      Line(points = {{-159, 32}, {-140, 32}, {-140, 41}}, color = {0, 0, 127}));
    connect(Vbc.y, Average.Vbc) annotation(
      Line(points = {{-159, 18}, {-136, 18}, {-136, 41}}, color = {0, 0, 127}));
    connect(Ia.y, Average.Ia) annotation(
      Line(points = {{-159, 4}, {-132, 4}, {-132, 41}}, color = {0, 0, 127}));
    connect(Vab.y, Average.Vab) annotation(
      Line(points = {{-159, -10}, {-128, -10}, {-128, 41}}, color = {0, 0, 127}));
    connect(C.p, Average.D) annotation(
      Line(points = {{-158, 62}, {-146, 62}, {-146, 60}, {-146, 60}}, color = {0, 0, 255}));
    connect(C.n, Average.C) annotation(
      Line(points = {{-158, 42}, {-146, 42}, {-146, 44}, {-146, 44}}, color = {0, 0, 255}));
    connect(vzq.y, ref_Computation.Vzq) annotation(
      Line(points = {{-35, -112}, {-22, -112}}, color = {0, 0, 127}));
    connect(Lc.plug_n, Cs.plug_p) annotation(
      Line(points = {{56, 52}, {74, 52}}, color = {0, 0, 255}));
    connect(Udc.y, inverterModd.u) annotation(
      Line(points = {{-70, -76}, {-60, -76}, {-60, -34}, {-60, -34}}, color = {0, 0, 127}));
    connect(P.y[1], ref_Computation.Pref) annotation(
      Line(points = {{-80, -120}, {-24, -120}, {-24, -120}, {-22, -120}}, color = {0, 0, 127}));
    connect(Q.y[1], ref_Computation.Qref) annotation(
      Line(points = {{-81, -146}, {-42, -146}, {-42, -128}, {-22, -128}}, color = {0, 0, 127}));
    connect(LV.plug_n, star.plug_p) annotation(
      Line(points = {{190, 52}, {198, 52}, {198, 38}}, color = {0, 0, 255}));
    connect(star.pin_n, ground1.p) annotation(
      Line(points = {{198, 18}, {198, 10}}, color = {0, 0, 255}));
    connect(Cs.plug_n, Lg.plug_p) annotation(
      Line(points = {{94, 52}, {116, 52}, {116, 52}, {116, 52}}, color = {0, 0, 255}));
    connect(Lg.plug_n, Rg.plug_p) annotation(
      Line(points = {{136, 52}, {142, 52}, {142, 52}, {142, 52}}, color = {0, 0, 255}));
    connect(Rg.plug_n, LV.plug_p) annotation(
      Line(points = {{162, 52}, {170, 52}, {170, 52}, {170, 52}}, color = {0, 0, 255}));
    connect(constantVoltage.n, C.p) annotation(
      Line(points = {{-180, 62}, {-158, 62}, {-158, 62}, {-158, 62}}, color = {0, 0, 255}));
    connect(C.n, constantVoltage.p) annotation(
      Line(points = {{-158, 42}, {-180, 42}, {-180, 42}, {-180, 42}}, color = {0, 0, 255}));
  protected
    annotation(
      uses(iPSL(version = "1.1.0"), PVSystems(version = "0.6.3"), Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0")),
      Diagram(coordinateSystem(extent = {{-210, -210}, {210, 210}})),
      Icon(coordinateSystem(extent = {{-210, -210}, {210, 210}})));
  end VSC_1;
  annotation(
    uses(Modelica(version = "3.2.3")));
end LSPVPP;
