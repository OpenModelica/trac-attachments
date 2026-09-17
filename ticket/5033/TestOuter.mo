package TestOuter

partial model PartialFluid
  constant Real c = 1;
  partial function fBase
    input Real u;
    output Real y;
  end fBase;
end PartialFluid;

model MyFluid
  extends PartialFluid;
  function f
    extends fBase;
  algorithm
    y := 3*u;
  end f;
end MyFluid;

model System
  replaceable model FluidModel = MyFluid constrainedby PartialFluid;
  FluidModel fluid;
end System;

model Component
  outer System system;
  Real a = system.fluid.f(3);
end Component;

model Model
  Component c;
  inner System system;
end Model;

end TestOuter;
