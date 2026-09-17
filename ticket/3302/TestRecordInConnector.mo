package TestRecordInConnector
  record R
    parameter String myString = "default string";
    parameter Integer n = 0;
    parameter Real x[n] = zeros(n);
    parameter Integer ID = 0;
  end R;

  record Ra
    extends R(final myString = "string a", n = 1);
  end Ra;

  record Rb
    extends R(final myString = "string b", n = 2);
  end Rb;

  record Rc
    extends R(final myString = "string c", n = 3);
  end Rc;

  model SIM
    replaceable parameter Ra r1 constrainedby R(ID = 1);
    replaceable parameter Ra r2 constrainedby R(ID = 2);
  end SIM;

  model Submodel
    outer SIM sim;
    parameter Ra r = sim.r1;
  end Submodel;

  model Tester_workingButWithError
    inner SIM sim annotation(Placement(visible = true, transformation(origin = {38, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Submodel submodel;
  end Tester_workingButWithError;

  model Tester_FlatteningFails
    inner SIM sim(redeclare Rb r1) annotation(Placement(visible = true, transformation(origin = {38, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Submodel submodel;
  end Tester_FlatteningFails;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TestRecordInConnector;