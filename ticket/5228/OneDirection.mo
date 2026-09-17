package OneDirection
  model Source
    output Real h;
  initial equation
    h = 0;
  equation
    der(h) = 1;
  end Source;

  model Target
    input Real d;
    output Real h;
  initial equation
    h = 1;
  equation
    der(h) = d;
  end Target;

  model OneDir
    Source S1;
    Target S2;
  equation
    connect(S1.h, S2.d);
  end OneDir;
end OneDirection;
