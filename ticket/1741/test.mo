

class TestObject
  extends ExternalObject;

  function constructor
    input Real value;
    output TestObject obj;
    external "C" obj = initTest(value) annotation(Library="TestObj");
  end constructor;
  
  function destructor
    input TestObject obj;
    external "C" clearTest(obj) annotation(Library="TestObj");
  end destructor;
end TestObject;

function evaluateTest
  input TestObject obj;
  input Real t;
  output Real value;
          
  external "C" evaluateTest(obj, t, value) annotation(Library="TestObj");
end evaluateTest; 

model Model
  parameter Real value = 10;
  TestObject obj = TestObject(value = value);
   
  Real v;
 
equation  
  v = evaluateTest(obj, time);
end Model;


model Test
  parameter Real value = 5;
  Model m(value = value);

  Real y;
  Real x; 
equation
  y = m.v;
  x = m.value;

end Test;
