package TestPackage
model Test
  Real x(start = 0, fixed = true);
equation
  der(x) = 1 - x;
end Test;
end TestPackage;
