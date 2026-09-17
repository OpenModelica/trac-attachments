package BooleanIssue
  package Basic "TelSysPro Basic Components"

    package Operators "low level operators"

      model RealTransmission
        // Parameters
      protected
        parameter Integer defaultLatency = 20 "default latency";
        parameter Boolean defaultIsWorking = true "default state";
        parameter Real maxDelay = 1000 "protected parameter for compatibility with OM (unit is s)" annotation(
          HideResult = true);
        parameter Real ud_init[nR](each fixed = false) annotation(
          HideResult = true);
      public
        parameter Integer samplingPeriod[nR] = zeros(nR) "sampling period (ms)";
        parameter Integer nR "number of Reals to transmit";
        // Connectors
        Modelica.Blocks.Interfaces.RealOutput y[nR] annotation(
          Placement(transformation(extent = {{100, -10}, {120, 10}})));
        Modelica.Blocks.Interfaces.RealInput u[nR] annotation(
          Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        Interfaces.ToReceive u_UL annotation(
          Placement(transformation(extent = {{-10, -120}, {10, -100}}), iconTransformation(extent = {{-10, -120}, {10, -100}})));
        // Local variables
        discrete Real ud1[nR](start = ud_init) annotation(
          HideResult = true);
        Real ud2[nR](start = ud_init) annotation(
          HideResult = true);
      initial equation
        ud_init = u;
      equation
        if cardinality(u_UL) == 0 then
          u_UL.latency = defaultLatency;
          u_UL.isWorking = defaultIsWorking;
        end if;
        for i in 1:nR loop
          if samplingPeriod[i] == 0 then
            when u_UL.isWorking == false then
              ud1[i] = pre(u[i]);
            end when;
            ud2[i] = if u_UL.isWorking then u[i] else ud1[i];
          else
            when sample(0, samplingPeriod[i] / 1000) then
              ud1[i] = u[i];
              ud2[i] = if u_UL.isWorking then ud1[i] else pre(ud2[i]);
            end when;
          end if;
          y[i] = if u_UL.latency == 0 then ud2[i] else delay(ud2[i], u_UL.latency / 1000, maxDelay);
        end for;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false)));
      end RealTransmission;

            model BooleanTransmission
                // Parameters
            protected
                parameter Integer defaultLatency = 20 "default latency";
                parameter Boolean defaultIsWorking = true "default state";
                parameter Real maxDelay = 1000 "protected parameter for compatibility with OM (unit is s)" annotation(
                    HideResult = true);
                parameter Boolean ud_init[nB](each fixed = false) annotation(
                    HideResult = true);
            public
                parameter Integer nB "number of Booleans to transmit";
                // Connectors
                Modelica.Blocks.Interfaces.BooleanOutput y[nB] annotation(
                    Placement(transformation(extent = {{100, -10}, {120, 10}})));
                Modelica.Blocks.Interfaces.BooleanInput u[nB] annotation(
                    Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
                Interfaces.ToReceive u_UL annotation(
                    Placement(transformation(extent = {{-10, -120}, {10, -100}}), iconTransformation(extent = {{-10, -120}, {10, -100}})));
                // Local variables
                Boolean ud1[nB](start = ud_init) ;//annotation(HideResult = true);
                Real ud2[nB] ;//annotation(HideResult = true);
            initial equation
                ud_init = u;
            equation
                if cardinality(u_UL) == 0 then
                    u_UL.latency = defaultLatency;
                    u_UL.isWorking = defaultIsWorking;
                end if;
      // Signal delay
                for i in 1:nB loop
                    ud1[i] = if u_UL.isWorking then u[i] else pre(ud1[i]);
                    ud2[i] = if u_UL.latency == 0 then if ud1[i] then 1.0 else 0.0 else delay(if ud1[i] then 1.0 else 0.0, u_UL.latency / 1000, maxDelay);
                    y[i] = if ud2[i] > 0.0 then true else false;
                end for;
                annotation(
                    Icon(coordinateSystem(preserveAspectRatio = false)),
                    Diagram(coordinateSystem(preserveAspectRatio = false)));
            end BooleanTransmission;
      

      model IntegerTransmission
        // Parameters
      protected
        parameter Integer defaultLatency = 20 "default latency";
        parameter Boolean defaultIsWorking = true "default state";
        parameter Real maxDelay = 1000 "protected parameter for compatibility with OM (unit is s)" annotation(
          HideResult = true);
        parameter Integer ud_init[nI](each fixed = false) annotation(
          HideResult = true);
      public
        parameter Integer nI "number of Integers to transmit";
        // Connectors
        Modelica.Blocks.Interfaces.IntegerOutput y[nI] annotation(
          Placement(transformation(extent = {{100, -10}, {120, 10}})));
        Modelica.Blocks.Interfaces.IntegerInput u[nI] annotation(
          Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        Interfaces.ToReceive u_UL annotation(
          Placement(transformation(extent = {{-10, -120}, {10, -100}}), iconTransformation(extent = {{-10, -120}, {10, -100}})));
        // Local variables
        Integer ud1[nI](start = ud_init) annotation(
          HideResult = true);
        Real ud2[nI] annotation(
          HideResult = true);
      initial equation
        ud_init = u;
      equation
        if cardinality(u_UL) == 0 then
          u_UL.latency = defaultLatency;
          u_UL.isWorking = defaultIsWorking;
        end if;
// Signal delay
        for i in 1:nI loop
          ud1[i] = if u_UL.isWorking then u[i] else pre(ud1[i]);
          ud2[i] = if u_UL.latency == 0 then ud1[i] else delay(ud1[i], u_UL.latency / 1000, maxDelay);
          y[i] = if ud2[i] > 0.0 then integer(floor(ud2[i] + 0.5)) else integer(ceil(ud2[i] - 0.5));
        end for;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false)));
      end IntegerTransmission;
    end Operators;

    package Tests "unitary tests for basic Components"

      model TestIntegerlTransmission
        Basic.Operators.IntegerTransmission integerTransmission(nI = 3) annotation(
          Placement(transformation(extent = {{-12, -4}, {28, 14}})));
        Modelica.Blocks.Sources.IntegerTable table(table = [0, 1; 1, 4; 3.5, 5; 4, -1]) annotation(
          Placement(transformation(extent = {{-62, -42}, {-42, -22}})));
        Modelica.Blocks.Sources.IntegerConstant const(k = 2) annotation(
          Placement(transformation(extent = {{-62, 28}, {-42, 48}})));
        Modelica.Blocks.Sources.IntegerStep step(startTime = 0.5, offset = 2) annotation(
          Placement(transformation(extent = {{-62, -4}, {-42, 16}})));
      equation
        connect(const.y, integerTransmission.u[1]) annotation(
          Line(points = {{-41, 38}, {-28, 38}, {-28, 3.8}, {-16, 3.8}}, color = {255, 127, 0}));
        connect(step.y, integerTransmission.u[2]) annotation(
          Line(points = {{-41, 6}, {-28, 6}, {-28, 5}, {-16, 5}}, color = {255, 127, 0}));
        connect(table.y, integerTransmission.u[3]) annotation(
          Line(points = {{-41, -32}, {-28, -32}, {-28, 6.2}, {-16, 6.2}}, color = {255, 127, 0}));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-60, 92}, {26, 64}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Validate transmission of integers with respect to their initial value:
