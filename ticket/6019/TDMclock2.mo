model TDMclock2 "Digital clocked multiplexer index generator"
  import SI = Modelica.SIunits;
  parameter Integer nr_channels(final min=1) = 6;
  parameter SI.Time period(
    final min=Modelica.Constants.small)=0.09 "Time for one period";
  Modelica.Blocks.Interfaces.IntegerOutput y( min=1,max=nr_channels, start = 1) "Connector of Digital output signal"
                annotation (Placement(transformation(extent={{90,-10},{110,
            10}})));
   discrete Integer increment;
   Clock cSample=Clock(period);
equation
  increment = sample(1,Clock(period));
  y = if (time == 0 or previous(y)==nr_channels) then 1 else previous(y) + increment;
  annotation (Documentation(info="<html>
<p>
The clock source generates an incrementing index number
The number of periods is unlimited. The first pulse starts at startTime.
</p>
<p> The clock source is a special but often used variant of the pulse source.
</p>
</html>", revisions="<html>
<dl>
Based on 'Clock' library module by Andre Schneider
<dt><em>June 9, 2020</em></dt>
<dd>by Paul van der Hulst.</dd>
</dl>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
        100,100}}), graphics={
    Rectangle(
      extent={{-50,100},{50,-100}},
      lineThickness=0.5,
      fillColor={213,255,170},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{152,-160},{-148,-100}},
      lineColor={0,0,255},
      textString="%name"),
    Line(points={{50,0},{90,0}}, color={127,0,127}),
    Line(points={{-36,80},{-30,80},{-30,40},{-18,40},{-18,50},{-6,50},{
          -6,60},{6,60},{6,70},{18,70},{18,80},{30,80},{30,40},{36,40}})}));
end TDMclock2;
