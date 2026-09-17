package AdvancedNoise  "A library with additional noise modules compatible to the Modelica standard library" 
  extends Modelica.Icons.Package;

  package Examples  "Examples for the Noise library" 
    extends Modelica.Icons.ExamplesPackage;

    model VaryingDistribution  "Shows how distributions can vary in time" 
      extends Modelica.Icons.Example;
      inner Modelica.Blocks.Noise.GlobalSeed globalSeed;
      Real t = time;
      Sources.TimeBasedNoise discreteNoise(samplePeriod = 0.001, redeclare function distribution = Distributions.Discrete.quantile(p = if t < 1 then {0.2, 0.8} else {0.8, 0.2}));
      Modelica.Blocks.Math.ContinuousMean continuousMean;
    equation
      connect(continuousMean.u, discreteNoise.y);
      annotation(experiment(StopTime = 10)); 
    end VaryingDistribution;
  end Examples;

  package Sources  "More noise sources" 
    extends Modelica.Icons.Package;

    block TimeBasedNoise  "Noise generator for Real numbers associated with time (this block computes always the same (random) output y at the same time instant)" 
      extends Modelica.Blocks.Interfaces.SO;
      parameter Modelica.SIunits.Time samplePeriod(start = 0.01) "Period for sampling the raw random numbers";
      parameter Boolean enableNoise = true "=true: y = noise, otherwise y = y_off";
      parameter Real y_off = 0.0 "Output if time<startTime or enableNoise=false";
      parameter Integer sampleFactor(min = 1) = 100 "Events only at samplePeriod*sampleFactor if continuous" annotation(Evaluate = true);
      final parameter Integer shift = 200 - interpolation.nPast "Shift noise samples to account for interpolation buffer";
      replaceable function distribution = Modelica.Math.Distributions.Uniform.quantile constrainedby Modelica.Math.Distributions.Interfaces.partialQuantile;
      replaceable package interpolation = Interpolators.Constant constrainedby Interpolators.Utilities.Interfaces.PartialInterpolator;
      replaceable package generator = Modelica.Math.Random.Generators.Xorshift128plus constrainedby Generators.Utilities.Interfaces.PartialGenerator;
      parameter Boolean useGlobalSeed = true "= true: use global seed, otherwise ignore it";
      parameter Boolean useAutomaticLocalSeed = true "= true: use instance name hash else fixedLocalSeed";
      parameter Integer fixedLocalSeed = 10 "Local seed if useAutomaticLocalSeed = false";
      final parameter Integer localSeed(fixed = false) "The actual localSeed";
      parameter Modelica.SIunits.Time startTime = 0.0 "Start time for sampling the raw random numbers";
    protected
      outer Modelica.Blocks.Noise.GlobalSeed globalSeed "Definition of global seed via inner/outer";
      parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0 "The global seed, which is atually used";
      parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise "= true if noise shall be generated, otherwise no noise";
      parameter Boolean continuous = interpolation.continuous "= true, if continuous interpolation";
      parameter Real actualSamplePeriod = if continuous then sampleFactor * samplePeriod else samplePeriod "Sample period of when-clause";
      parameter Integer nFuture = interpolation.nFuture + 1 "Number of buffer elements to be predicted in the future (+1 for crossing sample events)";
      parameter Integer nPast = interpolation.nPast "Number of buffer elements to be retained from the past";
      parameter Integer nCopy = nPast + nFuture "Number of buffer entries to retain when re-filling buffer";
      parameter Integer nBuffer = if continuous then nPast + sampleFactor + nFuture else nPast + 1 + nFuture "Size of buffer";
      discrete Integer[generator.nState] state "Internal state of random number generator";
      discrete Real[nBuffer] buffer "Buffer to hold raw random numbers";
      discrete Real bufferStartTime "The last time we have filled the buffer";
      discrete Real r "Uniform random number in the range (0,1]";
    initial equation
      localSeed = if useAutomaticLocalSeed then .Modelica.Math.Random.Utilities.impureRandomInteger(globalSeed.id_impure) else fixedLocalSeed;
    equation
      y = if not generateNoise or time < startTime then y_off else if interpolation.continuous then smooth(interpolation.smoothness, interpolation.interpolate(buffer = buffer, offset = (time - bufferStartTime) / samplePeriod + nPast, samplePeriod = samplePeriod)) else interpolation.interpolate(buffer = buffer, offset = (time - bufferStartTime) / samplePeriod + nPast, samplePeriod = samplePeriod);
    algorithm
      when initial() then
        state := generator.initialState(localSeed, actualGlobalSeed);
        bufferStartTime := time;
        for i in 1:shift loop
          (r, state) := generator.random(state);
        end for;
        for i in 1:nBuffer loop
          (r, state) := generator.random(state);
          buffer[i] := distribution(r);
        end for;
      elsewhen generateNoise and time >= startTime then
        bufferStartTime := time;
      elsewhen generateNoise and sample(startTime + actualSamplePeriod, actualSamplePeriod) then
        bufferStartTime := time;
        buffer[1:nCopy] := buffer[nBuffer - nCopy + 1:nBuffer];
        for i in nCopy + 1:nBuffer loop
          (r, state) := generator.random(state);
          buffer[i] := distribution(r);
        end for;
      end when;
    end TimeBasedNoise;
  end Sources;

  package Distributions  "Additional distributions" 
    extends Modelica.Icons.Package;

    package Discrete  "Library of discrete distribution functions" 
      extends Modelica.Icons.Package;

      function quantile  "Quantile of discrete distribution (= inverse cumulative distribution function)" 
        extends Modelica.Math.Distributions.Interfaces.partialQuantile;
        input Real[:] x = {0, 1} "Discrete values to be chosen from";
        input Real[size(x, 1)] p = ones(size(x, 1)) / size(x, 1) "The probabilities of the discrete values";
      protected
        Integer[size(x, 1)] iSorted "Sorted indices";
        Real[size(x, 1)] xSorted "Sorted values of x";
        Real[size(x, 1)] pSorted "Sorted values of p";
        Real cdf;
      algorithm
        (xSorted, iSorted) := Modelica.Math.Vectors.sort(x);
        cdf := 0;
        for i in 1:size(x, 1) loop
          if u > cdf / sum(p) then
            y := xSorted[i];
          else
          end if;
          cdf := cdf + p[iSorted[i]];
        end for;
        annotation(Inline = true); 
      end quantile;
    end Discrete;
  end Distributions;

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
            extends .AdvancedNoise.Interpolators.Utilities.Interfaces.interpolate;
          end interpolate;
        end PartialInterpolator;

        partial function interpolate  "Interface of a function to interpolate in a buffer of random numbers" 
          extends Modelica.Icons.Function;
          input Real[:] buffer "Buffer of random numbers";
          input Real offset "Offset from buffer start (0..size(buffer)-1";
          input Real samplePeriod = 1 "The sample period of the noise buffer";
          output Real y "Interpolated value at position offset";
        protected
          Integer nBuffer = size(buffer, 1) "Size of the buffer";
        end interpolate;
      end Interfaces;
    end Utilities;
  end Interpolators;
  annotation(version = "1.0.0", versionDate = "2016-05-03", versionBuild = 1); 
