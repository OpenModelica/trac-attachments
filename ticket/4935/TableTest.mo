model TableTest
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(fileName = "BadTable.txt", tableName = "Cycle", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(Modelica(version = "3.2.2")),
  experiment(StartTime = 0, StopTime = 180, Tolerance = 1e-06, Interval = 0.36));
end TableTest;
