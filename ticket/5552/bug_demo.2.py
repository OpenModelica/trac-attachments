import fmpy
import re
import matplotlib.pyplot as plt
import numpy as np

def getStates(model_description):
    ''' extracts the continuous state names and their variables references from
    a model description '''

    derivative_names = [
        der.variable.name for der in model_description.derivatives]

    names = [
        re.search(r'der\((.*)\)', n).group(1) for n in derivative_names]

    var_refs = get_var_refs(names, model_description)

    return (names, var_refs)

def get_var_refs(signal_names,
                 model_description):
    return [var.valueReference for var in model_description.modelVariables
    if var.name in signal_names]

''' example model: Gyro3d.fmu '''
fmu_file = 'Gyro3d.fmu'

model_description = fmpy.read_model_description(fmu_file, validate=False)
unzip_dir = fmpy.extract(fmu_file)

if model_description.coSimulation is not None:
    modelIdentifier = model_description.coSimulation.modelIdentifier
else:
    modelIdentifier = model_description.modelExchange.modelIdentifier

state_names, var_ref_states = getStates(model_description)

''' set up 2 FMU2Slaves from the same .fmu archive '''
fmus = []

for i in range(2):
    fmus.append(fmpy.fmi2.FMU2Slave(guid=model_description.guid,
                                    unzipDirectory=unzip_dir,
                                    modelIdentifier=modelIdentifier,
                                    instanceName='i1')
                )

for fmu in fmus:
    fmu.instantiate(loggingOn=False)
    fmu.setupExperiment(startTime=0)

    fmu.enterInitializationMode()
    fmu.exitInitializationMode()

time = 0
n_steps = 1000
step_size = 1e-3

saved_states_0 = np.zeros([n_steps, len(state_names)])
saved_states_1 = saved_states_0.copy()

'''=============================================================================
simulation loop
============================================================================='''

for step_id in range(saved_states_0.shape[0]):
    ''' save the state of fmu 0 '''
    saved_states_0[step_id, :] = np.array(fmus[0].getReal(var_ref_states))

    fmus[0].doStep(currentCommunicationPoint=time,
                  communicationStepSize=step_size)

    ''' set fmu 1 state to the PREVIOUS state of fmu 0 '''
    fmus[1].setReal(var_ref_states, saved_states_0[step_id, :])

    fmus[1].doStep(currentCommunicationPoint=time,
                  communicationStepSize=step_size)

    ''' save the state of fmu 1 '''
    saved_states_1[step_id, :] = np.array(fmus[1].getReal(var_ref_states))

    time += step_size

for fmu in fmus:
    fmu.terminate()
    fmu.freeInstance()

fig, axes = plt.subplots(saved_states_0.shape[1], 1)

'''=============================================================================
visualisation
============================================================================='''

''' determine differences between the saved states of fmu 0 and fmu 1 '''
differences = saved_states_0[1:] - saved_states_1[:-1]

for state_id, ax in enumerate(axes):
    ax.plot(differences[:, state_id])
    ax.set_ylabel(state_names[state_id])

plt.show()
