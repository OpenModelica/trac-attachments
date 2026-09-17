package TestTxtFile
  model M
    Modelica.Blocks.Sources.CombiTimeTable table(                                                                                              tableName = "tab1", tableOnFile = true,
      fileName="Table.txt")                                                                                                                                                             annotation (
      Placement(visible = true, transformation(origin={-20,0},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(uses(Modelica(version="3.2.2")),experiment(StopTime=4),
      Diagram(coordinateSystem(extent={{-60,-40},{20,40}})),
      Icon(coordinateSystem(extent={{-60,-40},{20,40}})));
  end M;


  annotation (
    uses(Modelica(version = "3.2.2")));
end TestTxtFile;
