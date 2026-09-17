package Medium 
  function h_pt 
    input Real p; 
    input Real t; 
    output Real h; 
  algorithm 
    h := t; 
  end h_pt; 
  
  function d_ph 
    input Real p; 
    input Real h; 
    output Real d; 
  algorithm 
    d := h; 
  end d_ph;  
end Medium; 

connector Port 
  flow Real mf; 
  Real p; 
  stream Real h; 
end Port; 


model Pipe 
  Port port_a, port_b; 
  Real loopPressure; 
    
protected 
  Real density; 
  Real outputPressure; 
  
  function func 
    input Real inputPressure; 
    input Real density; 
    output Real outputPressure; 
    output Real loopPressure; 
  algorithm 
    loopPressure := inputPressure; 
    outputPressure := inputPressure; 
  end func; 

equation 
  density = Medium.d_ph(port_a.p, port_a.h); 
  (outputPressure, loopPressure) = func(port_a.p, density); 

  port_a.mf + port_b.mf = 0; 
  port_b.p = outputPressure; 
  port_a.h = inStream(port_b.h); 
  port_b.h = inStream(port_a.h); 
end Pipe; 

model Split 
  Port port_a, port_b, port_c; 
equation 
  connect(port_a, port_b); 
  connect(port_a, port_c);  
end Split; 

model Join 
  Port port_a, port_b, port_c; 
  final parameter Real epsFlow = 1e-15; 
equation 
  port_a.mf + port_b.mf + port_c.mf = 0; 
  port_b.p = min(port_a.p, port_c.p); 
  port_a.h = (max(port_b.mf, epsFlow) * inStream(port_b.h) + max(port_c.mf, epsFlow) * inStream(port_c.h)) / (max(port_b.mf, epsFlow) + max(port_c.mf, epsFlow)); 
  port_b.h = (max(port_a.mf, epsFlow) * inStream(port_a.h) + max(port_c.mf, epsFlow) * inStream(port_c.h)) / (max(port_a.mf, epsFlow) + max(port_c.mf, epsFlow)); 
  port_c.h = (max(port_a.mf, epsFlow) * inStream(port_a.h) + max(port_b.mf, epsFlow) * inStream(port_b.h)) / (max(port_a.mf, epsFlow) + max(port_b.mf, epsFlow)); 
end Join;  

model Boundary 
  Port port; 
  Real t; 
  Real mf; 
  Real p; 
equation 
  port.mf = mf; 
  port.p = p; 
  port.h = Medium.h_pt(p, t); 
end Boundary; 

model Test 
  Split[numberOfSplits - 1] split; 
  Join[numberOfSplits - 1] join;                                                                  
  Pipe[numberOfSplits] pipe; 
    
  Boundary source; 
  Boundary sink; 
    
  parameter Integer numberOfSplits = 2;    
  parameter Integer numberOfLoops = 10; 
    
equation  
  source.mf = -10; 
  source.p = 100000; 
  source.t = 300; 
  sink.t = 300; 
  
  // Grid: 
  //  split 
  // --+--+--- 
  //   |  |  | pipe 
  // --+--+--- 
  //  join 
  
  connect(source.port, split[1].port_a); 
  
  for i in 1:numberOfSplits - 1 loop 
    connect(split[i].port_c, pipe[i].port_a); 
    connect(pipe[i].port_b, join[i].port_c); 

    split[i].port_c.mf = -source.port.mf / numberOfSplits;    
  end for; 
  
  
  for i in 1:numberOfSplits - 2 loop 
    connect(split[i].port_b, split[i + 1].port_a); 
    connect(join[i + 1].port_b, join[i].port_a); 
  end for;  
    
  connect(split[numberOfSplits - 1].port_b, pipe[numberOfSplits].port_a); 
  connect(pipe[numberOfSplits].port_b, join[numberOfSplits - 1].port_a); 
  
  connect(join[1].port_b, sink.port); 
end Test;