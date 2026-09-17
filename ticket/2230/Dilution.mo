within ;
model Dilution "we need to move the result's time axis by -t"
  Real step;
  parameter Integer num = 40;
  Real u[num](start = {0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0});
  parameter Real alfa = 2.3 "thermal diffusility of iron";
  parameter Integer position = 8;
  parameter Integer thickness = 2;
  parameter Real t = 4;
  parameter Real length = 10;
  parameter Real liquid_flow = 0;
  Integer n(start = 0);
  //Real eventTime;
  discrete Real result(start = 0);
  discrete Real res[num](each start = -0.1);
equation
  length = step * num;
  u[end] = u[end - 1];
  u[2] = u[1];

  for i in 2:num - 1 loop
    der(u[i]) = (alfa * (u[i + 1] - 2 * u[i] + u[i - 1]) - liquid_flow * (u[i] - u[i - 1])) / step;
  end for;

  when time > num + pre(n) * step then
    n = pre(n) + 1;
    result = res[n];
  end when;

   when time > t then
     for i in 1:num loop
       res[i] = u[i];
     end for;
   end when;
  annotation(uses(Modelica(version = "3.1")));
end Dilution;

