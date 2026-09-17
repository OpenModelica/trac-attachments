model M
  model Polygon
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Polygon(
            points={{-98,90},{-94,96},{-84,98},{84,98},{96,96},{100,92},{98,86},
                {94,80},{94,80},{94,-92},{94,-92},{94,-96},{92,-100},{88,-100},{
                84,-100},{-84,-100},{-88,-100},{-92,-100},{-94,-96},{-94,-92},{-94,
                24},{-94,78},{-94,80},{-98,90}},
            lineColor={127,0,127},
            smooth=Smooth.Bezier,
            pattern=LinePattern.Dot,
            thickness=0.5)}));
  end Polygon;
  model ClosedLine
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Line(
            points={{-98,90},{-94,96},{-84,98},{84,98},{96,96},{100,92},{98,86},
                {94,80},{94,80},{94,-92},{94,-92},{94,-96},{92,-100},{88,-100},{
                84,-100},{-84,-100},{-88,-100},{-92,-100},{-94,-96},{-94,-92},{-94,
                24},{-94,78},{-94,80},{-98,90}},
            color={127,0,127},
            smooth=Smooth.Bezier,
            pattern=LinePattern.Dot,
            thickness=0.5)}));
  end ClosedLine;
  model RectangleNone
    annotation (Icon(graphics={Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            extent={{-100,100},{100,-100}})}));
  end RectangleNone;
  model RectangleSolid
    annotation (Icon(graphics={Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-100,100},{100,-100}})}));
  end RectangleSolid;
  Modelica.Blocks.Math.Gain gain2
    annotation (Placement(visible = true, transformation(extent = {{40, 40}, {60, 60}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1
    annotation (Placement(visible = true, transformation(extent = {{-60, 40}, {-40, 60}}, rotation = 0)));
  M.Polygon polygon
    annotation (Placement(visible = true, transformation(extent = {{-80, 20}, {-20, 80}}, rotation = 0)));
  M.ClosedLine closedLine
    annotation (Placement(visible = true, transformation(extent = {{20, 20}, {80, 80}}, rotation = 0)));
  M.RectangleNone rectangleNone
    annotation (Placement(visible = true, transformation(origin = {-48.5, -49.5}, extent = {{-28.5, -28.5}, {28.5, 28.5}}, rotation = 0)));
  M.RectangleSolid rectangleSolid
    annotation (Placement(visible = true, transformation(origin = {50.5, -50.5}, extent = {{-29.5, -29.5}, {29.5, 29.5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3
    annotation (Placement(visible = true, transformation(extent = {{-60, -60}, {-40, -40}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain4
    annotation (Placement(visible = true, transformation(extent = {{38, -60}, {58, -40}}, rotation = 0)));
  annotation (uses(Modelica(version="3.2.2")));
end M;