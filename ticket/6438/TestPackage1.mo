package  TestPackage
  model Test
    Modelica.Blocks.Sources.Step step annotation(
      Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MyModel myModel annotation(
      Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(myModel.u, step.y) annotation(
      Line(points = {{10, 0}, {-26, 0}}, color = {0, 0, 127}));
  end Test;
  
  model MyModel
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-106, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-106, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(firstOrder.u, u) annotation(
      Line(points = {{-12, 0}, {-106, 0}}, color = {0, 0, 127}));
    connect(y, firstOrder.y) annotation(
      Line(points = {{108, 0}, {12, 0}}, color = {0, 0, 127}));
  
  annotation(
      uses(Modelica(version = "3.2.3")));
  end MyModel;
equation

annotation(
    uses(Modelica(version = "3.2.3")));
end TestPackage;
