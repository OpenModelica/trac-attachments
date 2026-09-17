within ;
package VariableError
  partial package Common
    constant Integer int1;
    constant Integer int2;
    replaceable partial model Model1
      Real c[int1];
      Real Variable1;
    end Model1;
  end Common;

  package Package1
    extends Common(int1=2, int2=2);
    redeclare partial model extends Model1
    equation
      Variable1 = c[int2];
    end Model1;

  end Package1;

  model Model2
    extends Package1.Model1;
    Real Variable2[2]={1,2};
  equation
    Variable2 = c;
  end Model2;
  annotation (uses(Modelica(version="3.0")));
end VariableError;
