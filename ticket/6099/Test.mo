package Test

function f1
  input  Real Z[:,:];
  output Real y;  
algorithm
  y:= 1/(sum({{ Z[i,j] for j in 1:size(Z,2)} for i in 1:size(Z,1)}));
end f1;

model M1
  constant Integer n = 2;
  constant Integer m = 1;  
  Real[n,m] Z(start=[1; 0]);
  Real x;
equation
  Z = {{ 0 for j in 1:m} for i in 1:n};     
  x = f1(Z); 
end M1;

end Test;
