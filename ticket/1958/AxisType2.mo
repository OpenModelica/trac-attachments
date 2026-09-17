within ;
model AxisType2 "Axis model of the r3 joints 4,5,6 "

  Controller                    controller
                 annotation (Placement(transformation(extent={{-70,-10},{-50,10}},
                      rotation=0)));
  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
    axisControlBus
    annotation (Placement(transformation(
        origin={-100,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  connect(controller.axisControlBus,axisControlBus)  annotation (Line(
      points={{-60,-10},{-60,-20},{-95,-20},{-95,-4},{-100,-4},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 4,5,6 (= model axisType2) is
that elasticity and damping in the gear boxes are not neglected.
</p>
<p>
The input signals of this component are the desired angle and desired angular
velocity of the joint. The reference signals have to be \"smooth\" (position
has to be differentiable at least 2 times). Otherwise, the gear elasticity
leads to significant oscillations.
</p>
<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</html>"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}), Text(
          extent={{-150,57},{150,97}},
          textString="%name",
          lineColor={0,0,255})}),
    uses(Modelica(version="3.2.1")),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end AxisType2;
