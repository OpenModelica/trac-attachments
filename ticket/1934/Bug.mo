within ;
package Bug
  package Interface
    partial function partial_T
      input Real x;
      output Real y;
    end partial_T;

    partial record BaseClass
      replaceable partial function T = Bug.Interface.partial_T;
    end BaseClass;
  end Interface;

  package Implementation
    function const_T
      extends Interface.partial_T;
    algorithm
      y := x;
    end const_T;

    record SubClass
      extends Interface.BaseClass(redeclare final function T = const_T);
    end SubClass;
  end Implementation;

  model Component
    Real x = 1;
    Real y;
    outer Interface.BaseClass prop;
  equation
    y = prop.T(x);
  end Component;

  model Test
    Component component
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    inner Implementation.SubClass prop
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  end Test;
  annotation (uses(Modelica(version="3.2")));
end Bug;
