model FMIExercise_Components_PI_me_FMU "Proportional-Integral controller"
  constant String fmuWorkingDir = "/tmp/OpenModelica_bernhard/OMEdit";
  parameter Integer logLevel = 3 "log level used during the loading of FMU" annotation (Dialog(tab="FMI", group="Enable logging"));
  parameter Boolean debugLogging = false "enables the FMU simulation logging" annotation (Dialog(tab="FMI", group="Enable logging"));
  Modelica.Blocks.Interfaces.RealOutput x "State of block" annotation(Placement(transformation(extent={{100,60},{120,80}})));
  Real der_x_ "der(State of block)";
  Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal" annotation(Placement(transformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent={{100,35},{120,55}})));
  parameter Real T = 0.0145 "Time Constant (T>0 required)";
  parameter Real k = 0.1 "Gain";
protected
  FMI2ModelExchange fmi2me = FMI2ModelExchange(logLevel, fmuWorkingDir, "FMIExercise_Components_PI", debugLogging);
  constant Integer numberOfContinuousStates = 1;
  Real fmi_x[numberOfContinuousStates] "States";
  //Real fmi_x_new[numberOfContinuousStates](each fixed=true) "New States";
  constant Integer numberOfEventIndicators = 0;
  Real fmi_z[numberOfEventIndicators] "Events Indicators";
  Boolean fmi_z_positive[numberOfEventIndicators](each fixed=true);
  Real flowTime;
  Real flowStatesInputs;
  Real fmi_input_u[1];
  //Boolean callEventUpdate;
  Real callEventUpdate; // HACK: Not allowed to use Boolean in continuous-time
  //Boolean newStatesAvailable(fixed = true);
  //Real triggerDSSEvent;
 // Real nextEventTime(fixed = true);
  Real flowDer[numberOfContinuousStates];
  Real dummy = 0;
initial equation
  fmi_x = initializestuff(fmi2me, time, T, k, u);
equation
// compute derivatives
  flowDer = fmi2Functions.fmi2GetDerivatives(fmi2me, numberOfContinuousStates, time);
  der(fmi_x) = flowDer;
algorithm
  // advance time
  flowTime := fmi2Functions.fmi2SetTime(fmi2me, time, sum(flowDer));
  
  // set inputs at t = time
  fmi_input_u := fmi2Functions.fmi2SetReal(fmi2me, {2.0}, {u});
  
  // set states at t = time and perform one step
  // integration by chosen solver: x = x + h*der_x // forward Euler method
  flowStatesInputs := fmi2Functions.fmi2SetContinuousStates(fmi2me, fmi_x, sum(fmi_input_u));

equation
  // get event indicators at t = time
  fmi_z  = fmi2Functions.fmi2GetEventIndicators(fmi2me, numberOfEventIndicators, flowStatesInputs);
  
  // detect events, if any
  //?? time_event = abs(time - Tnext) <= eps
  // state event:
  for i in 1:size(fmi_z,1) loop
    fmi_z_positive[i] = if not terminal() then fmi_z[i] > 0 else pre(fmi_z_positive[i]);
  end for;
  
  // inform the model about an accepted step
  callEventUpdate = fmi2Functions.fmi2CompletedIntegratorStep(fmi2me, flowStatesInputs+flowTime+sum(fmi_z));

  {x, der_x_, y} = fmi2Functions.fmi2GetReal(fmi2me, {0.0, 1.0, 3.0}, callEventUpdate);
  
  // BELOW IS NOT YET ALIGNED WITH PSEUDO SPEC CODE
  /*
  triggerDSSEvent = noEvent(if callEventUpdate then flowStatesInputs+1.0 else flowStatesInputs-1.0);
algorithm
  when {triggerDSSEvent > flowStatesInputs, pre(nextEventTime) < time, terminal()} then
    newStatesAvailable := fmi2Functions.fmi2EventUpdate(fmi2me);
    nextEventTime := fmi2Functions.fmi2nextEventTime(fmi2me, flowStatesInputs);
    if newStatesAvailable then
      fmi_x_new := fmi2Functions.fmi2GetContinuousStates(fmi2me, numberOfContinuousStates, flowStatesInputs);
      reinit(fmi_x[1], fmi_x_new[1]);
    end if;
  end when;
  */
  annotation(experiment(StartTime=0.0, StopTime=1.0, Tolerance=1e-06));
  annotation (Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        fillColor={240,240,240},
        fillPattern=FillPattern.Solid,
        lineThickness=0.5),
      Text(
        extent={{-100,40},{100,0}},
        lineColor={0,0,0},
        textString="%name"),
      Text(
        extent={{-100,-50},{100,-90}},
        lineColor={0,0,0},
        textString="V2.0")}));
