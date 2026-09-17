package MagTest
  model Core
    Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube generic(area = 0.001)  annotation(
      Placement(visible = true, transformation(origin = {0, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end Core;


  record ExCore
    extends Modelica.Icons.Record;
    extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData(mu_i = 500, B_myMax = 0.7, c_a = 24000, c_b = 9.38, n = 9.6);
    annotation(
      Icon(coordinateSystem(initialScale = 0.05, grid = {0.1, 0.1})));
  end ExCore;
  annotation(
    uses(Modelica(version = "3.2.2")));

end MagTest;
