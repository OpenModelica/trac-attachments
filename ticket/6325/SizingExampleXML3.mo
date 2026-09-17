model SizingExampleXML3
  constant String hString = "multiTank.tankHeights" "XML element name";
  constant String fName = "/tmp/multiTank1.xml" "XML file name";
  final parameter Integer n = readArraySize1D(hString, fName) "Array size";
  parameter Real heightVector[n] = readRealArray1D(hString, fName, n) "Array parameter";
  function readArraySize1D "Read array size"
    input String hString "XML element name";
    input String fName "XML file name";
    output Integer n "Array size";
  protected
    ExternData.Types.ExternXMLFile extObj = ExternData.Types.ExternXMLFile(fName, verboseRead=true) "External XML file object";
  algorithm
    n := ExternData.Functions.XML.getArraySize1D(hString, extObj);
  end readArraySize1D;
  function readRealArray1D "Read array"
    input String hString "XML element name";
    input String fName "XML file name";
    input Integer n "Array size";
    output Real arr[n] "Array";
  protected
    ExternData.Types.ExternXMLFile extObj = ExternData.Types.ExternXMLFile(fName, verboseRead=true) "External XML file object";
  algorithm
    arr := ExternData.Functions.XML.getRealArray1D(hString, n, extObj);
  end readRealArray1D;
  annotation(uses(ExternData(version="2.5.0")));
end SizingExampleXML3;