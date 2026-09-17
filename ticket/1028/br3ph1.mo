model br3ph1 "three phase diode bridge feeding R-L load (source inductance present"
   constant Real PI = Modelica.Constants.pi;
   Modelica.Electrical.Analog.Sources.SineVoltage src_a(V=120.0,phase=0,freqHz=60.0);
   Modelica.Electrical.Analog.Sources.SineVoltage src_b(V=120.0,phase=-2*PI/3,freqHz=60.0);
   Modelica.Electrical.Analog.Sources.SineVoltage src_c(V=120.0,phase=2*PI/3,freqHz=60.0);
   Modelica.Electrical.Analog.Basic.Resistor rs[3](each R=0.1) "source resistance";
   Modelica.Electrical.Analog.Basic.Inductor ls[3](each L=1e-3) "source inductance";
   Modelica.Electrical.Analog.Ideal.IdealDiode D1,D2,D3,D4,D5,D6;
   Modelica.Electrical.Analog.Basic.Resistor r_l(R=1) "load resistance";
   Modelica.Electrical.Analog.Basic.Inductor l_l(L=0.1) "load inductance";
   Modelica.Electrical.Analog.Basic.Ground g;

   Real v_out, i_out;

equation
   connect(src_a.p,rs[1].p);
   connect(src_b.p,rs[2].p);
   connect(src_c.p,rs[3].p);
   connect(src_a.n,src_b.n);
   connect(src_b.n,src_c.n);
   connect(src_c.n,g.p);

   connect(rs[1].n,ls[1].p);
   connect(rs[2].n,ls[2].p);
   connect(rs[3].n,ls[3].p);

   connect(ls[1].n,D1.p);
   connect(D1.p,D4.n);

   connect(ls[2].n,D3.p);
   connect(D3.p,D6.n);
   
   connect(ls[3].n,D5.p);
   connect(D5.p,D2.n);

   connect(D1.n,D3.n);
   connect(D3.n,D5.n);
   connect(D5.n,r_l.p);
   connect(r_l.n,l_l.p);
   connect(l_l.n,D2.p);
   connect(D2.p,D6.p);
   connect(D6.p,D4.p);

   v_out = r_l.p.v - l_l.n.v;
   i_out = r_l.p.i;
end br3ph1;
