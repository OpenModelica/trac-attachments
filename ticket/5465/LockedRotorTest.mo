model LockedRotorTest
  extends Modelica.Electrical.Machines.Examples.AsynchronousInductionMachines.AIMC_DOL(aimc(useSupport=true));
equation 
  connect(aimc.support, aimc.flange) annotation (Line(points={{0,-50},{0,-40}}, color={0,0,0}));
end LockedRotorTest;
