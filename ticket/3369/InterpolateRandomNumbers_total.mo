package Modelica_Noise  "Modelica_Noise version 1.0-Beta.1 (Library for random numbers and noise signals; planned to be included into the Modelica Standard Library)"
  package Math  "Additions to Math package of MSL"
    package Random  "Library of functions for generating random numbers"
      extends Modelica.Icons.Package;

      package Generators  "Library of functions generating uniform random numbers in the range 0 < random <= 1.0 (with exposed state vectors)"
        extends Modelica.Icons.Package;

        package Xorshift64star  "Random number generator xorshift64*"
          extends Interfaces.PartialGenerator(final nState = 2);

          redeclare function extends initialState  "Returns an initial state for the xorshift64* algorithm"
          protected
            Real r "Random number not used outside the function";
            constant Integer p = 10 "The number of iterations to use";
          algorithm
            if localSeed == 0 and globalSeed == 0 then
              state := {126247697, globalSeed};
            else
              state := {localSeed, globalSeed};
            end if;
            for i in 1:p loop
              (r, state) := random(state);
            end for;
          end initialState;

          redeclare function extends random  "Returns a uniform random number with the xorshift64* algorithm"
            external "C" ModelicaRandom_xorshift64star(stateIn, stateOut, result) annotation(Include = "#include \"ModelicaRandom.c\"");
            annotation(Include = "#include \"ModelicaRandom.c\"");
          end random;
        end Xorshift64star;
      end Generators;

      package Interfaces  "Library of partial packages and functions for the Random package"
        extends Modelica.Icons.InterfacesPackage;

        partial package PartialGenerator  "Interfaces of a uniform random number generator"
          extends Modelica.Icons.Package;
          constant Integer nState = 1 "The dimension of the internal state vector";

          replaceable partial function initialState  "Return the initial internal states for the uniform random number generator"
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
          end initialState;

          replaceable partial function random  "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
          end random;
        end PartialGenerator;
      end Interfaces;

      package Utilities  "Library of utility functions for the Random package (usually of no interest for the user)"
        extends Modelica.Icons.UtilitiesPackage;

        function initialStateWithXorshift64star  "Return an initial state vector for a random number generator (based on xorshift64star algorithm)"
          extends Modelica.Icons.Function;
          input Integer localSeed "The local seed to be used for generating initial states";
          input Integer globalSeed "The global seed to be combined with the local seed";
          input Integer nState(min = 1) "The dimension of the state vector (>= 1)";
          output Integer[nState] state "The generated initial states";
        protected
          Real r "Random number only used inside function";
        algorithm
          if nState >= 2 then
            state[1:2] := .Modelica_Noise.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed);
          else
            state[1] := .Modelica_Noise.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed) * {1, 0};
          end if;
          for i in 3:2:nState - 1 loop
            (r, state[i:i + 1]) := .Modelica_Noise.Math.Random.Generators.Xorshift64star.random(state[i - 2:i - 1]);
          end for;
          if nState >= 3 then
            (r, state[nState - 1:nState]) := .Modelica_Noise.Math.Random.Generators.Xorshift64star.random(state[nState - 2:nState - 1]);
          else
          end if;
        end initialStateWithXorshift64star;

        function initializeImpureRandom  "Initializes the internal state of the impure random number generator"
          input Integer seed "The input seed to initialize the impure random number generator";
          output Integer id "Identification number to be passed as input to function impureRandom, in order that sorting is correct";
        protected
          constant Integer localSeed = 715827883 "Since there is no local seed, a large prime number is used";
          Integer[33] state "The internal state vector of the impure random number generator";

          function setInternalState  "Stores the given state vector in an external static variable"
            input Integer[33] state "The initial state";
            input Integer id;
            external "C" ModelicaRandom_setInternalState_xorshift1024star(state, size(state, 1), id) annotation(Include = "#include \"ModelicaRandom.c\"");
            annotation(Include = "#include \"ModelicaRandom.c\"");
          end setInternalState;
        algorithm
          state := Random.Utilities.initialStateWithXorshift64star(localSeed, seed, size(state, 1));
          id := localSeed;
          setInternalState(state, id);
        end initializeImpureRandom;

        function impureRandom  "Impure random number generator (with hidden state vector)"
          input Integer id "Identification number from initializeImpureRandom(..) function (is needed for correct sorting)";
          output Real y "A random number with a uniform distribution on the interval (0,1]";
          external "C" y = ModelicaRandom_impureRandom_xorshift1024star(id) annotation(Include = "#include \"ModelicaRandom.c\"");
          annotation(Include = "#include \"ModelicaRandom.c\"");
        end impureRandom;
      end Utilities;
    end Random;

    package Special  "Library of special mathematical functions"
      extends Modelica.Icons.Package;

      function sinc  "Unnormalized sinc function: sinc(u) = sin(u)/u"
        input Real u "Input argument";
        output Real y "= sinc(u) = sin(u)/u";
      algorithm
        y := if abs(u) > 0.5e-4 then sin(u) / u else 1 - u ^ 2 / 6 + u ^ 4 / 120;
        annotation(Inline = true);
      end sinc;
    end Special;
  end Math;
  annotation(version = "1.0-Beta.1", versionDate = "2015-06-22", versionBuild = 0);
