within ;
partial package MyPartialMedium
  replaceable partial function MyFunction
    output Modelica.SIunits.SpecificHeatCapacityAtConstantPressure CP "Cp";
  end MyFunction;
end MyPartialMedium;


package MyMedium1
  extends MyPartialMedium;
  redeclare function extends MyFunction
  algorithm
    CP:=1;
  end MyFunction;
end MyMedium1;


package MyMedium2
  extends MyPartialMedium;
  redeclare function extends MyFunction
  algorithm
    CP:=2;
  end MyFunction;
end MyMedium2;


model MyComponent
  replaceable package componentMedium = MyPartialMedium;
  Real result;
equation
  result = componentMedium.MyFunction();
end MyComponent;


model MyModel1
  replaceable package model1Medium = MyMedium1 constrainedby MyPartialMedium;
  MyComponent comp(redeclare package componentMedium = model1Medium);
  Real result;
equation
  result = comp.result;
end MyModel1;


model MyModel2
  replaceable package model2Medium = MyMedium2 constrainedby MyPartialMedium;
  MyComponent comp(redeclare package componentMedium = model2Medium);
  Real result;
equation
  result = comp.result;
end MyModel2;


model MyModel3
  MyModel1 model1(redeclare package model1Medium = MyMedium2);
  Real result;
equation
  result = model1.result;
end MyModel3;

