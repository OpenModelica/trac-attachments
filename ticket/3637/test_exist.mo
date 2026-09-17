within ;
model test_exist
  import Modelica.Utilities.Files.exist;
  import Modelica.Utilities.Files.removeFile;
  import Modelica.Utilities.Streams.print;
  Real x;
  Integer i;
  Boolean file_exists(start = false, fixed = true);
equation
  der(x) = 1 - x;
algorithm
  when sample(0,0.7) then
    print("I think therefore I am", "go.txt");
    while not file_exists loop
       file_exists :=exist("go.txt");
       i := i+1;
    end while;
    print("Gone!, time = "+String(time)+", i = "+String(i), "result.txt");
    removeFile("go.txt");
  end when;
  annotation (uses(Modelica(version="3.2.1")));
end test_exist;
