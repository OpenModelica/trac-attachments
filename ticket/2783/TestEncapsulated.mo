within ;
package TestEncapsulated
  model MyModelWithEncapsulated
    parameter Real m = 4.0;
    encapsulated model myEncapsulated
     import TestEncapsulated.Interface;
     extends Interface;
    equation
          var = u;
    end myEncapsulated;
    myEncapsulated myEncapsulated1
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  equation
    connect(myEncapsulated1.y, y) annotation (Line(
        points={{1,0},{100,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, myEncapsulated1.u) annotation (Line(
        points={{-59,0},{-22,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end MyModelWithEncapsulated;

  package Functions
    function CalcSomething
      input Real u;
      output Real y;
    algorithm
      y:= u+3.2;
    end CalcSomething;
  end Functions;

  partial model Interface
     extends Modelica.Blocks.Interfaces.SISO;
     Real var;
  equation
    y = TestEncapsulated.Functions.CalcSomething(var);
  end Interface;
  annotation (uses(Modelica(version="3.2.1")));
end TestEncapsulated;
