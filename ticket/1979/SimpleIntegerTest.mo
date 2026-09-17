model SimpleIntegerTest
parameter Integer n=3;
Integer selected(start=1,fixed=true);
Integer chooseInt[n](start=zeros(3),fixed=true);
Integer modtime;
Real te;
equation
  te=time;
modtime=rem(integer(te),n);
if
  (modtime==0) then
chooseInt[1]=1;
chooseInt[2]=0;
chooseInt[3]=0;
elseif
      (modtime==1) then
chooseInt[1]=0;
chooseInt[2]=1;
chooseInt[3]=0;
else
chooseInt[1]=0;
chooseInt[2]=0;
chooseInt[3]=1;
end if;
selected=chooseInt*(1:n);
  annotation (experiment(StopTime=10));
end SimpleIntegerTest;