end AdvancedNoise;

package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;
    end Interfaces;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      extends Modelica.Icons.Package;

      block ContinuousMean  "Calculates the empirical expectation (mean) value of its input signal" 
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.Time t_eps(min = 0.0) = 1e-7 "Mean value calculation starts at startTime + t_eps";
        Modelica.Blocks.Interfaces.RealInput u "Noisy input signal";
        Modelica.Blocks.Interfaces.RealOutput y "Expectation (mean) value of the input signal";
      protected
        Real mu "Internal integrator variable";
        parameter Real t_0(fixed = false) "Start time";
      initial equation
        t_0 = time;
        mu = u;
      equation
        der(mu) = noEvent(if time >= t_0 + t_eps then (u - mu) / (time - t_0) else 0);
        y = noEvent(if time >= t_0 + t_eps then mu else u);
      end ContinuousMean;
    end Math;

    package Noise  "Library of noise blocks" 
      extends Modelica.Icons.Package;

      model GlobalSeed  "Defines global settings for the blocks of sublibrary Noise, especially a global seed value is defined" 
        parameter Boolean enableNoise = true "= true, if noise blocks generate noise as output; = false, if they generate a constant output";
        parameter Boolean useAutomaticSeed = false "= true, choose a seed by system time and process id; = false, use fixedSeed";
        parameter Integer fixedSeed = 67867967 "Fixed global seed for random number generators (if useAutomaticSeed = false)";
        final parameter Integer seed(fixed = false) "Actually used global seed";
        final parameter Integer id_impure(fixed = false) "ID for impure random number generators Modelica.Math.Random.Utilities.impureXXX" annotation(HideResult = true);
      initial equation
        seed = if useAutomaticSeed then Modelica.Math.Random.Utilities.automaticGlobalSeed() else fixedSeed;
        id_impure = Modelica.Math.Random.Utilities.initializeImpureRandom(seed);
        annotation(defaultComponentPrefixes = "inner", missingInnerMessage = "
      Your model is using an outer \"globalSeed\" component but
      an inner \"globalSeed\" component is not defined and therefore
      a default inner \"globalSeed\" component is introduced by the tool.
      To change the default setting, drag Noise.GlobalSeed
      into your model and specify the seed.
      "); 
      end GlobalSeed;
    end Noise;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;
    end Icons;
  end Blocks;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Vectors  "Library of functions operating on vectors" 
      extends Modelica.Icons.Package;

      function sort  "Sort elements of vector in ascending or descending order" 
        extends Modelica.Icons.Function;
        input Real[:] v "Real vector to be sorted";
        input Boolean ascending = true "= true if ascending order, otherwise descending order";
        output Real[size(v, 1)] sorted_v = v "Sorted vector";
        output Integer[size(v, 1)] indices = 1:size(v, 1) "sorted_v = v[indices]";
      protected
        Integer gap;
        Integer i;
        Integer j;
        Real wv;
        Integer wi;
        Integer nv = size(v, 1);
        Boolean swap;
      algorithm
        gap := div(nv, 2);
        while gap > 0 loop
          i := gap;
          while i < nv loop
            j := i - gap;
            if j >= 0 then
              if ascending then
                swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
              else
                swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
              end if;
            else
              swap := false;
            end if;
            while swap loop
              wv := sorted_v[j + 1];
              wi := indices[j + 1];
              sorted_v[j + 1] := sorted_v[j + gap + 1];
              sorted_v[j + gap + 1] := wv;
              indices[j + 1] := indices[j + gap + 1];
              indices[j + gap + 1] := wi;
              j := j - gap;
              if j >= 0 then
                if ascending then
                  swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
                else
                  swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
                end if;
              else
                swap := false;
              end if;
            end while;
            i := i + 1;
          end while;
          gap := div(gap, 2);
        end while;
      end sort;
    end Vectors;

    package Random  "Library of functions for generating random numbers" 
      extends Modelica.Icons.Package;

      package Generators  "Library of functions generating uniform random numbers in the range 0 < random <= 1.0 (with exposed state vectors)" 
        extends Modelica.Icons.Package;

        package Xorshift64star  "Random number generator xorshift64*" 
          constant Integer nState = 2 "The dimension of the internal state vector";
          extends Modelica.Icons.Package;

          function initialState  "Returns an initial state for the xorshift64* algorithm" 
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
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

          function random  "Returns a uniform random number with the xorshift64* algorithm" 
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
            external "C" ModelicaRandom_xorshift64star(stateIn, stateOut, result) annotation(Library = "ModelicaExternalC");
          end random;
        end Xorshift64star;

        package Xorshift128plus  "Random number generator xorshift128+" 
          constant Integer nState = 4 "The dimension of the internal state vector";
          extends Modelica.Icons.Package;

          function initialState  "Returns an initial state for the xorshift128+ algorithm" 
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
          algorithm
            state := Utilities.initialStateWithXorshift64star(localSeed, globalSeed, size(state, 1));
            annotation(Inline = true); 
          end initialState;

          function random  "Returns a uniform random number with the xorshift128+ algorithm" 
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
            external "C" ModelicaRandom_xorshift128plus(stateIn, stateOut, result) annotation(Library = "ModelicaExternalC");
          end random;
        end Xorshift128plus;
      end Generators;

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
          Integer[2] aux "Intermediate container of state integers";
          Integer nStateEven "Highest even number <= nState";
        algorithm
          aux := .Modelica.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed);
          if nState >= 2 then
            state[1:2] := aux;
          else
            state[1] := aux[1];
          end if;
          nStateEven := 2 * div(nState, 2);
          for i in 3:2:nStateEven loop
            (r, aux) := .Modelica.Math.Random.Generators.Xorshift64star.random(state[i - 2:i - 1]);
            state[i:i + 1] := aux;
          end for;
          if nState >= 3 and nState <> nStateEven then
            (r, aux) := .Modelica.Math.Random.Generators.Xorshift64star.random(state[nState - 2:nState - 1]);
            state[nState] := aux[1];
          else
          end if;
        end initialStateWithXorshift64star;

        function automaticGlobalSeed  "Creates an automatic integer seed (typically from the current time and process id; this is an impure function)" 
          extends Modelica.Icons.Function;
          output Integer seed "Automatically generated seed";
          external "C" seed = ModelicaRandom_automaticGlobalSeed(0.0) annotation(Library = "ModelicaExternalC", __ModelicaAssociation_Impure = true);
          annotation(__ModelicaAssociation_Impure = true); 
        end automaticGlobalSeed;

        function initializeImpureRandom  "Initializes the internal state of the impure random number generator" 
          extends Modelica.Icons.Function;
          input Integer seed "The input seed to initialize the impure random number generator";
          output Integer id "Identification number to be passed as input to function impureRandom, in order that sorting is correct";
        protected
          constant Integer localSeed = 715827883 "Since there is no local seed, a large prime number is used";
          Integer[33] rngState "The internal state vector of the impure random number generator";

          function setInternalState  "Stores the given state vector in an external static variable" 
            extends Modelica.Icons.Function;
            input Integer[33] rngState "The initial state";
            input Integer id;
            external "C" ModelicaRandom_setInternalState_xorshift1024star(rngState, size(rngState, 1), id) annotation(Library = "ModelicaExternalC");
          end setInternalState;
        algorithm
          rngState := initialStateWithXorshift64star(localSeed, seed, size(rngState, 1));
          id := localSeed;
          setInternalState(rngState, id);
        end initializeImpureRandom;

        function impureRandom  "Impure random number generator (with hidden state vector)" 
          extends Modelica.Icons.Function;
          input Integer id "Identification number from initializeImpureRandom(..) function (is needed for correct sorting)";
          output Real y "A random number with a uniform distribution on the interval (0,1]";
          external "C" y = ModelicaRandom_impureRandom_xorshift1024star(id) annotation(Library = "ModelicaExternalC", __ModelicaAssociation_Impure = true);
          annotation(__ModelicaAssociation_Impure = true); 
        end impureRandom;

        function impureRandomInteger  "Impure random number generator for integer values (with hidden state vector)" 
          extends Modelica.Icons.Function;
          input Integer id "Identification number from initializeImpureRandom(..) function (is needed for correct sorting)";
          input Integer imin = 1 "Minimum integer to generate";
          input Integer imax = 268435456 "Maximum integer to generate (default = 2^28)";
          output Integer y "A random number with a uniform distribution on the interval [imin,imax]";
        protected
          Real r "Impure Real random number";
        algorithm
          r := impureRandom(id = id);
          y := integer(r * imax) + integer((1 - r) * imin);
          y := min(imax, max(imin, y));
          annotation(__ModelicaAssociation_Impure = true); 
        end impureRandomInteger;
      end Utilities;
    end Random;

    package Distributions  "Library of distribution functions" 
      extends Modelica.Icons.Package;

      package Uniform  "Library of uniform distribution functions" 
        extends Modelica.Icons.Package;

        function quantile  "Quantile of uniform distribution" 
          extends Modelica.Math.Distributions.Interfaces.partialQuantile;
          input Real y_min = 0 "Lower limit of y";
          input Real y_max = 1 "Upper limit of y";
        algorithm
          y := u * (y_max - y_min) + y_min;
          annotation(Inline = true); 
        end quantile;
      end Uniform;

      package Interfaces  "Library of interfaces for distribution functions" 
        extends Modelica.Icons.InterfacesPackage;

        partial function partialQuantile  "Common interface of quantile functions (= inverse cumulative distribution functions)" 
          extends Modelica.Icons.Function;
          input Real u(min = 0, max = 1) "Random number in the range 0 <= u <= 1";
          output Real y "Random number u transformed according to the given distribution";
        end partialQuantile;
      end Interfaces;
    end Distributions;
  end Math;

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
    type Time = Real(final quantity = "Time", final unit = "s");
  end SIunits;
  annotation(version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z"); 
end Modelica;

model VaryingDistribution_total  "Shows how distributions can vary in time"
  extends AdvancedNoise.Examples.VaryingDistribution;
 annotation(experiment(StopTime = 10));
end VaryingDistribution_total;
