from fmpy import *

fmu = 'AixLib.Fluid.FMI.ExportContainers.Examples.FMUs.ThermalZone.fmu' # OMC FMU # gives unit error 
#fmu = 'AixLib_Fluid_FMI_ExportContainers_Examples_FMUs_ThermalZone.fmu' # Dymola FMU # doesn't give unit error

dump(fmu)  # get information

from fmpy import read_model_description
model_description = read_model_description(fmu)