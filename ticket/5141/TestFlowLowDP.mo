package TestFlowLowDP
  model Test1
    ThermoPower.Water.SourcePressure source(T = 150 + 273.15, p0 = 1.1e5, use_T = true) annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.SinkPressure sink(p0 = 1e5) annotation(
      Placement(visible = true, transformation(origin = {120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.ValveVap valve1(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, dpnom = 5000, pnom = 1.1e5, rhonom = 0.6, useThetaInput = true, wnom = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.ValveVap valve2(CvData = ThermoPower.Choices.Valve.CvTypes.OpPoint, dpnom (displayUnit = "Pa") = 5000, pnom = 1.05e5, rhonom = 0.6, useThetaInput = true, wnom = 1) annotation(
      Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.Header volume1(V = 1, pstart = 1.05e5) annotation(
      Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.Header volume2(V = 1, pstart = 1.e5) annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.PressDrop pressDrop1(FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, dpnom = 10, rhonom = 0.6, wnom = 1) annotation(
      Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermoPower.Water.PressDrop pressDrop2(FFtype = ThermoPower.Choices.PressDrop.FFtypes.OpPoint, dpnom = 10, rhonom = 0.6, wnom = 1) annotation(
      Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step valveOpening(height = -1, offset = 1, startTime = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    inner ThermoPower.System system(allowFlowReversal = false, initOpt = ThermoPower.Choices.Init.Options.steadyState) annotation(
      Placement(visible = true, transformation(origin = {108, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(valveOpening.y, valve2.theta) annotation(
      Line(points = {{-108, 50}, {90, 50}, {90, 8}, {90, 8}}, color = {0, 0, 127}));
    connect(valveOpening.y, valve1.theta) annotation(
      Line(points = {{-108, 50}, {-90, 50}, {-90, 8}, {-90, 8}}, color = {0, 0, 127}));
    connect(valve2.outlet, sink.flange) annotation(
      Line(points = {{100, 0}, {110, 0}, {110, 0}, {110, 0}}, color = {0, 0, 255}));
    connect(volume2.outlet, valve2.inlet) annotation(
      Line(points = {{60, 0}, {80, 0}, {80, 0}, {80, 0}}, color = {0, 0, 255}));
    connect(pressDrop2.outlet, volume2.inlet) annotation(
      Line(points = {{26, 0}, {40, 0}, {40, 0}, {40, 0}}, color = {0, 0, 255}));
    connect(pressDrop1.outlet, pressDrop2.inlet) annotation(
      Line(points = {{-8, 0}, {6, 0}, {6, 0}, {6, 0}}, color = {0, 0, 255}));
    connect(volume1.outlet, pressDrop1.inlet) annotation(
      Line(points = {{-40, 0}, {-28, 0}, {-28, 0}, {-28, 0}}, color = {0, 0, 255}));
    connect(valve1.outlet, volume1.inlet) annotation(
      Line(points = {{-80, 0}, {-60, 0}, {-60, 0}, {-60, 0}}, color = {0, 0, 255}));
    connect(source.flange, valve1.inlet) annotation(
      Line(points = {{-110, 0}, {-100, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 255}));
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 0.12, Tolerance = 1e-06, Interval = 0.0004),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"));
  end Test1;




  model Test2
    extends Test1(pressDrop2.dpnom = 50);
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 0.12, Tolerance = 1e-06, Interval = 0.0004));
  
  end Test2;

  model Test3
    extends Test1;
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 0.12, Tolerance = 1e-06, Interval = 0.0004),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", noEquidistantTimeGrid = "()", outputFormat = "mat", s = "dassl"));
  end Test3;



  model Test4
    extends Test1;
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-07, Interval = 0.0004),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", noEquidistantTimeGrid = "()", outputFormat = "mat", s = "dassl"));
  end Test4;

  model Test5
    extends Test1(volume2.p(stateSelect=StateSelect.avoid));
    Modelica.SIunits.PressureDifference dp(stateSelect=StateSelect.prefer) = volume2.p - volume1.p;
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 0.12, Tolerance = 1e-03, Interval = 0.0004),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", noEquidistantTimeGrid = "()", outputFormat = "mat", s = "dassl"));
  end Test5;

  model Test6
    extends Test1(volume2.p(stateSelect = StateSelect.avoid));
    Modelica.SIunits.PressureDifference dp(stateSelect = StateSelect.prefer) = volume2.p - volume1.p;
    annotation(
      uses(ThermoPower(version = "3.1"), Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})),
      experiment(StartTime = 0, StopTime = 0.12, Tolerance = 1e-06, Interval = 0.0004),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", noEquidistantTimeGrid = "()", outputFormat = "mat", s = "dassl"));
  end Test6;















end TestFlowLowDP;
