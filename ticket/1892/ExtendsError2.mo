within ;
package ExtendsError2
  package Package1
    constant Integer Int1=2;
    model Model2     
    end Model2;
  end Package1;

  model Model1
    package Package2 = Package1;
    extends Package2.Model2;
    constant Integer Int2 = Package2.Int1;
  equation

  end Model1;
  annotation (uses(Modelica(version="3.0")));
end ExtendsError2;
