# Figure - Simulation of test of handling medium
#          We pump from one tank to another.
#
# Author: Jan Peter Axelsson
# 2019-02-07 - Created
# 2019-02-14 - Try replaceable partial model idea...
# 2019-02-15 - Set initial values in Modelia code to simplify for OpenModelica
# 2019-02-16 - Works - and I increase to 7 compounds to avoid mixing up v4 with nc=4
# 2019-02-27 - Options for simulation changed to improva accuracy  - from Modelon
# 2019-03-07 - Adapted for DEMO_v9
#--------------------------------------------------------------------------------------

# Setup of Modelica etc
import numpy as np 
import matplotlib.pyplot as plt 
from pymodelica import compile_fmu 
from pyfmi import load_fmu

# Define model file name and class name 
model_name = 'd9_app7.Test' 
model_file = 'd9_app7.mo'
library_file = 'DEMO_v9.mo'

# Compile model
fmu_model = compile_fmu(model_name, [model_file, library_file])

# Load model
model = load_fmu(fmu_model)

# Set parameters
#model.set('feedtank.c_in[1]', 0.5)
#model.set('feedtank.c_in[2]', 0.2)
#model.set('harvesttank.V_0',1.0)
#model.set('harvesttank.m_0[1]',0.7)
#model.set('harvesttank.m_0[2]',0)
#model.set('Fsp.val', 1.0)

# Simulation time
global simulationTime; simulationTime = 100.0

# Set solver options
opts = model.simulate_options()
opts['ncp'] = 100

# Simulation
sim_res = model.simulate(final_time=simulationTime, options=opts)

# Extract results
res = sim_res.result_data
F = res.get_variable_data('harvesttank.inlet.F')
V = res.get_variable_data('harvesttank.V')
c1 = res.get_variable_data('harvesttank.c[1]')
c2 = res.get_variable_data('harvesttank.c[2]') 
c3 = res.get_variable_data('harvesttank.c[3]')  
c7 = res.get_variable_data('harvesttank.c[7]') 

# Plot results    
plt.figure()
plt.subplot(3,1,1)
plt.plot(c1.t,c1.x,'b')
plt.plot(c2.t,c2.x,'r')
plt.plot(c3.t,c3.x,'g')
plt.plot(c7.t,c7.x,'k')
plt.grid()
plt.legend(['c1','c2','c3','c7'])
plt.ylabel('Conc [kg/m3]')

plt.subplot(3,1,2)
plt.plot(F.t,F.x,'b') 
plt.grid()
plt.ylabel('Flow [m3/s]')

plt.subplot(3,1,3)
plt.plot(V.t,V.x,'b') 
plt.grid()
plt.ylabel('V [m3]')
plt.xlabel('Time [s]')

plt.show()