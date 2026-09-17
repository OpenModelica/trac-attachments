within ;
model ControlledMixingUnit2
  extends Modelica_Synchronous.Examples.Systems.ControlledMixingUnit(
    periodicClock1(solverMethod="ImplicitEuler"));
  annotation(uses(Modelica_Synchronous(version="0.92.1")));
end ControlledMixingUnit2;
