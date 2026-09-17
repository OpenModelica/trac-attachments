model TestOfMediumPipelineOil
  extends Modelica.Media.Examples.Tests.Components.PartialTestModel(redeclare package Medium = MixtureIncompressibleLiquid.Examples.PipelineOil);
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TestOfMediumPipelineOil;