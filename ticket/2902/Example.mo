within ;
package Example 
  function conj "Conjugate of complex number" 
    input Complex c1 "Complex number";
    output Complex c2 "= c1.re - j*c1.im";
  algorithm 
    c2 := Complex(c1.re, -c1.im);
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function returns the Complex conjugate of the Complex input.</p>
                         </html>"));
  end conj;
  
  function real "Real part of complex number" 
    input Complex c "Complex number";
    output Real r "= c.re ";
  algorithm 
    r := c.re;
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function returns the real part of the Complex input.</p>
                         </html>"));
  end real;
  
  function imag "Imaginary part of complex number" 
    input Complex c "Complex number";
    output Real r "= c.im ";
  algorithm 
    r := c.im;
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function returns the imaginary part of the Complex input.</p>
                         </html>"));
  end imag;
  
  function arg "Phase angle of complex number" 
    input Complex c "Complex number";
    input Modelica.SIunits.Angle phi0 = 0 
      "Phase angle phi shall be in the range: -pi < phi-phi0 < pi";
    output Modelica.SIunits.Angle phi "= phase angle of c";
  algorithm 
    phi := Modelica.Math.atan3(
        c.im, 
        c.re, 
        phi0);
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function returns the Real argument of the Complex input, i.e., it's angle.</p>
                         </html>"));
  end arg;
  
  function 'abs' "Absolute value of complex number" 
    input Complex c "Complex number";
    output Real result "= abs(c)";
  algorithm 
    result := (c.re ^ 2 + c.im ^ 2) ^ 0.5;
    //changed from sqrt
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function returns the Real absolute of the Complex input, i.e., it's length.</p>
                         </html>"));
  end 'abs';
  
  function fromPolar "Complex from polar representation" 
    input Real len "abs of complex";
    input Modelica.SIunits.Angle phi "arg of complex";
    output Complex c "= len*cos(phi) + j*len*sin(phi)";
  algorithm 
    c := Complex(len*Modelica.Math.cos(phi), len*Modelica.Math.sin(phi));
    annotation(Inline = true, Documentation(info = "<html>
                         <p>This function constructs a Complex number from it's length (absolute) and angle (argument).</p>
                         </html>"));
  end fromPolar;
  
  
  
  model Test_complex 
    
    Complex_bindinglost complex_bindinglost1 annotation (Placement(
          visible=true, transformation(
          origin={-40,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
   Complex_bindingOK complex_bindingok1 annotation (Placement(
          visible=true, transformation(
          origin={40,0},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Test_complex;
  
  
  
  model Complex_bindinglost 
    constant Real pi = Modelica.Constants.pi;
    parameter Real eterm = 0.999999 "terminal voltage";
    //1.0
    parameter Real anglev0 = 4.0463 "Power flow, node angle in degree";
    parameter Real pelec = 0.399989 * 100 "active power MVA";
    //80.0
    parameter Real qelec = 5.41649 "reactive power MVA";
    //50.0
    parameter Real wbase = 2 * pi * 50 "system base speed";
    parameter Real mbase = 100 "system base power rating MVA";
    parameter Real Ra = 0 "amature resistance";
    parameter Real Xpp = 1;
    parameter Real anglev_rad = anglev0 * pi / 180 
      "initial value of bus anglev in rad";
    parameter Real p0 = pelec / mbase 
      "initial value of bus active power in p.u.";
    parameter Real q0 = qelec / mbase 
      "initial value of bus reactive power in p.u.";
    parameter Complex Zs(re = Ra, im = Xpp) "Equivation impedance";
    parameter Complex VT(re = eterm * cos(anglev_rad), im = eterm * sin(anglev_rad));
    parameter Complex S(re = p0, im = q0);
    parameter Complex It = conj(S / VT);
    //Initialize current and voltage components of rotor reference fram (dq axes).
  end Complex_bindinglost;
  
  model Complex_bindingOK 
    constant Real pi = Modelica.Constants.pi;
    parameter Complex Zs(re = 1, im = 1) "Equivation impedance";
    parameter Complex VT(re = cos(pi), im = sin(pi));
    parameter Complex S(re = 1, im = 1);
    parameter Complex It = conj(S / VT);
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Complex_bindingOK;
  annotation (uses(Complex(version="3.2.1"), Modelica(version="2.2.2")));
end Example;
