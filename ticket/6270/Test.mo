model Test "Figure 4 of paper"
  Real zenerEnergy;
  Modelica.Electrical.Analog.Sensors.PotentialSensor vMeter annotation(
    Placement(visible = true, transformation(extent = {{-32, 54}, {-12, 34}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1D vTable(smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, table = [-1, 0; 0.0, 0.0; 0.8, 0.1; 1.5, 5.5; 1.8, 6.3; 2, 6.5; 2.5, 6.6; 6, 6.7; 10, 6.8]) annotation(
    Placement(visible = true, transformation(extent = {{12, 6}, {-8, 26}}, rotation = 0)));
equation
  der(zenerEnergy) = zDiode.LossPower;
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -40}, {80, 80}})),
    Icon(coordinateSystem(extent = {{-80, -40}, {80, 80}})),
    experiment(StartTime = 0.005, StopTime = 0.0055, __Dymola_NumberOfIntervals = 2000),
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html>
    <p>Compliance is satisfactory.</p>
    <p>Only the duration of clamped zener voltage in the paper is larger than this simulation.</p>
    <p>This can only be explained with a difference in primary transformer inductanceshown in table 1.</p>
    </html>"));
end Test;
