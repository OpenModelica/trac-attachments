-- oms2_setTempDirectory("./temp/")
oms2_newFMIModel("model")

-- instantiate FMUs
oms2_addFMU("model", "OneDirection.Source.fmu", "Source")
oms2_addFMU("model", "OneDirection.Target.fmu", "Target")

-- add connections
oms2_addConnection("model", "Source:h", "Target:d")

oms2_describe("model")

oms2_setStopTime("model", 50.0)
oms2_setResultFile("model", "results.mat")

oms2_initialize("model")
oms2_simulate("model")

oms2_unloadModel("model")
