package TestConstrainedBy
  partial package BaseMedium
    partial function f
      input Real x;
      output Real y;
    end f;
  end BaseMedium;
  
  package RegularMedium
    extends BaseMedium;
    redeclare function extends f
    algorithm
      y :=3*x^3;
    end f;
  end RegularMedium;
  
  package AdvancedMedium
    extends BaseMedium;
    function fa
      input Real x;
      output Real y;
    algorithm
      y := 3*x^2;
    end fa;
  end AdvancedMedium;
  
  model Component
    replaceable package Medium = AdvancedMedium constrainedby BaseMedium;
    Real x = Medium.fa(time);
  end Component;
  
  model SystemOK
    Component c;
  end SystemOK;
  
  model SystemBroken
    Component c(redeclare package Medium = RegularMedium);
  end SystemBroken;
end TestConstrainedBy;
