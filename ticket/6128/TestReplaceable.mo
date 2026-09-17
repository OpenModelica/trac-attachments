package TestReplaceable
  model M
    replaceable model RM = TestReplaceable.RM1 constrainedby TestReplaceable.BM
      annotation(choicesAllMatching = true);
    parameter Real p = 4;
    RM rm;
  end M;
  
  model S1
    TestReplaceable.M m(
      redeclare model RM = TestReplaceable.RM1,
      p = 5)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end S1;

  partial model BM "Partial model"
  end BM;
  
  model RM1 "Replaceable model 1"
    extends TestReplaceable.BM;
    Real x = 3;
  end RM1;
end TestReplaceable;
