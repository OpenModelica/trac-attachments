within ;
package gaspropreties
model gaspropreties1
  protected
Real pco1;
equation
when initial() then
pco1=14.39;
end when;
end gaspropreties1;
//*************************
  model intake1
    extends gaspropreties1;
  protected
  Real var;
  equation
  var=1/pco1;
  end intake1;
  annotation (uses(Modelica(version="3.1")));
end gaspropreties;

