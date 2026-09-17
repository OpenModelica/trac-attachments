within Project1;
model KinematicsTest "Front suspension kinematics experiment"
  extends VDLMotorsports.Chassis.Suspensions.Experiments.Templates.Kinematics(
      redeclare FrontSuspension suspension, kinematicsRig(
      redeclare VehicleDynamics.Vehicles.Chassis.Experiments.Blocks.NHTSAJTurn
        verticalDynamics_2,
      redeclare VehicleDynamics.Vehicles.Chassis.Experiments.Blocks.NHTSAJTurn
        steering,
      redeclare VehicleDynamics.Vehicles.Chassis.Experiments.Blocks.NHTSAJTurn
        verticalDynamics_1));
end KinematicsTest;
