package TestPkg

    model SimpleModule "Simple module with load resistor"
      extends Modelica.Icons.Example;
      Modelica.Electrical.Analog.Basic.Ground ground annotation(
        Placement(visible = true, transformation(origin = {-28, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PhotoVoltaics.Components.SimplePhotoVoltaics.SimpleModule module(T = 298.15, cell(v(start = zeros(moduleData.ns))), moduleData = moduleData, shadow = {0, 0, 0}, useConstantIrradiance = true) annotation(
        Placement(visible = true, transformation(origin = {-28, 2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      PhotoVoltaics.Sources.Blocks.PowerRamp powerRamp(duration = 0.6, height = 8, offset = -4, ref = moduleData.VmpCellRef / moduleData.ImpRef, startTime = 0.2) annotation(
        Placement(visible = true, transformation(origin = {42, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation(
        Placement(visible = true, transformation(origin = {12, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
      parameter MyModule moduleData(VmpRef = 1.5, VocRef = 1.8, nb = 0, ns = 3) annotation(
        Placement(visible = true, transformation(origin = {-62, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(ground.p, module.n) annotation(
        Line(points = {{-28, -20}, {-28, -8}}, color = {0, 0, 255}));
      connect(module.p, variableResistor.p) annotation(
        Line(points = {{-28, 12}, {-28, 20}, {12, 20}, {12, 10}}, color = {0, 0, 255}));
      connect(variableResistor.R, powerRamp.y) annotation(
        Line(points = {{24, 0}, {31, 0}}, color = {0, 0, 127}));
      connect(variableResistor.n, ground.p) annotation(
        Line(points = {{12, -10}, {12, -20}, {-28, -20}}, color = {0, 0, 255}));
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
        __OpenModelica_simulationFlags(jacobian = "coloredNumerical", nls = "newton", s = "dassl", lv = "LOG_STATS"),
        Diagram(coordinateSystem(extent = {{-80, -60}, {80, 60}}, initialScale = 0.1)));
    end SimpleModule;

    record MyModule "Modified for testing"
      extends PhotoVoltaics.Records.ModuleData(final moduleName = "SHARP_NU_S5_E3E", TRef = 298.15, irradianceRef = 1000, VocRef = 30.2, IscRef = 8.54, VmpRef = 24.0, ImpRef = 7.71, alphaIsc = +0.00053, alphaVoc = -0.00340, ns = 48, nb = 3);
      annotation(
        defaultComponentName = "moduleData",
        defaultComponentPrefixes = "parameter",
        Documentation(info = "<html>
    The original data of this module are taken from
    <a href=\"http://www.smartgreenenergycompany.com/Resources/sharp-solar-nu-series.pdf\">SHARP</a>. You may want to download this PDF file and store it in the directory Resources/DataSheets for convenience reasons. You may want to make these data directly 
    <a href=\"modelica://PhotoVoltaics/Resources/DataSheets/SHARP_NU_S5_E3E.pdf\">available</a>.
    </html>"));
    end MyModule;
  annotation(
    uses(Modelica(version = "3.2.3"), Complex(version = "3.2.3")),
    Documentation(info = "<html>
<p>Questo sotto package approfondisce la questione del &quot;current controller&quot;, che ha come igresso i valori di id/iq e come uscita o gli indici di conduzione di fase o addirittura le tensioni di fase. Metteremo a contfronto le tecniche presenti in Modelica.Electrical.Machines.Examples.SynchronousInductionMachines.SMPM_VoltageSource con quelli negli articoli della TF IEEE e di Paramita.</p>
</html>"));
end TestPkg;
