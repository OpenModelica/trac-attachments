package TestComplexConnect
  connector pin
    Modelica.SIunits.ComplexVoltage v;
    flow Modelica.SIunits.ComplexCurrent i;
  end pin;
 
  model VSource
    parameter Modelica.SIunits.ComplexVoltage v = Complex(0);
    pin p;
  equation
    p.v = v;   
  end VSource;


  model Impedance1
    pin p;
    parameter Modelica.SIunits.ComplexImpedance Z;
  equation
    p.v = Z * p.i;
  end Impedance1;



  
  model Impedance2
    pin p,n;
    parameter Modelica.SIunits.ComplexImpedance Z;
    Modelica.SIunits.ComplexVoltage v;
    Modelica.SIunits.ComplexCurrent i;
  equation
    v = p.v - n.v;
    p.i + n.i = Complex(0);
    i = p.i;
    v = Z*i;
  end Impedance2;


  model Circuit1
    VSource V1(v = Complex(1, 0));
    Impedance1 Z1(Z = Complex(0, 1));
  equation
    connect(V1.p, Z1.p);
  end Circuit1;



  model Circuit1a
    VSource V1(v = Complex(1, 0));
    Impedance1 Z1(Z = Complex(0, 1));
    Impedance1 Z2(Z = Complex(1, 0));
  equation
    connect(V1.p, Z1.p);
    connect(V1.p, Z2.p);
  end Circuit1a;





  
  model Circuit2
    VSource V1(v = Complex(1,0));
    VSource V2;
    Impedance2 Z1(Z = Complex(0,1));
  equation
    connect(V1.p, Z1.p);
    connect(Z1.n, V2.p);
  end Circuit2;

end TestComplexConnect;
