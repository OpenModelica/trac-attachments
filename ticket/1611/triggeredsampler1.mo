model triggeredsampler1
  Modelica.Blocks.Sources.BooleanPulse booleanpulse1(period = 3);
  Modelica.Blocks.Discrete.TriggeredSampler triggeredsampler1;
  Modelica.Blocks.Math.Add add1(k1 = -1);
  Modelica.Blocks.Sources.Constant constant1(k = 1);
equation
  connect(constant1.y,add1.u2);
  connect(triggeredsampler1.y,add1.u1);
  connect(add1.y,triggeredsampler1.u);
  connect(booleanpulse1.y,triggeredsampler1.trigger);
end triggeredsampler1;
