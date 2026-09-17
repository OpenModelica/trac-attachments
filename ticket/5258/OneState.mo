model OneState

  parameter Real quantum = 1.0;
  parameter Boolean variableQuantum = false;
  parameter Real tolerance = 0.05; 
  parameter Boolean rollback = true;

  // impossible to directly use parameter tolerance in the classes -> OM bug?
  NewMaster.Stepper2 s(quantum = quantum, variableQuantum = variableQuantum, tolerance = 0.05, rollback = rollback);
   NewMaster.Stepper2 bads(quantum = quantum, variableQuantum = variableQuantum, tolerance = tolerance, rollback = rollback);
  
equation 
  
end OneState;
