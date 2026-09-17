package extendsError

  package Package1
    model Model1

    end Model1;
  end Package1;

  model Model2
    package P = Package1;
    extends P.Model1;
  equation

  end Model2;
end extendsError;
