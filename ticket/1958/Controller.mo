within ;
model Controller "P-PI cascade controller for one axis"

  Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Components.AxisControlBus
    axisControlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}},
          rotation=0)));
  Modelica.Blocks.Math.Sum sum(nin=4)
    annotation (Placement(transformation(extent={{18,32},{38,52}})));
equation
  connect(sum.u[1], axisControlBus.speed_ref)
                                  annotation (Line(points={{16,40.5},{16,-100},{
          0,-100}},             color={0,0,127}));
  connect(sum.u[2], axisControlBus.angle_ref)
                                  annotation (Line(points={{16,41.5},{-80,41.5},
          {-80,-100},{0,-100}}, color={0,0,127}));
  connect(sum.u[3], axisControlBus.motorAngle)
                                        annotation (Line(points={{16,42.5},{16,-100},
          {0,-100}},           color={0,0,127}));
  connect(sum.u[4], axisControlBus.motorSpeed)
                                   annotation (Line(points={{16,43.5},{0,44},{0,
          -100}}, color={0,0,127}));
  connect(sum.y, axisControlBus.current_ref)
                                 annotation (Line(points={{39,42},{90,42},{90,-100},
          {0,-100}},          color={0,0,127}));
  annotation (uses(Modelica(version="3.2.1")));
end Controller;
