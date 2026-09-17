model DiodeTest
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Text(visible=true, fillPattern=FillPattern.Solid, extent={{-100,-150},{100,-110}}, textString="%name")}), Diagram(coordinateSystem(extent={{-148.5,-105},{148.5,105}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor1 annotation(Placement(visible=true, transformation(x=-96.1871, y=54.5703, scale=0.075)));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1 annotation(Placement(visible=true, transformation(x=-73.3116, y=54.5703, scale=0.075)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(visible=true, transformation(x=-82.4067, y=4.13411, scale=0.075)));
  Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent1 annotation(Placement(visible=true, transformation(x=-74.6896, y=32.7973, scale=0.075)));
  Modelica.Electrical.Analog.Basic.Conductor conductor2 annotation(Placement(visible=true, transformation(x=-51.263, y=54.2947, scale=0.075)));

equation 
  connect(sineCurrent1.n,conductor2.n) annotation(Line(visible=true, points={{-67.19,32.8},{-43.54,33.07},{-43.76,54.29}}));
  connect(idealDiode1.n,conductor2.p) annotation(Line(visible=true, points={{-65.81,54.57},{-58.76,54.29}}));
  connect(sineCurrent1.p,ground1.p) annotation(Line(visible=true, points={{-82.19,32.8},{-82.41,11.63}}));
  connect(conductor1.p,sineCurrent1.p) annotation(Line(visible=true, points={{-103.7,54.57},{-103.9,33.15},{-82.19,32.8}}));
  connect(idealDiode1.p,conductor1.n) annotation(Line(visible=true, points={{-80.81,54.57},{-88.69,54.57}}));
end DiodeTest;

