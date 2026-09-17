within ;
package ReplaceableError 
  model model1 
    package myModelPackage = package1;
    model2 component1(redeclare package modelPackage=myModelPackage);
  equation 
    
  end model1;
  
  model model2 
    replaceable package modelPackage = package1 extends basePackage;
    extends modelPackage.Base;
    extends modelPackage.Base2;
    Real b;
  equation 
    b = a;
  end model2;
  
  package package1 
    extends ReplaceableError.basePackage;
  end package1;
  
  package basePackage 
    model Base 
      Real a(start=1);
    equation 
      der(a)=1;
    end Base;
    
    replaceable partial model Base2     
    end Base2;
    
  end basePackage;
  annotation (uses(Modelica(version="2.2.2")));
end ReplaceableError;
