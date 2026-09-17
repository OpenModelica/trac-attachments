package ArrayBug
  model IzhikevichNetNeuron "Izhikevich neuron model, simplified version <br><br> <cite>Eugene M. Izhikevich, February 25, 2003</cite>"
    // Parameters:
    parameter Real a = 0.02;
    parameter Real b = 0.2;
    parameter Real c = -65;
    parameter Real d = 8;
    // Variables:
    Real I;
    Real V(start = c, fixed = true);
    Real U(start = b * c, fixed = true);
    // Connectors:
    Modelica.Blocks.Interfaces.RealInput IN;
    Modelica.Blocks.Interfaces.RealOutput OUT;
  equation
    IN = I;
    OUT = V / 0.5;
    //
    // Eugene M. Izhikevich, February 25, 2003
    der(V) = 0.04 * V ^ 2 + 5 * V + 140 - U + I;
    der(U) = a * (b * V - U);
    when V >= 30 then
      reinit(V, c);
      reinit(U, U + d);
    end when;
    //
  end IzhikevichNetNeuron;

  model IzhNetNeuronTest1 "Basic test of IzhNetNeuron class, working"
    Modelica.Blocks.Sources.Pulse pulse(amplitude = 60, width = 50, period = 30, startTime = 20);
    IzhikevichNetNeuron neuron1;
    IzhikevichNetNeuron neuron2;
  equation
    // Connect pulse with the first.
    connect(pulse.y, neuron1.IN);
    // Connect t.
    connect(neuron1.OUT, neuron2.IN);
  end IzhNetNeuronTest1;

  model IzhNetNeuronTest2 "Another test of IzhNetNeuron class, this time using arrays - not working in OM"
    Modelica.Blocks.Sources.Pulse pulse(amplitude = 60, width = 50, period = 30, startTime = 20);
    parameter Integer num_neurons = 2;
    IzhikevichNetNeuron[num_neurons] neuron;
  equation
    // Connect pulse with the first.
    connect(pulse.y, neuron[1].IN);
    // Connect others.
    for i in 2:num_neurons loop
      connect(neuron[i - 1].OUT, neuron[i].IN);
    end for;
  end IzhNetNeuronTest2;
end ArrayBug;