protected
  function initializestuff
    input FMI2ModelExchange fmi2me;
    input Real startTime;
    input Real T;
    input Real k;
    input Real u;
    output Real fmi_x_[numberOfContinuousStates];
  protected
    Real dummy = 0;
    Real dummy1, dummy2, dummy3[1], dummy4, dummy5;
  algorithm
    // set the start time
    dummy1 := fmi2Functions.fmi2SetTime(fmi2me, startTime, 1);
    Modelica.Utilities.Streams.print("dummy1: " + String(dummy1) + "X");
    // set all variable start values (of "ScalarVariable / <type> / start") and
    // set the input values at time = Tstart
    dummy2 := fmi2Functions.fmi2SetRealParameter(fmi2me, {4.0, 5.0}, {T, k});
    Modelica.Utilities.Streams.print("dummy2: " + String(dummy2) + "X");
    dummy3 := fmi2Functions.fmi2SetReal(fmi2me, {2.0}, {u});
    Modelica.Utilities.Streams.print("dummy3[1]: " + String(dummy3[1]) + "X");
  
    // initialize
      // determine continuous and discrete states
      //?? M_fmi2SetupExperiment(m,fmi2False,0.0, Tstart, fmi2True,Tend)
      dummy4 := fmi2Functions.fmi2EnterInitialization(fmi2me, dummy);
      Modelica.Utilities.Streams.print("dummy4: " + String(dummy4) + "X");
      dummy5 := fmi2Functions.fmi2ExitInitialization(fmi2me, dummy);
      Modelica.Utilities.Streams.print("dummy5: " + String(dummy5) + "X");
      
      // event iteration
      /* ??
      eventInfo.newDiscreteStatesNeeded = true;
      while eventInfo.newDiscreteStatesNeeded loop
        // update discrete states
        M_fmi2NewDiscreteStates(m, &eventInfo)
        if eventInfo.terminateSimulation then goto TERMINATE_MODEL
      end while
      */
    
    // enter Continuous-Time Mode
    //?? M_fmi2EnterContinuousTimeMode(m)
    fmi2Functions.fmi2EventUpdate(fmi2me); // HACK this will call M_fmi2EnterContinuousTimeMode(m)
    
    // retrieve initial state x and
    // nominal values of x (if absolute tolerance is needed)
    fmi_x_ := fmi2Functions.fmi2GetContinuousStates(fmi2me, numberOfContinuousStates, dummy);
    Modelica.Utilities.Streams.print("fmi_x_: " + String(fmi_x_[1]) + "X");
    //?? M_fmi2GetNominalsOfContinuousStates(m, x_nominal, nx)
  
    // retrieve solution at t=Tstart, for example for outputs
    //? M_fmi2GetReal/Integer/Boolean/String(m, ...)
  end initializestuff;

  class FMI2ModelExchange
    extends ExternalObject;
      function constructor
        input Integer logLevel;
        input String workingDirectory;
        input String instanceName;
        input Boolean debugLogging;
        output FMI2ModelExchange fmi2me;
        external "C" fmi2me = FMI2ModelExchangeConstructor_OMC(logLevel, workingDirectory, instanceName, debugLogging) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end constructor;

      function destructor
        input FMI2ModelExchange fmi2me;
        external "C" FMI2ModelExchangeDestructor_OMC(fmi2me) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
      end destructor;
  end FMI2ModelExchange;


  
  package fmi2Functions
    function fmi2SetTime
      input FMI2ModelExchange fmi2me;
      input Real inTime;
      input Real inFlow;
      output Real outFlow = inFlow;
      external "C" fmi2SetTime_OMC(fmi2me, inTime) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetTime;

  
    function fmi2EnterInitialization
      input FMI2ModelExchange fmi2me;
      input Real inFlowVariable;
      output Real outFlowVariable = inFlowVariable;
      external "C" fmi2EnterInitializationModel_OMC(fmi2me) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2EnterInitialization;

  
    function fmi2ExitInitialization
      input FMI2ModelExchange fmi2me;
      input Real inFlowVariable;
      output Real outFlowVariable = inFlowVariable;
      external "C" fmi2ExitInitializationModel_OMC(fmi2me) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2ExitInitialization;
  
    function fmi2GetContinuousStates
      input FMI2ModelExchange fmi2me;
      input Integer numberOfContinuousStates;
      input Real inFlowParams;
      output Real fmi_x[numberOfContinuousStates];
      external "C" fmi2GetContinuousStates_OMC(fmi2me, numberOfContinuousStates, inFlowParams, fmi_x) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetContinuousStates;
  
    function fmi2SetContinuousStates
      input FMI2ModelExchange fmi2me;
      input Real fmi_x[:];
      input Real inFlowParams;
      output Real outFlowStates;
      external "C" outFlowStates = fmi2SetContinuousStates_OMC(fmi2me, size(fmi_x, 1), inFlowParams, fmi_x) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetContinuousStates;
  
    function fmi2GetDerivatives
      input FMI2ModelExchange fmi2me;
      input Integer numberOfContinuousStates;
      input Real inFlowStates;
      output Real fmi_x[numberOfContinuousStates];
      external "C" fmi2GetDerivatives_OMC(fmi2me, numberOfContinuousStates, inFlowStates, fmi_x) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetDerivatives;
  
    function fmi2GetEventIndicators
      input FMI2ModelExchange fmi2me;
      input Integer numberOfEventIndicators;
      input Real inFlowStates;
      output Real fmi_z[numberOfEventIndicators];
      external "C" fmi2GetEventIndicators_OMC(fmi2me, numberOfEventIndicators, inFlowStates, fmi_z) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetEventIndicators;
  
    function fmi2GetReal
      input FMI2ModelExchange fmi2me;
      input Real realValuesReferences[:];
      input Real inFlowStatesInput;
      output Real realValues[size(realValuesReferences, 1)];
      external "C" fmi2GetReal_OMC(fmi2me, size(realValuesReferences, 1), realValuesReferences, inFlowStatesInput, realValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetReal;
  
    function fmi2SetReal
      input FMI2ModelExchange fmi2me;
      input Real realValueReferences[:];
      input Real realValues[size(realValueReferences, 1)];
      output Real outValues[size(realValueReferences, 1)] = realValues;
      external "C" fmi2SetReal_OMC(fmi2me, size(realValueReferences, 1), realValueReferences, realValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetReal;



  
    function fmi2SetRealParameter
      input FMI2ModelExchange fmi2me;
      input Real realValueReferences[:];
      input Real realValues[size(realValueReferences, 1)];
      output Real out_Value = 1;
      external "C" fmi2SetReal_OMC(fmi2me, size(realValueReferences, 1), realValueReferences, realValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetRealParameter;
  
    function fmi2GetInteger
      input FMI2ModelExchange fmi2me;
      input Real integerValueReferences[:];
      input Real inFlowStatesInput;
      output Integer integerValues[size(integerValueReferences, 1)];
      external "C" fmi2GetInteger_OMC(fmi2me, size(integerValueReferences, 1), integerValueReferences, inFlowStatesInput, integerValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetInteger;
  
    function fmi2SetInteger
      input FMI2ModelExchange fmi2me;
      input Real integerValuesReferences[:];
      input Integer integerValues[size(integerValuesReferences, 1)];
      output Integer outValues[size(integerValuesReferences, 1)] = integerValues;
      external "C" fmi2SetInteger_OMC(fmi2me, size(integerValuesReferences, 1), integerValuesReferences, integerValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetInteger;
  
    function fmi2SetIntegerParameter
      input FMI2ModelExchange fmi2me;
      input Real integerValuesReferences[:];
      input Integer integerValues[size(integerValuesReferences, 1)];
      output Real out_Value = 1;
      external "C" fmi2SetInteger_OMC(fmi2me, size(integerValuesReferences, 1), integerValuesReferences, integerValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetIntegerParameter;
  
    function fmi2GetBoolean
      input FMI2ModelExchange fmi2me;
      input Real booleanValuesReferences[:];
      input Real inFlowStatesInput;
      output Boolean booleanValues[size(booleanValuesReferences, 1)];
      external "C" fmi2GetBoolean_OMC(fmi2me, size(booleanValuesReferences, 1), booleanValuesReferences, inFlowStatesInput, booleanValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetBoolean;
  
    function fmi2SetBoolean
      input FMI2ModelExchange fmi2me;
      input Real booleanValueReferences[:];
      input Boolean booleanValues[size(booleanValueReferences, 1)];
      output Boolean outValues[size(booleanValueReferences, 1)] = booleanValues;
      external "C" fmi2SetBoolean_OMC(fmi2me, size(booleanValueReferences, 1), booleanValueReferences, booleanValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetBoolean;
  
    function fmi2SetBooleanParameter
      input FMI2ModelExchange fmi2me;
      input Real booleanValueReferences[:];
      input Boolean booleanValues[size(booleanValueReferences, 1)];
      output Real out_Value = 1;
      external "C" fmi2SetBoolean_OMC(fmi2me, size(booleanValueReferences, 1), booleanValueReferences, booleanValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetBooleanParameter;
  
    function fmi2GetString
      input FMI2ModelExchange fmi2me;
      input Real stringValuesReferences[:];
      input Real inFlowStatesInput;
      output String stringValues[size(stringValuesReferences, 1)];
      external "C" fmi2GetString_OMC(fmi2me, size(stringValuesReferences, 1), stringValuesReferences, inFlowStatesInput, stringValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2GetString;
  
    function fmi2SetString
      input FMI2ModelExchange fmi2me;
      input Real stringValueReferences[:];
      input String stringValues[size(stringValueReferences, 1)];
      output String outValues[size(stringValueReferences, 1)] = stringValues;
      external "C" fmi2SetString_OMC(fmi2me, size(stringValueReferences, 1), stringValueReferences, stringValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetString;
  
    function fmi2SetStringParameter
      input FMI2ModelExchange fmi2me;
      input Real stringValueReferences[:];
      input String stringValues[size(stringValueReferences, 1)];
      output Real out_Value = 1;
      external "C" fmi2SetString_OMC(fmi2me, size(stringValueReferences, 1), stringValueReferences, stringValues, 1) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2SetStringParameter;
  
    function fmi2EventUpdate
      input FMI2ModelExchange fmi2me;
      output Boolean outNewStatesAvailable;
      external "C" outNewStatesAvailable = fmi2EventUpdate_OMC(fmi2me) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2EventUpdate;
  
    function fmi2nextEventTime
      input FMI2ModelExchange fmi2me;
      input Real inFlowStates;
      output Real outNewnextTime;
      external "C" outNewnextTime = fmi2nextEventTime_OMC(fmi2me, inFlowStates) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2nextEventTime;
  
    function fmi2CompletedIntegratorStep
      input FMI2ModelExchange fmi2me;
      input Real inFlowStates;
      output Real outCallEventUpdate;
      external "C" outCallEventUpdate = fmi2CompletedIntegratorStep_OMC(fmi2me, inFlowStates) annotation(Library = {"OpenModelicaFMIRuntimeC", "fmilib"});
    end fmi2CompletedIntegratorStep;

  end fmi2Functions;
end FMIExercise_Components_PI_me_FMU;
