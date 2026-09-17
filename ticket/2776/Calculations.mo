package Calculations "Exemplary package for efficiency calculations."
  model PumpEfficiencyMeter "Calculate pump efficiency from measurements"
    Modelica.Blocks.Interfaces.RealInput P_shaft "Shaft power" annotation(Placement(transformation(extent = {{-120, -90}, {-100, -70}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput T_suction "Temperature at suction side" annotation(Placement(transformation(extent = {{-120, 70}, {-100, 90}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput T_deliver "Temperature at delivery side" annotation(Placement(transformation(extent = {{-120, 30}, {-100, 50}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput p_suction "Pressure at suction side" annotation(Placement(transformation(extent = {{-120, -10}, {-100, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput p_deliver "Pressure at delivery side" annotation(Placement(transformation(extent = {{-120, -50}, {-100, -30}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput m_dot "Mass flow rate through pump" annotation(Placement(transformation(extent = {{-120, 110}, {-100, 130}}, rotation = 0)));
    Calculations.Conversions.FromCelsius fromCelsius annotation(Placement(transformation(extent = {{-80, 70}, {-60, 90}}, rotation = 0)));
    Calculations.Conversions.FromCelsius fromCelsius1 annotation(Placement(transformation(extent = {{-80, 30}, {-60, 50}}, rotation = 0)));
    Calculations.Conversions.FromBar fromBar annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}}, rotation = 0)));
    Calculations.Conversions.FromBar fromBar1 annotation(Placement(transformation(extent = {{-80, -50}, {-60, -30}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput eta "efficiency of pump" annotation(Placement(transformation(extent = {{100, 40}, {120, 60}}, rotation = 0)));
    Calculations.Conversions.FromMW fromMW annotation(Placement(transformation(extent = {{-80, -90}, {-60, -70}}, rotation = 0)));
    Calculations.Components.OverallPumpEfficiency eta_o(z_suction = 0, z_deliver = 1, D_suction = 0.6, D_deliver = 0.5) annotation(Placement(visible = true, transformation(origin = {20, 40}, extent = {{-30, -35.4167}, {30, 49.5833}}, rotation = 0)));
  equation
    connect(eta_o.eta, eta) annotation(Line(points = {{53, 47.0833}, {104.332, 47.0833}, {104.332, 49.1395}, {104.332, 49.1395}}, color = {0, 0, 127}));
    connect(m_dot, eta_o.m_dot) annotation(Line(points = {{-110, 120}, {-28.4866, 120}, {-28.4866, 82.5091}, {-13.5312, 82.5}, {-13, 82.5}}, color = {0, 0, 127}));
    connect(fromCelsius.kelvin, eta_o.T_suction) annotation(Line(points = {{-59, 80}, {-43.0861, 80}, {-42.8074, 68.2249}, {-12.4629, 68.3333}, {-13, 68.3333}}, color = {0, 0, 127}));
    connect(fromCelsius1.kelvin, eta_o.T_deliver) annotation(Line(points = {{-59, 40}, {-42.73, 40}, {-42.73, 54.0998}, {-12.4629, 54.1667}, {-13, 54.1667}}, color = {0, 0, 127}));
    connect(fromBar.pa, eta_o.p_suction) annotation(Line(points = {{-59, 0}, {-35.2522, 0}, {-35.2522, 40.0579}, {-12.4629, 40}, {-13, 40}}, color = {0, 0, 127}));
    connect(fromBar1.pa, eta_o.p_deliver) annotation(Line(points = {{-59, -40}, {-29.1988, -40}, {-29.1988, 25.8351}, {-13.1751, 25.8333}, {-13, 25.8333}}, color = {0, 0, 127}));
    connect(fromMW.w, eta_o.P_shaft) annotation(Line(points = {{-59, -80}, {-20.2967, -80}, {-20.2967, 12.1288}, {-12.819, 11.6667}, {-13, 11.6667}}, color = {0, 0, 127}));
    connect(T_suction, fromCelsius.celsius) annotation(Line(points = {{-110, 80}, {-82, 80}}, color = {0, 0, 127}));
    connect(T_deliver, fromCelsius1.celsius) annotation(Line(points = {{-110, 40}, {-82, 40}}, color = {0, 0, 127}));
    connect(p_suction, fromBar.bar) annotation(Line(points = {{-110, 0}, {-82, 0}}, color = {0, 0, 127}));
    connect(p_deliver, fromBar1.bar) annotation(Line(points = {{-110, -40}, {-82, -40}}, color = {0, 0, 127}));
    connect(P_shaft, fromMW.mw) annotation(Line(points = {{-110, -80}, {-82, -80}}, color = {0, 0, 127}));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 140}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 140}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0.15, -0.3}, lineColor = {0, 0, 255}, extent = {{-100, 140}, {100, -100}}), Text(origin = {1.17, 26.69}, lineColor = {0, 0, 255}, extent = {{-63.27, 28.7}, {63.27, -28.7}}, textString = "eta pump")}));
  end PumpEfficiencyMeter;

  package Components
    model OverallPumpEfficiency "Efficiency of a pump, relating delivered power to shaft power"
      import SI = Modelica.SIunits;
      import g = Modelica.Constants.g_n;
      import Modelica.Constants.pi;
      import Modelica.Media.Water.IF97_Utilities.rho_pT;
      Modelica.Blocks.Interfaces.RealInput m_dot "Mass flow rate though pump" annotation(Placement(transformation(extent = {{-120, 110}, {-100, 130}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput T_suction "Temperature at suction side" annotation(Placement(transformation(extent = {{-120, 70}, {-100, 90}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput T_deliver "Temperature at delivery side" annotation(Placement(transformation(extent = {{-120, 30}, {-100, 50}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput p_suction "Pressure at suction side" annotation(Placement(transformation(extent = {{-120, -10}, {-100, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput p_deliver "Pressure at delivery side" annotation(Placement(transformation(extent = {{-120, -50}, {-100, -30}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput P_shaft "Shaft power" annotation(Placement(transformation(extent = {{-120, -90}, {-100, -70}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput eta "efficiency of pump" annotation(Placement(transformation(extent = {{100, 10}, {120, 30}}, rotation = 0)));
      parameter SI.Height z_suction = 0 "Relative height at suction side";
      parameter SI.Height z_deliver = 1 "Relative height at delivery side";
      parameter SI.Diameter D_suction = 0.6 "Pipe diameter at suction side";
      parameter SI.Diameter D_deliver = 0.5 "Pipe diameter at delivery side";
      SI.SpecificEnthalpy Dht_deliver "delivered increase in total enthalpy";
      SI.Density rho_suction = rho_pT(p_suction, T_suction) "density at suction side";
      SI.Density rho_deliver = rho_pT(p_deliver, T_deliver) "density at delivery side";
      SI.Velocity c_suction = m_dot / rho_suction / (pi / 4 * D_suction ^ 2) "velocity at suction side";
      SI.Velocity c_deliver = m_dot / rho_deliver / (pi / 4 * D_deliver ^ 2) "velocity at delivery side";
    equation
      eta = m_dot * Dht_deliver / P_shaft;
      Dht_deliver = p_deliver / rho_deliver - p_suction / rho_suction + 0.5 * (c_deliver ^ 2 - c_suction ^ 2) + g * (z_deliver - z_suction);
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 140}}), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 140}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {0.14, 19.86}, lineColor = {0, 0, 255}, extent = {{-99.86, 119.86}, {99.57, -119.57}}), Text(origin = {2.79, 20.75}, lineColor = {0, 0, 255}, extent = {{-49.55, 27.87}, {49.55, -27.87}}, textString = "eta")}));
    end OverallPumpEfficiency;
  end Components;

  package Constants
    constant Modelica.SIunits.AbsolutePressure p_reference = 101325 "Ambient pressure";
  end Constants;

  package Conversions
    model FromCelsius "Conversion block from °Celsius to Kelvin"
      Modelica.Blocks.Interfaces.RealInput celsius annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput kelvin annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      kelvin = Modelica.SIunits.Conversions.from_degC(celsius);
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "°C"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "K"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "K"), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "°C"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Celsius to Kelvin
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end FromCelsius;

    model ToCelsius "Conversion from Kelvin to °Celsius"
      Modelica.Blocks.Interfaces.RealInput kelvin annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput celsius annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      celsius = Modelica.SIunits.Conversions.to_degC(kelvin);
      annotation(Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-34, -42}, {-114, -122}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "K"), Text(extent = {{110, -39}, {30, -119}}, lineColor = {0, 0, 0}, textString = "°C"), Line(points = {{-40, 0}, {-100, 0}}), Line(points = {{40, 0}, {100, 0}})}), Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-42, -41}, {-101, -98}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "K"), Text(extent = {{100, -40}, {30, -100}}, lineColor = {0, 0, 0}, textString = "°C"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{40, 0}, {100, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Kelvin to Celsius
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end ToCelsius;

    model FromBar "Conversion block from Bar to Pascal"
      Modelica.Blocks.Interfaces.RealInput bar annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput pa annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      pa = Modelica.SIunits.Conversions.from_bar(bar) + Constants.p_reference;
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "bar"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "Pa"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "bar"), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "Pa"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Bar, given relative
                                     to Constants.p_reference, to Pascal and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end FromBar;

    model ToBar "Conversion block from Pascal to Bar"
      Modelica.Blocks.Interfaces.RealInput pa annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput bar annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      bar = Modelica.SIunits.Conversions.to_bar(pa - Constants.p_reference);
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "Pa"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "bar"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "Pa"), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "bar"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Pascal to Bar,
                                     relative to Constants.p_reference, and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end ToBar;

    model FromBarAbs "Conversion block from Bar to Pascal"
      Modelica.Blocks.Interfaces.RealInput bar annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput pa annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      pa = Modelica.SIunits.Conversions.from_bar(bar);
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{30, -48}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "barabs"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "Pa"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{20, -40}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "barabs"), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "Pa"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Bar to Pascal
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end FromBarAbs;

    model ToBarAbs "Conversion block from Pascal to Bar"
      Modelica.Blocks.Interfaces.RealInput pa annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput bar annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      bar = Modelica.SIunits.Conversions.to_bar(pa);
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "Pa"), Text(extent = {{100, -47}, {-20, -100}}, lineColor = {0, 0, 0}, textString = "barabs"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{112, -40}, {-20, -126}}, lineColor = {0, 0, 0}, textString = "barabs"), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "Pa"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Pascal to Bar
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end ToBarAbs;

    model FromMW "Conversion block from MW to W"
      Modelica.Blocks.Interfaces.RealInput mw annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput w annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      w = mw * 1e6;
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "MW"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "W"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "MW"), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "W"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Megawatt to Watt
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end FromMW;

    model ToMW "Conversion block from MW to W"
      Modelica.Blocks.Interfaces.RealInput w annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput mw annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
    equation
      mw = w * 1e-6;
      annotation(Diagram(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-40, -50}, {-99, -99}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "W"), Text(extent = {{100, -47}, {44, -100}}, lineColor = {0, 0, 0}, textString = "MW"), Line(points = {{-100, 0}, {-40, 0}}), Line(points = {{41, 0}, {100, 0}})}), Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-31, -39}, {-111, -119}}, lineColor = {0, 0, 0}, lineThickness = 1, textString = "W"), Text(extent = {{112, -40}, {32, -120}}, lineColor = {0, 0, 0}, textString = "MW"), Line(points = {{-41, 0}, {-100, 0}}), Line(points = {{100, 0}, {40, 0}})}), Documentation(info = "<HTML>
                                     <p>
                                     This component converts an input signal from Watt to Megawatt
                                     and provides it as output signal.
                                     </p>
                                     </HTML>
                                     "));
    end ToMW;
  end Conversions;

  model PumpEfficiencyMeterTest
    Modelica.Blocks.Sources.Constant constant1(k = 180) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant2(k = 187) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant3(k = 15) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant4(k = 360) annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant5(k = 20) annotation(Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 427) annotation(Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Calculations.PumpEfficiencyMeter pumpefficiencymeter1 annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-48.75, -40.625}, {48.75, 56.875}}, rotation = 0)));
  equation
    connect(constant5.y, pumpefficiencymeter1.P_shaft) annotation(Line(points = {{-69, -80}, {-40.566, -80}, {-40.566, -52.6165}, {-29.2393, -52.6165}, {-13.625, -52.5835}, {-13.625, -52.5}}, color = {0, 0, 127}));
    connect(constant3.y, pumpefficiencymeter1.p_suction) annotation(Line(points = {{-69, 0}, {-61.3208, 0}, {-61.3208, -19.9868}, {-8.96226, -20}, {-13.625, -20}}, color = {0, 0, 127}));
    connect(constant1.y, pumpefficiencymeter1.T_suction) annotation(Line(points = {{-69, 80}, {-53.7736, 80}, {-53.7736, 12.4891}, {-9.90566, 12.5}, {-13.625, 12.5}}, color = {0, 0, 127}));
    connect(const.y, pumpefficiencymeter1.m_dot) annotation(Line(points = {{-29, 60}, {-21.4797, 60}, {-21.4797, 28.4934}, {-9.54654, 28.75}, {-13.625, 28.75}}, color = {0, 0, 127}));
    connect(constant4.y, pumpefficiencymeter1.p_deliver) annotation(Line(points = {{-69, -40}, {-18.2267, -40}, {-13.625, -36.1617}, {-13.625, -36.25}}, color = {0, 0, 127}));
    connect(constant2.y, pumpefficiencymeter1.T_deliver) annotation(Line(points = {{-69, 40}, {-55.6604, 40}, {-55.6604, -3.7974}, {-11.7925, -3.75}, {-13.625, -3.75}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end PumpEfficiencyMeterTest;

  model PumpEfficiencyMeterTestFMU
    Modelica.Blocks.Sources.Constant constant1(k = 180) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant2(k = 187) annotation(Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant3(k = 15) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant4(k = 360) annotation(Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constant5(k = 20) annotation(Placement(visible = true, transformation(origin = {-80, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 427) annotation(Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Calculations_PumpEfficiencyMeter_me_FMU calculations_pumpefficiencymeter_me_fmu1 annotation(Placement(visible = true, transformation(origin = {40, -20}, extent = {{-55, -55}, {55, 55}}, rotation = 0)));
  equation
    connect(const.y, calculations_pumpefficiencymeter_me_fmu1.m_dot) annotation(Line(points = {{-29, 60}, {-28.2158, 60}, {-28.2158, -22.4066}, {-21.1618, -22.4066}, {-21.1618, -22.4066}}, color = {0, 0, 127}));
    connect(constant5.y, calculations_pumpefficiencymeter_me_fmu1.P_shaft) annotation(Line(points = {{-69, -80}, {-38.9262, -80}, {-38.9262, 19.7987}, {-21.1409, 19.7987}, {-21.1409, 19.7987}}, color = {0, 0, 127}));
    connect(constant1.y, calculations_pumpefficiencymeter_me_fmu1.T_suction) annotation(Line(points = {{-69, 80}, {-50.3356, 80}, {-50.3356, -9.0604}, {-21.1409, -9.0604}, {-21.1409, -9.0604}}, color = {0, 0, 127}));
    connect(constant2.y, calculations_pumpefficiencymeter_me_fmu1.T_deliver) annotation(Line(points = {{-69, 40}, {-46.3087, 40}, {-46.3087, 4.36242}, {-19.7987, 4.36242}, {-19.7987, 4.36242}}, color = {0, 0, 127}));
    connect(constant3.y, calculations_pumpefficiencymeter_me_fmu1.p_suction) annotation(Line(points = {{-69, 0}, {-59.0164, 0}, {-59.0164, -51.9126}, {-20.2186, -51.9126}, {-20.2186, -51.9126}}, color = {0, 0, 127}));
    connect(constant4.y, calculations_pumpefficiencymeter_me_fmu1.p_deliver) annotation(Line(points = {{-69, -40}, {-21.8579, -40}, {-21.8579, -36.612}, {-21.8579, -36.612}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end PumpEfficiencyMeterTestFMU;
  annotation(uses(Modelica(version = "3.2.1")), version = "1", conversion(noneFromVersion = ""));
end Calculations;