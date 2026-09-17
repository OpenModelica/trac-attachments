model MultiFunctionReturnValueUseOnlyFirst
equation
  assert(abs(Modelica.Math.Vectors.interpolate({ 0,  2,  4,  6,  8, 10},{10, 20, 30, 40, 50, 60},5)) < 0.1,"Only a Test");
end MultiFunctionReturnValueUseOnlyFirst;