model DiodeTest
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(visible=true, fillPattern=FillPattern.Solid, extent={{-100,-150},{100,-110}}, textString="%name")}), Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor1 annotation(Placement(visible=true, transformation(x=-96.1871, y=54.5703, scale=0.075)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1 annotation(Placement(visible=true, transformation(x=-73.3116, y=54.5703, scale=0.075)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible=true, transformation(x=-73.036, y=2.48046, scale=0.075)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1 annotation(Placement(visible=true, transformation(x=-65.319, y=18.7413, scale=0.075)));
  Modelica.Electrical.Analog.Basic.Conductor conductor2 annotation(Placement(visible=true, transformation(x=-51.5386, y=54.5703, scale=0.075)));

equation 
  connect(idealDiode1.n,conductor2.p) annotation(Line(visible=true, points={{-65.81,54.57},{-59.04,54.57}}));
  connect(sineVoltage1.n,conductor2.n) annotation(Line(visible=true, points={{-57.82,18.74},{-44.1,18.74},{-44.04,54.57}}));
  connect(ground1.p,sineVoltage1.p) annotation(Line(visible=true, points={{-73.04,9.98},{-72.82,18.74}}));
  connect(sineVoltage1.p,conductor1.p) annotation(Line(visible=true, points={{-72.82,18.74},{-103.7,19.02},{-103.7,54.57}}));
  connect(idealDiode1.p,conductor1.n) annotation(Line(visible=true, points={{-80.81,54.57},{-88.69,54.57}}));
end DiodeTest;

