model Alias_debug "Test whether alias variables get displayed in OM Transformational Debugger. PH, April 2020. With OM 1.15 dev, 'y' is not visible, only '(alias) 3'"
  Real x(start=1),y;
  
equation
  der(x) = -x;
  y = x;

end Alias_debug;