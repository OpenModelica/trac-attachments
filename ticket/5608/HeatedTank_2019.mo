package HeatedTank_2019 "New models for OpenModelica, built in 2019"
  package Basic "Basic Components; The seed is transmitted via graphical connections"
    model Block "Component with failure and repair rates"
      // Parameters
      parameter Boolean perfect = false "are the failures to be inhibited? (default is false)" annotation (
        choices(checkBox = true));
      Real failureRate = 0.1 "failure rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));
      Real repairRate = 1 "repair rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));
      // To get an impure function (e.g. a non reproducible series)
      Modelica.Blocks.Interfaces.BooleanOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Boolean componentIsWorking(start = true);
      Real r "random number" annotation (
        HideResult = false);
      Real F "cumulative distribution function" annotation (
        HideResult = true);
      Real hazardRate "hazard rate";
      Integer seed;
      Modelica.Blocks.Interfaces.IntegerInput u annotation (
        Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
    equation
      u = seed;
      if not perfect then
        hazardRate = if componentIsWorking then failureRate else repairRate;
        der(F) = (1 - F) * hazardRate;
        when {initial(), componentIsWorking <> pre(componentIsWorking)} then
          // Generate a new random number when initial() or each time a transition occurs
          r = HeatedTank_2019.Basic.getRandom(s = seed);
        end when;
        when F > pre(r) then
          reinit(F, 0);
          componentIsWorking = not pre(componentIsWorking);
        end when;
      else
        //perfect component
        {r, F, hazardRate} = {0.0, 0.0, 0.0};
        // dummy equation
        componentIsWorking = true;
      end if;
      y = not componentIsWorking;
      annotation (
        Icon(graphics={  Rectangle(origin = {1, 0}, extent = {{-101, 40}, {99, -40}}), Text(extent = {{-54, -10}, {48, 20}}, lineColor = {28, 108, 200}, textString = "%name")}),
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Block;

    model test
      HeatedTank_2019.Basic.Block block1(perfect = false) annotation (
        Placement(visible = true, transformation(origin = {-62, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.Basic.MyGlobalRandom RNG(useInitialSeed = true) annotation (
        Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.Basic.Block block2 annotation (
        Placement(visible = true, transformation(origin = {-62, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and1 annotation (
        Placement(visible = true, transformation(origin = {18, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(block1.y, or1.u1) annotation (
        Line(points = {{-51, 62}, {-2, 62}, {-2, 0}}, color = {255, 0, 255}));
      connect(block1.y, and1.u1) annotation (
        Line(points = {{-51, 62}, {6, 62}, {6, 54}}, color = {255, 0, 255}));
      connect(block2.y, or1.u2) annotation (
        Line(points = {{-51, 24}, {-38, 24}, {-38, -8}, {-2, -8}}, color = {255, 0, 255}));
      connect(block2.y, and1.u2) annotation (
        Line(points = {{-51, 24}, {-19, 24}, {-19, 46}, {6, 46}}, color = {255, 0, 255}));
      connect(RNG.y, block2.u) annotation (
        Line(points = {{-59, -30}, {-46, -30}, {-46, 12}, {-80, 12}, {-80, 24}, {-74, 24}}, color = {255, 127, 0}));
      connect(block1.u, block2.u) annotation (
        Line(points = {{-74, 62}, {-80, 62}, {-80, 24}, {-74, 24}}, color = {255, 127, 0}));
      annotation (
        Diagram(graphics={  Text(origin = {63, 56}, extent = {{-39, 6}, {39, -6}}, textString = "series system"), Text(origin = {55, 3}, extent = {{-25, 7}, {31, -11}}, textString = "Parallel system")}, coordinateSystem(initialScale = 0.1)),
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end test;

    model MyGlobalRandom "Global seed and random number function (produces random number in the range 0 < number <= 1)"
      // This model sets a seed (chosen by the user or at random) for the function getRandom that it encapsulates
      // extends Modelica.Icons.??;
      // Global parameters
      parameter Boolean useInitialSeed = false "= true, if reproducible sequence with the given seed" annotation (
        choices(checkBox = true));
      parameter Integer globalSeed = 30020 "Seed to initialize random number generator";
      Integer seed;
      Modelica.Blocks.Interfaces.IntegerOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
    equation
      when initial() then
        seed = if not useInitialSeed then Modelica.Math.Random.Utilities.initializeImpureRandom(Modelica.Math.Random.Utilities.automaticGlobalSeed()) else Modelica.Math.Random.Utilities.initializeImpureRandom(globalSeed);
      end when;
      y = seed;
      annotation (
        experiment(StopTime = 2),
        Documentation(info = "<html>
    <p>
    This example demonstrates how to utilize the random number generator
    of package <a href=\"Modelica.Math.Random.Generators\">Math.Random.Generators</a> in a Modelica model.
    </p>
    </html>"));
    end MyGlobalRandom;

    model BlockOld "Component with failure and repair rates"
      // ON essaie de transmettre seed par inner et outer mais ne fonctionne pas en l'état
      // Parameters
      parameter input Boolean perfect = false "are the failures to be inhibited? (default is false)" annotation (
        choices(checkBox = true));
      Real failureRate = 0.1 "failure rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));
      Real repairRate = 1 "repair rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));

      Modelica.Blocks.Interfaces.BooleanOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Boolean componentIsWorking(start = true);
      Real r "random number" annotation (
        HideResult = false);
      Real F "cumulative distribution function" annotation (
        HideResult = true);
      Real hazardRate "hazard rate";
      outer input Integer seed;
    equation
      if not perfect then
        hazardRate = if componentIsWorking then failureRate else repairRate;
        der(F) = (1 - F) * hazardRate;
        when {initial(), componentIsWorking <> pre(componentIsWorking)} then
          // Generate a new random number when initial() or each time a transition occurs
          r = HeatedTank_2019.Basic.MyGlobalRandom.getRandom(s = seed);
        end when;
        when F > pre(r) then
          reinit(F, 0);
          componentIsWorking = not pre(componentIsWorking);
        end when;
      else
        //perfect component
        {r, F, hazardRate} = {0.0, 0.0, 0.0};
        // dummy equation
        componentIsWorking = true;
      end if;
      y = not componentIsWorking;
      annotation (
        Icon(graphics={  Rectangle(origin = {1, 0}, extent = {{-101, 40}, {99, -40}}), Text(extent = {{-54, -10}, {48, 20}}, lineColor = {28, 108, 200}, textString = "%name")}),
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end BlockOld;

    function getRandom
      input Integer s;
      output Real x;
    algorithm
      x := Modelica.Math.Random.Utilities.impureRandom(id = s);
    end getRandom;
  end Basic;

  package HeatedTank_from_FormL "System without failures, model deduced from Form-L model"
    model HydroDevice
      // TODO stochastic transitions must be added to this class
      // Initialisation: do not give a state because it is determined by input u at t=0
      parameter Real lambda_hat = 1e-3 annotation (
        Dialog(enable = true));
      Real lambda;
      Real t = 15;
      Real v_c;
      type State = enumeration(
          on,
          off,
          stuck_on,
          stuck_off);
      State state(start = State.on) annotation (
        Dialog(enable = true));

      function aa
        input Real t;
        output Real aa;
      protected
        parameter Real b1 = 3.0295;
        parameter Real b2 = 0.7578;
        parameter Real bc = 0.05756;
        parameter Real bd = 0.2301;
      algorithm
        aa := (b1 * exp(bc * (t - 20)) + b2 * exp(-bd * (t - 20))) / (b1 + b2);
      end aa;

      flow Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput u annotation (
        Placement(visible = true, transformation(origin = {-108, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-108, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    algorithm
      if pre(state) == State.on and u == false then
        state := State.off;
      end if;
      if pre(state) == State.off and u == true then
        state := State.on;
      end if;
      /*  if time >10 then  deterministic failure
        state:=State.stuck_on;
        end if; */
    equation
      v_c = if state == State.on or state == State.stuck_on then 1 else 0;
      y = -v_c annotation (
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics={  Ellipse(origin = {7, 1}, fillColor = {255, 85, 255},
                fillPattern =                                                               FillPattern.Solid, extent = {{-89, 73}, {89, -73}}, endAngle = 360)}));
      lambda = aa(t) * lambda_hat;
      // NB bug Dymola : si on met l'équation suivante en premier, on a un message d'erreur
      annotation (
        Icon(graphics = {Ellipse(origin = {6, 0}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 62}, {80, -62}}, endAngle = 360), Text(origin = {-23, 27}, extent = {{93, -87}, {-35, 37}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end HydroDevice;

    model Tank
      constant Real gg = 1.5;
      // Parameter used in the derivative of level
      constant Real theta_in = 15;
      constant Real max_level = 8;
      constant Real min_level = 6;
      constant Real overFlowLevel = 10;
      constant Real dryOutLevel = 4;
      Real theta(start = 30.9261);
      Modelica.Blocks.Interfaces.RealOutput level(start = 7) annotation (
        Placement(visible = true, transformation(origin = {108, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      flow Modelica.Blocks.Interfaces.RealInput flow_in annotation (
        Placement(visible = true, transformation(origin = {2, 124}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      flow Modelica.Blocks.Interfaces.RealInput flow_out annotation (
        Placement(visible = true, transformation(origin = {4, -112}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    equation
      der(level) = gg * (flow_in - flow_out);
      der(theta) = (gg * flow_in * (theta_in - theta) + 23.88915) / level;
      annotation (
        defaultComponentName = "tank",
        Icon(coordinateSystem(initialScale = 0.2), graphics={  Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                    FillPattern.VerticalCylinder, extent = {{-100, 100}, {100, -100}}), Rectangle(fillColor = {170, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 10}}), Line(origin = {-0.385321, 0}, points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}), Text(extent = {{-95, -24}, {95, -44}}, textString = "Start level = %level_start", fontName = "0")}),
        Documentation(info = "<html>
<p>
Model of a simple tank.
</p>
</html>"),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Tank;

    model InterfaceTankToHydrodevice
      Modelica.Blocks.Interfaces.RealInput level annotation (
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Real max_level = 8;
      parameter Real min_level = 6;
      // pre_command_start = false corresponds to an initial
      // state where y = true
      parameter Boolean pre_command_start = false;
      Boolean command;
    initial equation
      pre(command) = pre_command_start;
    equation
      // inspired by the equation of block hysteresis
      command = not pre(command) and level > max_level or pre(command) and level >= min_level;
      y = not command;
      annotation (
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics={  Rectangle(fillColor = {85, 0, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {100, -10}})}));
    end InterfaceTankToHydrodevice;

    model system
      // fonctionne
      HeatedTank_2019.HeatedTank_from_FormL.Tank tank annotation (
        Placement(visible = true, transformation(origin = {-8, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      HeatedTank_2019.HeatedTank_from_FormL.InterfaceTankToHydrodevice interfaceTankToHydrodevice1(
          pre_command_start=true)                                                                                             annotation (
        Placement(visible = true, transformation(origin = {52, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.HeatedTank_from_FormL.InterfaceTankToHydrodevice interfaceTankToHydrodevice2(
          pre_command_start=true)                                                                                            annotation (
        Placement(visible = true, transformation(origin = {52, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Not not1 annotation (
        Placement(visible = true, transformation(origin={-60,-44},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HydroDevice pump_1 annotation (
        Placement(transformation(extent = {{-58, 50}, {-38, 70}})));
      HydroDevice pump_2 annotation (
        Placement(transformation(extent = {{46, 50}, {26, 70}})));
      HydroDevice valve_1 annotation (
        Placement(transformation(extent = {{-32, -54}, {-12, -34}})));
    equation
      connect(tank.level, interfaceTankToHydrodevice1.level) annotation (
        Line(points = {{14, 6}, {28, 6}, {28, -16}, {40, -16}}, color = {0, 0, 127}));
      connect(tank.level, interfaceTankToHydrodevice2.level) annotation (
        Line(points = {{14, 6}, {40, 6}}, color = {0, 0, 127}));
      connect(pump_1.y, tank.flow_in) annotation (
        Line(points = {{-37, 60}, {-8, 60}, {-8, 28}}, color = {0, 0, 127}));
      connect(pump_2.y, tank.flow_in) annotation (
        Line(points = {{25, 60}, {-8, 60}, {-8, 28}}, color = {0, 0, 127}));
      connect(not1.y, valve_1.u) annotation (
        Line(points={{-49,-44},{-32.8,-44}},                              color = {255, 0, 255}));
      connect(valve_1.y, tank.flow_out) annotation (
        Line(points={{-11,-44},{-8,-44},{-8,-20}},                    color = {0, 0, 127}));
      connect(interfaceTankToHydrodevice1.y, pump_2.u) annotation (
        Line(points = {{63, -16}, {68, -16}, {68, 60}, {46.8, 60}}, color = {255, 0, 255}));
      connect(interfaceTankToHydrodevice1.y, not1.u) annotation (Line(points={{63,-16},
              {68,-16},{68,-82},{-84,-82},{-84,-44},{-72,-44}},      color={255,0,
              255}));
      connect(interfaceTankToHydrodevice2.y, pump_1.u) annotation (Line(points={{63,
              6},{82,6},{82,80},{-70,80},{-70,60},{-58.8,60}}, color={255,0,255}));
      annotation (
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2),
        Diagram(graphics={  Text(origin = {55, -4}, extent = {{9, -12}, {-9, 12}}, textString = "Control"), Text(origin = {44, -25}, extent = {{0, -1}, {0, 1}}, lineColor = {0, 0, 0}, textString = "The initial state is set by the pre_command_start
 value of control components")}, coordinateSystem(initialScale = 0.1)));
    end system;

  end HeatedTank_from_FormL;

  package HeatedTank_with_failures
    model HydroDevice
      // inner Integer seed;
      // Initialisation: do not give a state because it is determined by input u at t=0
      parameter Real lambda_hat = 1e-3 annotation (
        Dialog(enable = true));
      Real lambda;
      Real t = 15;
      Real v_c;
      type State = enumeration(
          on,
          off,
          stuck_on,
          stuck_off);
      State state annotation (
        Dialog(enable = true));

      function aa
        input Real t;
        output Real aa;
      protected
        parameter Real b1 = 3.0295;
        parameter Real b2 = 0.7578;
        parameter Real bc = 0.05756;
        parameter Real bd = 0.2301;
      algorithm
        aa := (b1 * exp(bc * (t - 20)) + b2 * exp(-bd * (t - 20))) / (b1 + b2);
      end aa;

      flow Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanInput u annotation (
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Basic_woGraph.Block Stuck_open(failureRate = 0.02, repairRate = 0) annotation (
        Placement(visible = true, transformation(origin = {-38, 42}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
      HeatedTank_2019.Basic_woGraph.Block Stuck_closed(failureRate = 0.02, repairRate = 0) annotation (
        Placement(visible = true, transformation(origin = {-38, -28}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
      Modelica.Blocks.Interfaces.IntegerInput seed annotation (
        Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
    initial equation
      pre(state) = State.on;

    algorithm
      if pre(state) == State.on and u == false then
        state := State.off;
      end if;
      if pre(state) == State.off and u == true then
        state := State.on;
      end if;
      if edge(Stuck_open.y) then
        state := State.stuck_on;
      end if;
      if edge(Stuck_closed.y) then
        state := State.stuck_off;
      end if;
    equation
      // Sharing the seed of RNG
      seed = Stuck_open.u;
      seed = Stuck_closed.u;
      lambda = aa(t) * lambda_hat;
      v_c = if (state == State.on or state == State.stuck_on) then 1 else 0;
      y = -v_c annotation (
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics={  Ellipse(origin = {7, 1}, fillColor = {255, 85, 255},
                fillPattern =                                                               FillPattern.Solid, extent = {{-89, 73}, {89, -73}}, endAngle = 360)}));
      annotation (
        Icon(graphics = {Ellipse(origin = {6, 0}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 62}, {80, -62}}, endAngle = 360), Text(origin = {-23, 27}, extent = {{93, -87}, {-35, 37}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
        experiment(StopTime = 1000, Interval = 0.002, Tolerance = 1e-06));
    end HydroDevice;

    model Tank
      constant Real gg = 1.5;
      // Parameter used in the derivative of level
      constant Real theta_in = 15;
      constant Real max_level = 8;
      constant Real min_level = 6;
      constant Real overFlowLevel = 10;
      constant Real dryOutLevel = 4;
      Real theta(start = 30.9261);
      Modelica.Blocks.Interfaces.RealOutput level(start = 7) annotation (
        Placement(visible = true, transformation(origin = {108, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      flow Modelica.Blocks.Interfaces.RealInput flow_in annotation (
        Placement(visible = true, transformation(origin = {2, 124}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      flow Modelica.Blocks.Interfaces.RealInput flow_out annotation (
        Placement(visible = true, transformation(origin = {4, -112}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    algorithm
        when level < dryOutLevel then
        terminate("Undesirable event Dryout");
         end when;
        when level > overFlowLevel then
        terminate("Undesirable event Overflow");
         end when;
        when theta > 100 then
        terminate("Undesirable event Boiling");
         end when;
    equation
      der(level) = gg * (flow_in - flow_out);
      der(theta) = (gg * flow_in * (theta_in - theta) + 23.88915) / level;
      annotation (
        defaultComponentName = "tank",
        Icon(coordinateSystem(initialScale = 0.2), graphics={  Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                    FillPattern.VerticalCylinder, extent = {{-100, 100}, {100, -100}}), Rectangle(fillColor = {170, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 10}}), Line(origin = {-0.385321, 0}, points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}), Text(extent = {{-95, -24}, {95, -44}}, textString = "Start level = %level_start", fontName = "0")}),
        Documentation(info = "<html>
<p>
Model of a simple tank.
</p>
</html>"),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Tank;

    model InterfaceTankToHydrodevice
      Modelica.Blocks.Interfaces.RealInput level annotation (
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanOutput y annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Real max_level = 8;
      parameter Real min_level = 6;
      // pre_command_start = false corresponds to an initial
      // state where y = true
      parameter Boolean pre_command_start = false;
      Boolean command;
    initial equation
      pre(command) = pre_command_start;
    equation
      // inspired by the equation of block hysteresis
      command = not pre(command) and level > max_level or pre(command) and level >= min_level;
      y = not command;
      annotation (
        Diagram(coordinateSystem(initialScale = 0.1)),
        Icon(graphics={  Rectangle(fillColor = {85, 0, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {100, -10}})}));
    end InterfaceTankToHydrodevice;

    model system
      //   inner Integer seed;
      HeatedTank_2019.HeatedTank_with_failures.Tank tank annotation (
        Placement(visible = true, transformation(origin = {-8, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      HeatedTank_2019.HeatedTank_with_failures.InterfaceTankToHydrodevice interfaceTankToHydrodevice1(
          pre_command_start=true)                                                                     annotation (
        Placement(visible = true, transformation(origin = {52, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.HeatedTank_with_failures.InterfaceTankToHydrodevice interfaceTankToHydrodevice2(
          pre_command_start=false)                                                                                              annotation (
        Placement(visible = true, transformation(origin = {52, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.Basic.MyGlobalRandom RNG(useInitialSeed = false)  annotation (
        Placement(visible = true, transformation(origin = {-82, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HydroDevice pump_2 annotation (
        Placement(transformation(extent = {{34, 38}, {14, 58}})));
      HydroDevice pump_1 annotation (
        Placement(transformation(extent = {{-58, 38}, {-38, 58}})));
      HydroDevice valve_1 annotation (
        Placement(transformation(extent = {{-38, -56}, {-18, -36}})));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{-74,-56},{-54,-36}})));
    equation
      RNG.y = pump_1.seed;
      RNG.y = pump_2.seed;
      RNG.y = valve_1.seed;
      connect(tank.level, interfaceTankToHydrodevice1.level) annotation (
        Line(points = {{14, 6}, {28, 6}, {28, -16}, {40, -16}}, color = {0, 0, 127}));
      connect(tank.level, interfaceTankToHydrodevice2.level) annotation (
        Line(points = {{14, 6}, {40, 6}}, color = {0, 0, 127}));
      connect(pump_2.y, tank.flow_in) annotation (
        Line(points = {{13, 48}, {-8, 48}, {-8, 28}}, color = {0, 0, 127}));
      connect(pump_1.y, tank.flow_in) annotation (
        Line(points = {{-37, 48}, {-8, 48}, {-8, 28}}, color = {0, 0, 127}));
      connect(valve_1.y, tank.flow_out) annotation (
        Line(points = {{-17, -46}, {-8, -46}, {-8, -20}}, color = {0, 0, 127}));
      connect(interfaceTankToHydrodevice2.y, pump_1.u) annotation (
        Line(points = {{63, 6}, {76, 6}, {76, 66}, {-76, 66}, {-76, 48}, {-60, 48}}, color = {255, 0, 255}));
      connect(interfaceTankToHydrodevice1.y, pump_2.u) annotation (
        Line(points = {{63, -16}, {70, -16}, {70, 48}, {36, 48}}, color = {255, 0, 255}));
      connect(interfaceTankToHydrodevice1.y, not1.u) annotation (Line(points={{
              63,-16},{70,-16},{70,-70},{-82,-70},{-82,-46},{-76,-46}}, color={
              255,0,255}));
      connect(not1.y, valve_1.u)
        annotation (Line(points={{-53,-46},{-40,-46}}, color={255,0,255}));
      annotation (
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2),
        Diagram(graphics={  Text(origin = {55, -4}, extent = {{9, -12}, {-9, 12}}, textString = "Control"), Text(origin = {44, -31}, extent = {{0, -1}, {0, 1}}, lineColor = {0, 0, 0}, textString = "The initial state is set by the pre_command_start
 value of control components")}, coordinateSystem(initialScale = 0.1)));
    end system;

  end HeatedTank_with_failures;

  package Basic_woGraph "Basic Components. The seed is transmitted WITHOUT graphical connections"
    model Block "Component with failure and repair rates"
      // Parameters
      parameter Boolean perfect = false "are the failures to be inhibited? (default is false)" annotation (
        choices(checkBox = true));
      Real failureRate = 1 "failure rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));
      Real repairRate = 1 "repair rate (nb/time unit)" annotation (
        Dialog(enable = not perfect));
      // To get an impure function (e.g. a non reproducible series)
      Modelica.Blocks.Interfaces.BooleanOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Boolean componentIsWorking(start = true);
      Real r "random number" annotation (
        HideResult = false);
      Real F "cumulative distribution function" annotation (
        HideResult = true);
      Real hazardRate "hazard rate";
      Integer seed;
      Modelica.Blocks.Interfaces.IntegerInput u annotation (
        Placement(visible = true, transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0), iconTransformation(extent = {{-100, 0}, {-60, 40}}, rotation = 0)));
      HeatedTank_2019.Basic_woGraph.Bool FailureIsPresent(start = false) annotation (
        Placement(visible = true, transformation(origin = {-120, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-100,-20},   extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      u = seed;
      if not perfect then
        hazardRate = if componentIsWorking then failureRate else repairRate;
        der(F) = (1 - F) * hazardRate;
        when {initial(), componentIsWorking <> pre(componentIsWorking)} then
          // Generate a new random number when initial() or each time a transition occurs
          r = HeatedTank_2019.Basic_woGraph.getRandom(s = seed);
        end when;
          // Allow transition if it is a repair (not componentIsWorking) or if no failure is present
          // in a group of mutually exclusive failure modes
        when F > pre(r) and (not pre(componentIsWorking) or not pre(FailureIsPresent)) then
          reinit(F, 0);
          componentIsWorking = not pre(componentIsWorking);
          FailureIsPresent = not componentIsWorking;
        end when;
      else
        //perfect component
        {r, F, hazardRate} = {0.0, 0.0, 0.0};
        //   FailureIsPresent = false;
      end if;
      y = not componentIsWorking;
      annotation (
        Icon(graphics={  Rectangle(origin = {1, 0}, extent = {{-101, 40}, {99, -40}}), Text(extent = {{-54, -10}, {48, 20}}, lineColor = {28, 108, 200}, textString = "%name")}),
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
    end Block;

    model test
      HeatedTank_2019.Basic_woGraph.Block block1(perfect = false) annotation (
        Placement(visible = true, transformation(origin = {-62, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.Basic_woGraph.MyGlobalRandom RNG(useInitialSeed = true) annotation (
        Placement(visible = true, transformation(origin={-84,86},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      HeatedTank_2019.Basic_woGraph.Block block2 annotation (
        Placement(visible = true, transformation(origin={-62,46},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and1 annotation (
        Placement(visible = true, transformation(origin = {18, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Or or1 annotation (
        Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      RNG.y = block1.u;
      RNG.y = block2.u;
      connect(block1.y, or1.u1) annotation (
        Line(points = {{-51, 62}, {-2, 62}, {-2, 0}}, color = {255, 0, 255}));
      connect(block1.y, and1.u1) annotation (
        Line(points = {{-51, 62}, {6, 62}, {6, 54}}, color = {255, 0, 255}));
      connect(block2.y, or1.u2) annotation (
        Line(points={{-51,46},{-38,46},{-38,-8},{-2,-8}},          color = {255, 0, 255}));
      connect(block2.y, and1.u2) annotation (
        Line(points={{-51,46},{6,46}},                            color = {255, 0, 255}));
      annotation (
        Diagram(graphics={  Text(origin = {63, 56}, extent = {{-39, 6}, {39, -6}}, textString = "series system"), Text(origin = {55, 3}, extent = {{-25, 7}, {31, -11}}, textString = "Parallel system")}, coordinateSystem(initialScale = 0.1)),
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end test;

    model MyGlobalRandom "Global seed and random number function (produces random number in the range 0 < number <= 1)"
      // This model sets a seed (chosen by the user or at random) for the function getRandom that it encapsulates
      // extends Modelica.Icons.??;
      // Global parameters
      parameter Boolean useInitialSeed = false "= true, if reproducible sequence with the given seed" annotation (
        choices(checkBox = true));
      parameter Integer globalSeed = 30020 "Seed to initialize random number generator";
      Integer seed;
      Modelica.Blocks.Interfaces.IntegerOutput y annotation (
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
    equation
      when initial() then
        seed = if not useInitialSeed then Modelica.Math.Random.Utilities.initializeImpureRandom(Modelica.Math.Random.Utilities.automaticGlobalSeed()) else Modelica.Math.Random.Utilities.initializeImpureRandom(globalSeed);
      end when;
      y = seed;
      annotation (
        experiment(StopTime = 2),
        Documentation(info = "<html>
    <p>
    This example demonstrates how to utilize the random number generator
    of package <a href=\"Modelica.Math.Random.Generators\">Math.Random.Generators</a> in a Modelica model.
    </p>
    </html>"));
    end MyGlobalRandom;

    connector Bool = Boolean "' Boolean' as connector" annotation (
      defaultComponentName = "u",
      Icon(graphics={  Polygon(points={{20,100},{100,0},{20,-100},{20,100}},                lineColor = {255, 0, 255}, fillColor = {255, 0, 255},
              fillPattern =                                                                                                                                     FillPattern.Solid),
                       Polygon(points={{-20,100},{-100,0},{-20,-100},{-20,100}},            lineColor = {255, 0, 255}, fillColor = {255, 0, 255},
              fillPattern =                                                                                                                                     FillPattern.Solid)}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, lineColor = {255, 0, 255}, fillColor = {255, 0, 255},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Text(extent = {{-10, 85}, {-10, 60}}, lineColor = {255, 0, 255}, textString = "%name")}),
      Documentation(info = "<html>
<p>
Connector with one input signal of type Boolean.
</p>
</html>"));

    function getRandom
      input Integer s;
      output Real x;
    algorithm
      x := Modelica.Math.Random.Utilities.impureRandom(id = s);
    end getRandom;
  end Basic_woGraph;
  annotation (
    uses(Modelica(version = "3.2.2")));
end HeatedTank_2019;
