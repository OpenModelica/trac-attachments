model M
  Real temper[10];
  Integer k(start = 0);
  Integer i;
algorithm
  when sample(0, 100) then
      k:=1 + integer(time / 100);  
  end when;
  when sample(0, 10) then
      i:=1 + integer((time - (k - 1) * 100) / 10);
    temper[i]:=17 + temper[i];  
  end when;
  annotation(experiment(StartTime = 0.0, StopTime = 1000.0, Tolerance = 0.000001));
end M;

