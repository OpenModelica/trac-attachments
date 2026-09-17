package P
  package Components
    model PropDriver
      annotation(Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-100, 100}, {100, -100}}), Ellipse(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}), Diagram);
    end PropDriver;
    annotation(Icon, Diagram);
  end Components;

  package DO
    package P
      annotation(Icon, Diagram);
    end P;

    model ThreeLosses
      P.Components.PropDriver propdriver1 annotation(Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      annotation(Icon, Diagram);
    end ThreeLosses;
    annotation(Icon, Diagram);
  end DO;
  annotation(Icon, Diagram);
end P;