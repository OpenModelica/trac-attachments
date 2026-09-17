model ReadArray
  import Streams = Modelica.Utilities.Streams;
  import Strings = Modelica.Utilities.Strings;
  constant String filename = "<pathtofile>/numberfile.txt";
  constant Integer alength = 3;
  Real[alength] a;
  String line;
  Boolean eof;
algorithm
  for lineno in 1:alength loop
    (line, eof):= Streams.readLine( filename, lineno );
    a[lineno]:= Strings.scanReal( line );
  end for;
end ReadArray;
