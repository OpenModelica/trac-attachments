package TestJacobian
  model Test1
    Real x1,x2;
    Real y1,y2;
  equation
    x1 + sin(x1) + x2 + sin(x2) = 1;
    x1 + sin(x1) - x2 + sin(x2) = 0;
    y1 + homotopy(sin(y1),y1) + y2 + homotopy(sin(y2),y2) = 1;
    y1 + homotopy(sin(y1),y1) - y2 + homotopy(sin(y2),y2) = 0;
    annotation(__OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
             experiment(StopTime = 15, Tolerance = 1e-4));
  end Test1;
  
  model Test2
    extends Test1;
    annotation(__OpenModelica_commandLineOptions = "--replaceHomotopy=actual --tearingMethod=minimalTearing",
             experiment(StopTime = 15, Tolerance = 1e-4));
  end Test2;
  
  model Test3
    extends Test1;
    annotation(__OpenModelica_commandLineOptions = "-d=forceNLSanalyticJacobian --tearingMethod=minimalTearing",
             experiment(StopTime = 15, Tolerance = 1e-4));
  end Test3;
  
  model Test4
    Real x1,x2;
    Real y1,y2;
  equation
    x1 + sin(x1) + x2 + sin(x2) = 1;
    x1 + sin(x1) - x2 + sin(x2) = 0;
    y1 + smooth(2,if y1 > 0 then sin(y1) else -sin(-y1)) + y2 + sin(y2) = 1;
    y1 + sin(y1) - y2 + sin(y2) = 0;
    annotation(__OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
             experiment(StopTime = 15, Tolerance = 1e-4));
  end Test4;

  model Test5
    extends Test1;
  annotation(__OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
             __OpenModelica_simulationFlags(nlssMinSize = "1", nlssMaxDensity = "1.1", lv = "LOG_NLS_V"),
             experiment(StopTime = 15, Tolerance = 1e-4));
  
  end Test5;

  model Test6
    extends Test1;
  annotation(__OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
             __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv = "LOG_NLS_V"),
             experiment(StopTime = 15, Tolerance = 1e-4));
  end Test6;
end TestJacobian;
