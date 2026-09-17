package camelbrake

  model InnerBrake
    extends Modelica.Mechanics.Rotational.Components.Brake;
  end InnerBrake;

  model testbench

    "Simulation of a Brake component.  A constant torque feeds the brake."

    Modelica.Mechanics.Rotational.Sources.ConstantTorque engine(tau_constant=1);
    InnerBrake brake;
    Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedometer;

    // after 5 seconds, depress the brake pedal and hold it for 500 seconds
    Modelica.Blocks.Sources.Trapezoid brake_pedal(rising=1, width=500, period=600, startTime=5);
    
  equation
    connect(engine.flange, brake.flange_a);
    connect(brake.flange_b, speedometer.flange);
    connect(brake_pedal.y, brake.f_normalized);
  end testbench;

end camelbrake;
