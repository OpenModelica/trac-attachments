model ReadNumber
  import Streams = Modelica.Utilities.Streams;
  import Strings = Modelica.Utilities.Strings;
  constant String filename = "<pathtofile>/numberfile.txt";
  Integer lineno = 1;
  String line;
  Boolean eof;
  Real value;
algorithm
    (line, eof):= Streams.readLine( filename, lineno );
    value:= Strings.scanReal( line );
end ReadNumber;
