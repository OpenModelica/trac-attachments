within ;
package MOS4

  connector PressureFlow "Pressure[mmHg] and Flow[ml/min]"
    Real pressure( final quantity="Pressure");//, final unit="mmHg");
    flow Real q( final quantity="Flow", final unit="ml/min") "flow";
    annotation (Documentation(revisions="<html>
<table>
<tr>
<td>Author:</td>
<td>Marek Matejak</td>
</tr>
<tr>
<td>Copyright:</td>
<td>In public domains</td>
</tr>
<tr>
<td>By:</td>
<td>Charles University, Prague, Czech Republic</td>
</tr>
<tr>
<td>Date of:</td>
<td>january 2009</td>
</tr>
</table>
</html>",
      info="<html>
<p><font style=\"font-size: 9pt; \">This connector connects hydraulic domains elements. The elements contains one equation for each his pressure-flow connector. The equation defines relation between variables in the connector. Variables are hydraulic pressure and volume flow of hydraulic medium. The pressure is the same in each connector that are connected together. The sum of flow in connectors connected together is zero (</font><b><font style=\"font-size: 9pt; \">Kirchhoff&apos;s circuit laws</font></b><font style=\"font-size: 9pt; \">).</font> </p>
</html>"));
  end PressureFlow;

  connector NegativePressureFlow "Pressure[mmHg] and negative Outflow[ml/min]"

    extends PressureFlow;

  annotation (
      defaultComponentName="q_out",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-20,10},{20,-10}},
            lineColor={0,0,0},
            lineThickness=1), Polygon(
            points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid,
            fillColor={200,200,200})}),
      Diagram(Polygon(points=[-21,-3; 5,23; 31,-3; 5,-29; -21,-3],   style(
            color=74,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})), Text(
          extent=[-105,-38; 115,-83],
          string="%name",
          style(color=0, rgbcolor={0,0,0}))));
  end NegativePressureFlow;

  connector PositivePressureFlow "Pressure[mmHg] and Inflow[ml/min]"
    extends PressureFlow;

  annotation (
      defaultComponentName="q_in",
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-20,10},{20,-10}},
            lineColor={0,0,0},
            lineThickness=1), Polygon(
            points={{0,100},{100,0},{0,-100},{-100,0},{0,100}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid,
            fillColor={0,0,0})}),
      Diagram(Polygon(points=[-21,-3; 5,23; 31,-3; 5,-29; -21,-3],   style(
            color=74,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})), Text(
          extent=[-105,-38; 115,-83],
          string="%name",
          style(color=0, rgbcolor={0,0,0}))));
  end PositivePressureFlow;

  model P
  parameter Real tlak = 0;
    NegativePressureFlow q_out 
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}),
          iconTransformation(extent={{-10,-10},{10,10}})));
  equation
    q_out.pressure = tlak;
    annotation (Icon(graphics={Rectangle(extent={{-80,60},{60,-40}}, lineColor={0,
                0,255}), Text(
            extent={{-80,66},{62,100}},
            lineColor={0,0,255},
            textString="Pzdroj"),
          Text(
            extent={{-76,-98},{56,-44}},
            lineColor={0,0,255},
            textString="%tlak")}));
  end P;

  model Odpor

    PositivePressureFlow q_in annotation (Placement(transformation(extent={{-90,-10},
              {-70,10}}), iconTransformation(extent={{-90,-10},{-70,10}})));
    NegativePressureFlow q_out annotation (Placement(transformation(extent={{70,-10},
              {90,10}}), iconTransformation(extent={{70,-10},{90,10}})));
  parameter Real R = 1;
  Real dp;
  equation
    q_in.q + q_out.q = 0;
    dp = q_out.pressure - q_in.pressure;
    dp = R*q_in.q;
    annotation (Icon(graphics={Rectangle(extent={{-60,20},{60,-20}}, lineColor={0,
                0,255})}));
  end Odpor;

  model chlopen
  Real s;
  Boolean off;
  Real dp;
    PositivePressureFlow q_in 
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    NegativePressureFlow q_out 
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  equation
  off = s <0;
  q_in.q = if off then 0 else s;
  dp = q_in.pressure - q_out.pressure;
  dp = if off then s else 0;
  q_in.q + q_out.q = 0;
    annotation (Icon(graphics={Polygon(
            points={{-60,60},{40,0},{-60,-60},{-60,-20},{-60,60}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{40,60},{60,-60}},
            lineColor={127,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid)}));
  end chlopen;

  model komora

    PositivePressureFlow q_in 
      annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
    Modelica.Blocks.Interfaces.RealInput elastance annotation (Placement(transformation(
            extent={{-60,-32},{-20,8}}), iconTransformation(extent={{-60,-32},{-20,
              8}})));
  parameter Real pExt = -4;
  Real volume;
  Real pTransmural;
  equation
    der(volume) = -q_in.q;
    pTransmural = volume*elastance;
    q_in.pressure - pExt = pTransmural;

    annotation (Diagram(graphics={Ellipse(
            extent={{-60,60},{60,-80}},
            lineColor={127,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid)}), Icon(graphics={Ellipse(
            extent={{-60,60},{60,-80}},
            lineColor={127,0,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid)}));
  end komora;

  model testHeartBeat
    P pZdroj annotation (Placement(transformation(extent={{-96,18},{-76,38}})));
    Odpor odporVstup 
      annotation (Placement(transformation(extent={{-66,18},{-46,38}})));
    chlopen chlopen1 
      annotation (Placement(transformation(extent={{-40,18},{-20,38}})));
    komora komora1 
      annotation (Placement(transformation(extent={{-20,42},{0,62}})));
    Odpor odporVystup 
      annotation (Placement(transformation(extent={{34,18},{54,38}})));
    P pOdtok(tlak=12) 
      annotation (Placement(transformation(extent={{68,18},{88,38}})));
    chlopen chlopen2 
      annotation (Placement(transformation(extent={{0,18},{20,38}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=1,
      freqHz=1,
      offset=1) 
      annotation (Placement(transformation(extent={{-76,54},{-56,74}})));
  equation
    connect(pZdroj.q_out, odporVstup.q_in) annotation (Line(
        points={{-86,28},{-64,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(odporVstup.q_out, chlopen1.q_in) annotation (Line(
        points={{-48,28},{-38,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(odporVystup.q_out, pOdtok.q_out) annotation (Line(
        points={{52,28},{78,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(chlopen2.q_out, odporVystup.q_in) annotation (Line(
        points={{18,28},{36,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(chlopen1.q_out, chlopen2.q_in) annotation (Line(
        points={{-22,28},{2,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(komora1.q_in, chlopen2.q_in) annotation (Line(
        points={{-10,44},{-10,28},{2,28}},
        color={0,0,0},
        thickness=1,
        smooth=Smooth.None));
    connect(sine.y, komora1.elastance) annotation (Line(
        points={{-55,64},{-34,64},{-34,50.8},{-14,50.8}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(graphics));
  end testHeartBeat;
  annotation (uses(Modelica(version="3.1")));
end MOS4;
