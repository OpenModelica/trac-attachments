model testcase
protected
  Modelica.Electrical.Analog.Basic.Ground ground;
  Modelica.Electrical.Analog.Ideal.AD_Converter vsense_adc[1](each N = 2);
  Modelica.Electrical.Digital.Sources.Clock adc_clock;
equation
  connect(vsense_adc[1].p, ground.p);
  connect(vsense_adc[1].n, ground.p);
  connect(vsense_adc[1].trig, adc_clock.y);
  annotation(uses(Modelica(version = "3.2.1")));
end testcase;