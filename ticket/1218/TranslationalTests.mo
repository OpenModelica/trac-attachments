model TranslationalTests "Tests Elastogap,Position,Move and RelativeStates" 
  annotation (uses(Modelica(version="2.2.1")), Diagram(Text(
        extent=[-54,102; 90,62], 
        string="Test of Translational Components", 
        style(color=0, rgbcolor={0,0,0}))));
  Modelica.Mechanics.Translational.ElastoGap elastoGap(s_rel0=0.1)
    annotation (extent=[2,-38; 22,-18]);
  Modelica.Mechanics.Translational.Rod rod(L=0.1)
    annotation (extent=[-32,-38; -12,-18]);
  Modelica.Mechanics.Translational.Move move
    annotation (extent=[-58,-38; -38,-18]);
  Modelica.Mechanics.Translational.Position position
    annotation (extent=[46,-100; 66,-80], rotation=0);
  Modelica.Blocks.Sources.SawTooth sawTooth(period=0.1)
    annotation (extent=[10,-100; 30,-80]);
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (extent=[-94,58; -74,78]);
  Modelica.Blocks.Continuous.Derivative derivative
    annotation (extent=[-92,-12; -72,8]);
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (extent=[-54,18; -34,38]);
  Modelica.Blocks.Sources.Sine sine(freqHz=15, amplitude=50)
    annotation (extent=[-92,20; -72,40]);
  Modelica.Mechanics.Translational.Spring spring(s_rel0=0.1)
    annotation (extent=[-4,2; 16,22]);
  Modelica.Mechanics.Translational.SlidingMass slidingMass(L=0.1, m=0.01)
    annotation (extent=[24,2; 44,22]);
  Modelica.Mechanics.Translational.Spring spring1(s_rel0=0.1)
    annotation (extent=[50,2; 70,22]);
  Modelica.Mechanics.Translational.Fixed fixed(s0=0.4)
    annotation (extent=[76,2; 96,22]);
  Modelica.Mechanics.Translational.RelativeStates relativeStates
    annotation (extent=[24,42; 44,62]);
equation 
  connect(elastoGap.flange_a, rod.flange_b)
    annotation (points=[2,-28; -12,-28], style(color=58, rgbcolor={0,127,0}));
  connect(sawTooth.y, position.s_ref)
    annotation (points=[31,-90; 44,-90], style(color=74, rgbcolor={0,0,127}));
  connect(integrator.y, multiplex3_1.u1[1]) annotation (points=[-73,68; -66,68; 
        -66,35; -56,35], style(color=74, rgbcolor={0,0,127}));
  connect(derivative.y, multiplex3_1.u3[1]) annotation (points=[-71,-2; -64,-2; 
        -64,21; -56,21], style(color=74, rgbcolor={0,0,127}));
  connect(rod.flange_a, move.flange_b) annotation (points=[-32,-28; -38,-28], 
      style(color=58, rgbcolor={0,127,0}));
  connect(move.u, multiplex3_1.y) annotation (points=[-60,-28; -64,-28; -64,-14; 
        -26,-14; -26,28; -33,28], style(color=74, rgbcolor={0,0,127}));
  connect(sine.y, integrator.u) annotation (points=[-71,30; -68,30; -68,46; 
        -100,46; -100,68; -96,68], style(color=74, rgbcolor={0,0,127}));
  connect(derivative.u, sine.y) annotation (points=[-94,-2; -98,-2; -98,12; -68,
        12; -68,30; -71,30], style(color=74, rgbcolor={0,0,127}));
  connect(multiplex3_1.u2[1], sine.y) annotation (points=[-56,28; -62,28; -62,
        30; -71,30], style(color=74, rgbcolor={0,0,127}));
  connect(position.flange_b, elastoGap.flange_b) annotation (points=[66,-90; 68,
        -90; 68,-28; 22,-28], style(color=58, rgbcolor={0,127,0}));
  connect(spring.flange_a, rod.flange_b) annotation (points=[-4,12; -12,12; -12,
        -28], style(color=58, rgbcolor={0,127,0}));
  connect(slidingMass.flange_a, spring.flange_b)
    annotation (points=[24,12; 16,12], style(color=58, rgbcolor={0,127,0}));
  connect(spring1.flange_a, slidingMass.flange_b)
    annotation (points=[50,12; 44,12], style(color=58, rgbcolor={0,127,0}));
  connect(fixed.flange_b, spring1.flange_b)
    annotation (points=[86,12; 70,12], style(color=58, rgbcolor={0,127,0}));
  connect(relativeStates.flange_a, slidingMass.flange_a)
    annotation (points=[24,52; 24,12], style(color=58, rgbcolor={0,127,0}));
  connect(relativeStates.flange_b, slidingMass.flange_b)
    annotation (points=[44,52; 44,12], style(color=58, rgbcolor={0,127,0}));
end TranslationalTests;
