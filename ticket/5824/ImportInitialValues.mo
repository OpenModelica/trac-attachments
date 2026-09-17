package ImportInitialValues "Test cases for importing initial values in OpenModelica"

  partial model BaseModel
    Real v1;
    Real v2;
    Real v3;
    Real x;
    parameter Real p1;
    parameter Real p2 = 2*p1;
    final Real p3 = 3*p1;
  equation
  end BaseModel;
  
  model ResultGenerator
    extends BaseModel(p1 = 7, p2 = 10);
  equation
    v1 = 2.8;
    v2 = 3.9;
    v3 = 10;
    der(x) = 0;
  initial equation
    x = 4;
  annotation(
    experiment(StopTime = 1),
    __OpenModelica_simulationFlags(r = "initial.mat"));
  end ResultGenerator;

  model ImportModel
    extends BaseModel(
      v1(start = 14),
      v2(start = 14),
      p1 = 1, p2 = 1);
  equation
    (v1 - 3)*(v1 + 10)*(v1 - 15) = 0;
    (v2 - x)*(v2 + 10)*(v2 - 15) = 0;
    v3 = time;
    der(x) = -x;    
  initial equation
    x = 6;
  end ImportModel;
  
  model ImportModelAnnotationInitialEqs
    extends BaseModel(
      v1(start = 12),
      v2(start = 12),
      p1 = 1, p2 = 1);
  equation
    (v1 - 3)*(v1 + 10)*(v1 - 15) = 0;
    (v2 - x)*(v2 + 10)*(v2 - 15) = 0;
    v3 = time;
    der(x) = -x;    
  initial equation
    x = 6;
  annotation(__OpenModelica_simulationFlags(iif = "initial.mat"));
  end ImportModelAnnotationInitialEqs;
  
  model ImportModelAnnotationNoInitialEqs
    extends BaseModel(
      v1(start = 12),
      v2(start = 12),
      p1 = 1, p2 = 1);
  equation
    (v1 - 3)*(v1 + 10)*(v1 - 15) = 0;
    (v2 - x)*(v2 + 10)*(v2 - 15) = 0;
    v3 = time;
    der(x) = -x;    
  initial equation
    x = 6;
  annotation(__OpenModelica_simulationFlags(iim = "none", iif = "initial.mat"));
  end ImportModelAnnotationNoInitialEqs;
end ImportInitialValues;
