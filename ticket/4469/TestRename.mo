package TestRename "Electric and Hybrid Power train library Rev March 2017"
  //Symbol to force Dymola to use UTF: €
  //package Propulsion
  extends Modelica.Icons.Package;
  //end Propulsion;

  package MapBased "Contains map-based models of Internal combustion engines and electric drives"
    extends Modelica.Icons.Package;
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, -84}, {-80, 68}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-88, -80}, {78, -80}}, color = {0, 0, 0}, smooth = Smooth.None), Polygon(points = {{94, -80}, {78, -74}, {78, -86}, {94, -80}}, lineColor = {0, 0, 0}, smooth = Smooth.None), Polygon(points = {{8, 0}, {-8, 6}, {-8, -6}, {8, 0}}, lineColor = {0, 0, 0}, smooth = Smooth.None, origin = {-80, 76}, rotation = 90), Line(points = {{-84, 40}, {-14, 40}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-14, 40}, {-4, 2}, {22, -32}, {62, -44}, {62, -80}}, color = {0, 0, 0}, smooth = Smooth.None)}));
  end MapBased;

  model IceT "Simple  map-based ice model with connector"
    import Modelica.Constants.*;
    extends PartialIce;
    parameter Modelica.SIunits.AngularVelocity wIceStart = 167;
    // rad/s
    Modelica.Blocks.Interfaces.RealInput tauRef "torque request (positive when motor)" annotation(
      Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-60, -100}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-60, -100})));
    Modelica.Blocks.Interfaces.RealOutput fuelCons "Fuel consumption (g/h)" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {60, -90})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMin = 0, uMax = 1e99) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-60, -16})));
    Modelica.Blocks.Math.Min min annotation(
      Placement(transformation(extent = {{-48, 50}, {-28, 70}})));
  equation
    connect(toG_perHour.y, fuelCons) annotation(
      Line(points = {{30, -61}, {30, -61}, {26, -61}, {60, -61}, {60, -90}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(limiter.u, tauRef) annotation(
      Line(points = {{-60, -28}, {-60, -100}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(min.u1, toLimTau.y[1]) annotation(
      Line(points = {{-50, 66}, {-58, 66}, {-61, 66}}, color = {0, 0, 127}));
    connect(min.u2, limiter.y) annotation(
      Line(points = {{-50, 54}, {-60, 54}, {-60, -5}}, color = {0, 0, 127}));
    connect(min.y, Tice.tau) annotation(
      Line(points = {{-27, 60}, {-21.5, 60}, {-14, 60}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
      experiment(StopTime = 200, __Dymola_NumberOfIntervals = 1000, __Dymola_Algorithm = "Lsodar"),
      __Dymola_experimentSetupOutput,
      Documentation(info = "<html>
<p>This model belongs to the map-based models of power train components.</p>
<p>It models an Internal Combustion Engine, neglecting any dynamics except that related with its rotor inertia.</p>
<p>The input signal is the torque request (Nm). </p>
<p>The generated torque is the minimum between this signal (negative values are transformed to 0) and the maximum deliverable torque at the actual engine speed, defined by means of a table.</p>
<p>From the generated torque and speed the fuel consumption is computed.</p>
<p>Compare ICE input tau and internal Tice.tau.</p>
</html>"),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Text(extent = {{-100, -44}, {-22, -72}}, lineColor = {0, 0, 127}, textString = "Nm")}));
  end IceT;

  partial model PartialIce "Simple  map-based Internal Combustion Engine model"
    import Modelica.Constants.*;
    parameter Modelica.SIunits.AngularVelocity wIceStart = 167;
    // rad/s
    parameter Modelica.SIunits.MomentOfInertia iceJ = 0.5 "ICE moment of inertia";
    parameter Boolean tablesOnFile = false "= true, if tables are got from a file";
    parameter String mapsFileName = "NoName" "File where matrix is stored" annotation(
      Dialog(enable = tablesOnFile, loadSelector(filter = "Text files (*.txt)", caption = "Open file in which required tables are")));
    parameter Real maxIceTau[:, :] = [0, 80; 100, 80; 350, 95; 500, 95] "First column: speed (rad/s); first column: maximum ICE torque (Nm)" annotation(
      Dialog(enable = not tablesOnFile));
    parameter Real specificCons[:, :] = [0.0, 100, 200, 300, 400, 500; 10, 630, 580, 550, 580, 630; 20, 430, 420, 400, 400, 450; 30, 320, 325, 330, 340, 350; 40, 285, 285, 288, 290, 300; 50, 270, 265, 265, 270, 275; 60, 255, 248, 250, 255, 258; 70, 245, 237, 238, 243, 246; 80, 245, 230, 233, 237, 240; 90, 235, 230, 228, 233, 235] "curve of ice specific consumption (g/kWh)" annotation(
      Dialog(enable = not tablesOnFile));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation(
      Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(
      Placement(visible = true, transformation(extent = {{90, 10}, {110, 30}}, rotation = 0), iconTransformation(extent = {{90, 10}, {110, 30}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor icePow annotation(
      Placement(visible = true, transformation(extent = {{66, 50}, {86, 70}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque Tice annotation(
      Placement(visible = true, transformation(extent = {{-12, 50}, {8, 70}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia ICE(w(fixed = true, start = wIceStart, displayUnit = "rpm"), J = iceJ) annotation(
      Placement(visible = true, transformation(extent = {{16, 50}, {36, 70}}, rotation = 0)));
    Modelica.Blocks.Math.Product toPowW0 annotation(
      Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Product toG_perHour annotation(
      Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    //  Modelica.Blocks.Continuous.Integrator toGrams(k = 1 / 3600000.0)
    // annotation(Placement(visible = true, transformation(origin = {26, -44},
    //extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Tables.CombiTable1D toLimTau(table = maxIceTau) annotation(
      Placement(visible = true, transformation(origin = {-72, 66}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.RealExpression rotorW(y = w.w) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-88, 36})));
    Modelica.Blocks.Math.Gain tokW(k = 1e-3) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {0, -18})));
    Modelica.Blocks.Tables.CombiTable2D toSpecCons(table = specificCons) annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = -90, origin = {40, 0})));
  equation
    connect(toPowW0.u1, w.w) annotation(
      Line(points = {{6, 24}, {6, 33}, {52, 33}}, color = {0, 0, 127}));
    connect(w.flange, ICE.flange_b) annotation(
      Line(points = {{52, 54}, {52, 60}, {36, 60}}));
    connect(icePow.flange_a, ICE.flange_b) annotation(
      Line(points = {{66, 60}, {36, 60}}));
    connect(Tice.flange, ICE.flange_a) annotation(
      Line(points = {{8, 60}, {16, 60}}));
    connect(icePow.flange_b, flange_a) annotation(
      Line(points = {{86, 60}, {94, 60}, {94, 20}, {100, 20}}));
    connect(toLimTau.u[1], rotorW.y) annotation(
      Line(points = {{-84, 66}, {-88, 66}, {-88, 47}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(toPowW0.y, tokW.u) annotation(
      Line(points = {{-2.22045e-015, 1}, {-2.22045e-015, -2}, {2.22045e-015, -2}, {2.22045e-015, -6}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(toSpecCons.y, toG_perHour.u1) annotation(
      Line(points = {{40, -11}, {40, -24}, {36, -24}, {36, -38}}, color = {0, 0, 127}));
    connect(toG_perHour.u2, tokW.y) annotation(
      Line(points = {{24, -38}, {24, -32}, {0, -32}, {0, -29}}, color = {0, 0, 127}));
    connect(toSpecCons.u2, w.w) annotation(
      Line(points = {{46, 12}, {46, 28}, {52, 28}, {52, 33}}, color = {0, 0, 127}));
    connect(toSpecCons.u1, Tice.tau) annotation(
      Line(points = {{34, 12}, {34, 12}, {34, 38}, {34, 42}, {-22, 42}, {-22, 60}, {-14, 60}}, color = {0, 0, 127}));
    connect(toPowW0.u2, Tice.tau) annotation(
      Line(points = {{-6, 24}, {-6, 42}, {-22, 42}, {-22, 60}, {-14, 60}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}})),
      experiment(StopTime = 200, __Dymola_NumberOfIntervals = 1000, __Dymola_Algorithm = "Lsodar"),
      __Dymola_experimentSetupOutput,
      Documentation(info = "<html>
<h4>Basic map-based ICE model.</h4>
<p>It receives as input the reference torque as a fracton of the maximum deliverable torque at a given speed. It can be approximately thought as a signal proportional to the accelerator position oF the vehicle.</p>
<p>The generated torque is the minimum between this signal and the maximum deliverable torque at the actual engine speed (defined by means of a table).</p>
<p>From the generated torque and speed the fuel consumption is computed.</p>
<p>The used maxTorque (toLimTau) and specific fuel consumption (toSpecCons) maps are inspired to public data related to the Toyota Prius&apos; engine </p>
</html>"),
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-24, 68}, {76, -24}}), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.HorizontalCylinder, extent = {{76, 30}, {100, 10}}), Text(origin = {0, 30}, lineColor = {0, 0, 255}, extent = {{-140, 100}, {140, 60}}, textString = "%name"), Rectangle(extent = {{-90, 68}, {-32, -26}}), Rectangle(fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, extent = {{-90, 22}, {-32, 0}}), Line(points = {{-60, 56}, {-60, 32}}), Polygon(points = {{-60, 66}, {-66, 56}, {-54, 56}, {-60, 66}}), Polygon(points = {{-60, 24}, {-66, 34}, {-54, 34}, {-60, 24}}), Rectangle(fillColor = {135, 135, 135}, fillPattern = FillPattern.Solid, extent = {{-64, 0}, {-54, -20}})}));
  end PartialIce;

  model TestIceT
    import TestRename;
    TestRename.IceT iceT(wIceStart = 90) annotation(
      Placement(transformation(extent = {{-20, -2}, {0, 18}})));
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.5, phi(start = 0, fixed = true)) annotation(
      Placement(transformation(extent = {{10, 0}, {30, 20}})));
    Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(w_nominal = 100, tau_nominal = -80) annotation(
      Placement(transformation(extent = {{64, 0}, {44, 20}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(rising = 10, width = 10, falling = 10, period = 1e6, startTime = 10, offset = 60, amplitude = 30) annotation(
      Placement(transformation(extent = {{-50, -38}, {-30, -18}})));
  equation
    connect(iceT.flange_a, inertia.flange_a) annotation(
      Line(points = {{0, 10}, {10, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(inertia.flange_b, loadTorque.flange) annotation(
      Line(points = {{30, 10}, {44, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
    connect(iceT.tauRef, trapezoid.y) annotation(
      Line(points = {{-16, -2}, {-16, -28}, {-29, -28}}, color = {0, 0, 127}, smooth = Smooth.None));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -60}, {80, 40}}), graphics),
      experiment(StopTime = 50),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(extent = {{-60, -60}, {80, 40}})),
      Documentation(info = "<html>
<p>This is a simple test of model IceT.</p>
<p>It shows that the generated torque follows the torque request as long as the maximum allowed is not overcome; otherwise this maximum is generated.</p>
<p>It shows also the fuel consumption output.</p>
<p>The user could compare the torque request tauRef with the torque generated and at the ICE flange (with this transient the inertia torques are very small and can be neglected). The user could also have a look at the rotational speeds and fuel consumption. </p>
</html>"));
  end TestIceT;
  annotation(
    uses(Modelica(version = "3.2.2"), Complex(version = "3.2.2")),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-60, 16}, {78, 16}, {94, 0}, {96, -16}, {-98, -16}, {-90, 0}, {-76, 12}, {-60, 16}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-70, -4}, {-30, -40}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Ellipse(extent = {{34, -6}, {74, -42}}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid), Polygon(points = {{-54, 16}, {-18, 46}, {46, 46}, {74, 16}, {-54, 16}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-86, -6}, {-92, 4}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{98, -10}, {92, -4}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-46, 20}, {-20, 42}, {16, 42}, {14, 20}, {-46, 20}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{22, 42}, {42, 42}, {60, 20}, {20, 20}, {22, 42}}, lineColor = {0, 0, 0}, smooth = Smooth.None, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-60, -12}, {-40, -30}}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Ellipse(extent = {{44, -14}, {64, -32}}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid)}),
    Documentation(info = "<html>
<p>Library containing models of components, subsystems and full vehicle examples for simulation of electric and Hybrid vehicular power trains.</p>
<p>A general description of the library composition and on how to use it effectively is in the compaion paper:</p>
<p>M. Ceraolo &QUOT;Modelica Electric and hybrid power trains library&QUOT; submitted for publication at the 11th International Modelica Conference, 2015, September 21-23, Palais des congr&egrave;s de Versailles, 23-23 September, France</p>
</html>"));
end TestRename;
