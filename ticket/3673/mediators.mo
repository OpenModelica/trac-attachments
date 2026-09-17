package Mediators

record numberOfOperatingPumps
  extends Mediator(name = "NumberOfOperatingPumps", mType = "Integer", template = "sum(all)",     
  clients = {Client(className = "test.PumpR", instance = "inOperation")},   
  providers = {Provider(className = "test.PA", template = "if getPath.on then 1 else 0"), 
    Provider(className = "test.PB", template = "if (getPath.volFlowRate) > 0 then 1 else 0")});
end numberOfOperatingPumps;

end Mediators;