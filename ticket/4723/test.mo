model test
  model M0
    annotation (Icon(graphics={Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-40,200},{40,-200}})}));
  end M0;

  model M1
    annotation (Icon(coordinateSystem(extent={{-40,-100},{40,100}}), graphics={
            Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-40,200},{40,-200}})}));
  end M1;

  model M2
    annotation (Icon(coordinateSystem(extent={{-100,-40},{100,40}}), graphics={
            Rectangle(
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-200,40},{200,-40}})}));
  end M2;

  model M12
    extends M1;
    extends M2;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics
          ={Rectangle(lineColor={255,0,0}, extent={{-100,100},{100,-100}})}));
  end M12;

  model M21
    extends M2;
    extends M1;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics
          ={Rectangle(lineColor={255,0,0}, extent={{-100,100},{100,-100}})}));
  end M21;

  model N12
    extends M1;
    extends M2;
    annotation (Icon(coordinateSystem(extent={{-200,-200},{200,200}}), graphics
          ={Rectangle(lineColor={255,0,0}, extent={{-200,200},{200,-200}})}));
  end N12;

  model N21
    extends M2;
    extends M1;
    annotation (Icon(coordinateSystem(extent={{-200,-200},{200,200}}), graphics
          ={Rectangle(lineColor={255,0,0}, extent={{-200,200},{200,-200}})}));
  end N21;

  model O12
    extends M1;
    extends M2;
    annotation (Icon(graphics={Rectangle(lineColor={255,0,0}, extent={{-40,-100},
                {40,100}})}));
  end O12;

  model O21
    extends M2;
    extends M1;
    annotation (Icon(graphics={Rectangle(lineColor={255,0,0}, extent={{-100,-40},
                {100,40}})}));
  end O21;

  model O02
    extends M0;
    extends M2;
    annotation (Icon(graphics={Rectangle(lineColor={255,0,0}, extent={{-100,-100},
                {100,100}})}));
  end O02;

  model O20
    extends M2;
    extends M0;
    annotation (Icon(graphics={Rectangle(lineColor={255,0,0}, extent={{-100,-40},
                {100,40}})}));
  end O20;

  connector Flange
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics
          ={Rectangle(extent={{-100,-100},{100,100}}, lineColor={255,0,0})}));
  end Flange;

  model A
    Flange f1
      annotation (Placement(transformation(extent={{-200,-150},{-180,-130}})));
    Flange f2
      annotation (Placement(transformation(extent={{180,-150},{200,-130}})));
    annotation (Documentation(info="<html>Help for A</html>"), Icon(
          coordinateSystem(extent={{-200,-200},{200,200}}), graphics={Rectangle(
            extent={{-200,-200},{200,200}},
            fillColor={255,255,191},
            fillPattern=FillPattern.Solid), Rectangle(extent={{-100,-100},{100,100}},
              lineColor={127,127,0})}));
  end A;

  model B
    extends A annotation (Documentation(info="<html>Help for B</html>"), Icon(
          graphics={Rectangle(extent={{-90,-90},{90,90}}, lineColor={0,255,0})}));
  end B;

  model A1
    Flange f1
      annotation (Placement(transformation(extent={{-200,-150},{-180,-130}})));
    annotation (Documentation(info="<html>Help for A1</html>"), Icon(
          coordinateSystem(extent={{-200,-200},{200,200}}), graphics={Rectangle(
            extent={{-200,-200},{200,200}},
            fillColor={191,255,255},
            fillPattern=FillPattern.Solid), Rectangle(extent={{-110,-110},{110,110}},
              lineColor={0,127,127})}));
  end A1;

  model A2
    Flange f2
      annotation (Placement(transformation(extent={{180,-150},{200,-130}})));
    annotation (Documentation(info="<html>Help for A2</html>"), Icon(
          coordinateSystem(extent={{-314,-159},{265,359}}), graphics={Rectangle(
            extent={{-314,-159},{265,359}},
            fillColor={191,191,255},
            fillPattern=FillPattern.Solid), Rectangle(extent={{-100,-100},{100,100}},
              lineColor={0,0,255})}));
  end A2;

  model C
    extends A1;
    extends A2;
    annotation (Documentation(info="<html>Help for C</html>"), Icon(graphics={
            Rectangle(extent={{-90,-90},{90,90}}, lineColor={127,0,127})}));
  end C;

  model A3
    Flange f1
      annotation (Placement(transformation(extent={{-200,-150},{-180,-130}})));
    Flange f2
      annotation (Placement(transformation(extent={{180,-150},{200,-130}})));
    annotation (Documentation(info="<html>Help for A</html>"), Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}),
          graphics={Rectangle(
            extent={{-200,-200},{200,200}},
            fillColor={255,255,191},
            fillPattern=FillPattern.Solid), Rectangle(extent={{-100,-100},{100,100}},
              lineColor={127,127,0})}));
  end A3;

  model D1
    extends A annotation (IconMap(extent={{-200,-100},{200,100}},
          primitivesVisible=false), DiagramMap(extent={{-50,-50},{0,0}},
          primitivesVisible=true));
    annotation (Icon(graphics={Rectangle(extent={{-200,-200},{200,200}},
              lineColor={255,0,0})}));
  end D1;

  model D2
    extends A annotation (IconMap(extent={{-200,-100},{200,100}},
          primitivesVisible=true), DiagramMap(extent={{-50,-50},{0,0}},
          primitivesVisible=false));
    annotation (Icon(graphics={Rectangle(extent={{-200,-200},{200,200}},
              lineColor={255,0,0})}));
  end D2;

  model D3
    extends A3 annotation (IconMap(extent={{-200,-100},{200,100}},
          primitivesVisible=true), DiagramMap(extent={{-50,-50},{0,0}},
          primitivesVisible=false));
    annotation (Icon(graphics={Rectangle(extent={{-200,-200},{200,200}},
              lineColor={255,0,0})}));
  end D3;
  M12 m12_1 annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  M21 m21_1 annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  O12 o12_1 annotation (Placement(transformation(extent={{-74,-20},{-66,0}})));
  O21 o21_1 annotation (Placement(transformation(extent={{-40,-14},{-20,-6}})));
  N12 n12_1 annotation (Placement(transformation(extent={{-90,10},{-50,50}})));
  N21 n21_1 annotation (Placement(transformation(extent={{-50,10},{-10,50}})));
  O02 o02_1 annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  O20 o20_1 annotation (Placement(transformation(extent={{-40,-54},{-20,-46}})));
  Flange flange annotation (Placement(transformation(extent={{20,60},{40,80}})));
  A a annotation (Placement(transformation(extent={{50,50},{90,90}})));
  B b annotation (Placement(transformation(extent={{50,10},{90,50}})));
  A1 a1_1 annotation (Placement(transformation(extent={{10,10},{50,50}})));
  A2 a2_1 annotation (Placement(transformation(extent={{-0.37,-45.9614},{55.63,6.0386}})));
  C c annotation (Placement(transformation(extent={{70,-50},{110,-10}})));
  D1 d1 annotation (Placement(transformation(extent={{-20,-100},{20,-60}})));
  D2 d2 annotation (Placement(transformation(extent={{20,-100},{60,-60}})));
  D3 d3 annotation (Placement(transformation(extent={{60,-100},{100,-60}})));
end test;
