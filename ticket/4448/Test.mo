package Test
  extends Modelica.Icons.Package;
  function __OpenModelica_getReal "Get scalar Real value from XML file"
    extends Modelica.Icons.Function;
    input String fileName="" "File where external data is stored";
    input String varName "Key";
    output Real y "Real value";
    protected
      ExternData.Types.ExternXMLFile xml = ExternData.Types.ExternXMLFile(fileName) "External XML file object";
    algorithm
      y := ExternData.Functions.XML.getReal(xml=xml, varName=varName);
    annotation(Inline=false);
  end __OpenModelica_getReal;
  
  model XMLTest "XML file read test"
    extends Modelica.Icons.Example;
    parameter String fileName = Modelica.Utilities.Files.loadResource("C:\OpenModelica1.12.0-dev-64bit\lib\omlibrary\ExternData 2.2.0\Resources\Examples\test.xml");
    Real test = __OpenModelica_getReal(fileName, "set1.gain.k");
    annotation(experiment(StopTime=1));
  end XMLTest;

  annotation(uses(ExternData(version="2.2.0"), Modelica(version="3.2.2")));
end Test;
