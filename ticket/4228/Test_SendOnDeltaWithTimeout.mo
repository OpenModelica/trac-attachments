package Test_SendOnDeltaWithTimeout
  model TriggerByDeltaAndTimeout
    parameter Real Delta = 0.01 "SOD threshold";
    parameter Real TOq = 0.01 "timeout quantum";
    parameter Real TOmul[:] = {5, 10, 20, 50, 100, 20, 500} "timeout multipliers";
  protected
    final parameter Integer N = size(TOmul, 1);
    Integer dex;
    Real tlast, ulast;
  public
    Modelica.Blocks.Interfaces.BooleanOutput trig annotation(
      Placement(visible = true, transformation(origin = {152, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-94, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  algorithm
    when pre(dex) == 1 and time - tlast > TOq * TOmul[pre(dex)] or pre(dex) > 1 and (abs(u - ulast) > Delta or time - tlast > TOq * TOmul[pre(dex)]) then
      if time - tlast > TOq * TOmul[pre(dex)] then
        dex := min(pre(dex) + 1, N);
      else
        dex := 1;
      end if;
      trig := not trig;
      tlast := time;
      ulast := u;
    end when;
  initial algorithm
    trig := false;
    dex := 1;
    tlast := time;
    ulast := u;
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(graphics = {Rectangle(fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-2, -7}, extent = {{-52, 47}, {52, -47}}, textString = "SOD\n+TO")}));
  end TriggerByDeltaAndTimeout;

  model Test_TriggerByDeltaAndTimeout
    Modelica.Blocks.Sources.RealExpression IN(y = sin(time)) annotation(
      Placement(visible = true, transformation(origin = {-120, -1.42109e-14}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Test_SendOnDeltaWithTimeout.TriggerByDeltaAndTimeout T annotation(
      Placement(visible = true, transformation(origin = {1, -1}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
  equation
    connect(IN.y, T.u) annotation(
      Line(points = {{-76, 0}, {-44, 0}, {-44, 0}, {-40, 0}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end Test_TriggerByDeltaAndTimeout;
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  uses(Modelica(version = "3.2.2")));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end Test_SendOnDeltaWithTimeout;