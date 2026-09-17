model InductionMotor
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistorNum(R_ref = {100E3, 100E3, 100E3}, m = 3)  annotation(
    Placement(visible = true, transformation(origin = {46, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starNum annotation(
    Placement(visible = true, transformation(origin = {76, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundNum annotation(
    Placement(visible = true, transformation(origin = {86, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta delta annotation(
    Placement(visible = true, transformation(origin = {54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-10, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.IdealClosingSwitch idealCloser(m = 3)  annotation(
    Placement(visible = true, transformation(origin = {-44, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor annotation(
    Placement(visible = true, transformation(origin = {-14, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor annotation(
    Placement(visible = true, transformation(origin = {16, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starSensor annotation(
    Placement(visible = true, transformation(origin = {-14, 2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starSource annotation(
    Placement(visible = true, transformation(origin = {-48, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageRMSSensor annotation(
    Placement(visible = true, transformation(origin = {56, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0)  annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout = 3)  annotation(
    Placement(visible = true, transformation(origin = {-60, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imc(Jr = 1.6, Lm = 30.06E-3, Lrsigma = 2.213E-3, Lssigma(start = 2.213E-3), Rr = 95.47E-3, Rs(start = 75.07E-3), fsNominal = 50, gamma(displayUnit = "rad"), gammar(displayUnit = "rad"), gammas(displayUnit = "rad"), m = 3, p = 4, wMechanical(displayUnit = "rad/s"))  annotation(
    Placement(visible = true, transformation(origin = {26, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource( V = {480, 480, 480}, f = 50,gamma(displayUnit = "rad"), m = 3)  annotation(
    Placement(visible = true, transformation(origin = {-72, -30}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.TerminalBox terminalBox(m = 3, terminalConnection = "Y")  annotation(
    Placement(visible = true, transformation(origin = {26, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
connect(voltageSource.plug_p, idealCloser.plug_p) annotation(
    Line(points = {{-72, -20}, {-72, 32}, {-54, 32}}, color = {85, 170, 255}));
connect(voltageSource.plug_n, starSource.plug_p) annotation(
    Line(points = {{-72, -40}, {-72, -40}, {-72, -68}, {-58, -68}, {-58, -68}}, color = {85, 170, 255}));
connect(idealCloser.plug_n, powerSensor.currentP) annotation(
    Line(points = {{-34, 32}, {-24, 32}, {-24, 32}, {-24, 32}}, color = {85, 170, 255}));
connect(powerSensor.currentN, currentRMSSensor.plug_p) annotation(
    Line(points = {{-4, 32}, {6, 32}, {6, 32}, {6, 32}}, color = {85, 170, 255}));
connect(currentRMSSensor.plug_n, resistorNum.plug_p) annotation(
    Line(points = {{26, 32}, {36, 32}, {36, 32}, {36, 32}}, color = {85, 170, 255}));
connect(resistorNum.plug_n, starNum.plug_p) annotation(
    Line(points = {{56, 32}, {66, 32}, {66, 32}, {66, 32}}, color = {85, 170, 255}));
connect(starNum.pin_n, groundNum.pin) annotation(
    Line(points = {{86, 32}, {86, 32}, {86, 24}, {86, 24}}, color = {85, 170, 255}));
connect(powerSensor.voltageN, starSensor.plug_p) annotation(
    Line(points = {{-14, 22}, {-14, 22}, {-14, 12}, {-14, 12}}, color = {85, 170, 255}));
connect(starSensor.pin_n, starSource.pin_n) annotation(
    Line(points = {{-14, -8}, {-14, -8}, {-14, -34}, {-38, -34}, {-38, -68}, {-38, -68}}, color = {85, 170, 255}));
connect(starSource.pin_n, ground1.pin) annotation(
    Line(points = {{-38, -68}, {-20, -68}, {-20, -68}, {-20, -68}}, color = {85, 170, 255}));
connect(terminalBox.starpoint, ground1.pin) annotation(
    Line(points = {{16, -58}, {-20, -58}, {-20, -68}}, color = {85, 170, 255}));
connect(imc.plug_sp, terminalBox.plug_sp) annotation(
    Line(points = {{32, -70}, {32, -60}}, color = {85, 170, 255}));
connect(imc.plug_sn, terminalBox.plug_sn) annotation(
    Line(points = {{20, -70}, {20, -60}}, color = {85, 170, 255}));
connect(currentRMSSensor.plug_n, terminalBox.plugSupply) annotation(
    Line(points = {{26, 32}, {26, -58}}, color = {85, 170, 255}));
connect(currentRMSSensor.plug_n, delta.plug_p) annotation(
    Line(points = {{26, 32}, {26, 32}, {26, -2}, {44, -2}, {44, -2}}, color = {85, 170, 255}));
connect(voltageRMSSensor.plug_p, delta.plug_p) annotation(
    Line(points = {{46, -24}, {40, -24}, {40, -2}, {44, -2}, {44, -2}}, color = {85, 170, 255}));
connect(voltageRMSSensor.plug_n, delta.plug_n) annotation(
    Line(points = {{66, -24}, {74, -24}, {74, -2}, {64, -2}, {64, -2}}, color = {85, 170, 255}));
connect(booleanStep.y, booleanReplicator.u) annotation(
    Line(points = {{-78, 50}, {-72, 50}, {-72, 50}, {-72, 50}}, color = {255, 0, 255}));
connect(booleanReplicator.y, idealCloser.control) annotation(
    Line(points = {{-48, 50}, {-44, 50}, {-44, 44}, {-44, 44}}, color = {255, 0, 255}, thickness = 0.5));
connect(powerSensor.voltageP, powerSensor.currentP) annotation(
    Line(points = {{-14, 42}, {-24, 42}, {-24, 32}, {-24, 32}}, color = {85, 170, 255}));
end InductionMotor;