model TestPlotArray
  Real y[3];
  
equation
  y[1] = time;
  y[2] = time^2;
  y[3] = time^3;
  
annotation(
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
    
end TestPlotArray;