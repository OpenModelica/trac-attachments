package WhenPackage
  extends Modelica.Icons.Package;

  model WhenExample
    extends Modelica.Icons.Example;
    parameter String outputFile = "output.dat";
    parameter Modelica.SIunits.Voltage V = 10 "Voltage";
    parameter Modelica.SIunits.Resistance R = 1 "Resistance";
    parameter Modelica.SIunits.Inductance L = 0.5 "Inductance";
    parameter Modelica.SIunits.Time tStart = 1 "Start time";
    final parameter Modelica.SIunits.Time T = L / R "Time constant";
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantvoltage1(V = V) annotation(Placement(visible = true, transformation(origin = {-80, 9.642860000000001}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealclosingswitchOn annotation(Placement(visible = true, transformation(origin = {-50.3571, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(visible = true, transformation(origin = {-80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Electrical.Analog.Basic.Inductor inductor1(L = L) annotation(Placement(visible = true, transformation(origin = {40, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Resistor resistor1(R = R) annotation(Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanStep booleanstep1(startTime = tStart) annotation(Placement(visible = true, transformation(origin = {-69.28570000000001, 50.7143}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    inductor1.i = 0;
  equation
    connect(booleanstep1.y, idealclosingswitchOn.control) annotation(Line(points = {{-58.2857, 50.7143}, {-49.2857, 50.3571}, {-49.2857, 27}, {-50.3571, 27}}));
    connect(constantvoltage1.n, ground.p) annotation(Line(points = {{-80, -0.35714}, {-80, -19.2857}, {-80, -20}}));
    connect(inductor1.n, constantvoltage1.n) annotation(Line(points = {{40, 1.22125e-015}, {40, 0}, {-80, 0}, {-80, -0.35714}}));
    connect(resistor1.n, inductor1.p) annotation(Line(points = {{5.55112e-16, 20}, {39.6429, 20}, {40, 20}}));
    connect(idealclosingswitchOn.n, resistor1.p) annotation(Line(points = {{-40.3571, 20}, {-20, 20}}));
    connect(constantvoltage1.p, idealclosingswitchOn.p) annotation(Line(points = {{-80, 19.6429}, {-80, 20.3571}, {-60.3571, 20.3571}, {-60.3571, 20}}));
    when time >= tStart then
      writeRealParameters(outputFile, {"i0", "di0/dt"}, {0, inductor1.v / L}, append = false);
    end when;
    when time >= tStart + 1 * T then
      writeRealParameters(outputFile, {"i1"}, {resistor1.i}, append = true);
    end when;
    when time >= tStart + 2 * T then
      writeRealParameters(outputFile, {"i2"}, {resistor1.i}, append = true);
    end when;
    when time >= tStart + 5 * T then
      writeRealParameters(outputFile, {"i5"}, {resistor1.i}, append = true);
    end when;
    when terminal() then
      writeRealParameters(outputFile, {"vR", "vL"}, {V, 0}, append = true);
    end when;
    annotation(experiment(StopTime = 11), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end WhenExample;

  function writeRealParameters "Writing multiple real parameters to file"
    input String fileName "Name of file";
    input String name[:] "Name of parameter";
    input Real data[:] "Actual value of parameter";
    input Boolean append = false "Append data to file";
  algorithm
    // Check sizes of name and data
    if size(name, 1) <> size(data, 1) then
      assert(false, "writeReadParameters: Lengths of name and data have to be equal");
    end if;
    // Write data to file
    if not append then
      Modelica.Utilities.Files.removeFile(fileName);
    end if;
    for k in 1:size(name, 1) loop
      Modelica.Utilities.Streams.print(name[k] + " = " + String(data[k]), fileName);
    end for;
  end writeRealParameters;
  annotation(uses(Modelica(version = "3.2.1")));
end WhenPackage;