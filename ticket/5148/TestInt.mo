model TestInt
  input Integer inInt;
  output Integer outInt;
  output Integer passthrough;
initial equation
  outInt = 0;
algorithm
  when inInt > pre(inInt) then
    outInt := outInt + 1;
  end when;
equation
  passthrough = inInt;
end TestInt;