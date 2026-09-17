oms2_setTempDirectory("./temp/")
oms2_newFMIModel("model")

-- instantiate FMUs
oms2_addFMU("model", "worldmodel.fmu", "World")
oms2_addFMU("model", "MoonLander.fmu", "Lander")

-- add connections
oms2_addConnection("model", "World:h", "Lander:h")
oms2_addConnection("model", "World:v", "Lander:v")
oms2_addConnection("model", "Lander:u", "World:u")

oms2_describe("model")

oms2_setStopTime("model", 50.0)
oms2_setResultFile("model", "results.mat")

oms2_initialize("model")
oms2_simulate("model")

oms2_unloadModel("model")
