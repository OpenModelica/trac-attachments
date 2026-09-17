within ;
model testcase
  Modelica.Mechanics.Translational.Sources.Position position1(
                                                             exact = false, f_crit = 1000,
    v(fixed=true))                                                                         annotation(Placement(transformation(extent={{2,-10},
            {22,10}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(
                                              table = [0,0;1,20;2,25;3,28;5,15]) annotation(Placement(transformation(extent={{-78,-10},
            {-58,10}})));
  Modelica.Blocks.Math.Gain gain1(
                                 k = 0.001) annotation(Placement(transformation(extent={{-38,-10},
            {-18,10}})));
  test test1 annotation (Placement(transformation(extent={{36,-10},{56,10}})));
equation
  connect(gain1.y,position1. s_ref)
                                 annotation(Line(points={{-17,0},{0,0}},    color = {0,0,127}, smooth = Smooth.None));
  connect(timeTable1.y,gain1. u)
                              annotation(Line(points={{-57,0},{-40,0}},   color = {0,0,127}, smooth = Smooth.None));
  connect(position1.flange, test1.flange_a) annotation (Line(
      points={{22,0},{36,0}},
      color={0,127,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics), uses(Modelica(version="3.2")));
end testcase;
