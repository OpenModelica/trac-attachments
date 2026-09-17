package PNlib

  model PC "Continuous Place"
    Real t = if t_ < minMarks then minMarks else t_ "marking";
    Real tSumIn(fixed = true, start = 0.0);
    Real tSumIn_[nIn](each fixed = true, each start = 0.0);
    Real tSumOut(fixed = true, start = 0.0);
    Real tSumOut_[nOut](each fixed = true, each start = 0.0);
    parameter Integer nIn = 0 "number of input transitions" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output transitions" annotation(Dialog(connectorSizing = true));
    // *** MODIFIABLE PARAMETERS AND VARIABLES BEGIN ***
    parameter Real startMarks = 0 "start marks" annotation(Dialog(enable = true, group = "Marks"));
    parameter Real minMarks(min=0) = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Marks"));
    parameter Real maxMarks(min=minMarks) = PNlib.Constants.inf
    "maximum capacity"                                                             annotation(Dialog(enable = true, group = "Marks"));
    // *** MODIFIABLE PARAMETERS AND VARIABLES END ***
protected
    Real t_(start = startMarks, fixed = true) "marking";
    Real arcWeightIn[nIn] "weights of input arcs";
    Real arcWeightOut[nOut] "weights of output arcs";
    Real instSpeedIn[nIn] "instantaneous speed of input transitions";
    Real instSpeedOut[nOut] "instantaneous speed of output transitions";
    Real maxSpeedIn[nIn] "maximum speed of input transitions";
    Real maxSpeedOut[nOut] "maximum speed of output transitions";
    Real prelimSpeedIn[nIn] "preliminary speed of input transitions";
    Real prelimSpeedOut[nOut] "preliminary speed of output transitions";
    Boolean fireIn[nIn](each start = false, each fixed = true)
    "Does any input transition fire?";
    Boolean fireOut[nOut](each start = false, each fixed = true)
    "Does any output transition fire?";
    Boolean activeIn[nIn] "Are the input transitions active?";
    Boolean activeOut[nOut] "Are the output transitions active?";
    Boolean enabledByInPlaces[nIn]
    "Are the input transitions enabled by all their input places?";
    // *** BLOCKS BEGIN ***
    // since no events are generated within functions!!!
    Boolean feeding = Functions.anyTrue(pre(fireIn))
    "Is the place fed by input transitions?";
    Boolean emptying = Functions.anyTrue(vec=  pre(fireOut))
    "Is the place emptied by output transitions?";
    Real firingSumIn = Functions.firingSumCon(fire=pre(fireIn), arcWeight=arcWeightIn, instSpeed=instSpeedIn)
    "firing sum calculation";
    Real firingSumOut = Functions.firingSumCon(fire=  pre(fireOut), arcWeight=  arcWeightOut, instSpeed=  instSpeedOut)
    "firing sum calculation";
    // *** BLOCKS END ***
