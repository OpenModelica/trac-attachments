within ;
package TestCaching
  model FirstOrder
    Real u = 0;
    Real x(start = 0, fixed = true);
    Modelica.SIunits.Time T = 1;
  equation
    T*der(x) = u - x;
  end FirstOrder;

  model ResistorSource
    FirstOrder m1(u = u);
    Real u = 0;
    Modelica.Electrical.Analog.Interfaces.Pin p;
    Modelica.Electrical.Analog.Interfaces.Pin n;
    parameter Modelica.SIunits.Resistance R = 1;
  equation
    p.i + n.i = 0;
    p.v - n.v = R*p.i + m1.x;
  end ResistorSource;

  model SystemSmall
    Modelica.Electrical.Analog.Basic.Ground g1, g2;
    TestCaching.ResistorSource rs_1(R = 1, u = sin(time));
    TestCaching.ResistorSource rs_2(R = 2);
    TestCaching.ResistorSource rs_3(R = 3, u = sin(time));
    TestCaching.ResistorSource rs_4(R = 4);
    TestCaching.ResistorSource rs_5(R = 5, u = sin(time));
  equation
    connect(rs_1.n, g1.p);
    connect(rs_5.p, g2.p);
    connect(rs_1.p, rs_2.n);
    connect(rs_2.p, rs_3.n);
    connect(rs_3.p, rs_4.n);
    connect(rs_4.p, rs_5.n);
  end SystemSmall;

  model GenerateSystemLarge
    constant Integer N = 100 "Number of generators with modifier";
    constant Integer M = 50
      "Number of modifier-less generator per generator with modifier";
  constant String fn = "SystemLarge.mo";
  algorithm
    when terminal() then
      Modelica.Utilities.Streams.print("model SystemLarge", fn);
      Modelica.Utilities.Streams.print("  Modelica.Electrical.Analog.Basic.Ground g1, g2;", fn);
      for i in 0:N-1 loop
        Modelica.Utilities.Streams.print("  TestCaching.ResistorSource rs_"+String(i*M+1)+"(R = "+String(i*M+1)+", u = sin(time));", fn);
        for j in 2:M loop
          Modelica.Utilities.Streams.print("  TestCaching.ResistorSource rs_"+String(i*M+j)+"(R = "+String(i*M+j)+");", fn);
        end for;
      end for;
      Modelica.Utilities.Streams.print("  TestCaching.ResistorSource rs_"+String(N*M+1)+"(R = "+String(N*M+1)+", u = sin(time));", fn);
      Modelica.Utilities.Streams.print("equation", fn);
      Modelica.Utilities.Streams.print("  connect(rs_1.n, g1.p);", fn);
      Modelica.Utilities.Streams.print("  connect(rs_"+String(N*M+1)+".p, g2.p);", fn);
      for i in 0:N-1 loop
        for j in 1:M loop
          Modelica.Utilities.Streams.print("  connect(rs_"+String(i*M+j)+".p, rs_"+String(i*M+j+1)+".n);", fn);
        end for;
      end for;
      Modelica.Utilities.Streams.print("end SystemLarge;", fn);
    end when;
  end GenerateSystemLarge;
  annotation (uses(Modelica(version="3.2.1")));
end TestCaching;
