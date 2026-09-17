block TimeProgramEnergyModeFunctionality
  ScheduleWeekly weeklySchedule(inputIntervalsAndValue = PAR_WSCH);
  parameter Real[:, 5] PAR_WSCH = {weeklySchedule.startTime, {0, 7, 30, 0, 3.0}};
end TimeProgramEnergyModeFunctionality;

partial block PartialFunction 
  replaceable PartialFunctionality functionality;
end PartialFunction;

partial block PartialFunctionality end PartialFunctionality;

block ScheduleWeekly 
  parameter Real[5] startTime = {0, 0, 0, 0, 0.0};
  parameter Real[:, 5] inputIntervalsAndValue = {{0, 8, 11, 0, 0.0}, {0, 8, 11, 0, 0.5}} ;
end ScheduleWeekly;

block TimeProgramEnergyMode
  extends PartialFunction(redeclare TimeProgramEnergyModeFunctionality functionality(PAR_WSCH = PAR_WSCH));
  parameter Real[:, 5] PAR_WSCH = {functionality.weeklySchedule.startTime, {0, 7, 30, 0, 3.0}};
end TimeProgramEnergyMode;
