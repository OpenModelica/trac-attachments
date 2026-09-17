package ExcelReaderTest
  class ExcelReader
    extends ExternalObject;

    function constructor
      input String inFilename;
      output ExcelReader outReader;
    protected
    
      external "C" outReader = initExcelReader(inFilename) annotation(IncludeDirectory = "modelica://ExcelReaderTest", Include = "#include \"ExcelReader.c\"", LibraryDirectory = "modelica://ExcelReaderTest", Library = "xl");
    end constructor;

    function destructor
      input ExcelReader inReader;
    
      external "C" closeExcelReader(inReader);
    end destructor;
  end ExcelReader;

  function readExcelSheet
    input ExcelReader inReader;
    input Real inTime;
    output Real outValue;
  
    external "C" outValue = readExcelSheet(inReader, inTime);
  end readExcelSheet;

  model test
    Real t(start = 0);
    ExcelReader reader = ExcelReader(OpenModelica.Scripting.uriToFilename("modelica://ExcelReaderTest/SP.xls"));
    //ExcelReader reader =
    //  ExcelReader(ModelicaServices.ExternalReferences.loadResource("modelica://ExcelReaderTest/SP.xls"));
  equation
    t = readExcelSheet(reader, time);
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end test;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end ExcelReaderTest;