within ;
model TestVarType

  model T
    Real x;
  equation
    x = 2;
  end T;

  T t[4];

end TestVarType;
