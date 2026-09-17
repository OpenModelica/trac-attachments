package TestPkg
  model SimpleDriver
    parameter String CycleFileName = "MyCycleName.txt" "Drive Cycle Name ex: \"sort1.txt\"";
    parameter Real k "Controller gain";
    parameter Modelica.SIunits.Time T "Controller Integral part time constant";
    parameter Real yMax = 1000000.0 "Max output value (absolute)";
    Modelica.Blocks.Interfaces.RealOutput Tref annotation(Placement(transformation(extent = {{100,40},{120,60}}), iconTransformation(extent = {{100,50},{120,70}})));
    Modelica.Blocks.Sources.CombiTimeTable DriveCyc(tableOnFile = true, tableName = "Cycle", extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = CycleFileName, columns = {2}) annotation(Placement(transformation(extent = {{-86,40},{-66,60}})));
    Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh annotation(Placement(transformation(extent = {{-48,40},{-28,60}})));
    Modelica.Blocks.Continuous.LimPID PID(k = k, Ti = T, Td = 1000000.0, yMax = yMax) annotation(Placement(transformation(extent = {{0,40},{20,60}})));
    Modelica.Blocks.Interfaces.RealInput V annotation(Placement(visible = true, transformation(origin = {0,-114}, extent = {{14,-14},{-14,14}}, rotation = 90), iconTransformation(origin = {0,-112}, extent = {{12,-12},{-12,12}}, rotation = 90)));
  equation
    connect(from_kmh.u,DriveCyc.y[1]) annotation(Line(points = {{-50,50},{-65,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(V,PID.u_m) annotation(Line(points = {{0.00000000000000177636,-114},{0.00000000000000177636,30},{10,30},{10,38}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PID.u_s,from_kmh.y) annotation(Line(points = {{-2,50},{-27,50}}, color = {0,0,127}, smooth = Smooth.None));
    connect(PID.y,Tref) annotation(Line(points = {{21,50},{110,50}}, color = {0,0,127}, smooth = Smooth.None));
    annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {95,95,95}, fillPattern = FillPattern.Solid, fillColor = {255,255,255}),Polygon(points = {{-50,-60},{-50,20},{0,20},{0,-60},{2,-60},{-50,-60}}, lineColor = {95,95,95}, smooth = Smooth.None),Rectangle(extent = {{-34,32},{-16,20}}, lineColor = {95,95,95}),Polygon(points = {{-12,14},{-20,8},{-12,-2},{48,-6},{54,8},{-12,14}}, lineColor = {95,95,95}, smooth = Smooth.None),Polygon(points = {{-16,-44},{76,-56},{80,-90},{64,-88},{62,-68},{-16,-52},{-16,-44}}, lineColor = {95,95,95}, smooth = Smooth.None),Text(extent = {{-90,126},{88,112}}, lineColor = {0,0,255}, textString = "%name"),Ellipse(extent = {{-44,62},{-6,30}}, lineColor = {95,95,95}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>Modello semplice di pilota.</p>
<p>Esso contiene al suo interno il ciclo di riferimento, che insegue attraverso un regolatore PI.</p>
</html>"));
  end SimpleDriver;
  model TestLoadCycle2
    Modelica.Blocks.Sources.Constant const annotation(Placement(visible = true, transformation(origin = {-40.6114,-36.2445}, extent = {{-12,-12},{12,12}}, rotation = 0)));
    SimpleDriver simpledriver1(CycleFileName = "Sort1.txt", k = 1, T = 1) annotation(Placement(visible = true, transformation(origin = {-14.4105,17.9039}, extent = {{-12,-12},{12,12}}, rotation = 0)));
  equation
    connect(const.y,simpledriver1.V) annotation(Line(points = {{-27.4114,-36.2445},{-14.4105,-36.2445},{-14.4105,4.80349},{-14.4105,4.80349},{-14.4105,4.22393}}));
  end TestLoadCycle2;
end TestPkg;

