model test
import KeyWordIO.*;

parameter String outputFileName = Modelica.Utilities.Files.loadResource("modelica://test/myoutput.txt");
Real M[2,2] = [1,2;3,4];

algorithm
  when initial() then
    KeyWordIO.writeRealCSV(outputFileName, "\t", M);
  end when;

annotation (
  uses(KeyWordIO(version = "0.7.0")));

end test;