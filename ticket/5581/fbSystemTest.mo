package fbSystemTest
  model fbSystem
    Modelica.Blocks.Continuous.PI PI(T = 1) annotation(
      Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 0.1) annotation(
      Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
      Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
      Placement(visible = true, transformation(origin = {74, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(inertia1.flange_b, speedSensor1.flange) annotation(
      Line(points = {{56, 0}, {74, 0}, {74, -6}}));
    connect(feedback1.u2, speedSensor1.w) annotation(
      Line(points = {{-52, -8}, {-52, -36}, {74, -36}, {74, -27}}, color = {0, 0, 127}));
    connect(feedback1.y, PI.u) annotation(
      Line(points = {{-42, 0}, {-34, 0}, {-34, 0}, {-32, 0}}, color = {0, 0, 127}));
    connect(PI.y, torque1.tau) annotation(
      Line(points = {{-8, 0}, {0, 0}, {0, 0}, {2, 0}}, color = {0, 0, 127}));
    connect(inertia1.flange_a, torque1.flange) annotation(
      Line(points = {{36, 0}, {24, 0}, {24, 0}, {24, 0}, {24, 0}}));
    connect(const.y, feedback1.u1) annotation(
      Line(points = {{-70, 0}, {-62, 0}, {-62, 0}, {-60, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, initialScale = 0.1), graphics = {Rectangle(origin = {26, -11}, lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-64, 33}, {64, -33}})}),
      Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
      version = "",
      __OpenModelica_commandLineOptions = "");
  end fbSystem;

  model fbSubSysDX
    Modelica.Blocks.Continuous.PI PI(T = 1) annotation(
      Placement(visible = true, transformation(origin = {-42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Components.Inertia inertia1(J = 0.1) annotation(
      Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(
      Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput PIu annotation(
      Placement(visible = true, transformation(origin = {-92, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-92, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput w annotation(
      Placement(visible = true, transformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor wSens annotation(
      Placement(visible = true, transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(wSens.w, w) annotation(
      Line(points = {{72, 0}, {86, 0}, {86, 0}, {94, 0}}, color = {0, 0, 127}));
    connect(inertia1.flange_b, wSens.flange) annotation(
      Line(points = {{38, 0}, {50, 0}, {50, 0}, {50, 0}}));
    connect(inertia1.flange_a, torque1.flange) annotation(
      Line(points = {{18, 0}, {4, 0}}));
    connect(PI.y, torque1.tau) annotation(
      Line(points = {{-31, 0}, {-18, 0}}, color = {0, 0, 127}));
    connect(PI.u, PIu) annotation(
      Line(points = {{-54, 0}, {-92, 0}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
      Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
      version = "",
      __OpenModelica_commandLineOptions = "");
  end fbSubSysDX;

  model fbSystemFMU
    Modelica.Blocks.Math.Feedback feedback1 annotation(
      Placement(visible = true, transformation(origin = {-8, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-36, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    fbSystemPkg_fbSubSysDX_me_FMU fmu annotation(
      Placement(visible = true, transformation(origin = {26, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fmu.w, feedback1.u2) annotation(
      Line(points = {{37, 9}, {45, 9}, {45, -17}, {-9, -17}, {-9, -1}}, color = {0, 0, 127}));
    connect(fmu.PIu, feedback1.y) annotation(
      Line(points = {{15, 9}, {9, 9}, {9, 7}, {3, 7}}, color = {0, 0, 127}));
    connect(const.y, feedback1.u1) annotation(
      Line(points = {{-25, 8}, {-16, 8}}, color = {0, 0, 127}));
    annotation(
      uses(Modelica(version = "3.2.2")),
      Diagram(coordinateSystem(extent = {{-80, -40}, {80, 40}})),
      Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}})),
      version = "",
      __OpenModelica_commandLineOptions = "");
  end fbSystemFMU;
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
    uses(Modelica(version = "3.2.3")),
    Documentation(info = "<html><head></head><body><font size=\"5\">Questo package mostra un semplice utilizzo di fmu e integrazione in modelica.&nbsp;</font><div><font size=\"5\">La parte inserita nell'fmu è il nodo sommatore, un'inerzia e un sensore di velocità.</font></div><div><br></div><div><font size=\"5\">I files nella radice del package mostrano come questa parte può essere sostituita con la fmu e i risultati vengono identici.</font></div><div><font size=\"5\">Essa però mostra come non risulti possibile fissare il valore iniziale della velocità angolare dell'inerzia. Una semplice analisi ha mostrato che in effetti le condizioni inziali dell'inerzia vengono gestiti in maniera molto più sofisticata che nel caso del PI, facendo uso anche si una record StateSelect.&nbsp;</font></div><div><font size=\"5\">Pertanto nella cartella\"myInertia\" è stata realizata una versione differente dell'inerzia, che non fa uso di stateSelect e gestisce i valori iniziali in maniera simile al PI. Con questa modifica col modello fbSystemFMUmi si riescono a modificare tutti i valori iniziali, inclusi quelli dell'inerzia. &nbsp;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">Notare che l'importazine di FMU in OMEdit si può fare solo con le model exchange; per la co-simulation occorre ricorrere a OMSimulator.</font></div></body></html>"));
end fbSystemTest;
