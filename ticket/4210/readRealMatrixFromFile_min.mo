  model ReadRealMatrixFromFile
    parameter String matrixName = "Matrix_A" "Matrix name in file";

    String file = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v4.mat") "File name of check matrix 1";
    Integer dim[2] = Modelica.Utilities.Streams.readMatrixSize(file,matrixName) "Dimensions of check matrix 1";
    Real A[:,:] = Modelica.Utilities.Streams.readRealMatrix(file,matrixName,dim[1],dim[2]) "Data of check matrix 1";
    Real x(start=1);
  equation
    der(x) = 1;
    when initial() then
       print("...    " + matrixName + "[1,1] = " + String(A[1,1]));
    end when;
  end ReadRealMatrixFromFile;
