package testcase

model Test_005_RC
Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 1)  annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.Analog.Basic.Resistor resistor(R = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 1)  annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(resistor.p, constantVoltage.p) annotation(
    Line(points = {{-10, 40}, {-50, 40}, {-50, 20}, {-50, 20}, {-50, 20}}, color = {0, 0, 255}));
connect(resistor.n, capacitor.p) annotation(
    Line(points = {{-10, 20}, {-10, 20}, {-10, 10}, {-10, 10}}, color = {0, 0, 255}));
connect(capacitor.n, ground.p) annotation(
    Line(points = {{-10, -10}, {-50, -10}, {-50, -20}, {-50, -20}}, color = {0, 0, 255}));
connect(constantVoltage.n, ground.p) annotation(
    Line(points = {{-50, 0}, {-50, 0}, {-50, -20}, {-50, -20}}, color = {0, 0, 255}));
annotation(Diagram,
      experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-6, Interval = 0.002),
      __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,newInst",
      __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "impeuler"));end Test_005_RC;

end testcase;