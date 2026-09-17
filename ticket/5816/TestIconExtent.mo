within ;
package TestIconExtent

  model M0
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-240,-100},{240,100}},
          initialScale=0.1), graphics={Rectangle(extent={{-240,100},{240,-100}})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-240,-100},{240,100}},
          initialScale=0.1)));

  end M0;

  model M01
    extends TestIconExtent.M0;
  end M01;

  model M02
    extends TestIconExtent.M0;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-240, -100}, {240, 100}})));
  end M02;

  model M1
    M0 m0 annotation (Placement(transformation(extent={{-482,-248},{364,74}})));
    annotation (Diagram(coordinateSystem(extent={{-580,-300},{520,300}})),
        Icon(coordinateSystem(extent = {{-400, -180}, {400, 300}}, initialScale = 0.1,preserveAspectRatio=false),
         graphics={  Rectangle(origin = {0, 78}, extent = {{-400, 222}, {400, -258}})}));
  end M1;

  model M11
    M01 m0 annotation (Placement(transformation(extent={{-482,-248},{364,74}})));
    annotation (Diagram(coordinateSystem(extent={{-580,-300},{520,300}})),
        Icon(coordinateSystem(extent = {{-400, -180}, {400, 300}}, initialScale = 0.1), graphics={  Rectangle(origin = {0, 78}, extent = {{-400, 222}, {400, -258}})}));
  end M11;

  model M12
    M02 m0 annotation (Placement(transformation(extent={{-482,-248},{364,74}})));
    annotation (Diagram(coordinateSystem(extent={{-580,-300},{520,300}})),
        Icon(coordinateSystem(extent = {{-400, -180}, {400, 300}}, initialScale = 0.1), graphics={  Rectangle(origin = {0, 78}, extent = {{-400, 222}, {400, -258}})}));
  end M12;

  model M2
    TestIconExtent.M1 m1_1
      annotation (Placement(visible = true, transformation(origin={152,-282.85},        extent={{-310,
              -97.71},{310,162.85}},                                                                                                       rotation = 0)));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(extent = {{-540, -480}, {650, 480}}, initialScale = 0.1), graphics={Rectangle(origin = {-6, 6}, lineColor = {28, 108, 200}, extent = {{-174, -106}, {486, -404}})}));
  end M2;
end TestIconExtent;
