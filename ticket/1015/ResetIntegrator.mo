model ResetIntegrator
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
  Real state;
  parameter Real zero=1e-05;
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(x=-90.27189, y=59.032257, scale=0.21000001), iconTransformation(x=-92.0, y=55.0, scale=0.21000001)));
  Modelica.Blocks.Interfaces.RealInput c annotation(Placement(transformation(x=-90.64056, y=-0.69585264, scale=0.21000001), iconTransformation(x=-82.0, y=-3.0, scale=0.21000001)));
  Modelica.Blocks.Interfaces.RealInput s annotation(Placement(transformation(x=-88.15208, y=-59.207375, scale=0.21000001), iconTransformation(x=-87.0, y=-69.0, scale=0.21000001)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(x=96.792625, y=0.1520737, scale=0.21000001), iconTransformation(x=87.0, y=-1.0, scale=0.21000001)));

equation 
  der(state)=u;
algorithm 
  if c < zero and c > -zero then 
    y:=s;

  else   y:=state;

  end if;
  when c < zero and c > -zero then
      reinit(y,s);
  
  end when;
end ResetIntegrator;

