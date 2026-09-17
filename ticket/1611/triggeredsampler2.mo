model triggeredsampler2
  Modelica.Blocks.Sources.BooleanPulse booleanpulse1(period = 1);
  Modelica.Blocks.Discrete.TriggeredSampler triggeredsampler1;
  Modelica.Blocks.Sources.Sine sine1(freqHz = 0.2);
equation
  connect(sine1.y,triggeredsampler1.u);
  connect(booleanpulse1.y,triggeredsampler1.trigger);
end triggeredsampler2;
