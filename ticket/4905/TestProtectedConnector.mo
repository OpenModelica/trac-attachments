package TestProtectedConnector
  model M
    Modelica.Blocks.Interfaces.RealInput u if use_u;
    parameter Boolean use_u;
  // protected
    Modelica.Blocks.Interfaces.RealInput u_internal;
  equation
    if not use_u then
      u_internal = 1;
    end if;
    connect(u, u_internal);
  end M;

  model P
    TestProtectedConnector.M m1(use_u = true);
    TestProtectedConnector.M m2(use_u = false);
    Modelica.Blocks.Sources.RealExpression source;
  equation
    connect(source.y, m1.u);
  end P;
end TestProtectedConnector;
