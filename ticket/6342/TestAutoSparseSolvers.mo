package TestAutoSparseSolvers
  package Linear
    package DefaultSolver
      model Test_N_10
        parameter Integer N = 10;
        Real x[N];
      equation
        x[1] + 0.1*x[2] = 1;
        for i in 2:N - 1 loop
          0.1*x[i-1] + x[i] + 0.1*x[i+1] = 1;
        end for;
        0.1*x[N-1] + x[N] = 1;
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
         experiment(StopTime = 0));
      end Test_N_10;
    
      model Test_N_20
        extends Test_N_10(N = 20);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_20;
    
      model Test_N_40
        extends Test_N_10(N = 40);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_40;
    
      model Test_N_80
        extends Test_N_10(N = 80);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_80;
    
      model Test_N_160
        extends Test_N_10(N = 160);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_160;
    
      model Test_N_320
        extends Test_N_10(N = 320);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_320;
    
      model Test_N_640
        extends Test_N_10(N = 640);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_640;
    
      model Test_N_1280
        extends Test_N_10(N = 1280);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
         experiment(StopTime = 0));
      end Test_N_1280;
    
      model Test_N_2560
        extends Test_N_10(N = 2560);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
         experiment(StopTime = 0));
      end Test_N_2560;
    
      model Test_N_5120
        extends Test_N_10(N = 5120);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
         experiment(StopTime = 0));
      end Test_N_5120;
    
      model Test_N_10240
        extends Test_N_10(N = 10240);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_10240;
    end DefaultSolver;
  
    package SparseSolver
      model Test_N_10
        parameter Integer N = 10;
        Real x[N];
      equation
        x[1] + 0.1*sin(x[2]) = 1;
        for i in 2:N - 1 loop
          0.1 * sin(x[i-1]) + x[i] + 0.1*sin(x[i+1]) = 1;
        end for;
        0.1*sin(x[N-1]) + x[N] = 1;
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_10;
    
      model Test_N_20
        extends Test_N_10(N = 20);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_20;
    
      model Test_N_40
        extends Test_N_10(N = 40);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_40;
    
      model Test_N_80
        extends Test_N_10(N = 80);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_80;
    
      model Test_N_160
        extends Test_N_10(N = 160);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_160;
    
      model Test_N_320
        extends Test_N_10(N = 320);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_320;
    
      model Test_N_640
        extends Test_N_10(N = 640);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_640;
    
      model Test_N_1280
        extends Test_N_10(N = 1280);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_1280;
    
      model Test_N_2560
        extends Test_N_10(N = 2560);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_2560;
    
      model Test_N_5120
        extends Test_N_10(N = 5120);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_5120;
    
      model Test_N_10240
        extends Test_N_10(N = 10240);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(ls="klu", lv="LOG_LS"),
          experiment(StopTime = 0));
      end Test_N_10240;
    end SparseSolver;
  end Linear;
  
  package Nonlinear
    package DefaultSolver
      model Test_N_10
        parameter Integer N = 10;
        Real x[N];
      equation
        x[1] + 0.1 * sin(x[2]) = 1;
        for i in 2:N - 1 loop
          0.1 * sin(x[i - 1]) + x[i] + 0.1 * sin(x[i + 1]) = 1;
        end for;
        0.1 * sin(x[N - 1]) + x[N] = 1;
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_10;
    
      model Test_N_20
        extends Test_N_10(N = 20);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_20;
    
      model Test_N_40
        extends Test_N_10(N = 40);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_40;
    
      model Test_N_80
        extends Test_N_10(N = 80);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_80;
    
      model Test_N_160
        extends Test_N_10(N = 160);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_160;
    
      model Test_N_320
        extends Test_N_10(N = 320);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_320;
    
      model Test_N_640
        extends Test_N_10(N = 640);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
           __OpenModelica_simulationFlags(lv="LOG_NLS"),
         experiment(StopTime = 0));
      end Test_N_640;
    
      model Test_N_1280
        extends Test_N_10(N = 1280);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_1280;
    
      model Test_N_2560
        extends Test_N_10(N = 2560);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_2560;
    
      model Test_N_5120
        extends Test_N_10(N = 5120);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_5120;
    
      model Test_N_10240
        extends Test_N_10(N = 10240);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_10240;
    end DefaultSolver;
  
    package SparseSolver
      model Test_N_10
        parameter Integer N = 10;
        Real x[N];
      equation
        x[1] + 0.1 * sin(x[2]) = 1;
        for i in 2:N - 1 loop
          0.1 * sin(x[i - 1]) + x[i] + 0.1 * sin(x[i + 1]) = 1;
        end for;
        0.1 * sin(x[N - 1]) + x[N] = 1;
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_10;
    
      model Test_N_20
        extends Test_N_10(N = 20);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_20;
    
      model Test_N_40
        extends Test_N_10(N = 40);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_40;
    
      model Test_N_80
        extends Test_N_10(N = 80);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_80;
    
      model Test_N_160
        extends Test_N_10(N = 160);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_160;
    
      model Test_N_320
        extends Test_N_10(N = 320);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_320;
    
      model Test_N_640
        extends Test_N_10(N = 640);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_640;
    
      model Test_N_1280
        extends Test_N_10(N = 1280);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_1280;
    
      model Test_N_2560
        extends Test_N_10(N = 2560);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_2560;
    
      model Test_N_5120
        extends Test_N_10(N = 5120);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_5120;
    
      model Test_N_10240
        extends Test_N_10(N = 10240);
        annotation(
          __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing",
          __OpenModelica_simulationFlags(nls="kinsol", nlsLS="klu", lv="LOG_NLS"),
          experiment(StopTime = 0));
      end Test_N_10240;
    end SparseSolver;
  end Nonlinear;
end TestAutoSparseSolvers;
