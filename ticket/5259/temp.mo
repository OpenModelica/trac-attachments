package temp
  package Basic "TelSysPro Basic Components"
    package Operators "low level operators"
      model RealTransmission
        // Parameters
        parameter Integer samplingPeriod[nR] = zeros(nR) "sampling period (ms)";
        parameter Integer nR "number of Reals to transmit";
        parameter Real maxDelay = 1000 "maxDelay value required for OM";
        // Connectors
        Modelica.Blocks.Interfaces.RealOutput y[nR] annotation(
          Placement(transformation(extent = {{100, -10}, {120, 10}})));
        Modelica.Blocks.Interfaces.RealInput u[nR] annotation(
          Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
        Interfaces.ToReceive u_UL annotation(
          Placement(transformation(extent = {{-10, -120}, {10, -100}}), iconTransformation(extent = {{-10, -120}, {10, -100}})));
        // Local variables
        discrete Real ud1[nR] annotation(
          HideResult = true);
        Real ud2[nR] annotation(
          HideResult = true);
      
      equation
        if cardinality(u_UL) == 0 then
          u_UL.latency = 20;
          u_UL.isWorking = true;
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
          
        y[i] = if u_UL.latency == 0 then ud2[i] else delay(ud2[i], u_UL.latency / 1000);
          //y[i] = if u_UL.latency == 0 then ud2[i] else delay(ud2[i], u_UL.latency / 1000, maxDelay);
        end for;
        
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false)),
          Diagram(coordinateSystem(preserveAspectRatio = false)));
      end RealTransmission;


    end Operators;
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
end temp;
