package myEVpkg
  model DragForce "Vehicle rolling and aerodinamical drag force"
    import Modelica.Constants.g_n;
    extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
    extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
    Modelica.SIunits.Force f "Total drag force";
    Modelica.SIunits.Velocity v "vehicle velocity";
    Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
    Real Sign;
    parameter Modelica.SIunits.Mass m "vehicle mass";
    parameter Modelica.SIunits.Density rho(start = 1.226) "air density";
    parameter Modelica.SIunits.Area S "vehicle cross area";
    parameter Real fc(start = 0.01) "rolling friction coefficient";
    parameter Real Cx "aerodinamic drag coefficient";
  protected
    parameter Real A = fc * m * g_n;
    parameter Real B = 1 / 2 * rho * S * Cx;
    // Constant auxiliary variable
  equation
//  s = flange.s;
    v = der(s);
    a = der(v);
// Le seguenti definizioni seguono l'ordine e le richieste del modello "PartialFriction" di
// Modelica.Mechanics.Translational.Interfaces"
    v_relfric = v;
    a_relfric = a;
    f0 = A "forza a velocita'  0 ma con scorrimento";
    f0_max = A "massima forza  velocita'  0 e senza scorrimento ";
    free = false "sarebbe true quando la ruota si stacca dalla strada";
// Ora il calcolo di f, e la sua attribuzione alla flangia:
    flange.f - f = 0;
