model foo
  parameter Real step = 0.1;
  parameter Integer nOutputs = 2;
  Real outputs1[nOutputs];
  Real outputs2[nOutputs];
  Integer done;
algorithm
  when sample(0, step) then
      outputs1:=calculate1(step, nOutputs);
    (outputs2,done):=calculate2(step, nOutputs);  
  end when;
protected
  function calculate1
    input Real s;
    input Integer outputArrSize;
    output Real outputArr[outputArrSize];

    external "C" calculate1(s,outputArrSize,outputArr)     annotation(Include = "#include <stdio.h>
                                                                                  void calculate1(double step, int n, double *arr)
                                                                                  {
                                                                                    arr[0] += 1;
                                                                                    arr[1] += 2;
                                                                                  }"); 
  end calculate1;
  function calculate2
    input Real s;
    input Integer outputArrSize;
    output Real outputArr[outputArrSize];
    output Integer done;

    external "C" calculate2(s,outputArrSize,outputArr,done)     annotation(Include = "#include <stdio.h>
                                                                                        calculate2(double step, int n, double *arr, int *sldone)
                                                                                        {
                                                                                          arr[0] += 1;
                                                                                          arr[1] += 2;
                                                                                          
                                                                                          *sldone = 1;
                                                                                        }"); 
  end calculate2;
end foo;

