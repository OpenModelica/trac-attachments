model LockedRotorTest
  extends Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_DOL(aimc(useSupport = true), terminalBox.terminalConnection = "Y");
equation
  connect(aimc.support, aimc.flange) annotation(
    Line(points = {{0, -50}, {0, -50}, {0, -40}, {0, -40}}));
end LockedRotorTest;