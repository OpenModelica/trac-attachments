model TestDelete
  import Modelica.Utilities.Files.removeFile;
  import Modelica.Utilities.Streams.close;
  import Modelica.Utilities.Streams.print;
  
 impure function exist "Workaround for exist being pure" 
    input String fileName; 
    output Boolean b; 
  algorithm 
    b := Modelica.Utilities.Files.exist(fileName); 
    annotation(Inline = false);
  end exist;
  
  Real x(start = 0, fixed = true);
  
equation
  der(x) = -x + 1;
algorithm
  when time > 0.5 then
    print("One line", "file.txt");
    close("file.txt");
    removeFile("file.txt");
    if exist("file.txt") then
      print("Error: file still exists after being deleted!");
    else
      print("OK: File deleted correctly");
    end if;
  end when;
end TestDelete;
