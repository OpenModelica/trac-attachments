package MWE

  model TaskPool_SatInt
    parameter Real k[:] = {0.01, 0.02, 0.05} "completion integrator gains";
    Modelica.Blocks.Interfaces.RealInput c[N] "cores to tasks" annotation(
      Placement(visible = true, transformation(origin = {-108, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput compl01[N](each start = 0, each fixed = true) "completions [0,1]" annotation(
      Placement(visible = true, transformation(origin = {56, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    final parameter Integer N = size(k, 1);
  equation
    for i in 1:N loop
      der(compl01[i]) = if compl01[i] < 0 or compl01[i] > 1 then 0 else k[i] * c[i];
    end for;
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(graphics = {Rectangle(fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-2, 0}, extent = {{-66, 74}, {66, -74}}, textString = "Tpool\nSatInt")}));
  end TaskPool_SatInt;
  
  model CompletionSPs
    parameter Real release_times[:]={10,20,30} "task release times";
    parameter Real relative_deadlines[N]={100,10,50} "task deadlimes relative to release";
    final parameter Integer N=size(release_times,1);
    Real sps[N](each start=0.0,each fixed=true);
  Modelica.Blocks.Interfaces.RealOutput SPs[N] annotation(
      Placement(visible = true, transformation(origin = {84, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    SPs = sps;
    for i in 1:N loop
      der(sps[i])=if time>=release_times[i] and time<=release_times[i]+relative_deadlines[i]
               then 1/relative_deadlines[i]
               else 0;
    end for;
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.066778),
  Icon(graphics = {Rectangle(fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-7, 0}, extent = {{-61, 56}, {71, -62}}, textString = "Compl\nSPs")}));
  end CompletionSPs;

  model Controller_eq
    parameter Integer N=3;
    parameter Real K=10;
    Modelica.Blocks.Interfaces.RealInput SP[N] annotation(
      Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput PV[N] annotation(
      Placement(visible = true, transformation(origin = {-180, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput CS[N] annotation(
      Placement(visible = true, transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  equation
    CS = K * (SP - PV);
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(graphics = {Rectangle(origin = {1, 0}, fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {38, -13}, extent = {{-92, 75}, {12, -41}}, textString = "C_eq")}, coordinateSystem(initialScale = 0.1)));
  end Controller_eq;

  model Controller_alg
    parameter Integer N=3;
    parameter Real K=10;
    parameter Real Ts=0.5;
    Modelica.Blocks.Interfaces.RealInput SP[N] annotation(
      Placement(visible = true, transformation(origin = {-180, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput PV[N] annotation(
      Placement(visible = true, transformation(origin = {-180, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput CS[N] annotation(
      Placement(visible = true, transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    discrete Real cs[N](each start=0.0, each fixed=true);
  equation
    CS = cs;
  algorithm
    when sample(0, Ts) then
      cs := K * (SP - PV);
    end when;
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(graphics = {Rectangle(origin = {1, 0}, fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {28, -7}, extent = {{-92, 75}, {24, -55}}, textString = "C_alg")}, coordinateSystem(initialScale = 0.1)));
  end Controller_alg;

  
  model Test_controllers
    Controller_eq Ceq annotation(
      Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Controller_alg Calg annotation(
      Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression SP[3](each y=0.0) annotation(
      Placement(visible = true, transformation(origin = {-110, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid PV[3](each falling = 2, each nperiod = 1, each period = 8, each rising = 2, each startTime = 1, each width = 2)  annotation(
      Placement(visible = true, transformation(origin = {-110, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    connect(PV.y, Ceq.PV) annotation(
      Line(points = {{-98, -16}, {-60, -16}, {-60, 24}, {-20, 24}, {-20, 24}}, color = {0, 0, 127}, thickness = 0.5));
    connect(PV.y, Calg.PV) annotation(
      Line(points = {{-99, -16}, {-20, -16}}, color = {0, 0, 127}, thickness = 0.5));
    connect(SP.y, Calg.SP) annotation(
      Line(points = {{-98, 36}, {-40, 36}, {-40, -4}, {-20, -4}, {-20, -4}}, color = {0, 0, 127}, thickness = 0.5));
    connect(SP.y, Ceq.SP) annotation(
      Line(points = {{-98, 36}, {-22, 36}, {-22, 36}, {-20, 36}}, color = {0, 0, 127}, thickness = 0.5));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.00333333));
  end Test_controllers;

  model Loop_eq
    MWE.CompletionSPs CSP annotation(
      Placement(visible = true, transformation(origin = {-70, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MWE.TaskPool_SatInt Pool annotation(
      Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    MWE.Controller_eq C annotation(
      Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Pool.compl01, C.PV) annotation(
      Line(points = {{60, 10}, {70, 10}, {70, -20}, {-30, -20}, {-30, 4}, {-20, 4}, {-20, 4}}, color = {0, 0, 127}, thickness = 0.5));
    connect(C.CS, Pool.c) annotation(
      Line(points = {{0, 10}, {38, 10}, {38, 10}, {40, 10}}, color = {0, 0, 127}, thickness = 0.5));
    connect(CSP.SPs, C.SP) annotation(
      Line(points = {{-60, 16}, {-20, 16}}, color = {0, 0, 127}, thickness = 0.5));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.05));
  end Loop_eq;

  model Loop_alg
  MWE.CompletionSPs CSP annotation(
      Placement(visible = true, transformation(origin = {-70, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MWE.TaskPool_SatInt Pool annotation(
      Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MWE.Controller_alg C annotation(
      Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Pool.compl01, C.PV) annotation(
      Line(points = {{60, 10}, {70, 10}, {70, -20}, {-30, -20}, {-30, 4}, {-20, 4}, {-20, 4}}, color = {0, 0, 127}, thickness = 0.5));
    connect(C.CS, Pool.c) annotation(
      Line(points = {{0, 10}, {38, 10}, {38, 10}, {40, 10}}, color = {0, 0, 127}, thickness = 0.5));
    connect(CSP.SPs, C.SP) annotation(
      Line(points = {{-60, 16}, {-20, 16}}, color = {0, 0, 127}, thickness = 0.5));
    annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      experiment(StartTime = 0, StopTime = 150, Tolerance = 1e-06, Interval = 0.05));
  end Loop_alg;







  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  uses(Modelica(version = "3.2.2")));
end MWE;
