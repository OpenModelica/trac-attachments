package TestReplaceablePaths
  model M
    replaceable model RM = RM1 constrainedby BM
      annotation(choicesAllMatching = true);
    RM rm;
  end M;
  
  model S
    M m annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end S; 

  partial model BM
    parameter Real p;
  end BM;
  
  model RM1
    extends BM(p = 1);
    parameter Real q = 2;
  end RM1;
  
  model RM2
    extends BM(p = 2);
    parameter Real r = 4;
  end RM2;
  
end TestReplaceablePaths;
