package Test1 "Package containing basic EV models"
  model EVbasic "Simulates a very basic Electric Vehicle"
    import Modelica;
    DragForce dragF(Cx = 0.65, rho = 1.226, S = 6.0, fc = 0.013, m = mass.m) annotation(
      Placement(visible = true, transformation(origin = {104, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 6) annotation(
      Placement(visible = true, transformation(origin = {-26, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque annotation(
      Placement(visible = true, transformation(extent = {{-92, 12}, {-72, 32}}, rotation = 0)));
    Test1.PropDriver driver(k = 1000, yMax = 100000.0, CycleFileName = "Sort1.txt") annotation(
      Placement(visible = true, transformation(extent = {{-130, 12}, {-110, 32}}, rotation = 0)));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP2 annotation(
      Placement(visible = true, transformation(origin = {104, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation(
      Placement(visible = true, transformation(origin = {28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Translational.Components.Mass mass(m = 16000) annotation(
      Placement(visible = true, transformation(extent = {{46, 12}, {66, 32}}, rotation = 0)));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation(
      Placement(visible = true, transformation(origin = {78, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.5715) annotation(
      Placement(visible = true, transformation(extent = {{-8, 12}, {12, 32}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor motSpeed annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-40, 0})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 5) annotation(
      Placement(transformation(extent = {{-64, 12}, {-44, 32}})));
  equation
    connect(torque.tau, driver.tauRef) annotation(
      Line(points = {{-94, 22}, {-109, 22}}, color = {0, 0, 127}));
    connect(driver.V, velSens.v) annotation(
      Line(points = {{-120, 10.8}, {-120, -34}, {78, -34}, {78, -19}}, color = {0, 0, 127}));
    connect(mP1.flange_a, wheel.flangeT) annotation(
      Line(points = {{18, 22}, {12, 22}}, color = {0, 127, 0}));
    connect(gear.flange_b, wheel.flangeR) annotation(
      Line(points = {{-16, 22}, {-16, 22}, {-8, 22}}));
    connect(velSens.flange, mP2.flange_a) annotation(
      Line(points = {{78, 2}, {78, 22}, {104, 22}}, color = {0, 127, 0}));
    connect(mass.flange_a, mP1.flange_b) annotation(
      Line(points = {{46, 22}, {38, 22}}, color = {0, 127, 0}));
    connect(mP2.flange_a, mass.flange_b) annotation(
      Line(points = {{104, 22}, {66, 22}}, color = {0, 127, 0}));
    connect(dragF.flange, mP2.flange_b) annotation(
      Line(points = {{104, -18}, {104, 2}}, color = {0, 127, 0}));
    connect(motSpeed.flange, gear.flange_a) annotation(
      Line(points = {{-40, 10}, {-40, 22}, {-36, 22}}, color = {0, 0, 0}));
    connect(inertia.flange_a, torque.flange) annotation(
      Line(points = {{-64, 22}, {-68, 22}, {-72, 22}}, color = {0, 0, 0}));
    connect(inertia.flange_b, gear.flange_a) annotation(
      Line(points = {{-44, 22}, {-36, 22}}, color = {0, 0, 0}));
    annotation(
      experimentSetupOutput(derivatives = false),
      Documentation(info = "<html>
             <p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2015-16.</p>
              <p>OM 23136 OK </p>
             </html>"),
      Commands,
      Icon(coordinateSystem(extent = {{-120, -60}, {120, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
      experiment(StartTime = 0, StopTime = 200, Tolerance = 0.0001, Interval = 0.1),
      Diagram(coordinateSystem(extent = {{-140, -40}, {120, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
  end EVbasic;

  model PropDriver "Simple Proportional controller driver"
    parameter String CycleFileName = "MyCycleName.txt" "Drive Cycle Name ex: \"sort1.txt\"";
    parameter Real k(unit = "N.m/(m/s)") "Controller gain";
    parameter Real yMax(unit = "N.m") = 1000000.0 "Max output value (absolute)";
    parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint;
    Modelica.Blocks.Interfaces.RealInput V annotation(
      Placement(transformation(extent = {{-14, -14}, {14, 14}}, rotation = 90, origin = {0, -114}), iconTransformation(extent = {{-12, -12}, {12, 12}}, rotation = 90, origin = {0, -112})));
    Modelica.Blocks.Interfaces.RealOutput tauRef(unit = "N.m") annotation(
      Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Sources.CombiTimeTable driveCyc(columns = {2}, extrapolation = extrapolation, fileName = CycleFileName, tableName = "Cycle", tableOnFile = true) annotation(
      Placement(transformation(extent = {{-86, -10}, {-66, 10}})));
    //    fileName=Modelica.Utilities.Files.loadResource("modelica://EVPkg1718eng/"+CycleFileName))   annotation (
    Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh annotation(
      Placement(transformation(extent = {{-48, -10}, {-28, 10}})));
    Modelica.Blocks.Math.Feedback feedback annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Gain gain(k = k) annotation(
      Placement(transformation(extent = {{32, -10}, {52, 10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax = yMax) annotation(
      Placement(transformation(extent = {{70, -10}, {90, 10}})));
  equation
    connect(from_kmh.u, driveCyc.y[1]) annotation(
      Line(points = {{-50, 0}, {-65, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(from_kmh.y, feedback.u1) annotation(
      Line(points = {{-27, 0}, {-8, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(feedback.u2, V) annotation(
      Line(points = {{0, -8}, {0, -114}, {1.77636e-015, -114}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(feedback.y, gain.u) annotation(
      Line(points = {{9, 0}, {30, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(gain.y, limiter.u) annotation(
      Line(points = {{53, 0}, {68, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(tauRef, limiter.y) annotation(
      Line(points = {{110, 0}, {91, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
      Documentation(info = "<html>
            <p>Modello semplice di pilota.</p>
            <p>Esso contiene al suo interno il ciclo di riferimento, che insegue attraverso un regolatore solo proporzionale.</p>
            </html>"),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(fillColor = {255, 213, 170}, fillPattern = FillPattern.Solid, extent = {{-23, 26}, {-12, 0}}, endAngle = 360), Text(origin = {0, 1.81063}, lineColor = {0, 0, 255}, extent = {{-104, 142.189}, {98, 104}}, textString = "%name"), Polygon(fillColor = {215, 215, 215}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-22, -56}, {-42, -84}, {-16, -84}, {16, -84}, {-22, -56}}), Polygon(fillColor = {135, 135, 135}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-32, 44}, {-62, -48}, {-30, -48}, {-30, -48}, {-32, 44}}, smooth = Smooth.Bezier), Polygon(fillColor = {135, 135, 135}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-68, -32}, {-14, -86}, {10, -46}, {0, -46}, {-68, -32}}, smooth = Smooth.Bezier), Polygon(fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, points = {{-22, 14}, {-30, 10}, {-40, -44}, {2, -42}, {2, -30}, {0, 6}, {-22, 14}}, smooth = Smooth.Bezier), Ellipse(fillColor = {255, 213, 170}, fillPattern = FillPattern.Solid, extent = {{-30, 48}, {-3, 14}}, endAngle = 360), Polygon(pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-38, 38}, {-16, 54}, {-2, 40}, {4, 40}, {6, 40}, {-38, 38}}, smooth = Smooth.Bezier), Polygon(fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{30, -40}, {-32, -24}, {-36, -40}, {-24, -54}, {30, -40}}, smooth = Smooth.Bezier), Polygon(fillPattern = FillPattern.Solid, points = {{42, -66}, {36, -80}, {48, -74}, {52, -68}, {50, -64}, {42, -66}}, smooth = Smooth.Bezier), Line(points = {{48, -10}, {26, 4}, {26, 4}}, thickness = 0.5), Line(points = {{20, -6}, {34, 14}, {34, 14}}, thickness = 0.5), Polygon(fillColor = {255, 213, 170}, fillPattern = FillPattern.Solid, points = {{28, 8}, {32, 12}, {28, 6}, {34, 10}, {30, 6}, {34, 8}, {30, 4}, {26, 6}, {34, 4}, {26, 4}, {26, 6}, {28, 8}, {28, 8}, {26, 6}, {26, 6}, {26, 6}, {28, 12}, {28, 10}, {28, 8}}, smooth = Smooth.Bezier), Polygon(fillColor = {175, 175, 175}, fillPattern = FillPattern.Solid, points = {{-18, 4}, {28, 10}, {26, 2}, {-16, -12}, {-20, -12}, {-24, -2}, {-18, 4}}, smooth = Smooth.Bezier), Polygon(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, points = {{72, -2}, {48, -2}, {36, -22}, {58, -82}, {72, -82}, {72, -2}}), Polygon(fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{49, -90}, {17, -36}, {7, -40}, {-1, -46}, {49, -90}}, smooth = Smooth.Bezier), Line(points = {{-7, 35}, {-3, 33}}), Line(points = {{-9, 22}, {-5, 22}}), Line(points = {{-7, 35}, {-3, 35}}), Text(extent = {{-82, 98}, {94, 58}}, lineColor = {238, 46, 47}, textString = "%CycleFileName")}));
  end PropDriver;
  annotation(
    uses(Modelica(version = "3.2.2")));
end Test1;
