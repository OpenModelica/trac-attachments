model delay_n_differentialequation 
  "class for the differential equation for a n series time delay function for sensor classes" 
  parameter Modelica.SIunits.Time T90 = 1 
    "The T90 delay time of this sensor [min!!!]";
  parameter Integer n = 2 "Number of first order transfer functions in series";
  
  Modelica.SIunits.Time Tac( start=0.5) 
    "the actual delay time in the diff.eqns [min!!!]";
  
protected 
  parameter Real ht = 0.9 "percentages of response after step";
  
equation 
  ht = 1 - sum(  1/(Tac^(i-1)) * product(  1/j for j in 1:i-1) * T90^(i-1) * exp(-1/Tac * T90) for i in 1:n);
end delay_n_differentialequation;
