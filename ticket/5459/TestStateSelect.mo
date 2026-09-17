package TestStateSelect
  package UnknownParameter
    import SI = Modelica.SIunits;

    model Pdefault_Tdefault
      parameter SI.Length d = 0.25 "pneumatic chamber diameter";
      parameter SI.Volume Vtot = 0.126 "accumulator total working volume inside the piston stroke";
      parameter SI.Pressure p0 = 750e5 "gas precharge pressure";
      parameter SI.Temperature T0 = 293.15 "gas precharge temperature";
      parameter SI.Pressure p_start = p0 "initial pressure" annotation(
        Dialog(tab = "Initialization"));
      parameter SI.Temperature T_start = T0 "initial temperature" annotation(
        Dialog(tab = "Initialization"));
      final parameter SI.AmountOfSubstance N(fixed = false) "Total amount of gas";
      final parameter SI.Area S = 3.1415 * (d / 2) ^ 2 "piston surface";
      final parameter SI.Length ps = Vtot / S "piston stroke";
      // Gas properties
      final parameter SI.MolarMass MM = 0.028 "molar mass";
      final parameter SI.SpecificHeatCapacityAtConstantPressure Cp = 1040 "specific heat capacity at constant pressure";
      final parameter Real a = 0.1408*1e5/1e6 "Van Der Waals Constant a";
      final parameter Real b = 0.03913/1e3 "Van Der Waals Constant b";
      import Modelica.Constants.R;
      // Variables
      SI.Volume Vg(nominal = Vtot) "gas volume";
      SI.Pressure p(start = p_start, stateSelect = StateSelect.default) "chamber pressure";
      SI.Temperature T(start = T_start, stateSelect = StateSelect.default) "gas temperature";
    equation
// mechanical equations
      Vg = 0.125 + 0.01 * sin(2 * 3.1415 * time);
// pneumatic equations
      N*R*T = (p + a*N^2/Vg^2) * (Vg - N*b);
// Energy balance
      N*MM*Cp*der(T) - Vg*der(p)=0;
    initial equation
      p = p_start;
// calculation of parameter N
      (p0 + a*N^2/Vtot^2)*(Vtot - N*b) = N*R*T0;
      annotation(
        experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.004));
    end Pdefault_Tdefault;

    model Pprefer_Tavoid
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.prefer), T(stateSelect = StateSelect.avoid));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Pprefer_Tavoid;

    model Pprefer_Tnever
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.prefer), T(stateSelect = StateSelect.never));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Pprefer_Tnever;

    model Palways_Tnever
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.always), T(stateSelect = StateSelect.never));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Palways_Tnever;
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end UnknownParameter;

  package KnownParameter
    import SI = Modelica.SIunits;
  
    model Pdefault_Tdefault
      parameter SI.Length d = 0.25 "pneumatic chamber diameter";
      parameter SI.Volume Vtot = 0.126 "accumulator total working volume inside the piston stroke";
      parameter SI.Pressure p0 = 750e5 "gas precharge pressure";
      parameter SI.Temperature T0 = 293.15 "gas precharge temperature";
      parameter SI.Pressure p_start = p0 "initial pressure" annotation(
        Dialog(tab = "Initialization"));
      parameter SI.Temperature T_start = T0 "initial temperature" annotation(
        Dialog(tab = "Initialization"));
      final parameter SI.AmountOfSubstance N = 1788.66 "Total amount of gas";
      final parameter SI.Area S = 3.1415 * (d / 2) ^ 2 "piston surface";
      final parameter SI.Length ps = Vtot / S "piston stroke";
      // Gas properties
      final parameter SI.MolarMass MM = 0.028 "molar mass";
      final parameter SI.SpecificHeatCapacityAtConstantPressure Cp = 1040 "specific heat capacity at constant pressure";
      final parameter Real a = 0.1408*1e5/1e6 "Van Der Waals Constant a";
      final parameter Real b = 0.03913/1e3 "Van Der Waals Constant b";
      import Modelica.Constants.R;
      // Variables
      SI.Volume Vg(nominal = Vtot) "gas volume";
      SI.Pressure p(start = p_start, stateSelect = StateSelect.default) "chamber pressure";
      SI.Temperature T(start = T_start, stateSelect = StateSelect.default) "gas temperature";
    equation
  // mechanical equations
      Vg = 0.125 + 0.01 * sin(2 * 3.1415 * time);
  // pneumatic equations
      N * R * T = (p + a * N ^ 2 / Vg ^ 2) * (Vg - N * b);
  // Energy balance
      N * MM * Cp * der(T) - Vg * der(p) = 0;
    initial equation
      p = p_start;
  // calculation of parameter N
      annotation(
        experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.004));
    end Pdefault_Tdefault;
  
    model Pprefer_Tavoid
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.prefer), T(stateSelect = StateSelect.avoid));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Pprefer_Tavoid;
  
    model Pprefer_Tnever
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.prefer), T(stateSelect = StateSelect.never));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Pprefer_Tnever;
  
    model Palways_Tnever
      extends Pdefault_Tdefault(p(stateSelect = StateSelect.always), T(stateSelect = StateSelect.never));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Palways_Tnever;
    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  

  end KnownParameter;
end TestStateSelect;
