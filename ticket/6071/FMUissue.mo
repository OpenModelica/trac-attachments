package FMUissue
  model Gain
  parameter Real K=2 "Guadagno";
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = K)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(gain1.y, y) annotation(
      Line(points = {{12, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(gain1.u, u) annotation(
      Line(points = {{-12, 0}, {-106, 0}, {-106, 0}, {-118, 0}}, color = {0, 0, 127}));
  end Gain;
  
  model Test
    Modelica.Blocks.Sources.RealExpression realExpression(y = 1)  annotation(
      Placement(visible = true, transformation(origin = {-54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  FMUissue_Gain_me_FMU fMUissue_Gain_me_FMU(gain1_k = 4)  annotation(
      Placement(visible = true, transformation(origin = {-8, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fMUissue_Gain_me_FMU.u, realExpression.y) annotation(
      Line(points = {{-18, 0}, {-44, 0}, {-44, 0}, {-42, 0}}, color = {0, 0, 127}));
  protected
  annotation(
      uses(Modelica(version = "3.2.3")),
      Diagram);
  end Test;
  annotation(
    uses(Modelica(version = "3.2.3")));
end FMUissue;
