package TestComplex
  model Basic
    Complex z, w, v, y, q(re = time, im = 2),r,s;
    Real x;
  equation 
    x = 2*time;
    z = Complex(time);
    w = Complex(time, 1);
    v = z*w;
    y = time*w;
    r = q;
    s = x*w;
  end Basic;


  model Reduced
    Complex z, w, v, y, p, q(re = time, im = 2), r, s;
    Real x;
  equation
    x = 2 * time;
    z = Complex(time);
    w = Complex(time, 1);
    v = z * w;
    y = time * w;
    p = sqrt(3) * w;
    r = q;
    s = x * w;
  end Reduced;






  
  model Test
    Basic M1;
    Basic M2[2];
  end Test;
end TestComplex;
