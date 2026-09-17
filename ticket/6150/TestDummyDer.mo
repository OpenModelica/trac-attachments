model TestDummyDer
  Real x1(stateSelect = StateSelect.avoid);
  Real x2(stateSelect = StateSelect.avoid);
  Real z1(stateSelect = StateSelect.prefer);
  Real z2(stateSelect = StateSelect.prefer);
equation
  der(x1) = -x1 + x2;
  der(x2) = x2 - x1;
  z1 = 4*x1 + 3*x2;
  z2 = 3*x1 - 2*x2;
end TestDummyDer;
