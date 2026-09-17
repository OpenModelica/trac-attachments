model invlaid_xml
  Real y(start = 5) "foo & bar";
  Real vy(start = 0);
  Real ay;
equation
  der(y) = vy;
  der(vy) = ay;
  ay = -9.8;
  when y <= 0 and vy <= 0 then
      reinit(.vy, -0.9 * pre(vy));
  
  end when;
end invlaid_xml;