// friction force
    if v > 0 then
      Sign = 1;
    else
      Sign = -1;
    end if;
    f - B * v ^ 2 * Sign = if locked then sa * unitForce else f0 * (if startForward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else if startBackward then -Modelica.Math.tempInterpol1(-v, [0, 1], 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(v, [0, 1], 2) else -Modelica.Math.tempInterpol1(-v, [0, 1], 2));
    annotation(
      Documentation(info = "<html>
            <p>This component models the total (rolling and aerodynamic vehicle drag resistance: </p>
            <p>F=fc*m*g+(1/2)*rho*Cx*S*v^2</p>
            <p>It models reliably the stuck phase. Based on Modelica-Intrerfaces.PartialFriction model</p>
            </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-98, 10}, {22, 10}, {22, 41}, {92, 0}, {22, -41}, {22, -10}, {-98, -10}, {-98, 10}}, lineColor = {0, 127, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Line(points = {{-42, -50}, {87, -50}}, color = {0, 0, 0}), Polygon(points = {{-72, -50}, {-41, -40}, {-41, -60}, {-72, -50}}, lineColor = {0, 0, 0}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Line(points = {{-90, -90}, {-70, -88}, {-50, -82}, {-30, -72}, {-10, -58}, {10, -40}, {30, -18}, {50, 8}, {70, 38}, {90, 72}, {110, 110}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-82, 90}, {80, 50}}, lineColor = {0, 0, 255}, textString = "%name")}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics));
  end DragForce;

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

  package WithRecord
    record Car
      parameter Real m = 1300;
      parameter Real ratio = 3.905;
      parameter Real radius = 0.31;
      parameter Real J = 1.5;
      parameter Real Cx = 0.26;
      parameter Real S = 2.2;
      parameter Real fc = 0.014;
      parameter Real rho = 1.226;
      parameter Real kContr = 100;
      annotation(
        Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
        Icon(graphics = {Text(origin = {-3, 4}, lineColor = {170, 0, 0}, extent = {{-93, 22}, {93, -22}}, textString = "Car"), Rectangle(lineColor = {170, 0, 0}, extent = {{-100, 100}, {100, -100}}), Text(origin = {2, -48}, lineColor = {0, 0, 255}, extent = {{-48, 14}, {48, -14}}, textString = "%name")}));
    end Car;

    model EVbasicMB
      Modelica.SIunits.Energy enP1, enDrag, enP1Pos, enP1Neg, enDC;
      myEVpkg.PropDriver driver(CycleFileName = "AccBrake.txt", k = data.kContr) annotation(
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = data.radius) annotation(
        Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = data.ratio) annotation(
        Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor motSpeed annotation(
        Placement(visible = true, transformation(origin = {-42, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation(
        Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Translational.Components.Mass mass(m = data.m) annotation(
        Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Translational.Sensors.PowerSensor mPDrag annotation(
        Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation(
        Placement(visible = true, transformation(origin = {88, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Nonlinear.Limiter to_mP1Neg(limitsAtInit = true, uMax = 0, uMin = -1e99) annotation(
        Placement(visible = true, transformation(origin = {12, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Nonlinear.Limiter to_mP1Pos(limitsAtInit = true, uMax = 1e99, uMin = 0) annotation(
        Placement(visible = true, transformation(origin = {56, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      myEVpkg.DragForce dragForce(Cx = data.Cx, S = data.S, fc = data.fc, m = mass.m, rho(displayUnit = "kg/m3") = data.rho) annotation(
        Placement(visible = true, transformation(origin = {132, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      wbEHPTlib.MapBased.OneFlange powertrain(J = data.J, effTable = [0, 0, 1; 0, 0.8, 0.8; 1, 0.8, 0.8], effTableName = "effTable", mapsFileName = "EVmaps.txt", mapsOnFile = false, powMax = 50e3, tauMax = 200, uDcNom = 100, wMax = 1000) annotation(
        Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -8}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.Ground ground annotation(
        Placement(visible = true, transformation(origin = {-140, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sensors.PowerSensor pSensor annotation(
        Placement(visible = true, transformation(origin = {-104, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Sources.ConstantVoltage batt(V = 500) annotation(
        Placement(visible = true, transformation(origin = {-140, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      myEVpkg.WithRecord.Car data annotation(
        Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(pSensor.pv, pSensor.pc) annotation(
        Line(points = {{-104, 56}, {-114, 56}, {-114, 46}, {-114, 46}}, color = {0, 0, 255}));
      connect(pSensor.nv, batt.n) annotation(
        Line(points = {{-104, 36}, {-104, 36}, {-104, 26}, {-140, 26}, {-140, 26}}, color = {0, 0, 255}));
      connect(powertrain.pin_n, batt.n) annotation(
        Line(points = {{-80, -4}, {-96, -4}, {-96, 26}, {-140, 26}, {-140, 26}}, color = {0, 0, 255}));
      connect(pSensor.nc, powertrain.pin_p) annotation(
        Line(points = {{-94, 46}, {-86, 46}, {-86, 4}, {-80, 4}, {-80, 4}}, color = {0, 0, 255}));
      connect(batt.p, pSensor.pc) annotation(
        Line(points = {{-140, 46}, {-114, 46}}, color = {0, 0, 255}));
      connect(batt.n, ground.p) annotation(
        Line(points = {{-140, 26}, {-140, 26}, {-140, 16}, {-140, 16}}, color = {0, 0, 255}));
      connect(powertrain.tauRef, driver.tauRef) annotation(
        Line(points = {{-81.4, 0}, {-110, 0}, {-110, 0}, {-109, 0}}, color = {0, 0, 127}));
      connect(powertrain.flange_a, gear.flange_a) annotation(
        Line(points = {{-60, 0}, {-36, 0}, {-36, 0}, {-36, 0}}));
      connect(motSpeed.flange, gear.flange_a) annotation(
        Line(points = {{-42, -16}, {-42, 4.47036e-07}, {-36, 4.47036e-07}}));
      connect(mPDrag.flange_b, dragForce.flange) annotation(
        Line(points = {{116, 0}, {122, 0}}, color = {0, 127, 0}));
      connect(mass.flange_b, mPDrag.flange_a) annotation(
        Line(points = {{80, 0}, {96, 0}}, color = {0, 127, 0}));
      connect(velSens.v, driver.V) annotation(
        Line(points = {{88, -51}, {-120, -51}, {-120, -11.2}}, color = {0, 0, 127}));
      connect(velSens.flange, mass.flange_b) annotation(
        Line(points = {{88, -30}, {88, 0}, {80, 0}}, color = {0, 127, 0}));
      connect(mP1.flange_b, mass.flange_a) annotation(
        Line(points = {{52, 0}, {60, 0}}, color = {0, 127, 0}));
      connect(gear.flange_b, wheel.flangeR) annotation(
        Line(points = {{-16, 0}, {-8, 0}}));
      connect(mP1.power, to_mP1Neg.u) annotation(
        Line(points = {{34, -11}, {34, -32}, {24, -32}}, color = {0, 0, 127}));
      connect(to_mP1Pos.u, mP1.power) annotation(
        Line(points = {{44, -32}, {34, -32}, {34, -11}, {34, -11}}, color = {0, 0, 127}));
      connect(wheel.flangeT, mP1.flange_a) annotation(
        Line(points = {{12, 0}, {32, 0}, {32, 0}, {32, 0}}, color = {0, 127, 0}));
      der(enDrag) = mPDrag.power;
      der(enP1) = mP1.power;
      der(enP1Pos) = to_mP1Pos.y;
      der(enP1Neg) = -to_mP1Neg.y;
      der(enDC) = pSensor.power;
      annotation(
        Diagram(coordinateSystem(extent = {{-150, -60}, {150, 60}}), graphics = {Text(origin = {-14, 52}, extent = {{-30, 2}, {66, -6}}, textString = "Sort1: 150s   NEDC: 1184s   WLTC3: 1800s")}),
        Icon(coordinateSystem(extent = {{-150, -60}, {150, 60}})),
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 80, Tolerance = 1e-06, Interval = 0.04));
    end EVbasicMB;

    record Bus
      parameter Real m = 160000;
      parameter Real ratio = 6;
      parameter Real radius = 0.5715;
      parameter Real J = 5;
      parameter Real Cx = 0.65;
      parameter Real S = 6;
      parameter Real fc = 0.013;
      parameter Real rho = 1.226;
      parameter Real kContr = 1000;
      annotation(
        Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
        Icon(graphics = {Text(origin = {-3, 4}, lineColor = {170, 0, 0}, extent = {{-93, 22}, {93, -22}}, textString = "Bus"), Rectangle(lineColor = {170, 0, 0}, extent = {{-100, 100}, {100, -100}}), Text(origin = {2, -48}, lineColor = {0, 0, 255}, extent = {{-48, 14}, {48, -14}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
    end Bus;
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
  end WithRecord;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(Modelica(version = "3.2.2")));
end myEVpkg;
