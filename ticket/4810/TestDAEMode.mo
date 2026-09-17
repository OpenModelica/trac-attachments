
model TestDAEMode
  Real x(start=0,fixed=true),y;
 
equation
  der(x) = y;
  y= -x+1;
  annotation(experiment(StopTime = 5, Tolerance = 1e-6),
     __OpenModelica_simulationFlags(daeMode),
     __OpenModelica_commandLineOptions = "--daeMode=all");
end TestDAEMode;
