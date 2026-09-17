model StateSelectCheck
  parameter Boolean preferredStates=true;
  parameter Boolean preferredStatesUnfixed(fixed=false);
  parameter Boolean preferredStatesUnfixedStart(fixed=false,start=true);
  Real x(stateSelect = if preferredStates then StateSelect.prefer else StateSelect.avoid);
  Real y(stateSelect = if preferredStatesUnfixed then StateSelect.prefer else StateSelect.avoid);
  Real z(stateSelect = if preferredStatesUnfixedStart then StateSelect.prefer else StateSelect.avoid);
initial equation
  preferredStatesUnfixed = true;
  preferredStatesUnfixedStart = false;
equation
  der(z) = time;
  0 = x^2 + y^2 + z^2;
  y = x + z;
end StateSelectCheck;