class Oven
  type states = enumeration(Open, Idle, Cooking);
  Integer state;
end Oven;    

class Light
  type states = enumeration(Off, On);
  Integer state;
end Light;

class Powertube
  type states = enumeration(Energised, Off);
  Integer state;
end Powertube;

class Timer 
  type states = enumeration(OneMinute, Stopped, ExtraMinute);
  constant Integer state_OneMinute = Integer(states.OneMinute);
  constant Integer state_Stopped = Integer(states.Stopped);
  constant Integer state_ExtraMinute = Integer(states.ExtraMinute);
  Integer state;
  Boolean TimedOut;

  Real timer (start = -1);
  Real TimedOutDelay;
  constant Real delay = 0.01;

  algorithm

  when state <> pre(state) then
    if state == state_OneMinute then
      timer := time + 1; 
    elseif state == state_Stopped then
      timer := -1;
    elseif state == state_ExtraMinute then
      timer := timer + 1;
    end if;
  end when;

  if timer > 0 and timer <= time then
    if time <= TimedOutDelay then
      TimedOut := true;  
    else
      timer := -1;
    end if;
  else 
    TimedOut := false;
    TimedOutDelay := time + (delay*2);
  end if;
end Timer;

class Beeper
  type states = enumeration(EmitWarningBeep);
  Integer state;
end Beeper;

model MicrowaveOven
  // Nodes
  Integer branch1 (start = 1), branch2, branch3, branch4, branch5, branch6;
  Integer activeBranch (start = 1), lastActiveBranch;
  Boolean next (start = true);

  // Events
  Boolean CloseDoor, PushButton, OpenDoor;
  Boolean TimerTimedOut;
    
  // Components
  Oven oven;
  Light light;
  Powertube powertube;
  Timer timer;
  Beeper beeper;  

  // Delay  
  Real startTime;
  constant Real delay = 0.01;       
              
  algorithm
  
  if time > 0.9 and startTime < 0.9 + delay then
    CloseDoor := true;
  elseif time > 0.3 and startTime < 0.3 + delay then
    CloseDoor := true;
  else
    CloseDoor := false;
  end if;  
         
  if time > 1 and startTime < 1 + delay then
    PushButton := true;
  else
    PushButton := false;
  end if;
    
  if time > 0.7 and startTime < 0.7 + delay then
    OpenDoor := true;
  else
    OpenDoor := false;
  end if;
        
  TimerTimedOut := false;
                    
  when time > startTime + delay then
    while branch1 == pre(branch1) and branch2 == pre(branch2) and branch3 == pre(branch3) and branch4 == pre(branch4) and branch5 == pre(branch5) and branch6 == pre(branch6) and next loop          
      if activeBranch == 1 then
        if branch1 == 1 then
          oven.state := Integer(oven.states.Open);
          branch1 := 2;
        elseif branch1 == 2 then
          if CloseDoor then 
            branch1 := 3;
          end if;
        elseif branch1 == 3 then
          light.state := Integer(light.states.Off);
          branch1 := 4;
        elseif branch1 == 4 then
          oven.state := Integer(oven.states.Idle);
          branch1 := 0;
          branch2 := 1;
          branch6 := 1;
        end if;
      elseif activeBranch == 2 then
        if branch2 == 1 then
          if PushButton then
            branch2 := 2;
            branch6 := 0;        
          end if;       
        elseif branch2 == 2 then
          powertube.state := Integer(powertube.states.Energised);
          branch2 := 3;      
        elseif branch2 == 3 then
          light.state := Integer(light.states.On);
          branch2 := 4;      
        elseif branch2 == 4 then
          timer.state := Integer(timer.states.OneMinute);
          branch2 := 5;      
        elseif branch2 == 5 then
          oven.state := Integer(oven.states.Cooking);
          branch2 := 0;
          branch3 := 1;
          branch4 := 1;                  
          branch5 := 1;        
        end if;
      elseif activeBranch == 3 then
        if branch3 == 1 then
          if OpenDoor then
            branch3 := 2;
            branch4 := 0;
            branch5 := 0;            
          end if;            
        elseif branch3 == 2 then
          powertube.state := Integer(powertube.states.Off);    
          branch3 := 3;
        elseif branch3 == 3 then    
          timer.state := Integer(timer.states.Stopped);
          branch3 := 4;        
        elseif branch3 == 4 then
          branch3 := 0;
          branch1 := 1;            
        end if;
      elseif activeBranch == 4 then
        if branch4 == 1 then
          if timer.TimedOut then  
            branch4 := 2;
            branch3 := 0;
            branch5 := 0;                  
          end if;
        elseif branch4 == 2 then
          light.state := Integer(light.states.Off);
          branch4 := 3;    
        elseif branch4 == 3 then
          powertube.state := Integer(powertube.states.Off);
          branch4 := 4;        
        elseif branch4 == 4 then
          beeper.state := Integer(beeper.states.EmitWarningBeep);
          branch4 := 5;
        elseif branch4 == 5 then
          branch4 := 0;
          branch1 := 4;    
        end if;        
      elseif activeBranch == 5 then
        if branch5 == 1 then
          if PushButton then
            branch5 := 2;
            branch3 := 0;
            branch4 := 0;
          end if;      
        elseif branch5 == 2 then
          timer.state := Integer(timer.states.ExtraMinute);
          branch5 := 3;
        elseif branch5 == 3 then
          oven.state := Integer(oven.states.Cooking);
          branch5 := 0;
          branch2 := 5;
        end if;
      elseif activeBranch == 6 then
        if branch6 == 1 then
          if OpenDoor then
            branch6 := 2;
            branch2 := 0;
          end if;
        elseif branch6 == 2 then
          light.state := Integer(light.states.On);
          branch6 := 3;
        elseif branch6 == 3 then
          branch6 := 0;
          branch1 := 1;
        end if;
      end if;

      activeBranch := activeBranch + 1;
    
      if activeBranch == 7 then activeBranch := 1; end if;
    
      if activeBranch == 1 and branch1 == 0 then
        activeBranch := activeBranch + 1;
      end if;
      
      if activeBranch == 2 and branch2 == 0 then
        activeBranch := activeBranch + 1;
      end if;
    
      if activeBranch == 3 and branch3 == 0 then
        activeBranch := activeBranch + 1;
      end if;

      if activeBranch == 4 and branch4 == 0 then
        activeBranch := activeBranch + 1;
      end if;

      if activeBranch == 5 and branch5 == 0 then
        activeBranch := activeBranch + 1;
      end if;

      if activeBranch == 6 and branch6 == 0 then
        activeBranch := 1;
      end if;

      if activeBranch == 1 and branch1 == 0 then
        activeBranch := activeBranch + 1;
      end if;
      
      if activeBranch == 2 and branch2 == 0 then
        activeBranch := activeBranch + 1;
      end if;
    
      if activeBranch == 3 and branch3 == 0 then
        activeBranch := activeBranch + 1;
      end if;

      if activeBranch == 4 and branch4 == 0 then
        activeBranch := activeBranch + 1;
      end if;

      if activeBranch == 5 and branch5 == 0 then
        activeBranch := activeBranch + 1;
      end if;
  
      if (activeBranch == lastActiveBranch) then
        next := false;
      end if; 

    end while;

    startTime := time;
    lastActiveBranch := activeBranch;      
    next := true;
    
  end when;
end MicrowaveOven;
