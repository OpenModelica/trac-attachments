model rectifier 
  annotation (uses(Modelica(version="1.6")), Diagram);
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (extent=[-20,-72; 0,-52]);
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode
    annotation (extent=[-8,48; 12,68], rotation=90);
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1e-3)
    annotation (extent=[-58,24; -38,44]);
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=33e-3)
    annotation (extent=[-34,24; -14,44]);
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=10e-6)
    annotation (extent=[58,10; 78,30], rotation=270);
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=50, V=5)
    annotation (extent=[-78,-16; -58,4], rotation=270);
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode1
    annotation (extent=[22,48; 42,68], rotation=90);
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode2
    annotation (extent=[-8,0; 12,20], rotation=90);
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode3
    annotation (extent=[22,0; 42,20], rotation=90);
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1000)
    annotation (extent=[80,10; 100,30], rotation=270);
equation 
  connect(sineVoltage.n, ground.p) annotation (points=[-68,-16; -68,-44; -10,
        -44; -10,-52], style(color=3, rgbcolor={0,0,255}));
  connect(idealDiode.n, idealDiode1.n) annotation (points=[2,68; 2,80; 32,80; 
        32,68], style(color=3, rgbcolor={0,0,255}));
  connect(capacitor.p, idealDiode1.n) annotation (points=[68,30; 68,80; 32,80; 
        32,68], style(color=3, rgbcolor={0,0,255}));
  connect(resistor1.p, idealDiode1.n) annotation (points=[90,30; 90,80; 32,80; 
        32,68], style(color=3, rgbcolor={0,0,255}));
  connect(idealDiode2.p, idealDiode3.p) annotation (points=[2,0; 2,-10; 32,-10; 
        32,0], style(color=3, rgbcolor={0,0,255}));
  connect(capacitor.n, idealDiode3.p) annotation (points=[68,10; 68,-10; 32,-10; 
        32,0], style(color=3, rgbcolor={0,0,255}));
  connect(resistor1.n, idealDiode3.p) annotation (points=[90,10; 90,-10; 32,-10; 
        32,0], style(color=3, rgbcolor={0,0,255}));
  connect(idealDiode2.n, inductor.n) annotation (points=[2,20; 2,34; -14,34], 
      style(color=3, rgbcolor={0,0,255}));
  connect(idealDiode.p, idealDiode2.n) annotation (points=[2,48; 2,41; 2,41; 2,
        34; 2,20; 2,20], style(color=3, rgbcolor={0,0,255}));
  connect(idealDiode1.p, idealDiode3.n)
    annotation (points=[32,48; 32,20], style(color=3, rgbcolor={0,0,255}));
  connect(resistor.p, sineVoltage.p) annotation (points=[-58,34; -68,34; -68,4], 
      style(color=3, rgbcolor={0,0,255}));
  connect(ground.p, idealDiode3.n) annotation (points=[-10,-52; -10,-44; 46,-44; 
        46,34; 32,34; 32,20], style(color=3, rgbcolor={0,0,255}));
  connect(resistor.n, inductor.p)
    annotation (points=[-38,34; -34,34], style(color=3, rgbcolor={0,0,255}));
end rectifier;
