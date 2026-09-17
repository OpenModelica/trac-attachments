package test
  record PumpR "Observation signals needed for one pump"
    input Boolean inOperation;
    input Boolean cavitate;
  end PumpR;
  
  model TestModel
    test.PumpR pr;
    test.SystemModel sm;
  end TestModel;
  
  model SystemModel
    test.PA pa;
    test.PB pb, pb2;
    
  end SystemModel; 
    
   model PA
    Boolean on;
  end PA; 
  
  model PB
    Boolean volFlowRate;
  end PB;
  
end test;