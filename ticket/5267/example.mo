model example

input Real myInput;
output Real myOutput(start = 0.5, fixed = true);
parameter Integer MyParam = 1;
Boolean myVar(start = false, fixed = true);

equation
der(myOutput) = -myOutput - MyParam - myInput;
myVar = if myOutput < -0.5 then true else false;

end example;


