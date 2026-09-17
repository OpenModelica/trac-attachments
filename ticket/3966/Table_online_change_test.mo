model Table_online_change_test
  parameter Real[5] x1 = {0, 1, 2, 3, 4};
  Real[5] y1(start = {0, 1, 2, 3, 4});
  Real   xa(start=0),xb(start=0),ya,yb;
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-114, 38}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

algorithm 

for i in 1:size(x1,1) loop  
  if i==1 and x1[i]>u then
    xa:=x1[1];
    xb:=x1[1];
    ya:=y1[1];
    yb:=y1[1];
      break;
  elseif i>1 then
      if x1[i]>u and x1[i-1]<=u then
        xa:=x1[i-1];
        xb:=x1[i];
        ya:=y1[i-1];
        yb:=y1[i];
           break;
       else
        xa:=x1[size(x1,1)];
        ya:=y1[size(x1,1)];
        xb:=x1[size(x1,1)];
        yb:=y1[size(x1,1)];
       end if;
  else 
    xa:=x1[size(x1,1)];
    ya:=y1[size(x1,1)];
    xb:=x1[size(x1,1)];
    yb:=y1[size(x1,1)];  
  end if;
end for;

equation

if xa==xb then
  y=ya;
else
  y=(u-xa)*(yb-ya)/(xb-xa)+xa;
end if;  


when time>1 then
 y1[1]=pre(y1[1]);
 y1[2]=pre(y1[2]);
 y1[3]=pre(y1[3])+5;
 y1[4]=pre(y1[4]);
 y1[5]=pre(y1[5]);
end when;



  
  annotation(uses(Modelica(version = "3.2.1")), experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end Table_online_change_test;