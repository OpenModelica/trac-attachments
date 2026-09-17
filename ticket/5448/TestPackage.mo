package TestPackage

  model TestModel
    input Real x;
    output Integer y;
    
  equation
    y = floor(x);
  end TestModel;
  
end TestPackage;
