within ;
model MultiLineEncodingDOS "This is a doc string
  with embedded DOS line ending"
  Modelica.Blocks.Interfaces.RealInput Pin(start=2.7076e6);
  Modelica.Blocks.Interfaces.RealOutput Pout;
equation
  connect(Pin, Pout);
end MultiLineEncodingDOS;
