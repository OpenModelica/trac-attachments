within ;
model PULSER
  Modelica.Blocks.Interfaces.RealInput ampl annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 44}, {-100, 84}})));
  Modelica.Blocks.Interfaces.RealInput ph_deg annotation(Placement(transformation(extent = {{-138, -76}, {-98, -36}}), iconTransformation(extent = {{-140, -74}, {-100, -34}})));
  Modelica.Blocks.Interfaces.BooleanOutput up annotation(Placement(transformation(extent = {{100, 10}, {120, 30}}), iconTransformation(extent = {{100, 56}, {120, 76}})));
  Modelica.Blocks.Interfaces.BooleanOutput down annotation(Placement(transformation(extent = {{100, -62}, {120, -42}}), iconTransformation(extent = {{100, -68}, {120, -48}})));
equation

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})), Icon(graphics={  Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {0, 0, 127}, extent = {{-100, 88}, {-42, 60}}, textString = "inp1"), Text(lineColor = {0, 0, 127}, extent = {{-98, -62}, {-28, -88}}, textString = "inp2"), Text(lineColor = {255, 0, 255}, extent = {{28, 86}, {100, 60}}, textString = "out1"), Text(lineColor = {255, 0, 255}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                    FillPattern.Solid, extent = {{42, -62}, {96, -88}}, textString = "out2"),
        Text(
          extent={{-41,28},{41,-28}},
          lineColor={0,0,0},
          origin={-9,6},
          rotation=90,
          textString="Text")},                                                                                                    coordinateSystem(extent={{-100,
            -100},{100,100}},                                                                                                    preserveAspectRatio=false,  initialScale = 0.1, grid = {2, 2})),
    uses(Modelica(version="3.2.1")));
end PULSER;
