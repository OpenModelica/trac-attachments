model ReadingParameters
  parameter String inputFile = Modelica.Utilities.Files.loadResource("modelica://ReadingParameters/input.dat") "Input data file";
  parameter Modelica.SIunits.Voltage V1 = KeyWordIO.readRealParameter(inputFile, "V1");
  parameter Modelica.SIunits.Voltage V2 = KeyWordIO.readRealParameter(inputFile, "V2");
  final parameter Real n12 = V1 / V2;
  annotation(Icon, Diagram);
end ReadingParameters;