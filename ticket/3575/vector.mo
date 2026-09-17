package P
  function f
    import SI = Modelica.SIunits;
    import Vec = Modelica.Math.Vectors;
    input Real[3] yAxisSat;
    input Real delT;
    output Real mAtt;
  protected
    Real[3] pt0 = {0, 0, 0};
  algorithm
      pt0 := yAxisSat;
      mAtt := pt0[0];
  end f;

  model M
    import SI = Modelica.SIunits;
    import Vec = Modelica.Math.Vectors;
    parameter SI.Time delT = 0.01;
    Real[3] yAxisSat(each fixed = true);
    Real mAtt(fixed = true);
    algorithm
    when sample(0, delT) then
      yAxisSat := Vec.normalize({0,0,0});
    end when;
      mAtt := f(yAxisSat, delT);
  end M;
end P;