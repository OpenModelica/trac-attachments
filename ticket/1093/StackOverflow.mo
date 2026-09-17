model SubTest
  parameter Real c = 1;
end SubTest; 

model GeneralTest
  SubTest t1;
  SubTest t2;
end GeneralTest; 

// OMC fails with Stack Overflow if you try to simulate the following model 'TestFail'
model TestFail
  extends GeneralTest( t1(c = c), t2(c = c));
  parameter Real c = 2;
end TestFail;

// OMC does not fail to simulate the following model 'TestOK' however
model TestOK
  extends GeneralTest( t1(c = c2), t2(c = c2));
  parameter Real c2 = 2;
end TestOK;
