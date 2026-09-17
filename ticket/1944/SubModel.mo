within ;
model SubModel
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_a topPorts[0](
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(
        extent={{-20,0},{20,10}},
        origin={0,100})));

  annotation (uses(Modelica(version="3.2.1")));
end SubModel;
