package CPAP
  package Units
    type Viscosity = Real(final quantity = "Viscosity", final unit = "microPa*s");
    type Length = Real(final quantity = "Length", final unit = "cm");
    package Conversion
      function to_cmH2Osecperl "Convert from cubic metre to litre"
        input Real x "in Pa*s/m3";
        output Real y "in cmH2O*s/l";
      algorithm
        y:=1.019716 * 10 ^ (-5) * x;
        annotation(Inline = true, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Text(extent = {{100,-56},{0,-100}}, lineColor = {0,0,0}, textString = "litre"),Text(extent = {{6,100},{-100,56}}, lineColor = {0,0,0}, textString = "m3")}));
      end to_cmH2Osecperl;
    end Conversion;
    type Flow = Real(final quantity = "Flow", final unit = "l/s");
    type Pressure = Real(final quantity = "Pressure", final unit = "cmH2O");
    type FlowResistance = Real(final quantity = "FlowResistance", final unit = "cmH2O/(l/s)");
    type Compliance = Real(final quantity = "Compliance", final unit = "l/cmH2O");
    type Inertance = Real(final quantity = "Inertance", final unit = "cmH2O/l/s2");
  end Units;
  package Interfaces
    connector PositivePin "Positive pin of an electric component"
      CPAP.Units.Pressure p "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      flow CPAP.Units.Flow Q "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      annotation(defaultComponentName = "pin_p", Documentation(info = "<html>
<p>Connectors PositivePin and NegativePin are nearly identical. The only difference is that the icons are different in order to identify more easily the pins of a component. Usually, connector PositivePin is used for the positive and connector NegativePin for the negative pin of an electrical component.</p>
</html>", revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-40,40},{40,-40}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid),Text(extent = {{-160,110},{40,50}}, lineColor = {0,0,255}, textString = "%name")}));
    end PositivePin;
    connector NegativePin "Negative pin of an electric component"
      CPAP.Units.Pressure p "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      flow CPAP.Units.Flow Q "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      annotation(defaultComponentName = "pin_n", Documentation(info = "<html>
<p>Connectors PositivePin and NegativePin are nearly identical. The only difference is that the icons are different in order to identify more easily the pins of a component. Usually, connector PositivePin is used for the positive and connector NegativePin for the negative pin of an electrical component.</p>
</html>", revisions = "<html>
<dl>
<dt><i>1998</i></dt>
<dd>by Christoph Clauss initially implemented
</dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-40,40},{40,-40}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-40,110},{160,50}}, textString = "%name", lineColor = {0,0,255})}));
    end NegativePin;
    partial model TwoPort "Component with two electrical ports, including current"
      Units.Pressure p1 "Voltage drop over the left port";
      Units.Pressure p2 "Voltage drop over the right port";
      Units.Flow Q1 "Current flowing from pos. to neg. pin of the left port";
      Units.Flow Q2 "Current flowing from pos. to neg. pin of the right port";
      PositivePin pin1 "Positive pin of the left port (potential p1.v > n1.v for positive voltage drop v1)" annotation(Placement(transformation(extent = {{-110,40},{-90,60}}, rotation = 0)));
      NegativePin n1 "Negative pin of the left port" annotation(Placement(transformation(extent = {{-90,-60},{-110,-40}}, rotation = 0)));
      PositivePin pin2 "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)" annotation(Placement(transformation(extent = {{110,40},{90,60}}, rotation = 0)));
      NegativePin n2 "Negative pin of the right port" annotation(Placement(transformation(extent = {{90,-60},{110,-40}}, rotation = 0)));
    equation
      p1 = pin1.p - n1.p;
      p2 = pin2.p - n2.p;
      0 = pin1.Q + n1.Q;
      0 = pin2.Q + n2.Q;
      Q1 = pin1.Q;
      Q2 = pin2.Q;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Polygon(points = {{-120,53},{-110,50},{-120,47},{-120,53}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Line(points = {{-136,50},{-111,50}}, color = {160,160,164}),Polygon(points = {{127,-47},{137,-50},{127,-53},{127,-47}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Line(points = {{111,-50},{136,-50}}, color = {160,160,164}),Text(extent = {{112,-44},{128,-29}}, lineColor = {160,160,164}, textString = "i2"),Text(extent = {{118,52},{135,67}}, lineColor = {0,0,0}, textString = "i2"),Polygon(points = {{120,53},{110,50},{120,47},{120,53}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {160,160,164}),Line(points = {{111,50},{136,50}}, color = {0,0,0}),Line(points = {{-136,-49},{-111,-49}}, color = {160,160,164}),Polygon(points = {{-126,-46},{-136,-49},{-126,-52},{-126,-46}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Text(extent = {{-127,-46},{-110,-31}}, lineColor = {160,160,164}, textString = "i1"),Text(extent = {{-136,53},{-119,68}}, lineColor = {160,160,164}, textString = "i1")}), Documentation(revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info = "<html>
<p>TwoPort is a partial model that consists of two ports. Like OnePort each port has two pins. It is assumed that the current flowing into the positive  pin   is identical to the current flowing out of pin n. This currents of each port are  provided explicitly as currents i1 and i2, the voltages respectively as v1 and v2.</p>
</html>"));
    end TwoPort;
    partial model OnePort "Component with two electrical pins p and n and current i from p to n"
      Units.Pressure p "Voltage drop between the two pins (= p.v - n.v)";
      Units.Flow Q "Current flowing from pin p to pin n";
      PositivePin pin "Positive pin (potential p.v > n.v for positive voltage drop v)" annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0)));
      NegativePin n "Negative pin" annotation(Placement(transformation(extent = {{110,-10},{90,10}}, rotation = 0)));
    equation
      p = pin.p - n.p;
      0 = pin.Q + n.Q;
      Q = pin.Q;
      annotation(Documentation(info = "<html>
<p>Superclass of elements which have <b>two</b> electrical pins: the positive pin connector <i>p</i>, and the negative pin connector <i>n</i>. It is assumed that the current flowing into pin p is identical to the current flowing out of pin n. This current is provided explicitly as current i.</p>
</html>", revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Line(points = {{-110,20},{-85,20}}, color = {160,160,164}),Polygon(points = {{-95,23},{-85,20},{-95,17},{-95,23}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Line(points = {{90,20},{115,20}}, color = {160,160,164}),Line(points = {{-125,0},{-115,0}}, color = {160,160,164}),Line(points = {{-120,-5},{-120,5}}, color = {160,160,164}),Text(extent = {{-110,25},{-90,45}}, lineColor = {160,160,164}, textString = "i"),Polygon(points = {{105,23},{115,20},{105,17},{105,23}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Line(points = {{115,0},{125,0}}, color = {160,160,164}),Text(extent = {{90,45},{110,25}}, lineColor = {160,160,164}, textString = "i")}));
    end OnePort;
    connector Pin "Pin of an electrical component"
      Units.Pressure p "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      flow Units.Flow Q "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
      annotation(defaultComponentName = "pin", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-40,40},{40,-40}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid),Text(extent = {{-160,110},{40,50}}, lineColor = {0,0,255}, textString = "%name")}), Documentation(revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info = "<html>
<p>Pin is the basic electric connector. It includes the voltage which consists between the pin and the ground node. The ground node is the node of (any) ground device (Modelica.Electrical.Basic.Ground). Furthermore, the pin includes the current, which is considered to be <b>positive</b> if it is flowing at the pin<b> into the device</b>.</p>
</html>"));
    end Pin;
  end Interfaces;
  package Blocks
    package Interfaces
      connector RealInput = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(points = {{-100,100},{100,0},{-100,-100},{-100,100}}, lineColor = {0,0,127}, fillColor = {0,0,127}, fillPattern = FillPattern.Solid)}, coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Polygon(points = {{0,50},{100,0},{0,-50},{0,50}}, lineColor = {0,0,127}, fillColor = {0,0,127}, fillPattern = FillPattern.Solid),Text(extent = {{-10,85},{-10,60}}, lineColor = {0,0,127}, textString = "%name")}), Documentation(info = "<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));
    end Interfaces;
    package Source
    end Source;
  end Blocks;
  model SignalPressure "Generic voltage source using the input signal as source voltage"
    Interfaces.PositivePin pin annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0)));
    Interfaces.NegativePin n annotation(Placement(transformation(extent = {{110,-10},{90,10}}, rotation = 0)));
    Units.Flow Q "Current flowing from pin p to pin n";
    Blocks.Interfaces.RealInput p(final quantity = "PotentialDifference", final unit = "Pa") "Voltage between pin p and n (= p.v - n.v) as input signal" annotation(Placement(visible = true, transformation(origin = {0,70}, extent = {{-20,20},{20,-20}}, rotation = 270), iconTransformation(origin = {0,70}, extent = {{-20,20},{20,-20}}, rotation = 270)));
  equation
    p = pin.p - n.p;
    0 = pin.Q + n.Q;
    Q = pin.Q;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Ellipse(extent = {{-50,50},{50,-50}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{-90,0},{-50,0}}, color = {0,0,255}),Line(points = {{50,0},{90,0}}, color = {0,0,255}),Line(points = {{-50,0},{50,0}}, color = {0,0,255}),Text(extent = {{-150,-104},{150,-64}}, textString = "%name", lineColor = {0,0,255}),Text(extent = {{-120,50},{-20,0}}, lineColor = {0,0,255}, textString = "+"),Text(extent = {{20,50},{120,0}}, lineColor = {0,0,255}, textString = "-")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Ellipse(extent = {{-50,50},{50,-50}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{-96,0},{-50,0}}, color = {0,0,255}),Line(points = {{50,0},{96,0}}, color = {0,0,255}),Line(points = {{-50,0},{50,0}}, color = {0,0,255}),Line(points = {{-109,20},{-84,20}}, color = {160,160,164}),Polygon(points = {{-94,23},{-84,20},{-94,17},{-94,23}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Line(points = {{91,20},{116,20}}, color = {160,160,164}),Text(extent = {{-109,25},{-89,45}}, lineColor = {160,160,164}, textString = "i"),Polygon(points = {{106,23},{116,20},{106,17},{106,23}}, lineColor = {160,160,164}, fillColor = {160,160,164}, fillPattern = FillPattern.Solid),Text(extent = {{91,45},{111,25}}, lineColor = {160,160,164}, textString = "i"),Line(points = {{-119,-5},{-119,5}}, color = {160,160,164}),Line(points = {{-124,0},{-114,0}}, color = {160,160,164}),Line(points = {{116,0},{126,0}}, color = {160,160,164})}), Documentation(revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Martin Otter<br> initially implemented<br>
       </li>
</ul>
</html>", info = "<html>
<p>The signal voltage source is a parameterless converter of real valued signals into a the source voltage. No further effects are modeled. The real valued signal has to be provided by components of the blocks library. It can be regarded as the &quot;Opposite&quot; of a voltage sensor.</p>
</html>"));
  end SignalPressure;
  model test
    annotation(experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 0.000001));
    CPAP.CPAP_machine cpap_machine1(amplitude_cmH20 = 0, freq_Hz = 0, offset_cmH20 = 30) annotation(Placement(visible = true, transformation(origin = {-55.1622,16.2242}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    CPAP.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-55.1622,-29.2035}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    CPAP.Pipe pipe1(eta_microPas = 18.1, l_cm = 50, r_cm = 0.9) annotation(Placement(visible = true, transformation(origin = {-17.1091,43.9528}, extent = {{12,12},{-12,-12}}, rotation = -180)));
  equation
    connect(pipe1.pin,cpap_machine1.pin_p) annotation(Line(points = {{-5.10914,43.9528},{-8.25959,43.9528},{-8.25959,8.84956},{-56.8613,8.84956},{-56.8613,8.71977}}));
    connect(cpap_machine1.pin_n,pipe1.n) annotation(Line(points = {{-57.1799,26.4543},{-57.2271,26.4543},{-57.2271,44.5428},{-29.1091,44.5428},{-29.1091,43.9528}}));
    connect(cpap_machine1.pin_p,ground1.pin) annotation(Line(points = {{-56.8614,8.71976},{-55.1622,8.71976},{-55.1622,-17.2035},{-55.1622,-17.2035}}));
  end test;
  model CPAP_machine
    Modelica.Blocks.Sources.Sine sine1(amplitude = amplitude_cmH20, freqHz = freq_Hz, offset = offset_cmH20) annotation(Placement(visible = true, transformation(origin = {-75.5162,33.0383}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    annotation(Diagram(), Icon(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-84.0708,54.8673},{74.9263,-31.8584}}),Text(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-54.8673,37.4631},{41.5929,-12.6844}}, textString = "CPAP"),Line(points = {{-16.8142,72.8614},{-16.8142,55.4572}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{-14.4543,-50.1475},{-14.4543,-31.5634}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}));
    CPAP.Interfaces.NegativePin pin_n annotation(Placement(visible = true, transformation(origin = {-16.8142,85.2507}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-16.8142,85.2507}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    CPAP.Interfaces.PositivePin pin_p annotation(Placement(visible = true, transformation(origin = {-14.1593,-62.5369}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-14.1593,-62.5369}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    parameter Real amplitude_cmH20 = 10 annotation(Placement(visible = true, transformation(origin = {46.6077,69.9115}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    parameter Real offset_cmH20 = 10;
    parameter Real freq_Hz = 10;
    CPAP.SignalPressure signalpressure1 annotation(Placement(visible = true, transformation(origin = {-15.9292,33.9233}, extent = {{12,-12},{-12,12}}, rotation = -270)));
  equation
    connect(signalpressure1.pin,pin_p) annotation(Line(points = {{-15.9292,21.9233},{-15.3392,21.9233},{-15.3392,-62.5369},{-14.1593,-62.5369}}));
    connect(signalpressure1.n,pin_n) annotation(Line(points = {{-15.9292,45.9233},{-16.8142,45.9233},{-16.8142,85.2507},{-16.8142,85.2507}}));
    connect(sine1.y,signalpressure1.p) annotation(Line(points = {{-62.3162,33.0383},{-26.2537,33.0383},{-26.2537,33.9233},{-24.3292,33.9233}}));
  end CPAP_machine;
  model Ground "Ground node"
    Interfaces.Pin pin annotation(Placement(visible = true, transformation(origin = {0,100}, extent = {{-10,10},{10,-10}}, rotation = 270), iconTransformation(origin = {0,100}, extent = {{-10,10},{10,-10}}, rotation = 270)));
  equation
    pin.p = 0;
    annotation(Documentation(info = "<html>
<p>Ground of an electrical circuit. The potential at the ground node is zero. Every electrical circuit has to contain at least one ground object.</p>
</html>", revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Line(points = {{-60,50},{60,50}}, color = {0,0,255}),Line(points = {{-40,30},{40,30}}, color = {0,0,255}),Line(points = {{-20,10},{20,10}}, color = {0,0,255}),Line(points = {{0,90},{0,50}}, color = {0,0,255}),Text(extent = {{-144,-19},{156,-59}}, textString = "%name", lineColor = {0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Line(points = {{-60,50},{60,50}}, thickness = 0.5, color = {0,0,255}),Line(points = {{-40,30},{40,30}}, thickness = 0.5, color = {0,0,255}),Line(points = {{-20,10},{20,10}}, thickness = 0.5, color = {0,0,255}),Line(points = {{0,96},{0,50}}, thickness = 0.5, color = {0,0,255}),Text(extent = {{-24,-38},{22,-6}}, textString = "pin.p=0", lineColor = {0,0,255})}));
  end Ground;
  function calculate_resistance
    input Units.Viscosity eta_microPas;
    input Units.Length l_cm "length of pipe";
    input Units.Length r_cm "radius of pipe";
    output Units.FlowResistance R;
  algorithm
    R:=(8 * eta_microPas * 10 ^ (-6) * l_cm) / 100 / (Modelica.Constants.pi * (r_cm / 100) ^ 4);
  end calculate_resistance;
  model Pipe "Ideal linear electrical resistor"
    extends CPAP.Interfaces.OnePort;
    parameter Units.Viscosity eta_microPas(start = 18.1);
    parameter Units.Length l_cm(start = 100) "length of pipe";
    parameter Units.Length r_cm(start = 1) "radius of pipe";
    Units.FlowResistance R = Units.Conversion.to_cmH2Osecperl(CPAP.calculate_resistance(eta_microPas, l_cm, r_cm));
  equation
    p = R * Q;
    annotation(Documentation(info = "<html>
<p>The linear resistor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i*R = v</i>. The Resistance <i>R</i> is allowed to be positive, zero, or negative.</p>
</html>", revisions = "<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Diagram(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-70,30},{70,-30}}),Line(points = {{-96,0},{-70,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{70,0},{96,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), Icon(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-79.056,47.4926},{82.0059,-49.2625}}),Line(points = {{-89.9705,0.294985},{-78.7611,0.294985}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{82.3009,-0.294985},{90.2655,-0.294985}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), experiment(StartTime = 0.0, StopTime = 1.0, Tolerance = 0.000001));
  end Pipe;
  model Atemmuskulatur
    Modelica.Blocks.Sources.Sine sine1(amplitude = amplitude_cmH20, freqHz = freq_Hz, offset = offset_cmH20) annotation(Placement(visible = true, transformation(origin = {-75.5162,33.0383}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    annotation(Diagram(), Icon(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-84.0708,54.8673},{74.9263,-31.8584}}),Line(points = {{-16.8142,72.8614},{-16.8142,55.4572}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{-14.4543,-50.1475},{-14.4543,-31.5634}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Text(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-85.2507,60.472},{76.6962,-31.2684}}, textString = "Atemmuskulatur")}));
    CPAP.Interfaces.NegativePin pin_n annotation(Placement(visible = true, transformation(origin = {-16.8142,85.2507}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-16.8142,85.2507}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    CPAP.Interfaces.PositivePin pin_p annotation(Placement(visible = true, transformation(origin = {-14.1593,-62.5369}, extent = {{-12,-12},{12,12}}, rotation = 0), iconTransformation(origin = {-14.1593,-62.5369}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    parameter Real amplitude_cmH20 = 10 annotation(Placement(visible = true, transformation(origin = {46.6077,69.9115}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    parameter Real offset_cmH20 = 10;
    parameter Real freq_Hz = 10;
    CPAP.SignalPressure signalpressure1 annotation(Placement(visible = true, transformation(origin = {-15.9292,33.9233}, extent = {{12,-12},{-12,12}}, rotation = -270)));
  equation
    connect(signalpressure1.pin,pin_p) annotation(Line(points = {{-15.9292,21.9233},{-15.3392,21.9233},{-15.3392,-62.5369},{-14.1593,-62.5369}}));
    connect(signalpressure1.n,pin_n) annotation(Line(points = {{-15.9292,45.9233},{-16.8142,45.9233},{-16.8142,85.2507},{-16.8142,85.2507}}));
    connect(sine1.y,signalpressure1.p) annotation(Line(points = {{-62.3162,33.0383},{-26.2537,33.0383},{-26.2537,33.9233},{-24.3292,33.9233}}));
  end Atemmuskulatur;
  model Compliance "Ideal linear electrical capacitor"
    extends Interfaces.OnePort;
    parameter Units.Compliance C(start = 1) "Capacitance";
    parameter Units.Pressure IC = 0 "Initial Value";
    parameter Boolean UIC = false;
  initial equation
    if UIC then
      p = IC;
    end if;
  equation
    Q = C * der(p);
    annotation(Documentation(info = "<html>
<p>The linear capacitor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i = C * dv/dt</i>. The Capacitance <i>C</i> is allowed to be positive, zero, or negative.</p>
<p><br/>Besides the capacitance C parameter the capacitor model has got the two parameters IC and UIC that belong together. With the IC parameter the user can specify an initial value of the voltage over the capacitor, which is defined from positive pin p to negative pin n (v=p.v - n.v).</p>
<p><br/>Hence the capacitor is charged at the beginning of the simulation. The other parameter UIC is of type Boolean. If UIC is true, the simulation tool uses</p>
<p><br/>the IC value at the initial calculation by adding the equation v= IC. If UIC is false, the IC value can be used (but it does not need to!) to calculate the initial values in order to simplify the numerical algorithms of initial calculation.</p>
</html>", revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Line(points = {{-14,28},{-14,-28}}, thickness = 0.5, color = {0,0,255}),Line(points = {{14,28},{14,-28}}, thickness = 0.5, color = {0,0,255}),Line(points = {{-90,0},{-14,0}}, color = {0,0,255}),Line(points = {{14,0},{90,0}}, color = {0,0,255}),Text(extent = {{-136,-60},{136,-92}}, lineColor = {0,0,0}, textString = "C=%C"),Text(extent = {{-150,85},{150,45}}, textString = "%name", lineColor = {0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Line(points = {{-20,40},{-20,-40}}, thickness = 0.5, color = {0,0,255}),Line(points = {{20,40},{20,-40}}, thickness = 0.5, color = {0,0,255}),Line(points = {{-96,0},{-20,0}}, color = {0,0,255}),Line(points = {{20,0},{96,0}}, color = {0,0,255})}));
  end Compliance;
  model Resistor "Ideal linear electrical resistor"
    extends CPAP.Interfaces.OnePort;
    parameter Units.FlowResistance R(start = 1);
  equation
    p = R * Q;
    annotation(Documentation(info = "<html>
<p>The linear resistor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i*R = v</i>. The Resistance <i>R</i> is allowed to be positive, zero, or negative.</p>
</html>", revisions = "<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Diagram(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-70,30},{70,-30}}),Line(points = {{-96,0},{-70,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{70,0},{96,0}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), Icon(graphics = {Rectangle(rotation = 0, lineColor = {0,0,255}, fillColor = {0,0,255}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-79.056,47.4926},{82.0059,-49.2625}}),Line(points = {{-89.9705,0.294985},{-78.7611,0.294985}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25),Line(points = {{82.3009,-0.294985},{90.2655,-0.294985}}, rotation = 0, color = {0,0,255}, pattern = LinePattern.Solid, thickness = 0.25)}), experiment(StartTime = 0.0, StopTime = 1.0, Tolerance = 0.000001));
  end Resistor;
  model Inertance "Ideal linear electrical inductor"
    extends CPAP.Interfaces.OnePort;
    parameter Units.Inertance I(start = 1) "Inertance";
    parameter Units.Flow IC = 0 "Initial Value";
    parameter Boolean UIC = false;
  initial equation
    if UIC then
      i = IC;
    end if;
  equation
    I * der(Q) = p;
    annotation(Documentation(info = "<html>
<p>The linear inductor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>v = L * di/dt</i>. The Inductance <i>L</i> is allowed to be positive, zero, or negative.</p>
<p><br/>Besides the inductance L parameter the inductor model has got the two parameters IC and UIC that belong together. With the IC parameter the user can specify an initial value of the current that flows through the inductor.</p>
<p><br/>Hence the inductor has an initial current at the beginning of the simulation. The other parameter UIC is of type Boolean. If UIC is true, the simulation tool uses</p>
<p><br/>the IC value at the initial calculation by adding the equation i= IC. If UIC is false, the IC value can be used (but it does not need to!) to calculate the initial values in order to simplify the numerical algorithms of initial calculation.</p>
</html>", revisions = "<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Ellipse(extent = {{-60,-15},{-30,15}}, lineColor = {0,0,255}),Ellipse(extent = {{-30,-15},{0,15}}, lineColor = {0,0,255}),Ellipse(extent = {{0,-15},{30,15}}, lineColor = {0,0,255}),Ellipse(extent = {{30,-15},{60,15}}, lineColor = {0,0,255}),Rectangle(extent = {{-60,-30},{60,0}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{60,0},{90,0}}, color = {0,0,255}),Line(points = {{-90,0},{-60,0}}, color = {0,0,255}),Text(extent = {{-138,-60},{144,-94}}, lineColor = {0,0,0}, textString = "L=%L"),Text(extent = {{-152,79},{148,39}}, textString = "%name", lineColor = {0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {2,2}), graphics = {Ellipse(extent = {{-60,-15},{-30,15}}, lineColor = {0,0,255}),Ellipse(extent = {{-30,-15},{0,15}}, lineColor = {0,0,255}),Ellipse(extent = {{0,-15},{30,15}}, lineColor = {0,0,255}),Ellipse(extent = {{30,-15},{60,15}}, lineColor = {0,0,255}),Rectangle(extent = {{-60,-30},{60,0}}, lineColor = {255,255,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{60,0},{96,0}}, color = {0,0,255}),Line(points = {{-96,0},{-60,0}}, color = {0,0,255})}));
  end Inertance;
  package Components
    replaceable CPAP.Interfaces.TwoPort twoport1 annotation(Placement(visible = true, transformation(origin = {-72.5664,51.0324}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    package LungModels
      model extendedRIC
        CPAP.Resistor resistor1(R = 2.23) annotation(Placement(visible = true, transformation(origin = {-55.1622,0.000000000000000999201}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Inertance inertance1(I = 0.0079) annotation(Placement(visible = true, transformation(origin = {-7.07965,-0.294985}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Compliance compliance1(C = 0.0081) annotation(Placement(visible = true, transformation(origin = {35.3982,0}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Ground ground1 annotation(Placement(visible = true, transformation(origin = {27.1386,-86.4307}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        annotation(experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 0.000001));
        CPAP.Atemmuskulatur atemmuskulatur1(amplitude_cmH20 = 4, offset_cmH20 = 0, freq_Hz = 0.25) annotation(Placement(visible = true, transformation(origin = {61.0619,-55.1622}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Resistor resistor2(R = 5.41) annotation(Placement(visible = true, transformation(origin = {34.5133,34.5133}, extent = {{-12,-12},{12,12}}, rotation = 0)));
      equation
        connect(resistor2.n,compliance1.n) annotation(Line(points = {{46.5133,34.5133},{58.7021,34.5133},{58.7021,-0.589971},{47.4926,-0.589971},{47.4926,0},{47.3982,0}}));
        connect(inertance1.n,resistor2.pin) annotation(Line(points = {{4.92035,-0.294985},{13.5693,-0.294985},{13.5693,35.3982},{22.5133,35.3982},{22.5133,34.5133}}));
        connect(ground1.pin,atemmuskulatur1.pin_p) annotation(Line(points = {{27.1386,-74.4307},{27.1386,-62.2419},{59.3628,-62.2419},{59.3628,-62.6667}}));
        connect(atemmuskulatur1.pin_p,resistor1.pin) annotation(Line(points = {{59.3628,-62.6667},{-87.0206,-62.6667},{-87.0206,0},{-67.1622,0},{-67.1622,0.000000000000000999201}}));
        connect(atemmuskulatur1.pin_n,compliance1.n) annotation(Line(points = {{59.0442,-44.9322},{58.4071,-44.9322},{58.4071,-0.589971},{47.3982,-0.589971},{47.3982,0}}));
        connect(inertance1.n,compliance1.pin) annotation(Line(points = {{4.92035,-0.294985},{23.0088,-0.294985},{23.0088,0},{23.3982,0}}));
        connect(resistor1.n,inertance1.pin) annotation(Line(points = {{-43.1622,0.000000000000000999201},{-6.78466,0.000000000000000999201},{-6.78466,-0.294985},{-19.0796,-0.294985}}));
      end extendedRIC;
      model Chbat_Rideout
        CPAP.Resistor resistor4(R = 1) annotation(Placement(visible = true, transformation(origin = {-67.8466,62.8319}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        annotation(experiment(StartTime = 0.0, StopTime = 60.0, Tolerance = 0.000001));
        CPAP.Resistor resistor3(R = 1) annotation(Placement(visible = true, transformation(origin = {72.8613,60.767}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Resistor resistor1(R = 1) annotation(Placement(visible = true, transformation(origin = {-3.24483,62.8318}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Atemmuskulatur atemmuskulatur1(amplitude_cmH20 = 4, offset_cmH20 = 0, freq_Hz = 0.25) annotation(Placement(visible = true, transformation(origin = {57.5221,-48.3776}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Ground ground1 annotation(Placement(visible = true, transformation(origin = {-61.6519,-81.1209}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Resistor resistor2(R = 1) annotation(Placement(visible = true, transformation(origin = {34.5133,64.0118}, extent = {{-12,-12},{12,12}}, rotation = 0)));
        CPAP.Compliance compliance3(C = 0.01) annotation(Placement(visible = true, transformation(origin = {86.7257,14.4543}, extent = {{-12,12},{12,-12}}, rotation = -90)));
        CPAP.Compliance compliance1(C = 0.01) annotation(Placement(visible = true, transformation(origin = {56.3421,16.2242}, extent = {{-12,12},{12,-12}}, rotation = -90)));
        CPAP.Compliance compliance2(C = 0.01) annotation(Placement(visible = true, transformation(origin = {16.5192,16.5192}, extent = {{-12,12},{12,-12}}, rotation = -90)));
        CPAP.Compliance compliance4(C = 0.01) annotation(Placement(visible = true, transformation(origin = {-46.9027,16.2242}, extent = {{-12,12},{12,-12}}, rotation = -90)));
      equation
        connect(compliance4.n,atemmuskulatur1.pin_p) annotation(Line(points = {{-46.9027,4.22419},{-46.9027,4.22419},{-46.9027,-56.6372},{55.823,-56.6372},{55.823,-55.882}}));
        connect(resistor4.n,compliance4.pin) annotation(Line(points = {{-55.8466,62.8319},{-46.6077,62.8319},{-46.6077,28.2242},{-46.9027,28.2242}}));
        connect(resistor1.n,resistor2.pin) annotation(Line(points = {{8.75517,62.8318},{22.7139,62.8318},{22.7139,64.0118},{22.5133,64.0118}}));
        connect(resistor2.n,resistor3.pin) annotation(Line(points = {{46.5133,64.0118},{56.9322,64.0118},{56.9322,60.767},{60.8613,60.767}}));
        connect(resistor2.n,compliance1.pin) annotation(Line(points = {{46.5133,64.0118},{51.6224,64.0118},{51.6224,29.2035},{51.0324,29.2035},{51.0324,28.2242},{56.3421,28.2242}}));
        connect(ground1.pin,atemmuskulatur1.pin_p) annotation(Line(points = {{-61.6519,-69.1209},{-61.6519,-56.6372},{55.1622,-56.6372},{55.1622,-55.882},{55.823,-55.882}}));
        connect(resistor4.pin,atemmuskulatur1.pin_p) annotation(Line(points = {{-79.8466,62.8319},{-80.826,62.8319},{-80.826,-56.6372},{55.823,-56.6372},{55.823,-55.882}}));
        connect(resistor1.n,compliance2.pin) annotation(Line(points = {{8.75517,62.8318},{15.6342,62.8318},{15.6342,28.0236},{16.5192,28.0236},{16.5192,28.5192}}));
        connect(compliance2.n,compliance1.n) annotation(Line(points = {{16.5192,4.51918},{51.0324,4.51918},{51.0324,4.22419},{56.3421,4.22419}}));
        connect(atemmuskulatur1.pin_n,compliance1.n) annotation(Line(points = {{55.5044,-38.1475},{55.7522,-38.1475},{55.7522,4.22419},{56.3421,4.22419}}));
        connect(resistor4.n,resistor1.pin) annotation(Line(points = {{-55.8466,62.8319},{-15.6342,62.8319},{-15.6342,62.8318},{-15.2448,62.8318}}));
        connect(compliance1.n,compliance3.n) annotation(Line(points = {{56.3421,4.22419},{85.8407,4.22419},{85.8407,2.4543},{86.7257,2.4543}}));
        connect(resistor3.n,compliance3.pin) annotation(Line(points = {{84.8613,60.767},{87.3156,60.767},{87.3156,26.8437},{86.7257,26.8437},{86.7257,26.4543}}));
      end Chbat_Rideout;
    end LungModels;
  end Components;
end CPAP;

