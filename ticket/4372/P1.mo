package P1
  model M1
    extends Modelica.Blocks.Interfaces.SISO;
    Boolean Flag = false;
    Real x = if Flag then u else 0;
  equation
    y = 0.5*x;
  end M1;

  model M2
    extends Modelica.Blocks.Interfaces.SISO;
    replaceable model Mx = P1.M1;
    Mx mx annotation(Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(mx.y, y) annotation(
      Line(points = {{9, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(u, mx.u) annotation(
      Line(points = {{-120, 0}, {-14, 0}}, color = {0, 0, 127}));
  end M2;


  model M3
    P1.M2 m2(redeclare model Mx=P1.M1(Flag=true)) annotation(Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step step1(startTime = 0.5)  annotation(Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(step1.y, m2.u) annotation(Line(points = {{-24, 0}, {-14, 0}}, color = {0, 0, 127}));
  end M3;
end P1;