end Modelica_Noise;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation"
  extends Modelica.Icons.Package;

  package Machine
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(Protection(access = Access.hide), version = "3.2.1", versionBuild = 2, versionDate = "2013-08-14", dateModified = "2013-08-14 08:44:41Z");
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.1 (Build 3)"
  extends Modelica.Icons.Package;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math"
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)"
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function exp  "Exponential, base e"
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7 "Magnetic constant";
  end Constants;

  package Icons  "Library of icons"
    extends Icons.Package;

    partial package ExamplesPackage  "Icon for packages containing runnable examples"
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example  "Icon for runnable examples" end Example;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces"
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package UtilitiesPackage  "Icon for utility packages"
      extends Modelica.Icons.Package;
    end UtilitiesPackage;

    partial package IconsPackage  "Icon for packages containing icons"
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units"
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Time = Real(final quantity = "Time", final unit = "s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
  annotation(version = "3.2.1", versionBuild = 3, versionDate = "2013-08-14", dateModified = "2014-06-27 19:30:00Z");
end Modelica;

package Noise  "A library with additional noise modules compatible to the Modelica standard library"
  extends Modelica.Icons.Package;

  package Examples  "Examples for the Noise library"
    extends Modelica.Icons.ExamplesPackage;

    model InterpolateRandomNumbers  "Interpolate random numbers with the various interpolators"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Time samplePeriod = 1.0 "Sample period for the generation of random numbers";
      parameter Integer seed = 614657 "Seed to initialize random number generator";
    protected
      final parameter Integer id = Modelica_Noise.Math.Random.Utilities.initializeImpureRandom(seed) "An identifier to ensure initialization of the impure random number generator";
    public
      parameter Real[100] r(fixed = false) "Random number buffer";
      Real offset "The offset for interpolation";
      Real rConstant "Constantly interpolated random number";
      Real rLinear "Linearly interpolated random number";
      Real rSmooth "Smoothly inteprolated random number";
    initial algorithm
      for i in 1:100 loop
        r[i] := Modelica_Noise.Math.Random.Utilities.impureRandom(id);
      end for;
    equation
      offset = mod(time / samplePeriod, 90) + 5.0;
      rConstant = Noise.Interpolators.Constant.interpolate(buffer = r, offset = offset);
      rLinear = Noise.Interpolators.Linear.interpolate(buffer = r, offset = offset);
      rSmooth = Noise.Interpolators.SmoothIdealLowPass.interpolate(buffer = r, offset = offset);
      annotation(experiment(StopTime = 20, NumberOfIntervals = 1000));
    end InterpolateRandomNumbers;
  end Examples;

  package Interpolators  "Additional interpolation packages"
    extends Modelica.Icons.Package;

    package Constant  "Constant interpolation"
      extends Utilities.Interfaces.PartialInterpolator(final continuous = false, final nFuture = 0, final nPast = 0, final varianceFactor = 1, final smoothness = -1);

      redeclare function extends interpolate  "Constant interpolation in a buffer of random values"
      algorithm
        y := buffer[if nBuffer == 1 then 1 else integer(offset) + 1];
        annotation(Inline = true);
      end interpolate;
    end Constant;

    package Linear  "Linear interpolation"
      extends Utilities.Interfaces.PartialInterpolator(final continuous = true, final nFuture = 1, final nPast = 0, final varianceFactor = 2 / 3, final smoothness = 0);

      redeclare replaceable function extends interpolate  "Linear interpolation in a buffer of random values"
      protected
        Integer ind "Index of buffer element just before offset";
        Real y1 "Value of buffer element just before offset";
        Real y2 "Value of buffer element just after offset";
        Real offset2;
      algorithm
        assert(offset >= 0 and offset < nBuffer - 1, "offset out of range (offset=" + String(offset) + ", nBuffer=" + String(nBuffer) + ")");
        ind := integer(offset) + 1;
        y1 := buffer[ind];
        y2 := buffer[ind + 1];
        y := y1 + (y2 - y1) * (offset - ind + 1);
        annotation(derivative(order = 1) = der_interpolate);
      end interpolate;

      function der_interpolate
        extends Modelica.Icons.Function;
        input Real[:] buffer "Buffer of random numbers";
        input Real offset "Offset from buffer start (0..size(buffer)-1";
        input Real samplePeriod = 1 "The sample period of the noise buffer";
        input Real[size(buffer, 1)] der_buffer "Derivatives of buffer values";
        input Real der_offset "Derivative of offset value";
        input Real der_samplePeriod "Derivative of samplePeriod (unused)";
        output Real der_y "Interpolated value at position offset";
      protected
        Integer ind "Index of buffer element just before offset";
        Real der_y1 "Value of buffer element just before offset";
        Real der_y2 "Value of buffer element just after offset";
        Integer nBuffer = size(buffer, 1);
      algorithm
        if offset >= nBuffer - nFuture and offset <= (1 + 1e-6) * (nBuffer - nFuture) then
          ind := nBuffer - 1;
        else
          assert(offset >= nPast and offset < nBuffer - nFuture, "offset out of range (offset=" + String(offset) + ", nBuffer=" + String(nBuffer) + ")");
          ind := integer(offset) + 1;
        end if;
        der_y1 := der_buffer[ind];
        der_y2 := der_buffer[ind + 1];
        der_y := (buffer[ind + 1] - buffer[ind]) * der_offset + der_y1 + (der_y2 - der_y1) * (offset - ind + 1);
      end der_interpolate;
    end Linear;

    package SmoothIdealLowPass  "Smooth interpolation (with sinc function)"
      extends Utilities.Interfaces.PartialInterpolator(final continuous = true, final nFuture = n - 1, final nPast = n, final varianceFactor = 0.979776342307764, final smoothness = 1);
      constant Integer n = 5 "Number of support points for convolution";

      redeclare function extends interpolate  "Smooth interpolation in a buffer of random values (using the sinc-function that approximates an ideal low pass filter)"
      protected
        Real coefficient "The intermediate container for the kernel evaluations";
      algorithm
        assert(offset >= nPast and offset < nBuffer - nFuture, "offset out of range (offset=" + String(offset) + ", nBuffer=" + String(nBuffer) + ")");
        y := 0;
        for i in (-nPast):nFuture loop
          coefficient := kernel(t = mod(offset, 1) - i);
          y := y + buffer[integer(offset) + i + 1] * coefficient;
        end for;
        annotation(derivative(order = 1) = der_interpolate);
      end interpolate;

      function der_interpolate  "Interpolates the buffer using a replaceable kernel"
        extends Modelica.Icons.Function;
        input Real[:] buffer "Buffer of random numbers";
        input Real offset "Offset from buffer start (0..size(buffer)-1";
        input Real samplePeriod = 1 "The sample period of the noise buffer";
        input Real[size(buffer, 1)] der_buffer "Derivatives of buffer values";
        input Real der_offset "Derivative of offset value";
        input Real der_samplePeriod "Derivative of samplePeriod (unused)";
        output Real der_y "Interpolated value at position offset";
      algorithm
        der_y := 0;
        for i in (-nPast):nFuture loop
          der_y := der_y + der_kernel_offset(t = mod(offset, 1) - i) * buffer[integer(offset) + i + 1] * der_offset + kernel(t = mod(offset, 1) - i) * der_buffer[integer(offset) + i + 1];
        end for;
      end der_interpolate;

      function kernel  "Kernel for ideal low pass (sinc-function)"
        input Real t "The (scaled) time for sampling period=1";
        input Modelica.SIunits.Frequency f = 1 / 2 "The cut-off frequency of the filter";
        output Real h "The impulse response of the convolution filter";
      algorithm
        h := 2 * f * .Modelica_Noise.Math.Special.sinc(2 * .Modelica.Constants.pi * f * t);
        annotation(Inline = true);
      end kernel;

      function der_kernel_offset
        input Real t "The (scaled) time for sampling period=1";
        input Modelica.SIunits.Frequency f = 1 / 2 "The cut-off frequency of the filter";
        output Real h "The impulse response of the convolution filter";
      protected
        function d = der(kernel, t);
      algorithm
        h := d(t, f);
      end der_kernel_offset;
    end SmoothIdealLowPass;

    package Utilities  "Utilities for Interpolators"
      extends Modelica.Icons.UtilitiesPackage;

      package Interfaces  "Interfaces package"
        extends Modelica.Icons.InterfacesPackage;

        partial package PartialInterpolator  "Interfaces of an interpolator in a buffer of random numbers"
          extends Modelica.Icons.Package;
          constant Boolean continuous = false "=true if interpolation is continuous, otherwise discontinuous";
          constant Integer nFuture(min = 0) = 0 "Number of buffer values required in the future (=0 for causal filters)";
          constant Integer nPast(min = 0) = 0 "Number of buffer values required in the past";
          constant Real varianceFactor = 1 "The factor by which the variance will be scaled, if this interpolation is used";
          constant Integer smoothness = 0 "The smoothness of the interpolation. =0: continuous, =1: continuous and differentiable, ...";

          replaceable partial function interpolate  "Interface of a function to interpolate in a buffer of random numbers"
            extends Modelica.Icons.Function;
            input Real[:] buffer "Buffer of random numbers";
            input Real offset "Offset from buffer start (0..size(buffer)-1";
            input Real samplePeriod = 1 "The sample period of the noise buffer";
            output Real y "Interpolated value at position offset";
          protected
            Integer nBuffer = size(buffer, 1) "Size of the buffer";
          end interpolate;
        end PartialInterpolator;
      end Interfaces;
    end Utilities;
  end Interpolators;
  annotation(version = "1.0-Beta.1", versionDate = "2015-06-22", versionBuild = 1);
end Noise;

model InterpolateRandomNumbers_total  "Interpolate random numbers with the various interpolators"
  extends Noise.Examples.InterpolateRandomNumbers;
 annotation(experiment(StopTime = 20, NumberOfIntervals = 1000));
end InterpolateRandomNumbers_total;
