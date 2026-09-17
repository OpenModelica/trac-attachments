package TestAssert
  model M
    Real x = 0;
  equation
    assert(x < 10, "Variable x is too big");
    assert(x < 5, "Variable x is probably too big", AssertionLevel.warning);
  end M;

  model TestWarningConstant
    M m1(x = 3);
    M m2(x = 4);
    M m3(x = 6);
  equation

  end TestWarningConstant;

  model TestWarningVariable
    M m1(x = 3 * time);
    M m2(x = 4 * time);
    M m3(x = 6 * time);
  equation

  end TestWarningVariable;

  model TestWarningRecurring
    M m1(x = 3 * time);
    M m2(x = 4 * time);
    M m3(x = 6 * sin(6.28 * time));
  equation

  end TestWarningRecurring;

  model TestErrorConstant
    M m1(x = 4);
    M m2(x = 20);
    M m3(x = 2);
  equation

  end TestErrorConstant;

  model TestErrorVariable
    M m1(x = 4 * time);
    M m2(x = 20 * time);
    M m3(x = 2 * time);
  equation

  end TestErrorVariable;
end TestAssert;