package TestFile
  model TestWrite1
    Real x(start = 1, fixed = true);
    Real y(start = 1, fixed = true);
    Real z(start = 1, fixed = true);
    parameter String fileName = "output.dat";
  equation
    der(x) = 1;
    der(y) = x;
    der(z) = y;
    when terminal() then
      Modelica.Utilities.Files.removeFile(fileName);
      Modelica.Utilities.Streams.print("x = " + String(x), fileName);
      Modelica.Utilities.Streams.print("y = " + String(y), fileName);
      Modelica.Utilities.Streams.print("z = " + String(z), fileName);
    end when;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end TestWrite1;

  model TestWrite2
    Real x(start = 1, fixed = true);
    Real y(start = 1, fixed = true);
    Real z(start = 1, fixed = true);
    parameter String fileName = "output.dat";
  equation
    der(x) = 1;
    der(y) = x;
    der(z) = y;
    when terminal() then
      writeRealParameter(fileName, "x", x, append = false);
      writeRealParameter(fileName, "y", y, append = true);
      writeRealParameter(fileName, "z", z, append = true);
    end when;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end TestWrite2;

  model TestWrite3
    Real x(start = 1, fixed = true);
    Real y(start = 1, fixed = true);
    Real z(start = 1, fixed = true);
    parameter String fileName = "output.dat";
  equation
    der(x) = 1;
    der(y) = x;
    der(z) = y;
    when terminal() then
      writeRealParameter(fileName, "z", z, append = true);
      writeRealParameter(fileName, "y", y, append = true);
      writeRealParameter(fileName, "x", x, append = false);
    end when;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end TestWrite3;

  function writeRealParameter "Writing real parameter to file"
    input String fileName "Name of file";
    input String name "Name of parameter";
    input Real data "Actual value of parameter";
    input Boolean append = false "Append data to file";
  algorithm
    if not append then
      Modelica.Utilities.Files.removeFile(fileName);
    end if;
    Modelica.Utilities.Streams.print(name + " = " + String(data), fileName);
  end writeRealParameter;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TestFile;