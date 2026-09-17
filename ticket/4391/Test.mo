model Test
  Real a, b;
  discrete Real flag;
  
algorithm
  when a > 0 and b > 0 then
    flag := 1;
  end when;
  
 
initial algorithm
  if (a > 0) then
    flag := -1;
  end if;

equation
  a = 1+time;
  b = if time < (-1) then -1 else time;

annotation(experiment(StartTime=-2, StopTime=2));
end Test;