- default latency is 20 ms (default value when no network is connected)

Recommended time interval is [0, 6]"), Text(extent = {{-22, -26}, {64, -54}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Expected results:
- no difference between const.y and integerTransmission.y[1]
- correct shifting between step.y and integerTransmission.y[2]
- correct shifting between table.y and integerTransmission.y[3]")}));
      end TestIntegerlTransmission;

      model TestBooleanTransmission
        Basic.Operators.BooleanTransmission booleanTransmission(nB = 2) annotation(
          Placement(transformation(extent = {{-12, -4}, {30, 14}})));
        Modelica.Blocks.Sources.BooleanConstant const(k = true) annotation(
          Placement(transformation(extent = {{-60, 26}, {-40, 46}})));
        Modelica.Blocks.Sources.BooleanPulse pulse(period = 2, startTime = 0) annotation(
          Placement(transformation(extent = {{-60, -30}, {-40, -10}})));
      equation
        connect(const.y, booleanTransmission.u[1]) annotation(
          Line(points = {{-39, 36}, {-28, 36}, {-28, 4.1}, {-16.2, 4.1}}, color = {255, 0, 255}));
        connect(pulse.y, booleanTransmission.u[2]) annotation(
          Line(points = {{-39, -20}, {-28, -20}, {-28, 5.9}, {-16.2, 5.9}}, color = {255, 0, 255}));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-60, 92}, {26, 64}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Validate transmission of Booleans with respect to their initial value
