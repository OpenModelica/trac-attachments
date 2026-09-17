block md_filter
  extends Modelica.Blocks.Interfaces.MISO;
  parameter Real x = 4;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
equation
  y = sum(u)/x;    
end md_filter;
