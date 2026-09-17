model CableReel
  DC_Mechlib_SB.Components.Rotatory.CableReel cableReel(wh = 0.001) annotation(Placement(transformation(extent = {{-4,-8},{16,12}})));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 0, origin = {-84,84})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {-14,-100})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {32,-100})));
  DC_Mechlib_SB.Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-82,30},{-62,50}})));
  DC_Mechlib_SB.Components.Rotatory.TorqueVariable torqueVariable annotation(Placement(transformation(extent = {{-36,30},{-16,50}})));
  DC_Mechlib_SB.Components.Linear.Clamp clamp1 annotation(Placement(transformation(extent = {{-84,-62},{-64,-42}})));
  DC_Mechlib_SB.Components.Linear.Clamp clamp2 annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {70,-54})));
  DC_Mechlib_SB.Components.Linear.ForceVariable forceVariable annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {-16,-52})));
  DC_Mechlib_SB.Components.Linear.ForceVariable forceVariable1 annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 180, origin = {32,-54})));
equation
  connect(clamp.flange_b,torqueVariable.flange_a) annotation(Line(points = {{-62,40},{-36,40}}, color = {0,0,0}, smooth = Smooth.None));
  connect(torqueVariable.flange_b,cableReel.flange_b) annotation(Line(points = {{-16,40},{-6,40},{-6,12},{6,12}}, color = {0,0,0}, smooth = Smooth.None));
  connect(u,torqueVariable.u) annotation(Line(points = {{-84,84},{-26,84},{-26,70},{-26,70},{-26,50},{-26,50}}, color = {0,0,127}, smooth = Smooth.None));
  connect(u1,forceVariable.f) annotation(Line(points = {{-14,-100},{-16,-100},{-16,-62}}, color = {0,0,127}, smooth = Smooth.None));
  connect(u2,forceVariable1.f) annotation(Line(points = {{32,-100},{32,-64}}, color = {0,0,127}, smooth = Smooth.None));
  connect(forceVariable1.flange_b,clamp2.flange) annotation(Line(points = {{42,-54},{60,-54}}, color = {0,127,0}, smooth = Smooth.None));
  connect(forceVariable.flange_a,clamp1.flange) annotation(Line(points = {{-26,-52},{-64,-52}}, color = {0,127,0}, smooth = Smooth.None));
  connect(forceVariable.flange_b,cableReel.flange_a) annotation(Line(points = {{-6,-52},{-4,-52},{-4,-8},{0,-8}}, color = {0,127,0}, smooth = Smooth.None));
  connect(forceVariable1.flange_a,cableReel.flange_b1) annotation(Line(points = {{22,-54},{18,-54},{18,-8},{12,-8}}, color = {0,127,0}, smooth = Smooth.None));
  annotation(uses(Modelica(version = "3.2")), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end CableReel;

