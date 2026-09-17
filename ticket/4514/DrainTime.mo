within ;
model DrainTime "With all tanks full, the maximum time to 

\t\tdrain all tanks shall be 50 seconds."

 //extends VVDRlib.Verification.Requirement;

  input Boolean allTanksAreFull;
  input Boolean systemIsBeingDrained;
  input Boolean allTanksAreEmpty;
  parameter Integer maxTime = 50;

  inner Integer st;
  inner Boolean timeOut;
  inner Integer mTime = maxTime;
  // define the requirement through state machines

  model Waiting
    outer output Integer st;
  equation
      st = 1;
  end Waiting;

  model WaitingTimeout
    outer output Integer st;
    outer Boolean timeOut;
    Real startT = sample(time);
    outer Integer mTime;
  equation
      st = 2;
      timeOut = if ((sample(time) - startT) > mTime) then true else false;
  end WaitingTimeout;

  Waiting notBeingDrained;
  WaitingTimeout beingDrained;

  model AfterTimeOutOK
    outer output Integer st;
  equation
      st = 3;
  end AfterTimeOutOK;

   model AfterTimeOutKO
    outer output Integer st;
   equation
     st = 4;
   end AfterTimeOutKO;

   AfterTimeOutOK afterTimeOutEmpty;
   AfterTimeOutKO afterTimeOutNotEmpty;

equation

  //status = st;

  transition(
    notBeingDrained,
    beingDrained,
    (systemIsBeingDrained and allTanksAreFull),
    immediate=false);
  transition(
      beingDrained,
      notBeingDrained,
      ((not systemIsBeingDrained) and (not timeOut)),
      immediate=false);
  transition(
      beingDrained,
      afterTimeOutNotEmpty,
      timeOut and (not allTanksAreEmpty),
      immediate=false,
      priority=2);
    transition(
      beingDrained,
      afterTimeOutEmpty,
      timeOut and allTanksAreEmpty,
      immediate=false,
      priority=3);
  initialState(notBeingDrained);

end DrainTime;
