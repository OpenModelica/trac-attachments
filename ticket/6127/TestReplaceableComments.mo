package TestReplaceableComments
  model M
    replaceable model RM = TestReplaceableComments.RM1 constrainedby TestReplaceableComments.BM
      annotation(choicesAllMatching = true);
    parameter Real p = 4;
    RM rm;
  end M;
  
  model S1
    TestReplaceableComments.M m  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end S1;
  
  model S2
    TestReplaceableComments.M m(redeclare model RM = TestReplaceableComments.RM2, p = 5)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end S2;

  partial model BM "Partial model"
  end BM;
  
  model RM1 "Replaceable model 1"
    extends TestReplaceableComments.BM;
    Real x = 3;
  end RM1;
  
  model RM2 "Replaceable model 2"
    extends TestReplaceableComments.BM;
    Real r = 4;
  end RM2;
  
end TestReplaceableComments;
