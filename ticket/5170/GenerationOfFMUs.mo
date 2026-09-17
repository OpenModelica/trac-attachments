model GenerationOfFMUs
  "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine sine1(freqHz = 2, amplitude = 1000) annotation(
    Placement(transformation(extent = {{-100, 40}, {-80, 60}})));
  Modelica.Thermal.HeatTransfer.Examples.Utilities.DirectCapacity directCapacity annotation(
    Placement(visible = true, transformation(extent = {{0, 40}, {20, 60}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Examples.Utilities.InverseCapacity inverseCapacity annotation(
    Placement(visible = true, transformation(extent = {{40, 40}, {60, 60}}, rotation = 0)));
equation
  connect(directCapacity.T, inverseCapacity.T) annotation(
    Line(points = {{21, 58}, {38, 58}}, color = {0, 0, 127}));
  connect(inverseCapacity.Q_flow, directCapacity.Q_flow) annotation(
    Line(points = {{39, 42}, {22, 42}}, color = {0, 0, 127}));
  connect(directCapacity.derT, inverseCapacity.derT) annotation(
    Line(points = {{21, 53}, {28.5, 53}, {28.5, 53}, {38, 53}}, color = {0, 0, 127}));
  connect(sine1.y, directCapacity.Q_flowDrive) annotation(
    Line(points = {{-79, 50}, {-2, 50}}, color = {0, 0, 127}));
  annotation(
    experiment(StopTime = 1, Interval = 0.001),
    Documentation(info = "<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various HeatTransfer components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different flange variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<strong>Connecting two masses</strong><br>
The upper part (DirectCapacity, InverseCapacity)
demonstrates how to export two heat capacitors and connect them
together in a target system. This requires that one of the capacitors
(here: DirectCapacity)
is defined to have states and the temperature and
derivative of temperature are provided in the interface.
The other capacitor (here: InverseCapacity) requires heat flow according
to the provided input temperature and derivative of temperature.
</p>

<p>
<strong>Connecting a conduction element that needs only temperature</strong><br>
The lower part (Conductor) demonstrates how to export a conduction element
that needs only temperatures for its conduction law and connect this
conduction law in a target system between two capacitors.
</p>
</html>"),
    uses(Modelica(version = "3.2.3")));
end GenerationOfFMUs;
