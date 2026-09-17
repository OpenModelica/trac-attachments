model Model1  
  TestPackage.TestModel testModel1;
equation
  testModel1.x = 2.3;
end Model1;

package TestPackage  
  model TestModel  
    input Real x;
    output Integer y;
  equation
    y = floor(x);
  end TestModel;
end TestPackage;

model Model1_total
  extends Model1;
end Model1_total;
