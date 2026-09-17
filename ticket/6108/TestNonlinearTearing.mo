package TestNonlinearTearing
  model Test1
    Real x1(start = 1);
    Real x2(start = 3);
    Real x3(start = 0);
    Real x4(start = 10);
    Real x5;
  equation
    sin(x1 - 10) * sin(x1 - 1) + 1e-2 * x5 = 0;
    1e-6 * x1 + x2 + 1e-2 * x3 + 1e-2 * x4 + 1e-2 * x5 = 1;
    1e-6 * x1 + 1e-6 * sin(x2) + x3 + 1e-6 * x4 = 0;
    (x4 - 10) * (x4 - 1) + 1e-2 * x1 + 1e-2 * x2 + 1e-2 * x3 + 1e-2 * x4 = 0;
    1e-6 * x1 + x5 + sin(x3) + 1e-6 * x4 = 4;
  end Test1;

  model Test2
    extends Test1;
    annotation(
      __OpenModelica_commandLineOptions = "--tearingMethod=minimalTearing");
  end Test2;
end TestNonlinearTearing;
