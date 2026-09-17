model Ex2_6_1
//solved by rungakutta method for range x>0
Real x,y;
equation
(x*y+y^2 +x^2)-der(y)*x^2=0;
x= time;
end Ex2_6_1;
