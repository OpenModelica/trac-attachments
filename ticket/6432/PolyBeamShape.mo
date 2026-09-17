model PolyBeamShape "Visualizing a beam with fixed shape given some points"
  parameter Modelica.SIunits.Position r_shape[3, :] = {{1.0, 0, 0}, {0, 1.0, 0}, {0, 0, 1.0}};

  parameter Integer ptsCount = size(r_shape, 2);
  parameter Real length[ptsCount - 1] = {Modelica.Math.Vectors.norm(r_shape[1:3, pt_sel + 1] - r_shape[:, pt_sel]) for pt_sel in 1:ptsCount - 1};
end PolyBeamShape;
