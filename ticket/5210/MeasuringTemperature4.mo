model MeasuringTemperature4 "Differences between using one port with and without explicit junction model and two port sensors for fluid temperature measuring"
   extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                      annotation (Placement(visible = true, transformation(extent = {{-40, -88}, {-20, -68}}, rotation = 0)));
  Modelica.Fluid.Vessels.OpenTank openTankHot3(nPorts=1,
    level_start=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    height=2,
    crossArea=2,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.05)},
    T_start=353.15)                                                                annotation (Placement(transformation(extent={{60,-80},
            {80,-60}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal junctionIdeal(
                                                       redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
equation
  connect(junctionIdeal.port_2, openTankHot3.ports[1]) annotation(
    Line(points = {{40, -80}, {55.5, -80}, {70, -80}}, color = {0, 127, 255}));
  annotation (Diagram(coordinateSystem(initialScale = 0.1)),
                       Documentation(info="<html>
<p>
This model demonstrates the differences that occur when using
one- and two-port temperature sensors with and without explicit junction models.
As shown in the next figure, the same system is shown in 3 different variations.
In all cases exactly the same fluid system is defined. The only difference is
how the temperature is measured:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/MeasuringTemperature1.png\"
   alt=\"MeasuringTemperature1.png\">
</blockquote>

<p>
A pre-defined mass flow rate is present so that fluid flows from the reservoir to the
tanks and after 0.5 s the mass flows from the tanks to the reservoir.
The reservoir has a temperature of 50<sup>0</sup>C whereas the tanks have an
initial temperature of 20<sup>0</sup>C and of 80<sup>0</sup>C. The initial height of the
tanks is made in such a form that fluid always flows out of the cold tank.
When the fluid flows from the reservoir to the tanks, then it mixes with the
cold tank and enters the hot tank.
When the fluid flow from the tanks to the reservoir, then the cold and hot water
from the two tanks first mixes and the flows to the reservoir.
</p>

<p>
A one-port sensor measures the <em>mixing</em> temperature at a connection point.
Therefore T_onePort.T (the blue curve in the figure below) is the
temperature of the mixing point.
A two-port sensor measures the temperature at the <em>upstream</em> side.
Therefore T_twoPort.T (the red curve in the figure below which is identical
to the green curve) shows first the temperature of the reservoir and then
the mixing temperature when fluid flows from the tanks to the reservoir.
The same is measured with T_junction.T (the green curve below), because
the one-port sensor is connected between the mass flow source and the junction
and since the mixing takes place in the junction, the same situation is
present as for T_twoPort.T.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/MeasuringTemperature2.png\"
   alt=\"MeasuringTemperature2.png\">
</blockquote>

</html>"),
    experiment(StopTime=1.1));
end MeasuringTemperature4;
