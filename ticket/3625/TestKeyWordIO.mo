within ;
package TestKeyWordIO
  model RLOn
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Voltage V = 10 "Voltage";
    parameter Modelica.SIunits.Resistance R = 1 "Resistance";
    parameter Modelica.SIunits.Inductance L = 0.5 "Inductance";
    parameter Modelica.SIunits.Time tStart = 1 "Start time";
    final parameter Modelica.SIunits.Time T = L / R "Time constant";
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantvoltage1(V = V) annotation(Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealclosingswitchOn annotation(Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = L) annotation(Placement(visible = true, transformation(origin = {40, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = R) annotation(Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanStep booleanstep1(startTime = tStart) annotation(Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(constantvoltage1.n, ground.p) annotation(Line(points = {{-80, 1.22125e-15}, {-80, 1.22125e-15}, {-80, -20}}));
    connect(inductor1.n, constantvoltage1.n) annotation(Line(points = {{40, 1.22125e-15}, {40, 0}, {-80, 0}, {-80, 1.22125e-15}}));
    connect(resistor1.n, inductor1.p) annotation(Line(points = {{5.55112e-16, 20}, {39.6429, 20}, {40, 20}}));
    connect(idealclosingswitchOn.n, resistor1.p) annotation(Line(points = {{-40, 20}, {-20, 20}}));
    connect(constantvoltage1.p, idealclosingswitchOn.p) annotation(Line(points = {{-80, 20}, {-80, 20.3571}, {-60, 20.3571}, {-60, 20}}));
    connect(booleanstep1.y, idealclosingswitchOn.control) annotation(Line(points = {{-59, 50}, {-50, 50}, {-50, 27}}, color = {255, 0, 255}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
  end RLOn;

  model RLOn_io
    parameter String inputFile = Modelica.Utilities.Files.loadResource("modelica://TestKeyWordIO/input.dat")
      "Input data file";
    parameter String outputFile = Modelica.Utilities.Files.loadResource("modelica://TestKeyWordIO/output.dat")
      "Output data file";
    extends RLOn(V = KeyWordIO.readRealParameter(                                 inputFile, "V"), R = KeyWordIO.readRealParameter(
                                                                                                  inputFile, "R"), L = KeyWordIO.readRealParameter(
                                                                                                  inputFile, "L"));
  equation
    when time >= tStart then
      KeyWordIO.writeRealVariables(
            outputFile,
            {"i0","di0/dt"},
            {0,inductor1.v/L},
            append=false);
    end when;
    when time >= tStart + 1 * T then
      KeyWordIO.writeRealVariables(
            outputFile,
            {"i1"},
            {resistor1.i},
            append=true);
    end when;
    when time >= tStart + 2 * T then
      KeyWordIO.writeRealVariables(
            outputFile,
            {"i2"},
            {resistor1.i},
            append=true);
    end when;
    when time >= tStart + 5 * T then
      KeyWordIO.writeRealVariables(
            outputFile,
            {"i5"},
            {resistor1.i},
            append=true);
    end when;
    when terminal() then
      KeyWordIO.writeRealVariables(
            outputFile,
            {"vR","vL"},
            {V,0},
            append=true);
    end when;
    annotation(experiment(StopTime = 11));
  end RLOn_io;
  annotation (uses(CPE3_Instructor(version="0.5.0"), Modelica(version="3.2.1")));
end TestKeyWordIO;
