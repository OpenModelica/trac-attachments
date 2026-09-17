model IndexConnect
  connector A
    Real a;
  end A;
  constant Integer n=5;
  A a[n];
equation 
  a[1].a = 1;
  connect(a[1:n-1],a[2:n]);
end IndexConnect;

model IndexConnectFor
  connector A
    Real a;
  end A;
  constant Integer n=5;
  A a[n];
equation 
  a[1].a = 1;
  for i in 2:n loop
	connect(a[i-1],a[i]);
  end for;
end IndexConnectFor;



