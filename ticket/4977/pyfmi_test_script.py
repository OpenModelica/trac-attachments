#!/usr/bin/env python 
# -*- coding: utf-8 -*-

import os as O

import matplotlib
import matplotlib.pyplot as plt

import numpy as N

from pyfmi import load_fmu

curr_dir = O.path.dirname(O.path.abspath(__file__));
path_to_fmus = O.path.join(curr_dir, 'FMUs') # The FMU must be in this folder!!!!!!


def run_fmu_native(filename, list_seed_vector, with_plots=True):
    """E10_linear (native) 

    Based on https://jmodelica.org/pyfmi/_modules/pyfmi/examples/fmi_bouncing_ball_native.html#run_demo

    """
    fmu_name = O.path.join(path_to_fmus, filename)
    model = load_fmu(fmu_name)

    Tstart = 0.0 #The start time.
    Tend   = 2.0 #The final simulation time.

    model.time = Tstart #Set the start time before the initialization.

    #Initialize the model. Also sets all the start attributes defined in the 
    # XML file.
    model.initialize() 

    #Get Continuous States
    x = model.continuous_states
    #Get the Nominal Values
    x_nominal = model.nominal_continuous_states
    #Get the Event Indicators
    event_ind = model.get_event_indicators()

    # Snippet from https://jmodelica.org/pyfmi/pyfmi.html#pyfmi.fmi.FMUModelBase2.get_directional_derivative
    assert model.get_capability_flags()["providesDirectionalDerivatives"]==True #Assert directional derivatives are provided

    states = model.get_states_list()
    states_references = [s.value_reference for s in states.values()]
    derivatives = model.get_derivatives_list()
    derivatives_references = [d.value_reference for d in derivatives.values()]
    
    print('state_references: {}'.format(states_references))
    print('derivatives_references: {}'.format(derivatives_references))
    print('seed vector: {}'.format(list_seed_vector))

    dd = model.get_directional_derivative(states_references, derivatives_references, list_seed_vector)

    #print('dd: {}'.format(dd))
    
if __name__ == "__main__":

    run_fmu_native('E10_linear.fmu', [1], with_plots=True)
