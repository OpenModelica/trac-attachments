package TestRecordInConnector
  record R
    parameter String myString = "default string";
    parameter Integer ID = 0;
  end R;

  record Ra
    extends R(final myString = "string a");
  end Ra;

  record Rb
    extends R(final myString = "string b");
  end Rb;

  record Rc
    extends R(final myString = "string c");
  end Rc;

  model SIM
    replaceable parameter Ra r1 constrainedby R(ID = 1);
    replaceable parameter Ra r2 constrainedby R(ID = 2);
  end SIM;

  model Submodel
    outer SIM sim;
    parameter Ra r = sim.r1;
  end Submodel;

  model Tester
    inner SIM sim annotation(Placement(visible = true, transformation(origin = {38, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Submodel submodel;
  end Tester;

  model workingTester
    inner SIM sim(redeclare Rb r1) annotation(Placement(visible = true, transformation(origin = {38, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Submodel submodel;
  end workingTester;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TestRecordInConnector;