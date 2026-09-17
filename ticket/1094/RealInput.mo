// works, 2 equations and 2 variables
model RealInputOK 
  input Real u;
  Modelica.Blocks.Continuous.FirstOrder firstOrder;
equation
  connect(u, firstOrder.u);  
end RealInputOK;

// fails, 3 equations and 2 variables
connector RealInput = input Real;	// from Modelica.Blocks.Interfaces.RealInput
model RealInputFail 
  RealInput u;
  Modelica.Blocks.Continuous.FirstOrder firstOrder;
equation
  connect(u.x, firstOrder.u);  
end RealInputFail;