public
    Interfaces.PlaceIn inTransition[nIn](each t = t_, each maxTokens = maxMarks, enable = activeIn, each emptied = emptying, each speedSum = firingSumOut, fire = fireIn, active = activeIn, arcWeight = arcWeightIn, instSpeed = instSpeedIn, maxSpeed = maxSpeedIn, prelimSpeed = prelimSpeedIn, enabledByInPlaces = enabledByInPlaces)
    "connector for input transitions"                                                                                                     annotation(Placement(transformation(origin = {-93, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-93, 0}, extent = {{-10, -10}, {10, 10}})));
    Interfaces.PlaceOut outTransition[nOut](each t = t_, each minTokens = minMarks, enable = activeOut, each arcType = PNlib.Types.ArcType.normal_arc, each testValue = -1.0, each fed = feeding, each speedSum = firingSumIn, fire = fireOut, active = activeOut, arcWeight = arcWeightOut, instSpeed = instSpeedOut, maxSpeed = maxSpeedOut, prelimSpeed = prelimSpeedOut)
    "connector for output transitions"                                                                                                     annotation(Placement(transformation(origin = {93, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {93, 0}, extent = {{-10, -10}, {10, 10}})));
    //initial equation
    //  fireIn = pre(fireIn);
    //  fireOut = pre(fireOut);
  equation
    // *** MAIN BEGIN ***
    der(tSumIn) = firingSumIn;
    // der(tSumIn_) = arcWeightIn .* instSpeedIn;
    for i in 1:nIn loop
      der(tSumIn_[i]) = if pre(fireIn[i]) then arcWeightIn[i] * instSpeedIn[i] else 0.0;
    end for;
    der(tSumOut) = firingSumOut;
    // der(tSumOut_) = arcWeightOut .* instSpeedOut;
    for i in 1:nOut loop
      der(tSumOut_[i]) = if pre(fireOut[i]) then arcWeightOut[i] * instSpeedOut[i] else 0.0;
    end for;
    der(t_) = firingSumIn - firingSumOut
    "calculation of continuous mark change";
    // *** MAIN END ***
    // *** ERROR MESSENGES BEGIN ***
    assert(startMarks >= minMarks and startMarks <= maxMarks, "minMarks <= startMarks <= maxMarks");
    // *** ERROR MESSENGES END ***
    annotation(defaultComponentName = "P1", Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false), graphics), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics={  Ellipse(fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-86, 86}, {86, -86}}, endAngle = 360), Ellipse(fillColor = {255, 255, 255},
              fillPattern =                                                                                                    FillPattern.Solid, extent = {{-79, 79}, {79, -79}}, endAngle = 360), Text(origin = {0.5, -0.5}, extent = {{-1.5, 25.5}, {-1.5, -21.5}}, textString = DynamicSelect("%startMarks", if t > 0 then realString(t, 1, 2) else "0.0")), Text(extent = {{-74, -103}, {-74, -128}}, textString = "%name")}));
  end PC;

  model TC "Continuous Transition"
    parameter Integer nIn = 0 "number of input places" annotation(Dialog(connectorSizing = true));
    parameter Integer nOut = 0 "number of output places" annotation(Dialog(connectorSizing = true));
    // *** MODIFIABLE PARAMETERS AND VARIABLES BEGIN ***
    Real maximumSpeed = 1 "maximum speed" annotation(Dialog(enable = true, group = "Maximum Speed"));
    Real arcWeightIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
    Real arcWeightOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
    // *** MODIFIABLE PARAMETERS AND VARIABLES END ***
    Boolean fire "Does the transition fire?";
    Real instantaneousSpeed "instantaneous speed";
    Real actualSpeed = if fire then instantaneousSpeed else 0.0;
    Interfaces.TransitionOut[nOut] outPlaces(each active = activation.active, each fire = fire, each enabledByInPlaces = true, arcWeight = arcWeightOut, each instSpeed = instantaneousSpeed, each prelimSpeed = preliminarySpeed, each maxSpeed = maximumSpeed, t = tOut, maxTokens = maxTokens, emptied = emptied, speedSum = speedSumOut)
    "connector for output places"                                                                                                     annotation(Placement(transformation(origin = {47, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {47, 0}, extent = {{-10, -10}, {10, 10}})));
    Interfaces.TransitionIn[nIn] inPlaces(each active = activation.active, each fire = fire, arcWeight = arcWeightIn, each instSpeed = instantaneousSpeed, each prelimSpeed = preliminarySpeed, each maxSpeed = maximumSpeed, t = tIn, minTokens = minTokens, fed = fed, enable = enableIn, speedSum = speedSumIn)
    "connector for input places"                                                                                                     annotation(Placement(visible = true, transformation(origin = {-47, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-47, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
    Real tIn[nIn] "tokens of input places";
    Real tOut[nOut] "tokens of output places";
    Real minTokens[nIn] "minimum tokens of input places";
    Real maxTokens[nOut] "maximum tokens of output places";
    Real speedSumIn[nIn] "Input speeds of continuous input places";
    Real speedSumOut[nOut] "Output speeds of continuous output places";
    Boolean fed[nIn] "Are the input places fed by their input transitions?";
    Boolean emptied[nOut]
    "Are the output places emptied by their output transitions?";
    Boolean enableIn[nIn]
    "Is the transition enabled by all its discrete input transitions?";
    // *** BLOCKS BEGIN ***
    // since no events are generated within functions!!!
    Blocks.activationCon activation(nIn = nIn, nOut = nOut, tIn = tIn, tOut = tOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, minTokens = minTokens, maxTokens = maxTokens, fed = fed, emptied = emptied, testValue = inPlaces.testValue, arcType = inPlaces.arcType)
    "activation process";
    Real preliminarySpeed = Functions.preliminarySpeed(nIn=  nIn, nOut=  nOut, arcWeightIn=  arcWeightIn, arcWeightOut=  arcWeightOut, speedSumIn=  speedSumIn, speedSumOut=  speedSumOut, maximumSpeed=  maximumSpeed, active=  activation.active, weaklyInputActiveVec=  activation.weaklyInputActiveVec, weaklyOutputActiveVec=  activation.weaklyOutputActiveVec)
    "preliminary speed calculation";
    // *** BLOCKS END ***
  equation
    // *** MAIN BEGIN ***
    fire = activation.active and not maximumSpeed <= 0 "firing process";
    instantaneousSpeed = max(min(maximumSpeed, preliminarySpeed), 0.0)
    "instantaneous speed calculation";
    // *** MAIN END ***
    annotation(defaultComponentName = "T1", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-40, 100}, {40, -100}}, lineColor = {0, 0, 0}, fillColor = DynamicSelect({255, 255, 255}, if fire then {255, 255, 0} else {255, 255, 255}),
              fillPattern =                                                                                                    FillPattern.Solid), Text(extent = {{-2, -116}, {-2, -144}}, lineColor = {0, 0, 0}, textString = DynamicSelect(" ", if animateSpeed == 1 and fire > 0.5 then if instantaneousSpeed > 0 then realString(instantaneousSpeed, 1, 2) else "0.0" else " ")), Text(extent = {{-4, 139}, {-4, 114}}, lineColor = {0, 0, 0}, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
  end TC;

  package Interfaces
  "contains the connectors for the Petri net component models"

    connector PlaceIn
    "part of place model to connect places to input transitions"
      output Real t "Marking of the place" annotation(HideResult = true);
      output Real maxTokens "Maximum capacity of the place" annotation(HideResult = true);
      output Boolean enable
      "Which of the input transitions are enabled by the place?"                       annotation(HideResult = true);
      output Boolean emptied
      "Is the continuous place emptied by output transitions?"                        annotation(HideResult = true);
      output Real speedSum "Output speed of a continuous place" annotation(HideResult = true);
      input Boolean active "Are the input transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the input transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of input transitions" annotation(HideResult = true);
      input Boolean enabledByInPlaces
      "Are the input transitions enabled by all theier input places?"                                 annotation(HideResult = true);
      input Real instSpeed
      "Instantaneous speeds of continuous input transitions"                      annotation(HideResult = true);
      input Real prelimSpeed
      "Preliminary speeds of continuous input transitions"                        annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous input transitions" annotation(HideResult = true);
      annotation(Diagram(graphics={  Polygon(fillColor = {95, 95, 95},
                fillPattern =                                                        FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}}, lineColor = {0, 0, 0})}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Polygon(
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}})}));
    end PlaceIn;

    connector PlaceOut
    "part of place model to connect places to output transitions"
      output Real t "Marking of the place" annotation(HideResult = true);
      output Real minTokens "Minimum capacity of the place" annotation(HideResult = true);
      output Boolean enable
      "Which of the output transitions are enabled by the place?"                       annotation(HideResult = true);
      output PNlib.Types.ArcType arcType
      "Type of output arcs ([1]normal, [2]test, [3]inhibition, or [4]read)"                                    annotation(HideResult = true);
      output Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      output Boolean fed "Is the continuous place fed by input transitions?" annotation(HideResult = true);
      output Real speedSum "Input speed of a continuous place" annotation(HideResult = true);
      input Boolean active "Are the output transitions active?" annotation(HideResult = true);
      input Boolean fire "Do the output transitions fire?" annotation(HideResult = true);
      input Real arcWeight "Arc weights of output transitions" annotation(HideResult = true);
      input Real instSpeed
      "Instantaneous speeds of continuous output transitions"                      annotation(HideResult = true);
      input Real prelimSpeed
      "Preliminary speeds of continuous output transitions"                        annotation(HideResult = true);
      input Real maxSpeed "Maximum speeds of continuous output transitions" annotation(HideResult = true);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Polygon(fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}})}), Diagram(graphics={  Polygon(fillColor = {215, 215, 215},
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-72, 100}, {68, 0}, {-72, -100}, {-72, 100}}, lineColor = {0, 0, 0})}));
    end PlaceOut;

    connector TransitionIn
    "part of transition model to connect transitions to input places"
      input Real t "Markings of input places" annotation(HideResult = true);
      input Real minTokens "Minimum capacites of input places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by input places?" annotation(HideResult = true);
      input PNlib.Types.ArcType arcType
      "Type of output arcs ([1]normal, [2]test, [3]inhibition, or [4]read)"                                   annotation(HideResult = true);
      input Real testValue "Test value of a test or inhibitor arc" annotation(HideResult = true);
      input Boolean fed "Are the continuous input places fed?" annotation(HideResult = true);
      input Real speedSum "Input speeds of continuous input places" annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Input arc weights of the transition" annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
      annotation(Diagram(graphics={  Polygon(fillColor = {95, 95, 95},
                fillPattern =                                                        FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}}, lineColor = {0, 0, 0})}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Polygon(
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}})}));
    end TransitionIn;

    connector TransitionOut
    "part of transition model to connect transitions to output places"
      input Real t "Markings of output places" annotation(HideResult = true);
      input Real maxTokens "Maximum capacities of output places" annotation(HideResult = true);
      input Boolean enable "Is the transition enabled by output places?" annotation(HideResult = true);
      input Boolean emptied "Are the continuous output places emptied?" annotation(HideResult = true);
      input Real speedSum "Output speeds of continuous output places" annotation(HideResult = true);
      output Boolean active "Is the transition active?" annotation(HideResult = true);
      output Boolean fire "Does the transition fire?" annotation(HideResult = true);
      output Real arcWeight "Output arc weights of the transition" annotation(HideResult = true);
      output Boolean enabledByInPlaces
      "Is the transition enabled by all input places?"                                  annotation(HideResult = true);
      output Real instSpeed "Instantaneous speed of a continuous transition" annotation(HideResult = true);
      output Real prelimSpeed "Preliminary speed of a continuous transition" annotation(HideResult = true);
      output Real maxSpeed "Maximum speed of a continuous transition" annotation(HideResult = true);
      annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics={  Polygon(fillColor = {255, 255, 255},
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}})}), Diagram(graphics={  Polygon(fillColor = {215, 215, 215},
                fillPattern =                                                                                                    FillPattern.Solid, points = {{-70, 100}, {70, 0}, {-70, -100}, {-70, 100}}, lineColor = {0, 0, 0})}));
    end TransitionOut;
  end Interfaces;

  package Blocks
  "contains blocks with specific procedures that are used in the Petri net component models"

    block activationCon "activation process of continuous transitions"
      parameter input Integer nIn "number of input places";
      parameter input Integer nOut "number of output places";
      input Real tIn[:] "marking of input places";
      input Real tOut[:] "marking of output places";
      input Real arcWeightIn[:] "arc weights of input places";
      input Real arcWeightOut[:] "arc weights of output places";
      input Real minTokens[:] "minimum capacities of input places";
      input Real maxTokens[:] "maximum capacities of output places";
      input Boolean fed[:] "input places are fed?";
      input Boolean emptied[:] "output places are emptied?";
      input PNlib.Types.ArcType arcType[:] "arc type of input places";
      input Real testValue[:] "test values of test and inhibitor arcs";
      output Boolean active "activation of transition";
      output Boolean weaklyInputActiveVec[nIn]
      "places that causes weakly input activation";
      output Boolean weaklyOutputActiveVec[nOut]
      "places that causes weakly output activation";
    algorithm
      active := true;
      weaklyInputActiveVec := fill(false, nIn);
      weaklyOutputActiveVec := fill(false, nOut);

      //check input places
      for i in 1:nIn loop
        // normal arc
        if arcType[i] == PNlib.Types.ArcType.normal_arc then
          if tIn[i] <= minTokens[i] then
             if fed[i] then
               weaklyInputActiveVec[i] := true;
             else
               active := false;
             end if;
          end if;
        // inhibitor arc
        elseif arcType[i] == PNlib.Types.ArcType.inhibitor_arc then
          if not tIn[i] < testValue[i] then
            active := false;
          end if;
        end if;
      end for;

      //output places
      for i in 1:nOut loop
        if tOut[i] >= maxTokens[i] and not emptied[i] then
          active := false;
        elseif tOut[i] >= maxTokens[i] and emptied[i] then
          weaklyOutputActiveVec[i] := true;
        end if;
      end for;
    end activationCon;
  end Blocks;

  package Functions

    function anyTrue "Is any entry of a Boolean vector true?"
      input Boolean vec[:];
      output Boolean anytrue;
    algorithm
      anytrue := false;
      for i in 1:size(vec, 1) loop
        if vec[i] then
          anytrue := true;
        end if;
      end for;
    end anyTrue;

    function firingSumCon "calculates the firing sum of continuous places"
      input Boolean fire[:] "firability of transitions";
      input Real arcWeight[:] "arc weights";
      input Real instSpeed[:] "istantaneous speed of transitions";
      output Real conFiringSum "continuous firing sum";
    algorithm
      conFiringSum := 0.0;
      for i in 1:size(fire, 1) loop
        if fire[i] then
          conFiringSum := conFiringSum + arcWeight[i] * instSpeed[i];
        end if;
      end for;
    end firingSumCon;

    function preliminarySpeed
    "calculates the preliminary speed of a continuous transition"
      input Integer nIn "number of input places";
      input Integer nOut "number of output places";
      input Real arcWeightIn[:] "input arc weights";
      input Real arcWeightOut[:] "output arc weights";
      input Real speedSumIn[:] "input speed";
      input Real speedSumOut[:] "output speed";
      input Real maximumSpeed "maximum speed";
      input Boolean active "activation";
      input Boolean weaklyInputActiveVec[:]
      "places that causes weakly input activation";
      input Boolean weaklyOutputActiveVec[:]
      "places that causes weakly output activation";
      output Real prelimSpeed "preliminary speed";
    algorithm
      prelimSpeed := maximumSpeed;
      for i in 1:nIn loop
        if weaklyInputActiveVec[i] and speedSumIn[i] / arcWeightIn[i] < prelimSpeed then
          prelimSpeed := speedSumIn[i] / arcWeightIn[i];
        end if;
      end for;
      for i in 1:nOut loop
        if weaklyOutputActiveVec[i] and speedSumOut[i] / arcWeightOut[i] < prelimSpeed then
          prelimSpeed := speedSumOut[i] / arcWeightOut[i];
        end if;
      end for;
    end preliminarySpeed;
  end Functions;

  package Constants
  "contains constants which are used in the Petri net component models"

    constant Real inf = 9.999999999999999e+059
    "Biggest Real number such that inf and -inf are representable on the machine";
  end Constants;

  package Types

    type ArcType = enumeration(
      normal_arc,
      inhibitor_arc);
  end Types;

  package Examples

    model Test6
      PNlib.PC P1(nOut = 1, startMarks = 1) annotation(Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.PC P2(nIn = 1, maxMarks = 0.4) annotation(Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      PNlib.TC T1(nIn = 1, nOut = 1) annotation(Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(T1.outPlaces[1], P2.inTransition[1]) annotation(Line(points = {{4.7, 10}, {4.7, 10}, {20.7, 10}}));
      connect(P1.outTransition[1], T1.inPlaces[1]) annotation(Line(points = {{-20.7, 10}, {-20.7, 10}, {-4.7, 10}}));
      annotation(Diagram(coordinateSystem(extent = {{-60, -20}, {60, 40}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-60, -20}, {60, 40}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-006));
    end Test6;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Examples;
  annotation(uses(Modelica(version="3.2.1")));
end PNlib;
model PNlib_Examples_Test6
 extends PNlib.Examples.Test6;
  annotation(experiment(
  StartTime=0,
  StopTime=1,
  Tolerance=1e-006));
end PNlib_Examples_Test6;
