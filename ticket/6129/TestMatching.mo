package TestMatching
  partial model B1
    constant Real dummy;
  end B1;
   
  model D1
    extends B1;
  end D1;   

  model D2
    extends B1;
  end D2;   

  model M1
    replaceable model rmod = D1
      constrainedby B1
      annotation(choicesAllMatching = true);
  end M1;
  
  model M2
    replaceable model rmod = D1
      constrainedby B1
      annotation(choicesAllMatching = true);  
  end M2;
  
  model M3
    TestMatching.M2 m2 annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end M3;
end TestMatching;
