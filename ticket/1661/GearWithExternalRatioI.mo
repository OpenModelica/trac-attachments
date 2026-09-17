model GearWithExternalRatioI
  Modelica.Mechanics.Rotational.Interfaces.Flange_a fla annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flb annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerInput ratio annotation(Placement(visible = true, transformation(origin = {0,100}, extent = {{-10,10},{10,-10}}, rotation = -90), iconTransformation(origin = {0,100}, extent = {{-10,10},{10,-10}}, rotation = -90)));
  annotation(Icon(graphics = {Rectangle(rotation = 0, lineColor = {0,0,0}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-98.3655,98.9599},{99.8514,-99.2571}}),Ellipse(rotation = 0, lineColor = {0,0,0}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-44.5765,16.6419},{-10.9955,-15.156}}),Ellipse(rotation = 0, lineColor = {0,0,0}, fillColor = {0,0,0}, pattern = LinePattern.Solid, fillPattern = FillPattern.None, lineThickness = 0.25, extent = {{-6.24071,39.5245},{66.5676,-37.7415}}),Line(points = {{-98.3655,0.297177},{99.8514,0.594354},{99.8514,-0.297177},{99.8514,-0.297177}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25, smooth = Smooth.Bezier),Line(points = {{-0.297177,98.3655},{-0.297177,25.8544},{-0.594354,25.8544}}, rotation = 0, color = {0,0,0}, pattern = LinePattern.Solid, thickness = 0.25, smooth = Smooth.Bezier)}));
equation
  fla.tau = -flb.tau / ratio;
  fla.phi = ratio * flb.phi;
end GearWithExternalRatioI;

