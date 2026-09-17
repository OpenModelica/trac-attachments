package P
  expandable connector bus
  end bus;
  model M
    Modelica.Blocks.Continuous.FirstOrder fo;
  equation
    connect(fo.u, bus.u);
  end M;
end P;