- default latency is 20 ms (default value when no network is connected)

Recommended time interval is [0, 6]"), Text(extent = {{-32, -30}, {54, -58}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Expected results:
- no difference between const.y and booleanTransmission.y[1]
- correct shifting between pulse.y and booleanTransmission.y[2]")}));
      end TestBooleanTransmission;

      model TestRealTransmission
        Basic.Operators.RealTransmission realTransmission(nR = 6) annotation(
          Placement(transformation(extent = {{-4, -10}, {34, 8}})));
        Modelica.Blocks.Sources.Sine sine(freqHz = 2, phase = 0.78539816339745) annotation(
          Placement(transformation(extent = {{-54, 2}, {-34, 22}})));
        Modelica.Blocks.Sources.Constant const(k = 1.5) annotation(
          Placement(transformation(extent = {{-98, 48}, {-78, 68}})));
        Modelica.Blocks.Sources.Ramp ramp(duration = 4) annotation(
          Placement(transformation(extent = {{-54, 32}, {-34, 52}})));
        Modelica.Blocks.Sources.Exponentials exponentials(riseTime = 3, startTime = 1, offset = 0.5) annotation(
          Placement(transformation(extent = {{-54, -30}, {-34, -10}})));
        Modelica.Blocks.Sources.Pulse pulse(period = 1, offset = 0.2) annotation(
          Placement(transformation(extent = {{-54, -60}, {-34, -40}})));
        Modelica.Blocks.Sources.Trapezoid trapezoid(falling = 0.1, period = 1.5) annotation(
          Placement(transformation(extent = {{-54, -92}, {-34, -72}})));
      equation
        connect(const.y, realTransmission.u[1]) annotation(
          Line(points = {{-77, 58}, {-20, 58}, {-20, -2.5}, {-7.8, -2.5}}, color = {0, 0, 127}));
        connect(ramp.y, realTransmission.u[2]) annotation(
          Line(points = {{-33, 42}, {-20, 42}, {-20, -1.9}, {-7.8, -1.9}}, color = {0, 0, 127}));
        connect(sine.y, realTransmission.u[3]) annotation(
          Line(points = {{-33, 12}, {-20, 12}, {-20, -1.3}, {-7.8, -1.3}}, color = {0, 0, 127}));
        connect(exponentials.y, realTransmission.u[4]) annotation(
          Line(points = {{-33, -20}, {-20, -20}, {-20, -0.7}, {-7.8, -0.7}}, color = {0, 0, 127}));
        connect(pulse.y, realTransmission.u[5]) annotation(
          Line(points = {{-33, -50}, {-20, -50}, {-20, -0.1}, {-7.8, -0.1}}, color = {0, 0, 127}));
        connect(trapezoid.y, realTransmission.u[6]) annotation(
          Line(points = {{-33, -82}, {-20, -82}, {-20, 0.5}, {-7.8, 0.5}}, color = {0, 0, 127}));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false), graphics = {Text(extent = {{-76, 92}, {10, 64}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Validate transmission of reals with respect to their initial value:
- default latency is 20 ms (default value when no network is connected)
- try no discretization (default value for parameter samplingPeriod in realTransmission)
and then with a sampling period (e.g. parameter samplingPeriod={10,10,10,10,10,10})

Recommended time interval is [0, 6]"), Text(extent = {{-14, -72}, {72, -100}}, lineColor = {0, 0, 0}, fontSize = 16, horizontalAlignment = TextAlignment.Left, textString = "Expected results:
- no difference between const.y and realTransmission.y[1]
- correct shifting between ramp.y and realTransmission.y[2]
- correct shifting between sin.y and realTransmission.y[3]
- correct shifting between exponentials.y and realTransmission.y[4]
- correct shifting between pulse.y and realTransmission.y[5]
- correct shifting between trapezoid.y and realTransmission.y[6]

- with discretization, the output signals are piecewise constant












          ")}));
      end TestRealTransmission;
    end Tests;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}),
      Documentation(info = "<html>
    <p><span style=\"font-family: MS Shell Dlg 2;\">This package contains basic TelSysPro components.</span></p>
    </html>"),
      Diagram(graphics = {Text(extent = {{116, 34}, {-114, 10}}, lineColor = {0, 0, 0}, fontSize = 17, textStyle = {TextStyle.Bold}, textString = "TelSysPro Basic Components")}));
  end Basic;

  package Interfaces "TelSysPro Interfaces"
    connector ToReceive = input Types.TelCoVars "System variables as input" annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward)}),
      Diagram(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward)}));
    connector ToSend = output Types.TelCoVars "System variables as output" annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward)}),
      Diagram(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward)}));
    annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, fillPattern = FillPattern.None, extent = {{-100, -100}, {100, 100}}, radius = 25.0), Polygon(origin = {20, 0}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-10.0, 70.0}, {10.0, 70.0}, {40.0, 20.0}, {80.0, 20.0}, {80.0, -20.0}, {40.0, -20.0}, {10.0, -70.0}, {-10.0, -70.0}}), Polygon(fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-100, 20}, {-60, 20}, {-30, 70}, {-10, 70}, {-10, -70}, {-30, -70}, {-60, -20}, {-100, -20}})}),
      Documentation(info = "<html>
        <p><span style=\"font-family: MS Shell Dlg 2;\">This package contains the input and output connectors required by TelSysPro.</span></p>
        <p>Each connector is composed with two system variables:</p>
<ul>
<li>Boolean 'isWorking' as Operating Mode</li>
<li>Integer 'latency' as Latency</li>
</ul>
</html>"),
      Diagram(graphics = {Text(extent = {{116, 34}, {-114, 10}}, lineColor = {0, 0, 0}, fontSize = 18, textStyle = {TextStyle.Bold}, textString = "TelSysPro Interfaces")}));
  end Interfaces;

  package Types "TelSysPro Types"
    record TelCoVars "System Variables to exchange"
      Boolean isWorking "Current operationg mode";
      Integer latency "Cuurent latency";
      annotation(
        Documentation(info = "<html>

</html>"));
    end TelCoVars;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, extent = {{-100, -100}, {100, 100}}, radius = 25, lineThickness = 0.5), Polygon(origin = {-12.167, -23}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{12.167, 65}, {14.167, 93}, {36.167, 89}, {24.167, 20}, {4.167, -30}, {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, -30}, {4.167, 20}, {12.167, 65}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Polygon(origin = {2.7403, 1.6673}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{49.2597, 22.3327}, {31.2597, 24.3327}, {7.2597, 18.3327}, {-26.7403, 10.3327}, {-46.7403, 14.3327}, {-48.7403, 6.3327}, {-32.7403, 0.3327}, {-6.7403, 4.3327}, {33.2597, 14.3327}, {49.2597, 14.3327}, {49.2597, 22.3327}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0})}),
      Documentation(info = "<html>
        <p><span style=\"font-family: MS Shell Dlg 2;\">This package defines the type to declare system varizbles.</span></p>
        <p>This type is a record composed with two parts:</p>
<ul>
<li>a Boolean</li>
<li>an Integer</li>
</ul></html>"),
      Diagram(graphics = {Text(extent = {{116, 34}, {-114, 10}}, lineColor = {0, 0, 0}, fontSize = 18, textStyle = {TextStyle.Bold}, textString = "TelSysPro Types")}));
  end Types;
  annotation(
    uses(Modelica(version = "3.2.2"), ThermoSysPro(version = "3.3")),
    Diagram(graphics = {Text(extent = {{116, 34}, {-114, 10}}, lineColor = {0, 0, 0}, fontSize = 18, textStyle = {TextStyle.Bold}, textString = "TelSysPro Library for Basic Modeling
of Telecom Networks")}),
    Icon(graphics = {Rectangle(lineColor = {128, 128, 128}, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25, lineThickness = 0.5), Text(extent = {{-120, -26}, {126, 30}}, lineColor = {128, 128, 128}, lineThickness = 0.5, textString = "TSP", fontName = "Century Gothic", textStyle = {TextStyle.Bold, TextStyle.Italic})}),
    Documentation(info = "<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">TelSysPro</span></b> is a Modelica library able to model telecommunication networks. This library is being developped and maintained by J.Ph. Tavella and A. Jardin at EDF R&amp;D Saclay Lab in the frame of the project SIMSE (2016-19). </p>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Copyright &copy; 2017-18, EDF</span></b> </p>
</html>"),
    version = "2");
end BooleanIssue;
