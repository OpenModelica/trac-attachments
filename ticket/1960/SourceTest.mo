within TestPolimi;
model SourceTest

  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=2,
    period=0.2,
    offset=-1.5);

  Modelica.Mechanics.Rotational.Sources.Torque torque1;

  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    phi(fixed=true),
    w(fixed=true),
    J=1);
equation
  connect(sine.y, torque1.tau);
  connect(torque1.flange, inertia.flange_a);
  annotation (experiment(StopTime=2, NumberOfIntervals=5000));
end SourceTest;
