model M
  parameter Real step;
  parameter Integer nOutputs = 2;
  Real outputs1[nOutputs];
  Real outputs2[nOutputs];
  Integer done;
initial algorithm
  step := getSimulationStepSize();
algorithm
  when (sample(0, step)) then
    (outputs1) := calculate1(step, size(outputs1, 1));
    (outputs2, done) := calculate2(step, size(outputs2, 1));
  end when;
protected
  function calculate1
    input Real s;
    input Integer outputArrSize;
    output Real outputArr[outputArrSize];
    external "C" calculate1(s, outputArrSize, outputArr) annotation(Library = {"mylib"});
  end calculate1;

  function calculate2
    input Real s;
    input Integer outputArrSize;
    output Real outputArr[outputArrSize];
    output Integer done;
    external "C" calculate2(s, outputArrSize, outputArr, done) annotation(Library = {"mylib"});
  end calculate2;
  
  function getSimulationStepSize
    output Real s;
    external "C" s = getSimulationStepSize() annotation(Library = {"SimulationRuntimeC"});
  end getSimulationStepSize;
end M;