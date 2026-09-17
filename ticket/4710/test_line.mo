model test_line
  import Modelica.Utilities.Streams;

  record Metadata
    String line7;
  end Metadata;

  function getMetadata
    input String line7;
    output Metadata meta;
  algorithm
    meta.line7 := line7;
  end getMetadata;

  parameter String wea_file = "/home/ali/Desktop/weather.motab"; // This absolute path should be changed accordingly in your machine
  
  parameter String line7_read = Streams.readLine(wea_file,7);
  parameter String line7_local = "#METADATA,76031-MILDURA AIRPORT,-34.236,142.087,50,10.0,6600.0";
  
  
  parameter Metadata meta = getMetadata(line7_local); //<---change to 'line7_read', then meta.line7 below becomes blank
equation
  Modelica.Utilities.Streams.print("line7_read = " + String(line7_read));
  Modelica.Utilities.Streams.print("line7_local = " + String(line7_local));
  Modelica.Utilities.Streams.print("meta.line7 = " + String(meta.line7));
end test_line;