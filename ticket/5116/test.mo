operator record Complex  "Complex number with overloaded operators" 
  replaceable Real re "Real part of complex number";
  replaceable Real im "Imaginary part of complex number";

  encapsulated operator 'constructor'  "Constructor" 
    function fromReal  "Construct Complex from Real" 
      import Complex;
      input Real re "Real part of complex number";
      input Real im = 0 "Imaginary part of complex number";
      output Complex result(re = re, im = im) "Complex number";
    algorithm
      annotation(Inline = true); 
    end fromReal;
  end 'constructor';

  encapsulated operator '*'  "Multiplication" 
    function multiply  "Multiply two complex numbers" 
      import Complex;
      input Complex c1 "Complex number 1";
      input Complex c2 "Complex number 2";
      output Complex c3 "= c1*c2";
    algorithm
      c3 := Complex(c1.re * c2.re - c1.im * c2.im, c1.re * c2.im + c1.im * c2.re);
      annotation(Inline = true); 
    end multiply;

    function scalarProduct  "Scalar product c1*c2 of two complex vectors" 
      import Complex;
      input Complex[:] c1 "Vector of Complex numbers 1";
      input Complex[size(c1, 1)] c2 "Vector of Complex numbers 2";
      output Complex c3 "= c1*c2";
    algorithm
      c3 := Complex(0);
      for i in 1:size(c1, 1) loop
        c3 := c3 + c1[i] * c2[i];
      end for;
      annotation(Inline = true); 
    end scalarProduct;
  end '*';

  encapsulated operator function '+'  "Add two complex numbers" 
    import Complex;
    input Complex c1 "Complex number 1";
    input Complex c2 "Complex number 2";
    output Complex c3 "= c1 + c2";
  algorithm
    c3 := Complex(c1.re + c2.re, c1.im + c2.im);
    annotation(Inline = true); 
  end '+';
end Complex;

package ComplexMath
  function exp
    input Complex c1;
    output Complex c2;
  algorithm
    c2 := Complex(.exp(c1.re) * cos(c1.im), .exp(c1.re) * sin(c1.im));
    annotation(Inline = true); 
  end exp;
end ComplexMath;

model SinglePhaseElectroMagneticConverter
  parameter Real effectiveTurns;
  parameter Real orientation annotation(Evaluate = true);
  final parameter Complex N = effectiveTurns * ComplexMath.exp(Complex(0, orientation));
end SinglePhaseElectroMagneticConverter;

model MultiPhaseElectroMagneticConverter
  parameter Integer m = 3;
  parameter Real[m] effectiveTurns;
  parameter Real[m] orientation;
  SinglePhaseElectroMagneticConverter[m] singlePhaseElectroMagneticConverter(final effectiveTurns = effectiveTurns, final orientation = orientation);
end MultiPhaseElectroMagneticConverter;

model SymmetricMultiPhaseCageWinding
  parameter Integer m = 3;
  MultiPhaseElectroMagneticConverter electroMagneticConverter(final m = m, final effectiveTurns = fill(1, m), final orientation = {0, 2, 4});
end SymmetricMultiPhaseCageWinding;
