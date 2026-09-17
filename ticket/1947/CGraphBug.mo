within ;
package CGraphBug
  model TopModel

    SubModel1 subModel1
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Mechanics.MultiBody.Parts.Body mass(
      animation=false,
      m=1,
      I_11=1,
      I_22=1,
      I_33=1,
      r_CM={0,0,0},
      r_0(start={0,0,0}))
                annotation (Placement(transformation(extent={{60,0},{80,20}})));
    inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false)
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  equation
    connect(subModel1.frame_a, mass.frame_a) annotation (Line(
        points={{-40,10},{60,10}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end TopModel;

  model SubModel1
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
      annotation (Placement(transformation(extent={{84,-16},{116,16}})));
    outer Modelica.Mechanics.MultiBody.World world
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  equation
    connect(world.frame_b, frame_a) annotation (Line(
        points={{-40,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Text(
            extent={{-88,54},{78,-16}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Submodel 1")}));
  end SubModel1;
  annotation (uses(Modelica(version="3.2")));
end CGraphBug;
