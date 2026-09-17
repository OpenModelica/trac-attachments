model ConnectIssue "With thick array-connecting lines "

  constant Real PI = Modelica.Constants.pi;
  Modelica.Blocks.Math.Product product[3] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {10, -2})));
  Modelica.Blocks.Routing.Replicator replicator(nout = 3) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-36, 4})));
equation

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -40}, {60, 40}})), experiment(StopTime = 0.3, __Dymola_NumberOfIntervals = 1000), Documentation(info = "<html>
<p>The rectifier example shows a B6 diode bridge fed by a three phase sinusoidal voltage, loaded by a DC current. 
DC capacitors start at ideal no-load voltage, thus making easier initial transient.</p>
<p>Simulate until T=0.1 s. Plot in separate windows:
<br>uDC ... DC-voltage
<br>iAC ... AC-currents 1..3
<br>uAC ... AC-voltages 1..3 (distorted)
<br>Try different load currents iDC = 0..approximately 500 A. You may watch losses (of the whole diode bridge) trying different diode parameters.</p>
</html>", revisions = "<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 7, 2004   </i>
       by Anton Haumer<br> realized<br>
       </li>
</ul>
</html>"), __Dymola_experimentSetupOutput, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-80, -40}, {60, 40}})), uses(Modelica(version = "3.2.2")), version = "", __OpenModelica_commandLineOptions = "");
end ConnectIssue;
