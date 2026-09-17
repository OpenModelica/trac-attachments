package Test
  function f1
    input Real u1;
  end f1;
  
  function f2
    input Boolean b1;
  end f2;
 
  model M1
    replaceable function fr = f1
    constrainedby f2;
  end M1;

end Test;