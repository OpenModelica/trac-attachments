package TestReplaceablePar
  model M
    replaceable model RM = TestReplaceablePar.RM1 constrainedby TestReplaceablePar.BM
      annotation(choicesAllMatching = true);
    RM rm;
  end M;
  
  model S
    TestReplaceablePar.M m(redeclare model RM = TestReplaceablePar.RM2)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end S;
 

  partial model BM
    parameter Real p;
  end BM;
  
  model RM1 "Replaceable model 1"
    extends TestReplaceablePar.BM(p = 1);
    parameter Real q = 2;
  end RM1;
  
  model RM2 "Replaceable model 2"
    extends TestReplaceablePar.BM(p = 2);
    parameter Real r = 4;
  end RM2;
  
end TestReplaceablePar;
