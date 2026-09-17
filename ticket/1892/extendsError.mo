within ;
package ExtendsError
  package Package1
    model Model2     
    end Model2;
  end Package1;

  model Model1
    package Package2 = Package1;
    extends Package2.Model2;
  equation

  end Model1;
  annotation (uses(Modelica(version="3.0")));
end ExtendsError;
