model Test3
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    tableOnFile=true,
    tableName="Cycle",
    fileName="Test.txt")                                 annotation (
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation (
    uses(Modelica(version="3.2.2")),
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    version = "");
end Test3;
