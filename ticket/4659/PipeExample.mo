package PipeExample "A simple gas pipe model example for Module 1 of the course"
  model R "Resistive module for the pipe model"
    parameter Modelica.SIunits.Area Av "Friction coefficient";
    parameter Modelica.SIunits.Temperature T_env "Environment temperature";
    parameter Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
    Modelica.Blocks.Interfaces.RealOutput f_E annotation(
      Placement(visible = true,transformation(extent = {{-84, 44}, {-64, 64}}, rotation = 0), iconTransformation(extent = {{-100, 20}, {-140, 60}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput P_E annotation(
      Placement(visible = true,transformation(extent = {{-102, -40}, {-62, 0}}, rotation = 0), iconTransformation(extent = {{-140, -60}, {-100, -20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput P_L annotation(
      Placement(visible = true,transformation(extent = {{-100, -74}, {-60, -34}}, rotation = 0), iconTransformation(extent = {{140, -60}, {100, -20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput f_L annotation(
      Placement(visible = true,transformation(extent = {{-84, 30}, {-64, 50}}, rotation = 0), iconTransformation(extent = {{100, 20}, {140, 60}}, rotation = 0)));
    Modelica.SIunits.Density rho_E "Density of entering fluid";
    Modelica.SIunits.Temperature T "Temperature of fluid";
  equation
// Conservation equations
    f_L = f_E;
    f_E = Av * sqrt(rho_E * (P_E - P_L));
    T = T_env;
// Constitutive equation
    P_E = rho_E * R * T;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 56}, {60, -44}}, lineColor = {0, 0, 127}, textString = "R")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end R;

  model S "Storage module for the pipe model"
    parameter Modelica.SIunits.Volume V "Volume";
    parameter Modelica.SIunits.Temperature T_env "Environment temperature";
    parameter Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
    parameter Modelica.SIunits.Pressure P_start "Initial value of the pressure";
    Modelica.Blocks.Interfaces.RealInput f_E "Entering mass flow" annotation(
      Placement(visible = true,transformation(extent = {{-72, 26}, {-52, 46}}, rotation = 0), iconTransformation(extent = {{-140, 20}, {-100, 60}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput P_E "Entering pressure" annotation(
      Placement(visible = true,transformation(extent = {{-66, -62}, {-26, -22}}, rotation = 0), iconTransformation(extent = {{-100, -60}, {-140, -20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput f_L "Leaving mass flow" annotation(
      Placement(visible = true,transformation(extent = {{-74, 50}, {-54, 70}}, rotation = 0), iconTransformation(extent = {{140, 20}, {100, 60}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput P_L "Leaving pressure" annotation(
      Placement(visible = true,transformation(extent = {{-64, -28}, {-24, 12}}, rotation = 0), iconTransformation(extent = {{100, -60}, {140, -20}}, rotation = 0)));
    Modelica.SIunits.Density rho "Fluid density";
    Modelica.SIunits.Temperature T "Fluid temperature";
    Modelica.SIunits.Mass M "Fluid mass";
  equation
// Conservation equations
    der(M) = f_E - f_L;
    P_E = P_L;
    T = T_env;
// Constitutive equations
    rho = P_L / (R * T);
    M = rho * V;
  initial equation
    P_L = P_start;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 56}, {60, -44}}, lineColor = {0, 0, 127}, textString = "S")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end S;

  model Pipe
    import PipeExample;
    parameter Modelica.SIunits.Volume V "Volume";
    parameter Modelica.SIunits.Area Av "Friction coefficient";
    parameter Modelica.SIunits.Temperature T_env = 298.15 "Environment temperature";
    parameter Modelica.SIunits.SpecificHeatCapacity R = 286 "Gas constant";
    parameter Modelica.SIunits.Pressure P_start "Initial value of the pressure";
    Modelica.Blocks.Interfaces.RealOutput f_E(unit = "kg/s") annotation(
      Placement(visible = true, transformation(extent = {{-86, 0}, {-126, 40}}, rotation = 0), iconTransformation(extent = {{-180, 0}, {-220, 40}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput P_E(unit = "Pa", displayUnit = "bar") annotation(
      Placement(visible = true,transformation(extent = {{-126, -38}, {-86, 2}}, rotation = 0), iconTransformation(extent = {{-220, -38}, {-180, 2}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput P_L(unit = "Pa", displayUnit = "bar") annotation(
      Placement(visible = true, transformation(extent = {{90, -38}, {130, 2}}, rotation = 0), iconTransformation(extent = {{160, -40}, {200, 0}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput f_L(unit = "kg/s") annotation(
      Placement(visible = true, transformation(extent = {{132, 0}, {92, 40}}, rotation = 0), iconTransformation(extent = {{198, 0}, {158, 40}}, rotation = 0)));
    PipeExample.S s(V = V, T_env = T_env, R = R, P_start = P_start) annotation(
      Placement(transformation(extent = {{20, -20}, {60, 20}})));
    PipeExample.R r(Av = Av, T_env = T_env, R = R) annotation(
      Placement(transformation(extent = {{-60, -20}, {-20, 20}})));
  equation
    connect(s.f_L, f_L) annotation(
      Line(points = {{60, 8}, {82, 8}, {82, 20}, {112, 20}}, color = {0, 0, 127}));
    connect(s.P_L, P_L) annotation(
      Line(points = {{60, -8}, {70, -8}, {70, -18}, {110, -18}}, color = {0, 0, 127}));
    connect(f_E, r.f_E) annotation(
      Line(points = {{-106, 20}, {-76, 20}, {-76, 8}, {-60, 8}}, color = {0, 0, 127}));
    connect(P_E, r.P_E) annotation(
      Line(points = {{-106, -18}, {-78, -18}, {-78, -8}, {-60, -8}}, color = {0, 0, 127}));
    connect(r.f_L, s.f_E) annotation(
      Line(points = {{-20, 8}, {20, 8}}, color = {0, 0, 127}));
    connect(r.P_L, s.P_E) annotation(
      Line(points = {{-20, -8}, {20, -8}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-220, -100}, {220, 100}}), graphics = {Rectangle(origin = {-2, -14}, lineColor = {0, 0, 127}, fillColor = {28, 108, 200}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-178, 54}, {162, -26}}), Text(lineColor = {255, 255, 255}, fillColor = {28, 108, 200}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 42}, {100, -32}}, textString = "Pipe")}),
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-220, -100}, {220, 100}})),
      __OpenModelica_commandLineOptions = "");
  end Pipe;


  model PS "Pressure source component"
    parameter Modelica.SIunits.Pressure P "Fixed pressure";
    Modelica.Blocks.Interfaces.RealOutput P_L annotation(
      Placement(visible = true, transformation(extent = {{-64, -28}, {-24, 12}}, rotation = 0), iconTransformation(extent = {{100, -60}, {140, -20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput f_L annotation(
      Placement(visible = true, transformation(extent = {{-74, 50}, {-54, 70}}, rotation = 0), iconTransformation(extent = {{140, 20}, {100, 60}}, rotation = 0)));
  equation
    P_L = P;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-62, 58}, {60, -50}}, lineColor = {0, 0, 127}, textString = "PS")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end PS;

  model FS "Flow sink component"
    Modelica.Blocks.Interfaces.RealInput P_L annotation(
      Placement(visible = true, transformation(extent = {{-64, -28}, {-24, 12}}, rotation = 0), iconTransformation(extent = {{-140, -60}, {-100, -20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput f_L annotation(
      Placement(visible = true, transformation(extent = {{-74, 50}, {-54, 70}}, rotation = 0), iconTransformation(extent = {{-100, 20}, {-140, 60}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput f_in annotation(
      Placement(visible = true, transformation(extent = {{-92, 82}, {-52, 122}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  equation
    f_L = f_in;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-62, 58}, {60, -50}}, lineColor = {0, 0, 127}, textString = "FS")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end FS;

  model System
    FS sink annotation(
      Placement(transformation(extent = {{32, -10}, {52, 10}})));
    PS source(P = 961100) annotation(
      Placement(transformation(extent = {{-52, -10}, {-32, 10}})));
    Pipe pipe(V = 8.83125, Av = 0.00404137, T_env = 293.15, P_start = 816677) annotation(
      Placement(transformation(extent = {{-16, -10}, {16, 10}})));
    Modelica.Blocks.Sources.Step outletFlow(offset = 5.2, startTime = 20, height = 0.8) annotation(
      Placement(visible = true, transformation(origin = {70, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(outletFlow.y, sink.f_in) annotation(
      Line(points = {{59, 30}, {42, 30}, {42, 10}}, color = {0, 0, 127}));
    connect(source.P_L, pipe.P_E) annotation(
      Line(points = {{-30, -4}, {-24, -4}, {-24, -2}, {-20, -2}, {-20, -2}}, color = {0, 0, 127}));
    connect(source.f_L, pipe.f_E) annotation(
      Line(points = {{-30, 4}, {-24, 4}, {-24, 2}, {-22, 2}, {-22, 2}, {-20, 2}}, color = {0, 0, 127}));
    connect(sink.f_L, pipe.f_L) annotation(
      Line(points = {{32, 4}, {24, 4}, {24, 2}, {16, 2}}, color = {0, 0, 127}));
    connect(pipe.P_L, sink.P_L) annotation(
      Line(points = {{16, -2}, {24, -2}, {24, -4}, {32, -4}, {32, -4}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false)),
      Diagram(coordinateSystem(preserveAspectRatio = false)),
      experiment(StopTime = 100));
  end System;
  annotation(
    uses(Modelica(version = "3.2.2")));
end PipeExample;
