package ModelicaByExample
  package Architectures  "Examples demonstrating configuration management features for creating architectures"
    package ThermalControl  "A thermal control problem with mulltiple controllers and sensors"
      package Examples
        model ExpandableModel  "Thermal system using expandable bus architecture"
          extends Architectures.ExpandableArchitecture(redeclare replaceable Implementations.ThreeZonePlantModel plant(C = 2, G = 1, T_ambient = 278.15, h = 2), redeclare replaceable Implementations.ContinuousActuator actuator, redeclare replaceable Implementations.TemperatureSensor sensor, redeclare replaceable Implementations.ExpandablePIControl controller(setpoint = 300, k = 20, T = 1));
        end ExpandableModel;

        model OnOffVariant  "Variation with on-off control"
          extends ExpandableModel(redeclare replaceable Implementations.OnOffActuator actuator(heating_capacity = 500), redeclare replaceable Implementations.OnOffControl controller(setpoint = 300));
        end OnOffVariant;
      end Examples;

      package Interfaces  "Contains subsystem interfaces"
        partial model PlantModel  "Plant subsystem interface model"
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a room "Room temperature";
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b furnace "Connection point for the furnace";
        end PlantModel;

        partial model ControlSystem_WithExpandableBus  "Control system interface using an expandable bus connector"
          ExpandableBus bus;
        end ControlSystem_WithExpandableBus;

        partial model Actuator_WithExpandableBus  "Actuator subsystem interface with an expandable bus"
          ExpandableBus bus;
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b furnace "Connection point for the furnace";
        end Actuator_WithExpandableBus;

        partial model Sensor_WithExpandableBus  "Sensor subsystem interface using an expandable bus"
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a room "Thermal connection to room";
          ModelicaByExample.Architectures.ThermalControl.Interfaces.ExpandableBus bus;
        end Sensor_WithExpandableBus;

        expandable connector ExpandableBus  "An example of an expandable bus connector" end ExpandableBus;
      end Interfaces;

      package Architectures  "Architectures for our thermal control system"
        partial model ExpandableArchitecture  "A thermal architecture using an expandable bus"
          replaceable Interfaces.PlantModel plant;
          replaceable Interfaces.Actuator_WithExpandableBus actuator;
          replaceable Interfaces.ControlSystem_WithExpandableBus controller;
          replaceable Interfaces.Sensor_WithExpandableBus sensor;
        equation
          connect(actuator.furnace, plant.furnace);
          connect(controller.bus, actuator.bus);
          connect(sensor.room, plant.room);
          connect(sensor.bus, controller.bus);
        end ExpandableArchitecture;
      end Architectures;

      package Implementations  "Implementations of several subsystem interfaces"
        model ThreeZonePlantModel  "A plant model with three zones"
          extends Interfaces.PlantModel;
          parameter Modelica.SIunits.HeatCapacity C "Zone capacitance";
          parameter Modelica.SIunits.ThermalConductance G "Conductance between rooms";
          parameter Modelica.SIunits.Temperature T_ambient "Fixed temperature at port";
          parameter Real h "Convenction coefficient";
        protected
          Modelica.Thermal.HeatTransfer.Components.HeatCapacitor zone1(C = C);
          Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond12(G = G);
          Modelica.Thermal.HeatTransfer.Components.HeatCapacitor zone2(C = C);
          Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond23(G = G);
          Modelica.Thermal.HeatTransfer.Components.HeatCapacitor zone3(C = C);
          Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond13(G = G);
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(final T = T_ambient);
          Modelica.Thermal.HeatTransfer.Components.Convection convection;
          Modelica.Thermal.HeatTransfer.Components.Convection convection1;
          Modelica.Thermal.HeatTransfer.Components.Convection convection2;
          Modelica.Blocks.Sources.Constant const(final k = h);
        equation
          connect(zone1.port, furnace);
          connect(zone1.port, cond13.port_a);
          connect(cond13.port_b, zone3.port);
          connect(zone1.port, cond12.port_a);
          connect(cond12.port_b, zone2.port);
          connect(zone2.port, cond23.port_a);
          connect(cond23.port_b, zone3.port);
          connect(zone3.port, room);
          connect(ambient.port, convection2.fluid);
          connect(convection1.fluid, ambient.port);
          connect(convection.fluid, ambient.port);
          connect(const.y, convection.Gc);
          connect(const.y, convection1.Gc);
          connect(const.y, convection2.Gc);
          connect(convection.solid, zone1.port);
          connect(convection1.solid, zone2.port);
          connect(convection2.solid, zone3.port);
        end ThreeZonePlantModel;

        model ExpandablePIControl  "PI controller implemented with an expandable bus"
          extends Interfaces.ControlSystem_WithExpandableBus;
          parameter Real setpoint "Desired temperature";
          parameter Real k = 1 "Gain";
          parameter Modelica.SIunits.Time T "Time Constant (T>0 required)";
        protected
          Modelica.Blocks.Sources.Trapezoid setpoint_signal(amplitude = 5, final offset = setpoint, rising = 1, width = 10, falling = 1, period = 20);
          Modelica.Blocks.Math.Feedback feedback;
          Modelica.Blocks.Continuous.PI PI(final T = T, final k = -k);
        equation
          connect(setpoint_signal.y, feedback.u2);
          connect(PI.u, feedback.y);
          connect(bus.temperature, feedback.u1);
          connect(PI.y, bus.heat);
        end ExpandablePIControl;

        model ContinuousActuator  "Actuator taking continuous heat command from expandable bus"
          extends Interfaces.Actuator_WithExpandableBus;
        protected
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax = Modelica.Constants.inf, uMin = 0);
          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater;
        equation
          connect(limiter.y, heater.Q_flow);
          connect(heater.port, furnace);
          connect(limiter.u, bus.heat);
        end ContinuousActuator;

        model TemperatureSensor  "Temperature sensor using an expandable bus"
          extends Interfaces.Sensor_WithExpandableBus;
        protected
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor sensor;
        equation
          connect(sensor.T, bus.temperature);
          connect(room, sensor.port);
        end TemperatureSensor;

        model OnOffControl  "An example of an on-off controller without hysteresis"
          extends Interfaces.ControlSystem_WithExpandableBus;
          parameter Real setpoint "Desired temperature";
        protected
          Modelica.Blocks.Logical.Greater greater;
          Modelica.Blocks.Sources.Trapezoid setpoint_signal(amplitude = 5, final offset = setpoint, rising = 1, width = 10, falling = 1, period = 20);
        equation
          connect(greater.y, bus.heat_command);
          connect(setpoint_signal.y, greater.u1);
          connect(bus.temperature, greater.u2);
        end OnOffControl;

        model OnOffActuator  "On-off actuator implemented with an expandable bus"
          extends Interfaces.Actuator_WithExpandableBus;
          parameter Real heating_capacity "Heating capacity of actuator";
        protected
          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater;
          Modelica.Blocks.Math.BooleanToReal command(realTrue = heating_capacity, realFalse = 0);
        equation
          connect(heater.port, furnace);
          connect(command.y, heater.Q_flow);
          connect(command.u, bus.heat_command);
        end OnOffActuator;
      end Implementations;
    end ThermalControl;
  end Architectures;
end ModelicaByExample;

model OnOffVariant_total  "Variation with on-off control"
  extends ModelicaByExample.Architectures.ThermalControl.Examples.OnOffVariant;
end OnOffVariant_total;
