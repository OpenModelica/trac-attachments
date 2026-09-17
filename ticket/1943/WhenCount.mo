within ;
model WhenCount
  type EnumA = enumeration(
      Value1,
      Value2);

  EnumA a;

equation
  when (time > 0.5) then
    if (time < 1) then
      a = EnumA.Value1;
    else
      a = EnumA.Value2;
    end if;
  end when;

  annotation (uses(Modelica(version="3.2")));
end WhenCount;
