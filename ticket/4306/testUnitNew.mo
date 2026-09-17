model testUnitNew "Simulates a very basic Electric Vehicle"
  import Modelica;
  Modelica.Mechanics.Translational.Sensors.PowerSensor measP annotation (
      Placement(visible=true, transformation(
        origin={18,12},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m=1) annotation (
      Placement(visible=true, transformation(extent={{-32,2},{-12,22}},
          rotation=0)));
  Modelica.Mechanics.Translational.Sources.ConstantForce constForce(f_constant=
        1) annotation (Placement(visible=true, transformation(
        origin={-54,12},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Mechanics.Translational.Sources.LinearSpeedDependentForce quadForce(
      f_nominal=1, v_nominal=1) annotation (Placement(visible=true,
        transformation(
        origin={58,12},
        extent={{10,-10},{-10,10}},
        rotation=0)));
equation
  connect(measP.flange_b, quadForce.flange)
    annotation (Line(points={{28,12},{48,12}}, color={0,127,0}));
  connect(mass.flange_a, constForce.flange) annotation (Line(points={{-32,12},{
          -44,12},{-44,12},{-44,12}}, color={0,127,0}));
  connect(measP.flange_a, mass.flange_b)
    annotation (Line(points={{8,12},{-12,12}}, color={0,127,0}));
  annotation (
    experimentSetupOutput(derivatives=false),
    Documentation(info="<html>
             <p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2015-16.</p>
              <p>OM 23136 OK </p>
             </html>"),
    Commands,
    Icon(coordinateSystem(
        extent={{-120,-60},{120,60}},
        preserveAspectRatio=false,
        initialScale=0.1,
        grid={2,2})),
    experiment(
      StartTime=0,
      StopTime=200,
      Tolerance=0.0001,
      Interval=0.1),
    Diagram(coordinateSystem(extent={{-80,-40},{80,60}}, preserveAspectRatio=
            false)),
    uses(Modelica(version="3.2.2")),
    version="",
    __OpenModelica_commandLineOptions="");
end testUnitNew;
