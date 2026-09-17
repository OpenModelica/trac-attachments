model Test "Simple Proportional controller driver"//    fileName=Modelica.Utilities.Files.loadResource("modelica://EVPkg1718eng/"+CycleFileName))   annotation (

  Modelica.Blocks.Sources.CombiTimeTable driveCyc(columns = {2}, fileName = "Test.txt", tableName = "Cycle", tableOnFile = true) annotation(
    Placement(visible = true, transformation(extent = {{-44, -8}, {-24, 12}}, rotation = 0)));
  end Test;
