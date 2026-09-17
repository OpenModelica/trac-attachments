model TestProtectedInput
  protected
    Modelica.Blocks.Interfaces.BooleanInput u;
equation
  u = time > 1 and time < 2;
  annotation(
    experiment(StopTime = 10));
end TestProtectedInput;
