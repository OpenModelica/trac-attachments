model ComplexArray

  record Complex
    Real re;
	Real im;
  end Complex;
  
  function g
    input Real i;
	output Real o;
  protected
    Complex a = Complex(0.0, 0.0);
    Complex[3] r = 
	  {Complex(-72.597457432922, -78.100842711287), 
	   Complex(-0.0000557107698030123, 0.0000464578634580806), 
	   Complex(0.0000000000234801409215913, -0.0000000000285651142904972)};
  algorithm
    for k in 1:3 loop
      a.re := a.re + r[k].re * i;
    end for;
	o := a.re;
  end g;
  
  Real x;
equation
  x = g(time);
end ComplexArray;

