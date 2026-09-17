package Bug
connector HeatPortVector
  parameter Integer n = 4;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort port[n];
end HeatPortVector;

  model Component
    HeatPortVector bottom(n = rows);
    
    parameter Integer rows = 4;
    parameter Integer cols = 4;
    
    parameter Modelica.SIunits.HeatCapacity c = 1;
    parameter Modelica.SIunits.ThermalConductance gx = 1;
    parameter Modelica.SIunits.ThermalConductance gy = 1;
    parameter Modelica.SIunits.ThermalConductance gf = 1;
    parameter Modelica.SIunits.Temperature inletFluidTemperature = 300;
    
    Modelica.SIunits.Temperature T[rows, cols](each start = inletFluidTemperature, each fixed = true);
  equation
  
    for i in 1:rows loop
      bottom.port[i].Q_flow = 2 * gx * (bottom.port[i].T - T[i, 1]);
    end for;
    
    c * der(T[1, 1]) = gx * (T[1, 2] - T[1, 1])
                     + gy * (T[2, 1] - T[1, 1])
                     + gf * (inletFluidTemperature - T[1, 1])
                     + bottom.port[1].Q_flow;
    
    if cols > 1 then
      c * der(T[1, cols]) = gx * (T[1, cols - 1] - T[1, cols])
                          + gy * (T[2, cols] - T[1, cols])
                          + gf * (inletFluidTemperature - T[1, cols]);
    end if;
    
    if rows > 1 then
      c * der(T[rows, 1]) = gx * (T[rows, 2] - T[rows, 1])
                          + gy * (T[rows - 1, 1] - T[rows, 1])
                          + gf * (inletFluidTemperature - T[rows, 1])
                          + bottom.port[rows].Q_flow;
    end if;
    
    if rows > 1 and cols > 1 then
      c * der(T[rows, cols]) = gx * (T[rows, cols - 1] - T[rows, cols])
                             + gy * (T[rows - 1, cols] - T[rows, cols])
                             + gf * (inletFluidTemperature - T[rows, cols]);
    end if;
  
    for i in 2:rows - 1 loop
      c * der(T[i, 1]) = gx * (T[i, 2] - T[i, 1])
                       + gy * (T[i - 1, 1] + T[i + 1, 1] - 2 * T[i, 1])
                       + gf * (inletFluidTemperature - T[i, 1])
                       + bottom.port[i].Q_flow;
      
      if cols > 1 then
        c * der(T[i, cols]) = gx * (T[i, cols - 1] - T[i, cols])
                            + gy * (T[i - 1, cols] + T[i + 1, cols] - 2 * T[i, cols])
                            + gf * (inletFluidTemperature - T[i, cols]);
      end if;
    end for;
    
    for j in 2:cols - 1 loop
      c * der(T[1, j]) = gx * (T[1, j - 1] + T[1, j + 1] - 2 * T[1, j])
                       + gy * (T[2, j] - T[1, j])
                       + gf * (inletFluidTemperature - T[1, j]);
      
      if rows > 1 then
        c * der(T[rows, j]) = gx * (T[rows, j - 1] + T[rows, j + 1] - 2 * T[rows, j])
                            + gy * (T[rows - 1, j] - T[rows, j])
                            + gf * (inletFluidTemperature - T[rows, j]);
      end if;
    end for;
    
    for i in 2:rows - 1 loop
      for j in 2:cols - 1 loop
        c * der(T[i, j]) = gx * (T[i, j - 1] + T[i, j + 1] - 2 * T[i, j])
                         + gy * (T[i - 1, j] + T[i + 1, j] - 2 * T[i, j])
                         + gf * (inletFluidTemperature - T[i, j]);
      end for;
    end for;
  end Component;

  model Top
    //Setting z to any positive integer greater than 1 makes it compile
    Component components[x](each cols = z);
    parameter Integer x = 4;
    parameter Integer z = 1;
  end Top;
end Bug;