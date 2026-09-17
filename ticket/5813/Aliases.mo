package Aliases
  type Temperature = Real(start = 300, unit="K");
  type Power = Real(unit="W");

  connector Port
    Temperature T;
    flow Power Q;
  end Port;

  model TemperatureSource
    parameter Temperature Tstart = 320;
    Temperature T1;
    Temperature T2(start = 310);
    Temperature T3(start = Tstart);
    Port port;
  equation
    port.T = T1;
    T1 = T2;
    T2 = T3;
    T1+1e-6*sin(T1) = 300 "Implicit equation on T1";
  end TemperatureSource;
  
  model PowerSource
    parameter Temperature Tstart = 320;
    Port port;
    Temperature T1;
    Temperature T2(start = 330);
    Temperature T3(start = Tstart);
  equation
    port.T = T1;
    T1 = T2;
    T2 = T3;
    port.Q - (port.T-300) = sin(time);
  end PowerSource;

  model WrappedTemperatureSource
    parameter Temperature Tstart = 345;
    Port port;
    TemperatureSource ts(Tstart = Tstart);
  equation
    connect(ts.port, port);
  end WrappedTemperatureSource;  
  
  model WrappedPowerSource
    parameter Temperature Tstart = 345;
    Port port;
    PowerSource ts(Tstart = Tstart);
  equation
    connect(ts.port, port);
  end WrappedPowerSource;
  
  
  model System1
    TemperatureSource ts;
    PowerSource ps;
  equation
    connect(ts.port,ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System1;
  
  model System2
    TemperatureSource ts(Tstart = 350);
    PowerSource ps;
  equation
    connect(ts.port,ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System2;
  
  model System3
    TemperatureSource ts(T1(start = 360));
    PowerSource ps;
  equation
    connect(ts.port,ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System3;
  
  model System4
    WrappedTemperatureSource ts(Tstart = 370);
    PowerSource ps;
  equation
    connect(ts.port,ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System4;
  
  model System5
    TemperatureSource ts;
    WrappedPowerSource ps(Tstart = 380);
  equation
    connect(ts.port, ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System5;

  model System6
    WrappedTemperatureSource ts(ts(T1(start = 390)));
    WrappedPowerSource ps(Tstart = 400);
  equation
    connect(ts.port, ps.port);
    annotation(__OpenModelica_commandLineOptions ="-d=aliasConflicts");
  end System6;
end Aliases;
